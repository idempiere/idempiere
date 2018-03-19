SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 10, 2015 6:06:59 PM COT
-- IDEMPIERE-1594 Prospect defaults to Y wrongly
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2015-01-10 18:06:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2918
;

-- Jan 10, 2015 6:07:02 PM COT
ALTER TABLE C_BPartner MODIFY IsProspect CHAR(1) DEFAULT 'N'
;

-- Jan 10, 2015 6:07:03 PM COT
UPDATE C_BPartner SET IsProspect='N' WHERE IsProspect IS NULL
;

SELECT register_migration_script('201501101807_IDEMPIERE-1594.sql') FROM dual
;

