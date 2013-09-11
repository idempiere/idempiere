-- Aug 29, 2013 5:55:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Tab SET SeqNo=80,Updated=TO_TIMESTAMP('2013-08-29 17:55:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200096
;

-- Aug 29, 2013 5:55:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Tab SET SeqNo=90,Updated=TO_TIMESTAMP('2013-08-29 17:55:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200097
;

-- Aug 29, 2013 5:55:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Tab SET SeqNo=100,Updated=TO_TIMESTAMP('2013-08-29 17:55:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200098
;

-- Aug 29, 2013 5:55:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Tab SET SeqNo=110,Updated=TO_TIMESTAMP('2013-08-29 17:55:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200099
;

SELECT register_migration_script('201308291756_IDEMPIERE-1132.sql') FROM dual
;