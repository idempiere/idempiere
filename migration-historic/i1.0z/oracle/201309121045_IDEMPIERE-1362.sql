SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 11, 2013 1:51:57 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsShowinLogin',202569,'IsShowinLogin','Show Login','2ab0a775-6946-4c57-9d54-cdf2a570521a',TO_DATE('2013-07-11 13:51:56','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-07-11 13:51:56','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 11, 2013 1:51:58 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202569 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 11, 2013 1:53:24 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,50010,210650,'N','N','N',0,'N',1,'N',20,'N','N','Y','070bb901-b89f-4336-bcb7-e824928d4af7','Y','IsShowinLogin','Y','IsShowinLogin','Y',TO_DATE('2013-07-11 13:53:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-07-11 13:53:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202569)
;

-- Jul 11, 2013 1:53:24 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210650 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 11, 2013 1:53:38 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
ALTER TABLE PA_DashboardContent ADD IsShowinLogin CHAR(1) DEFAULT 'Y' CHECK (IsShowinLogin IN ('Y','N'))
;

-- Jul 11, 2013 1:55:06 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',50010,1,'N','N',210650,210,'Y',202286,'N','D','IsShowinLogin','627c465f-3add-4a1e-afb4-781306a787c6','Y','N',100,0,TO_DATE('2013-07-11 13:55:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-07-11 13:55:05','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Jul 11, 2013 1:55:06 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202286 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 19, 2013 12:50:35 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Manage Gadgets',200211,'D','662b6b4e-185e-473d-a965-25d189d273df','ManageGadgets','Y',TO_DATE('2013-07-19 12:50:33','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-07-19 12:50:33','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 19, 2013 12:50:35 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200211 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 19, 2013 12:51:03 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Dashboard Gadgets',200212,'D','9f80d414-3ab4-4227-90cc-bc2662c59907','DashboardGadgets','Y',TO_DATE('2013-07-19 12:51:03','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-07-19 12:51:03','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 19, 2013 12:51:03 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200212 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 19, 2013 12:52:45 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Show',200215,'D','869943ba-5623-4fc6-b43b-dfa73435aa9c','Show','Y',TO_DATE('2013-07-19 12:52:44','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-07-19 12:52:44','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 19, 2013 12:52:45 PM COT
-- Ticket #1002633: Feature Request: Implement button to register/unregister available dashboard content
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200215 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201309121045_IDEMPIERE-1362.sql') FROM dual
;

