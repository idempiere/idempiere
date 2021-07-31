SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4748 Window, Tab & Field: Fields that are not displayed in the frontend window are hidden also in the backend.
-- Apr 12, 2021, 12:25:49 PM CEST
UPDATE AD_Tab SET WhereClause=NULL, OrderByClause='CASE WHEN AD_Field.IsActive=''Y'' AND (AD_Field.IsDisplayed=''Y'' OR AD_Field.IsDisplayedGrid=''Y'') THEN 0 ELSE 1 END, AD_Field.SeqNo, AD_Field.SeqNoGrid, AD_Field.AD_Field_ID',Updated=TO_DATE('2021-04-12 12:25:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=107
;

SELECT register_migration_script('202104121227_IDEMPIERE-4748.sql') FROM dual
;

