-- Oct 3, 2012 3:52:52 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,297,200579,'U','N','N','N',0,'N',10,'N',19,'N','N',1385,'N','Y','4dbd226a-1b09-4ae7-96dc-5c4379f249bc','N','Y','N','C_PaymentProcessor_ID','Payment processor for electronic payments','The Payment Processor indicates the processor to be used for electronic payments','Payment Processor','Y',100,TO_DATE('2012-10-03 15:52:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-03 15:52:51','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 3, 2012 3:52:53 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200579 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 3, 2012 3:53:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
ALTER TABLE C_BankAccount ADD C_PaymentProcessor_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 3, 2012 3:53:12 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-10-03 15:53:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200579
;

-- Oct 3, 2012 3:53:15 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
ALTER TABLE C_BankAccount MODIFY C_PaymentProcessor_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 3, 2012 3:53:54 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,Processing,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('M','Y','N','N',0,0,'D','Payment Processor',200015,'N','be2857c6-7fdf-4c81-9431-c31855562b5d',TO_DATE('2012-10-03 15:53:54','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-03 15:53:54','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Oct 3, 2012 3:53:55 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200015 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Oct 3, 2012 3:54:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsReadOnly,IsInfoTab,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('N',200015,10,'N','N',398,'N','N','N','N','Y','N',0,'2929b7ec-62c4-46d9-a7cc-59728070eb40','D','Payment Processor',200024,0,0,TO_DATE('2012-10-03 15:54:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-10-03 15:54:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Oct 3, 2012 3:54:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200024 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Oct 3, 2012 3:54:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,14,'N','N',5054,10,'Y',200557,'N','The Payment Processor indicates the processor to be used for electronic payments','D','Payment processor for electronic payments','Payment Processor','N','N','e27b85cc-ad5f-4dc5-89f0-d9ed6661101b',100,0,TO_DATE('2012-10-03 15:54:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:25','YYYY-MM-DD HH24:MI:SS'),'Y','N',10,1,2,1)
;

-- Oct 3, 2012 3:54:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200557 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:27 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,14,'N','N',5163,20,'Y',200558,'Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','f8b7204e-62b4-4c4d-8cf6-1cb9b5d5d2fc',100,0,TO_DATE('2012-10-03 15:54:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:27','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,2,1)
;

-- Oct 3, 2012 3:54:27 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200558 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:28 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,14,'Y','N',5164,30,'Y',200559,'Y','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','6f14f2a6-2419-41a8-8119-dd39f2f6ef8a',100,0,TO_DATE('2012-10-03 15:54:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:27','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,4,2,1)
;

-- Oct 3, 2012 3:54:28 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200559 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:29 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,14,'N','N',5057,40,'Y',200560,'Y','The Bank Account identifies an account at this Bank.','D','Account at the Bank','Bank Account','N','Y','ccc2dd6b-5108-4bb3-8701-063e21c7a0e7',100,0,TO_DATE('2012-10-03 15:54:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:28','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,2,1)
;

-- Oct 3, 2012 3:54:29 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200560 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:29 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES (1,'N',200024,60,'N','N',5055,50,'Y',200561,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','N','Y','4951c671-36ed-4711-b92a-44db8de47051',100,0,TO_DATE('2012-10-03 15:54:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:29','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,1,5,1)
;

-- Oct 3, 2012 3:54:30 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200561 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:30 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,60,'N','N',5056,60,'Y',200562,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','N','Y','060b2eee-c0d8-416c-9e90-beea430b3fcd',100,0,TO_DATE('2012-10-03 15:54:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:30','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,5,1)
;

-- Oct 3, 2012 3:54:30 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200562 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:31 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'N','N',5165,70,'Y',200563,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','1010c8fe-fe5d-4769-9b06-02b019607ca5',100,0,TO_DATE('2012-10-03 15:54:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:30','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,2,2,1)
;

-- Oct 3, 2012 3:54:31 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200563 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:32 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,20,'N','N',5060,80,'Y',200564,'N','The Host Address identifies the URL or DNS of the target host','D','Host Address URL or DNS','Host Address','N','Y','c20bcb42-54ac-40e9-8d17-429df645f70e',100,0,TO_DATE('2012-10-03 15:54:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:31','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,2,1)
;

-- Oct 3, 2012 3:54:32 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200564 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:32 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,11,'Y','N',5061,90,'Y',200565,'N','The Host Port identifies the port to communicate with the host.','D','Host Communication Port','Host port','N','Y','054cddae-7028-4232-a2d4-77153dea73df',100,0,TO_DATE('2012-10-03 15:54:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:32','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,4,2,1)
;

-- Oct 3, 2012 3:54:32 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200565 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:33 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,20,'N','N',7798,100,'Y',200566,'N','Partner ID (Verisign) or Account ID (Optimal)','D','Partner ID or Account for the Payment Processor','Partner ID','N','Y','718f44d0-1000-4374-a88a-c3159f0b38ba',100,0,TO_DATE('2012-10-03 15:54:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:32','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,1,2,1)
;

-- Oct 3, 2012 3:54:33 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200566 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:34 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,20,'Y','N',7797,110,'Y',200567,'N','D','Vendor ID for the Payment Processor','Vendor ID','N','Y','16f5458d-fcd9-4ebf-aab8-fd6fbe1e378d',100,0,TO_DATE('2012-10-03 15:54:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:33','YYYY-MM-DD HH24:MI:SS'),'Y','Y',110,4,2,1)
;

-- Oct 3, 2012 3:54:34 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200567 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:34 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,20,'N','N',5058,120,'Y',200568,'N','The User ID identifies a user and allows access to records or processes.','D','User ID or account number','User ID','N','Y','44ae6576-129f-44e1-9bf0-acfddd6a7aae',100,0,TO_DATE('2012-10-03 15:54:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:34','YYYY-MM-DD HH24:MI:SS'),'Y','Y',120,1,2,1)
;

-- Oct 3, 2012 3:54:35 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200568 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:35 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('Y',200024,20,'Y','N',5059,130,'Y',200569,'N','The Password for this User.  Passwords are required to identify authorized users.  For Adempiere Users, you can change the password via the Process "Reset Password".','D','Password of any length (case sensitive)','Password','N','Y','e87e8ed4-2624-47d7-942c-232d64d933b1',100,0,TO_DATE('2012-10-03 15:54:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:35','YYYY-MM-DD HH24:MI:SS'),'Y','Y',130,4,2,1)
;

-- Oct 3, 2012 3:54:35 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200569 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:36 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,20,'N','N',5062,140,'Y',200570,'N','The Proxy Address must be defined if you must pass through a firewall to access your payment processor. ','D',' Address of your proxy server','Proxy address','N','Y','9d38e19d-fc52-4be3-94f1-daef7d2344fc',100,0,TO_DATE('2012-10-03 15:54:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:35','YYYY-MM-DD HH24:MI:SS'),'Y','Y',140,1,2,1)
;

-- Oct 3, 2012 3:54:36 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200570 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:37 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,11,'Y','N',5063,150,'Y',200571,'N','The Proxy Port identifies the port of your proxy server.','D','Port of your proxy server','Proxy port','N','Y','f59364c8-8fe5-4816-8310-3f4f493755a8',100,0,TO_DATE('2012-10-03 15:54:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:36','YYYY-MM-DD HH24:MI:SS'),'Y','Y',150,4,2,1)
;

-- Oct 3, 2012 3:54:37 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200571 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:38 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,20,'N','N',5064,160,'Y',200572,'N','The Proxy Logon identifies the Logon ID for your proxy server.','D','Logon of your proxy server','Proxy logon','N','Y','728771b9-c404-499e-9d8d-fdbb24ca6e1f',100,0,TO_DATE('2012-10-03 15:54:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:37','YYYY-MM-DD HH24:MI:SS'),'Y','Y',160,1,2,1)
;

-- Oct 3, 2012 3:54:38 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200572 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:39 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('Y',200024,20,'Y','N',5065,170,'Y',200573,'N','The Proxy Password identifies the password for your proxy server.','D','Password of your proxy server','Proxy password','N','Y','af4105cc-e6f6-4fd2-8ebe-f86b16ace1ad',100,0,TO_DATE('2012-10-03 15:54:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:38','YYYY-MM-DD HH24:MI:SS'),'Y','Y',170,4,2,1)
;

-- Oct 3, 2012 3:54:39 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200573 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:39 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'N','N',5067,180,'Y',200574,'N','Indicates if Master Cards are accepted ','D','Accept Master Card','Accept MasterCard','N','Y','f00ba72b-d610-4d5b-8e50-07731549f2ad',100,0,TO_DATE('2012-10-03 15:54:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:39','YYYY-MM-DD HH24:MI:SS'),'Y','Y',180,2,2,1)
;

