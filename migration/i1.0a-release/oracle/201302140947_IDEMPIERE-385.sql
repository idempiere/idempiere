-- Feb 14, 2013 9:38:24 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Element SET Name='Reservation Locator', Description='Reservation Locator (just for reporting purposes)',Updated=TO_DATE('2013-02-14 09:38:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200188
;

-- Feb 14, 2013 9:38:24 AM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200188
;

-- Feb 14, 2013 9:38:24 AM COT
UPDATE AD_Column SET ColumnName='M_ReserveLocator_ID', Name='Reservation Locator', Description='Reservation Locator (just for reporting purposes)', Help=NULL WHERE AD_Element_ID=200188
;

-- Feb 14, 2013 9:38:24 AM COT
UPDATE AD_Process_Para SET ColumnName='M_ReserveLocator_ID', Name='Reservation Locator', Description='Reservation Locator (just for reporting purposes)', Help=NULL, AD_Element_ID=200188 WHERE UPPER(ColumnName)='M_RESERVELOCATOR_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 14, 2013 9:38:24 AM COT
UPDATE AD_Process_Para SET ColumnName='M_ReserveLocator_ID', Name='Reservation Locator', Description='Reservation Locator (just for reporting purposes)', Help=NULL WHERE AD_Element_ID=200188 AND IsCentrallyMaintained='Y'
;

-- Feb 14, 2013 9:38:24 AM COT
UPDATE AD_InfoColumn SET ColumnName='M_ReserveLocator_ID', Name='Reservation Locator', Description='Reservation Locator (just for reporting purposes)', Help=NULL WHERE AD_Element_ID=200188 AND IsCentrallyMaintained='Y'
;

-- Feb 14, 2013 9:38:24 AM COT
UPDATE AD_Field SET Name='Reservation Locator', Description='Reservation Locator (just for reporting purposes)', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200188) AND IsCentrallyMaintained='Y'
;

-- Feb 14, 2013 9:38:24 AM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Reserve Locator', Name='Reservation Locator' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200188)
;

SELECT register_migration_script('201302140947_IDEMPIERE-385.sql') FROM dual;

