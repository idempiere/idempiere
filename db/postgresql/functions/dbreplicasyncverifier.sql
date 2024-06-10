/*
CREATE TABLE dbreplicasyncverifier (lastupdate date)
;

INSERT INTO dbreplicasyncverifier values (to_date('1900-01-01 00:00:00', 'yyyy-mm-dd HH24:MI:SS'))
;
*/

CREATE OR REPLACE FUNCTION forbid_multiple_rows_in_dbreplicasyncverifier()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the table already contains a row
    IF (SELECT COUNT(*) FROM dbreplicasyncverifier) > 0 THEN
        RAISE EXCEPTION 'Table can only contain one row.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql
;

CREATE TRIGGER single_row_only_trigger_dbreplicasyncverifier
BEFORE INSERT ON dbreplicasyncverifier
FOR EACH ROW
EXECUTE FUNCTION forbid_multiple_rows_in_dbreplicasyncverifier()
;

CREATE OR REPLACE RULE delete_dbreplicasyncverifier AS ON DELETE TO dbreplicasyncverifier DO INSTEAD NOTHING
;

