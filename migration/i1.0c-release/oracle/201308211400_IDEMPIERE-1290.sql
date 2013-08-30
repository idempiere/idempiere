-- Aug 21, 2013 1:44:20 PM COT
-- IDEMPIERE-1290 Can't see/select the Label Printer in the window Print Label
UPDATE AD_Column SET AD_Reference_ID=19,Updated=TO_DATE('2013-08-21 13:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=9875
;

SELECT register_migration_script('201308211400_IDEMPIERE-1290.sql') FROM dual
;
