-- IDEMPIERE-6203 Costing details by Account Date
SELECT register_migration_script('202409031411_IDEMPIERE-6203.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 3, 2024, 2:11:36 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203945,0,0,'Y',TO_TIMESTAMP('2024-09-03 14:11:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:11:35','YYYY-MM-DD HH24:MI:SS'),100,'BackDateDay','Back-Date Days','Number of days to be able to post a back-date transaction (based on system date)',NULL,'Back-Date Days','D','fb543a1d-29a0-49b4-bd1a-729f104f6585')
;

-- Sep 3, 2024, 2:11:54 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216680,1,'Back-Date Days','Number of days to be able to post a back-date transaction (based on system date)',265,'BackDateDay',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2024-09-03 14:11:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:11:53','YYYY-MM-DD HH24:MI:SS'),100,203945,'Y','N','D','N','N','N','Y','fa500c1c-0086-42b7-8676-6159e78f3f7a','Y','N','N','N','N')
;

-- Sep 3, 2024, 2:12:48 PM MYT
ALTER TABLE C_AcctSchema ADD BackDateDay NUMBER(10) DEFAULT NULL 
;

-- Sep 3, 2024, 2:13:59 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208508,'Back-Date Days','Number of days to be able to post a back-date transaction (based on system date)',199,216680,'Y',22,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-09-03 14:13:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:13:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','57f104e5-573c-48f3-b900-7b7f95625650','Y',280,2)
;

-- Sep 3, 2024, 2:14:22 PM MYT
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2024-09-03 14:14:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1358
;

-- Sep 3, 2024, 2:14:23 PM MYT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2024-09-03 14:14:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12361
;

-- Sep 3, 2024, 2:14:23 PM MYT
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2024-09-03 14:14:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1360
;

-- Sep 3, 2024, 2:14:23 PM MYT
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2024-09-03 14:14:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1361
;

-- Sep 3, 2024, 2:14:24 PM MYT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2024-09-03 14:14:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1362
;

-- Sep 3, 2024, 2:14:24 PM MYT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2024-09-03 14:14:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1363
;

-- Sep 3, 2024, 2:14:24 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, XPosition=1,Updated=TO_TIMESTAMP('2024-09-03 14:14:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208508
;

-- Sep 3, 2024, 2:14:25 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-09-03 14:14:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204658
;

-- Sep 3, 2024, 2:14:41 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2024-09-03 14:14:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1351
;

-- Sep 3, 2024, 2:14:41 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2024-09-03 14:14:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2037
;

-- Sep 3, 2024, 2:14:41 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2024-09-03 14:14:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1353
;

-- Sep 3, 2024, 2:14:42 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2024-09-03 14:14:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1354
;

-- Sep 3, 2024, 2:14:42 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2024-09-03 14:14:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1352
;

-- Sep 3, 2024, 2:14:42 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2024-09-03 14:14:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1355
;

-- Sep 3, 2024, 2:14:42 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2024-09-03 14:14:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12374
;

-- Sep 3, 2024, 2:14:43 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=70,Updated=TO_TIMESTAMP('2024-09-03 14:14:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1356
;

-- Sep 3, 2024, 2:14:43 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=80,Updated=TO_TIMESTAMP('2024-09-03 14:14:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1357
;

-- Sep 3, 2024, 2:14:43 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=90,Updated=TO_TIMESTAMP('2024-09-03 14:14:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11267
;

-- Sep 3, 2024, 2:14:44 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=100,Updated=TO_TIMESTAMP('2024-09-03 14:14:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12157
;

-- Sep 3, 2024, 2:14:44 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=110,Updated=TO_TIMESTAMP('2024-09-03 14:14:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12164
;

-- Sep 3, 2024, 2:14:44 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=120,Updated=TO_TIMESTAMP('2024-09-03 14:14:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1358
;

-- Sep 3, 2024, 2:14:45 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=130,Updated=TO_TIMESTAMP('2024-09-03 14:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1360
;

-- Sep 3, 2024, 2:14:45 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=140,Updated=TO_TIMESTAMP('2024-09-03 14:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1361
;

-- Sep 3, 2024, 2:14:45 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=150,Updated=TO_TIMESTAMP('2024-09-03 14:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1362
;

-- Sep 3, 2024, 2:14:45 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=160,Updated=TO_TIMESTAMP('2024-09-03 14:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1363
;

-- Sep 3, 2024, 2:14:46 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=170,Updated=TO_TIMESTAMP('2024-09-03 14:14:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208508
;

-- Sep 3, 2024, 2:16:28 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203946,0,0,'Y',TO_TIMESTAMP('2024-09-03 14:16:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:16:27','YYYY-MM-DD HH24:MI:SS'),100,'BackDateProcessedOn','Back-Date Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.','Back-Date Processed On','D','e46b0ed3-2170-4745-8d5a-4007a881b1a4')
;

-- Sep 3, 2024, 2:16:51 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216681,0,'Back-Date Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',808,'BackDateProcessedOn',NULL,7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2024-09-03 14:16:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:16:50','YYYY-MM-DD HH24:MI:SS'),100,203946,'Y','N','D','N','N','N','N','a3e21417-629c-409e-9951-f94de7f26458','N','N','N','N','N')
;

-- Sep 3, 2024, 2:16:58 PM MYT
ALTER TABLE M_CostDetail ADD BackDateProcessedOn DATE DEFAULT NULL 
;

-- Sep 3, 2024, 2:18:16 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216682,0,'Back-Date Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',200001,'BackDateProcessedOn',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2024-09-03 14:18:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:18:16','YYYY-MM-DD HH24:MI:SS'),100,203946,'Y','N','D','N','N','N','Y','a8510710-3b14-4964-b0d1-62cbe3f986a5','Y',0,'N','N','N','N','N')
;

-- Sep 3, 2024, 2:18:24 PM MYT
ALTER TABLE M_CostHistory ADD BackDateProcessedOn DATE DEFAULT NULL 
;

-- Sep 3, 2024, 2:19:36 PM MYT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217717,'b34ef7f9-97d9-4c4f-aed6-1e0872183d13',TO_TIMESTAMP('2024-09-03 14:19:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-09-03 14:19:35','YYYY-MM-DD HH24:MI:SS'),100,200064,'BackDateProcessedOn','a.BackDateProcessedOn',380)
;

-- Sep 3, 2024, 2:23:52 PM MYT
CREATE OR REPLACE VIEW M_CostMovement_v(AD_Client_ID, AD_Org_ID, C_AcctSchema_ID, M_CostHistory_ID, M_CostType_ID, M_CostElement_ID, M_AttributeSetInstance_ID, M_Product_ID, OldQty, NewQty, OldCostPrice, NewCostPrice, OldCQty, NewCQty, OldCAmt, NewCAmt, Qty, Amt, DeltaQty, DeltaAmt, C_OrderLine_ID, M_InOutLine_ID, C_InvoiceLine_ID, M_MovementLine_ID, M_InventoryLine_ID, M_ProductionLine_ID, C_ProjectIssue_ID, M_MatchInv_ID, M_CostDetail_ID, Description, Created, CreatedBy, Updated, UpdatedBy, IsActive, DateAcct, IsBackDate, BackDateProcessedOn) AS SELECT a.ad_client_id AS AD_Client_ID, a.ad_org_id AS AD_Org_ID, b.c_acctschema_id AS C_AcctSchema_ID, a.m_costhistory_id AS M_CostHistory_ID, a.m_costtype_id AS M_CostType_ID, a.m_costelement_id AS M_CostElement_ID, a.m_attributesetinstance_id AS M_AttributeSetInstance_ID, a.m_product_id AS M_Product_ID, a.oldqty AS OldQty, a.newqty AS NewQty, a.oldcostprice AS OldCostPrice, a.newcostprice AS NewCostPrice, a.oldcqty AS OldCQty, a.newcqty AS NewCQty, a.oldcamt AS OldCAmt, a.newcamt AS NewCAmt, b.qty AS Qty, b.amt AS Amt, b.deltaqty AS DeltaQty, b.deltaamt AS DeltaAmt, b.c_orderline_id AS C_OrderLine_ID, b.m_inoutline_id AS M_InOutLine_ID, b.c_invoiceline_id AS C_InvoiceLine_ID, b.m_movementline_id AS M_MovementLine_ID, b.m_inventoryline_id AS M_InventoryLine_ID, b.m_productionline_id AS M_ProductionLine_ID, b.c_projectissue_id AS C_ProjectIssue_ID, b.m_matchinv_id AS M_MatchInv_ID, a.m_costdetail_id AS M_CostDetail_ID, b.description AS Description, a.created AS Created, a.createdby AS CreatedBy, a.updated AS Updated, a.updatedby AS UpdatedBy, a.isactive AS IsActive, a.DateAcct AS DateAcct, a.IsBackDate AS IsBackDate, a.BackDateProcessedOn AS BackDateProcessedOn FROM m_costhistory a
JOIN m_costdetail b ON a.m_costdetail_id = b.m_costdetail_id ORDER BY a.m_costhistory_id
;

-- Sep 3, 2024, 2:24:43 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216683,0.0,'Back-Date Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',200002,'BackDateProcessedOn',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-09-03 14:24:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:24:42','YYYY-MM-DD HH24:MI:SS'),100,203946,'N','N','D','N','61847599-055a-4ce3-aabd-f2e2a1657394','N','N')
;

-- Sep 3, 2024, 2:25:19 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208509,'Back-Date Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',748,216681,'Y',7,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-09-03 14:25:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:25:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e9493249-6fb3-4f57-9be4-040de444f8e3','Y',280,2)
;

-- Sep 3, 2024, 2:25:45 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, XPosition=4,Updated=TO_TIMESTAMP('2024-09-03 14:25:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208509
;

-- Sep 3, 2024, 2:25:46 PM MYT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2024-09-03 14:25:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58846
;

-- Sep 3, 2024, 2:25:46 PM MYT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2024-09-03 14:25:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58847
;

-- Sep 3, 2024, 2:25:46 PM MYT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2024-09-03 14:25:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58848
;

-- Sep 3, 2024, 2:25:47 PM MYT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2024-09-03 14:25:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58849
;

-- Sep 3, 2024, 2:26:01 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=240,Updated=TO_TIMESTAMP('2024-09-03 14:26:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208509
;

-- Sep 3, 2024, 2:26:01 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=250,Updated=TO_TIMESTAMP('2024-09-03 14:26:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58846
;

-- Sep 3, 2024, 2:26:02 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=260,Updated=TO_TIMESTAMP('2024-09-03 14:26:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58847
;

-- Sep 3, 2024, 2:26:02 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=270,Updated=TO_TIMESTAMP('2024-09-03 14:26:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58848
;

-- Sep 3, 2024, 2:26:02 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=280,Updated=TO_TIMESTAMP('2024-09-03 14:26:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58849
;

-- Sep 3, 2024, 2:26:19 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208510,'Back-Date Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',200000,216683,'Y',29,300,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-09-03 14:26:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-03 14:26:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e2b2cc9b-1d53-45fc-b58a-0685291e95f4','Y',300,2)
;

-- Sep 3, 2024, 2:27:00 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=220, XPosition=4,Updated=TO_TIMESTAMP('2024-09-03 14:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208510
;

-- Sep 3, 2024, 2:27:00 PM MYT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2024-09-03 14:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200018
;

-- Sep 3, 2024, 2:27:00 PM MYT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2024-09-03 14:27:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200017
;

-- Sep 3, 2024, 2:27:01 PM MYT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2024-09-03 14:27:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200028
;

-- Sep 3, 2024, 2:27:01 PM MYT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2024-09-03 14:27:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200030
;

-- Sep 3, 2024, 2:27:01 PM MYT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2024-09-03 14:27:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200031
;

-- Sep 3, 2024, 2:27:02 PM MYT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2024-09-03 14:27:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200033
;

-- Sep 3, 2024, 2:27:02 PM MYT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2024-09-03 14:27:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200034
;

-- Sep 3, 2024, 2:27:02 PM MYT
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2024-09-03 14:27:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202340
;

-- Sep 3, 2024, 2:27:14 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=220,Updated=TO_TIMESTAMP('2024-09-03 14:27:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208510
;

-- Sep 3, 2024, 2:27:14 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=230,Updated=TO_TIMESTAMP('2024-09-03 14:27:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200018
;

-- Sep 3, 2024, 2:27:14 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=240,Updated=TO_TIMESTAMP('2024-09-03 14:27:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200017
;

-- Sep 3, 2024, 2:27:15 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=250,Updated=TO_TIMESTAMP('2024-09-03 14:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200028
;

-- Sep 3, 2024, 2:27:15 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=260,Updated=TO_TIMESTAMP('2024-09-03 14:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200030
;

-- Sep 3, 2024, 2:27:15 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=270,Updated=TO_TIMESTAMP('2024-09-03 14:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200031
;

-- Sep 3, 2024, 2:27:16 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=280,Updated=TO_TIMESTAMP('2024-09-03 14:27:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200033
;

-- Sep 3, 2024, 2:27:16 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=290,Updated=TO_TIMESTAMP('2024-09-03 14:27:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200034
;

-- Sep 3, 2024, 2:27:16 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=300,Updated=TO_TIMESTAMP('2024-09-03 14:27:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202340
;

CREATE TABLE T_Fact_Acct_History AS SELECT * FROM Fact_Acct WHERE Fact_Acct_ID=0;

-- Sep 10, 2024, 4:50:49 PM MYT
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing,IsShowInDrillOptions,IsPartition) VALUES (200420,'Accounting Fact History','T_Fact_Acct_History',140,'3',0,0,'Y',TO_TIMESTAMP('2024-09-10 16:50:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:50:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N','Y','N','D','N','L','Y','93d29548-f01f-4761-82d2-47ec6974d402','N','Y','N')
;

-- Sep 10, 2024, 4:51:53 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216837,0.0,'Accounting Fact',200420,'Fact_Acct_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:52','YYYY-MM-DD HH24:MI:SS'),100,885,'N','N','D','N','9eb0f02d-e55f-475b-b91d-66e6123774c6','N')
;

-- Sep 10, 2024, 4:51:54 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216838,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200420,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:53','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','c63685bd-454d-46d8-b60f-139a15839bf6','N','D')
;

-- Sep 10, 2024, 4:51:55 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216839,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200420,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:54','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','02b4d562-ae82-4a29-b72c-774bd0263cb2','N','D')
;

-- Sep 10, 2024, 4:51:56 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216840,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200420,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:55','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','ff1b2b56-a6a1-45e6-af74-50f1e28e1208','N')
;

-- Sep 10, 2024, 4:51:56 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216841,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200420,'Created','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:56','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','ee92b347-031a-4e56-a3dc-363aeb808a2f','N')
;

-- Sep 10, 2024, 4:51:57 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216842,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200420,'CreatedBy',10,'N','N','N','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:56','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','425cdd74-ed7a-43a1-b2b3-3eb577d613a2','N','D')
;

-- Sep 10, 2024, 4:51:58 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216843,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200420,'Updated','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:57','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','7f6fc0e2-b166-4ee6-8174-ab1dc42c9fa8','N')
;

-- Sep 10, 2024, 4:51:59 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216844,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200420,'UpdatedBy',10,'N','N','N','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:58','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','96432306-c65a-4878-b693-e82dbb23e851','N','D')
;

-- Sep 10, 2024, 4:52:00 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216845,0.0,'Accounting Schema','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',200420,'C_AcctSchema_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:51:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:51:59','YYYY-MM-DD HH24:MI:SS'),100,181,'N','N','D','N','118a955b-674f-44c5-87a8-93c4ce387857','N','C')
;

-- Sep 10, 2024, 4:52:01 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216846,0.0,'Account','Account used','The (natural) account used',200420,'Account_ID',10,'N','N','N','N','N','N',30,132,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:00','YYYY-MM-DD HH24:MI:SS'),100,148,'N','N','D','N','e39a45b8-f4da-4a84-89d7-89f019945f50','N')
;

-- Sep 10, 2024, 4:52:01 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216847,0.0,'Transaction Date','Transaction Date','The Transaction Date indicates the date of the transaction.',200420,'DateTrx',29,'N','N','N','N','N','N',15,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:01','YYYY-MM-DD HH24:MI:SS'),100,1297,'N','N','D','N','d92892d7-7fa2-4a72-a0fe-efc4fcdfca8f','N')
;

-- Sep 10, 2024, 4:52:02 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216848,0.0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200420,'DateAcct',29,'N','N','N','N','N','N',15,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:02','YYYY-MM-DD HH24:MI:SS'),100,263,'N','N','D','N','9fa733ea-397b-4706-b1b7-5ede13f57407','N')
;

-- Sep 10, 2024, 4:52:03 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216849,0.0,'Period','Period of the Calendar','The Period indicates an exclusive range of dates for a calendar.',200420,'C_Period_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:02','YYYY-MM-DD HH24:MI:SS'),100,206,'N','N','D','N','1e7ebde6-6065-4290-bb80-eb0d585f230c','N')
;

-- Sep 10, 2024, 4:52:04 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216850,0.0,'Table','Database Table information','The Database Table provides the information of the table definition',200420,'AD_Table_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:03','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','5ea29838-4a14-430e-a1e2-9ce206e6999a','N','N')
;

-- Sep 10, 2024, 4:52:05 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216851,0.0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200420,'Record_ID',10,'N','N','N','N','N','N',200202,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:04','YYYY-MM-DD HH24:MI:SS'),100,538,'N','N','D','N','13b99b10-f8e0-4645-bbaf-cddcfa5afbe2','N','D')
;

-- Sep 10, 2024, 4:52:06 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216852,0.0,'Line ID','Transaction line ID (internal)','Internal link',200420,'Line_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:05','YYYY-MM-DD HH24:MI:SS'),100,1738,'N','N','D','N','7069501e-90fc-47d1-b1e3-86283745d9a3','N')
;

-- Sep 10, 2024, 4:52:07 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216853,0.0,'GL Category','General Ledger Category','The General Ledger Category is an optional, user defined method of grouping journal lines.',200420,'GL_Category_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:06','YYYY-MM-DD HH24:MI:SS'),100,309,'N','N','D','N','fd2c3b97-1081-45d4-a7d1-42d10421ecf1','N')
;

-- Sep 10, 2024, 4:52:08 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216854,0.0,'Budget','General Ledger Budget','The General Ledger Budget identifies a user defined budget.  These can be used in reporting as a comparison against your actual amounts.',200420,'GL_Budget_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:07','YYYY-MM-DD HH24:MI:SS'),100,308,'N','N','D','N','c6e47616-7ea7-4ecf-80a3-fa50a1dfcd51','N')
;

-- Sep 10, 2024, 4:52:09 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216855,0.0,'Tax','Tax identifier','The Tax indicates the type of tax used in document line.',200420,'C_Tax_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:08','YYYY-MM-DD HH24:MI:SS'),100,213,'N','N','D','N','464da92b-6576-4d3d-aad1-2de320b990df','N')
;

-- Sep 10, 2024, 4:52:10 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216856,0.0,'Locator','Warehouse Locator','The Locator indicates where in a Warehouse a product is located.',200420,'M_Locator_ID',10,'N','N','N','N','N','N',31,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:09','YYYY-MM-DD HH24:MI:SS'),100,448,'N','N','D','N','95b29669-9e46-4716-a31b-4f52850ed114','N')
;

-- Sep 10, 2024, 4:52:10 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216857,0.0,'Posting Type','The type of posted amount for the transaction','The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.',200420,'PostingType',1,'N','N','N','N','N','N',17,125,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:10','YYYY-MM-DD HH24:MI:SS'),100,514,'Y','N','D','N','cc7a5ff2-87d3-4c41-8752-8d820430affd','N')
;

-- Sep 10, 2024, 4:52:11 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216858,0.0,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200420,'C_Currency_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:11','YYYY-MM-DD HH24:MI:SS'),100,193,'Y','N','D','N','723389ba-13df-439b-810b-b17e032621a3','N','N')
;

-- Sep 10, 2024, 4:52:12 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216859,0.0,'Source Debit','Source Debit Amount','The Source Debit Amount indicates the credit amount for this line in the source currency.',200420,'AmtSourceDr',14,'N','N','N','N','N','N',12,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:11','YYYY-MM-DD HH24:MI:SS'),100,165,'N','N','D','N','cd3a5dae-6897-4c9a-8d69-e773cdd19e07','N')
;

-- Sep 10, 2024, 4:52:13 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216860,0.0,'Source Credit','Source Credit Amount','The Source Credit Amount indicates the credit amount for this line in the source currency.',200420,'AmtSourceCr',14,'N','N','N','N','N','N',12,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:12','YYYY-MM-DD HH24:MI:SS'),100,164,'N','N','D','N','4cdbf9d3-bc5f-45c4-8578-2740688b30cd','N')
;

-- Sep 10, 2024, 4:52:14 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216861,0.0,'Accounted Debit','Accounted Debit Amount','The Account Debit Amount indicates the transaction amount converted to this organization''s accounting currency',200420,'AmtAcctDr',14,'N','N','N','N','N','N',12,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:13','YYYY-MM-DD HH24:MI:SS'),100,162,'N','N','D','N','8a3c745a-b6f6-4666-8403-a806a75cc641','N')
;

-- Sep 10, 2024, 4:52:15 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216862,0.0,'Accounted Credit','Accounted Credit Amount','The Account Credit Amount indicates the transaction amount converted to this organization''s accounting currency',200420,'AmtAcctCr',14,'N','N','N','N','N','N',12,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:14','YYYY-MM-DD HH24:MI:SS'),100,161,'N','N','D','N','2676a809-81f6-4cf6-8f1b-531735acc5e3','N')
;

-- Sep 10, 2024, 4:52:16 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216863,0.0,'UOM','Unit of Measure','The UOM defines a unique non monetary Unit of Measure',200420,'C_UOM_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:15','YYYY-MM-DD HH24:MI:SS'),100,215,'Y','N','D','N','e9876ab8-5d6c-4a14-bd20-be26ecbeedfd','N','N')
;

-- Sep 10, 2024, 4:52:16 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216864,0.0,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',200420,'Qty',14,'N','N','N','N','N','N',29,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:16','YYYY-MM-DD HH24:MI:SS'),100,526,'Y','N','D','N','08bf51c3-0ecf-4b08-8564-a9edc566db21','N')
;

-- Sep 10, 2024, 4:52:17 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216865,0.0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200420,231,'M_Product_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:17','YYYY-MM-DD HH24:MI:SS'),100,454,'Y','N','D','N','d63864d3-35aa-4d0c-9dac-d2381d0a12ed','N','N')
;

