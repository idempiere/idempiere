-- IDEMPIERE-6893
SELECT register_migration_script('202603061658_IDEMPIERE-6893.sql') FROM dual;

-- Mar 6, 2026, 4:58:33 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200435,'User defined Form','AD_UserDef_Form','6',0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:32','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:32','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N','N','D','Y','L','019cc3df-3d65-7487-be6e-3a6351e90e6f','N')
;

-- Mar 6, 2026, 4:58:33 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Form',1000000,'N','N','Table AD_UserDef_Form','Y','Y',0,0,TO_TIMESTAMP('2026-03-06 16:58:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:33','YYYY-MM-DD HH24:MI:SS'),10,200525,'Y',1000000,1,200000,'019cc3df-3e7c-7334-8e50-c691646e6d91')
;

-- Mar 6, 2026, 4:58:33 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217389,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200435,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:33','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','1=1','D','N','019cc3df-3f81-72e2-bd2e-1f9ed7f601f2','N')
;

-- Mar 6, 2026, 4:58:34 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217390,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200435,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:33','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','019cc3df-4096-72b3-87b6-c217b8936ebc','N')
;

-- Mar 6, 2026, 4:58:34 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217391,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200435,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:34','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','019cc3df-419d-7b69-a3a1-340486d497d7','N')
;

-- Mar 6, 2026, 4:58:34 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217392,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200435,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:34','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','019cc3df-42a4-74f0-b167-bc3ce71d7fbc','N')
;

-- Mar 6, 2026, 4:58:34 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217393,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200435,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:34','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','019cc3df-43a6-7011-9920-18c6ebab8936','N')
;

-- Mar 6, 2026, 4:58:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217394,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200435,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:34','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','019cc3df-449d-7ddc-af85-0e954ac2fa3b','N')
;

-- Mar 6, 2026, 4:58:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217395,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200435,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:35','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','019cc3df-45bb-7cdd-ab36-a827a28f4219','N')
;

-- Mar 6, 2026, 4:58:35 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204038,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:35','YYYY-MM-DD HH24:MI:SS'),10,'AD_UserDef_Form_ID','User defined Form','User defined Form','D','019cc3df-46e2-736e-847c-f48322822431')
;

-- Mar 6, 2026, 4:58:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217396,0.0,'User defined Form',200435,'AD_UserDef_Form_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:35','YYYY-MM-DD HH24:MI:SS'),10,204038,'N','N','D','N','019cc3df-47ee-76a8-b2e7-9f4552b53699','N')
;

-- Mar 6, 2026, 4:58:36 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204039,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:36','YYYY-MM-DD HH24:MI:SS'),10,'AD_UserDef_Form_UU','AD_UserDef_Form_UU','AD_UserDef_Form_UU','D','019cc3df-48ee-7bf7-a9e8-49de6e72ba0a')
;

-- Mar 6, 2026, 4:58:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217397,0.0,'AD_UserDef_Form_UU',200435,'AD_UserDef_Form_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:36','YYYY-MM-DD HH24:MI:SS'),10,204039,'Y','N','D','N','019cc3df-49f4-7314-aed4-61c0f42e144b','N')
;

-- Mar 6, 2026, 4:58:36 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201299,'019cc3df-4af6-7db5-bc66-58efa8a1bf65',TO_TIMESTAMP('2026-03-06 16:58:36','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','AD_UserDef_Form_UU_idx',TO_TIMESTAMP('2026-03-06 16:58:36','YYYY-MM-DD HH24:MI:SS'),10,200435,'Y','Y','N','N')
;

-- Mar 6, 2026, 4:58:37 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201784,'019cc3df-4c53-7965-88bf-aa0cc64d3acb',TO_TIMESTAMP('2026-03-06 16:58:36','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-06 16:58:36','YYYY-MM-DD HH24:MI:SS'),10,217397,201299,10)
;

