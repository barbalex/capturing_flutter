create extension if not exists "uuid-ossp";

create extension if not exists postgis;

drop table if exists users cascade;

create table users (
  id uuid primary key default uuid_generate_v1mc (),
  name text default null,
  email text default null,
  account_id uuid default null, -- references accounts (id) on delete no action on update cascade,
  auth_id text,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now()
);

create index on users using btree (id);

create index on users using btree (name);

create index on users using btree (email);

create index on users using btree (account_id);

create index on users using btree (auth_id);

comment on table users is 'Goal: authentication, authorization, communication, configuration. Not versioned (not recorded and only added by manager)';

comment on column users.id is 'primary key';

comment on column users.name is 'name';

comment on column users.email is 'email';

comment on column users.account_id is 'associated account';

comment on column users.auth_id is 'associated auth';

comment on column users.client_rev_at is 'time of last edit on client';

comment on column users.client_rev_by is 'user editing last on client';

comment on column users.server_rev_at is 'time of last edit on server';

drop table if exists accounts cascade;

create table accounts (
  id uuid primary key default uuid_generate_v1mc (),
  service_id text default null, -- uid of firebase
  manager uuid default null references users (id) on delete no action on update cascade,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now()
  -- any more?
);

create index on accounts using btree (id);

create index on accounts using btree (service_id);

create index on accounts using btree (manager);

create index on accounts using btree (server_rev_at);

comment on table accounts is 'Goal: earn money. Base table. Projects, tables, rows and files depend on it. Not versioned (not recorded and only added by manager)';

comment on column accounts.id is 'primary key';

comment on column accounts.service_id is 'id used by external service';

comment on column accounts.manager is 'user that can manage account (create and edit projects)';

comment on column accounts.client_rev_at is 'time of last edit on client';

comment on column accounts.client_rev_by is 'user editing last on client';

comment on column accounts.server_rev_at is 'time of last edit on server';

-- need to wait to create this reference until accounts exists:
alter table users
  add foreign key (account_id) references accounts (id) on delete no action on update cascade;

--drop table if exists account_managers cascade;
--create table account_managers (
--  id uuid primary key default uuid_generate_v1mc(),
--  account_id uuid default null references accounts (id) on delete no action on update cascade,
--  user_id uuid default null references users (id) on delete no action on update cascade,
--);
--create index on account_managers using btree (id);
--create index on account_managers using btree (account_id);
--create index on account_managers using btree (user_id);
--comment on table account_managers is 'Goal: enable having multiple account managers. Not versioned (not recorded and only added by manager)';
--comment on column account_managers.id is 'primary key';
--comment on column account_managers.account_id is 'associated account';
--comment on column account_managers.user_id is 'associated user';
drop table if exists projects cascade;

create table projects (
  id uuid primary key default uuid_generate_v1mc (),
  account_id uuid default null references accounts (id) on delete no action on update cascade,
  name text default null,
  label text default null,
  srs_id integer default 4326,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now(),
  unique (account_id, name)
  -- geometry?
  -- data?
);

create index on projects using btree (id);

create index on projects using btree (account_id);

create index on projects using btree (name);

create index on projects using btree (label);

comment on table projects is 'Goal: Define data structure per project. Tables, rows and files depend on it. Not versioned (not recorded and only added by manager)';

comment on column projects.id is 'primary key';

comment on column projects.account_id is 'associated account';

comment on column projects.name is 'name for use in db and url (lowercase, no special characters)';

comment on column projects.label is 'name for use when labeling';

comment on column projects.srs_id is 'srs used in geometry fields';

comment on column projects.client_rev_at is 'time of last edit on client';

comment on column projects.client_rev_by is 'user editing last on client';

comment on column projects.server_rev_at is 'time of last edit on server';

drop table if exists rel_types cascade;

create table rel_types (
  value text primary key,
  sort smallint default null,
  comment text,
  server_rev_at timestamp with time zone default now()
);

create index on rel_types using btree (value);

create index on rel_types using btree (sort);

create index on rel_types using btree (server_rev_at);

comment on table rel_types is 'Goal: list of rel_types';

comment on column rel_types.value is 'the relation type';

comment on column rel_types.comment is 'explains the version type';

comment on column rel_types.sort is 'enables sorting at will';

comment on column rel_types.server_rev_at is 'time of last edit on server';

insert into rel_types (value, sort, comment)
  values ('1', 2, '1 to 1'), ('n', 1, '1 to n')
on conflict on constraint rel_types_pkey
  do update set
    comment = excluded.comment;

drop table if exists tables cascade;

create table tables (
  id uuid primary key default uuid_generate_v1mc (),
  project_id uuid default null references projects (id) on delete no action on update cascade,
  parent_id uuid default null references tables (id) on delete no action on update cascade,
  rel_type text default 'n' references rel_types (value) on delete no action on update cascade,
  name text default null,
  label text default null,
  is_options boolean default false,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now(),
  unique (project_id, name)
);

