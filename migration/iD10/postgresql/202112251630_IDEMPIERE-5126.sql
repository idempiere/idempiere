-- Virtual Column Test
-- Dec 25, 2021, 3:25:02 PM ART
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203552,0,0,'Y',TO_TIMESTAMP('2021-12-25 15:25:01','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-12-25 15:25:01','YYYY-MM-DD HH24:MI:SS'),0,'TestVirtualQty','Virtual Quantity','Used only for testing purposes','Test Virtual Column (Quantity)','D','c1b166c4-e265-47e1-b5f9-d9ce684df5aa')
;

-- Dec 25, 2021, 3:26:11 PM ART
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,ColumnSQL,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214655,0,'Virtual Quantity','Used only for testing purposes',135,'TestVirtualQty',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2021-12-25 15:26:10','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-12-25 15:26:10','YYYY-MM-DD HH24:MI:SS'),0,203552,'N','N','D','N','N','(SELECT 123.45)','N','Y','db8b1287-434e-43a4-91fe-748141eb8ffb','N',0,'N','N','N')
;

-- Dec 25, 2021, 5:14:12 PM ART
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206818,'Virtual Quantity','Used only for testing purposes',152,214655,'Y',0,260,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-12-25 17:14:11','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-12-25 17:14:11','YYYY-MM-DD HH24:MI:SS'),0,'N','Y',123,'D','240ab652-73b9-4dd1-b52f-0faa1d522817','Y',270,1,1,1,'N','N','N','N')
;


SELECT register_migration_script('202112251630_IDEMPIERE-5126.sql') FROM dual
;
