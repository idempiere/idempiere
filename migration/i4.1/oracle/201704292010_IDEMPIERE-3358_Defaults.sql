SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3358 Dictionary fixes - set Defaults
-- Apr 29, 2017 8:07:14 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200095,0,0,TO_DATE('2017-04-29 20:07:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2017-04-29 20:07:14','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','DEFAULT_ENTITYTYPE','U','Set the default for EntityType columns and parameters - useful when working on a plugin with a different EntityType than U','D','S','5dd403ad-a926-4e38-a058-b9b6b1ea052e')
;

update ad_column set defaultvalue='@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual' where ad_element_id=1682;

update ad_process_para set defaultvalue='@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual' where ad_element_id=1682;

update ad_field set defaultvalue=null where defaultvalue is not null and ad_column_id in (select ad_column_id from ad_column where ad_element_id=1682);

-- Apr 29, 2017 8:26:17 PM CEST
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_DATE('2017-04-29 20:26:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8564
;

-- Apr 29, 2017 8:27:05 PM CEST
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_DATE('2017-04-29 20:27:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4426
;

-- set IsChangeLog
update ad_table set ischangelog='N' where tablename in (
'A_Asset_Group_Trl',
'A_Asset_Info_Oth',
'A_FundingMode_Acct',
'AD_BroadcastMessage_Trl',
'AD_Color_Trl',
'AD_LdapAccess',
'AD_PrintColor_Trl',
'AD_PrintFormat_Trl',
'AD_UserBPAccess',
'C_Activity_Trl',
'C_Campaign_Trl',
'C_Region_Trl',
'C_SalesRegion_Trl',
'GL_Category_Trl',
'M_PriceList_Trl',
'M_PriceList_Version_Trl',
'M_Product_Category_Trl'
);

update ad_table set ischangelog='Y' where tablename in (
'AD_Chart',
'AD_ChartDatasource',
'AD_LdapProcessor',
'AD_Package_Exp',
'AD_Package_Exp_Common',
'AD_Package_Exp_Detail',
'AD_Package_Imp',
'AD_Package_Imp_Inst',
'AD_Style',
'AD_StyleLine',
'AD_UserPreference',
'AD_ZoomCondition',
'C_AddressValidation',
'C_AddressValidationCfg',
'C_ContactActivity',
'C_CountryGroup',
'C_CountryGroupCountry',
'C_Opportunity',
'C_RecurringGroup',
'C_SalesStage',
'C_TaxProvider',
'C_TaxProviderCfg',
'K_Index',
'M_BP_Price',
'M_EDI',
'M_EDI_Info'
);

-- Apr 29, 2017 9:14:31 PM CEST
UPDATE AD_Message SET MsgText='New',Updated=TO_DATE('2017-04-29 21:14:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=347
;

SELECT register_migration_script('201704292010_IDEMPIERE-3358_Defaults.sql') FROM dual
;

