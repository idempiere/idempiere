SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-6155 Add Invoice Vendor support in Issue Project Process
-- 23-May-2024, 6:39:07 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200190,'Invoice Line','Vendor Invoice Line as Document Completed or Closed','S','C_InvoiceLine.C_InvoiceLine_ID In (SELECT cil.C_InvoiceLine_ID FROM C_InvoiceLine cil LEFT Join C_Invoice ci On ci.C_Invoice_ID=cil.C_Invoice_ID Where ci.DocStatus In ( ''CL'', ''CO'') And ci.IsSOTrx=''N'' And cil.C_Charge_ID IS Not Null Minus Select C_InvoiceLine_ID FROM C_ProjectIssue)',0,0,'Y',TO_DATE('2024-05-23 18:39:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-23 18:39:06','YYYY-MM-DD HH24:MI:SS'),100,'D','ab71eb7a-e64d-4c68-887e-14b46a3809c1')
;

-- 23-May-2024, 6:43:00 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200483,0,0,'Y',TO_DATE('2024-05-23 18:42:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-23 18:42:59','YYYY-MM-DD HH24:MI:SS'),100,'Invoice Line','Invoice Detail Line','The Invoice Line uniquely identifies a single line of an Invoice.',224,35,19,'N',200190,0,'N','C_InvoiceLine_ID','Y','D',1076,'5021cb15-2b9e-428b-ac02-0bb4d27c3fdf','N')
;

-- 23-May-2024, 6:44:29 PM IST
UPDATE AD_Process SET Help='Select a project and one of the following items to process
<br>- Material Receipt
<br>- Expense Report
<br>- Vendor Invoice Line
<br>- Inventory Location and Project Line Which is not issued yet
<br>- Inventory Location, Product and Quantity
<br>- The default Movement Date is today''s date.',Updated=TO_DATE('2024-05-23 18:44:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=224
;

-- May 27, 2024, 4:10:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216608,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',623,'C_Charge_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2024-05-27 16:10:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-27 16:10:10','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','N','N','Y','faad5d09-99a7-4c22-8a47-2a7769872d5c','Y',0,'N','N','N')
;

-- May 27, 2024, 4:10:53 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216609,0,'Invoice Line','Invoice Detail Line','The Invoice Line uniquely identifies a single line of an Invoice.',623,'C_InvoiceLine_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2024-05-27 16:10:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-27 16:10:52','YYYY-MM-DD HH24:MI:SS'),100,1076,'N','N','D','N','N','N','Y','379fb39b-67aa-47bf-a289-bfd62d5c6f34','Y',0,'N','N','N','N')
;

-- May 27, 2024, 4:11:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (216610,0,'Amount','Amount','Amount',623,'Amt',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_DATE('2024-05-27 16:11:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-27 16:11:11','YYYY-MM-DD HH24:MI:SS'),100,160,'Y','N','D','N','N','N','Y','c897c6fc-1f32-457c-ae6d-72b5b812a500','Y',0,'N','N','N')
;

-- May 27, 2024, 4:11:22 PM IST
ALTER TABLE C_ProjectIssue ADD Amt NUMBER DEFAULT NULL
;

