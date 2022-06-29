-- IDEMPIERE-5302
SELECT register_migration_script('202205251513_IDEMPIERE-5302.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

INSERT INTO ad_element(ad_element_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, columnname, entitytype, name, printname, description, help, po_name, po_printname, po_description, po_help, ad_element_uu, placeholder) VALUES (203568, 0, 0, 'Y', TO_TIMESTAMP('2022-04-06 12:43:12','YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2022-04-06 12:45:43','YYYY-MM-DD HH24:MI:SS'), 100, 'IsShowInDrillOptions', 'D', 'Show In Drill Options', 'Show In Drill Options', 'This parameter enables the table is displayed in Report Viewer Drill options list', NULL, NULL, NULL, NULL, NULL, '42e1bc41-4d1b-491b-b1a3-6a63fc8a76c2', NULL);

INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214721,0,'Show In Drill Options','This parameter enables the table is displayed in Report Viewer Drill options list',NULL,100,'IsShowInDrillOptions',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-04-06 12:52:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 13:23:14','YYYY-MM-DD HH24:MI:SS'),100,203568,'Y','N','D','N','N','N','Y','9e728d8a-e625-480c-b609-c25bac5266f3','Y',0,'N','N','N','N');

-- Apr 6, 2022, 1:21:07 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206920,'Show In Drill Options','This parameter enables the table is displayed in Report Viewer Drill options list',100,214721,'Y',1,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 13:21:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 13:21:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dc30834f-3921-4800-989b-d96e11cf1cc4','Y',200,2,2)
;

-- Apr 6, 2022, 1:21:30 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-06 13:21:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206920
;

ALTER TABLE AD_Table ADD COLUMN IsShowInDrillOptions character(1) DEFAULT 'N';

-- Apr 6, 2022, 1:23:14 PM CEST
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_TIMESTAMP('2022-04-06 13:23:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214721
;

-- Apr 6, 2022, 1:23:20 PM CEST
ALTER TABLE AD_Table MODIFY IsShowInDrillOptions CHAR(1) DEFAULT 'Y'
;

-- Apr 6, 2022, 2:46:56 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200335,'Drill Rule','AD_Process_DrillRule',0,'4',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:46:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:46:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','83361033-2aa3-41d6-9de5-1ce897245dde','N','N','N','N','Y')
;

-- Apr 6, 2022, 2:46:56 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Process_DrillRule',1000000,'N','N','Table AD_Process_DrillRule','Y','Y',0,0,TO_TIMESTAMP('2022-04-06 14:46:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:46:56','YYYY-MM-DD HH24:MI:SS'),100,200404,'Y',1000000,1,200000,'ca0fd3a7-124d-48f9-b00a-e554f0e79fe4')
;

-- Apr 6, 2022, 2:47:08 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203569,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:08','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_DrillRule_ID','Drill Rule','Drill Rule','D','0c9e8965-941a-46f7-be4e-5794df9dfc9d')
;

-- Apr 6, 2022, 2:47:08 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214722,0.0,'Drill Rule',200335,'AD_Process_DrillRule_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:08','YYYY-MM-DD HH24:MI:SS'),100,203569,'N','N','D','N','afd2c9af-9c8d-4fb9-b4ea-88626a1ef43d','N')
;

-- Apr 6, 2022, 2:47:08 PM CEST
CREATE TABLE AD_Process_DrillRule (ad_process_drillrule_id numeric(10,0) NOT NULL) TABLESPACE pg_default
;

-- Apr 6, 2022, 2:47:08 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214723,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200335,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:08','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','dcbbbea4-8ccd-4c07-8964-0d8d9f6b10f1','N','D')
;

-- Apr 6, 2022, 2:47:09 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN ad_client_id numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:47:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214724,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200335,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:08','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','a0b49fe9-f6ce-4ea6-b317-ae979c02d027','N','D')
;

-- Apr 6, 2022, 2:47:09 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN ad_org_id numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:47:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214725,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200335,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:09','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','feaf7550-5361-45f1-9986-2deb5187727e','N')
;

-- Apr 6, 2022, 2:47:09 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN isactive character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::bpchar
;

-- Apr 6, 2022, 2:47:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214726,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200335,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:09','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','d3772d17-fb70-4cbc-af0c-cc2a54b7813f','N')
;

-- Apr 6, 2022, 2:47:09 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN created timestamp without time zone NOT NULL DEFAULT now()
;

-- Apr 6, 2022, 2:47:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214727,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200335,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:09','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','c629839b-dc5a-4238-9087-b9500fa241de','N','D')
;

-- Apr 6, 2022, 2:47:10 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN createdby numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:47:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214728,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200335,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:10','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','0a2b4e06-7142-455a-ac49-7637be07716b','N')
;

-- Apr 6, 2022, 2:47:10 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN updated timestamp without time zone NOT NULL DEFAULT now()
;

-- Apr 6, 2022, 2:47:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214729,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200335,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:10','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','82ea3b7f-7165-4d7b-98b7-35a20c1bd315','N','D')
;

-- Apr 6, 2022, 2:47:10 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN updatedby numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:47:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214730,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200335,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:10','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','3a29e5d3-8271-4a43-b5c2-19547c78f295',10,'N')
;

-- Apr 6, 2022, 2:47:10 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN name character varying(60) COLLATE pg_catalog."default" NOT NULL
;

-- Apr 6, 2022, 2:47:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214731,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200335,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:10','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','907cdb65-3239-4d65-bcc4-fbefb10ea218',20,'N')
;

