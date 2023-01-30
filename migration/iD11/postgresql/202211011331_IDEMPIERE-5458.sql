-- IDEMPIERE-5458
SELECT register_migration_script('202211011331_IDEMPIERE-5458.sql') FROM dual;

-- Nov 1, 2022, 1:31:23 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215633,0,'Time Zone','Time zone name',228,'TimeZone',60,'N','N','N','N','N',0,'N',200135,0,0,'Y',TO_TIMESTAMP('2022-11-01 13:31:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-01 13:31:22','YYYY-MM-DD HH24:MI:SS'),100,203049,'Y','N','D','N','N','N','Y','cee6683d-23df-4918-be6f-afa14608e010','Y',0,'N','N','N','N')
;

-- Nov 1, 2022, 1:31:26 PM BRT
ALTER TABLE AD_OrgInfo ADD COLUMN TimeZone VARCHAR(60) DEFAULT NULL 
;