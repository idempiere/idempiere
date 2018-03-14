SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2405 Implement SaaS support for Setup Wizard
-- Apr 28, 2016 12:59:00 PM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2016-04-28 12:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4986
;

-- Apr 28, 2016 12:59:11 PM COT
ALTER TABLE C_BP_Group_Acct MODIFY V_Liability_Services_Acct NUMBER(10) DEFAULT NULL 
;

-- Apr 28, 2016 12:59:11 PM COT
ALTER TABLE C_BP_Group_Acct MODIFY V_Liability_Services_Acct NULL
;

SELECT register_migration_script('201604281128_IDEMPIERE-3087.sql') FROM dual
;

