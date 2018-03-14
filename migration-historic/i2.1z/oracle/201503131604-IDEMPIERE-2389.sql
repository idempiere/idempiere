SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Mar 13, 2015 3:58:49 AM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211868,0,'Language ID',282,'AD_Language_ID','@SQL=SELECT NVL(MAX(AD_Language_ID),0)+1 AS DefaultValue FROM AD_Language',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-03-13 03:58:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-03-13 03:58:48','YYYY-MM-DD HH24:MI:SS'),100,2159,'N','N','D','N','N','N','Y','f813543d-ec4b-4673-8bb2-8a7099f9fbb0','N',0,'N','N')
;

-- Mar 13, 2015 3:59:05 AM ICT
ALTER TABLE AD_PInstance ADD AD_Language_ID NUMBER(10) DEFAULT NULL 
;

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Mar 13, 2015 4:59:52 AM ICT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2015-03-13 04:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211868
;


SELECT register_migration_script('201503131604-IDEMPIERE-2389.sql') FROM dual
;
