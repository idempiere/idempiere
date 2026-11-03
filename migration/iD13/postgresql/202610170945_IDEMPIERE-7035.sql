-- IDEMPIERE-7035 Allow saving asset group account when asset group is not depreciated
SELECT register_migration_script('202610170945_IDEMPIERE-7035.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 17, 2026, 9:45:00 AM ICT
ALTER TABLE A_Asset_Group_Acct MODIFY A_Depreciation_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 17, 2026, 9:45:00 AM ICT
ALTER TABLE A_Asset_Group_Acct MODIFY A_Depreciation_ID NULL
;

-- Oct 17, 2026, 9:45:00 AM ICT
ALTER TABLE A_Asset_Group_Acct MODIFY A_Depreciation_F_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 17, 2026, 9:45:00 AM ICT
ALTER TABLE A_Asset_Group_Acct MODIFY A_Depreciation_F_ID NULL
;

-- Oct 17, 2026, 9:45:00 AM ICT
UPDATE AD_Column SET IsMandatory='N', MandatoryLogic='@IsDepreciated@=Y', Updated=TO_TIMESTAMP('2026-10-17 09:45:00','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Column_ID=55759
;

-- Oct 17, 2026, 9:45:00 AM ICT
UPDATE AD_Column SET IsMandatory='N', MandatoryLogic='@IsDepreciated@=Y', Updated=TO_TIMESTAMP('2026-10-17 09:45:00','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Column_ID=59407
;
