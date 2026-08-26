-- IDEMPIERE-6376
SELECT register_migration_script('202604061420_IDEMPIERE-6376.sql') FROM dual;

-- Apr 6, 2026, 2:20:39 PM UTC
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204061,0,0,'Y',TO_TIMESTAMP('2026-04-06 14:20:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-04-06 14:20:38','YYYY-MM-DD HH24:MI:SS'),100,'IsUseDateMaterialPolicy','Use Date Material Policy','Use transaction or guarantee date to track storage records per date','When enabled, storage records are created per Date Material Policy
(transaction date or guarantee date depending on the product attribute set).
This allows FIFO/LIFO costing and lot traceability at the cost of
generating multiple storage records over time.

When disabled, all storage movements for this product are consolidated
into a single storage record using a fixed reference date (01/01/1900).
Use this option for products where date-based tracking is not required
and having a single on-hand record per locator is preferred.

Only applicable to stocked products.','Use Date Material Policy','D','019d632a-bf00-754d-b29a-d66223d69516')
;

-- Apr 6, 2026, 2:21:07 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217474,0,'Use Date Material Policy','Use transaction or guarantee date to track storage records per date','When enabled, storage records are created per Date Material Policy
(transaction date or guarantee date depending on the product attribute set).
This allows FIFO/LIFO costing and lot traceability at the cost of
generating multiple storage records over time.

When disabled, all storage movements for this product are consolidated
into a single storage record using a fixed reference date (01/01/1900).
Use this option for products where date-based tracking is not required
and having a single on-hand record per locator is preferred.

Only applicable to stocked products.',208,'IsUseDateMaterialPolicy','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-04-06 14:21:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-04-06 14:21:07','YYYY-MM-DD HH24:MI:SS'),100,204061,'Y','N','D','N','N','N','Y','019d632b-2d36-7408-ba8b-5d0b748479f2','Y',0,'N','N','N','N')
;

-- Apr 6, 2026, 2:21:13 PM UTC
ALTER TABLE M_Product ADD COLUMN IsUseDateMaterialPolicy CHAR(1) DEFAULT 'Y' CHECK (IsUseDateMaterialPolicy IN ('Y','N')) NOT NULL
;

-- Apr 6, 2026, 2:21:34 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209080,'Use Date Material Policy','Use transaction or guarantee date to track storage records per date','When enabled, storage records are created per Date Material Policy
(transaction date or guarantee date depending on the product attribute set).
This allows FIFO/LIFO costing and lot traceability at the cost of
generating multiple storage records over time.

When disabled, all storage movements for this product are consolidated
into a single storage record using a fixed reference date (01/01/1900).
Use this option for products where date-based tracking is not required
and having a single on-hand record per locator is preferred.

Only applicable to stocked products.',180,217474,'Y',1,620,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-04-06 14:21:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-04-06 14:21:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d632b-9614-7cab-b2cb-e0ba651728cc','Y',620,2,2)
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@IsStocked@=''Y''', SeqNo=280, XPosition=5,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209080
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200294
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200295
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200296
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200297
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7646
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1319
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1320
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1321
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1322
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3743
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3746
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3747
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206800
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209004
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=430,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3744
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=440,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3745
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=450,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1027
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=460,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1028
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=470,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1568
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=480,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1569
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=490,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5381
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=500,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5383
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=510,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12418
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=520,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5910
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=530,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5911
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=540,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6130
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=550,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8307
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=560,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6343
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=570,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6344
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=580,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58973
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=590,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8608
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=600,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8613
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=610,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52015
;

-- Apr 6, 2026, 2:22:24 PM UTC
UPDATE AD_Field SET SeqNo=620,Updated=TO_TIMESTAMP('2026-04-06 14:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52016
;


-- Apr 9, 2026, 5:20:50 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Cannot change Use Date Material Policy when product has on hand quantity. Please consolidate or clear storage records first.',NULL,0,0,'Y',TO_TIMESTAMP('2026-04-09 17:20:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-04-09 17:20:50','YYYY-MM-DD HH24:MI:SS'),100,201040,'CannotChangeUseDateMaterialPolicy','D','019d73e7-96db-748b-8690-b6c6f680c822')
;
