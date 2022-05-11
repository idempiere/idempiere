-- IDEMPIERE-4550 Fix columns length difference between AD and DB
SELECT register_migration_script('202203261837_IDEMPIERE-4550.sql') FROM dual;

-- 26/03/2022, 6:37:19 p. m. GMT+01:00
UPDATE AD_Column SET FieldLength=1,Updated=TO_TIMESTAMP('2022-03-26 18:37:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55810
;


-- 26/03/2022, 6:45:16 p. m. GMT+01:00
INSERT INTO t_alter_column values('ad_fieldgroup','FieldGroupType','VARCHAR(10)',null,'NULL')
;

-- 26/03/2022, 6:51:08 p. m. GMT+01:00
UPDATE AD_Column SET FieldLength=10,Updated=TO_TIMESTAMP('2022-03-26 18:51:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211257
;

-- 26/03/2022, 6:51:32 p. m. GMT+01:00
UPDATE AD_InfoProcess SET LayoutType='B' WHERE LayoutType IS NULL
;

-- 26/03/2022, 6:56:07 p. m. GMT+01:00
UPDATE AD_Column SET IsActive='Y',Updated=TO_TIMESTAMP('2022-03-26 18:56:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=52069
;

-- 26/03/2022, 6:56:54 p. m. GMT+01:00
INSERT INTO t_alter_column values('ad_printformat','Args','VARCHAR(510)',null,'NULL')
;

-- 26/03/2022, 6:57:10 p. m. GMT+01:00
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2022-03-26 18:57:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=52069
;

-- 26/03/2022, 6:59:45 p. m. GMT+01:00
INSERT INTO t_alter_column values('ad_userbpaccess','DocBaseType','VARCHAR(10)',null,'NULL')
;

-- 26/03/2022, 7:02:56 p. m. GMT+01:00
UPDATE AD_Column SET FieldLength=1,Updated=TO_TIMESTAMP('2022-03-26 19:02:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13894
;

-- 26/03/2022, 7:06:50 p. m. GMT+01:00
UPDATE AD_Column SET FieldLength=510, SeqNoSelection=10,Updated=TO_TIMESTAMP('2022-03-26 19:06:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2011
;

-- 26/03/2022, 8:24:05 p. m. GMT+01:00
INSERT INTO t_alter_column values('m_product','Value','VARCHAR(510)',null,null)
;

-- 26/03/2022, 7:08:38 p. m. GMT+01:00
INSERT INTO t_alter_column values('r_issueproject','Name','VARCHAR(120)',null,null)
;

-- 26/03/2022, 7:10:54 p. m. GMT+01:00
UPDATE AD_Column SET FieldLength=3,Updated=TO_TIMESTAMP('2022-03-26 19:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12926
;

-- 26/03/2022, 7:31:00 p. m. GMT+01:00
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-03-26 19:31:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6008
;

-- 26/03/2022, 7:31:10 p. m. GMT+01:00
INSERT INTO t_alter_column values('pa_reportcolumn','Name','VARCHAR(255)',null,null)
;

-- 26/03/2022, 7:37:32 p. m. GMT+01:00
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-03-26 19:37:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6054
;

-- 26/03/2022, 7:37:37 p. m. GMT+01:00
INSERT INTO t_alter_column values('pa_reportline','Name','VARCHAR(255)',null,null)
;