-- Mar 6, 2026, 4:58:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (217398,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200435,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:37','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','019cc3df-4d5f-7136-ae06-65874f705981',10,'N')
;

-- Mar 6, 2026, 4:58:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217399,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200435,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:37','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','N','D','N','019cc3df-4e6f-7ac8-bfaf-06bc874bba50','N')
;

-- Mar 6, 2026, 4:58:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217400,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200435,'Help',2000,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:37','YYYY-MM-DD HH24:MI:SS'),10,326,'Y','N','D','N','019cc3df-4f73-7098-b117-1b4dbd549274','N')
;

-- Mar 6, 2026, 4:58:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217401,0.0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200435,'AD_User_ID',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-03-06 16:58:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 16:58:37','YYYY-MM-DD HH24:MI:SS'),10,138,'Y','N','D','N','019cc3df-5073-7c58-aaba-1cdd7c41fec8','N')
;

-- Mar 6, 2026, 5:00:42 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217402,0,'Special Form','Special Form','The Special Form field identifies a unique Special Form in the system.',200435,'AD_Form_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-06 17:00:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:00:42','YYYY-MM-DD HH24:MI:SS'),10,1298,'N','N','D','N','N','N','Y','019cc3e1-3709-720e-af9d-5868fd2fd615','Y',0,'N','N','N','N','N')
;

-- Mar 6, 2026, 5:01:02 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217403,0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200435,'AD_Language',6,'N','N','N','N','N',0,'N',18,327,0,0,'Y',TO_TIMESTAMP('2026-03-06 17:01:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:01:02','YYYY-MM-DD HH24:MI:SS'),10,109,'Y','N','D','N','N','N','Y','019cc3e1-851d-75a5-b221-2ab83724c864','Y',0,'N','N','N','N','N')
;

-- Mar 6, 2026, 5:01:24 PM CET
UPDATE AD_Column SET IsUpdateable='Y', IsAllowCopy='N',Updated=TO_TIMESTAMP('2026-03-06 17:01:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217390
;

-- Mar 6, 2026, 5:01:49 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217404,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200435,'AD_Role_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-03-06 17:01:49','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:01:49','YYYY-MM-DD HH24:MI:SS'),10,123,'Y','N','D','N','N','N','Y','019cc3e2-3b60-71aa-a16b-1034a3575cfa','Y',0,'N','N','C','N','N')
;

-- Mar 6, 2026, 5:02:13 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217405,0,'Image URL','URL of  image','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.',200435,'ImageURL',120,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-06 17:02:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:02:13','YYYY-MM-DD HH24:MI:SS'),10,1720,'Y','N','D','N','N','N','Y','019cc3e2-9a4e-7b8f-b64d-499d1831ac88','Y',0,'N','N','N','N')
;

-- Mar 6, 2026, 5:05:13 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADUserDefForm', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-06 17:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217389
;

-- Mar 6, 2026, 5:05:13 PM CET
UPDATE AD_Column SET FKConstraintName='ADForm_ADUserDefForm', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-06 17:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217402
;

-- Mar 6, 2026, 5:05:13 PM CET
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADUserDefForm', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-06 17:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217403
;

-- Mar 6, 2026, 5:05:13 PM CET
UPDATE AD_Column SET FKConstraintName='ADOrg_ADUserDefForm', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-06 17:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217390
;

-- Mar 6, 2026, 5:05:13 PM CET
UPDATE AD_Column SET FKConstraintName='ADRole_ADUserDefForm', FKConstraintType='C',Updated=TO_TIMESTAMP('2026-03-06 17:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217404
;

-- Mar 6, 2026, 5:05:13 PM CET
UPDATE AD_Column SET FKConstraintName='ADUser_ADUserDefForm', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-06 17:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217401
;

-- Mar 6, 2026, 5:05:13 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADUserDefForm', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-06 17:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217392
;

-- Mar 6, 2026, 5:05:13 PM CET
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADUserDefForm', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-03-06 17:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217394
;

-- Mar 6, 2026, 5:05:13 PM CET
CREATE TABLE AD_UserDef_Form (AD_Client_ID NUMERIC(10) NOT NULL, AD_Form_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) DEFAULT NULL , AD_Org_ID NUMERIC(10) NOT NULL, AD_Role_ID NUMERIC(10) DEFAULT NULL , AD_User_ID NUMERIC(10) NOT NULL, AD_UserDef_Form_ID NUMERIC(10) NOT NULL, AD_UserDef_Form_UU UUID DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , Help VARCHAR(2000) DEFAULT NULL , ImageURL VARCHAR(120) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_UserDef_Form_Key PRIMARY KEY (AD_UserDef_Form_ID), CONSTRAINT AD_UserDef_Form_UU_idx UNIQUE (AD_UserDef_Form_UU))
;

