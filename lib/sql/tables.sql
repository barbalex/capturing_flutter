create table users (
  id text primary key,
  name text default null,
  email text default null,
  account_id text default null references accounts (id) on delete no action on update cascade DEFERRABLE INITIALLY DEFERRED,
  auth_id text,
  client_rev_at text,
  client_rev_by text default null references users (id) on delete no action on update cascade,
  server_rev_at text
);
create index users_id_idx on users (id);
create index users_name_idx on users (name);
create index users_email_idx on users (email);
create index users_account_id_idx on users (account_id);
create index users_auth_id_idx on users (auth_id);


create table accounts (
  id text primary key,
  service_id text default null,
  manager text default null references users (id) on delete no action on update cascade,
  client_rev_at text,
  client_rev_by text default null references users (id) on delete no action on update cascade,
  server_rev_at text
);
create index accounts_id_idx on accounts (id);
create index accounts_service_id_idx on accounts (service_id);
create index accounts_manager_idx on accounts (manager);
create index accounts_server_rev_at_idx on accounts (server_rev_at);

--create table account_managers (
--  id text primary key default uuid_generate_v1mc(),
--  account_id text default null references accounts (id) on delete no action on update cascade,
--  user_id text default null references users (id) on delete no action on update cascade,
--);
--create index on account_managers (id);
--create index on account_managers (account_id);
--create index on account_managers (user_id);

create table projects (
  id text primary key,
  account_id text default null references accounts (id) on delete no action on update cascade,
  name text default null,
  label text default null,
  srs_id integer default 4326,
  client_rev_at text,
  client_rev_by text default null references users (id) on delete no action on update cascade,
  server_rev_at text,
  unique (account_id, name)
);
create index projects_id_idx on projects (id);
create index projects_account_id_idx on projects (account_id);
create index projects_name_idx on projects (name);
create index projects_label_idx on projects (label);

create table rel_types (
  value text primary key,
  sort integer default null,
  comment text,
  server_rev_at text
);
create index rel_types_value_idx on rel_types (value);
create index rel_types_sort_idx on rel_types (sort);
create index rel_types_server_rev_at_idx on rel_types (server_rev_at);

insert into rel_types (value, sort, comment)
values ('1', 2, '1 to 1'), ('n', 1, '1 to n') on conflict (value) do update set comment = excluded.comment;

create table tables (
  id text primary key,
  project_id text default null references projects (id) on delete no action on update cascade,
  parent_id text default null references tables (id) on delete no action on update cascade,
  rel_type text default 'n' references rel_types (value) on delete no action on update cascade,
  name text default null,
  label text default null,
  is_options integer default 0,
  client_rev_at text,
  client_rev_by text default null references users (id) on delete no action on update cascade,
  server_rev_at text,
  unique (project_id, name)
);
create index tables_id_idx on tables (id);
create index tables_project_id_idx on tables (project_id);
create index tables_parent_id_idx on tables (parent_id);
create index tables_name_idx on tables (name);
create index tables_label_idx on tables (label);
create index tables_is_options_idx on tables (is_options);

create table field_types (
  value text primary key,
  sort integer default null,
  comment text,
  server_rev_at text
);
create index field_types_value_idx on field_types (value);
create index field_types_sort_idx on field_types (sort);
create index field_types_server_rev_at_idx on field_types (server_rev_at);

insert into field_types (value, sort, comment)
values ('text', 1, 'Example: text'),
  ('boolean', 2, 'true or false'),
  ('integer', 3, 'Example: 1'),
  ('decimal', 4, 'Example: 1.1'),
  ('date', 5, 'Example: 2021-03-08'),
  (
    'date-time',
    6,
    'Timestamp with time zone. Example: 2021-03-08 10:23:54+01'
  ),
  ('file-reference', 7, 'the id of the file') on conflict (value) do
update set comment = excluded.comment;

create table widget_types (
  value text primary key,
  sort integer default null,
  comment text,
  server_rev_at text
);
create index widget_types_value_idx on widget_types (value);
create index widget_types_sort_idx on widget_types (sort);
create index widget_types_server_rev_at_idx on widget_types (server_rev_at);

insert into widget_types (value, sort, comment)
values ('text', 1, 'Short field accepting text'),
  (
    'text-area',
    2,
    'Field accepting text, lines can break'
  ),
  (
    'markdown',
    3,
    'Field accepting text, expressing markdown'
  ),
  (
    'options-2',
    4,
    'boolean field showing true and false (not null)'
  ),
  (
    'options-3',
    5,
    'boolean field showing true, false and null'
  ),
  (
    'options-few',
    6,
    'short list, showing every entry'
  ),
  ('options-many', 7, 'long dropdown-list'),
  ('date-chooser', 8, 'enables choosing a date'),
  ('file-chooser', 9, 'enables choosing a file') on conflict (value) do