-- Apr 6, 2022, 2:47:11 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN description character varying(255) COLLATE pg_catalog."default"
;

-- Apr 6, 2022, 2:47:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214732,0.0,'Show Help',200335,'ShowHelp','Y',1,'N','N','N','N','N','N',17,50007,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:11','YYYY-MM-DD HH24:MI:SS'),100,50038,'Y','N','D','N','74c04cf6-c00f-495a-80f1-66dc036be9e4','N')
;

-- Apr 6, 2022, 2:47:11 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN showhelp character(1) COLLATE pg_catalog."default" DEFAULT 'Y'::bpchar
;

-- Apr 6, 2022, 2:47:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214733,0.0,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200335,'AD_Process_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:11','YYYY-MM-DD HH24:MI:SS'),100,117,'Y','N','D','N','c7b4d348-fca5-4442-9575-c0046d000a89','N','N')
;

-- Apr 6, 2022, 2:47:11 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN ad_process_id numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:47:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214734,0.0,'Table','Database Table information','The Database Table provides the information of the table definition',200335,'AD_Table_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:11','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','ac425e9f-2a69-45f1-aa44-cd82ea080ea2','N','N')
;

-- Apr 6, 2022, 2:47:12 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN ad_table_id numeric(10,0) DEFAULT NULL::numeric
;

-- Apr 6, 2022, 2:47:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214735,0.0,'Report View','View used to generate this report','The Report View indicates the view used to generate this report.',200335,'AD_ReportView_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:12','YYYY-MM-DD HH24:MI:SS'),100,1252,'N','N','D','N','67f6721b-a7b9-4c0e-b704-0a82534ec640','N')
;

-- Apr 6, 2022, 2:47:12 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN ad_reportview_id numeric(10,0) DEFAULT NULL::numeric
;

-- Apr 6, 2022, 2:47:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214736,0.0,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200335,'AD_PrintFormat_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:12','YYYY-MM-DD HH24:MI:SS'),100,1790,'Y','N','D','N','bf68bfcd-02cd-4507-a6f5-46ac33bbe525','N','N')
;

-- Apr 6, 2022, 2:47:12 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN ad_printformat_id numeric(10,0) DEFAULT NULL::numeric
;

-- Apr 6, 2022, 4:01:24 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214752,0.0,'System Element','System Element enables the central maintenance of column description and help.','The System Element allows for the central maintenance of help, descriptions and terminology for a database column.',200335,'AD_Element_ID',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-04-06 16:01:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 16:01:24','YYYY-MM-DD HH24:MI:SS'),100,106,'Y','N','D','N','6647624f-44a9-4143-b453-b15a689d76fb','N','N')
;

-- Apr 6, 2022, 2:47:13 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN ad_element_id numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:47:13 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203570,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:12','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_DrillRule_UU','AD_Process_DrillRule_UU','AD_Process_DrillRule_UU','D','deb41a28-7518-4e08-93d4-f574052eca6c')
;

-- Apr 6, 2022, 2:47:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214738,0.0,'AD_Process_DrillRule_UU',200335,'AD_Process_DrillRule_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:47:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:47:12','YYYY-MM-DD HH24:MI:SS'),100,203570,'N','N','D','N','cd5833a4-a634-49af-a711-3f207a5223f5','N')
;

-- Apr 6, 2022, 2:47:13 PM CEST
ALTER TABLE AD_Process_DrillRule ADD COLUMN ad_process_drillrule_uu character varying(36) COLLATE pg_catalog."default" DEFAULT NULL::character varying
;

-- Apr 6, 2022, 2:49:42 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT ad_process_drillrule_pkey PRIMARY KEY (ad_process_drillrule_id)
;

-- Apr 6, 2022, 2:49:42 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT adprintformat_addrillrule FOREIGN KEY (ad_printformat_id) REFERENCES adempiere.ad_printformat (ad_printformat_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
;

-- Apr 6, 2022, 2:49:42 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT adprocess_addrillrule FOREIGN KEY (ad_process_id) REFERENCES adempiere.ad_process (ad_process_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Apr 6, 2022, 2:49:42 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT adtable_addrillrule FOREIGN KEY (ad_table_id) REFERENCES adempiere.ad_table (ad_table_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED
;

-- Apr 6, 2022, 2:49:42 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT celement_addrillrule FOREIGN KEY (ad_element_id) REFERENCES adempiere.ad_element (ad_element_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Apr 6, 2022, 2:49:42 PM CEST
ALTER TABLE IF EXISTS adempiere.ad_process_drillrule OWNER to adempiere
;

-- Apr 6, 2022, 2:49:42 PM CEST
CREATE UNIQUE INDEX IF NOT EXISTS ad_process_drillrule_uu_idx ON adempiere.ad_process_drillrule USING btree (ad_process_drillrule_uu COLLATE pg_catalog."default" ASC NULLS LAST) TABLESPACE pg_default
;

-- Apr 6, 2022, 2:49:42 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200336,'Drill Rule Parameter','AD_Process_DrillRule_Para',0,'4',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','1c5204bd-d8e8-4cc6-ab2d-e11735e1ff3c','N','N','N','N','Y')
;

-- Apr 6, 2022, 2:49:43 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Process_DrillRule_Para',1000000,'N','N','Table AD_Process_DrillRule_Para','Y','Y',0,0,TO_TIMESTAMP('2022-04-06 14:49:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:42','YYYY-MM-DD HH24:MI:SS'),100,200405,'Y',1000000,1,200000,'fc2f35bc-3607-4568-836d-776dcef87571')
;

-- Apr 6, 2022, 2:49:54 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214739,0.0,'Drill Rule',200336,'AD_Process_DrillRule_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:53','YYYY-MM-DD HH24:MI:SS'),100,203569,'N','N','D','N','cc9d25da-cd10-4a46-b598-49bfa88a5fef','N','N')
;

-- Apr 6, 2022, 2:47:08 PM CEST
CREATE TABLE AD_Process_DrillRule_Para (ad_process_drillrule_id numeric(10,0) NOT NULL) TABLESPACE pg_default
;

-- Apr 6, 2022, 4:23:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214753,0.0,'Process Parameter',200336,'AD_Process_Para_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 16:23:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 16:23:01','YYYY-MM-DD HH24:MI:SS'),100,118,'N','N','D','N','baeb0d20-439e-46aa-b4e7-0eb81a391b63','N')
;