-- Sep 10, 2024, 4:52:18 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216866,0.0,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200420,'C_BPartner_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:17','YYYY-MM-DD HH24:MI:SS'),100,187,'N','N','D','N','a90128cf-3e7f-4955-a224-8424954936f5','N')
;

-- Sep 10, 2024, 4:52:19 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216867,0.0,'Trx Organization','Performing or initiating organization','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.',200420,'AD_OrgTrx_ID',10,'N','N','N','N','N','N',18,130,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:18','YYYY-MM-DD HH24:MI:SS'),100,112,'Y','N','D','N','23cf1e57-647a-4c3f-a951-b2a08d87eacc','N','N')
;

-- Sep 10, 2024, 4:52:20 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216868,0.0,'Location From','Location that inventory was moved from','The Location From indicates the location that a product was moved from.',200420,'C_LocFrom_ID',10,'N','N','N','N','N','N',18,133,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:19','YYYY-MM-DD HH24:MI:SS'),100,200,'N','N','D','N','143a558e-08d6-4b0c-b8f5-2acd1c763f2a','N')
;

-- Sep 10, 2024, 4:52:21 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216869,0.0,'Location To','Location that inventory was moved to','The Location To indicates the location that a product was moved to.',200420,'C_LocTo_ID',10,'N','N','N','N','N','N',18,133,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:20','YYYY-MM-DD HH24:MI:SS'),100,201,'N','N','D','N','4686616a-460b-4f2d-a96b-18ce8ea57cfc','N')
;

