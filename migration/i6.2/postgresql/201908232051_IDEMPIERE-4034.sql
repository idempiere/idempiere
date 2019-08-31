-- IDEMPIERE-4034 - Payment Selection improvements/bugs
-- Aug 23, 2019, 7:04:12 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Only positive balance','',0,0,'Y',TO_TIMESTAMP('2019-08-23 19:04:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-23 19:04:11','YYYY-MM-DD HH24:MI:SS'),100,200537,'PositiveBalance','D','9184dbfd-02c9-4881-9dad-c3a6b390da1e')
;

-- Aug 23, 2019, 8:27:41 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203357,0,0,'Y',TO_TIMESTAMP('2019-08-23 20:27:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-23 20:27:40','YYYY-MM-DD HH24:MI:SS'),100,'PositiveBalance','Only positive balance','Include only positive balance','Only positive balance','D','27848071-41b9-4a4f-ada2-aa536af547c7')
;

-- Aug 23, 2019, 8:28:34 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200281,0,0,'Y',TO_TIMESTAMP('2019-08-23 20:28:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-23 20:28:34','YYYY-MM-DD HH24:MI:SS'),100,'Only positive balance','Include only positive balance',156,80,20,'N',0,'Y','N','PositiveBalance','Y','D',203357,'50f11422-1361-4d50-b6d3-bfe6770e43d3','N')
;

-- Aug 24, 2019, 2:53:06 PM CEST
UPDATE AD_Process_Para SET DefaultValue='Y',Updated=TO_TIMESTAMP('2019-08-24 14:53:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200281
;

SELECT register_migration_script('201908232051_IDEMPIERE-4034.sql') FROM dual
;
