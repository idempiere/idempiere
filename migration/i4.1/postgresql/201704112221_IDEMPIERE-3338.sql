CREATE TABLE pa_documentstatus ( pa_documentstatus_id numeric(10) NOT NULL, ad_client_id numeric(10) NOT NULL, ad_org_id numeric(10) NOT NULL, ad_role_id numeric(10) NULL, ad_user_id numeric(10) NULL, c_project_id numeric(10) NULL, created timestamp NOT NULL, createdby numeric(10) NOT NULL, updated timestamp NOT NULL, updatedby numeric(10) NOT NULL, name varchar(60) NOT NULL, description varchar(255) NULL, isactive bpchar(1) NOT NULL DEFAULT 'Y'::bpchar, seqno numeric(10) NOT NULL, name_printcolor_id numeric(10) NOT NULL, name_printfont_id numeric(10) NOT NULL, number_printcolor_id numeric(10) NOT NULL, number_printfont_id numeric(10) NOT NULL, ad_table_id numeric(10) NOT NULL, whereclause varchar(2000) NULL, ad_window_id numeric(10) NULL, ad_form_id numeric(10) NULL DEFAULT NULL::numeric, CONSTRAINT pa_docstatus_active_check CHECK ((isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))), CONSTRAINT pa_documentstatus_key PRIMARY KEY (pa_documentstatus_id) ) ;

-- IDEMPIERE-3338 - document status indicator
-- 11/04/2017 18h49min47s BRT
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200216,'Document Status','PA_DocumentStatus',0,'7',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:49:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:49:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','902a22b1-891f-4d94-9438-bc305abce6be','N','N','N')
;

-- 11/04/2017 18h49min48s BRT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('PA_DocumentStatus',1000000,'N','N','Table PA_DocumentStatus','Y','Y',0,0,TO_TIMESTAMP('2017-04-11 18:49:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:49:47','YYYY-MM-DD HH24:MI:SS'),100,200280,'Y',1000000,1,200000,'c9d7e750-6a14-4ee3-8ab0-0e52bddfc21e')
;

-- 11/04/2017 18h50min6s BRT
UPDATE AD_Table SET EntityType='D',Updated=TO_TIMESTAMP('2017-04-11 18:50:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200216
;

-- 11/04/2017 18h52min28s BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203069,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:27','YYYY-MM-DD HH24:MI:SS'),100,'PA_DocumentStatus_ID','Document Status','Document Status','D','a3621f9a-d7b8-4f9d-8609-dc75c9e2c28c')
;

-- 11/04/2017 18h52min28s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212983,0.0,'Document Status',200216,'PA_DocumentStatus_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:27','YYYY-MM-DD HH24:MI:SS'),100,203069,'N','N','D','N','927e5a19-885a-497a-9ba2-403d2908c1f0','N')
;

-- 11/04/2017 18h52min28s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (212984,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200216,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:28','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','6a0e08b7-ed09-4fd7-aeb9-44ab50b3bbd8','N','D')
;

-- 11/04/2017 18h52min28s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (212985,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200216,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:28','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','1728852b-0ad3-4753-a026-baf63cf1b959','N','D')
;

-- 11/04/2017 18h52min29s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (212986,0.0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200216,'AD_Role_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:28','YYYY-MM-DD HH24:MI:SS'),100,123,'N','N','D','N','90e9c912-c550-4d02-9f4c-5a92cb7d43af','N','C')
;

-- 11/04/2017 18h52min29s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212987,0.0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200216,'AD_User_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:29','YYYY-MM-DD HH24:MI:SS'),100,138,'N','N','D','N','db3a0dd3-6b5f-408c-844c-c462921029f9','N')
;

-- 11/04/2017 18h52min29s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212988,0.0,'Project','Financial Project','A Project allows you to track and control internal or external activities.',200216,'C_Project_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:29','YYYY-MM-DD HH24:MI:SS'),100,208,'N','N','D','N','9448bc9d-bbde-4138-8690-df718a9d2216','N')
;

-- 11/04/2017 18h52min29s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212989,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200216,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:29','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','6b95d360-5f34-4f49-ba9e-621dee8a9ed5','N')
;

-- 11/04/2017 18h52min29s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (212990,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200216,'CreatedBy',10,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:29','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','cb2a6103-3572-45b1-a2a8-aa24a35f62b0','N','D')
;

-- 11/04/2017 18h52min30s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212991,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200216,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','f6d0f676-20de-45a9-b9fd-ac4faf4e1959','N')
;

-- 11/04/2017 18h52min30s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (212992,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200216,'UpdatedBy',10,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','2104d6ed-0b66-409c-a2e8-45ddd01a24a0','N','D')
;

-- 11/04/2017 18h52min30s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212993,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200216,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','fedee024-fd3b-4f3e-bc23-6bda6c4b78db','N')
;

-- 11/04/2017 18h52min30s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212994,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200216,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','ad1ad80c-8e42-4780-818e-454bd4355804','N')
;

-- 11/04/2017 18h52min30s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212995,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200216,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','b42b23a8-df07-4a4c-8a13-65a97210895f','N')
;

-- 11/04/2017 18h52min30s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212996,0.0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200216,'SeqNo',10,'N','N','Y','N','N','N',11,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:30','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','b59e1982-78d1-453b-88e3-f91547844a4b','N')
;

-- 11/04/2017 18h52min31s BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203070,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,'name_printcolor_id','Print Color for Name','Print Color for Name','D','beaed179-9c69-4e06-b2ac-06c58ec0aeb0')
;

-- 11/04/2017 18h52min31s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212997,0.0,'Print Color for Name',200216,'name_printcolor_id',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,203070,'Y','N','D','N','037ba00c-ef76-41bb-8900-b7f2b10acfae','N')
;