-- Sep 10, 2024, 4:52:22 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216870,0.0,'Sales Region','Sales coverage region','The Sales Region indicates a specific area of sales coverage.',200420,'C_SalesRegion_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:21','YYYY-MM-DD HH24:MI:SS'),100,210,'Y','N','D','N','37cca086-a321-4fc6-838b-710699aa4fc8','N','N')
;

-- Sep 10, 2024, 4:52:22 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216871,0.0,'Project','Financial Project','A Project allows you to track and control internal or external activities.',200420,'C_Project_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:22','YYYY-MM-DD HH24:MI:SS'),100,208,'N','N','D','N','a078d48f-de07-4e82-8906-37b24bdec76f','N')
;

-- Sep 10, 2024, 4:52:23 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216872,0.0,'Campaign','Marketing Campaign','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',200420,'C_Campaign_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:22','YYYY-MM-DD HH24:MI:SS'),100,550,'Y','N','D','N','9285eb2f-3e83-43d3-805a-2bb4e103c411','N','N')
;

-- Sep 10, 2024, 4:52:24 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216873,0.0,'Activity','Business Activity','Activities indicate tasks that are performed and used to utilize Activity based Costing',200420,'C_Activity_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:23','YYYY-MM-DD HH24:MI:SS'),100,1005,'Y','N','D','N','900fc691-dd02-4aa7-9592-074fda5da066','N','N')
;

