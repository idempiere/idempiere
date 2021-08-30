-- IDEMPIERE-1575 with regards to IDEMPIERE-4724
-- 30.08.2021, 10:54:12 MESZ
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2021-08-30 10:54:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4704
;

-- 30.08.2021, 10:56:36 MESZ
INSERT INTO t_alter_column values('ad_impformat_row','Callout','VARCHAR(255)',null,'NULL')
;
