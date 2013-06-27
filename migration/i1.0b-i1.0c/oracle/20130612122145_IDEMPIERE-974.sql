-- Jun 12, 2013 12:21:45 PM COT
-- IDEMPIERE-974 Issue with Quick Entry editor when a checkbox is added and a new record is created
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Fill Minimum Information of:',200180,'D','03c360e6-3cdb-4058-818f-260e3aeff485','FillMinimumlInfo','Y',TO_DATE('2013-06-12 12:21:42','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-06-12 12:21:42','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jun 12, 2013 12:21:45 PM COT
-- IDEMPIERE-974 Issue with Quick Entry editor when a checkbox is added and a new record is created
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200180 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('20130612122145_IDEMPIERE-974.sql') FROM dual
;
