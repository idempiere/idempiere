SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 10, 2015 5:23:47 PM COT
-- IDEMPIERE-1413 User Substitute list must show just tenant users
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_DATE('2015-01-10 17:23:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=573
;

-- Jan 10, 2015 5:25:45 PM COT
UPDATE AD_Column SET AD_Val_Rule_ID=200052,Updated=TO_DATE('2015-01-10 17:25:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10412
;

-- Jan 10, 2015 5:28:21 PM COT
UPDATE AD_Val_Rule SET Name='AD_User with role on Client',Updated=TO_DATE('2015-01-10 17:28:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200052
;

-- Jan 10, 2015 5:28:50 PM COT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200066,'AD_User of Client with role on Client','S','AD_User.AD_Client_ID=@#AD_Client_ID@ AND AD_User.AD_User_ID IN (SELECT AD_User_ID FROM AD_User_Roles WHERE IsActive=''Y'' AND AD_User_Roles.AD_Client_ID=@#AD_Client_ID@)',0,0,'Y',TO_DATE('2015-01-10 17:28:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-10 17:28:50','YYYY-MM-DD HH24:MI:SS'),100,'D','24b4843c-bd1c-41ae-958b-0e6a86d7ff47')
;

-- Jan 10, 2015 5:28:59 PM COT
UPDATE AD_Column SET AD_Val_Rule_ID=200066,Updated=TO_DATE('2015-01-10 17:28:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10412
;

SELECT register_migration_script('201501101729_IDEMPIERE-1413.sql') FROM dual
;

