-- IDEMPIERE-4297 Doc Print fixes
SELECT register_migration_script('202203031336_IDEMPIERE-4297.sql') FROM dual;

-- Fix missing data in RMA Line
UPDATE M_RMALine SET Amt=21.59,Line=10,LineNetAmt=21.59,Updated=TO_TIMESTAMP('2022-03-03 13:36:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_RMALine_ID = 100
;

-- Mar 3, 2022, 1:36:13 PM AEDT
UPDATE AD_PrintFormat SET AD_PrintFont_ID=160,Updated=TO_TIMESTAMP('2022-03-03 13:36:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=118
;

-- Mar 3, 2022, 1:36:21 PM AEDT
UPDATE AD_PrintFormat SET AD_PrintFont_ID=160,Updated=TO_TIMESTAMP('2022-03-03 13:36:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=119
;

-- Mar 3, 2022, 1:37:11 PM AEDT
UPDATE AD_PrintFormatItem SET SortNo=0, IsPageBreak='N', YPosition=0, IsHeightOneLine='N', XPosition=0, IsGroupBy='N',Updated=TO_TIMESTAMP('2022-03-03 13:37:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=612
;

-- Mar 3, 2022, 1:38:32 PM AEDT
UPDATE AD_PrintFormat SET AD_PrintFont_ID=160,Updated=TO_TIMESTAMP('2022-03-03 13:38:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=122
;

-- Mar 3, 2022, 1:38:38 PM AEDT
UPDATE AD_PrintFormat SET AD_PrintFont_ID=160,Updated=TO_TIMESTAMP('2022-03-03 13:38:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=123
;

-- Mar 3, 2022, 1:40:24 PM AEDT
UPDATE AD_PrintFormatItem SET PrintName='Sales Order 	:', YSpace=0, SortNo=0, IsPageBreak='N', XSpace=0, IsGroupBy='N',Updated=TO_TIMESTAMP('2022-03-03 13:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=749
;

-- Mar 3, 2022, 1:41:38 PM AEDT
UPDATE AD_PrintFormatItem SET PrintName='Warehouse  	:', SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsGroupBy='N',Updated=TO_TIMESTAMP('2022-03-03 13:41:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=754
;

-- Mar 3, 2022, 1:42:19 PM AEDT
UPDATE AD_PrintFormat SET AD_PrintFont_ID=160,Updated=TO_TIMESTAMP('2022-03-03 13:42:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=120
;

-- Mar 3, 2022, 1:42:26 PM AEDT
UPDATE AD_PrintFormat SET AD_PrintFont_ID=160,Updated=TO_TIMESTAMP('2022-03-03 13:42:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=121
;

-- Mar 3, 2022, 1:42:56 PM AEDT
UPDATE AD_PrintFormatItem SET PrintName='Sales Order 	:', YSpace=0, SortNo=0, IsPageBreak='N', XSpace=0, IsGroupBy='N',Updated=TO_TIMESTAMP('2022-03-03 13:42:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=685
;

-- Mar 4, 2022, 10:04:21 PM AEDT
UPDATE AD_PrintFormatItem SET YSpace=20, SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsGroupBy='N',Updated=TO_TIMESTAMP('2022-03-04 22:04:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=631
;

-- Mar 4, 2022, 10:06:42 PM AEDT
UPDATE AD_PrintFormatItem SET YSpace=20, SortNo=0, IsPageBreak='N', YPosition=0, XPosition=0, IsGroupBy='N',Updated=TO_TIMESTAMP('2022-03-04 22:06:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=697
;
