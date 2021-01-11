-- IDEMPIERE-4083 currency rate by document or by transaction
-- Nov 10, 2020, 5:09:35 PM CET
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,Referenced_Table_ID,SeqNo,FromClause) VALUES (0,0,200006,'78e6730d-9dd2-40e4-ac35-173b63c3ac54',TO_TIMESTAMP('2020-11-10 17:09:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','c_payment',TO_TIMESTAMP('2020-11-10 17:09:35','YYYY-MM-DD HH24:MI:SS'),100,554,335,10,'FROM c_payment')
;

-- Nov 10, 2020, 5:09:57 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200126,'a2023067-051a-4852-b58d-1803e4e15a19',TO_TIMESTAMP('2020-11-10 17:09:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:56','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_payment_id','c_payment.c_payment_id',10)
;

-- Nov 10, 2020, 5:09:57 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200127,'25019a47-7d5f-42d8-8889-3ca32766da25',TO_TIMESTAMP('2020-11-10 17:09:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:57','YYYY-MM-DD HH24:MI:SS'),100,200006,'ad_client_id','c_payment.ad_client_id',20)
;

-- Nov 10, 2020, 5:09:57 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200128,'ea46c076-26ea-40d4-8fcc-68a8a81a75e2',TO_TIMESTAMP('2020-11-10 17:09:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:57','YYYY-MM-DD HH24:MI:SS'),100,200006,'ad_org_id','c_payment.ad_org_id',30)
;

-- Nov 10, 2020, 5:09:58 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200129,'f3bc4f64-1c76-40ba-8eab-8a3722b7498d',TO_TIMESTAMP('2020-11-10 17:09:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:57','YYYY-MM-DD HH24:MI:SS'),100,200006,'isactive','c_payment.isactive',40)
;

-- Nov 10, 2020, 5:09:58 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200130,'6eb12857-87c7-486d-88cf-31798e6e4a2e',TO_TIMESTAMP('2020-11-10 17:09:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:58','YYYY-MM-DD HH24:MI:SS'),100,200006,'created','c_payment.created',50)
;

-- Nov 10, 2020, 5:09:58 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200131,'e5d20b02-d3d2-4b23-926f-465262927a21',TO_TIMESTAMP('2020-11-10 17:09:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:58','YYYY-MM-DD HH24:MI:SS'),100,200006,'createdby','c_payment.createdby',60)
;

-- Nov 10, 2020, 5:09:59 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200132,'deeb56d1-dafb-49bc-9eaf-0dfc704ee28f',TO_TIMESTAMP('2020-11-10 17:09:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:58','YYYY-MM-DD HH24:MI:SS'),100,200006,'updated','c_payment.updated',70)
;

-- Nov 10, 2020, 5:09:59 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200133,'3e0556d8-f05f-4259-b2d2-68a57f13b2ae',TO_TIMESTAMP('2020-11-10 17:09:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:59','YYYY-MM-DD HH24:MI:SS'),100,200006,'updatedby','c_payment.updatedby',80)
;

-- Nov 10, 2020, 5:09:59 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200134,'cb89a814-1cf5-4254-902e-6395a6f030ab',TO_TIMESTAMP('2020-11-10 17:09:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:09:59','YYYY-MM-DD HH24:MI:SS'),100,200006,'documentno','c_payment.documentno',90)
;

-- Nov 10, 2020, 5:10:00 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200135,'ca15d7a8-bf31-4768-8a9f-96cc22753575',TO_TIMESTAMP('2020-11-10 17:10:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:00','YYYY-MM-DD HH24:MI:SS'),100,200006,'datetrx','c_payment.datetrx',100)
;

-- Nov 10, 2020, 5:10:00 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200136,'3c3248f0-6f55-4d7e-8426-1a67589a9622',TO_TIMESTAMP('2020-11-10 17:10:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:00','YYYY-MM-DD HH24:MI:SS'),100,200006,'isreceipt','c_payment.isreceipt',110)
;

-- Nov 10, 2020, 5:10:00 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200137,'64ac21f5-96fd-4677-b7f3-5e364e8be322',TO_TIMESTAMP('2020-11-10 17:10:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:00','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_doctype_id','c_payment.c_doctype_id',120)
;

-- Nov 10, 2020, 5:10:01 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200138,'30b1f874-89b3-486e-981e-c80744ac95f5',TO_TIMESTAMP('2020-11-10 17:10:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:01','YYYY-MM-DD HH24:MI:SS'),100,200006,'trxtype','c_payment.trxtype',130)
;

-- Nov 10, 2020, 5:10:01 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200139,'7e741082-1f49-4429-a2ea-ff6c030518cb',TO_TIMESTAMP('2020-11-10 17:10:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:01','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_bankaccount_id','c_payment.c_bankaccount_id',140)
;

