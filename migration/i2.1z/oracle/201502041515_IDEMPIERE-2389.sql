SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 4, 2015 3:19:23 PM IST
-- IDEMPIERE-2389 Add ReportType and AD_PrintFormat_ID in AD_PInstance Table
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202814,0,0,'Y',TO_DATE('2015-02-04 15:19:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-02-04 15:19:22','YYYY-MM-DD HH24:MI:SS'),100,'ReportType','Report Type','Report Type','D','84422b03-ffa2-435b-a485-9ac5de986f0c')
;

-- Feb 4, 2015 3:20:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211830,0,'Report Type',282,'ReportType',NULL,5,'N','N','N','N','N',0,'N',10,NULL,0,0,'Y',TO_DATE('2015-02-04 15:20:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-02-04 15:20:46','YYYY-MM-DD HH24:MI:SS'),100,202814,'Y','N','D','N','N','N','Y','613c626e-e9a4-4efb-a39c-88529c27aea4','Y',0,'N','N')
;

-- Feb 4, 2015 3:20:54 PM IST
ALTER TABLE AD_PInstance ADD ReportType VARCHAR2(5) DEFAULT NULL
;

-- Feb 4, 2015 4:10:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211834,0,'Print Format','Data Print Format','The print format determines how data is rendered for print.',282,'AD_PrintFormat_ID',NULL,22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-02-04 16:10:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-02-04 16:10:36','YYYY-MM-DD HH24:MI:SS'),100,1790,'Y','N','D','N','N','N','Y','d2dbfea7-01e4-4fd5-8d75-cfe123ccf422','Y',0,'N','N')
;

-- Feb 4, 2015 4:10:41 PM IST
UPDATE AD_Column SET IsToolbarButton='N', FKConstraintName='ADPrintFormat_ADPInstance', FKConstraintType='N',Updated=TO_DATE('2015-02-04 16:10:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211834
;

-- Feb 4, 2015 4:10:41 PM IST
ALTER TABLE AD_PInstance ADD AD_PrintFormat_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 4, 2015 4:10:42 PM IST
ALTER TABLE AD_PInstance ADD CONSTRAINT ADPrintFormat_ADPInstance FOREIGN KEY (AD_PrintFormat_ID) REFERENCES ad_printformat(ad_printformat_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201502041515_IDEMPIERE-2389.sql') FROM dual
;
