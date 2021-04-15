-- 1. first set the revision fields
--    assumption: client passed in values from the row
--    TODO: client needs to update it's own row though - so this does not make sense?
CREATE OR REPLACE FUNCTION trigger_row_revs_set_revision_fields ()
  RETURNS TRIGGER
  AS $$
DECLARE
  new_depth int := NEW._depth + 1;
  -- `${newDepth}-${md5(JSON.stringify(newObject))}`:
  new_rev text := concat(new_depth, '-', md5(concat('{', 'row_id:', NEW.row_id, 'table_id:', NEW.table_id, 'geometry:', NEW.geometry, 'data:', NEW.data, 'deleted:', NEW.deleted, '_parent_rev:', NEW._rev, '}')));
BEGIN
  NEW._parent_rev := NEW._rev;
  NEW._depth := new_depth;
  NEW._rev := new_rev;
  NEW._revisions := array_append(NEW._revisions, new_rev);
  RETURN new;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trigger_row_revs_set_revision_fields
  BEFORE INSERT ON row_revs FOR EACH ROW
  EXECUTE PROCEDURE trigger_row_revs_set_revision_fields ();

-- 2. now that the revision fields are set (either by client or before insert trigger),
--    choose winner and upsert row
CREATE OR REPLACE FUNCTION row_revs_children (row_id uuid, parent_rev text)
  RETURNS SETOF row_revs
  AS $$
  SELECT
    *
  FROM
    row_revs
  WHERE
    row_revs.row_id = $1
    -- its parent is the row_rev, thus this is its child
    AND row_revs._parent_rev = $2
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION row_revs_leaves (row_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS SETOF row_revs
  AS $$
  SELECT
    *
  FROM
    row_revs
  WHERE
    -- of this record
    row_id = $1
    -- undeleted
    AND deleted = $2
    -- leaves
    AND NOT EXISTS (
      SELECT
        1
      FROM
        row_revs_children ($1, row_revs._rev));

$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION row_revs_max_depth (row_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS int
  AS $$
  SELECT
    max(_depth)
  FROM
    row_revs_leaves ($1, $2);

$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION row_revs_winner_rev_value (row_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS text
  AS $$
  SELECT
    -- here we choose the winning revision
    max(leaves._rev) AS _rev
  FROM
    row_revs_leaves ($1, $2) AS leaves
WHERE
  row_revs_max_depth ($1, $2) = leaves._depth
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION row_revs_winner (row_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS SETOF row_revs
  AS $$
  SELECT
    *
  FROM
    row_revs_leaves ($1, $2) AS leaves
WHERE
  leaves._rev = row_revs_winner_rev_value ($1, $2)
  OR (leaves._rev IS NULL
    AND row_revs_winner_rev_value ($1, $2) IS NULL)
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION row_conflicts_of_winner (row_id uuid, deleted boolean DEFAULT FALSE)
  RETURNS text[]
  AS $$
  SELECT
    ARRAY (
      SELECT
        _rev
      FROM
        row_revs_leaves ($1, $2)
      WHERE
        _rev <> row_revs._rev)
  FROM
    row_revs_winner ($1, $2) AS row_revs
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION row_revs_set_winning_revision ()
  RETURNS TRIGGER
  AS $$
BEGIN
  IF EXISTS (
    SELECT
      1
    FROM
      row_revs_winner (NEW.row_id, FALSE))
  -- 1. if a winning undeleted leaf exists, use this
  --    (else pick a winner from the deleted leaves)
  THEN
  INSERT INTO ROWS (id, table_id, geometry, data, deleted, client_rev_at, client_rev_by, server_rev_at, _rev, _revisions, _parent_rev, _depth, _conflicts)
  SELECT
    winner.row_id,
    winner.table_id,
    winner.geometry,
    winner.data,
    winner.deleted,
    winner.client_rev_at,
    winner.client_rev_by,
    winner.server_rev_at,
    winner._rev,
    winner._revisions,
    winner._parent_rev,
    winner._depth,
    row_conflicts_of_winner (NEW.row_id) AS _conflicts
FROM
  row_revs_winner (NEW.row_id) AS winner
ON CONFLICT (id)
  DO UPDATE SET
    -- do not update the id
    table_id = excluded.table_id,
    geometry = excluded.geometry,
    data = excluded.data,
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
  INSERT INTO ROWS (id, table_id, geometry, data, deleted, client_rev_at, client_rev_by, server_rev_at, _rev, _revisions, _parent_rev, _depth, _conflicts)
  SELECT
    winner.row_id,
    winner.table_id,
    winner.geometry,
    winner.data,
    winner.deleted,
    winner.client_rev_at,
    winner.client_rev_by,
    winner.server_rev_at,
    winner._rev,
    winner._revisions,
    winner._parent_rev,
    winner._depth,
    row_conflicts_of_winner (NEW.row_id, TRUE) AS _conflicts
  FROM
    row_revs_winner (NEW.row_id, TRUE) AS winner
ON CONFLICT (id)
  DO UPDATE SET
    -- do not update the id
    table_id = excluded.table_id,
    geometry = excluded.geometry,
    data = excluded.data,
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

CREATE TRIGGER trigger_row_revs_set_winning_revision
  AFTER INSERT ON row_revs FOR EACH ROW
  EXECUTE PROCEDURE row_revs_set_winning_revision ();

