-- Dec 27, 2020, 1:10:12 AM MYT
UPDATE AD_Window SET IsActive='N',Updated=TO_TIMESTAMP('2020-12-27 01:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=389
;

-- Dec 27, 2020, 1:10:12 AM MYT
UPDATE AD_Menu SET Name='LDAP Server', Description='LDAP Server to authenticate and authorize external systems based on iDempiere', IsActive='N',Updated=TO_TIMESTAMP('2020-12-27 01:10:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=594
;

SELECT register_migration_script('202012261710_IDEMPIERE-4610.sql') FROM dual
;

