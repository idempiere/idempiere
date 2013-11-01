-- 16/10/2013 06:08:38 PM COT
-- IDEMPIERE-1432 Drag and Drop Translation missing
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','(Drag and drop menu item here)',200236,'D','f78e351a-68f9-494d-abd2-421b3ffd4633','DropMenuItemHere','Y',TO_TIMESTAMP('2013-10-16 18:08:36','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-10-16 18:08:36','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201310161811_IDEMPIERE-1432.sql') FROM dual
;

