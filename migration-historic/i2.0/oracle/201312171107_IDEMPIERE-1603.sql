SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 17, 2013 11:04:16 AM COT
-- IDEMPIERE-1603 Copy Info Window Columns from other Info Window's
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Classname,Value,AD_Client_ID) VALUES ('N',200067,'N','N','32fe7794-53ce-442d-bb40-a132ebcdff7e','4','N','N',0,0,'Y','D','Copy Info Window Columns',0,TO_DATE('2013-12-17 11:04:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-12-17 11:04:16','YYYY-MM-DD HH24:MI:SS'),'Y',100,'org.compiere.process.CopyInfoWindowColumns','CopyInfoWindowColumns',0)
;

-- Dec 17, 2013 11:05:01 AM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID) VALUES ('N',200073,'989f60c7-012b-4f13-9a15-6118d75a4854','The Info window is used to search and select records as well as display information relevant to the selection.',200067,19,'Y','D','Info Window','AD_InfoWindow_ID','Info and search/select Window',10,'Y',10,'Y',100,TO_DATE('2013-12-17 11:05:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-12-17 11:05:01','YYYY-MM-DD HH24:MI:SS'),0,'N',0,3068)
;

-- Dec 17, 2013 11:06:48 AM COT
INSERT INTO AD_ToolBarButton (Action,AD_Tab_ID,AD_Process_ID,SeqNo,Name,ComponentName,IsCustomization,AD_Org_ID,Created,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_ToolBarButton_UU) VALUES ('W',842,200067,10,'Copy Info Window Columns','CopyInfoWindowColumns','N',0,TO_DATE('2013-12-17 11:06:48','YYYY-MM-DD HH24:MI:SS'),100,200079,TO_DATE('2013-12-17 11:06:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,'c4845d6f-abf8-4419-b7e6-adaec70cebe2')
;

SELECT register_migration_script('201312171107_IDEMPIERE-1603.sql') FROM dual
;

