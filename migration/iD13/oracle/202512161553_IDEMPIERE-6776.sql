-- IDEMPIERE-6776  Accounting Fact Daily Report Missing All Newly Added Accounting Dimensions
SELECT register_migration_script('202512161553_IDEMPIERE-6776.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 16, 2025, 3:53:00 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217733,'019b26af-4a1d-7f63-9001-19d5eb4f2413',TO_TIMESTAMP('2025-12-16 15:52:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:52:59','YYYY-MM-DD HH24:MI:SS'),100,200139,'customfieldtext1','fact_acct.customfieldtext1',320)
;

-- Dec 16, 2025, 3:53:21 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217734,'019b26af-9ae6-73fd-bd98-66f5d8ded5db',TO_TIMESTAMP('2025-12-16 15:53:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:53:20','YYYY-MM-DD HH24:MI:SS'),100,200139,'customfieldtext2','fact_acct.customfieldtext2',330)
;

-- Dec 16, 2025, 3:53:28 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217735,'019b26af-b5cb-73fa-8cf2-4f1f5e4a026e',TO_TIMESTAMP('2025-12-16 15:53:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:53:27','YYYY-MM-DD HH24:MI:SS'),100,200139,'customfieldtext3','fact_acct.customfieldtext3',340)
;

-- Dec 16, 2025, 3:53:36 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217736,'019b26af-d607-7138-b354-de7ebe22f3dc',TO_TIMESTAMP('2025-12-16 15:53:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:53:35','YYYY-MM-DD HH24:MI:SS'),100,200139,'customfieldtext4','fact_acct.customfieldtext4',350)
;

-- Dec 16, 2025, 3:53:43 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217737,'019b26af-f00f-74c6-8fb3-6a693fdf1d3d',TO_TIMESTAMP('2025-12-16 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,200139,'M_AttributeSetInstance_ID','fact_acct.M_AttributeSetInstance_ID',360)
;

-- Dec 16, 2025, 3:53:50 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217738,'019b26b0-0af2-73d2-ad01-c9e1be746b08',TO_TIMESTAMP('2025-12-16 15:53:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:53:49','YYYY-MM-DD HH24:MI:SS'),100,200139,'C_Charge_ID','fact_acct.C_Charge_ID',370)
;

-- Dec 16, 2025, 3:53:56 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217739,'019b26b0-258b-70ee-a89b-062135fbf5f6',TO_TIMESTAMP('2025-12-16 15:53:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:53:56','YYYY-MM-DD HH24:MI:SS'),100,200139,'C_CostCenter_ID','fact_acct.C_CostCenter_ID',380)
;

-- Dec 16, 2025, 3:54:04 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217740,'019b26b0-41ea-78e7-8728-9785bdc9e300',TO_TIMESTAMP('2025-12-16 15:54:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:54:03','YYYY-MM-DD HH24:MI:SS'),100,200139,'C_Department_ID','fact_acct.C_Department_ID',390)
;

-- Dec 16, 2025, 3:54:10 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217741,'019b26b0-5c4e-7e2c-941c-9a6b6e38f102',TO_TIMESTAMP('2025-12-16 15:54:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:54:10','YYYY-MM-DD HH24:MI:SS'),100,200139,'C_Employee_ID','fact_acct.C_Employee_ID',400)
;

-- Dec 16, 2025, 3:54:17 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217742,'019b26b0-76c8-79d5-80f1-9f83381d6626',TO_TIMESTAMP('2025-12-16 15:54:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 15:54:16','YYYY-MM-DD HH24:MI:SS'),100,200139,'M_Warehouse_ID','fact_acct.M_Warehouse_ID',410)
;

