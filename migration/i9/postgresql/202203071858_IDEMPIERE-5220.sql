-- IDEMPIERE-5220 Duplicated indexes in postgresql (and mismatch against oracle) / FHCA-2740
SELECT register_migration_script('202203071858_IDEMPIERE-5220.sql') FROM dual;

-- Mar 7, 2022, 6:44:00 PM CET
DROP INDEX ad_wlistbox_customization_uu_idx
;

-- Mar 7, 2022, 6:44:14 PM CET
UPDATE AD_TableIndex SET Name='ad_wlistbox_customizationuuidx',Updated=TO_TIMESTAMP('2022-03-07 18:44:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201090
;

