-- IDEMPIERE-1965
SELECT register_migration_script('202207181552_IDEMPIERE-1965.sql') FROM dual;

-- Jul 18, 2022, 3:52:22 PM CEST
UPDATE AD_ViewComponent SET IsUnionAll='Y',Updated=TO_TIMESTAMP('2022-07-18 15:52:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200019
;

UPDATE AD_ViewComponent SET OtherClause='GROUP BY o.ad_client_id, o.ad_org_id, o.created, o.updated, o.isactive, o.c_bpartner_id, o.c_order_id, o.documentno, o.dateordered, o.c_doctype_id,o.invoicerule',Updated=TO_TIMESTAMP('2022-07-29 10:10:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200019
;

-- Jul 18, 2022, 3:53:32 PM CEST
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200220,'3a3a0b11-e939-4611-b1e8-fc9d6bdd0f04',TO_TIMESTAMP('2022-07-18 15:53:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','c_invoice_candidate_v-020',TO_TIMESTAMP('2022-07-18 15:53:31','YYYY-MM-DD HH24:MI:SS'),100,200292,20,'WHERE  rma.docstatus = ''CO''
AND    dt.docbasetype = ''SOO''
AND    NOT (
              EXISTS
              (
                     SELECT 1
                     FROM   c_invoice i
                     WHERE  i.m_rma_id = rma.m_rma_id
                     AND    (
                                   i.docstatus IN (''IP'', ''CO'', ''CL''))))
AND    (
              EXISTS
              (
                     SELECT 1
                     FROM   c_invoiceline il
                     JOIN   m_inoutline iol ON     il.m_inoutline_id = iol.m_inoutline_id
                     JOIN   c_invoice i ON     i.c_invoice_id = il.c_invoice_id
                     WHERE  (
                                   i.docstatus IN (''CO'', ''CL'') AND EXISTS (SELECT 1
                                      FROM   m_rmaline rl
                                      WHERE  rl.m_rma_id = rma.m_rma_id
                                             AND iol.m_inoutline_id =
                                                 rl.m_inoutline_id
                                             AND rl.m_inoutline_id IS NOT NULL))
                     ))','FROM   m_rma rma
JOIN c_doctype dt ON rma.c_doctype_id = dt.c_doctype_id
','Y')
;

-- Jul 18, 2022, 3:54:11 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217384,'71743947-0761-4eba-a296-833d9d1c16ae',TO_TIMESTAMP('2022-07-18 15:54:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:54:11','YYYY-MM-DD HH24:MI:SS'),100,200220,'AD_Client_ID','rma.ad_client_id',10)
;

-- Jul 18, 2022, 3:54:28 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217385,'82f37338-0ccd-46c8-9c99-a745dc3b6bab',TO_TIMESTAMP('2022-07-18 15:54:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:54:28','YYYY-MM-DD HH24:MI:SS'),100,200220,'AD_Org_ID','rma.ad_org_id',20)
;

-- Jul 18, 2022, 3:54:45 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217386,'9c12f385-cbbc-4030-a267-15687f643c44',TO_TIMESTAMP('2022-07-18 15:54:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:54:45','YYYY-MM-DD HH24:MI:SS'),100,200220,'Created','rma.created',30)
;

-- Jul 18, 2022, 3:54:56 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217387,'2de5e810-176b-4ec9-b121-7be8d4b87072',TO_TIMESTAMP('2022-07-18 15:54:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:54:56','YYYY-MM-DD HH24:MI:SS'),100,200220,'Updated','rma.updated',40)
;

-- Jul 18, 2022, 3:55:09 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217388,'1f0430f5-4278-4002-a286-205c0097bb87',TO_TIMESTAMP('2022-07-18 15:55:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:55:09','YYYY-MM-DD HH24:MI:SS'),100,200220,'IsActive','rma.isactive',50)
;

-- Jul 18, 2022, 3:55:24 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217389,'ce6adb69-2a32-4899-bf8c-7f07a8f7c2ee',TO_TIMESTAMP('2022-07-18 15:55:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:55:24','YYYY-MM-DD HH24:MI:SS'),100,200220,'C_BPartner_ID','rma.c_bpartner_id',60)
;

-- Jul 18, 2022, 3:55:38 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217390,'7a602dc7-e881-4e24-83fc-0c7b59c2ded8',TO_TIMESTAMP('2022-07-18 15:55:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:55:38','YYYY-MM-DD HH24:MI:SS'),100,200220,'C_Order_ID','rma.c_order_id',70)
;

