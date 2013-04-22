-- Apr 4, 2013 10:56:47 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Switch Time Zone',200159,'D','8539c2e0-cd62-4370-9ae2-0feec520d6ef','SwitchTimeZone','Y',TO_TIMESTAMP('2013-04-04 10:56:46','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 10:56:46','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 10:56:47 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200159 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 10:57:12 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Monday',200160,'D','9f4120cb-22aa-4f16-9e86-1a27cb66b820','Monday','Y',TO_TIMESTAMP('2013-04-04 10:57:11','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 10:57:11','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 10:57:12 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200160 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:02:30 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Tuesday',200161,'D','8acbe969-a354-4772-89ce-9ba0ead46a2b','Tuesday','Y',TO_TIMESTAMP('2013-04-04 11:02:29','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:02:29','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:02:30 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200161 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:02:50 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Wednesday',200162,'D','209709d6-bb75-4a20-8e69-e5e93d95ef7f','Wednesday','Y',TO_TIMESTAMP('2013-04-04 11:02:50','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:02:50','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:02:50 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200162 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:03:14 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Thursday',200163,'D','11fcd2a1-9512-4517-8d20-aa3bfc0b198f','Thursday','Y',TO_TIMESTAMP('2013-04-04 11:03:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:03:13','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:03:14 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200163 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:03:35 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Friday',200164,'D','2024cad8-556d-481e-8aae-ed4681187f87','Friday','Y',TO_TIMESTAMP('2013-04-04 11:03:34','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:03:34','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:03:35 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200164 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:03:58 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Saturday',200165,'D','bab8bdc5-a283-4173-9385-9dc2de4044ae','Saturday','Y',TO_TIMESTAMP('2013-04-04 11:03:57','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:03:57','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:03:58 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200165 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:04:16 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Sunday',200166,'D','a586e26e-9daf-4aff-8a53-973bd95817ce','Sunday','Y',TO_TIMESTAMP('2013-04-04 11:04:16','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:04:16','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:04:16 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200166 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:04:39 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','5 Days',200167,'D','7b5a1228-284b-47c1-a3c0-bb1899b8cd60','5Days','Y',TO_TIMESTAMP('2013-04-04 11:04:38','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:04:38','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:04:39 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200167 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:04:59 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Events Analysis',200168,'D','730ed6ed-ba76-4b8c-8d13-7ab27f8ad603','EventsAnalysis','Y',TO_TIMESTAMP('2013-04-04 11:04:58','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:04:58','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:04:59 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200168 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Apr 4, 2013 11:05:27 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','First Day of Week',200169,'D','98506145-5a38-4cf2-bde0-11cbff6a4ced','FirstDayofWeek','Y',TO_TIMESTAMP('2013-04-04 11:05:26','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-04 11:05:26','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 4, 2013 11:05:27 AM COT
-- IDEMPIERE-788 , Translation support for dashboard calendar
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200169 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201304041108_IDEMPIERE-788.sql') FROM dual
;

