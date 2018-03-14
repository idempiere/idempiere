SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 10, 2015 6:09:35 PM COT
-- IDEMPIERE-1596 Interest Area cannot be subscribed/unsubscribed in zkwebui
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2015-01-10 18:09:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5880
;

-- Jan 10, 2015 6:09:38 PM COT
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2015-01-10 18:09:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5877
;

-- Jan 10, 2015 6:11:10 PM COT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2015-01-10 18:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7769
;

-- Jan 10, 2015 6:11:22 PM COT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2015-01-10 18:11:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7765
;

SELECT register_migration_script('201501101812_IDEMPIERE-1596.sql') FROM dual
;