-- Jul 18, 2022, 3:55:59 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217391,'98b737fc-fa7a-4b09-9667-17f9d95bc815',TO_TIMESTAMP('2022-07-18 15:55:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:55:59','YYYY-MM-DD HH24:MI:SS'),100,200220,'M_InOut_ID','rma.inout_id',80)
;

-- Jul 18, 2022, 3:56:13 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217392,'b0912fac-ed3d-4e73-8cdd-fcab0fe0d777',TO_TIMESTAMP('2022-07-18 15:56:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:56:13','YYYY-MM-DD HH24:MI:SS'),100,200220,'DocumentNo','rma.documentno',90)
;

-- Jul 18, 2022, 3:56:28 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217393,'85aa5f5e-300a-47e4-b856-a6bdf8f6d091',TO_TIMESTAMP('2022-07-18 15:56:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:56:28','YYYY-MM-DD HH24:MI:SS'),100,200220,'DateOrdered','rma.created',100)
;

-- Jul 18, 2022, 3:56:43 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217394,'ab638496-115e-4408-9abc-a131b73284d6',TO_TIMESTAMP('2022-07-18 15:56:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:56:43','YYYY-MM-DD HH24:MI:SS'),100,200220,'C_DocType_ID','rma.c_doctype_id',110)
;

-- Jul 18, 2022, 3:57:06 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217395,'a353b097-b281-42d5-85f4-ed6c5e346153',TO_TIMESTAMP('2022-07-18 15:57:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 15:57:06','YYYY-MM-DD HH24:MI:SS'),100,200220,'TotalLines','rma.amt',120)
;

-- Jul 18, 2022, 4:05:14 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217396,'b34664fd-2289-4224-8677-81f19015e40c',TO_TIMESTAMP('2022-07-18 16:05:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:05:13','YYYY-MM-DD HH24:MI:SS'),100,200220,'DocSource','''R''',130)
;

-- Jul 18, 2022, 4:05:39 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217397,'1043b1d3-41bf-418d-ae20-d3d165b4d1a4',TO_TIMESTAMP('2022-07-18 16:05:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:05:39','YYYY-MM-DD HH24:MI:SS'),100,200220,'C_Invoice_Candidate_v_ID','rma.m_rma_id',140)
;

-- Jul 18, 2022, 4:07:01 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217398,'036da593-6991-4156-8247-51733795ab6d',TO_TIMESTAMP('2022-07-18 16:07:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:07:01','YYYY-MM-DD HH24:MI:SS'),100,200220,'InvoiceRule','NULL',150)
;

-- Jul 18, 2022, 4:08:09 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217399,'17baa323-d085-4ef5-a03c-1374aa4f8abf',TO_TIMESTAMP('2022-07-18 16:08:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:08:09','YYYY-MM-DD HH24:MI:SS'),100,200019,'Created','o.created',30)
;

-- Jul 18, 2022, 4:08:25 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217400,'9c20265d-cd68-4e72-87ed-2bb901f2e1b9',TO_TIMESTAMP('2022-07-18 16:08:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:08:24','YYYY-MM-DD HH24:MI:SS'),100,200019,'Updated','o.updated',40)
;

-- Jul 18, 2022, 4:08:40 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217401,'fb3ed537-91fb-4035-b9e6-a6ac9728de45',TO_TIMESTAMP('2022-07-18 16:08:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:08:40','YYYY-MM-DD HH24:MI:SS'),100,200019,'IsActive','o.isactive',50)
;

-- Jul 18, 2022, 4:09:26 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217402,'6b27ea88-9816-4bcf-ae2f-98a9025827c9',TO_TIMESTAMP('2022-07-18 16:09:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:09:26','YYYY-MM-DD HH24:MI:SS'),100,200019,'M_InOut_ID','NULL',80)
;

-- Jul 18, 2022, 4:09:51 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217403,'9ead5cbd-04d8-4ad0-b6e4-ac1b24854adf',TO_TIMESTAMP('2022-07-18 16:09:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:09:51','YYYY-MM-DD HH24:MI:SS'),100,200019,'InvoiceRule','o.invoicerule',120)
;

-- Jul 18, 2022, 4:10:25 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217404,'5d32876a-2925-4889-8f29-6499d4881fa9',TO_TIMESTAMP('2022-07-18 16:10:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:10:25','YYYY-MM-DD HH24:MI:SS'),100,200019,'DocSource','''O''',140)
;

