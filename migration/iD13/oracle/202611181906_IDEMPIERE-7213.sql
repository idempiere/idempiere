-- IDEMPIERE-7213 - Allow creation of View Components from an existing Database View (reverse of DatabaseViewValidate)
SELECT register_migration_script('202611181906_IDEMPIERE-7213.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 18, 2026, 7:06:52 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200530,0,0,'Y',TO_TIMESTAMP('2026-11-18 19:06:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-18 19:06:51','YYYY-MM-DD HH24:MI:SS'),100,'Remove PostgreSQL casts','Remove the PostgreSQL type casts (::type) so the view definition can be used on Oracle. The process log lists where casts were removed, review them ',200174,30,20,'N',1,'N','Y','IsRemoveCasts','N','D','@#DBType@=PostgreSQL','01a1efd7-12f7-7304-86f6-9754765a0d79','N','N','D','N')
;

-- Nov 18, 2026, 7:07:09 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','PostgreSQL casts removed, review: {0}',0,0,'Y',TO_TIMESTAMP('2026-11-18 19:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-18 19:07:09','YYYY-MM-DD HH24:MI:SS'),100,201075,'ViewCastsRemoved','D','01a1efd7-56ad-739d-9fa9-bb581e716022')
;

-- Nov 18, 2026, 7:07:36 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-529b-7604-9b02-84d63cda735a'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-529e-7f07-86b9-dcebc2f930f7'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52a1-7cf3-8564-540c84f78c02'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52a4-7415-805d-22074cbdca4a'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52a7-7211-8e9e-3a7d71c6b836'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52aa-7475-9b60-d235fe5b7dab'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52ad-7b2d-85c6-c65e6d29b467'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52b0-75a1-8c07-56711ce56e71'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52b3-7d3c-80c1-0e2eaf09cc4c'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52b6-7f05-ade1-be30b2deda94'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52b8-7e1a-b354-95073b381a08'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52bb-72b3-97df-d8c1ae764939'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewColumn WHERE AD_ViewColumn_UU='01a1e9a4-52be-7194-928b-106839e6e1dd'
;

-- Nov 18, 2026, 7:07:37 PM CET
DELETE FROM AD_ViewComponent WHERE AD_ViewComponent_UU='01a1e9a4-5298-7947-9ee5-3f0dd2c62f30'
;

-- Nov 18, 2026, 7:07:37 PM CET
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,OtherClause,SeqNo,FromClause,IsUnionAll,IsDistinct) VALUES (0,0,200233,'01a1efd7-c44b-7e9c-b626-1a1b213af648',TO_TIMESTAMP('2026-11-18 19:07:37','YYYY-MM-DD HH24:MI:SS'),100,'U','Y','RV_TestViewDiego23-010',TO_TIMESTAMP('2026-11-18 19:07:37','YYYY-MM-DD HH24:MI:SS'),100,(SELECT AD_Table_ID FROM AD_Table WHERE AD_Table_UU = '01a1e9a4-41a0-7cf3-bae8-8a593dd82a31'),'GROUP BY il.ad_client_id, il.ad_org_id, il.m_product_category_id, (firstof(il.dateinvoiced, ''MM'')), il.issotrx, i.c_currency_id',10,'FROM rv_c_invoiceline il
     JOIN c_invoice i ON i.c_invoice_id = il.c_invoice_id','N','N')
;

-- Nov 18, 2026, 7:07:37 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217763,'01a1efd7-c55e-72e5-ab55-ffdaf0c8ddfd',TO_TIMESTAMP('2026-11-18 19:07:37','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:37','YYYY-MM-DD HH24:MI:SS'),100,200233,'AD_Client_ID','il.ad_client_id',10)
;

-- Nov 18, 2026, 7:07:38 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217764,'01a1efd7-c667-7b3d-8bfc-fc5b5762d8d3',TO_TIMESTAMP('2026-11-18 19:07:37','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:37','YYYY-MM-DD HH24:MI:SS'),100,200233,'AD_Org_ID','il.ad_org_id',20)
;

