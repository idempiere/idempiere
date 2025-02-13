-- IDEMPIERE-6203 Costing details by Account Date
SELECT register_migration_script('202408051548_IDEMPIERE-6203.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 5, 2024, 3:50:45 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216621,0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',808,'DateAcct',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2024-08-05 15:50:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 15:50:44','YYYY-MM-DD HH24:MI:SS'),100,263,'N','N','D','N','N','N','Y','e8e81f27-a584-4d8c-8f8b-0121f139145d','Y',0,'N','N','N','N')
;

-- Aug 5, 2024, 3:50:57 PM MYT
ALTER TABLE M_CostDetail ADD DateAcct DATE DEFAULT NULL 
;

-- Aug 5, 2024, 3:51:59 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216622,0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200001,'DateAcct',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2024-08-05 15:51:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 15:51:59','YYYY-MM-DD HH24:MI:SS'),100,263,'N','N','D','N','N','N','Y','075b7fba-53f8-4237-b6e8-85dbbe1a5251','Y',0,'N','N','N','N')
;

-- Aug 5, 2024, 3:52:07 PM MYT
ALTER TABLE M_CostHistory ADD DateAcct DATE DEFAULT NULL 
;

-- Aug 5, 2024, 3:52:43 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203939,0,0,'Y',TO_TIMESTAMP('2024-08-05 15:52:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 15:52:43','YYYY-MM-DD HH24:MI:SS'),100,'IsBackDate','Back-Date','Back-Date','D','14cb7ab8-8f1e-429b-882a-b9d80078558a')
;

-- Aug 5, 2024, 3:53:38 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216623,0,'Back-Date',200001,'IsBackDate','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-08-05 15:53:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 15:53:37','YYYY-MM-DD HH24:MI:SS'),100,203939,'Y','N','D','N','N','N','Y','6e75599d-d2a5-46e8-a89b-319584a3b6c8','Y',0,'N','N','N','N')
;

-- Aug 5, 2024, 3:53:45 PM MYT
ALTER TABLE M_CostHistory ADD IsBackDate CHAR(1) DEFAULT 'N' CHECK (IsBackDate IN ('Y','N')) NOT NULL
;

-- Aug 5, 2024, 3:54:02 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216624,0,'Back-Date',808,'IsBackDate','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-08-05 15:54:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 15:54:01','YYYY-MM-DD HH24:MI:SS'),100,203939,'Y','N','D','N','N','N','Y','b30d05bf-2d7f-4d05-8f6a-000a6f824f68','Y',0,'N','N','N','N','N')
;

-- Aug 5, 2024, 3:54:11 PM MYT
ALTER TABLE M_CostDetail ADD IsBackDate CHAR(1) DEFAULT 'N' CHECK (IsBackDate IN ('Y','N')) NOT NULL
;

UPDATE M_CostDetail SET DateAcct=TRUNC(Created) WHERE DateAcct IS NULL;

UPDATE M_CostHistory SET DateAcct=TRUNC(Created) WHERE DateAcct IS NULL;

-- Aug 5, 2024, 3:57:52 PM MYT
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-08-05 15:57:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216622
;

-- Aug 5, 2024, 3:58:10 PM MYT
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2024-08-05 15:58:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216622
;

-- Aug 5, 2024, 3:58:16 PM MYT
ALTER TABLE M_CostHistory MODIFY DateAcct DATE
;

-- Aug 5, 2024, 3:58:16 PM MYT
ALTER TABLE M_CostHistory MODIFY DateAcct NOT NULL
;

-- Aug 5, 2024, 3:58:26 PM MYT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2024-08-05 15:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216621
;

-- Aug 5, 2024, 3:58:32 PM MYT
ALTER TABLE M_CostDetail MODIFY DateAcct DATE
;

-- Aug 5, 2024, 3:58:32 PM MYT
ALTER TABLE M_CostDetail MODIFY DateAcct NOT NULL
;

-- Aug 5, 2024, 3:59:30 PM MYT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-08-05 15:59:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216621
;

-- Aug 5, 2024, 3:59:38 PM MYT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2024-08-05 15:59:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216622
;

-- Aug 5, 2024, 4:02:20 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208499,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',748,216621,'Y',7,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-08-05 16:02:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 16:02:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6fb91747-a5d0-4028-85db-e613bba099f4','Y',270,2)
;

