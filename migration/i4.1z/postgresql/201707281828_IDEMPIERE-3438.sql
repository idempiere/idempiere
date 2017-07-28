-- IDEMPIERE-3438
-- Jul 28, 2017 6:27:15 PM CEST
UPDATE AD_Column SET FKConstraintName=NULL, FKConstraintType='D',Updated=TO_TIMESTAMP('2017-07-28 18:27:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212804
;

-- Jul 28, 2017 6:27:16 PM CEST
ALTER TABLE AD_CtxHelpSuggestion DROP CONSTRAINT aduserclient_adctxhelpsuggesti
;

-- Jul 28, 2017 6:27:37 PM CEST
UPDATE AD_Column SET FKConstraintName=NULL, FKConstraintType='D',Updated=TO_TIMESTAMP('2017-07-28 18:27:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212805
;

-- Jul 28, 2017 6:27:39 PM CEST
ALTER TABLE AD_CtxHelpSuggestion DROP CONSTRAINT aduser_adctxhelpsuggestion
;

-- Jul 28, 2017 6:27:55 PM CEST
UPDATE AD_Column SET FKConstraintName=NULL, FKConstraintType='D',Updated=TO_TIMESTAMP('2017-07-28 18:27:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212779
;

-- Jul 28, 2017 6:27:56 PM CEST
ALTER TABLE AD_FieldSuggestion DROP CONSTRAINT aduserclient_adfieldsuggestion
;

-- Jul 28, 2017 6:28:02 PM CEST
UPDATE AD_Column SET FKConstraintName=NULL, FKConstraintType='D',Updated=TO_TIMESTAMP('2017-07-28 18:28:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212780
;

-- Jul 28, 2017 6:28:03 PM CEST
ALTER TABLE AD_FieldSuggestion DROP CONSTRAINT aduser_adfieldsuggestion
;

-- Jul 28, 2017 6:31:14 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200144,'AD_Client All Clients','Client selection','T',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:31:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:31:14','YYYY-MM-DD HH24:MI:SS'),100,'D','N','af992906-5d2e-4e4f-8cf4-01689ffa190f')
;

-- Jul 28, 2017 6:31:38 PM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200144,200223,213145,213154,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:31:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:31:38','YYYY-MM-DD HH24:MI:SS'),100,'N','D','128a3717-30a2-48fe-b9da-d04ee37bd736')
;

-- Jul 28, 2017 6:32:01 PM CEST
UPDATE AD_Column SET AD_Reference_Value_ID=200144,Updated=TO_TIMESTAMP('2017-07-28 18:32:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212779
;

-- Jul 28, 2017 6:32:03 PM CEST
UPDATE AD_Column SET AD_Reference_Value_ID=200144,Updated=TO_TIMESTAMP('2017-07-28 18:32:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212804
;

-- Jul 28, 2017 6:32:36 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200145,'AD_User Users from all Clients','Users from all clients','T',0,0,'Y',TO_TIMESTAMP('2017-07-28 18:32:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:32:35','YYYY-MM-DD HH24:MI:SS'),100,'D','N','cabfba5a-23ab-450c-bacf-ebcda08039ae')
;

-- Jul 28, 2017 6:32:56 PM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200145,200224,213158,213168,0,0,'Y',TO_TIMESTAMP('2017-07-28 18:32:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-28 18:32:56','YYYY-MM-DD HH24:MI:SS'),100,'N','D','ac22117d-10eb-4356-bb62-a6c4cad02115')
;

-- Jul 28, 2017 6:33:12 PM CEST
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=200145, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2017-07-28 18:33:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212805
;

-- Jul 28, 2017 6:33:19 PM CEST
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=200145, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2017-07-28 18:33:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212780
;

-- Jul 28, 2017 6:33:25 PM CEST
UPDATE AD_Column SET FKConstraintType='D',Updated=TO_TIMESTAMP('2017-07-28 18:33:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212780
;

-- Jul 28, 2017 6:33:29 PM CEST
UPDATE AD_Column SET FKConstraintType='D',Updated=TO_TIMESTAMP('2017-07-28 18:33:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212805
;

SELECT register_migration_script('201707281828_IDEMPIERE-3438.sql') FROM dual
;

