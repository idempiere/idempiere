-- IDEMPIERE-1848 can delete org, account record in "Account Schema Dimensions"
-- Jun 30, 2020, 10:11:59 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@ElementType@=AC | @ElementType@=OO', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2020-06-30 22:11:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1528
;

SELECT register_migration_script('202006302210_IDEMPIERE-1848.sql') FROM dual
;