-- Oct 3, 2012 3:54:39 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200574 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:40 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'Y','N',5066,190,'Y',200575,'N','Indicates if Visa Cards are accepted ','D','Accept Visa Cards','Accept Visa','N','Y','1a9b931f-7dc1-471c-829d-c73f83616371',100,0,TO_DATE('2012-10-03 15:54:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:39','YYYY-MM-DD HH24:MI:SS'),'Y','Y',190,5,2,1)
;

-- Oct 3, 2012 3:54:40 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200575 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:41 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'N','N',5068,200,'Y',200576,'N','Indicates if American Express Cards are accepted','D','Accept American Express Card','Accept AMEX','N','Y','19614db3-d11f-4e06-8f71-c7905367fd1a',100,0,TO_DATE('2012-10-03 15:54:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:40','YYYY-MM-DD HH24:MI:SS'),'Y','Y',200,2,2,1)
;

-- Oct 3, 2012 3:54:41 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200576 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:42 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'Y','N',5069,210,'Y',200577,'N','Indicates if Diner''s Club Cards are accepted ','D','Accept Diner''s Club','Accept Diners','N','Y','d14f97a6-f55d-418a-a58c-1a49357ed3a9',100,0,TO_DATE('2012-10-03 15:54:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:41','YYYY-MM-DD HH24:MI:SS'),'Y','Y',210,5,2,1)
;

