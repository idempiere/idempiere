-- Jul 23, 2012 10:28:32 AM CEST
-- IDEMPIERE-344 - Improve usability for GL Journal
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200216,112,0,18,130,226,'org.compiere.model.CalloutGLJournal.account','AD_OrgTrx_ID',TO_DATE('2012-07-23 10:28:29','YYYY-MM-DD HH24:MI:SS'),100,'Performing or initiating organization','D',10,'The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Trx Organization',0,TO_DATE('2012-07-23 10:28:29','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:28:32 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200216 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:28:37 AM CEST
ALTER TABLE GL_JournalLine ADD AD_OrgTrx_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:29:55 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Val_Rule_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200217,148,0,18,362,226,252,'org.compiere.model.CalloutGLJournal.account','Account_ID',TO_DATE('2012-07-23 10:29:54','YYYY-MM-DD HH24:MI:SS'),100,'Account used','D',10,'The (natural) account used','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Account',0,TO_DATE('2012-07-23 10:29:54','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:29:55 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200217 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:29:56 AM CEST
ALTER TABLE GL_JournalLine ADD Account_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:30:36 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200218,1005,0,18,142,226,'org.compiere.model.CalloutGLJournal.account','C_Activity_ID',TO_DATE('2012-07-23 10:30:36','YYYY-MM-DD HH24:MI:SS'),100,'Business Activity','D',10,'Activities indicate tasks that are performed and used to utilize Activity based Costing','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Activity',0,TO_DATE('2012-07-23 10:30:36','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:30:36 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200218 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:30:37 AM CEST
ALTER TABLE GL_JournalLine ADD C_Activity_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:30:59 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200219,187,0,30,138,226,'org.compiere.model.CalloutGLJournal.account','C_BPartner_ID',TO_DATE('2012-07-23 10:30:59','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a Business Partner','D',10,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Business Partner ',0,TO_DATE('2012-07-23 10:30:59','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:30:59 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200219 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:31:00 AM CEST
ALTER TABLE GL_JournalLine ADD C_BPartner_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:31:18 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200220,550,0,18,143,226,'org.compiere.model.CalloutGLJournal.account','C_Campaign_ID',TO_DATE('2012-07-23 10:31:17','YYYY-MM-DD HH24:MI:SS'),100,'Marketing Campaign','D',10,'The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Campaign',0,TO_DATE('2012-07-23 10:31:17','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:31:18 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200220 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:31:18 AM CEST
ALTER TABLE GL_JournalLine ADD C_Campaign_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:31:36 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200221,200,0,30,133,226,'org.compiere.model.CalloutGLJournal.account','C_LocFrom_ID',TO_DATE('2012-07-23 10:31:35','YYYY-MM-DD HH24:MI:SS'),100,'Location that inventory was moved from','D',10,'The Location From indicates the location that a product was moved from.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Location From',0,TO_DATE('2012-07-23 10:31:35','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:31:36 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200221 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:31:37 AM CEST
ALTER TABLE GL_JournalLine ADD C_LocFrom_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:31:49 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200222,201,0,30,133,226,'C_LocTo_ID',TO_DATE('2012-07-23 10:31:48','YYYY-MM-DD HH24:MI:SS'),100,'Location that inventory was moved to','D',10,'The Location To indicates the location that a product was moved to.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Location To',0,TO_DATE('2012-07-23 10:31:48','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:31:49 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200222 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:31:50 AM CEST
ALTER TABLE GL_JournalLine ADD C_LocTo_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:32:11 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200223,208,0,18,141,226,'org.compiere.model.CalloutGLJournal.account','C_Project_ID',TO_DATE('2012-07-23 10:32:11','YYYY-MM-DD HH24:MI:SS'),100,'Financial Project','D',20,'A Project allows you to track and control internal or external activities.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Project',0,TO_DATE('2012-07-23 10:32:11','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:32:11 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200223 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:32:12 AM CEST
ALTER TABLE GL_JournalLine ADD C_Project_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:32:29 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200224,210,0,18,144,226,'org.compiere.model.CalloutGLJournal.account','C_SalesRegion_ID',TO_DATE('2012-07-23 10:32:28','YYYY-MM-DD HH24:MI:SS'),100,'Sales coverage region','D',10,'The Sales Region indicates a specific area of sales coverage.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Sales Region',0,TO_DATE('2012-07-23 10:32:28','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:32:29 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200224 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:32:30 AM CEST
ALTER TABLE GL_JournalLine ADD C_SalesRegion_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:32:45 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200225,2876,0,19,226,255,'C_SubAcct_ID',TO_DATE('2012-07-23 10:32:44','YYYY-MM-DD HH24:MI:SS'),100,'Sub account for Element Value','D',10,'The Element Value (e.g. Account) may have optional sub accounts for further detail. The sub account is dependent on the value of the account, so a further specification. If the sub-accounts are more or less the same, consider using another accounting dimension.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Sub Account',0,TO_DATE('2012-07-23 10:32:44','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:32:45 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200225 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:32:46 AM CEST
ALTER TABLE GL_JournalLine ADD C_SubAcct_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:33:06 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200226,454,0,30,162,226,'org.compiere.model.CalloutGLJournal.account','M_Product_ID',TO_DATE('2012-07-23 10:33:05','YYYY-MM-DD HH24:MI:SS'),100,'Product, Service, Item','D',10,'Identifies an item which is either purchased or sold in this organization.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Product',0,TO_DATE('2012-07-23 10:33:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:33:06 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200226 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:33:06 AM CEST
ALTER TABLE GL_JournalLine ADD M_Product_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:33:29 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Val_Rule_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200227,613,0,18,134,226,138,'org.compiere.model.CalloutGLJournal.account','User1_ID',TO_DATE('2012-07-23 10:33:29','YYYY-MM-DD HH24:MI:SS'),100,'User defined list element #1','D',10,'The user defined element displays the optional elements that have been defined for this account combination.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','User List 1',0,TO_DATE('2012-07-23 10:33:29','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:33:29 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200227 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:33:30 AM CEST
ALTER TABLE GL_JournalLine ADD User1_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:33:49 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Val_Rule_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200228,614,0,18,137,226,139,'org.compiere.model.CalloutGLJournal.account','User2_ID',TO_DATE('2012-07-23 10:33:48','YYYY-MM-DD HH24:MI:SS'),100,'User defined list element #2','D',10,'The user defined element displays the optional elements that have been defined for this account combination.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','User List 2',0,TO_DATE('2012-07-23 10:33:48','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:33:49 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200228 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:33:50 AM CEST
ALTER TABLE GL_JournalLine ADD User2_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:34:03 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200229,2877,0,13,226,'org.compiere.model.CalloutGLJournal.account','UserElement1_ID',TO_DATE('2012-07-23 10:34:03','YYYY-MM-DD HH24:MI:SS'),100,'User defined accounting Element','D',10,'A user defined accounting element refers to a Adempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','User Element 1',0,TO_DATE('2012-07-23 10:34:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:34:03 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200229 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:34:04 AM CEST
ALTER TABLE GL_JournalLine ADD UserElement1_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:34:18 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200230,2878,0,13,226,'org.compiere.model.CalloutGLJournal.account','UserElement2_ID',TO_DATE('2012-07-23 10:34:17','YYYY-MM-DD HH24:MI:SS'),100,'User defined accounting Element','D',10,'A user defined accounting element refers to a Adempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','User Element 2',0,TO_DATE('2012-07-23 10:34:17','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:34:18 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200230 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:34:18 AM CEST
ALTER TABLE GL_JournalLine ADD UserElement2_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 10:35:11 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200231,159,0,18,175,226,'org.compiere.model.CalloutGLJournal.alias','Alias',TO_DATE('2012-07-23 10:35:10','YYYY-MM-DD HH24:MI:SS'),100,'Defines an alternate method of indicating an account combination.','D',10,'The Alias field allows you to define a alternate method for referring to a full account combination.  For example, the Account Receivable Account for Garden World may be aliased as GW_AR.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Alias',0,TO_DATE('2012-07-23 10:35:10','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 23, 2012 10:35:11 AM CEST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200231 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 23, 2012 10:36:10 AM CEST
UPDATE AD_Window SET Name='GL Journal Batch',Updated=TO_DATE('2012-07-23 10:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=132
;

-- Jul 23, 2012 10:36:10 AM CEST
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=132
;

-- Jul 23, 2012 10:36:10 AM CEST
UPDATE AD_Menu SET Description='Enter and change Manual Journal Entries', IsActive='Y', Name='GL Journal Batch',Updated=TO_DATE('2012-07-23 10:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=118
;

-- Jul 23, 2012 10:36:10 AM CEST
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=118
;

-- Jul 23, 2012 10:36:25 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200217,200166,0,161,TO_DATE('2012-07-23 10:36:25','YYYY-MM-DD HH24:MI:SS'),100,'Account used',10,'D','The (natural) account used','Y','Y','Y','N','N','N','N','N','Account',TO_DATE('2012-07-23 10:36:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:26 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200166 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:26 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200218,200167,0,161,TO_DATE('2012-07-23 10:36:26','YYYY-MM-DD HH24:MI:SS'),100,'Business Activity',10,'D','Activities indicate tasks that are performed and used to utilize Activity based Costing','Y','Y','Y','N','N','N','N','N','Activity',TO_DATE('2012-07-23 10:36:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:26 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200167 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:27 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200231,200168,0,161,TO_DATE('2012-07-23 10:36:26','YYYY-MM-DD HH24:MI:SS'),100,'Defines an alternate method of indicating an account combination.',10,'D','The Alias field allows you to define a alternate method for referring to a full account combination.  For example, the Account Receivable Account for Garden World may be aliased as GW_AR.','Y','Y','Y','N','N','N','N','N','Alias',TO_DATE('2012-07-23 10:36:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:27 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200168 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:27 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200219,200169,0,161,TO_DATE('2012-07-23 10:36:27','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a Business Partner',10,'D','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Y','Y','Y','N','N','N','N','N','Business Partner ',TO_DATE('2012-07-23 10:36:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:27 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200169 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:28 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200220,200170,0,161,TO_DATE('2012-07-23 10:36:27','YYYY-MM-DD HH24:MI:SS'),100,'Marketing Campaign',10,'D','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.','Y','Y','Y','N','N','N','N','N','Campaign',TO_DATE('2012-07-23 10:36:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:28 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200170 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:28 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200221,200171,0,161,TO_DATE('2012-07-23 10:36:28','YYYY-MM-DD HH24:MI:SS'),100,'Location that inventory was moved from',10,'D','The Location From indicates the location that a product was moved from.','Y','Y','Y','N','N','N','N','N','Location From',TO_DATE('2012-07-23 10:36:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:28 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200171 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:29 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200222,200172,0,161,TO_DATE('2012-07-23 10:36:28','YYYY-MM-DD HH24:MI:SS'),100,'Location that inventory was moved to',10,'D','The Location To indicates the location that a product was moved to.','Y','Y','Y','N','N','N','N','N','Location To',TO_DATE('2012-07-23 10:36:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:29 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200172 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:29 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200226,200173,0,161,TO_DATE('2012-07-23 10:36:29','YYYY-MM-DD HH24:MI:SS'),100,'Product, Service, Item',10,'D','Identifies an item which is either purchased or sold in this organization.','Y','Y','Y','N','N','N','N','N','Product',TO_DATE('2012-07-23 10:36:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:29 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200173 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:30 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200223,200174,0,161,TO_DATE('2012-07-23 10:36:29','YYYY-MM-DD HH24:MI:SS'),100,'Financial Project',20,'D','A Project allows you to track and control internal or external activities.','Y','Y','Y','N','N','N','N','N','Project',TO_DATE('2012-07-23 10:36:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:30 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200174 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:30 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200224,200175,0,161,TO_DATE('2012-07-23 10:36:30','YYYY-MM-DD HH24:MI:SS'),100,'Sales coverage region',10,'D','The Sales Region indicates a specific area of sales coverage.','Y','Y','Y','N','N','N','N','N','Sales Region',TO_DATE('2012-07-23 10:36:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:30 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200175 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:31 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200225,200176,0,161,TO_DATE('2012-07-23 10:36:30','YYYY-MM-DD HH24:MI:SS'),100,'Sub account for Element Value',10,'D','The Element Value (e.g. Account) may have optional sub accounts for further detail. The sub account is dependent on the value of the account, so a further specification. If the sub-accounts are more or less the same, consider using another accounting dimension.','Y','Y','Y','N','N','N','N','N','Sub Account',TO_DATE('2012-07-23 10:36:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:31 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200176 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:31 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200216,200177,0,161,TO_DATE('2012-07-23 10:36:31','YYYY-MM-DD HH24:MI:SS'),100,'Performing or initiating organization',10,'D','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.','Y','Y','Y','N','N','N','N','N','Trx Organization',TO_DATE('2012-07-23 10:36:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:31 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200177 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:32 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200229,200178,0,161,TO_DATE('2012-07-23 10:36:31','YYYY-MM-DD HH24:MI:SS'),100,'User defined accounting Element',10,'D','A user defined accounting element refers to a Adempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Y','Y','Y','N','N','N','N','N','User Element 1',TO_DATE('2012-07-23 10:36:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:32 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200178 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:32 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200230,200179,0,161,TO_DATE('2012-07-23 10:36:32','YYYY-MM-DD HH24:MI:SS'),100,'User defined accounting Element',10,'D','A user defined accounting element refers to a Adempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Y','Y','Y','N','N','N','N','N','User Element 2',TO_DATE('2012-07-23 10:36:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:32 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200179 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:33 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200227,200180,0,161,TO_DATE('2012-07-23 10:36:32','YYYY-MM-DD HH24:MI:SS'),100,'User defined list element #1',10,'D','The user defined element displays the optional elements that have been defined for this account combination.','Y','Y','Y','N','N','N','N','N','User List 1',TO_DATE('2012-07-23 10:36:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:33 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200180 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:36:33 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200228,200181,0,161,TO_DATE('2012-07-23 10:36:33','YYYY-MM-DD HH24:MI:SS'),100,'User defined list element #2',10,'D','The user defined element displays the optional elements that have been defined for this account combination.','Y','Y','Y','N','N','N','N','N','User List 2',TO_DATE('2012-07-23 10:36:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 10:36:33 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200181 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 10:37:52 AM CEST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=713
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=10325
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=714
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=903
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=716
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=724
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=725
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=715
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=884
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=727
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=1293
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=8645
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200166
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200169
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200177
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200167
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200170
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200175
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200174
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200176
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200173
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200171
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200172
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=200178
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=200179
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200180
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200181
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200168
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=895
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=4724
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=56249
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=56250
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=56251
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=728
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=729
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=730
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=731
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=1294
;

-- Jul 23, 2012 10:37:53 AM CEST
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=1295
;

-- Jul 23, 2012 10:38:12 AM CEST
UPDATE AD_Field SET AD_FieldGroup_ID=104,Updated=TO_DATE('2012-07-23 10:38:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200166
;

-- Jul 23, 2012 10:38:43 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_OT@=Y', IsSameLine='Y',Updated=TO_DATE('2012-07-23 10:38:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200177
;

-- Jul 23, 2012 10:39:02 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_AY@=Y',Updated=TO_DATE('2012-07-23 10:39:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200167
;

-- Jul 23, 2012 10:39:11 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_MC@=Y', IsSameLine='Y',Updated=TO_DATE('2012-07-23 10:39:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200170
;

-- Jul 23, 2012 10:39:36 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_SR@=Y',Updated=TO_DATE('2012-07-23 10:39:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200175
;

-- Jul 23, 2012 10:39:44 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_PJ@=Y', IsSameLine='Y',Updated=TO_DATE('2012-07-23 10:39:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200174
;

-- Jul 23, 2012 10:39:52 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_SA@=Y',Updated=TO_DATE('2012-07-23 10:39:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200176
;

-- Jul 23, 2012 10:40:02 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_PR@=Y', IsSameLine='Y',Updated=TO_DATE('2012-07-23 10:40:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200173
;

-- Jul 23, 2012 10:40:12 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_LF@=Y',Updated=TO_DATE('2012-07-23 10:40:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200171
;

-- Jul 23, 2012 10:40:22 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_LT@=Y', IsSameLine='Y',Updated=TO_DATE('2012-07-23 10:40:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200172
;

-- Jul 23, 2012 10:40:28 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_X1@=Y',Updated=TO_DATE('2012-07-23 10:40:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200178
;

-- Jul 23, 2012 10:40:36 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_X2@=Y', IsSameLine='Y',Updated=TO_DATE('2012-07-23 10:40:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200179
;

-- Jul 23, 2012 10:40:42 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_U1@=Y',Updated=TO_DATE('2012-07-23 10:40:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200180
;

-- Jul 23, 2012 10:40:49 AM CEST
UPDATE AD_Field SET DisplayLogic='@$Element_U2@=Y', IsSameLine='Y',Updated=TO_DATE('2012-07-23 10:40:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200181
;

-- Jul 23, 2012 11:07:40 AM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-07-23 11:07:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5955
;

-- Jul 23, 2012 11:07:43 AM CEST
ALTER TABLE GL_JournalLine MODIFY C_ValidCombination_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 23, 2012 11:07:44 AM CEST
ALTER TABLE GL_JournalLine MODIFY C_ValidCombination_ID NULL
;

-- Jul 23, 2012 11:10:26 AM CEST
INSERT INTO AD_Reference (AD_Client_ID,AD_Org_ID,AD_Reference_ID,Created,CreatedBy,Description,EntityType,IsActive,IsOrderByValue,Name,Updated,UpdatedBy,ValidationType) VALUES (0,0,200001,TO_DATE('2012-07-23 11:10:26','YYYY-MM-DD HH24:MI:SS'),100,'Valid Account combinations','D','Y','N','C_ValidCombination (with Alias defined)',TO_DATE('2012-07-23 11:10:26','YYYY-MM-DD HH24:MI:SS'),100,'T')
;

-- Jul 23, 2012 11:10:27 AM CEST
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Reference_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Jul 23, 2012 11:10:47 AM CEST
INSERT INTO AD_Ref_Table (AD_Client_ID,AD_Display,AD_Key,AD_Org_ID,AD_Reference_ID,AD_Table_ID,Created,CreatedBy,EntityType,IsActive,IsValueDisplayed,Updated,UpdatedBy,WhereClause) VALUES (0,2399,1014,0,200001,176,TO_DATE('2012-07-23 11:10:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','N',TO_DATE('2012-07-23 11:10:47','YYYY-MM-DD HH24:MI:SS'),100,'C_ValidCombination.Alias IS NOT NULL')
;

-- Jul 23, 2012 11:10:55 AM CEST
UPDATE AD_Column SET AD_Reference_Value_ID=200001,Updated=TO_DATE('2012-07-23 11:10:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200231
;

-- Jul 23, 2012 11:18:21 AM CEST
INSERT INTO AD_Window (AD_Client_ID,AD_Image_ID,AD_Org_ID,AD_Window_ID,Created,CreatedBy,Description,EntityType,Help,IsActive,IsBetaFunctionality,IsDefault,IsSOTrx,Name,Processing,Updated,UpdatedBy,WindowType) VALUES (0,102,0,200005,TO_DATE('2012-07-23 11:18:20','YYYY-MM-DD HH24:MI:SS'),100,'Enter and change Manual Journal Entries','D','The GL Journal Window allows you to enter and modify manual journal entries','Y','N','N','Y','GL Journal','N',TO_DATE('2012-07-23 11:18:20','YYYY-MM-DD HH24:MI:SS'),100,'T')
;

-- Jul 23, 2012 11:18:21 AM CEST
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Window_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Jul 23, 2012 11:20:06 AM CEST
INSERT INTO AD_Tab (AD_Client_ID,AD_Org_ID,AD_Tab_ID,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy,WhereClause) VALUES (0,0,200007,224,200005,TO_DATE('2012-07-23 11:20:05','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','Y','Y','N','Y','N','N','Journal','N',10,0,TO_DATE('2012-07-23 11:20:05','YYYY-MM-DD HH24:MI:SS'),100,'GL_JournalBatch_ID IS NULL')
;

-- Jul 23, 2012 11:20:06 AM CEST
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, CommitWarning,Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.CommitWarning,t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200007 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jul 23, 2012 11:29:20 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1617,200182,0,200007,TO_DATE('2012-07-23 11:29:20','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Journal',14,'D','The General Ledger Journal identifies a group of journal lines which represent a logical business transaction','Y','Y','N','N','N','N','N','N','Journal',10,TO_DATE('2012-07-23 11:29:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:20 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200182 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:21 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1628,200183,0,200007,TO_DATE('2012-07-23 11:29:20','YYYY-MM-DD HH24:MI:SS'),100,'Indicates if this document / line is printed',1,'D','The Printed checkbox indicates if this document or line will included when printing.','Y','Y','N','N','N','N','Y','Y','Printed',20,TO_DATE('2012-07-23 11:29:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:21 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200183 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:22 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,5953,200184,0,200007,TO_DATE('2012-07-23 11:29:21','YYYY-MM-DD HH24:MI:SS'),100,'The document has been processed',1,'D','The Processed checkbox indicates that a document has been processed.','Y','N','Y','N','N','N','N','N','N','Processed',30,TO_DATE('2012-07-23 11:29:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:22 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200184 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:22 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,5954,200185,0,200007,TO_DATE('2012-07-23 11:29:22','YYYY-MM-DD HH24:MI:SS'),100,23,'D','Y','Y','N','N','N','N','N','N','Process Now',40,TO_DATE('2012-07-23 11:29:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:22 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200185 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:23 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1618,200186,0,200007,TO_DATE('2012-07-23 11:29:22','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',14,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','Y','N','Client',50,TO_DATE('2012-07-23 11:29:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:23 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200186 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:23 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1619,200187,0,200007,TO_DATE('2012-07-23 11:29:23','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',14,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','N','N','N','N','Y','Organization',60,TO_DATE('2012-07-23 11:29:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:23 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200187 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:24 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1632,200188,0,200007,TO_DATE('2012-07-23 11:29:23','YYYY-MM-DD HH24:MI:SS'),100,'Rules for accounting',14,'D','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar','Y','Y','Y','N','N','N','N','N','Accounting Schema',70,TO_DATE('2012-07-23 11:29:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:24 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200188 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:24 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1638,200189,0,200007,TO_DATE('2012-07-23 11:29:24','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Journal Batch',14,'D','The General Ledger Journal Batch identifies a group of journals to be processed as a group.','Y','Y','Y','N','N','N','Y','Y','Journal Batch',80,TO_DATE('2012-07-23 11:29:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:25 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200189 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:25 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,1626,200190,0,200007,TO_DATE('2012-07-23 11:29:25','YYYY-MM-DD HH24:MI:SS'),100,'Document sequence number of the document',20,'D','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Y','N','Y','Y','N','N','N','N','N','Document No',90,1,TO_DATE('2012-07-23 11:29:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:25 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200190 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:26 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1630,200191,0,200007,TO_DATE('2012-07-23 11:29:25','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',60,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',100,TO_DATE('2012-07-23 11:29:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:26 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200191 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:26 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1620,200192,0,200007,TO_DATE('2012-07-23 11:29:26','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','Y','Y','Active',110,TO_DATE('2012-07-23 11:29:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:26 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200192 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:27 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1631,200193,0,200007,TO_DATE('2012-07-23 11:29:26','YYYY-MM-DD HH24:MI:SS'),100,'The type of posted amount for the transaction',14,'D','The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.','Y','Y','Y','N','N','N','N','N','PostingType',120,TO_DATE('2012-07-23 11:29:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:27 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200193 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:27 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,2334,200194,0,200007,TO_DATE('2012-07-23 11:29:27','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Budget',14,'@PostingType@=''B''','D','The General Ledger Budget identifies a user defined budget.  These can be used in reporting as a comparison against your actual amounts.','Y','Y','Y','N','N','N','N','Y','Budget',130,TO_DATE('2012-07-23 11:29:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:27 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200194 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:28 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1625,200195,0,200007,TO_DATE('2012-07-23 11:29:27','YYYY-MM-DD HH24:MI:SS'),100,'Document type or rules',14,'D','The Document Type determines document sequence and processing rules','Y','Y','Y','N','N','N','N','N','Document Type',140,TO_DATE('2012-07-23 11:29:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:28 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200195 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:28 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1633,200196,0,200007,TO_DATE('2012-07-23 11:29:28','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Category',14,'D','The General Ledger Category is an optional, user defined method of grouping journal lines.','Y','Y','Y','N','N','N','N','Y','GL Category',150,TO_DATE('2012-07-23 11:29:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:29 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200196 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:29 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1634,200197,0,200007,TO_DATE('2012-07-23 11:29:29','YYYY-MM-DD HH24:MI:SS'),100,'Date of the Document',14,'D','The Document Date indicates the date the document was generated.  It may or may not be the same as the accounting date.','Y','Y','Y','N','N','N','N','N','Document Date',160,TO_DATE('2012-07-23 11:29:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:29 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200197 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:30 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1635,200198,0,200007,TO_DATE('2012-07-23 11:29:29','YYYY-MM-DD HH24:MI:SS'),100,'Accounting Date',14,'D','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.','Y','Y','Y','N','N','N','N','Y','Account Date',170,TO_DATE('2012-07-23 11:29:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:30 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200198 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:30 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1636,200199,0,200007,TO_DATE('2012-07-23 11:29:30','YYYY-MM-DD HH24:MI:SS'),100,'Period of the Calendar',14,'D','The Period indicates an exclusive range of dates for a calendar.','Y','Y','Y','N','N','N','N','N','Period',180,TO_DATE('2012-07-23 11:29:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:30 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200199 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:31 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1637,200200,0,200007,TO_DATE('2012-07-23 11:29:30','YYYY-MM-DD HH24:MI:SS'),100,'The Currency for this record',14,'D','Indicates the Currency to be used when processing or reporting on this record','Y','Y','Y','N','N','N','N','Y','Currency',190,TO_DATE('2012-07-23 11:29:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:31 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200200 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:31 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,10295,200201,0,200007,TO_DATE('2012-07-23 11:29:31','YYYY-MM-DD HH24:MI:SS'),100,'Currency Conversion Rate Type',14,'@$C_Currency_ID@!@C_Currency_ID@','D','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.','Y','Y','Y','N','N','N','N','N','Currency Type',200,TO_DATE('2012-07-23 11:29:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:31 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200201 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:32 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1792,200202,0,200007,TO_DATE('2012-07-23 11:29:31','YYYY-MM-DD HH24:MI:SS'),100,'Currency Conversion Rate',26,'@$C_Currency_ID@!@C_Currency_ID@','D','The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency','Y','Y','Y','N','N','N','N','Y','Rate',210,TO_DATE('2012-07-23 11:29:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:32 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200202 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:33 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,5952,101,200203,0,200007,TO_DATE('2012-07-23 11:29:32','YYYY-MM-DD HH24:MI:SS'),100,'If not zero, the Debit amount of the document must be equal this amount',26,'D','If the control amount is zero, no check is performed.
Otherwise the total Debit amount must be equal to the control amount, before the document is processed.','Y','Y','Y','N','N','N','N','N','Control Amount',220,TO_DATE('2012-07-23 11:29:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:33 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200203 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:33 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1790,200204,0,200007,TO_DATE('2012-07-23 11:29:33','YYYY-MM-DD HH24:MI:SS'),100,'Indicates if this document requires approval',1,'D','The Approved checkbox indicates if this document requires approval before it can be processed.','Y','N','Y','Y','N','N','N','Y','Y','Approved',230,TO_DATE('2012-07-23 11:29:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:33 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200204 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:34 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1639,101,200205,0,200007,TO_DATE('2012-07-23 11:29:33','YYYY-MM-DD HH24:MI:SS'),100,'Total debit in document currency',26,'D','The Total Debit indicates the total debit amount for a journal or journal batch in the source currency','Y','Y','Y','N','N','N','Y','N','Total Debit',240,TO_DATE('2012-07-23 11:29:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:34 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200205 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:35 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1640,101,200206,0,200007,TO_DATE('2012-07-23 11:29:34','YYYY-MM-DD HH24:MI:SS'),100,'Total Credit in document currency',26,'D','The Total Credit indicates the total credit amount for a journal or journal batch in the source currency','Y','Y','Y','N','N','N','Y','Y','Total Credit',250,TO_DATE('2012-07-23 11:29:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:35 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200206 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:35 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1627,101,200207,0,200007,TO_DATE('2012-07-23 11:29:35','YYYY-MM-DD HH24:MI:SS'),100,'The current status of the document',14,'D','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','Y','N','Y','Y','N','N','N','Y','N','Document Status',260,TO_DATE('2012-07-23 11:29:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:35 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200207 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:36 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1789,101,200208,0,200007,TO_DATE('2012-07-23 11:29:35','YYYY-MM-DD HH24:MI:SS'),100,'The targeted status of the document',23,'D','You find the current status in the Document Status field. The options are listed in a popup','Y','N','Y','N','N','N','N','N','Y','Document Action',270,TO_DATE('2012-07-23 11:29:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:36 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200208 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:29:36 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1629,200209,0,200007,TO_DATE('2012-07-23 11:29:36','YYYY-MM-DD HH24:MI:SS'),100,'Posting status',23,'@Processed@=Y & @#ShowAcct@=Y','D','The Posted field indicates the status of the Generation of General Ledger Accounting Lines ','Y','N','Y','Y','N','N','N','N','N','Posted',280,TO_DATE('2012-07-23 11:29:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:29:36 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200209 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:21 AM CEST
INSERT INTO AD_Tab (AD_Client_ID,AD_Org_ID,AD_Tab_ID,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,0,200008,226,200005,TO_DATE('2012-07-23 11:31:21','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','Y','N','N','Line','N',20,1,TO_DATE('2012-07-23 11:31:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:21 AM CEST
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, CommitWarning,Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.CommitWarning,t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jul 23, 2012 11:31:25 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1659,200210,0,200008,TO_DATE('2012-07-23 11:31:25','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Journal Line',14,'D','The General Ledger Journal Line identifies a single transaction in a journal.','Y','Y','N','N','N','N','N','N','Journal Line',0,TO_DATE('2012-07-23 11:31:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:25 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200210 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:26 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,56071,200211,0,200008,TO_DATE('2012-07-23 11:31:25','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','Y','N','N','N','N','N','N','Processed',0,0,TO_DATE('2012-07-23 11:31:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:26 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200211 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:26 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,12068,200212,0,200008,TO_DATE('2012-07-23 11:31:26','YYYY-MM-DD HH24:MI:SS'),100,'The document has been processed',1,'D','The Processed checkbox indicates that a document has been processed.','Y','N','Y','N','N','N','N','N','N','Processed',0,TO_DATE('2012-07-23 11:31:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:26 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200212 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:27 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1660,200213,0,200008,TO_DATE('2012-07-23 11:31:26','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',14,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','Y','N','Client',10,TO_DATE('2012-07-23 11:31:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:27 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200213 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:27 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1661,200214,0,200008,TO_DATE('2012-07-23 11:31:27','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',14,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','N','N','N','N','Y','Organization',20,TO_DATE('2012-07-23 11:31:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:27 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200214 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:28 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1667,200215,0,200008,TO_DATE('2012-07-23 11:31:27','YYYY-MM-DD HH24:MI:SS'),100,'General Ledger Journal',14,'D','The General Ledger Journal identifies a group of journal lines which represent a logical business transaction','Y','Y','Y','N','N','N','Y','N','Journal',30,TO_DATE('2012-07-23 11:31:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:28 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200215 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:28 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,1675,200216,0,200008,TO_DATE('2012-07-23 11:31:28','YYYY-MM-DD HH24:MI:SS'),100,'Unique line for this document',11,'D','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','Y','N','Y','Y','N','N','N','N','N','Line No',40,1,TO_DATE('2012-07-23 11:31:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:28 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200216 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:29 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1676,200217,0,200008,TO_DATE('2012-07-23 11:31:28','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',60,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',50,TO_DATE('2012-07-23 11:31:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:29 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200217 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:29 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1662,200218,0,200008,TO_DATE('2012-07-23 11:31:29','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','Y','N','Active',60,TO_DATE('2012-07-23 11:31:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:29 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200218 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:30 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsAllowCopy,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1795,200219,0,200008,TO_DATE('2012-07-23 11:31:29','YYYY-MM-DD HH24:MI:SS'),100,'This Line is generated',1,'D','The Generated checkbox identifies a journal line that was generated from a source document.  Lines could also be entered manually or imported.','Y','N','Y','Y','N','N','N','Y','Y','Generated',70,TO_DATE('2012-07-23 11:31:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:30 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200219 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:31 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1678,200220,0,200008,TO_DATE('2012-07-23 11:31:30','YYYY-MM-DD HH24:MI:SS'),100,'The Currency for this record',14,'D','Indicates the Currency to be used when processing or reporting on this record','Y','Y','Y','N','N','N','N','N','Currency',80,TO_DATE('2012-07-23 11:31:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:31 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200220 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:31 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,2336,200221,0,200008,TO_DATE('2012-07-23 11:31:31','YYYY-MM-DD HH24:MI:SS'),100,'Accounting Date',14,'@C_Currency_ID@!@$C_Currency_ID@','D','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.','Y','Y','Y','N','N','N','N','Y','Account Date',90,TO_DATE('2012-07-23 11:31:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:31 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200221 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:32 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,10296,200222,0,200008,TO_DATE('2012-07-23 11:31:31','YYYY-MM-DD HH24:MI:SS'),100,'Currency Conversion Rate Type',14,'@C_Currency_ID@!@$C_Currency_ID@','D','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.','Y','Y','Y','N','N','N','N','N','Currency Type',100,TO_DATE('2012-07-23 11:31:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:32 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200222 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:32 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200217,104,200223,0,200008,TO_DATE('2012-07-23 11:31:32','YYYY-MM-DD HH24:MI:SS'),100,'Account used',10,'D','The (natural) account used','Y','Y','Y','N','N','N','N','N','Account',110,TO_DATE('2012-07-23 11:31:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:32 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200223 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:33 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200219,200224,0,200008,TO_DATE('2012-07-23 11:31:32','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a Business Partner',10,'D','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Y','Y','Y','N','N','N','N','N','Business Partner ',120,TO_DATE('2012-07-23 11:31:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:33 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200224 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:33 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200216,200225,0,200008,TO_DATE('2012-07-23 11:31:33','YYYY-MM-DD HH24:MI:SS'),100,'Performing or initiating organization',10,'@$Element_OT@=Y','D','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.','Y','Y','Y','N','N','N','N','Y','Trx Organization',130,TO_DATE('2012-07-23 11:31:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:33 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200225 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:34 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200218,200226,0,200008,TO_DATE('2012-07-23 11:31:33','YYYY-MM-DD HH24:MI:SS'),100,'Business Activity',10,'@$Element_AY@=Y','D','Activities indicate tasks that are performed and used to utilize Activity based Costing','Y','Y','Y','N','N','N','N','N','Activity',140,TO_DATE('2012-07-23 11:31:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:34 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200226 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:34 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200220,200227,0,200008,TO_DATE('2012-07-23 11:31:34','YYYY-MM-DD HH24:MI:SS'),100,'Marketing Campaign',10,'@$Element_MC@=Y','D','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.','Y','Y','Y','N','N','N','N','Y','Campaign',150,TO_DATE('2012-07-23 11:31:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:35 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200227 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:35 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200224,200228,0,200008,TO_DATE('2012-07-23 11:31:35','YYYY-MM-DD HH24:MI:SS'),100,'Sales coverage region',10,'@$Element_SR@=Y','D','The Sales Region indicates a specific area of sales coverage.','Y','Y','Y','N','N','N','N','N','Sales Region',160,TO_DATE('2012-07-23 11:31:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:35 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200228 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:36 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200223,200229,0,200008,TO_DATE('2012-07-23 11:31:35','YYYY-MM-DD HH24:MI:SS'),100,'Financial Project',20,'@$Element_PJ@=Y','D','A Project allows you to track and control internal or external activities.','Y','Y','Y','N','N','N','N','Y','Project',170,TO_DATE('2012-07-23 11:31:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:36 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200229 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:36 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200225,200230,0,200008,TO_DATE('2012-07-23 11:31:36','YYYY-MM-DD HH24:MI:SS'),100,'Sub account for Element Value',10,'@$Element_SA@=Y','D','The Element Value (e.g. Account) may have optional sub accounts for further detail. The sub account is dependent on the value of the account, so a further specification. If the sub-accounts are more or less the same, consider using another accounting dimension.','Y','Y','Y','N','N','N','N','N','Sub Account',180,TO_DATE('2012-07-23 11:31:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:36 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200230 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:37 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200226,200231,0,200008,TO_DATE('2012-07-23 11:31:36','YYYY-MM-DD HH24:MI:SS'),100,'Product, Service, Item',10,'@$Element_PR@=Y','D','Identifies an item which is either purchased or sold in this organization.','Y','Y','Y','N','N','N','N','Y','Product',190,TO_DATE('2012-07-23 11:31:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:37 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200231 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:37 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200221,200232,0,200008,TO_DATE('2012-07-23 11:31:37','YYYY-MM-DD HH24:MI:SS'),100,'Location that inventory was moved from',10,'@$Element_LF@=Y','D','The Location From indicates the location that a product was moved from.','Y','Y','Y','N','N','N','N','N','Location From',200,TO_DATE('2012-07-23 11:31:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:37 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200232 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:38 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200222,200233,0,200008,TO_DATE('2012-07-23 11:31:37','YYYY-MM-DD HH24:MI:SS'),100,'Location that inventory was moved to',10,'@$Element_LT@=Y','D','The Location To indicates the location that a product was moved to.','Y','Y','Y','N','N','N','N','Y','Location To',210,TO_DATE('2012-07-23 11:31:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:38 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200233 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:38 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200229,200234,0,200008,TO_DATE('2012-07-23 11:31:38','YYYY-MM-DD HH24:MI:SS'),100,'User defined accounting Element',10,'@$Element_X1@=Y','D','A user defined accounting element refers to a Adempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Y','Y','Y','N','N','N','N','N','User Element 1',220,TO_DATE('2012-07-23 11:31:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:38 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200234 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:39 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200230,200235,0,200008,TO_DATE('2012-07-23 11:31:38','YYYY-MM-DD HH24:MI:SS'),100,'User defined accounting Element',10,'@$Element_X2@=Y','D','A user defined accounting element refers to a Adempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)','Y','Y','Y','N','N','N','N','Y','User Element 2',230,TO_DATE('2012-07-23 11:31:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:39 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200235 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:39 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200227,200236,0,200008,TO_DATE('2012-07-23 11:31:39','YYYY-MM-DD HH24:MI:SS'),100,'User defined list element #1',10,'@$Element_U1@=Y','D','The user defined element displays the optional elements that have been defined for this account combination.','Y','Y','Y','N','N','N','N','N','User List 1',240,TO_DATE('2012-07-23 11:31:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:39 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200236 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:40 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200228,200237,0,200008,TO_DATE('2012-07-23 11:31:39','YYYY-MM-DD HH24:MI:SS'),100,'User defined list element #2',10,'@$Element_U2@=Y','D','The user defined element displays the optional elements that have been defined for this account combination.','Y','Y','Y','N','N','N','N','Y','User List 2',250,TO_DATE('2012-07-23 11:31:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:40 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200237 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:40 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200231,200238,0,200008,TO_DATE('2012-07-23 11:31:40','YYYY-MM-DD HH24:MI:SS'),100,'Defines an alternate method of indicating an account combination.',10,'D','The Alias field allows you to define a alternate method for referring to a full account combination.  For example, the Account Receivable Account for Garden World may be aliased as GW_AR.','Y','Y','Y','N','N','N','N','N','Alias',260,TO_DATE('2012-07-23 11:31:40','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:40 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200238 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:41 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1806,200239,0,200008,TO_DATE('2012-07-23 11:31:40','YYYY-MM-DD HH24:MI:SS'),100,'Currency Conversion Rate',26,'@C_Currency_ID@!@$C_Currency_ID@','D','The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency','Y','Y','Y','N','N','N','Y','Y','Rate',270,TO_DATE('2012-07-23 11:31:40','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:41 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200239 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:41 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,5955,104,200240,0,200008,TO_DATE('2012-07-23 11:31:41','YYYY-MM-DD HH24:MI:SS'),100,'Valid Account Combination',26,'D','The Combination identifies a valid combination of element which represent a GL account.','Y','Y','Y','N','N','N','N','N','Combination',280,TO_DATE('2012-07-23 11:31:41','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:41 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200240 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:42 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,56070,200241,0,200008,TO_DATE('2012-07-23 11:31:42','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','Y','Y','N','N','N','N','Y','Asset Related?',290,0,TO_DATE('2012-07-23 11:31:42','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:42 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200241 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:43 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,56069,200242,0,200008,TO_DATE('2012-07-23 11:31:42','YYYY-MM-DD HH24:MI:SS'),100,'Asset used internally or by customers',22,'@A_CreateAsset@=''Y''','D','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.','Y','Y','Y','N','N','N','N','N','Asset',300,0,TO_DATE('2012-07-23 11:31:42','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:43 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200242 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:43 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,DisplayLogic,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,56068,200243,0,200008,TO_DATE('2012-07-23 11:31:43','YYYY-MM-DD HH24:MI:SS'),100,'Group of Assets',10,'@A_Asset_ID@<1&@A_CreateAsset@=''Y''','D','The group of assets determines default accounts.  If an asset group is selected in the product category, assets are created when delivering the asset.','Y','Y','Y','N','N','N','N','Y','Asset Group',310,0,TO_DATE('2012-07-23 11:31:43','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:43 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200243 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:44 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1679,103,200244,0,200008,TO_DATE('2012-07-23 11:31:43','YYYY-MM-DD HH24:MI:SS'),100,'Source Debit Amount',26,'D','The Source Debit Amount indicates the credit amount for this line in the source currency.','Y','Y','Y','N','N','N','N','N','Source Debit',320,TO_DATE('2012-07-23 11:31:43','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:44 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200244 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:44 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1680,103,200245,0,200008,TO_DATE('2012-07-23 11:31:44','YYYY-MM-DD HH24:MI:SS'),100,'Source Credit Amount',26,'D','The Source Credit Amount indicates the credit amount for this line in the source currency.','Y','Y','Y','N','N','N','N','Y','Source Credit',330,TO_DATE('2012-07-23 11:31:44','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:44 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200245 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:45 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1681,103,200246,0,200008,TO_DATE('2012-07-23 11:31:44','YYYY-MM-DD HH24:MI:SS'),100,'Accounted Debit Amount',26,'D','The Account Debit Amount indicates the transaction amount converted to this organization''s accounting currency','Y','Y','Y','N','N','N','Y','N','Accounted Debit',340,TO_DATE('2012-07-23 11:31:44','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:45 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200246 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:45 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1682,103,200247,0,200008,TO_DATE('2012-07-23 11:31:45','YYYY-MM-DD HH24:MI:SS'),100,'Accounted Credit Amount',26,'D','The Account Credit Amount indicates the transaction amount converted to this organization''s accounting currency','Y','Y','Y','N','N','N','Y','Y','Accounted Credit',350,TO_DATE('2012-07-23 11:31:45','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:45 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200247 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:46 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,2337,102,200248,0,200008,TO_DATE('2012-07-23 11:31:45','YYYY-MM-DD HH24:MI:SS'),100,'Unit of Measure',14,'D','The UOM defines a unique non monetary Unit of Measure','Y','Y','Y','N','N','N','N','N','UOM',360,TO_DATE('2012-07-23 11:31:45','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:46 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200248 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:46 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,2338,102,200249,0,200008,TO_DATE('2012-07-23 11:31:46','YYYY-MM-DD HH24:MI:SS'),100,'Quantity',26,'D','The Quantity indicates the number of a specific product or item for this document.','Y','Y','Y','N','N','N','N','Y','Quantity',370,TO_DATE('2012-07-23 11:31:46','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 11:31:46 AM CEST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200249 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 23, 2012 11:31:57 AM CEST
UPDATE AD_Tab SET Description='General Ledger Journal Line', Help='The GL Journal Line Tab defines the individual debit and credit transactions that comprise a journal.',Updated=TO_DATE('2012-07-23 11:31:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200008
;

-- Jul 23, 2012 11:31:57 AM CEST
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=200008
;

-- Jul 23, 2012 11:32:07 AM CEST
UPDATE AD_Tab SET Description='General Ledger Journal',Updated=TO_DATE('2012-07-23 11:32:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200007
;

-- Jul 23, 2012 11:32:07 AM CEST
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=200007
;

-- Jul 23, 2012 12:02:09 PM CEST
INSERT INTO AD_Menu (AD_Client_ID,AD_Menu_ID,AD_Org_ID,AD_Window_ID,Action,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsReadOnly,IsSOTrx,IsSummary,Name,Updated,UpdatedBy) VALUES (0,200008,0,200005,'W',TO_DATE('2012-07-23 12:02:08','YYYY-MM-DD HH24:MI:SS'),100,'Enter and change Manual Journal Entries','D','Y','Y','N','Y','N','GL Journal',TO_DATE('2012-07-23 12:02:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 23, 2012 12:02:09 PM CEST
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Menu_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Jul 23, 2012 12:02:09 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200008, 0, 999 FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200008)
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=164
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=280
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=158
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=522
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200008
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=118
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53288
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53289
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53290
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=169
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=433
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=352
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=434
;

-- Jul 23, 2012 12:02:13 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=435
;


UPDATE GL_JournalLine SET C_BPartner_ID = (SELECT C_BPartner_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET AD_OrgTrx_ID = (SELECT AD_OrgTrx_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET C_Activity_ID = (SELECT C_Activity_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET C_Campaign_ID = (SELECT C_Campaign_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET C_LocFrom_ID = (SELECT C_LocFrom_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET C_LocTo_ID = (SELECT C_LocTo_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET C_Project_ID = (SELECT C_Project_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET C_SalesRegion_ID = (SELECT C_SalesRegion_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET C_SubAcct_ID = (SELECT C_SubAcct_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET M_Product_ID = (SELECT M_Product_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET User1_ID = (SELECT User1_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET User2_ID = (SELECT User2_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET UserElement1_ID = (SELECT UserElement1_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);
UPDATE GL_JournalLine SET UserElement2_ID = (SELECT UserElement2_ID FROM C_ValidCombination vc WHERE vc.C_ValidCombination_ID = GL_JournalLine.C_ValidCombination_ID);

-- Jul 25, 2012 9:35:57 AM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutGLJournal.alias',Updated=TO_DATE('2012-07-25 09:35:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5955
;

-- Jul 25, 2012 9:37:29 AM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Help,EntityType,Name,Description,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200063,'Alias_ValidCombination_ID','The Combination identifies a valid combination of element which represent a GL account.','D','Alias List','Valid Account Alias List','Alias List',0,TO_DATE('2012-07-25 09:37:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-07-25 09:37:27','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Jul 25, 2012 9:37:29 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200063 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 25, 2012 9:38:00 AM COT
UPDATE AD_Column SET Help='The Combination identifies a valid combination of element which represent a GL account.', AD_Element_ID=200063, ColumnName='Alias_ValidCombination_ID', Description='Valid Account Alias List', Name='Alias List',Updated=TO_DATE('2012-07-25 09:38:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200231
;

-- Jul 25, 2012 9:38:00 AM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200231
;

-- Jul 25, 2012 9:38:00 AM COT
UPDATE AD_Field SET Name='Alias List', Description='Valid Account Alias List', Help='The Combination identifies a valid combination of element which represent a GL account.' WHERE AD_Column_ID=200231 AND IsCentrallyMaintained='Y'
;

-- Jul 25, 2012 9:38:08 AM COT
ALTER TABLE GL_JournalLine ADD Alias_ValidCombination_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 25, 2012 9:51:01 AM COT
UPDATE AD_Table SET AD_Window_ID=200005,Updated=TO_DATE('2012-07-25 09:51:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=224
;

-- Jul 25, 2012 9:51:13 AM COT
UPDATE AD_Table SET AD_Window_ID=200005,Updated=TO_DATE('2012-07-25 09:51:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=226
;

-- Jul 25, 2012 10:01:38 AM COT
UPDATE AD_Tab SET WhereClause=NULL,Updated=TO_DATE('2012-07-25 10:01:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200007
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200182
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200183
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200185
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200184
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200186
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200187
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200188
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200189
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200190
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200191
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200192
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200193
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200194
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200195
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200196
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200197
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200198
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200199
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200200
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200201
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200202
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200203
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200204
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200205
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200206
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=200207
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=200208
;

-- Jul 25, 2012 10:49:51 AM COT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200209
;

-- Jul 25, 2012 11:01:59 AM COT
INSERT INTO AD_Process (AD_Process_ID,IsDirectPrint,IsReport,AccessLevel,IsBetaFunctionality,IsServerProcess,ShowHelp,EntityType,Statistic_Seconds,Statistic_Count,Classname,Description,Value,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,CreatedBy,Created,IsActive) VALUES (200005,'N','N','1','N','N','Y','D',0,0,'org.compiere.process.CopyFromJournalDoc','Copy Journal/Lines from other Journal','GL_Journal CopyFrom','Copy Details',0,0,TO_DATE('2012-07-25 11:01:58','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2012-07-25 11:01:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jul 25, 2012 11:01:59 AM COT
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Jul 25, 2012 11:02:44 AM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,IsEncrypted,FieldLength,Help,AD_Process_ID,IsCentrallyMaintained,AD_Reference_ID,SeqNo,IsMandatory,AD_Element_ID,EntityType,Name,ColumnName,Description,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('N',200025,'N',0,'The General Ledger Journal identifies a group of journal lines which represent a logical business transaction',200005,'Y',30,10,'Y',315,'D','Journal','GL_Journal_ID','General Ledger Journal','Y',0,100,TO_DATE('2012-07-25 11:02:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-07-25 11:02:43','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 25, 2012 11:02:44 AM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200025 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Jul 25, 2012 11:03:20 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,AD_Process_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200232,224,'D',0,'N','N','N',0,'Copy From Record','N',1,'N',28,'N','N',2037,200005,'N','Y','N','Y','N','CopyFrom','Copy From Record','Copy From','Y',100,TO_DATE('2012-07-25 11:03:19','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-07-25 11:03:19','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 25, 2012 11:03:20 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200232 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 25, 2012 11:03:24 AM COT
ALTER TABLE GL_Journal ADD CopyFrom CHAR(1) DEFAULT NULL 
;

-- Jul 25, 2012 11:04:34 AM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',23,'Y','N','N',200232,'N',240,'Y',200007,200250,'N','Copy From Record','D','Copy From Record','Copy From',100,0,'Y',TO_DATE('2012-07-25 11:04:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-07-25 11:04:33','YYYY-MM-DD HH24:MI:SS'))
;

-- Jul 25, 2012 11:04:34 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200250 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 25, 2012 11:04:42 AM COT
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2012-07-25 11:04:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200209
;

-- Jul 25, 2012 11:05:03 AM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-07-25 11:05:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200209
;

-- Jul 25, 2012 11:23:39 AM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutGLJournal.account',Updated=TO_DATE('2012-07-25 11:23:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1661
;

-- Jul 25, 2012 12:43:48 PM COT
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2012-07-25 12:43:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14440
;

-- Jul 25, 2012 12:43:50 PM COT
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2012-07-25 12:43:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14441
;

-- Jul 25, 2012 12:43:56 PM COT
ALTER TABLE I_GLJournal MODIFY IsCreateNewBatch CHAR(1) DEFAULT 'N'
;

-- Jul 25, 2012 12:44:02 PM COT
ALTER TABLE I_GLJournal MODIFY IsCreateNewJournal CHAR(1) DEFAULT 'N'
;

-- Jul 25, 2012 1:01:43 PM COT
UPDATE AD_Field SET DisplayLogic='@GL_JournalBatch_ID@=0',Updated=TO_DATE('2012-07-25 13:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200208
;

UPDATE AD_System
  SET LastMigrationScriptApplied='855_IDEMPIERE-344_GLJournalImprovement.sql'
WHERE LastMigrationScriptApplied<'855_IDEMPIERE-344_GLJournalImprovement.sql'
   OR LastMigrationScriptApplied IS NULL
;
