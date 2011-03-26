SET CLIENT_ENCODING TO 'UTF8';

-- Dec 31, 2010 12:43:26 PM COT
-- Disallow Negative Inventory - configurable per warehouse
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,53132,0,TO_TIMESTAMP('2010-12-31 12:43:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Negative inventory disallowed in this warehouse','E',TO_TIMESTAMP('2010-12-31 12:43:23','YYYY-MM-DD HH24:MI:SS'),100,'NegativeInventoryDisallowed')
;

-- Dec 31, 2010 12:43:26 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=53132 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Dec 31, 2010 12:44:35 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='No se permite inventario negativo en este almacén',Updated=TO_TIMESTAMP('2010-12-31 12:44:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53132 AND AD_Language LIKE 'es_%'
;

