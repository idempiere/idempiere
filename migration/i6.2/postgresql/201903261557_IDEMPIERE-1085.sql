-- IDEMPIERE-1085 Loading Info windows dynamically
-- Mar 26, 2019, 3:56:49 PM BRT
UPDATE AD_Column SET DefaultValue='@SQL=SELECT NVL(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_InfoWindow',Updated=TO_TIMESTAMP('2019-03-26 15:56:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210510
;

SELECT register_migration_script('201903261557_IDEMPIERE-1085.sql') FROM dual
;

