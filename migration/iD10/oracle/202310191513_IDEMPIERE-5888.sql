-- IDEMPIERE-5888 Login Preferences are created on System tenant
SELECT register_migration_script('202310191513_IDEMPIERE-5888.sql') FROM dual;

-- 19/10/2023, 3:13:51 p. m. GMT+02:00
UPDATE AD_Preference
SET AD_Client_ID=(SELECT AD_Client_ID FROM AD_User WHERE AD_User_ID=AD_Preference.AD_User_ID),
    AD_Org_ID=0
WHERE AD_Client_ID!=(SELECT AD_Client_ID FROM AD_User WHERE AD_User_ID=AD_Preference.AD_User_ID)
    AND Attribute IN ('Language','Role','Client','Organization','Warehouse')
;