-- Oct 3, 2012 3:54:42 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200577 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:42 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'N','N',5073,220,'Y',200578,'N','Indicates if Corporate Purchase Cards are accepted ','D','Accept Corporate Purchase Cards','Accept Corporate','N','Y','aadbeb74-e953-49bb-8b8b-f3d37db88630',100,0,TO_DATE('2012-10-03 15:54:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',220,2,2,1)
;

-- Oct 3, 2012 3:54:42 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200578 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:43 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'Y','N',5357,230,'Y',200579,'N','Indicates if Discover Cards are accepted','D','Accept Discover Card','Accept Discover','N','Y','b91b9eb8-591c-4146-9727-41aea3445387',100,0,TO_DATE('2012-10-03 15:54:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',230,5,2,1)
;

-- Oct 3, 2012 3:54:43 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200579 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:44 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'N','N',5070,240,'Y',200580,'N','Indicates if Direct Deposits (wire transfers, etc.) are accepted. Direct Deposits are initiated by the payee.','D','Accept Direct Deposit (payee initiated)','Accept Direct Deposit','N','Y','daed29a8-24da-403a-bfba-9fd3b6fd33ce',100,0,TO_DATE('2012-10-03 15:54:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:43','YYYY-MM-DD HH24:MI:SS'),'Y','Y',240,2,2,1)
;

-- Oct 3, 2012 3:54:44 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200580 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:44 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'Y','N',10763,250,'Y',200581,'N','Accept Direct Debit transactions. Direct Debits are initiated by the vendor who has permission to deduct amounts from the payee''s account.','D','Accept Direct Debits (vendor initiated)','Accept Direct Debit','N','Y','d202e8d5-89f9-4587-b864-38ba9d70289c',100,0,TO_DATE('2012-10-03 15:54:44','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:44','YYYY-MM-DD HH24:MI:SS'),'Y','Y',250,5,2,1)
;

-- Oct 3, 2012 3:54:44 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200581 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:45 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'N','N',5071,260,'Y',200582,'N','Indicates if EChecks are accepted','D','Accept ECheck (Electronic Checks)','Accept Electronic Check','N','Y','0992214d-ed4f-4d58-b89e-a763a3775e28',100,0,TO_DATE('2012-10-03 15:54:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:45','YYYY-MM-DD HH24:MI:SS'),'Y','Y',260,2,2,1)
;

-- Oct 3, 2012 3:54:45 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200582 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:46 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'Y','N',5072,270,'Y',200583,'N','Indicates if Bank ATM Cards are accepted','D','Accept Bank ATM Card','Accept ATM','N','Y','a752c4d3-dfed-4031-8ea4-6b8f73fceaf3',100,0,TO_DATE('2012-10-03 15:54:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:45','YYYY-MM-DD HH24:MI:SS'),'Y','Y',270,5,2,1)
;

-- Oct 3, 2012 3:54:46 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200583 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:47 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,26,'N','N',9832,280,'Y',200584,'N','D','Minimum Amount in Document Currency','Minimum Amt','N','Y','d0838a33-67b8-4833-8488-db678d6c7b5e',100,0,TO_DATE('2012-10-03 15:54:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:46','YYYY-MM-DD HH24:MI:SS'),'Y','Y',280,1,2,1)
;

