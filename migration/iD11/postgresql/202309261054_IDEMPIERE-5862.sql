-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=6215
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=7718
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=54896
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=3084
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=54679
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=4019
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=4020
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=201246
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=202209
;

-- Sep 26, 2023, 10:54:33 AM WIB
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-09-26 10:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=5637
;

UPDATE AD_Column SET IsAlwaysUpdateable='Y'
WHERE IsAlwaysUpdateable='N' AND ColumnName='PaymentRule'
AND EXISTS (SELECT 1 FROM AD_Table t WHERE t.AD_Table_ID=AD_Column.AD_Table_ID AND t.IsView='N')
;

-- IDEMPIERE-5862
SELECT register_migration_script('202309261054_IDEMPIERE-5862.sql') FROM dual;
