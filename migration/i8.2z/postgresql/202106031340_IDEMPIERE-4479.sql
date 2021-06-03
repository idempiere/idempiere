-- IDEMPIERE-4479
-- Jun 3, 2021, 1:36:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214499,0,'Column SQL','Virtual Column (r/o)','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days',107,'ColumnSQL',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-06-03 13:36:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-03 13:36:38','YYYY-MM-DD HH24:MI:SS'),100,2699,'Y','N','D','N','N','N','Y','5726e9db-774b-4257-956e-ae067fb23f33','Y',0,'N','N','N')
;

-- Jun 3, 2021, 1:36:42 PM CEST
ALTER TABLE AD_Field ADD COLUMN ColumnSQL VARCHAR(255) DEFAULT NULL 
;

-- Jun 3, 2021, 1:37:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206665,'Column SQL','Virtual Column (r/o)','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days',107,214499,'Y',255,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-06-03 13:37:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-03 13:37:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f2dc4a54-a4c2-4be4-83b4-0134783c12cd','Y',490,5)
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=924
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=133
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206665
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Jun 3, 2021, 1:40:24 PM CEST
UPDATE AD_Field SET SeqNo=500, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

-- Jun 3, 2021, 3:42:52 PM CEST
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2021-06-03 15:42:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214499
;

-- Jun 3, 2021, 3:42:57 PM CEST
INSERT INTO t_alter_column values('ad_field','ColumnSQL','VARCHAR(4000)',null,'NULL')
;

CREATE OR REPLACE VIEW ad_field_v 
AS
SELECT t.ad_window_id,
       f.ad_tab_id,
       f.ad_field_id,
       tbl.ad_table_id,
       f.ad_column_id,
       f.name,
       f.description,
       f.help,
       f.isdisplayed,
       f.displaylogic,
       f.displaylength,
       f.seqno,
       f.sortno,
       f.issameline,
       f.isheading,
       f.isfieldonly,
       f.isreadonly,
       f.isencrypted AS isencryptedfield,
       f.obscuretype,
       c.columnname,
       COALESCE(f.columnsql,c.columnsql) AS columnsql,
       c.fieldlength,
       COALESCE(f.VFormat,c.VFormat) AS VFormat,
       COALESCE(f.defaultvalue,c.defaultvalue) AS defaultvalue,
       c.iskey,
       c.isparent,
       COALESCE(f.ismandatory,c.ismandatory) AS ismandatory,
       c.isidentifier,
       c.istranslated,
       COALESCE(f.ad_reference_value_id,c.ad_reference_value_id) AS ad_reference_value_id,
       c.callout,
       COALESCE(f.ad_reference_id,c.ad_reference_id) AS ad_reference_id,
       COALESCE(f.ad_val_rule_id,c.ad_val_rule_id) AS ad_val_rule_id,
       c.ad_process_id,
       COALESCE(f.isalwaysupdateable,c.isalwaysupdateable) AS isalwaysupdateable,
       COALESCE(f.readonlylogic,c.readonlylogic) AS readonlylogic,
       COALESCE(f.mandatorylogic,c.mandatorylogic) AS mandatorylogic,
       COALESCE(f.isupdateable,c.isupdateable) AS isupdateable,
       c.isencrypted AS isencryptedcolumn,
       COALESCE(f.isselectioncolumn,c.isselectioncolumn) AS isselectioncolumn,
       tbl.tablename,
       c.valuemin,
       c.valuemax,
       fg.name AS fieldgroup,
       vr.code AS validationcode,
       f.included_tab_id,
       fg.fieldgrouptype,
       fg.iscollapsedbydefault,
       COALESCE(f.infofactoryclass,c.infofactoryclass) AS infofactoryclass,
       c.isautocomplete,
       COALESCE(f.isallowcopy,c.isallowcopy) AS isallowcopy,
       f.isdisplayedgrid,
       f.seqnogrid,
       c.seqnoselection,
       f.xposition,
       f.columnspan,
       f.numlines,
       COALESCE(f.istoolbarbutton,c.istoolbarbutton) AS istoolbarbutton,
       c.formatpattern,
       f.isadvancedfield,
       f.isdefaultfocus,
       c.ad_chart_id,
       f.ad_labelstyle_id,
       f.ad_fieldstyle_id,
       c.pa_dashboardcontent_id,
       COALESCE(f.placeholder,c.placeholder) AS placeholder,
       c.ishtml,
       f.isquickform,
       COALESCE(f.ad_val_rule_Lookup_id,c.ad_val_rule_Lookup_id) AS ad_val_rule_Lookup_id,
       vrf.code AS validationcodeLookup
