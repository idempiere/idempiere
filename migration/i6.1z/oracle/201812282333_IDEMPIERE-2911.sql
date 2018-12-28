SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2911
-- Dec 28, 2018, 10:15:03 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213823,0,'Parent Column','The link column on the parent tab.',288,100,'Parent_Column_ID',22,'N','N','N','N','N',0,'N',18,251,0,0,'Y',TO_DATE('2018-12-28 22:15:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-12-28 22:15:03','YYYY-MM-DD HH24:MI:SS'),100,53874,'Y','N','D','N','N','N','Y','6ba6d93a-99c2-4b97-b8eb-df3739282a99','Y',0,'N','N','N','N')
;

-- Dec 28, 2018, 10:15:05 PM CET
UPDATE AD_Column SET FKConstraintName='ParentColumn_ADTree', FKConstraintType='N',Updated=TO_DATE('2018-12-28 22:15:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213823
;

-- Dec 28, 2018, 10:15:05 PM CET
ALTER TABLE AD_Tree ADD Parent_Column_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 28, 2018, 10:15:05 PM CET
ALTER TABLE AD_Tree ADD CONSTRAINT ParentColumn_ADTree FOREIGN KEY (Parent_Column_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 28, 2018, 10:16:02 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205899,'Parent Column','The link column on the parent tab.',243,213823,'Y',22,140,'N','N','N','N',0,0,'Y',TO_DATE('2018-12-28 22:16:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-12-28 22:16:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','37ab9f61-295a-4c3a-9fc0-e88e99e50e61','Y',130,2)
;

-- Dec 28, 2018, 10:16:56 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-28 22:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205899
;

-- Dec 28, 2018, 10:16:56 PM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-28 22:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5228
;

-- Dec 28, 2018, 10:16:56 PM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-28 22:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12421
;

-- Dec 28, 2018, 10:16:56 PM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-28 22:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204379
;

-- Dec 28, 2018, 10:16:56 PM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-28 22:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8371
;

-- Dec 28, 2018, 10:17:22 PM CET
UPDATE AD_Field SET DisplayLogic='@TreeType@=''TL''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-12-28 22:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205899
;

SELECT register_migration_script('201812282333_IDEMPIERE-2911.sql') FROM dual
;