-- Oct 3, 2012 3:54:47 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200584 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:47 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,14,'N','N',5360,290,'N',200585,'N','The Only Currency field indicates that this bank account accepts only the currency identified here.','D','Restrict accepting only this currency','Only Currency','N','Y','ae63d36f-5e17-4bca-b470-4f17bcd90e94',100,0,TO_DATE('2012-10-03 15:54:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:47','YYYY-MM-DD HH24:MI:SS'),'Y','Y',290,1,2,1)
;

-- Oct 3, 2012 3:54:47 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200585 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:48 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,1,'Y','N',5361,300,'Y',200586,'N','The Require CC Verification checkbox indicates if this bank accounts requires a verification number for credit card transactions.','D','Require 3/4 digit Credit Verification Code','Require CreditCard Verification Code','N','Y','d4087352-9d0c-464b-b44c-78219776dc2c',100,0,TO_DATE('2012-10-03 15:54:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:47','YYYY-MM-DD HH24:MI:SS'),'Y','Y',300,5,2,1)
;

-- Oct 3, 2012 3:54:48 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200586 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,14,'N','N',5319,310,'Y',200587,'N','The Sequence defines the numbering sequence to be used for documents.','D','Document Sequence','Sequence','N','Y','844c95b1-2338-4c92-a57c-834d2c698d82',100,0,TO_DATE('2012-10-03 15:54:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:48','YYYY-MM-DD HH24:MI:SS'),'Y','Y',310,1,2,1)
;

-- Oct 3, 2012 3:54:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200587 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:50 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,26,'N','N',5320,320,'Y',200588,'N','Payment Processor class identifies the Java class used to process payments extending the org.compiere.model.PaymentProcessor class. <br>
Example implementations are Optimal Payments: org.compiere.model.PP_Optimal or Verisign: org.compiere.model.PP_PayFlowPro','D','Payment Processor Java Class','Payment Processor Class','N','Y','bd7bdcdf-5cbb-4572-ae84-cebf8cff2e78',100,0,TO_DATE('2012-10-03 15:54:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:49','YYYY-MM-DD HH24:MI:SS'),'Y','Y',320,1,2,1)
;

-- Oct 3, 2012 3:54:50 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200588 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:50 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,26,'N','N',5358,330,'Y',200589,'N','The Commission indicates (as a percentage) the commission to be paid.','D','Commission stated as a percentage','Commission %','N','Y','62d0f61e-a78e-4c8d-a782-3008d45f55fe',100,0,TO_DATE('2012-10-03 15:54:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:50','YYYY-MM-DD HH24:MI:SS'),'Y','Y',330,1,2,1)
;

-- Oct 3, 2012 3:54:50 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200589 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:54:51 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200024,26,'Y','N',5359,340,'Y',200590,'N','The Cost per Transaction indicates the fixed cost per to be charged per transaction.','D','Fixed cost per transaction','Cost per transaction','N','Y','60e201df-0286-4e88-864f-24b56a91402d',100,0,TO_DATE('2012-10-03 15:54:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 15:54:50','YYYY-MM-DD HH24:MI:SS'),'Y','Y',340,4,2,1)
;

-- Oct 3, 2012 3:54:51 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200590 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200560
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200557
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200558
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200559
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200561
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200562
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200563
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200564
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200565
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200566
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200567
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200568
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200569
;

-- Oct 3, 2012 3:55:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200570
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200571
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200572
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200573
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200574
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200575
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200576
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200577
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200578
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200579
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=200580
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=200581
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200582
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200583
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200584
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200585
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=200586
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=200587
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=200588
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=200589
;

-- Oct 3, 2012 3:55:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=200590
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200560
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200557
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200558
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200559
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200561
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200562
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200563
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200564
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200565
;

-- Oct 3, 2012 3:55:06 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200566
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200567
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200568
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200569
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200570
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200571
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200572
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200573
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200574
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200575
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200576
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200577
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200578
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200579
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=200580
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=200581
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=200582
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=200583
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=200584
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=200585
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=200586
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=200587
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=200588
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=200589
;

-- Oct 3, 2012 3:55:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=200590
;

