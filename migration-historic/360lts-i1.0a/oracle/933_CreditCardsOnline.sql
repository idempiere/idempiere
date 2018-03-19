-- Oct 12, 2012 2:47:39 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,335,200604,'U','N','N','N',0,'N',10,'N',19,'N','N',1385,'N','Y','56df3d84-fc69-4921-b0cf-6868235d0caf','N','Y','N','C_PaymentProcessor_ID','Payment processor for electronic payments','The Payment Processor indicates the processor to be used for electronic payments','Payment Processor','Y',100,TO_DATE('2012-10-12 14:47:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:47:37','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:47:39 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200604 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:47:53 PM SGT
-- Credit Cards Online
ALTER TABLE C_Payment ADD C_PaymentProcessor_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 12, 2012 2:48:34 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('CustomerPaymentProfileID',200177,'U','Customer Payment Profile ID','Customer Payment Profile ID','53b868ea-9905-4911-97bb-cd10bdfca500',0,TO_DATE('2012-10-12 14:48:33','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-12 14:48:33','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 12, 2012 2:48:34 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200177 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 12, 2012 2:50:09 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,335,200605,'U','N','N','N',0,'N',60,'N',10,'N','N',200177,'N','Y','dbc4a09c-16e9-4c00-b721-48835ab4fed0','N','Y','N','CustomerPaymentProfileID','Customer Payment Profile ID','Y',100,TO_DATE('2012-10-12 14:50:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:50:08','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:50:09 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200605 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:50:21 PM SGT
-- Credit Cards Online
ALTER TABLE C_Payment ADD CustomerPaymentProfileID NVARCHAR2(60) DEFAULT NULL 
;

-- Oct 12, 2012 2:50:46 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('CustomerProfileID',200178,'U','Customer Profile ID','Customer Profile ID','b2c5fc6c-b123-4100-bd66-d18efad21c84',0,TO_DATE('2012-10-12 14:50:46','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-12 14:50:46','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 12, 2012 2:50:46 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200178 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 12, 2012 2:51:04 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,335,200606,'U','N','N','N',0,'N',60,'N',10,'N','N',200178,'N','Y','7ea69556-9beb-4451-a36b-0bd325807608','N','Y','N','CustomerProfileID','Customer Profile ID','Y',100,TO_DATE('2012-10-12 14:51:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:51:04','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:51:05 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200606 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:51:09 PM SGT
-- Credit Cards Online
ALTER TABLE C_Payment ADD CustomerProfileID NVARCHAR2(60) DEFAULT NULL 
;

-- Oct 12, 2012 2:51:32 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('CustomerAddressID',200179,'U','Customer Address ID','Customer Address ID','97af8b7f-e95d-4909-a8f8-ce802a36a394',0,TO_DATE('2012-10-12 14:51:31','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-12 14:51:31','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 12, 2012 2:51:32 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200179 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 12, 2012 2:51:48 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,335,200607,'U','N','N','N',0,'N',60,'N',10,'N','N',200179,'N','Y','4877fa01-0d5b-4770-aab2-d5351c506aae','N','Y','N','CustomerAddressID','Customer Address ID','Y',100,TO_DATE('2012-10-12 14:51:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:51:47','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:51:48 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200607 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:51:52 PM SGT
-- Credit Cards Online
ALTER TABLE C_Payment ADD CustomerAddressID NVARCHAR2(60) DEFAULT NULL 
;

-- Oct 12, 2012 2:52:51 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsVoided',200180,'U','Voided','Voided','a3270fc9-075e-4aea-a816-f3e2a8291e97',0,TO_DATE('2012-10-12 14:52:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-12 14:52:50','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 12, 2012 2:52:51 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200180 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 12, 2012 2:53:10 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,335,200608,'U','Y','N','N',0,'N',1,'N',20,'N','N',200180,'N','Y','4ae42f8f-d6f3-49c8-bfc2-4fa90449d6fd','N','Y','N','IsVoided','N','Voided','Y',100,TO_DATE('2012-10-12 14:53:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:53:09','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:53:10 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200608 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:53:14 PM SGT
-- Credit Cards Online
ALTER TABLE C_Payment ADD IsVoided CHAR(1) DEFAULT 'N' CHECK (IsVoided IN ('Y','N')) NOT NULL
;

-- Oct 12, 2012 2:53:42 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('R_VoidMsg',200181,'U','Void Message','Void Message','540fe118-8e5a-4491-82ec-83da12bfb31e',0,TO_DATE('2012-10-12 14:53:41','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-12 14:53:41','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 12, 2012 2:53:42 PM SGT
-- Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200181 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 12, 2012 2:53:52 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,335,200609,'U','N','N','N',0,'N',255,'N',14,'N','N',200181,'N','Y','fd9cb9e1-b792-4746-8403-464c6573a9d8','N','Y','N','R_VoidMsg','Void Message','Y',100,TO_DATE('2012-10-12 14:53:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:53:51','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:53:52 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200609 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:53:56 PM SGT
-- Credit Cards Online
ALTER TABLE C_Payment ADD R_VoidMsg NVARCHAR2(255) DEFAULT NULL 
;

-- Oct 12, 2012 2:54:27 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,298,200610,'U','N','N','N',0,'N',60,'N',10,'N','N',200177,'N','Y','cf44d48a-8bac-4f6c-9ec7-5855b0553c5d','N','Y','N','CustomerPaymentProfileID','Customer Payment Profile ID','Y',100,TO_DATE('2012-10-12 14:54:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:54:26','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:54:27 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200610 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:54:31 PM SGT
-- Credit Cards Online
ALTER TABLE C_BP_BankAccount ADD CustomerPaymentProfileID NVARCHAR2(60) DEFAULT NULL 
;

-- Oct 12, 2012 2:55:06 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,293,200611,'U','N','N','N',0,'N',60,'N',10,'N','N',200179,'N','Y','7dba45a0-88ec-4ed3-ba15-e0b9e9a7cb39','N','Y','N','CustomerAddressID','Customer Address ID','Y',100,TO_DATE('2012-10-12 14:55:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:55:05','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:55:06 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200611 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:55:12 PM SGT
-- Credit Cards Online
ALTER TABLE C_BPartner_Location ADD CustomerAddressID NVARCHAR2(60) DEFAULT NULL 
;

-- Oct 12, 2012 2:56:01 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,291,200612,'U','N','N','N',0,'N',60,'N',10,'N','N',200178,'N','Y','8dc700b3-493a-45f2-a0da-3ccabb91f6ea','N','Y','N','CustomerProfileID','Customer Profile ID','Y',100,TO_DATE('2012-10-12 14:56:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-12 14:56:00','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 12, 2012 2:56:01 PM SGT
-- Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200612 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 12, 2012 2:56:08 PM SGT
-- Credit Cards Online
ALTER TABLE C_BPartner ADD CustomerProfileID NVARCHAR2(60) DEFAULT NULL 
;

-- Oct 12, 2012 2:58:28 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',226,36,'N','N',60608,'Y',200616,'N','D','C_BP_BankAccount_UU','N','Y','f157b7ae-47ea-4c60-a688-7faed3dc4789',100,0,TO_DATE('2012-10-12 14:58:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 14:58:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 2:58:28 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200616 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 2:58:29 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',226,60,'N','N',200610,'Y',200617,'N','U','Customer Payment Profile ID','N','Y','d363ee5c-ddf1-4113-b56b-5d4d7f117631',100,0,TO_DATE('2012-10-12 14:58:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 14:58:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 2:58:29 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200617 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 2:58:36 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200616
;

-- Oct 12, 2012 2:58:36 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=200617
;

-- Oct 12, 2012 2:58:40 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200616
;

-- Oct 12, 2012 2:58:40 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=200617
;

-- Oct 12, 2012 2:58:53 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 14:58:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200617
;

-- Oct 12, 2012 2:59:15 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',222,36,'N','N',60606,'Y',200618,'N','D','C_BPartner_Location_UU','N','Y','d1bdc44f-81cc-4c85-be76-a9c3dbfeae03',100,0,TO_DATE('2012-10-12 14:59:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 14:59:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 2:59:15 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200618 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 2:59:15 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',222,60,'N','N',200611,'Y',200619,'N','U','Customer Address ID','N','Y','5ca1616f-7ff7-4122-80c1-8163a04bbabc',100,0,TO_DATE('2012-10-12 14:59:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 14:59:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 2:59:15 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200619 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200618
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=2613
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=2181
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=2182
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=2183
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=2190
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=2189
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=2185
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=2191
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=2192
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=2187
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=2188
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=2196
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=2193
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=2194
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=2195
;

-- Oct 12, 2012 2:59:22 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=2186
;

-- Oct 12, 2012 2:59:23 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200619
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200618
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2613
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2181
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=2182
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=2183
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=2190
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=2189
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=2185
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=2191
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=2192
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=2187
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=2188
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=2196
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=2193
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=2194
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=2195
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=2186
;

-- Oct 12, 2012 2:59:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200619
;

-- Oct 12, 2012 2:59:45 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 14:59:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200619
;

-- Oct 12, 2012 3:00:06 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',220,36,'N','N',60605,'Y',200620,'N','D','C_BPartner_UU','N','Y','bf715801-124c-4d74-9d33-76716e763e2f',100,0,TO_DATE('2012-10-12 15:00:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:00:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:00:07 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200620 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:00:07 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',220,60,'N','N',200612,'Y',200621,'N','U','Customer Profile ID','N','Y','7871a05d-2257-43bc-bace-3d75f6f6100e',100,0,TO_DATE('2012-10-12 15:00:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:00:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:00:07 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200621 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:00:08 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',220,1,'N','N',58596,'Y',200622,'N','D','Indicate role of this Business partner as Manufacturer','Is Manufacturer','N','Y','17515cc8-f7d9-4364-bce0-6f28c00a4b8d',100,0,TO_DATE('2012-10-12 15:00:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:00:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:00:08 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200622 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:00:20 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200620
;

-- Oct 12, 2012 3:00:20 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200622
;

-- Oct 12, 2012 3:00:20 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=200621
;

-- Oct 12, 2012 3:00:28 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200620
;

-- Oct 12, 2012 3:00:28 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200622
;

-- Oct 12, 2012 3:00:28 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=200621
;

-- Oct 12, 2012 3:00:41 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 15:00:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200621
;

-- Oct 12, 2012 3:01:02 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,36,'N','N',60721,'Y',200623,'N','D','C_Payment_UU','N','Y','60b37d1c-7202-4946-b378-739ebb09a12d',100,0,TO_DATE('2012-10-12 15:01:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:02 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200623 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:01:03 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,60,'N','N',200607,'Y',200624,'N','U','Customer Address ID','N','Y','331957e9-eb69-42e1-aaaf-b6bc50df09a4',100,0,TO_DATE('2012-10-12 15:01:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:03 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200624 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:01:04 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,60,'N','N',200605,'Y',200625,'N','U','Customer Payment Profile ID','N','Y','de578287-46c7-4500-8a1e-fb2944c7c972',100,0,TO_DATE('2012-10-12 15:01:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:04 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200625 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:01:05 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,60,'N','N',200606,'Y',200626,'N','U','Customer Profile ID','N','Y','9196e838-5fae-4e46-ace3-378dcb42bc24',100,0,TO_DATE('2012-10-12 15:01:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:05 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200626 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:01:06 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,10,'N','N',200604,'Y',200627,'N','The Payment Processor indicates the processor to be used for electronic payments','U','Payment processor for electronic payments','Payment Processor','N','Y','41f24066-99f9-4ba0-ac5a-b224666a90cb',100,0,TO_DATE('2012-10-12 15:01:05','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:05','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:06 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200627 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:01:06 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,20,'N','N',59039,'Y',200628,'N','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.','D','The date+time (expressed in decimal format) when the document has been processed','Processed On','N','Y','95c7ee21-c5ac-4ea9-a073-c6baba2be408',100,0,TO_DATE('2012-10-12 15:01:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:06 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200628 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:01:07 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,22,'N','N',55309,'Y',200629,'N','D','ID of document reversal','Reversal ID','N','Y','fcd3cf89-1bc2-474b-bbfe-13fc2fad4b1c',100,0,TO_DATE('2012-10-12 15:01:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:07 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200629 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:01:08 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,255,'N','N',200609,'Y',200630,'N','U','Void Message','N','Y','b26bb847-00cf-4154-9978-71a99704697c',100,0,TO_DATE('2012-10-12 15:01:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:08 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200630 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:01:09 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',330,1,'N','N',200608,'Y',200631,'N','U','Voided','N','Y','aa300b96-d887-451f-88f5-711949e592ca',100,0,TO_DATE('2012-10-12 15:01:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:01:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:01:09 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200631 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200623
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200628
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200629
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=680,IsDisplayed='Y' WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=690,IsDisplayed='Y' WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=700,IsDisplayed='Y' WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=710,IsDisplayed='Y' WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=720,IsDisplayed='Y' WHERE AD_Field_ID=200631
;

-- Oct 12, 2012 3:02:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=730,IsDisplayed='Y' WHERE AD_Field_ID=200630
;

-- Oct 12, 2012 3:02:19 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200623
;

-- Oct 12, 2012 3:02:19 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200628
;

-- Oct 12, 2012 3:02:19 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200629
;

-- Oct 12, 2012 3:02:19 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=670,IsDisplayedGrid='Y' WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:02:19 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=680,IsDisplayedGrid='Y' WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:02:20 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=690,IsDisplayedGrid='Y' WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:02:20 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=700,IsDisplayedGrid='Y' WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:02:20 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=710,IsDisplayedGrid='Y' WHERE AD_Field_ID=200631
;

-- Oct 12, 2012 3:02:20 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=720,IsDisplayedGrid='Y' WHERE AD_Field_ID=200630
;

-- Oct 12, 2012 3:02:28 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=680,IsDisplayed='Y' WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:02:28 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=690,IsDisplayed='Y' WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:02:28 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=700,IsDisplayed='Y' WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:02:28 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=710,IsDisplayed='Y' WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:03:12 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-12 15:03:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:03:17 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-12 15:03:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:03:27 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y', IsReadOnly='Y',Updated=TO_DATE('2012-10-12 15:03:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:03:35 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-12 15:03:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200630
;

-- Oct 12, 2012 3:03:53 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 15:03:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:03:55 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 15:03:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:03:56 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 15:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:03:58 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 15:03:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:04:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 15:04:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200631
;

-- Oct 12, 2012 3:04:10 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-12 15:04:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200630
;

-- Oct 12, 2012 3:04:13 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2012-10-12 15:04:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200631
;

-- Oct 12, 2012 3:04:17 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2012-10-12 15:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:04:51 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-12 15:04:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200621
;

-- Oct 12, 2012 3:06:54 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-12 15:06:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200617
;

-- Oct 12, 2012 3:07:01 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-12 15:07:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200619
;

-- Oct 12, 2012 3:34:34 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200621
;

-- Oct 12, 2012 3:34:40 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200621
;

-- Oct 12, 2012 3:34:47 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',223,36,'N','N',60605,'Y',200632,'N','D','C_BPartner_UU','N','Y','6d075331-9d18-4ab5-b87d-70a24ab357d2',100,0,TO_DATE('2012-10-12 15:34:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:34:46','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:34:47 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200632 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:34:48 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',223,60,'N','N',200612,'Y',200633,'N','U','Customer Profile ID','N','Y','ecccb306-359f-4744-adf1-23b119e7ac81',100,0,TO_DATE('2012-10-12 15:34:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:34:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:34:48 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200633 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:34:49 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',223,1,'N','N',58596,'Y',200634,'N','D','Indicate role of this Business partner as Manufacturer','Is Manufacturer','N','Y','2edc19d5-ff0b-4393-ab9b-07b1a23fa5cd',100,0,TO_DATE('2012-10-12 15:34:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:34:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:34:49 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200634 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:34:50 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',223,10,'N','N',58113,'Y',200635,'N','D','Logo','N','Y','10112b66-395c-49ab-b614-be4dfbeddaa8',100,0,TO_DATE('2012-10-12 15:34:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:34:49','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:34:50 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200635 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:34:51 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',223,1,'N','N',58381,'Y',200636,'N','If a business partner is exempt from tax on purchases, the exempt tax rate is used. For this, you need to set up a tax rate with a 0% rate and indicate that this is your tax exempt rate.  This is required for tax reporting, so that you can track tax exempt transactions.','D','Business partner is exempt from tax on purchases','PO Tax exempt','N','Y','64ded006-c7b5-49be-8497-dba5c5a03db4',100,0,TO_DATE('2012-10-12 15:34:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:34:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:34:51 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200636 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:34:51 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',223,10,'N','N',54463,'Y',200637,'N','EE04','Tax Group','N','Y','1d4a8b40-8391-4db4-806c-b8cdbf26e2ae',100,0,TO_DATE('2012-10-12 15:34:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-12 15:34:51','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 12, 2012 3:34:51 PM SGT
-- Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200637 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 12, 2012 3:35:02 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200632
;

-- Oct 12, 2012 3:35:02 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200634
;

-- Oct 12, 2012 3:35:02 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200635
;

-- Oct 12, 2012 3:35:02 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200636
;

-- Oct 12, 2012 3:35:02 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200637
;

-- Oct 12, 2012 3:35:02 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200633
;

-- Oct 12, 2012 3:35:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200632
;

-- Oct 12, 2012 3:35:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200634
;

-- Oct 12, 2012 3:35:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200635
;

-- Oct 12, 2012 3:35:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200636
;

-- Oct 12, 2012 3:35:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200637
;

-- Oct 12, 2012 3:35:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=200633
;

-- Oct 12, 2012 3:35:30 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLength=26, IsReadOnly='Y', ColumnSpan=2,Updated=TO_DATE('2012-10-12 15:35:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200633
;

-- Oct 12, 2012 3:36:02 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_DATE('2012-10-12 15:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200617
;

-- Oct 12, 2012 3:36:20 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLength=26,Updated=TO_DATE('2012-10-12 15:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200619
;

-- Oct 12, 2012 3:37:06 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=580,IsDisplayed='Y' WHERE AD_Field_ID=200631
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=590,IsDisplayed='Y' WHERE AD_Field_ID=200630
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=600,IsDisplayed='Y' WHERE AD_Field_ID=4051
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=610,IsDisplayed='Y' WHERE AD_Field_ID=4047
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=620,IsDisplayed='Y' WHERE AD_Field_ID=4049
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=630,IsDisplayed='Y' WHERE AD_Field_ID=4048
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=640,IsDisplayed='Y' WHERE AD_Field_ID=4362
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=650,IsDisplayed='Y' WHERE AD_Field_ID=4361
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=660,IsDisplayed='Y' WHERE AD_Field_ID=6552
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=670,IsDisplayed='Y' WHERE AD_Field_ID=4044
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=680,IsDisplayed='Y' WHERE AD_Field_ID=4266
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=690,IsDisplayed='Y' WHERE AD_Field_ID=52052
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=700,IsDisplayed='Y' WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=710,IsDisplayed='Y' WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=720,IsDisplayed='Y' WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:37:07 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=730,IsDisplayed='Y' WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=570,IsDisplayedGrid='Y' WHERE AD_Field_ID=200631
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=580,IsDisplayedGrid='Y' WHERE AD_Field_ID=200630
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=590,IsDisplayedGrid='Y' WHERE AD_Field_ID=4051
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=600,IsDisplayedGrid='Y' WHERE AD_Field_ID=4047
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=610,IsDisplayedGrid='Y' WHERE AD_Field_ID=4049
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=620,IsDisplayedGrid='Y' WHERE AD_Field_ID=4048
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=630,IsDisplayedGrid='Y' WHERE AD_Field_ID=4362
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=640,IsDisplayedGrid='Y' WHERE AD_Field_ID=4361
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=650,IsDisplayedGrid='Y' WHERE AD_Field_ID=6552
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=660,IsDisplayedGrid='Y' WHERE AD_Field_ID=4044
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=670,IsDisplayedGrid='Y' WHERE AD_Field_ID=4266
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=680,IsDisplayedGrid='Y' WHERE AD_Field_ID=52052
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=690,IsDisplayedGrid='Y' WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=700,IsDisplayedGrid='Y' WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=710,IsDisplayedGrid='Y' WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:37:37 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=720,IsDisplayedGrid='Y' WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=640,IsDisplayed='Y' WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=650,IsDisplayed='Y' WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=660,IsDisplayed='Y' WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=670,IsDisplayed='Y' WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=680,IsDisplayed='Y' WHERE AD_Field_ID=4362
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=690,IsDisplayed='Y' WHERE AD_Field_ID=4361
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=700,IsDisplayed='Y' WHERE AD_Field_ID=6552
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=710,IsDisplayed='Y' WHERE AD_Field_ID=4044
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=720,IsDisplayed='Y' WHERE AD_Field_ID=4266
;

-- Oct 12, 2012 3:37:48 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNo=730,IsDisplayed='Y' WHERE AD_Field_ID=52052
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=630,IsDisplayedGrid='Y' WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=640,IsDisplayedGrid='Y' WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=650,IsDisplayedGrid='Y' WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=660,IsDisplayedGrid='Y' WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=670,IsDisplayedGrid='Y' WHERE AD_Field_ID=4362
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=680,IsDisplayedGrid='Y' WHERE AD_Field_ID=4361
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=690,IsDisplayedGrid='Y' WHERE AD_Field_ID=6552
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=700,IsDisplayedGrid='Y' WHERE AD_Field_ID=4044
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=710,IsDisplayedGrid='Y' WHERE AD_Field_ID=4266
;

-- Oct 12, 2012 3:38:05 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=720,IsDisplayedGrid='Y' WHERE AD_Field_ID=52052
;

-- Oct 12, 2012 3:38:17 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_DATE('2012-10-12 15:38:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200631
;

-- Oct 12, 2012 3:39:00 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y', NumLines=3,Updated=TO_DATE('2012-10-12 15:39:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200630
;

-- Oct 12, 2012 3:39:08 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_DATE('2012-10-12 15:39:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:39:09 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_DATE('2012-10-12 15:39:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:39:12 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_DATE('2012-10-12 15:39:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:39:23 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_DATE('2012-10-12 15:39:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:39:25 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_DATE('2012-10-12 15:39:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200626
;

-- Oct 12, 2012 3:39:27 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_DATE('2012-10-12 15:39:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200624
;

-- Oct 12, 2012 3:41:35 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-12 15:41:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200627
;

-- Oct 12, 2012 3:41:36 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-10-12 15:41:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 3:53:32 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET XPosition=5,Updated=TO_DATE('2012-10-12 15:53:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200631
;

-- Oct 12, 2012 3:53:49 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-10-12 15:53:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200630
;

-- Oct 12, 2012 3:54:15 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2012-10-12 15:54:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200625
;

-- Oct 12, 2012 5:25:25 PM SGT
-- Credit Cards Online
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200012,'Payment','U','8959c366-e7f0-4893-8d23-edb1abe2db3f','N','Payment Rule list and Process Payment button','D',0,0,100,TO_DATE('2012-10-12 17:25:23','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-10-12 17:25:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 12, 2012 5:25:25 PM SGT
-- Credit Cards Online
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Oct 12, 2012 5:36:49 PM SGT
-- Credit Cards Online
UPDATE AD_Column SET AD_Reference_Value_ID=NULL, AD_Reference_ID=200012,Updated=TO_DATE('2012-10-12 17:36:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4019
;

-- Oct 12, 2012 5:38:41 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012',Updated=TO_DATE('2012-10-12 17:38:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Oct 12, 2012 5:40:41 PM SGT
-- Credit Cards Online
UPDATE AD_Column SET AD_Reference_Value_ID=NULL, AD_Reference_ID=200012,Updated=TO_DATE('2012-10-12 17:40:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4020
;

-- Oct 12, 2012 6:45:31 PM SGT
-- Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012',Updated=TO_DATE('2012-10-12 18:45:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

SELECT register_migration_script('933_CreditCardsOnline.sql') FROM dual
;