-- Aug 5, 2024, 4:02:21 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208500,'Back-Date',748,216624,'Y',1,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-08-05 16:02:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 16:02:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','96f68440-936c-4e83-99f3-4f9dc4560085','Y',280,2,2)
;

-- Aug 5, 2024, 4:04:11 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=1,Updated=TO_TIMESTAMP('2024-08-05 16:04:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208499
;

-- Aug 5, 2024, 4:04:11 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=5,Updated=TO_TIMESTAMP('2024-08-05 16:04:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208500
;

-- Aug 5, 2024, 4:04:11 PM MYT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2024-08-05 16:04:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12177
;

-- Aug 5, 2024, 4:04:11 PM MYT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2024-08-05 16:04:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12151
;

-- Aug 5, 2024, 4:04:12 PM MYT
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2024-08-05 16:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12156
;

-- Aug 5, 2024, 4:04:12 PM MYT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2024-08-05 16:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12342
;

-- Aug 5, 2024, 4:04:12 PM MYT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2024-08-05 16:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12343
;

-- Aug 5, 2024, 4:04:13 PM MYT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2024-08-05 16:04:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12345
;

-- Aug 5, 2024, 4:04:13 PM MYT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2024-08-05 16:04:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12344
;

-- Aug 5, 2024, 4:04:13 PM MYT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2024-08-05 16:04:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12346
;

-- Aug 5, 2024, 4:04:13 PM MYT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2024-08-05 16:04:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12153
;

-- Aug 5, 2024, 4:04:14 PM MYT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2024-08-05 16:04:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58846
;

-- Aug 5, 2024, 4:04:14 PM MYT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2024-08-05 16:04:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58847
;

-- Aug 5, 2024, 4:04:14 PM MYT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2024-08-05 16:04:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58848
;

-- Aug 5, 2024, 4:04:14 PM MYT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2024-08-05 16:04:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58849
;

-- Aug 5, 2024, 4:04:15 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-08-05 16:04:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204879
;

-- Aug 5, 2024, 4:04:43 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2024-08-05 16:04:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12149
;

-- Aug 5, 2024, 4:04:43 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2024-08-05 16:04:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12152
;

-- Aug 5, 2024, 4:04:44 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2024-08-05 16:04:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12145
;

-- Aug 5, 2024, 4:04:44 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2024-08-05 16:04:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12163
;

-- Aug 5, 2024, 4:04:44 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2024-08-05 16:04:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12154
;

-- Aug 5, 2024, 4:04:45 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2024-08-05 16:04:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12148
;

-- Aug 5, 2024, 4:04:45 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2024-08-05 16:04:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12317
;

-- Aug 5, 2024, 4:04:45 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=70,Updated=TO_TIMESTAMP('2024-08-05 16:04:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12155
;

-- Aug 5, 2024, 4:04:45 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=80,Updated=TO_TIMESTAMP('2024-08-05 16:04:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12147
;

-- Aug 5, 2024, 4:04:46 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=90,Updated=TO_TIMESTAMP('2024-08-05 16:04:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12341
;

-- Aug 5, 2024, 4:04:46 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=100,Updated=TO_TIMESTAMP('2024-08-05 16:04:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12340
;

-- Aug 5, 2024, 4:04:46 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=110,Updated=TO_TIMESTAMP('2024-08-05 16:04:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12150
;

-- Aug 5, 2024, 4:04:46 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=120,Updated=TO_TIMESTAMP('2024-08-05 16:04:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12328
;

-- Aug 5, 2024, 4:04:47 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=130,Updated=TO_TIMESTAMP('2024-08-05 16:04:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208499
;

-- Aug 5, 2024, 4:04:47 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=140,Updated=TO_TIMESTAMP('2024-08-05 16:04:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208500
;

-- Aug 5, 2024, 4:04:47 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=150,Updated=TO_TIMESTAMP('2024-08-05 16:04:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12177
;

-- Aug 5, 2024, 4:04:47 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=160,Updated=TO_TIMESTAMP('2024-08-05 16:04:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12151
;

-- Aug 5, 2024, 4:04:48 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=170,Updated=TO_TIMESTAMP('2024-08-05 16:04:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12156
;

-- Aug 5, 2024, 4:04:48 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=180,Updated=TO_TIMESTAMP('2024-08-05 16:04:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12342
;

-- Aug 5, 2024, 4:04:48 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=190,Updated=TO_TIMESTAMP('2024-08-05 16:04:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12343
;

-- Aug 5, 2024, 4:04:48 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=200,Updated=TO_TIMESTAMP('2024-08-05 16:04:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12345
;

-- Aug 5, 2024, 4:04:49 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=210,Updated=TO_TIMESTAMP('2024-08-05 16:04:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12344
;

-- Aug 5, 2024, 4:04:49 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=220,Updated=TO_TIMESTAMP('2024-08-05 16:04:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12346
;

-- Aug 5, 2024, 4:04:49 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=230,Updated=TO_TIMESTAMP('2024-08-05 16:04:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12153
;

-- Aug 5, 2024, 4:04:50 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=240,Updated=TO_TIMESTAMP('2024-08-05 16:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58846
;

-- Aug 5, 2024, 4:04:50 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=250,Updated=TO_TIMESTAMP('2024-08-05 16:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58847
;

-- Aug 5, 2024, 4:04:50 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=260,Updated=TO_TIMESTAMP('2024-08-05 16:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58848
;

-- Aug 5, 2024, 4:04:50 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=270,Updated=TO_TIMESTAMP('2024-08-05 16:04:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58849
;

-- Aug 5, 2024, 4:07:02 PM MYT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217714,'92bc1465-6512-41ff-92f1-b47808928ea7',TO_TIMESTAMP('2024-08-05 16:07:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-08-05 16:07:01','YYYY-MM-DD HH24:MI:SS'),100,200064,'DateAcct','a.DateAcct',360)
;

-- Aug 5, 2024, 4:07:15 PM MYT
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217715,'eaae7e4d-dc38-48cd-9935-b69e8112c802',TO_TIMESTAMP('2024-08-05 16:07:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-08-05 16:07:14','YYYY-MM-DD HH24:MI:SS'),100,200064,'IsBackDate','a.IsBackDate',370)
;

-- Aug 5, 2024, 4:07:30 PM MYT
CREATE OR REPLACE VIEW M_CostMovement_v(AD_Client_ID, AD_Org_ID, C_AcctSchema_ID, M_CostHistory_ID, M_CostType_ID, M_CostElement_ID, M_AttributeSetInstance_ID, M_Product_ID, OldQty, NewQty, OldCostPrice, NewCostPrice, OldCQty, NewCQty, OldCAmt, NewCAmt, Qty, Amt, DeltaQty, DeltaAmt, C_OrderLine_ID, M_InOutLine_ID, C_InvoiceLine_ID, M_MovementLine_ID, M_InventoryLine_ID, M_ProductionLine_ID, C_ProjectIssue_ID, M_MatchInv_ID, M_CostDetail_ID, Description, Created, CreatedBy, Updated, UpdatedBy, IsActive, DateAcct, IsBackDate) AS SELECT a.ad_client_id AS AD_Client_ID, a.ad_org_id AS AD_Org_ID, b.c_acctschema_id AS C_AcctSchema_ID, a.m_costhistory_id AS M_CostHistory_ID, a.m_costtype_id AS M_CostType_ID, a.m_costelement_id AS M_CostElement_ID, a.m_attributesetinstance_id AS M_AttributeSetInstance_ID, a.m_product_id AS M_Product_ID, a.oldqty AS OldQty, a.newqty AS NewQty, a.oldcostprice AS OldCostPrice, a.newcostprice AS NewCostPrice, a.oldcqty AS OldCQty, a.newcqty AS NewCQty, a.oldcamt AS OldCAmt, a.newcamt AS NewCAmt, b.qty AS Qty, b.amt AS Amt, b.deltaqty AS DeltaQty, b.deltaamt AS DeltaAmt, b.c_orderline_id AS C_OrderLine_ID, b.m_inoutline_id AS M_InOutLine_ID, b.c_invoiceline_id AS C_InvoiceLine_ID, b.m_movementline_id AS M_MovementLine_ID, b.m_inventoryline_id AS M_InventoryLine_ID, b.m_productionline_id AS M_ProductionLine_ID, b.c_projectissue_id AS C_ProjectIssue_ID, b.m_matchinv_id AS M_MatchInv_ID, a.m_costdetail_id AS M_CostDetail_ID, b.description AS Description, a.created AS Created, a.createdby AS CreatedBy, a.updated AS Updated, a.updatedby AS UpdatedBy, a.isactive AS IsActive, a.DateAcct AS DateAcct, a.IsBackDate AS IsBackDate FROM m_costhistory a
JOIN m_costdetail b ON a.m_costdetail_id = b.m_costdetail_id ORDER BY a.m_costhistory_id
;

-- Aug 5, 2024, 4:08:22 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216625,0.0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200002,'DateAcct',29,'N','N','N','N','N','N',15,0,0,'Y',TO_TIMESTAMP('2024-08-05 16:08:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 16:08:20','YYYY-MM-DD HH24:MI:SS'),100,263,'N','N','D','N','bc497c4f-9267-4b27-a7eb-99b2b7a4a9bc','N')
;

-- Aug 5, 2024, 4:08:23 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (216626,0.0,'Back-Date',200002,'IsBackDate','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2024-08-05 16:08:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 16:08:22','YYYY-MM-DD HH24:MI:SS'),100,203939,'N','N','D','N','6cba3aa4-4fa3-4d0c-aba3-b3f83e880f4e','N','N')
;

-- Aug 5, 2024, 4:09:20 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208501,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200000,216625,'Y',29,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-08-05 16:09:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 16:09:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c0405016-1138-4a9b-8d13-5afea839dde4','Y',280,2)
;

-- Aug 5, 2024, 4:09:20 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208502,'Back-Date',200000,216626,'Y',1,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-08-05 16:09:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-08-05 16:09:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8f0c2805-5aaa-49dd-a9d5-03052faeadc6','Y',290,2,2)
;

-- Aug 5, 2024, 4:10:35 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=200, XPosition=1,Updated=TO_TIMESTAMP('2024-08-05 16:10:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208501
;

-- Aug 5, 2024, 4:10:36 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, XPosition=5,Updated=TO_TIMESTAMP('2024-08-05 16:10:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208502
;

-- Aug 5, 2024, 4:10:36 PM MYT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2024-08-05 16:10:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200018
;

-- Aug 5, 2024, 4:10:36 PM MYT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2024-08-05 16:10:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200017
;

-- Aug 5, 2024, 4:10:36 PM MYT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2024-08-05 16:10:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200028
;

-- Aug 5, 2024, 4:10:37 PM MYT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2024-08-05 16:10:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200030
;

-- Aug 5, 2024, 4:10:37 PM MYT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2024-08-05 16:10:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200031
;

-- Aug 5, 2024, 4:10:37 PM MYT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2024-08-05 16:10:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200033
;

-- Aug 5, 2024, 4:10:38 PM MYT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2024-08-05 16:10:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200034
;

-- Aug 5, 2024, 4:10:38 PM MYT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2024-08-05 16:10:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202340
;

-- Aug 5, 2024, 4:10:55 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=200,Updated=TO_TIMESTAMP('2024-08-05 16:10:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208501
;

-- Aug 5, 2024, 4:10:55 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=210,Updated=TO_TIMESTAMP('2024-08-05 16:10:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208502
;

-- Aug 5, 2024, 4:10:56 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=220,Updated=TO_TIMESTAMP('2024-08-05 16:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200018
;

-- Aug 5, 2024, 4:10:56 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=230,Updated=TO_TIMESTAMP('2024-08-05 16:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200017
;

-- Aug 5, 2024, 4:10:56 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=240,Updated=TO_TIMESTAMP('2024-08-05 16:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200028
;

-- Aug 5, 2024, 4:10:56 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=250,Updated=TO_TIMESTAMP('2024-08-05 16:10:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200030
;

-- Aug 5, 2024, 4:10:57 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=260,Updated=TO_TIMESTAMP('2024-08-05 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200031
;

-- Aug 5, 2024, 4:10:57 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=270,Updated=TO_TIMESTAMP('2024-08-05 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200033
;

-- Aug 5, 2024, 4:10:57 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=280,Updated=TO_TIMESTAMP('2024-08-05 16:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200034
;

-- Aug 5, 2024, 4:10:58 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=290,Updated=TO_TIMESTAMP('2024-08-05 16:10:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202340
;

