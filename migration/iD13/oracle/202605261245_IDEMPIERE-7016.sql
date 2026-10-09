-- IDEMPIERE-7016
-- Purpose: Add ExportFormat2Pack parameter to the PackOut process, enabling JSON and YAML as export formats alongside XML
-- Impact: Inserts new AD_Reference, AD_Ref_List (XML/JSON/YAML), AD_Element, and AD_Process_Para records
SELECT register_migration_script('202605261245_IDEMPIERE-7016.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 26, 2026, 12:45:48 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200286,'2Pack Export Format','L',0,0,'Y',TO_TIMESTAMP('2026-05-26 12:45:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 12:45:48','YYYY-MM-DD HH24:MI:SS'),100,'D','N','019e63e4-0691-706f-ad58-697355812515','N')
;

-- May 26, 2026, 12:46:55 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200770,'XML',200286,'X',0,0,'Y',TO_TIMESTAMP('2026-05-26 12:46:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 12:46:54','YYYY-MM-DD HH24:MI:SS'),100,'D','019e63e5-0a14-777c-a0c0-972907b0dab2')
;

-- May 26, 2026, 12:47:10 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200771,'JSON',200286,'J',0,0,'Y',TO_TIMESTAMP('2026-05-26 12:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 12:47:10','YYYY-MM-DD HH24:MI:SS'),100,'D','019e63e5-46eb-7cae-8919-0455a796273e')
;

-- May 26, 2026, 12:47:27 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200772,'YAML',200286,'Y',0,0,'Y',TO_TIMESTAMP('2026-05-26 12:47:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 12:47:27','YYYY-MM-DD HH24:MI:SS'),100,'D','019e63e5-8945-79a6-a2c5-b76316368204')
;

-- May 26, 2026, 3:33:28 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204100,0,0,'Y',TO_TIMESTAMP('2026-05-26 15:33:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 15:33:28','YYYY-MM-DD HH24:MI:SS'),100,'ExportFormat2Pack','Export Format','Export Format','D','019e647d-881a-77d2-9e21-b5661d4a0be3')
;

-- May 26, 2026, 3:34:20 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200521,0,0,'Y',TO_TIMESTAMP('2026-05-26 15:34:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-05-26 15:34:20','YYYY-MM-DD HH24:MI:SS'),100,'Export Format',50004,10,17,200286,'N',1,'Y','X','ExportFormat2Pack','Y','D',204100,'019e647e-5259-70f5-80d4-609084009af0','N','N','D','N')
;

