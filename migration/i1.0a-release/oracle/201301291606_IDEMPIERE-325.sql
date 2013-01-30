-- Jan 25, 2013 5:00:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,IsDefault,IsDistinct,OrderByClause,IsValid) VALUES ('N','C_BPartner bp
LEFT OUTER JOIN C_BPartner_Location l ON (bp.C_BPartner_ID=l.C_BPartner_ID AND l.IsActive=''Y'')
LEFT OUTER JOIN AD_User c ON (bp.C_BPartner_ID=c.C_BPartner_ID AND (c.C_BPartner_Location_ID IS NULL OR c.C_BPartner_Location_ID=l.C_BPartner_Location_ID) AND c.IsActive=''Y'')
LEFT OUTER JOIN C_Location a ON (l.C_Location_ID=a.C_Location_ID)','bdb6ccb3-1aed-4b9e-92f4-9db792480cb4',200001,291,'D','Business Partner Info',0,0,TO_DATE('2013-01-25 17:00:39','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-25 17:00:39','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','N','N','bp.Value','N')
;

-- Jan 25, 2013 5:00:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('d5601d36-ca71-439b-9e54-7e536d2e9411',TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,50002,200001,0,0,TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 25, 2013 5:00:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('4d18fc73-b444-435c-9bb3-be403350dec4',TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,0,200001,0,0,TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 25, 2013 5:00:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('67391a3c-06c1-4093-bdb1-d7edd33d6125',TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,102,200001,11,0,TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 25, 2013 5:00:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('b58f0899-9056-41d8-8063-53f1641ce392',TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,103,200001,11,0,TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 25, 2013 5:00:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('db57c82f-a146-464c-b0f5-a665f453eb95',TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,50001,200001,0,0,TO_DATE('2013-01-25 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 25, 2013 5:01:34 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200001,'A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','18790dce-5531-4f38-885a-c1c658e4b468',10,200023,'Y','D','Search key for the record in the format required - must be unique',TO_DATE('2013-01-25 17:01:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:01:33','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Search Key','Y','Value','Y','Y',620,10,'Like','Upper','bp.Value')
;

-- Jan 25, 2013 5:01:56 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200001,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','f03d7099-a3a1-4a86-b553-28438c4fea58',10,200024,'Y','D','Alphanumeric identifier of the entity',TO_DATE('2013-01-25 17:01:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:01:55','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Name','Y','Name','Y','Y',469,20,'Like','Upper','bp.Name')
;

-- Jan 25, 2013 5:03:34 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200001,'233bd7fd-180d-4c10-935b-23e6a04cf403',10,200025,'Y','D','Business Partner Contact Name',TO_DATE('2013-01-25 17:03:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:03:33','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Contact Name','Y','ContactName','Y','Y',1839,30,'Like','Upper','c.Name AS ContactName')
;

-- Jan 25, 2013 5:05:11 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200001,'232c6bc0-5390-4e7b-b40e-c52c2b4e578c',12,200026,'N','D','Available Credit based on Credit Limit (not Total Open Balance) and Credit Used',TO_DATE('2013-01-25 17:05:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:05:09','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Credit Available','Y','SO_CreditAvailable','Y','Y',1851,40,'=','bp.SO_CreditLimit-bp.SO_CreditUsed AS SO_CreditAvailable')
;

-- Jan 25, 2013 5:06:02 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200001,'The Credit Used indicates the total amount of open or unpaid invoices in primary accounting currency for the Business Partner. Credit Management is based on the Total Open Amount, which includes Vendor activities.','2b743596-27ec-4968-a7c0-7a99834313d6',12,200027,'N','D','Current open balance',TO_DATE('2013-01-25 17:06:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:06:01','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Credit Used','Y','SO_CreditUsed','Y','Y',554,50,'bp.SO_CreditUsed')
;

-- Jan 25, 2013 5:06:51 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200001,'The Phone field identifies a telephone number','89b27cb6-0002-4905-ad0a-28b14e9eeebb',10,200028,'Y','D','Identifies a telephone number',TO_DATE('2013-01-25 17:06:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:06:50','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Phone','Y','Phone','Y','Y',505,60,'Like','c.Phone')
;

-- Jan 25, 2013 5:08:01 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200001,'The Postal Code or ZIP identifies the postal code for this entity''s address.','04d7c2cb-01fc-4756-b2e3-53d91a27014c',10,200029,'Y','D','Postal code',TO_DATE('2013-01-25 17:07:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:07:59','YYYY-MM-DD HH24:MI:SS'),0,0,100,'ZIP','Y','Postal','Y','Y',512,70,'Like','Upper','a.Postal')
;

-- Jan 25, 2013 5:08:26 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200001,'The City identifies a unique City for this Country or Region.','87b2a158-eb69-475c-9324-eefca8d0c7da',10,200030,'N','D','Identifies a City',TO_DATE('2013-01-25 17:08:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:08:26','YYYY-MM-DD HH24:MI:SS'),0,0,100,'City','Y','City','Y','Y',225,80,'Like','Upper','a.City')
;

-- Jan 25, 2013 5:08:52 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200001,'The Total Open Balance Amount is the calculated open item amount for Customer and Vendor activity.  If the Balance is below zero, we owe the Business Partner.  The amount is used for Credit Management.
Invoices and Payment Allocations determine the Open Balance (i.e. not Orders or Payments).','743b5ce2-9257-450a-8d0c-718caa30ed35',12,200031,'N','D','Total Open Balance Amount in primary Accounting Currency',TO_DATE('2013-01-25 17:08:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:08:51','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Open Balance','Y','TotalOpenBalance','Y','Y',2562,90,'bp.TotalOpenBalance')
;

-- Jan 25, 2013 5:09:47 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,SelectClause) VALUES (200001,'3032fa64-7e07-4adf-a252-07dabfe12427',12,200032,'N','D',TO_DATE('2013-01-25 17:09:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:09:46','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Revenue','Y','Revenue','Y','Y',100,'=','bp.ActualLifetimeValue')
;

-- Jan 25, 2013 5:10:10 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200001,'The Address 1 identifies the address for an entity''s location','501f1ba5-9eed-4d94-af31-589a97c810f2',10,200033,'N','D','Address line 1 for this location',TO_DATE('2013-01-25 17:10:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:10:09','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Address 1','Y','Address1','Y','Y',156,110,'a.Address1')
;

-- Jan 25, 2013 5:10:27 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsQueryCriteria='Y', QueryOperator='Like', QueryFunction='Upper',Updated=TO_DATE('2013-01-25 17:10:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200033
;

-- Jan 25, 2013 5:10:53 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsQueryCriteria='N', QueryOperator=NULL, QueryFunction=NULL,Updated=TO_DATE('2013-01-25 17:10:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200033
;

-- Jan 25, 2013 5:11:22 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200001,'If the Ship Address is selected, the location is used to ship goods to a customer or receive goods from a vendor.','e6154d16-db40-45e7-adaf-2f6aa19d78dc',20,200034,'N','D','Business Partner Shipment Address',TO_DATE('2013-01-25 17:11:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:11:21','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Ship Address','Y','IsShipTo','Y','Y',929,120,'l.IsShipTo')
;

-- Jan 25, 2013 5:11:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200001,'If the Invoice Address is selected, the location is used to send invoices to a customer or receive invoices from a vendor.','b1e8e398-453d-497d-8ae1-b5bcd3572191',20,200035,'N','D','Business Partner Invoice/Bill Address',TO_DATE('2013-01-25 17:11:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-25 17:11:32','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Invoice Address','Y','IsBillTo','Y','Y',916,130,'l.IsBillTo')
;

-- Jan 29, 2013 3:58:06 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET DisplayLogic='@IsDisplayed@=Y|@IsQueryCriteria=Y',Updated=TO_DATE('2013-01-29 15:58:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Jan 29, 2013 3:58:22 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET DisplayLogic='@IsDisplayed@=Y|@IsQueryCriteria@=Y',Updated=TO_DATE('2013-01-29 15:58:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Jan 29, 2013 3:59:19 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Preference (AD_Preference_ID,AD_Window_ID,Attribute,AD_Preference_UU,Value,CreatedBy,AD_Org_ID,AD_Client_ID,Created,UpdatedBy,Updated,IsActive) VALUES (200000,102,'106|DetailPane.IsOpen','8366496c-2e0e-4898-92cc-0093cb95cecc','N',100,0,0,TO_DATE('2013-01-29 15:59:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-29 15:59:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 29, 2013 4:04:57 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200001,'The Customer checkbox indicates if this Business Partner is a customer.  If it is select additional fields will display which further define this customer.','64676c6f-aab0-40d3-8875-23257197ef5c',20,200036,'Y','D','Indicates if this Business Partner is a Customer',TO_DATE('2013-01-29 16:04:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-29 16:04:53','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Customer','Y','@IsSOTrx:Y@=Y','IsCustomer','N','Y',364,140,'=','bp.IsCustomer')
;

-- Jan 29, 2013 4:05:34 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,DisplayLogic,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200001,'The Vendor checkbox indicates if this Business Partner is a Vendor.  If it is selected, additional fields will display which further identify this vendor.','4c718d20-3bc5-41a4-ab06-d32ff0388596',20,200037,'Y','D','Indicates if this Business Partner is a Vendor',TO_DATE('2013-01-29 16:05:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-29 16:05:32','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Vendor','Y','@IsSOTrx:N@=N','IsVendor','N','Y',426,150,'=','bp.IsVendor')
;

-- Jan 29, 2013 4:20:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_DATE('2013-01-29 16:20:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200001
;

-- Jan 29, 2013 4:21:01 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsDefault='Y',Updated=TO_DATE('2013-01-29 16:21:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200001
;

-- Jan 29, 2013 4:25:02 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200001,'The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.','b2ad7812-46e8-4a59-8fec-b472270b985a',10,200038,'Y','D','Electronic Mail Address',TO_DATE('2013-01-29 16:25:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-29 16:25:00','YYYY-MM-DD HH24:MI:SS'),0,0,100,'EMail Address','Y','EMail','N','Y',881,160,'Like','Upper','c.EMail')
;

-- Jan 29, 2013 4:26:08 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=35,Updated=TO_DATE('2013-01-29 16:26:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200038
;

-- Jan 29, 2013 4:56:19 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2013-01-29 16:56:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200036
;

-- Jan 29, 2013 4:56:34 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2013-01-29 16:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200037
;

-- Jan 29, 2013 5:05:53 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Message SET MsgTip='Match all search criteria',Updated=TO_DATE('2013-01-29 17:05:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=518
;

SELECT register_migration_script('201301291606_IDEMPIERE-325.sql') FROM dual
;


