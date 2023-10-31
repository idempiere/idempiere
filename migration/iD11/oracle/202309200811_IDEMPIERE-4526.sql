SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 20, 2023, 8:11:21 AM WIB
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200247,'C_UOM Weight Type','Unit of Measure selection for Weight UOM Type','T',0,0,'Y',TO_TIMESTAMP('2023-09-20 08:11:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-09-20 08:11:21','YYYY-MM-DD HH24:MI:SS'),10,'D','N','c78a88bb-cb9a-4846-8f61-3eb790f08b51','N')
;

-- Sep 20, 2023, 8:18:28 AM WIB
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200247,146,485,485,'(C_UOM.UOMType is NULL OR C_UOM.UOMType=''WE'')',0,0,'Y',TO_TIMESTAMP('2023-09-20 08:18:28','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-09-20 08:18:28','YYYY-MM-DD HH24:MI:SS'),10,'N','D','49e83bc3-ae22-464f-a2a8-d34799d50465')
;

-- Sep 20, 2023, 8:18:43 AM WIB
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200248,'C_UOM Length Type','Unit of Measure selection for Length UOM Type','T',0,0,'Y',TO_TIMESTAMP('2023-09-20 08:18:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-09-20 08:18:42','YYYY-MM-DD HH24:MI:SS'),10,'D','N','a9996de5-c232-4304-b081-3c4620350bb2','N')
;

-- Sep 20, 2023, 8:19:13 AM WIB
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200248,146,485,485,'(C_UOM.UOMType is NULL OR C_UOM.UOMType=''LE'')',0,0,'Y',TO_TIMESTAMP('2023-09-20 08:19:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-09-20 08:19:13','YYYY-MM-DD HH24:MI:SS'),10,'N','D','2e62436b-8005-424f-8755-9c85056ca57d')
;

-- Sep 20, 2023, 8:20:09 AM WIB
UPDATE AD_Column SET AD_Reference_Value_ID=200248,Updated=TO_TIMESTAMP('2023-09-20 08:20:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=2349
;

-- Sep 20, 2023, 8:20:23 AM WIB
UPDATE AD_Column SET AD_Reference_Value_ID=200247,Updated=TO_TIMESTAMP('2023-09-20 08:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=2348
;

-- IDEMPIERE-4526
SELECT register_migration_script('202309200811_IDEMPIERE-4526.sql') FROM dual;
