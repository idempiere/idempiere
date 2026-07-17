-- IDEMPIERE-4042: Make Requisition Line Model Order Line - Add UOM, QTY Ordered, Reference, Charge Fields
SELECT register_migration_script('202001081713_IDEMPIERE-4042.sql') FROM dual
;

-- Oct 10, 2019 3:31:06 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214080,0,'Project','Financial Project','A Project allows you to track and control internal or external activities.',702,'C_Project_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2019-10-10 15:31:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:31:06','YYYY-MM-DD HH24:MI:SS'),100,208,'Y','N','D','N','N','N','Y','3851c14e-b601-42b1-974b-90d9e9476a18','Y',0,'N','N')
;

-- Oct 10, 2019 3:31:25 PM IST
UPDATE AD_Column SET FKConstraintName='CProject_MRequisition', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-10 15:31:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214080
;

-- Oct 10, 2019 3:31:25 PM IST
ALTER TABLE M_Requisition ADD COLUMN C_Project_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 10, 2019 3:31:25 PM IST
ALTER TABLE M_Requisition ADD CONSTRAINT CProject_MRequisition FOREIGN KEY (C_Project_ID) REFERENCES c_project(c_project_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 10, 2019 3:31:48 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214081,0,'Campaign','Marketing Campaign','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',702,'C_Campaign_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2019-10-10 15:31:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:31:48','YYYY-MM-DD HH24:MI:SS'),100,550,'Y','N','D','N','N','N','Y','9f62ccdf-78c0-47a5-835f-16be311b79a2','Y',0,'N','N','N')
;

-- Oct 10, 2019 3:31:52 PM IST
UPDATE AD_Column SET FKConstraintName='CCampaign_MRequisition', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-10 15:31:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214081
;

-- Oct 10, 2019 3:31:52 PM IST
ALTER TABLE M_Requisition ADD COLUMN C_Campaign_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 10, 2019 3:31:52 PM IST
ALTER TABLE M_Requisition ADD CONSTRAINT CCampaign_MRequisition FOREIGN KEY (C_Campaign_ID) REFERENCES c_campaign(c_campaign_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 10, 2019 3:32:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206205,'Project','Financial Project','A Project allows you to track and control internal or external activities.',641,214080,'Y','@$Element_PJ@=Y',10,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-10 15:32:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:32:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d5dd301f-bc30-44ba-b2d5-f32c5f727408','Y',190,2)
;

-- Oct 10, 2019 3:32:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206206,'Campaign','Marketing Campaign','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',641,214081,'Y','@$Element_MC@=Y',22,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-10 15:32:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:32:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','520fca1f-cba1-4ed7-82a6-7999f59ad743','Y',200,2)
;

-- Oct 10, 2019 3:33:46 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-10 15:33:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206206
;

-- Oct 10, 2019 3:34:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214082,0,'Price','Price Entered - the price based on the selected/base UoM','The price entered is converted to the actual price based on the UoM conversion',703,'PriceEntered',22,'N','N','N','N','N',0,'N',37,0,0,'Y',TO_TIMESTAMP('2019-10-10 15:34:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:34:49','YYYY-MM-DD HH24:MI:SS'),100,2588,'Y','N','D','N','N','N','Y','049802a6-6516-4ce6-bf6d-d3a19b86abb8','Y',0,'N','N')
;

-- Oct 10, 2019 3:34:55 PM IST
ALTER TABLE M_RequisitionLine ADD COLUMN PriceEntered NUMERIC DEFAULT NULL 
;

-- Oct 10, 2019 3:35:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214084,0,'Project','Financial Project','A Project allows you to track and control internal or external activities.',703,'C_Project_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2019-10-10 15:35:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:35:23','YYYY-MM-DD HH24:MI:SS'),100,208,'Y','N','D','N','N','N','Y','d0d9e90f-a13d-4bd7-ad95-8af21cf9738c','Y',0,'N','N')
;

-- Oct 10, 2019 3:35:26 PM IST
UPDATE AD_Column SET FKConstraintName='CProject_MRequisitionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-10 15:35:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214084
;

