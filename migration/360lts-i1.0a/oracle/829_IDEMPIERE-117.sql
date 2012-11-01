-- Apr 3, 2012 11:17:51 AM COT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,CreatedBy,IsActive) VALUES (1,'N',100,'Y',1000000,1000000,'N','Y',200005,'Table M_CostHistory','M_CostHistory',0,0,TO_DATE('2012-04-03 11:17:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-04-03 11:17:50','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

UPDATE AD_System
  SET LastMigrationScriptApplied='829_IDEMPIERE-117.sql'
WHERE LastMigrationScriptApplied<'829_IDEMPIERE-117.sql'
   OR LastMigrationScriptApplied IS NULL
;
