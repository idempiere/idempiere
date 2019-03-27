SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3936 Info Window to maintain Support Roles
-- Mar 27, 2019 11:32:10 AM BRT
UPDATE AD_Element SET Name='Role (All)', PrintName='Role (All)',Updated=TO_DATE('2019-03-27 11:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203312
;

-- Mar 27, 2019 11:32:10 AM BRT
UPDATE AD_Column SET ColumnName='AD_AllRoles_V_ID', Name='Role (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203312
;

-- Mar 27, 2019 11:32:10 AM BRT
UPDATE AD_Process_Para SET ColumnName='AD_AllRoles_V_ID', Name='Role (All)', Description=NULL, Help=NULL, AD_Element_ID=203312 WHERE UPPER(ColumnName)='AD_ALLROLES_V_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 27, 2019 11:32:10 AM BRT
UPDATE AD_Process_Para SET ColumnName='AD_AllRoles_V_ID', Name='Role (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203312 AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:10 AM BRT
UPDATE AD_InfoColumn SET ColumnName='AD_AllRoles_V_ID', Name='Role (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203312 AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:10 AM BRT
UPDATE AD_Field SET Name='Role (All)', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203312) AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:10 AM BRT
UPDATE AD_PrintFormatItem SET PrintName='Role (All)', Name='Role (All)' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203312)
;

-- Mar 27, 2019 11:32:21 AM BRT
UPDATE AD_Element SET Name='User (All)', PrintName='User (All)',Updated=TO_DATE('2019-03-27 11:32:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203121
;

-- Mar 27, 2019 11:32:21 AM BRT
UPDATE AD_Column SET ColumnName='AD_AllUsers_V_ID', Name='User (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203121
;

-- Mar 27, 2019 11:32:21 AM BRT
UPDATE AD_Process_Para SET ColumnName='AD_AllUsers_V_ID', Name='User (All)', Description=NULL, Help=NULL, AD_Element_ID=203121 WHERE UPPER(ColumnName)='AD_ALLUSERS_V_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 27, 2019 11:32:21 AM BRT
UPDATE AD_Process_Para SET ColumnName='AD_AllUsers_V_ID', Name='User (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203121 AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:21 AM BRT
UPDATE AD_InfoColumn SET ColumnName='AD_AllUsers_V_ID', Name='User (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203121 AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:21 AM BRT
UPDATE AD_Field SET Name='User (All)', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203121) AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:21 AM BRT
UPDATE AD_PrintFormatItem SET PrintName='User (All)', Name='User (All)' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203121)
;

-- Mar 27, 2019 11:32:30 AM BRT
UPDATE AD_Element SET Name='Client (All)', PrintName='Client (All)',Updated=TO_DATE('2019-03-27 11:32:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203119
;

-- Mar 27, 2019 11:32:30 AM BRT
UPDATE AD_Column SET ColumnName='AD_AllClients_V_ID', Name='Client (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203119
;

-- Mar 27, 2019 11:32:30 AM BRT
UPDATE AD_Process_Para SET ColumnName='AD_AllClients_V_ID', Name='Client (All)', Description=NULL, Help=NULL, AD_Element_ID=203119 WHERE UPPER(ColumnName)='AD_ALLCLIENTS_V_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 27, 2019 11:32:30 AM BRT
UPDATE AD_Process_Para SET ColumnName='AD_AllClients_V_ID', Name='Client (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203119 AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:30 AM BRT
UPDATE AD_InfoColumn SET ColumnName='AD_AllClients_V_ID', Name='Client (All)', Description=NULL, Help=NULL WHERE AD_Element_ID=203119 AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:30 AM BRT
UPDATE AD_Field SET Name='Client (All)', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203119) AND IsCentrallyMaintained='Y'
;

-- Mar 27, 2019 11:32:30 AM BRT
UPDATE AD_PrintFormatItem SET PrintName='Client (All)', Name='Client (All)' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203119)
;

-- IDEMPIERE-3936 Info Window to maintain Support Roles
-- Mar 27, 2019 3:17:19 PM BRT
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,OrderByClause,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum) VALUES (200013,0,0,'Y',TO_DATE('2019-03-27 15:17:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:18','YYYY-MM-DD HH24:MI:SS'),100,'Role (All)',200255,'D','AD_AllRoles_V r','N','927cfb7d-e612-4a3b-a2dd-7799cfc08f80','Y','N','r.Name, r.AD_AllClients_V_ID','Y',0,'N',0,'Y')
;

