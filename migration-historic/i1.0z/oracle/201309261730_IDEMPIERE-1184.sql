-- Jul 17, 2013 3:14:50 PM COT
-- IDEMPIERE-1184 Register browser information available on AD_Session
UPDATE AD_Column SET FieldLength=2000,Updated=TO_DATE('2013-07-17 15:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54349
;

-- Jul 17, 2013 3:14:55 PM COT
-- IDEMPIERE-1184 Register browser information available on AD_Session
ALTER TABLE AD_Session MODIFY Description NVARCHAR2(2000) DEFAULT NULL 
;

SELECT register_migration_script('201309261730_IDEMPIERE-1184.sql') FROM dual
;

