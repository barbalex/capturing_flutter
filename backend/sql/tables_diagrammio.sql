-- https://dbdiagram.io/d/6048d556fcdcb6230b237d7f

CREATE TABLE "users" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v1mc()),
  "name" text DEFAULT null,
  "email" text DEFAULT null,
  "account_id" uuid DEFAULT null,
  "auth_id" text,
  "client_rev_at" timestamp DEFAULT (now()),
  "client_rev_by" uuid DEFAULT null,
  "server_rev_at" timestamp DEFAULT (now()),
  "deleted" boolean DEFAULT false
);

CREATE TABLE "accounts" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v1mc()),
  "service_id" text DEFAULT null,
  "client_rev_at" timestamp DEFAULT (now()),
  "client_rev_by" uuid DEFAULT null,
  "server_rev_at" timestamp DEFAULT (now()),
  "deleted" boolean DEFAULT false
);

CREATE TABLE "projects" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v1mc()),
  "account_id" uuid UNIQUE DEFAULT null,
  "name" text UNIQUE DEFAULT null,
  "label" text DEFAULT null,
  "srs_id" integer DEFAULT 4326,
  "client_rev_at" timestamp DEFAULT (now()),
  "client_rev_by" uuid DEFAULT null,
  "server_rev_at" timestamp DEFAULT (now()),
  "deleted" boolean DEFAULT false
);

CREATE TABLE "tables" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v1mc()),
  "project_id" uuid UNIQUE DEFAULT null,
  "parent_id" uuid DEFAULT null,
  "rel_type" text,
  "name" text UNIQUE DEFAULT null,
  "label" text DEFAULT null,
  "option_type" text,
  "client_rev_at" timestamp DEFAULT (now()),
  "client_rev_by" uuid DEFAULT null,
  "server_rev_at" timestamp DEFAULT (now()),
  "deleted" boolean DEFAULT false
);

CREATE TABLE "fields" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v1mc()),
  "table_id" uuid UNIQUE DEFAULT null,
  "name" text UNIQUE DEFAULT null,
  "label" text DEFAULT null,
  "is_internal_id" boolean DEFAULT false,
  "field_type" text,
  "widget_type" text,
  "options_table" uuid,
  "standard_value" text,
  "client_rev_at" timestamp DEFAULT (now()),
  "client_rev_by" uuid DEFAULT null,
  "server_rev_at" timestamp DEFAULT (now())
);

CREATE TABLE "rows" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v1mc()),
  "table_id" uuid DEFAULT null,
  "geometry" "geometry(GeometryCollection, 4326)" DEFAULT null,
  "srs_id" integer DEFAULT 4326,
  "data" jsonb,
  "client_rev_at" timestamp DEFAULT (now()),
  "client_rev_by" uuid DEFAULT null,
  "server_rev_at" timestamp DEFAULT (now()),
  "rev" text DEFAULT null,
  "parent_rev" text DEFAULT null,
  "revisions" text DEFAULT null,
  "depth" integer DEFAULT 1,
  "deleted" boolean DEFAULT false,
  "conflicts" text DEFAULT null
);

CREATE TABLE "files" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v1mc()),
  "row_id" uuid DEFAULT null,
  "field_id" uuid DEFAULT null,
  "filename" text DEFAULT null,
  "url" text DEFAULT null,
  "version" integer DEFAULT 1,
  "client_rev_at" timestamp DEFAULT (now()),
  "client_rev_by" uuid DEFAULT null,
  "server_rev_at" timestamp DEFAULT (now()),
  "rev" text DEFAULT null,
  "parent_rev" text DEFAULT null,
  "revisions" text DEFAULT null,
  "depth" integer DEFAULT 1,
  "deleted" boolean DEFAULT false,
  "conflicts" text DEFAULT null
);

CREATE TABLE "project_users" (
  "id" uuid PRIMARY KEY DEFAULT (uuid_generate_v1mc()),
  "project_id" uuid DEFAULT null,
  "user_email" text DEFAULT null,
  "role" text,
  "client_rev_at" timestamp DEFAULT (now()),
  "client_rev_by" uuid DEFAULT null,
  "server_rev_at" timestamp DEFAULT (now()),
  "deleted" boolean DEFAULT false
);

ALTER TABLE "users" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "projects" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "tables" ADD FOREIGN KEY ("project_id") REFERENCES "projects" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "tables" ADD FOREIGN KEY ("parent_id") REFERENCES "tables" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "fields" ADD FOREIGN KEY ("table_id") REFERENCES "tables" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "fields" ADD FOREIGN KEY ("options_table") REFERENCES "tables" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "rows" ADD FOREIGN KEY ("table_id") REFERENCES "tables" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "files" ADD FOREIGN KEY ("row_id") REFERENCES "rows" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "files" ADD FOREIGN KEY ("field_id") REFERENCES "fields" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "project_users" ADD FOREIGN KEY ("project_id") REFERENCES "projects" ("id") ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE "project_users" ADD FOREIGN KEY ("user_email") REFERENCES "users" ("email") ON DELETE NO ACTION ON UPDATE CASCADE;
