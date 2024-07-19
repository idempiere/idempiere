-- IDEMPIERE-5243 More columns to increase length
SELECT register_migration_script('202209101629_IDEMPIERE-5243.sql') FROM dual;

-- Sep 10, 2022, 4:29:13 PM CEST
UPDATE AD_Column SET FieldLength=4000, AD_Reference_ID=34,Updated=TO_TIMESTAMP('2022-09-10 16:29:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8781
;

-- Sep 10, 2022, 4:29:16 PM CEST
INSERT INTO t_alter_column values('ad_pinstance_log','P_Msg','VARCHAR(4000)',null,'NULL')
;

-- Sep 10, 2022, 4:30:03 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-10 16:30:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10521
;

