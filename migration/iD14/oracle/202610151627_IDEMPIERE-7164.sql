-- IDEMPIERE-7164
SELECT register_migration_script('202610151627_IDEMPIERE-7164.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 15, 2026, 4:27:26 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217667,0,'Show Negate Button','Show Negate Button for Chosen Multiple editors',897,'IsShowNegateButton','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-10-15 16:27:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-15 16:27:26','YYYY-MM-DD HH24:MI:SS'),100,203791,'Y','N','D','N','N','N','Y','01a13ff5-f66a-797a-af2b-d3b5722dbf23','Y',0,'N','N','N','N','N')
;

-- Oct 15, 2026, 4:27:33 PM CEST
ALTER TABLE AD_InfoColumn ADD IsShowNegateButton CHAR(1) DEFAULT 'N' CHECK (IsShowNegateButton IN ('Y','N')) NOT NULL
;

-- Oct 15, 2026, 4:29:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209252,'Show Negate Button','Show Negate Button for Chosen Multiple editors',844,217667,'Y',1,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-10-15 16:29:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-15 16:29:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a13ff7-f04c-7518-b04e-4c0799b518f9','Y',230,2,2)
;

-- Oct 15, 2026, 4:30:56 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=320, XPosition=2,Updated=TO_TIMESTAMP('2026-10-15 16:30:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209252
;

-- Oct 15, 2026, 4:30:56 PM CEST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2026-10-15 16:30:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Oct 15, 2026, 4:30:56 PM CEST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2026-10-15 16:30:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- Oct 15, 2026, 4:30:56 PM CEST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2026-10-15 16:30:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206178
;

-- Oct 15, 2026, 4:30:56 PM CEST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2026-10-15 16:30:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206409
;

-- Oct 15, 2026, 4:31:26 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@ = 200161 | @AD_Reference_ID@ = 200163 | @AD_Reference_ID@ = 200162', SeqNo=320,Updated=TO_TIMESTAMP('2026-10-15 16:31:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209252
;