-- Sep 10, 2024, 4:52:25 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216874,0.0,'User Element List 1','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.',200420,'User1_ID',10,'N','N','N','N','N','N',30,134,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:24','YYYY-MM-DD HH24:MI:SS'),100,613,'Y','N','D','N','41856917-29a4-4e1f-a6b0-7a6d41e21fc8','N','N')
;

-- Sep 10, 2024, 4:52:26 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216875,0.0,'User Element List 2','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.',200420,'User2_ID',10,'N','N','N','N','N','N',30,137,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:25','YYYY-MM-DD HH24:MI:SS'),100,614,'Y','N','D','N','cc202b69-8a09-4bce-9404-55ad5398d17e','N','N')
;

-- Sep 10, 2024, 4:52:27 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (216876,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200420,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:26','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','ebbda095-3129-4385-a1f6-0842e504b33d',10,'N')
;

-- Sep 10, 2024, 4:52:27 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216877,0.0,'Asset','Asset used internally or by customers','An asset is either created by purchasing or by delivering a product.  An asset can be used internally or be a customer asset.',200420,'A_Asset_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:27','YYYY-MM-DD HH24:MI:SS'),100,1884,'Y','N','D','N','1336c7e7-9b3d-4430-9d08-59562799921d','N','N')
;

-- Sep 10, 2024, 4:52:28 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216878,0.0,'Sub Account','Sub account for Element Value','The Element Value (e.g. Account) may have optional sub accounts for further detail. The sub account is dependent on the value of the account, so a further specification. If the sub-accounts are more or less the same, consider using another accounting dimension.',200420,'C_SubAcct_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:27','YYYY-MM-DD HH24:MI:SS'),100,2876,'N','N','D','N','b8b748e8-6a9a-49ee-ad63-8a80312b1e3e','N')
;

