-- IDEMPIERE-5576
SELECT register_migration_script('202302151600_IDEMPIERE-5576.sql') FROM dual;

-- Feb 15, 2023, 4:00:40 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM gl_journal
JOIN C_DocType dt ON (dt.C_DocType_ID = gl_journal.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200184
;

-- Feb 15, 2023, 4:01:20 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217664,'b05f5fd1-d181-49fd-b0f9-234dea42c0d9',TO_TIMESTAMP('2023-02-15 16:01:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:01:20','YYYY-MM-DD HH24:MI:SS'),100,200184,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:01:35 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM c_projectissue pi
JOIN c_project p ON pi.c_project_id = p.c_project_id
JOIN C_DocType dt ON (dt.C_DocType_ID = gl_journal.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:01:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200185
;

-- Feb 15, 2023, 4:02:24 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM c_projectissue pi
JOIN c_project p ON pi.c_project_id = p.c_project_id',Updated=TO_TIMESTAMP('2023-02-15 16:02:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200185
;

-- Feb 15, 2023, 4:03:24 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217665,'d3fef2c7-5e1a-4671-bc66-78345bc88239',TO_TIMESTAMP('2023-02-15 16:03:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:03:24','YYYY-MM-DD HH24:MI:SS'),100,200185,'DocBaseType','''PJI''',190)
;

-- Feb 15, 2023, 4:05:02 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM c_invoice
JOIN C_DocType dt ON (dt.C_DocType_ID = c_invoice.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:05:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200186
;

-- Feb 15, 2023, 4:05:25 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217666,'c61efe93-99b7-481c-9cc7-e793a9dee882',TO_TIMESTAMP('2023-02-15 16:05:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:05:25','YYYY-MM-DD HH24:MI:SS'),100,200186,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:05:43 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM m_inout
JOIN C_DocType dt ON (dt.C_DocType_ID = m_inout.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:05:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200187
;

-- Feb 15, 2023, 4:05:56 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217667,'644739b6-e562-49c9-96f3-5c0cd0d98840',TO_TIMESTAMP('2023-02-15 16:05:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:05:56','YYYY-MM-DD HH24:MI:SS'),100,200187,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:06:10 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM m_inventory
JOIN C_DocType dt ON (dt.C_DocType_ID = m_inout.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:06:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200188
;

-- Feb 15, 2023, 4:06:15 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM m_inventory
JOIN C_DocType dt ON (dt.C_DocType_ID = m_inventory.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:06:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200188
;

-- Feb 15, 2023, 4:06:29 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217668,'396ea9d6-4315-4005-ac6b-cdf8d8e1c6e1',TO_TIMESTAMP('2023-02-15 16:06:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:06:28','YYYY-MM-DD HH24:MI:SS'),100,200188,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:06:50 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM m_movement
JOIN C_DocType dt ON (dt.C_DocType_ID = m_movement.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:06:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200189
;

-- Feb 15, 2023, 4:07:04 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217669,'a6dbd2cd-2389-4bdb-a594-684f6a3bbe36',TO_TIMESTAMP('2023-02-15 16:07:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:07:04','YYYY-MM-DD HH24:MI:SS'),100,200189,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:08:11 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217670,'c6da5312-86f0-4bf1-91f7-6ef225ef28bc',TO_TIMESTAMP('2023-02-15 16:08:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:08:11','YYYY-MM-DD HH24:MI:SS'),100,200190,'DocBaseType','''MMP''',190)
;

-- Feb 15, 2023, 4:09:27 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217671,'84f31efa-c328-47bf-b4e3-dd7c50e681b5',TO_TIMESTAMP('2023-02-15 16:09:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:09:27','YYYY-MM-DD HH24:MI:SS'),100,200191,'DocBaseType','''CMC''',190)
;

-- Feb 15, 2023, 4:10:13 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM c_payment
JOIN C_DocType dt ON (dt.C_DocType_ID = c_payment.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200192
;

-- Feb 15, 2023, 4:10:30 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217672,'7d75c5ab-d876-4f37-8684-3c0de093ffd2',TO_TIMESTAMP('2023-02-15 16:10:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:10:30','YYYY-MM-DD HH24:MI:SS'),100,200192,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:11:00 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM c_allocationhdr
JOIN C_DocType dt ON (dt.C_DocType_ID = c_allocationhdr.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:11:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200193
;

-- Feb 15, 2023, 4:11:12 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217673,'5b70981d-baa5-4ec0-a504-bda44e640242',TO_TIMESTAMP('2023-02-15 16:11:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:11:12','YYYY-MM-DD HH24:MI:SS'),100,200193,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:12:06 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217674,'90057648-29ab-4ffc-b59a-bf5b421b13a0',TO_TIMESTAMP('2023-02-15 16:12:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:12:06','YYYY-MM-DD HH24:MI:SS'),100,200194,'DocBaseType','''CMB''',190)
;

-- Feb 15, 2023, 4:12:51 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217675,'ed743bd2-3385-4a96-94b8-2aa68c0ce0e2',TO_TIMESTAMP('2023-02-15 16:12:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:12:51','YYYY-MM-DD HH24:MI:SS'),100,200195,'DocBaseType','''MXI''',190)
;

-- Feb 15, 2023, 4:13:42 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217676,'0b747223-4ae9-4971-90b9-a3841b52559f',TO_TIMESTAMP('2023-02-15 16:13:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:13:42','YYYY-MM-DD HH24:MI:SS'),100,200196,'DocBaseType','''MXP''',190)
;

-- Feb 15, 2023, 4:14:02 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM c_order
JOIN C_DocType dt ON (dt.C_DocType_ID = c_order.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200197
;

-- Feb 15, 2023, 4:14:17 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217677,'1efbd02f-7cd0-4674-b182-f8f30143244d',TO_TIMESTAMP('2023-02-15 16:14:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:14:17','YYYY-MM-DD HH24:MI:SS'),100,200197,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:14:50 PM CET
UPDATE AD_ViewComponent SET FromClause='FROM m_requisition
JOIN C_DocType dt ON (dt.C_DocType_ID = m_requisition.C_DocType_ID)',Updated=TO_TIMESTAMP('2023-02-15 16:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200198
;

-- Feb 15, 2023, 4:15:01 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217678,'c402fbf4-f73b-47b9-a22a-cf0b6f45e572',TO_TIMESTAMP('2023-02-15 16:15:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-02-15 16:15:00','YYYY-MM-DD HH24:MI:SS'),100,200198,'DocBaseType','dt.DocBaseType',190)
;

-- Feb 15, 2023, 4:15:19 PM CET
CREATE OR REPLACE VIEW RV_UnPosted(AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy, IsActive, DocumentNo, DateDoc, DateAcct, AD_Table_ID, Record_ID, IsSOTrx, Posted, Processing, Processed, DocStatus, ProcessedOn, DocBaseType) AS SELECT gl_journal.ad_client_id AS AD_Client_ID, gl_journal.ad_org_id AS AD_Org_ID, gl_journal.created AS Created, gl_journal.createdby AS CreatedBy, gl_journal.updated AS Updated, gl_journal.updatedby AS UpdatedBy, gl_journal.isactive AS IsActive, gl_journal.documentno AS DocumentNo, gl_journal.datedoc AS DateDoc, gl_journal.dateacct AS DateAcct, 224 AS AD_Table_ID, gl_journal.gl_journal_id AS Record_ID, 'N' AS IsSOTrx, gl_journal.posted AS Posted, gl_journal.processing AS Processing, gl_journal.processed AS Processed, gl_journal.docstatus AS DocStatus, gl_journal.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM gl_journal JOIN C_DocType dt ON (dt.C_DocType_ID = gl_journal.C_DocType_ID) WHERE gl_journal.posted <> 'Y' AND gl_journal.docstatus <> 'VO' UNION SELECT pi.ad_client_id AS AD_Client_ID, pi.ad_org_id AS AD_Org_ID, pi.created AS Created, pi.createdby AS CreatedBy, pi.updated AS Updated, pi.updatedby AS UpdatedBy, pi.isactive AS IsActive, (p.name || '_') || pi.line AS DocumentNo, pi.movementdate AS DateDoc, pi.movementdate AS DateAcct, 623 AS AD_Table_ID, pi.c_projectissue_id AS Record_ID, 'N' AS IsSOTrx, pi.posted AS Posted, pi.processing AS Processing, pi.processed AS Processed, 'CO' AS DocStatus, pi.processedon AS ProcessedOn, 'PJI' AS DocBaseType FROM c_projectissue pi JOIN c_project p ON pi.c_project_id = p.c_project_id WHERE pi.posted <> 'Y' UNION SELECT c_invoice.ad_client_id AS AD_Client_ID, c_invoice.ad_org_id AS AD_Org_ID, c_invoice.created AS Created, c_invoice.createdby AS CreatedBy, c_invoice.updated AS Updated, c_invoice.updatedby AS UpdatedBy, c_invoice.isactive AS IsActive, c_invoice.documentno AS DocumentNo, c_invoice.dateinvoiced AS DateDoc, c_invoice.dateacct AS DateAcct, 318 AS AD_Table_ID, c_invoice.c_invoice_id AS Record_ID, c_invoice.issotrx AS IsSOTrx, c_invoice.posted AS Posted, c_invoice.processing AS Processing, c_invoice.processed AS Processed, c_invoice.docstatus AS DocStatus, c_invoice.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM c_invoice JOIN C_DocType dt ON (dt.C_DocType_ID = c_invoice.C_DocType_ID) WHERE c_invoice.posted <> 'Y' AND c_invoice.docstatus <> 'VO' UNION SELECT m_inout.ad_client_id AS AD_Client_ID, m_inout.ad_org_id AS AD_Org_ID, m_inout.created AS Created, m_inout.createdby AS CreatedBy, m_inout.updated AS Updated, m_inout.updatedby AS UpdatedBy, m_inout.isactive AS IsActive, m_inout.documentno AS DocumentNo, m_inout.movementdate AS DateDoc, m_inout.dateacct AS DateAcct, 319 AS AD_Table_ID, m_inout.m_inout_id AS Record_ID, m_inout.issotrx AS IsSOTrx, m_inout.posted AS Posted, m_inout.processing AS Processing, m_inout.processed AS Processed, m_inout.docstatus AS DocStatus, m_inout.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM m_inout JOIN C_DocType dt ON (dt.C_DocType_ID = m_inout.C_DocType_ID) WHERE m_inout.posted <> 'Y' AND m_inout.docstatus <> 'VO' UNION SELECT m_inventory.ad_client_id AS AD_Client_ID, m_inventory.ad_org_id AS AD_Org_ID, m_inventory.created AS Created, m_inventory.createdby AS CreatedBy, m_inventory.updated AS Updated, m_inventory.updatedby AS UpdatedBy, m_inventory.isactive AS IsActive, m_inventory.documentno AS DocumentNo, m_inventory.movementdate AS DateDoc, m_inventory.movementdate AS DateAcct, 321 AS AD_Table_ID, m_inventory.m_inventory_id AS Record_ID, 'N' AS IsSOTrx, m_inventory.posted AS Posted, m_inventory.processing AS Processing, m_inventory.processed AS Processed, m_inventory.docstatus AS DocStatus, m_inventory.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM m_inventory JOIN C_DocType dt ON (dt.C_DocType_ID = m_inventory.C_DocType_ID) WHERE m_inventory.posted <> 'Y' AND m_inventory.docstatus <> 'VO' UNION SELECT m_movement.ad_client_id AS AD_Client_ID, m_movement.ad_org_id AS AD_Org_ID, m_movement.created AS Created, m_movement.createdby AS CreatedBy, m_movement.updated AS Updated, m_movement.updatedby AS UpdatedBy, m_movement.isactive AS IsActive, m_movement.documentno AS DocumentNo, m_movement.movementdate AS DateDoc, m_movement.movementdate AS DateAcct, 323 AS AD_Table_ID, m_movement.m_movement_id AS Record_ID, 'N' AS IsSOTrx, m_movement.posted AS Posted, m_movement.processing AS Processing, m_movement.processed AS Processed, m_movement.docstatus AS DocStatus, m_movement.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM m_movement JOIN C_DocType dt ON (dt.C_DocType_ID = m_movement.C_DocType_ID) WHERE m_movement.posted <> 'Y' AND m_movement.docstatus <> 'VO' UNION SELECT m_production.ad_client_id AS AD_Client_ID, m_production.ad_org_id AS AD_Org_ID, m_production.created AS Created, m_production.createdby AS CreatedBy, m_production.updated AS Updated, m_production.updatedby AS UpdatedBy, m_production.isactive AS IsActive, m_production.documentno AS DocumentNo, m_production.movementdate AS DateDoc, m_production.movementdate AS DateAcct, 325 AS AD_Table_ID, m_production.m_production_id AS Record_ID, 'N' AS IsSOTrx, m_production.posted AS Posted, m_production.processing AS Processing, m_production.processed AS Processed, m_production.docstatus AS DocStatus, m_production.processedon AS ProcessedOn, 'MMP' AS DocBaseType FROM m_production WHERE m_production.posted <> 'Y' AND m_production.docstatus <> 'VO' UNION SELECT c_cash.ad_client_id AS AD_Client_ID, c_cash.ad_org_id AS AD_Org_ID, c_cash.created AS Created, c_cash.createdby AS CreatedBy, c_cash.updated AS Updated, c_cash.updatedby AS UpdatedBy, c_cash.isactive AS IsActive, c_cash.name AS DocumentNo, c_cash.statementdate AS DateDoc, c_cash.dateacct AS DateAcct, 407 AS AD_Table_ID, c_cash.c_cash_id AS Record_ID, 'N' AS IsSOTrx, c_cash.posted AS Posted, c_cash.processing AS Processing, c_cash.processed AS Processed, c_cash.docstatus AS DocStatus, c_cash.processedon AS ProcessedOn, 'CMC' AS DocBaseType FROM c_cash WHERE c_cash.posted <> 'Y' AND c_cash.docstatus <> 'VO' UNION SELECT c_payment.ad_client_id AS AD_Client_ID, c_payment.ad_org_id AS AD_Org_ID, c_payment.created AS Created, c_payment.createdby AS CreatedBy, c_payment.updated AS Updated, c_payment.updatedby AS UpdatedBy, c_payment.isactive AS IsActive, c_payment.documentno AS DocumentNo, c_payment.datetrx AS DateDoc, c_payment.dateacct AS DateAcct, 335 AS AD_Table_ID, c_payment.c_payment_id AS Record_ID, 'N' AS IsSOTrx, c_payment.posted AS Posted, c_payment.processing AS Processing, c_payment.processed AS Processed, c_payment.docstatus AS DocStatus, c_payment.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM c_payment JOIN C_DocType dt ON (dt.C_DocType_ID = c_payment.C_DocType_ID) WHERE c_payment.posted <> 'Y' AND c_payment.docstatus <> 'VO' UNION SELECT c_allocationhdr.ad_client_id AS AD_Client_ID, c_allocationhdr.ad_org_id AS AD_Org_ID, c_allocationhdr.created AS Created, c_allocationhdr.createdby AS CreatedBy, c_allocationhdr.updated AS Updated, c_allocationhdr.updatedby AS UpdatedBy, c_allocationhdr.isactive AS IsActive, c_allocationhdr.documentno AS DocumentNo, c_allocationhdr.datetrx AS DateDoc, c_allocationhdr.dateacct AS DateAcct, 735 AS AD_Table_ID, c_allocationhdr.c_allocationhdr_id AS Record_ID, 'N' AS IsSOTrx, c_allocationhdr.posted AS Posted, c_allocationhdr.processing AS Processing, c_allocationhdr.processed AS Processed, c_allocationhdr.docstatus AS DocStatus, c_allocationhdr.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM c_allocationhdr JOIN C_DocType dt ON (dt.C_DocType_ID = c_allocationhdr.C_DocType_ID) WHERE c_allocationhdr.posted <> 'Y' AND c_allocationhdr.docstatus <> 'VO' UNION SELECT c_bankstatement.ad_client_id AS AD_Client_ID, c_bankstatement.ad_org_id AS AD_Org_ID, c_bankstatement.created AS Created, c_bankstatement.createdby AS CreatedBy, c_bankstatement.updated AS Updated, c_bankstatement.updatedby AS UpdatedBy, c_bankstatement.isactive AS IsActive, c_bankstatement.name AS DocumentNo, c_bankstatement.statementdate AS DateDoc, c_bankstatement.statementdate AS DateAcct, 392 AS AD_Table_ID, c_bankstatement.c_bankstatement_id AS Record_ID, 'N' AS IsSOTrx, c_bankstatement.posted AS Posted, c_bankstatement.processing AS Processing, c_bankstatement.processed AS Processed, c_bankstatement.docstatus AS DocStatus, c_bankstatement.processedon AS ProcessedOn, 'CMB' AS DocBaseType FROM c_bankstatement WHERE c_bankstatement.posted <> 'Y' AND c_bankstatement.docstatus <> 'VO' UNION SELECT m_matchinv.ad_client_id AS AD_Client_ID, m_matchinv.ad_org_id AS AD_Org_ID, m_matchinv.created AS Created, m_matchinv.createdby AS CreatedBy, m_matchinv.updated AS Updated, m_matchinv.updatedby AS UpdatedBy, m_matchinv.isactive AS IsActive, m_matchinv.documentno AS DocumentNo, m_matchinv.datetrx AS DateDoc, m_matchinv.dateacct AS DateAcct, 472 AS AD_Table_ID, m_matchinv.m_matchinv_id AS Record_ID, 'N' AS IsSOTrx, m_matchinv.posted AS Posted, m_matchinv.processing AS Processing, m_matchinv.processed AS Processed, 'CO' AS DocStatus, m_matchinv.processedon AS ProcessedOn, 'MXI' AS DocBaseType FROM m_matchinv WHERE m_matchinv.posted <> 'Y' UNION SELECT m_matchpo.ad_client_id AS AD_Client_ID, m_matchpo.ad_org_id AS AD_Org_ID, m_matchpo.created AS Created, m_matchpo.createdby AS CreatedBy, m_matchpo.updated AS Updated, m_matchpo.updatedby AS UpdatedBy, m_matchpo.isactive AS IsActive, m_matchpo.documentno AS DocumentNo, m_matchpo.datetrx AS DateDoc, m_matchpo.dateacct AS DateAcct, 473 AS AD_Table_ID, m_matchpo.m_matchpo_id AS Record_ID, 'N' AS IsSOTrx, m_matchpo.posted AS Posted, m_matchpo.processing AS Processing, m_matchpo.processed AS Processed, 'CO' AS DocStatus, m_matchpo.processedon AS ProcessedOn, 'MXP' AS DocBaseType FROM m_matchpo WHERE m_matchpo.posted <> 'Y' UNION SELECT c_order.ad_client_id AS AD_Client_ID, c_order.ad_org_id AS AD_Org_ID, c_order.created AS Created, c_order.createdby AS CreatedBy, c_order.updated AS Updated, c_order.updatedby AS UpdatedBy, c_order.isactive AS IsActive, c_order.documentno AS DocumentNo, c_order.dateordered AS DateDoc, c_order.dateacct AS DateAcct, 259 AS AD_Table_ID, c_order.c_order_id AS Record_ID, c_order.issotrx AS IsSOTrx, c_order.posted AS Posted, c_order.processing AS Processing, c_order.processed AS Processed, c_order.docstatus AS DocStatus, c_order.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM c_order JOIN C_DocType dt ON (dt.C_DocType_ID = c_order.C_DocType_ID) WHERE c_order.posted <> 'Y' AND c_order.docstatus <> 'VO' UNION SELECT m_requisition.ad_client_id AS AD_Client_ID, m_requisition.ad_org_id AS AD_Org_ID, m_requisition.created AS Created, m_requisition.createdby AS CreatedBy, m_requisition.updated AS Updated, m_requisition.updatedby AS UpdatedBy, m_requisition.isactive AS IsActive, m_requisition.documentno AS DocumentNo, m_requisition.datedoc AS DateDoc, m_requisition.datedoc AS DateAcct, 702 AS AD_Table_ID, m_requisition.m_requisition_id AS Record_ID, 'N' AS IsSOTrx, m_requisition.posted AS Posted, m_requisition.processing AS Processing, m_requisition.processed AS Processed, m_requisition.docstatus AS DocStatus, m_requisition.processedon AS ProcessedOn, dt.DocBaseType AS DocBaseType FROM m_requisition JOIN C_DocType dt ON (dt.C_DocType_ID = m_requisition.C_DocType_ID) WHERE m_requisition.posted <> 'Y' AND m_requisition.docstatus <> 'VO'
;

-- Feb 15, 2023, 4:21:03 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215773,0,'Document Base Type','Logical type of document','The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.',635,'DocBaseType',3,'N','N','N','N','N',0,'N',17,183,0,0,'Y',TO_TIMESTAMP('2023-02-15 16:21:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-15 16:21:03','YYYY-MM-DD HH24:MI:SS'),100,865,'Y','N','D','N','N','N','Y','c6662d1a-bf48-424d-9c5e-7401593ead48','Y',0,'N','N','N')
;

-- Feb 15, 2023, 4:21:13 PM CET
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2023-02-15 16:21:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215773
;

-- Feb 15, 2023, 4:21:37 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207568,'Document Base Type','Logical type of document','The Document Base Type identifies the base or starting point for a document.  Multiple document types may share a single document base type.',662,215773,'Y',0,130,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-02-15 16:21:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-15 16:21:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aef2777c-c571-4e8d-81ea-146af48ebd08','Y',130,1,1,1,'N','N','N','N')
;

-- Feb 15, 2023, 4:22:21 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-02-15 16:22:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207568
;

-- Feb 15, 2023, 4:22:21 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-02-15 16:22:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58842
;

-- Feb 15, 2023, 4:52:24 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Post all Unposted Documents before closing the Period.',0,0,'Y',TO_TIMESTAMP('2023-02-15 16:52:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-15 16:52:24','YYYY-MM-DD HH24:MI:SS'),100,200821,'PostUnpostedDocs','D','ec123347-25d8-4305-9392-e10d7c6c4e2b')
;

