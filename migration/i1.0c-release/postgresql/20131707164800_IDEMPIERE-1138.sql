-- Jul 16, 2013 5:50:07 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Ref_List SET Value='E',Updated=TO_TIMESTAMP('2013-07-16 17:50:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200046
;

-- Jul 16, 2013 5:56:21 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_BroadcastMessage SET BroadcastFrequency='E' WHERE BroadcastFrequency='U'
;

-- Jul 16, 2013 5:54:09 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Description,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200156,200020,'Repeat it until the message has been acknowledged','Until Acknowledge','d6b87260-502d-4984-b9e3-8daafde1acd9','A',TO_TIMESTAMP('2013-07-16 17:54:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-16 17:54:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 16, 2013 5:54:09 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200156 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 16, 2013 5:56:21 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Description,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200157,200020,'Repeat it until the message expires or until it has been acknowledged, whatever happens first','Until Expiration or Acknowledge','aa345f63-dfbe-4d18-aae4-e5ed06cd4407','O',TO_TIMESTAMP('2013-07-16 17:56:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-16 17:56:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 16, 2013 5:56:21 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200157 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 17, 2013 8:50:32 AM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-07-17 08:50:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200882
;

-- Jul 17, 2013 8:50:51 AM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2013-07-17 08:50:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200881
;

-- Jul 17, 2013 8:50:59 AM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Field SET IsDisplayed='N',Updated=TO_TIMESTAMP('2013-07-17 08:50:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200881
;

-- Jul 17, 2013 8:54:47 AM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Field SET DisplayLogic='@BroadcastType@!''I''',Updated=TO_TIMESTAMP('2013-07-17 08:54:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200873
;

-- Jul 17, 2013 9:14:17 AM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Field SET DisplayLogic='@BroadcastFrequency@=''E'' | @BroadcastFrequency@=''O''',Updated=TO_TIMESTAMP('2013-07-17 09:14:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200879
;

-- Jul 17, 2013 3:18:50 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,EntityType,Name,Code,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Org_ID,IsActive,AD_Client_ID) VALUES (200051,'D','AD_BroadcastMessage - Combination','AD_Ref_List.Value NOT IN(SELECT CASE WHEN AD_Client_ID<>0 THEN ''E'' ELSE ''1'' END FROM AD_Client WHERE AD_Client_ID=@#AD_Client_ID@)','S','9c09aaee-c787-4f30-900e-25412968812a',100,100,TO_TIMESTAMP('2013-07-17 15:18:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-17 15:18:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Jul 17, 2013 3:19:09 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Column SET AD_Val_Rule_ID=200051, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-07-17 15:19:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200989
;

-- Jul 17, 2013 4:29:38 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Field SET Help='<p>1. Just Once : Message will be broadcasted one time.&nbsp;</p>
<p><span style="line-height: 1.6em;">2. Until Acknowledge : Repeat it until the message has been acknowledged.&nbsp;</span></p>
<p><span style="line-height: 1.6em;">3.&nbsp;</span><span style="line-height: 1.6em;">Until Expiration or Acknowledge : Repeat it until&nbsp;the message expires or until it has been acknowledged, whatever happens first.</span></p>
<p><span style="line-height: 1.6em;">4.&nbsp;</span><span style="line-height: 1.6em;">Until Expiration : Repeat it until message expiration value.</span></p>
',Updated=TO_TIMESTAMP('2013-07-17 16:29:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200873
;

-- Jul 17, 2013 4:29:49 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Column SET Help='<p>1. Just Once : Message will be broadcasted one time.&nbsp;</p>
<p><span style="line-height: 1.6em;">2. Until Acknowledge : Repeat it until the message has been acknowledged.&nbsp;</span></p>
<p><span style="line-height: 1.6em;">3.&nbsp;</span><span style="line-height: 1.6em;">Until Expiration or Acknowledge : Repeat it until&nbsp;the message expires or until it has been acknowledged, whatever happens first.</span></p>
<p><span style="line-height: 1.6em;">4.&nbsp;</span><span style="line-height: 1.6em;">Until Expiration : Repeat it until message expiration value.</span></p>
',Updated=TO_TIMESTAMP('2013-07-17 16:29:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200984
;

-- Jul 17, 2013 4:29:49 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Field SET Name='Broadcast Frequency', Description='How Many Times Message Should be Broadcasted', Help='<p>1. Just Once : Message will be broadcasted one time.&nbsp;</p>
<p><span style="line-height: 1.6em;">2. Until Acknowledge : Repeat it until the message has been acknowledged.&nbsp;</span></p>
<p><span style="line-height: 1.6em;">3.&nbsp;</span><span style="line-height: 1.6em;">Until Expiration or Acknowledge : Repeat it until&nbsp;the message expires or until it has been acknowledged, whatever happens first.</span></p>
<p><span style="line-height: 1.6em;">4.&nbsp;</span><span style="line-height: 1.6em;">Until Expiration : Repeat it until message expiration value.</span></p>
' WHERE AD_Column_ID=200984 AND IsCentrallyMaintained='Y'
;

SELECT register_migration_script('20131707164800_IDEMPIERE-1138.sql') FROM dual
;