-- 11/04/2017 18h52min31s BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203071,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,'name_printfont_id','Print Font for Name','Print Font for Name','D','b52fe533-6588-4e69-93c0-35cae47c5c18')
;

-- 11/04/2017 18h52min31s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212998,0.0,'Print Font for Name',200216,'name_printfont_id',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,203071,'Y','N','D','N','f0089b80-a8e4-45ce-991d-b93b378979de','N')
;

-- 11/04/2017 18h52min31s BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203072,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,'number_printcolor_id','Print Color for Number','Print Color for Number','D','5b5d4d22-466f-4f5c-aafc-012bb2ae620f')
;

-- 11/04/2017 18h52min31s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (212999,0.0,'Print Color for Number',200216,'number_printcolor_id',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,203072,'Y','N','D','N','39b57a04-849b-46e4-9ef9-43eb38fb5edf','N')
;

-- 11/04/2017 18h52min32s BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203073,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,'number_printfont_id','Print Font for Number','Print Font for Number','D','de84fd4d-4e60-4d5a-8893-b4c5ff3afe71')
;

-- 11/04/2017 18h52min32s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213000,0.0,'Print Font for Number',200216,'number_printfont_id',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,203073,'Y','N','D','N','0cc8ca2f-57b1-41e0-9392-a30af0db55ef','N')
;

-- 11/04/2017 18h52min32s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213001,0.0,'Table','Database Table information','The Database Table provides the information of the table definition',200216,'AD_Table_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:32','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','e70d6dfe-516d-46c6-91fb-0f7a667a376c','N','N')
;

-- 11/04/2017 18h52min32s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213002,0.0,'Sql WHERE','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".',200216,'WhereClause',2000,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:32','YYYY-MM-DD HH24:MI:SS'),100,630,'Y','N','D','N','7d2461ca-2e72-4331-8013-320d99c2ec3a','N')
;

-- 11/04/2017 18h52min32s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213003,0.0,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',200216,'AD_Window_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:32','YYYY-MM-DD HH24:MI:SS'),100,143,'Y','N','D','N','b89f7162-e45f-406d-9e41-9befd58dfb18','N','N')
;

-- 11/04/2017 18h52min33s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (213004,0.0,'Special Form','Special Form','The Special Form field identifies a unique Special Form in the system.',200216,'AD_Form_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:52:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:52:32','YYYY-MM-DD HH24:MI:SS'),100,1298,'Y','N','D','N','adca4186-c9b6-483d-a897-9d361cc56d70','N','N')
;

-- 11/04/2017 18h53min7s BRT
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200090,'Document Status',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:07','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','121c9bfb-4ba7-4ffc-a180-5fcada879abf')
;

-- 11/04/2017 18h53min29s BRT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200222,'Document Status',200090,10,'Y',200216,0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','Y','f8bf9ee8-5766-4360-a841-a3f7e04385c9','B')
;

-- 11/04/2017 18h53min33s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204399,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200222,212984,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','54e533e5-8104-416f-85d6-6ef64fa8e488','Y',10,2)
;

-- 11/04/2017 18h53min33s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204400,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200222,212985,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a1ea7d9b-71c9-4481-8136-bfa0da99b0e3','Y','Y',20,4,2)
;

-- 11/04/2017 18h53min34s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204401,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200222,212993,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','130ad7cc-b993-497c-8927-d3bf16fc87b7','Y',30,5)
;

-- 11/04/2017 18h53min34s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204402,'Description','Optional short description of the record','A description is limited to 255 characters.',200222,212994,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','22ade669-d167-4e89-aa2e-420c7576fac0','Y',40,5)
;

-- 11/04/2017 18h53min34s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (204403,'Document Status',200222,212983,'N',10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fcf1977b-3fee-411a-be63-7ee701ccc8c7','N',2)
;

-- 11/04/2017 18h53min34s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204404,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200222,212986,'Y',10,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fcbda817-0402-4b0a-85d0-e9788d87f1ff','Y',50,2)
;

-- 11/04/2017 18h53min34s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204405,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200222,212987,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b9011734-3dbf-4f76-9625-4ef04321fce2','Y',60,2)
;

-- 11/04/2017 18h53min34s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204406,'Project','Financial Project','A Project allows you to track and control internal or external activities.',200222,212988,'Y','@$Element_PJ@=Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','95a5f650-d5f5-4281-b636-014e6ebddd28','Y',70,2)
;

-- 11/04/2017 18h53min35s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204407,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200222,212996,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9f4fa5bb-7029-44a0-8d30-bc7693aa9ded','Y',80,2)
;

-- 11/04/2017 18h53min35s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204408,'Print Color for Name',200222,212997,'Y',10,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b3d42399-056a-4976-bcc9-376008989484','Y',90,2)
;

-- 11/04/2017 18h53min35s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204409,'Print Font for Name',200222,212998,'Y',10,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f2fc28d0-0204-4516-b317-a240b9fbc4e5','Y',100,2)
;

-- 11/04/2017 18h53min35s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204410,'Print Color for Number',200222,212999,'Y',10,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c4466995-fc95-4a39-a7d0-3e73f4085f94','Y',110,2)
;

-- 11/04/2017 18h53min35s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204411,'Print Font for Number',200222,213000,'Y',10,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7e1c5b6d-fe2b-4465-aecf-01d82ec54734','Y',120,2)
;

