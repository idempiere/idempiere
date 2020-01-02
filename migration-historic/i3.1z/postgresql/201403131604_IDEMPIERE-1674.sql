-- Mar 13, 2014 1:44:41 AM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@<1', IsUpdateable='Y',Updated=TO_TIMESTAMP('2014-03-13 01:44:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=3557
;
UPDATE AD_Column SET Callout='org.compiere.model.CalloutInventory.setCharge',Updated=TO_TIMESTAMP('2014-03-13 02:26:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9950
;
-- Mar 13, 2014 6:41:26 AM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Field SET ReadOnlyLogic='@InventoryType@!C',Updated=TO_TIMESTAMP('2014-03-13 06:41:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2691
;

-- Mar 13, 2014 6:58:08 AM ICT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutInventory.setInventoryType',Updated=TO_TIMESTAMP('2014-03-13 06:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9951
;

SELECT register_migration_script('201403131604_IDEMPIERE-1674.sql') FROM dual
;