-- Nov 10, 2020, 5:10:02 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200140,'f90f5def-7b62-4984-a43f-7cef4f770407',TO_TIMESTAMP('2020-11-10 17:10:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:01','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_bpartner_id','c_payment.c_bpartner_id',150)
;

-- Nov 10, 2020, 5:10:02 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200141,'2caf1721-cb86-484c-9c05-a60659577776',TO_TIMESTAMP('2020-11-10 17:10:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:02','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_invoice_id','c_payment.c_invoice_id',160)
;

-- Nov 10, 2020, 5:10:02 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200142,'854337e7-9142-4a40-bf18-06bf4719e7b4',TO_TIMESTAMP('2020-11-10 17:10:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:02','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_bp_bankaccount_id','c_payment.c_bp_bankaccount_id',170)
;

-- Nov 10, 2020, 5:10:03 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200143,'2d09d469-a7df-405b-86c4-f0c2838eb5ad',TO_TIMESTAMP('2020-11-10 17:10:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:02','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_paymentbatch_id','c_payment.c_paymentbatch_id',180)
;

-- Nov 10, 2020, 5:10:03 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200144,'908f64c7-de3a-4295-bfb0-4e36b75e8138',TO_TIMESTAMP('2020-11-10 17:10:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:03','YYYY-MM-DD HH24:MI:SS'),100,200006,'tendertype','c_payment.tendertype',190)
;

-- Nov 10, 2020, 5:10:03 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200145,'d7820000-4e49-44dd-80d2-20e495dd65d8',TO_TIMESTAMP('2020-11-10 17:10:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:03','YYYY-MM-DD HH24:MI:SS'),100,200006,'creditcardtype','c_payment.creditcardtype',200)
;

-- Nov 10, 2020, 5:10:04 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200146,'b09a2e6f-a499-4339-889c-a8e11ae1039f',TO_TIMESTAMP('2020-11-10 17:10:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:03','YYYY-MM-DD HH24:MI:SS'),100,200006,'creditcardnumber','c_payment.creditcardnumber',210)
;

-- Nov 10, 2020, 5:10:04 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200147,'e548038c-d491-44b1-a2a0-95bf9ac1cac9',TO_TIMESTAMP('2020-11-10 17:10:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:04','YYYY-MM-DD HH24:MI:SS'),100,200006,'creditcardvv','c_payment.creditcardvv',220)
;

-- Nov 10, 2020, 5:10:04 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200148,'79f94e32-cce9-47fd-bc3b-7b7b976ec668',TO_TIMESTAMP('2020-11-10 17:10:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:04','YYYY-MM-DD HH24:MI:SS'),100,200006,'creditcardexpmm','c_payment.creditcardexpmm',230)
;

-- Nov 10, 2020, 5:10:05 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200149,'5a03f868-93af-4bf1-b7c6-42355669a9f4',TO_TIMESTAMP('2020-11-10 17:10:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:04','YYYY-MM-DD HH24:MI:SS'),100,200006,'creditcardexpyy','c_payment.creditcardexpyy',240)
;

-- Nov 10, 2020, 5:10:05 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200150,'69d29ea4-28b8-4c75-8e51-8e1e20d1229e',TO_TIMESTAMP('2020-11-10 17:10:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:05','YYYY-MM-DD HH24:MI:SS'),100,200006,'micr','c_payment.micr',250)
;

-- Nov 10, 2020, 5:10:05 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200151,'d4552a59-91dc-46ec-8c23-f3ce93106ecc',TO_TIMESTAMP('2020-11-10 17:10:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:05','YYYY-MM-DD HH24:MI:SS'),100,200006,'routingno','c_payment.routingno',260)
;

-- Nov 10, 2020, 5:10:06 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200152,'b82e5186-26a2-4883-aaa3-39d5a5e726f4',TO_TIMESTAMP('2020-11-10 17:10:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:05','YYYY-MM-DD HH24:MI:SS'),100,200006,'accountno','c_payment.accountno',270)
;

-- Nov 10, 2020, 5:10:06 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200153,'6d342b32-e260-4744-b435-b6a0a3b2a1de',TO_TIMESTAMP('2020-11-10 17:10:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:06','YYYY-MM-DD HH24:MI:SS'),100,200006,'checkno','c_payment.checkno',280)
;

-- Nov 10, 2020, 5:10:06 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200154,'4e7d5e50-4723-49af-8fd8-07845795c514',TO_TIMESTAMP('2020-11-10 17:10:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:06','YYYY-MM-DD HH24:MI:SS'),100,200006,'a_name','c_payment.a_name',290)
;

-- Nov 10, 2020, 5:10:07 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200155,'52c17e6b-7105-4e09-87d9-eab779b9b5e9',TO_TIMESTAMP('2020-11-10 17:10:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:06','YYYY-MM-DD HH24:MI:SS'),100,200006,'a_street','c_payment.a_street',300)
;

