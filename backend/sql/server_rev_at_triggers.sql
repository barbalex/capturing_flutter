-- need to set server_rev_at on updates to non-revisioned tables
create or replace function users_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_users_set_server_rev_at
  after update on users
  for each row
  execute procedure users_set_server_rev_at ();

-- accounts
create or replace function accounts_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_accounts_set_server_rev_at
  after update on accounts
  for each row
  execute procedure accounts_set_server_rev_at ();

-- projects
create or replace function projects_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_projects_set_server_rev_at
  after update on projects
  for each row
  execute procedure projects_set_server_rev_at ();

-- rel_types
create or replace function rel_types_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_rel_types_set_server_rev_at
  after update on rel_types
  for each row
  execute procedure rel_types_set_server_rev_at ();

-- tables
create or replace function tables_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_tables_set_server_rev_at
  after update on tables
  for each row
  execute procedure tables_set_server_rev_at ();

-- field_types
create or replace function field_types_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_field_types_set_server_rev_at
  after update on field_types
  for each row
  execute procedure field_types_set_server_rev_at ();

-- widget_types
create or replace function widget_types_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_widget_types_set_server_rev_at
  after update on widget_types
  for each row
  execute procedure widget_types_set_server_rev_at ();

-- fields
create or replace function fields_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_fields_set_server_rev_at
  after update on fields
  for each row
  execute procedure fields_set_server_rev_at ();

-- role_types
create or replace function role_types_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_role_types_set_server_rev_at
  after update on role_types
  for each row
  execute procedure role_types_set_server_rev_at ();

-- project_users
create or replace function project_users_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_project_users_set_server_rev_at
  after update on project_users
  for each row
  execute procedure project_users_set_server_rev_at ();

-- version_types
create or replace function version_types_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_version_types_set_server_rev_at
  after update on version_types
  for each row
  execute procedure version_types_set_server_rev_at ();

-- news
create or replace function news_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_news_set_server_rev_at
  after update on news
  for each row
  execute procedure news_set_server_rev_at ();

-- news_delivery
create or replace function news_delivery_set_server_rev_at ()
  returns trigger as $$
begin
  new.server_rev_at = now();
  return new;
end;
$$ language plpgsql;

create trigger trigger_news_delivery_set_server_rev_at
  after update on news_delivery
  for each row
  execute procedure news_delivery_set_server_rev_at ();