create index on tables using btree (id);

create index on tables using btree (project_id);

create index on tables using btree (parent_id);

create index on tables using btree (name);

create index on tables using btree (label);

create index on tables using btree (is_options);

comment on table tables is 'Goal: Define tables used per project. Rows and files depend on it. Not versioned (not recorded and only added by manager)';

comment on column tables.id is 'primary key';

comment on column tables.project_id is 'associated project';

comment on column tables.parent_id is 'parent table';

comment on column tables.rel_type is 'releation with parent table: 1:1 or 1:n';

comment on column tables.name is 'name for use in db and url (lowercase, no special characters)';

comment on column tables.label is 'name for use when labeling';

comment on column tables.is_options is 'is this table used as an options list for a field?';

comment on column tables.client_rev_at is 'time of last edit on client';

comment on column tables.client_rev_by is 'user editing last on client';

comment on column tables.server_rev_at is 'time of last edit on server';

drop table if exists field_types cascade;

create table field_types (
  value text primary key,
  sort smallint default null,
  comment text,
  server_rev_at timestamp with time zone default now()
);

create index on field_types using btree (value);

create index on field_types using btree (sort);

create index on field_types using btree (server_rev_at);

comment on table field_types is 'Goal: list of field_types';

comment on column field_types.value is 'the relation type';

comment on column field_types.value is 'explains the version type';

comment on column field_types.sort is 'enables sorting at will';

comment on column field_types.server_rev_at is 'time of last edit on server';

insert into field_types (value, sort, comment)
  values ('text', 1, 'Example: text'), ('boolean', 2, 'true or false'), ('integer', 3, 'Example: 1'), ('decimal', 4, 'Example: 1.1'), ('date', 5, 'Example: 2021-03-08'), ('date-time', 6, 'Timestamp with time zone. Example: 2021-03-08 10:23:54+01'), ('file-reference', 7, 'the id of the file')
on conflict on constraint field_types_pkey
  do update set
    comment = excluded.comment;

drop table if exists widget_types cascade;

create table widget_types (
  value text primary key,
  sort smallint default null,
  comment text,
  server_rev_at timestamp with time zone default now()
);

create index on widget_types using btree (value);

create index on widget_types using btree (sort);

create index on widget_types using btree (server_rev_at);

comment on table widget_types is 'Goal: list of widget_types';

comment on column widget_types.value is 'the relation type';

comment on column widget_types.value is 'explains the version type';

comment on column widget_types.sort is 'enables sorting at will';

comment on column widget_types.server_rev_at is 'time of last edit on server';

insert into widget_types (value, sort, comment)
  values ('text', 1, 'Short field accepting text'), ('text-area', 2, 'Field accepting text, lines can break'), ('markdown', 3, 'Field accepting text, expressing markdown'), ('options-2', 4, 'boolean field showing true and false (not null)'), ('options-3', 5, 'boolean field showing true, false and null'), ('options-few', 6, 'short list, showing every entry'), ('options-many', 7, 'long dropdown-list'), ('date-chooser', 8, 'enables choosing a date'), ('file-chooser', 9, 'enables choosing a file')
on conflict on constraint widget_types_pkey
  do update set
    comment = excluded.comment;

drop table if exists fields cascade;

create table fields (
  id uuid primary key default uuid_generate_v1mc (),
  table_id uuid default null references tables (id) on delete no action on update cascade,
  name text default null,
  label text default null,
  is_internal_id boolean default false,
  field_type text default 'text' references field_types (value) on delete no action on update cascade,
  widget_type text default 'text' references widget_types (value) on delete no action on update cascade,
  options_table uuid references tables (id) on delete no action on update cascade,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now(),
  unique (table_id, name)
);

create index on fields using btree (id);

create index on fields using btree (table_id);

create index on fields using btree (name);

create index on fields using btree (label);

create index on fields using btree (options_table);

comment on table fields is 'Goal: Define fields used per table. Defines structure and presentation of data column in rows. Not versioned (not recorded and only added by manager)';

comment on column fields.id is 'primary key';

comment on column fields.table_id is 'associated table';

comment on column fields.name is 'name for use in db and url (lowercase, no special characters)';

comment on column fields.label is 'name for use when labeling';

comment on column fields.is_internal_id is 'is this table used as an id in the users own system?';

comment on column fields.field_type is 'what type of data will populate this field?';

comment on column fields.widget_type is 'what type of widget shall be used to enter data?';

comment on column fields.options_table is 'for fields with field_type options-few and options-many: what table contains the options?';

comment on column fields.client_rev_at is 'time of last edit on client';

comment on column fields.client_rev_by is 'user editing last on client';

comment on column fields.server_rev_at is 'time of last edit on server';

