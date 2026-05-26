-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603281559_IDEMPIERE-6908.sql') FROM dual;

-- Mar 28, 2026, 3:59:27 PM GMT+08:00
UPDATE AD_Field SET IsUpdateable='N',Updated=TO_TIMESTAMP('2026-03-28 15:59:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209059
;

-- Mar 28, 2026, 3:59:57 PM GMT+08:00
UPDATE AD_Field SET IsUpdateable='N',Updated=TO_TIMESTAMP('2026-03-28 15:59:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209063
;

