-- IDEMPIERE-2556 User preferences window configurable
-- Apr 27, 2015 10:32:35 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (202883,0,0,'Y',TO_TIMESTAMP('2015-04-27 10:32:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-27 10:32:34','YYYY-MM-DD HH24:MI:SS'),100,'AutomaticDecimalPlacesForAmoun','Automatic Decimal Places For Amounts','Automatically insert a decimal point','Automatically insert a decimal point','Automatic Decimal Places For Amounts','D','369fb0de-beae-468d-b6f6-eb08022b5d99')
;

-- Apr 27, 2015 10:36:04 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212178,0,'Automatic Decimal Places For Amounts','Automatically insert a decimal point','Automatically insert a decimal point',200174,'AutomaticDecimalPlacesForAmoun','0',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2015-04-27 10:36:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-27 10:36:04','YYYY-MM-DD HH24:MI:SS'),100,202883,'Y','N','D','N','N','N','Y','ece77164-32a7-4cc5-a549-64f9179f0ff7','Y',0,'N','N')
;

-- Apr 27, 2015 10:36:06 AM CEST
ALTER TABLE AD_UserPreference ADD COLUMN AutomaticDecimalPlacesForAmoun NUMERIC(10) DEFAULT '0' 
;

-- Apr 27, 2015 10:36:18 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203800,'Automatic Decimal Places For Amounts','Automatically insert a decimal point','Automatically insert a decimal point',200189,212178,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-04-27 10:36:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-27 10:36:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1e15c066-264b-4f32-8f17-43fff3948d88','Y',70,2)
;

-- Apr 27, 2015 10:36:32 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1,Updated=TO_TIMESTAMP('2015-04-27 10:36:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203800
;

-- Apr 27, 2015 10:36:32 AM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2015-04-27 10:36:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203798
;

-- Apr 27, 2015 9:53:47 PM CEST
UPDATE AD_Element SET Help='i.e. "Entering 2 only results in a value of 0.02 for the entry. If you use the "." key during entry of a value, the decimal point is included at the place you specify. This mode has no effect on multiplication and division operations. If 0 is entered it will work as usual."',Updated=TO_TIMESTAMP('2015-04-27 21:53:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202883
;

-- Apr 27, 2015 9:53:47 PM CEST
UPDATE AD_Column SET ColumnName='AutomaticDecimalPlacesForAmoun', Name='Automatic Decimal Places For Amounts', Description='Automatically insert a decimal point', Help='i.e. "Entering 2 only results in a value of 0.02 for the entry. If you use the "." key during entry of a value, the decimal point is included at the place you specify. This mode has no effect on multiplication and division operations. If 0 is entered it will work as usual."' WHERE AD_Element_ID=202883
;

-- Apr 27, 2015 9:53:47 PM CEST
UPDATE AD_InfoColumn SET ColumnName='AutomaticDecimalPlacesForAmoun', Name='Automatic Decimal Places For Amounts', Description='Automatically insert a decimal point', Help='i.e. "Entering 2 only results in a value of 0.02 for the entry. If you use the "." key during entry of a value, the decimal point is included at the place you specify. This mode has no effect on multiplication and division operations. If 0 is entered it will work as usual."' WHERE AD_Element_ID=202883 AND IsCentrallyMaintained='Y'
;

-- Apr 27, 2015 9:53:47 PM CEST
UPDATE AD_Field SET Name='Automatic Decimal Places For Amounts', Description='Automatically insert a decimal point', Help='i.e. "Entering 2 only results in a value of 0.02 for the entry. If you use the "." key during entry of a value, the decimal point is included at the place you specify. This mode has no effect on multiplication and division operations. If 0 is entered it will work as usual."' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202883) AND IsCentrallyMaintained='Y'
;


SELECT register_migration_script('201504271636_IDEMPIERE-2553.sql') FROM dual
;