-- Sep 10, 2024, 4:52:29 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216879,0.0,'User Column 1','User defined accounting Element','A user defined accounting element refers to an iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200420,'UserElement1_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:28','YYYY-MM-DD HH24:MI:SS'),100,2877,'Y','N','D','N','55391651-09b1-42c1-b63f-92a52900d095','N')
;

-- Sep 10, 2024, 4:52:30 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216880,0.0,'User Column 2','User defined accounting Element','A user defined accounting element refers to an iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested) ',200420,'UserElement2_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:29','YYYY-MM-DD HH24:MI:SS'),100,2878,'Y','N','D','N','2f68852d-c77c-4431-85b9-818771cd99f7','N')
;

-- Sep 10, 2024, 4:52:31 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216881,0.0,'Project Phase','Phase of a Project',200420,'C_ProjectPhase_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:30','YYYY-MM-DD HH24:MI:SS'),100,2073,'N','N','D','N','b2656475-eb94-4d7e-8b86-9d01187a0384','N')
;

-- Sep 10, 2024, 4:52:32 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216882,0.0,'Project Task','Actual Project Task in a Phase','A Project Task in a Project Phase represents the actual work.',200420,'C_ProjectTask_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:31','YYYY-MM-DD HH24:MI:SS'),100,2074,'N','N','D','N','e082c8a2-3f94-4cea-af7d-50be88caa7de','N')
;