-- Jul 18, 2022, 4:10:50 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217405,'40fe8d8a-3b88-45f5-bddf-6f615651ef91',TO_TIMESTAMP('2022-07-18 16:10:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-18 16:10:50','YYYY-MM-DD HH24:MI:SS'),100,200019,'C_Invoice_Candidate_v_ID','o.c_order_id',150)
;

-- Jul 18, 2022, 4:20:42 PM CEST
UPDATE AD_ViewColumn SET SeqNo=60,Updated=TO_TIMESTAMP('2022-07-18 16:20:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=201384
;

-- Jul 18, 2022, 4:20:54 PM CEST
UPDATE AD_ViewColumn SET SeqNo=70,Updated=TO_TIMESTAMP('2022-07-18 16:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=201385
;

-- Jul 18, 2022, 4:21:07 PM CEST
UPDATE AD_ViewColumn SET SeqNo=90,Updated=TO_TIMESTAMP('2022-07-18 16:21:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=201386
;

-- Jul 18, 2022, 4:21:20 PM CEST
UPDATE AD_ViewColumn SET SeqNo=100,Updated=TO_TIMESTAMP('2022-07-18 16:21:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=201387
;

-- Jul 18, 2022, 4:21:31 PM CEST
UPDATE AD_ViewColumn SET SeqNo=110,Updated=TO_TIMESTAMP('2022-07-18 16:21:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=201388
;

-- Jul 18, 2022, 4:21:53 PM CEST
UPDATE AD_ViewColumn SET SeqNo=130,Updated=TO_TIMESTAMP('2022-07-18 16:21:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=201389
;

-- Jul 19, 2022, 10:07:02 AM CEST
DROP VIEW C_Invoice_Candidate_v
;

-- Aug 1, 2022, 2:03:54 PM CEST
CREATE OR REPLACE VIEW C_Invoice_Candidate_v(AD_Client_ID, AD_Org_ID, Created, Updated, IsActive, C_BPartner_ID, C_Order_ID, M_InOut_ID, DocumentNo, DateOrdered, C_DocType_ID, InvoiceRule, TotalLines, DocSource, C_Invoice_Candidate_v_ID) AS SELECT o.ad_client_id AS AD_Client_ID, o.ad_org_id AS AD_Org_ID, o.created AS Created, o.updated AS Updated, o.isactive AS IsActive, o.c_bpartner_id AS C_BPartner_ID, o.c_order_id AS C_Order_ID, NULL AS M_InOut_ID, o.documentno AS DocumentNo, o.dateordered AS DateOrdered, o.c_doctype_id AS C_DocType_ID, o.invoicerule AS InvoiceRule, sum((l.qtyordered - l.qtyinvoiced) * l.priceactual) AS TotalLines, 'O' AS DocSource, o.c_order_id AS C_Invoice_Candidate_v_ID FROM c_order o JOIN c_orderline l ON o.c_order_id = l.c_order_id JOIN c_bpartner bp ON o.c_bpartner_id = bp.c_bpartner_id LEFT JOIN c_invoiceschedule si ON bp.c_invoiceschedule_id = si.c_invoiceschedule_id WHERE (o.docstatus IN ('CO', 'CL', 'IP')) AND (o.c_doctype_id IN ( SELECT c_doctype.c_doctype_id FROM c_doctype WHERE c_doctype.docbasetype = 'SOO' AND (c_doctype.docsubtypeso NOT IN ('ON', 'OB', 'WR')))) AND l.qtyordered <> l.qtyinvoiced AND (o.invoicerule = 'I' OR o.invoicerule = 'O' AND NOT (EXISTS ( SELECT 1 FROM c_orderline zz1 WHERE zz1.c_order_id = o.c_order_id AND zz1.qtyordered <> zz1.qtydelivered)) OR o.invoicerule = 'D' AND l.qtyinvoiced <> l.qtydelivered OR o.invoicerule = 'S' AND bp.c_invoiceschedule_id IS NULL OR o.invoicerule = 'S' AND bp.c_invoiceschedule_id IS NOT NULL AND (si.invoicefrequency IS NULL OR si.invoicefrequency = 'D' OR si.invoicefrequency = 'W' OR si.invoicefrequency = 'T' AND (trunc(o.dateordered) <= (firstof(statement_timestamp(), 'MM') + si.invoicedaycutoff - 1) AND trunc(statement_timestamp()) >= (firstof(o.dateordered, 'MM') + si.invoiceday - 1) OR trunc(o.dateordered) <= (firstof(statement_timestamp(), 'MM') + si.invoicedaycutoff + 14) AND trunc(statement_timestamp()) >= (firstof(o.dateordered, 'MM') + si.invoiceday + 14)) OR si.invoicefrequency = 'M' AND trunc(o.dateordered) <= (firstof(statement_timestamp(), 'MM') + si.invoicedaycutoff - 1) AND trunc(statement_timestamp()) >= (firstof(o.dateordered, 'MM') + si.invoiceday - 1))) GROUP BY o.ad_client_id, o.ad_org_id, o.created, o.updated, o.isactive, o.c_bpartner_id, o.c_order_id, o.documentno, o.dateordered, o.c_doctype_id,o.invoicerule UNION ALL SELECT rma.ad_client_id AS AD_Client_ID, rma.ad_org_id AS AD_Org_ID, rma.created AS Created, rma.updated AS Updated, rma.isactive AS IsActive, rma.c_bpartner_id AS C_BPartner_ID, rma.c_order_id AS C_Order_ID, rma.inout_id AS M_InOut_ID, rma.documentno AS DocumentNo, rma.created AS DateOrdered, rma.c_doctype_id AS C_DocType_ID, NULL AS InvoiceRule, rma.amt AS TotalLines, 'R' AS DocSource, rma.m_rma_id AS C_Invoice_Candidate_v_ID FROM m_rma rma JOIN c_doctype dt ON rma.c_doctype_id = dt.c_doctype_id WHERE rma.docstatus = 'CO' AND dt.docbasetype = 'SOO' AND NOT ( EXISTS ( SELECT 1 FROM c_invoice i WHERE i.m_rma_id = rma.m_rma_id AND ( i.docstatus IN ('IP', 'CO', 'CL')))) AND ( EXISTS ( SELECT 1 FROM c_invoiceline il JOIN m_inoutline iol ON il.m_inoutline_id = iol.m_inoutline_id JOIN c_invoice i ON i.c_invoice_id = il.c_invoice_id WHERE ( i.docstatus IN ('CO', 'CL') AND EXISTS (SELECT 1 FROM m_rmaline rl WHERE rl.m_rma_id = rma.m_rma_id AND iol.m_inoutline_id = rl.m_inoutline_id AND rl.m_inoutline_id IS NOT NULL)) ))
;

-- Jul 18, 2022, 4:55:41 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215078,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200292,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:55:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:55:40','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','85b862b3-5259-44dd-8c74-f03e0ead71e2','N','D')
;

-- Jul 18, 2022, 4:55:41 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (215079,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200292,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:55:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:55:41','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','74da43a7-a94f-4434-890c-28a1e1c5796e','N','D')
;

-- Jul 18, 2022, 4:55:41 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215080,0.0,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200292,'C_BPartner_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:55:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:55:41','YYYY-MM-DD HH24:MI:SS'),100,187,'N','N','D','N','b10a4d89-b87d-411d-bba9-f2012ab615ae','N')
;

-- Jul 18, 2022, 4:55:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215081,0.0,'Order','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',200292,'C_Order_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:55:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:55:41','YYYY-MM-DD HH24:MI:SS'),100,558,'N','N','D','N','c46a0d02-5445-4d0b-8d57-465fc68ad589','N')
;

-- Jul 18, 2022, 4:55:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (215082,0.0,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200292,'DocumentNo',30,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:55:42','YYYY-MM-DD HH24:MI:SS'),100,290,'N','Y','D','N','5bea4a95-50b2-48b8-8d7b-22834f3afaff',10,'N')
;

-- Jul 18, 2022, 4:55:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215083,0.0,'Date Ordered','Date of Order','Indicates the Date an item was ordered.',200292,'DateOrdered',29,'N','N','N','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:55:42','YYYY-MM-DD HH24:MI:SS'),100,268,'N','N','D','N','94d6e90b-b069-436f-bbe7-376878312a04','N')
;

-- Jul 18, 2022, 4:55:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215084,0.0,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200292,'C_DocType_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:55:42','YYYY-MM-DD HH24:MI:SS'),100,196,'N','N','D','N','cd282faa-7025-4ad4-b8e3-e54351855e1b','N')
;

