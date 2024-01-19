-- IDEMPIERE-3989
SELECT register_migration_script('202310161106_IDEMPIERE-3989.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 16, 2023, 11:06:04 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203900,0,0,'Y',TO_TIMESTAMP('2023-10-16 11:06:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-16 11:06:04','YYYY-MM-DD HH24:MI:SS'),100,'IsShowTechnicalInfOnHelp','Show Technical Information on Help','Show Technical Information on Help','D','5a3fdeb9-c731-4a41-b635-98f0e5e81d55')
;

-- Oct 16, 2023, 11:06:36 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216346,0,'Show Technical Information on Help',200174,'IsShowTechnicalInfOnHelp','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-10-16 11:06:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-16 11:06:36','YYYY-MM-DD HH24:MI:SS'),100,203900,'Y','N','D','N','N','N','Y','74d7e55d-13c6-446d-9fa5-6efac88444b4','Y',0,'N','N','N')
;

-- Oct 16, 2023, 11:06:49 AM BRT
ALTER TABLE AD_UserPreference ADD IsShowTechnicalInfOnHelp CHAR(1) DEFAULT 'N' CHECK (IsShowTechnicalInfOnHelp IN ('Y','N')) NOT NULL
;

-- Oct 16, 2023, 11:08:02 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208189,'Show Technical Information on Help',200189,216346,'Y',1,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-16 11:08:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-16 11:08:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f4bbd0c1-7db6-4c60-97db-1440d650c307','Y',160,2,2)
;

