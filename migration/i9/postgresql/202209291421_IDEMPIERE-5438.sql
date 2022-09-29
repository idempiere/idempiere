-- IDEMPIERE-5438
SELECT register_migration_script('202209291421_IDEMPIERE-5438.sql') FROM dual;

-- Sep 29, 2022, 2:21:24 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200215,'AD_Role RoleType - WebService','Roles with RoleType = WebService','T',0,0,'Y',TO_TIMESTAMP('2022-09-29 14:21:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-29 14:21:23','YYYY-MM-DD HH24:MI:SS'),100,'D','N','aa03ad0d-015b-4c27-a83e-044aa156dbb1')
;

-- Sep 29, 2022, 2:21:53 PM CEST
UPDATE AD_Column SET AD_Reference_ID=18, AD_Reference_Value_ID=200215, IsUpdateable='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2022-09-29 14:21:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56768
;

-- Sep 29, 2022, 2:22:42 PM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200215,156,531,531,'AD_Role.RoleType = ''WS''',0,0,'Y',TO_TIMESTAMP('2022-09-29 14:22:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-29 14:22:42','YYYY-MM-DD HH24:MI:SS'),100,'N','D','27d57bf9-6dd4-426b-a8c9-c0e1a95b44d7')
;

-- Sep 29, 2022, 2:44:59 PM CEST
UPDATE AD_Reference SET Description='Roles with RoleType NULL or WebService',Updated=TO_TIMESTAMP('2022-09-29 14:44:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200215
;

-- Sep 29, 2022, 2:45:11 PM CEST
UPDATE AD_Ref_Table SET WhereClause='(AD_Role.RoleType IS NULL OR AD_Role.RoleType = ''WS'')',Updated=TO_TIMESTAMP('2022-09-29 14:45:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200215
;