-- Mar 27, 2019 3:17:19 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200148,0,0,'Y',TO_DATE('2019-03-27 15:17:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:19','YYYY-MM-DD HH24:MI:SS'),100,'Client (All)',200013,'D','r.AD_AllClients_V_ID',20,'Y','Y',203119,30,'1456a03c-c683-4b4b-acff-46b7e81106bc','Y','AD_AllClients_V_ID','=','N',20,'N','N')
;

-- Mar 27, 2019 3:17:20 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200149,0,0,'Y',TO_DATE('2019-03-27 15:17:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:19','YYYY-MM-DD HH24:MI:SS'),100,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200013,'D','r.Name',10,'Y','Y',469,10,'146d9ab8-e4c2-4d07-b833-44ce35198407','Y','Name','Like','Upper','Y',10,'N','N')
;

-- Mar 27, 2019 3:17:20 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200150,0,0,'Y',TO_DATE('2019-03-27 15:17:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:20','YYYY-MM-DD HH24:MI:SS'),100,'Description','Optional short description of the record','A description is limited to 255 characters.',200013,'D','r.Description',30,'Y','Y',275,10,'85e5a368-f95b-4e47-8b1d-bac24185ebf0','Y','Description','Like','Upper','N',30,'N','N')
;

-- Mar 27, 2019 3:17:21 PM BRT
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,WhereClause,IsDefault,IsDistinct,OrderByClause,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum) VALUES (200014,0,0,'Y',TO_DATE('2019-03-27 15:17:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:20','YYYY-MM-DD HH24:MI:SS'),100,'Support Users vs Roles',200255,'D','AD_AllRoles_V r
JOIN AD_AllUsers_V u ON (1=1)
LEFT JOIN AD_AllUserRoles_V ur ON (ur.AD_AllUsers_V_ID=u.AD_AllUsers_V_ID AND ur.AD_AllRoles_V_ID=r.AD_AllRoles_V_ID)','N','ede4d13f-fefc-4de6-843b-3236c1941ce4','u.IsActive=''Y'' AND u.IsSupportUser=''Y'' AND r.IsActive=''Y'' AND r.RoleType=''SS'' AND r.AD_AllRoles_V_ID>0 AND u.AD_AllUsers_V_ID>100','N','N','u.Name, r.Name, u.AD_AllUsers_V_ID, r.AD_AllRoles_V_ID','Y',0,'N',0,'Y')
;

-- Mar 27, 2019 3:17:22 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200151,0,0,'Y',TO_DATE('2019-03-27 15:17:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:21','YYYY-MM-DD HH24:MI:SS'),100,'Created','Date this record was created','The Created field indicates the date that this record was created.',200014,'D','ur.Created',50,'Y','N',245,15,'85c737d2-cb15-426a-979e-865a2b56ca50','Y','Created','=','Trunc','N',0,'N','N')
;

-- Mar 27, 2019 3:17:22 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200152,0,0,'Y',TO_DATE('2019-03-27 15:17:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:22','YYYY-MM-DD HH24:MI:SS'),100,'Info','Information','The Information displays data from the source document line.',200014,'D','u.AD_AllUsers_V_ID||''|''||r.AD_AllRoles_V_ID',60,'N','N',1270,10,'13c207d6-4d04-4a39-ac4c-2a766d7f521c','Y','Info','Like','Upper','N',0,'N','N')
;

-- Mar 27, 2019 3:17:23 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200153,0,0,'Y',TO_DATE('2019-03-27 15:17:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:22','YYYY-MM-DD HH24:MI:SS'),100,'Test ID',200014,'D','ROW_NUMBER() OVER (ORDER BY u.AD_AllUsers_V_ID)',70,'N','N',592,19,'d0ce4aaa-8f97-4447-b0b5-062dc7ac46a3','Y','Test_ID','=','N',0,'N','Y')
;

-- Mar 27, 2019 3:17:24 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200154,0,0,'Y',TO_DATE('2019-03-27 15:17:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:23','YYYY-MM-DD HH24:MI:SS'),100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200014,'D','COALESCE(ur.IsActive,''N'')',40,'Y','Y',348,17,'401a4472-3c34-4585-b2b7-8e75a961bf5e',319,'Y','IsActive','=','N',30,'N','N')
;

-- Mar 27, 2019 3:17:24 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200155,0,0,'Y',TO_DATE('2019-03-27 15:17:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:24','YYYY-MM-DD HH24:MI:SS'),100,'Role Name',200014,'D','r.Name',80,'Y','Y',469,10,'d712c8bc-3855-4a43-9107-0e68f32baf4b','N','Name','Like','Upper','N',40,'N','N')
;

