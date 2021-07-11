-- Feb 14, 2021, 10:47:10 AM IST
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-14 10:47:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5707
;

update AD_Tab set ad_tabtype='SORT' where isSortTab='Y';

SELECT register_migration_script('202102141100_IDEMPIERE-2853.sql') FROM dual
;
