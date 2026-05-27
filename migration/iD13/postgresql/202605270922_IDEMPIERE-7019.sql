-- IDEMPIERE-7019
SELECT register_migration_script('202605270922_IDEMPIERE-7019.sql') FROM dual;

-- May 27, 2026, 9:22:00 AM CEST
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,CurSymbol,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200002,'CLF',2,'Chilean Unidad de Fomento',4,0,0,0,'Y',TO_TIMESTAMP('2026-05-27 09:21:59','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-27 09:21:59','YYYY-MM-DD HH24:MI:SS'),10,'UF','N','N','019e684f-c9ec-7280-ac03-0d9f58018f5b')
;

