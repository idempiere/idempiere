-- Sep 11, 2012 8:42:54 PM IST
-- Adding i18n messages
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Invoice Processed: ',200060,'U','3c06a457-be2c-4e54-a197-ac5b5646143f','InvoiceProcessed','Y',TO_TIMESTAMP('2012-09-11 20:42:53','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-11 20:42:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2012 8:42:55 PM IST
-- Adding i18n messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200060 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 11, 2012 8:49:40 PM IST
-- Adding i18n messages
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Payment Allocated: ',200061,'U','2d9d4e87-b308-4643-9046-a2730a95cb9b','PaymentAllocated','Y',TO_TIMESTAMP('2012-09-11 20:49:39','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-11 20:49:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2012 8:49:40 PM IST
-- Adding i18n messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200061 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 11, 2012 8:52:47 PM IST
-- Adding i18n messages
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Allocation Processed: ',200062,'U','5e6e24fc-a609-4424-9aa4-f30f13fa03ac','AllocationProcessed','Y',TO_TIMESTAMP('2012-09-11 20:52:46','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-11 20:52:46','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2012 8:52:47 PM IST
-- Adding i18n messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200062 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 11, 2012 8:54:59 PM IST
-- Adding i18n messages
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Shipment Processed: ',200063,'U','1de82564-7da4-468e-955d-7451a304844d','ShipmentProcessed','Y',TO_TIMESTAMP('2012-09-11 20:54:58','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-11 20:54:58','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2012 8:54:59 PM IST
-- Adding i18n messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200063 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 11, 2012 9:00:52 PM IST
-- Adding i18n messages
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Order Created: ',200064,'U','0e54bec9-9529-4ac8-b453-b36b201b5149','OrderCreated','Y',TO_TIMESTAMP('2012-09-11 21:00:51','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-11 21:00:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2012 9:00:52 PM IST
-- Adding i18n messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200064 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 11, 2012 9:05:34 PM IST
-- Adding i18n messages
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Generated PO: ',200065,'U','f0135f4a-27e6-499c-9c7e-851631a10a4f','GeneratedPO','Y',TO_TIMESTAMP('2012-09-11 21:05:33','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-11 21:05:33','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2012 9:05:34 PM IST
-- Adding i18n messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200065 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('908_Process_Message.sql') FROM dual
;