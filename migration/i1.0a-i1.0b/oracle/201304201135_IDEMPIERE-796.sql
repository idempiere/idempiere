-- Apr 20, 2013 11:34:34 AM COT
-- IDEMPIERE-796 All Fixed Asset Related Document Must Use New DocBaseType FAA
UPDATE AD_Column SET IsMandatory='N', IsActive='Y',Updated=TO_DATE('2013-04-20 11:34:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55559
;

-- Apr 20, 2013 11:34:42 AM COT
ALTER TABLE A_Depreciation_Entry MODIFY GL_Category_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 20, 2013 11:34:42 AM COT
ALTER TABLE A_Depreciation_Entry MODIFY GL_Category_ID NULL
;

-- Apr 20, 2013 11:34:55 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2013-04-20 11:34:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=55559
;

SELECT register_migration_script('201304201135_IDEMPIERE-796.sql') FROM dual
;

