-- IDEMPIERE-4339
-- Jun 18, 2020, 4:13:12 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200138,'AD_Column in AD_Table (not present in WS_WebServiceFieldIn)','S','AD_Column.AD_Table_ID=@AD_Table_ID@ AND AD_Column.AD_Column_ID NOT IN (SELECT AD_Column_ID FROM WS_WebServiceFieldInput WHERE WS_WebServiceType_ID = @WS_WebServiceType_ID@)',0,0,'Y',TO_TIMESTAMP('2020-06-18 16:13:12','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2020-06-18 16:13:12','YYYY-MM-DD HH24:MI:SS'),0,'D','d9ec441e-4653-45ba-8413-488cf9cfb4dd')
;

-- Jun 18, 2020, 4:13:34 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200139,'AD_Column in AD_Table (not present in WS_WebServiceFieldOut)','S','AD_Column.AD_Table_ID=@AD_Table_ID@ AND AD_Column.AD_Column_ID NOT IN (SELECT AD_Column_ID FROM WS_WebServiceFieldOutput WHERE WS_WebServiceType_ID = @WS_WebServiceType_ID@)',0,0,'Y',TO_TIMESTAMP('2020-06-18 16:13:34','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2020-06-18 16:13:34','YYYY-MM-DD HH24:MI:SS'),0,'D','fde75581-b497-4ceb-8bff-eed0012a8a48')
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56645
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56649
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56653
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56654
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56652
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56648
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56647
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=205067
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56655
;

-- Jun 18, 2020, 4:14:19 PM CEST
UPDATE AD_Tab SET IsSingleRow='N',Updated=TO_TIMESTAMP('2020-06-18 16:14:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53188
;

-- Jun 18, 2020, 4:14:24 PM CEST
UPDATE AD_Tab SET IsSingleRow='N',Updated=TO_TIMESTAMP('2020-06-18 16:14:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53189
;

-- Jun 18, 2020, 4:14:36 PM CEST
UPDATE AD_Tab SET IsSingleRow='N',Updated=TO_TIMESTAMP('2020-06-18 16:14:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53190
;

-- Jun 18, 2020, 4:15:37 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200138, IsToolbarButton='N',Updated=TO_TIMESTAMP('2020-06-18 16:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=56755
;

-- Jun 18, 2020, 4:15:52 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200139, IsToolbarButton='N',Updated=TO_TIMESTAMP('2020-06-18 16:15:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=56757
;

-- Jun 18, 2020, 4:15:52 PM CEST
UPDATE AD_Tab SET IsSingleRow='N',Updated=TO_TIMESTAMP('2020-06-18 16:14:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53191
;

SELECT register_migration_script('202006181620_IDEMPIERE-4339.sql') FROM dual
;