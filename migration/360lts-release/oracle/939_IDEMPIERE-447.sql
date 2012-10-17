-- Oct 17, 2012 3:50:55 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=200593
;

-- Oct 17, 2012 3:50:55 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE FROM AD_Field WHERE AD_Field_ID=200593
;

-- Oct 17, 2012 3:51:07 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=200579
;

-- Oct 17, 2012 3:51:08 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE FROM AD_Column WHERE AD_Column_ID=200579
;

-- Oct 17, 2012 4:07:55 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','3',145,158,200030,'N','N','N','D','L','471aedbd-8298-42f2-8dad-ab8be38279f4','Y','N','C_BankAccount_Processor','Bank Account Processor',0,'Y',0,TO_DATE('2012-10-17 16:07:53','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2012-10-17 16:07:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 17, 2012 4:07:55 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200030 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Oct 17, 2012 4:08:18 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200688,'D','Y','N','N','N',22,'N',19,'N',129,'N',102,'N','Y','b9f429d0-2a8f-4ab0-94ec-85ff869690c5','N','N','N','AD_Client_ID','Client/Tenant for this installation.','@AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2012-10-17 16:08:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:18','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:18 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200688 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:19 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200689,'D','Y','N','N','N',22,'N',19,'N',104,'N',113,'N','Y','5c6f57bf-377c-4fe7-90a2-ebc74b974679','N','N','N','AD_Org_ID','Organizational entity within client','@AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2012-10-17 16:08:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:18','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:19 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200689 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:20 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200690,'D','Y','N','N','N',7,'N',16,'N','N',245,'N','Y','6cd0b686-74c5-4de9-b214-fc6b8aa2f7db','N','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2012-10-17 16:08:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:19','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:20 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200690 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:21 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200691,'D',110,'Y','N','N','N',22,'N',18,'N','N',246,'N','Y','c09022a9-0141-47d7-9008-13c435260519','N','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2012-10-17 16:08:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:21 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200691 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200692,'D','Y','N','N','N',1,'N',20,'N','N',348,'N','Y','3478bc60-b0df-4852-abfd-d44510806de5','N','Y','N','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2012-10-17 16:08:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:21','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200692 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200030,200693,'D','Y','N','N','Y',22,'N',19,'N','N',450,'N','Y','bbbf50a6-663b-4b83-a846-a01b7694e91a','N','N','N','M_PriceList_Version_ID','Identifies a unique instance of a Price List','Each Price List can have multiple versions.  The most common use is to indicate the dates that a Price List is valid for.','Price List Version','Y',100,TO_DATE('2012-10-17 16:08:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:22','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200693 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200694,'D','Y','N','N','Y',22,'N',30,'N',231,'N',454,'N','Y','59d9301f-daef-421d-9bf7-18726aae07a1','N','N','N','M_Product_ID','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.','Product','Y',100,TO_DATE('2012-10-17 16:08:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:22','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:23 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200694 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:24 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('C_BankAccount_Processor_UU',200185,'D','C_BankAccount_Processor_UU','C_BankAccount_Processor_UU','808efaa4-40d2-4e2e-9e6c-a6cf987dfe86',0,TO_DATE('2012-10-17 16:08:23','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-17 16:08:23','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 17, 2012 4:08:24 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200185 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 17, 2012 4:08:25 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200030,200695,'D','N','N','N','N',36,'N',10,'N','N',200185,'N','Y','81b5ac50-4154-48d4-bd71-01dcdda30bee','N','Y','N','C_BankAccount_Processor_UU','C_BankAccount_Processor_UU','N',100,TO_DATE('2012-10-17 16:08:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:23','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:25 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200695 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200696,'D','Y','N','N','N',22,'N',37,'N','N',955,'N','Y','511e5d93-d3e6-41d8-ba24-e90ad2c52d03','N','Y','N','PriceLimit','Lowest price for a product','The Price Limit indicates the lowest price for a product stated in the Price List Currency.','Limit Price','Y',100,TO_DATE('2012-10-17 16:08:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:25','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200696 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200697,'D','Y','N','N','N',22,'N',37,'N','N',520,'N','Y','b3938e76-d817-49fe-afa0-2975f144faa4','N','Y','N','PriceList','List Price','The List Price is the official List Price in the document currency.','List Price','Y',100,TO_DATE('2012-10-17 16:08:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:26','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:27 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200697 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:27 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200698,'D','Y','N','N','N',22,'N',37,'N','N',957,'N','Y','4444790c-113f-4ba0-8bc0-6b899e20fe2e','N','Y','N','PriceStd','Standard Price','The Standard Price indicates the standard or normal price for a product on this price list','Standard Price','Y',100,TO_DATE('2012-10-17 16:08:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:27 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200698 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:28 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200699,'D','Y','N','N','N',7,'N',16,'N','N',607,'N','Y','a94382be-adad-4ee6-adfe-306750d39756','N','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2012-10-17 16:08:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:28 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200699 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:08:29 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200030,200700,'D',110,'Y','N','N','N',22,'N',18,'N','N',608,'N','Y','5605e703-d80e-4517-bea5-dfee7e6b9b6e','N','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2012-10-17 16:08:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-10-17 16:08:28','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 17, 2012 4:08:29 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200700 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 17, 2012 4:09:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Column SET AD_Element_ID=836, IsUpdateable='N', ColumnName='C_BankAccount_ID', Description='Account at the Bank', Help='The Bank Account identifies an account at this Bank.', Name='Bank Account',Updated=TO_DATE('2012-10-17 16:09:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200693
;

-- Oct 17, 2012 4:09:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200693
;

-- Oct 17, 2012 4:09:04 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET Name='Bank Account', Description='Account at the Bank', Help='The Bank Account identifies an account at this Bank.' WHERE AD_Column_ID=200693 AND IsCentrallyMaintained='Y'
;

-- Oct 17, 2012 4:09:41 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Column SET AD_Reference_ID=19, AD_Val_Rule_ID=NULL, AD_Element_ID=1385, IsUpdateable='N', ColumnName='C_PaymentProcessor_ID', Description='Payment processor for electronic payments', Help='The Payment Processor indicates the processor to be used for electronic payments', Name='Payment Processor',Updated=TO_DATE('2012-10-17 16:09:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200694
;

-- Oct 17, 2012 4:09:41 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200694
;

-- Oct 17, 2012 4:09:41 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET Name='Payment Processor', Description='Payment processor for electronic payments', Help='The Payment Processor indicates the processor to be used for electronic payments' WHERE AD_Column_ID=200694 AND IsCentrallyMaintained='Y'
;

-- Oct 17, 2012 4:09:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=200696
;

-- Oct 17, 2012 4:09:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE FROM AD_Column WHERE AD_Column_ID=200696
;

-- Oct 17, 2012 4:09:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=200697
;

-- Oct 17, 2012 4:09:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE FROM AD_Column WHERE AD_Column_ID=200697
;

-- Oct 17, 2012 4:09:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=200698
;

-- Oct 17, 2012 4:09:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
DELETE FROM AD_Column WHERE AD_Column_ID=200698
;

-- Oct 17, 2012 4:10:15 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
CREATE TABLE C_BankAccount_Processor (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_BankAccount_ID NUMBER(10) NOT NULL, C_BankAccount_Processor_UU NVARCHAR2(36) DEFAULT NULL , C_PaymentProcessor_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT C_BankAccount_Processor_Key PRIMARY KEY (C_BankAccount_ID, C_PaymentProcessor_ID))
;

-- Oct 17, 2012 4:12:17 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,Help,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,Processing,IsActive) VALUES ('N',158,40,NULL,'N','N',200030,'N','N','N','Y','N',2,'f0709010-509c-4a1f-8773-68cbeefd0f04','D','Bank Account Processor','Maintain Bank Account Payment Processors',200026,0,TO_DATE('2012-10-17 16:12:17','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-10-17 16:12:17','YYYY-MM-DD HH24:MI:SS'),100,100,'N','Y')
;

-- Oct 17, 2012 4:12:18 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200026 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Oct 17, 2012 4:12:24 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200692,'Y',200640,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','2d243e8a-cbb3-45cf-b8fe-d36bb479c591',100,0,TO_DATE('2012-10-17 16:12:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-17 16:12:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 17, 2012 4:12:24 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200640 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 17, 2012 4:12:25 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,22,'N','N',200693,'Y',200641,'N','The Bank Account identifies an account at this Bank.','D','Account at the Bank','Bank Account','N','Y','fcdac875-f873-4d28-8aea-c063b02e6b9d',100,0,TO_DATE('2012-10-17 16:12:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-17 16:12:24','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 17, 2012 4:12:25 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200641 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 17, 2012 4:12:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,36,'N','N',200695,'Y',200642,'N','D','C_BankAccount_Processor_UU','N','Y','fb920783-2bd1-4f9d-9be1-bd5e52f51a4a',100,0,TO_DATE('2012-10-17 16:12:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-17 16:12:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 17, 2012 4:12:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200642 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 17, 2012 4:12:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,22,'N','N',200688,'Y',200643,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','ec299a6f-8cb0-4c1a-a02e-9e527de9e721',100,0,TO_DATE('2012-10-17 16:12:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-17 16:12:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 17, 2012 4:12:26 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200643 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 17, 2012 4:12:27 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,22,'N','N',200689,'Y',200644,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','e9fd2a83-3580-49ba-bcaa-b4c0ef35b758',100,0,TO_DATE('2012-10-17 16:12:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-17 16:12:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 17, 2012 4:12:27 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200644 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 17, 2012 4:12:28 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,22,'N','N',200694,'Y',200645,'N','The Payment Processor indicates the processor to be used for electronic payments','D','Payment processor for electronic payments','Payment Processor','N','Y','d9792865-1bb8-4052-b9ce-c8f1789b365f',100,0,TO_DATE('2012-10-17 16:12:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-17 16:12:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 17, 2012 4:12:28 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200645 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 17, 2012 4:13:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200642
;

-- Oct 17, 2012 4:13:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200643
;

-- Oct 17, 2012 4:13:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200644
;

-- Oct 17, 2012 4:13:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200641
;

-- Oct 17, 2012 4:13:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200645
;

-- Oct 17, 2012 4:13:10 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200640
;

-- Oct 17, 2012 4:13:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200642
;

-- Oct 17, 2012 4:13:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200643
;

-- Oct 17, 2012 4:13:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200644
;

-- Oct 17, 2012 4:13:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200641
;

-- Oct 17, 2012 4:13:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200645
;

-- Oct 17, 2012 4:13:22 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200640
;

-- Oct 17, 2012 4:13:46 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2012-10-17 16:13:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200644
;

-- Oct 17, 2012 4:13:47 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-17 16:13:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200643
;

-- Oct 17, 2012 4:13:48 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-17 16:13:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200644
;

-- Oct 17, 2012 4:13:49 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-17 16:13:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200641
;

-- Oct 17, 2012 4:13:51 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-10-17 16:13:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200645
;

-- Oct 17, 2012 4:13:53 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-10-17 16:13:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200640
;

-- Oct 17, 2012 4:14:14 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-17 16:14:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200643
;

-- Oct 17, 2012 4:14:15 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-17 16:14:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200644
;

-- Oct 17, 2012 4:14:24 PM SGT
-- IDEMPIERE-447 Abstract Payment Processor from Tenant configuration
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-10-17 16:14:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200641
;

INSERT INTO C_BankAccount_Processor (AD_Client_ID, AD_Org_ID, C_BankAccount_ID, C_PaymentProcessor_ID, Created, CreatedBy, IsActive, Updated, UpdatedBy) 
	SELECT AD_Client_ID, AD_Org_ID, C_BankAccount_ID, C_PaymentProcessor_ID, Created, CreatedBy, IsActive, Updated, UpdatedBy
	FROM C_BankAccount 
	WHERE (C_BankAccount_ID, C_PaymentProcessor_ID) NOT IN (
		SELECT C_BankAccount_ID, C_PaymentProcessor_ID FROM C_BankAccount_Processor)
	AND C_PaymentProcessor_ID IS NOT NULL;

ALTER TABLE C_BankAccount DROP COLUMN C_PaymentProcessor_ID;

SELECT register_migration_script('939_IDEMPIERE-447.sql') FROM dual
;