-- Sep 10, 2024, 4:52:33 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216883,0.0,'Fact_Acct_UU',200420,'Fact_Acct_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2024-09-10 16:52:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 16:52:32','YYYY-MM-DD HH24:MI:SS'),100,54893,'Y','N','D','N','c42c7a98-1de0-44b6-9165-e96c976c06b5','N','N')
;

-- Sep 10, 2024, 4:53:32 PM MYT
UPDATE AD_Column SET AD_Reference_ID=13, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2024-09-10 16:53:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216837
;

-- Sep 10, 2024, 4:53:51 PM MYT
ALTER TABLE T_Fact_Acct_History MODIFY Fact_Acct_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 10, 2024, 5:38:59 PM MYT
INSERT INTO AD_HouseKeeping (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,AD_HouseKeeping_ID,Name,Updated,UpdatedBy,Value,LastDeleted,IsExportXMLBackup,IsSaveInHistoric,Processing,WhereClause,AD_Table_ID,AD_HouseKeeping_UU) VALUES (0,0,TO_TIMESTAMP('2024-09-10 17:38:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',200000,'Delete T_Fact_Acct_History records preserving last week',TO_TIMESTAMP('2024-09-10 17:38:58','YYYY-MM-DD HH24:MI:SS'),100,'T_Fact_Acct_History',0,'N','N','N','Updated <= SYSDATE - 7',200420,'8b5b1aa0-13c4-4d7a-8035-c416470fb0ca')
;

-- Sep 10, 2024, 5:42:00 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Back-Date transaction not allowed',0,0,'Y',TO_TIMESTAMP('2024-09-10 17:42:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-10 17:42:00','YYYY-MM-DD HH24:MI:SS'),100,200903,'BackDateTrxNotAllowed','D','6cf49870-488d-4f67-9fec-d369186ccbc2')
;

