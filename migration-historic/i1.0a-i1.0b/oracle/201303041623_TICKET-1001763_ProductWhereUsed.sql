SET SQLBLANKLINES ON
SET DEFINE OFF

CREATE OR REPLACE VIEW RV_M_Product_WhereUsed_V AS 
 SELECT bom.ad_client_id, bom.ad_org_id, p2.m_product_id, p2.name AS selectedproductname, 
 p2.value AS selectedproductvalue, p2.description AS selectedproductdescription, b.pp_product_bom_id, 
 p.value, p.name, p.description, b.qtybom, b.line
   FROM m_product p2
   LEFT JOIN pp_product_bomline b ON p2.m_product_id = b.m_product_id
   LEFT JOIN pp_product_bom bom ON b.pp_product_bom_id = bom.pp_product_bom_id
   LEFT JOIN m_product p ON bom.m_product_id = p.m_product_id
  WHERE p.isactive = 'Y' AND b.isactive = 'Y' AND p2.isactive = 'Y'
;

-- Mar 1, 2013 2:25:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','3',0,200071,'N','Y','N','D','L','d50870a2-be0f-4af1-9e21-f2274ff2013a','Y','N','RV_M_Product_WhereUsed_V','Product/Component Where Used',0,'Y',0,TO_DATE('2013-03-01 14:25:28','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2013-03-01 14:25:28','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 1, 2013 2:25:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200071 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Mar 1, 2013 2:25:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200066,'da1fcf3f-75a0-49a9-8e8e-33bcb0333fa0','Table RV_M_Product_WhereUsed_V','RV_M_Product_WhereUsed_V',1,0,0,TO_DATE('2013-03-01 14:25:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 14:25:30','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Mar 1, 2013 2:26:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208727,'D','N','N','N','N',10,'N',19,'N',102,'beed4f42-399b-4528-a199-db97d9585a59','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client',100,TO_DATE('2013-03-01 14:26:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:27','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208727 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208728,'D','N','N','N','N',10,'N',19,'N',113,'0e956082-39e0-45b4-b9eb-219d35cadde5','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization',100,TO_DATE('2013-03-01 14:26:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:29','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208728 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208729,'D','N','N','N','N',10,'N',19,'N',454,'42d1334e-6e36-4285-9b9f-a22ccd9905f3','N','M_Product_ID','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.','Product',100,TO_DATE('2013-03-01 14:26:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:30','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208729 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('selectedproductname',202255,'D','selectedproductname','selectedproductname','6c2e9946-7985-4765-98f1-017e946b3de4',0,TO_DATE('2013-03-01 14:26:31','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 14:26:31','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 2:26:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202255 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 2:26:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208730,'D','N','N','N','N',255,'Y',10,'N',202255,'f52dcaac-a25c-45fc-a6e9-9d0fa5d2e475','N','selectedproductname','selectedproductname',100,TO_DATE('2013-03-01 14:26:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:31','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208730 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('selectedproductvalue',202256,'D','selectedproductvalue','selectedproductvalue','64c695a5-8338-4451-b5a8-b303916fc72a',0,TO_DATE('2013-03-01 14:26:32','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 14:26:32','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 2:26:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202256 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 2:26:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208731,'D','N','N','N','N',40,'N',10,'N',202256,'37809389-db8b-41e0-905d-91401de71557','N','selectedproductvalue','selectedproductvalue',100,TO_DATE('2013-03-01 14:26:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:32','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208731 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('selectedproductdescription',202257,'D','selectedproductdescription','selectedproductdescription','884d0a2c-e721-4535-bf53-78219a143a4d',0,TO_DATE('2013-03-01 14:26:34','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 14:26:34','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 2:26:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202257 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 2:26:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208732,'D','N','N','N','N',255,'N',10,'N',202257,'11024fa9-4688-4ca1-81e2-4961ca4c3b22','N','selectedproductdescription','selectedproductdescription',100,TO_DATE('2013-03-01 14:26:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208732 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208733,'D','N','N','N','N',10,'N',19,'N',53245,'9daccb82-ac45-4894-b04d-77513168ea19','N','PP_Product_BOM_ID','BOM & Formula','BOM & Formula',100,TO_DATE('2013-03-01 14:26:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208733 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208734,'D','N','N','N','N',40,'Y',10,'N',620,'a739c739-0e76-4b61-839c-3655e62b448a','N','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key',100,TO_DATE('2013-03-01 14:26:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208734 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208735,'D','N','N','Y',1,'N',255,'Y',10,'N',469,'780d73f6-fc81-45e6-82d5-9c0aeeeb657d','N','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name',100,TO_DATE('2013-03-01 14:26:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:38','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208735 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208736,'D','N','N','N','N',255,'Y',10,'N',275,'e677d5fe-e1e8-4719-b08d-4425e4164312','N','Description','Optional short description of the record','A description is limited to 255 characters.','Description',100,TO_DATE('2013-03-01 14:26:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208736 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208737,'D','N','N','N','N',131089,'N',29,'N',53255,'13304a67-8a49-410e-ba53-c85e8640a379','N','QtyBOM','Indicate the Quantity  use in this BOM','Exist two way the add a compenent to a BOM or Formula:

1.- Adding a Component based in quantity to use in this BOM
2.- Adding a Component based in % to use the Order Quantity of Manufacturing Order in this Formula.
','Quantity',100,TO_DATE('2013-03-01 14:26:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208737 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:26:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200071,208738,'D','N','N','N','N',10,'N',11,'N',439,'6e074fb9-0ead-4932-a046-5ede903e9781','N','Line','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','Line No',100,TO_DATE('2013-03-01 14:26:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-03-01 14:26:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Mar 1, 2013 2:26:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208738 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 2:27:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='SelectedProductDescription', Name='Selected Product Description', PrintName='Selected Product Description',Updated=TO_DATE('2013-03-01 14:27:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202257
;

-- Mar 1, 2013 2:27:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202257
;

-- Mar 1, 2013 2:27:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='SelectedProductDescription', Name='Selected Product Description', Description=NULL, Help=NULL WHERE AD_Element_ID=202257
;

-- Mar 1, 2013 2:27:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='SelectedProductDescription', Name='Selected Product Description', Description=NULL, Help=NULL, AD_Element_ID=202257 WHERE UPPER(ColumnName)='SELECTEDPRODUCTDESCRIPTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 2:27:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='SelectedProductDescription', Name='Selected Product Description', Description=NULL, Help=NULL WHERE AD_Element_ID=202257 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:27:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='SelectedProductDescription', Name='Selected Product Description', Description=NULL, Help=NULL WHERE AD_Element_ID=202257 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:27:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Selected Product Description', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202257) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:27:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Selected Product Description', Name='Selected Product Description' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202257)
;

-- Mar 1, 2013 2:27:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='SelectedProductName', Name='Selected Product Name', PrintName='Selected Product Name',Updated=TO_DATE('2013-03-01 14:27:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202255
;

-- Mar 1, 2013 2:27:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202255
;

-- Mar 1, 2013 2:27:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='SelectedProductName', Name='Selected Product Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202255
;

-- Mar 1, 2013 2:27:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='SelectedProductName', Name='Selected Product Name', Description=NULL, Help=NULL, AD_Element_ID=202255 WHERE UPPER(ColumnName)='SELECTEDPRODUCTNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 2:27:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='SelectedProductName', Name='Selected Product Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202255 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:27:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='SelectedProductName', Name='Selected Product Name', Description=NULL, Help=NULL WHERE AD_Element_ID=202255 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:27:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Selected Product Name', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202255) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:27:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Selected Product Name', Name='Selected Product Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202255)
;

-- Mar 1, 2013 2:28:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='SelectedProductValue', Name='Selected Product Value', PrintName='Selected Product Value',Updated=TO_DATE('2013-03-01 14:28:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202256
;

-- Mar 1, 2013 2:28:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202256
;

-- Mar 1, 2013 2:28:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='SelectedProductValue', Name='Selected Product Value', Description=NULL, Help=NULL WHERE AD_Element_ID=202256
;

-- Mar 1, 2013 2:28:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='SelectedProductValue', Name='Selected Product Value', Description=NULL, Help=NULL, AD_Element_ID=202256 WHERE UPPER(ColumnName)='SELECTEDPRODUCTVALUE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 1, 2013 2:28:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='SelectedProductValue', Name='Selected Product Value', Description=NULL, Help=NULL WHERE AD_Element_ID=202256 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:28:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='SelectedProductValue', Name='Selected Product Value', Description=NULL, Help=NULL WHERE AD_Element_ID=202256 AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:28:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Selected Product Value', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202256) AND IsCentrallyMaintained='Y'
;

-- Mar 1, 2013 2:28:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem pi SET PrintName='Selected Product Value', Name='Selected Product Value' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202256)
;

-- Mar 1, 2013 2:29:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_ReportView (AD_ReportView_UU,AD_Table_ID,AD_ReportView_ID,EntityType,Name,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Org_ID,IsActive) VALUES ('d9136825-2589-4001-b4bd-e6df2df8ff78',200071,200002,'D','RV_M_Product_WhereUsed_V',0,TO_DATE('2013-03-01 14:29:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 14:29:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Mar 1, 2013 2:30:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process (CopyFromProcess,Help,AD_Process_ID,IsDirectPrint,AD_ReportView_ID,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Description,Name,Value,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N','Enter a product/component below, and the system will check for BOM(s) that contain that product/component.  This report is non-recursive.  In other words, it will only show one parent level above the product/component.',200036,'N',200002,'Y','7f338cc6-05cc-42ba-8bf7-56051b4e7971','3','N','N',0,0,'Y','D','Product/Component Where Used','Product/Component Where Used','RV_M_Product_WhereUsed_V',0,0,TO_DATE('2013-03-01 14:30:39','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-01 14:30:39','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Mar 1, 2013 2:30:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200036 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Mar 1, 2013 2:31:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',454,200055,'89347a17-13c7-4705-88ad-502c19658f45','Identifies an item which is either purchased or sold in this organization.',200036,30,'Y','D','Product','M_Product_ID','Product, Service, Item',0,'Y',10,'Y',100,TO_DATE('2013-03-01 14:31:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 14:31:19','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 2:31:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200055 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 2:31:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET Help=NULL, Description='Please enter the product (component) you wish to search for', IsCentrallyMaintained='N',Updated=TO_DATE('2013-03-01 14:31:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200055
;

-- Mar 1, 2013 2:31:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para_Trl SET IsTranslated='N' WHERE AD_Process_Para_ID=200055
;

-- Mar 1, 2013 2:34:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,AD_Menu_UU,IsCentrallyMaintained,Name,Description,Action,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200044,'N','N','N',200036,'D','61d17885-f1e3-4600-bf7c-f66decb23e8d','Y','Product/Component Where Used',NULL,'R','Y',0,100,TO_DATE('2013-03-01 14:34:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-03-01 14:34:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 1, 2013 2:34:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200044 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Mar 1, 2013 2:34:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200044, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200044)
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=268
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=125
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=422
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=107
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=130
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=188
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=227
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=381
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=126
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=421
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=534
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200044
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=267
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=490
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=132
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=310
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200032
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200033
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200029
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=128
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=585
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=187
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53210
;

-- Mar 1, 2013 2:34:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=167, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53211
;

-- Mar 1, 2013 2:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormat (CreateCopy,IsForm,IsDefault,AD_PrintFormat_ID,IsStandardHeaderFooter,AD_ReportView_ID,AD_PrintPaper_ID,AD_PrintColor_ID,AD_PrintTableFormat_ID,IsTableBased,AD_Table_ID,HeaderMargin,AD_PrintFont_ID,AD_PrintFormat_UU,FooterMargin,Name,Updated,CreatedBy,Created,UpdatedBy,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('N','N','N',200006,'Y',200002,100,100,100,'Y',200071,0,130,'eb357ba2-5e77-4da2-919d-db942619249c',0,'Product/Component Where Used',TO_DATE('2013-03-01 14:38:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-01 14:38:59','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0)
;

-- Mar 1, 2013 2:39:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET AD_PrintPaper_ID=100, AD_PrintColor_ID=100, AD_Table_ID=200071, AD_PrintFont_ID=130, Name='RV_M_Product_WhereUsed_V_2',Updated=TO_DATE('2013-03-01 14:39:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200006
;

-- Mar 1, 2013 2:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Name',0,'Y','Y','C',200006,'N',0,'F','N',1,208735,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Name',1,'N','8f730ef8-fcf9-43b4-8635-5ade4f48fb60',0,200152,'N',0,TO_DATE('2013-03-01 14:39:12','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:12','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200152 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208735) WHERE AD_PrintFormatItem_ID = 200152 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208735 AND trl.AD_PrintFormatItem_ID = 200152) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('BOM & Formula',0,'N','Y','C',200006,'N',0,'F','N',2,208733,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','BOM & Formula',0,'N','a5ba879b-3be9-4a68-8b77-8a1cc83031e6',0,200153,'N',0,TO_DATE('2013-03-01 14:39:15','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:15','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200153 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208733) WHERE AD_PrintFormatItem_ID = 200153 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208733 AND trl.AD_PrintFormatItem_ID = 200153) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Client',0,'N','N','C',200006,'N',0,'F','N',0,208727,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Client',0,'N','e92f4a2c-aa33-43c4-8986-f0bb8a6b7fe8',0,200154,'N',0,TO_DATE('2013-03-01 14:39:16','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:16','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200154 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208727) WHERE AD_PrintFormatItem_ID = 200154 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208727 AND trl.AD_PrintFormatItem_ID = 200154) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Description',0,'N','Y','C',200006,'N',0,'F','N',4,208736,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Description',0,'N','ee989c86-9bd1-46a4-9230-5498215b5879',0,200155,'N',0,TO_DATE('2013-03-01 14:39:17','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:17','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200155 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208736) WHERE AD_PrintFormatItem_ID = 200155 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208736 AND trl.AD_PrintFormatItem_ID = 200155) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Line No',0,'N','Y','C',200006,'N',0,'F','N',5,208738,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Line No',0,'N','dc49bf58-92fd-4c98-a84c-a2e374641148',0,200156,'N',0,TO_DATE('2013-03-01 14:39:18','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:18','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200156 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208738) WHERE AD_PrintFormatItem_ID = 200156 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208738 AND trl.AD_PrintFormatItem_ID = 200156) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Organization',0,'N','N','C',200006,'N',0,'F','N',0,208728,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Organization',0,'N','0e671bf6-703a-4210-9586-201a390232e4',0,200157,'N',0,TO_DATE('2013-03-01 14:39:19','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:19','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200157 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208728) WHERE AD_PrintFormatItem_ID = 200157 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208728 AND trl.AD_PrintFormatItem_ID = 200157) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Product',0,'N','Y','C',200006,'N',0,'F','N',7,208729,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Product',0,'N','b906826a-0f2b-440f-94ba-3161fbc6ad2d',0,200158,'N',0,TO_DATE('2013-03-01 14:39:20','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:20','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200158 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208729) WHERE AD_PrintFormatItem_ID = 200158 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208729 AND trl.AD_PrintFormatItem_ID = 200158) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Quantity',0,'N','Y','C',200006,'N',0,'F','N',8,208737,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Quantity',0,'N','ddf1e9e8-af92-4b78-a631-c3ac9b7862d9',0,200159,'N',0,TO_DATE('2013-03-01 14:39:21','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:21','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200159 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208737) WHERE AD_PrintFormatItem_ID = 200159 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208737 AND trl.AD_PrintFormatItem_ID = 200159) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Search Key',0,'N','Y','C',200006,'N',0,'F','N',9,208734,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Search Key',0,'N','b7d011c9-46ad-4f70-a6e3-3806516c950c',0,200160,'N',0,TO_DATE('2013-03-01 14:39:22','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:22','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200160 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208734) WHERE AD_PrintFormatItem_ID = 200160 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208734 AND trl.AD_PrintFormatItem_ID = 200160) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Selected Product Description',0,'N','Y','C',200006,'N',0,'F','N',10,208732,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Selected Product Description',0,'N','db5849db-c725-4d6e-9a89-7b12f26a2dfb',0,200161,'N',0,TO_DATE('2013-03-01 14:39:23','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:23','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200161 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208732) WHERE AD_PrintFormatItem_ID = 200161 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208732 AND trl.AD_PrintFormatItem_ID = 200161) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Selected Product Name',0,'N','Y','C',200006,'N',0,'F','N',11,208730,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Selected Product Name',0,'N','01726c2f-2aaa-45aa-ba40-78a4853752b0',0,200162,'N',0,TO_DATE('2013-03-01 14:39:23','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:23','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200162 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208730) WHERE AD_PrintFormatItem_ID = 200162 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208730 AND trl.AD_PrintFormatItem_ID = 200162) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:39:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Selected Product Value',0,'N','Y','C',200006,'N',0,'F','N',12,208731,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Selected Product Value',0,'N','b6f59bad-6aff-4137-8d5d-d9323042ee2c',0,200163,'N',0,TO_DATE('2013-03-01 14:39:24','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_DATE('2013-03-01 14:39:24','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 2:39:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200163 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 2:39:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208731) WHERE AD_PrintFormatItem_ID = 200163 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208731 AND trl.AD_PrintFormatItem_ID = 200163) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200155
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200160
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200161
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200162
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200163
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=10,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200158
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=20,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200153
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=30,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200152
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=40,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200159
;

-- Mar 1, 2013 2:40:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=50,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200156
;

-- Mar 1, 2013 2:40:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET Name='Master BOM', XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsCentrallyMaintained='N', PrintName='Master BOM', SortNo=0,Updated=TO_DATE('2013-03-01 14:40:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200153
;

-- Mar 1, 2013 2:40:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200153
;

-- Mar 1, 2013 2:41:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_DATE('2013-03-01 14:41:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200153
;

-- Mar 1, 2013 2:41:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET Name='Product/Component Where Used',Updated=TO_DATE('2013-03-01 14:41:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200006
;

SELECT register_migration_script('201303041623_TICKET-1001763_ProductWhereUsed.sql') FROM dual
;
