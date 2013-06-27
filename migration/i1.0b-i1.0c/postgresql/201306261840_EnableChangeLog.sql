-- enable audit change log for tables that:
-- a) have an ID column with same name than table
-- b) exclude Import and Temporary tables
-- c) exclude tables ending with Log
-- d) exclude packin/packout tables
-- e) exclude some specific tables that are usual logs
update ad_table set ischangelog = 'Y'
-- select tablename from ad_table
where ischangelog='N' and isview='N' and isactive='Y'
and exists (select 1 from ad_column c where c.ad_table_id=ad_table.ad_table_id and columnname like ad_table.tablename || '_ID')
and not (tablename in 
(
'AD_Issue',
'AD_LdapProcessor',
'AD_Note',
'AD_PInstance',
'AD_RecentItem',
'AD_Session',
'AD_UserMail',
'AD_WF_Activity',
'AD_WF_ActivityResult',
'AD_WF_EventAudit',
'AD_WF_Process',
'AD_WF_ProcessData',
'C_OnlineTrxHistory',
'Fact_Acct',
'Fact_Acct_Summary',
'M_CostDetail',
'M_CostQueue'
)
or tablename like 'I|_%' escape '|'
or tablename like 'T|_%' escape '|'
or tablename like '%Log'
or tablename like 'AD|_Pack%' escape '|'
)
;

SELECT register_migration_script('201306261840_EnableChangeLog.sql') FROM dual
;

