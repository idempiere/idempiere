SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 16, 2014 11:33:27 AM ICT
-- IDEMPIERE-1693 In InfoProductWindow, tab "Available to Promise" can change by change level of log. Should make a checkbox for it.
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','Show detail','Show detail locator info in "Available to promise" tab',200252,'D','693d3147-e09b-4e69-9ada-23ff6c1289fc','showDetailAtp','Y',TO_DATE('2014-01-16 11:33:27','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-01-16 11:33:27','YYYY-MM-DD HH24:MI:SS'),0,0)
;


SELECT register_migration_script('201401161604_IDEMPIERE-1693.sql') FROM dual
;