-- Dec 16, 2025, 3:58:27 PM IST
UPDATE AD_ViewComponent SET OtherClause='GROUP BY fact_acct.ad_client_id, fact_acct.ad_org_id, fact_acct.c_acctschema_id, fact_acct.account_id, (firstof(fact_acct.dateacct, ''DD'')), fact_acct.c_period_id, fact_acct.gl_category_id, fact_acct.gl_budget_id, fact_acct.c_tax_id, fact_acct.m_locator_id, fact_acct.postingtype, fact_acct.c_currency_id, fact_acct.m_product_id, fact_acct.c_bpartner_id, fact_acct.ad_orgtrx_id, fact_acct.c_locfrom_id, fact_acct.c_locto_id, fact_acct.c_salesregion_id, fact_acct.c_project_id, fact_acct.c_campaign_id, fact_acct.c_activity_id, fact_acct.user1_id, fact_acct.user2_id, fact_acct.a_asset_id, fact_acct.customfieldtext1, fact_acct.customfieldtext2, fact_acct.customfieldtext3, fact_acct.customfieldtext4, fact_acct.M_AttributeSetInstance_ID, fact_acct.C_Charge_ID, fact_acct.C_CostCenter_ID, fact_acct.C_Department_ID, fact_acct.C_Employee_ID, fact_acct.M_Warehouse_ID',Updated=TO_TIMESTAMP('2025-12-16 15:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200139
;

-- Dec 16, 2025, 3:58:30 PM IST
CREATE OR REPLACE VIEW RV_Fact_Acct_Day(AD_Client_ID, AD_Org_ID, C_AcctSchema_ID, Account_ID, DateAcct, C_Period_ID, GL_Category_ID, GL_Budget_ID, C_Tax_ID, M_Locator_ID, PostingType, C_Currency_ID, AmtSourceDr, AmtSourceCr, AmtSource, AmtAcctDr, AmtAcctCr, AmtAcct, Rate, M_Product_ID, C_BPartner_ID, AD_OrgTrx_ID, C_LocFrom_ID, C_LocTo_ID, C_SalesRegion_ID, C_Project_ID, C_Campaign_ID, C_Activity_ID, User1_ID, User2_ID, A_Asset_ID, customfieldtext1, customfieldtext2, customfieldtext3, customfieldtext4, M_AttributeSetInstance_ID, C_Charge_ID, C_CostCenter_ID, C_Department_ID, C_Employee_ID, M_Warehouse_ID) AS SELECT fact_acct.ad_client_id AS AD_Client_ID, fact_acct.ad_org_id AS AD_Org_ID, fact_acct.c_acctschema_id AS C_AcctSchema_ID, fact_acct.account_id AS Account_ID, firstof(fact_acct.dateacct, 'DD') AS DateAcct, fact_acct.c_period_id AS C_Period_ID, fact_acct.gl_category_id AS GL_Category_ID, fact_acct.gl_budget_id AS GL_Budget_ID, fact_acct.c_tax_id AS C_Tax_ID, fact_acct.m_locator_id AS M_Locator_ID, fact_acct.postingtype AS PostingType, fact_acct.c_currency_id AS C_Currency_ID, sum(fact_acct.amtsourcedr) AS AmtSourceDr, sum(fact_acct.amtsourcecr) AS AmtSourceCr, sum(fact_acct.amtsourcedr - fact_acct.amtsourcecr) AS AmtSource, sum(fact_acct.amtacctdr) AS AmtAcctDr, sum(fact_acct.amtacctcr) AS AmtAcctCr, sum(fact_acct.amtacctdr - fact_acct.amtacctcr) AS AmtAcct, CASE WHEN sum(fact_acct.amtsourcedr - fact_acct.amtsourcecr) = 0 THEN 0 ELSE sum(fact_acct.amtacctdr - fact_acct.amtacctcr) / sum(fact_acct.amtsourcedr - fact_acct.amtsourcecr) END AS Rate, fact_acct.m_product_id AS M_Product_ID, fact_acct.c_bpartner_id AS C_BPartner_ID, fact_acct.ad_orgtrx_id AS AD_OrgTrx_ID, fact_acct.c_locfrom_id AS C_LocFrom_ID, fact_acct.c_locto_id AS C_LocTo_ID, fact_acct.c_salesregion_id AS C_SalesRegion_ID, fact_acct.c_project_id AS C_Project_ID, fact_acct.c_campaign_id AS C_Campaign_ID, fact_acct.c_activity_id AS C_Activity_ID, fact_acct.user1_id AS User1_ID, fact_acct.user2_id AS User2_ID, fact_acct.a_asset_id AS A_Asset_ID, fact_acct.customfieldtext1 AS customfieldtext1, fact_acct.customfieldtext2 AS customfieldtext2, fact_acct.customfieldtext3 AS customfieldtext3, fact_acct.customfieldtext4 AS customfieldtext4, fact_acct.M_AttributeSetInstance_ID AS M_AttributeSetInstance_ID, fact_acct.C_Charge_ID AS C_Charge_ID, fact_acct.C_CostCenter_ID AS C_CostCenter_ID, fact_acct.C_Department_ID AS C_Department_ID, fact_acct.C_Employee_ID AS C_Employee_ID,
fact_acct.M_Warehouse_ID AS M_Warehouse_ID FROM fact_acct GROUP BY fact_acct.ad_client_id, fact_acct.ad_org_id, fact_acct.c_acctschema_id, fact_acct.account_id, (firstof(fact_acct.dateacct, 'DD')), fact_acct.c_period_id, fact_acct.gl_category_id, fact_acct.gl_budget_id, fact_acct.c_tax_id, fact_acct.m_locator_id, fact_acct.postingtype, fact_acct.c_currency_id, fact_acct.m_product_id, fact_acct.c_bpartner_id, fact_acct.ad_orgtrx_id, fact_acct.c_locfrom_id, fact_acct.c_locto_id, fact_acct.c_salesregion_id, fact_acct.c_project_id, fact_acct.c_campaign_id, fact_acct.c_activity_id, fact_acct.user1_id, fact_acct.user2_id, fact_acct.a_asset_id, fact_acct.customfieldtext1, fact_acct.customfieldtext2, fact_acct.customfieldtext3, fact_acct.customfieldtext4, fact_acct.M_AttributeSetInstance_ID, fact_acct.C_Charge_ID, fact_acct.C_CostCenter_ID, fact_acct.C_Department_ID, fact_acct.C_Employee_ID, fact_acct.M_Warehouse_ID
;

-- Dec 16, 2025, 3:58:46 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217328,0.0,'Text Column 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',656,'CustomFieldText1',255,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:45','YYYY-MM-DD HH24:MI:SS'),100,203894,'N','N','D','N','019b26b4-8f3e-7bd3-b588-5d692cbc37c3','N','N')
;

-- Dec 16, 2025, 3:58:46 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217329,0.0,'Text Column 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',656,'CustomFieldText2',255,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:46','YYYY-MM-DD HH24:MI:SS'),100,203895,'N','N','D','N','019b26b4-9211-79ce-b088-4f5625f8f000','N','N')
;

-- Dec 16, 2025, 3:58:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217330,0.0,'Text Column 3','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',656,'CustomFieldText3',255,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:46','YYYY-MM-DD HH24:MI:SS'),100,203896,'N','N','D','N','019b26b4-94a6-77d4-9535-2f6994313385','N','N')
;

-- Dec 16, 2025, 3:58:48 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217331,0.0,'Text Column 4','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',656,'CustomFieldText4',255,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:47','YYYY-MM-DD HH24:MI:SS'),100,203897,'N','N','D','N','019b26b4-972f-77a3-b62a-de9062678280','N','N')
;

-- Dec 16, 2025, 3:58:48 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217332,0.0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',656,'M_AttributeSetInstance_ID',10,'N','N','N','N','N','N',35,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:48','YYYY-MM-DD HH24:MI:SS'),100,2019,'N','N','D','N','019b26b4-99c9-755f-b1e2-b840c80fd5e1','N','N')
;