-- Oct 3, 2012 3:55:30 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Column SET IsMandatory='N', IsUpdateable='N',Updated=TO_DATE('2012-10-03 15:55:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5057
;

-- Oct 3, 2012 3:56:02 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Column SET IsParent='N',Updated=TO_DATE('2012-10-03 15:56:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5057
;

-- Oct 3, 2012 3:56:09 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
ALTER TABLE C_PaymentProcessor MODIFY C_BankAccount_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 3, 2012 3:56:09 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
ALTER TABLE C_PaymentProcessor MODIFY C_BankAccount_ID NULL
;

-- Oct 3, 2012 3:56:53 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Table SET AccessLevel='6', AD_Window_ID=NULL,Updated=TO_DATE('2012-10-03 15:56:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=398
;

-- Oct 3, 2012 3:57:12 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Table SET AD_Window_ID=200015,Updated=TO_DATE('2012-10-03 15:57:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=398
;

-- Oct 3, 2012 3:58:53 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Description,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200015,200021,'N','Y','N','D','Y','Payment Processor','Maintain Payment Processor','W','8b19f811-50bc-435e-8722-9dc8a94244d0','Y',0,100,TO_DATE('2012-10-03 15:58:52','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-10-03 15:58:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 3, 2012 3:58:53 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Oct 3, 2012 3:58:54 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200021, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200021)
;

-- Oct 3, 2012 3:59:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=155
;

-- Oct 3, 2012 3:59:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=156
;

-- Oct 3, 2012 3:59:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=175
;

-- Oct 3, 2012 3:59:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Oct 3, 2012 3:59:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=157
;

-- Oct 3, 2012 3:59:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53251
;

-- Oct 3, 2012 3:59:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=552
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=441
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=149
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50010
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200010
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=171
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=437
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=240
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Oct 3, 2012 3:59:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=361
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=441
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=149
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50010
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200010
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=171
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=437
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=240
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Oct 3, 2012 3:59:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=361
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=441
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=149
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50010
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200010
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=171
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200021
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=437
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=240
;

-- Oct 3, 2012 3:59:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_TreeNodeMM SET Parent_ID=175, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=361
;

-- Oct 3, 2012 4:05:54 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',227,36,'N','N',60597,'Y',200591,'N','D','C_Bank_UU','N','Y','fdff0eca-55e9-44fd-a28f-dc601ee3ae4d',100,0,TO_DATE('2012-10-03 16:05:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 16:05:51','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 3, 2012 4:05:54 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200591 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 4:06:17 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200591
;

-- Oct 3, 2012 4:06:20 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200591
;

-- Oct 3, 2012 4:06:54 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',228,36,'N','N',60598,'Y',200592,'N','D','C_BankAccount_UU','N','Y','978e72b4-e2d0-4a52-9547-3fba0277afa3',100,0,TO_DATE('2012-10-03 16:06:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 16:06:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 3, 2012 4:06:54 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200592 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 4:06:54 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',228,10,'N','N',200579,'Y',200593,'N','The Payment Processor indicates the processor to be used for electronic payments','D','Payment processor for electronic payments','Payment Processor','N','Y','3aab6e76-c1ed-4f4d-ba1e-2b17a3194914',100,0,TO_DATE('2012-10-03 16:06:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-03 16:06:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 3, 2012 4:06:55 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200593 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 3, 2012 4:07:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200592
;

-- Oct 3, 2012 4:07:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=60881
;

-- Oct 3, 2012 4:07:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=2221
;

-- Oct 3, 2012 4:07:03 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200593
;

-- Oct 3, 2012 4:07:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200592
;

-- Oct 3, 2012 4:07:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=60881
;

-- Oct 3, 2012 4:07:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=2221
;

-- Oct 3, 2012 4:07:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200593
;

-- Oct 3, 2012 4:07:54 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-03 16:07:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200593
;

-- Oct 3, 2012 4:09:00 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Tab SET IsActive='N',Updated=TO_DATE('2012-10-03 16:09:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=326
;

-- Oct 3, 2012 4:09:08 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE  FROM  AD_Tab_Trl WHERE AD_Tab_ID=326
;

-- Oct 3, 2012 4:09:09 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE FROM AD_Tab WHERE AD_Tab_ID=326
;

UPDATE C_BankAccount ba SET C_PaymentProcessor_ID = (
	SELECT pp.C_PaymentProcessor_ID 
	FROM C_PaymentProcessor pp
	WHERE pp.C_BankAccount_ID IS NOT NULL 
	AND pp.C_BankAccount_ID = ba.C_BankAccount_ID)
WHERE ba.C_PaymentProcessor_ID IS NULL;

UPDATE C_PaymentProcessor pp SET C_BankAccount_ID = NULL, AD_Client_ID = 0, AD_Org_ID = 0 
	WHERE C_PaymentProcessor_ID IN (100, 101);
	
SELECT register_migration_script('924_IDEMPIERE-447.sql') FROM dual
;