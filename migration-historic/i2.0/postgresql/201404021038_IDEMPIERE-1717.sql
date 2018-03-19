-- Apr 2, 2014 10:27:03 AM COT
-- IDEMPIERE-1717 Maintenance mode
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Updated,Created,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200052,'C','N','Define if the system is in manteinance mode.  Y = just advanced roles can log in    /   N = normal operation mode','636b9278-5633-4f92-9180-a2eb4f0674b1',TO_TIMESTAMP('2014-04-02 10:27:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-04-02 10:27:02','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'SYSTEM_IN_MAINTENANCE_MODE',0,'D')
;

-- Apr 2, 2014 10:39:33 AM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('E','System is in maintenance mode, please wait until the access is restored.',200268,'D','bc45a082-4784-46a8-b5a5-14874ed5ee69','SystemInMaintenance','Y',TO_TIMESTAMP('2014-04-02 10:39:32','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2014-04-02 10:39:32','YYYY-MM-DD HH24:MI:SS'),0,0)
;

SELECT register_migration_script('201404021038_IDEMPIERE-1717.sql') FROM dual
;

