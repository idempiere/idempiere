-- Apr 10, 2013 9:58:31 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
INSERT INTO AD_Field (ColumnSpan,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,NumLines) VALUES (1,0,'N',402,0,'N','N',14726,560,'Y',201896,'N','Date when the task is planned to be complete','D','Planned Completion Date','Complete Plan','5180aa2f-2af0-4421-ae30-02328180bafe','Y','N',100,0,TO_TIMESTAMP('2013-04-10 09:58:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-04-10 09:58:30','YYYY-MM-DD HH24:MI:SS'),'Y','Y',540,1,'N',0,1)
;

-- Apr 10, 2013 9:58:31 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201896 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 10, 2013 10:03:54 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
INSERT INTO AD_Field (ColumnSpan,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,NumLines) VALUES (1,0,'N',402,0,'N','N',14734,570,'Y',201897,'N','Date when you plan to start','D','Planned Start Date','Start Plan','c318610c-187c-467a-885f-457b8d0d5209','Y','N',100,0,TO_TIMESTAMP('2013-04-10 10:03:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-04-10 10:03:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',550,1,'N',0,1)
;

-- Apr 10, 2013 10:03:54 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201897 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 10, 2013 10:07:11 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-04-10 10:07:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201897
;

-- Apr 10, 2013 10:07:11 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-04-10 10:07:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201896
;

-- Apr 10, 2013 10:07:45 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
UPDATE AD_Column SET AD_Reference_ID=16,Updated=TO_TIMESTAMP('2013-04-10 10:07:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14726
;

-- Apr 10, 2013 10:07:59 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
UPDATE AD_Column SET AD_Reference_ID=16,Updated=TO_TIMESTAMP('2013-04-10 10:07:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14734
;

-- Apr 10, 2013 10:08:56 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
UPDATE AD_Field SET ColumnSpan=2, SeqNo=130,Updated=TO_TIMESTAMP('2013-04-10 10:08:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201897
;

-- Apr 10, 2013 10:08:56 AM COT
-- IDEMPIERE-791, Dates used in request calendar not visible in request
UPDATE AD_Field SET ColumnSpan=2, SeqNo=140,Updated=TO_TIMESTAMP('2013-04-10 10:08:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201896
;

SELECT register_migration_script('201304101012_IDEMPIERE-791.sql') FROM dual;

