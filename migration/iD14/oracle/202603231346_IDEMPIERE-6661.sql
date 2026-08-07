-- IDEMPIERE-6661
SELECT register_migration_script('202603231346_IDEMPIERE-6661.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 23, 2026, 1:46:47 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204052,0,0,'Y',TO_TIMESTAMP('2026-03-23 13:46:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-23 13:46:47','YYYY-MM-DD HH24:MI:SS'),10,'WebSessionLogic','Web Session Logic','Web Session Logic','D','019d1abb-cab2-743d-bf8a-370c56a20223')
;

-- Mar 23, 2026, 1:47:18 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217452,0,'Web Session Logic',688,'WebSessionLogic',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-23 13:47:18','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-23 13:47:18','YYYY-MM-DD HH24:MI:SS'),10,204052,'Y','N','D','N','N','N','Y','019d1abc-4127-788b-af23-ee63799334e3','Y',0,'N','N','N','N')
;

-- Mar 23, 2026, 1:47:19 PM CET
ALTER TABLE AD_Scheduler ADD WebSessionLogic VARCHAR2(60 CHAR) DEFAULT NULL 
;

-- Mar 23, 2026, 1:47:38 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209055,'Web Session Logic',589,217452,'Y',60,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-23 13:47:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-23 13:47:37','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019d1abc-8ef4-72ce-b2bf-001f85f23128','Y',170,5)
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206075
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206076
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=203924
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=200501
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209055
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=9432
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=9442
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=9443
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=9438
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=60991
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=60992
;

-- Mar 23, 2026, 1:47:55 PM CET
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-03-23 13:47:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206185
;

-- Mar 23, 2026, 1:48:09 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-03-23 13:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=8584
;

-- Mar 23, 2026, 1:48:10 PM CET
ALTER TABLE AD_Session MODIFY WebSession VARCHAR2(255 CHAR) DEFAULT NULL 
;

