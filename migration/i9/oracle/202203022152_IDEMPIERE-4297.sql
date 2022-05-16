-- IDEMPIERE-4297 Improve test data
SELECT register_migration_script('202203022152_IDEMPIERE-4297.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 2, 2022, 9:52:22 PM AEDT
INSERT INTO C_Location (C_Location_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Address1,Address2,City,C_Country_ID,Postal,Postal_Add,Address3,Address4,C_Location_UU,Address5,Comments) VALUES (200000,11,0,'Y',TO_TIMESTAMP('2022-03-02 21:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 21:51:21','YYYY-MM-DD HH24:MI:SS'),100,'Schillerstrabe 18d',NULL,'Munich',101,'47445',NULL,NULL,NULL,'7111f669-7439-4516-864d-afca8e133439',NULL,NULL)
;

-- Mar 2, 2022, 9:52:51 PM AEDT
UPDATE AD_OrgInfo SET C_Location_ID=200000,Updated=TO_TIMESTAMP('2022-03-02 21:52:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Org_ID=50001
;

-- Mar 2, 2022, 9:54:34 PM AEDT
UPDATE C_Location SET Address1='80 Rue Principale', Address2=NULL, City='Paris', C_Country_ID=102, C_Region_ID=NULL, Postal='75014', Postal_Add=NULL, C_City_ID=NULL, RegionName=NULL, Address3=NULL, Address4=NULL, Address5=NULL, Comments=NULL,Updated=TO_TIMESTAMP('2022-03-02 21:54:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Location_ID=50003
;

-- Mar 2, 2022, 9:55:43 PM AEDT
INSERT INTO C_Location (C_Location_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Address1,Address2,City,C_Country_ID,Postal,Postal_Add,Address3,Address4,C_Location_UU,Address5,Comments) VALUES (200001,11,0,'Y',TO_TIMESTAMP('2022-03-02 21:55:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 21:55:00','YYYY-MM-DD HH24:MI:SS'),100,'80 Rue Principale',NULL,'Paris',102,'75014',NULL,NULL,NULL,'e96a211f-12f9-4d68-94a0-aada9ea3e228',NULL,NULL)
;

-- Mar 2, 2022, 9:55:51 PM AEDT
UPDATE AD_OrgInfo SET C_Location_ID=200001,Updated=TO_TIMESTAMP('2022-03-02 21:55:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Org_ID=50000
;

-- Mar 2, 2022, 9:57:18 PM AEDT
UPDATE M_Product_PO SET PriceList=1.50, C_Currency_ID=102, PricePO=1.50,Updated=TO_TIMESTAMP('2022-03-02 21:57:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Product_ID=50016 AND C_BPartner_ID=50000
;

-- Mar 2, 2022, 9:57:56 PM AEDT
UPDATE M_Product_PO SET PriceList=3.00, C_Currency_ID=102, PricePO=3.00,Updated=TO_TIMESTAMP('2022-03-02 21:57:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Product_ID=50005 AND C_BPartner_ID=50000
;

-- Mar 2, 2022, 9:58:33 PM AEDT
UPDATE M_Product_PO SET PriceList=1.07, C_Currency_ID=102, PricePO=1.07,Updated=TO_TIMESTAMP('2022-03-02 21:58:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Product_ID=50015 AND C_BPartner_ID=50000
;

-- Mar 2, 2022, 9:59:11 PM AEDT
UPDATE M_Product_PO SET PriceList=1.70, C_Currency_ID=102, PricePO=1.70,Updated=TO_TIMESTAMP('2022-03-02 21:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE M_Product_ID=50004 AND C_BPartner_ID=50000
;

-- Mar 2, 2022, 10:00:18 PM AEDT
INSERT INTO M_PriceList (M_PriceList_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,C_Currency_ID,IsSOPriceList,EnforcePriceLimit,IsTaxIncluded,IsDefault,PricePrecision,M_PriceList_UU) VALUES (200000,11,11,'Y',TO_TIMESTAMP('2022-03-02 22:00:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:00:18','YYYY-MM-DD HH24:MI:SS'),100,'Import','Import Prices in EUR',102,'N','N','N','N',2,'9a4fe288-7e89-4f04-8f34-ea6a88364762')
;

-- Mar 2, 2022, 10:04:06 PM AEDT
INSERT INTO M_PriceList_Version (M_PriceList_Version_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,M_PriceList_ID,ValidFrom,ProcCreate,M_DiscountSchema_ID,M_PriceList_Version_UU) VALUES (200000,11,11,'Y',TO_TIMESTAMP('2022-03-02 22:04:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:04:05','YYYY-MM-DD HH24:MI:SS'),100,'Import 2003',200000,TO_TIMESTAMP('2003-01-01','YYYY-MM-DD'),'N',101,'fa5047ca-7d95-4beb-b003-a45a2894613d')
;

-- Mar 2, 2022, 10:05:19 PM AEDT
UPDATE C_BPartner SET PO_PriceList_ID=200000,Updated=TO_TIMESTAMP('2022-03-02 22:05:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_BPartner_ID=50003
;

-- Mar 2, 2022, 10:06:22 PM AEDT
INSERT INTO C_Location (C_Location_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Address1,Address2,City,C_Country_ID,Postal,Postal_Add,Address3,Address4,C_Location_UU,Address5,Comments) VALUES (200002,11,0,'Y',TO_TIMESTAMP('2022-03-02 22:05:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:05:36','YYYY-MM-DD HH24:MI:SS'),100,'Hauptstraße 110',NULL,'Berlin',101,'10117',NULL,NULL,NULL,'2540211f-3e3f-4965-b1c9-306992e5af6a',NULL,NULL)
;

-- Mar 2, 2022, 10:06:36 PM AEDT
INSERT INTO C_BPartner_Location (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_BPartner_ID,C_Location_ID,Name,IsBillTo,IsShipTo,IsPayFrom,IsRemitTo,C_BPartner_Location_ID,C_BPartner_Location_UU,IsPreserveCustomName) VALUES (11,0,'Y',TO_TIMESTAMP('2022-03-02 22:06:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:06:35','YYYY-MM-DD HH24:MI:SS'),100,50003,200002,'Berlin','Y','Y','Y','Y',200000,'a2320984-6fef-4b04-bcdd-00e909d2bca4','N')
;

-- Mar 2, 2022, 10:07:09 PM AEDT
UPDATE C_BPartner SET PO_PriceList_ID=200000,Updated=TO_TIMESTAMP('2022-03-02 22:07:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_BPartner_ID=50000
;

-- Mar 2, 2022, 10:10:55 PM AEDT
INSERT INTO C_Location (C_Location_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Address1,Address2,City,C_Country_ID,Postal,Postal_Add,Address3,Address4,C_Location_UU,Address5,Comments) VALUES (200003,11,0,'Y',TO_TIMESTAMP('2022-03-02 22:07:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:07:20','YYYY-MM-DD HH24:MI:SS'),100,'51 Rue des Fleurs',NULL,'Libourne',102,'33500',NULL,NULL,NULL,'f5dfaf82-7c6a-4636-97ec-5a5ca9bd1796',NULL,NULL)
;

-- Mar 2, 2022, 10:11:01 PM AEDT
INSERT INTO C_BPartner_Location (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_BPartner_ID,C_Location_ID,Name,IsBillTo,IsShipTo,IsPayFrom,IsRemitTo,C_BPartner_Location_ID,C_BPartner_Location_UU,IsPreserveCustomName) VALUES (11,0,'Y',TO_TIMESTAMP('2022-03-02 22:11:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:11:01','YYYY-MM-DD HH24:MI:SS'),100,50000,200003,'Libourne','Y','Y','Y','Y',200001,'0e171ff4-45c8-4a48-968e-76f2e381b93c','N')
;

-- Mar 2, 2022, 10:17:18 PM AEDT
INSERT INTO C_BPartner (C_BPartner_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Value,Name,SalesVolume,NumberEmployees,IsSummary,AD_Language,IsVendor,IsCustomer,IsProspect,SO_CreditLimit,SO_CreditUsed,AcqusitionCost,PotentialLifeTimeValue,C_PaymentTerm_ID,ActualLifeTimeValue,ShareOfCustomer,IsEmployee,IsSalesRep,M_PriceList_ID,IsOneTime,IsTaxExempt,C_Dunning_ID,DocumentCopies,IsDiscountPrinted,C_BP_Group_ID,SendEMail,SOCreditStatus,ShelfLifeMinPct,FlatDiscount,TotalOpenBalance,IsPOTaxExempt,IsManufacturer,C_BPartner_UU,Is1099Vendor) VALUES (200000,11,0,'Y',TO_TIMESTAMP('2022-03-02 22:17:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:17:17','YYYY-MM-DD HH24:MI:SS'),100,'Agri-Tech','Agri-Tech',0,0,'N','en_US','N','Y','N',0,0,0,0,105,0,0,'N','N',103,'N','N',100,0,'N',103,'N','X',0,0,0,'N','N','605450c7-24a7-4da9-990d-a8e5e7dd57eb','N')
;

-- Mar 2, 2022, 10:17:18 PM AEDT
INSERT INTO AD_TreeNodeBP (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeBP_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200000, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=11 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='BP' AND NOT EXISTS (SELECT * FROM AD_TreeNodeBP e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200000)
;

-- Mar 2, 2022, 10:17:18 PM AEDT
INSERT INTO C_BP_Customer_Acct (C_BPartner_ID, C_AcctSchema_ID, AD_Client_ID,AD_Org_ID,IsActive, Created,CreatedBy,Updated,UpdatedBy ,C_Prepayment_Acct,C_Receivable_Acct,C_Receivable_Services_Acct,C_BP_Customer_Acct_UU) SELECT 200000, p.C_AcctSchema_ID, p.AD_Client_ID,0,'Y', getDate(),100,getDate(),100,p.C_Prepayment_Acct,p.C_Receivable_Acct,p.C_Receivable_Services_Acct,generate_uuid() FROM C_BP_Group_Acct p WHERE p.AD_Client_ID=11 AND p.C_BP_Group_ID=103 AND NOT EXISTS (SELECT * FROM C_BP_Customer_Acct e WHERE e.C_AcctSchema_ID=p.C_AcctSchema_ID AND e.C_BPartner_ID=200000)
;

-- Mar 2, 2022, 10:17:18 PM AEDT
INSERT INTO C_BP_Vendor_Acct (C_BPartner_ID, C_AcctSchema_ID, AD_Client_ID,AD_Org_ID,IsActive, Created,CreatedBy,Updated,UpdatedBy ,V_Liability_Acct,V_Liability_Services_Acct,V_Prepayment_Acct,C_BP_Vendor_Acct_UU) SELECT 200000, p.C_AcctSchema_ID, p.AD_Client_ID,0,'Y', getDate(),100,getDate(),100,p.V_Liability_Acct,p.V_Liability_Services_Acct,p.V_Prepayment_Acct,generate_uuid() FROM C_BP_Group_Acct p WHERE p.AD_Client_ID=11 AND p.C_BP_Group_ID=103 AND NOT EXISTS (SELECT * FROM C_BP_Vendor_Acct e WHERE e.C_AcctSchema_ID=p.C_AcctSchema_ID AND e.C_BPartner_ID=200000)
;

-- Mar 2, 2022, 10:17:18 PM AEDT
INSERT INTO AD_WF_Process (Created,Processing,Updated,Processed,IsActive,AD_Workflow_ID,AD_Client_ID,CreatedBy,AD_Org_ID,WFState,AD_User_ID,UpdatedBy,AD_WF_Responsible_ID,AD_WF_Process_ID,AD_Table_ID,Priority,Record_ID,AD_WF_Process_UU) VALUES (TO_TIMESTAMP('2022-03-02 22:17:18','YYYY-MM-DD HH24:MI:SS'),'N',TO_TIMESTAMP('2022-03-02 22:17:18','YYYY-MM-DD HH24:MI:SS'),'N','Y',131,11,100,0,'ON',100,100,101,200006,291,0,200000,'4562fc0b-396c-403e-bf1f-cb9b624768a6')
;

-- Mar 2, 2022, 10:17:18 PM AEDT
UPDATE AD_WF_Process SET WFState='OR',Updated=TO_TIMESTAMP('2022-03-02 22:17:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200006
;

-- Mar 2, 2022, 10:17:19 PM AEDT
INSERT INTO AD_WF_Activity (AD_WF_Node_ID,AD_WF_Responsible_ID,AD_Org_ID,CreatedBy,AD_User_ID,AD_WF_Activity_ID,AD_WF_Process_ID,IsActive,Processed,Processing,WFState,Created,UpdatedBy,AD_Client_ID,Updated,AD_Workflow_ID,Priority,Record_ID,AD_Table_ID,AD_WF_Activity_UU) VALUES (244,100,0,100,100,200018,200006,'Y','N','N','ON',TO_TIMESTAMP('2022-03-02 22:17:18','YYYY-MM-DD HH24:MI:SS'),100,11,TO_TIMESTAMP('2022-03-02 22:17:18','YYYY-MM-DD HH24:MI:SS'),131,0,200000,291,'a3af24a8-4ccb-4d1a-964c-70acbbbb9512')
;

-- Mar 2, 2022, 10:17:19 PM AEDT
INSERT INTO AD_WF_EventAudit (AD_User_ID,AD_WF_Responsible_ID,AD_Client_ID,IsActive,UpdatedBy,AD_Org_ID,Updated,CreatedBy,WFState,Created,AD_WF_EventAudit_ID,EventType,AD_WF_Process_ID,AD_Table_ID,AD_WF_Node_ID,Record_ID,ElapsedTimeMS,AD_WF_EventAudit_UU) VALUES (100,100,11,'Y',100,0,TO_TIMESTAMP('2022-03-02 22:17:19','YYYY-MM-DD HH24:MI:SS'),100,'ON',TO_TIMESTAMP('2022-03-02 22:17:19','YYYY-MM-DD HH24:MI:SS'),200018,'PC',200006,291,244,200000,0.0,'c8942cc6-a11b-443b-ba27-360604fd3d17')
;

-- Mar 2, 2022, 10:17:19 PM AEDT
UPDATE AD_WF_Activity SET WFState='OR',Updated=TO_TIMESTAMP('2022-03-02 22:17:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200018
;

-- Mar 2, 2022, 10:17:19 PM AEDT
UPDATE AD_WF_EventAudit SET WFState='OR', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-03-02 22:17:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200018
;

-- Mar 2, 2022, 10:17:19 PM AEDT
UPDATE AD_WF_Activity SET WFState='OS',Updated=TO_TIMESTAMP('2022-03-02 22:17:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Activity_ID=200018
;

-- Mar 2, 2022, 10:17:19 PM AEDT
UPDATE AD_WF_EventAudit SET WFState='OS', EventType='SC', TextMsg=NULL,Updated=TO_TIMESTAMP('2022-03-02 22:17:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_EventAudit_ID=200018
;

-- Mar 2, 2022, 10:17:19 PM AEDT
UPDATE AD_WF_Process SET WFState='OS',Updated=TO_TIMESTAMP('2022-03-02 22:17:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Process_ID=200006
;

-- Mar 2, 2022, 10:18:27 PM AEDT
INSERT INTO C_Location (C_Location_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Address1,Address2,City,C_Country_ID,Postal,Postal_Add,Address3,Address4,C_Location_UU,Address5,Comments) VALUES (200004,11,0,'Y',TO_TIMESTAMP('2022-03-02 22:17:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:17:36','YYYY-MM-DD HH24:MI:SS'),100,'Hauptstraße 12',NULL,'Munich',101,'80331',NULL,NULL,NULL,'9dbe2cfa-d068-4422-a2d1-9d8f1c88597b',NULL,NULL)
;

-- Mar 2, 2022, 10:18:31 PM AEDT
INSERT INTO C_BPartner_Location (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_BPartner_ID,C_Location_ID,Name,IsBillTo,IsShipTo,IsPayFrom,IsRemitTo,C_BPartner_Location_ID,C_BPartner_Location_UU,IsPreserveCustomName) VALUES (11,0,'Y',TO_TIMESTAMP('2022-03-02 22:18:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:18:31','YYYY-MM-DD HH24:MI:SS'),100,200000,200004,'Munich','Y','Y','Y','Y',200002,'975da4a3-d53e-40d4-8316-59c3726ae0b4','N')
;

-- Mar 2, 2022, 10:54:02 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:01','YYYY-MM-DD HH24:MI:SS'),100,123,200000,51,30.6,20.4,'ef56045a-0999-4875-ad2a-29391ea6c317',200087)
;

-- Mar 2, 2022, 10:54:03 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:02','YYYY-MM-DD HH24:MI:SS'),100,124,200000,51,30.6,20.4,'fd802676-75e8-47b3-b39d-9924ddf7180e',200088)
;

-- Mar 2, 2022, 10:54:03 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:03','YYYY-MM-DD HH24:MI:SS'),100,125,200000,68,40.8,34,'4d25f816-8019-4c83-b4a1-6faf3e41cf47',200089)
;

-- Mar 2, 2022, 10:54:04 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:03','YYYY-MM-DD HH24:MI:SS'),100,126,200000,38.25,38.25,38.25,'4272ab28-ceb1-4f02-95f1-9e2533697e90',200090)
;

-- Mar 2, 2022, 10:54:04 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:04','YYYY-MM-DD HH24:MI:SS'),100,127,200000,25.5,15.3,10.2,'19313461-f489-4904-89bc-661170ab33a5',200091)
;

-- Mar 2, 2022, 10:54:05 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:04','YYYY-MM-DD HH24:MI:SS'),100,128,200000,21.25,12.75,8.5,'aa15d555-0905-4db0-83e6-bd05d2567e0a',200092)
;

-- Mar 2, 2022, 10:54:05 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:05','YYYY-MM-DD HH24:MI:SS'),100,129,200000,34,20.4,13.6,'d4e420b9-27be-4f67-8058-704eacf383ba',200093)
;

-- Mar 2, 2022, 10:54:06 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:06','YYYY-MM-DD HH24:MI:SS'),100,130,200000,42.5,25.5,17,'cf1f15a6-cc4c-4bd1-9502-b8a769f11b56',200094)
;

-- Mar 2, 2022, 10:54:07 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:06','YYYY-MM-DD HH24:MI:SS'),100,133,200000,25.5,22.95,21.68,'9c9005a1-8aa6-46e3-8acb-3457bc75e9b6',200095)
;

-- Mar 2, 2022, 10:54:07 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:07','YYYY-MM-DD HH24:MI:SS'),100,134,200000,51,45.9,43.35,'73eddf3d-c0ca-43ca-bb43-ccf431d7ebe6',200096)
;

-- Mar 2, 2022, 10:54:08 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:07','YYYY-MM-DD HH24:MI:SS'),100,135,200000,17,15.3,14.45,'85f56a09-59a9-4a32-a6be-caac9248033d',200097)
;

-- Mar 2, 2022, 10:54:08 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:08','YYYY-MM-DD HH24:MI:SS'),100,136,200000,17,15.3,14.45,'f6d1e3d9-e71f-4813-aec5-a26691c37c54',200098)
;

-- Mar 2, 2022, 10:54:09 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:08','YYYY-MM-DD HH24:MI:SS'),100,137,200000,2.55,2.29,2.17,'3c10f6ae-46fa-4618-a4ca-d057a3f9e993',200099)
;

-- Mar 2, 2022, 10:54:10 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:09','YYYY-MM-DD HH24:MI:SS'),100,138,200000,12.75,10.84,9.56,'12145b76-ae15-44ea-937c-60ad3707e69a',200100)
;

-- Mar 2, 2022, 10:54:10 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:10','YYYY-MM-DD HH24:MI:SS'),100,139,200000,7.65,6.5,5.74,'6fcee505-27a6-41ee-a01c-424b815d6540',200101)
;

-- Mar 2, 2022, 10:54:11 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:10','YYYY-MM-DD HH24:MI:SS'),100,140,200000,10.2,8.67,7.65,'961be58a-8e6b-4014-a1e5-446035a6c79a',200102)
;

-- Mar 2, 2022, 10:54:11 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:11','YYYY-MM-DD HH24:MI:SS'),100,141,200000,2.55,2.17,1.91,'011af6d9-416e-40bf-9df0-535e263ee8fe',200103)
;

-- Mar 2, 2022, 10:54:12 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:11','YYYY-MM-DD HH24:MI:SS'),100,142,200000,2.98,2.53,2.23,'7c7478ee-6bf2-4ad7-984b-b3bc4fb16632',200104)
;

-- Mar 2, 2022, 10:54:12 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:12','YYYY-MM-DD HH24:MI:SS'),100,143,200000,25.5,21.68,19.13,'6b16f505-b217-4c21-ad02-abde7182007b',200105)
;

-- Mar 2, 2022, 10:54:13 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:12','YYYY-MM-DD HH24:MI:SS'),100,144,200000,29.75,25.29,22.31,'e9ab669f-edd7-487f-a677-6c08de780b99',200106)
;

-- Mar 2, 2022, 10:54:14 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:13','YYYY-MM-DD HH24:MI:SS'),100,50003,200000,0,0,0,'4280fc88-654d-45a1-8e14-2ff8727cd91f',200107)
;

-- Mar 2, 2022, 10:54:14 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:14','YYYY-MM-DD HH24:MI:SS'),100,50004,200000,1.7,1.02,0.85,'74094d3f-e0fd-478e-8dfb-c3a49bfbbbe1',200108)
;

-- Mar 2, 2022, 10:54:15 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:14','YYYY-MM-DD HH24:MI:SS'),100,50005,200000,3,1.8,1.5,'4c185e96-8d0c-4ee9-87d1-a9f47166ce48',200109)
;

-- Mar 2, 2022, 10:54:15 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:15','YYYY-MM-DD HH24:MI:SS'),100,50009,200000,1,0.6,0.5,'1ecc4a65-372b-46a7-a32a-1274b8cc73ea',200110)
;

-- Mar 2, 2022, 10:54:16 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:15','YYYY-MM-DD HH24:MI:SS'),100,50010,200000,0.5,0.3,0.25,'ccd757d7-b424-4c8e-8b04-a10a0def3b15',200111)
;

-- Mar 2, 2022, 10:54:16 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:16','YYYY-MM-DD HH24:MI:SS'),100,50012,200000,2,1.2,1,'da36e4f8-6695-458f-8ec6-4096e2d8ad80',200112)
;

-- Mar 2, 2022, 10:54:17 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:16','YYYY-MM-DD HH24:MI:SS'),100,50015,200000,1.07,0.64,0.54,'da9c89f7-30f6-44d0-8679-45696d1bab29',200113)
;

-- Mar 2, 2022, 10:54:18 PM AEDT
INSERT INTO M_ProductPrice (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,M_Product_ID,M_PriceList_Version_ID,PriceList,PriceStd,PriceLimit,M_ProductPrice_UU,M_ProductPrice_ID) VALUES (11,11,'Y',TO_TIMESTAMP('2022-03-02 22:54:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 22:54:17','YYYY-MM-DD HH24:MI:SS'),100,50016,200000,1.5,0.9,0.75,'8b9601d1-f893-4844-b945-903d08fda324',200114)
;

