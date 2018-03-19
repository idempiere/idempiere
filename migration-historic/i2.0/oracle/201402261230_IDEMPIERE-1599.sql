SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 26, 2014 11:50:10 AM SGT
-- IDEMPIERE-1599 Correct naming for acct wildcard dimensions
UPDATE AD_Ref_List SET Description='User Element List 1', Name='User Element List 1',Updated=TO_DATE('2014-02-26 11:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=282
;

-- Feb 26, 2014 11:50:32 AM SGT
UPDATE AD_Ref_List SET Description='User Element List 2', Name='User Element List 2',Updated=TO_DATE('2014-02-26 11:50:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=283
;

-- Feb 26, 2014 11:50:54 AM SGT
UPDATE AD_Ref_List SET Name='User Column 1',Updated=TO_DATE('2014-02-26 11:50:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=796
;

-- Feb 26, 2014 11:51:00 AM SGT
UPDATE AD_Ref_List SET Name='User Column 2',Updated=TO_DATE('2014-02-26 11:51:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=797
;

-- Feb 26, 2014 11:51:46 AM SGT
UPDATE AD_Ref_List SET Description='User Column 1',Updated=TO_DATE('2014-02-26 11:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=796
;

-- Feb 26, 2014 11:51:48 AM SGT
UPDATE AD_Ref_List SET Description='User Column 2',Updated=TO_DATE('2014-02-26 11:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=797
;

-- Feb 26, 2014 11:52:30 AM SGT
UPDATE AD_Ref_List SET Description='User Element List 1', Name='User Element List 1',Updated=TO_DATE('2014-02-26 11:52:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53430
;

-- Feb 26, 2014 11:52:38 AM SGT
UPDATE AD_Ref_List SET Name='User Element List 2',Updated=TO_DATE('2014-02-26 11:52:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53431
;

-- Feb 26, 2014 11:52:49 AM SGT
UPDATE AD_Ref_List SET Description='User Column 1', Name='User Column 1',Updated=TO_DATE('2014-02-26 11:52:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53432
;

-- Feb 26, 2014 11:52:52 AM SGT
UPDATE AD_Ref_List SET Name='User Column 2',Updated=TO_DATE('2014-02-26 11:52:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53433
;

-- Feb 26, 2014 11:52:54 AM SGT
UPDATE AD_Ref_List SET Description='User Column 2',Updated=TO_DATE('2014-02-26 11:52:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53433
;

SELECT register_migration_script('201402261230_IDEMPIERE-1599.sql') FROM dual
;