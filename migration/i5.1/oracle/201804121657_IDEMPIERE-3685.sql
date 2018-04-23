SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3685
-- Apr 12, 2018 4:51:48 PM CEST
UPDATE AD_Tab SET WhereClause='(AD_Field.IsDisplayed=''Y'' OR AD_Field.IsDisplayedGrid=''Y'')', OrderByClause='AD_Field.SeqNo, AD_Field.SeqNoGrid',Updated=TO_DATE('2018-04-12 16:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=107
;

SELECT register_migration_script('201804121657_IDEMPIERE-3685.sql') FROM dual
;

