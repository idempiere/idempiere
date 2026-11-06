-- IDEMPIERE-7102 FIFO/LIFO costing: use account date as cost layer when there is no attribute set instance
SELECT register_migration_script('202610201200_IDEMPIERE-7102.sql') FROM dual;

-- Oct 20, 2026, 12:00:00 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217669,0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',817,'DateAcct',7,'N','N','Y','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2026-10-20 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-20 12:00:00','YYYY-MM-DD HH24:MI:SS'),100,263,'N','N','D','N','N','N','Y','320c0842-a2a8-40fe-b136-6b6d938203ed','Y',0,'N','N','N','N')
;

-- Oct 20, 2026, 12:00:00 PM BRT
ALTER TABLE M_CostQueue ADD COLUMN DateAcct TIMESTAMP DEFAULT NULL 
;

UPDATE M_CostQueue SET DateAcct=TRUNC(Created) WHERE DateAcct IS NULL
;

-- Oct 20, 2026, 12:00:00 PM BRT
INSERT INTO t_alter_column values('m_costqueue','DateAcct',null,'NOT NULL',null)
;

