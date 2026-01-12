-- IDEMPIERE-6777  Accounting Fact Period report does not display new NF13 Accounting Dimensions.
SELECT register_migration_script('202512161712_IDEMPIERE-6777.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 16, 2025, 5:12:42 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217743,'019b26f8-4031-7555-967d-54c9bfe94cfa',TO_TIMESTAMP('2025-12-16 17:12:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:12:41','YYYY-MM-DD HH24:MI:SS'),100,200140,'customfieldtext1','fact_acct.customfieldtext1',310)
;

-- Dec 16, 2025, 5:12:49 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217744,'019b26f8-5b68-79ee-916f-0902cb8cca47',TO_TIMESTAMP('2025-12-16 17:12:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:12:48','YYYY-MM-DD HH24:MI:SS'),100,200140,'customfieldtext2','fact_acct.customfieldtext2',320)
;

-- Dec 16, 2025, 5:12:56 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217745,'019b26f8-78ee-7495-93af-29293b653a57',TO_TIMESTAMP('2025-12-16 17:12:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:12:56','YYYY-MM-DD HH24:MI:SS'),100,200140,'customfieldtext3','fact_acct.customfieldtext3',330)
;

-- Dec 16, 2025, 5:13:04 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217746,'019b26f8-98ca-74b2-a2d2-df712662fedc',TO_TIMESTAMP('2025-12-16 17:13:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:13:04','YYYY-MM-DD HH24:MI:SS'),100,200140,'customfieldtext4','fact_acct.customfieldtext4',340)
;

-- Dec 16, 2025, 5:13:48 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217747,'019b26f9-4270-7aac-bf5c-3df4dcdbd3e0',TO_TIMESTAMP('2025-12-16 17:13:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:13:47','YYYY-MM-DD HH24:MI:SS'),100,200140,'M_AttributeSetInstance_ID','fact_acct.M_AttributeSetInstance_ID',350)
;

-- Dec 16, 2025, 5:13:53 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217748,'019b26f9-5539-7cb5-bc03-86a9d76dead3',TO_TIMESTAMP('2025-12-16 17:13:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:13:52','YYYY-MM-DD HH24:MI:SS'),100,200140,'C_Charge_ID','fact_acct.C_Charge_ID',360)
;

-- Dec 16, 2025, 5:14:00 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217749,'019b26f9-7374-74ad-b36a-b788ed981bba',TO_TIMESTAMP('2025-12-16 17:14:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:14:00','YYYY-MM-DD HH24:MI:SS'),100,200140,'C_CostCenter_ID','fact_acct.C_CostCenter_ID',370)
;

-- Dec 16, 2025, 5:14:08 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217750,'019b26f9-8f70-77a8-8045-1aacfacbd44d',TO_TIMESTAMP('2025-12-16 17:14:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:14:07','YYYY-MM-DD HH24:MI:SS'),100,200140,'C_Department_ID','fact_acct.C_Department_ID',380)
;

-- Dec 16, 2025, 5:14:15 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217751,'019b26f9-ace3-75c9-b522-b77b4cde4a19',TO_TIMESTAMP('2025-12-16 17:14:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:14:14','YYYY-MM-DD HH24:MI:SS'),100,200140,'C_Employee_ID','fact_acct.C_Employee_ID',390)
;

-- Dec 16, 2025, 5:14:22 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217752,'019b26f9-c85e-7d35-86f7-64daf8afa5e8',TO_TIMESTAMP('2025-12-16 17:14:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-12-16 17:14:21','YYYY-MM-DD HH24:MI:SS'),100,200140,'M_Warehouse_ID','fact_acct.M_Warehouse_ID',400)
;

-- Dec 16, 2025, 5:16:05 PM IST
UPDATE AD_ViewComponent
SET OtherClause =
'GROUP BY fact_acct.ad_client_id, fact_acct.ad_org_id, ' ||
'fact_acct.c_acctschema_id, fact_acct.account_id, ' ||
'fact_acct.c_period_id, fact_acct.gl_category_id, ' ||
'fact_acct.gl_budget_id, fact_acct.c_tax_id, ' ||
'fact_acct.m_locator_id, fact_acct.postingtype, ' ||
'fact_acct.c_currency_id, fact_acct.m_product_id, ' ||
'fact_acct.c_bpartner_id, fact_acct.ad_orgtrx_id, ' ||
'fact_acct.c_locfrom_id, fact_acct.c_locto_id, ' ||
'fact_acct.c_salesregion_id, fact_acct.c_project_id, ' ||
'fact_acct.c_campaign_id, fact_acct.c_activity_id, ' ||
'fact_acct.user1_id, fact_acct.user2_id, ' ||
'fact_acct.a_asset_id, fact_acct.customfieldtext1, ' ||
'fact_acct.customfieldtext2, fact_acct.customfieldtext3, ' ||
'fact_acct.customfieldtext4, ' ||
'fact_acct.M_AttributeSetInstance_ID, fact_acct.C_Charge_ID, ' ||
'fact_acct.C_CostCenter_ID, fact_acct.C_Department_ID, ' ||
'fact_acct.C_Employee_ID, fact_acct.M_Warehouse_ID',
Updated   = TO_TIMESTAMP('2025-12-16 17:16:05','YYYY-MM-DD HH24:MI:SS'),
UpdatedBy = 100
WHERE AD_ViewComponent_ID = 200140;


