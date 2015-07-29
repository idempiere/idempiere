SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2658 - Show bpartner name instead of user name in description of allocations generated from Payment Allocation
-- Jul 29, 2015 4:16:23 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200064,0,0,TO_DATE('2015-07-29 16:16:22','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2015-07-29 16:16:22','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ALLOCATION_DESCRIPTION','@#AD_User_Name@','Description of allocation generated through the Allocation (manual) form','D','C','3a12099d-4449-43ee-b8b2-5738a7c96d94')
;

SELECT register_migration_script('201507291615_IDEMPIERE-2658.sql') FROM dual
;
