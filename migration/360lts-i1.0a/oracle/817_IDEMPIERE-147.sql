-- Feb 11, 2012 12:12:21 PM COT
-- IDEMPIERE-147 GoogleMap to show Locators
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200004,'D','S','LOCATION_MAPS_URL_PREFIX','http://local.google.com/maps?q=','URL to indicate the preferred maps service',0,0,TO_DATE('2012-02-11 12:12:19','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-11 12:12:19','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Feb 11, 2012 12:13:04 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200005,'D','S','LOCATION_MAPS_ROUTE_PREFIX','http://maps.google.com/maps?f=d&geocode=','URL to indicate the preferred maps routing service',0,0,TO_DATE('2012-02-11 12:13:03','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-11 12:13:03','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Feb 11, 2012 12:13:50 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200006,'D','S','LOCATION_MAPS_SOURCE_ADDRESS','&saddr=','Prefix for source address used by the preferred maps routing service',0,0,TO_DATE('2012-02-11 12:13:49','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-11 12:13:49','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Feb 11, 2012 12:14:07 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200007,'D','S','LOCATION_MAPS_DESTINATION_ADDRESS','&daddr=','Prefix for destination address used by the preferred maps routing service',0,0,TO_DATE('2012-02-11 12:14:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-11 12:14:07','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Feb 11, 2012 12:14:42 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,Value,IsActive,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,Created,UpdatedBy) VALUES ('I','Map',200001,'D','Map','Y',TO_DATE('2012-02-11 12:14:41','YYYY-MM-DD HH24:MI:SS'),0,0,100,TO_DATE('2012-02-11 12:14:41','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 11, 2012 12:14:42 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 11, 2012 12:14:50 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='Mapa',Updated=TO_DATE('2012-02-11 12:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200001 AND AD_Language LIKE 'es%'
;

-- Feb 11, 2012 12:15:06 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,Value,IsActive,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,Created,UpdatedBy) VALUES ('I','Route',200002,'D','Route','Y',TO_DATE('2012-02-11 12:15:05','YYYY-MM-DD HH24:MI:SS'),0,0,100,TO_DATE('2012-02-11 12:15:05','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 11, 2012 12:15:06 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200002 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 11, 2012 12:15:12 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='Ruta',Updated=TO_DATE('2012-02-11 12:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200002 AND AD_Language LIKE 'es%'
;

UPDATE AD_System
  SET LastMigrationScriptApplied='817_IDEMPIERE-147.sql'
WHERE LastMigrationScriptApplied<'817_IDEMPIERE-147.sql'
   OR LastMigrationScriptApplied IS NULL
;
