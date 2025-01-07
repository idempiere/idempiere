-- IDEMPIERE-5683
SELECT register_migration_script('202304280940_IDEMPIERE-5683.sql') FROM dual;

-- Apr 28, 2023, 9:41:24 AM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=53370 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235 | @AD_Reference_ID@=200202 | @AD_Reference_ID@=200240',Updated=TO_TIMESTAMP('2023-04-28 09:41:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- update Constraint Type based on java arrays from PO_Record.java
UPDATE AD_Column
SET FKConstraintType = 
	CASE 
		WHEN AD_Table_ID IN(254,754,389,200000,200215,200347) THEN 'M' /* AD_Attachment, AD_Archive, AD_Note, AD_RecentItem, AD_PostIt, AD_LabelAssignment - Model Cascade */
		WHEN AD_Table_ID IN(417,876,270) THEN 'O' /* R_Request, CM_Chat, Fact_Acct - No Action - Model No Action Forbid Deletion */
		ELSE 'D'
	END
WHERE AD_Reference_ID = 200202 /* Record ID */
;

-- May 5, 2023, 7:57:28 PM CEST
UPDATE AD_Process_Para SET IsActive='N',Updated=TO_TIMESTAMP('2023-05-05 19:57:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200269
;

-- May 5, 2023, 8:23:32 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200640,'Model Set Null',200075,'T',0,0,'Y',TO_TIMESTAMP('2023-05-05 20:23:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-05 20:23:31','YYYY-MM-DD HH24:MI:SS'),100,'D','6591e7a2-e8f9-4cd4-9ef2-afea1275e578')
;

-- May 5, 2023, 8:23:59 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200641,'Model No Action - Forbid Deletion',200075,'O',0,0,'Y',TO_TIMESTAMP('2023-05-05 20:23:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-05 20:23:59','YYYY-MM-DD HH24:MI:SS'),100,'D','8300ca2c-50f9-4882-8776-dfdc949db534')
;

-- May 5, 2023, 8:24:07 PM CEST
UPDATE AD_Ref_List SET Name='No Action - Forbid Deletion',Updated=TO_TIMESTAMP('2023-05-05 20:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200162
;

-- May 5, 2023, 8:24:13 PM CEST
UPDATE AD_Ref_List SET Name='Do Not Create - Ignore',Updated=TO_TIMESTAMP('2023-05-05 20:24:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200161
;

-- May 5, 2023, 8:57:26 PM CEST
UPDATE AD_Val_Rule SET Code='(
    AD_Ref_List.Value = ''D''
/* Cascade/SetNull/Forbid supported for all DB constraints */
OR (AD_Ref_List.Value IN (''C'',''S'',''N'') AND @AD_Reference_ID@ IN (18,19,21,25,30,31,32,33,35,53370,200233,200234,200235))
/* ModelCascade supported for Table/TableDir/Search/RecordID */
OR (AD_Ref_List.Value = ''M''            AND @AD_Reference_ID@ IN (18,19,30,200202,200240))
/* ModelSetNull/ModelForbid supported for RecordID */
OR (AD_Ref_List.Value IN (''T'',''O'')     AND @AD_Reference_ID@ IN (200202,200240))
)',Updated=TO_TIMESTAMP('2023-05-05 20:57:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200064
;

