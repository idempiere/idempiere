-- Oct 23, 2012 2:03:20 PM COT
-- IDEMPIERE-466 AD_Client.RequestUserPW too short
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2012-10-23 14:03:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6560
;

-- Oct 23, 2012 2:03:23 PM COT
-- IDEMPIERE-466 AD_Client.RequestUserPW too short
INSERT INTO t_alter_column values('ad_client','RequestUserPW','VARCHAR(255)',null,'NULL')
;

SELECT register_migration_script('943_IDEMPIERE-466.sql') FROM dual
;

