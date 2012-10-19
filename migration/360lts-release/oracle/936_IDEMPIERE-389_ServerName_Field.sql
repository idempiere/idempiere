-- Oct 16, 2012 11:39:49 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',475,36,'N','N',60501,'Y',200638,'N','D','AD_Session_UU','N','Y','bf38a28b-bfab-4c21-8626-18322acd7807',100,0,TO_DATE('2012-10-16 11:39:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-16 11:39:47','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 16, 2012 11:39:49 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200638 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 16, 2012 11:39:50 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',475,40,'N','N',200613,'Y',200639,'N','Node instance name','D','Server Name','N','Y','7b8abf7a-5cb6-4d8e-9ed4-a0191ea16c7f',100,0,TO_DATE('2012-10-16 11:39:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-10-16 11:39:49','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 16, 2012 11:39:50 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200639 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 16, 2012 11:42:31 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200639
;

-- Oct 16, 2012 11:42:31 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=6620
;

-- Oct 16, 2012 11:42:31 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=54394
;

-- Oct 16, 2012 11:42:31 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=54395
;

-- Oct 16, 2012 11:42:31 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=54393
;

-- Oct 16, 2012 11:42:31 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=6622
;

-- Oct 16, 2012 11:42:31 AM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200638
;

-- Oct 16, 2012 12:01:13 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200639
;

-- Oct 16, 2012 12:01:13 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=6620
;

-- Oct 16, 2012 12:01:13 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=54394
;

-- Oct 16, 2012 12:01:13 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=54395
;

-- Oct 16, 2012 12:01:13 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=54393
;

-- Oct 16, 2012 12:01:13 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=6622
;

-- Oct 16, 2012 12:01:13 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200638
;

-- Oct 16, 2012 12:03:37 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-10-16 12:03:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200639
;

-- Oct 16, 2012 12:04:28 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET XPosition=3,Updated=TO_DATE('2012-10-16 12:04:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200639
;

-- Oct 16, 2012 12:05:12 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET XPosition=1,Updated=TO_DATE('2012-10-16 12:05:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200639
;

-- Oct 16, 2012 12:05:44 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET IsSameLine='N',Updated=TO_DATE('2012-10-16 12:05:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200639
;

-- Oct 16, 2012 12:06:43 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2012-10-16 12:06:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6620
;

-- Oct 16, 2012 12:11:26 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=110, XPosition=1,Updated=TO_DATE('2012-10-16 12:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54394
;

-- Oct 16, 2012 12:11:43 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2012-10-16 12:11:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54395
;

-- Oct 16, 2012 12:12:44 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2012-10-16 12:12:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54394
;


SELECT register_migration_script('936_IDEMPIERE-389_ServerName_Field.sql') FROM dual
;
