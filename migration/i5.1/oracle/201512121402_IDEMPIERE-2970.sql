SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2970 Display URL in the Record info panel
-- Dec 12, 2015 2:00:57 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Permalink',0,0,'Y',TO_DATE('2015-12-12 14:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-12-12 14:00:57','YYYY-MM-DD HH24:MI:SS'),100,200369,'Permalink','D','df044d1d-59d8-4d56-85ef-66c459cf45ea')
;

-- Dec 12, 2015 2:02:04 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Right click and copy link for a permanent link to this record.',0,0,'Y',TO_DATE('2015-12-12 14:02:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-12-12 14:02:03','YYYY-MM-DD HH24:MI:SS'),100,200370,'Permalink_tooltip','D','cec80265-768c-495c-be62-1a321d356c3c')
;

SELECT register_migration_script('201512121402_IDEMPIERE-2970.sql') FROM dual
;

