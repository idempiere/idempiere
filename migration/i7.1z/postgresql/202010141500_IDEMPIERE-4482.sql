-- Oct 14, 2020, 11:28:34 AM MYT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator,EntityType,IsShowMore) VALUES (0,0,TO_TIMESTAMP('2020-10-14 11:28:33','YYYY-MM-DD HH24:MI:SS'),100,'Customize','Y',200108,'Detail - Customize',TO_TIMESTAMP('2020-10-14 11:28:33','YYYY-MM-DD HH24:MI:SS'),100,'N',0,0,'5b08fba8-f90e-4e27-8690-e4c7bbc242d2','D',0,'N','N','D','N')
;

-- Oct 14, 2020, 11:29:29 AM MYT
UPDATE AD_ToolBarButton SET SeqNo=60,Updated=TO_TIMESTAMP('2020-10-14 11:29:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200095
;

-- Oct 14, 2020, 11:29:34 AM MYT
UPDATE AD_ToolBarButton SET SeqNo=70,Updated=TO_TIMESTAMP('2020-10-14 11:29:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200108
;

SELECT register_migration_script('202010141500_IDEMPIERE-4482.sql') FROM dual
;

