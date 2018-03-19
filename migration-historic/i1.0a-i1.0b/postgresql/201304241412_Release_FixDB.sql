-- Apr 24, 2013 1:24:51 PM COT
-- Release fix db problems
UPDATE AD_Column SET AD_Process_ID=NULL,Updated=TO_TIMESTAMP('2013-04-24 13:24:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50110
;

update ad_field set isdisplayedgrid='N' where ad_field_id in (
200848,
200891,
200870
)
;

SELECT register_migration_script('201304241412_Release_FixDB.sql') FROM dual
;

