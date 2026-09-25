-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603242048_IDEMPIERE-6908.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 24, 2026, 8:48:39 PM GMT+08:00
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200164,0,0,'Y',TO_TIMESTAMP('2026-03-24 20:48:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 20:48:38','YYYY-MM-DD HH24:MI:SS'),100,'Install Extension','Process to install extension','N','InstallExtension','N','org.idempiere.extension.manager.process.InstallExtension','4','D',0,0,'N','S','N','019d1fe3-d89d-76d8-960c-0e7f8262003d','P')
;

