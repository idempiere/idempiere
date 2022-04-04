-- IDEMPIERE-5093 cheduler cron pattern scheduling is always using server time zone
SELECT register_migration_script('202204041140_IDEMPIERE-5093.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 4, 2022, 11:40:38 AM MYT
UPDATE AD_Element SET Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html
If set, the time zone from tenant info is used. Otherwise, use the default JVM time zone at the server.',Updated=TO_TIMESTAMP('2022-04-04 11:40:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54124
;

-- Apr 4, 2022, 11:40:38 AM MYT
UPDATE AD_Column SET ColumnName='CronPattern', Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html
If set, the time zone from tenant info is used. Otherwise, use the default JVM time zone at the server.', Placeholder=NULL WHERE AD_Element_ID=54124
;

-- Apr 4, 2022, 11:40:38 AM MYT
UPDATE AD_Process_Para SET ColumnName='CronPattern', Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html
If set, the time zone from tenant info is used. Otherwise, use the default JVM time zone at the server.', AD_Element_ID=54124 WHERE UPPER(ColumnName)='CRONPATTERN' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 4, 2022, 11:40:38 AM MYT
UPDATE AD_Process_Para SET ColumnName='CronPattern', Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html
If set, the time zone from tenant info is used. Otherwise, use the default JVM time zone at the server.', Placeholder=NULL WHERE AD_Element_ID=54124 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2022, 11:40:38 AM MYT
UPDATE AD_InfoColumn SET ColumnName='CronPattern', Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html
If set, the time zone from tenant info is used. Otherwise, use the default JVM time zone at the server.', Placeholder=NULL WHERE AD_Element_ID=54124 AND IsCentrallyMaintained='Y'
;

-- Apr 4, 2022, 11:40:38 AM MYT
UPDATE AD_Field SET Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html
If set, the time zone from tenant info is used. Otherwise, use the default JVM time zone at the server.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=54124) AND IsCentrallyMaintained='Y'
;

