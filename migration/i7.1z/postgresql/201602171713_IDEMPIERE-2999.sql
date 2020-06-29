-- IDEMPIERE-2999 Attribute, Table Direct and date field support
-- Mar 3, 2016 11:15:59 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200352,'Reference','Reference',326,'R',0,0,'Y',TO_TIMESTAMP('2016-03-03 11:15:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:15:58','YYYY-MM-DD HH24:MI:SS'),100,'D','57503d9a-9bd2-4eb9-b2cf-1f43dc144dcc')
;

-- Mar 3, 2016 11:16:56 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212643,0,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',562,'AD_Reference_ID',22,'N','N','N','N','N',0,'N',18,1,0,0,'Y',TO_TIMESTAMP('2016-03-03 11:16:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:16:55','YYYY-MM-DD HH24:MI:SS'),100,120,'Y','N','D','N','N','N','Y','30425bec-829d-4fdd-9781-be453810859b','Y',0,'N','N','N')
;

-- Mar 3, 2016 11:16:59 AM IST
UPDATE AD_Column SET FKConstraintName='ADReference_MAttribute', FKConstraintType='N',Updated=TO_TIMESTAMP('2016-03-03 11:16:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212643
;

-- Mar 3, 2016 11:16:59 AM IST
ALTER TABLE M_Attribute ADD COLUMN AD_Reference_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 3, 2016 11:16:59 AM IST
ALTER TABLE M_Attribute ADD CONSTRAINT ADReference_MAttribute FOREIGN KEY (AD_Reference_ID) REFERENCES ad_reference(ad_reference_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2016 11:17:19 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (212644,0,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',562,115,'AD_Reference_Value_ID',22,'N','N','N','N','N',0,'N',18,4,0,0,'Y',TO_TIMESTAMP('2016-03-03 11:17:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:17:19','YYYY-MM-DD HH24:MI:SS'),100,121,'Y','N','D','N','N','N','Y','4773b14c-3fd5-4a27-b612-f2c055e30906','Y',0,'N','N','N')
;

-- Mar 3, 2016 11:17:28 AM IST
UPDATE AD_Column SET FKConstraintName='ADReferenceValue_MAttribute', FKConstraintType='N',Updated=TO_TIMESTAMP('2016-03-03 11:17:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212644
;

-- Mar 3, 2016 11:17:28 AM IST
ALTER TABLE M_Attribute ADD COLUMN AD_Reference_Value_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 3, 2016 11:17:28 AM IST
ALTER TABLE M_Attribute ADD CONSTRAINT ADReferenceValue_MAttribute FOREIGN KEY (AD_Reference_Value_ID) REFERENCES ad_reference(ad_reference_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 3, 2016 11:19:23 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202981,0,0,'Y',TO_TIMESTAMP('2016-03-03 11:19:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:19:19','YYYY-MM-DD HH24:MI:SS'),100,'ValueInt','Value','Value','D','12e1f7c7-5b52-4190-8777-10da977b2b05')
;

-- Mar 3, 2016 11:20:16 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212645,0,'Value',561,'ValueInt',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2016-03-03 11:20:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:20:15','YYYY-MM-DD HH24:MI:SS'),100,202981,'Y','N','D','N','N','N','Y','893764b7-1e65-4fb2-81a5-9ac4acf1428d','Y',0,'N','N')
;

-- Mar 3, 2016 11:20:20 AM IST
ALTER TABLE M_AttributeInstance ADD COLUMN ValueInt NUMERIC(10) DEFAULT NULL 
;

-- Mar 3, 2016 11:20:32 AM IST
UPDATE AD_Column SET FieldLength=10,Updated=TO_TIMESTAMP('2016-03-03 11:20:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212645
;

-- Mar 3, 2016 11:20:35 AM IST
INSERT INTO t_alter_column values('m_attributeinstance','ValueInt','NUMERIC(10)',null,'NULL')
;

-- Mar 3, 2016 11:22:28 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (202982,0,0,'Y',TO_TIMESTAMP('2016-03-03 11:22:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:22:24','YYYY-MM-DD HH24:MI:SS'),100,'ValueTimeStamp','Value','TimeStamp Value','Value','D','e0775628-b063-44d7-8586-a5f384301d22')
;

-- Mar 3, 2016 11:22:40 AM IST
UPDATE AD_Element SET Description='Integer Value',Updated=TO_TIMESTAMP('2016-03-03 11:22:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202981
;

-- Mar 3, 2016 11:22:40 AM IST
UPDATE AD_Column SET ColumnName='ValueInt', Name='Value', Description='Integer Value', Help=NULL WHERE AD_Element_ID=202981
;

-- Mar 3, 2016 11:22:40 AM IST
UPDATE AD_Process_Para SET ColumnName='ValueInt', Name='Value', Description='Integer Value', Help=NULL, AD_Element_ID=202981 WHERE UPPER(ColumnName)='VALUEINT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 3, 2016 11:22:40 AM IST
UPDATE AD_Process_Para SET ColumnName='ValueInt', Name='Value', Description='Integer Value', Help=NULL WHERE AD_Element_ID=202981 AND IsCentrallyMaintained='Y'
;

-- Mar 3, 2016 11:22:40 AM IST
UPDATE AD_InfoColumn SET ColumnName='ValueInt', Name='Value', Description='Integer Value', Help=NULL WHERE AD_Element_ID=202981 AND IsCentrallyMaintained='Y'
;

-- Mar 3, 2016 11:22:40 AM IST
UPDATE AD_Field SET Name='Value', Description='Integer Value', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202981) AND IsCentrallyMaintained='Y'
;

-- Mar 3, 2016 11:23:59 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212646,0,'Value','TimeStamp Value',561,'ValueTimeStamp',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2016-03-03 11:23:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:23:59','YYYY-MM-DD HH24:MI:SS'),100,202982,'Y','N','D','N','N','N','Y','bb9c7cec-410c-4267-a864-77d2cf87a499','Y',0,'N','N')
;

-- Mar 3, 2016 11:24:03 AM IST
ALTER TABLE M_AttributeInstance ADD COLUMN ValueTimeStamp TIMESTAMP DEFAULT NULL 
;

-- Mar 3, 2016 11:25:44 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204143,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',462,212643,'Y','@AttributeValueType@=''R''',0,90,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-03 11:25:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:25:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6662da7e-b41c-44d0-aa42-edc15857a9f3','Y',100,1,1,1,'N','N','N')
;

-- Mar 3, 2016 11:38:57 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204144,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',462,212644,'Y','(@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28) & @AttributeValueType@=''R''',0,100,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2016-03-03 11:38:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:38:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0ac3e965-019d-4da4-a8c5-7fa0ced885fa','Y',110,1,1,1,'N','N','N')
;

-- Mar 3, 2016 11:39:18 AM IST
UPDATE AD_Field SET SeqNo=90, ColumnSpan=2,Updated=TO_TIMESTAMP('2016-03-03 11:39:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204143
;

-- Mar 3, 2016 11:39:18 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2016-03-03 11:39:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Mar 3, 2016 11:40:04 AM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200090,'AD_Reference Attribute','S','AD_Reference_ID NOT IN (21,23,28,35,53370,19)',0,0,'Y',TO_TIMESTAMP('2016-03-03 11:40:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2016-03-03 11:40:03','YYYY-MM-DD HH24:MI:SS'),100,'D','df9e32eb-59df-49b8-a7fa-a6fb9c1f6786')
;

-- Mar 3, 2016 11:40:25 AM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200090,Updated=TO_TIMESTAMP('2016-03-03 11:40:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212643
;

SELECT register_migration_script('201602171713_IDEMPIERE-2999.sql') FROM dual
;

