-- IDEMPIERE-5624 Implement export data as SQL insert statement
SELECT register_migration_script('202303111206_IDEMPIERE-5624.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 11, 2023, 12:06:48 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','zip - SQL zip file','Zip archive of Oracle and PostgreSQL Insert SQL scripts',0,0,'Y',TO_TIMESTAMP('2023-03-11 12:06:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-11 12:06:46','YYYY-MM-DD HH24:MI:SS'),100,200825,'FileSQLInsertZip','D','9308f542-5ab1-4462-90a3-c0d70b2eb009')
;

-- Mar 11, 2023, 12:11:29 PM MYT
UPDATE AD_Message SET MsgText='zip - SQL Insert scripts zip archive', MsgTip=NULL,Updated=TO_TIMESTAMP('2023-03-11 12:11:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200825
;

