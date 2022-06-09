-- IDEMPIERE-5245   Fix typos in dictionary
SELECT register_migration_script('202205192100_IDEMPIERE-5245.sql') FROM dual;

-- May 19, 2022, 9:00:49 PM CEST
UPDATE AD_Message SET MsgText='Error while creating the Accounting Setup. 
Check the error log and the format of the Accounting*.csv file - No duplicate Accounts and all defaut accounts must be included (even if you will not use them).',Updated=TO_TIMESTAMP('2022-05-19 21:00:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=807
;

-- May 19, 2022, 9:05:36 PM CEST
UPDATE AD_Message SET MsgText='Org target is not  linked to BPartner', MsgTip='Org target is not linked to BPartner',Updated=TO_TIMESTAMP('2022-05-19 21:05:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53036
;

-- May 19, 2022, 9:06:24 PM CEST
UPDATE AD_Message SET MsgText='This utility is to import the products and Stock in Hand from a csv file into the system,<br> For importing the garment products, the CSV file name should contain the word ''Garment'' <br>The csv file should look like the one shown below including the header',Updated=TO_TIMESTAMP('2022-05-19 21:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=52188
;

-- May 19, 2022, 9:08:02 PM CEST
UPDATE AD_Message SET MsgText='Admin User Email is required',Updated=TO_TIMESTAMP('2022-05-19 21:08:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200522
;

-- May 19, 2022, 9:08:25 PM CEST
UPDATE AD_Message SET MsgText='Admin User Email',Updated=TO_TIMESTAMP('2022-05-19 21:08:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200523
;

-- May 19, 2022, 9:08:49 PM CEST
UPDATE AD_Message SET MsgText='Coa File',Updated=TO_TIMESTAMP('2022-05-19 21:08:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200527
;

-- May 19, 2022, 9:09:17 PM CEST
UPDATE AD_Message SET MsgText='Cannot read Coa File',Updated=TO_TIMESTAMP('2022-05-19 21:09:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200529
;

-- May 19, 2022, 9:09:44 PM CEST
UPDATE AD_Message SET MsgText='Document Type unknown',Updated=TO_TIMESTAMP('2022-05-19 21:09:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200560
;

-- May 19, 2022, 9:10:10 PM CEST
UPDATE AD_Message SET MsgText='Fact Line DR not created',Updated=TO_TIMESTAMP('2022-05-19 21:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200548
;

-- May 19, 2022, 9:10:26 PM CEST
UPDATE AD_Message SET MsgText='Fact Line CR not created',Updated=TO_TIMESTAMP('2022-05-19 21:10:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200550
;

-- May 19, 2022, 9:11:45 PM CEST
UPDATE AD_Message SET MsgText='Mobile No',Updated=TO_TIMESTAMP('2022-05-19 21:11:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=52223
;

-- May 19, 2022, 9:12:17 PM CEST
UPDATE AD_Message SET MsgText='No Order Line',Updated=TO_TIMESTAMP('2022-05-19 21:12:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200539
;

-- May 19, 2022, 9:12:37 PM CEST
UPDATE AD_Message SET MsgText='Normal User Email is required',Updated=TO_TIMESTAMP('2022-05-19 21:12:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200525
;

-- May 19, 2022, 9:13:56 PM CEST
UPDATE AD_Message SET MsgText='Normal User Email',Updated=TO_TIMESTAMP('2022-05-19 21:13:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200526
;

-- May 19, 2022, 9:14:32 PM CEST
UPDATE AD_Message SET MsgText='Some error occurred while communicating with the server. Please try again.',Updated=TO_TIMESTAMP('2022-05-19 21:14:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=52040
;

-- May 19, 2022, 9:14:53 PM CEST
UPDATE AD_Message SET MsgText='Enforce Override Limit Price',Updated=TO_TIMESTAMP('2022-05-19 21:14:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=52489
;

-- May 19, 2022, 9:15:37 PM CEST
UPDATE AD_Message SET MsgText='Price List Version',Updated=TO_TIMESTAMP('2022-05-19 21:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=423
;

-- May 19, 2022, 9:16:03 PM CEST
UPDATE AD_Message SET MsgText='Product is not on Price List',Updated=TO_TIMESTAMP('2022-05-19 21:16:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=805
;

-- May 19, 2022, 9:16:39 PM CEST
UPDATE AD_Message SET MsgText='Created index successfully',Updated=TO_TIMESTAMP('2022-05-19 21:16:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200196
;

-- May 19, 2022, 9:17:47 PM CEST
UPDATE AD_Message SET MsgText='Enforce Discount up to Limit Price',Updated=TO_TIMESTAMP('2022-05-19 21:17:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=52488
;


-- Jun 8, 2022, 6:50:40 PM CEST
UPDATE AD_Message SET MsgText='Error while creating the Accounting Setup. 
Check the error log and the format of the Accounting*.csv file - No duplicate Accounts and all default accounts must be included (even if you will not use them).',Updated=TO_TIMESTAMP('2022-06-08 18:50:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=807
;

-- Jun 8, 2022, 6:53:56 PM CEST
UPDATE AD_Message SET MsgText='CoA File',Updated=TO_TIMESTAMP('2022-06-08 18:53:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200527
;

-- Jun 8, 2022, 6:54:23 PM CEST
UPDATE AD_Message SET MsgText='Cannot read CoA File',Updated=TO_TIMESTAMP('2022-06-08 18:54:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200529
;

