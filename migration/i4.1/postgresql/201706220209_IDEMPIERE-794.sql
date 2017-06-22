-- IDEMPIERE-794 Ticket #1001025 - Expand the views to provide more information / fix a reference that was wrongly defined
-- Jun 21, 2017 7:07:04 PM COT
UPDATE AD_Ref_Table SET AD_Table_ID=560, AD_Key=8490, AD_Display=8489,Updated=TO_TIMESTAMP('2017-06-21 19:07:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200055
;

SELECT register_migration_script('201706220209_IDEMPIERE-794.sql') FROM dual
;

