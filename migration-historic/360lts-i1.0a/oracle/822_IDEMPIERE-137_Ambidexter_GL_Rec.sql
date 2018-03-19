-- Remove Old Primary Key Fact_Acct_ID
ALTER TABLE Fact_Reconciliation DROP CONSTRAINT fact_reconciliation_key
;

-- Feb 3, 2012 10:04:01 PM ICT
-- Ambidexter GL Reconciliation
UPDATE AD_Column SET IsKey='N',Updated=TO_DATE('2012-02-03 22:04:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59777
;

-- Feb 3, 2012 10:07:48 PM ICT
-- Ambidexter GL Reconciliation
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200001,0,'Fact_Reconciliation_ID',TO_DATE('2012-02-03 22:07:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Accounting Fact Reconciliation','Accounting Fact Reconciliation',TO_DATE('2012-02-03 22:07:45','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 3, 2012 10:07:48 PM ICT
-- Ambidexter GL Reconciliation
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 3, 2012 10:08:29 PM ICT
-- Ambidexter GL Reconciliation
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200014,200001,0,13,53286,'Fact_Reconciliation_ID',TO_DATE('2012-02-03 22:08:22','YYYY-MM-DD HH24:MI:SS'),100,'D',10,'Y','Y','N','N','N','N','Y','Y','N','N','N','N','N','Accounting Fact Reconciliation',0,TO_DATE('2012-02-03 22:08:22','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 3, 2012 10:08:29 PM ICT
-- Ambidexter GL Reconciliation
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 3, 2012 10:08:33 PM ICT
-- Ambidexter GL Reconciliation
ALTER TABLE Fact_Reconciliation ADD Fact_Reconciliation_ID NUMBER(10) NOT NULL
;

-- Feb 3, 2012 10:08:33 PM ICT
-- Ambidexter GL Reconciliation
ALTER TABLE Fact_Reconciliation ADD CONSTRAINT Fact_Reconciliation_Key PRIMARY KEY (Fact_Reconciliation_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='822_IDEMPIERE-137_Ambidexter_GL_Rec.sql'
WHERE LastMigrationScriptApplied<'822_IDEMPIERE-137_Ambidexter_GL_Rec.sql'
   OR LastMigrationScriptApplied IS NULL
;