-- Nov 10, 2020, 5:10:07 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200156,'033d307a-3dea-493e-885a-f56a418cce97',TO_TIMESTAMP('2020-11-10 17:10:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:07','YYYY-MM-DD HH24:MI:SS'),100,200006,'a_city','c_payment.a_city',310)
;

-- Nov 10, 2020, 5:10:07 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200157,'aee5ffcc-00ca-4908-b1a3-3c75c8d86615',TO_TIMESTAMP('2020-11-10 17:10:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:07','YYYY-MM-DD HH24:MI:SS'),100,200006,'a_state','c_payment.a_state',320)
;

-- Nov 10, 2020, 5:10:08 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200158,'5c907d7f-2d0c-4fbb-a33b-e852d1ca0acf',TO_TIMESTAMP('2020-11-10 17:10:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:07','YYYY-MM-DD HH24:MI:SS'),100,200006,'a_zip','c_payment.a_zip',330)
;

-- Nov 10, 2020, 5:10:08 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200159,'e8b4e988-4c05-4bad-b3c5-f7459415bb10',TO_TIMESTAMP('2020-11-10 17:10:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:08','YYYY-MM-DD HH24:MI:SS'),100,200006,'a_ident_dl','c_payment.a_ident_dl',340)
;

-- Nov 10, 2020, 5:10:08 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200160,'afa9d04c-b6e6-44e7-afaa-6b678a4a3ecb',TO_TIMESTAMP('2020-11-10 17:10:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:08','YYYY-MM-DD HH24:MI:SS'),100,200006,'a_ident_ssn','c_payment.a_ident_ssn',350)
;

-- Nov 10, 2020, 5:10:09 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200161,'4684f7bb-bc89-40ca-a0f4-379f654f264b',TO_TIMESTAMP('2020-11-10 17:10:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:08','YYYY-MM-DD HH24:MI:SS'),100,200006,'a_email','c_payment.a_email',360)
;

-- Nov 10, 2020, 5:10:09 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200162,'5ae46091-5ffc-4ed2-8cf7-de58c93e2ba2',TO_TIMESTAMP('2020-11-10 17:10:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:09','YYYY-MM-DD HH24:MI:SS'),100,200006,'voiceauthcode','c_payment.voiceauthcode',370)
;

-- Nov 10, 2020, 5:10:09 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200163,'8a283d47-579c-405a-960c-6db15ecc08f9',TO_TIMESTAMP('2020-11-10 17:10:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:09','YYYY-MM-DD HH24:MI:SS'),100,200006,'orig_trxid','c_payment.orig_trxid',380)
;

-- Nov 10, 2020, 5:10:10 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200164,'dcb18fd6-1be0-4aca-a9f9-d0eb4bb666ef',TO_TIMESTAMP('2020-11-10 17:10:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:09','YYYY-MM-DD HH24:MI:SS'),100,200006,'ponum','c_payment.ponum',390)
;

-- Nov 10, 2020, 5:10:10 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200165,'b79cedf5-0e67-4449-9c0a-aa23d55f8c90',TO_TIMESTAMP('2020-11-10 17:10:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:10','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_currency_id','c_payment.c_currency_id',400)
;

-- Nov 10, 2020, 5:10:10 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200166,'f1ad3759-a1d8-4323-963a-1663eaba1a88',TO_TIMESTAMP('2020-11-10 17:10:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:10','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_conversiontype_id','c_payment.c_conversiontype_id',410)
;

-- Nov 10, 2020, 5:10:11 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200167,'7bf35c9f-dad1-4718-a55c-71a3c6e62ca4',TO_TIMESTAMP('2020-11-10 17:10:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:10','YYYY-MM-DD HH24:MI:SS'),100,200006,'payamt','CASE c_payment.isreceipt WHEN ''Y'' THEN c_payment.payamt ELSE c_payment.payamt * (-1) END',420)
;

-- Nov 10, 2020, 5:10:11 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200168,'f204c0f4-c5ce-4a1f-b3b8-6cdd35c769ee',TO_TIMESTAMP('2020-11-10 17:10:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:11','YYYY-MM-DD HH24:MI:SS'),100,200006,'discountamt','CASE c_payment.isreceipt WHEN ''Y'' THEN c_payment.discountamt ELSE c_payment.discountamt * (-1) END',430)
;

-- Nov 10, 2020, 5:10:11 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200169,'46b31e39-9928-44d2-b465-bed36a60d42f',TO_TIMESTAMP('2020-11-10 17:10:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:11','YYYY-MM-DD HH24:MI:SS'),100,200006,'writeoffamt','CASE c_payment.isreceipt WHEN ''Y'' THEN c_payment.writeoffamt ELSE c_payment.writeoffamt * (-1) END',440)
;

