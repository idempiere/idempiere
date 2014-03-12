-- Mar 13, 2014 3:37:35 AM ICT
UPDATE AD_Field SET DisplayLogic='@Processed@=Y & @M_Product_ID.IsBOM@=Y',Updated=TO_TIMESTAMP('2014-03-13 03:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200271
;
SELECT register_migration_script('201403131604_IDEMPIERE-1742.sql') FROM dual
;
