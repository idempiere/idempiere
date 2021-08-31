SET SQLBLANKLINES ON
SET DEFINE OFF

INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,Name,Updated,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,AD_Org_ID,IsActive,AD_Client_ID,Created,EntityType) VALUES ('M_AttributeValue.M_Attribute_ID=@M_Attribute_ID@',200100,'M_AttributeValue of M_Attribute (Dictionary)',TO_DATE('2021-08-04 15:51:27','YYYY-MM-DD HH24:MI:SS'),'S','3f465604-2f70-4bf8-a874-87ad6d4cd7e5',100,100,0,'Y',0,TO_DATE('2021-08-04 15:51:27','YYYY-MM-DD HH24:MI:SS'),'D')
;

-- Aug 2, 2017 1:39:02 PM GMT+08:00
-- IDEMPIERE-4899 Report: print product instance attribute name and value as column
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Help,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203123,'IsPrintInstanceAttributes','This control the printing of product attribute set instance. When checked, the report will have one column for each instance attribute instead of printing the description of attribute set instance.',TO_DATE('2021-08-04 13:39:00','YYYY-MM-DD HH24:MI:SS'),'Print Instance Attributes','Print each instance attributes as report column instead of printing the description of attribute set instance','Print Instance Attributes','6c12c1aa-3760-4261-b37d-cf8c9050ea86','Y',TO_DATE('2021-08-04 13:39:00','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Aug 2, 2017 1:40:07 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213184,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','21121b4e-772a-4a09-bde9-bdc1e26a67e6',TO_DATE('2021-08-04 13:40:06','YYYY-MM-DD HH24:MI:SS'),'Y','IsPrintInstanceAttributes','Print each instance attributes as report column instead of printing the description of attribute set instance','N','This control the printing of product attribute set instance. When checked, the report will have one column for each instance attribute instead of printing the description of attribute set instance.','Print Instance Attributes','Y','Y',100,100,'N',0,0,TO_DATE('2021-08-04 13:40:06','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203123,20,489,'N')
;

-- Aug 2, 2017 1:40:20 PM GMT+08:00
ALTER TABLE AD_PrintFormatItem ADD IsPrintInstanceAttributes CHAR(1) DEFAULT 'N' CHECK (IsPrintInstanceAttributes IN ('Y','N')) NOT NULL
;

-- Aug 2, 2017 1:44:13 PM GMT+08:00
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,DisplayLogic,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (0,205192,'N',0,'N','N',155,'Y','N','This control the printing of product attribute set instance. When checked, the report will have one column for each instance attribute instead of printing the description of attribute set instance.','@PrintFormatType@=F & @AD_Column_ID.AD_Reference_ID@=35',0,TO_DATE('2021-08-04 13:44:13','YYYY-MM-DD HH24:MI:SS'),'Print each instance attributes as report column instead of printing the description of attribute set instance','Print Instance Attributes','984bc17c-ad84-4f7c-bad3-009a259d6a1f','Y','N',100,100,'Y','Y',155,5,'N',0,TO_DATE('2021-08-04 13:44:13','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213184,'D',426)
;

-- Aug 3, 2017 10:42:42 PM GMT+08:00
-- IDEMPIERE-4899 Report: print product instance attribute name and value as column
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,Name,Updated,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,AD_Org_ID,IsActive,AD_Client_ID,Created,EntityType) VALUES ('M_Attribute.M_Attribute_ID IN ( SELECT M_Attribute_ID FROM M_AttributeUse WHERE IsActive=''Y'' AND M_AttributeSet_ID=@M_Product_M_AttributeSet_ID@ )',200099,'M_Attribute of M_Product_M_AttributeSet',TO_DATE('2021-08-04 22:42:40','YYYY-MM-DD HH24:MI:SS'),'S','16287e64-946d-4256-abfe-6dcc694eebb7',100,100,0,'Y',0,TO_DATE('2021-08-04 22:42:40','YYYY-MM-DD HH24:MI:SS'),'D')
;

-- Aug 3, 2017 10:44:52 PM GMT+08:00
UPDATE AD_Element SET Name='Product Attribute Set', PrintName='Product Attribute Set',Updated=TO_DATE('2021-08-04 22:44:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=201353
;

-- Aug 3, 2017 10:44:52 PM GMT+08:00
UPDATE AD_Column SET ColumnName='M_Product_M_AttributeSet_ID', Name='Product Attribute Set', Description=NULL, Help=NULL WHERE AD_Element_ID=201353
;

-- Aug 3, 2017 10:44:52 PM GMT+08:00
UPDATE AD_InfoColumn SET ColumnName='M_Product_M_AttributeSet_ID', Name='Product Attribute Set', Description=NULL, Help=NULL WHERE AD_Element_ID=201353 AND IsCentrallyMaintained='Y'
;

-- Aug 3, 2017 10:44:52 PM GMT+08:00
UPDATE AD_Field SET Name='Product Attribute Set', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=201353) AND IsCentrallyMaintained='Y'
;

-- Aug 3, 2017 10:44:52 PM GMT+08:00
UPDATE AD_PrintFormatItem SET PrintName='Product Attribute Set', Name='Product Attribute Set' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=201353)
;

-- Aug 4, 2017 4:58:53 PM GMT+08:00
-- IDEMPIERE-4899 Report: print product instance attribute name and value as column
UPDATE AD_Val_Rule SET Code='M_Attribute.M_Attribute_ID IN ( SELECT M_Attribute_ID FROM M_AttributeUse WHERE IsActive=''Y'' AND M_AttributeSet_ID=@M_Product_M_AttributeSet_ID@ ) AND M_Attribute.IsInstanceAttribute=''N''',Updated=TO_DATE('2021-08-04 16:58:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200099
;

-- Aug 7, 2017 10:05:56 AM GMT+08:00
-- IDEMPIERE-4899 Report: print product instance attribute name and value as column
UPDATE AD_Element SET Help='This control the printing of product attribute set instance. When checked, the report will have one column for each attribute instead of printing the description of attribute set instance.', Name='Print Attributes', Description='Print each attributes as report column instead of printing the description of attribute set instance', PrintName='Print Attributes',Updated=TO_DATE('2021-08-04 10:05:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203123
;

-- Aug 7, 2017 10:05:56 AM GMT+08:00
UPDATE AD_Column SET ColumnName='IsPrintInstanceAttributes', Name='Print Attributes', Description='Print each attributes as report column instead of printing the description of attribute set instance', Help='This control the printing of product attribute set instance. When checked, the report will have one column for each attribute instead of printing the description of attribute set instance.' WHERE AD_Element_ID=203123
;

-- Aug 7, 2017 10:05:57 AM GMT+08:00
UPDATE AD_InfoColumn SET ColumnName='IsPrintInstanceAttributes', Name='Print Attributes', Description='Print each attributes as report column instead of printing the description of attribute set instance', Help='This control the printing of product attribute set instance. When checked, the report will have one column for each attribute instead of printing the description of attribute set instance.' WHERE AD_Element_ID=203123 AND IsCentrallyMaintained='Y'
;

-- Aug 7, 2017 10:05:57 AM GMT+08:00
UPDATE AD_Field SET Name='Print Attributes', Description='Print each attributes as report column instead of printing the description of attribute set instance', Help='This control the printing of product attribute set instance. When checked, the report will have one column for each attribute instead of printing the description of attribute set instance.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203123) AND IsCentrallyMaintained='Y'
;

-- Aug 7, 2017 10:05:57 AM GMT+08:00
UPDATE AD_PrintFormatItem SET PrintName='Print Attributes', Name='Print Attributes' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203123)
;

-- Aug 9, 2017 10:58:35 AM GMT+08:00
-- IDEMPIERE-4899 Report: print product instance attribute name and value as column
UPDATE AD_Val_Rule SET Code='M_Attribute.M_Attribute_ID IN ( SELECT M_Attribute_ID FROM M_AttributeUse WHERE IsActive=''Y'' AND M_AttributeSet_ID=@M_Product_M_AttributeSet_ID@ )',Updated=TO_DATE('2021-08-04 10:58:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200099
;

-- Aug 10, 2017 7:35:34 AM GMT+08:00
UPDATE AD_Field SET DisplayLogic='(@AD_Column_ID.AD_Reference_ID@=35 | @AD_Column_ID.ColumnName@=''M_AttributeSetInstance_ID'') & @PrintFormatType@=F & @IsForm@=N', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-08-04 08:20:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205192
;

SELECT register_migration_script('202108021350_IDEMPIERE-4899.sql') FROM dual
;
