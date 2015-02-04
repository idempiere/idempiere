-- Feb 4, 2015 9:37:10 AM COT
-- IDEMPIERE-2412 Generate Production from Project with Phase - New Process
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200077,0,0,'Y',TO_TIMESTAMP('2015-02-04 09:37:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-04 09:37:09','YYYY-MM-DD HH24:MI:SS'),100,'Generate Production from Project','Generate Production from Project Line(s)','N','C_Project_GenerateProduction','N','org.compiere.process.ProjectGenProduction','1','D',6,6,'N','N','Y','N','542a66f7-afe0-493e-90d4-a91e10f17ac8')
;

-- Feb 4, 2015 9:37:10 AM COT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200118,0,0,'Y',TO_TIMESTAMP('2015-02-04 09:37:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-04 09:37:10','YYYY-MM-DD HH24:MI:SS'),100,'Project','Financial Project','A Project allows you to track and control internal or external activities.',200077,10,19,'N',0,'Y','C_Project_ID','Y','D',208,'fd3854a0-4d69-46b6-9469-775f8f30a319','N')
;

-- Feb 4, 2015 9:37:11 AM COT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200119,0,0,'Y',TO_TIMESTAMP('2015-02-04 09:37:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-04 09:37:11','YYYY-MM-DD HH24:MI:SS'),100,'Project Phase','Phase of a Project',200077,20,19,'N',165,10,'N','C_ProjectPhase_ID','Y','D',2073,'9ba5e0b9-e245-4129-9f67-55837f1092e1','N')
;

-- Feb 4, 2015 9:37:11 AM COT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200120,0,0,'Y',TO_TIMESTAMP('2015-02-04 09:37:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-04 09:37:11','YYYY-MM-DD HH24:MI:SS'),100,'Project Line','Task or step in a project','The Project Line indicates a unique project line.',200077,30,19,'N',174,0,'N','C_ProjectLine_ID','Y','D',1552,'67c806e3-f4ba-4fd2-a26a-3082a6c4ff64','N')
;

-- Feb 4, 2015 9:37:11 AM COT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200098,'Generate Production from Project','Generate Production from Project Line(s)','P',0,0,'Y',TO_TIMESTAMP('2015-02-04 09:37:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-02-04 09:37:11','YYYY-MM-DD HH24:MI:SS'),100,'N',200077,'N','N','D','Y','47d506b6-e2d4-4ec3-8df2-9b913c0864b0')
;

-- Feb 4, 2015 9:37:11 AM COT
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 160,5, 10, 200098)
;

SELECT register_migration_script('201502040937_IDEMPIERE-2412.sql') FROM dual
;

