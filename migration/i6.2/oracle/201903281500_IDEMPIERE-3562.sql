SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3562 Timeline view of record changes
-- Mar 28, 2019, 3:57:53 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Time Line',0,0,'Y',TO_DATE('2019-03-28 15:57:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-28 15:57:52','YYYY-MM-DD HH24:MI:SS'),100,200491,'TimeLine','D','744a1b33-8052-457e-b763-73a75d7b4d52')
;

SELECT register_migration_script('201903281500_IDEMPIERE-3562.sql') FROM dual
;

