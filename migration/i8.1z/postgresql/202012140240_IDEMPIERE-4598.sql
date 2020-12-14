-- Dec 14, 2020, 10:18:10 AM MYT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', SeqNoGrid=0, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-12-14 10:18:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12100
;

-- Dec 14, 2020, 10:19:05 AM MYT
UPDATE AD_Column SET IsMandatory='N', IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2020-12-14 10:19:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14084
;

-- Dec 14, 2020, 10:19:12 AM MYT
INSERT INTO t_alter_column values('ad_process','IsServerProcess','CHAR(1)',null,'NULL')
;

-- Dec 14, 2020, 10:19:12 AM MYT
INSERT INTO t_alter_column values('ad_process','IsServerProcess',null,'NULL',null)
;

-- Dec 14, 2020, 10:19:37 AM MYT
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2020-12-14 10:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14084
;

-- Dec 14, 2020, 10:21:10 AM MYT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', SeqNoGrid=0, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-12-14 10:21:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12099
;

-- Dec 14, 2020, 10:21:26 AM MYT
UPDATE AD_Column SET IsMandatory='N', IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2020-12-14 10:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14085
;

-- Dec 14, 2020, 10:21:29 AM MYT
INSERT INTO t_alter_column values('ad_client','IsServerEMail','CHAR(1)',null,'NULL')
;

-- Dec 14, 2020, 10:21:29 AM MYT
INSERT INTO t_alter_column values('ad_client','IsServerEMail',null,'NULL',null)
;

-- Dec 14, 2020, 10:21:34 AM MYT
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2020-12-14 10:21:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14085
;

-- Dec 14, 2020, 10:22:16 AM MYT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', SeqNoGrid=0, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-12-14 10:22:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12105
;

-- Dec 14, 2020, 10:22:28 AM MYT
UPDATE AD_Column SET IsMandatory='N', IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2020-12-14 10:22:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14090
;

-- Dec 14, 2020, 10:22:31 AM MYT
INSERT INTO t_alter_column values('ad_task','IsServerProcess','CHAR(1)',null,'N')
;

-- Dec 14, 2020, 10:22:31 AM MYT
INSERT INTO t_alter_column values('ad_task','IsServerProcess',null,'NULL',null)
;

-- Dec 14, 2020, 10:22:36 AM MYT
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2020-12-14 10:22:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14090
;

SELECT register_migration_script('202012140240_IDEMPIERE-4598.sql') FROM dual
;

