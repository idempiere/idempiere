SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2020 Value Format for ZK
-- Feb 25, 2015 5:45:01 PM COT
UPDATE AD_Column SET ReadOnlyLogic=NULL,Updated=TO_DATE('2015-02-25 17:45:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1179
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

Example of format "(000)_000-0000"',107,'VFormat',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-02-25 17:54:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-02-25 17:54:41','YYYY-MM-DD HH24:MI:SS'),100,616,'Y','N','D','N','N','N','Y','a585debb-2c2f-4a8f-89c9-28281fd44b62','Y',0,'N','N')
;

-- Feb 25, 2015 5:55:50 PM COT
UPDATE AD_Column SET FieldLength=255,Updated=TO_DATE('2015-02-25 17:55:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1179
;

-- Feb 25, 2015 5:55:52 PM COT
ALTER TABLE AD_Column MODIFY VFormat NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 25, 2015 5:56:14 PM COT
UPDATE AD_Column SET FieldLength=255,Updated=TO_DATE('2015-02-25 17:56:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3740
;

-- Feb 25, 2015 5:56:15 PM COT
ALTER TABLE AD_Process_Para MODIFY VFormat NVARCHAR2(255) DEFAULT NULL 
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

Example of format "(000)_000-0000"',464,'VFormat',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2015-02-25 17:57:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-02-25 17:57:00','YYYY-MM-DD HH24:MI:SS'),100,616,'Y','N','U','N','N','N','Y','35514060-1c96-435d-b3bf-101ed064d4f6','Y',0,'N','N')
;

-- Feb 25, 2015 5:57:03 PM COT
ALTER TABLE AD_UserDef_Field ADD VFormat NVARCHAR2(255) DEFAULT NULL 
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

Example of format "(000)_000-0000"',395,211840,'Y',255,290,'N','N','N','N',0,0,'Y',TO_DATE('2015-02-25 17:57:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-02-25 17:57:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','f8a92fba-ee26-4ccc-95ed-62dcfd3d7207','Y',290,5)
;

