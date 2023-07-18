-- IDEMPIERE-5767 Help/Tooltip on the Activities panel records
SELECT register_migration_script('202307172216_IDEMPIERE-5767.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 17, 2023, 10:16:36 PM PDT
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2023-07-17 22:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212994
;

-- Jul 17, 2023, 10:18:49 PM PDT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215888,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200217,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-07-17 22:18:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-07-17 22:18:49','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','N','N','Y','355c2883-8023-4d60-a129-07fc5f0bfdf8','Y',10,'N','N','N')
;

-- Jul 17, 2023, 10:18:55 PM PDT
ALTER TABLE PA_DocumentStatus_Trl ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jul 17, 2023, 10:19:10 PM PDT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207700,'Description','Optional short description of the record','A description is limited to 255 characters.',200223,215888,'Y',255,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-17 22:19:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-07-17 22:19:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5c944edb-31dd-4daa-89bb-a94c4f37c329','Y',90,5)
;

-- Jul 17, 2023, 10:19:20 PM PDT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1,Updated=TO_TIMESTAMP('2023-07-17 22:19:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207700
;

UPDATE pa_documentstatus_trl
SET description=(SELECT description FROM pa_documentstatus ds WHERE ds.pa_documentstatus_id=pa_documentstatus_trl.pa_documentstatus_id)
WHERE description IS NULL
;
