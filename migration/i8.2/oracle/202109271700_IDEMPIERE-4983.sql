SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4983
-- Sep 27, 2021, 5:00:28 PM CEST
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200001,'RUB',2,'Russian Ruble',4,0,0,0,'Y',TO_DATE('2021-09-27 17:00:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-27 17:00:28','YYYY-MM-DD HH24:MI:SS'),0,'N','N','a7e597d0-89ef-498c-ba18-72a1076981d8')
;

-- Sep 27, 2021, 5:00:42 PM CEST
UPDATE C_Country SET C_Currency_ID=200001,Updated=TO_DATE('2021-09-27 17:00:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE C_Country_ID=286
;

UPDATE C_Currency SET IsActive='N',Updated=TO_DATE('2021-09-27 17:02:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE C_Currency_ID=155
;

SELECT register_migration_script('202109271700_IDEMPIERE-4983.sql') FROM dual
;