-- Jul 18, 2022, 4:55:43 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215085,0.0,'Total Lines','Total of all document lines','The Total amount displays the total of all lines in document currency',200292,'TotalLines',14,'N','N','N','N','N','N',12,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:55:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:55:42','YYYY-MM-DD HH24:MI:SS'),100,598,'N','N','D','N','ce052def-efb8-4bca-b026-91e9b462824b','N')
;

-- Jul 18, 2022, 4:56:49 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215086,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200292,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:56:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:56:49','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','6fd8aec3-2dbf-4c63-8772-35e56f95fa38','N',0,'N','N','N')
;

-- Jul 18, 2022, 4:57:03 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215087,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200292,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:57:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:57:03','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','00c8eb17-5e1a-4830-b59c-55e6d6e977ec','N',0,'N','N','N')
;

-- Jul 18, 2022, 4:57:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215088,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200292,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:57:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:57:19','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','46fe285c-fe15-413c-914b-0d5b772a4dc1','N',0,'N','N','N')
;

-- Jul 18, 2022, 4:57:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215089,0,'Shipment/Receipt','Material Shipment Document','The Material Shipment / Receipt ',200292,'M_InOut_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:57:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:57:32','YYYY-MM-DD HH24:MI:SS'),100,1025,'N','N','D','N','N','N','Y','e7bcea98-78e8-4fcd-b14e-728676e41508','Y',0,'N','N','N')
;