-- Apr 6, 2022, 2:49:55 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN ad_process_para_id numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:49:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214741,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200336,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:54','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','1a2c8dc6-66f5-438c-89bf-df56e12e708e','N','D')
;

-- Apr 6, 2022, 2:49:55 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN ad_client_id numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:49:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214742,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200336,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:55','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','4c8313ac-11d5-4fab-aba2-1ca5ecb34155','N','D')
;

-- Apr 6, 2022, 2:49:55 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN ad_org_id numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:49:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214743,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200336,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:55','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','dfcfb4b4-38f9-4b8e-8c5c-811c1bdcd58d','N')
;

-- Apr 6, 2022, 2:49:55 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN isactive character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::bpchar
;

-- Apr 6, 2022, 2:49:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214744,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200336,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:55','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','30b678ab-40aa-468e-9a2d-9108d38bdcc1','N')
;

-- Apr 6, 2022, 2:49:55 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN created timestamp without time zone NOT NULL DEFAULT now()
;

-- Apr 6, 2022, 2:49:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214745,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200336,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:55','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','c5875da8-08c5-4d3d-a99b-b80459d286dc','N','D')
;

-- Apr 6, 2022, 2:49:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN createdby numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:49:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214746,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200336,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:56','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','418403df-269d-4cd1-9aca-2d335a230ccb','N')
;

-- Apr 6, 2022, 2:49:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN updated timestamp without time zone NOT NULL DEFAULT now()
;

-- Apr 6, 2022, 2:49:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214747,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200336,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:56','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','f3f1a606-2119-4671-8c13-d96a12441570','N','D')
;

-- Apr 6, 2022, 2:49:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN updatedby numeric(10,0) NOT NULL
;

-- Apr 6, 2022, 2:49:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214748,0.0,'Default Parameter','Default value of the parameter','The default value can be a variable like @#Date@ ',200336,'ParameterDefault',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:56','YYYY-MM-DD HH24:MI:SS'),100,2419,'Y','N','D','N','c37de7ce-4091-4f0d-b38e-d23770c5db4d','N')
;

-- Apr 6, 2022, 2:49:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN parameterdefault character varying(255) COLLATE pg_catalog."default"
;

-- Apr 6, 2022, 2:49:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214749,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200336,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:57','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','7503a18e-7cde-422f-a911-f06143d187c4',10,'N')
;

-- Apr 6, 2022, 2:49:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN description character varying(255) COLLATE pg_catalog."default"
;

-- Apr 6, 2022, 2:49:57 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203572,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:57','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_DrillRule_Para_UU','AD_Process_DrillRule_Para_UU','AD_Process_DrillRule_Para_UU','D','7db65d50-a7f5-4c47-b7a2-365568ae7551')
;

-- Apr 6, 2022, 2:49:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214750,0.0,'AD_Process_DrillRule_Para_UU',200336,'AD_Process_DrillRule_Para_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:57','YYYY-MM-DD HH24:MI:SS'),100,203572,'N','N','D','N','ac660503-7779-406e-81d1-5d1bab1241f9','N')
;

-- Apr 6, 2022, 2:49:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN ad_process_drillrule_para_uu character varying(36) COLLATE pg_catalog."default" DEFAULT NULL::character varying
;

-- Apr 6, 2022, 2:49:58 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214751,0.0,'Default To Parameter','Default value of the to parameter','The default value can be a variable like @#Date@ ',200336,'ParameterToDefault',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:49:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:49:57','YYYY-MM-DD HH24:MI:SS'),100,202621,'Y','N','D','N','82c6f4d8-e611-4b13-944f-2bf5f42bd768','N','N')
;

-- Apr 6, 2022, 2:49:58 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD COLUMN parametertodefault character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying
;

-- Apr 6, 2022, 2:49:58 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD CONSTRAINT ad_process_drillrule_para_pkey PRIMARY KEY (ad_process_drillrule_id, ad_process_para_id)
;

