-- IDEMPIERE-5302 Drill Assistant Feature IDEMPIERE-5523
SELECT register_migration_script('202212231059_IDEMPIERE-5302.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 23, 2022, 10:59:34 AM CET
ALTER TABLE AD_Process_DrillRule_Trl ADD CONSTRAINT AD_Process_DrillRule_Trl_pkey PRIMARY KEY (AD_Process_DrillRule_ID,AD_Language)
;

-- Dec 23, 2022, 11:05:05 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201177,'1088638a-4816-4f76-80bf-6194c53b27ea',TO_TIMESTAMP('2022-12-23 11:05:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Process_DrillRule_Para_pkey',TO_TIMESTAMP('2022-12-23 11:05:05','YYYY-MM-DD HH24:MI:SS'),100,200336,'Y','Y','N','N','Y')
;

-- Dec 23, 2022, 11:05:27 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201609,'3ad70e9e-740f-4410-b252-6930fe4d39b0',TO_TIMESTAMP('2022-12-23 11:05:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-12-23 11:05:27','YYYY-MM-DD HH24:MI:SS'),100,214739,201177,10)
;

-- Dec 23, 2022, 11:05:31 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201610,'0a01d24f-e715-45c9-ab36-b12bede80fb0',TO_TIMESTAMP('2022-12-23 11:05:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-12-23 11:05:31','YYYY-MM-DD HH24:MI:SS'),100,214753,201177,20)
;

-- Dec 23, 2022, 11:05:43 AM CET
ALTER TABLE AD_Process_DrillRule_Para ADD CONSTRAINT AD_Process_DrillRule_Para_pkey PRIMARY KEY (AD_Process_DrillRule_ID,AD_Process_Para_ID)
;

