SET CLIENT_ENCODING TO 'UTF8';

-- May 13, 2011 4:56:03 PM COT
-- Some new iDempiere messages
INSERT INTO AD_Message (IsActive,Updated,CreatedBy,MsgType,MsgText,UpdatedBy,AD_Message_ID,EntityType,AD_Message_UU,AD_Client_ID,AD_Org_ID,Created,Value) VALUES ('Y',TO_TIMESTAMP('2011-05-13 16:56:02','YYYY-MM-DD HH24:MI:SS'),100,'I','Save and Create New',100,53133,'D','70352996-ba6c-4f0e-861f-17507c3bb323',0,0,TO_TIMESTAMP('2011-05-13 16:56:02','YYYY-MM-DD HH24:MI:SS'),'SaveCreate')
;

-- May 13, 2011 4:56:03 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=53133 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- May 13, 2011 4:56:59 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='Guardar cambios y crear nuevo',Updated=TO_TIMESTAMP('2011-05-13 16:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53133 AND AD_Language LIKE 'es_%'
;

-- May 13, 2011 4:57:59 PM COT
INSERT INTO AD_Message (IsActive,Updated,CreatedBy,MsgType,MsgText,UpdatedBy,AD_Message_ID,EntityType,AD_Message_UU,AD_Client_ID,AD_Org_ID,Created,Value) VALUES ('Y',TO_TIMESTAMP('2011-05-13 16:57:59','YYYY-MM-DD HH24:MI:SS'),100,'I','zip - 2Pack zip file',100,53134,'D','d749b4aa-3402-49b2-a079-408523aebb83',0,0,TO_TIMESTAMP('2011-05-13 16:57:59','YYYY-MM-DD HH24:MI:SS'),'File2PackZip')
;

-- May 13, 2011 4:58:00 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=53134 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- May 13, 2011 4:58:15 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='zip - Archivo zip 2Pack',Updated=TO_TIMESTAMP('2011-05-13 16:58:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53134 AND AD_Language LIKE 'es_%'
;

-- May 13, 2011 5:06:55 PM COT
INSERT INTO AD_Message (IsActive,Updated,CreatedBy,MsgType,MsgText,UpdatedBy,AD_Message_ID,EntityType,AD_Message_UU,AD_Client_ID,AD_Org_ID,Created,Value) VALUES ('Y',TO_TIMESTAMP('2011-05-13 17:06:54','YYYY-MM-DD HH24:MI:SS'),100,'I','Export current row only?',100,53135,'D','9c5d847e-1d48-4238-826f-987f9d211f7d',0,0,TO_TIMESTAMP('2011-05-13 17:06:54','YYYY-MM-DD HH24:MI:SS'),'ExportCurrentRowOnly')
;

-- May 13, 2011 5:06:55 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=53135 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- May 13, 2011 5:07:47 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='¿Exportar sólo la fila actual?',Updated=TO_TIMESTAMP('2011-05-13 17:07:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53135 AND AD_Language LIKE 'es_%'
;