-- Apr 6, 2022, 2:49:58 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD CONSTRAINT adprocess_addrillrulepara FOREIGN KEY (ad_process_drillrule_id) REFERENCES adempiere.ad_process_drillrule (ad_process_drillrule_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Apr 6, 2022, 2:49:58 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD CONSTRAINT adprocesspara_adschedulerpara FOREIGN KEY (ad_process_para_id) REFERENCES adempiere.ad_process_para (ad_process_para_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Apr 6, 2022, 2:49:59 PM CEST
ALTER TABLE IF EXISTS adempiere.ad_process_drillrule_para OWNER to adempiere
;

-- Apr 6, 2022, 2:49:59 PM CEST
CREATE UNIQUE INDEX IF NOT EXISTS ad_process_drillrule_para_uu_idx ON adempiere.ad_process_drillrule_para USING btree (ad_process_drillrule_para_uu COLLATE pg_catalog."default" ASC NULLS LAST) TABLESPACE pg_default
;

-- Apr 6, 2022, 2:51:06 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200123,'Drill Rule',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:51:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:51:06','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','91407fde-0a29-41fd-b44c-aff7070f94ec')
;

-- Apr 6, 2022, 2:55:04 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200308,'Drill Rule',200123,10,'Y',200335,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','1c99e0b5-4718-463a-a0e7-bf8432d1b70e','B','N','Y',0)
;

-- Apr 6, 2022, 2:55:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206921,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200308,214723,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5dcf564e-4dfd-4861-94e0-96e072e9c4a9','N',2)
;

-- Apr 6, 2022, 2:55:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206922,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200308,214724,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','860d79ca-5019-4b3f-87f5-411f7715fdc2','Y','N',4,2)
;

-- Apr 6, 2022, 2:55:26 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206923,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200308,214730,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1c1f603b-1d53-4ed4-8b33-0e2c8e285538','Y',10,5)
;

-- Apr 6, 2022, 2:55:26 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206924,'Description','Optional short description of the record','A description is limited to 255 characters.',200308,214731,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','84693c4f-75a8-4df8-882b-73f357961ae2','Y',20,5)
;

-- Apr 6, 2022, 2:55:26 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206925,'Drill Rule',200308,214722,'N',10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6487a092-0a7c-4d9c-9cc7-f6bea064af07','N',2)
;

-- Apr 6, 2022, 2:55:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206926,'Show Help',200308,214732,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e391bd8f-d510-4974-86d3-cb28df01455c','Y',30,2)
;

-- Apr 6, 2022, 2:55:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206927,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200308,214733,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7c6ecc52-f2b7-42cc-a78e-80ca01928c01','Y',40,2)
;

-- Apr 6, 2022, 2:55:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206928,'Table','Database Table information','The Database Table provides the information of the table definition',200308,214734,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f351d63e-611f-4a5b-80ed-7e78e73a00cd','Y',50,2)
;

-- Apr 6, 2022, 2:55:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206929,'Report View','View used to generate this report','The Report View indicates the view used to generate this report.',200308,214735,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','117f2b2c-1719-4ff3-b7c5-c8da0b9f2cd0','Y',60,2)
;

-- Apr 6, 2022, 2:55:28 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206930,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200308,214736,'Y',10,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','84e95705-785f-44b4-b966-48d10fb766a6','Y',70,2)
;

-- Apr 6, 2022, 2:55:28 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206932,'AD_Process_DrillRule_UU',200308,214738,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7dcb0cd5-450c-4642-b213-2a0cf2dc2ddb','N',2)
;

-- Apr 6, 2022, 2:55:29 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206933,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200308,214725,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:55:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:55:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','221d1536-dd3e-4279-afb9-b2592ab008f3','Y',90,2,2)
;

-- Apr 6, 2022, 2:56:56 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200309,'Drill Rule Parameter',200123,20,'Y',200336,0,0,'Y',TO_TIMESTAMP('2022-04-06 14:56:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:56:56','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',214739,'N','N',0,'N','D','Y','N','cf646be0-5bd7-4d8e-9ede-185fec8f6b64','B','N','Y',0)
;

-- Apr 6, 2022, 2:57:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206934,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200309,214741,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:57:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:57:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a31d9d5-18f9-4901-827e-368ec8d94ee4','N',2)
;

-- Apr 6, 2022, 2:57:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206935,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200309,214742,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:57:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:57:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19e03e36-0698-4ec2-bcf1-2a477e02c028','Y','N',4,2)
;

-- Apr 6, 2022, 2:57:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206936,'Description','Optional short description of the record','A description is limited to 255 characters.',200309,214749,'Y',255,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:57:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:57:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5328039c-28f7-41ec-8753-9bd40fef703b','Y',10,5)
;

-- Apr 6, 2022, 2:57:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206937,'Drill Rule',200309,214739,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:57:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:57:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c375dd96-6b77-4d57-8bd4-3783ad332aa3','Y',20,2)
;

-- Apr 6, 2022, 2:57:07 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206939,'Default Parameter','Default value of the parameter','The default value can be a variable like @#Date@ ',200309,214748,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:57:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:57:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cec431e5-61c2-46d3-b3d6-266b0c10c57b','Y',30,5)
;

-- Apr 6, 2022, 2:57:07 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206940,'AD_Process_DrillRule_Para_UU',200309,214750,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:57:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:57:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','56105b60-807f-4790-bddb-4d44f1a45706','N',2)
;

-- Apr 6, 2022, 2:57:07 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206941,'Default To Parameter','Default value of the to parameter','The default value can be a variable like @#Date@ ',200309,214751,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:57:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:57:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','86b3b8c8-7d82-4ef4-864d-c6cb69b1570f','Y',40,5)
;

-- Apr 6, 2022, 2:57:08 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206942,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200309,214743,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 14:57:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 14:57:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b4bb1db1-e2da-41e2-a573-cb3c1bb4f0a7','Y',50,2,2)
;

-- Apr 6, 2022, 3:02:36 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200201,'Drill Rule','W',200123,0,0,'Y',TO_TIMESTAMP('2022-04-06 15:02:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 15:02:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','732c12fb-276b-445d-a3ba-e984dfb22cbf')
;

-- Apr 6, 2022, 3:02:36 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200201, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200201)
;

-- Apr 6, 2022, 3:15:18 PM CEST
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2022-04-06 15:15:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200336
;

-- Apr 6, 2022, 3:16:16 PM CEST
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2022-04-06 15:16:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200335
;

-- Apr 6, 2022, 3:18:32 PM CEST
UPDATE AD_Table SET AD_Window_ID=200123,Updated=TO_TIMESTAMP('2022-04-06 15:18:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200335
;

-- Apr 6, 2022, 3:20:07 PM CEST
UPDATE AD_Table SET AD_Window_ID=200123,Updated=TO_TIMESTAMP('2022-04-06 15:20:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200336
;

-- Apr 6, 2022, 3:22:03 PM CEST
UPDATE AD_Window SET WinWidth=NULL,Updated=TO_TIMESTAMP('2022-04-06 15:22:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200123
;

-- Apr 6, 2022, 3:55:00 PM CEST
UPDATE AD_Tab SET TabLevel=1,Updated=TO_TIMESTAMP('2022-04-06 15:55:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200309
;

-- Apr 6, 2022, 4:03:52 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206943,'System Element','System Element enables the central maintenance of column description and help.','The System Element allows for the central maintenance of help, descriptions and terminology for a database column.',200308,214752,'Y',10,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 16:03:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 16:03:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a7e4e6f0-34b4-41f4-a92b-5928d30b4f10','Y',100,2)
;

-- Apr 6, 2022, 4:23:18 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206944,'Process Parameter',200309,214753,'Y',10,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-06 16:23:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-06 16:23:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3aaa0900-2afb-4fb9-bda7-0e5310e8013e','Y',60,2)
;

-- Apr 7, 2022, 2:24:36 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=186,Updated=TO_TIMESTAMP('2022-04-07 14:24:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214753
;

-- Apr 7, 2022, 2:27:03 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:27:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206944
;

-- Apr 7, 2022, 2:27:03 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:27:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206942
;

-- Apr 7, 2022, 2:27:03 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:27:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206936
;

-- Apr 7, 2022, 2:27:03 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:27:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206940
;

-- Apr 7, 2022, 2:27:03 PM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:27:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206937
;

-- Apr 7, 2022, 2:28:07 PM CEST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2022-04-07 14:28:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214735
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_FieldGroup_ID=113, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206928
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206933
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206929
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206930
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206943
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_FieldGroup_ID=114, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206927
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206926
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206932
;

-- Apr 7, 2022, 2:30:26 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:30:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206925
;

-- Apr 7, 2022, 2:33:23 PM CEST
UPDATE AD_Field SET SeqNo=10, IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:33:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206934
;

-- Apr 7, 2022, 2:33:35 PM CEST
UPDATE AD_Field SET SeqNo=10, IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:33:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206921
;

-- Apr 11, 2022, 8:58:19 AM CEST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2022-04-11 08:58:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214753
;

-- Apr 11, 2022, 8:58:27 AM CEST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2022-04-11 08:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214739
;

-- Apr 22, 2022, 4:22:51 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2022-04-22 16:22:50','YYYY-MM-DD HH24:MI:SS'),100,'Captured Process Parameter','Y',200119,'Captured Process Parameter',TO_TIMESTAMP('2022-04-22 16:22:50','YYYY-MM-DD HH24:MI:SS'),100,'N','588e50d2-2ee5-4007-8fa1-7f60ac1767f1','W',200308,200064,10,'D')
;

-- Apr 22, 2022, 4:38:34 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Drill Assistant',0,0,'Y',TO_TIMESTAMP('2022-04-22 16:38:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-22 16:38:34','YYYY-MM-DD HH24:MI:SS'),100,200744,'DrillAssistant','D','9834ddc4-e261-4a92-84f5-da6ebca72822')
;

-- Apr 22, 2022, 4:38:51 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Drill Column',0,0,'Y',TO_TIMESTAMP('2022-04-22 16:38:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-22 16:38:51','YYYY-MM-DD HH24:MI:SS'),100,200745,'DrillColumn','D','b36997cf-a012-4e9f-9711-b051b44d05cc')
;

-- Apr 25, 2022, 10:40:00 AM CEST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2022-04-25 10:40:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200335
;

-- Apr 25, 2022, 10:40:07 AM CEST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2022-04-25 10:40:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200336
;

-- Apr 25, 2022, 11:21:19 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200158,'AD_ReportView of AD_Table','S','AD_ReportView.AD_Table_ID = @AD_Table_ID@',0,0,'Y',TO_TIMESTAMP('2022-04-25 11:21:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-25 11:21:19','YYYY-MM-DD HH24:MI:SS'),100,'D','cd974660-b27f-499c-a6e9-e9f959510395')
;

-- Apr 25, 2022, 11:22:01 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200159,'AD_PrintFormat of AD_ReportView','S','AD_PrintFormat.AD_ReportView_ID = @AD_ReportView_ID@',0,0,'Y',TO_TIMESTAMP('2022-04-25 11:22:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-25 11:22:01','YYYY-MM-DD HH24:MI:SS'),100,'D','83bb8e51-dc05-47b8-b3e0-f0d54d410e63')
;

-- Apr 25, 2022, 11:22:28 AM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200158,Updated=TO_TIMESTAMP('2022-04-25 11:22:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214735
;

-- Apr 25, 2022, 11:22:48 AM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200159,Updated=TO_TIMESTAMP('2022-04-25 11:22:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214736
;

-- May 25, 2022, 3:13:27 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200349,'Drill Rule Trl',200123,'AD_Process_DrillRule_Trl',0,'3',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:13:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:13:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','238cf5eb-d915-48d0-a1e6-df5cb52415e7','N','N','N','N')
;

-- May 25, 2022, 3:13:27 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Process_DrillRule_Trl',1000000,'N','N','Table AD_Process_DrillRule_Trl','Y','Y',0,0,TO_TIMESTAMP('2022-05-25 15:13:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:13:27','YYYY-MM-DD HH24:MI:SS'),100,200417,'Y',1000000,1,200000,'47e13bfc-592c-451a-9de8-0116ebd61a14')
;

-- May 25, 2022, 3:14:52 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214917,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200349,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:14:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:14:52','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','0aa5cf91-1216-472a-8cc4-cbdea568233e','N',0,'N','N','D','N')
;

-- May 25, 2022, 3:14:56 PM CEST
CREATE TABLE AD_Process_DrillRule_Trl (AD_Client_ID NUMBER(10) NOT NULL)
;

-- May 25, 2022, 3:16:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214918,0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200349,'AD_Language',6,'N','N','Y','N','N',0,'N',18,106,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:16:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:16:32','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','N','N','Y','623d0880-7b03-4357-96cf-4102d2c1d037','Y',0,'N','N','N','N')
;

-- May 25, 2022, 3:16:46 PM CEST
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADProcessDrillRuleT', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-05-25 15:16:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214918
;

-- May 25, 2022, 3:16:46 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD AD_Language VARCHAR2(6 CHAR) NOT NULL
;

-- May 25, 2022, 3:16:46 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CONSTRAINT ADLanguage_ADProcessDrillRuleT FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- May 25, 2022, 3:17:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214919,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200349,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:17:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:17:14','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','bd5074ec-a162-4337-854f-b3ab811f4b54','N',0,'N','N','D','N')
;

-- May 25, 2022, 3:17:18 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- May 25, 2022, 3:17:51 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214920,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200349,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:17:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:17:50','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','76b1ed53-f6d3-4554-9922-412c14df029e','N',0,'N','N','N')
;

-- May 25, 2022, 3:18:10 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- May 25, 2022, 3:19:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214921,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200349,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:19:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:19:09','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','80299531-63d4-4d73-a474-d66207e25a70','N',0,'N','N','D','N')
;

-- May 25, 2022, 3:19:12 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CreatedBy NUMBER(10) NOT NULL
;

-- May 25, 2022, 3:20:07 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214922,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200349,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:20:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:20:07','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','N','N','Y','1daf3f54-2df8-48bf-a87e-892cb8f4df02','Y',10,'N','N','N')
;

-- May 25, 2022, 3:20:20 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- May 25, 2022, 3:21:26 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214923,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200349,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:21:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:21:26','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','a7ec7506-a7ba-42ae-b1dc-bec723ce7e3b','N',0,'N','N','N')
;

-- May 25, 2022, 3:21:31 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- May 25, 2022, 3:22:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214924,0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200349,'IsTranslated',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:22:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:22:13','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','N','N','Y','27f2296d-a28a-4849-b879-ec434e650c34','Y',0,'N','N','N')
;

-- May 25, 2022, 3:24:38 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203600,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:24:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:24:37','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_DrillRule_Trl_UU','AD_Process_DrillRule_Trl_UU','AD_Process_DrillRule_Trl_UU','D','4af8145b-0ba4-499f-b4af-222bc88e2891')
;

-- May 25, 2022, 3:25:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214925,0,'AD_Process_DrillRule_Trl_UU',200349,'AD_Process_DrillRule_Trl_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:25:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:25:13','YYYY-MM-DD HH24:MI:SS'),100,203600,'Y','N','D','N','N','N','Y','f1a207cd-ca7e-41c9-ae44-97c928127861','N',0,'N','N','N','N')
;

-- May 25, 2022, 3:25:38 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL
;

-- May 25, 2022, 3:25:38 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD AD_Process_DrillRule_Trl_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 25, 2022, 3:25:38 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CONSTRAINT AD_Process_DrillRule_Trl_uuidx UNIQUE (AD_Process_DrillRule_Trl_UU)
;

-- May 25, 2022, 3:25:47 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl MODIFY AD_Process_DrillRule_Trl_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- May 25, 2022, 3:27:51 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214926,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200349,'Name',255,'N','N','Y','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:27:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:27:51','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','3e17c966-5575-47bc-8b4a-fa6ea20e47fb','Y',20,'N','N','N')
;

-- May 25, 2022, 3:27:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD Name VARCHAR2(255 CHAR) NOT NULL
;

-- May 25, 2022, 3:29:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214927,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200349,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:29:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:29:20','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','65b7c93a-997a-42a4-818a-5c5a1825e012','N',0,'N','N','N')
;

-- May 25, 2022, 3:29:27 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- May 25, 2022, 3:29:50 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214928,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200349,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:29:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:29:50','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','56503a67-4f6d-4086-83e2-daef40e53de1','N',0,'N','N','D','N')
;

-- May 25, 2022, 3:29:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD UpdatedBy NUMBER(10) NOT NULL
;

-- May 25, 2022, 3:39:21 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214929,0,'Drill Rule',200349,'AD_Process_DrillRule_ID',22,'N','Y','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:39:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:39:20','YYYY-MM-DD HH24:MI:SS'),100,203569,'N','N','D','N','N','N','Y','6cba0265-b5f8-4134-850d-d6aa6b042a67','Y',0,'N','N','adprocessdrillrule_trl','C','N')
;

-- May 25, 2022, 3:39:24 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD AD_Process_DrillRule_ID NUMBER(10) NOT NULL
;

-- May 25, 2022, 3:39:24 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CONSTRAINT adprocessdrillrule_trl FOREIGN KEY (AD_Process_DrillRule_ID) REFERENCES ad_process_drillrule(ad_process_drillrule_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- May 25, 2022, 3:47:28 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200322,'Drill Rule Translation',200123,30,'Y',200349,0,0,'Y',TO_TIMESTAMP('2022-05-25 15:47:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:47:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N','Y','N',214929,'N','N',1,'N','D','Y','N','08a5d1fc-e264-48c6-84d3-dad1cbac8811','B','N','Y',0)
;

-- May 25, 2022, 3:48:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207063,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200322,214917,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','415b39ab-f8a0-4ebd-9205-ff17e323ea62','N',2)
;

-- May 25, 2022, 3:48:46 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207064,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200322,214919,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ebcd812e-7741-448a-a812-035785229365','Y','Y',10,4,2)
;

-- May 25, 2022, 3:48:46 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207065,'Drill Rule',200322,214929,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fbcbc793-12a4-40ea-b738-e0dee2869129','Y',20,2)
;

-- May 25, 2022, 3:48:46 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207066,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200322,214926,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','79a96976-9ed0-4691-b213-29a827aab39e','Y',30,5)
;

-- May 25, 2022, 3:48:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207067,'Description','Optional short description of the record','A description is limited to 255 characters.',200322,214922,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ce2cff54-a5c8-4d8c-98f6-1e9de59f3210','Y',40,5)
;

-- May 25, 2022, 3:48:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207068,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200322,214918,'Y',6,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','83c4f092-7083-436b-8858-3d08663b6efa','Y',50,2)
;

-- May 25, 2022, 3:48:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207069,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200322,214924,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ee3b1016-b121-4f42-a490-9723ec99b431','Y',60,2,2)
;

-- May 25, 2022, 3:48:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207070,'AD_Process_DrillRule_Trl_UU',200322,214925,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cd371b09-815e-4df7-bda1-cc5b35867ab9','N',2)
;

-- May 25, 2022, 3:48:48 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207071,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200322,214923,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-05-25 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-25 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f63a8890-9ddb-440b-988e-069a95d8a541','Y',70,2,2)
;

-- May 25, 2022, 3:50:39 PM CEST
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-05-25 15:50:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214730
;

-- May 25, 2022, 3:50:47 PM CEST
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-05-25 15:50:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214731
;

-- May 26, 2022, 12:13:49 PM CEST
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2022-05-26 12:13:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200322
;

-- Jun 3, 2022, 4:13:05 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214930,0,'Column','Column in the table','Link to the database column of the table',200335,'AD_Column_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-06-03 16:13:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-03 16:13:05','YYYY-MM-DD HH24:MI:SS'),100,104,'Y','N','D','N','N','N','Y','73a5f907-95a5-4043-a35a-898dfd6089af','Y',0,'N','N','N','N')
;

