SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 12, 2014 9:51:40 PM COT
-- IDEMPIERE-1150 Status Line window
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','Quick Info',200251,'D','4aa59d81-e275-407b-9bdf-d8017d03c791','QuickInfo','Y',TO_DATE('2014-01-12 21:51:39','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-01-12 21:51:39','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jan 13, 2014 8:31:22 AM COT
UPDATE AD_Column SET DefaultValue='U',Updated=TO_DATE('2014-01-13 08:31:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210904
;

-- Jan 13, 2014 8:31:24 AM COT
ALTER TABLE AD_StatusLine MODIFY EntityType VARCHAR2(40) DEFAULT 'U'
;

SELECT register_migration_script('201401122152_IDEMPIERE-1684_QuickInfoWidget.sql') FROM dual
;

