-- IDEMPIERE-5245   Fix typos in dictionary
SELECT register_migration_script('202205031611_IDEMPIERE-5245.sql') FROM dual;

-- 3/05/2022, 4:11:52 p. m. GMT+02:00
UPDATE AD_Element SET Name='Ad hoc Conversion', PrintName='Ad hoc Conversion',Updated=TO_TIMESTAMP('2022-05-03 16:11:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1608
;

-- 3/05/2022, 4:13:26 p. m. GMT+02:00
UPDATE AD_Element SET Name='All Fields', PrintName='All Fields',Updated=TO_TIMESTAMP('2022-05-03 16:13:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53328
;

-- 3/05/2022, 4:14:31 p. m. GMT+02:00
UPDATE AD_Element SET Name='Allocated Amount',Updated=TO_TIMESTAMP('2022-05-03 16:14:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2677
;

-- 3/05/2022, 4:15:22 p. m. GMT+02:00
UPDATE AD_Element SET Name='Allow Info Cash Journal', PrintName='Allow Info Cash Journal',Updated=TO_TIMESTAMP('2022-05-03 16:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50048
;

-- 3/05/2022, 4:17:13 p. m. GMT+02:00
UPDATE AD_Element SET Description='Should allow null value for identifier field',Updated=TO_TIMESTAMP('2022-05-03 16:17:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200593
;

-- 3/05/2022, 4:21:50 p. m. GMT+02:00
UPDATE AD_Element SET Name='Allow Product Without Price List', PrintName='Allow Product Without Price List',Updated=TO_TIMESTAMP('2022-05-03 16:21:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203543
;

-- 3/05/2022, 4:22:07 p. m. GMT+02:00
UPDATE AD_Element SET Help='Allow product without price list on this document type.',Updated=TO_TIMESTAMP('2022-05-03 16:22:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203543
;

-- 3/05/2022, 4:23:36 p. m. GMT+02:00
UPDATE AD_Element SET Description='Length of alphabetical sequence to validate',Updated=TO_TIMESTAMP('2022-05-03 16:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200068
;

-- 3/05/2022, 4:25:14 p. m. GMT+02:00
UPDATE AD_Element SET Name='Amount Refunded', PrintName='Amount Refunded',Updated=TO_TIMESTAMP('2022-05-03 16:25:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52022
;

-- 3/05/2022, 4:26:12 p. m. GMT+02:00
UPDATE AD_Element SET Name='Amount Tendered', PrintName='Amount Tendered',Updated=TO_TIMESTAMP('2022-05-03 16:26:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52021
;

-- 3/05/2022, 4:27:50 p. m. GMT+02:00
UPDATE AD_Element SET Name='Asset Accum Depreciation Amt', PrintName='Asset Accum Depreciation Amt',Updated=TO_TIMESTAMP('2022-05-03 16:27:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53605
;

-- 3/05/2022, 4:28:49 p. m. GMT+02:00
UPDATE AD_Element SET Name='Asset Book Value Amt', PrintName='Asset Book Value Amt',Updated=TO_TIMESTAMP('2022-05-03 16:28:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53604
;

-- 3/05/2022, 4:29:46 p. m. GMT+02:00
UPDATE AD_Element SET Name='Attachment Method',Updated=TO_TIMESTAMP('2022-05-03 16:29:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200241
;

-- 3/05/2022, 4:31:19 p. m. GMT+02:00
UPDATE AD_Element SET Name='Attribute Set Type', PrintName='Attribute Set Type',Updated=TO_TIMESTAMP('2022-05-03 16:31:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202952
;

-- 3/05/2022, 4:32:06 p. m. GMT+02:00
UPDATE AD_Element SET Name='Auto complete', Description='Automatic completion for text fields', PrintName='Auto complete',Updated=TO_TIMESTAMP('2022-05-03 16:32:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53655
;

-- 3/05/2022, 4:35:04 p. m. GMT+02:00
UPDATE AD_Element SET Name='Base Price List',Updated=TO_TIMESTAMP('2022-05-03 16:35:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1259
;

-- 3/05/2022, 4:35:51 p. m. GMT+02:00
UPDATE AD_Element SET Name='Cash Drawer', PrintName='Cash Drawer',Updated=TO_TIMESTAMP('2022-05-03 16:35:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52015
;

-- 3/05/2022, 4:37:34 p. m. GMT+02:00
UPDATE AD_Element SET Name='Change Accumulated Depreciation', PrintName='Change Accumulated Depreciation',Updated=TO_TIMESTAMP('2022-05-03 16:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54230
;

-- 3/05/2022, 4:38:30 p. m. GMT+02:00
UPDATE AD_Element SET Name='Change Amt', PrintName='Change Amt',Updated=TO_TIMESTAMP('2022-05-03 16:38:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53611
;

-- 3/05/2022, 4:39:12 p. m. GMT+02:00
UPDATE AD_Element SET Name='Change Date', PrintName='Change Date',Updated=TO_TIMESTAMP('2022-05-03 16:39:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53610
;

-- 3/05/2022, 4:39:43 p. m. GMT+02:00
UPDATE AD_Element SET Name='Change Type', PrintName='Change Type',Updated=TO_TIMESTAMP('2022-05-03 16:39:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53609
;

-- 3/05/2022, 4:40:40 p. m. GMT+02:00
UPDATE AD_Element SET Name='Col Value', PrintName='Col Value',Updated=TO_TIMESTAMP('2022-05-03 16:40:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50012
;

-- 3/05/2022, 4:41:26 p. m. GMT+02:00
UPDATE AD_Element SET Name='Container XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', PrintName='Container XML',Updated=TO_TIMESTAMP('2022-05-03 16:41:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2995
;

-- 3/05/2022, 4:42:27 p. m. GMT+02:00
UPDATE AD_Element SET Name='Convention Type', PrintName='Convention Type',Updated=TO_TIMESTAMP('2022-05-03 16:42:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53585
;

-- 3/05/2022, 4:42:56 p. m. GMT+02:00
UPDATE AD_Element SET Name='Created Date', PrintName='Created Date',Updated=TO_TIMESTAMP('2022-05-03 16:42:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50002
;

-- 3/05/2022, 4:43:59 p. m. GMT+02:00
UPDATE AD_Element SET ColumnName='CreatorContact', Name='Creator Contact', PrintName='Creator Contact',Updated=TO_TIMESTAMP('2022-05-03 16:43:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50008
;

-- 3/05/2022, 4:45:08 p. m. GMT+02:00
UPDATE AD_Element SET Name='Currency Rate Type', PrintName='Currency Rate Type',Updated=TO_TIMESTAMP('2022-05-03 16:45:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53503
;

-- 3/05/2022, 4:46:18 p. m. GMT+02:00
UPDATE AD_Element SET Description='Define number of day can reuse password',Updated=TO_TIMESTAMP('2022-05-03 16:46:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202868
;

-- 3/05/2022, 4:47:40 p. m. GMT+02:00
UPDATE AD_Element SET Name='DB Type', PrintName='DB Type',Updated=TO_TIMESTAMP('2022-05-03 16:47:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50026
;

-- 3/05/2022, 4:49:10 p. m. GMT+02:00
UPDATE AD_Element SET Name='Depreciation Type', PrintName='Depreciation Type',Updated=TO_TIMESTAMP('2022-05-03 16:49:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53474
;

-- 3/05/2022, 4:50:26 p. m. GMT+02:00
UPDATE AD_Element SET Name='Discount Price List', Description='Line of the price list trade discount schema', Help='For the Price list Discount Type, you enter how the list, standard and limit price is calculated.', PrintName='Discount Price List',Updated=TO_TIMESTAMP('2022-05-03 16:50:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1716
;

-- 3/05/2022, 4:51:37 p. m. GMT+02:00
UPDATE AD_Element SET Name='Document Base Type',Updated=TO_TIMESTAMP('2022-05-03 16:51:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=865
;

-- 3/05/2022, 4:52:06 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Doc Type Name',Updated=TO_TIMESTAMP('2022-05-03 16:52:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2098
;

-- 3/05/2022, 4:53:09 p. m. GMT+02:00
UPDATE AD_Element SET Name='Duration Required', PrintName='Duration Required',Updated=TO_TIMESTAMP('2022-05-03 16:53:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53284
;

-- 3/05/2022, 4:53:53 p. m. GMT+02:00
UPDATE AD_Element SET Name='Exclude Ser No', PrintName='Exclude Ser No',Updated=TO_TIMESTAMP('2022-05-03 16:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2831
;

-- 3/05/2022, 4:54:34 p. m. GMT+02:00
UPDATE AD_Element SET Name='Float Before', PrintName='Float Before',Updated=TO_TIMESTAMP('2022-05-03 16:54:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53301
;

-- 3/05/2022, 4:55:43 p. m. GMT+02:00
UPDATE AD_Element SET Name='Info Related', PrintName='Info Related',Updated=TO_TIMESTAMP('2022-05-03 16:55:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202556
;

-- 3/05/2022, 4:56:22 p. m. GMT+02:00
UPDATE AD_Element SET Description='Input field validation query', Help='Input field validation query',Updated=TO_TIMESTAMP('2022-05-03 16:56:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203216
;

-- 3/05/2022, 4:59:16 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Batch Time', PrintName='Is Batch Time',Updated=TO_TIMESTAMP('2022-05-03 16:59:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53309
;

-- 3/05/2022, 5:00:06 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Auto Generate Lot',Updated=TO_TIMESTAMP('2022-05-03 17:00:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203078
;

-- 3/05/2022, 5:01:17 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Discount Allowed On Total', PrintName='Is Discount Allowed On Total',Updated=TO_TIMESTAMP('2022-05-03 17:01:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52052
;

-- 3/05/2022, 5:02:12 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Discount Up to Limit Price', PrintName='Is Discount Up to Limit Price',Updated=TO_TIMESTAMP('2022-05-03 17:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52051
;

-- 3/05/2022, 5:03:25 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Fixed Asset',Updated=TO_TIMESTAMP('2022-05-03 17:03:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200176
;

-- 3/05/2022, 5:05:29 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Fixed Asset Invoice', PrintName='Is Fixed Asset Invoice',Updated=TO_TIMESTAMP('2022-05-03 17:05:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=55168
;

-- 3/05/2022, 5:06:32 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Present For Product',Updated=TO_TIMESTAMP('2022-05-03 17:06:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52027
;

-- 3/05/2022, 5:07:07 p. m. GMT+02:00
UPDATE AD_Element SET Name='Issue User',Updated=TO_TIMESTAMP('2022-05-03 17:07:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2959
;

-- 3/05/2022, 5:07:44 p. m. GMT+02:00
UPDATE AD_Element SET Name='Is Use ASP', PrintName='Is Use ASP',Updated=TO_TIMESTAMP('2022-05-03 17:07:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53325
;

-- 3/05/2022, 5:08:20 p. m. GMT+02:00
UPDATE AD_Element SET Description='The Jasper Process used by the print engine if any process defined',Updated=TO_TIMESTAMP('2022-05-03 17:08:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50064
;

-- 3/05/2022, 5:09:05 p. m. GMT+02:00
UPDATE AD_Element SET Name='Key Code', Description='Key Code for shortcuts', PrintName='Key Code',Updated=TO_TIMESTAMP('2022-05-03 17:09:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200020
;

-- 3/05/2022, 5:10:28 p. m. GMT+02:00
UPDATE AD_Element SET Name='Layout Type',Updated=TO_TIMESTAMP('2022-05-03 17:10:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202714
;

-- 3/05/2022, 5:10:57 p. m. GMT+02:00
UPDATE AD_Element SET Name='Link URL', PrintName='Link URL',Updated=TO_TIMESTAMP('2022-05-03 17:10:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3027
;

-- 3/05/2022, 5:11:34 p. m. GMT+02:00
UPDATE AD_Element SET Name='List Price',Updated=TO_TIMESTAMP('2022-05-03 17:11:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2590
;

-- 3/05/2022, 5:12:31 p. m. GMT+02:00
UPDATE AD_Element SET Description='Want to Log the Acknowledgment of Message?',Updated=TO_TIMESTAMP('2022-05-03 17:12:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200246
;

-- 3/05/2022, 5:13:57 p. m. GMT+02:00
UPDATE AD_Element SET Description='The Client ID or Login submitted to the Lookup URL', Help='Enter the Client ID or Login for your account provided by the post code web service provider',Updated=TO_TIMESTAMP('2022-05-03 17:13:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=51002
;

-- 3/05/2022, 5:15:06 p. m. GMT+02:00
UPDATE AD_Element SET Name='Model Package', PrintName='Model Package',Updated=TO_TIMESTAMP('2022-05-03 17:15:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3053
;

-- 3/05/2022, 5:16:07 p. m. GMT+02:00
UPDATE AD_Element SET Description='Print column headers on multiple lines if necessary.',Updated=TO_TIMESTAMP('2022-05-03 17:16:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53690
;

-- 3/05/2022, 5:17:19 p. m. GMT+02:00
UPDATE AD_Element SET Name='New Password Confirm',Updated=TO_TIMESTAMP('2022-05-03 17:17:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200064
;

-- 3/05/2022, 5:18:16 p. m. GMT+02:00
UPDATE AD_Element SET Name='Next Maintenance', Description='Next Maintenance Date', PrintName='Next Maintenance',Updated=TO_TIMESTAMP('2022-05-03 17:18:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2932
;

-- 3/05/2022, 5:19:20 p. m. GMT+02:00
UPDATE AD_Element SET Name='Not Committed Amount',Updated=TO_TIMESTAMP('2022-05-03 17:19:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2416
;

-- 3/05/2022, 5:20:32 p. m. GMT+02:00
UPDATE AD_Element SET Name='Overwrite Trx Organization',Updated=TO_TIMESTAMP('2022-05-03 17:20:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2612
;

-- 3/05/2022, 5:22:44 p. m. GMT+02:00
UPDATE AD_Element SET Name='Posting Type', PrintName='Posting Type',Updated=TO_TIMESTAMP('2022-05-03 17:22:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=514
;

-- 3/05/2022, 5:23:51 p. m. GMT+02:00
UPDATE AD_Element SET Name='Privileged Rate', PrintName='Privileged Rate',Updated=TO_TIMESTAMP('2022-05-03 17:23:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=201981
;

-- 3/05/2022, 5:24:58 p. m. GMT+02:00
UPDATE AD_Element SET Name='Purchase Price List', PrintName='Purchase Price List',Updated=TO_TIMESTAMP('2022-05-03 17:24:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=480
;

-- 3/05/2022, 5:26:24 p. m. GMT+02:00
UPDATE AD_Element SET Name='Qty Batch', PrintName='Qty Batch',Updated=TO_TIMESTAMP('2022-05-03 17:26:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53302
;

-- 3/05/2022, 5:27:26 p. m. GMT+02:00
UPDATE AD_Element SET Name='Qty Required',Updated=TO_TIMESTAMP('2022-05-03 17:27:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53288
;

-- 3/05/2022, 5:28:21 p. m. GMT+02:00
UPDATE AD_Element SET Name='Qty Csv', PrintName='Qty Csv',Updated=TO_TIMESTAMP('2022-05-03 17:28:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52053
;

-- 3/05/2022, 5:29:19 p. m. GMT+02:00
UPDATE AD_Element SET Description='Length of QWERTY sequences to validate',Updated=TO_TIMESTAMP('2022-05-03 17:29:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200029
;

-- 3/05/2022, 5:30:27 p. m. GMT+02:00
UPDATE AD_Element SET Name='Require Credit Card Verification Code',Updated=TO_TIMESTAMP('2022-05-03 17:30:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1499
;

-- 3/05/2022, 5:31:31 p. m. GMT+02:00
UPDATE AD_Element SET Name='Sales Price List', PrintName='Sales Price List',Updated=TO_TIMESTAMP('2022-05-03 17:31:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52046
;

-- 3/05/2022, 5:33:23 p. m. GMT+02:00
UPDATE AD_Element SET Description='Scrap % Quantity for this component', Help='Scrap % Quantity for this component',Updated=TO_TIMESTAMP('2022-05-03 17:33:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53289
;

-- 3/05/2022, 5:39:10 p. m. GMT+02:00
UPDATE AD_Element SET Name='Ser No Char End Overwrite', PrintName='Ser No Char End',Updated=TO_TIMESTAMP('2022-05-03 17:39:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2857
;

-- 3/05/2022, 5:40:12 p. m. GMT+02:00
UPDATE AD_Element SET Name='Ser No Char Start Overwrite', PrintName='Ser No Char Start',Updated=TO_TIMESTAMP('2022-05-03 17:40:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2856
;

-- 3/05/2022, 5:47:31 p. m. GMT+02:00
UPDATE AD_Element SET Name='Setup Time Required', PrintName='Setup Time Required',Updated=TO_TIMESTAMP('2022-05-03 17:47:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53291
;

-- 3/05/2022, 5:48:04 p. m. GMT+02:00
UPDATE AD_Element SET Name='Shipper Name',Updated=TO_TIMESTAMP('2022-05-03 17:48:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54240
;

-- 3/05/2022, 5:49:38 p. m. GMT+02:00
UPDATE AD_Element SET Name='Structure XML', Description='Autogenerated Container definition as XML Code', Help='Autogenerated Container definition as XML Code', PrintName='Structure XML',Updated=TO_TIMESTAMP('2022-05-03 17:49:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2994
;

-- 3/05/2022, 5:50:14 p. m. GMT+02:00
UPDATE AD_Element SET Name='Template XST', PrintName='Template XST',Updated=TO_TIMESTAMP('2022-05-03 17:50:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2984
;

-- 3/05/2022, 5:50:53 p. m. GMT+02:00
UPDATE AD_Element SET Name='Time Out In Seconds', PrintName='Time out In Seconds',Updated=TO_TIMESTAMP('2022-05-03 17:50:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200256
;

-- 3/05/2022, 5:51:52 p. m. GMT+02:00
UPDATE AD_Element SET Name='Token Type',Updated=TO_TIMESTAMP('2022-05-03 17:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3103
;

-- 3/05/2022, 5:54:01 p. m. GMT+02:00
UPDATE AD_Element SET Name='Transfer Check trx to',Updated=TO_TIMESTAMP('2022-05-03 17:54:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52036
;

-- 3/05/2022, 5:55:04 p. m. GMT+02:00
UPDATE AD_Element SET Name='Transfer Time', PrintName='Transfer Time',Updated=TO_TIMESTAMP('2022-05-03 17:55:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53271
;

-- 3/05/2022, 5:56:44 p. m. GMT+02:00
UPDATE AD_Element SET Name='Translation Tab', PrintName='Translation Tab',Updated=TO_TIMESTAMP('2022-05-03 17:56:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=421
;

-- 3/05/2022, 5:57:14 p. m. GMT+02:00
UPDATE AD_Element SET Name='Units Per Pack', PrintName='Units Per Pack',Updated=TO_TIMESTAMP('2022-05-03 17:57:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52054
;

-- 3/05/2022, 5:57:59 p. m. GMT+02:00
UPDATE AD_Element SET Name='Unlocking Time', PrintName='Unlocking Time',Updated=TO_TIMESTAMP('2022-05-03 17:57:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52047
;

-- 3/05/2022, 5:58:31 p. m. GMT+02:00
UPDATE AD_Element SET Name='Updated Date', PrintName='Updated Date',Updated=TO_TIMESTAMP('2022-05-03 17:58:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50004
;

-- 3/05/2022, 6:00:07 p. m. GMT+02:00
UPDATE AD_Element SET Name='Use Date', PrintName='Use Date',Updated=TO_TIMESTAMP('2022-05-03 18:00:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53643
;

-- 3/05/2022, 6:00:34 p. m. GMT+02:00
UPDATE AD_Element SET Name='User Discount', PrintName='User Discount',Updated=TO_TIMESTAMP('2022-05-03 18:00:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=52024
;

-- 3/05/2022, 6:01:04 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Validate workflow',Updated=TO_TIMESTAMP('2022-05-03 18:01:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2463
;

-- 3/05/2022, 6:01:28 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param 1',Updated=TO_TIMESTAMP('2022-05-03 18:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1989
;

-- 3/05/2022, 6:01:50 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param 2',Updated=TO_TIMESTAMP('2022-05-03 18:01:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1990
;

-- 3/05/2022, 6:02:13 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param 3',Updated=TO_TIMESTAMP('2022-05-03 18:02:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1991
;

-- 3/05/2022, 6:02:41 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param 4',Updated=TO_TIMESTAMP('2022-05-03 18:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1992
;

-- 3/05/2022, 6:03:21 p. m. GMT+02:00
UPDATE AD_Element SET PrintName='Web Param 6',Updated=TO_TIMESTAMP('2022-05-03 18:03:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2176
;

-- 3/05/2022, 6:03:56 p. m. GMT+02:00
UPDATE AD_Element SET Name='Window Type', PrintName='Window Type',Updated=TO_TIMESTAMP('2022-05-03 18:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=631
;

-- 3/05/2022, 6:04:29 p. m. GMT+02:00
UPDATE AD_Element SET Name='Workflow Processor Log',Updated=TO_TIMESTAMP('2022-05-03 18:04:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2359
;

-- 3/05/2022, 6:04:55 p. m. GMT+02:00
UPDATE AD_Element SET Name='Year Month', PrintName='Year Month',Updated=TO_TIMESTAMP('2022-05-03 18:04:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200062
;