-- Mar 27, 2019 3:17:25 PM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200132,'AD_AllUsers_V - Support Users','S','AD_AllUsers_V.IsSupportUser=''Y'' AND AD_AllUsers_V.AD_AllUsers_V_ID>100',0,0,'Y',TO_DATE('2019-03-27 15:17:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:24','YYYY-MM-DD HH24:MI:SS'),100,'D','2251d55c-2e14-4b2d-a154-cc57c29346ee')
;

-- Mar 27, 2019 3:17:25 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200156,0,0,'Y',TO_DATE('2019-03-27 15:17:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:25','YYYY-MM-DD HH24:MI:SS'),100,'User (All)',200014,'D','u.AD_AllUsers_V_ID',10,'Y','Y',203121,19,'4a190248-2ef9-48a4-bf72-5a0183e467c9',200132,'Y','AD_AllUsers_V_ID','=','N',10,'N','N')
;

-- Mar 27, 2019 3:17:26 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200157,0,0,'Y',TO_DATE('2019-03-27 15:17:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:25','YYYY-MM-DD HH24:MI:SS'),100,'Client (All)',200014,'D','r.AD_AllClients_V_ID',20,'Y','Y',203119,30,'d81e3460-fc90-4452-894e-4769c0551202','Y','AD_AllClients_V_ID','=','N',20,'N','N')
;

-- Mar 27, 2019 3:17:26 PM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200133,'AD_AllRoles_V - Support Roles','S','AD_AllRoles_V.RoleType=''SS'' AND AD_AllRoles_V.AD_AllRoles_V_ID>0',0,0,'Y',TO_DATE('2019-03-27 15:17:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:26','YYYY-MM-DD HH24:MI:SS'),100,'D','fcc15cc7-9248-4cf0-8b46-e224a5ba1ec8')
;

-- Mar 27, 2019 3:17:27 PM BRT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey) VALUES (200158,0,0,'Y',TO_DATE('2019-03-27 15:17:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:26','YYYY-MM-DD HH24:MI:SS'),100,'Role (All)',200014,'D','r.AD_AllRoles_V_ID',30,'Y','Y',203312,30,'997b7097-85fd-4b24-84bc-b91c20bb44ea',200133,'Y','AD_AllRoles_V_ID','=','N',50,'N','N')
;

-- Mar 27, 2019 3:17:28 PM BRT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200112,0,0,'Y',TO_DATE('2019-03-27 15:17:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:27','YYYY-MM-DD HH24:MI:SS'),100,'Activate','N','ActivateSupportRole','N','org.idempiere.process.MaintainSupportRoles','4','D',28,1098,'N','N','S','N','ef977b06-1d1b-4030-b3a7-f404c540767d')
;

-- Mar 27, 2019 3:17:28 PM BRT
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200167,'Activate/Deactivate/Delete','L',0,0,'Y',TO_DATE('2019-03-27 15:17:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:28','YYYY-MM-DD HH24:MI:SS'),100,'D','N','4fa8918c-0b18-40b6-a133-f7847d5d3404')
;

-- Mar 27, 2019 3:17:29 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200467,'Delete',200167,'D',0,0,'Y',TO_DATE('2019-03-27 15:17:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:28','YYYY-MM-DD HH24:MI:SS'),100,'D','9d82b99a-e6e7-45ef-9b49-3eb25683de0d')
;

-- Mar 27, 2019 3:17:29 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200468,'Deactivate',200167,'N',0,0,'Y',TO_DATE('2019-03-27 15:17:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:29','YYYY-MM-DD HH24:MI:SS'),100,'D','780929ff-b83f-4588-95d7-6b84a6457d9b')
;

-- Mar 27, 2019 3:17:30 PM BRT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200469,'Activate',200167,'Y',0,0,'Y',TO_DATE('2019-03-27 15:17:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:29','YYYY-MM-DD HH24:MI:SS'),100,'D','efec64a4-b591-49c9-8e99-f5b339383a82')
;

-- Mar 27, 2019 3:17:30 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200274,0,0,'Y',TO_DATE('2019-03-27 15:17:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:30','YYYY-MM-DD HH24:MI:SS'),100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200112,10,17,200167,'N',1,'N','Y','IsActive','Y','D',348,'5e399381-93cb-492c-ab22-1cbd7483b231','N')
;

