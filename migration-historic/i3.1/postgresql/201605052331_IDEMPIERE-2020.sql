-- IDEMPIERE-2020 Value Format for ZK
-- Feb 25, 2015 5:45:01 PM COT
UPDATE AD_Column SET ReadOnlyLogic=NULL,Updated=TO_TIMESTAMP('2015-02-25 17:45:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1179
;

-- Feb 25, 2015 5:54:41 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211839,0,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"',107,'VFormat',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2015-02-25 17:54:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-25 17:54:41','YYYY-MM-DD HH24:MI:SS'),100,616,'Y','N','D','N','N','N','Y','a585debb-2c2f-4a8f-89c9-28281fd44b62','Y',0,'N','N')
;

-- Feb 25, 2015 5:55:50 PM COT
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2015-02-25 17:55:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1179
;

-- Feb 25, 2015 5:55:52 PM COT
INSERT INTO t_alter_column values('ad_column','VFormat','VARCHAR(255)',null,'NULL')
;

-- Feb 25, 2015 5:56:14 PM COT
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2015-02-25 17:56:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3740
;

-- Feb 25, 2015 5:56:15 PM COT
INSERT INTO t_alter_column values('ad_process_para','VFormat','VARCHAR(255)',null,'NULL')
;

-- Feb 25, 2015 5:57:01 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211840,0,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"',464,'VFormat',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2015-02-25 17:57:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-25 17:57:00','YYYY-MM-DD HH24:MI:SS'),100,616,'Y','N','U','N','N','N','Y','35514060-1c96-435d-b3bf-101ed064d4f6','Y',0,'N','N')
;

-- Feb 25, 2015 5:57:03 PM COT
ALTER TABLE AD_UserDef_Field ADD COLUMN VFormat VARCHAR(255) DEFAULT NULL 
;

-- Feb 25, 2015 5:57:30 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203499,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"',395,211840,'Y',255,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-02-25 17:57:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-25 17:57:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','f8a92fba-ee26-4ccc-95ed-62dcfd3d7207','Y',290,5)
;

-- Feb 25, 2015 6:00:15 PM COT
ALTER TABLE AD_Field ADD COLUMN VFormat VARCHAR(255) DEFAULT NULL 
;

-- Feb 25, 2015 6:04:12 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, XPosition=1,Updated=TO_TIMESTAMP('2015-02-25 18:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203499
;

-- Feb 25, 2015 6:04:12 PM COT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2015-02-25 18:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- Feb 25, 2015 6:04:12 PM COT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2015-02-25 18:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

-- Feb 25, 2015 6:04:41 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203500,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"',107,211839,'Y',255,410,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-02-25 18:04:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-25 18:04:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8eb1b299-24e3-4c1b-bbc6-5c3b92e1adf8','Y',400,5)
;

-- Feb 25, 2015 6:05:15 PM COT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2015-02-25 18:05:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=400, XPosition=1,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

CREATE OR REPLACE VIEW ad_field_v AS 
 SELECT t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, f.name, f.description, 
 f.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, f.issameline, f.isheading, 
 f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype, c.columnname, c.columnsql, 
 c.fieldlength, COALESCE(f.vformat, c.vformat) AS vformat, COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, 
 COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, 
 COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, 
 COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, 
 COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, 
 COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable, 
 COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, 
 COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, 
 COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.isencrypted AS isencryptedcolumn, 
 c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fg.name AS fieldgroup, 
 vr.code AS validationcode, f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, 
 COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, 
 COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid, f.seqnogrid, c.seqnoselection, 
 f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, 
 c.formatpattern, f.isadvancedfield, f.IsDefaultFocus, c.AD_Chart_ID
   FROM ad_field f
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y'::bpchar AND c.isactive = 'Y'::bpchar
;

CREATE OR REPLACE VIEW ad_field_vt AS 
 SELECT trl.ad_language, t.ad_window_id, f.ad_tab_id, f.ad_field_id, tbl.ad_table_id, f.ad_column_id, 
 trl.name, trl.description, trl.help, f.isdisplayed, f.displaylogic, f.displaylength, f.seqno, f.sortno, 
 f.issameline, f.isheading, f.isfieldonly, f.isreadonly, f.isencrypted AS isencryptedfield, f.obscuretype,
c.columnname, c.columnsql, c.fieldlength, COALESCE(f.vformat, c.vformat) AS vformat, 
COALESCE(f.defaultvalue, c.defaultvalue) AS defaultvalue, c.iskey, c.isparent, 
COALESCE(f.ismandatory, c.ismandatory) AS ismandatory, c.isidentifier, c.istranslated, 
COALESCE(f.ad_reference_value_id, c.ad_reference_value_id) AS ad_reference_value_id, c.callout, 
COALESCE(f.ad_reference_id, c.ad_reference_id) AS ad_reference_id, 
COALESCE(f.ad_val_rule_id, c.ad_val_rule_id) AS ad_val_rule_id, c.ad_process_id, 
COALESCE(f.isalwaysupdateable, c.isalwaysupdateable) AS isalwaysupdateable, 
COALESCE(f.readonlylogic, c.readonlylogic) AS readonlylogic, 
COALESCE(f.mandatorylogic, c.mandatorylogic) AS mandatorylogic, 
COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.isencrypted AS isencryptedcolumn, 
c.isselectioncolumn, tbl.tablename, c.valuemin, c.valuemax, fgt.name AS fieldgroup, vr.code AS validationcode, 
f.included_tab_id, fg.fieldgrouptype, fg.iscollapsedbydefault, 
COALESCE(f.infofactoryclass, c.infofactoryclass) AS infofactoryclass, c.isautocomplete, 
COALESCE(f.isallowcopy, c.isallowcopy) AS isallowcopy, f.isdisplayedgrid, f.seqnogrid, c.seqnoselection, 
f.xposition, f.columnspan, f.numlines, COALESCE(f.istoolbarbutton, c.istoolbarbutton) AS istoolbarbutton, 
c.formatpattern, f.isadvancedfield, f.IsDefaultFocus, c.AD_Chart_ID
   FROM ad_field f
   JOIN ad_field_trl trl ON f.ad_field_id = trl.ad_field_id
   JOIN ad_tab t ON f.ad_tab_id = t.ad_tab_id
   LEFT JOIN ad_fieldgroup fg ON f.ad_fieldgroup_id = fg.ad_fieldgroup_id
   LEFT JOIN ad_fieldgroup_trl fgt ON f.ad_fieldgroup_id = fgt.ad_fieldgroup_id AND trl.ad_language::text = fgt.ad_language::text
   LEFT JOIN ad_column c ON f.ad_column_id = c.ad_column_id
   JOIN ad_table tbl ON c.ad_table_id = tbl.ad_table_id
   LEFT JOIN ad_val_rule vr ON vr.ad_val_rule_id = COALESCE(f.ad_val_rule_id, c.ad_val_rule_id)
  WHERE f.isactive = 'Y'::bpchar AND c.isactive = 'Y'::bpchar
;

SELECT register_migration_script('201605052331_IDEMPIERE-2020.sql') FROM dual
;
