-- Jul 12, 2014 3:39:07 PM ICT
-- Jul 12, 2014 3:39:16 PM ICT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Select tab to export',200303,'D','8ebc806d-f410-433a-b3d6-152133bd6d63','SelectTabToExport','Y',TO_TIMESTAMP('2014-07-12 15:39:15','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2014-07-12 15:39:15','YYYY-MM-DD HH24:MI:SS'))
;
SELECT register_migration_script('201407121604_IDEMPIERE-2052.sql') FROM dual
;
