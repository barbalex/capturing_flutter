-- https://dbdiagram.io/d/6048d556fcdcb6230b237d7f

drop table if exists users cascade;
create table users (
  id uuid primary key default uuid_generate_v1mc(),
  name text default null,
  email text default null,
  account_id uuid default null, -- references accounts (id) on delete no action on update cascade,
  auth_id text,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now()
);

drop table if exists accounts cascade;
create table accounts (
  id uuid primary key default uuid_generate_v1mc(),
  service_id text default null,
  manager_id uuid,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now()
  -- any more?
);

-- need to wait to create this reference until accounts exists:
alter table users add foreign key (account_id) references accounts (id) on delete no action on update cascade;

drop table if exists projects cascade;
create table projects (
  id uuid primary key default uuid_generate_v1mc(),
  account_id uuid default null references accounts (id) on delete no action on update cascade,
  name text default null,
  label text default null,
  srs_id integer default 4326,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now(),
  unique (account_id, name)
  -- geometry?
  -- data?
);

drop table if exists tables cascade;
create table tables (
  id uuid primary key default uuid_generate_v1mc(),
  project_id uuid default null references projects (id) on delete no action on update cascade,
  parent_id uuid default null references tables (id) on delete no action on update cascade,
  rel_type text,
  name text default null,
  label text default null,
  is_options boolean default false,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now(),
  unique (project_id, name)
);

drop table if exists fields cascade;
create table fields (
  id uuid primary key default uuid_generate_v1mc(),
  table_id uuid default null references tables (id) on delete no action on update cascade,
  name text default null,
  label text default null,
  is_internal_id boolean default false,
  field_type text,
  widget_type text,
  options_table uuid references tables (id) on delete no action on update cascade,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now(),
  unique (table_id, name)
);

drop table if exists rows cascade;
create table rows (
  id uuid primary key default uuid_generate_v1mc(),
  table_id uuid default null references tables (id) on delete no action on update cascade,
  geometry geometry(GeometryCollection, 4326) default null,
  srs_id integer default 4326,
  data jsonb,
  deleted boolean default false,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now(),
  rev text default null,
  parent_rev text default null,
  revisions text default null,
  depth integer default 1,
  deleted boolean default false,
  conflicts text default null
);

drop table if exists files cascade;
create table files (
  id uuid primary key default uuid_generate_v1mc(),
  row_id uuid default null references rows (id) on delete no action on update cascade,
  field_id uuid default null references fields (id) on delete no action on update cascade,
  filename text default null,
  hash text default null,
  version integer default 1,
  deleted boolean default false,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now(),
  rev text default null,
  parent_rev text default null,
  revisions text default null,
  depth integer default 1,
  deleted boolean default false,
  conflicts text default null
);

drop table if exists project_users cascade;
create table project_users (
  id uuid primary key default uuid_generate_v1mc(),
  project_id uuid default null references projects (id) on delete no action on update cascade,
  user_id uuid default null references users (id) on delete no action on update cascade,
  role text,
  client_rev_at timestamp with time zone default now(),
  client_rev_by uuid default null,
  server_rev_at timestamp with time zone default now()
);
