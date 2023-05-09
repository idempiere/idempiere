-- IDEMPIERE-5575
SELECT register_migration_script('202302150816_IDEMPIERE-5575.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 15, 2023, 8:16:38 AM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200628,'Document closed',177,'D',0,0,'Y',TO_TIMESTAMP('2023-02-15 08:16:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-15 08:16:38','YYYY-MM-DD HH24:MI:SS'),100,'D','948b0299-f812-4fc7-92b8-9063f7deae6d')
;

-- Feb 15, 2023, 8:26:25 AM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200629,'Document Close Period',176,'D',0,0,'Y',TO_TIMESTAMP('2023-02-15 08:26:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-15 08:26:25','YYYY-MM-DD HH24:MI:SS'),100,'D','115de309-7e7b-42a0-873b-7acf400d3ac3')
;