-- May 27, 2024, 4:11:27 PM IST
UPDATE AD_Column SET FKConstraintName='CCharge_CProjectIssue', FKConstraintType='N',Updated=TO_DATE('2024-05-27 16:11:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216608
;

-- May 27, 2024, 4:11:27 PM IST
ALTER TABLE C_ProjectIssue ADD C_Charge_ID NUMBER(10) DEFAULT NULL
;

-- May 27, 2024, 4:11:27 PM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT CCharge_CProjectIssue FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 27, 2024, 4:11:31 PM IST
UPDATE AD_Column SET FKConstraintName='cinvoiceline_cprojectissue', FKConstraintType='N',Updated=TO_DATE('2024-05-27 16:11:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216609
;

-- May 27, 2024, 4:11:31 PM IST
ALTER TABLE C_ProjectIssue MODIFY C_InvoiceLine_ID NUMBER(10) DEFAULT NULL
;

-- May 27, 2024, 4:11:31 PM IST
ALTER TABLE C_ProjectIssue ADD CONSTRAINT CInvoiceLine_CProjectIssue FOREIGN KEY (C_InvoiceLine_ID) REFERENCES c_invoiceline(c_invoiceline_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 27, 2024, 4:12:12 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208489,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',558,216608,'Y',10,180,'N','N','N','N',0,0,'Y',TO_DATE('2024-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e7bf21ed-15ae-4ddc-929d-7c9a6fba5ef3','Y',180,2)
;

-- May 27, 2024, 4:12:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208490,'Invoice Line','Invoice Detail Line','The Invoice Line uniquely identifies a single line of an Invoice.',558,216609,'Y',22,190,'N','N','N','N',0,0,'Y',TO_DATE('2024-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5dd58128-ea00-4d31-b4ef-ccbf08f1dc8c','Y',190,2)
;

-- May 27, 2024, 4:12:14 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208491,'Amount','Amount','Amount',558,216610,'Y',22,200,'N','N','N','N',0,0,'Y',TO_DATE('2024-05-27 16:12:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-05-27 16:12:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6ece669f-4aa1-4e71-b0b5-79403751aa84','Y',200,2)
;

-- May 27, 2024, 4:13:18 PM IST
UPDATE AD_Field SET SeqNo=115, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=115, IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8217
;

-- May 27, 2024, 4:14:12 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=110, IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:14:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- May 27, 2024, 4:14:23 PM IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:14:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- May 27, 2024, 4:14:42 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:14:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- May 27, 2024, 4:15:14 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@M_Product_ID@!0', IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:15:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- May 27, 2024, 4:15:28 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@C_Charge_ID@!0', IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:15:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8223
;

-- May 27, 2024, 4:15:41 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@M_Product_ID@>0', IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:15:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8225
;

-- May 27, 2024, 4:17:34 PM IST
UPDATE AD_Field SET SeqNo=154, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=154, IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:17:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208490
;

-- May 27, 2024, 4:18:04 PM IST
UPDATE AD_Field SET SeqNo=157, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=157, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2024-05-27 16:18:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208491
;

UPDATE AD_Column SET IsMandatory='N', MandatoryLogic='@M_Product_ID@>0',Updated=TO_DATE('2024-05-28 12:55:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9854
;

-- May 28, 2024, 12:56:00 PM IST
ALTER TABLE C_ProjectIssue MODIFY M_Locator_ID NUMBER(10) DEFAULT NULL
;

-- May 28, 2024, 12:56:00 PM IST
ALTER TABLE C_ProjectIssue MODIFY M_Locator_ID NULL
;

-- May 28, 2024, 12:56:24 PM IST
UPDATE AD_Column SET IsMandatory='N', MandatoryLogic='@C_Charge_ID@!0',Updated=TO_DATE('2024-05-28 12:56:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9852
;

-- May 28, 2024, 12:56:26 PM IST
ALTER TABLE C_ProjectIssue MODIFY M_Product_ID NUMBER(10) DEFAULT NULL
;

-- May 28, 2024, 12:56:26 PM IST
ALTER TABLE C_ProjectIssue MODIFY M_Product_ID NULL
;

-- May 28, 2024, 6:11:14 PM IST
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=8212
;

-- May 28, 2024, 6:13:17 PM IST
UPDATE AD_Field SET SeqNo=135, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=135, IsToolbarButton=NULL,Updated=TO_DATE('2024-05-28 18:13:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8212
;

-- Update Reference Id for Invoice Parameter of Issue Project Process
-- Jun 5, 2024, 7:03:56 PM IST
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_DATE('2024-06-05 19:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200483
;

-- Jun 10, 2024, 10:44:09 AM IST
UPDATE AD_Val_Rule SET Code='C_InvoiceLine.C_InvoiceLine_ID In ((SELECT cil.C_InvoiceLine_ID from C_InvoiceLine cil Inner Join C_Invoice ci On ci.C_Invoice_ID=cil.C_Invoice_ID Where ci.DocStatus In ( ''CL'', ''CO'') And ci.IsSOTrx=''N'' And cil.C_Charge_ID Is Not Null And cil.A_CreateAsset!=''Y'') Minus (SELECT DISTINCT C_INVOICELINE_ID from C_PROJECTISSUE Where C_INVOICELINE_ID Is Not Null))',Updated=TO_DATE('2024-06-10 10:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200190
;

-- Jun 7, 2024, 5:46:39 PM IST
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_DATE('2024-06-07 17:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200483
;

-- Jul 16, 2024, 6:49:53 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@C_Charge_ID@=0', IsToolbarButton=NULL,Updated=TO_DATE('2024-07-16 18:49:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8223
;

-- Jul 16, 2024, 6:49:59 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@M_Product_ID@=0 ', IsToolbarButton=NULL,Updated=TO_DATE('2024-07-16 18:49:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- Jun 25, 2025, 11:25:37 AM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_InvoiceLine_ID@ > 0 | @M_InOutLine_ID@ > 0 | @C_Charge_ID@ > 0', IsToolbarButton=NULL,Updated=TO_DATE('2025-06-25 11:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8223
;

-- Jun 25, 2025, 11:25:44 AM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@C_InvoiceLine_ID@ > 0 | @M_InOutLine_ID@ > 0 | @M_Product_ID@ > 0', IsToolbarButton=NULL,Updated=TO_DATE('2025-06-25 11:25:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208489
;

-- Jun 25, 2025, 4:16:13 PM IST
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_DATE('2025-06-25 16:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216609
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=4,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8217
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8218
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8216
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8236
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8235
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=1,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208490
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206738
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206739
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, XPosition=1,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208491
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, XPosition=5,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8219
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8215
;

-- Oct 10, 2025, 7:28:33 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-10-10 19:28:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204793
;

-- Oct 15, 2025, 7:49:37 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Locator is not present on Project Issue: {0}',0,0,'Y',TO_TIMESTAMP('2025-10-15 19:49:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-15 19:49:36','YYYY-MM-DD HH24:MI:SS'),100,200971,'LocatorMandatoryProjIssue','D','ebee4bf9-c37c-49c6-a1f1-2d4611d375c3')
;

-- Oct 16, 2025, 10:58:57 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Project Line delete for Project Issue ( {0} )',0,0,'Y',TO_TIMESTAMP('2025-10-16 10:58:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 10:58:56','YYYY-MM-DD HH24:MI:SS'),100,200972,'ProjectLineDelete','D','639d12ea-5911-4ec3-8c83-ecc49a61deb3')
;

-- Oct 16, 2025, 10:59:51 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Project Issue is not complete',0,0,'Y',TO_TIMESTAMP('2025-10-16 10:59:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 10:59:50','YYYY-MM-DD HH24:MI:SS'),100,200973,'ProjectIssueError','D','56904feb-ee7c-4a5a-a95a-ec62ea4ad118')
;

-- Oct 16, 2025, 11:01:16 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invoice Line:{0} Reference Present in Project Issue : {1}',0,0,'Y',TO_TIMESTAMP('2025-10-16 11:01:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 11:01:15','YYYY-MM-DD HH24:MI:SS'),100,200974,'InvLineRefProjeIssue','D','6e297e86-456e-4015-97c4-da303b98cb7e')
;

-- Oct 16, 2025, 11:04:03 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invoice Line is invalid - {0}',0,0,'Y',TO_TIMESTAMP('2025-10-16 11:04:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 11:04:02','YYYY-MM-DD HH24:MI:SS'),100,200975,'InvoiceLineInvalid','D','592ba0c0-af56-49f7-ae9b-be1478bd138d')
;

-- Oct 16, 2025, 11:06:20 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Invoice Line is invalid ( {0} ). Invoice Line Must be Closed or Completed',0,0,'Y',TO_TIMESTAMP('2025-10-16 11:06:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 11:06:19','YYYY-MM-DD HH24:MI:SS'),100,200976,'InvoiceLineMandatoryCOCL','D','50e1b23e-d352-4a63-98e4-1c6b583f2342')
;

-- Oct 16, 2025, 11:07:35 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invoice Line is created for another Project ( {0} )',0,0,'Y',TO_TIMESTAMP('2025-10-16 11:07:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 11:07:34','YYYY-MM-DD HH24:MI:SS'),100,200977,'InvoiceLineAnotherProject','D','db59e929-b7d6-455e-9e49-13d354424d3e')
;

-- Oct 16, 2025, 11:09:40 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invoice line ( {0} ) missing charge.',0,0,'Y',TO_TIMESTAMP('2025-10-16 11:09:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 11:09:39','YYYY-MM-DD HH24:MI:SS'),100,200978,'InvoiceLineNeedsCharge','D','4fb0e9af-d9a9-4e1b-92f4-6991dccfcfa5')
;

-- Oct 16, 2025, 11:11:03 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Invoice line ( {0} ) missing Invoice Quantity.',0,0,'Y',TO_TIMESTAMP('2025-10-16 11:11:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 11:11:02','YYYY-MM-DD HH24:MI:SS'),100,200979,'InvoiceLineNeedsQuantity','D','72a48bf7-41e3-480c-af1e-5613179d1a11')
;

-- Oct 16, 2025, 11:13:59 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Project Issue is already created for {0}',0,0,'Y',TO_TIMESTAMP('2025-10-16 11:13:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-16 11:13:58','YYYY-MM-DD HH24:MI:SS'),100,200980,'ProjectIssueUsedInvLine','D','cd993a14-1e25-4b30-8957-fa6e733cc845')
;

SELECT register_migration_script('202405231900_IDEMPIERE-6155.sql') FROM dual
;
