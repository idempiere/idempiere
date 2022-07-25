-- IDEMPIERE-1963
SELECT register_migration_script('202207141111_IDEMPIERE-1963.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 14, 2022, 11:11:43 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203628,0,0,'Y',TO_TIMESTAMP('2022-07-14 11:11:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 11:11:43','YYYY-MM-DD HH24:MI:SS'),100,'DocSource','Document Source','Document Source','D','824512df-68c6-483a-9a63-a04e217ed86d')
;

-- Jul 14, 2022, 11:24:13 AM CEST
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-07-14 11:24:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200065
;

-- Jul 14, 2022, 11:30:32 AM CEST
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200219,'7eee5607-2762-4c83-8682-69ada95df101',TO_TIMESTAMP('2022-07-14 11:30:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','m_inout_candidate_v-020',TO_TIMESTAMP('2022-07-14 11:30:32','YYYY-MM-DD HH24:MI:SS'),100,200309,20,'WHERE  RMA.docstatus = ''CO''
       AND DT.docbasetype = ''POO''
       AND EXISTS (SELECT 1
                   FROM   m_rma R
                          INNER JOIN m_rmaline RL
                                  ON R.m_rma_id = RL.m_rma_id
                   WHERE  R.m_rma_id = RMA.m_rma_id
                          AND RL.isactive = ''Y''
                          AND RL.m_inoutline_id > 0
                          AND RL.qtydelivered < RL.qty)
       AND NOT EXISTS (SELECT 1
                       FROM   m_inout OIO
                       WHERE  OIO.m_rma_id = RMA.m_rma_id
                              AND OIO.docstatus IN ( ''IP'', ''CO'', ''CL'' ))','FROM m_rma RMA
       INNER JOIN ad_org ORG ON RMA.ad_org_id = ORG.ad_org_id
       INNER JOIN c_doctype DT ON RMA.c_doctype_id = DT.c_doctype_id
       INNER JOIN c_bpartner BP ON RMA.c_bpartner_id = BP.c_bpartner_id
       INNER JOIN m_inout IO ON RMA.inout_id = IO.m_inout_id','Y')
;

-- Jul 14, 2022, 11:32:37 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217356,'c88d76ce-3ee6-4d86-804c-1e40e7771bde',TO_TIMESTAMP('2022-07-14 11:32:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:32:37','YYYY-MM-DD HH24:MI:SS'),100,200219,'AD_Client_ID','rma.ad_client_id',10)
;

-- Jul 14, 2022, 11:32:51 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217357,'bcc79863-4f92-45cc-b20a-529db7ad2bac',TO_TIMESTAMP('2022-07-14 11:32:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:32:50','YYYY-MM-DD HH24:MI:SS'),100,200219,'AD_Org_ID','rma.ad_org_id',20)
;

-- Jul 14, 2022, 11:33:03 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217358,'8b5346f5-2cae-4da8-ad27-3a9362d90bd3',TO_TIMESTAMP('2022-07-14 11:33:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:33:02','YYYY-MM-DD HH24:MI:SS'),100,200219,'Created','rma.created',30)
;

-- Jul 14, 2022, 11:33:14 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217359,'b387676e-ae5d-4d09-883d-212ea4d7ef2b',TO_TIMESTAMP('2022-07-14 11:33:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:33:14','YYYY-MM-DD HH24:MI:SS'),100,200219,'Updated','rma.updated',40)
;

-- Jul 14, 2022, 11:33:31 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217360,'37ca61a1-e2e1-4c09-bcd9-e07416fd77b3',TO_TIMESTAMP('2022-07-14 11:33:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:33:31','YYYY-MM-DD HH24:MI:SS'),100,200219,'IsActive','rma.isactive',50)
;

-- Jul 14, 2022, 11:33:58 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217361,'a84d0628-df99-4779-b52a-364f6d34c72b',TO_TIMESTAMP('2022-07-14 11:33:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:33:57','YYYY-MM-DD HH24:MI:SS'),100,200219,'C_BPartner_ID','rma.c_bpartner_id',60)
;

-- Jul 14, 2022, 11:34:17 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217362,'e2e09b41-c3a1-4a81-be87-38c5666e8568',TO_TIMESTAMP('2022-07-14 11:34:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:34:17','YYYY-MM-DD HH24:MI:SS'),100,200219,'C_Order_ID','rma.c_order_id',70)
;

-- Jul 14, 2022, 11:34:31 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217363,'99dd29f0-c557-4f4c-84be-e9b69d5fdab8',TO_TIMESTAMP('2022-07-14 11:34:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:34:31','YYYY-MM-DD HH24:MI:SS'),100,200219,'DocumentNo','rma.documentno',80)
;

-- Jul 14, 2022, 11:34:52 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217364,'e9dd7046-d455-474b-9eaf-bee222ec863e',TO_TIMESTAMP('2022-07-14 11:34:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:34:52','YYYY-MM-DD HH24:MI:SS'),100,200219,'DateOrdered','rma.created',90)
;