-- Jun 3, 2022, 4:13:10 PM CEST
UPDATE AD_Column SET FKConstraintName='ADColumn_ADProcessDrillRule', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-06-03 16:13:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214930
;

-- Jun 3, 2022, 4:13:10 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_Column_ID NUMBER(10) NOT NULL
;

-- Jun 3, 2022, 4:20:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207072,'Column','Column in the table','Link to the database column of the table',200308,214930,'Y',0,120,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-03 16:20:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-03 16:20:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','796de252-df4b-46f5-839d-e905b909f3aa','Y',110,1,1,1,'N','N','N','N')
;

-- Jun 3, 2022, 4:31:34 PM CEST
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=206943
;

-- Jun 3, 2022, 4:31:35 PM CEST
DELETE FROM AD_Field WHERE AD_Field_ID=206943
;

-- Jun 3, 2022, 4:32:29 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-03 16:32:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207072
;

-- Jun 3, 2022, 4:32:29 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-03 16:32:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206926
;

-- Jun 3, 2022, 4:32:53 PM CEST
ALTER TABLE AD_Process_DrillRule DROP COLUMN AD_Element_ID
;

-- Jun 3, 2022, 4:32:56 PM CEST
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=214752
;

-- Jun 3, 2022, 4:32:56 PM CEST
DELETE FROM AD_Column WHERE AD_Column_ID=214752
;

