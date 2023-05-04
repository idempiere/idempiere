-- IDEMPIERE-5683
SELECT register_migration_script('202304280940_IDEMPIERE-5683.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 28, 2023, 9:41:24 AM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=53370 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235 | @AD_Reference_ID@=200202 | @AD_Reference_ID@=200240',Updated=TO_TIMESTAMP('2023-04-28 09:41:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- update Constraint Type based on java arrays from PO_Record.java
UPDATE AD_Column
SET FKConstraintType = 
	CASE 
		WHEN AD_Table_ID IN(254,754,389,200000,200215,200347) THEN 'C' /* AD_Attachment, AD_Archive, AD_Note, AD_RecentItem, AD_PostIt, AD_LabelAssignment - Cascade */
		WHEN AD_Table_ID IN(417,876) THEN 'N' /* R_Request, CM_Chat - No Action */
		ELSE 'D'
	END
WHERE AD_Reference_ID IN(200202,200240)	/* Record ID, Record UU */
;