-- Nov 10, 2020, 5:10:12 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200170,'9019943a-a8b1-4bd6-9bde-4ef598c3f153',TO_TIMESTAMP('2020-11-10 17:10:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:11','YYYY-MM-DD HH24:MI:SS'),100,200006,'taxamt','CASE c_payment.isreceipt WHEN ''Y'' THEN c_payment.taxamt ELSE c_payment.taxamt * (-1) END',450)
;

-- Nov 10, 2020, 5:10:12 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200171,'cd28bade-62b3-4bc7-ac6c-eb09c89f6350',TO_TIMESTAMP('2020-11-10 17:10:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:12','YYYY-MM-DD HH24:MI:SS'),100,200006,'overunderamt','CASE c_payment.isreceipt WHEN ''Y'' THEN c_payment.overunderamt ELSE c_payment.overunderamt * (-1) END',460)
;

-- Nov 10, 2020, 5:10:12 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200172,'db24af2d-5ffc-4e4a-a77e-f9455818a0fb',TO_TIMESTAMP('2020-11-10 17:10:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:12','YYYY-MM-DD HH24:MI:SS'),100,200006,'multiplierap','CASE c_payment.isreceipt WHEN ''Y'' THEN 1 ELSE (-1) END',470)
;

-- Nov 10, 2020, 5:10:13 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200173,'cf18d63f-d129-4602-bad5-5bc1a062a8a4',TO_TIMESTAMP('2020-11-10 17:10:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:13','YYYY-MM-DD HH24:MI:SS'),100,200006,'isoverunderpayment','c_payment.isoverunderpayment',480)
;

-- Nov 10, 2020, 5:10:13 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200174,'cf91f9ce-1793-4d40-b275-79e1ca74d498',TO_TIMESTAMP('2020-11-10 17:10:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:13','YYYY-MM-DD HH24:MI:SS'),100,200006,'isapproved','c_payment.isapproved',490)
;

-- Nov 10, 2020, 5:10:13 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200175,'e42394fb-cc9e-4580-a9a3-ee3d8c54e55c',TO_TIMESTAMP('2020-11-10 17:10:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:13','YYYY-MM-DD HH24:MI:SS'),100,200006,'r_pnref','c_payment.r_pnref',500)
;

-- Nov 10, 2020, 5:10:14 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200176,'550bca62-566c-44a7-9f15-f5240bb769cd',TO_TIMESTAMP('2020-11-10 17:10:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:13','YYYY-MM-DD HH24:MI:SS'),100,200006,'r_result','c_payment.r_result',510)
;

-- Nov 10, 2020, 5:10:14 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200177,'7f085bc0-4af3-44c2-9922-8cf938a3fb3d',TO_TIMESTAMP('2020-11-10 17:10:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:14','YYYY-MM-DD HH24:MI:SS'),100,200006,'r_respmsg','c_payment.r_respmsg',520)
;

-- Nov 10, 2020, 5:10:14 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200178,'f6b8fd2c-1ba0-46b1-bce4-b84e2f8476a7',TO_TIMESTAMP('2020-11-10 17:10:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:14','YYYY-MM-DD HH24:MI:SS'),100,200006,'r_authcode','c_payment.r_authcode',530)
;

-- Nov 10, 2020, 5:10:15 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200179,'af44c734-502f-4f79-8560-befab64f6199',TO_TIMESTAMP('2020-11-10 17:10:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:14','YYYY-MM-DD HH24:MI:SS'),100,200006,'r_avsaddr','c_payment.r_avsaddr',540)
;

-- Nov 10, 2020, 5:10:15 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200180,'22a546d8-b559-4716-939a-62586ae2d680',TO_TIMESTAMP('2020-11-10 17:10:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:15','YYYY-MM-DD HH24:MI:SS'),100,200006,'r_avszip','c_payment.r_avszip',550)
;

-- Nov 10, 2020, 5:10:15 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200181,'d7376129-0a05-4063-99dc-8aadfc77ec7f',TO_TIMESTAMP('2020-11-10 17:10:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:15','YYYY-MM-DD HH24:MI:SS'),100,200006,'r_info','c_payment.r_info',560)
;

-- Nov 10, 2020, 5:10:16 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200182,'d88b96be-6110-46ad-89c5-d8326fb92888',TO_TIMESTAMP('2020-11-10 17:10:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:15','YYYY-MM-DD HH24:MI:SS'),100,200006,'processing','c_payment.processing',570)
;

-- Nov 10, 2020, 5:10:16 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200183,'36758fb9-bb76-4eff-ba2e-9f43d525e620',TO_TIMESTAMP('2020-11-10 17:10:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:16','YYYY-MM-DD HH24:MI:SS'),100,200006,'oprocessing','c_payment.oprocessing',580)
;

