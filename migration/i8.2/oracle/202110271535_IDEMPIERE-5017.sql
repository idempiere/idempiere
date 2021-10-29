SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5017 DateAcct on Find Window of M_InOut display wrong
-- Oct 27, 2021, 3:34:29 PM CEST
UPDATE AD_Field SET IsEncrypted='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-27 15:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100
WHERE AD_Field_ID IN (
12210, /* M_LotCtlExclude.AD_Org_ID */
1404, /* AD_Element_Trl.AD_Client_ID */
2486, /* C_BPartner.AD_Org_ID */
2935, /* M_InOut.DateAcct */
3493, /* M_InOut.DateAcct */
3545, /* C_BP_EDI.M_Warehouse_ID */
4445, /* C_Project.SalesRep_ID */
57719, /* M_InOut.DateAcct */
57853, /* M_InOut.DateAcct */
6977, /* W_ClickCount.AD_Org_ID */
7591, /* AD_Workflow_Trl.AD_Org_ID */
7668) /* C_Project.SalesRep_ID */
;

SELECT register_migration_script('202110271535_IDEMPIERE-5017.sql') FROM dual
;

