-- IDEMPIERE-6640 DBA - Tuning AD_Attachment (FHCA-3962)
-- Ignore error in function delete_ad_attachment_binary if the large object does not exist
SELECT register_migration_script('202512252116_IDEMPIERE-6640.sql') FROM dual;

CREATE OR REPLACE FUNCTION delete_ad_attachment_binary()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.binarydata IS NOT NULL AND OLD.binarydata <> 0 THEN
        BEGIN
            PERFORM lo_unlink(OLD.binarydata);
        EXCEPTION
            WHEN undefined_object THEN
                -- Silently ignore if large object doesn't exist
                NULL;
        END;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