-- Nov 10, 2020, 5:10:16 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200184,'934f8810-b91f-446e-955d-0509a0bb65cc',TO_TIMESTAMP('2020-11-10 17:10:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:16','YYYY-MM-DD HH24:MI:SS'),100,200006,'docstatus','c_payment.docstatus',590)
;

-- Nov 10, 2020, 5:10:17 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200185,'8b1ef078-fa18-4243-a440-4c799682bd33',TO_TIMESTAMP('2020-11-10 17:10:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:16','YYYY-MM-DD HH24:MI:SS'),100,200006,'docaction','c_payment.docaction',600)
;

-- Nov 10, 2020, 5:10:17 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200186,'9c3ae0a2-6968-4bce-be9f-14666d36e199',TO_TIMESTAMP('2020-11-10 17:10:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:17','YYYY-MM-DD HH24:MI:SS'),100,200006,'isprepayment','c_payment.isprepayment',610)
;

-- Nov 10, 2020, 5:10:18 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200187,'74075ca5-aac4-4b66-b4f4-acdba7bfc3de',TO_TIMESTAMP('2020-11-10 17:10:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:17','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_charge_id','c_payment.c_charge_id',620)
;

-- Nov 10, 2020, 5:10:18 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200188,'3fe557ab-7b76-40d1-b498-b621795330e0',TO_TIMESTAMP('2020-11-10 17:10:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:18','YYYY-MM-DD HH24:MI:SS'),100,200006,'isreconciled','c_payment.isreconciled',630)
;

-- Nov 10, 2020, 5:10:18 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200189,'52c0c3b9-3cd8-493c-91b4-5a13d60b301d',TO_TIMESTAMP('2020-11-10 17:10:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:18','YYYY-MM-DD HH24:MI:SS'),100,200006,'isallocated','c_payment.isallocated',640)
;

-- Nov 10, 2020, 5:10:19 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200190,'83c16a02-20dc-49ce-8d21-b22d6e3253ec',TO_TIMESTAMP('2020-11-10 17:10:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:18','YYYY-MM-DD HH24:MI:SS'),100,200006,'isonline','c_payment.isonline',650)
;

-- Nov 10, 2020, 5:10:19 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200191,'b4740ce6-3422-4dda-8461-18ce9f13e482',TO_TIMESTAMP('2020-11-10 17:10:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:19','YYYY-MM-DD HH24:MI:SS'),100,200006,'processed','c_payment.processed',660)
;

-- Nov 10, 2020, 5:10:19 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200192,'34732777-29dc-4037-b61e-edf5a74f393b',TO_TIMESTAMP('2020-11-10 17:10:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:19','YYYY-MM-DD HH24:MI:SS'),100,200006,'posted','c_payment.posted',670)
;

-- Nov 10, 2020, 5:10:20 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200193,'cf7ba7b7-a1bf-41bd-b898-502735e5476c',TO_TIMESTAMP('2020-11-10 17:10:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:19','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_campaign_id','c_payment.c_campaign_id',680)
;

-- Nov 10, 2020, 5:10:20 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200194,'791f8238-3dd7-4d35-9b38-28768cc4a937',TO_TIMESTAMP('2020-11-10 17:10:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:20','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_project_id','c_payment.c_project_id',690)
;

-- Nov 10, 2020, 5:10:20 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200195,'33c0f0fa-c273-4717-98f4-1ac71184df61',TO_TIMESTAMP('2020-11-10 17:10:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:20','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_activity_id','c_payment.c_activity_id',700)
;

-- Nov 10, 2020, 5:10:21 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200196,'27d74a26-ac55-45b9-82d8-a79283d65d86',TO_TIMESTAMP('2020-11-10 17:10:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:20','YYYY-MM-DD HH24:MI:SS'),100,200006,'ad_orgtrx_id','c_payment.ad_orgtrx_id',710)
;

-- Nov 10, 2020, 5:10:21 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200197,'226a9a6b-8777-45e3-adca-1b8c27835e92',TO_TIMESTAMP('2020-11-10 17:10:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:21','YYYY-MM-DD HH24:MI:SS'),100,200006,'chargeamt','c_payment.chargeamt',720)
;

-- Nov 10, 2020, 5:10:21 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200198,'9bf5752f-64e5-45be-ba8a-a3767b770a73',TO_TIMESTAMP('2020-11-10 17:10:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:21','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_order_id','c_payment.c_order_id',730)
;

-- Nov 10, 2020, 5:10:22 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200199,'0a09ac57-a0c3-4104-864b-6cf3047a47b5',TO_TIMESTAMP('2020-11-10 17:10:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:21','YYYY-MM-DD HH24:MI:SS'),100,200006,'dateacct','c_payment.dateacct',740)
;

