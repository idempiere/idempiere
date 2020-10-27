SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4510 Search in the toolbar improvement to work out of the box
-- Oct 27, 2020, 2:30:55 PM CET
UPDATE AD_Message SET MsgText='Select Query', Value='SelectQuery',Updated=TO_DATE('2020-10-27 14:30:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53005
;

SELECT register_migration_script('202010271430_IDEMPIERE-4510.sql') FROM dual
;
