-- Aug 6, 2020, 3:15:24 PM CEST
UPDATE C_Region SET Description='Amapá',Updated=TO_TIMESTAMP('2020-08-06 15:15:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=443
;

-- Aug 6, 2020, 3:17:01 PM CEST
UPDATE C_Region SET Description='Ceará',Updated=TO_TIMESTAMP('2020-08-06 15:17:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=446
;

-- Aug 6, 2020, 3:17:14 PM CEST
UPDATE C_Region SET Description='Espírito Santo',Updated=TO_TIMESTAMP('2020-08-06 15:17:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=448
;

-- Aug 6, 2020, 3:17:26 PM CEST
UPDATE C_Region SET Description='Goiás',Updated=TO_TIMESTAMP('2020-08-06 15:17:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=449
;

-- Aug 6, 2020, 3:17:33 PM CEST
UPDATE C_Region SET Description='Maranhão',Updated=TO_TIMESTAMP('2020-08-06 15:17:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=450
;

-- Aug 6, 2020, 3:17:46 PM CEST
UPDATE C_Region SET Description='Pará',Updated=TO_TIMESTAMP('2020-08-06 15:17:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=454
;

-- Aug 6, 2020, 3:17:54 PM CEST
UPDATE C_Region SET Description='Paraíba',Updated=TO_TIMESTAMP('2020-08-06 15:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=455
;

-- Aug 6, 2020, 3:18:03 PM CEST
UPDATE C_Region SET Description='Piauí',Updated=TO_TIMESTAMP('2020-08-06 15:18:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=458
;

-- Aug 6, 2020, 3:18:09 PM CEST
UPDATE C_Region SET Description='Paraná',Updated=TO_TIMESTAMP('2020-08-06 15:18:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=456
;

-- Aug 6, 2020, 3:18:20 PM CEST
UPDATE C_Region SET Description='Rondônia',Updated=TO_TIMESTAMP('2020-08-06 15:18:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=462
;

-- Aug 6, 2020, 3:18:54 PM CEST
UPDATE C_Region SET Description='São Paulo',Updated=TO_TIMESTAMP('2020-08-06 15:18:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Region_ID=465
;

SELECT register_migration_script('202008061523_IDEMPIERE-4404.sql') FROM dual
;

