SET SQLBLANKLINES ON
SET DEFINE OFF

-- Ticket #1005382: Requests are showing up on the wrong person's calendar
-- Nov 27, 2015 4:26:07 PM SGT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200074,0,0,TO_DATE('2015-11-27 16:26:05','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2015-11-27 16:26:05','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DASHBOARD_CALENDAR_REQUEST_DISPLAY_MODE','CSU','C - Created by of the request is the logged in user; S - Sales Rep of the request is the logged in user; U - User/Contact of the request is the logged in user','D','C','f134d1ed-4101-4582-a3b3-0d2bf5c3577c')
;

SELECT register_migration_script('201511271630_IDEMPIERE-2973_1005382.sql') FROM dual
;
