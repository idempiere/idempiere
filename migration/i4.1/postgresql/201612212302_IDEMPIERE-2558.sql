-- IDEMPIERE-2558 don't allow use old password when change password
-- Dec 21, 2016 11:01:23 PM CET
UPDATE AD_Table SET AccessLevel='7',LoadSeq=85,Updated=TO_TIMESTAMP('2016-12-21 23:01:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200171
;

-- Dec 21, 2016 11:34:17 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2016-12-21 23:34:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212106
;

-- Dec 21, 2016 11:34:21 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2016-12-21 23:34:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212107
;

-- Dec 21, 2016 11:34:49 PM CET
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2016-12-21 23:34:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212113
;

-- Dec 21, 2016 11:35:19 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2016-12-21 23:35:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212114
;

-- Dec 21, 2016 11:35:27 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2016-12-21 23:35:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212115
;

-- Dec 21, 2016 11:35:46 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2016-12-21 23:35:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212118
;

-- Dec 21, 2016 11:36:15 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2016-12-21 23:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212116
;

-- Dec 21, 2016 11:36:31 PM CET
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2016-12-21 23:36:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212117
;

-- Dec 21, 2016 11:37:15 PM CET
INSERT INTO t_alter_column values('ad_password_history','AD_Client_ID','NUMERIC(10)',null,null)
;

-- Dec 21, 2016 11:37:15 PM CET
INSERT INTO t_alter_column values('ad_password_history','AD_Client_ID',null,'NOT NULL',null)
;

-- Dec 21, 2016 11:37:15 PM CET
ALTER TABLE AD_Password_History ADD CONSTRAINT ADClient_ADPasswordHistory FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 21, 2016 11:38:06 PM CET
INSERT INTO t_alter_column values('ad_password_history','AD_Org_ID','NUMERIC(10)',null,null)
;

-- Dec 21, 2016 11:38:06 PM CET
INSERT INTO t_alter_column values('ad_password_history','AD_Org_ID',null,'NOT NULL',null)
;

-- Dec 21, 2016 11:38:06 PM CET
ALTER TABLE AD_Password_History ADD CONSTRAINT ADOrg_ADPasswordHistory FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 21, 2016 11:38:18 PM CET
INSERT INTO t_alter_column values('ad_password_history','Created','TIMESTAMP',null,'statement_timestamp()')
;

-- Dec 21, 2016 11:38:18 PM CET
UPDATE AD_Password_History SET Created=statement_timestamp() WHERE Created IS NULL
;

-- Dec 21, 2016 11:38:18 PM CET
INSERT INTO t_alter_column values('ad_password_history','Created',null,'NOT NULL',null)
;

-- Dec 21, 2016 11:38:24 PM CET
INSERT INTO t_alter_column values('ad_password_history','CreatedBy','NUMERIC(10)',null,null)
;

-- Dec 21, 2016 11:38:24 PM CET
INSERT INTO t_alter_column values('ad_password_history','CreatedBy',null,'NOT NULL',null)
;

-- Dec 21, 2016 11:38:31 PM CET
INSERT INTO t_alter_column values('ad_password_history','IsActive','CHAR(1)',null,'Y')
;

-- Dec 21, 2016 11:38:31 PM CET
UPDATE AD_Password_History SET IsActive='Y' WHERE IsActive IS NULL
;

-- Dec 21, 2016 11:38:31 PM CET
INSERT INTO t_alter_column values('ad_password_history','IsActive',null,'NOT NULL',null)
;

-- Dec 21, 2016 11:38:38 PM CET
INSERT INTO t_alter_column values('ad_password_history','Updated','TIMESTAMP',null,'statement_timestamp()')
;

-- Dec 21, 2016 11:38:38 PM CET
UPDATE AD_Password_History SET Updated=statement_timestamp() WHERE Updated IS NULL
;

-- Dec 21, 2016 11:38:38 PM CET
INSERT INTO t_alter_column values('ad_password_history','Updated',null,'NOT NULL',null)
;

-- Dec 21, 2016 11:38:43 PM CET
INSERT INTO t_alter_column values('ad_password_history','UpdatedBy','NUMERIC(10)',null,null)
;

-- Dec 21, 2016 11:38:43 PM CET
INSERT INTO t_alter_column values('ad_password_history','UpdatedBy',null,'NOT NULL',null)
;

SELECT register_migration_script('201612212302_IDEMPIERE-2558.sql') FROM dual
;

