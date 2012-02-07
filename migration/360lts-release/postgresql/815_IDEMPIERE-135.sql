-- Feb 6, 2012 9:16:24 PM COT
-- IDEMPIERE-135 Translation of User/Contact - English
-- Fix a bug introduced with script 785_744_FR3018857_ImporterInventoryMove.sql
UPDATE AD_Element SET Name='User/Contact', PrintName='User',Updated=TO_TIMESTAMP('2012-02-06 21:16:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=138
;

-- Feb 6, 2012 9:16:24 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=138
;

-- Feb 6, 2012 9:16:24 PM COT
UPDATE AD_Column SET ColumnName='AD_User_ID', Name='User/Contact', Description='User within the system - Internal or Business Partner Contact', Help='The User identifies a unique user in the system. This could be an internal user or a business partner contact' WHERE AD_Element_ID=138
;

-- Feb 6, 2012 9:16:25 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_ID', Name='User/Contact', Description='User within the system - Internal or Business Partner Contact', Help='The User identifies a unique user in the system. This could be an internal user or a business partner contact', AD_Element_ID=138 WHERE UPPER(ColumnName)='AD_USER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 6, 2012 9:16:25 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_User_ID', Name='User/Contact', Description='User within the system - Internal or Business Partner Contact', Help='The User identifies a unique user in the system. This could be an internal user or a business partner contact' WHERE AD_Element_ID=138 AND IsCentrallyMaintained='Y'
;

-- Feb 6, 2012 9:16:25 PM COT
UPDATE AD_Field SET Name='User/Contact', Description='User within the system - Internal or Business Partner Contact', Help='The User identifies a unique user in the system. This could be an internal user or a business partner contact' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=138) AND IsCentrallyMaintained='Y'
;

-- Feb 6, 2012 9:16:25 PM COT
UPDATE AD_PrintFormatItem SET PrintName='User', Name='User/Contact' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=138)
;

-- Feb 6, 2012 9:16:46 PM COT
UPDATE AD_Element_Trl SET IsTranslated='Y',Updated=TO_TIMESTAMP('2012-02-06 21:16:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=138 AND AD_Language='es_CO'
;

