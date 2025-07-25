CREATE OR REPLACE FUNCTION delete_ad_archive_binary()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.binarydata IS NOT NULL AND OLD.binarydata <> 0 THEN
        PERFORM lo_unlink(OLD.binarydata);
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_ad_archive_binary
BEFORE DELETE ON ad_archive_blob
FOR EACH ROW
EXECUTE FUNCTION delete_ad_archive_binary();

