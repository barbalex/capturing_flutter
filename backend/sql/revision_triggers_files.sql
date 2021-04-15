-- 1. first set the revision fields
--    assumption: client passed in values from the file
--    TODO: client needs to update it's own file though - so this does not make sense?
CREATE OR REPLACE FUNCTION trigger_file_revs_set_revision_fields ()
  RETURNS TRIGGER
  AS $$
DECLARE
  new_depth int := NEW._depth + 1;
  -- `${newDepth}-${md5(JSON.stringify(newObject))}`:
  new_rev text := concat(new_depth, '-', md5(concat('{', 'file_id:', NEW.file_id, 'row_id:', NEW.row_id, 'field_id:', NEW.field_id, 'filename:', NEW.filename, 'hash:', NEW.hash, 'version:', NEW.version, 'deleted:', NEW.deleted, '_parent_rev:', NEW._rev, '}')));
BEGIN
  NEW._parent_rev := NEW._rev;
  NEW._depth := new_depth;
  NEW._rev := new_rev;
  NEW._revisions := array_append(NEW._revisions, new_rev);
  RETURN new;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trigger_file_revs_set_revision_fields
  BEFORE INSERT ON file_revs
  FOR EACH ROW
  EXECUTE PROCEDURE trigger_file_revs_set_revision_fields ();

-- 2. now that the revision fields are set (either by client or before insert trigger),
--    choose winner and upsert file
CREATE OR REPLACE FUNCTION file_revs_children (file_id uuid, parent_rev text)
  RETURNS SETOF file_revs
  AS $$
  SELECT
    *
  FROM
    file_revs
  WHERE
    file_revs.file_id = $1
    -- its parent is the file_rev, thus this is its child
    AND file_revs._parent_rev = $2
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION file_revs_leaves (file_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS SETOF file_revs
  AS $$
  SELECT
    *
  FROM
    file_revs
  WHERE
    -- of this record
    file_id = $1
    -- undeleted
    AND deleted = $2
    -- leaves
    AND NOT EXISTS (
      SELECT
        1
      FROM
        file_revs_children ($1, file_revs._rev));

$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION file_revs_max_depth (file_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS int
  AS $$
  SELECT
    max(_depth)
  FROM
    file_revs_leaves ($1, $2);

$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION file_revs_winner_rev_value (file_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS text
  AS $$
  SELECT
    -- here we choose the winning revision
    max(leaves._rev) AS _rev
  FROM
    file_revs_leaves ($1, $2) AS leaves
WHERE
  file_revs_max_depth ($1, $2) = leaves._depth
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION file_revs_winner (file_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS SETOF file_revs
  AS $$
  SELECT
    *
  FROM
    file_revs_leaves ($1, $2) AS leaves
WHERE
  leaves._rev = file_revs_winner_rev_value ($1, $2)
  OR (leaves._rev IS NULL
    AND file_revs_winner_rev_value ($1, $2) IS NULL)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION file_conflicts_of_winner (file_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS text[]
  AS $$
  SELECT
    ARRAY (
      SELECT
        _rev
      FROM
        file_revs_leaves ($1, $2)
      WHERE
        _rev <> file_revs._rev)
  FROM
    file_revs_winner ($1, $2) AS file_revs
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION file_revs_set_winning_revision ()
  RETURNS TRIGGER
  AS $$
BEGIN
  IF EXISTS (
    SELECT
      1
    FROM
      file_revs_winner (NEW.file_id, FALSE))
  -- 1. if a winning undeleted leaf exists, use this
  --    (else pick a winner from the deleted leaves)
  THEN
  INSERT INTO files (id, row_id, field_id, filename, hash, version, deleted, client_rev_at, client_rev_by, server_rev_at, _rev, _revisions, _parent_rev, _depth, _conflicts)
  SELECT
    winner.file_id,
    row_id,
    winner.field_id,
    winner.filename,
    winner.hash,
    winner.version,
    winner.deleted,
    winner.client_rev_at,
    winner.client_rev_by,
    winner.server_rev_at,
    winner._rev,
    winner._revisions,
    winner._parent_rev,
    winner._depth,
    file_conflicts_of_winner (NEW.file_id) AS _conflicts
FROM
  file_revs_winner (NEW.file_id) AS winner
ON CONFLICT (id)
  DO UPDATE SET
    -- do not update the idrow_id,
    field_id = excluded.field_id,
    filename = excluded.filename,
    hash = excluded.hash,
    version = excluded.version,
    deleted = excluded.deleted,
    client_rev_at = excluded.client_rev_at,
    client_rev_by = excluded.client_rev_by,
    server_rev_at = excluded.server_rev_at,
    _rev = excluded._rev,
    _revisions = excluded._revisions,
    _parent_rev = excluded._parent_rev,
    _depth = excluded._depth,
    _conflicts = excluded._conflicts;
ELSE
  -- 2. so there is no undeleted winning leaf
  --    choose winner from deleted leaves
  --    is necessary to set the winner deleted
  --    so the client can pick this up
  INSERT INTO files (id, row_id, field_id, filename, hash, version, deleted, client_rev_at, client_rev_by, server_rev_at, _rev, _revisions, _parent_rev, _depth, _conflicts)
  SELECT
    winner.file_id,
    row_id,
    winner.field_id,
    winner.filename,
    winner.hash,
    winner.version,
    winner.deleted,
    winner.client_rev_at,
    winner.client_rev_by,
    winner.server_rev_at,
    winner._rev,
    winner._revisions,
    winner._parent_rev,
    winner._depth,
    file_conflicts_of_winner (NEW.file_id, TRUE) AS _conflicts
  FROM
    file_revs_winner (NEW.file_id, TRUE) AS winner
ON CONFLICT (id)
  DO UPDATE SET
    -- do not update the idrow_id,
    field_id = excluded.field_id,
    filename = excluded.filename,
    hash = excluded.hash,
    version = excluded.version,
    deleted = excluded.deleted,
    client_rev_at = excluded.client_rev_at,
    client_rev_by = excluded.client_rev_by,
    server_rev_at = excluded.server_rev_at,
    _rev = excluded._rev,
    _revisions = excluded._revisions,
    _parent_rev = excluded._parent_rev,
    _depth = excluded._depth,
    _conflicts = excluded._conflicts;
END IF;
  RETURN new;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trigger_file_revs_set_winning_revision
  AFTER INSERT ON file_revs
  FOR EACH ROW
  EXECUTE PROCEDURE file_revs_set_winning_revision ();

