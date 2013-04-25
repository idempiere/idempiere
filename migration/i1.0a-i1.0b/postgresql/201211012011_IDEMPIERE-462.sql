-- Oct 22, 2012 3:47:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','1',105,200031,'N','N','N','D','L','32bb4613-d058-44fb-9e5c-01f060281cc9','Y','Y','C_PaymentTransaction','Payment Transaction','Payment Transaction',0,'Y',0,TO_TIMESTAMP('2012-10-22 15:47:37','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2012-10-22 15:47:37','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 22, 2012 3:47:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200031 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Oct 22, 2012 3:47:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200029,'460a9bee-4780-4b89-99fe-70d07350a48c','Table C_PaymentTransaction','C_PaymentTransaction',1,0,0,TO_TIMESTAMP('2012-10-22 15:47:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-10-22 15:47:39','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Oct 22, 2012 3:47:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200710,'D','N','N','N','N',60,'N',10,'N',1350,'@IsApproved@=Y','N','Y','46ef934c-ac82-4804-86fe-382aa5dcb211','Y','N','A_City','City or the Credit Card or Account Holder','The Account City indicates the City of the Credit Card or Account holder','Account City','Y',100,TO_TIMESTAMP('2012-10-22 15:47:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:52','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200710 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:47:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200031,200711,'D','N','N','N',0,'N',40,'N',10,'N',1988,'@IsApproved@=Y','N','Y','570b9d91-a22e-4c3b-a1fa-e756bff046ee','Y','N','A_Country','Country','Account Country Name','Account Country','Y',100,TO_TIMESTAMP('2012-10-22 15:47:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:53','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200711 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:47:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200712,'D','N','N','N','N',60,'N',10,'N',1351,'@IsApproved@=Y','N','Y','22ebf03a-77cf-4993-b9ff-4d5804115401','Y','N','A_EMail','Email Address','The EMail Address indicates the EMail address off the Credit Card or Account holder.','Account EMail','Y',100,TO_TIMESTAMP('2012-10-22 15:47:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:53','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200712 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:47:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200713,'D','N','N','N','N',20,'N',10,'N',1352,'@IsApproved@=Y','N','Y','eb579fae-f5c6-47ab-ba99-ab7f968359b9','Y','N','A_Ident_DL','Payment Identification - Driver License','The Driver''s License being used as identification.','Driver License','Y',100,TO_TIMESTAMP('2012-10-22 15:47:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200713 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:47:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200714,'D','N','N','N','N',20,'N',10,'N',1353,'@IsApproved@=Y','N','Y','769af927-0406-445a-8912-3c92718d28ce','Y','N','A_Ident_SSN','Payment Identification - Social Security No','The Social Security number being used as identification.','Social Security No','Y',100,TO_TIMESTAMP('2012-10-22 15:47:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:55','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200714 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:47:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200715,'D','N','N','Y',4,'N',60,'Y',10,'N',1354,'@IsApproved@=Y','N','Y','cbd6039b-0050-4384-b026-91b808f57c67','Y','N','A_Name','Name on Credit Card or Account holder','The Name of the Credit Card or Account holder.','Account Name','Y',100,TO_TIMESTAMP('2012-10-22 15:47:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:56','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200715 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:47:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200716,'D','N','N','N','N',40,'N',10,'N',1355,'@IsApproved@=Y','N','Y','a8590cbc-0e79-4749-8073-084e9a53eef1','Y','N','A_State','State of the Credit Card or Account holder','The State of the Credit Card or Account holder','Account State','Y',100,TO_TIMESTAMP('2012-10-22 15:47:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:56','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200716 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:47:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200717,'D','N','N','N','N',60,'N',10,'N',1356,'@IsApproved@=Y','N','Y','8be37773-4216-4d64-9de5-58799e4b1cd2','Y','N','A_Street','Street address of the Credit Card or Account holder','The Street Address of the Credit Card or Account holder.','Account Street','Y',100,TO_TIMESTAMP('2012-10-22 15:47:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:57','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200717 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:47:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200718,'D','N','N','N','N',20,'N',10,'N',1357,'@IsApproved@=Y','N','Y','e292c969-7c3a-44e2-bcd5-156da7d8247f','Y','N','A_Zip','Zip Code of the Credit Card or Account Holder','The Zip Code of the Credit Card or Account Holder.','Account Zip/Postal','Y',100,TO_TIMESTAMP('2012-10-22 15:47:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:58','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:47:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200718 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200719,'D','N','N','N','N',20,'N',10,'N',840,'N','Y','b756dbb7-78f6-47e2-a368-71c0726d4d04','Y','N','AccountNo','Account Number','The Account Number indicates the Number assigned to this bank account. ','Account No','Y',100,TO_TIMESTAMP('2012-10-22 15:47:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:47:59','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200719 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200720,'D','Y','N','N','N',22,'N',19,129,'N',102,'N','Y','ae408115-7c3c-4106-b33d-5603df1c2bbf','N','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_TIMESTAMP('2012-10-22 15:48:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:00','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200720 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200721,'D','Y','N','N','N',22,'N',19,130,'N',113,'N','Y','687bb13a-277c-401c-ad13-6a55de99b57a','N','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_TIMESTAMP('2012-10-22 15:48:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:00','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200721 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200722,'D',130,'N','N','N',0,'N',22,'N',18,'N',112,'N','Y','0d1e932f-c50b-48e4-a3af-8163fd33d638','Y','N','AD_OrgTrx_ID','Performing or initiating organization','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.','Trx Organization','Y',100,TO_TIMESTAMP('2012-10-22 15:48:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:01','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200722 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200723,'D','N','N','N',0,'N',22,'N',19,'N',1005,'N','Y','bb369700-f7a7-4ecd-bb2d-0fab3bc9cb27','Y','N','C_Activity_ID','Business Activity','Activities indicate tasks that are performed and used to utilize Activity based Costing','Activity','Y',100,TO_TIMESTAMP('2012-10-22 15:48:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:02','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200723 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200724,'D','N','N','N','N',22,'N',19,'N',836,'N','Y','1fbe1126-bb87-4e6e-bbb5-207961201c96','Y','N','C_BankAccount_ID','Account at the Bank','The Bank Account identifies an account at this Bank.','Bank Account','Y',100,TO_TIMESTAMP('2012-10-22 15:48:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:03','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200724 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200725,'D','N','N','N','N',22,'N',19,'N',837,'N','Y','8c2467ab-f29b-47f3-a591-c4a130015962','Y','N','C_BP_BankAccount_ID','Bank Account of the Business Partner','The Partner Bank Account identifies the bank account to be used for this Business Partner','Partner Bank Account','Y',100,TO_TIMESTAMP('2012-10-22 15:48:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200725 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200726,'D','Y','N','N','N',22,'N',30,230,'N',187,'N','Y','3fc9eaa3-e210-432e-948c-3406990ce982','Y','N','C_BPartner_ID','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Business Partner ','Y',100,TO_TIMESTAMP('2012-10-22 15:48:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200726 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200727,'D','N','N','N',0,'N',22,'N',19,'N',550,'N','Y','ea57afe3-6462-4734-81d2-fbdf4a4e16d2','Y','N','C_Campaign_ID','Marketing Campaign','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.','Campaign','Y',100,TO_TIMESTAMP('2012-10-22 15:48:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:05','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200727 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200031,200728,'D','N','N','N','N',10,'N',19,'N',1463,'N','Y','0573cfa6-5b8d-4585-8961-0308a573d323','Y','N','C_CashBook_ID','Cash Book for recording petty cash transactions','The Cash Book identifies a unique cash book.  The cash book is used to record cash transactions.','Cash Book','Y',100,TO_TIMESTAMP('2012-10-22 15:48:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:06','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200728 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200729,'D','N','N','N',0,'N',22,'N',19,52029,'N',968,'@C_Invoice_ID@!0 | @C_Order_ID@!0','N','Y','aef7d5f9-95f5-4461-85b9-9987ca107619','Y','org.compiere.model.CalloutPayment.charge','N','C_Charge_ID','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)','Charge','Y',100,TO_TIMESTAMP('2012-10-22 15:48:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:07','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200729 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200730,'D','N','N','N',0,'N',22,'N',19,'N',2278,'N','Y','18da8ca0-d563-46ff-b090-78aed6bb7daf','Y','org.compiere.model.CalloutPayment.amounts','N','C_ConversionType_ID','Currency Conversion Rate Type','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.','Currency Type','Y',100,TO_TIMESTAMP('2012-10-22 15:48:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:08','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200730 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200731,'D','Y','N','N','N',22,'N',19,'N',193,'N','Y','a7d12fa7-c5c2-477d-a7f8-ddb3524771b9','Y','org.compiere.model.CalloutPayment.amounts','N','C_Currency_ID','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record','Currency','Y',100,TO_TIMESTAMP('2012-10-22 15:48:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:08','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200731 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200732,'D','Y','N','N','N',22,'N',19,149,'N',196,'N','Y','ce2ecbfc-465b-4f3c-83e2-a2169ab191f0','Y','org.compiere.model.CalloutPayment.docType','N','C_DocType_ID','Document type or rules','The Document Type determines document sequence and processing rules','Document Type','Y',100,TO_TIMESTAMP('2012-10-22 15:48:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200732 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200733,'D','N','N','N','N',22,'N',30,220,'N',1008,'@C_Order_ID@!0 | @C_Charge_ID@!0','N','Y','feff58ad-9c5a-4de9-8e6f-7c655facbdf3','Y','org.compiere.model.CalloutPayment.invoice','N','C_Invoice_ID','Invoice Identifier','The Invoice Document.','Invoice','Y',100,TO_TIMESTAMP('2012-10-22 15:48:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:10','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200733 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200734,'D','N','N','N',0,'N',22,'N',30,218,'N',558,'@C_Invoice_ID@!0 | @C_Charge_ID@!0','N','Y','116a8f83-f975-4710-96a2-ac1e2a9aef2d','Y','org.compiere.model.CalloutPayment.order','N','C_Order_ID','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','Order','Y',100,TO_TIMESTAMP('2012-10-22 15:48:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200734 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('C_PaymentTransaction_ID',200193,'D','Payment Transaction','Payment Transaction','3fcc2843-1709-40bd-b276-edc04b0897b2',0,TO_TIMESTAMP('2012-10-22 15:48:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-22 15:48:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 22, 2012 3:48:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200193 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 22, 2012 3:48:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200735,'D','Y','N','N','N',22,'N',13,'Y',200193,'N','Y','00d74068-9b5c-4df6-b7d4-96a440b57191','N','N','C_PaymentTransaction_ID','Payment Transaction','N',100,TO_TIMESTAMP('2012-10-22 15:48:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:12','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200735 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('C_PaymentTransaction_UU',200194,'D','C_PaymentTransaction_UU','C_PaymentTransaction_UU','78eb3c12-29f2-4101-84bc-dee2aad09595',0,TO_TIMESTAMP('2012-10-22 15:48:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-22 15:48:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 22, 2012 3:48:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200194 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 22, 2012 3:48:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1.00,'N','N',200031,200736,'D','N','N','N','N',36,'N',10,'N',200194,'N','Y','0982ee32-2a59-45ad-884c-fd7293a347b0','Y','N','C_PaymentTransaction_UU','C_PaymentTransaction_UU','N',100,TO_TIMESTAMP('2012-10-22 15:48:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:13','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200736 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200737,'D','N','N','N','N',22,'N',19,'N',1465,'N','Y','e5b79852-a9b5-416f-9cb1-f73cff78da75','Y','N','C_PaymentBatch_ID','Payment batch for EFT','Electronic Fund Transfer Payment Batch.','Payment Batch','Y',100,TO_TIMESTAMP('2012-10-22 15:48:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:15','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200737 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200738,'D','N','N','N',0,'N',10,'N',19,'N',1385,'N','Y','ad6f896d-375c-4e20-b8bc-1b3c7317a97a','Y','N','C_PaymentProcessor_ID','Payment processor for electronic payments','The Payment Processor indicates the processor to be used for electronic payments','Payment Processor','Y',100,TO_TIMESTAMP('2012-10-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:48:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200738 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200739,'D','N','N','N',0,'N',10,'N',19,'N',200118,'N','Y','6df638c5-6f60-45cd-8e3b-ed29168541a7','Y','N','C_POSTenderType_ID','POS Tender Type','Y',100,TO_TIMESTAMP('2012-10-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:16','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:48:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200739 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200740,'D','N','N','N',0,'N',22,'N',19,'N',208,'N','Y','36ab18d7-592d-4381-b5c4-f7dc214b46db','Y','N','C_Project_ID','Financial Project','A Project allows you to track and control internal or external activities.','Project','Y',100,TO_TIMESTAMP('2012-10-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200740 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200741,'D','N','N','N',0,'N',22,'N',12,'N',849,'N','Y','e1b53cdf-1d35-4eb8-8750-d2454e3e4642','Y','N','ChargeAmt','Charge Amount','The Charge Amount indicates the amount for an additional charge.','Charge amount','Y',100,TO_TIMESTAMP('2012-10-22 15:48:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200741 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200742,'D','N','N','N','N',20,'N',10,'N',1389,'N','Y','f88d18b3-8e40-48ae-9a2b-79c06be83ec4','Y','N','CheckNo','Check Number','The Check Number indicates the number on the check.','Check No','Y',100,TO_TIMESTAMP('2012-10-22 15:48:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200742 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200743,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','409feb56-80b4-42c7-88d2-f95f2f8c965d','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_TIMESTAMP('2012-10-22 15:48:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200743 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200744,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','feda4da1-310a-4b04-9542-dc472c337542','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_TIMESTAMP('2012-10-22 15:48:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200744 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,ValueMin,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,ValueMax,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'1','N','N',200031,200745,'12','D','N','N','N','N',22,'N',11,'N',1084,'@IsApproved@=Y','N','Y','4dfa58e5-05ff-438d-ba5d-97c2a96fb2ea','Y','N','CreditCardExpMM','Expiry Month','1','The Expiry Month indicates the expiry month for this credit card.','Exp. Month','Y',100,TO_TIMESTAMP('2012-10-22 15:48:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200745 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,ValueMin,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'3','N','N',200031,200746,'D','N','N','N','N',22,'N',11,'N',1085,'@IsApproved@=Y','N','Y','3aa62084-2dcd-4f19-aac9-6f27dc2992cb','Y','N','CreditCardExpYY','Expiry Year','03','The Expiry Year indicates the expiry year for this credit card.','Exp. Year','Y',100,TO_TIMESTAMP('2012-10-22 15:48:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:22','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200746 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200747,'D','N','N','N','N',20,'N',10,'N',249,'@IsApproved@=Y','N','Y','da8586bb-3714-4404-9474-18f6a754536e','Y','N','CreditCardNumber','Credit Card Number ','The Credit Card number indicates the number on the credit card, without blanks or spaces.','Number','Y',100,TO_TIMESTAMP('2012-10-22 15:48:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:23','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200747 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200748,'D',149,'N','N','N','N',1,'N',17,'N',1012,'@IsApproved@=Y','N','Y','737f2f3a-d761-4a79-902f-7d0e48db4750','Y','N','CreditCardType','Credit Card (Visa, MC, AmEx)','M','The Credit Card drop down list box is used for selecting the type of Credit Card presented for payment.','Credit Card','Y',100,TO_TIMESTAMP('2012-10-22 15:48:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:24','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200748 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200749,'D','N','N','N','N',4,'N',10,'N',1393,'@IsApproved@=Y','N','Y','885f05f3-82c5-4bcc-9733-e1a7136e994e','Y','N','CreditCardVV','Credit Card Verification code on credit card','The Credit Card Verification indicates the verification code on the credit card (AMEX 4 digits on front; MC,Visa 3 digits back)','Verification Code','Y',100,TO_TIMESTAMP('2012-10-22 15:48:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:24','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200749 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200750,'D','N','N','N',0,'N',60,'N',10,'N',200179,'N','Y','86f7d709-e700-4156-8ddd-f830ebe34d9a','Y','N','CustomerAddressID','Customer Address ID','Y',100,TO_TIMESTAMP('2012-10-22 15:48:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:25','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:48:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200750 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200751,'D','N','N','N',0,'N',60,'N',10,'N',200177,'N','Y','4f2d50ea-84a6-44a9-aa96-6a6f32f6aefe','Y','N','CustomerPaymentProfileID','Customer Payment Profile ID','Y',100,TO_TIMESTAMP('2012-10-22 15:48:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:26','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:48:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200751 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200752,'D','N','N','N',0,'N',60,'N',10,'N',200178,'N','Y','5db095bb-dab3-44be-b62e-b639d1e1fc83','Y','N','CustomerProfileID','Customer Profile ID','Y',100,TO_TIMESTAMP('2012-10-22 15:48:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:27','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:48:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200752 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200753,'D','Y','N','N',0,'N',7,'N',15,'N',263,'N','Y','dd4121a7-ee5c-4702-b145-4b8635c8225f','Y','N','DateAcct','Accounting Date','@#Date@','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.','Account Date','Y',100,TO_TIMESTAMP('2012-10-22 15:48:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:28','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200753 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200754,'D','Y','N','Y',2,'N',7,'N',15,'N',1297,'N','Y','c14c23c5-724c-4e01-a390-94e837ca483d','Y','org.compiere.model.CalloutEngine.dateAcct','N','DateTrx','Transaction Date','@#Date@','The Transaction Date indicates the date of the transaction.','Transaction Date','Y',100,TO_TIMESTAMP('2012-10-22 15:48:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:28','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200754 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200755,'D','N','N','N',0,'N',255,'Y',10,'N',275,'N','Y','b7c28c94-c33f-46ee-86f9-73140a94c43d','Y','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_TIMESTAMP('2012-10-22 15:48:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:29','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200755 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200756,'D','N','N','N','N',22,'N',12,'N',1395,'@C_Charge_ID@!0 | @C_Order_ID@!0','N','Y','b3ae375f-bf47-4a2c-9dfc-0cf09985d103','Y','org.compiere.model.CalloutPayment.amounts','N','DiscountAmt','Calculated amount of discount','0','The Discount Amount indicates the discount amount for a document or line.','Discount Amount','Y',100,TO_TIMESTAMP('2012-10-22 15:48:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:30','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200756 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200757,'D',135,'Y','N','N','N',2,'N',28,'N',287,149,'N','Y','8487912f-6fb8-4e0d-980b-446616daea54','Y','N','DocAction','The targeted status of the document','CO','You find the current status in the Document Status field. The options are listed in a popup','Document Action','Y',100,TO_TIMESTAMP('2012-10-22 15:48:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Oct 22, 2012 3:48:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200757 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200758,'D',131,'Y','N','N','N',2,'N',17,'N',289,'N','Y','3f9c72de-89f3-4375-89a6-0a55989231f8','Y','N','DocStatus','The current status of the document','DR','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','Document Status','Y',100,TO_TIMESTAMP('2012-10-22 15:48:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:32','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200758 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200759,'D','Y','N','Y',1,'N',30,'Y',10,'N',290,'N','Y','5032fe1f-3113-4616-b866-146a07d70c1a','Y','N','DocumentNo','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Document No','Y',100,TO_TIMESTAMP('2012-10-22 15:48:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:32','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200759 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200760,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','cb8c50a7-55df-45d9-a0c4-33a0be77ea8d','Y','N','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_TIMESTAMP('2012-10-22 15:48:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:33','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200760 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200761,'D','Y','N','N','N',1,'N',20,'N',1508,'N','Y','e102c684-a521-4abb-a62d-0bb84d6abf75','Y','N','IsAllocated','Indicates if the payment has been allocated','The Allocated checkbox indicates if a payment has been allocated or associated with an invoice or invoices.','Allocated','Y',100,TO_TIMESTAMP('2012-10-22 15:48:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200761 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200762,'D','Y','N','N','N',1,'N',20,'N',351,'N','Y','64ff7017-abaa-4af9-afd3-fa2286b384c1','N','N','IsApproved','Indicates if this document requires approval','N','The Approved checkbox indicates if this document requires approval before it can be processed.','Approved','Y',100,TO_TIMESTAMP('2012-10-22 15:48:35','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:35','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200762 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200763,'D','Y','N','N',0,'N',1,'N',20,'N',2107,'N','Y','dc74a389-e7bd-481b-a392-4e666c2bb962','Y','N','IsDelayedCapture','Charge after Shipment','Delayed Capture is required, if you ship products.  The first credit card transaction is the Authorization, the second is the actual transaction after the shipment of the product.','Delayed Capture','Y',100,TO_TIMESTAMP('2012-10-22 15:48:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200763 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200764,'D','Y','N','N','N',1,'N',20,'N',1401,'@IsApproved@=Y','N','Y','420209d2-ac54-4745-81f9-71e33410f38f','Y','N','IsOnline','Can be accessed online ','The Online Access check box indicates if the application can be accessed via the web. ','Online Access','Y',100,TO_TIMESTAMP('2012-10-22 15:48:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200764 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200031,200765,'D','Y','N','N',0,'N',1,'N',20,'N',1818,'@C_Charge_ID@!0 | @C_Order_ID@!0','N','Y','a6b2e64b-05e4-415f-ba60-16da58a9bc71','Y','org.compiere.model.CalloutPayment.amounts','N','IsOverUnderPayment','Over-Payment (unallocated) or Under-Payment (partial payment)','Y','Overpayments (negative) are unallocated amounts and allow you to receive money for more than the particular invoice. 
Underpayments (positive) is a partial payment for the invoice. You do not write off the unpaid amount.','Over/Under Payment','Y',100,TO_TIMESTAMP('2012-10-22 15:48:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200765 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200766,'D','Y','N','N',0,'N',1,'N',20,'N',2663,'N','Y','1aa84638-3d72-486c-87df-1aa5ba9afae6','Y','N','IsPrepayment','The Payment/Receipt is a Prepayment','Payments not allocated to an invoice with a charge are posted to Unallocated Payments. When setting this flag, the payment is posted to the Customer or Vendor Prepayment account.','Prepayment','Y',100,TO_TIMESTAMP('2012-10-22 15:48:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:38','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200766 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200767,'D','Y','N','N',0,'N',1,'N',20,'N',1634,'N','Y','ca52dd20-fe19-4b6e-97c0-5695352d487e','Y','N','IsReceipt','This is a sales transaction (receipt)','Receipt','Y',100,TO_TIMESTAMP('2012-10-22 15:48:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200767 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200768,'D','Y','N','N','N',1,'N',20,'N',1105,'N','Y','2674b016-b973-4259-a0d0-4d2e8d0f3c38','Y','N','IsReconciled','Payment is reconciled with bank statement','Reconciled','Y',100,TO_TIMESTAMP('2012-10-22 15:48:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200768 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200769,'D','Y','N','N',0,'N',1,'N',20,'N',2063,'N','Y','3f297a90-ca4a-444e-a2d8-583ec60d1580','Y','N','IsSelfService','This is a Self-Service entry or this entry can be changed via Self-Service','Self-Service allows users to enter data or update their data.  The flag indicates, that this record was entered or created via Self-Service or that the user can change it via the Self-Service functionality.','Self-Service','Y',100,TO_TIMESTAMP('2012-10-22 15:48:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200769 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200770,'D','Y','N','N',0,'N',1,'N',20,'N',200180,'N','Y','4f425eba-f670-418c-a98b-5b520fc92873','Y','N','IsVoided','N','Voided','Y',100,TO_TIMESTAMP('2012-10-22 15:48:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:41','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:48:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200770 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200771,'D','N','N','N','N',20,'N',10,'N',1407,'N','Y','ba8d5e9b-1ac4-4866-bfcf-fc7382e5f2cf','Y','N','Micr','Combination of routing no, account and check no','The Micr number is the combination of the bank routing number, account number and check number','Micr','Y',100,TO_TIMESTAMP('2012-10-22 15:48:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:42','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200771 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Process_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200772,'D','N','N','N','N',1,'N',28,'N',1497,153,'@IsApproved@=Y','N','Y','e8642ac7-7660-403f-8ed3-68a60a716d22','Y','N','OProcessing','This payment can be processed online','The Online Processing indicates if the payment can be processed online.','Online Processing','Y',100,TO_TIMESTAMP('2012-10-22 15:48:43','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:43','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Oct 22, 2012 3:48:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200772 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200773,'D','N','N','N','N',20,'N',10,'N',1409,'@IsApproved@=Y','N','Y','2501e80c-e346-4f6e-8074-469144c658d0','Y','N','Orig_TrxID','Original Transaction ID','The Original Transaction ID is used for reversing transactions and indicates the transaction that has been reversed.','Original Transaction ID','Y',100,TO_TIMESTAMP('2012-10-22 15:48:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:44','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200773 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200031,200774,'D','N','N','N',0,'N',22,'N',12,'N',1819,'@C_Charge_ID@!0 | @C_Order_ID@!0','N','Y','a8193013-3638-4ee7-86ad-0fcb064c28eb','Y','org.compiere.model.CalloutPayment.amounts','N','OverUnderAmt','Over-Payment (unallocated) or Under-Payment (partial payment) Amount','0','Overpayments (negative) are unallocated amounts and allow you to receive money for more than the particular invoice. 
Underpayments (positive) is a partial payment for the invoice. You do not write off the unpaid amount.','Over/Under Payment','Y',100,TO_TIMESTAMP('2012-10-22 15:48:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:44','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200774 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200775,'D','Y','N','Y',3,'N',22,'N',12,'N',1477,'N','Y','f064969f-1ce3-4def-999a-ab459a67e547','Y','org.compiere.model.CalloutPayment.amounts','N','PayAmt','Amount being paid','0','Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','Payment amount','Y',100,TO_TIMESTAMP('2012-10-22 15:48:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:45','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200775 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200776,'D','N','N','N','N',60,'N',10,'N',1415,'N','Y','1950f587-ee76-41d0-9870-c4671952930e','Y','N','PONum','Purchase Order Number','The PO Number indicates the number assigned to a purchase order','PO Number','Y',100,TO_TIMESTAMP('2012-10-22 15:48:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:46','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200776 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200777,'D',234,'Y','N','N','N',1,'N',28,'N',1308,'N','Y','aa149854-4173-46c9-a1d6-e841e2039edf','Y','N','Posted','Posting status','N','The Posted field indicates the status of the Generation of General Ledger Accounting Lines ','Posted','Y',100,TO_TIMESTAMP('2012-10-22 15:48:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Oct 22, 2012 3:48:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200777 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200778,'D','Y','N','N','N',1,'N',20,'N',1047,'N','Y','8f725293-be09-4ca6-92ed-182dc95ebc34','Y','N','Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.','Processed','Y',100,TO_TIMESTAMP('2012-10-22 15:48:48','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:48','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200778 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200031,200779,'D','N','N','N',0,'N',20,'N',22,'N',54128,'N','Y','7b457328-ec8e-4f1a-aaf9-049ccbea6487','Y','N','ProcessedOn','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.','Processed On','N',100,TO_TIMESTAMP('2012-10-22 15:48:48','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:48','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200779 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200780,'D','N','N','N','N',1,'N',28,'N',524,149,'N','Y','9ba9d147-e1c2-4fdf-8bc3-3ec4c7032642','Y','N','Processing','Process Now','N',100,TO_TIMESTAMP('2012-10-22 15:48:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:49','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Oct 22, 2012 3:48:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200780 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200781,'D','N','N','N','N',20,'N',10,'N',1422,'N','Y','e800689d-40cd-4911-8136-011543481e75','N','N','R_AuthCode','Authorization Code returned','The Authorization Code indicates the code returned from the electronic transmission.','Authorization Code','Y',100,TO_TIMESTAMP('2012-10-22 15:48:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:50','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200781 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200782,'D','N','N','N',0,'N',20,'N',10,'N',2119,'N','Y','4e411eac-be1c-46f5-80c1-5f2764dcb537','N','N','R_AuthCode_DC','Authorization Code Delayed Capture returned','The Authorization Code indicates the code returned from the electronic transmission.','Authorization Code (DC)','Y',100,TO_TIMESTAMP('2012-10-22 15:48:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:51','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200782 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200783,'D',213,'N','N','N','N',1,'N',17,'N',1423,'N','Y','6ef3cf1b-d5dd-48b1-a8af-124942c94edc','N','N','R_AvsAddr','This address has been verified','The Address Verified indicates if the address has been verified by the Credit Card Company.','Address verified','Y',100,TO_TIMESTAMP('2012-10-22 15:48:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:52','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200783 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200784,'D',213,'N','N','N','N',1,'N',17,'N',1424,'N','Y','cef8899e-bd2f-4042-af19-6d21d1d11db1','N','N','R_AvsZip','The Zip Code has been verified','The Zip Verified indicates if the zip code has been verified by the Credit Card Company.','Zip verified','Y',100,TO_TIMESTAMP('2012-10-22 15:48:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:52','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200784 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200785,'D','N','N','N',0,'N',1,'N',20,'N',2120,'N','Y','cc64accd-c2b7-412d-86d5-a9846f7478b0','N','N','R_CVV2Match','Credit Card Verification Code Match','The Credit Card Verification Code was matched','CVV Match','Y',100,TO_TIMESTAMP('2012-10-22 15:48:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:53','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200785 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200786,'D','N','N','N','N',2000,'N',10,'N',1425,'N','Y','c3556ab2-8b70-4d5e-99cc-2459a9826a17','N','N','R_Info','Response info','The Info indicates any response information returned from the Credit Card Company.','Info','Y',100,TO_TIMESTAMP('2012-10-22 15:48:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200786 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200787,'D','N','N','N','N',20,'N',10,'N',1426,'N','Y','cfa321e1-925a-45f3-8f6b-9bf634500178','N','N','R_PnRef','Payment reference','The Payment Reference indicates the reference returned from the Credit Card Company for a payment','Reference','Y',100,TO_TIMESTAMP('2012-10-22 15:48:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:55','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200787 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200788,'D','N','N','N',0,'N',20,'N',10,'N',2121,'N','Y','3b46f7dc-89ce-4968-b7d3-977670e483e4','N','N','R_PnRef_DC','Payment Reference Delayed Capture','The Payment Reference indicates the reference returned from the Credit Card Company for a payment','Reference (DC)','Y',100,TO_TIMESTAMP('2012-10-22 15:48:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:56','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200788 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200789,'D','N','N','N','N',60,'N',10,'N',1427,'N','Y','e057d00d-4376-42e3-bbed-642dfbf93792','N','N','R_RespMsg','Response message','The Response Message indicates the message returned from the Credit Card Company as the result of a transmission','Response Message','Y',100,TO_TIMESTAMP('2012-10-22 15:48:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:56','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200789 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200790,'D','N','N','N','N',20,'N',10,'N',1428,'N','Y','a0f682c2-e609-41db-a52b-5f6659231e9b','N','N','R_Result','Result of transmission','The Response Result indicates the result of the transmission to the Credit Card Company.','Result','Y',100,TO_TIMESTAMP('2012-10-22 15:48:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:57','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200790 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200791,'D','N','N','N',0,'N',255,'N',14,'N',200181,'N','Y','72cba648-45f2-49f7-a16e-48d16d92b932','Y','N','R_VoidMsg','Void Message','Y',100,TO_TIMESTAMP('2012-10-22 15:48:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:58','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:48:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200791 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:48:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200031,200792,'D',343,'N','N','N','N',10,'N',18,'N',2753,'N','Y','f2f48ea3-c189-46df-a5b3-edf0c6a0ab0f','N','N','Ref_Payment_ID','Referenced Payment','Y',100,TO_TIMESTAMP('2012-10-22 15:48:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:59','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:48:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200792 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200031,200793,'D',343,'N','N','N',0,'N',22,'N',18,'N',53457,'N','Y','d1036224-e1af-49ff-8d91-dc8776631893','Y','N','Reversal_ID','ID of document reversal','Reversal ID','N',100,TO_TIMESTAMP('2012-10-22 15:48:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:48:59','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200793 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200794,'D','N','N','N','N',20,'N',10,'N',964,'N','Y','1c2bcf87-7212-4332-8f3a-8bb62d9c4613','Y','N','RoutingNo','Bank Routing Number','The Bank Routing Number (ABA Number) identifies a legal Bank.  It is used in routing checks and electronic transactions.','Routing No','Y',100,TO_TIMESTAMP('2012-10-22 15:49:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:00','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200794 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200795,'D','N','N','N',0,'N',80,'N',10,'N',2125,'N','Y','a05913ae-6abd-4b00-bcc3-f30856aa4299','N','N','Swipe','Track 1 and 2 of the Credit Card','Swiped information for Credit Card Presence Transactions','Swipe','Y',100,TO_TIMESTAMP('2012-10-22 15:49:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:01','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200795 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200796,'D','N','N','N',0,'N',22,'N',12,'N',1133,'N','Y','742ae3fa-9494-49c8-bec4-04d293e73b07','Y','N','TaxAmt','Tax Amount for a document','The Tax Amount displays the total tax amount for a document.','Tax Amount','Y',100,TO_TIMESTAMP('2012-10-22 15:49:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:02','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200796 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200797,'D',214,'Y','N','N','N',1,'N',17,'N',1441,'@IsApproved@=Y','N','Y','09943175-3d23-48dc-bad5-7e84b9980382','Y','N','TenderType','Method of Payment','K','The Tender Type indicates the method of payment (ACH or Direct Deposit, Credit Card, Check, Direct Debit)','Tender type','Y',100,TO_TIMESTAMP('2012-10-22 15:49:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:03','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200797 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200798,'D',215,'Y','N','N','N',1,'N',17,'N',1295,'N','Y','7c9eb082-5c06-4285-95e4-f838fc74a183','Y','N','TrxType','Type of credit card transaction','S','The Transaction Type indicates the type of transaction to be submitted to the Credit Card Company.','Transaction Type','Y',100,TO_TIMESTAMP('2012-10-22 15:49:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:03','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200798 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200799,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','655288fe-6b9d-49d8-9f5c-18835663d0c3','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_TIMESTAMP('2012-10-22 15:49:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200799 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200800,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','c8ae3dd6-7ed8-4fb6-a0f0-a67f8797cc63','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_TIMESTAMP('2012-10-22 15:49:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:05','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200800 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200801,'D',134,'N','N','N',0,'N',22,'N',18,'N',613,'N','Y','8ac5c278-13b9-417f-8da9-4b7dd9c39aaa','Y','N','User1_ID','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.','User List 1','Y',100,TO_TIMESTAMP('2012-10-22 15:49:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:06','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200801 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200802,'D',137,'N','N','N',0,'N',22,'N',18,'N',614,'N','Y','bf87510b-af74-4467-a9c5-788dba135e38','Y','N','User2_ID','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.','User List 2','Y',100,TO_TIMESTAMP('2012-10-22 15:49:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:07','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200802 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200803,'D','N','N','N','N',20,'N',10,'N',1445,'@IsApproved@=Y','N','Y','bf2288c1-6e5c-4d58-9ced-4ce43ab60d0d','Y','N','VoiceAuthCode','Voice Authorization Code from credit card company','The Voice Authorization Code indicates the code received from the Credit Card Company.','Voice authorization code','Y',100,TO_TIMESTAMP('2012-10-22 15:49:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:07','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200803 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:49:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200031,200804,'D','N','N','N',0,'N',22,'N',12,'N',1450,'@C_Charge_ID@!0 | @C_Order_ID@!0','N','Y','12cee0a1-d391-4b03-ad6e-145f9d9b51e7','Y','org.compiere.model.CalloutPayment.amounts','N','WriteOffAmt','Amount to write-off','0','The Write Off Amount indicates the amount to be written off as uncollectible.','Write-off Amount','Y',100,TO_TIMESTAMP('2012-10-22 15:49:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:49:08','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 22, 2012 3:49:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200804 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200741
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200741
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200753
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200753
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200756
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200756
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200757
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200757
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200758
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200758
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200759
;

-- Oct 22, 2012 3:53:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200759
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200761
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200761
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200765
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200765
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200766
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200766
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200768
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200768
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200772
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200772
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200774
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200774
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200777
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200777
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200778
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200778
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200779
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200779
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200780
;

-- Oct 22, 2012 3:53:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200780
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200782
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200782
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200788
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200788
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200792
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200792
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200793
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200793
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200795
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200795
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200804
;

-- Oct 22, 2012 3:53:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200804
;

-- Oct 22, 2012 3:53:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200805,'U','N','N','N',0,'N',10,'N',30,'N',1384,'N','Y','2b3a608e-f460-42eb-99e7-b0b0588d6306','Y','N','C_Payment_ID','Payment identifier','The Payment is a unique identifier of this payment.','Payment','Y',100,TO_TIMESTAMP('2012-10-22 15:53:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:53:34','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:53:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200805 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:54:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Ref_PaymentTransaction_ID',200195,'D','Referenced Payment Transaction','Referenced Payment Transaction','fa18fa3d-497f-45ee-af57-71180602b970',0,TO_TIMESTAMP('2012-10-22 15:54:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-22 15:54:01','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 22, 2012 3:54:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200195 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 22, 2012 3:54:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200014,'C_PaymentTransaction','D','7fa2e8b3-8ba7-44fa-a532-3355610b28d4','N','T',0,0,100,TO_TIMESTAMP('2012-10-22 15:54:47','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2012-10-22 15:54:47','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 22, 2012 3:54:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Oct 22, 2012 3:55:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Ref_Table (IsValueDisplayed,AD_Reference_ID,AD_Key,AD_Display,EntityType,AD_Table_ID,AD_Ref_Table_UU,CreatedBy,Updated,Created,AD_Client_ID,UpdatedBy,AD_Org_ID,IsActive) VALUES ('N',200014,200735,200735,'D',200031,'d46f8e84-f884-46ef-b9b7-0492d8f7386e',100,TO_TIMESTAMP('2012-10-22 15:55:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-22 15:55:10','YYYY-MM-DD HH24:MI:SS'),0,100,0,'Y')
;

-- Oct 22, 2012 3:55:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200806,'U',200014,'N','N','N',0,'N',10,'N',30,'N',200195,'N','Y','79aee8e6-aadd-46a9-916e-8a5709825eca','Y','N','Ref_PaymentTransaction_ID','Referenced Payment Transaction','Y',100,TO_TIMESTAMP('2012-10-22 15:55:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:55:22','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 3:55:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200806 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:55:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('VoidIt',200196,'D','Void It','Void It','3dcf9f9e-e05c-4df7-99d1-9ad2eb21725f',0,TO_TIMESTAMP('2012-10-22 15:55:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-22 15:55:43','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 22, 2012 3:55:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200196 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 22, 2012 3:56:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200807,'D','N','N','N',0,'N',1,'N',28,'N',200196,'N','Y','78313715-ddc1-400c-ab70-9107099bd628','Y','N','VoidIt','Void It','Y',100,TO_TIMESTAMP('2012-10-22 15:56:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 15:56:05','YYYY-MM-DD HH24:MI:SS'),100,0,0,'Y')
;

-- Oct 22, 2012 3:56:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200807 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 3:56:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-22 15:56:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200805
;

-- Oct 22, 2012 3:56:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-22 15:56:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200806
;

-- Oct 22, 2012 3:56:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
CREATE TABLE C_PaymentTransaction (A_City VARCHAR(60) DEFAULT NULL , A_Country VARCHAR(40) DEFAULT NULL , A_EMail VARCHAR(60) DEFAULT NULL , A_Ident_DL VARCHAR(20) DEFAULT NULL , A_Ident_SSN VARCHAR(20) DEFAULT NULL , A_Name VARCHAR(60) DEFAULT NULL , A_State VARCHAR(40) DEFAULT NULL , A_Street VARCHAR(60) DEFAULT NULL , A_Zip VARCHAR(20) DEFAULT NULL , AccountNo VARCHAR(20) DEFAULT NULL , AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_OrgTrx_ID NUMERIC(10) DEFAULT NULL , C_Activity_ID NUMERIC(10) DEFAULT NULL , C_BankAccount_ID NUMERIC(10) DEFAULT NULL , C_BP_BankAccount_ID NUMERIC(10) DEFAULT NULL , C_BPartner_ID NUMERIC(10) NOT NULL, C_Campaign_ID NUMERIC(10) DEFAULT NULL , C_CashBook_ID NUMERIC(10) DEFAULT NULL , C_Charge_ID NUMERIC(10) DEFAULT NULL , C_ConversionType_ID NUMERIC(10) DEFAULT NULL , C_Currency_ID NUMERIC(10) NOT NULL, C_DocType_ID NUMERIC(10) NOT NULL, C_Invoice_ID NUMERIC(10) DEFAULT NULL , C_Order_ID NUMERIC(10) DEFAULT NULL , C_Payment_ID NUMERIC(10) DEFAULT NULL , C_PaymentBatch_ID NUMERIC(10) DEFAULT NULL , C_PaymentProcessor_ID NUMERIC(10) DEFAULT NULL , C_PaymentTransaction_ID NUMERIC(10) NOT NULL, C_PaymentTransaction_UU VARCHAR(36) DEFAULT NULL , C_POSTenderType_ID NUMERIC(10) DEFAULT NULL , C_Project_ID NUMERIC(10) DEFAULT NULL , CheckNo VARCHAR(20) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, CreditCardExpMM NUMERIC(10) DEFAULT 1, CreditCardExpYY NUMERIC(10) DEFAULT 03, CreditCardNumber VARCHAR(20) DEFAULT NULL , CreditCardType CHAR(1) DEFAULT 'M', CreditCardVV VARCHAR(4) DEFAULT NULL , CustomerAddressID VARCHAR(60) DEFAULT NULL , CustomerPaymentProfileID VARCHAR(60) DEFAULT NULL , CustomerProfileID VARCHAR(60) DEFAULT NULL , DateTrx TIMESTAMP NOT NULL, Description VARCHAR(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsApproved CHAR(1) DEFAULT 'N' CHECK (IsApproved IN ('Y','N')) NOT NULL, IsDelayedCapture CHAR(1) CHECK (IsDelayedCapture IN ('Y','N')) NOT NULL, IsOnline CHAR(1) CHECK (IsOnline IN ('Y','N')) NOT NULL, IsReceipt CHAR(1) CHECK (IsReceipt IN ('Y','N')) NOT NULL, IsSelfService CHAR(1) CHECK (IsSelfService IN ('Y','N')) NOT NULL, IsVoided CHAR(1) DEFAULT 'N' CHECK (IsVoided IN ('Y','N')) NOT NULL, Micr VARCHAR(20) DEFAULT NULL , Orig_TrxID VARCHAR(20) DEFAULT NULL , PayAmt NUMERIC DEFAULT 0 NOT NULL, PONum VARCHAR(60) DEFAULT NULL , R_AuthCode VARCHAR(20) DEFAULT NULL , R_AvsAddr CHAR(1) DEFAULT NULL , R_AvsZip CHAR(1) DEFAULT NULL , R_CVV2Match CHAR(1) DEFAULT NULL CHECK (R_CVV2Match IN ('Y','N')), R_Info VARCHAR(2000) DEFAULT NULL , R_PnRef VARCHAR(20) DEFAULT NULL , R_RespMsg VARCHAR(60) DEFAULT NULL , R_Result VARCHAR(20) DEFAULT NULL , R_VoidMsg VARCHAR(255) DEFAULT NULL , Ref_PaymentTransaction_ID NUMERIC(10) DEFAULT NULL , RoutingNo VARCHAR(20) DEFAULT NULL , TaxAmt NUMERIC DEFAULT NULL , TenderType CHAR(1) DEFAULT 'K' NOT NULL, TrxType CHAR(1) DEFAULT 'S' NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, User1_ID NUMERIC(10) DEFAULT NULL , User2_ID NUMERIC(10) DEFAULT NULL , VoiceAuthCode VARCHAR(20) DEFAULT NULL , VoidIt CHAR(1) DEFAULT NULL , CONSTRAINT C_PaymentTransaction_Key PRIMARY KEY (C_PaymentTransaction_ID))
;

-- Oct 22, 2012 3:57:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Window (Processing,WindowType,Help,IsSOTrx,IsDefault,IsBetaFunctionality,EntityType,Name,Description,AD_Window_ID,AD_Image_ID,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('N','T',NULL,'Y','N','N','D','Payment Transaction','Payment Transactions',200017,106,'eddc608b-a1b5-4952-a021-2d9637202615',TO_TIMESTAMP('2012-10-22 15:57:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-22 15:57:37','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Oct 22, 2012 3:57:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200017 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Oct 22, 2012 3:58:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','N',200017,10,'N','N',200031,'N','N','N','N','N',0,'e11fd05b-4ab2-43b8-8eae-790025de843e','D','Payment Transaction',200027,0,TO_TIMESTAMP('2012-10-22 15:58:10','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-10-22 15:58:10','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Oct 22, 2012 3:58:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200027 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Oct 22, 2012 3:58:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200710,'Y',200655,'N','The Account City indicates the City of the Credit Card or Account holder','D','City or the Credit Card or Account Holder','Account City','N','Y','45b717d3-2c58-4edf-a52d-4f033a72533b',100,0,TO_TIMESTAMP('2012-10-22 15:58:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:13','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200655 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,40,'N','N',200711,'Y',200656,'N','Account Country Name','D','Country','Account Country','N','Y','dc314819-02fb-41a1-8124-c6860ec29bfa',100,0,TO_TIMESTAMP('2012-10-22 15:58:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200656 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200712,'Y',200657,'N','The EMail Address indicates the EMail address off the Credit Card or Account holder.','D','Email Address','Account EMail','N','Y','71ca35da-b4c0-4aed-9651-b3d404a28b58',100,0,TO_TIMESTAMP('2012-10-22 15:58:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200657 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200715,'Y',200658,'N','The Name of the Credit Card or Account holder.','D','Name on Credit Card or Account holder','Account Name','N','Y','53a359ab-bd89-4a2e-94a8-f39f7b5b4e4e',100,0,TO_TIMESTAMP('2012-10-22 15:58:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200658 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200719,'Y',200659,'N','The Account Number indicates the Number assigned to this bank account. ','D','Account Number','Account No','N','Y','597eb74d-94e4-4147-a621-2c5a3a70f35b',100,0,TO_TIMESTAMP('2012-10-22 15:58:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200659 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,40,'N','N',200716,'Y',200660,'N','The State of the Credit Card or Account holder','D','State of the Credit Card or Account holder','Account State','N','Y','ca25ecb0-c998-48c5-ad84-af21bb9a7807',100,0,TO_TIMESTAMP('2012-10-22 15:58:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200660 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200717,'Y',200661,'N','The Street Address of the Credit Card or Account holder.','D','Street address of the Credit Card or Account holder','Account Street','N','Y','d9e39654-3068-4c88-a0f7-ea2be25cba3a',100,0,TO_TIMESTAMP('2012-10-22 15:58:18','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:18','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200661 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200718,'Y',200662,'N','The Zip Code of the Credit Card or Account Holder.','D','Zip Code of the Credit Card or Account Holder','Account Zip/Postal','N','Y','dd7a3224-9842-4fcc-83d3-beba3c0d0172',100,0,TO_TIMESTAMP('2012-10-22 15:58:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:19','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200662 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200760,'Y',200663,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','e7cb23ca-b785-4e63-a10b-df6886051b8c',100,0,TO_TIMESTAMP('2012-10-22 15:58:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:19','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200663 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200723,'Y',200664,'N','Activities indicate tasks that are performed and used to utilize Activity based Costing','D','Business Activity','Activity','N','Y','d13bc10e-14a3-4665-b676-0bb5203b7789',100,0,TO_TIMESTAMP('2012-10-22 15:58:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200664 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200783,'Y',200665,'N','The Address Verified indicates if the address has been verified by the Credit Card Company.','D','This address has been verified','Address verified','N','Y','05d9e9ab-4bdb-4c3b-b8ab-8432d2555703',100,0,TO_TIMESTAMP('2012-10-22 15:58:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:21','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200665 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200762,'Y',200666,'N','The Approved checkbox indicates if this document requires approval before it can be processed.','D','Indicates if this document requires approval','Approved','N','Y','155cbed1-b771-4149-8326-a20f56927bc6',100,0,TO_TIMESTAMP('2012-10-22 15:58:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200666 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200781,'Y',200667,'N','The Authorization Code indicates the code returned from the electronic transmission.','D','Authorization Code returned','Authorization Code','N','Y','b886eaa3-5797-447c-941c-4ecb43bf389b',100,0,TO_TIMESTAMP('2012-10-22 15:58:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200667 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200724,'Y',200668,'N','The Bank Account identifies an account at this Bank.','D','Account at the Bank','Bank Account','N','Y','f854e9af-8a01-4e50-ad1e-c1d6bc0bce64',100,0,TO_TIMESTAMP('2012-10-22 15:58:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200668 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200726,'Y',200669,'N','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','D','Identifies a Business Partner','Business Partner ','N','Y','bfc77a7a-b128-462d-be9e-e424ea8f85fe',100,0,TO_TIMESTAMP('2012-10-22 15:58:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:24','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200669 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,36,'N','N',200736,'Y',200670,'N','D','C_PaymentTransaction_UU','N','Y','8bac820e-ca6e-4582-9505-e40be2a63c0e',100,0,TO_TIMESTAMP('2012-10-22 15:58:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200670 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200727,'Y',200671,'N','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.','D','Marketing Campaign','Campaign','N','Y','839480c3-ba41-41e4-abd3-7fdabd73baa1',100,0,TO_TIMESTAMP('2012-10-22 15:58:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200671 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,10,'N','N',200728,'Y',200672,'N','The Cash Book identifies a unique cash book.  The cash book is used to record cash transactions.','D','Cash Book for recording petty cash transactions','Cash Book','N','Y','bad10f1a-3f1f-44a3-af7c-78734e3b4629',100,0,TO_TIMESTAMP('2012-10-22 15:58:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200672 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200729,'Y',200673,'N','The Charge indicates a type of Charge (Handling, Shipping, Restocking)','D','Additional document charges','Charge','N','Y','7b73d831-ec63-40bb-b1d8-f8a44b7596c8',100,0,TO_TIMESTAMP('2012-10-22 15:58:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200673 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200742,'Y',200674,'N','The Check Number indicates the number on the check.','D','Check Number','Check No','N','Y','ad5321d8-5b71-42e4-81ec-850493ac5a45',100,0,TO_TIMESTAMP('2012-10-22 15:58:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200674 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200720,'Y',200675,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','0281609d-565a-4c19-b8a8-44033f47ba33',100,0,TO_TIMESTAMP('2012-10-22 15:58:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200675 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200748,'Y',200676,'N','The Credit Card drop down list box is used for selecting the type of Credit Card presented for payment.','D','Credit Card (Visa, MC, AmEx)','Credit Card','N','Y','241ce0d0-01bc-4838-9495-25e98c7cd68a',100,0,TO_TIMESTAMP('2012-10-22 15:58:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:30','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200676 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200731,'Y',200677,'N','Indicates the Currency to be used when processing or reporting on this record','D','The Currency for this record','Currency','N','Y','77b4c0b6-dbca-49bc-8fb6-9cda0d27c355',100,0,TO_TIMESTAMP('2012-10-22 15:58:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200677 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200730,'Y',200678,'N','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.','D','Currency Conversion Rate Type','Currency Type','N','Y','b53f1a8d-87e5-48d3-b216-5e0365c4d284',100,0,TO_TIMESTAMP('2012-10-22 15:58:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200678 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200750,'Y',200679,'N','D','Customer Address ID','N','Y','5948f7aa-a1ea-4f6e-a7ad-efdc134b6d24',100,0,TO_TIMESTAMP('2012-10-22 15:58:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:32','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200679 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200751,'Y',200680,'N','D','Customer Payment Profile ID','N','Y','c876e516-d484-45c8-8fd5-49e95d76eddc',100,0,TO_TIMESTAMP('2012-10-22 15:58:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200680 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200752,'Y',200681,'N','D','Customer Profile ID','N','Y','a7b466e4-bb71-4c2d-b5b4-a5abee871dd8',100,0,TO_TIMESTAMP('2012-10-22 15:58:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200681 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200785,'Y',200682,'N','The Credit Card Verification Code was matched','D','Credit Card Verification Code Match','CVV Match','N','Y','953ec1e5-2d0f-4819-ad45-d1def1191895',100,0,TO_TIMESTAMP('2012-10-22 15:58:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200682 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200763,'Y',200683,'N','Delayed Capture is required, if you ship products.  The first credit card transaction is the Authorization, the second is the actual transaction after the shipment of the product.','D','Charge after Shipment','Delayed Capture','N','Y','e0c9c110-6a23-490a-a653-5d5f7da7c59a',100,0,TO_TIMESTAMP('2012-10-22 15:58:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200683 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,255,'N','N',200755,'Y',200684,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','N','Y','893c0d72-559a-40f4-86e1-1e565d29fb1d',100,0,TO_TIMESTAMP('2012-10-22 15:58:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200684 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200732,'Y',200685,'N','The Document Type determines document sequence and processing rules','D','Document type or rules','Document Type','N','Y','51c533ee-b033-42de-b2fb-a05d93539589',100,0,TO_TIMESTAMP('2012-10-22 15:58:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200685 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200713,'Y',200686,'N','The Driver''s License being used as identification.','D','Payment Identification - Driver License','Driver License','N','Y','ebff21db-7090-4079-9485-e165e11a71c4',100,0,TO_TIMESTAMP('2012-10-22 15:58:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:38','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200686 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200745,'Y',200687,'N','The Expiry Month indicates the expiry month for this credit card.','D','Expiry Month','Exp. Month','N','Y','b242996a-eb13-4bd3-bb96-ed3d7f0b2d8e',100,0,TO_TIMESTAMP('2012-10-22 15:58:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:39','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200687 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200746,'Y',200688,'N','The Expiry Year indicates the expiry year for this credit card.','D','Expiry Year','Exp. Year','N','Y','b348b1c5-721c-4812-b0ef-f45741483441',100,0,TO_TIMESTAMP('2012-10-22 15:58:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:40','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200688 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,2000,'N','N',200786,'Y',200689,'N','The Info indicates any response information returned from the Credit Card Company.','D','Response info','Info','N','Y','f54a0981-3646-4938-a894-7e43d669e31e',100,0,TO_TIMESTAMP('2012-10-22 15:58:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:40','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200689 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200733,'Y',200690,'N','The Invoice Document.','D','Invoice Identifier','Invoice','N','Y','fae429a5-266c-4bf5-bad0-d8367db844d1',100,0,TO_TIMESTAMP('2012-10-22 15:58:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200690 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200771,'Y',200691,'N','The Micr number is the combination of the bank routing number, account number and check number','D','Combination of routing no, account and check no','Micr','N','Y','30be68cc-94ec-43b2-aff2-933e20a7c525',100,0,TO_TIMESTAMP('2012-10-22 15:58:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:42','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200691 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200747,'Y',200692,'N','The Credit Card number indicates the number on the credit card, without blanks or spaces.','D','Credit Card Number ','Number','N','Y','4d218bea-d53a-4f54-9f62-024cf450c2db',100,0,TO_TIMESTAMP('2012-10-22 15:58:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:43','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200692 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200764,'Y',200693,'N','The Online Access check box indicates if the application can be accessed via the web. ','D','Can be accessed online ','Online Access','N','Y','b3f76e12-4c98-482d-be21-90e41db28ac9',100,0,TO_TIMESTAMP('2012-10-22 15:58:44','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:44','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200693 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200734,'Y',200694,'N','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','D','Order','Order','N','Y','50400c8b-f83a-4d28-9449-f8677e71eae6',100,0,TO_TIMESTAMP('2012-10-22 15:58:44','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:44','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200694 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200721,'Y',200695,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','8d7b7fb5-fb2f-4f82-bbe8-d832f9b4c75d',100,0,TO_TIMESTAMP('2012-10-22 15:58:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:45','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200695 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200773,'Y',200696,'N','The Original Transaction ID is used for reversing transactions and indicates the transaction that has been reversed.','D','Original Transaction ID','Original Transaction ID','N','Y','2a87b7f4-dd39-445f-bcfa-7cdf10380665',100,0,TO_TIMESTAMP('2012-10-22 15:58:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:46','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200696 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200725,'Y',200697,'N','The Partner Bank Account identifies the bank account to be used for this Business Partner','D','Bank Account of the Business Partner','Partner Bank Account','N','Y','d8ac70bc-0bc6-4d32-b063-6b4b07c3e865',100,0,TO_TIMESTAMP('2012-10-22 15:58:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:47','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200697 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,10,'N','N',200805,'Y',200698,'N','The Payment is a unique identifier of this payment.','D','Payment identifier','Payment','N','Y','543d023e-0b95-431b-8eb2-d50d065cb8d6',100,0,TO_TIMESTAMP('2012-10-22 15:58:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200698 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200775,'Y',200699,'N','Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','D','Amount being paid','Payment amount','N','Y','c7599ef5-0570-4360-9154-7c4944bd92ac',100,0,TO_TIMESTAMP('2012-10-22 15:58:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200699 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200737,'Y',200700,'N','Electronic Fund Transfer Payment Batch.','D','Payment batch for EFT','Payment Batch','N','Y','1532b48e-6508-4078-afd5-813930d05a12',100,0,TO_TIMESTAMP('2012-10-22 15:58:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:49','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200700 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,10,'N','N',200738,'Y',200701,'N','The Payment Processor indicates the processor to be used for electronic payments','D','Payment processor for electronic payments','Payment Processor','N','Y','d26a3983-8c40-4f15-9358-21ddc07dc438',100,0,TO_TIMESTAMP('2012-10-22 15:58:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200701 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200027,22,'N','N',200735,'Y',200702,'N','D','Payment Transaction','N','N','d36f1bb9-207e-4140-9841-0b3526187b7c',100,0,TO_TIMESTAMP('2012-10-22 15:58:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:51','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Oct 22, 2012 3:58:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200702 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200776,'Y',200703,'N','The PO Number indicates the number assigned to a purchase order','D','Purchase Order Number','PO Number','N','Y','2f28ee32-1cfc-4e52-b519-f7e05bc13491',100,0,TO_TIMESTAMP('2012-10-22 15:58:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:52','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200703 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,10,'N','N',200739,'Y',200704,'N','D','POS Tender Type','N','Y','4e39bdee-d3fd-4f08-bb90-1620e882499c',100,0,TO_TIMESTAMP('2012-10-22 15:58:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200704 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200740,'Y',200705,'N','A Project allows you to track and control internal or external activities.','D','Financial Project','Project','N','Y','36d65b3a-8928-43ee-853c-0fb0b4d3da73',100,0,TO_TIMESTAMP('2012-10-22 15:58:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200705 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200767,'Y',200706,'N','D','This is a sales transaction (receipt)','Receipt','N','Y','5f5229f0-fc71-4f13-a020-6d1c7ff4b1d4',100,0,TO_TIMESTAMP('2012-10-22 15:58:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200706 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200787,'Y',200707,'N','The Payment Reference indicates the reference returned from the Credit Card Company for a payment','D','Payment reference','Reference','N','Y','75d94771-456f-45c4-a7e6-945ae0ea740b',100,0,TO_TIMESTAMP('2012-10-22 15:58:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200707 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,10,'N','N',200806,'Y',200708,'N','D','Referenced Payment Transaction','N','Y','e9f1c84a-6b13-4782-81b0-80f6bd2883d9',100,0,TO_TIMESTAMP('2012-10-22 15:58:56','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:56','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200708 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,60,'N','N',200789,'Y',200709,'N','The Response Message indicates the message returned from the Credit Card Company as the result of a transmission','D','Response message','Response Message','N','Y','3ace79ba-e56d-4602-bbb2-204bc2021cab',100,0,TO_TIMESTAMP('2012-10-22 15:58:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200709 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200790,'Y',200710,'N','The Response Result indicates the result of the transmission to the Credit Card Company.','D','Result of transmission','Result','N','Y','b2f97464-91a4-423d-8149-1bc52d9e8a2b',100,0,TO_TIMESTAMP('2012-10-22 15:58:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200710 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:58:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200794,'Y',200711,'N','The Bank Routing Number (ABA Number) identifies a legal Bank.  It is used in routing checks and electronic transactions.','D','Bank Routing Number','Routing No','N','Y','4b313ff5-cf58-4cd0-9f1c-1de8ebc0cc91',100,0,TO_TIMESTAMP('2012-10-22 15:58:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:58:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200711 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200769,'Y',200712,'N','Self-Service allows users to enter data or update their data.  The flag indicates, that this record was entered or created via Self-Service or that the user can change it via the Self-Service functionality.','D','This is a Self-Service entry or this entry can be changed via Self-Service','Self-Service','N','Y','4b96abb0-0cdd-4416-88f6-927c18910caf',100,0,TO_TIMESTAMP('2012-10-22 15:58:59','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:58:59','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200712 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200714,'Y',200713,'N','The Social Security number being used as identification.','D','Payment Identification - Social Security No','Social Security No','N','Y','46c80679-cc6e-4d92-9027-0a2f3882df88',100,0,TO_TIMESTAMP('2012-10-22 15:59:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:00','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200713 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200796,'Y',200714,'N','The Tax Amount displays the total tax amount for a document.','D','Tax Amount for a document','Tax Amount','N','Y','60ea8883-b411-45f2-abee-f2f1815b4701',100,0,TO_TIMESTAMP('2012-10-22 15:59:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:00','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200714 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200797,'Y',200715,'N','The Tender Type indicates the method of payment (ACH or Direct Deposit, Credit Card, Check, Direct Debit)','D','Method of Payment','Tender type','N','Y','6b52fbef-6497-4d7a-bb27-cb186275a17a',100,0,TO_TIMESTAMP('2012-10-22 15:59:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:01','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200715 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,7,'N','N',200754,'Y',200716,'N','The Transaction Date indicates the date of the transaction.','D','Transaction Date','Transaction Date','N','Y','8ac4eb10-87ec-4e24-8f3e-1340879d7596',100,0,TO_TIMESTAMP('2012-10-22 15:59:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200716 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200798,'Y',200717,'N','The Transaction Type indicates the type of transaction to be submitted to the Credit Card Company.','D','Type of credit card transaction','Transaction Type','N','Y','1b077058-dbf2-45b5-8287-4f4e1e8d1b98',100,0,TO_TIMESTAMP('2012-10-22 15:59:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200717 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200722,'Y',200718,'N','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.','D','Performing or initiating organization','Trx Organization','N','Y','5aa3f8a6-6c29-4b84-b105-81ea5c9293e2',100,0,TO_TIMESTAMP('2012-10-22 15:59:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200718 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200801,'Y',200719,'N','The user defined element displays the optional elements that have been defined for this account combination.','D','User defined list element #1','User List 1','N','Y','5cbd235d-6d97-4bbc-9f17-21d0d5191f71',100,0,TO_TIMESTAMP('2012-10-22 15:59:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200719 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,22,'N','N',200802,'Y',200720,'N','The user defined element displays the optional elements that have been defined for this account combination.','D','User defined list element #2','User List 2','N','Y','9dbc3071-1880-490c-9f0b-30ed84a7753f',100,0,TO_TIMESTAMP('2012-10-22 15:59:05','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:05','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200720 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,4,'N','N',200749,'Y',200721,'N','The Credit Card Verification indicates the verification code on the credit card (AMEX 4 digits on front; MC,Visa 3 digits back)','D','Credit Card Verification code on credit card','Verification Code','N','Y','d265ee25-ed5b-470b-bbf8-2e4892c266b1',100,0,TO_TIMESTAMP('2012-10-22 15:59:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200721 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,20,'N','N',200803,'Y',200722,'N','The Voice Authorization Code indicates the code received from the Credit Card Company.','D','Voice Authorization Code from credit card company','Voice authorization code','N','Y','12ccd87c-e4d7-4504-928a-4e34d1f4f6cc',100,0,TO_TIMESTAMP('2012-10-22 15:59:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200722 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200807,'Y',200723,'N','D','Void It','N','Y','cfd7e49b-797a-460b-a388-a403ea6f0575',100,0,TO_TIMESTAMP('2012-10-22 15:59:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200723 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,255,'N','N',200791,'Y',200724,'N','D','Void Message','N','Y','0033a78c-55ec-4b39-a4bf-5eb59f934494',100,0,TO_TIMESTAMP('2012-10-22 15:59:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200724 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200770,'Y',200725,'N','D','Voided','N','Y','9b3581ed-710d-4265-9793-5bd3a31b19b6',100,0,TO_TIMESTAMP('2012-10-22 15:59:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200725 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 3:59:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200784,'Y',200726,'N','The Zip Verified indicates if the zip code has been verified by the Credit Card Company.','D','The Zip Code has been verified','Zip verified','N','Y','925ea9fb-6991-4448-86f5-e48bb35926d7',100,0,TO_TIMESTAMP('2012-10-22 15:59:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 15:59:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 3:59:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200726 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200663
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200670
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200675
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200695
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200702
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200668
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200685
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200706
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200669
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200716
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200684
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200690
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200694
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200705
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200673
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200664
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200671
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200718
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200719
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200720
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200699
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200677
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200678
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=200715
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=200704
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200693
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200697
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200711
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200659
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=200674
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=200691
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=200676
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=200717
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=200692
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=200721
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=200687
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=200688
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=200658
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=200661
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=200655
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=200662
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=200660
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=200656
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=200686
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=200713
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=200657
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y' WHERE AD_Field_ID=200714
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y' WHERE AD_Field_ID=200703
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y' WHERE AD_Field_ID=200722
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y' WHERE AD_Field_ID=200696
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y' WHERE AD_Field_ID=200723
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y' WHERE AD_Field_ID=200666
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y' WHERE AD_Field_ID=200683
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y' WHERE AD_Field_ID=200710
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y' WHERE AD_Field_ID=200709
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y' WHERE AD_Field_ID=200689
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y' WHERE AD_Field_ID=200725
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y' WHERE AD_Field_ID=200724
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=570,IsDisplayed='Y' WHERE AD_Field_ID=200707
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=580,IsDisplayed='Y' WHERE AD_Field_ID=200667
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=590,IsDisplayed='Y' WHERE AD_Field_ID=200726
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=600,IsDisplayed='Y' WHERE AD_Field_ID=200665
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=610,IsDisplayed='Y' WHERE AD_Field_ID=200682
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=620,IsDisplayed='Y' WHERE AD_Field_ID=200701
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=630,IsDisplayed='Y' WHERE AD_Field_ID=200680
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=640,IsDisplayed='Y' WHERE AD_Field_ID=200681
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=650,IsDisplayed='Y' WHERE AD_Field_ID=200679
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=660,IsDisplayed='Y' WHERE AD_Field_ID=200698
;

-- Oct 22, 2012 4:04:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=670,IsDisplayed='Y' WHERE AD_Field_ID=200672
;

-- Oct 22, 2012 4:04:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=680,IsDisplayed='Y' WHERE AD_Field_ID=200700
;

-- Oct 22, 2012 4:04:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=690,IsDisplayed='Y' WHERE AD_Field_ID=200708
;

-- Oct 22, 2012 4:04:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=700,IsDisplayed='Y' WHERE AD_Field_ID=200712
;

-- Oct 22, 2012 4:06:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200675
;

-- Oct 22, 2012 4:06:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200695
;

-- Oct 22, 2012 4:06:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200702
;

-- Oct 22, 2012 4:06:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200685
;

-- Oct 22, 2012 4:06:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200668
;

-- Oct 22, 2012 4:06:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200706
;

-- Oct 22, 2012 4:06:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200669
;

-- Oct 22, 2012 4:06:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200716
;

-- Oct 22, 2012 4:06:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200684
;

-- Oct 22, 2012 4:06:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200690
;

-- Oct 22, 2012 4:06:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200694
;

-- Oct 22, 2012 4:06:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200705
;

-- Oct 22, 2012 4:06:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200673
;

-- Oct 22, 2012 4:06:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200664
;

-- Oct 22, 2012 4:06:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200671
;

-- Oct 22, 2012 4:06:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200718
;

-- Oct 22, 2012 4:06:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200719
;

-- Oct 22, 2012 4:06:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200720
;

-- Oct 22, 2012 4:06:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200699
;

-- Oct 22, 2012 4:06:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200677
;

-- Oct 22, 2012 4:06:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200678
;

-- Oct 22, 2012 4:06:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200715
;

-- Oct 22, 2012 4:06:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200704
;

-- Oct 22, 2012 4:06:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200693
;

-- Oct 22, 2012 4:06:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200697
;

-- Oct 22, 2012 4:06:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200659
;

-- Oct 22, 2012 4:06:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200711
;

-- Oct 22, 2012 4:06:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200674
;

-- Oct 22, 2012 4:06:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200691
;

-- Oct 22, 2012 4:06:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200676
;

-- Oct 22, 2012 4:06:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200717
;

-- Oct 22, 2012 4:06:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200692
;

-- Oct 22, 2012 4:06:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200721
;

-- Oct 22, 2012 4:06:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200687
;

-- Oct 22, 2012 4:06:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200688
;

-- Oct 22, 2012 4:06:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200658
;

-- Oct 22, 2012 4:06:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200661
;

-- Oct 22, 2012 4:06:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200655
;

-- Oct 22, 2012 4:06:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200662
;

-- Oct 22, 2012 4:06:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200660
;

-- Oct 22, 2012 4:06:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200656
;

-- Oct 22, 2012 4:06:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200686
;

-- Oct 22, 2012 4:06:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200713
;

-- Oct 22, 2012 4:06:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200657
;

-- Oct 22, 2012 4:06:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200714
;

-- Oct 22, 2012 4:06:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200703
;

-- Oct 22, 2012 4:06:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200722
;

-- Oct 22, 2012 4:06:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200696
;

-- Oct 22, 2012 4:06:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Oct 22, 2012 4:06:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200666
;

-- Oct 22, 2012 4:06:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200683
;

-- Oct 22, 2012 4:06:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200710
;

-- Oct 22, 2012 4:06:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200709
;

-- Oct 22, 2012 4:06:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2012-10-22 16:06:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200689
;

-- Oct 22, 2012 4:06:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200725
;

-- Oct 22, 2012 4:06:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200724
;

-- Oct 22, 2012 4:06:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200707
;

-- Oct 22, 2012 4:06:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200667
;

-- Oct 22, 2012 4:06:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200726
;

-- Oct 22, 2012 4:06:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200665
;

-- Oct 22, 2012 4:06:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200682
;

-- Oct 22, 2012 4:06:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200680
;

-- Oct 22, 2012 4:06:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200701
;

-- Oct 22, 2012 4:06:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200681
;

-- Oct 22, 2012 4:06:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200679
;

-- Oct 22, 2012 4:06:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200698
;

-- Oct 22, 2012 4:06:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200672
;

-- Oct 22, 2012 4:06:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200700
;

-- Oct 22, 2012 4:06:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200708
;

-- Oct 22, 2012 4:06:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:06:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200712
;

-- Oct 22, 2012 4:07:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2012-10-22 16:07:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200684
;

-- Oct 22, 2012 4:07:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:07:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200695
;

-- Oct 22, 2012 4:07:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:07:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200668
;

-- Oct 22, 2012 4:07:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:07:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200706
;

-- Oct 22, 2012 4:07:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200716
;

-- Oct 22, 2012 4:07:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:07:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200694
;

-- Oct 22, 2012 4:07:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:07:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200673
;

-- Oct 22, 2012 4:07:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:07:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200671
;

-- Oct 22, 2012 4:08:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200720
;

-- Oct 22, 2012 4:08:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200678
;

-- Oct 22, 2012 4:08:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200704
;

-- Oct 22, 2012 4:08:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200659
;

-- Oct 22, 2012 4:08:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200691
;

-- Oct 22, 2012 4:08:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200717
;

-- Oct 22, 2012 4:08:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200721
;

-- Oct 22, 2012 4:08:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200688
;

-- Oct 22, 2012 4:08:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200661
;

-- Oct 22, 2012 4:08:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200662
;

-- Oct 22, 2012 4:08:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200656
;

-- Oct 22, 2012 4:08:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200713
;

-- Oct 22, 2012 4:08:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200703
;

-- Oct 22, 2012 4:08:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200696
;

-- Oct 22, 2012 4:08:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:08:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200683
;

-- Oct 22, 2012 4:09:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:09:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200709
;

-- Oct 22, 2012 4:09:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:09:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200667
;

-- Oct 22, 2012 4:09:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:09:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200665
;

-- Oct 22, 2012 4:09:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:09:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200680
;

-- Oct 22, 2012 4:09:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:09:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200679
;

-- Oct 22, 2012 4:09:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:09:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200672
;

-- Oct 22, 2012 4:09:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-22 16:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200708
;

-- Oct 22, 2012 4:09:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:09:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200695
;

-- Oct 22, 2012 4:09:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200668
;

-- Oct 22, 2012 4:09:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-10-22 16:09:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200706
;

-- Oct 22, 2012 4:09:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:09:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200716
;

-- Oct 22, 2012 4:09:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:09:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200694
;

-- Oct 22, 2012 4:09:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:09:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200673
;

-- Oct 22, 2012 4:09:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:09:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200671
;

-- Oct 22, 2012 4:09:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:09:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200720
;

-- Oct 22, 2012 4:10:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200678
;

-- Oct 22, 2012 4:10:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200704
;

-- Oct 22, 2012 4:10:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200659
;

-- Oct 22, 2012 4:10:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200691
;

-- Oct 22, 2012 4:10:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-10-22 16:10:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200717
;

-- Oct 22, 2012 4:10:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200721
;

-- Oct 22, 2012 4:10:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200688
;

-- Oct 22, 2012 4:10:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200661
;

-- Oct 22, 2012 4:10:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200662
;

-- Oct 22, 2012 4:10:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200656
;

-- Oct 22, 2012 4:10:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200713
;

-- Oct 22, 2012 4:10:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200703
;

-- Oct 22, 2012 4:10:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200696
;

-- Oct 22, 2012 4:10:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-10-22 16:10:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200683
;

-- Oct 22, 2012 4:10:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:10:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200709
;

-- Oct 22, 2012 4:11:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:11:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200667
;

-- Oct 22, 2012 4:11:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-10-22 16:11:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200665
;

-- Oct 22, 2012 4:11:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:11:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200680
;

-- Oct 22, 2012 4:11:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:11:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200679
;

-- Oct 22, 2012 4:11:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:11:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200672
;

-- Oct 22, 2012 4:11:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-22 16:11:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200708
;

-- Oct 22, 2012 4:11:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200679
;

-- Oct 22, 2012 4:11:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200681
;

-- Oct 22, 2012 4:11:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200680
;

-- Oct 22, 2012 4:11:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET NumLines=3, ColumnSpan=5,Updated=TO_TIMESTAMP('2012-10-22 16:11:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200724
;

-- Oct 22, 2012 4:11:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET NumLines=3,Updated=TO_TIMESTAMP('2012-10-22 16:11:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200689
;

-- Oct 22, 2012 4:11:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200709
;

-- Oct 22, 2012 4:11:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200703
;

-- Oct 22, 2012 4:11:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200657
;

-- Oct 22, 2012 4:11:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200656
;

-- Oct 22, 2012 4:11:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200660
;

-- Oct 22, 2012 4:11:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200661
;

-- Oct 22, 2012 4:11:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200655
;

-- Oct 22, 2012 4:11:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-10-22 16:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200658
;

-- Oct 22, 2012 4:12:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@$Element_PJ@=Y & @C_Invoice_ID@=0 | @C_Invoice_ID@=''''',Updated=TO_TIMESTAMP('2012-10-22 16:12:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200705
;

-- Oct 22, 2012 4:12:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@$Element_AY@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:12:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200664
;

-- Oct 22, 2012 4:12:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@$Element_MC@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:12:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200671
;

-- Oct 22, 2012 4:12:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@$Element_OT@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:12:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200718
;

-- Oct 22, 2012 4:12:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@$Element_U1@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:12:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200719
;

-- Oct 22, 2012 4:12:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@$Element_U2@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:12:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200720
;

-- Oct 22, 2012 4:12:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@',Updated=TO_TIMESTAMP('2012-10-22 16:12:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200678
;

-- Oct 22, 2012 4:12:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=A | @TenderType@=K',Updated=TO_TIMESTAMP('2012-10-22 16:12:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200711
;

-- Oct 22, 2012 4:13:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=A | @TenderType@=K',Updated=TO_TIMESTAMP('2012-10-22 16:13:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200659
;

-- Oct 22, 2012 4:13:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K',Updated=TO_TIMESTAMP('2012-10-22 16:13:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200674
;

-- Oct 22, 2012 4:13:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K',Updated=TO_TIMESTAMP('2012-10-22 16:13:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200691
;

-- Oct 22, 2012 4:13:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_TIMESTAMP('2012-10-22 16:13:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200676
;

-- Oct 22, 2012 4:13:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_TIMESTAMP('2012-10-22 16:13:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200717
;

-- Oct 22, 2012 4:13:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_TIMESTAMP('2012-10-22 16:13:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200692
;

-- Oct 22, 2012 4:13:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_TIMESTAMP('2012-10-22 16:13:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200721
;

-- Oct 22, 2012 4:13:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_TIMESTAMP('2012-10-22 16:13:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200687
;

-- Oct 22, 2012 4:13:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_TIMESTAMP('2012-10-22 16:13:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200688
;

-- Oct 22, 2012 4:13:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C | @TenderType@=K',Updated=TO_TIMESTAMP('2012-10-22 16:13:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200658
;

-- Oct 22, 2012 4:13:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C | @TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200661
;

-- Oct 22, 2012 4:13:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C | @TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200655
;

-- Oct 22, 2012 4:13:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C | @TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200662
;

-- Oct 22, 2012 4:13:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C | @TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200660
;

-- Oct 22, 2012 4:13:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C | @TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200656
;

-- Oct 22, 2012 4:13:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200686
;

-- Oct 22, 2012 4:13:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200713
;

-- Oct 22, 2012 4:13:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200657
;

-- Oct 22, 2012 4:13:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@CreditCardType@=P & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200714
;

-- Oct 22, 2012 4:13:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@CreditCardType@=P & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200703
;

-- Oct 22, 2012 4:13:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200722
;

-- Oct 22, 2012 4:13:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200696
;

-- Oct 22, 2012 4:13:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Oct 22, 2012 4:13:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200666
;

-- Oct 22, 2012 4:13:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200683
;

-- Oct 22, 2012 4:13:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200710
;

-- Oct 22, 2012 4:13:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200709
;

-- Oct 22, 2012 4:13:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200689
;

-- Oct 22, 2012 4:13:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200725
;

-- Oct 22, 2012 4:13:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200724
;

-- Oct 22, 2012 4:13:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200707
;

-- Oct 22, 2012 4:13:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200667
;

-- Oct 22, 2012 4:13:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200726
;

-- Oct 22, 2012 4:14:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:14:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200665
;

-- Oct 22, 2012 4:14:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:14:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200682
;

-- Oct 22, 2012 4:14:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200680
;

-- Oct 22, 2012 4:14:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:14:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200681
;

-- Oct 22, 2012 4:14:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-22 16:14:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200679
;

-- Oct 22, 2012 4:14:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='1=2 & @TenderType@=''X''',Updated=TO_TIMESTAMP('2012-10-22 16:14:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200672
;

-- Oct 22, 2012 4:14:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Description,AD_Menu_UU,"action",IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200017,200023,'N','Y','N','D','Y','Payment Transaction','Payment Transactions','97528d62-758c-4b4c-9013-f06efc5e0f39','W','Y',0,100,TO_TIMESTAMP('2012-10-22 16:14:46','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-10-22 16:14:46','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 22, 2012 4:14:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200023 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Oct 22, 2012 4:14:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200023, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200023)
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Oct 22, 2012 4:14:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Oct 22, 2012 4:15:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Table SET AD_Window_ID=200017,Updated=TO_TIMESTAMP('2012-10-22 16:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200031
;

-- Oct 22, 2012 4:25:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200712
;

-- Oct 22, 2012 4:25:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200682
;

-- Oct 22, 2012 4:25:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200726
;

-- Oct 22, 2012 4:25:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200725
;

-- Oct 22, 2012 4:25:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200666
;

-- Oct 22, 2012 4:25:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Oct 22, 2012 4:25:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200676
;

-- Oct 22, 2012 4:25:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200693
;

-- Oct 22, 2012 4:25:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-22 16:25:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200715
;

-- Oct 22, 2012 4:25:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=10,Updated=TO_TIMESTAMP('2012-10-22 16:25:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200675
;

-- Oct 22, 2012 4:26:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=20,Updated=TO_TIMESTAMP('2012-10-22 16:26:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200695
;

-- Oct 22, 2012 4:26:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=30,Updated=TO_TIMESTAMP('2012-10-22 16:26:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200702
;

-- Oct 22, 2012 4:26:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=40,Updated=TO_TIMESTAMP('2012-10-22 16:26:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200668
;

-- Oct 22, 2012 4:26:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=40,Updated=TO_TIMESTAMP('2012-10-22 16:26:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200685
;

-- Oct 22, 2012 4:26:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=60,Updated=TO_TIMESTAMP('2012-10-22 16:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200706
;

-- Oct 22, 2012 4:26:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=70,Updated=TO_TIMESTAMP('2012-10-22 16:26:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200669
;

-- Oct 22, 2012 4:26:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=80,Updated=TO_TIMESTAMP('2012-10-22 16:26:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200716
;

-- Oct 22, 2012 4:26:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=90,Updated=TO_TIMESTAMP('2012-10-22 16:26:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200684
;

-- Oct 22, 2012 4:26:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=100,Updated=TO_TIMESTAMP('2012-10-22 16:26:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200690
;

-- Oct 22, 2012 4:26:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=110,Updated=TO_TIMESTAMP('2012-10-22 16:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200694
;

-- Oct 22, 2012 4:26:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=120,Updated=TO_TIMESTAMP('2012-10-22 16:26:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200705
;

-- Oct 22, 2012 4:26:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=130,Updated=TO_TIMESTAMP('2012-10-22 16:26:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200673
;

-- Oct 22, 2012 4:26:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=140,Updated=TO_TIMESTAMP('2012-10-22 16:26:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200664
;

-- Oct 22, 2012 4:26:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=150,Updated=TO_TIMESTAMP('2012-10-22 16:26:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200671
;

-- Oct 22, 2012 4:26:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=160,Updated=TO_TIMESTAMP('2012-10-22 16:26:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200718
;

-- Oct 22, 2012 4:26:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=170,Updated=TO_TIMESTAMP('2012-10-22 16:26:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200719
;

-- Oct 22, 2012 4:26:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=180,Updated=TO_TIMESTAMP('2012-10-22 16:26:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200720
;

-- Oct 22, 2012 4:26:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=190,Updated=TO_TIMESTAMP('2012-10-22 16:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200699
;

-- Oct 22, 2012 4:26:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=200,Updated=TO_TIMESTAMP('2012-10-22 16:26:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200677
;

-- Oct 22, 2012 4:26:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=210,Updated=TO_TIMESTAMP('2012-10-22 16:26:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200678
;

-- Oct 22, 2012 4:26:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=220,Updated=TO_TIMESTAMP('2012-10-22 16:26:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200715
;

-- Oct 22, 2012 4:26:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=230,Updated=TO_TIMESTAMP('2012-10-22 16:26:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200704
;

-- Oct 22, 2012 4:26:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=240,Updated=TO_TIMESTAMP('2012-10-22 16:26:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200693
;

-- Oct 22, 2012 4:26:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=250,Updated=TO_TIMESTAMP('2012-10-22 16:26:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200697
;

-- Oct 22, 2012 4:26:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=260,Updated=TO_TIMESTAMP('2012-10-22 16:26:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200711
;

-- Oct 22, 2012 4:26:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=270,Updated=TO_TIMESTAMP('2012-10-22 16:26:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200659
;

-- Oct 22, 2012 4:26:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=280,Updated=TO_TIMESTAMP('2012-10-22 16:26:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200674
;

-- Oct 22, 2012 4:26:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=290,Updated=TO_TIMESTAMP('2012-10-22 16:26:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200691
;

-- Oct 22, 2012 4:26:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=300,Updated=TO_TIMESTAMP('2012-10-22 16:26:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200676
;

-- Oct 22, 2012 4:26:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=310,Updated=TO_TIMESTAMP('2012-10-22 16:26:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200717
;

-- Oct 22, 2012 4:26:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=320,Updated=TO_TIMESTAMP('2012-10-22 16:26:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200692
;

-- Oct 22, 2012 4:26:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=330,Updated=TO_TIMESTAMP('2012-10-22 16:26:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200721
;

-- Oct 22, 2012 4:26:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=340,Updated=TO_TIMESTAMP('2012-10-22 16:26:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200687
;

-- Oct 22, 2012 4:26:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=350,Updated=TO_TIMESTAMP('2012-10-22 16:26:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200688
;

-- Oct 22, 2012 4:26:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=360,Updated=TO_TIMESTAMP('2012-10-22 16:26:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200658
;

-- Oct 22, 2012 4:26:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=370,Updated=TO_TIMESTAMP('2012-10-22 16:26:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200661
;

-- Oct 22, 2012 4:26:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=380,Updated=TO_TIMESTAMP('2012-10-22 16:26:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200655
;

-- Oct 22, 2012 4:26:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=390,Updated=TO_TIMESTAMP('2012-10-22 16:26:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200662
;

-- Oct 22, 2012 4:26:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=400,Updated=TO_TIMESTAMP('2012-10-22 16:26:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200660
;

-- Oct 22, 2012 4:26:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=410,Updated=TO_TIMESTAMP('2012-10-22 16:26:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200656
;

-- Oct 22, 2012 4:26:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=420,Updated=TO_TIMESTAMP('2012-10-22 16:26:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200686
;

-- Oct 22, 2012 4:26:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=430,Updated=TO_TIMESTAMP('2012-10-22 16:26:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200713
;

-- Oct 22, 2012 4:26:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=440,Updated=TO_TIMESTAMP('2012-10-22 16:26:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200657
;

-- Oct 22, 2012 4:26:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=450,Updated=TO_TIMESTAMP('2012-10-22 16:26:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200714
;

-- Oct 22, 2012 4:26:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=460,Updated=TO_TIMESTAMP('2012-10-22 16:26:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200703
;

-- Oct 22, 2012 4:26:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=470,Updated=TO_TIMESTAMP('2012-10-22 16:26:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200722
;

-- Oct 22, 2012 4:26:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=480,Updated=TO_TIMESTAMP('2012-10-22 16:26:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200696
;

-- Oct 22, 2012 4:26:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=490,Updated=TO_TIMESTAMP('2012-10-22 16:26:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Oct 22, 2012 4:27:00 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=500,Updated=TO_TIMESTAMP('2012-10-22 16:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200666
;

-- Oct 22, 2012 4:27:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=510,Updated=TO_TIMESTAMP('2012-10-22 16:27:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200683
;

-- Oct 22, 2012 4:27:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=520,Updated=TO_TIMESTAMP('2012-10-22 16:27:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200710
;

-- Oct 22, 2012 4:27:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=530,Updated=TO_TIMESTAMP('2012-10-22 16:27:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200709
;

-- Oct 22, 2012 4:27:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=540,Updated=TO_TIMESTAMP('2012-10-22 16:27:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200689
;

-- Oct 22, 2012 4:27:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=550,Updated=TO_TIMESTAMP('2012-10-22 16:27:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200725
;

-- Oct 22, 2012 4:27:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=560,Updated=TO_TIMESTAMP('2012-10-22 16:27:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200724
;

-- Oct 22, 2012 4:27:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=570,Updated=TO_TIMESTAMP('2012-10-22 16:27:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200707
;

-- Oct 22, 2012 4:27:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=580,Updated=TO_TIMESTAMP('2012-10-22 16:27:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200667
;

-- Oct 22, 2012 4:27:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=590,Updated=TO_TIMESTAMP('2012-10-22 16:27:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200726
;

-- Oct 22, 2012 4:27:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=600,Updated=TO_TIMESTAMP('2012-10-22 16:27:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200665
;

-- Oct 22, 2012 4:27:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=610,Updated=TO_TIMESTAMP('2012-10-22 16:27:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200682
;

-- Oct 22, 2012 4:27:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=620,Updated=TO_TIMESTAMP('2012-10-22 16:27:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200701
;

-- Oct 22, 2012 4:27:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=630,Updated=TO_TIMESTAMP('2012-10-22 16:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200680
;

-- Oct 22, 2012 4:27:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=640,Updated=TO_TIMESTAMP('2012-10-22 16:27:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200681
;

-- Oct 22, 2012 4:27:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=650,Updated=TO_TIMESTAMP('2012-10-22 16:27:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200679
;

-- Oct 22, 2012 4:27:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=660,Updated=TO_TIMESTAMP('2012-10-22 16:27:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200698
;

-- Oct 22, 2012 4:27:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=670,Updated=TO_TIMESTAMP('2012-10-22 16:27:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200672
;

-- Oct 22, 2012 4:27:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=680,Updated=TO_TIMESTAMP('2012-10-22 16:27:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200700
;

-- Oct 22, 2012 4:27:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=690,Updated=TO_TIMESTAMP('2012-10-22 16:27:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200708
;

-- Oct 22, 2012 4:27:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=700,Updated=TO_TIMESTAMP('2012-10-22 16:27:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200712
;

-- Oct 22, 2012 4:27:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2012-10-22 16:27:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200715
;

-- Oct 22, 2012 4:28:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Tab SET IsInsertRecord='Y',Updated=TO_TIMESTAMP('2012-10-22 16:28:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200027
;

-- Oct 22, 2012 4:28:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2012-10-22 16:28:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200027
;

-- Oct 22, 2012 4:35:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200031,200808,'D','Y','N','N',0,'N',1,'N',20,'N',1047,'N','Y','0f744195-be96-4cdf-a5b7-0cc54f72c638','Y','N','Processed','The document has been processed','N','The Processed checkbox indicates that a document has been processed.','Processed','Y',100,TO_TIMESTAMP('2012-10-22 16:35:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 16:35:03','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 4:35:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200808 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 4:35:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
ALTER TABLE C_PaymentTransaction ADD COLUMN Processed CHAR(1) DEFAULT 'N' CHECK (Processed IN ('Y','N')) NOT NULL
;

-- Oct 22, 2012 4:35:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200027,1,'N','N',200808,'Y',200727,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','N','Y','37c234d4-0f57-4a8e-9e5c-cd488f4deb9e',100,0,TO_TIMESTAMP('2012-10-22 16:35:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 16:35:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 4:35:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200727 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 4:36:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y', SeqNo=710, SeqNoGrid=710, XPosition=5, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 16:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200727
;

-- Oct 22, 2012 6:03:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',398,200809,'U',215,'N','N','N',0,'N',1,'N',17,'N',1295,'N','Y','370fcf8e-d48d-46c7-9511-9e0bab4143e5','Y','N','TrxType','Type of credit card transaction','The Transaction Type indicates the type of transaction to be submitted to the Credit Card Company.','Transaction Type','Y',100,TO_TIMESTAMP('2012-10-22 18:03:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-22 18:03:40','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 22, 2012 6:03:42 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200809 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 22, 2012 6:03:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-22 18:03:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200809
;

-- Oct 22, 2012 6:03:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
ALTER TABLE C_PaymentProcessor ADD COLUMN TrxType CHAR(1) DEFAULT NULL 
;

-- Oct 22, 2012 6:04:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200024,36,'N','N',60724,'Y',200728,'N','D','C_PaymentProcessor_UU','N','Y','73300161-a750-4bfe-a848-b0ba2e38856e',100,0,TO_TIMESTAMP('2012-10-22 18:04:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 18:04:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 6:04:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200728 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 6:04:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200024,1,'N','N',200809,'Y',200729,'N','The Transaction Type indicates the type of transaction to be submitted to the Credit Card Company.','D','Type of credit card transaction','Transaction Type','N','Y','74b48395-aa90-4522-9c74-758d37c1c66e',100,0,TO_TIMESTAMP('2012-10-22 18:04:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-22 18:04:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 22, 2012 6:04:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200729 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 22, 2012 6:04:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200728
;

-- Oct 22, 2012 6:04:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=200729
;

-- Oct 22, 2012 6:04:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200728
;

-- Oct 22, 2012 6:04:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=200729
;

-- Oct 22, 2012 6:04:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-22 18:04:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200729
;

-- Oct 23, 2012 4:23:55 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET AD_Val_Rule_ID=NULL,Updated=TO_TIMESTAMP('2012-10-23 16:23:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200732
;

-- Oct 23, 2012 4:24:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET IsMandatory='N', Callout=NULL,Updated=TO_TIMESTAMP('2012-10-23 16:24:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200732
;

-- Oct 23, 2012 4:24:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200685
;

-- Oct 23, 2012 4:24:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Field WHERE AD_Field_ID=200685
;

-- Oct 23, 2012 4:25:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='N', XPosition=2,Updated=TO_TIMESTAMP('2012-10-23 16:25:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200706
;

-- Oct 23, 2012 4:25:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200732
;

-- Oct 23, 2012 4:25:28 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200732
;

-- Oct 23, 2012 4:25:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2012-10-23 16:25:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200729
;

-- Oct 23, 2012 4:25:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2012-10-23 16:25:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200730
;

-- Oct 23, 2012 4:25:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2012-10-23 16:25:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200731
;

-- Oct 23, 2012 4:25:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2012-10-23 16:25:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200733
;

-- Oct 23, 2012 4:25:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2012-10-23 16:25:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200734
;

-- Oct 23, 2012 4:26:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2012-10-23 16:26:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200754
;

-- Oct 23, 2012 4:38:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,'N',200031,200810,'D','Y','N','N','N',10,'N',19,'N',196,'bab52add-1666-495f-bb08-dd96ad13e0ef','Y','N','C_DocType_ID','Document type or rules','The Document Type determines document sequence and processing rules','Document Type',100,TO_TIMESTAMP('2012-10-23 16:38:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-23 16:38:46','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 23, 2012 4:38:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200810 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 23, 2012 4:39:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-10-23 16:39:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200810
;

-- Oct 23, 2012 4:39:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO t_alter_column values('c_paymenttransaction','C_DocType_ID','NUMERIC(10)',null,'NULL')
;

-- Oct 23, 2012 4:39:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO t_alter_column values('c_paymenttransaction','C_DocType_ID',null,'NULL',null)
;

-- Oct 23, 2012 4:39:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200810
;

-- Oct 23, 2012 4:39:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200810
;

-- Oct 23, 2012 4:53:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2012-10-23 16:53:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200676
;

-- Oct 23, 2012 4:53:46 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-23 16:53:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200717
;

-- Oct 23, 2012 4:54:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-23 16:54:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200683
;

-- Oct 23, 2012 4:54:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2012-10-23 16:54:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200726
;

-- Oct 23, 2012 4:54:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-10-23 16:54:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200665
;

-- Oct 23, 2012 4:57:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Tab SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-10-23 16:57:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200027
;

-- Oct 30, 2012 7:19:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','3',145,200032,'N','N','N','U','L','6d4c8a8d-57f4-42b7-a3cc-72ba4f6c0ef2','Y','Y','X_OnlineTrxHistory',NULL,'Online Transaction History',0,'Y',0,TO_TIMESTAMP('2012-10-30 19:19:08','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2012-10-30 19:19:08','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 30, 2012 7:19:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200032 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Oct 30, 2012 7:19:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200030,'11b57be8-46f2-45bd-a662-99aae5e37cc7','Table X_OnlineTrxHistory','X_OnlineTrxHistory',1,0,0,TO_TIMESTAMP('2012-10-30 19:19:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-10-30 19:19:11','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Oct 30, 2012 7:19:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200820,'U','Y','N','N',0,'Y',22,'N',19,'N',114,'N','Y','ce34fb59-e698-4183-a156-0da948069c79','N','N','AD_PInstance_ID','Instance of the process','Process Instance','Y',100,TO_TIMESTAMP('2012-10-30 19:19:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:31','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:19:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200820 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('X_OnlineTrxHistory_UU',200200,'U','X_OnlineTrxHistory_UU','X_OnlineTrxHistory_UU','f417e656-4cf0-4ef2-ae4e-11d9b436b518',0,TO_TIMESTAMP('2012-10-30 19:19:33','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-30 19:19:33','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 30, 2012 7:19:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200200 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 30, 2012 7:19:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1.00,'N','N',200032,200821,'U','N','N','N','N',36,'N',10,'N',200200,'N','Y','fb8fe08b-7dba-4f60-81a5-b8ac9abc73f2','Y','N','X_OnlineTrxHistory_UU','X_OnlineTrxHistory_UU','N',100,TO_TIMESTAMP('2012-10-30 19:19:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:33','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:19:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200821 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200032,200822,'U','N','N','N',0,'N',14,'N',19,'N',126,'N','Y','73b540e5-7d86-4ab8-9d5c-b42cc169dce1','Y','N','AD_Table_ID','Database Table information','The Database Table provides the information of the table definition','Table','Y',100,TO_TIMESTAMP('2012-10-30 19:19:35','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:35','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:19:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200822 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200823,'U','Y','N','N',0,'N',22,'N',13,'Y',2064,'N','Y','90946d04-b05c-4f2b-8122-199ca186a024','N','N','Log_ID','Log','N',100,TO_TIMESTAMP('2012-10-30 19:19:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:19:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200823 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200824,'U','N','N','N',0,'N',7,'N',15,'N',483,'N','Y','27895b53-b58f-416e-a7af-86a2609cdd13','N','N','P_Date','Process Parameter','Process Date','Y',100,TO_TIMESTAMP('2012-10-30 19:19:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:19:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200824 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200825,'U','N','N','N',0,'N',22,'N',13,'N',2067,'N','Y','66111030-9684-494e-b8ac-a52d915578fa','N','N','P_ID','Process ID','Y',100,TO_TIMESTAMP('2012-10-30 19:19:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:38','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:19:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200825 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200826,'U','N','N','N',0,'N',2000,'N',10,'N',2068,'N','Y','298971ff-1971-4d21-975d-9045c8769f83','N','N','P_Msg','Process Message','Y',100,TO_TIMESTAMP('2012-10-30 19:19:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:19:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200826 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200827,'U','N','N','N',0,'N',22,'N',22,'N',1121,'N','Y','c8659539-32c7-42a3-9d03-2f52934625af','N','N','P_Number','Process Parameter','Process Number','Y',100,TO_TIMESTAMP('2012-10-30 19:19:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:19:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200827 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',200032,200828,'U','N','N','N',0,'N',14,'N',28,'N',538,'N','Y','7d8824f8-5f55-44c2-aec6-14768ee89b77','Y','N','Record_ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.','Record ID','Y',100,TO_TIMESTAMP('2012-10-30 19:19:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:19:40','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Oct 30, 2012 7:19:41 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200828 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:19:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200820
;

-- Oct 30, 2012 7:19:50 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200820
;

-- Oct 30, 2012 7:21:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('X_OnlineTrxHistory_ID',200201,'U','Online Transaction History','Online Transaction History','416d5e2a-4024-4dbc-9e19-4debb1e45d5d',0,TO_TIMESTAMP('2012-10-30 19:21:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-30 19:21:25','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 30, 2012 7:21:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200201 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 30, 2012 7:21:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET AD_Element_ID=200201, IsUpdateable='N', ColumnName='X_OnlineTrxHistory_ID', Description=NULL, Help=NULL, Name='Online Transaction History',Updated=TO_TIMESTAMP('2012-10-30 19:21:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200823
;

-- Oct 30, 2012 7:21:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200823
;

-- Oct 30, 2012 7:21:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET Name='Online Transaction History', Description=NULL, Help=NULL WHERE AD_Column_ID=200823 AND IsCentrallyMaintained='Y'
;

-- Oct 30, 2012 7:22:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200822
;

-- Oct 30, 2012 7:22:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200822
;

-- Oct 30, 2012 7:22:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200824
;

-- Oct 30, 2012 7:22:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200824
;

-- Oct 30, 2012 7:22:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200825
;

-- Oct 30, 2012 7:22:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200825
;

-- Oct 30, 2012 7:22:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200826
;

-- Oct 30, 2012 7:22:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200826
;

-- Oct 30, 2012 7:22:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200827
;

-- Oct 30, 2012 7:22:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200827
;

-- Oct 30, 2012 7:22:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200828
;

-- Oct 30, 2012 7:22:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200828
;

-- Oct 30, 2012 7:22:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200823
;

-- Oct 30, 2012 7:22:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200823
;

-- Oct 30, 2012 7:22:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200821
;

-- Oct 30, 2012 7:22:06 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200821
;

-- Oct 30, 2012 7:22:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200829,'U','Y','N','N',0,'N',22,'N',19,'N',102,'N','Y','cfe2ceb0-404b-43e5-9b28-6c2454a0b538','N','N','AD_Client_ID','Client/Tenant for this installation.','@AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_TIMESTAMP('2012-10-30 19:22:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:14','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200829 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200830,'U','Y','N','N',0,'N',22,'N',19,104,'N',113,'N','Y','1c3dea46-f448-45e9-af47-548e0ddabee8','N','N','AD_Org_ID','Organizational entity within client','@AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_TIMESTAMP('2012-10-30 19:22:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:15','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200830 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200831,'U','Y','N','N',0,'Y',22,'N',19,'N',2356,'N','Y','f38c73b7-0cbe-41d1-82df-3315bd8c3924','N','N','AD_Scheduler_ID','Schedule Processes','Schedule processes to be executed asynchronously','Scheduler','Y',100,TO_TIMESTAMP('2012-10-30 19:22:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:15','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200831 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200832,'U','Y','N','N',0,'N',22,'N',13,'Y',200201,'N','Y','d0900143-bac9-4fd7-b8c1-aff4e432011a','N','N','X_OnlineTrxHistory_ID','Online Transaction History','N',100,TO_TIMESTAMP('2012-10-30 19:22:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200832 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1.00,'N','N',200032,200833,'U','N','N','N','N',36,'N',10,'N',200200,'N','Y','32041d72-089d-4106-ae5a-925b25496271','Y','N','X_OnlineTrxHistory_UU','X_OnlineTrxHistory_UU','N',100,TO_TIMESTAMP('2012-10-30 19:22:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200833 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200834,'U','N','N','N',0,'N',0,'N',23,'N',174,'N','Y','74eee45a-0517-4e18-b638-4d70738836f4','Y','N','BinaryData','Binary Data','The Binary field stores binary data.','Binary Data','Y',100,TO_TIMESTAMP('2012-10-30 19:22:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200834 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200835,'U','Y','N','N',0,'N',7,'N',16,'N',245,'N','Y','4f39b447-395c-49e8-982e-a896cd4c3815','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_TIMESTAMP('2012-10-30 19:22:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200835 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200836,'U',110,'Y','N','N',0,'N',22,'N',18,'N',246,'N','Y','c2e23bd6-c8b5-43f2-aa85-a57271de870b','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_TIMESTAMP('2012-10-30 19:22:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200836 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200837,'U','N','N','N',0,'N',255,'Y',10,'N',275,'N','Y','9884223e-9c75-412f-928f-f4175c951c10','Y','N','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_TIMESTAMP('2012-10-30 19:22:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200837 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200838,'U','Y','N','N',0,'N',1,'N',20,'N',348,'N','Y','80fc66f2-6a27-4558-b8c2-d505f3ea1b63','Y','N','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_TIMESTAMP('2012-10-30 19:22:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200838 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200839,'U','Y','N','N',0,'N',1,'N',20,'N',2395,'N','Y','e0fd0830-ce67-41a6-b341-9deda2feb700','Y','N','IsError','An Error occurred in the execution','Error','Y',100,TO_TIMESTAMP('2012-10-30 19:22:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:22','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:23 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200839 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200840,'U','N','N','N',0,'N',60,'N',10,'N',539,'N','Y','0299f079-bc2a-4acd-95ec-8e077d6a59e1','Y','N','Reference','Reference for this record','The Reference displays the source document number.','Reference','Y',100,TO_TIMESTAMP('2012-10-30 19:22:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:23','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200840 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200841,'U','N','N','N',0,'N',2000,'N',14,'N',1521,'N','Y','b515e834-0a55-4e9f-840f-c32c892dbc6b','Y','N','Summary','Textual summary of this request','The Summary allows free form text entry of a recap of this request.','Summary','Y',100,TO_TIMESTAMP('2012-10-30 19:22:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:24','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200841 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200842,'U','N','N','N',0,'N',2000,'N',14,'N',2438,'N','Y','ce5231e5-44db-4369-b88a-53e9107c6918','Y','N','TextMsg','Text Message','Text Message','Y',100,TO_TIMESTAMP('2012-10-30 19:22:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:25','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200842 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200843,'U','Y','N','N',0,'N',7,'N',16,'N',607,'N','Y','04dbee0a-586e-467e-8476-bd63348cc99d','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_TIMESTAMP('2012-10-30 19:22:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:26','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200843 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (1,'N','N',200032,200844,'U',110,'Y','N','N',0,'N',22,'N',18,'N',608,'N','Y','1de7b5c8-fca9-4fa5-a433-9161551f65e2','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_TIMESTAMP('2012-10-30 19:22:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:22:26','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Oct 30, 2012 7:22:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200844 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:22:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200840
;

-- Oct 30, 2012 7:22:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200840
;

-- Oct 30, 2012 7:22:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200841
;

-- Oct 30, 2012 7:22:44 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200841
;

-- Oct 30, 2012 7:23:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200831
;

-- Oct 30, 2012 7:23:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200831
;

-- Oct 30, 2012 7:23:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200834
;

-- Oct 30, 2012 7:23:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200834
;

-- Oct 30, 2012 7:23:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200837
;

-- Oct 30, 2012 7:23:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
DELETE FROM AD_Column WHERE AD_Column_ID=200837
;

-- Oct 30, 2012 7:24:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200032,200845,'U','N','N','N',0,'N',10,'N',19,'N',126,'N','Y','d3f59330-195e-43d0-a22c-52716ac479f3','Y','N','AD_Table_ID','Database Table information','The Database Table provides the information of the table definition','Table','Y',100,TO_TIMESTAMP('2012-10-30 19:24:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:24:19','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 30, 2012 7:24:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200845 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:24:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2012-10-30 19:24:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200845
;

-- Oct 30, 2012 7:24:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200032,200846,'U','Y','N','N',0,'N',22,'N',28,'N',538,'N','Y','fdb09c0d-ee30-4e69-bb78-5efce3f784a6','Y','N','Record_ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.','Record ID','Y',100,TO_TIMESTAMP('2012-10-30 19:24:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-30 19:24:55','YYYY-MM-DD HH24:MI:SS'),100,0,0,'Y')
;

-- Oct 30, 2012 7:24:56 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200846 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 30, 2012 7:25:02 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-10-30 19:25:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200846
;

-- Oct 30, 2012 7:25:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET IsToolbarButton='Y',Updated=TO_TIMESTAMP('2012-10-30 19:25:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200846
;

-- Oct 30, 2012 7:25:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET DefaultValue='N',Updated=TO_TIMESTAMP('2012-10-30 19:25:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200839
;

-- Oct 30, 2012 7:26:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
CREATE TABLE X_OnlineTrxHistory (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Table_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsError CHAR(1) DEFAULT 'N' CHECK (IsError IN ('Y','N')) NOT NULL, Record_ID NUMERIC(10) NOT NULL, TextMsg VARCHAR(2000) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, X_OnlineTrxHistory_ID NUMERIC(10) NOT NULL, X_OnlineTrxHistory_UU VARCHAR(36) DEFAULT NULL , CONSTRAINT X_OnlineTrxHistory_Key PRIMARY KEY (X_OnlineTrxHistory_ID))
;

-- Oct 30, 2012 7:26:58 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Table SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:26:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200032
;

-- Oct 30, 2012 7:27:03 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200829
;

-- Oct 30, 2012 7:27:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200830
;

-- Oct 30, 2012 7:27:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200845
;

-- Oct 30, 2012 7:27:13 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200835
;

-- Oct 30, 2012 7:27:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200836
;

-- Oct 30, 2012 7:27:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200838
;

-- Oct 30, 2012 7:27:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200839
;

-- Oct 30, 2012 7:27:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200846
;

-- Oct 30, 2012 7:27:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200842
;

-- Oct 30, 2012 7:27:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200843
;

-- Oct 30, 2012 7:27:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200844
;

-- Oct 30, 2012 7:27:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D', IsUpdateable='N',Updated=TO_TIMESTAMP('2012-10-30 19:27:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200832
;

-- Oct 30, 2012 7:27:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200833
;

-- Oct 30, 2012 7:27:47 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200200
;

-- Oct 30, 2012 7:27:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-30 19:27:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200201
;

-- Oct 30, 2012 7:28:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('N','T','Y','N','N',0,0,'D','Online Transaction History',200018,'8b7e7c11-b35e-4df2-bcc9-fdd0d9242d0f',TO_TIMESTAMP('2012-10-30 19:28:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-30 19:28:58','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Oct 30, 2012 7:28:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200018 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Oct 30, 2012 7:29:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','N',200018,10,'N','N',200032,'N','N','N','Y','N',0,'b7706902-4acf-42d0-a6f8-20e2c870d918','U','Online Transaction History',200029,0,TO_TIMESTAMP('2012-10-30 19:29:21','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-10-30 19:29:21','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Oct 30, 2012 7:29:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200029 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Oct 30, 2012 7:29:26 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Tab SET IsReadOnly='Y', IsInsertRecord='N',Updated=TO_TIMESTAMP('2012-10-30 19:29:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200029
;

-- Oct 30, 2012 7:29:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,1,'N','N',200838,'Y',200759,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','U','The record is active in the system','Active','N','Y','809ca393-bc6b-40e4-bf6e-90e4c5c06a12',100,0,TO_TIMESTAMP('2012-10-30 19:29:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 30, 2012 7:29:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200759 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:29:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,22,'N','N',200829,'Y',200760,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','U','Client/Tenant for this installation.','Client','N','Y','bd870bd7-dfa7-48ff-8569-314a08b1dd73',100,0,TO_TIMESTAMP('2012-10-30 19:29:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 30, 2012 7:29:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200760 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:29:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,1,'N','N',200839,'Y',200761,'N','U','An Error occurred in the execution','Error','N','Y','24080d67-18b9-4640-b3e9-a64f6ad8dac2',100,0,TO_TIMESTAMP('2012-10-30 19:29:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 30, 2012 7:29:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200761 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:29:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200029,22,'N','N',200832,'Y',200762,'N','U','Online Transaction History','N','N','e234db42-619c-4c97-b0d4-7f6944b4736b',100,0,TO_TIMESTAMP('2012-10-30 19:29:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:32','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Oct 30, 2012 7:29:33 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200762 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:29:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,22,'N','N',200830,'Y',200763,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','U','Organizational entity within client','Organization','N','Y','56bd1ec0-21c5-4005-aa0f-81a3e14f556e',100,0,TO_TIMESTAMP('2012-10-30 19:29:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 30, 2012 7:29:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200763 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:29:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,22,'N','N',200846,'Y',200764,'N','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.','U','Direct internal record ID','Record ID','N','Y','f59ba408-8a5a-4e31-ab60-c6f2e4efe709',100,0,TO_TIMESTAMP('2012-10-30 19:29:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 30, 2012 7:29:35 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200764 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:29:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,10,'N','N',200845,'Y',200765,'N','The Database Table provides the information of the table definition','U','Database Table information','Table','N','Y','2fe9cfa6-af27-48ff-be30-0fddd12f5d1e',100,0,TO_TIMESTAMP('2012-10-30 19:29:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 30, 2012 7:29:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200765 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:29:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,2000,'N','N',200842,'Y',200766,'N','U','Text Message','Text Message','N','Y','1536d193-a444-4144-a7f7-d055fba2a037',100,0,TO_TIMESTAMP('2012-10-30 19:29:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 30, 2012 7:29:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200766 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:29:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,36,'N','N',200833,'Y',200767,'N','U','X_OnlineTrxHistory_UU','N','Y','e23a3c0f-3e02-4710-8ed7-7e1fd5ca1ec2',100,0,TO_TIMESTAMP('2012-10-30 19:29:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-30 19:29:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 30, 2012 7:29:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200767 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 30, 2012 7:30:36 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200767
;

-- Oct 30, 2012 7:30:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200760
;

-- Oct 30, 2012 7:30:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200763
;

-- Oct 30, 2012 7:30:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200765
;

-- Oct 30, 2012 7:30:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200764
;

-- Oct 30, 2012 7:30:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200759
;

-- Oct 30, 2012 7:30:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200766
;

-- Oct 30, 2012 7:30:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200761
;

-- Oct 30, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200767
;

-- Oct 30, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200760
;

-- Oct 30, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200763
;

-- Oct 30, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200765
;

-- Oct 30, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200764
;

-- Oct 30, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200759
;

-- Oct 30, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200766
;

-- Oct 30, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200761
;

-- Oct 30, 2012 7:31:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-30 19:31:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200763
;

-- Oct 30, 2012 7:31:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-30 19:31:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200764
;

-- Oct 30, 2012 7:31:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200760
;

-- Oct 30, 2012 7:31:20 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200763
;

-- Oct 30, 2012 7:31:21 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200765
;

-- Oct 30, 2012 7:31:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200764
;

-- Oct 30, 2012 7:31:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200759
;

-- Oct 30, 2012 7:31:27 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2012-10-30 19:31:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200766
;

-- Oct 30, 2012 7:31:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200761
;

-- Oct 30, 2012 7:31:34 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET NumLines=3,Updated=TO_TIMESTAMP('2012-10-30 19:31:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200766
;

-- Oct 30, 2012 7:31:38 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200759
;

-- Oct 30, 2012 7:31:39 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200761
;

-- Oct 30, 2012 7:31:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-10-30 19:31:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200764
;

-- Oct 30, 2012 7:32:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Description,AD_Menu_UU,"action",IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200018,200024,'N','Y','N','D','Y','Online Transaction History','Online Transaction History','63e5ab1c-273c-4493-b3d2-4ee12cc664e0','W','Y',0,100,TO_TIMESTAMP('2012-10-30 19:32:42','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-10-30 19:32:42','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 30, 2012 7:32:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200024 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Oct 30, 2012 7:32:43 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200024, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200024)
;

-- Oct 30, 2012 7:33:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Table SET AD_Window_ID=200018,Updated=TO_TIMESTAMP('2012-10-30 19:33:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200032
;

-- Oct 31, 2012 2:38:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200032,200847,'U','Y','N','N',0,'N',1,'N',20,'N',1047,'N','Y','f860da32-92b1-4c86-be03-db45c99b0ace','Y','N','Processed','The document has been processed','N','The Processed checkbox indicates that a document has been processed.','Processed','Y',100,TO_TIMESTAMP('2012-10-31 14:38:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-31 14:38:14','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Oct 31, 2012 2:38:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200847 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 2:38:24 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:38:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200847
;

-- Oct 31, 2012 2:38:29 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
ALTER TABLE X_OnlineTrxHistory ADD COLUMN Processed CHAR(1) DEFAULT 'N' CHECK (Processed IN ('Y','N')) NOT NULL
;

-- Oct 31, 2012 2:39:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200029,1,'N','N',200847,'Y',200768,'N','The Processed checkbox indicates that a document has been processed.','U','The document has been processed','Processed','N','Y','bd1ab7e7-8755-4864-9133-9528ec3ba6a8',100,0,TO_TIMESTAMP('2012-10-31 14:39:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-31 14:39:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 31, 2012 2:39:17 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200768 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 31, 2012 2:39:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200768
;

-- Oct 31, 2012 2:39:40 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200768
;

-- Oct 31, 2012 2:39:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:39:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200760
;

-- Oct 31, 2012 2:39:59 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:39:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200763
;

-- Oct 31, 2012 2:40:01 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:40:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200765
;

-- Oct 31, 2012 2:40:04 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:40:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200764
;

-- Oct 31, 2012 2:40:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:40:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200759
;

-- Oct 31, 2012 2:40:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:40:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200766
;

-- Oct 31, 2012 2:40:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:40:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200761
;

-- Oct 31, 2012 2:40:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET EntityType='D', XPosition=5, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-31 14:40:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200768
;

-- Oct 31, 2012 2:40:45 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-10-31 14:40:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200768
;

-- Oct 31, 2012 2:40:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Tab SET EntityType='D',Updated=TO_TIMESTAMP('2012-10-31 14:40:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200029
;

-- Oct 31, 2012 5:50:25 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET ObscureType='904',Updated=TO_TIMESTAMP('2012-10-31 17:50:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200692
;

-- Oct 31, 2012 6:51:30 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET IsAlwaysUpdateable='Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-10-31 18:51:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200807
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200663
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200670
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200702
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200706
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200669
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200716
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200684
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200690
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200694
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200705
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200673
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200664
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200671
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200718
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200719
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200720
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200699
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200677
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200678
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200715
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=200704
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=200693
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=200697
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=200711
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=200659
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=200674
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=200691
;

-- Oct 31, 2012 6:53:15 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=200676
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=200717
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=200692
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=200721
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=200687
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=200688
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=200658
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=200661
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=200655
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=200662
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=200660
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=200656
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y' WHERE AD_Field_ID=200686
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y' WHERE AD_Field_ID=200713
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=430,IsDisplayedGrid='Y' WHERE AD_Field_ID=200657
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=440,IsDisplayedGrid='Y' WHERE AD_Field_ID=200714
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=450,IsDisplayedGrid='Y' WHERE AD_Field_ID=200703
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=460,IsDisplayedGrid='Y' WHERE AD_Field_ID=200722
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=470,IsDisplayedGrid='Y' WHERE AD_Field_ID=200696
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=480,IsDisplayedGrid='Y' WHERE AD_Field_ID=200723
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=490,IsDisplayedGrid='Y' WHERE AD_Field_ID=200666
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=500,IsDisplayedGrid='Y' WHERE AD_Field_ID=200683
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=510,IsDisplayedGrid='Y' WHERE AD_Field_ID=200710
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=520,IsDisplayedGrid='Y' WHERE AD_Field_ID=200709
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=530,IsDisplayedGrid='Y' WHERE AD_Field_ID=200689
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=540,IsDisplayedGrid='Y' WHERE AD_Field_ID=200725
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=550,IsDisplayedGrid='Y' WHERE AD_Field_ID=200724
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=560,IsDisplayedGrid='Y' WHERE AD_Field_ID=200707
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=570,IsDisplayedGrid='Y' WHERE AD_Field_ID=200667
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=580,IsDisplayedGrid='Y' WHERE AD_Field_ID=200726
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=590,IsDisplayedGrid='Y' WHERE AD_Field_ID=200665
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=600,IsDisplayedGrid='Y' WHERE AD_Field_ID=200682
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=610,IsDisplayedGrid='Y' WHERE AD_Field_ID=200701
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=620,IsDisplayedGrid='Y' WHERE AD_Field_ID=200680
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=630,IsDisplayedGrid='Y' WHERE AD_Field_ID=200681
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=640,IsDisplayedGrid='Y' WHERE AD_Field_ID=200679
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=650,IsDisplayedGrid='Y' WHERE AD_Field_ID=200698
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=660,IsDisplayedGrid='Y' WHERE AD_Field_ID=200672
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=670,IsDisplayedGrid='Y' WHERE AD_Field_ID=200700
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=680,IsDisplayedGrid='Y' WHERE AD_Field_ID=200708
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=690,IsDisplayedGrid='Y' WHERE AD_Field_ID=200712
;

-- Oct 31, 2012 6:53:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=700,IsDisplayedGrid='Y' WHERE AD_Field_ID=200727
;

-- Oct 31, 2012 6:56:05 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:56:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Oct 31, 2012 6:56:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:56:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200725
;

-- Oct 31, 2012 6:56:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:56:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200724
;

-- Oct 31, 2012 6:56:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:56:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200686
;

-- Oct 31, 2012 6:56:12 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:56:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200713
;

-- Oct 31, 2012 6:56:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:56:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200657
;

-- Oct 31, 2012 6:57:07 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:57:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200686
;

-- Oct 31, 2012 6:57:09 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:57:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200713
;

-- Oct 31, 2012 6:57:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:57:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200657
;

-- Oct 31, 2012 6:59:32 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:59:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200631
;

-- Oct 31, 2012 6:59:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y',Updated=TO_TIMESTAMP('2012-10-31 18:59:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200630
;

-- Oct 31, 2012 7:19:49 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y & @IsVoided@=N',Updated=TO_TIMESTAMP('2012-10-31 19:19:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Oct 31, 2012 7:30:51 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET DisplayLogic='@TenderType@=C & @IsOnline@=Y & @IsVoided@=N & @TrxType@=A',Updated=TO_TIMESTAMP('2012-10-31 19:30:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200723
;

-- Oct 31, 2012 7:59:10 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Process (AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Name,Value,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,IsActive,CreatedBy) VALUES (200014,'N','N','3b09d6d9-a658-4f51-899e-109faca70c03','1','N','N',0,0,'Y','D','org.compiere.process.VoidOnlineAuthorizationPaymentTransaction','Void Online Authorization Payment Transaction Process','C_PaymentTransaction VoidIt',0,0,TO_TIMESTAMP('2012-10-31 19:59:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 19:59:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Oct 31, 2012 7:59:11 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Oct 31, 2012 7:59:54 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET AD_Process_ID=200014,Updated=TO_TIMESTAMP('2012-10-31 19:59:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200807
;

-- Nov 1, 2012 12:19:18 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field (NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (1,0,'N',200029,0,'N','N',200835,90,'Y',200769,'N','The Created field indicates the date that this record was created.','D','Date this record was created','Created','N','Y','56d853dc-31a4-42cd-9f73-99fccb8d116e',100,0,TO_TIMESTAMP('2012-11-01 12:19:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-01 12:19:15','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,1,2)
;

-- Nov 1, 2012 12:19:19 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200769 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 1, 2012 12:21:22 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Tab SET OrderByClause='Created DESC',Updated=TO_TIMESTAMP('2012-11-01 12:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200029
;

-- Nov 1, 2012 12:21:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200769
;

-- Nov 1, 2012 12:21:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200765
;

-- Nov 1, 2012 12:21:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200764
;

-- Nov 1, 2012 12:21:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200759
;

-- Nov 1, 2012 12:21:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200766
;

-- Nov 1, 2012 12:21:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200761
;

-- Nov 1, 2012 12:21:53 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200768
;

-- Nov 1, 2012 12:21:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200769
;

-- Nov 1, 2012 12:21:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200765
;

-- Nov 1, 2012 12:21:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200764
;

-- Nov 1, 2012 12:21:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200759
;

-- Nov 1, 2012 12:21:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200766
;

-- Nov 1, 2012 12:21:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200761
;

-- Nov 1, 2012 12:21:57 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200768
;

-- Nov 1, 2012 12:37:31 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Tab SET OrderByClause='Created DESC',Updated=TO_TIMESTAMP('2012-11-01 12:37:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200027
;

-- Nov 1, 2012 12:47:37 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET NumLines=5,Updated=TO_TIMESTAMP('2012-11-01 12:47:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200766
;

-- Nov 1, 2012 12:48:14 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-11-01 12:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200846
;

-- Nov 1, 2012 12:48:52 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-11-01 12:48:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200764
;

SELECT register_migration_script('201211012011_IDEMPIERE-462.sql') FROM dual
;
