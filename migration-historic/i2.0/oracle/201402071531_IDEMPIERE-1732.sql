SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 7, 2014 3:29:48 PM COT
-- IDEMPIERE-1732 two users can complete same M_InOut and data is corrupted
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','Document status has been changed by other session, please refresh the record and try again.',200254,'D','de43afaf-61eb-4b85-bedd-5c599133a3f9','DocStatusChanged','Y',TO_DATE('2014-02-07 15:29:46','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2014-02-07 15:29:46','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201402071531_IDEMPIERE-1732.sql') FROM dual
;

