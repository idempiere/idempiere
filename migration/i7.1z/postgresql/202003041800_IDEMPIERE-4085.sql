-- IDEMPIERE-4085 search in the toolbar
-- Mar 4, 2020, 4:44:41 PM CET
UPDATE AD_ToolBarButton SET SeqNo=30,Updated=TO_TIMESTAMP('2020-03-04 16:44:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200031
;

-- Mar 4, 2020, 4:44:45 PM CET
UPDATE AD_ToolBarButton SET SeqNo=40,Updated=TO_TIMESTAMP('2020-03-04 16:44:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200032
;

-- Mar 4, 2020, 4:44:49 PM CET
UPDATE AD_ToolBarButton SET SeqNo=50,Updated=TO_TIMESTAMP('2020-03-04 16:44:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200035
;

-- Mar 4, 2020, 4:44:55 PM CET
UPDATE AD_ToolBarButton SET SeqNo=60,Updated=TO_TIMESTAMP('2020-03-04 16:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200029
;

-- Mar 4, 2020, 4:44:57 PM CET
UPDATE AD_ToolBarButton SET SeqNo=20,Updated=TO_TIMESTAMP('2020-03-04 16:44:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200038
;

-- Mar 4, 2020, 4:45:00 PM CET
UPDATE AD_ToolBarButton SET SeqNo=70,Updated=TO_TIMESTAMP('2020-03-04 16:45:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200041
;

-- Mar 4, 2020, 4:45:02 PM CET
UPDATE AD_ToolBarButton SET SeqNo=80,Updated=TO_TIMESTAMP('2020-03-04 16:45:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200053
;

-- Mar 4, 2020, 4:45:04 PM CET
UPDATE AD_ToolBarButton SET SeqNo=90,Updated=TO_TIMESTAMP('2020-03-04 16:45:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200049
;

-- Mar 4, 2020, 4:45:07 PM CET
UPDATE AD_ToolBarButton SET SeqNo=100,Updated=TO_TIMESTAMP('2020-03-04 16:45:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200078
;

-- Mar 4, 2020, 4:45:10 PM CET
UPDATE AD_ToolBarButton SET SeqNo=110,Updated=TO_TIMESTAMP('2020-03-04 16:45:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200051
;

-- Mar 4, 2020, 4:49:26 PM CET
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator,EntityType,isShowMore) VALUES (0,0,TO_TIMESTAMP('2020-03-04 16:49:25','YYYY-MM-DD HH24:MI:SS'),100,'SearchQuery','Y',200101,'Window - SearchQuery',TO_TIMESTAMP('2020-03-04 16:49:25','YYYY-MM-DD HH24:MI:SS'),100,'N',0,0,'b01e8ec6-1a3c-4f94-928b-4582e2c33f81','W',10,'N','Y','D','N')
;

-- Mar 4, 2020, 5:01:07 PM CET
UPDATE AD_Field SET DisplayLogic='@Action@=W  & @AD_ToolBarButton_ID@!200101', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-03-04 17:01:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206377
;

SELECT register_migration_script('202003041800_IDEMPIERE-4085.sql') FROM dual
;

