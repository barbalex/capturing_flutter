INSERT INTO users (id, name, email, auth_id, client_rev_by)
  VALUES ('a1830c80-824d-11eb-8dcd-0242ac130003', 'test tester', 'test@tester.ch', 'ba4964bc-824d-11eb-8dcd-0242ac130003', 'a1830c80-824d-11eb-8dcd-0242ac130003');

INSERT INTO accounts (id, service_id, manager_id, client_rev_by)
  VALUES ('b3c51c30-824d-11eb-8dcd-0242ac130003', '15536cc2-824e-11eb-8dcd-0242ac130003', 'a1830c80-824d-11eb-8dcd-0242ac130003', 'a1830c80-824d-11eb-8dcd-0242ac130003');

UPDATE
  users
SET
  account_id = 'b3c51c30-824d-11eb-8dcd-0242ac130003'
WHERE
  id = 'a1830c80-824d-11eb-8dcd-0242ac130003';

INSERT INTO projects (id, account_id, name, label, client_rev_by)
  VALUES ('b3188c9e-824e-11eb-8dcd-0242ac130003', 'b3c51c30-824d-11eb-8dcd-0242ac130003', 'test_project', 'test-project 1', 'a1830c80-824d-11eb-8dcd-0242ac130003');

INSERT INTO project_users (id, project_id, user_id, ROLE, client_rev_by)
  VALUES ('11c01c30-824f-11eb-8dcd-0242ac130003', 'b3188c9e-824e-11eb-8dcd-0242ac130003', 'a1830c80-824d-11eb-8dcd-0242ac130003', 'account_manager', 'a1830c80-824d-11eb-8dcd-0242ac130003');

INSERT INTO tables (id, project_id, name, label, client_rev_by)
  VALUES ('961c4cba-824f-11eb-8dcd-0242ac130003', 'b3188c9e-824e-11eb-8dcd-0242ac130003', 'test_table_1', 'test-table 1', 'a1830c80-824d-11eb-8dcd-0242ac130003');

INSERT INTO fields (id, table_id, name, label, field_type, widget_type, client_rev_by)
  VALUES ('ed1bd6c0-824f-11eb-8dcd-0242ac130003', '961c4cba-824f-11eb-8dcd-0242ac130003', 'field_1', 'field 1', 'text', 'text', 'a1830c80-824d-11eb-8dcd-0242ac130003'), ('25d1ec5c-8250-11eb-8dcd-0242ac130003', '961c4cba-824f-11eb-8dcd-0242ac130003', 'field_2', 'field 2', 'integer', 'text', 'a1830c80-824d-11eb-8dcd-0242ac130003');

INSERT INTO row_revs (row_id, table_id, data, client_rev_by)
  VALUES ('a5aeaa00-8250-11eb-8dcd-0242ac130003', '961c4cba-824f-11eb-8dcd-0242ac130003', '{"field_1": "test in field 1", "field_2": "test in field 2"}', 'a1830c80-824d-11eb-8dcd-0242ac130003');

INSERT INTO row_revs (row_id, table_id, data, client_rev_by, rev, revisions, depth)
  VALUES ('a5aeaa00-8250-11eb-8dcd-0242ac130003', '961c4cba-824f-11eb-8dcd-0242ac130003', '{"field_1": "test in field 1, verändert", "field_2": "test in field 2"}', 'a1830c80-824d-11eb-8dcd-0242ac130003', '1-1602ce5d8b68fd0172ef11a2598eedfe', '{"1-1602ce5d8b68fd0172ef11a2598eedfe"}', 1);

INSERT INTO file_revs (file_id, row_id, field_id, filename, hash, version, client_rev_by)
  VALUES ('93c4dac0-8274-11eb-8dcd-0242ac130003', 'a5aeaa00-8250-11eb-8dcd-0242ac130003', 'ed1bd6c0-824f-11eb-8dcd-0242ac130003', 'test-filename', 'test-hash', 1, 'a1830c80-824d-11eb-8dcd-0242ac130003');

INSERT INTO file_revs (file_id, row_id, field_id, filename, hash, version, client_rev_by, rev, revisions, depth)
  VALUES ('93c4dac0-8274-11eb-8dcd-0242ac130003', 'a5aeaa00-8250-11eb-8dcd-0242ac130003', 'ed1bd6c0-824f-11eb-8dcd-0242ac130003', 'test-filename changed', 'test-hash', 1, 'a1830c80-824d-11eb-8dcd-0242ac130003', '1-c407553f4c296c44ddd2b8c24ef847a7
', '{"1-c407553f4c296c44ddd2b8c24ef847a7"}', 1);

