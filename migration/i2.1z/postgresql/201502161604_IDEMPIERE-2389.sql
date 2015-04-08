-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator

-- Feb 16, 2015 9:52:26 AM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211837,0,'Summary Level','This is a summary entity','A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.',282,'IsSummary',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2015-02-16 09:52:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-16 09:52:25','YYYY-MM-DD HH24:MI:SS'),100,416,'Y','N','D','N','N','N','N','d7123c51-3508-4264-be07-7d6c48216795','Y',0,'N','N')
;

-- Feb 16, 2015 9:52:42 AM ICT
ALTER TABLE AD_PInstance ADD COLUMN IsSummary CHAR(1) DEFAULT NULL CHECK (IsSummary IN ('Y','N'))
;
SELECT register_migration_script('201502161604_IDEMPIERE-2389.sql') FROM dual
;