-- Oct 10, 2019 3:35:26 PM IST
ALTER TABLE M_RequisitionLine ADD COLUMN C_Project_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 10, 2019 3:35:26 PM IST
ALTER TABLE M_RequisitionLine ADD CONSTRAINT CProject_MRequisitionLine FOREIGN KEY (C_Project_ID) REFERENCES c_project(c_project_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 10, 2019 3:35:41 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214085,0,'Campaign','Marketing Campaign','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',703,'C_Campaign_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2019-10-10 15:35:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:35:40','YYYY-MM-DD HH24:MI:SS'),100,550,'Y','N','D','N','N','N','Y','f2d7f74b-d7a0-49e9-bbf4-8c0e3123321c','Y',0,'N','N','N')
;

-- Oct 10, 2019 3:35:44 PM IST
UPDATE AD_Column SET FKConstraintName='CCampaign_MRequisitionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-10 15:35:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214085
;

-- Oct 10, 2019 3:35:44 PM IST
ALTER TABLE M_RequisitionLine ADD COLUMN C_Campaign_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 10, 2019 3:35:44 PM IST
ALTER TABLE M_RequisitionLine ADD CONSTRAINT CCampaign_MRequisitionLine FOREIGN KEY (C_Campaign_ID) REFERENCES c_campaign(c_campaign_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 10, 2019 3:36:09 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206207,'Price','Price Entered - the price based on the selected/base UoM','The price entered is converted to the actual price based on the UoM conversion',642,214082,'Y',22,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-10 15:36:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:36:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b4cf7b22-0e22-4d70-b834-a18667204ced','Y',140,2)
;

-- Oct 10, 2019 3:36:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206209,'Project','Financial Project','A Project allows you to track and control internal or external activities.',642,214084,'Y','@$Element_PJ@=Y',10,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-10 15:36:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:36:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6c97e815-c352-4579-bbcd-4b9ab07338cd','Y',160,2)
;

-- Oct 10, 2019 3:36:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206210,'Campaign','Marketing Campaign','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',642,214085,'Y','@$Element_MC@=Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f8ce586f-6fc7-44fb-9496-afb5efd678cb','Y',170,2)
;

-- Oct 10, 2019 3:40:19 PM IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-10 15:48:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206207
;

-- Oct 10, 2019 3:40:19 PM IST
UPDATE AD_Field SET SeqNo=107, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-10 15:48:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10034
;

-- Oct 10, 2019 3:47:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214086,0,'Ordered Quantity','Ordered Quantity','The Ordered Quantity indicates the quantity of a product that was ordered.',703,'QtyOrdered',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2019-10-10 15:47:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:47:26','YYYY-MM-DD HH24:MI:SS'),100,531,'Y','N','D','N','N','N','Y','01d4c6c2-3760-43d3-88fa-061c596a4970','Y',0,'N','N')
;

-- Oct 10, 2019 3:47:29 PM IST
ALTER TABLE M_RequisitionLine ADD COLUMN QtyOrdered NUMERIC DEFAULT NULL 
;

-- Oct 10, 2019 3:47:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206211,'PO Quantity','Ordered Quantity','The Ordered Quantity indicates the quantity of a product that was ordered.',642,214086,'Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-10 15:47:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:47:51','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','134dc1b6-94d4-4750-b5ee-86348a001078','Y',180,2)
;

-- Oct 10, 2019 3:48:19 PM IST
UPDATE AD_Field SET SeqNo=105, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-10 15:48:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206211
;

-- Oct 10, 2019 3:48:25 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-10 15:48:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206210
;

-- Oct 10, 2019 3:48:53 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@C_Charge_ID@>0', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-10 15:48:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56715
;

-- Oct 10, 2019 3:49:46 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200284,0,0,'Y',TO_TIMESTAMP('2019-10-10 15:49:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-10 15:49:46','YYYY-MM-DD HH24:MI:SS'),100,'Project','Financial Project','A Project allows you to track and control internal or external activities.',337,105,19,'N',0,'N','C_Project_ID','Y','D',208,'0b49487a-2ea8-4372-a7b2-a91b05cb97a8','N')
;

-- Oct 10, 2019 3:55:12 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=104, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-10 15:55:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206206
;

-- Oct 10, 2019 3:55:19 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=104, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-10 15:55:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206205
;