-- Mar 6, 2026, 5:05:13 PM CET
ALTER TABLE AD_UserDef_Form ADD CONSTRAINT ADClient_ADUserDefForm FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 6, 2026, 5:05:13 PM CET
ALTER TABLE AD_UserDef_Form ADD CONSTRAINT ADForm_ADUserDefForm FOREIGN KEY (AD_Form_ID) REFERENCES ad_form(ad_form_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 6, 2026, 5:05:13 PM CET
ALTER TABLE AD_UserDef_Form ADD CONSTRAINT ADLanguage_ADUserDefForm FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 6, 2026, 5:05:13 PM CET
ALTER TABLE AD_UserDef_Form ADD CONSTRAINT ADOrg_ADUserDefForm FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 6, 2026, 5:05:13 PM CET
ALTER TABLE AD_UserDef_Form ADD CONSTRAINT ADRole_ADUserDefForm FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Mar 6, 2026, 5:05:13 PM CET
ALTER TABLE AD_UserDef_Form ADD CONSTRAINT ADUser_ADUserDefForm FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 6, 2026, 5:05:13 PM CET
ALTER TABLE AD_UserDef_Form ADD CONSTRAINT CreatedBy_ADUserDefForm FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 6, 2026, 5:05:13 PM CET
ALTER TABLE AD_UserDef_Form ADD CONSTRAINT UpdatedBy_ADUserDefForm FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 6, 2026, 5:06:30 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201300,'019cc3e6-859c-747e-b196-ef16cd611c4e',TO_TIMESTAMP('2026-03-06 17:06:30','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','AD_UserDef_Form_UU_Unique',TO_TIMESTAMP('2026-03-06 17:06:30','YYYY-MM-DD HH24:MI:SS'),10,200435,'N','Y','N','N')
;

-- Mar 6, 2026, 5:06:35 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201785,'019cc3e6-9acc-702e-bcf0-b39fe7d5f691',TO_TIMESTAMP('2026-03-06 17:06:35','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-06 17:06:35','YYYY-MM-DD HH24:MI:SS'),10,217402,201300,10)
;

-- Mar 6, 2026, 5:06:40 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201786,'019cc3e6-ad9b-7673-9beb-41a55f2fc917',TO_TIMESTAMP('2026-03-06 17:06:40','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-06 17:06:40','YYYY-MM-DD HH24:MI:SS'),10,217389,201300,20)
;

-- Mar 6, 2026, 5:06:43 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201787,'019cc3e6-b7e1-771b-95c7-8c170144a7fa',TO_TIMESTAMP('2026-03-06 17:06:43','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-06 17:06:43','YYYY-MM-DD HH24:MI:SS'),10,217390,201300,30)
;

-- Mar 6, 2026, 5:06:56 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201788,'019cc3e6-ecdf-7710-8047-5c7866d19c98',TO_TIMESTAMP('2026-03-06 17:06:56','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-06 17:06:56','YYYY-MM-DD HH24:MI:SS'),10,217404,201300,'COALESCE(AD_Role_ID, 0)',40)
;

-- Mar 6, 2026, 5:07:07 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201789,'019cc3e7-1468-723a-b2ac-3b01b34b7b2f',TO_TIMESTAMP('2026-03-06 17:07:06','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-06 17:07:06','YYYY-MM-DD HH24:MI:SS'),10,217401,201300,'COALESCE(AD_User_ID, 0)',50)
;

