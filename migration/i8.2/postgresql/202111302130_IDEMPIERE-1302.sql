-- IDEMPIERE-1302 Validate flag IsPurchased and IsSold on Price List, Order, InOut, and Invoice
-- Nov 30, 2021, 9:23:00 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=10,Updated=TO_TIMESTAMP('2021-11-30 21:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200000
;

-- Nov 30, 2021, 9:23:02 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=20,Updated=TO_TIMESTAMP('2021-11-30 21:23:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200001
;

-- Nov 30, 2021, 9:23:05 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=30,Updated=TO_TIMESTAMP('2021-11-30 21:23:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200003
;

-- Nov 30, 2021, 9:23:07 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=40,Updated=TO_TIMESTAMP('2021-11-30 21:23:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200004
;

-- Nov 30, 2021, 9:23:10 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=50,Updated=TO_TIMESTAMP('2021-11-30 21:23:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200002
;

-- Nov 30, 2021, 9:23:15 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=60,Updated=TO_TIMESTAMP('2021-11-30 21:23:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200005
;

-- Nov 30, 2021, 9:23:29 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=70,Updated=TO_TIMESTAMP('2021-11-30 21:23:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200010
;

-- Nov 30, 2021, 9:23:43 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=80,Updated=TO_TIMESTAMP('2021-11-30 21:23:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200009
;

-- Nov 30, 2021, 9:24:03 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=90,Updated=TO_TIMESTAMP('2021-11-30 21:24:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200007
;

-- Nov 30, 2021, 9:24:11 PM CET
UPDATE AD_InfoColumn SET SeqNoSelection=120,Updated=TO_TIMESTAMP('2021-11-30 21:24:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200008
;

-- Nov 30, 2021, 9:26:47 PM CET
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200226,0,0,'Y',TO_TIMESTAMP('2021-11-30 21:26:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-30 21:26:46','YYYY-MM-DD HH24:MI:SS'),100,'Sold','Organization sells this product','The Sold check box indicates if this product is sold by this organization.',200000,'D','p.IsSold',230,'N','Y',414,17,'3d1e9e15-1921-41bf-9348-3967f6be2c2b',319,'Y','@IsSOTrx:Y@=Y | @+IgnoreIsSOTrxInBPInfo:N@=Y','IsSold','=','N',100,'@SQL=SELECT CASE WHEN ''@IsSOTrx:X@''=''X'' OR ''@+IgnoreIsSOTrxInBPInfo:N@''=''Y'' THEN '''' WHEN ''@IsSOTrx:X@''=''Y'' THEN ''Y'' ELSE ''N'' END AS DefaultValue FROM DUAL','N','N','Y','N')
;

-- Nov 30, 2021, 9:27:39 PM CET
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,DisplayLogic,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200227,0,0,'Y',TO_TIMESTAMP('2021-11-30 21:27:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-30 21:27:39','YYYY-MM-DD HH24:MI:SS'),100,'Purchased','Organization purchases this product','The Purchased check box indicates if this product is purchased by this organization.',200000,'D','p.IsPurchased',240,'N','Y',403,17,'aea2488e-78e9-41c8-bbb2-9ec9953612ca',319,'Y','@IsSOTrx:N@=N | @+IgnoreIsSOTrxInBPInfo:N@=Y','IsPurchased','=','N',110,'@SQL=SELECT CASE WHEN ''@IsSOTrx:X@''=''X'' OR ''@+IgnoreIsSOTrxInBPInfo:N@''=''Y'' THEN '''' WHEN ''@IsSOTrx:X@''=''N'' THEN ''Y'' ELSE ''N'' END AS DefaultValue FROM DUAL','N','N','Y','N')
;

SELECT register_migration_script('202111302130_IDEMPIERE-1302.sql') FROM dual
;