-- Oct 21, 2019 5:49:49 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutRequisition.qty;org.compiere.model.CalloutRequisition.amt',Updated=TO_TIMESTAMP('2019-10-21 17:49:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11493
;

-- Oct 21, 2019 5:51:34 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutRequisition.qty;org.compiere.model.CalloutRequisition.amt',Updated=TO_DATE('2019-10-21 17:51:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214086
;

-- Oct 21, 2019 5:53:22 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutRequisition.amt',Updated=TO_DATE('2019-10-21 17:53:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214082
;

-- Oct 21, 2019 6:31:50 PM IST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-21 18:31:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10034
;

-- Oct 21, 2019 8:18:33 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214102,0,'User Element List 1','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.',702,'User1_ID',22,'N','N','N','N','N',0,'N',18,134,0,0,'Y',TO_TIMESTAMP('2019-10-21 20:18:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-21 20:18:32','YYYY-MM-DD HH24:MI:SS'),100,613,'Y','N','D','N','N','N','Y','d345fd62-d1f7-4489-b504-1c402b3878f9','Y',0,'N','N','N')
;

-- Oct 21, 2019 8:18:39 PM IST
UPDATE AD_Column SET FKConstraintName='User1_MRequisition', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-21 20:18:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214102
;

-- Oct 21, 2019 8:18:39 PM IST
ALTER TABLE M_Requisition ADD COLUMN User1_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 21, 2019 8:18:39 PM IST
ALTER TABLE M_Requisition ADD CONSTRAINT User1_MRequisition FOREIGN KEY (User1_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2019 8:18:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214103,0,'User Element List 2','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.',702,'User2_ID',22,'N','N','N','N','N',0,'N',18,137,0,0,'Y',TO_TIMESTAMP('2019-10-21 20:18:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-21 20:18:50','YYYY-MM-DD HH24:MI:SS'),100,614,'Y','N','D','N','N','N','Y','60e9c252-eae1-49ea-ac24-7e60062d8cd0','Y',0,'N','N','N')
;

-- Oct 21, 2019 8:18:55 PM IST
UPDATE AD_Column SET FKConstraintName='User2_MRequisition', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-21 20:18:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214103
;

-- Oct 21, 2019 8:18:55 PM IST
ALTER TABLE M_Requisition ADD COLUMN User2_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 21, 2019 8:18:55 PM IST
ALTER TABLE M_Requisition ADD CONSTRAINT User2_MRequisition FOREIGN KEY (User2_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2019 8:19:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206289,'User Element List 1','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.',641,214102,'Y','@$Element_U1@=Y',22,210,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-21 20:19:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-21 20:19:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6d4b43a4-12b2-40e8-9ca7-4fa73f895724','Y',210,2)
;

-- Oct 21, 2019 8:19:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206290,'User Element List 2','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.',641,214103,'Y','@$Element_U2@=Y',22,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-21 20:19:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-21 20:19:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5b42bd92-724c-47e6-89c6-421b2e05997d','Y',220,2)
;

-- Oct 21, 2019 8:19:30 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-21 20:19:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206290
;

-- Oct 21, 2019 8:20:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214104,0,'User Element List 1','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.',703,'User1_ID',22,'N','N','N','N','N',0,'N',18,134,0,0,'Y',TO_TIMESTAMP('2019-10-21 20:20:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-21 20:20:09','YYYY-MM-DD HH24:MI:SS'),100,613,'Y','N','D','N','N','N','Y','fb0838b2-4eb8-4930-bdbf-943398530b86','Y',0,'N','N','N')
;

-- Oct 21, 2019 8:20:13 PM IST
UPDATE AD_Column SET FKConstraintName='User1_MRequisitionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-21 20:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214104
;

-- Oct 21, 2019 8:20:13 PM IST
ALTER TABLE M_RequisitionLine ADD COLUMN User1_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 21, 2019 8:20:14 PM IST
ALTER TABLE M_RequisitionLine ADD CONSTRAINT User1_MRequisitionLine FOREIGN KEY (User1_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2019 8:20:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214105,0,'User Element List 2','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.',703,'User2_ID',22,'N','N','N','N','N',0,'N',18,137,0,0,'Y',TO_TIMESTAMP('2019-10-21 20:20:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-21 20:20:22','YYYY-MM-DD HH24:MI:SS'),100,614,'Y','N','D','N','N','N','Y','80c308c1-a2eb-4d4b-98fd-ec4f825ffdb2','Y',0,'N','N','N')
;