-- Mar 6, 2026, 5:07:31 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201790,'019cc3e7-757c-7411-9ff0-99c25e69e8f3',TO_TIMESTAMP('2026-03-06 17:07:31','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-06 17:07:31','YYYY-MM-DD HH24:MI:SS'),10,217403,201300,'COALESCE(AD_Language, '''')',60)
;

-- Mar 6, 2026, 5:07:34 PM CET
CREATE UNIQUE INDEX AD_UserDef_Form_UU_Unique ON AD_UserDef_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,COALESCE(AD_Role_ID, 0),COALESCE(AD_User_ID, 0),COALESCE(AD_Language, ''))
;

-- Mar 6, 2026, 5:07:50 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200159,'User defined Form',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:50','YYYY-MM-DD HH24:MI:SS'),10,'M','N','D','N','N','N','019cc3e7-be3f-7742-b544-14d3e098bd54')
;

-- Mar 6, 2026, 5:07:50 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200413,'User defined Form',200159,10,'Y',200435,0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:50','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','AD_UserDef_Form.Name','N',0,'N','D','Y','N','019cc3e7-bf5f-73a9-8018-b5a737255a4b')
;

-- Mar 6, 2026, 5:07:51 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209014,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200413,217389,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:50','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c07a-7e1f-8ea8-09fd5f5bf2a7','Y',10,2)
;

-- Mar 6, 2026, 5:07:51 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (209015,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200413,217390,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:51','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c17e-795d-8ef6-0bd939c3caf7','Y','N',4,2)
;

-- Mar 6, 2026, 5:07:51 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209016,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200413,217398,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:51','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c27c-7995-9692-e7465c121d20','Y',20,5)
;

-- Mar 6, 2026, 5:07:51 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209017,'Description','Optional short description of the record','A description is limited to 255 characters.',200413,217399,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:51','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c38d-771a-91bc-07d4f54a1060','Y',30,5)
;

-- Mar 6, 2026, 5:07:52 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209018,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200413,217400,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:51','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c498-7cce-8ccd-58856ce6abaa','Y',40,5)
;

-- Mar 6, 2026, 5:07:52 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209019,'User defined Form',200413,217396,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:52','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c5a0-74d0-b7e6-e7f29255a70d','N',2)
;

-- Mar 6, 2026, 5:07:52 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209020,'AD_UserDef_Form_UU',200413,217397,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:52','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c6ab-782b-bad5-e42207169599','N',2)
;

-- Mar 6, 2026, 5:07:52 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209021,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200413,217401,'Y',10,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:52','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c7a1-735d-87f1-78ec5878cdee','Y',50,2)
;

-- Mar 6, 2026, 5:07:53 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209022,'Special Form','Special Form','The Special Form field identifies a unique Special Form in the system.',200413,217402,'Y',22,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:52','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c8b5-737f-8932-6d125140e900','Y',60,2)
;

-- Mar 6, 2026, 5:07:53 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209023,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200413,217403,'Y',6,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:53','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:53','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-c9c4-7194-bf36-0ef134a187ea','Y',70,2)
;

-- Mar 6, 2026, 5:07:53 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209024,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200413,217404,'Y',22,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:53','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:53','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-cac6-78d3-925b-a6f193fc4a9c','Y',80,2)
;

-- Mar 6, 2026, 5:07:54 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209025,'Image URL','URL of  image','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.',200413,217405,'Y',120,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:53','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:53','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-cbd3-71e3-9411-cf746c496b41','Y',90,5)
;

-- Mar 6, 2026, 5:07:54 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209026,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200413,217395,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:54','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:54','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019cc3e7-ccd3-73d7-90b2-74eff8fc49a5','Y',100,2,2)
;

-- Mar 6, 2026, 5:07:54 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200248,'User defined Form','W',200159,0,0,'Y',TO_TIMESTAMP('2026-03-06 17:07:54','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-03-06 17:07:54','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','D','019cc3e7-cde6-713c-ad14-f1502b2ec872')
;

-- Mar 6, 2026, 5:07:54 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 10, statement_timestamp(), 10,t.AD_Tree_ID, 200248, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200248)
;

-- Mar 6, 2026, 5:07:54 PM CET
UPDATE AD_Table SET AD_Window_ID=200159,Updated=TO_TIMESTAMP('2026-03-06 17:07:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200435
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=1000000
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200233
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200232
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200248
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=33,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=34,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=35,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=36,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=37,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=38,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200198
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=39,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200206
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=40,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200207
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=41,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200208
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=42,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200227
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=43,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200228
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=44,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200246
;

-- Mar 6, 2026, 5:08:47 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=45,Updated=TO_TIMESTAMP('2026-03-06 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209022
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=6, ColumnSpan=1,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209026
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=1,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209024
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209021
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=1,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209023
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET SeqNo=80, ColumnSpan=2,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209016
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209025
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209017
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209018
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209020
;

-- Mar 6, 2026, 5:16:30 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-03-06 17:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209019
;

-- Mar 6, 2026, 5:19:01 PM CET
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2026-03-06 17:19:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217398
;

-- Mar 6, 2026, 5:19:12 PM CET
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2026-03-06 17:19:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217401
;

-- Mar 6, 2026, 5:19:14 PM CET
INSERT INTO t_alter_column values('ad_userdef_form','Name','VARCHAR(60)',null,'NULL')
;

-- Mar 6, 2026, 5:19:14 PM CET
INSERT INTO t_alter_column values('ad_userdef_form','Name',null,'NULL',null)
;

-- Mar 6, 2026, 5:19:14 PM CET
INSERT INTO t_alter_column values('ad_userdef_form','AD_User_ID','NUMERIC(10)',null,'NULL')
;

-- Mar 6, 2026, 5:19:14 PM CET
INSERT INTO t_alter_column values('ad_userdef_form','AD_User_ID',null,'NULL',null)
;

