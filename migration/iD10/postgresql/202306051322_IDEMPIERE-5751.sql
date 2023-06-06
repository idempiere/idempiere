-- IDEMPIERE-5751- Display the Link Order field when it is populated in Sales Order and Purchase Order
SELECT register_migration_script('202306051322_IDEMPIERE-5751.sql') FROM dual;

-- Jun 5, 2023, 1:22:15 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Link_Order_ID:0@>0', IsReadOnly='Y',Updated=TO_TIMESTAMP('2023-06-05 13:22:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201611
;

-- Jun 5, 2023, 1:23:07 PM CEST
UPDATE AD_Field SET SeqNo=610, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-06-05 13:23:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201611
;

-- Jun 5, 2023, 1:25:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207632,'Linked Order','This field links a sales order to the purchase order that is generated from it.',294,55322,'Y','@Link_Order_ID:0@>0
',0,490,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-05 13:25:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-05 13:25:13','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','e72aa65f-6623-43e9-9716-ed76f569a7a0','N',490,1,2,1,'N','N','N','N')
;

