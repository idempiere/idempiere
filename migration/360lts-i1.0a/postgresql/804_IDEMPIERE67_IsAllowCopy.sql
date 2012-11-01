-- Sep 9, 2011 10:58:03 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,55297,0,'IsAllowCopy',TO_TIMESTAMP('2011-09-09 10:58:02','YYYY-MM-DD HH24:MI:SS'),100,'Determine if a column must be copied when pushing the button to copy record','D','Y','Allow Copy','Allow Copy',TO_TIMESTAMP('2011-09-09 10:58:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 9, 2011 10:58:04 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=55297 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 9, 2011 10:58:35 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
UPDATE AD_Element_Trl SET IsTranslated='Y',Name='Permitir copia',PrintName='Permitir copia',Description='Determina si una columna debe ser copiada cuando se selecciona copiar registro',Updated=TO_TIMESTAMP('2011-09-09 10:58:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=55297 AND AD_Language LIKE 'es_%'
;

-- Sep 9, 2011 10:59:43 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,IsActive,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,62199,55297,0,20,101,'IsAllowCopy',TO_TIMESTAMP('2011-09-09 10:59:42','YYYY-MM-DD HH24:MI:SS'),100,'Y','Determine if a column must be copied when pushing the button to copy record','D',1,'Y','Y','N','N','N','N','N','Y','N','N','N','N','Y','Allow Copy',0,TO_TIMESTAMP('2011-09-09 10:59:42','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 9, 2011 10:59:43 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=62199 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 9, 2011 11:00:47 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
UPDATE AD_Field SET IsSameLine='N', SeqNo=390,Updated=TO_TIMESTAMP('2011-09-09 11:00:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5122
;

-- Sep 9, 2011 11:01:22 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,62199,62467,0,101,TO_TIMESTAMP('2011-09-09 11:01:22','YYYY-MM-DD HH24:MI:SS'),100,'Determine if a column must be copied when pushing the button to copy record',10,'D','Y','Y','Y','N','N','N','N','Y','Allow Copy',380,0,TO_TIMESTAMP('2011-09-09 11:01:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 9, 2011 11:01:22 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=62467 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 9, 2011 11:01:35 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
UPDATE AD_Field SET DisplayLength=10,Updated=TO_TIMESTAMP('2011-09-09 11:01:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56317
;

-- Sep 9, 2011 11:19:47 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
ALTER TABLE AD_Column ADD COLUMN IsAllowCopy CHAR(1) DEFAULT 'Y' CHECK (IsAllowCopy IN ('Y','N')) NOT NULL
;

-- Sep 11, 2011 11:49:44 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,IsActive,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,62200,55297,0,17,319,107,'IsAllowCopy',TO_TIMESTAMP('2011-09-11 11:49:42','YYYY-MM-DD HH24:MI:SS'),100,'Determine if a column must be copied when pushing the button to copy record','D',1,'Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Allow Copy',0,TO_TIMESTAMP('2011-09-11 11:49:42','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 11, 2011 11:49:44 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=62200 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 11, 2011 11:52:39 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
ALTER TABLE AD_Field ADD COLUMN IsAllowCopy CHAR(1) DEFAULT NULL 
;

-- Sep 11, 2011 11:51:12 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2011-09-11 11:51:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Sep 11, 2011 11:51:25 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,62200,62468,0,107,TO_TIMESTAMP('2011-09-11 11:51:24','YYYY-MM-DD HH24:MI:SS'),100,'Determine if a column must be copied when pushing the button to copy record',0,'D','Y','Y','Y','N','N','N','N','Y','Allow Copy',280,0,TO_TIMESTAMP('2011-09-11 11:51:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 11, 2011 11:56:01 AM COT
-- IDEMPIERE-67 ProcessedOn should not be copied by MOrder.copyFrom
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=62468 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Backward compatibility with old PO copyValues method
UPDATE AD_Column SET IsAllowCopy='N' WHERE ColumnName IN (
'Created',
'Created',
'CreatedBy',
'Updated',
'UpdatedBy',
'IsActive',
'AD_Client_ID',
'AD_Org_ID',
'Processing'
);

-- additional from GridTable (on AD_Field for better backward compatibility)
UPDATE AD_Field SET IsAllowCopy='N' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE ColumnName IN (
'EntityType',
'DocumentNo',
'Processed',
'IsSelfService',
'DocAction',
'DocStatus',
'Posted',
'IsReconciled',
'IsApproved',
'IsGenerated',
'GrandTotal',
'TotalLines',
'C_CashLine_ID',
'C_Payment_ID',
'IsPaid',
'IsAllocated',
'Line'
));

-- Ref_ from GridTable
UPDATE AD_Field SET IsAllowCopy='N' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE ColumnName LIKE 'Ref_%');

-- C_DocType_ID if there is DocTypeTarget from GridTable
UPDATE AD_Field SET IsAllowCopy='N' WHERE AD_Column_ID IN
  (SELECT AD_Column_ID FROM AD_Column cdt 
      WHERE cdt.ColumnName = 'C_DocType_ID' AND EXISTS
         (SELECT 1 FROM AD_Column cdtt
             WHERE cdtt.AD_Table_ID=cdt.AD_Table_ID AND cdtt.ColumnName='C_DocTypeTarget_ID'));

-- new columns found to be problematic
UPDATE AD_Column SET IsAllowCopy='N' WHERE ColumnName IN (
'ProcessedOn'
);

-- new fields found to be problematic
UPDATE AD_Field SET IsAllowCopy='N' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE ColumnName IN (
'QtyDelivered',
'QtyInvoiced',
'QtyReserved'
));

-- key columns
UPDATE AD_Column SET IsAllowCopy='N' WHERE IsKey='Y';

-- virtual columns
UPDATE AD_Column SET IsAllowCopy='N' WHERE ColumnSQL IS NOT NULL;

-- UUID columns
UPDATE AD_Column SET IsAllowCopy='N' WHERE columnname = (SELECT tablename||'_UU' FROM ad_table t where t.ad_table_id=ad_column.ad_table_id);

DROP VIEW ad_field_v;

CREATE OR REPLACE VIEW ad_field_v AS 
 SELECT t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, 
 f.name, f.description, f.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, 
 f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, 
 f.obscuretype, c.columnname, c.columnsql, c.fieldlength, c.vformat, 
 COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, 
 COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, 
 COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, 
 COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, 
 COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, 
 c.isalwaysupdateable, c.readonlylogic, c.mandatorylogic, c.isupdateable, 
 c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, 
 fg.name AS fieldgroup, vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, 
 COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete,
 COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   JOIN ad_reference r ON c.ad_reference_id = r.ad_reference_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y'::bpchar AND c.isactive = 'Y'::bpchar;

DROP VIEW ad_field_vt;

CREATE OR REPLACE VIEW ad_field_vt AS 
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, trl.name, trl.description, 
 trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, f.isfieldonly, f.isreadonly, 
 f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, c.fieldlength, c.vformat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, 
 c.iskey, c.isparent, COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, 
 COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, 
 COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, c.isalwaysupdateable, c.readonlylogic, c.mandatorylogic, c.isupdateable, 
 c.isencrypted AS isencryptedcolumn, c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, 
 f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete,
 COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language::text = fgt.ad_language::text
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   JOIN ad_reference r ON c.ad_reference_id = r.ad_reference_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y'::bpchar AND c.isactive = 'Y'::bpchar;