-- Nov 10, 2020, 5:10:22 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200200,'d801fb63-654d-4537-b7b0-e297a8568b99',TO_TIMESTAMP('2020-11-10 17:10:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:22','YYYY-MM-DD HH24:MI:SS'),100,200006,'description','c_payment.description',750)
;

-- Nov 10, 2020, 5:10:23 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200201,'deee38ca-a052-4f5e-9570-399a4908e382',TO_TIMESTAMP('2020-11-10 17:10:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:22','YYYY-MM-DD HH24:MI:SS'),100,200006,'isselfservice','c_payment.isselfservice',760)
;

-- Nov 10, 2020, 5:10:23 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200202,'3ad7ef94-5418-4ce3-ad4e-03820e8ee949',TO_TIMESTAMP('2020-11-10 17:10:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:23','YYYY-MM-DD HH24:MI:SS'),100,200006,'processedon','c_payment.processedon',770)
;

-- Nov 10, 2020, 5:10:23 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200203,'48a993a0-5294-4be1-b576-0df957f05288',TO_TIMESTAMP('2020-11-10 17:10:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:23','YYYY-MM-DD HH24:MI:SS'),100,200006,'reversal_id','c_payment.reversal_id',780)
;

-- Nov 10, 2020, 5:10:24 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200204,'f7554532-e7cf-455a-a23a-4738f8428ef0',TO_TIMESTAMP('2020-11-10 17:10:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:23','YYYY-MM-DD HH24:MI:SS'),100,200006,'currencyrate','c_payment.currencyrate',790)
;

-- Nov 10, 2020, 5:10:24 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200205,'f8336c93-2202-4272-a80d-97f7a55814b9',TO_TIMESTAMP('2020-11-10 17:10:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:24','YYYY-MM-DD HH24:MI:SS'),100,200006,'convertedamt','c_payment.convertedamt',800)
;

-- Nov 10, 2020, 5:10:24 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,200206,'3207fef8-900c-48d8-9696-cc484106cf69',TO_TIMESTAMP('2020-11-10 17:10:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-11-10 17:10:24','YYYY-MM-DD HH24:MI:SS'),100,200006,'isoverridecurrencyrate','c_payment.isoverridecurrencyrate',810)
;