-- Nov 18, 2026, 7:07:38 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217765,'01a1efd7-c76f-771f-beb9-050775c314c4',TO_TIMESTAMP('2026-11-18 19:07:38','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:38','YYYY-MM-DD HH24:MI:SS'),100,200233,'producto','il.m_product_category_id',30)
;

-- Nov 18, 2026, 7:07:38 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217766,'01a1efd7-c869-7ac6-a5ed-47a61b3ca643',TO_TIMESTAMP('2026-11-18 19:07:38','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:38','YYYY-MM-DD HH24:MI:SS'),100,200233,'DateInvoiced','firstof(il.dateinvoiced, ''MM'')',40)
;

-- Nov 18, 2026, 7:07:38 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217767,'01a1efd7-c970-7fc2-bef2-f6426cb3592b',TO_TIMESTAMP('2026-11-18 19:07:38','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:38','YYYY-MM-DD HH24:MI:SS'),100,200233,'LineNetAmt','sum(il.linenetamt)',50)
;

-- Nov 18, 2026, 7:07:39 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217768,'01a1efd7-ca68-735e-8e90-c710acdd2895',TO_TIMESTAMP('2026-11-18 19:07:38','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:38','YYYY-MM-DD HH24:MI:SS'),100,200233,'LineListAmt','sum(il.linelistamt)',60)
;

-- Nov 18, 2026, 7:07:39 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217769,'01a1efd7-cb70-754a-a1a5-6c607fa2c47a',TO_TIMESTAMP('2026-11-18 19:07:39','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:39','YYYY-MM-DD HH24:MI:SS'),100,200233,'LineLimitAmt','sum(il.linelimitamt)',70)
;

-- Nov 18, 2026, 7:07:39 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217770,'01a1efd7-cc6c-75f7-af59-c6a35cadedae',TO_TIMESTAMP('2026-11-18 19:07:39','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:39','YYYY-MM-DD HH24:MI:SS'),100,200233,'LineDiscountAmt','sum(il.linediscountamt)',80)
;

-- Nov 18, 2026, 7:07:39 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217771,'01a1efd7-cd77-7563-a022-c604fd8f6a1b',TO_TIMESTAMP('2026-11-18 19:07:39','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:39','YYYY-MM-DD HH24:MI:SS'),100,200233,'LineDiscount','CASE
            WHEN sum(il.linelistamt) = 0 THEN 0
            ELSE currencyround((sum(il.linelistamt) - sum(il.linenetamt)) / sum(il.linelistamt) * 100, i.c_currency_id, ''N'')
        END',90)
;

-- Nov 18, 2026, 7:07:40 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217772,'01a1efd7-cf0e-735f-ba1f-4599ef019c11',TO_TIMESTAMP('2026-11-18 19:07:39','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:39','YYYY-MM-DD HH24:MI:SS'),100,200233,'LineOverLimitAmt','sum(il.lineoverlimitamt)',100)
;

-- Nov 18, 2026, 7:07:40 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217773,'01a1efd7-d010-7bb2-91c8-0fd0b5adfafd',TO_TIMESTAMP('2026-11-18 19:07:40','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:40','YYYY-MM-DD HH24:MI:SS'),100,200233,'LineOverLimit','CASE
            WHEN sum(il.linenetamt) = 0 THEN 0
            ELSE 100 - currencyround((sum(il.linenetamt) - sum(il.lineoverlimitamt)) / sum(il.linenetamt) * 100, i.c_currency_id, ''N'')
        END',110)
;

-- Nov 18, 2026, 7:07:40 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217774,'01a1efd7-d169-7a18-b200-5a559f30277a',TO_TIMESTAMP('2026-11-18 19:07:40','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:40','YYYY-MM-DD HH24:MI:SS'),100,200233,'QtyInvoiced','sum(il.qtyinvoiced)',120)
;

-- Nov 18, 2026, 7:07:41 PM CET
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217775,'01a1efd7-d271-7583-bbc6-fd3b3dbcae65',TO_TIMESTAMP('2026-11-18 19:07:40','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_TIMESTAMP('2026-11-18 19:07:40','YYYY-MM-DD HH24:MI:SS'),100,200233,'IsSOTrx','il.issotrx',130)
;

