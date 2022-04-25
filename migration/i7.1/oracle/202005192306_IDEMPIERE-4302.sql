SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4302 Improve Schedule discovery
-- May 19, 2020, 11:04:59 PM CEST
UPDATE AD_Column SET Description='Run only on this IP address', Help='This is a list of semicolon (;) separated IP addresses or hostnames, if empty or 0.0.0.0 means the schedule can run in all servers.',Updated=TO_DATE('2020-05-19 23:04:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200486
;

SELECT register_migration_script('202005192306_IDEMPIERE-4302.sql') FROM dual
;