-- Oct 21, 2019 8:20:27 PM IST
UPDATE AD_Column SET FKConstraintName='User2_MRequisitionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-21 20:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214105
;

-- Oct 21, 2019 8:20:27 PM IST
ALTER TABLE M_RequisitionLine ADD COLUMN User2_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 21, 2019 8:20:27 PM IST
ALTER TABLE M_RequisitionLine ADD CONSTRAINT User2_MRequisitionLine FOREIGN KEY (User2_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2019 8:21:31 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206291,'User Element List 1','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.',642,214104,'Y','@$Element_U1@=Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-21 20:21:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-21 20:21:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1d18467d-8192-4040-8d49-dcc2bafea77a','Y',190,2)
;

-- Oct 21, 2019 8:21:32 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206292,'User Element List 2','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.',642,214105,'Y','@$Element_U2@=Y',22,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-21 20:21:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-21 20:21:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4319d26f-f5fe-41b5-b215-97febff3dd58','Y',200,2)
;

-- Oct 21, 2019 8:22:01 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-21 20:22:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206292
;

-- Oct 24, 2019 12:05:00 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200285,0,0,'Y',TO_TIMESTAMP('2019-10-24 12:04:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-24 12:04:59','YYYY-MM-DD HH24:MI:SS'),100,'Campaign','Marketing Campaign','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',337,107,19,'N',0,'N','C_Campaign_ID','Y','D',550,'d72af753-9df2-4035-9cae-2f56a7145dc4','N')
;

