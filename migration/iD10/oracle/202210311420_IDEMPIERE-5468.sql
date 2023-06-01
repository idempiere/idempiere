-- IDEMPIERE-5468
SELECT register_migration_script('202210311420_IDEMPIERE-5468.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 31, 2022, 2:20:52 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203724,0,0,'Y',TO_TIMESTAMP('2022-10-31 14:20:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-31 14:20:51','YYYY-MM-DD HH24:MI:SS'),100,'IsNotClause','Not Clause','Indicates if a chosen multiple component value must be negate','Not Clause','D','d50d4b2c-6ba8-4165-859e-9e307d6b1421')
;

-- Oct 31, 2022, 2:22:00 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215631,0,'Not Clause','Indicates if a chosen multiple component value must be negate',283,'IsNotClause','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-10-31 14:22:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-31 14:22:00','YYYY-MM-DD HH24:MI:SS'),100,203724,'Y','N','D','N','N','N','Y','cf018b7d-a0bd-4500-b9fc-ec57ef490418','Y',0,'N','N','N','N')
;

-- Oct 31, 2022, 2:22:06 PM BRT
ALTER TABLE AD_PInstance_Para ADD IsNotClause CHAR(1) DEFAULT 'N' CHECK (IsNotClause IN ('Y','N')) NOT NULL
;

-- Oct 31, 2022, 2:23:59 PM BRT
ALTER TABLE AD_PInstance_Para MODIFY IsNotClause CHAR(1) DEFAULT 'N'
;

-- Oct 31, 2022, 2:28:32 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207410,'Not Clause','Indicates if a chosen multiple component value must be negate',664,215631,'Y',1,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-31 14:28:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-31 14:28:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8fa2857f-38a3-4f31-bff6-d6baa56ea352','Y',140,2,2)
;