-- Nov 10, 2020, 5:10:44 PM CET
CREATE OR REPLACE VIEW C_Payment_v(c_payment_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, documentno, datetrx, isreceipt, c_doctype_id, trxtype, c_bankaccount_id, c_bpartner_id, c_invoice_id, c_bp_bankaccount_id, c_paymentbatch_id, tendertype, creditcardtype, creditcardnumber, creditcardvv, creditcardexpmm, creditcardexpyy, micr, routingno, accountno, checkno, a_name, a_street, a_city, a_state, a_zip, a_ident_dl, a_ident_ssn, a_email, voiceauthcode, orig_trxid, ponum, c_currency_id, c_conversiontype_id, payamt, discountamt, writeoffamt, taxamt, overunderamt, multiplierap, isoverunderpayment, isapproved, r_pnref, r_result, r_respmsg, r_authcode, r_avsaddr, r_avszip, r_info, processing, oprocessing, docstatus, docaction, isprepayment, c_charge_id, isreconciled, isallocated, isonline, processed, posted, c_campaign_id, c_project_id, c_activity_id, ad_orgtrx_id, chargeamt, c_order_id, dateacct, description, isselfservice, processedon, reversal_id, currencyrate, convertedamt, isoverridecurrencyrate) AS SELECT c_payment.c_payment_id AS c_payment_id, c_payment.ad_client_id AS ad_client_id, c_payment.ad_org_id AS ad_org_id, c_payment.isactive AS isactive, c_payment.created AS created, c_payment.createdby AS createdby, c_payment.updated AS updated, c_payment.updatedby AS updatedby, c_payment.documentno AS documentno, c_payment.datetrx AS datetrx, c_payment.isreceipt AS isreceipt, c_payment.c_doctype_id AS c_doctype_id, c_payment.trxtype AS trxtype, c_payment.c_bankaccount_id AS c_bankaccount_id, c_payment.c_bpartner_id AS c_bpartner_id, c_payment.c_invoice_id AS c_invoice_id, c_payment.c_bp_bankaccount_id AS c_bp_bankaccount_id, c_payment.c_paymentbatch_id AS c_paymentbatch_id, c_payment.tendertype AS tendertype, c_payment.creditcardtype AS creditcardtype, c_payment.creditcardnumber AS creditcardnumber, c_payment.creditcardvv AS creditcardvv, c_payment.creditcardexpmm AS creditcardexpmm, c_payment.creditcardexpyy AS creditcardexpyy, c_payment.micr AS micr, c_payment.routingno AS routingno, c_payment.accountno AS accountno, c_payment.checkno AS checkno, c_payment.a_name AS a_name, c_payment.a_street AS a_street, c_payment.a_city AS a_city, c_payment.a_state AS a_state, c_payment.a_zip AS a_zip, c_payment.a_ident_dl AS a_ident_dl, c_payment.a_ident_ssn AS a_ident_ssn, c_payment.a_email AS a_email, c_payment.voiceauthcode AS voiceauthcode, c_payment.orig_trxid AS orig_trxid, c_payment.ponum AS ponum, c_payment.c_currency_id AS c_currency_id, c_payment.c_conversiontype_id AS c_conversiontype_id, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.payamt ELSE c_payment.payamt * (-1) END AS payamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.discountamt ELSE c_payment.discountamt * (-1) END AS discountamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.writeoffamt ELSE c_payment.writeoffamt * (-1) END AS writeoffamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.taxamt ELSE c_payment.taxamt * (-1) END AS taxamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.overunderamt ELSE c_payment.overunderamt * (-1) END AS overunderamt, CASE c_payment.isreceipt WHEN 'Y' THEN 1 ELSE (-1) END AS multiplierap, c_payment.isoverunderpayment AS isoverunderpayment, c_payment.isapproved AS isapproved, c_payment.r_pnref AS r_pnref, c_payment.r_result AS r_result, c_payment.r_respmsg AS r_respmsg, c_payment.r_authcode AS r_authcode, c_payment.r_avsaddr AS r_avsaddr, c_payment.r_avszip AS r_avszip, c_payment.r_info AS r_info, c_payment.processing AS processing, c_payment.oprocessing AS oprocessing, c_payment.docstatus AS docstatus, c_payment.docaction AS docaction, c_payment.isprepayment AS isprepayment, c_payment.c_charge_id AS c_charge_id, c_payment.isreconciled AS isreconciled, c_payment.isallocated AS isallocated, c_payment.isonline AS isonline, c_payment.processed AS processed, c_payment.posted AS posted, c_payment.c_campaign_id AS c_campaign_id, c_payment.c_project_id AS c_project_id, c_payment.c_activity_id AS c_activity_id, c_payment.ad_orgtrx_id AS ad_orgtrx_id, c_payment.chargeamt AS chargeamt, c_payment.c_order_id AS c_order_id, c_payment.dateacct AS dateacct, c_payment.description AS description, c_payment.isselfservice AS isselfservice, c_payment.processedon AS processedon, c_payment.reversal_id AS reversal_id, c_payment.currencyrate AS currencyrate, c_payment.convertedamt AS convertedamt, c_payment.isoverridecurrencyrate AS isoverridecurrencyrate FROM c_payment
;

-- Nov 10, 2020, 5:10:54 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214331,0.0,'Trx Organization','Performing or initiating organization','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.',554,'AD_OrgTrx_ID',10,'N','N','N','N','N','N',18,130,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:53','YYYY-MM-DD HH24:MI:SS'),100,112,'N','N','D','N','623551f6-ca6c-4773-9996-ff9adbf11d95','N','N')
;

-- Nov 10, 2020, 5:10:54 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214332,0.0,'Charge amount','Charge Amount','The Charge Amount indicates the amount for an additional charge.',554,'ChargeAmt',131089,'N','N','N','N','N','N',12,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:54','YYYY-MM-DD HH24:MI:SS'),100,849,'N','N','D','N','ce82e529-fcd6-4c43-8ef2-b5330f5e8282','N')
;

-- Nov 10, 2020, 5:10:54 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214333,0.0,'Order','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',554,'C_Order_ID',10,'N','N','N','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:54','YYYY-MM-DD HH24:MI:SS'),100,558,'N','N','D','N','8a41c541-234a-4940-b26c-7b403fc4bf71','N')
;

-- Nov 10, 2020, 5:10:55 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214334,0.0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',554,'DateAcct',29,'N','N','N','N','N','N',15,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:54','YYYY-MM-DD HH24:MI:SS'),100,263,'N','N','D','N','6502eab1-cd9a-476f-83ca-083d1d7ba43e','N')
;

-- Nov 10, 2020, 5:10:55 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214335,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',554,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:55','YYYY-MM-DD HH24:MI:SS'),100,275,'N','Y','D','N','d3cdaa0e-907c-47f4-87cd-5d8fd1aa5935',10,'N')
;

-- Nov 10, 2020, 5:10:55 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214336,0.0,'Self-Service','This is a Self-Service entry or this entry can be changed via Self-Service','Self-Service allows users to enter data or update their data.  The flag indicates, that this record was entered or created via Self-Service or that the user can change it via the Self-Service functionality.',554,'IsSelfService',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:55','YYYY-MM-DD HH24:MI:SS'),100,2063,'N','N','D','N','8623c2bb-733a-4f81-baa2-ba16928b4545','N')
;

