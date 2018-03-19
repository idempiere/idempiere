-- Nov 27, 2013 10:35:14 AM IST
-- IDEMPIERE-1572: Last Run and Saved parameter for process
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,EntityType,IsEncrypted,AD_Element_ID,AD_Client_ID,IsSecure) VALUES (0,'N',0,282,210890,'N','N','Y',0,'N',60,'Y',10,'N','N','Y','4f66cceb-27a2-47b8-a1ef-0bc2882bfdef','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_TIMESTAMP('2013-11-27 10:35:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-11-27 10:35:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N','D','N',469,0,'N')
;

-- Nov 27, 2013 10:35:20 AM IST
-- IDEMPIERE-1572: Last Run and Saved parameter for process
ALTER TABLE AD_PInstance ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

-- Nov 27, 2013 10:36:46 AM IST
-- IDEMPIERE-1572: Last Run and Saved parameter for process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Last Run',200240,'D','fd39a4cd-eb0a-4b35-97ae-cbd4657d8234','LastRun','Y',TO_TIMESTAMP('2013-11-27 10:36:45','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-11-27 10:36:45','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 27, 2013 10:37:01 AM IST
-- IDEMPIERE-1572: Last Run and Saved parameter for process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Saved Parameters',200241,'D','f1688973-03c3-4af4-9b76-a0cec366ec41','SavedParameter','Y',TO_TIMESTAMP('2013-11-27 10:37:00','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-11-27 10:37:00','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 27, 2013 10:47:53 AM IST
-- IDEMPIERE-1572: Last Run and Saved parameter for process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Could not save parameters.',200242,'D','d07376af-ab08-4835-a962-9f5addc8dedc','SaveParameterError','Y',TO_TIMESTAMP('2013-11-27 10:47:52','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-11-27 10:47:52','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Mar 28, 2014 12:23:30 PM IST
-- IDEMPIERE-1572: Last Run and Saved parameter for process
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Created,Updated,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200046,'C','5','9b2426cb-b513-4199-b835-016cbc34a24f',TO_TIMESTAMP('2014-03-28 12:23:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-03-28 12:23:23','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'LASTRUN_RECORD_COUNT',0,'D')
;

SELECT register_migration_script('201404040826_IDEMPIERE-1572.sql') FROM dual
;
