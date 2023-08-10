-- IDEMPIERE-5827
SELECT register_migration_script('202308101331_IDEMPIERE-5827.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 10, 2023, 1:31:49 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200642,'Form',200084,'X',0,0,'Y',TO_TIMESTAMP('2023-08-10 13:31:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-08-10 13:31:48','YYYY-MM-DD HH24:MI:SS'),10,'D','0b1e6c9b-2cc6-4a53-bb47-42dee6f1105d')
;

-- Aug 10, 2023, 1:31:52 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200643,'Info',200084,'I',0,0,'Y',TO_TIMESTAMP('2023-08-10 13:31:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-08-10 13:31:51','YYYY-MM-DD HH24:MI:SS'),10,'D','4e05c125-8a96-4a0c-8e7a-57781c141f3a')
;

-- Aug 10, 2023, 1:32:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215907,1,'Special Form','Special Form','The Special Form field identifies a unique Special Form in the system.',195,'AD_Form_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2023-08-10 13:32:30','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-08-10 13:32:30','YYYY-MM-DD HH24:MI:SS'),10,1298,'Y','N','D','N','N','N','N','c90974fc-f238-45ff-a133-6a58b08c0bd2','N','N','N','N','N')
;

-- Aug 10, 2023, 1:32:32 PM CEST
UPDATE AD_Column SET FKConstraintName='ADForm_ADPreference', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-08-10 13:32:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=215907
;

-- Aug 10, 2023, 1:32:32 PM CEST
ALTER TABLE AD_Preference ADD AD_Form_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 10, 2023, 1:32:32 PM CEST
ALTER TABLE AD_Preference ADD CONSTRAINT ADForm_ADPreference FOREIGN KEY (AD_Form_ID) REFERENCES ad_form(ad_form_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 10, 2023, 1:32:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207714,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',156,211766,'Y',10,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-08-10 13:32:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-08-10 13:32:45','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','621b4e27-5931-45c2-9b1a-8adef6bedb46','Y',110,2)
;

-- Aug 10, 2023, 1:32:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207715,'Special Form','Special Form','The Special Form field identifies a unique Special Form in the system.',156,215907,'Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-08-10 13:32:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-08-10 13:32:45','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','422d46ed-8239-46cf-91f7-2394ea86c8e7','Y',120,2)
;

-- Aug 10, 2023, 1:37:05 PM CEST
UPDATE AD_Column SET IsAllowLogging='Y', IsAllowCopy='Y',Updated=TO_TIMESTAMP('2023-08-10 13:37:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=215907
;