-- Dec 16, 2025, 5:16:15 PM IST
CREATE OR REPLACE VIEW RV_Fact_Acct_Period (
AD_Client_ID, AD_Org_ID, C_AcctSchema_ID, Account_ID, C_Period_ID,
GL_Category_ID, GL_Budget_ID, C_Tax_ID, M_Locator_ID, PostingType,
C_Currency_ID, AmtSourceDr, AmtSourceCr, AmtSource, AmtAcctDr,
AmtAcctCr, AmtAcct, Rate, M_Product_ID, C_BPartner_ID, AD_OrgTrx_ID,
C_LocFrom_ID, C_LocTo_ID, C_SalesRegion_ID, C_Project_ID,
C_Campaign_ID, C_Activity_ID, User1_ID, User2_ID, A_Asset_ID,
customfieldtext1, customfieldtext2, customfieldtext3, customfieldtext4,
M_AttributeSetInstance_ID, C_Charge_ID, C_CostCenter_ID,
C_Department_ID, C_Employee_ID, M_Warehouse_ID
)
AS
SELECT
fa.ad_client_id, fa.ad_org_id, fa.c_acctschema_id, fa.account_id,
fa.c_period_id, fa.gl_category_id, fa.gl_budget_id, fa.c_tax_id,
fa.m_locator_id, fa.postingtype, fa.c_currency_id,
SUM(fa.amtsourcedr) AmtSourceDr, SUM(fa.amtsourcecr) AmtSourceCr,
SUM(fa.amtsourcedr - fa.amtsourcecr) AmtSource,
SUM(fa.amtacctdr) AmtAcctDr, SUM(fa.amtacctcr) AmtAcctCr,
SUM(fa.amtacctdr - fa.amtacctcr) AmtAcct,
CASE
  WHEN SUM(fa.amtsourcedr - fa.amtsourcecr) = 0 THEN 0
  ELSE SUM(fa.amtacctdr - fa.amtacctcr)
       / SUM(fa.amtsourcedr - fa.amtsourcecr)
END Rate,
fa.m_product_id, fa.c_bpartner_id, fa.ad_orgtrx_id,
fa.c_locfrom_id, fa.c_locto_id, fa.c_salesregion_id,
fa.c_project_id, fa.c_campaign_id, fa.c_activity_id,
fa.user1_id, fa.user2_id, fa.a_asset_id,
fa.customfieldtext1, fa.customfieldtext2,
fa.customfieldtext3, fa.customfieldtext4,
fa.m_attributesetinstance_id, fa.c_charge_id,
fa.c_costcenter_id, fa.c_department_id,
fa.c_employee_id, fa.m_warehouse_id
FROM fact_acct fa
GROUP BY
fa.ad_client_id, fa.ad_org_id, fa.c_acctschema_id, fa.account_id,
fa.c_period_id, fa.gl_category_id, fa.gl_budget_id, fa.c_tax_id,
fa.m_locator_id, fa.postingtype, fa.c_currency_id,
fa.m_product_id, fa.c_bpartner_id, fa.ad_orgtrx_id,
fa.c_locfrom_id, fa.c_locto_id, fa.c_salesregion_id,
fa.c_project_id, fa.c_campaign_id, fa.c_activity_id,
fa.user1_id, fa.user2_id, fa.a_asset_id,
fa.customfieldtext1, fa.customfieldtext2,
fa.customfieldtext3, fa.customfieldtext4,
fa.m_attributesetinstance_id, fa.c_charge_id,
fa.c_costcenter_id, fa.c_department_id,
fa.c_employee_id, fa.m_warehouse_id;

-- Dec 16, 2025, 5:16:25 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217338,0.0,'Text Column 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',655,'CustomFieldText1',255,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:24','YYYY-MM-DD HH24:MI:SS'),100,203894,'N','N','D','N','019b26fb-a9b5-7af1-93e5-a4cb3b1cf941','N','N')
;

-- Dec 16, 2025, 5:16:26 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217339,0.0,'Text Column 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',655,'CustomFieldText2',255,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:25','YYYY-MM-DD HH24:MI:SS'),100,203895,'N','N','D','N','019b26fb-ac7d-75d0-bff0-dfde51914912','N','N')
;

-- Dec 16, 2025, 5:16:27 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217340,0.0,'Text Column 3','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',655,'CustomFieldText3',255,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:26','YYYY-MM-DD HH24:MI:SS'),100,203896,'N','N','D','N','019b26fb-af18-72ac-ae7a-9808172dcf79','N','N')
;

