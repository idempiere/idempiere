-- IDEMPIERE-5146 Load/Import Bank Statement issues
-- Jan 10, 2022, 8:27:42 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2022-01-10 20:27:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10016
;

-- Jan 10, 2022, 8:27:44 PM CET
INSERT INTO t_alter_column values('i_bankstatement','EftMemo','VARCHAR(4000)',null,'NULL')
;

-- Jan 10, 2022, 8:28:04 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2022-01-10 20:28:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9293
;

-- Jan 10, 2022, 8:28:08 PM CET
INSERT INTO t_alter_column values('i_bankstatement','Memo','VARCHAR(4000)',null,'NULL')
;

-- Jan 10, 2022, 8:28:32 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2022-01-10 20:28:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10029
;

-- Jan 10, 2022, 8:28:34 PM CET
INSERT INTO t_alter_column values('c_bankstatementline','EftMemo','VARCHAR(4000)',null,'NULL')
;

-- Jan 10, 2022, 8:29:03 PM CET
UPDATE AD_Column SET FieldLength=4000,Updated=TO_TIMESTAMP('2022-01-10 20:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8987
;

-- Jan 10, 2022, 8:29:04 PM CET
INSERT INTO t_alter_column values('c_bankstatementline','Memo','VARCHAR(4000)',null,'NULL')
;

-- Jan 10, 2022, 8:30:00 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-10 20:30:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7069
;

-- Jan 10, 2022, 8:30:05 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-10 20:30:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6864
;

-- Jan 10, 2022, 8:30:20 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-10 20:30:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8365
;

-- Jan 10, 2022, 8:30:33 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-01-10 20:30:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8361
;

-- Jan 10, 2022, 8:31:11 PM CET
UPDATE AD_Column SET FieldLength=1000,Updated=TO_TIMESTAMP('2022-01-10 20:31:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9299
;

-- Jan 10, 2022, 8:31:13 PM CET
INSERT INTO t_alter_column values('i_bankstatement','LineDescription','VARCHAR(1000)',null,'NULL')
;

-- Jan 10, 2022, 8:31:28 PM CET
UPDATE AD_Column SET FieldLength=1000, SeqNoSelection=10,Updated=TO_TIMESTAMP('2022-01-10 20:31:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4936
;

-- Jan 10, 2022, 8:31:30 PM CET
INSERT INTO t_alter_column values('c_bankstatementline','Description','VARCHAR(1000)',null,'NULL')
;

-- Jan 10, 2022, 8:32:45 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-01-10 20:32:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10018
;

-- Jan 10, 2022, 8:32:47 PM CET
INSERT INTO t_alter_column values('i_bankstatement','EftTrxType','VARCHAR(255)',null,'NULL')
;

-- Jan 10, 2022, 8:32:53 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-01-10 20:32:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10026
;

-- Jan 10, 2022, 8:32:55 PM CET
INSERT INTO t_alter_column values('c_bankstatementline','EftTrxType','VARCHAR(255)',null,'NULL')
;

-- Jan 10, 2022, 8:33:49 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-01-10 20:33:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10017
;

-- Jan 10, 2022, 8:33:50 PM CET
INSERT INTO t_alter_column values('i_bankstatement','EftReference','VARCHAR(255)',null,'NULL')
;

-- Jan 10, 2022, 8:33:56 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-01-10 20:33:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10339
;

-- Jan 10, 2022, 8:33:57 PM CET
INSERT INTO t_alter_column values('c_bankstatementline','EftReference','VARCHAR(255)',null,'NULL')
;

-- Jan 10, 2022, 8:34:38 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-01-10 20:34:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9290
;

-- Jan 10, 2022, 8:34:40 PM CET
INSERT INTO t_alter_column values('i_bankstatement','ReferenceNo','VARCHAR(255)',null,'NULL')
;

-- Jan 10, 2022, 8:34:45 PM CET
UPDATE AD_Column SET FieldLength=255,Updated=TO_TIMESTAMP('2022-01-10 20:34:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8986
;

-- Jan 10, 2022, 8:34:46 PM CET
INSERT INTO t_alter_column values('c_bankstatementline','ReferenceNo','VARCHAR(255)',null,'NULL')
;

-- Jan 10, 2022, 10:58:34 PM CET
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2022-01-10 22:58:33','YYYY-MM-DD HH24:MI:SS'),100,'CreatePayment','Y',200116,'CreatePayment',TO_TIMESTAMP('2022-01-10 22:58:33','YYYY-MM-DD HH24:MI:SS'),100,'N','106df1bc-ac3b-44a6-92ba-ead2d2171155','W',328,257,10,'D')
;

-- Jan 10, 2022, 11:10:31 PM CET
UPDATE AD_ToolBarButton SET DisplayLogic='@Processed@=N',Updated=TO_TIMESTAMP('2022-01-10 23:10:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200116
;

SELECT register_migration_script('202201102035_IDEMPIERE-5146.sql') FROM dual
;