-- Dec 16, 2025, 3:58:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217333,0.0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',656,'C_Charge_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:48','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','019b26b4-9c54-7a8c-a00b-6289858aa64a','N','N')
;

-- Dec 16, 2025, 3:58:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217334,0.0,'Cost Center',656,'C_CostCenter_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:49','YYYY-MM-DD HH24:MI:SS'),100,203903,'N','N','D','N','019b26b4-9edd-7b9e-8b14-506007a8ca9a','N','N')
;

-- Dec 16, 2025, 3:58:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217335,0.0,'Department',656,'C_Department_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:50','YYYY-MM-DD HH24:MI:SS'),100,203901,'N','N','D','N','019b26b4-a16f-73c6-8bc7-58981edb466c','N','N')
;

-- Dec 16, 2025, 3:58:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217336,0.0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',656,'C_Employee_ID',10,'N','N','N','N','N','N',18,252,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:50','YYYY-MM-DD HH24:MI:SS'),100,203893,'N','N','D','N','019b26b4-a3f4-72fd-a8c9-fa4b7f782210','N','N')
;

-- Dec 16, 2025, 3:58:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217337,0.0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',656,'M_Warehouse_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-12-16 15:58:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 15:58:51','YYYY-MM-DD HH24:MI:SS'),100,459,'N','N','D','N','019b26b4-a67d-79da-b431-3eb8f59059a5','N','N')
;

