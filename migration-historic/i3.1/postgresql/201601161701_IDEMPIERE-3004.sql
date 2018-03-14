-- IDEMPIERE-3004: View Column - View Component require SeqNo
-- Jan 25, 2016 4:42:40 PM CET
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_ViewComponent WHERE AD_Table_ID=@AD_Table_ID@', IsUpdateable='N',Updated=TO_TIMESTAMP('2016-01-25 16:42:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210567
;

-- Jan 25, 2016 4:49:47 PM CET
UPDATE AD_Field SET SortNo=1.0,Updated=TO_TIMESTAMP('2016-01-25 16:49:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202233
;

SELECT register_migration_script('201601161701_IDEMPIERE-3004.sql') FROM dual
;

