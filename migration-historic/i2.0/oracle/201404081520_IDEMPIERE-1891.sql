SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 8, 2014 3:18:45 PM CEST
-- IDEMPIERE-1891
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200269,'0b36ffa9-8364-4d93-8d9a-1e3eae4aa81b',0,TO_DATE('2014-04-08 15:18:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','You cannot access process {0} with your role : {1}','I',TO_DATE('2014-04-08 15:18:44','YYYY-MM-DD HH24:MI:SS'),100,'CannotAccessProcess')
;

SELECT register_migration_script('201404081520_IDEMPIERE-1891.sql') FROM dual
;
