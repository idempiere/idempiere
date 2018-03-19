-- Aug 14, 2013 12:20:12 PM IST
-- IDEMPIERE-1243 It shall not be possible to change Organization on the Order Line
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-08-14 12:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2053
;

-- Aug 14, 2013 12:22:49 PM IST
-- IDEMPIERE-1243 It shall not be possible to change Organization on the Order Line
UPDATE AD_Column SET AD_Val_Rule_ID=189,Updated=TO_DATE('2013-08-14 12:22:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2223
;

-- Aug 14, 2013 12:34:17 PM IST
-- IDEMPIERE-1243 It shall not be possible to change Organization on the Order Line
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-08-14 12:34:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3409
;

-- Aug 14, 2013 6:06:28 PM MYT
-- IDEMPIERE-1243 It shall not be possible to change Organization on the Order Line
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-08-14 18:06:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1129
;

-- Aug 14, 2013 6:10:37 PM MYT
-- IDEMPIERE-1243 It shall not be possible to change Organization on the Order Line
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-08-14 18:10:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3388
;

SELECT register_migration_script('201308141244_IDEMPIERE-1243.sql') FROM dual
;