-- Jun 3, 2022, 4:56:13 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=100,Updated=TO_TIMESTAMP('2022-06-03 16:56:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214930
;

-- Jun 13, 2022, 3:56:41 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_FieldGroup_ID=114, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-13 15:56:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206926
;

-- Jun 13, 2022, 4:12:27 PM CEST
UPDATE AD_Column SET DefaultValue='S',Updated=TO_TIMESTAMP('2022-06-13 16:12:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214732
;

-- Jun 16, 2022, 10:00:03 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Cannot find Drill Across for Column in Tables.','You can enable Drill Across in Application Dictionary as System User in the Table window.',0,0,'Y',TO_TIMESTAMP('2022-06-16 10:00:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-16 10:00:02','YYYY-MM-DD HH24:MI:SS'),100,200761,'NoTableWithDrillOptions','D','22c1a70e-5ba7-4d22-a84c-db19c552b693')
;

-- Jun 16, 2022, 10:01:24 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Cannot find Drill Rule for the selected Column.','You can define new definitions in Drill Rule window.',0,0,'Y',TO_TIMESTAMP('2022-06-16 10:01:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-16 10:01:24','YYYY-MM-DD HH24:MI:SS'),100,200762,'NoDrillRuleFound','D','6953574e-88f7-4d13-9914-ee36e2dd3bf9')
;

-- Jun 16, 2022, 2:03:49 PM CEST
UPDATE AD_Column SET Callout='org.cloudempiere.model.CalloutProcessDrillRule.process',Updated=TO_TIMESTAMP('2022-06-16 14:03:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214733
;

-- Jun 16, 2022, 2:04:36 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=128,Updated=TO_TIMESTAMP('2022-06-16 14:04:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214733
;

-- Jun 16, 2022, 2:08:50 PM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-16 14:08:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206928
;

-- Jun 16, 2022, 3:29:53 PM CEST
INSERT INTO AD_Tab_Customization (AD_Client_ID,AD_Org_ID,AD_Tab_Customization_ID,AD_Tab_ID,AD_User_ID,Created,CreatedBy,Custom,IsActive,Updated,UpdatedBy,AD_Tab_Customization_UU,IsQuickForm) VALUES (11,0,200000,200309,100,TO_TIMESTAMP('2022-06-16 15:29:52','YYYY-MM-DD HH24:MI:SS'),100,'206937,206944,206939,206942,206936,206941','Y',TO_TIMESTAMP('2022-06-16 15:29:52','YYYY-MM-DD HH24:MI:SS'),100,'373b146c-85ce-4a24-8648-a2785472528a','N')
;

-- Jun 24, 2022, 4:18:53 PM CEST
UPDATE AD_Table SET IsShowInDrillOptions = 'Y' WHERE TableName IN('C_AllocationHdr','C_BankStatement','C_BankTransfer','C_Invoice','C_Order','C_Payment','C_Project','C_RfQ','GL_Journal','M_InOut','M_Inventory','M_Movement','M_Production','M_Requisition','M_RMA','R_Request')
;

-- Jun 27, 2022, 9:16:01 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Drill Key Parameter is Not Set',0,0,'Y',TO_TIMESTAMP('2022-06-27 09:16:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-27 09:16:01','YYYY-MM-DD HH24:MI:SS'),100,200766,'NoDrillKeyParameterSet','D','afe60283-10a3-446b-a557-b0003c457ee4')
;

-- Jun 27, 2022, 9:47:33 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200160,'AD_Column of AD_Process_Para in AD_Table','Table must be previously defined','S','AD_Column.AD_Table_ID=@AD_Table_ID@ AND AD_Column.ColumnName IN (
SELECT ColumnName FROM AD_Process_Para WHERE AD_Process_ID = @AD_Process_ID@
)',0,0,'Y',TO_TIMESTAMP('2022-06-27 09:47:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-27 09:47:33','YYYY-MM-DD HH24:MI:SS'),100,'D','93841ae5-8071-444c-b626-efdf06798b13')
;

-- Jun 27, 2022, 9:48:56 AM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200160,Updated=TO_TIMESTAMP('2022-06-27 09:48:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214930
;

-- Jun 28, 2022, 12:07:13 PM CEST
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=207072
;

-- Jun 28, 2022, 12:07:13 PM CEST
DELETE FROM AD_Field WHERE AD_Field_ID=207072
;

-- Jun 28, 2022, 12:07:19 PM CEST
ALTER TABLE AD_Process_DrillRule DROP CONSTRAINT ADColumn_ADProcessDrillRule
;

-- Jun 28, 2022, 12:07:35 PM CEST
ALTER TABLE AD_Process_DrillRule DROP COLUMN AD_Column_ID
;

-- Jun 28, 2022, 12:08:06 PM CEST
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=214930
;

-- Jun 28, 2022, 12:08:06 PM CEST
DELETE FROM AD_Column WHERE AD_Column_ID=214930
;

-- Jun 28, 2022, 12:29:34 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214967,0,'Process Parameter',200335,186,'AD_Process_Para_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-06-28 12:29:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-28 12:29:33','YYYY-MM-DD HH24:MI:SS'),100,118,'Y','N','D','N','N','N','Y','a793c423-1a45-4fd7-95a0-d03bfb6c6f94','Y',0,'N','N','N')
;

-- Jun 28, 2022, 12:30:40 PM CEST
UPDATE AD_Column SET FKConstraintName='ADProcessPara_ADProcessDrillRu', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-06-28 12:30:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214967
;

-- Jun 28, 2022, 12:30:40 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_Process_Para_ID NUMBER(10) NOT NULL
;

-- Jun 28, 2022, 12:32:12 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT ADProcessPara_ADProcessDrillRu FOREIGN KEY (AD_Process_Para_ID) REFERENCES ad_process_para(ad_process_para_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 28, 2022, 12:38:29 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207109,'Process Parameter',200308,214967,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-28 12:38:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-28 12:38:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6dbd8833-4d79-4312-a7b4-5ccc05af8f12','Y',100,1,1,1,'N','N','N','N')
;

-- Jun 28, 2022, 12:39:27 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-28 12:39:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207109
;

-- Jun 28, 2022, 2:31:48 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Fill Mandatory Drill Rule Parameters',0,0,'Y',TO_TIMESTAMP('2022-06-28 14:31:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-28 14:31:48','YYYY-MM-DD HH24:MI:SS'),100,200767,'FillMandatoryDrillRulePara','D','115f5fac-3645-4f9f-af30-050dda684d24')
;