-- 11/04/2017 18h53min35s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204412,'Table','Database Table information','The Database Table provides the information of the table definition',200222,213001,'Y',10,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aee5d02a-37e6-41d4-9c93-7997132c806b','Y',130,2)
;

-- 11/04/2017 18h53min36s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (204413,'Sql WHERE','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".',200222,213002,'Y',2000,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d0e735e2-db4a-4a36-bb61-f24b2d322f06','Y',140,5,3)
;

-- 11/04/2017 18h53min36s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204414,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',200222,213003,'Y',10,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a4fc124a-b401-403f-b640-29f088f30d71','Y',150,2)
;

-- 11/04/2017 18h53min36s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204415,'Special Form','Special Form','The Special Form field identifies a unique Special Form in the system.',200222,213004,'Y',10,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f7c41944-d538-45e0-9d7b-e1ac783bbca4','Y',160,2)
;

-- 11/04/2017 18h53min36s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204416,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200222,212995,'Y',1,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-11 18:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 18:53:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','330a2d54-eceb-43f0-b23e-fcd87ddd053e','Y',170,2,2)
;

-- 11/04/2017 18h53min52s BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:53:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204403
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204416
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204404
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204405
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204406
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204407
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204408
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204410
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204412
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204413
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204414
;

-- 11/04/2017 18h56min17s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204415
;

-- 11/04/2017 18h59min31s BRT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=266, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:59:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212997
;

-- 11/04/2017 18h59min43s BRT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=266, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:59:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212998
;

-- 11/04/2017 18h59min56s BRT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=266, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2017-04-11 18:59:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212999
;

-- 11/04/2017 19h0min6s BRT
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=266, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2017-04-11 19:00:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213000
;

-- 11/04/2017 19h0min45s BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203076,0,0,'Y',TO_TIMESTAMP('2017-04-11 19:00:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 19:00:44','YYYY-MM-DD HH24:MI:SS'),100,'PA_DocumentStatus_UU','PA_DocumentStatus_UU','PA_DocumentStatus_UU','D','8c2e3e95-1e24-4189-b3cc-c516e8c132a8')
;

-- 11/04/2017 19h0min45s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213007,1.0,'PA_DocumentStatus_UU',200216,'PA_DocumentStatus_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-04-11 19:00:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 19:00:44','YYYY-MM-DD HH24:MI:SS'),100,203076,'Y','N','D','N','a44a25de-f95f-4806-bdc5-2e54305ca0bb','N')
;

-- 11/04/2017 19h0min45s BRT
ALTER TABLE PA_DocumentStatus ADD COLUMN PA_DocumentStatus_UU VARCHAR(36) DEFAULT NULL
;

-- 11/04/2017 19h0min45s BRT
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT PA_DocumentStatus_UU_idx UNIQUE (PA_DocumentStatus_UU)
;

