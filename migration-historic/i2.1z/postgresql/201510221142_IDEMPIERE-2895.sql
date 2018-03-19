-- IDEMPIERE-2895 UX: Save changes in Detail Tab of a Master-Detail window
-- Oct 21, 2015 2:37:45 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200318,'Detail',104,'D',0,0,'Y',TO_TIMESTAMP('2015-10-21 14:37:45','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2015-10-21 14:37:45','YYYY-MM-DD HH24:MI:SS'),0,'D','c08370ea-385c-4569-bc28-1b6a869f700a')
;

-- Oct 21, 2015 2:38:16 PM CEST
UPDATE AD_Val_Rule SET Name='AD_ToolBarButton Action - Window/Report/Detail', Code='AD_Ref_List.Value IN (''W'',''R'',''D'')',Updated=TO_TIMESTAMP('2015-10-22 10:25:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=200002
;

-- Oct 21, 2015 2:45:15 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator) VALUES (0,0,TO_TIMESTAMP('2015-10-21 14:45:15','YYYY-MM-DD HH24:MI:SS'),0,'New','Y',200082,'Detail - New',TO_TIMESTAMP('2015-10-21 14:45:15','YYYY-MM-DD HH24:MI:SS'),0,'N',0,0,'6851393a-1f9b-4dae-8562-3d206a87ae62','D',10,'N','N')
;

-- Oct 21, 2015 2:46:04 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator) VALUES (0,0,TO_TIMESTAMP('2015-10-21 14:46:04','YYYY-MM-DD HH24:MI:SS'),0,'Delete','Y',200083,'Detail - Delete',TO_TIMESTAMP('2015-10-21 14:46:04','YYYY-MM-DD HH24:MI:SS'),0,'N',0,0,'dd8ab071-0a60-42bc-948b-cd0a09d90fa3','D',30,'N','N')
;

-- Oct 21, 2015 2:46:28 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator) VALUES (0,0,TO_TIMESTAMP('2015-10-21 14:46:28','YYYY-MM-DD HH24:MI:SS'),0,'Save','Y',200084,'Detail - Save',TO_TIMESTAMP('2015-10-21 14:46:28','YYYY-MM-DD HH24:MI:SS'),0,'N',0,0,'fb6ffe6d-3e54-43ba-8fac-d7e6145af116','D',40,'N','N')
;

-- Oct 21, 2015 2:47:21 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator) VALUES (0,0,TO_TIMESTAMP('2015-10-21 14:47:21','YYYY-MM-DD HH24:MI:SS'),0,'Process','Y',200085,'Detail - Process',TO_TIMESTAMP('2015-10-21 14:47:21','YYYY-MM-DD HH24:MI:SS'),0,'N',0,0,'29608027-c79c-4a28-a8cb-89749077e0cd','D',50,'N','N')
;

-- Oct 21, 2015 2:47:35 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator) VALUES (0,0,TO_TIMESTAMP('2015-10-21 14:47:34','YYYY-MM-DD HH24:MI:SS'),0,'Edit','Y',200086,'Detail - Edit',TO_TIMESTAMP('2015-10-21 14:47:34','YYYY-MM-DD HH24:MI:SS'),0,'N',0,0,'11b7e9ee-5f06-4595-96ca-a14321b93c38','D',20,'N','N')
;

-- Oct 22, 2015 11:42:03 AM CEST
UPDATE AD_Field SET DisplayLogic='@Action@=W | @Action@=D',Updated=TO_TIMESTAMP('2015-10-22 11:42:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200070
;

-- Oct 22, 2015 11:42:13 AM CEST
UPDATE AD_Field SET DisplayLogic='@Action@=W | @Action@=D',Updated=TO_TIMESTAMP('2015-10-22 11:42:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200732
;

SELECT register_migration_script('201510221142_IDEMPIERE-2895.sql') FROM dual
;