-- Nov 10, 2020, 5:10:56 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214337,0.0,'Processed On','The date+time (expressed in decimal format) when the document has been processed','The ProcessedOn Date+Time save the exact moment (nanoseconds precision if allowed by the DB) when a document has been processed.',554,'ProcessedOn',131089,'N','N','N','N','N','N',22,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:55','YYYY-MM-DD HH24:MI:SS'),100,54128,'N','N','D','N','96f54714-a83b-4bee-b4d6-891cc78b95dd','N')
;

-- Nov 10, 2020, 5:10:56 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214338,0.0,'Reversal ID','ID of document reversal',554,'Reversal_ID',10,'N','N','N','N','N','N',30,336,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:56','YYYY-MM-DD HH24:MI:SS'),100,53457,'N','N','D','N','5beaab31-f77a-4f89-91d4-a2cd0b277d7f','N')
;

-- Nov 10, 2020, 5:10:56 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214339,0.0,'Rate','Currency Conversion Rate','The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency',554,'CurrencyRate',131089,'N','N','N','N','N','N',22,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:56','YYYY-MM-DD HH24:MI:SS'),100,253,'N','N','D','N','fdfdf604-f4be-4413-aebd-8fdd8c0ee16b','N')
;

-- Nov 10, 2020, 5:10:57 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214340,0.0,'Converted Amount','Converted Amount','The Converted Amount is the result of multiplying the Source Amount by the Conversion Rate for this target currency.',554,'ConvertedAmt',131089,'N','N','N','N','N','N',12,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:56','YYYY-MM-DD HH24:MI:SS'),100,1555,'N','N','D','N','716f5c6e-ce69-4c66-96f9-79c6fbb9fa77','N')
;

-- Nov 10, 2020, 5:10:57 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214341,0.0,'Override Currency Conversion Rate','Override Currency Conversion Rate',554,'IsOverrideCurrencyRate','N',1,'N','N','N','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2020-11-10 17:10:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-10 17:10:57','YYYY-MM-DD HH24:MI:SS'),100,203258,'N','N','D','N','11230ce7-ac50-4c84-bc9f-4b1de06e1587','N','N')
;

CREATE OR REPLACE FUNCTION currencyConvertPayment(
	p_C_Payment_ID numeric,
	p_Currency_To_id numeric,
	p_Amt numeric default null,
	p_conversionDate timestamp with time zone default null)
    RETURNS numeric
    LANGUAGE 'plpgsql'
AS $BODY$		
DECLARE
	v_PayAmt NUMERIC;
	v_ConversionType_ID NUMERIC;
	v_Client_ID NUMERIC;
	v_Org_ID NUMERIC;
	v_Currency_ID NUMERIC;
	v_CurrencyRate NUMERIC;
	v_ConvertedAmt NUMERIC;
	v_DateAcct timestamp with time zone;
	v_BaseCurrency_ID NUMERIC;
	v_IsOverrideCurrencyRate character(1);
BEGIN
	SELECT AD_Client_ID, AD_Org_ID, DateAcct, C_Currency_ID, C_ConversionType_ID, CurrencyRate, ConvertedAmt, PayAmt, IsOverrideCurrencyRate
	INTO v_Client_ID, v_Org_ID, v_DateAcct, v_Currency_ID, v_ConversionType_ID, v_CurrencyRate, v_ConvertedAmt, v_PayAmt, v_IsOverrideCurrencyRate
	FROM C_Payment_V
	WHERE C_Payment_ID=p_C_Payment_ID;
	
	SELECT sc.C_Currency_ID
	INTO v_BaseCurrency_ID
	FROM AD_ClientInfo ci
	JOIN C_AcctSchema sc ON ci.C_AcctSchema1_ID=sc.C_AcctSchema_ID
	WHERE ci.AD_Client_ID=v_Client_ID;
	
	IF v_BaseCurrency_ID=p_Currency_To_id AND Coalesce(v_CurrencyRate,0) > 0 AND Coalesce(v_ConvertedAmt,0) != 0 AND v_Currency_ID != p_Currency_To_id AND v_IsOverrideCurrencyRate='Y' THEN
		IF p_Amt IS NULL THEN
			RETURN v_ConvertedAmt;
		ELSE
			RETURN currencyRound(p_Amt*v_CurrencyRate, p_Currency_To_id, null);
		END IF;
	END IF;
	
	RETURN currencyConvert(Coalesce(p_Amt,v_PayAmt), v_Currency_ID, p_Currency_To_id, Coalesce(p_conversionDate,v_DateAcct), v_ConversionType_ID, v_Client_ID, v_Org_ID);
END;
$BODY$;

SELECT register_migration_script('202011101712_IDEMPIERE-4083.sql') FROM dual
;