drop table if exists rows cascade;

create table rows (
  id uuid primary key default uuid_generate_v1mc (),
  table_id uuid default null references tables (id) on delete no action on update cascade,
  geometry geometry(GeometryCollection, 4326) default null,
  data jsonb,
  deleted boolean default false,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now(),
  _rev text default null,
  _parent_rev text default null,
  _revisions text[] default null,
  _depth integer default 0,
  _deleted boolean default false,
  _conflicts text[] default null
);

create index on rows using btree (id);

create index on rows using btree (table_id);

create index on rows using gist (geometry);

create index on rows using gin (data);

create index on rows using btree (deleted);

comment on table rows is 'Goal: Collect data. Versioned';

comment on column rows.id is 'primary key';

comment on column rows.table_id is 'associated table';

comment on column rows.geometry is 'row geometry (GeometryCollection)';

comment on column rows.data is 'fields (keys) and data (values) according to the related fields table';

comment on column rows.deleted is 'marks if the row is deleted';

comment on column rows.client_rev_at is 'time of last edit on client';

comment on column rows.client_rev_by is 'user editing last on client';

comment on column rows.server_rev_at is 'time of last edit on server';

drop table if exists row_revs cascade;

create table row_revs (
  id uuid primary key default uuid_generate_v1mc (),
  row_id uuid default null,
  table_id uuid default null,
  geometry geometry(GeometryCollection, 4326) default null,
  data jsonb,
  deleted boolean default false,
  client_rev_at timestamp with time zone default null,
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now(),
  _rev text default null,
  _parent_rev text default null,
  _revisions text[] default null,
  _depth integer default 0
);

create index on row_revs using btree (id);

create index on row_revs using btree (row_id);

create index on row_revs using btree (server_rev_at);

create index on row_revs using btree (_rev);

create index on row_revs using btree (_parent_rev);

create index on row_revs using btree (_depth);

create index on row_revs using btree (deleted);

comment on table row_revs is 'Goal: Sync rows and handle conflicts';

comment on column row_revs.id is 'primary key';

comment on column row_revs.row_id is 'key of table rows';

comment on column row_revs._rev is 'hashed value the fields: row_id, table_id, geometry, data, deleted';

comment on column row_revs._parent_rev is 'hash of the previous revision';

comment on column row_revs._revisions is 'array of hashes of all previous revisions';

comment on column row_revs._depth is 'depth of the revision tree';

drop table if exists files cascade;

create table files (
  id uuid primary key default uuid_generate_v1mc (),
  row_id uuid default null references rows (id) on delete no action on update cascade,
  field_id uuid default null references fields (id) on delete no action on update cascade,
  filename text default null,
  hash text default null,
  version integer default 1,
  deleted boolean default false,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now(),
  _rev text default null,
  _parent_rev text default null,
  _revisions text[] default null,
  _depth integer default 0,
  _deleted boolean default false,
  _conflicts text[] default null
);

create index on files using btree (id);

create index on files using btree (row_id);

create index on files using btree (field_id);

create index on files using btree (filename);

create index on rows using btree (deleted);

comment on table files is 'Goal: Collect data. Versioned in db. Files managed following db data';

comment on column files.id is 'primary key. used as filename in internal and cloud storage';

comment on column files.row_id is 'associated row';

comment on column files.field_id is 'associated field';

comment on column files.filename is 'filename is set to this when exporting files';

comment on column files.hash is 'hash is used if file was accidentally renamed';

comment on column files.version is 'is incremented on every edit of a pre-existing file. Enables clients to re-sync';

comment on column files.deleted is 'marks if the file is deleted';

comment on column files.client_rev_at is 'time of last edit on client';

comment on column files.client_rev_by is 'user editing last on client';

comment on column files.server_rev_at is 'time of last edit on server';

drop table if exists file_revs cascade;

create table file_revs (
  id uuid primary key default uuid_generate_v1mc (),
  row_id uuid default null,
  file_id uuid default null,
  field_id uuid default null,
  filename text default null,
  hash text default null,
  version integer default null,
  deleted boolean default false,
  client_rev_at timestamp with time zone default null,
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now(),
  _rev text default null,
  _parent_rev text default null,
  _revisions text[] default null,
  _depth integer default 0
);

create index on file_revs using btree (id);

create index on file_revs using btree (row_id);

create index on file_revs using btree (file_id);

create index on file_revs using btree (server_rev_at);

create index on file_revs using btree (_rev);

create index on file_revs using btree (_parent_rev);

create index on file_revs using btree (_depth);

create index on file_revs using btree (deleted);

comment on table file_revs is 'Goal: Sync files and handle conflicts';

comment on column file_revs.id is 'primary key';

comment on column file_revs.file_id is 'key of table files';

comment on column file_revs._rev is 'hashed value the fields: file_id, field_id, filename, hash, version, deleted';