-- Jul 14, 2022, 11:35:10 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217365,'73a4aff2-f49d-481e-883a-6f04747e403a',TO_TIMESTAMP('2022-07-14 11:35:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:35:10','YYYY-MM-DD HH24:MI:SS'),100,200219,'C_DocType_ID','rma.c_doctype_id',100)
;

-- Jul 14, 2022, 11:35:30 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217366,'0d328714-fcc1-470b-83cf-acda74a0aa65',TO_TIMESTAMP('2022-07-14 11:35:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:35:30','YYYY-MM-DD HH24:MI:SS'),100,200219,'POReference','NULL',110)
;

-- Jul 14, 2022, 11:35:46 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217367,'6c14e96c-a531-48d8-a3e8-6126c0b98970',TO_TIMESTAMP('2022-07-14 11:35:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:35:46','YYYY-MM-DD HH24:MI:SS'),100,200219,'Description','NULL',120)
;

-- Jul 14, 2022, 11:36:13 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217368,'dd2c6e39-1087-4afd-adfa-28a35321cbd5',TO_TIMESTAMP('2022-07-14 11:36:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:36:13','YYYY-MM-DD HH24:MI:SS'),100,200219,'SalesRep_ID','NULL',130)
;

-- Jul 14, 2022, 11:36:35 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217369,'f3b2790c-8558-4b61-8977-b9626e0508a4',TO_TIMESTAMP('2022-07-14 11:36:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:36:35','YYYY-MM-DD HH24:MI:SS'),100,200219,'M_Warehouse_ID','io.m_warehouse_id',140)
;

-- Jul 14, 2022, 11:37:01 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217370,'346f9303-b815-403f-9e68-a0eac825c5fc',TO_TIMESTAMP('2022-07-14 11:37:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:37:00','YYYY-MM-DD HH24:MI:SS'),100,200219,'M_InOut_ID','rma.inout_id',150)
;

-- Jul 14, 2022, 11:37:19 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217371,'f5d98f38-400d-4ae6-9fd2-d405e238874d',TO_TIMESTAMP('2022-07-14 11:37:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:37:18','YYYY-MM-DD HH24:MI:SS'),100,200219,'TotalLines','rma.amt',160)
;

-- Jul 14, 2022, 11:38:08 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217372,'ce0cf5ba-e39b-4df7-85ae-7b81872ced45',TO_TIMESTAMP('2022-07-14 11:38:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:38:08','YYYY-MM-DD HH24:MI:SS'),100,200219,'DocSource','''R''',170)
;

-- Jul 14, 2022, 11:39:10 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217373,'332f5ba4-9258-479c-8371-68d849bf1bc5',TO_TIMESTAMP('2022-07-14 11:39:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:39:10','YYYY-MM-DD HH24:MI:SS'),100,200219,'M_InOut_Candidate_v_ID','rma.m_rma_id',180)
;

-- Jul 14, 2022, 11:45:57 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217374,'5f0c451b-16f0-480d-85ed-7fe51aedb701',TO_TIMESTAMP('2022-07-14 11:45:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:45:56','YYYY-MM-DD HH24:MI:SS'),100,200065,'Created','o.created',130)
;

-- Jul 14, 2022, 11:46:13 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217375,'328f17ed-24bf-4132-8dba-937752453f8c',TO_TIMESTAMP('2022-07-14 11:46:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:46:13','YYYY-MM-DD HH24:MI:SS'),100,200065,'Updated','o.updated',140)
;

-- Jul 14, 2022, 11:46:25 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217376,'750c670f-cdc5-441f-9370-f7d55a5ca83e',TO_TIMESTAMP('2022-07-14 11:46:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:46:25','YYYY-MM-DD HH24:MI:SS'),100,200065,'IsActive','o.isactive',150)
;

-- Jul 14, 2022, 11:47:37 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217377,'34bac1c8-b988-40c7-ac40-6ac410efc342',TO_TIMESTAMP('2022-07-14 11:47:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:47:37','YYYY-MM-DD HH24:MI:SS'),100,200065,'M_InOut_ID','NULL',160)
;

-- Jul 14, 2022, 11:48:20 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217378,'c5d16738-b415-4263-be3a-4940e20a7109',TO_TIMESTAMP('2022-07-14 11:48:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:48:19','YYYY-MM-DD HH24:MI:SS'),100,200065,'DocSource','''O''',170)
;

-- Jul 14, 2022, 11:48:53 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217379,'0b5dd867-e576-4a14-8a76-61ef07dbd091',TO_TIMESTAMP('2022-07-14 11:48:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-14 11:48:53','YYYY-MM-DD HH24:MI:SS'),100,200065,'M_InOut_Candidate_v_ID','o.c_order_id',180)
;