-- 11/04/2017 19h1min59s BRT
UPDATE AD_Table SET AD_Window_ID=200090,Updated=TO_TIMESTAMP('2017-04-11 19:01:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200216
;

-- 11/04/2017 19h2min26s BRT
UPDATE AD_Table SET Name='Document Status Indicator',Updated=TO_TIMESTAMP('2017-04-11 19:02:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200216
;

-- 11/04/2017 19h2min45s BRT
UPDATE AD_Tab SET Name='Document Status Indicator',Updated=TO_TIMESTAMP('2017-04-11 19:02:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200222
;

-- 11/04/2017 19h3min28s BRT
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200145,'Document Status Indicator','W',200090,0,0,'Y',TO_TIMESTAMP('2017-04-11 19:03:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 19:03:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','6e7804fa-ea65-4f7c-b724-ba3ec71ca0a2')
;

-- 11/04/2017 19h3min28s BRT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200145, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200145)
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200145
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200065
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- 11/04/2017 19h3min47s BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- 11/04/2017 19h4min42s BRT
INSERT INTO PA_DashboardContent (Name,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive,Line,Updated,AD_Client_ID,PA_DashboardContent_ID,ColumnNo,ZulFilePath,IsCollapsible,GoalDisplay,PA_DashboardContent_UU,IsShowInDashboard,IsEmbedReportContent,IsCollapsedByDefault,AD_User_ID,AD_Role_ID,IsShowinLogin) VALUES ('Document Status window display',0,TO_TIMESTAMP('2017-04-11 19:04:42','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',0,TO_TIMESTAMP('2017-04-11 19:04:42','YYYY-MM-DD HH24:MI:SS'),0,200003,1,'/zul/docstatus.zul','Y','T','ff808989-6264-4c4c-98a9-83c8b0fe00ef','Y','N','N',0,0,'Y')
;

-- 11/04/2017 19h5min43s BRT
UPDATE AD_Column SET AD_Reference_Value_ID=267,Updated=TO_TIMESTAMP('2017-04-11 19:05:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212998
;

-- 11/04/2017 19h5min49s BRT
UPDATE AD_Column SET AD_Reference_Value_ID=267,Updated=TO_TIMESTAMP('2017-04-11 19:05:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213000
;

-- 11/04/2017 19h6min40s BRT
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,AD_Role_ID,AD_User_ID,Created,CreatedBy,Updated,UpdatedBy,Name,IsActive,SeqNo,name_printcolor_id,name_printfont_id,number_printcolor_id,number_printfont_id,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU) VALUES (200000,11,0,null,null,TO_TIMESTAMP('2017-04-11 19:06:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 19:06:39','YYYY-MM-DD HH24:MI:SS'),100,'Sales Orders received today','Y',50,100,129,102,129,259,'C_Order.IsSoTrx=''Y'' and c_Order.DateOrdered > SYSDATE-1',143,'07fa8eef-2ad7-476a-b1ce-ebc6a5caf6fc')
;

-- 11/04/2017 19h7min35s BRT
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Name,IsActive,SeqNo,name_printcolor_id,name_printfont_id,number_printcolor_id,number_printfont_id,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU) VALUES (200001,11,0,TO_TIMESTAMP('2017-04-11 19:07:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-11 19:07:35','YYYY-MM-DD HH24:MI:SS'),100,'Pending Customer Shipments','Y',60,100,129,102,129,319,'M_InOut.IsSOTrx=''Y'' AND M_InOut.Processed=''N''',169,'e6df3b28-7ba1-4277-99e8-fa4ff9bfd082')
;

-- 11/04/2017 19h7min49s BRT
UPDATE AD_Column SET DefaultValue='-1',Updated=TO_TIMESTAMP('2017-04-11 19:07:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212986
;

-- 11/04/2017 19h8min18s BRT
UPDATE AD_Column SET DefaultValue='-1',Updated=TO_TIMESTAMP('2017-04-11 19:08:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212987
;

-- Apr 12, 2017 5:59:43 PM CEST
UPDATE AD_Table SET IsChangeLog='Y',Updated=TO_TIMESTAMP('2017-04-12 17:59:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200216
;

-- IDEMPIERE-3338 Document Status Indicator
-- Apr 12, 2017 6:20:01 PM CEST
UPDATE PA_DashboardContent SET IsActive='N',Updated=TO_TIMESTAMP('2017-04-12 18:20:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=50000
;

-- Apr 12, 2017 6:20:14 PM CEST
UPDATE PA_DashboardContent SET Name='Activities', ColumnNo=0,Updated=TO_TIMESTAMP('2017-04-12 18:20:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200003
;

-- Apr 12, 2017 6:23:42 PM CEST
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Name,IsActive,SeqNo,name_printcolor_id,name_printfont_id,number_printcolor_id,number_printfont_id,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU) VALUES (200002,0,0,TO_TIMESTAMP('2017-04-12 18:23:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 18:23:42','YYYY-MM-DD HH24:MI:SS'),10,'Notice','Y',10,100,131,100,131,389,'AD_Client_ID=@#AD_Client_ID@ AND AD_User_ID IN (0,@#AD_User_ID@) AND Processed=''N'' AND AD_BroadcastMessage_ID IS NULL',193,'5243bd4a-7da4-44bb-90dd-08846ad3fcf1')
;

-- Apr 12, 2017 7:23:51 PM CEST
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Name,IsActive,SeqNo,name_printcolor_id,name_printfont_id,number_printcolor_id,number_printfont_id,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU) VALUES (200003,0,0,TO_TIMESTAMP('2017-04-12 19:23:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:23:51','YYYY-MM-DD HH24:MI:SS'),100,'Request','Y',20,100,131,100,131,417,'(SalesRep_ID=@#AD_User_ID@ OR AD_Role_ID=@#AD_Role_ID@) AND Processed=''N'' AND (DateNextAction IS NULL OR TRUNC(DateNextAction) <= TRUNC(SysDate)) AND (R_Status_ID IS NULL OR R_Status_ID IN (SELECT R_Status_ID FROM R_Status WHERE IsClosed=''N''))',201,'202b749a-cf08-41fc-b93c-67c6a28a6786')
;

-- Apr 12, 2017 7:27:03 PM CEST
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Name,IsActive,SeqNo,name_printcolor_id,name_printfont_id,number_printcolor_id,number_printfont_id,AD_Table_ID,WhereClause,AD_Form_ID,PA_DocumentStatus_UU) VALUES (200004,0,0,TO_TIMESTAMP('2017-04-12 19:27:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:27:03','YYYY-MM-DD HH24:MI:SS'),100,'Request','Y',30,100,131,100,131,644,'a.Processed=''N'' AND a.WFState=''OS'' AND ("
/* Owner of Activity */
a.AD_User_ID=@#AD_User_ID@
/* Invoker (if no invoker = all) */
OR EXISTS (SELECT * FROM AD_WF_Responsible r WHERE a.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID"
AND r.ResponsibleType=''H'' AND COALESCE(r.AD_User_ID,0)=0 AND COALESCE(r.AD_Role_ID,0)=0 AND (a.AD_User_ID=@#AD_User_ID@ OR a.AD_User_ID IS NULL))
/* Responsible User */
OR EXISTS (SELECT * FROM AD_WF_Responsible r WHERE a.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID"
AND r.ResponsibleType=''H'' AND r.AD_User_ID=@#AD_User_ID@)
/* Responsible Role */
OR EXISTS (SELECT * FROM AD_WF_Responsible r INNER JOIN AD_User_Roles ur ON (r.AD_Role_ID=ur.AD_Role_ID)"
WHERE a.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID AND r.ResponsibleType=''R'' AND ur.AD_User_ID=@#AD_User_ID@)
) AND a.AD_Client_ID=@#AD_Client_ID@
',117,'fc908088-6254-4e4f-b070-0de535fef6fd')
;

-- Apr 12, 2017 7:28:32 PM CEST
INSERT INTO PA_DocumentStatus (PA_DocumentStatus_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Name,IsActive,SeqNo,name_printcolor_id,name_printfont_id,number_printcolor_id,number_printfont_id,AD_Table_ID,WhereClause,AD_Window_ID,PA_DocumentStatus_UU) VALUES (200005,0,0,TO_TIMESTAMP('2017-04-12 19:28:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:28:31','YYYY-MM-DD HH24:MI:SS'),100,'Unprocessed Documents','Y',40,100,131,100,131,53221,'AD_Client_ID=@#AD_Client_ID@ AND CreatedBy=@#AD_User_ID@',53086,'3b78213b-9cd6-44a8-81d9-65e84b91bfdc')
;

-- Apr 12, 2017 7:33:08 PM CEST
UPDATE PA_DocumentStatus SET WhereClause='AD_WF_Activity.Processed=''N'' AND AD_WF_Activity.WFState=''OS'' AND (
/* Owner of Activity */
AD_WF_Activity.AD_User_ID=@#AD_User_ID@
/* Invoker (if no invoker = all) */
OR EXISTS (SELECT * FROM AD_WF_Responsible r WHERE AD_WF_Activity.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID
AND r.ResponsibleType=''H'' AND COALESCE(r.AD_User_ID,0)=0 AND COALESCE(r.AD_Role_ID,0)=0 AND (AD_WF_Activity.AD_User_ID=@#AD_User_ID@ OR AD_WF_Activity.AD_User_ID IS NULL))
/* Responsible User */
OR EXISTS (SELECT * FROM AD_WF_Responsible r WHERE AD_WF_Activity.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID
AND r.ResponsibleType=''H'' AND r.AD_User_ID=@#AD_User_ID@)
/* Responsible Role */
OR EXISTS (SELECT * FROM AD_WF_Responsible r INNER JOIN AD_User_Roles ur ON (r.AD_Role_ID=ur.AD_Role_ID)
WHERE AD_WF_Activity.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID AND r.ResponsibleType=''R'' AND ur.AD_User_ID=@#AD_User_ID@)
) AND AD_WF_Activity.AD_Client_ID=@#AD_Client_ID@',Updated=TO_TIMESTAMP('2017-04-12 19:33:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200004
;

-- Apr 12, 2017 7:33:59 PM CEST
UPDATE PA_DocumentStatus SET Name='Workflow Activities',Updated=TO_TIMESTAMP('2017-04-12 19:33:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200004
;

-- Apr 12, 2017 7:37:14 PM CEST
UPDATE AD_Tab SET OrderByClause='PA_DocumentStatus.SeqNo',Updated=TO_TIMESTAMP('2017-04-12 19:37:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200222
;

-- Apr 12, 2017 7:44:46 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing) VALUES (200217,'Document Status Trl',NULL,200090,'PA_DocumentStatus_Trl',145,'7',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:44:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:44:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','L','Y','4b3df9cc-86c7-4fb3-9b35-10b6ec28de7e','N')
;

-- Apr 12, 2017 7:44:46 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('PA_DocumentStatus_Trl',1000000,'N','N','Table PA_DocumentStatus_Trl','Y','Y',0,0,TO_TIMESTAMP('2017-04-12 19:44:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:44:46','YYYY-MM-DD HH24:MI:SS'),100,200281,'Y',1000000,1,200000,'48314e8b-356c-48fd-bb18-95386def6cf3')
;

-- Apr 12, 2017 7:45:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213008,1,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200217,129,'AD_Client_ID','@AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:10','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','7652cb1e-f3ea-4ee7-b308-8b538eebf5f8','N','N','N','D')
;

-- Apr 12, 2017 7:45:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213009,1,'Column','Column in the table','Link to the database column of the table',200217,'AD_Column_ID',22,'N','Y','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:10','YYYY-MM-DD HH24:MI:SS'),100,104,'N','N','D','N','N','N','Y','1b4493d8-8994-41ea-9d3d-5f134cd1d198','Y','N','N','C')
;

-- Apr 12, 2017 7:45:11 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203077,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:11','YYYY-MM-DD HH24:MI:SS'),100,'PA_DocumentStatus_Trl_UU','PA_DocumentStatus_Trl_UU','PA_DocumentStatus_Trl_UU','D','a5557e5f-8777-43f6-89d7-6c9794616afb')
;

-- Apr 12, 2017 7:45:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (213010,1.00,'PA_DocumentStatus_Trl_UU',200217,'PA_DocumentStatus_Trl_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:11','YYYY-MM-DD HH24:MI:SS'),100,203077,'Y','N','D','N','N','N','Y','bd57b0dc-f859-485a-a8a2-2cd8627986a3','N','N','N')
;

-- Apr 12, 2017 7:45:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213011,1,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200217,'AD_Language',6,'N','Y','Y','N','N',0,'N',18,106,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:11','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','N','N','Y','1f56790c-872a-49f3-ab50-266254f9de72','Y','N','N','N')
;

-- Apr 12, 2017 7:45:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213012,1,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200217,104,'AD_Org_ID','@AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:12','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','dbdce8aa-6e2b-4f06-a806-23f2f807dd94','N','N','N','D')
;

-- Apr 12, 2017 7:45:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (213013,1,'Created','Date this record was created','The Created field indicates the date that this record was created.',200217,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:12','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','c673a880-09c1-4e62-bba9-3d2dd3ae3c13','N','N','N')
;

-- Apr 12, 2017 7:45:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213014,1,'Created By','User who created this records','The Created By field indicates the user who created this record.',200217,'CreatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:13','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','d80db012-4c4c-427d-bf93-893c549b1d84','N','N','N','D')
;

-- Apr 12, 2017 7:45:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (213015,1,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200217,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:13','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','8c9f048b-cddb-4e25-b1a2-9298c10e6d18','N','N','N')
;

-- Apr 12, 2017 7:45:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (213016,1,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200217,'IsTranslated',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:13','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','N','N','Y','0255dbe6-841d-4ed8-824d-1ab18c11c90f','Y','N','N')
;

-- Apr 12, 2017 7:45:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (213017,1,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200217,'Name',60,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:14','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','8729a576-e682-4776-ae44-b087e69e794a','Y','N','N')
;

-- Apr 12, 2017 7:45:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (213018,1,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200217,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:14','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','7de627e8-f738-496e-888e-67ac2ea9eecd','N','N','N')
;

-- Apr 12, 2017 7:45:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213019,1,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200217,'UpdatedBy',22,'N','N','Y','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:45:14','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','33ba98a5-9c99-49e6-addb-0c059408153c','N','N','N','D')
;

-- Apr 12, 2017 7:46:15 PM CEST
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2017-04-12 19:46:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212993
;

-- Apr 12, 2017 7:47:23 PM CEST
UPDATE AD_Element SET ColumnName='Name_PrintColor_ID', EntityType='D',Updated=TO_TIMESTAMP('2017-04-12 19:47:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203070
;

-- Apr 12, 2017 7:47:23 PM CEST
UPDATE AD_Column SET ColumnName='Name_PrintColor_ID', Name='Print Color for Name', Description=NULL, Help=NULL WHERE AD_Element_ID=203070
;

-- Apr 12, 2017 7:47:23 PM CEST
UPDATE AD_Process_Para SET ColumnName='Name_PrintColor_ID', Name='Print Color for Name', Description=NULL, Help=NULL, AD_Element_ID=203070 WHERE UPPER(ColumnName)='NAME_PRINTCOLOR_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 12, 2017 7:47:23 PM CEST
UPDATE AD_Process_Para SET ColumnName='Name_PrintColor_ID', Name='Print Color for Name', Description=NULL, Help=NULL WHERE AD_Element_ID=203070 AND IsCentrallyMaintained='Y'
;

-- Apr 12, 2017 7:47:23 PM CEST
UPDATE AD_InfoColumn SET ColumnName='Name_PrintColor_ID', Name='Print Color for Name', Description=NULL, Help=NULL WHERE AD_Element_ID=203070 AND IsCentrallyMaintained='Y'
;

-- Apr 12, 2017 7:47:50 PM CEST
UPDATE AD_Element SET ColumnName='Name_PrintFont_ID', EntityType='D',Updated=TO_TIMESTAMP('2017-04-12 19:47:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203071
;

-- Apr 12, 2017 7:47:50 PM CEST
UPDATE AD_Column SET ColumnName='Name_PrintFont_ID', Name='Print Font for Name', Description=NULL, Help=NULL WHERE AD_Element_ID=203071
;

-- Apr 12, 2017 7:47:50 PM CEST
UPDATE AD_Process_Para SET ColumnName='Name_PrintFont_ID', Name='Print Font for Name', Description=NULL, Help=NULL, AD_Element_ID=203071 WHERE UPPER(ColumnName)='NAME_PRINTFONT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 12, 2017 7:47:50 PM CEST
UPDATE AD_Process_Para SET ColumnName='Name_PrintFont_ID', Name='Print Font for Name', Description=NULL, Help=NULL WHERE AD_Element_ID=203071 AND IsCentrallyMaintained='Y'
;

-- Apr 12, 2017 7:47:50 PM CEST
UPDATE AD_InfoColumn SET ColumnName='Name_PrintFont_ID', Name='Print Font for Name', Description=NULL, Help=NULL WHERE AD_Element_ID=203071 AND IsCentrallyMaintained='Y'
;

-- Apr 12, 2017 7:48:24 PM CEST
UPDATE AD_Element SET ColumnName='Number_PrintColor_ID', EntityType='D',Updated=TO_TIMESTAMP('2017-04-12 19:48:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203072
;

-- Apr 12, 2017 7:48:24 PM CEST
UPDATE AD_Column SET ColumnName='Number_PrintColor_ID', Name='Print Color for Number', Description=NULL, Help=NULL WHERE AD_Element_ID=203072
;

-- Apr 12, 2017 7:48:24 PM CEST
UPDATE AD_Process_Para SET ColumnName='Number_PrintColor_ID', Name='Print Color for Number', Description=NULL, Help=NULL, AD_Element_ID=203072 WHERE UPPER(ColumnName)='NUMBER_PRINTCOLOR_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 12, 2017 7:48:24 PM CEST
UPDATE AD_Process_Para SET ColumnName='Number_PrintColor_ID', Name='Print Color for Number', Description=NULL, Help=NULL WHERE AD_Element_ID=203072 AND IsCentrallyMaintained='Y'
;

-- Apr 12, 2017 7:48:24 PM CEST
UPDATE AD_InfoColumn SET ColumnName='Number_PrintColor_ID', Name='Print Color for Number', Description=NULL, Help=NULL WHERE AD_Element_ID=203072 AND IsCentrallyMaintained='Y'
;

-- Apr 12, 2017 7:48:37 PM CEST
UPDATE AD_Element SET ColumnName='Number_PrintFont_ID', EntityType='D',Updated=TO_TIMESTAMP('2017-04-12 19:48:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203073
;

-- Apr 12, 2017 7:48:37 PM CEST
UPDATE AD_Column SET ColumnName='Number_PrintFont_ID', Name='Print Font for Number', Description=NULL, Help=NULL WHERE AD_Element_ID=203073
;

-- Apr 12, 2017 7:48:37 PM CEST
UPDATE AD_Process_Para SET ColumnName='Number_PrintFont_ID', Name='Print Font for Number', Description=NULL, Help=NULL, AD_Element_ID=203073 WHERE UPPER(ColumnName)='NUMBER_PRINTFONT_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 12, 2017 7:48:37 PM CEST
UPDATE AD_Process_Para SET ColumnName='Number_PrintFont_ID', Name='Print Font for Number', Description=NULL, Help=NULL WHERE AD_Element_ID=203073 AND IsCentrallyMaintained='Y'
;

-- Apr 12, 2017 7:48:37 PM CEST
UPDATE AD_InfoColumn SET ColumnName='Number_PrintFont_ID', Name='Print Font for Number', Description=NULL, Help=NULL WHERE AD_Element_ID=203073 AND IsCentrallyMaintained='Y'
;

-- Apr 12, 2017 7:51:05 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADColumn_PADocumentStatusTrl', FKConstraintType='C',Updated=TO_TIMESTAMP('2017-04-12 19:51:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213009
;

-- Apr 12, 2017 7:51:05 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADLanguage_PADocumentStatusTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:51:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213011
;

-- Apr 12, 2017 7:51:05 PM CEST
CREATE TABLE PA_DocumentStatus_Trl (AD_Client_ID NUMERIC(10) NOT NULL, PA_DocumentStatus_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, PA_DocumentStatus_Trl_UU VARCHAR(36) DEFAULT NULL , Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT PA_DocumentStatus_Trl_UU_idx UNIQUE (PA_DocumentStatus_Trl_UU))
;

-- Apr 12, 2017 7:51:05 PM CEST
ALTER TABLE PA_DocumentStatus_Trl ADD CONSTRAINT PADocumentStatus_PADocumentSta FOREIGN KEY (PA_DocumentStatus_ID) REFERENCES pa_documentstatus(pa_documentstatus_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:51:05 PM CEST
ALTER TABLE PA_DocumentStatus_Trl ADD CONSTRAINT ADLanguage_PADocumentStatusTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:51:42 PM CEST
UPDATE AD_Column SET FKConstraintName='ADForm_PADocumentStatus', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:51:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213004
;

-- Apr 12, 2017 7:51:42 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','AD_Form_ID','NUMERIC(10)',null,'NULL')
;

-- Apr 12, 2017 7:51:42 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT ADForm_PADocumentStatus FOREIGN KEY (AD_Form_ID) REFERENCES ad_form(ad_form_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:51:53 PM CEST
UPDATE AD_Column SET FKConstraintName='ADRole_PADocumentStatus', FKConstraintType='C',Updated=TO_TIMESTAMP('2017-04-12 19:51:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212986
;

-- Apr 12, 2017 7:51:53 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','AD_Role_ID','NUMERIC(10)',null,'NULL')
;

-- Apr 12, 2017 7:51:53 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT ADRole_PADocumentStatus FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:52:02 PM CEST
UPDATE AD_Column SET FKConstraintName='ADTable_PADocumentStatus', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:52:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213001
;

-- Apr 12, 2017 7:52:02 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','AD_Table_ID','NUMERIC(10)',null,null)
;

-- Apr 12, 2017 7:52:02 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT ADTable_PADocumentStatus FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:52:07 PM CEST
UPDATE AD_Column SET FKConstraintName='ADUser_PADocumentStatus', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:52:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212987
;

-- Apr 12, 2017 7:52:07 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','AD_User_ID','NUMERIC(10)',null,'NULL')
;

-- Apr 12, 2017 7:52:07 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT ADUser_PADocumentStatus FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:52:14 PM CEST
UPDATE AD_Column SET FKConstraintName='ADWindow_PADocumentStatus', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:52:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213003
;

-- Apr 12, 2017 7:52:14 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','AD_Window_ID','NUMERIC(10)',null,'NULL')
;

-- Apr 12, 2017 7:52:14 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT ADWindow_PADocumentStatus FOREIGN KEY (AD_Window_ID) REFERENCES ad_window(ad_window_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:52:21 PM CEST
UPDATE AD_Column SET FKConstraintName='CProject_PADocumentStatus', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:52:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212988
;

-- Apr 12, 2017 7:52:21 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','C_Project_ID','NUMERIC(10)',null,'NULL')
;

-- Apr 12, 2017 7:52:21 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT CProject_PADocumentStatus FOREIGN KEY (C_Project_ID) REFERENCES c_project(c_project_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:52:38 PM CEST
UPDATE AD_Column SET FKConstraintName='NamePrintColor_PADocumentStatu', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:52:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212997
;

-- Apr 12, 2017 7:52:38 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','Name_PrintColor_ID','NUMERIC(10)',null,null)
;

-- Apr 12, 2017 7:52:38 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT NamePrintColor_PADocumentStatu FOREIGN KEY (Name_PrintColor_ID) REFERENCES ad_printcolor(ad_printcolor_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:52:44 PM CEST
UPDATE AD_Column SET FKConstraintName='NamePrintFont_PADocumentStatus', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:52:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212998
;

-- Apr 12, 2017 7:52:44 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','Name_PrintFont_ID','NUMERIC(10)',null,null)
;

-- Apr 12, 2017 7:52:44 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT NamePrintFont_PADocumentStatus FOREIGN KEY (Name_PrintFont_ID) REFERENCES ad_printfont(ad_printfont_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:52:49 PM CEST
UPDATE AD_Column SET FKConstraintName='NumberPrintColor_PADocumentSta', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:52:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212999
;

-- Apr 12, 2017 7:52:49 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','Number_PrintColor_ID','NUMERIC(10)',null,null)
;

-- Apr 12, 2017 7:52:49 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT NumberPrintColor_PADocumentSta FOREIGN KEY (Number_PrintColor_ID) REFERENCES ad_printcolor(ad_printcolor_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:52:53 PM CEST
UPDATE AD_Column SET FKConstraintName='NumberPrintFont_PADocumentStat', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:52:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213000
;

-- Apr 12, 2017 7:52:53 PM CEST
INSERT INTO t_alter_column values('pa_documentstatus','Number_PrintFont_ID','NUMERIC(10)',null,null)
;

-- Apr 12, 2017 7:52:53 PM CEST
ALTER TABLE PA_DocumentStatus ADD CONSTRAINT NumberPrintFont_PADocumentStat FOREIGN KEY (Number_PrintFont_ID) REFERENCES ad_printfont(ad_printfont_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 12, 2017 7:54:34 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200223,'Document Status Translation',200090,20,'Y',200217,0,0,'Y',TO_TIMESTAMP('2017-04-12 19:54:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:54:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N','Y','N','N','N',1,'N','D','N','N','16c4fe42-d942-4297-bb65-2724fd7cb9c2','B')
;

-- Apr 12, 2017 7:57:50 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204417,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200223,213008,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:57:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:57:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','15123f16-e255-4268-80e6-a98d49001584','Y',10,2)
;

-- Apr 12, 2017 7:57:50 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204418,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200223,213012,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:57:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:57:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','48191488-6fd2-43b6-a4f5-f5a71729b547','Y','Y',20,4,2)
;

-- Apr 12, 2017 7:57:51 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204419,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200223,213017,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:57:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:57:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1bf6cf12-c803-48d2-bc90-5daedfa723ca','Y',30,5)
;

-- Apr 12, 2017 7:57:51 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204420,'Column','Column in the table','Link to the database column of the table',200223,213009,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:57:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:57:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d8d17984-1d12-4f59-9b58-e74ea680d608','Y',40,2)
;

-- Apr 12, 2017 7:57:51 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (204421,'PA_DocumentStatus_Trl_UU',200223,213010,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:57:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:57:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ee8f2240-8427-464d-9623-38d25e2ff8d3','N',2)
;

-- Apr 12, 2017 7:57:52 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204422,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200223,213011,'Y',6,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:57:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:57:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','74e8ff6f-7eec-4c20-baa7-7d4ddcd8933c','Y',50,2)
;

-- Apr 12, 2017 7:57:53 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204423,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200223,213016,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:57:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:57:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','18f64c4e-57ac-4e38-967e-08a69b47d924','Y',60,2,2)
;

-- Apr 12, 2017 7:57:53 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204424,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200223,213015,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-12 19:57:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-12 19:57:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c8f4c5bc-2fdc-4117-9693-c96b92b46ab9','Y',70,2,2)
;

-- Apr 12, 2017 7:58:22 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-12 19:58:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204420
;

-- Apr 12, 2017 7:58:22 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-12 19:58:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204422
;

-- Apr 12, 2017 7:58:22 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-12 19:58:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204419
;

-- Apr 12, 2017 7:58:22 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-12 19:58:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204421
;

-- Apr 12, 2017 7:58:57 PM CEST
UPDATE AD_Column SET Name='Document Status', Description=NULL, Help=NULL, ColumnName='PA_DocumentStatus_ID', FieldLength=10, AD_Element_ID=203069, IsUpdateable='N', FKConstraintName=NULL, FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:58:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213009
;

-- Apr 12, 2017 7:58:58 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='PADocumentStatus_PADocumentSta', FKConstraintType='N',Updated=TO_TIMESTAMP('2017-04-12 19:58:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213009
;

-- Apr 12, 2017 8:00:17 PM CEST
UPDATE AD_Field SET Name='Document Status', Description=NULL, Help=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-12 20:00:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204420
;

-- Apr 12, 2017 8:14:49 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201041,'f3338dcb-c411-4f07-934e-9a0b01172a73',TO_TIMESTAMP('2017-04-12 20:14:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','pa_documentstatus_trl_pkey',TO_TIMESTAMP('2017-04-12 20:14:49','YYYY-MM-DD HH24:MI:SS'),100,200217,'Y','Y','N','N','Y')
;

-- Apr 12, 2017 8:15:16 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201276,'571005cd-0f89-45ce-9b87-f91d005b099e',TO_TIMESTAMP('2017-04-12 20:15:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-04-12 20:15:16','YYYY-MM-DD HH24:MI:SS'),100,213009,201041,10)
;

-- Apr 12, 2017 8:15:25 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201277,'53eee079-7aca-45a6-badb-8bcf5ea1c4f7',TO_TIMESTAMP('2017-04-12 20:15:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2017-04-12 20:15:25','YYYY-MM-DD HH24:MI:SS'),100,213011,201041,20)
;

-- Apr 12, 2017 8:15:30 PM CEST
ALTER TABLE PA_DocumentStatus_Trl ADD CONSTRAINT pa_documentstatus_trl_pkey PRIMARY KEY (PA_DocumentStatus_ID,AD_Language)
;

-- Apr 12, 2017 9:05:00 PM CEST
UPDATE AD_Tab SET IsTranslationTab='N',Updated=TO_TIMESTAMP('2017-04-12 21:05:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200223
;

SELECT register_migration_script('201704112221_IDEMPIERE-3338.sql') FROM dual
;
