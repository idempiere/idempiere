-- Aug 17, 2012 1:03:26 PM COT
-- New Table
CREATE TABLE ASP_Ref_List (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Reference_ID NUMERIC(10) NOT NULL, AD_Ref_List_ID NUMERIC(10) NOT NULL, ASP_Level_ID NUMERIC(10) NOT NULL, ASP_Ref_List_ID NUMERIC(10) NOT NULL, ASP_Ref_List_UU VARCHAR(36) DEFAULT NULL , ASP_Status CHAR(1) DEFAULT 'U', Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), Updated TIMESTAMP DEFAULT NULL , UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT ASP_Ref_List_Key PRIMARY KEY (ASP_Ref_List_ID))
;


-- Aug 14, 2012 4:43:19 PM COT
-- Table to enable the asp filter to the ref list
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CopyColumnsFromTable,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','4',0,200011,'N','N','N','N','U','N','L','d4532318-c4b9-43ed-8ae0-a97bf2008ace','Y','Y','ASP_Ref_List','ASP_Ref_List',0,'Y',0,100,TO_TIMESTAMP('2012-08-14 16:43:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-14 16:43:17','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 14, 2012 4:43:19 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200011 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 14, 2012 4:43:26 PM COT
UPDATE AD_Table SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-14 16:43:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200011
;

-- Aug 14, 2012 4:43:52 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ASP_Ref_List_ID',200090,'D','ASP_Ref_List','ASP_Ref_List','8cd85dd3-af2d-4926-b7f5-49763a29eb56',0,TO_TIMESTAMP('2012-08-14 16:43:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-14 16:43:51','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 14, 2012 4:43:52 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200090 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;


-- Aug 14, 2012 4:43:53 PM COT
-- Key
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200293,'D','Y','N','N','N',10,'N',13,'Y',200090,'55a57ae8-d081-42e6-a5c1-41d326d21e52','N','N','N','ASP_Ref_List_ID','ASP_Ref_List',100,TO_TIMESTAMP('2012-08-14 16:43:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:51','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:53 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200293 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2012 4:43:53 PM COT
-- AD Client
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200294,'D','Y','N','N','N',10,'N',19,'N',102,'0ca1e1d8-9b2b-4a14-bb4d-b31e610a2eaf','N','N','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client',100,TO_DATE('2012-08-14 16:43:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-14 16:43:53','YYYY-MM-DD HH24:MI:SS'),100,0)
;


INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200294 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;



