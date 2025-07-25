-- IDEMPIERE-6617
SELECT register_migration_script('202507100820_IDEMPIERE-6617.sql') FROM dual;

CREATE TABLE ad_image_blob (ad_image_id numeric(10, 0) not null references ad_image(ad_image_id) on delete cascade DEFERRABLE INITIALLY DEFERRED, binarydata oid, unique(ad_image_id));

CREATE OR REPLACE FUNCTION delete_ad_image_binary()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.binarydata IS NOT NULL AND OLD.binarydata <> 0 THEN
        PERFORM lo_unlink(OLD.binarydata);
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_ad_image_binary
BEFORE DELETE ON ad_image_blob
FOR EACH ROW
EXECUTE FUNCTION delete_ad_image_binary();