-- Jul 18, 2022, 4:57:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215090,0,'Invoice Rule','Frequency and method of invoicing ','The Invoice Rule defines how a Business Partner is invoiced and the frequency of invoicing.',200292,'InvoiceRule',1,'N','N','N','N','N',0,'N',17,150,0,0,'Y',TO_TIMESTAMP('2022-07-18 16:57:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-18 16:57:39','YYYY-MM-DD HH24:MI:SS'),100,559,'N','N','D','N','N','N','Y','77116e70-467a-41e7-83b6-4ee5d4926738','Y',0,'N','N','N')
;

-- Jul 19, 2022, 8:47:16 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203632,0,0,'Y',TO_TIMESTAMP('2022-07-19 08:47:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 08:47:16','YYYY-MM-DD HH24:MI:SS'),100,'C_Invoice_Candidate_v_ID','C_Invoice_Candidate_v_ID','C_Invoice_Candidate_v_ID','D','3d8c623c-1b01-4bf9-ac04-5f6a49057746')
;

-- Jul 19, 2022, 8:47:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215091,0.0,'Document Source',200292,'DocSource',2147483647,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2022-07-19 08:47:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 08:47:41','YYYY-MM-DD HH24:MI:SS'),100,203628,'N','N','D','N','16d14d99-44f0-4df6-a202-d0e126d038f8','N')
;

-- Jul 19, 2022, 8:47:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (215092,0.0,'C_Invoice_Candidate_v_ID',200292,'C_Invoice_Candidate_v_ID',10,'Y','N','N','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-07-19 08:47:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 08:47:41','YYYY-MM-DD HH24:MI:SS'),100,203632,'N','N','D','N','01bdcfe1-fe5e-4742-825d-8c446e54519f','N')
;

-- Jun 5, 2014 1:31:39 PM CEST
INSERT INTO AD_InfoWindow (IsDefault,AD_Table_ID,Created,Updated,SeqNo,IsShowInDashboard,MaxQueryRecords,EntityType,Name,IsDistinct,FromClause,Processing,AD_InfoWindow_UU,Description,IsValid,AD_Org_ID,UpdatedBy,CreatedBy,IsActive,AD_Client_ID,AD_InfoWindow_ID) VALUES ('N',200292,TO_TIMESTAMP('2014-06-05 13:31:33','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-06-05 13:31:33','YYYY-MM-DD HH24:MI:SS'),20,'Y',0,'D','Generate Invoices (manual)','N','c_invoice_candidate_v a','N','8c19258d-2180-44e4-bbb3-2808f18319bc','Select and generate invoices','N',0,100,100,'Y',0,200011)
;