update set comment = excluded.comment;

create table fields (
  id text primary key,
  table_id text default null references tables (id) on delete no action on update cascade,
  name text default null,
  label text default null,
  is_internal_id integer default 0,
  field_type text default 'text' references field_types (value) on delete no action on update cascade,
  widget_type text default 'text' references widget_types (value) on delete no action on update cascade,
  options_table text references tables (id) on delete no action on update cascade,
  client_rev_at text,
  client_rev_by text default null references users (id) on delete no action on update cascade,
  server_rev_at text,
  unique (table_id, name)
);
create index fields_id_idx on fields (id);
create index fields_table_id_idx on fields (table_id);
create index fields_name_idx on fields (name);
create index fields_label_idx on fields (label);
create index fields_options_table_idx on fields (options_table);


create table rows (
  id text primary key,
  table_id text default null references tables (id) on delete no action on update cascade,
  data json,
  deleted integer default 0,
  client_rev_at text,
  client_rev_by text default null references users (id) on delete no action on update cascade,
  server_rev_at text,
  _rev text default null,
  _parent_rev text default null,
  _revisions text default null,
  _depth integer default 0,
  _deleted integer default 0,
  _conflicts text default null
);
SELECT AddGeometryColumn('rows', 'geometry', 4326, 'GeometryCollection', 'XY');
select CreateSpatialIndex('geometry', 'Geometry');
create index rows_id_idx on rows (id);
create index rows_table_id_idx on rows (table_id);
create index rows_deleted_idx on rows (deleted);

--insert into rows (id, data) values ('1', json_object('a',2,'c',4));


create table files (
  id text primary key,
  row_id text default null references rows (id) on delete no action on update cascade,
  field_id text default null references fields (id) on delete no action on update cascade,
  filename text default null,
  hash text default null,
  version integer default 1,
  deleted integer default 0,
  client_rev_at text,
  client_rev_by text default null references users (id) on delete no action on update cascade,
  server_rev_at text,
  _rev text default null,
  _parent_rev text default null,
  _revisions text default null,
  _depth integer default 0,
  _deleted integer default 0,
  _conflicts text default null
);
create index files_id_idx on files (id);
create index files_row_id_idx on files (row_id);
create index files_field_id_idx on files (field_id);
create index files_filename_idx on files (filename);
create index files_deleted_idx on rows (deleted);


create table role_types (
  value text primary key,
  sort integer default 1,
  comment text,
  server_rev_at text
);
create index role_types_value_idx on role_types (value);
create index role_types_sort_idx on role_types (sort);
create index role_types_server_rev_at_idx on role_types (server_rev_at);

insert into role_types (value, sort, comment)
values (
    'account_manager',
    1,
    'Only role to: create users, give them roles, create projects'
  ),
  (
    'project_manager',
    2,
    'Can edit projects and their structure'
  ),
  ('project_editor', 3, 'Can edit rows and files'),
  ('project_reader', 4, 'Can read data') on conflict (value) do
update
set comment = excluded.comment;


create table project_users (
  id text primary key,
  project_id text default null references projects (id) on delete no action on update cascade,
  user_id text default null references users (id) on delete no action on update cascade,
  role text default 'project_reader' references role_types (value) on delete no action on update cascade,
  client_rev_at text,
  client_rev_by text default null references users (id) on delete no action on update cascade,
  server_rev_at text
);
create index project_users_id_idx on project_users (id);
create index project_users_project_id_idx on project_users (project_id);
create index project_users_user_id_idx on project_users (user_id);
create index project_users_role_idx on project_users (role);


create table version_types (
  value text primary key,
  sort integer default null,
  comment text,
  server_rev_at text
);
create index version_types_value_idx on version_types (value);
create index version_types_sort_idx on version_types (sort);
create index version_types_server_rev_at_idx on version_types (server_rev_at);

insert into version_types (value, sort, comment)
values ('patch', 1, 'Backward compatible bug fixes'),
  ('minor', 2, 'Backward compatible new features'),
  (
    'major',
    3,
    'Changes that break backward compatibility'
  ) on conflict (value) do
update
set comment = excluded.comment;


create table news (
  id text primary key,
  time text,
  version_type text default 'minor' references version_types (value) on delete no action on update cascade,
  version text default null,
  message text default null,
  server_rev_at text
);
create index news_id_idx on news (id);
create index news_time_idx on news (time);
create index news_version_type_idx on news (version_type);


create table news_delivery (
  id text primary key,
  news_id text default null references news (id) on delete no action on update cascade,
  user_id text default null references users (id) on delete no action on update cascade,
  server_rev_at text
);
create index news_delivery_id_idx on news_delivery (id);
create index news_delivery_news_id_idx on news_delivery (news_id);
create index news_delivery_user_id_idx on news_delivery (user_id);