-- Nov 14, 2019 10:30:08 AM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted) VALUES (200286,0,0,'Y',TO_TIMESTAMP('2019-11-14 10:30:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-11-14 10:30:07','YYYY-MM-DD HH24:MI:SS'),100,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',337,95,19,'N',0,'N','-1','C_Charge_ID','Y','D',968,'@M_Product__ID@=0','bf53949d-f334-4e02-ae9f-00efd2e7576e','N')
;

-- Nov 14, 2019 10:30:57 AM IST
UPDATE AD_Process_Para SET DisplayLogic='@M_Product_Category_ID@=0 & @C_Charge_ID@=0',Updated=TO_TIMESTAMP('2019-11-14 10:30:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=695
;

-- Nov 14, 2019 10:32:12 AM IST
UPDATE AD_Process_Para SET DisplayLogic='@M_Product_ID@=0 & @C_Charge_ID@=0',Updated=TO_TIMESTAMP('2019-11-14 10:32:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53322
;

-- Nov 14, 2019 10:35:50 AM IST
UPDATE AD_Process_Para SET DisplayLogic='@M_Product_ID@=0 & @M_Product_Category_ID@=0',Updated=TO_TIMESTAMP('2019-11-14 10:35:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200286
;

-- Nov 14, 2019 3:17:46 PM IST
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-11-21 15:17:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10043
;

-- Nov 14, 2019 3:18:31 PM IST
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-11-21 15:18:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13014
;

-- Jan 8, 2020 2:46:44 PM IST
UPDATE AD_Column SET IsUpdateable='Y', Callout='org.compiere.model.CalloutRequisition.qty;org.compiere.model.CalloutRequisition.amt', Updated=TO_TIMESTAMP('2020-01-08 14:46:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=57955
;

-- Jan 8, 2020 3:01:32 PM IST
UPDATE AD_Field SET IsReadOnly='N', Updated=TO_TIMESTAMP('2020-01-08 15:01:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57388
;


CREATE OR REPLACE FUNCTION uom_convertproductfrom(
    p_m_product_id  INTEGER,
    p_c_uom_to_id   INTEGER,
    p_qtyprice      NUMERIC,
    p_precision     INTEGER DEFAULT -1
) RETURNS NUMERIC AS $$

/*************************************************************************
* Title	   : Convert Product Value From Stocking UOM
* Function : uom_convertproductfrom()
* Purpose  : Converts a Qty/Price value expressed in a Product's stocking 
*            UOM (M_Product.C_UOM_ID) into a target UOM, using the rate 
*            defined in C_UOM_Conversion.
*            This is a SQL/PL-pgSQL port of iDempiere's Java utility method:
*                MUOMConversion.convertProductFrom(ctx, M_Product_ID, C_UOM_To_ID, qtyPrice, precision)
* 
* Parameters:
*   p_m_product_id : M_Product_ID of the product whose stocking UOM the 
*                    input value (p_qtyprice) is currently expressed in.
*   p_c_uom_to_id  : Target C_UOM_ID to convert the value into.
*   p_qtyprice     : The Qty or Price value to convert (in the product's stocking UOM).
*   p_precision    : Decimal places to round the result to.
*                      >= 0  -> round to that many decimal places.
*                      -1    -> round using the target UOM's StdPrecision 
*                               (default, mirrors MUOM.round() behavior).
* 
* Returns:
*   NUMERIC - the converted value, rounded per p_precision.
*   Returns the original p_qtyprice unchanged if:
*     - p_qtyprice is NULL or 0
*     - p_c_uom_to_id or p_m_product_id is NULL/0
*     - the matched conversion rate is exactly 1 (no real conversion needed)
*   Returns NULL if no active C_UOM_Conversion row is found for the 
*   product's stocking UOM -> target UOM pair (product-specific rows take 
*   priority over generic/product-independent rows).
* 
* Test:
*		SELECT uom_convertproductfrom(137, 100, 10, -1);
*
* Notes:
*   	Lookup is DIRECTION-SPECIFIC: only checks 
*		C_UOM_ID = ProductStockingUOM AND C_UOM_To_ID = p_c_uom_to_id.
*
* Contributor(s): Logilite Technologies LLP
*************************************************************************/

DECLARE
    v_product_uom_id INTEGER;
    v_rate           NUMERIC;
    v_result         NUMERIC;
    v_uom_precision  INTEGER;
BEGIN
    -- No conversion: same short-circuit conditions as the Java method
    IF p_qtyprice IS NULL 
       OR p_qtyprice = 0 
       OR p_c_uom_to_id IS NULL OR p_c_uom_to_id = 0
       OR p_m_product_id IS NULL OR p_m_product_id = 0 THEN
        RETURN p_qtyprice;
    END IF;

    -- Get product's stocking UOM (M_Product.C_UOM_ID)
    SELECT C_UOM_ID INTO v_product_uom_id 
    FROM M_Product 
    WHERE M_Product_ID = p_m_product_id;

    IF v_product_uom_id IS NULL THEN
        RETURN NULL;  -- product not found
    END IF;

    -- getProductRateFrom: direct lookup only (Product UOM -> Target UOM)
    SELECT	DivideRate INTO v_rate
    FROM C_UOM_Conversion
    WHERE C_UOM_ID    = v_product_uom_id
      AND C_UOM_To_ID  = p_c_uom_to_id
      AND IsActive     = 'Y'
      AND (M_Product_ID = p_m_product_id OR M_Product_ID IS NULL)
    ORDER BY M_Product_ID NULLS LAST   -- product-specific wins over generic
    LIMIT 1;

    IF v_rate IS NULL THEN
        RETURN NULL;
    END IF;

    -- Rate of 1 (same UOM effectively) -> return as-is
    IF v_rate = 1 THEN
        RETURN p_qtyprice;
    END IF;

    v_result := v_rate * p_qtyprice;

    IF p_precision >= 0 THEN
        RETURN ROUND(v_result, p_precision);
    ELSE
        -- precision = -1 -> round using the target UOM's StdPrecision (mirrors MUOM.round())
        SELECT StdPrecision INTO v_uom_precision 
        FROM C_UOM 
        WHERE C_UOM_ID = p_c_uom_to_id;

        IF v_uom_precision IS NOT NULL THEN
            RETURN ROUND(v_result, v_uom_precision);
        ELSE
            RETURN v_result;
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql
;


UPDATE M_RequisitionLine
SET 
	QtyOrdered	= COALESCE( uom_convertproductfrom( M_Product_ID::INTEGER, C_UOM_ID::INTEGER, Qty, 		    -1 ), Qty		  ),
	PriceActual	= COALESCE( uom_convertproductfrom( M_Product_ID::INTEGER, C_UOM_ID::INTEGER, PriceEntered, -1 ), PriceEntered)
;
