-- IDEMPIERE-7019
SELECT register_migration_script('202605270922_IDEMPIERE-7019.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 27, 2026, 9:22:00 AM CEST
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,CurSymbol,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200002,'CLF',2,'Chilean Unidad de Fomento',4,0,0,0,'Y',TO_TIMESTAMP('2026-05-27 09:21:59','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-27 09:21:59','YYYY-MM-DD HH24:MI:SS'),10,'UF','N','N','019e684f-c9ec-7280-ac03-0d9f58018f5b')
;

-- May 27, 2026, 4:11:31 PM CEST
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,CurSymbol,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200003,'COU',2,'Colombian Unidad de Valor Real',4,0,0,0,'Y',TO_TIMESTAMP('2026-05-27 16:11:31','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-27 16:11:31','YYYY-MM-DD HH24:MI:SS'),10,'UVR','N','N','019e69c6-b7e6-72c1-886c-6a01913da771')
;

-- May 27, 2026, 4:11:48 PM CEST
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,CurSymbol,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200004,'MXV',2,'Mexican Unidad de Inversión',4,0,0,0,'Y',TO_TIMESTAMP('2026-05-27 16:11:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-27 16:11:48','YYYY-MM-DD HH24:MI:SS'),10,'UDI','N','N','019e69c6-f9f3-70f1-8042-52566dd90bdb')
;

-- May 27, 2026, 4:12:03 PM CEST
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,CurSymbol,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200005,'BOV',2,'Bolivian Mvdol',4,0,0,0,'Y',TO_TIMESTAMP('2026-05-27 16:12:03','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-27 16:12:03','YYYY-MM-DD HH24:MI:SS'),10,'Mvdol','N','N','019e69c7-35ba-7f57-9147-110c5b59b3ca')
;

-- May 27, 2026, 4:12:13 PM CEST
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,CurSymbol,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200006,'UYI',2,'Uruguayan Indexed Unit',4,0,0,0,'Y',TO_TIMESTAMP('2026-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-27 16:12:12','YYYY-MM-DD HH24:MI:SS'),10,'UI','N','N','019e69c7-5a53-70f5-8199-af0baaea44df')
;

-- May 27, 2026, 4:12:29 PM CEST
INSERT INTO C_Currency (C_Currency_ID,ISO_Code,StdPrecision,Description,CostingPrecision,EMURate,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,CurSymbol,IsEuro,IsEMUMember,C_Currency_UU) VALUES (200007,'UYW',2,'Uruguayan Nominal Wage Index Unit',4,0,0,0,'Y',TO_TIMESTAMP('2026-05-27 16:12:29','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-27 16:12:29','YYYY-MM-DD HH24:MI:SS'),10,'UP','N','N','019e69c7-9aff-74ce-a2f3-09f6a8e34673')
;

-- May 27, 2026, 4:17:41 PM CEST
UPDATE AD_Window SET TitleLogic='@Description@',Updated=TO_TIMESTAMP('2026-05-27 16:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Window_ID=115
;