-- Dec 16, 2025, 5:16:27 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217341,0.0,'Text Column 4','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Description).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',655,'CustomFieldText4',255,'N','N','N','N','N','N',14,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:27','YYYY-MM-DD HH24:MI:SS'),100,203897,'N','N','D','N','019b26fb-b1d4-764e-896c-0951dd5ffe4c','N','N')
;

-- Dec 16, 2025, 5:16:28 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217342,0.0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',655,'M_AttributeSetInstance_ID',10,'N','N','N','N','N','N',35,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:27','YYYY-MM-DD HH24:MI:SS'),100,2019,'N','N','D','N','019b26fb-b4b1-78d6-989e-1257ed81d941','N','N')
;

-- Dec 16, 2025, 5:16:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217343,0.0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',655,'C_Charge_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:28','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','019b26fb-b73d-79be-93ee-85ce893cb30d','N','N')
;

-- Dec 16, 2025, 5:16:29 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217344,0.0,'Cost Center',655,'C_CostCenter_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:29','YYYY-MM-DD HH24:MI:SS'),100,203903,'N','N','D','N','019b26fb-b9c6-71f9-9efb-5e1b58254fb1','N','N')
;

-- Dec 16, 2025, 5:16:30 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217345,0.0,'Department',655,'C_Department_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:29','YYYY-MM-DD HH24:MI:SS'),100,203901,'N','N','D','N','019b26fb-bc74-7541-b2e8-d131c439fb2d','N','N')
;

-- Dec 16, 2025, 5:16:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217346,0.0,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',655,'C_Employee_ID',10,'N','N','N','N','N','N',18,252,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:30','YYYY-MM-DD HH24:MI:SS'),100,203893,'N','N','D','N','019b26fb-bf07-78a8-8038-a89d52e2e2c4','N','N')
;

-- Dec 16, 2025, 5:16:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217347,0.0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',655,'M_Warehouse_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-12-16 17:16:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-16 17:16:31','YYYY-MM-DD HH24:MI:SS'),100,459,'N','N','D','N','019b26fb-c193-7f17-a0c1-c0e1df8ee04e','N','N')
;

-- Dec 17, 2025, 7:54:03 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200513,0,0,'Y',TO_TIMESTAMP('2025-12-17 19:54:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 19:54:02','YYYY-MM-DD HH24:MI:SS'),100,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',254,70,19,'N',22,'N','M_AttributeSetInstance_ID','Y','D',2019,'@$Element_AI@=Y','019b2cb2-54a8-7e93-8ce3-11e9f981d37b','N','N','D','N')
;

-- Dec 17, 2025, 7:54:31 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200514,0,0,'Y',TO_TIMESTAMP('2025-12-17 19:54:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 19:54:30','YYYY-MM-DD HH24:MI:SS'),100,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',254,80,19,'N',0,'N','C_Charge_ID','Y','D',968,'@$Element_CH@=Y','019b2cb2-c219-7fa1-b265-be1da981220b','N','N','D','N')
;

-- Dec 17, 2025, 7:54:43 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200515,0,0,'Y',TO_TIMESTAMP('2025-12-17 19:54:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 19:54:42','YYYY-MM-DD HH24:MI:SS'),100,'Cost Center',254,90,19,'N',22,'N','C_CostCenter_ID','Y','D',203903,'@$Element_CC@=Y','019b2cb2-f1f8-7805-b4f0-30b1dc2a18da','N','N','D','N')
;

-- Dec 17, 2025, 7:54:55 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200516,0,0,'Y',TO_TIMESTAMP('2025-12-17 19:54:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 19:54:55','YYYY-MM-DD HH24:MI:SS'),100,'Department',254,100,19,'N',22,'N','C_Department_ID','Y','D',203901,'@$Element_DP@=Y','019b2cb3-227c-761d-ac65-2f65d66c9957','N','N','D','N')
;

-- Dec 17, 2025, 7:55:10 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200517,0,0,'Y',TO_TIMESTAMP('2025-12-17 19:55:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 19:55:10','YYYY-MM-DD HH24:MI:SS'),100,'Employee','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',254,110,18,252,'N',10,'N','C_Employee_ID','Y','D',203893,'@$Element_EP@=Y','019b2cb3-5cac-75d0-bc28-6c55065d39cb','N','N','D','N')
;

-- Dec 17, 2025, 7:55:24 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200518,0,0,'Y',TO_TIMESTAMP('2025-12-17 19:55:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-12-17 19:55:24','YYYY-MM-DD HH24:MI:SS'),100,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',254,120,19,'N',0,'N','M_Warehouse_ID','Y','D',459,'@$Element_WH@=Y','019b2cb3-937b-770d-90ba-3c70b0e4fb47','N','N','D','N')
;
