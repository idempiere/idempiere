SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 3, 2014 9:38:10 AM COT
-- IDEMPIERE-2342 SearchDefinition - query : could show record of other tenants
UPDATE AD_SearchDefinition SET Query='SELECT b.C_BPartner_ID FROM C_BPartner b
INNER JOIN AD_User u ON (b.C_BPartner_ID = u.C_BPartner_ID)
WHERE (UPPER(b.name) LIKE UPPER(?) OR UPPER(u.name) LIKE UPPER(?))
AND b.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2014-12-03 09:38:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SearchDefinition_ID=50001
;

SELECT register_migration_script('201412030938_IDEMPIERE-2342.sql') FROM dual
;

