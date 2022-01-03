SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5069 Completion of Shipment for Close Order produce inconsistent order line data
-- Dec 6, 2021, 1:06:27 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Shipment/Material Receipt is in progress','Please process all shipment/material receipt documents for an order before closing it',0,0,'Y',TO_DATE('2021-12-06 13:06:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-12-06 13:06:26','YYYY-MM-DD HH24:MI:SS'),100,200722,'MInOutInProgress','D','c4e61fb0-1ac6-4a51-bb83-1435ce66bf4f')
;

-- Dec 6, 2021, 1:14:37 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Order has been closed','You can not ship or receive on a closed order',0,0,'Y',TO_DATE('2021-12-06 13:14:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-12-06 13:14:36','YYYY-MM-DD HH24:MI:SS'),100,200723,'OrderClosed','D','13f415ff-8347-4751-8480-f7165ace0a63')
;

-- Dec 6, 2021, 4:14:25 PM MYT
UPDATE AD_Message SET MsgText='Order has been closed.', MsgTip=NULL,Updated=TO_DATE('2021-12-06 16:14:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200723
;

-- Dec 6, 2021, 4:14:32 PM MYT
UPDATE AD_Message SET MsgText='Shipment/Material Receipt is in progress.', MsgTip=NULL,Updated=TO_DATE('2021-12-06 16:14:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200722
;

SELECT register_migration_script('202112060845_IDEMPIERE-5069.sql') FROM dual
;