comment on column file_revs._parent_rev is 'hash of the previous revision';

comment on column file_revs._revisions is 'array of hashes of all previous revisions';

comment on column file_revs._depth is 'depth of the revision tree';

drop table if exists role_types cascade;

create table role_types (
  value text primary key,
  sort smallint default 1,
  comment text,
  server_rev_at timestamp with time zone default now()
);

create index on role_types using btree (value);

create index on role_types using btree (sort);

create index on role_types using btree (server_rev_at);

comment on table role_types is 'Goal: list of roles';

comment on column role_types.value is 'the role';

comment on column role_types.comment is 'explains the role';

comment on column role_types.sort is 'enables sorting at will';

comment on column role_types.server_rev_at is 'time of last edit on server';

insert into role_types (value, sort, comment)
  values ('account_manager', 1, 'Only role to: create users, give them roles, create projects'), ('project_manager', 2, 'Can edit projects and their structure'), ('project_editor', 3, 'Can edit rows and files'), ('project_reader', 4, 'Can read data')
on conflict on constraint role_types_pkey
  do update set
    comment = excluded.comment;

drop table if exists project_users cascade;

create table project_users (
  id uuid primary key default uuid_generate_v1mc (),
  project_id uuid default null references projects (id) on delete no action on update cascade,
  user_id uuid default null references users (id) on delete no action on update cascade,
  role text default 'project_reader' references role_types (value) on delete no action on update cascade,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now()
);

create index on project_users using btree (id);

create index on project_users using btree (project_id);

create index on project_users using btree (user_id);

create index on project_users using btree (role);

comment on table project_users is 'Goal: Project manager can list users that get this project synced. And give them roles. Not versioned (not recorded and only added by manager)';

comment on column project_users.id is 'primary key';

comment on column project_users.project_id is 'associated project';

comment on column project_users.user_id is 'associated user';

comment on column project_users.role is 'associated role';

comment on column project_users.client_rev_at is 'time of last edit on client';

comment on column project_users.client_rev_by is 'user editing last on client';

comment on column project_users.server_rev_at is 'time of last edit on server';

drop table if exists version_types cascade;

create table version_types (
  value text primary key,
  sort smallint default null,
  comment text,
  server_rev_at timestamp with time zone default now()
);

create index on version_types using btree (value);

create index on version_types using btree (sort);

create index on version_types using btree (server_rev_at);

comment on table version_types is 'Goal: list of version_types';

comment on column version_types.value is 'the version type. See: https://docs.npmjs.com/about-semantic-versioning';

comment on column version_types.value is 'explains the version type';

comment on column version_types.sort is 'enables sorting at will';

comment on column version_types.server_rev_at is 'time of last edit on server';

insert into version_types (value, sort, comment)
  values ('patch', 1, 'Backward compatible bug fixes'), ('minor', 2, 'Backward compatible new features'), ('major', 3, 'Changes that break backward compatibility')
on conflict on constraint version_types_pkey
  do update set
    comment = excluded.comment;

drop table if exists news cascade;

create table news (
  id uuid primary key default uuid_generate_v1mc (),
  time timestamp with time zone default now(),
  version_type text default 'minor' references version_types (value) on delete no action on update cascade,
  version text default null,
  message text default null,
  server_rev_at timestamp with time zone default now()
);

create index on news using btree (id);

create index on news using btree (time);

create index on news using btree (version_type);

comment on table project_users is 'Goal: Inform users about changes to the app. Not versioned';

comment on column news.id is 'primary key';

comment on column news.time is 'time the news was created';

comment on column news.version_type is 'associated version_type';

comment on column news.version is 'version the news refers to';

comment on column news.message is 'this is the news';

comment on column news.server_rev_at is 'time of last edit on server';

drop table if exists news_delivery cascade;

create table news_delivery (
  id uuid primary key default uuid_generate_v1mc (),
  news_id uuid default null references news (id) on delete no action on update cascade,
  user_id uuid default null references users (id) on delete no action on update cascade,
  server_rev_at timestamp with time zone default now()
);

create index on news_delivery using btree (id);

create index on news_delivery using btree (news_id);

create index on news_delivery using btree (user_id);

comment on table project_users is 'Goal: Show new messages only once. Not versioned';

comment on column news_delivery.id is 'primary key';

comment on column news_delivery.news_id is 'associated news';

comment on column news_delivery.user_id is 'associated user';

comment on column news_delivery.server_rev_at is 'time of last edit on server';

-- TODO: vector_layers
--comment on table vector_layers is 'Goal: Bring your own vector layers. File and/or wms. Not versioned (not recorded and only added by manager)';
-- TODO: raster_layers
--comment on table raster_layers is 'Goal: Bring your own raster layers. File and/or wms. Not versioned (not recorded and only added by manager)';
