-- IDEMPIERE-5302
SELECT register_migration_script('202205270955_IDEMPIERE-5302.sql') FROM dual;

-- May 27, 2022, 9:55:11 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201122,'d60d3d3f-33ce-4186-b160-b567ae53e478',TO_TIMESTAMP('2022-05-27 09:55:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Process_DrillRule_Trl_pkey',TO_TIMESTAMP('2022-05-27 09:55:10','YYYY-MM-DD HH24:MI:SS'),100,200349,'Y','Y','N','N','Y')
;

-- May 27, 2022, 9:55:29 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201499,'85a6b307-66bb-4905-a9c6-7eff6e438b6d',TO_TIMESTAMP('2022-05-27 09:55:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-05-27 09:55:29','YYYY-MM-DD HH24:MI:SS'),100,214929,201122,10)
;

-- May 27, 2022, 9:55:38 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201500,'489493fb-35a5-4083-b3df-baa69901cc65',TO_TIMESTAMP('2022-05-27 09:55:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-05-27 09:55:38','YYYY-MM-DD HH24:MI:SS'),100,214918,201122,20)
;

-- May 27, 2022, 9:55:40 AM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CONSTRAINT AD_Process_DrillRule_Trl_pkey PRIMARY KEY (AD_Process_DrillRule_ID,AD_Language)
;

