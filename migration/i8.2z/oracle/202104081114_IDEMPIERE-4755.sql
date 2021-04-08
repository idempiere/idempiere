SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4755 - Change data access level of Report View to System+Client
-- 8 de abr de 2021 11:10:58 BRT
UPDATE AD_Table SET AccessLevel='6',Updated=TO_DATE('2021-04-08 11:10:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=361
;

-- 8 de abr de 2021 11:11:29 BRT
UPDATE AD_Column SET IsUpdateable='Y', SeqNoSelection=10,Updated=TO_DATE('2021-04-08 11:11:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7046
;

-- 8 de abr de 2021 11:11:58 BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200147,'AD_ReportView of Table','S','AD_ReportView.AD_Table_ID=@AD_Table_ID@',0,0,'Y',TO_DATE('2021-04-08 11:11:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-04-08 11:11:56','YYYY-MM-DD HH24:MI:SS'),100,'D','b22e8fb3-0de2-49ff-a304-96bc55b78edb')
;

-- 8 de abr de 2021 11:12:18 BRT
UPDATE AD_Column SET AD_Val_Rule_ID=200147,Updated=TO_DATE('2021-04-08 11:12:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7046
;

SELECT Register_Migration_Script ('202104081114_IDEMPIERE-4755.sql') FROM DUAL
;