-- Mar 20, 2013 5:15:40 PM COT
-- IDEMPIERE-783 search fields in Window Process Audit 
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_DATE('2013-03-20 17:15:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2781
;

-- Mar 20, 2013 5:15:32 PM COT
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_DATE('2013-03-20 17:15:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5951
;

-- Mar 22, 2013 3:19:07 PM COT
UPDATE AD_Column SET SeqNo=3,Updated=TO_DATE('2013-03-22 15:19:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2809
;

-- Mar 22, 2013 3:19:13 PM COT
UPDATE AD_Column SET SeqNo=2,Updated=TO_DATE('2013-03-22 15:19:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4023
;

-- Mar 22, 2013 3:19:19 PM COT
UPDATE AD_Column SET SeqNo=1,Updated=TO_DATE('2013-03-22 15:19:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2809
;

SELECT register_migration_script('201303201719_IDEMPIERE-783.sql') FROM dual;
