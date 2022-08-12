-- IDEMPIERE-5372  Wrong default for IsApproved column on C_Order, C_Invoice and C_CashPlan
SELECT register_migration_script('202208111553_IDEMPIERE-5372.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 11, 2022, 3:53:54 PM CEST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_TIMESTAMP('2022-08-11 15:53:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2175
;

-- Aug 11, 2022, 3:55:19 PM CEST
ALTER TABLE C_Order MODIFY IsApproved CHAR(1) DEFAULT 'N'
;

-- Aug 11, 2022, 3:55:21 PM CEST
UPDATE C_Order SET IsApproved='N' WHERE IsApproved IS NULL
;

-- Aug 11, 2022, 3:58:17 PM CEST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_TIMESTAMP('2022-08-11 15:58:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3503
;

-- Aug 11, 2022, 3:58:28 PM CEST
ALTER TABLE C_Invoice MODIFY IsApproved CHAR(1) DEFAULT 'N'
;

-- Aug 11, 2022, 3:58:28 PM CEST
UPDATE C_Invoice SET IsApproved='N' WHERE IsApproved IS NULL
;

-- Aug 11, 2022, 4:00:09 PM CEST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_TIMESTAMP('2022-08-11 16:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=60172
;

-- Aug 11, 2022, 4:00:31 PM CEST
ALTER TABLE C_CashPlan MODIFY IsApproved CHAR(1) DEFAULT 'N'
;

-- Aug 11, 2022, 4:00:31 PM CEST
UPDATE C_CashPlan SET IsApproved='N' WHERE IsApproved IS NULL
;

