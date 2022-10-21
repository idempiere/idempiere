-- IDEMPIERE-5455 Use Multi-Select parameters in Info Windows
SELECT register_migration_script('202210191953_IDEMPIERE-5455.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 19, 2022, 7:53:10 PM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=138, AD_Val_Rule_ID=NULL, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-19 19:53:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200039
;

-- Oct 21, 2022, 10:40:18 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=138, AD_Val_Rule_ID=NULL, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-21 10:40:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200052
;

-- Oct 21, 2022, 10:40:55 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=290, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-21 10:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200069
;

-- Oct 21, 2022, 10:41:23 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=138, AD_Val_Rule_ID=NULL, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-21 10:41:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200071
;

-- Oct 21, 2022, 10:41:56 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=138, AD_Val_Rule_ID=NULL, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-21 10:41:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200080
;

-- Oct 21, 2022, 10:43:49 AM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200224,'S_ResourceType','Resource Type','T',0,0,'Y',TO_TIMESTAMP('2022-10-21 10:43:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-21 10:43:48','YYYY-MM-DD HH24:MI:SS'),100,'D','N','f7d402bd-d4e2-404e-ac59-30ee64057f7a')
;

-- Oct 21, 2022, 10:44:26 AM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200224,480,6889,6898,0,0,'Y',TO_TIMESTAMP('2022-10-21 10:44:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-21 10:44:26','YYYY-MM-DD HH24:MI:SS'),100,'N','D','7372c6f3-97c1-46ac-bb01-285074488678')
;

-- Oct 21, 2022, 10:44:34 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=200224, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-21 10:44:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200094
;

-- Oct 21, 2022, 10:45:29 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=53320, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-21 10:45:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200095
;

-- Oct 21, 2022, 10:45:50 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=138, AD_Val_Rule_ID=NULL, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-21 10:45:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200106
;

-- Oct 21, 2022, 10:46:36 AM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=162, AD_Val_Rule_ID=NULL, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-21 10:46:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200105
;