-- Jun 5, 2014 1:32:16 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200011,'Y','Y',113,'a.AD_Org_ID',TO_TIMESTAMP('2014-06-05 13:32:14','YYYY-MM-DD HH24:MI:SS'),'D','Organizational entity within client',100,100,'Organization','=',0,'N',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','aa5c1471-286e-48cd-ad26-9a0e1f466eb8',19,200131,'Y',104,'Y','AD_Org_ID',TO_TIMESTAMP('2014-06-05 13:32:14','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 1:32:32 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200011,'Y','Y',196,'a.C_DocType_ID',TO_TIMESTAMP('2014-06-05 13:32:31','YYYY-MM-DD HH24:MI:SS'),'D','Document type or rules',100,100,'Document Type',0,'N',20,'The Document Type determines document sequence and processing rules','1d0cb73d-b23a-4c00-8263-8f346883efbf',19,200132,'N','Y','C_DocType_ID',TO_TIMESTAMP('2014-06-05 13:32:31','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 1:32:49 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,QueryFunction,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200011,'Y','Y',290,'a.DocumentNo',TO_TIMESTAMP('2014-06-05 13:32:48','YYYY-MM-DD HH24:MI:SS'),'D','Document sequence number of the document',100,100,'Document No','Like',0,'N',30,'The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','b74b40b0-5a5f-47e8-8607-cbafd4d5c4b0',10,200133,'N','Y','Upper','DocumentNo',TO_TIMESTAMP('2014-06-05 13:32:48','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 1:33:12 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200011,'Y','Y',187,'a.C_BPartner_ID',TO_TIMESTAMP('2014-06-05 13:33:08','YYYY-MM-DD HH24:MI:SS'),'D','Identifies a Business Partner',100,100,'Business Partner ','=',0,'N',40,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','68f8eff0-35d3-4e0d-bc70-aac61ef34890',30,200134,'Y','Y','C_BPartner_ID',TO_TIMESTAMP('2014-06-05 13:33:08','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 1:37:22 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_Reference_Value_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200011,200085,'N','Y',203628,'a.DocSource',TO_TIMESTAMP('2014-06-05 13:37:19','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Document Source','=',0,'N',50,'58dafeef-0bde-4fc7-9b66-d74f08fb8f31',17,200135,'Y','Y','DocSource',TO_TIMESTAMP('2014-06-05 13:37:19','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 1:37:40 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,QueryFunction,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200011,'Y','Y',268,'a.DateOrdered',TO_TIMESTAMP('2014-06-05 13:37:40','YYYY-MM-DD HH24:MI:SS'),'D','Date of Order',100,100,'Date Ordered','=',0,'N',60,'Indicates the Date an item was ordered.','56828510-44b7-4212-b5f6-968e9bef193e',15,200136,'N','Y','Trunc','DateOrdered',TO_TIMESTAMP('2014-06-05 13:37:40','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 1:38:17 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200011,'Y','Y',598,'a.TotalLines',TO_TIMESTAMP('2014-06-05 13:37:54','YYYY-MM-DD HH24:MI:SS'),'D','Total of all document lines',100,100,'Total Lines',0,'N',70,'The Total amount displays the total of all lines in document currency','a114a2f8-9d50-4c5b-944f-ea51d7a7c659',12,200137,'N','Y','TotalLines',TO_TIMESTAMP('2014-06-05 13:37:54','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 1:38:31 PM CEST
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2014-06-05 13:38:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200011
;

-- Jun 5, 2014 1:39:03 PM CEST
INSERT INTO AD_Menu (EntityType,Created,UpdatedBy,IsSummary,AD_Menu_ID,IsReadOnly,IsCentrallyMaintained,Name,Description,AD_Menu_UU,"action",AD_InfoWindow_ID,IsSOTrx,IsActive,CreatedBy,Updated,AD_Client_ID,AD_Org_ID) VALUES ('D',TO_TIMESTAMP('2014-06-05 13:39:02','YYYY-MM-DD HH24:MI:SS'),100,'N',200083,'N','Y','Generate Invoices (manual)','Select and generate invoices Info Window','56b27cac-0a4f-4531-8b56-96a7e5967e31','I',200011,'N','Y',100,TO_TIMESTAMP('2014-06-05 13:39:02','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 1:39:03 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200083, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200083)
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=458, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=217
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=458, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200083
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=458, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=192
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=458, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=178
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=458, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=377
;

-- Jun 5, 2014 1:39:07 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=458, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=347
;

-- Jun 5, 2014 1:40:27 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='O',Updated=TO_TIMESTAMP('2014-06-05 13:40:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200135
;

-- Jul 19, 2022, 9:02:07 AM CEST
UPDATE AD_Column SET FieldLength=22, AD_Reference_ID=17, AD_Reference_Value_ID=200085,Updated=TO_TIMESTAMP('2022-07-19 09:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215091
;

-- Jul 19, 2022, 9:08:45 AM CEST
UPDATE AD_ViewColumn SET SeqNo=120,Updated=TO_TIMESTAMP('2022-07-19 09:08:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217398
;

-- Jul 19, 2022, 9:08:49 AM CEST
UPDATE AD_ViewColumn SET SeqNo=130,Updated=TO_TIMESTAMP('2022-07-19 09:08:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217395
;

-- Jul 19, 2022, 9:08:52 AM CEST
UPDATE AD_ViewColumn SET SeqNo=140,Updated=TO_TIMESTAMP('2022-07-19 09:08:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217396
;

-- Jul 19, 2022, 9:08:55 AM CEST
UPDATE AD_ViewColumn SET SeqNo=150,Updated=TO_TIMESTAMP('2022-07-19 09:08:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217397
;

-- Jul 19, 2022, 9:55:27 AM CEST
UPDATE AD_InfoColumn SET IsQueryCriteria='N',Updated=TO_TIMESTAMP('2022-07-19 09:55:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200131
;

-- Jul 19, 2022, 10:02:09 AM CEST
UPDATE AD_InfoColumn SET SeqNoSelection=10,Updated=TO_TIMESTAMP('2022-07-19 10:02:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200135
;

-- Jul 19, 2022, 10:02:24 AM CEST
UPDATE AD_InfoColumn SET SeqNoSelection=30,Updated=TO_TIMESTAMP('2022-07-19 10:02:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200134
;

-- Jul 19, 2022, 10:06:21 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200243,0,0,'Y',TO_TIMESTAMP('2022-07-19 10:06:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 10:06:21','YYYY-MM-DD HH24:MI:SS'),100,'Invoice Rule','Frequency and method of invoicing ','The Invoice Rule defines how a Business Partner is invoiced and the frequency of invoicing.',200011,'D','a.InvoiceRule',80,'Y','Y',559,17,'562cd86f-8023-4a99-85dc-0c14a05de57a',150,'Y','InvoiceRule','=','N',20,'N','N','Y','N')
;

-- Jul 19, 2022, 11:16:46 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200244,0,0,'Y',TO_TIMESTAMP('2022-07-19 11:16:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 11:16:46','YYYY-MM-DD HH24:MI:SS'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200011,'D','a.C_DocType_ID',90,'N','Y',196,19,'c202a51f-8a1f-4b48-b1d0-f078561306c1','Y','C_DocType_ID','=','N',40,'N','N','Y','N')
;

-- Jul 19, 2022, 11:17:24 AM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200245,0,0,'Y',TO_TIMESTAMP('2022-07-19 11:17:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 11:17:24','YYYY-MM-DD HH24:MI:SS'),100,'Date Ordered','Date of Order','Indicates the Date an item was ordered.',200011,'D','a.DateOrdered',100,'N','Y',268,16,'6b47eeda-ce51-4049-be5e-8a923d9efe37','Y','DateOrdered','<=','N',50,'N','N','Y','N')
;

-- Jul 19, 2022, 11:19:37 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=15, QueryFunction='Trunc',Updated=TO_TIMESTAMP('2022-07-19 11:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200245
;

-- Jul 19, 2022, 11:24:42 AM CEST
UPDATE AD_InfoColumn SET DisplayLogic='@DocSource@=''O''',Updated=TO_TIMESTAMP('2022-07-19 11:24:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200243
;

-- Jul 19, 2022, 11:25:09 AM CEST
UPDATE AD_InfoColumn SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-07-19 11:25:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200135
;

-- Jul 19, 2022, 11:37:13 AM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200208,'C_DocType S.Order + RMA','T',0,0,'Y',TO_TIMESTAMP('2022-07-19 11:37:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 11:37:12','YYYY-MM-DD HH24:MI:SS'),100,'D','N','fddc29fc-46cf-4b27-935c-7909f05501b7')
;

-- Jul 19, 2022, 11:38:00 AM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200208,217,1501,1509,'C_DocType.DocBaseType=''SOO'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@ AND C_DocType.DocSubTypeSO NOT IN (''OB'', ''ON'')',0,0,'Y',TO_TIMESTAMP('2022-07-19 11:38:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 11:38:00','YYYY-MM-DD HH24:MI:SS'),100,'N','D','2ebea6bd-5bd2-46bd-8d7b-24336081cc4e')
;

-- Jul 19, 2022, 11:38:18 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=18, AD_Reference_Value_ID=200208,Updated=TO_TIMESTAMP('2022-07-19 11:38:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200244
;

-- Jul 19, 2022, 11:59:38 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200399,0,0,'Y',TO_TIMESTAMP('2022-07-19 11:59:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 11:59:37','YYYY-MM-DD HH24:MI:SS'),100,'Date Invoiced','Date printed on Invoice','The Date Invoice indicates the date printed on the invoice.',134,10,15,'N',0,'N','@#Date@','DateInvoiced','Y','D',267,'958980bd-9635-482f-bdbc-7d3e4d6ee590','N','N')
;

-- Jul 19, 2022, 12:00:16 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200400,0,0,'Y',TO_TIMESTAMP('2022-07-19 12:00:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:00:16','YYYY-MM-DD HH24:MI:SS'),100,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',134,20,17,135,'N',219,1,'Y','CO','DocAction','Y','D',287,'9753bdd6-5261-4c17-a909-15c204e4429c','N','N')
;

-- Jul 19, 2022, 12:00:57 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200401,0,0,'Y',TO_TIMESTAMP('2022-07-19 12:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:00:57','YYYY-MM-DD HH24:MI:SS'),100,'Consolidate to one Document','Consolidate Lines into one Document',134,30,20,'N',0,'Y','Y','ConsolidateDocument','Y','D',2182,'a89af796-6c5c-4d34-99cb-c08896983ae7','N','N')
;

-- Jul 19, 2022, 12:01:46 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200402,0,0,'Y',TO_TIMESTAMP('2022-07-19 12:01:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:01:46','YYYY-MM-DD HH24:MI:SS'),100,'Minimum Amt','Minimum Amount in Document Currency',134,40,12,'N',22,'N','MinimumAmt','Y','D',2177,'6a5756b3-3095-43ce-a5b0-4ab51402bf64','N','N')
;

-- Jul 19, 2022, 12:02:33 PM CEST
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,DisplayLogic,EntityType) VALUES (200011,'30f9b146-42bb-4450-b5ef-1fdaf896aae3',0,0,'Y',TO_TIMESTAMP('2022-07-19 12:02:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:02:33','YYYY-MM-DD HH24:MI:SS'),100,10,134,200011,'B','@DocSource@=''O''','D')
;

-- Jul 19, 2022, 12:17:57 PM CEST
UPDATE AD_InfoColumn SET SeqNoSelection=60,Updated=TO_TIMESTAMP('2022-07-19 12:17:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200243
;

-- Jul 19, 2022, 12:24:26 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200403,0,0,'Y',TO_TIMESTAMP('2022-07-19 12:24:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:24:26','YYYY-MM-DD HH24:MI:SS'),100,'Date Invoiced','Date printed on Invoice','The Date Invoice indicates the date printed on the invoice.',52002,10,15,'N',0,'N','@#Date@','DateInvoiced','Y','D',267,'9bddd698-dcb7-4b33-9481-4cbd7804583e','N','N')
;

-- Jul 19, 2022, 12:24:46 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200404,0,0,'Y',TO_TIMESTAMP('2022-07-19 12:24:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:24:46','YYYY-MM-DD HH24:MI:SS'),100,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',52002,20,17,135,'N',219,1,'Y','CO','DocAction','Y','D',287,'6f538814-bc87-4249-8cf1-42ea6f16841e','N','N')
;

-- Jul 19, 2022, 12:25:22 PM CEST
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,DisplayLogic,EntityType) VALUES (200012,'9f93bf86-891b-42aa-bc97-db25d45d8b96',0,0,'Y',TO_TIMESTAMP('2022-07-19 12:25:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-19 12:25:22','YYYY-MM-DD HH24:MI:SS'),100,20,52002,200011,'B','@DocSource@=''R''','D')
;

-- Jul 19, 2022, 3:05:38 PM CEST
UPDATE AD_Process SET Name='Generate Invoices for RMA', Description='Generate Invoices from open RMA based on selection.',Updated=TO_TIMESTAMP('2022-07-19 15:05:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=52002
;

-- Jul 21, 2022, 8:00:45 AM CEST
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2022-07-21 08:00:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=217
;

-- Jul 21, 2022, 8:15:11 AM CEST
UPDATE AD_Reference SET Name='DocSource Generate Shipments/Invoices (manual)',Updated=TO_TIMESTAMP('2022-07-21 08:15:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200085
;

-- Jul 21, 2022, 8:15:21 AM CEST
UPDATE AD_Ref_List SET Name='RMA',Updated=TO_TIMESTAMP('2022-07-21 08:15:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200191
;

-- Aug 1, 2022, 2:03:41 PM CEST
UPDATE AD_InfoWindow SET IsShowInDashboard='N',Updated=TO_TIMESTAMP('2022-08-01 14:03:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200011
;