-- Aug 14, 2012 4:43:54 PM COT
-- AD_Org
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200295,'D','Y','N','N','N',10,'N',19,'N',113,'47189a0e-5c46-4edc-932b-e1e22ad4b202','N','N','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization',100,TO_TIMESTAMP('2012-08-14 16:43:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:53','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:54 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200295 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;


-- Aug 14, 2012 4:43:54 PM COT
-- Created
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200296,'D','Y','N','N','N',29,'N',16,'N',245,'cf5e8a71-219d-44bc-b2ba-62005342b5b0','N','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created',100,TO_TIMESTAMP('2012-08-14 16:43:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:54','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:54 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200296 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;


-- Aug 14, 2012 4:43:55 PM COT
-- Created By
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200297,'D',110,'Y','N','N','N',10,'N',18,'N',246,'6e3c010f-36ad-4505-8f78-17b77ecd114e','N','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By',100,TO_TIMESTAMP('2012-08-14 16:43:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:54','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:55 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200297 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;


-- Aug 14, 2012 4:43:55 PM COT
-- Updated By
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200298,'D',110,'Y','N','N','N',10,'N',18,'N',608,'c1a6e667-5ea2-4110-b01e-4ee2cd9c1799','N','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By',100,TO_TIMESTAMP('2012-08-14 16:43:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:55','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:55 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200298 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2012 4:43:56 PM COT
-- Reference
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200299,'D','Y','N','N','N',10,'N',19,'N',120,'40b51540-7ae8-4740-9624-3c3bb003788e','N','Y','N','AD_Reference_ID','System Reference and Validation','The Reference could be a display type, list or table validation.','Reference',100,TO_TIMESTAMP('2012-08-14 16:43:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:55','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:56 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200299 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2012 4:43:56 PM COT
-- UU
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('asp_ref_list_uu',200091,'D','asp_ref_list_uu','asp_ref_list_uu','35796bbc-b288-4646-af4c-ebb19866c08f',0,TO_TIMESTAMP('2012-08-14 16:43:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-14 16:43:56','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 14, 2012 4:43:56 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200091 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 14, 2012 4:43:57 PM COT
-- UU
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200300,'D','N','N','N','N',36,'N',10,'N',200091,'9cc459be-b830-4e56-b75e-7e4431b87ff9','N','Y','N','asp_ref_list_uu','asp_ref_list_uu',100,TO_TIMESTAMP('2012-08-14 16:43:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:56','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:57 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200300 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2012 4:43:57 PM COT
-- Active
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200301,'D','N','N','N','N',1,'N',20,'N',348,'a3472edc-7f0e-4a5f-8673-93b826af9c42','N','Y','N','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active',100,TO_TIMESTAMP('2012-08-14 16:43:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:57','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:57 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200301 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2012 4:43:58 PM COT
-- Status
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200302,'D','N','N','N','N',1,'N',20,'N',53327,'11a532b2-d0d8-4eea-8120-96525401214d','N','Y','N','ASP_Status','ASP Status',100,TO_TIMESTAMP('2012-08-14 16:43:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:57','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:58 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200302 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2012 4:43:58 PM COT
-- ID Ref List
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200303,'D','Y','N','N','N',10,'N',19,'N',119,'0778c23f-1c35-4656-ab7b-da0c6483ef97','N','Y','N','AD_Ref_List_ID','Reference List based on Table','The Reference List field indicates a list of reference values from a database tables.  Reference lists populate drop down list boxes in data entry screens','Reference List',100,TO_TIMESTAMP('2012-08-14 16:43:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:58','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:58 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200303 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2012 4:43:59 PM COT
-- Date last Updated
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200304,'D','N','N','N','N',29,'N',16,'N',607,'bd82cb97-0ad2-4e29-868b-a7dcdc9705ec','N','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated',100,TO_TIMESTAMP('2012-08-14 16:43:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:58','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:59 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200304 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2012 4:43:59 PM COT
-- ASP Level ID
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200011,200305,'D','Y','N','N','N',10,'N',19,'N',53326,'fade0ebc-a1b2-403a-8ded-64a248c89ecd','N','Y','N','ASP_Level_ID','ASP Level',100,TO_TIMESTAMP('2012-08-14 16:43:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-14 16:43:59','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2012 4:43:59 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200305 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;


-- Aug 14, 2012 4:45:34 PM COT
UPDATE AD_Column SET ColumnName='ASP_Ref_List_UU', Name='ASP_Ref_List_UU', IsAllowCopy='N',Updated=TO_TIMESTAMP('2012-08-14 16:45:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200300
;

-- Aug 14, 2012 4:45:34 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200300
;

-- Aug 14, 2012 4:45:34 PM COT
UPDATE AD_Field SET Name='ASP_Ref_List_UU', Description=NULL, Help=NULL WHERE AD_Column_ID=200300 AND IsCentrallyMaintained='Y'
;

-- Aug 14, 2012 4:45:47 PM COT
UPDATE AD_Element SET ColumnName='ASP_Ref_List_UU', Name='ASP_Ref_List_UU', PrintName='ASP_Ref_List_UU',Updated=TO_TIMESTAMP('2012-08-14 16:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200091
;

-- Aug 14, 2012 4:45:47 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200091
;

-- Aug 14, 2012 4:45:47 PM COT
UPDATE AD_Column SET ColumnName='ASP_Ref_List_UU', Name='ASP_Ref_List_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200091
;

-- Aug 14, 2012 4:45:47 PM COT
UPDATE AD_Process_Para SET ColumnName='ASP_Ref_List_UU', Name='ASP_Ref_List_UU', Description=NULL, Help=NULL, AD_Element_ID=200091 WHERE UPPER(ColumnName)='ASP_REF_LIST_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 14, 2012 4:45:47 PM COT
UPDATE AD_Process_Para SET ColumnName='ASP_Ref_List_UU', Name='ASP_Ref_List_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=200091 AND IsCentrallyMaintained='Y'
;

-- Aug 14, 2012 4:45:47 PM COT
UPDATE AD_Field SET Name='ASP_Ref_List_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200091) AND IsCentrallyMaintained='Y'
;

-- Aug 14, 2012 4:45:47 PM COT
UPDATE AD_PrintFormatItem SET PrintName='ASP_Ref_List_UU', Name='ASP_Ref_List_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200091)
;

-- Aug 14, 2012 4:48:26 PM COT
-- Tab in the window asp module
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,AD_Column_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('N',53015,120,'N','N',200011,'N','N','N','N',200305,'Y','N',2,'8a54e851-1731-4b8a-9e11-503f15f26aab','U','Ref List',200010,0,0,TO_TIMESTAMP('2012-08-14 16:48:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-14 16:48:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Aug 14, 2012 4:48:26 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200010 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;


-- Aug 14, 2012 4:48:34 PM COT
UPDATE AD_Tab SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-14 16:48:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200010
;

-- Aug 14, 2012 4:49:09 PM COT
-- Active
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200010,1,'N','N',200301,'Y',200277,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','Y','N','a299f169-5588-4ce8-a0a8-d9a5435835ae',100,0,TO_TIMESTAMP('2012-08-14 16:49:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 14, 2012 4:49:09 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200277 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;


-- Aug 14, 2012 4:49:10 PM COT
-- ASP Level
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200010,10,'N','N',200305,'Y',200278,'N','D','ASP Level','Y','N','8289aece-c729-4aff-bcda-16d76ef20f10',100,0,TO_TIMESTAMP('2012-08-14 16:49:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 14, 2012 4:49:10 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200278 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;


-- Aug 14, 2012 4:49:10 PM COT
-- Key
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200010,10,'N','N',200293,'Y',200279,'N','D','ASP_Ref_List','N','N','622dbe18-9630-4114-b4ae-9e2c5872c3ed',100,0,TO_TIMESTAMP('2012-08-14 16:49:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:10','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Aug 14, 2012 4:49:10 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200279 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;


-- Aug 14, 2012 4:49:11 PM COT
-- UU
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200010,36,'N','N',200300,'Y',200280,'N','D','ASP_Ref_List_UU','Y','N','47d4060c-eee9-4eec-8fd5-4a49a8e1da60',100,0,TO_TIMESTAMP('2012-08-14 16:49:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 14, 2012 4:49:11 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200280 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2012 4:49:11 PM COT
-- Status
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200010,1,'N','N',200302,'Y',200281,'N','D','ASP Status','Y','N','131721db-4fac-402d-bd4a-b9df4d28185d',100,0,TO_TIMESTAMP('2012-08-14 16:49:11','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:11','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 14, 2012 4:49:11 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200281 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2012 4:49:12 PM COT
-- Client
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200010,10,'N','N',200294,'Y',200282,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','Y','N','02fcc057-a62a-4c88-88b1-6844c675105b',100,0,TO_TIMESTAMP('2012-08-14 16:49:11','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:11','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 14, 2012 4:49:12 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200282 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;


-- Aug 14, 2012 4:49:12 PM COT
-- Organization
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200010,10,'N','N',200295,'Y',200283,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','Y','N','c4aa51bf-4eda-4fda-bec4-419343d33eec',100,0,TO_TIMESTAMP('2012-08-14 16:49:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 14, 2012 4:49:12 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200283 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2012 4:49:13 PM COT
-- Reference
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200010,10,'N','N',200299,'Y',200284,'N','The Reference could be a display type, list or table validation.','D','System Reference and Validation','Reference','Y','N','a1fb2962-baa0-4ed4-aa10-235151c79491',100,0,TO_TIMESTAMP('2012-08-14 16:49:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 14, 2012 4:49:13 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200284 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2012 4:49:13 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200010,10,'N','N',200303,'Y',200285,'N','The Reference List field indicates a list of reference values from a database tables.  Reference lists populate drop down list boxes in data entry screens','D','Reference List based on Table','Reference List','Y','N','981ba7dc-6214-459c-add0-a6831e47ff95',100,0,TO_TIMESTAMP('2012-08-14 16:49:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-14 16:49:13','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 14, 2012 4:49:13 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200285 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2012 4:50:07 PM COT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200282
;

-- Aug 14, 2012 4:50:07 PM COT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200283
;

-- Aug 14, 2012 4:50:07 PM COT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200278
;

-- Aug 14, 2012 4:50:07 PM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200284
;

-- Aug 14, 2012 4:50:07 PM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200285
;

-- Aug 14, 2012 4:50:07 PM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200281
;

-- Aug 14, 2012 4:50:07 PM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200277
;

-- Aug 14, 2012 4:50:27 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-14 16:50:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200283
;

-- Aug 14, 2012 4:50:34 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-14 16:50:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200285
;

-- Aug 14, 2012 4:50:43 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-14 16:50:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200277
;

-- Aug 14, 2012 4:56:32 PM COT
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Description,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_Ref_List.AD_Reference_ID=@AD_Reference_ID@',200003,'U','AD_Ref_List_ID by Reference','Ref List by Reference','S','6d752432-378a-4f8b-a1d5-81738e45731b',100,100,TO_TIMESTAMP('2012-08-14 16:56:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-14 16:56:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Aug 14, 2012 5:08:52 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=53234, AD_Reference_ID=17,Updated=TO_TIMESTAMP('2012-08-14 17:08:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200302
;

-- Aug 14, 2012 5:08:52 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=53234, AD_Reference_ID=17,Updated=TO_TIMESTAMP('2012-08-14 17:08:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200302
;

-- Aug 16, 2012 4:37:29 PM COT
UPDATE AD_Tab SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2012-08-16 16:37:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53058
;

-- Aug 17, 2012 10:45:49 AM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200280
;

-- Aug 17, 2012 10:46:41 AM COT
UPDATE AD_Column SET DefaultValue='@#AD_Client_ID@',Updated=TO_TIMESTAMP('2012-08-17 10:46:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200294
;

-- Aug 17, 2012 10:46:56 AM COT
UPDATE AD_Column SET DefaultValue='@#AD_Org_ID@',Updated=TO_TIMESTAMP('2012-08-17 10:46:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200295
;

-- Aug 17, 2012 10:47:11 AM COT
UPDATE AD_Column SET DefaultValue='U',Updated=TO_TIMESTAMP('2012-08-17 10:47:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200302
;

-- Aug 17, 2012 10:47:18 AM COT
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_TIMESTAMP('2012-08-17 10:47:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200301
;

-- Aug 17, 2012 11:48:50 AM COT
UPDATE AD_Column SET AD_Val_Rule_ID=200003,Updated=TO_TIMESTAMP('2012-08-17 11:48:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200303
;

-- Aug 17, 2012 2:42:59 PM COT
-- Sequence asp_ref_list
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',50000,'Y',1000000,1000000,'N','Y',200012,'ASP_Ref_List','ASP_Ref_List',1,'db36a063-5d47-4131-aded-85cce9c8b4c8',0,0,TO_TIMESTAMP('2012-08-17 14:42:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-17 14:42:58','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Aug 22, 2012 11:04:29 PM COT
UPDATE AD_Column SET AD_Val_Rule_ID=52047,Updated=TO_TIMESTAMP('2012-08-22 23:04:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200299
;

-- Aug 22, 2012 11:20:55 PM COT
-- IDEMPIERE-363 ASP / SaaS module - implement reference lists show/hide option
UPDATE AD_Column SET AD_Val_Rule_ID=186,Updated=TO_TIMESTAMP('2012-08-22 23:20:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54231
;

UPDATE AD_System
  SET LastMigrationScriptApplied='877_IDEMPIERE_363.sql'
WHERE LastMigrationScriptApplied<'877_IDEMPIERE_363.sql'
   OR LastMigrationScriptApplied IS NULL
;
