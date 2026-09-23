-- IDEMPIERE-7120 Implement UUID Document No Sequences
SELECT register_migration_script('202609232303_IDEMPIERE-7120.sql') FROM dual;

-- Sep 23, 2026, 11:03:26 PM CEST
UPDATE AD_Process_Para SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:03:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200040
;

-- Sep 23, 2026, 11:03:42 PM CEST
UPDATE AD_Process_Para SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53251
;

-- Sep 23, 2026, 11:03:51 PM CEST
UPDATE AD_Process_Para SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:03:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53217
;

-- Sep 23, 2026, 11:04:02 PM CEST
UPDATE AD_Process_Para SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=301
;

-- Sep 23, 2026, 11:04:58 PM CEST
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55966;

INSERT INTO t_alter_column values('a_asset_addition','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59483;

INSERT INTO t_alter_column values('a_asset_disposed','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59419;

INSERT INTO t_alter_column values('a_asset_reval','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55524;

INSERT INTO t_alter_column values('a_asset_reval_entry','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59351;

INSERT INTO t_alter_column values('a_asset_transfer','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55552;

INSERT INTO t_alter_column values('a_depreciation_entry','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6201;

INSERT INTO t_alter_column values('ad_sequence_audit','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53318;

INSERT INTO t_alter_column values('ad_workflow','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11128;

INSERT INTO t_alter_column values('b_topic','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12323;

INSERT INTO t_alter_column values('c_allocationhdr','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215848;

INSERT INTO t_alter_column values('c_bankstatement','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213643;

INSERT INTO t_alter_column values('c_banktransfer','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=60178;

INSERT INTO t_alter_column values('c_cashplan','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5810;

INSERT INTO t_alter_column values('c_commissionrun','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208419;

INSERT INTO t_alter_column values('c_depositbatch','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3492;

INSERT INTO t_alter_column values('c_invoice','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13381;

INSERT INTO t_alter_column values('c_invoicebatch','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13401;

INSERT INTO t_alter_column values('c_invoicebatchline','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=62141;

INSERT INTO t_alter_column values('c_opportunity','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2169;

INSERT INTO t_alter_column values('c_order','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5401;

INSERT INTO t_alter_column values('c_payment','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5314;

INSERT INTO t_alter_column values('c_paymentbatch','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7720;

INSERT INTO t_alter_column values('c_payselectioncheck','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12057;

INSERT INTO t_alter_column values('c_rfq','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54289;

INSERT INTO t_alter_column values('dd_networkdistribution','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53864;

INSERT INTO t_alter_column values('dd_order','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1626;

INSERT INTO t_alter_column values('gl_journal','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1650;

INSERT INTO t_alter_column values('gl_journalbatch','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54870;

INSERT INTO t_alter_column values('hr_process','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9187;

INSERT INTO t_alter_column values('i_invoice','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59561;

INSERT INTO t_alter_column values('i_movement','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8999;

INSERT INTO t_alter_column values('i_order','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9144;

INSERT INTO t_alter_column values('i_payment','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13947;

INSERT INTO t_alter_column values('m_changerequest','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4469;

INSERT INTO t_alter_column values('m_edi','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3791;

INSERT INTO t_alter_column values('m_inout','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12091;

INSERT INTO t_alter_column values('m_inoutconfirm','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3550;

INSERT INTO t_alter_column values('m_inventory','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13086;

INSERT INTO t_alter_column values('m_matchinv','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13087;

INSERT INTO t_alter_column values('m_matchpo','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3577;

INSERT INTO t_alter_column values('m_movement','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12459;

INSERT INTO t_alter_column values('m_movementconfirm','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10889;

INSERT INTO t_alter_column values('m_package','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59961;

INSERT INTO t_alter_column values('m_production','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11470;

INSERT INTO t_alter_column values('m_requisition','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10841;

INSERT INTO t_alter_column values('m_rma','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56573;

INSERT INTO t_alter_column values('pp_cost_collector','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53621;

INSERT INTO t_alter_column values('pp_order','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53605;

INSERT INTO t_alter_column values('pp_order_bom','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53698;

INSERT INTO t_alter_column values('pp_order_workflow','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53323;

INSERT INTO t_alter_column values('pp_product_bom','DocumentNo','VARCHAR(255)',null,'NULL');

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5423;

INSERT INTO t_alter_column values('r_request','DocumentNo','VARCHAR(255)',null,null);

UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2026-09-23 23:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6840;

INSERT INTO t_alter_column values('s_timeexpense','DocumentNo','VARCHAR(255)',null,null);

-- Sep 23, 2026, 11:31:47 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204125,0,0,'Y',TO_TIMESTAMP('2026-09-23 23:30:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-23 23:30:33','YYYY-MM-DD HH24:MI:SS'),100,'IsUUIDSeq','Is UUID','Defines if the sequence is UUID based','UUID based sequences don''t follow a numeric ID but generates a UUID instead, the advantage is that they don''t need to lock the sequence table avoiding contention','Is UUID','D','01a0d02e-8f04-77fd-8214-2877f5540cf4')
;

-- Sep 23, 2026, 11:32:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217659,0,'Is UUID','Defines if the sequence is UUID based','UUID based sequences don''t follow a numeric ID but generates a UUID instead, the advantage is that they don''t need to lock the sequence table avoiding contention',115,'IsUUIDSeq','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-09-23 23:32:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-23 23:32:18','YYYY-MM-DD HH24:MI:SS'),100,204125,'Y','N','D','N','N','N','Y','01a0d02f-093a-756f-ae0c-44142c14ab32','Y',0,'N','N','N','N')
;

-- Sep 23, 2026, 11:32:22 PM CEST
ALTER TABLE AD_Sequence ADD COLUMN IsUUIDSeq CHAR(1) DEFAULT 'N' CHECK (IsUUIDSeq IN ('Y','N')) NOT NULL
;

-- Sep 23, 2026, 11:33:20 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (209244,'Is UUID','Defines if the sequence is UUID based','UUID based sequences don''t follow a numeric ID but generates a UUID instead, the advantage is that they don''t need to lock the sequence table avoiding contention',146,217659,'Y',0,210,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-09-23 23:33:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-23 23:33:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a0d02f-fbe1-7be8-85aa-7158e66be31e','Y',210,1,1,1,'N','N','N','N','N')
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=5,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209244
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=330
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=331
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=635
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsAutoSequence@=Y & @IsUUIDSeq@=N', SeqNo=100,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1554
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsAutoSequence@=Y & @IsUUIDSeq@=N', SeqNo=110,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=329
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsUUIDSeq@=N', SeqNo=120,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54391
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=332
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=333
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200162
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200163
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=335
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54357
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200164
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsAutoSequence@=Y & @IsTableID@=N & @IsUUIDSeq@=N', SeqNo=200,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1555
;

-- Sep 23, 2026, 11:37:54 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-09-23 23:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204597
;

-- Sep 23, 2026, 11:38:19 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsUUIDSeq@=N',Updated=TO_TIMESTAMP('2026-09-23 23:38:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=330
;

-- Sep 23, 2026, 11:38:28 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsAutoSequence@=Y & @IsUUIDSeq@=N',Updated=TO_TIMESTAMP('2026-09-23 23:38:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=331
;

-- Sep 23, 2026, 11:39:01 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsTableID@=N & @IsUUIDSeq@=N',Updated=TO_TIMESTAMP('2026-09-23 23:39:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200162
;

-- Sep 23, 2026, 11:39:04 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsOrgLevelSequence@=Y & @IsUUIDSeq@=N',Updated=TO_TIMESTAMP('2026-09-23 23:39:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200163
;

-- Sep 23, 2026, 11:39:09 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsAutoSequence@=Y & @IsTableID@=N & @IsUUIDSeq@=N',Updated=TO_TIMESTAMP('2026-09-23 23:39:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=335
;

-- Sep 23, 2026, 11:39:15 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsAutoSequence@=Y & @IsTableID@=N & @StartNewYear@=Y & @IsUUIDSeq@=N',Updated=TO_TIMESTAMP('2026-09-23 23:39:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54357
;

-- Sep 23, 2026, 11:39:18 PM CEST
UPDATE AD_Field SET DisplayLogic='@StartNewYear@=Y & @IsUUIDSeq@=N',Updated=TO_TIMESTAMP('2026-09-23 23:39:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200164
;

-- Sep 23, 2026, 11:56:06 PM CEST
UPDATE AD_Field SET DisplayLogic='IsTableID=N',Updated=TO_TIMESTAMP('2026-09-23 23:56:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209244
;

-- Sep 23, 2026, 11:58:08 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsTableID@=N',Updated=TO_TIMESTAMP('2026-09-23 23:58:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209244
;

