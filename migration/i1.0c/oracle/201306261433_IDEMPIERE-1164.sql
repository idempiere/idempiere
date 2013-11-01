-- Jun 25, 2013 6:30:15 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_DATE('2013-06-25 18:30:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201369
;

-- Jun 25, 2013 6:30:56 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201366
;

-- Jun 25, 2013 6:30:56 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201369
;

-- Jun 25, 2013 6:30:56 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201895
;

-- Jun 25, 2013 6:30:56 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=56664
;

-- Jun 25, 2013 6:30:56 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=201367
;

-- Jun 25, 2013 6:30:56 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=201365
;

-- Jun 25, 2013 6:30:56 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=201368
;

-- Jun 25, 2013 6:48:01 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET DisplayLogic='@IsIdentifier@=''Y" & @AD_Column_ID@!0',Updated=TO_DATE('2013-06-25 18:48:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201365
;

-- Jun 25, 2013 6:48:57 PM IST
-- Changes in the layout of Web Service Security window
UPDATE AD_Field SET DisplayLogic='@IsIdentifier@=''Y" & @AD_Column_ID@!0',Updated=TO_DATE('2013-06-25 18:48:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201368
;

SELECT register_migration_script('201306261433_IDEMPIERE-1164.sql') FROM dual
;