-- Jul 14, 2022, 11:51:26 AM CEST
UPDATE AD_ViewColumn SET SeqNo=30,Updated=TO_TIMESTAMP('2022-07-14 11:51:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217374
;

-- Jul 14, 2022, 11:51:37 AM CEST
UPDATE AD_ViewColumn SET SeqNo=40,Updated=TO_TIMESTAMP('2022-07-14 11:51:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217375
;

-- Jul 14, 2022, 11:51:45 AM CEST
UPDATE AD_ViewColumn SET SeqNo=50,Updated=TO_TIMESTAMP('2022-07-14 11:51:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217376
;

-- Jul 14, 2022, 11:52:22 AM CEST
UPDATE AD_ViewColumn SET SeqNo=60,Updated=TO_TIMESTAMP('2022-07-14 11:52:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210466
;

-- Jul 14, 2022, 11:52:26 AM CEST
UPDATE AD_ViewColumn SET SeqNo=70,Updated=TO_TIMESTAMP('2022-07-14 11:52:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210467
;

-- Jul 14, 2022, 11:52:30 AM CEST
UPDATE AD_ViewColumn SET SeqNo=80,Updated=TO_TIMESTAMP('2022-07-14 11:52:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210468
;

-- Jul 14, 2022, 11:53:45 AM CEST
UPDATE AD_ViewColumn SET SeqNo=90,Updated=TO_TIMESTAMP('2022-07-14 11:53:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210469
;

-- Jul 14, 2022, 11:53:59 AM CEST
UPDATE AD_ViewColumn SET SeqNo=100,Updated=TO_TIMESTAMP('2022-07-14 11:53:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210470
;

-- Jul 14, 2022, 11:54:27 AM CEST
UPDATE AD_ViewColumn SET SeqNo=110,Updated=TO_TIMESTAMP('2022-07-14 11:54:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210471
;

-- Jul 14, 2022, 11:55:25 AM CEST
UPDATE AD_ViewColumn SET SeqNo=120,Updated=TO_TIMESTAMP('2022-07-14 11:55:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210472
;

-- Jul 14, 2022, 11:55:33 AM CEST
UPDATE AD_ViewColumn SET SeqNo=130,Updated=TO_TIMESTAMP('2022-07-14 11:55:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210473
;

-- Jul 14, 2022, 11:55:49 AM CEST
UPDATE AD_ViewColumn SET SeqNo=140,Updated=TO_TIMESTAMP('2022-07-14 11:55:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210474
;

-- Jul 14, 2022, 11:55:55 AM CEST
UPDATE AD_ViewColumn SET SeqNo=150,Updated=TO_TIMESTAMP('2022-07-14 11:55:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217377
;

-- Jul 14, 2022, 11:56:10 AM CEST
UPDATE AD_ViewColumn SET SeqNo=160,Updated=TO_TIMESTAMP('2022-07-14 11:56:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=210475
;

-- Jul 14, 2022, 12:01:21 PM CEST
DROP VIEW M_InOut_Candidate_v
;

-- Jul 20, 2022, 4:04:11 PM CEST
CREATE OR REPLACE VIEW M_InOut_Candidate_v(AD_Client_ID, AD_Org_ID, Created, Updated, IsActive, C_BPartner_ID, C_Order_ID, DocumentNo, DateOrdered, C_DocType_ID, POReference, Description, SalesRep_ID, M_Warehouse_ID, M_InOut_ID, TotalLines, DocSource, M_InOut_Candidate_v_ID, DeliveryRule) AS SELECT o.ad_client_id AS AD_Client_ID, o.ad_org_id AS AD_Org_ID, o.created AS Created, o.updated AS Updated, o.isactive AS IsActive, o.c_bpartner_id AS C_BPartner_ID, o.c_order_id AS C_Order_ID, o.documentno AS DocumentNo, o.dateordered AS DateOrdered, o.c_doctype_id AS C_DocType_ID, o.poreference AS POReference, o.description AS Description, o.salesrep_id AS SalesRep_ID, l.m_warehouse_id AS M_Warehouse_ID, NULL AS M_InOut_ID, sum((l.qtyordered - l.qtydelivered) * l.priceactual) AS TotalLines, 'O' AS DocSource, o.c_order_id AS M_InOut_Candidate_v_ID, o.deliveryrule AS DeliveryRule FROM c_order o
JOIN c_orderline l ON o.c_order_id = l.c_order_id WHERE o.docstatus = 'CO' AND o.isdelivered = 'N' AND (o.c_doctype_id IN ( SELECT c_doctype.c_doctype_id
           FROM c_doctype
          WHERE c_doctype.docbasetype = 'SOO' AND (c_doctype.docsubtypeso NOT IN ('ON', 'OB', 'WR')))) AND o.deliveryrule <> 'M' AND (l.m_product_id IS NULL OR (EXISTS ( SELECT 1
           FROM m_product p
          WHERE l.m_product_id = p.m_product_id AND p.isexcludeautodelivery = 'N'))) AND l.qtyordered <> l.qtydelivered AND (l.m_product_id IS NOT NULL OR l.c_charge_id IS NOT NULL) AND NOT (EXISTS ( SELECT 1
           FROM m_inoutline iol
             JOIN m_inout io ON iol.m_inout_id = io.m_inout_id
          WHERE iol.c_orderline_id = l.c_orderline_id AND (io.docstatus IN ('DR', 'IN', 'IP', 'WC')))) GROUP BY o.ad_client_id, o.ad_org_id, o.c_bpartner_id, o.c_order_id, o.documentno, o.dateordered, o.c_doctype_id, o.poreference, o.description, o.salesrep_id, l.m_warehouse_id, o.created, o.updated, o.isactive, o.deliveryrule
 UNION  ALL SELECT rma.ad_client_id AS AD_Client_ID, rma.ad_org_id AS AD_Org_ID, rma.created AS Created, rma.updated AS Updated, rma.isactive AS IsActive, rma.c_bpartner_id AS C_BPartner_ID, rma.c_order_id AS C_Order_ID, rma.documentno AS DocumentNo, rma.created AS DateOrdered, rma.c_doctype_id AS C_DocType_ID, NULL AS POReference, NULL AS Description, NULL AS SalesRep_ID, io.m_warehouse_id AS M_Warehouse_ID, rma.inout_id AS M_InOut_ID, rma.amt AS TotalLines, 'R' AS DocSource, rma.m_rma_id AS M_InOut_Candidate_v_ID, NULL AS DeliveryRule FROM m_rma RMA
       INNER JOIN ad_org ORG ON RMA.ad_org_id = ORG.ad_org_id
       INNER JOIN c_doctype DT ON RMA.c_doctype_id = DT.c_doctype_id
       INNER JOIN c_bpartner BP ON RMA.c_bpartner_id = BP.c_bpartner_id
       INNER JOIN m_inout IO ON RMA.inout_id = IO.m_inout_id WHERE  RMA.docstatus = 'CO'
       AND DT.docbasetype = 'POO'
       AND EXISTS (SELECT 1
                   FROM   m_rma R
                          INNER JOIN m_rmaline RL
                                  ON R.m_rma_id = RL.m_rma_id
                   WHERE  R.m_rma_id = RMA.m_rma_id
                          AND RL.isactive = 'Y'
                          AND RL.m_inoutline_id > 0
                          AND RL.qtydelivered < RL.qty)
       AND NOT EXISTS (SELECT 1
                       FROM   m_inout OIO
                       WHERE  OIO.m_rma_id = RMA.m_rma_id
                              AND OIO.docstatus IN ( 'IP', 'CO', 'CL' ))
;

-- Jul 14, 2022, 12:05:41 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215039,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200309,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:41','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','1816beee-3baa-4cbb-8449-ba06e2a4fcf4','N','D')
;

-- Jul 14, 2022, 12:05:41 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215040,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200309,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:41','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','122146ae-51c0-4034-9472-63ab53a7af47','N','D')
;

-- Jul 14, 2022, 12:05:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215041,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200309,'Created','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:41','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','65fe0596-d3d4-4333-8f73-493be0b74dc7','N')
;

-- Jul 14, 2022, 12:05:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215042,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200309,'Updated','SYSDATE',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:42','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','331bc7a0-ad7f-4fa7-a472-82d6d6f0abc8','N')
;

-- Jul 14, 2022, 12:05:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215043,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200309,'IsActive','Y',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:42','YYYY-MM-DD HH24:MI:SS'),100,348,'N','N','D','N','4329fa73-2ee1-4e13-81a6-6dde0a396186','N')
;

-- Jul 14, 2022, 12:05:43 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215044,0.0,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200309,'C_BPartner_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:42','YYYY-MM-DD HH24:MI:SS'),100,187,'N','N','D','N','ae35a9b1-bca1-4704-a790-58d57cbfbc8f','N')
;

-- Jul 14, 2022, 12:05:43 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215045,0.0,'Order','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',200309,'C_Order_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:43','YYYY-MM-DD HH24:MI:SS'),100,558,'N','N','D','N','0736e208-2721-4ffb-8d24-016b43d736ef','N')
;

-- Jul 14, 2022, 12:05:43 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215046,0.0,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200309,'DocumentNo',30,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:43','YYYY-MM-DD HH24:MI:SS'),100,290,'N','Y','D','N','539e1274-da49-420e-a67a-5b05c04863a9',10,'N')
;

-- Jul 14, 2022, 12:05:43 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215047,0.0,'Date Ordered','Date of Order','Indicates the Date an item was ordered.',200309,'DateOrdered',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:43','YYYY-MM-DD HH24:MI:SS'),100,268,'N','N','D','N','248452a0-b11b-46aa-9426-3a5febc2fadf','N')
;

-- Jul 14, 2022, 12:05:44 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215048,0.0,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200309,'C_DocType_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:43','YYYY-MM-DD HH24:MI:SS'),100,196,'N','N','D','N','ffd74cf7-7081-42ea-a060-6f9c93284449','N')
;

-- Jul 14, 2022, 12:05:44 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215049,0.0,'Order Reference','Transaction Reference Number (Sales Order, Purchase Order) of your Business Partner','The business partner order reference is the order reference for this specific transaction; Often Purchase Order numbers are given to print on Invoices for easier reference.  A standard number can be defined in the Business Partner (Customer) window.',200309,'POReference',2147483647,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:44','YYYY-MM-DD HH24:MI:SS'),100,952,'N','N','D','N','eae540a5-7013-4324-8f0f-20ce103876c9','N')
;

-- Jul 14, 2022, 12:05:44 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215050,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200309,'Description',2147483647,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:44','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','N','a25196ab-3d3b-41a6-a99f-8c38cd9e21e7',20,'N')
;

-- Jul 14, 2022, 12:05:45 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215051,0.0,'Sales Representative','Sales Representative or Company Agent','The Sales Representative indicates the Sales Rep for this Region.  Any Sales Rep must be a valid internal user.',200309,'SalesRep_ID',10,'N','N','N','N','N','N',18,190,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:44','YYYY-MM-DD HH24:MI:SS'),100,1063,'N','N','D','N','549c17f1-5fab-42b5-ba21-cc53256451e8','N')
;

-- Jul 14, 2022, 12:05:45 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215052,0.0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200309,'M_Warehouse_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:45','YYYY-MM-DD HH24:MI:SS'),100,459,'N','N','D','N','4fa63a25-3980-4497-bebb-a034cbdbe16d','N')
;

-- Jul 14, 2022, 12:05:45 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215053,0.0,'Shipment/Receipt','Material Shipment Document','The Material Shipment / Receipt ',200309,'M_InOut_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:45','YYYY-MM-DD HH24:MI:SS'),100,1025,'N','N','D','N','f59bcd80-bfde-48eb-b2c3-6ac040f1df0f','N')
;

-- Jul 14, 2022, 12:05:46 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215054,0.0,'Total Lines','Total of all document lines','The Total amount displays the total of all lines in document currency',200309,'TotalLines',14,'N','N','N','N','N','N',12,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:45','YYYY-MM-DD HH24:MI:SS'),100,598,'N','N','D','N','f72ff768-b1f7-4bf8-bca4-708d2cbc7b71','N')
;

-- Jul 14, 2022, 12:05:46 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215055,0.0,'Document Source',200309,'DocSource',2147483647,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:46','YYYY-MM-DD HH24:MI:SS'),100,203628,'N','N','D','N','6fdd9d17-197a-452a-8877-821eb2de534e','N')
;

-- Jul 14, 2022, 12:58:20 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203629,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:58:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:58:19','YYYY-MM-DD HH24:MI:SS'),100,'M_InOut_Candidate_v_ID','M_InOut_Candidate_v_ID','M_InOut_Candidate_v_ID','D','56a7e0c2-8376-4e20-aefc-0ea2542bafa9')
;

-- Jul 14, 2022, 12:05:46 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215056,0.0,'M_InOut_Candidate_v',200309,'M_InOut_Candidate_v_ID',10,'Y','N','N','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-07-14 12:05:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 12:05:46','YYYY-MM-DD HH24:MI:SS'),100,203629,'N','N','D','N','00acccf4-f131-46c1-b484-4b85f93e6c82','N')
;

-- Jun 5, 2014 12:07:40 PM CEST
INSERT INTO AD_InfoWindow (IsDefault,AD_Table_ID,Created,Updated,SeqNo,IsShowInDashboard,MaxQueryRecords,EntityType,Name,IsDistinct,FromClause,Processing,AD_InfoWindow_UU,Description,IsValid,AD_Org_ID,UpdatedBy,CreatedBy,IsActive,AD_Client_ID,AD_InfoWindow_ID) VALUES ('N',200309,TO_DATE('2014-06-05 12:07:39','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-06-05 12:07:39','YYYY-MM-DD HH24:MI:SS'),20,'Y',0,'D','Generate Shipments (manual)','N','M_InOut_Candidate_v a','N','240e290d-77ce-40bb-8f27-a9cfd46746d3','Select and generate shipments','N',0,100,100,'Y',0,200008)
;

-- Jun 5, 2014 12:08:08 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',113,'a.AD_Org_ID',TO_DATE('2014-06-05 12:08:08','YYYY-MM-DD HH24:MI:SS'),'D','Organizational entity within client',100,100,'Organization',0,'N',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','a401b5af-e5b2-405e-a22f-5f2e042ad69c',19,200116,'N',104,'Y','AD_Org_ID',TO_DATE('2014-06-05 12:08:08','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:09:35 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'N','Y',459,'a.M_Warehouse_ID',TO_DATE('2014-06-05 12:09:23','YYYY-MM-DD HH24:MI:SS'),'D','Storage Warehouse and Service Point',100,100,'Warehouse','=',0,'N',20,'The Warehouse identifies a unique Warehouse where products are stored or Services are provided.','5594ac73-41a1-42ad-a845-d12509ce248a',19,200117,'Y','Y','M_Warehouse_ID',TO_DATE('2014-06-05 12:09:23','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:09:58 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',196,'a.C_DocType_ID',TO_DATE('2014-06-05 12:09:57','YYYY-MM-DD HH24:MI:SS'),'D','Document type or rules',100,100,'Document Type',0,'N',30,'The Document Type determines document sequence and processing rules','c68d83d2-fdbb-4a8a-85ca-4ba8181a90c8',19,200118,'N','Y','C_DocType_ID',TO_DATE('2014-06-05 12:09:57','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:10:43 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,QueryFunction,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',290,'a.DocumentNo',TO_DATE('2014-06-05 12:10:42','YYYY-MM-DD HH24:MI:SS'),'D','Document sequence number of the document',100,100,'Document No','Like',0,'N',40,'The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','1a06bf7a-14ec-4534-8a8b-a873df866060',10,200119,'Y','Y','Upper','DocumentNo',TO_DATE('2014-06-05 12:10:42','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:10:51 PM CEST
UPDATE AD_InfoColumn SET IsQueryCriteria='N',Updated=TO_DATE('2014-06-05 12:10:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200119
;

-- Jun 5, 2014 12:11:17 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',187,'a.C_BPartner_ID',TO_DATE('2014-06-05 12:11:17','YYYY-MM-DD HH24:MI:SS'),'D','Identifies a Business Partner',100,100,'Business Partner ','=',0,'N',50,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','4f5efb70-0cd5-40bb-a5b8-8229ce7e7f1d',30,200120,'Y','Y','C_BPartner_ID',TO_DATE('2014-06-05 12:11:17','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Column SET ColumnName='DocSource', Name='Document Source', Description=NULL, Help=NULL WHERE AD_Element_ID=203628
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Process_Para SET ColumnName='DocSource', Name='Document Source', Description=NULL, Help=NULL, AD_Element_ID=203628 WHERE UPPER(ColumnName)='DocSource' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Process_Para SET ColumnName='DocSource', Name='Document Source', Description=NULL, Help=NULL WHERE AD_Element_ID=203628 AND IsCentrallyMaintained='Y'
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DocSource', Name='Document Source', Description=NULL, Help=NULL WHERE AD_Element_ID=203628 AND IsCentrallyMaintained='Y'
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Field SET Name='Document Source', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203628) AND IsCentrallyMaintained='Y'
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Document Source', Name='Document Source' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203628)
;

-- Jun 5, 2014 12:13:37 PM CEST
INSERT INTO AD_Reference (AD_Org_ID,Created,EntityType,IsActive,IsOrderByValue,AD_Reference_ID,ValidationType,Name,CreatedBy,Updated,UpdatedBy,AD_Reference_UU,AD_Client_ID) VALUES (0,TO_DATE('2014-06-05 12:13:35','YYYY-MM-DD HH24:MI:SS'),'D','Y','N',200085,'L','DocSource Generate Shipments (manual)',100,TO_DATE('2014-06-05 12:13:35','YYYY-MM-DD HH24:MI:SS'),100,'3be7b948-8b9e-490c-849c-df25ea642a23',0)
;

-- Jun 5, 2014 12:13:46 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_Reference_Value_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,200085,'N','Y',203628,'a.DocSource',TO_DATE('2014-06-05 12:13:46','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Document Source','=',0,'N',60,'7502653b-55ef-4384-90b3-dcd224533968',17,200121,'Y','Y','DocSource',TO_DATE('2014-06-05 12:13:46','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:14:06 PM CEST
INSERT INTO AD_Ref_List (AD_Org_ID,EntityType,Updated,UpdatedBy,AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,IsActive,AD_Client_ID) VALUES (0,'D',TO_DATE('2014-06-05 12:14:05','YYYY-MM-DD HH24:MI:SS'),100,200190,200085,'Order','aba7bebd-533e-4c9b-94d0-0a3a014b8335','O',TO_DATE('2014-06-05 12:14:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Jun 5, 2014 12:14:21 PM CEST
INSERT INTO AD_Ref_List (AD_Org_ID,EntityType,Updated,UpdatedBy,AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,IsActive,AD_Client_ID) VALUES (0,'D',TO_DATE('2014-06-05 12:14:20','YYYY-MM-DD HH24:MI:SS'),100,200191,200085,'Vendor RMA','0390303f-bfa0-4207-93b1-750461733fab','R',TO_DATE('2014-06-05 12:14:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Jun 5, 2014 12:14:45 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,QueryFunction,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',268,'a.DateOrdered',TO_DATE('2014-06-05 12:14:44','YYYY-MM-DD HH24:MI:SS'),'D','Date of Order',100,100,'Date Ordered','=',0,'N',70,'Indicates the Date an item was ordered.','f28fce81-2286-4324-8e64-3c9681de7043',15,200122,'N','Y','Trunc','DateOrdered',TO_DATE('2014-06-05 12:14:44','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:14:59 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',598,'a.TotalLines',TO_DATE('2014-06-05 12:14:58','YYYY-MM-DD HH24:MI:SS'),'D','Total of all document lines',100,100,'Total Lines',0,'N',80,'The Total amount displays the total of all lines in document currency','1717aefd-5cea-4190-941e-92ba92986e71',12,200123,'N','Y','TotalLines',TO_DATE('2014-06-05 12:14:58','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:20:20 PM CEST
INSERT INTO AD_Menu (EntityType,Created,UpdatedBy,IsSummary,AD_Menu_ID,IsReadOnly,IsCentrallyMaintained,Name,Description,AD_Menu_UU,Action,AD_InfoWindow_ID,IsSOTrx,IsActive,CreatedBy,Updated,AD_Client_ID,AD_Org_ID) VALUES ('D',TO_DATE('2014-06-05 12:20:20','YYYY-MM-DD HH24:MI:SS'),100,'N',200081,'N','Y','Generate Shipments (manual)','Select and generate shipments Info Window','ada6b5a5-767c-4243-9f8b-c49c36263072','I',200008,'N','Y',100,TO_DATE('2014-06-05 12:20:20','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:20:20 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200081, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200081)
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=346
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53132
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200081
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=193
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=180
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=494
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200031
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200030
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200034
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=444
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=346
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200081
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53132
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=193
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=180
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=494
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200031
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200030
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200034
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=444
;

-- Jun 5, 2014 12:21:50 PM CEST
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_DATE('2014-06-05 12:21:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200008
;

-- Jun 5, 2014 12:27:38 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='O',Updated=TO_DATE('2014-06-05 12:27:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200121
;

-- Jul 14, 2022, 3:03:41 PM CEST
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,EntityType) VALUES (200009,'b264dabb-a1a4-410a-8ac4-8c38faefda89',0,0,'Y',TO_TIMESTAMP('2022-07-14 15:03:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-14 15:03:41','YYYY-MM-DD HH24:MI:SS'),100,10,199,200008,'B','D')
;

-- Jul 15, 2022, 9:06:24 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200392,0,0,'Y',TO_TIMESTAMP('2022-07-15 09:06:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-15 09:06:23','YYYY-MM-DD HH24:MI:SS'),100,'Shipment Date','Date printed on shipment','The Shipment Date indicates the date printed on the shipment.',199,10,15,'N',0,'N','MovementDate','N','D',1037,'acf84a24-38d7-464b-b9c6-36d7ee7baa40','N','N')
;

-- Jul 15, 2022, 9:10:45 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200393,0,0,'Y',TO_TIMESTAMP('2022-07-15 09:10:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-15 09:10:45','YYYY-MM-DD HH24:MI:SS'),100,'Orders with unconfirmed Shipments','Generate shipments for Orders with open delivery confirmations?','You can also include orders who have outstanding confirmations (e.g. ordered=10 - not confirmed shipments=4 - would create a new shipment of 6 if available).',199,20,20,'N',0,'N','N','IsUnconfirmedInOut','N','D','dc0d81e7-41d9-4410-bd7d-d2136410c491','N','N')
;

-- Jul 15, 2022, 9:11:13 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200394,0,0,'Y',TO_TIMESTAMP('2022-07-15 09:11:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-15 09:11:13','YYYY-MM-DD HH24:MI:SS'),100,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',199,30,17,135,'N',219,1,'N','CO','DocAction','Y','D',287,'d831768d-0233-448d-852d-7de02227b705','N','N')
;

-- Jul 15, 2022, 9:11:41 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200395,0,0,'Y',TO_TIMESTAMP('2022-07-15 09:11:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-15 09:11:41','YYYY-MM-DD HH24:MI:SS'),100,'Consolidate to one Document','Consolidate Lines into one Document',199,40,20,'N',0,'N','Y','ConsolidateDocument','Y','D',2182,'427d66d4-6723-4957-96c5-b628ea4fb4fb','N','N')
;

-- Jul 15, 2022, 9:12:01 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200396,0,0,'Y',TO_TIMESTAMP('2022-07-15 09:12:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-15 09:12:01','YYYY-MM-DD HH24:MI:SS'),100,'Subtract In Progress Shipment From On Hand','Subtract In Progress Shipment From On Hand',199,50,20,'N',0,'N','N','SubtractOnHand','Y','D',203610,'9784286a-7cb2-40d0-8ac9-90b36503a02d','N','N')
;

-- Jul 15, 2022, 9:20:24 AM CEST
UPDATE AD_InfoColumn SET SeqNoSelection=10, IsMandatory='Y',Updated=TO_TIMESTAMP('2022-07-15 09:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200117
;

-- Jul 15, 2022, 9:20:44 AM CEST
UPDATE AD_InfoColumn SET SeqNoSelection=20, IsMandatory='Y',Updated=TO_TIMESTAMP('2022-07-15 09:20:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200121
;

-- Jul 15, 2022, 2:25:37 PM CEST
UPDATE AD_InfoProcess SET DisplayLogic='@DocSource@=''O''',Updated=TO_TIMESTAMP('2022-07-15 14:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoProcess_ID=200009
;

-- Jul 15, 2022, 2:27:35 PM CEST
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,DisplayLogic,EntityType) VALUES (200010,'b783d36e-94e6-4d4e-a5c8-b2bcfcbe878f',0,0,'Y',TO_TIMESTAMP('2022-07-15 14:27:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-15 14:27:35','YYYY-MM-DD HH24:MI:SS'),100,20,52001,200008,'B','@DocSource@=''R''','D')
;

-- Jul 15, 2022, 2:38:55 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200397,0,0,'Y',TO_TIMESTAMP('2022-07-15 14:38:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-15 14:38:55','YYYY-MM-DD HH24:MI:SS'),100,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',52001,10,17,135,'N',219,1,'N','CO','DocAction','Y','D',287,'44ae361a-c07a-4f03-ac88-9f6510aba751','N','N')
;

-- Jul 18, 2022, 11:03:08 AM CEST
UPDATE AD_InfoColumn SET SeqNoSelection=40,Updated=TO_TIMESTAMP('2022-07-18 11:03:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200120
;

-- Jul 18, 2022, 11:18:25 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217382,'8c35f8fc-ef89-46c1-af9b-7c6b4a9fabca',TO_TIMESTAMP('2022-07-18 11:18:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 11:18:24','YYYY-MM-DD HH24:MI:SS'),100,200219,'DeliveryRule','NULL',190)
;

-- Jul 18, 2022, 11:18:48 AM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217383,'1a10e02e-37b3-4295-b606-9ec604819372',TO_TIMESTAMP('2022-07-18 11:18:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 11:18:48','YYYY-MM-DD HH24:MI:SS'),100,200065,'DeliveryRule','o.deliveryrule',190)
;

-- Jul 20, 2022, 4:04:06 PM CEST
UPDATE AD_ViewComponent SET OtherClause='GROUP BY o.ad_client_id, o.ad_org_id, o.c_bpartner_id, o.c_order_id, o.documentno, o.dateordered, o.c_doctype_id, o.poreference, o.description, o.salesrep_id, l.m_warehouse_id, o.created, o.updated, o.isactive, o.deliveryrule
',Updated=TO_TIMESTAMP('2022-07-20 16:04:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200065
;

-- Jul 18, 2022, 11:19:15 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215061,0,'Delivery Rule','Defines the timing of Delivery','The Delivery Rule indicates when an order should be delivered. For example should the order be delivered when the entire order is complete, when a line is complete or as the products become available.',200309,'DeliveryRule',1,'N','N','N','N','N',0,'N',17,151,0,0,'Y',TO_TIMESTAMP('2022-07-18 11:19:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 11:19:15','YYYY-MM-DD HH24:MI:SS'),100,555,'N','N','D','N','N','N','Y','43e1ba5e-0212-4467-861b-09b869aa892e','Y',0,'N','N','N')
;

-- Jul 18, 2022, 11:28:52 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200242,0,0,'Y',TO_TIMESTAMP('2022-07-18 11:28:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 11:28:52','YYYY-MM-DD HH24:MI:SS'),100,'Delivery Rule','Defines the timing of Delivery','The Delivery Rule indicates when an order should be delivered. For example should the order be delivered when the entire order is complete, when a line is complete or as the products become available.',200008,'D','a.DeliveryRule',90,'N','Y',555,17,'1ef4359a-3255-4c16-a1ef-62b4cc060ccb',151,'Y','DeliveryRule','=','N',30,'N','N','Y','N')
;

-- Jul 18, 2022, 11:29:44 AM CEST
UPDATE AD_Process_Para SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-07-18 11:29:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200394
;

-- Jul 18, 2022, 11:30:47 AM CEST
UPDATE AD_Process_Para SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-07-18 11:30:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200397
;

-- Jul 18, 2022, 11:31:28 AM CEST
UPDATE AD_Process_Para SET SeqNo=20,Updated=TO_TIMESTAMP('2022-07-18 11:31:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200397
;

-- Jul 18, 2022, 11:32:07 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200398,0,0,'Y',TO_TIMESTAMP('2022-07-18 11:32:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 11:32:07','YYYY-MM-DD HH24:MI:SS'),100,'Movement Date','Date a product was moved in or out of inventory','The Movement Date indicates the date that a product moved in or out of inventory.  This is the result of a shipment, receipt or inventory movement.',52001,10,15,'N',0,'N','MovementDate','Y','D',1037,'48323d5f-01b4-4579-9a6b-ef8199cdb443','N','N')
;

-- Jul 18, 2022, 11:49:56 AM CEST
UPDATE AD_InfoColumn SET DisplayLogic='@DocSource@=''O''',Updated=TO_TIMESTAMP('2022-07-18 11:49:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200242
;

