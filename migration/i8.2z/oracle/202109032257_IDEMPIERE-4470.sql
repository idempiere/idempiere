SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4364 - Advanced Search - Allow select column from window tabs.
-- Jul 17, 2020, 9:33:17 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','AND NOT',0,0,'Y',TO_DATE('2020-07-17 09:33:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-07-17 09:33:17','YYYY-MM-DD HH24:MI:SS'),100,200621,'ANDNOT','D','edddd9d0-bfc5-44b9-bba8-cfa4e5ab8d2a')
;

-- Jul 17, 2020, 9:35:20 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','OR NOT',0,0,'Y',TO_DATE('2020-07-17 09:35:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-07-17 09:35:20','YYYY-MM-DD HH24:MI:SS'),100,200622,'ORNOT','D','dc113e24-35bc-4736-8de0-22a036e9f01b')
;

SELECT register_migration_script('202109032257_IDEMPIERE-4470.sql') FROM dual
;

