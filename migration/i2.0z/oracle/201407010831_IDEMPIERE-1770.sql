SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 18, 2014 12:49:29 AM IST
-- IDEMPIERE-1770 Making Attribute tab Manually editable
UPDATE AD_Tab SET IsReadOnly='N', IsInsertRecord='Y',Updated=TO_DATE('2014-04-18 00:49:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=749
;

-- Apr 18, 2014 12:49:54 AM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2014-04-18 00:49:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12182
;

-- Apr 18, 2014 12:49:59 AM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2014-04-18 00:49:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12184
;

-- Apr 18, 2014 12:54:05 AM IST
UPDATE AD_Tab SET IsReadOnly='N', IsInsertRecord='Y',Updated=TO_DATE('2014-04-18 00:54:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=750
;

-- Apr 18, 2014 12:54:25 AM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2014-04-18 00:54:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12188
;

-- Apr 18, 2014 12:54:27 AM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2014-04-18 00:54:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12191
;

-- Apr 18, 2014 2:37:40 PM IST
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@',Updated=TO_DATE('2014-04-18 14:37:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13357
;

-- Apr 18, 2014 3:53:52 PM IST
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@',Updated=TO_DATE('2014-04-18 15:53:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13305
;


-- Apr 20, 2014 11:44:44 AM IST
-- IDEMPIERE-1770 Making Attribute tab Manually editable
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2014-04-20 11:44:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13355
;

-- Apr 20, 2014 11:45:36 AM IST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2014-04-20 11:45:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210653
;

-- Apr 20, 2014 11:46:25 AM IST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2014-04-20 11:46:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13303
;

-- Apr 20, 2014 11:46:56 AM IST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2014-04-20 11:46:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210651
;

-- Apr 20, 2014 12:43:45 PM IST
UPDATE AD_Tab SET IsReadOnly='N', IsInsertRecord='Y',Updated=TO_DATE('2014-04-20 12:43:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53134
;

-- Apr 20, 2014 12:43:57 PM IST
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2014-04-20 12:43:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=55368
;

-- Apr 20, 2014 12:44:24 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',36,'N','N',60903,60,'Y',202873,'N','M_InventoryLineMA_UU','56f2de3d-9fa1-4e67-bcd5-cdbfc3199071','N','N',100,0,TO_DATE('2014-04-20 12:44:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-04-20 12:44:22','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D',53134)
;

-- Apr 20, 2014 12:44:25 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',7,'N','N',210653,70,'Y',202874,'N','This field is used to record time used for LIFO and FIFO material policy','Time used for LIFO and FIFO Material Policy','Date  Material Policy','0d13babb-408e-43c1-ad73-8b5056ef3f5d','Y','N',100,0,TO_DATE('2014-04-20 12:44:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-04-20 12:44:24','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',53134)
;

-- Apr 20, 2014 12:45:00 PM IST
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2014-04-20 12:45:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202874
;

-- Apr 20, 2014 12:46:49 PM IST
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2014-04-20 12:46:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=55364
;

-- Apr 20, 2014 12:48:30 PM IST
UPDATE AD_Field SET XPosition=1,Updated=TO_DATE('2014-04-20 12:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=55366
;

SELECT register_migration_script('201407010831_IDEMPIERE-1770.sql') FROM dual
;
