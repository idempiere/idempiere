-- Sep 26, 2013 11:06:55 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET SeqNo=30, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-26 11:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200011
;

-- Sep 26, 2013 11:06:55 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-26 11:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200008
;

-- Sep 26, 2013 11:06:55 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-26 11:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200007
;

-- Sep 26, 2013 11:06:55 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-26 11:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200015
;

-- Sep 26, 2013 11:06:55 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-26 11:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200025
;

-- Sep 26, 2013 11:06:55 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-26 11:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200023
;

-- Sep 26, 2013 11:06:55 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET SeqNo=160, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-26 11:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200021
;

-- Sep 26, 2013 11:06:55 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET SeqNo=180, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-09-26 11:06:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200019
;

-- Sep 26, 2013 11:07:27 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET DisplayLogic='@M_MovementLine_ID@!0',Updated=TO_TIMESTAMP('2013-09-26 11:07:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200018
;

-- Sep 26, 2013 11:07:41 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET DisplayLogic='@C_InvoiceLine_ID@!0',Updated=TO_TIMESTAMP('2013-09-26 11:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200017
;

-- Sep 26, 2013 11:07:57 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET DisplayLogic='@M_InventoryLine_ID@!0',Updated=TO_TIMESTAMP('2013-09-26 11:07:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200028
;

-- Sep 26, 2013 11:08:09 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET DisplayLogic='@M_ProductionLine_ID@!0',Updated=TO_TIMESTAMP('2013-09-26 11:08:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200030
;

-- Sep 26, 2013 11:08:24 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET DisplayLogic='@C_ProjectIssue_ID@!0',Updated=TO_TIMESTAMP('2013-09-26 11:08:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200031
;

-- Sep 26, 2013 11:08:40 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET DisplayLogic='@C_OrderLine_ID@!0',Updated=TO_TIMESTAMP('2013-09-26 11:08:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200033
;

-- Sep 26, 2013 11:08:53 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET DisplayLogic='@M_InOutLine_ID@!0',Updated=TO_TIMESTAMP('2013-09-26 11:08:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200034
;

-- Sep 26, 2013 11:09:09 AM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Field SET DisplayLogic='@M_MatchInv_ID@!0',Updated=TO_TIMESTAMP('2013-09-26 11:09:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202340
;

SELECT register_migration_script('201309260313_1002861.sql') FROM dual
;

