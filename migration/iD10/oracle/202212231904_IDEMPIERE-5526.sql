-- IDEMPIERE-5526
SELECT register_migration_script('202212231904_IDEMPIERE-5526.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 23, 2022, 7:04:21 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','{0} recursively contains {1}',0,0,'Y',TO_TIMESTAMP('2022-12-23 19:04:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-23 19:04:20','YYYY-MM-DD HH24:MI:SS'),100,200811,'BOMRecursivelyContains','D','90eea01f-b0fc-4d72-b40d-70ae6fe43ffd')
;

-- Dec 23, 2022, 7:06:54 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No default BOM for product {0}',0,0,'Y',TO_TIMESTAMP('2022-12-23 19:06:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-23 19:06:53','YYYY-MM-DD HH24:MI:SS'),100,200812,'BOMNoDefaultBOMForProduct','D','12514fa3-0f5c-4af3-8b3a-0000e38fabca')
;

-- Dec 23, 2022, 7:07:27 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','BOM missing for product {0}',0,0,'Y',TO_TIMESTAMP('2022-12-23 19:07:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-23 19:07:26','YYYY-MM-DD HH24:MI:SS'),100,200813,'BOMMissingForProduct','D','caf952ea-a0f9-44da-be9e-5c79c3861649')
;

-- Dec 23, 2022, 7:07:33 PM BRT
UPDATE AD_Message SET MsgType='E',Updated=TO_TIMESTAMP('2022-12-23 19:07:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200813
;

-- Dec 23, 2022, 7:08:10 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','BOM {0} for product {1} does not have lines',0,0,'Y',TO_TIMESTAMP('2022-12-23 19:08:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-12-23 19:08:10','YYYY-MM-DD HH24:MI:SS'),100,200814,'BOMForProductDoesNotHaveLines','D','356544c0-e10f-4bb9-9215-a93b2f67243f')
;

-- Jan 14, 2023, 6:10:27 PM CET
UPDATE AD_Process_Para SET ReadOnlyLogic='@M_Product_ID@>0 & @_WinInfo_AD_Window_ID:0@>0',Updated=TO_TIMESTAMP('2023-01-14 18:10:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53461
;

