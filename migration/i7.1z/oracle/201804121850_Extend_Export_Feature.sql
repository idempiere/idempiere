SET SQLBLANKLINES ON
SET DEFINE OFF

-- Excel 2007 support in idempiere
-- Apr 12, 2018 3:12:17 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','xlsx - Excel file',0,0,'Y',TO_DATE('2018-04-12 15:12:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-04-12 15:12:16','YYYY-MM-DD HH24:MI:SS'),100,200451,'FileXLSX','D','48cc5032-f2c7-4b27-99bc-05c6269d032b')
;

SELECT register_migration_script('201804121850_Extend_Export_Feature.sql') FROM dual
;