FROM ad_field f
  JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
  LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
  LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
  JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
  LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE (f.ad_val_rule_id,c.ad_val_rule_id)
  LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE (f.ad_val_rule_Lookup_id,c.ad_val_rule_Lookup_id)
WHERE f.isactive = 'Y'
AND   c.isactive = 'Y';


CREATE OR REPLACE VIEW ad_field_vt 
AS
SELECT trl.ad_language, t.ad_window_id,
       f.ad_tab_id,f.ad_field_id,
       tbl.ad_table_id,
       f.ad_column_id,
       trl.name,
       trl.description,
       trl.help,
       f.isdisplayed,
       f.displaylogic,
       f.displaylength,
       f.seqno,
       f.sortno,
       f.issameline,
       f.isheading,
       f.isfieldonly,
       f.isreadonly,
       f.isencrypted AS isencryptedfield,
       f.obscuretype,
       c.columnname,
       COALESCE(f.columnsql,c.columnsql) AS columnsql,
       c.fieldlength,
       COALESCE(f.VFormat,c.VFormat) AS VFormat,
       COALESCE(f.defaultvalue,c.defaultvalue) AS defaultvalue,
       c.iskey,
       c.isparent,
       COALESCE(f.ismandatory,c.ismandatory) AS ismandatory,
       c.isidentifier,
       c.istranslated,
       COALESCE(f.ad_reference_value_id,c.ad_reference_value_id) AS ad_reference_value_id,
       c.callout,
       COALESCE(f.ad_reference_id,c.ad_reference_id) AS ad_reference_id,
       COALESCE(f.ad_val_rule_id,c.ad_val_rule_id) AS ad_val_rule_id,
       c.ad_process_id,
       COALESCE(f.isalwaysupdateable,c.isalwaysupdateable) AS isalwaysupdateable,
       COALESCE(f.readonlylogic,c.readonlylogic) AS readonlylogic,
       COALESCE(f.mandatorylogic,c.mandatorylogic) AS mandatorylogic,
       COALESCE(f.isupdateable,c.isupdateable) AS isupdateable,
       c.isencrypted AS isencryptedcolumn,
       COALESCE(f.isselectioncolumn,c.isselectioncolumn) AS isselectioncolumn,
       tbl.tablename,
       c.valuemin,
       c.valuemax,
       fgt.name AS fieldgroup,
       vr.code AS validationcode,
       f.included_tab_id,
       fg.fieldgrouptype,
       fg.iscollapsedbydefault,
       COALESCE(f.infofactoryclass,c.infofactoryclass) AS infofactoryclass,
       c.isautocomplete,
       COALESCE(f.isallowcopy,c.isallowcopy) AS isallowcopy,
       f.isdisplayedgrid,
       f.seqnogrid,
       c.seqnoselection,
       f.xposition,
       f.columnspan,
       f.numlines,
       COALESCE(f.istoolbarbutton,c.istoolbarbutton) AS istoolbarbutton,
       c.formatpattern,
       f.isadvancedfield,
       f.isdefaultfocus,
       c.ad_chart_id,
       f.ad_labelstyle_id,
       f.ad_fieldstyle_id,
       c.pa_dashboardcontent_id,
       COALESCE(trl.placeholder,ct.placeholder) AS placeholder,
       c.ishtml,
       f.isquickform,
       COALESCE(f.ad_val_rule_Lookup_id,c.ad_val_rule_Lookup_id) AS ad_val_rule_Lookup_id,
       vrf.code AS validationcodeLookup
FROM ad_field f
  JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
  JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
  LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
  LEFT JOIN ad_fieldgroup_trl fgt
         ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id
        AND trl.ad_language::TEXT = fgt.ad_language::TEXT
  LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
  LEFT JOIN ad_column_trl ct
         ON f.ad_column_id = ct.ad_column_id
        AND trl.ad_language::TEXT = ct.ad_language::TEXT
  JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
  LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE (f.ad_val_rule_id,c.ad_val_rule_id)
  LEFT JOIN ad_val_rule vrf ON vrf.ad_val_rule_id = COALESCE (f.ad_val_rule_Lookup_id,c.ad_val_rule_Lookup_id)
WHERE f.isactive = 'Y'
AND   c.isactive = 'Y';


SELECT Register_Migration_Script ('202106031340_IDEMPIERE-4479.sql') FROM DUAL
;