-- Feb 25, 2015 6:00:15 PM COT
ALTER TABLE AD_Field ADD VFormat NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 25, 2015 6:04:12 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, XPosition=1,Updated=TO_DATE('2015-02-25 18:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203499
;

-- Feb 25, 2015 6:04:12 PM COT
UPDATE AD_Field SET SeqNo=280,Updated=TO_DATE('2015-02-25 18:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- Feb 25, 2015 6:04:12 PM COT
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2015-02-25 18:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
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

Example of format "(000)_000-0000"',107,211839,'Y',255,410,'N','N','N','N',0,0,'Y',TO_DATE('2015-02-25 18:04:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-02-25 18:04:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8eb1b299-24e3-4c1b-bbc6-5c3b92e1adf8','Y',400,5)
;

-- Feb 25, 2015 6:05:15 PM COT
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2015-02-25 18:05:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=141
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=260,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200350
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=270,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200348
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=280,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200349
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13425
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=300,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200837
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=320,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=330,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200838
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=340,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200834
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=350,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13424
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=360,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62468
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=370,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53280
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=380,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200836
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=390,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200835
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=400, XPosition=1,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203500
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=410,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=136
;

-- Feb 25, 2015 6:05:16 PM COT
UPDATE AD_Field SET SeqNo=420,Updated=TO_DATE('2015-02-25 18:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=139
;

CREATE OR REPLACE VIEW AD_FIELD_V AS 
  SELECT t.AD_Window_ID, f.AD_Tab_ID, f.AD_Field_ID, tbl.AD_Table_ID, f.AD_Column_ID, 
 f.NAME, f.Description, f.Help, f.IsDisplayed, f.DisplayLogic, f.DisplayLength, 
 f.SeqNo, f.SortNo, f.IsSameLine, f.IsHeading, f.IsFieldOnly, f.IsReadOnly, 
 f.IsEncrypted AS IsEncryptedField, f.ObscureType,
 c.ColumnName, c.ColumnSQL, c.FieldLength, COALESCE(f.VFormat, c.VFormat) AS VFormat,
 COALESCE(f.DefaultValue, c.DefaultValue) AS DefaultValue,
 c.IsKey, c.IsParent, 
 COALESCE(f.IsMandatory, c.IsMandatory) AS IsMandatory, 
    c.IsIdentifier, c.IsTranslated, COALESCE(f.AD_Reference_Value_ID, c.AD_Reference_Value_ID) AS AD_Reference_Value_ID, 
 c.Callout, COALESCE(f.AD_Reference_ID, c.AD_Reference_ID) AS AD_Reference_ID, 
    COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID) AS AD_Val_Rule_ID, c.AD_Process_ID, 
 COALESCE(f.Isalwaysupdateable , C.Isalwaysupdateable) As Isalwaysupdateable,
 COALESCE(f.Readonlylogic,  c.Readonlylogic ) As Readonlylogic,
 COALESCE(f.Mandatorylogic , C.Mandatorylogic) As Mandatorylogic, 
 COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.IsEncrypted AS IsEncryptedColumn, 
    c.IsSelectionColumn,
 tbl.TableName, c.ValueMin, c.ValueMax,
 fg.NAME AS FieldGroup, vr.Code AS ValidationCode,
 f.Included_Tab_ID, fg.FieldGroupType, fg.IsCollapsedByDefault,
 COALESCE(f.InfoFactoryClass, c.InfoFactoryClass) as InfoFactoryClass,
 c.IsAutocomplete, COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines, 
 COALESCE(f.istoolbarbutton , c.istoolbarbutton ) As istoolbarbutton,
 c.FormatPattern, f.isadvancedfield, f.IsDefaultFocus, c.AD_Chart_ID
FROM AD_FIELD f 
  INNER JOIN AD_TAB t ON (f.AD_Tab_ID = t.AD_Tab_ID)
  LEFT OUTER JOIN AD_FIELDGROUP fg ON (f.AD_FieldGroup_ID = fg.AD_FieldGroup_ID) 
  LEFT OUTER JOIN AD_COLUMN c ON (f.AD_Column_ID = c.AD_Column_ID)
 INNER JOIN AD_TABLE tbl ON (c.AD_Table_ID = tbl.AD_Table_ID)
 LEFT OUTER JOIN AD_VAL_RULE vr ON (vr.AD_Val_Rule_ID = COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID))
WHERE f.IsActive = 'Y' 
  AND c.IsActive = 'Y'
;

CREATE OR REPLACE VIEW AD_FIELD_VT AS 
    SELECT trl.AD_LANGUAGE, t.AD_Window_ID, f.AD_Tab_ID, f.AD_Field_ID, tbl.AD_Table_ID, f.AD_Column_ID, 
   trl.NAME, trl.Description, trl.Help, f.IsDisplayed, f.DisplayLogic, f.DisplayLength, 
   f.SeqNo, f.SortNo, f.IsSameLine, f.IsHeading, f.IsFieldOnly, f.IsReadOnly, 
   f.IsEncrypted AS IsEncryptedField, f.ObscureType,
   c.ColumnName, c.ColumnSQL, c.FieldLength, COALESCE(f.VFormat, c.VFormat) AS VFormat,
   COALESCE(f.DefaultValue, c.DefaultValue) AS DefaultValue,
   c.IsKey, c.IsParent, 
   COALESCE(f.IsMandatory, c.IsMandatory) AS IsMandatory, 
      c.IsIdentifier, c.IsTranslated, COALESCE(f.AD_Reference_Value_ID, c.AD_Reference_Value_ID) AS AD_Reference_Value_ID, 
   c.Callout, COALESCE(f.AD_Reference_ID, c.AD_Reference_ID) AS AD_Reference_ID, 
      COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID) as AD_Val_Rule_ID, c.AD_Process_ID, 
   COALESCE(f.Isalwaysupdateable , C.Isalwaysupdateable) As Isalwaysupdateable,
   COALESCE(f.Readonlylogic,  c.Readonlylogic ) As Readonlylogic,
   COALESCE(f.Mandatorylogic , C.Mandatorylogic) As Mandatorylogic,  
   COALESCE(f.isupdateable, c.isupdateable) AS isupdateable, c.IsEncrypted AS IsEncryptedColumn, c.IsSelectionColumn,
   tbl.TableName, c.ValueMin, c.ValueMax, 
   fgt.NAME AS FieldGroup, vr.Code AS ValidationCode,
   f.Included_Tab_ID, fg.FieldGroupType, fg.IsCollapsedByDefault,
   COALESCE(f.InfoFactoryClass, c.InfoFactoryClass) as InfoFactoryClass,
   c.IsAutocomplete, COALESCE(f.IsAllowCopy, c.IsAllowCopy) AS IsAllowCopy,
	f.isdisplayedgrid, 
	f.seqnogrid,
	c.seqnoselection, f.xposition, f.columnspan, f.numlines, 
  COALESCE(f.istoolbarbutton , c.istoolbarbutton ) As istoolbarbutton,
  c.FormatPattern, f.isadvancedfield, f.IsDefaultFocus, c.AD_Chart_ID
  FROM AD_FIELD f 
   INNER JOIN AD_FIELD_TRL trl ON (f.AD_Field_ID = trl.AD_Field_ID)
    INNER JOIN AD_TAB t ON (f.AD_Tab_ID = t.AD_Tab_ID)
    LEFT OUTER JOIN AD_FIELDGROUP fg ON (f.AD_FieldGroup_ID = fg.AD_FieldGroup_ID) 
    LEFT OUTER JOIN AD_FIELDGROUP_TRL fgt ON 
   (f.AD_FieldGroup_ID = fgt.AD_FieldGroup_ID AND trl.AD_LANGUAGE=fgt.AD_LANGUAGE)
    LEFT OUTER JOIN AD_COLUMN c ON (f.AD_Column_ID = c.AD_Column_ID)
   INNER JOIN AD_TABLE tbl ON (c.AD_Table_ID = tbl.AD_Table_ID)
   LEFT OUTER JOIN AD_VAL_RULE vr ON (vr.AD_Val_Rule_ID=COALESCE(f.AD_Val_Rule_ID, c.AD_Val_Rule_ID))
  WHERE f.IsActive = 'Y' 
  AND c.IsActive = 'Y'
;

SELECT register_migration_script('201605052331_IDEMPIERE-2020.sql') FROM dual
;
