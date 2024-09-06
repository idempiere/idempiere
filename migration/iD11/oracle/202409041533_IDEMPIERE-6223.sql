-- Adding new fields to  AD_PInstance and AD_PInstance_Log
SELECT register_migration_script('202409041533_IDEMPIERE-6223.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 4, 2024, 3:33:12 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216788,0,'JSON Data','The json field stores json data.',282,'JsonData',0,'N','N','N','N','N',0,'N',200267,0,0,'Y',TO_TIMESTAMP('2024-09-04 15:33:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-04 15:33:12','YYYY-MM-DD HH24:MI:SS'),100,203924,'Y','N','D','N','N','N','Y','6ec3e423-205d-482f-b7e2-3dea6b66d5d0','Y',0,'N','N','N','N','N')
;

-- Sep 4, 2024, 3:33:16 PM BRT
ALTER TABLE AD_PInstance ADD JsonData CLOB DEFAULT NULL  CONSTRAINT AD_PInstance_JsonData_isjson CHECK (JsonData IS JSON)
;

-- Sep 4, 2024, 3:33:39 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208511,'JSON Data','The json field stores json data.',663,216788,'Y',0,210,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-09-04 15:33:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-04 15:33:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2455e488-36a8-48d2-8410-2ff0808915e4','Y',200,2,5)
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=1, ColumnSpan=5,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208511
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10501
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207416
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10495
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202845
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202847
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207405
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207407
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207406
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207408
;

-- Sep 4, 2024, 3:34:12 PM BRT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2024-09-04 15:34:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207720
;

-- Sep 4, 2024, 3:34:40 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216789,0,'JSON Data','The json field stores json data.',578,'JsonData',0,'N','N','N','N','N',0,'N',200267,0,0,'Y',TO_TIMESTAMP('2024-09-04 15:34:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-04 15:34:40','YYYY-MM-DD HH24:MI:SS'),100,203924,'Y','N','D','N','N','N','Y','7539f67f-922d-4e27-881f-c04f0dc8c160','Y',0,'N','N','N','N','N')
;

-- Sep 4, 2024, 3:34:43 PM BRT
ALTER TABLE AD_PInstance_Log ADD JsonData CLOB DEFAULT NULL  CONSTRAINT AD_PInstance_Log_JsonData_isjson CHECK (JsonData IS JSON)
;

-- Sep 4, 2024, 3:35:54 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208512,'JSON Data','The json field stores json data.',665,216789,'Y',0,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-09-04 15:35:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-04 15:35:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','27e958ae-9e31-4e8b-824e-e571df7da15c','Y',100,2,5)
;

-- Sep 4, 2024, 3:36:15 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1, ColumnSpan=5,Updated=TO_TIMESTAMP('2024-09-04 15:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208512
;

-- Sep 4, 2024, 3:36:15 PM BRT
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2024-09-04 15:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200309
;

-- Sep 4, 2024, 3:36:15 PM BRT
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2024-09-04 15:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200310
;

-- Sep 4, 2024, 3:36:15 PM BRT
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2024-09-04 15:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207622
;

-- Sep 4, 2024, 3:36:15 PM BRT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-09-04 15:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204554
;

