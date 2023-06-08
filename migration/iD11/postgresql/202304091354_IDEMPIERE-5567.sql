-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202304091354_IDEMPIERE-5567.sql') FROM dual;

-- Apr 9, 2023, 1:54:18 PM CEST
INSERT INTO Test (Test_ID,Name,T_Integer,T_Number,T_Amount,Created,Updated,IsActive,AD_Client_ID,AD_Org_ID,CreatedBy,UpdatedBy,C_Currency_ID,C_UOM_ID,T_Qty,Processing,Processed,Test_UU) VALUES (200003,'Test Record in GardenWorld',0,0,0,TO_TIMESTAMP('2023-04-09 13:54:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-04-09 13:54:18','YYYY-MM-DD HH24:MI:SS'),'Y',11,0,100,100,100,100,0,'N','N','6846b9eb-aff1-47c8-8b50-e9632b39c0c7')
;

