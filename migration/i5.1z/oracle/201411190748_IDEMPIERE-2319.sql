SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 18, 2014 5:10:06 PM IST
-- IDEMPIERE-2319: Adding date value type support in Attribute set
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created,Updated) VALUES ('ValueDate',202805,'Value Date','Value Date','ba9c466b-4436-47ec-b193-5d3b5e9ce30a',0,100,100,'Y',0,'D',TO_DATE('2014-11-18 17:10:05','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-11-18 17:10:05','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 18, 2014 5:10:42 PM IST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,Updated) VALUES (0,'N',0,211801,'N','N','N',0,'N',7,'N','N','N','Y','986f6b4a-a721-4fa3-a865-89416a9adb6e','Y','ValueDate','Value Date','Y',100,0,'Y',TO_DATE('2014-11-18 17:10:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N',202805,15,561,TO_DATE('2014-11-18 17:10:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 18, 2014 5:10:50 PM IST
ALTER TABLE M_AttributeInstance ADD ValueDate DATE DEFAULT NULL 
;

-- Nov 18, 2014 3:37:28 PM IST
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Table_ID,Updated) VALUES (0,'N',0,211800,'N','N','N',0,'N',20,'N','N','N','Y','@AttributeValueType@=''D''','e5d9f3a8-5bc5-44ea-8bd0-4c00f54785c0','Y','DateFormat','Date format used in the input format','The date format is usually detected, but sometimes need to be defined.','Date Format','Y',100,0,'Y',TO_DATE('2014-11-18 15:37:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N',2286,10,562,TO_DATE('2014-11-18 15:37:27','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 18, 2014 3:37:33 PM IST
ALTER TABLE M_Attribute ADD DateFormat VARCHAR2(20) DEFAULT NULL 
;

-- Nov 18, 2014 3:39:07 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,CreatedBy,UpdatedBy,Created,IsActive,EntityType,AD_Client_ID,AD_Org_ID,Updated) VALUES (200279,326,'Date','34c7fbc0-6718-433e-a55c-6d203496e06a','D',100,100,TO_DATE('2014-11-18 15:39:07','YYYY-MM-DD HH24:MI:SS'),'Y','D',0,0,TO_DATE('2014-11-18 15:39:07','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 18, 2014 3:41:05 PM IST
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2014-11-18 15:41:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211800
;

-- Nov 18, 2014 3:41:33 PM IST
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,ColumnSpan,AD_Column_ID,EntityType,Created,Updated) VALUES ('N',462,20,'N','N',100,'Y',203472,'N','The date format is usually detected, but sometimes need to be defined.','Date format used in the input format','Date Format','361e4d18-9ad0-4b74-b730-bc6620502b40','Y','N',100,0,100,'Y','Y',100,0,2,211800,'D',TO_DATE('2014-11-18 15:41:32','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-11-18 15:41:32','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 18, 2014 3:43:32 PM IST
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=''D''', MandatoryLogic='@AttributeValueType@=''D''',Updated=TO_DATE('2014-11-18 15:43:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203472
;

SELECT register_migration_script('201411190748_IDEMPIERE-2319.sql') FROM dual
;
