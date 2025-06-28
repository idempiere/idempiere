-- IDEMPIERE-6570 Improve attachment support for large file
SELECT register_migration_script('202506210625_IDEMPIERE-6570.sql') FROM dual;

-- Jun 21, 2025, 6:25:47 AM MYT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200724,'Database with Large Object Support','Use blob for storage of big file and with lazy loading support',200019,'DB_LOB',0,0,'Y',TO_TIMESTAMP('2025-06-21 06:25:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-21 06:25:47','YYYY-MM-DD HH24:MI:SS'),100,'D','eea57fee-cb78-4344-ac0a-474508616dff')
;

CREATE OR REPLACE FUNCTION delete_ad_attachment_binary()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.binarydata IS NOT NULL AND OLD.binarydata <> 0 THEN
        PERFORM lo_unlink(OLD.binarydata);
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_ad_attachment_binary
BEFORE DELETE ON ad_attachment_entry
FOR EACH ROW
EXECUTE FUNCTION delete_ad_attachment_binary();