-- Dec 17, 2025, 6:23:41 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200501,0,0,'Y',TO_TIMESTAMP('2025-12-17 18:23:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 18:23:40','YYYY-MM-DD HH24:MI:SS'),100,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',253,80,18,'N',22,'N','M_AttributeSetInstance_ID','Y','D',2019,'@$Element_AI@=Y','019b2c5f-9a34-7b67-88ac-2e14ccac5b1a','N','N','D','N')
;

-- Dec 17, 2025, 6:24:17 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200502,0,0,'Y',TO_TIMESTAMP('2025-12-17 18:24:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 18:24:16','YYYY-MM-DD HH24:MI:SS'),100,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',253,90,19,'N',0,'N','C_Charge_ID','Y','D',968,'@$Element_CH@=Y','019b2c60-24ce-7b27-9011-090231309893','N','N','D','N')
;

-- Dec 17, 2025, 6:24:54 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200503,0,0,'Y',TO_TIMESTAMP('2025-12-17 18:24:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 18:24:54','YYYY-MM-DD HH24:MI:SS'),100,'Cost Center',253,100,19,'N',22,'N','C_CostCenter_ID','Y','D',203903,'@$Element_CC@=Y','019b2c60-b8f7-71a0-ab3c-c1ed649aca37','N','N','D','N')
;

-- Dec 17, 2025, 6:25:30 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200504,0,0,'Y',TO_TIMESTAMP('2025-12-17 18:25:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 18:25:29','YYYY-MM-DD HH24:MI:SS'),100,'Department',253,110,19,'N',22,'N','C_Department_ID','Y','D',203901,'@$Element_DP@=Y','019b2c61-4276-719f-aac0-0183dbfb0340','N','N','D','N')
;

-- Dec 17, 2025, 6:25:47 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200505,0,0,'Y',TO_TIMESTAMP('2025-12-17 18:25:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 18:25:46','YYYY-MM-DD HH24:MI:SS'),100,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',253,120,18,252,'N',10,'N','C_Employee_ID','Y','D',203893,'@$Element_EP@=Y','019b2c61-84de-7c24-9688-7441335cf611','N','N','D','N')
;

-- Dec 17, 2025, 6:26:09 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200506,0,0,'Y',TO_TIMESTAMP('2025-12-17 18:26:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 18:26:09','YYYY-MM-DD HH24:MI:SS'),100,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',253,130,19,'N',0,'N','M_Warehouse_ID','Y','D',459,'@$Element_WH@=Y','019b2c61-ddbd-707d-812b-cd9117389299','N','N','D','N')
;
