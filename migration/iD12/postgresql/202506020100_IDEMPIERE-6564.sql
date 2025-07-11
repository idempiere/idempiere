-- IDEMPIERE-6564
SELECT register_migration_script('202506020100_IDEMPIERE-6564.sql') FROM dual;

CREATE TABLE ad_archive_blob (ad_archive_id numeric(10, 0) not null references ad_archive(ad_archive_id) on delete cascade DEFERRABLE INITIALLY DEFERRED, binarydata oid, unique(ad_archive_id));

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