-- Mar 27, 2019 3:17:31 PM BRT
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,AD_InfoColumn_ID) VALUES (200005,'642882e5-f464-433b-803f-70737552fa1a',0,0,'Y',TO_DATE('2019-03-27 15:17:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:30','YYYY-MM-DD HH24:MI:SS'),100,10,200112,200014,'B',200152)
;

-- Mar 27, 2019 3:17:31 PM BRT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200113,0,0,'Y',TO_DATE('2019-03-27 15:17:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:31','YYYY-MM-DD HH24:MI:SS'),100,'Deactivate','N','DeactivateSupportRole','N','org.idempiere.process.MaintainSupportRoles','4','D',10,683,'N','N','S','N','7587be02-733c-4c7e-a40c-becbef1cc1d7')
;

-- Mar 27, 2019 3:17:32 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200275,0,0,'Y',TO_DATE('2019-03-27 15:17:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:31','YYYY-MM-DD HH24:MI:SS'),100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200113,10,17,200167,'N',1,'N','N','IsActive','Y','D',348,'01786cdf-a245-4923-bda8-a146a4a60aa9','N')
;

-- Mar 27, 2019 3:17:32 PM BRT
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,AD_InfoColumn_ID) VALUES (200006,'746b8cee-2eac-406e-8a3a-321b499b33e7',0,0,'Y',TO_DATE('2019-03-27 15:17:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:32','YYYY-MM-DD HH24:MI:SS'),100,20,200113,200014,'B',200152)
;

-- Mar 27, 2019 3:17:33 PM BRT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200114,0,0,'Y',TO_DATE('2019-03-27 15:17:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:32','YYYY-MM-DD HH24:MI:SS'),100,'Delete','N','DeleteSupportRole','N','org.idempiere.process.MaintainSupportRoles','4','D',6,52,'N','N','S','N','dd2a56da-3f62-4bec-b186-6c2b0aead59b')
;

-- Mar 27, 2019 3:17:33 PM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200276,0,0,'Y',TO_DATE('2019-03-27 15:17:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:33','YYYY-MM-DD HH24:MI:SS'),100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200114,10,17,200167,'N',1,'N','D','IsActive','Y','D',348,'0a1630f1-6c3c-448e-b3cb-94163dea26a8','N')
;

-- Mar 27, 2019 3:17:34 PM BRT
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,AD_InfoColumn_ID) VALUES (200007,'aba479a2-91bf-4931-a21a-c5654975b637',0,0,'Y',TO_DATE('2019-03-27 15:17:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:33','YYYY-MM-DD HH24:MI:SS'),100,30,200114,200014,'B',200152)
;

-- Mar 27, 2019 3:17:34 PM BRT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU,AD_InfoWindow_ID) VALUES (200171,'Support Users vs Roles','I',0,0,'Y',TO_DATE('2019-03-27 15:17:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-27 15:17:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','a86fb1cd-7266-4376-9705-dc5bc72f806e',200014)
;

-- Mar 27, 2019 3:17:34 PM BRT
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 367,23, 10, 200171)
;

UPDATE ad_treenodemm SET ad_treenodemm_uu='e507c008-8a01-4937-880c-cc6a6e64f5b5' WHERE node_id=200171 AND ad_tree_id=10 AND ad_treenodemm_uu IS NULL;

-- Mar 27, 2019, 3:47:38 PM BRT
UPDATE AD_InfoWindow SET WhereClause='u.IsActive=''Y'' AND u.IsSupportUser=''Y'' AND r.IsActive=''Y'' AND r.RoleType=''SS'' AND r.AD_AllRoles_V_ID>0 AND u.AD_AllUsers_V_ID>100 AND r.IsMasterRole=''N''', IsValid='Y',Updated=TO_DATE('2019-03-27 15:47:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200014
;

-- Mar 27, 2019, 3:48:19 PM BRT
UPDATE AD_Val_Rule SET Code='AD_AllRoles_V.RoleType=''SS'' AND AD_AllRoles_V.AD_AllRoles_V_ID>0 AND AD_AllRoles_V.IsMasterRole=''N''',Updated=TO_DATE('2019-03-27 15:48:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200133
;

-- Mar 27, 2019, 3:49:15 PM BRT
UPDATE AD_InfoColumn SET IsDisplayed='N',Updated=TO_DATE('2019-03-27 15:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200155
;

SELECT register_migration_script('201903271134_IDEMPIERE-3936.sql') FROM dual
;

