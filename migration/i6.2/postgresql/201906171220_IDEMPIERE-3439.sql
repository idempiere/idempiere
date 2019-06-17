-- IDEMPIERE-3439-3936
-- Jun 17, 2019, 12:19:10 PM CEST
UPDATE AD_Column SET FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:19:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212804
;

-- Jun 17, 2019, 12:19:20 PM CEST
UPDATE AD_Column SET FKConstraintName='ADUserClient_ADCtxHelpSuggesti', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:19:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212804
;

-- Jun 17, 2019, 12:19:20 PM CEST
INSERT INTO t_alter_column values('ad_ctxhelpsuggestion','AD_UserClient_ID','NUMERIC(10)',null,null)
;

-- Jun 17, 2019, 12:19:20 PM CEST
ALTER TABLE AD_CtxHelpSuggestion ADD CONSTRAINT ADUserClient_ADCtxHelpSuggesti FOREIGN KEY (AD_UserClient_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 17, 2019, 12:19:40 PM CEST
UPDATE AD_Column SET FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:19:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212805
;

-- Jun 17, 2019, 12:19:42 PM CEST
UPDATE AD_Column SET FKConstraintName='ADUser_ADCtxHelpSuggestion', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:19:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212805
;

-- Jun 17, 2019, 12:19:42 PM CEST
INSERT INTO t_alter_column values('ad_ctxhelpsuggestion','AD_User_ID','NUMERIC(10)',null,null)
;

-- Jun 17, 2019, 12:19:42 PM CEST
ALTER TABLE AD_CtxHelpSuggestion ADD CONSTRAINT ADUser_ADCtxHelpSuggestion FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 17, 2019, 12:20:02 PM CEST
UPDATE AD_Column SET FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:20:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212779
;

-- Jun 17, 2019, 12:20:04 PM CEST
UPDATE AD_Column SET FKConstraintName='ADUserClient_ADFieldSuggestion', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:20:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212779
;

-- Jun 17, 2019, 12:20:04 PM CEST
INSERT INTO t_alter_column values('ad_fieldsuggestion','AD_UserClient_ID','NUMERIC(10)',null,null)
;

-- Jun 17, 2019, 12:20:04 PM CEST
ALTER TABLE AD_FieldSuggestion ADD CONSTRAINT ADUserClient_ADFieldSuggestion FOREIGN KEY (AD_UserClient_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 17, 2019, 12:20:12 PM CEST
UPDATE AD_Column SET FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212780
;

-- Jun 17, 2019, 12:20:13 PM CEST
UPDATE AD_Column SET FKConstraintName='ADUser_ADFieldSuggestion', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:20:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212780
;

-- Jun 17, 2019, 12:20:13 PM CEST
INSERT INTO t_alter_column values('ad_fieldsuggestion','AD_User_ID','NUMERIC(10)',null,null)
;

-- Jun 17, 2019, 12:20:13 PM CEST
ALTER TABLE AD_FieldSuggestion ADD CONSTRAINT ADUser_ADFieldSuggestion FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201906171220_IDEMPIERE-3439.sql') FROM dual
;

