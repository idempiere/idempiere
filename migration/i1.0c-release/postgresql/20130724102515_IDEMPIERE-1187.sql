-- Jul 24, 2013 10:16:11 AM COT
-- IDEMPIERE-1187 in make menu window, when select "Summary Level", field "Window" still display
UPDATE AD_Field SET DisplayLogic='@Action@=W & @IsSummary@=N',Updated=TO_TIMESTAMP('2013-07-24 10:16:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206
;

-- Jul 24, 2013 10:16:35 AM COT
-- IDEMPIERE-1187 in make menu window, when select "Summary Level", field "Window" still display
UPDATE AD_Field SET DisplayLogic='@Action@=X & @IsSummary@=N',Updated=TO_TIMESTAMP('2013-07-24 10:16:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3612
;

-- Jul 24, 2013 10:16:48 AM COT
-- IDEMPIERE-1187 in make menu window, when select "Summary Level", field "Window" still display
UPDATE AD_Field SET DisplayLogic='@Action@=I & @IsSummary@=N',Updated=TO_TIMESTAMP('2013-07-24 10:16:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201638
;

-- Jul 24, 2013 10:17:27 AM COT
-- IDEMPIERE-1187 in make menu window, when select "Summary Level", field "Window" still display
UPDATE AD_Field SET DisplayLogic='@Action@=P | @Action@=R & @IsSummary@=N',Updated=TO_TIMESTAMP('2013-07-24 10:17:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2576
;

-- Jul 24, 2013 10:17:53 AM COT
-- IDEMPIERE-1187 in make menu window, when select "Summary Level", field "Window" still display
UPDATE AD_Field SET DisplayLogic='@Action@=T & @IsSummary@=N',Updated=TO_TIMESTAMP('2013-07-24 10:17:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208
;

-- Jul 24, 2013 10:18:05 AM COT
-- IDEMPIERE-1187 in make menu window, when select "Summary Level", field "Window" still display
UPDATE AD_Field SET DisplayLogic='@Action@=F & @IsSummary@=N',Updated=TO_TIMESTAMP('2013-07-24 10:18:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207
;

SELECT register_migration_script('20130724102515_IDEMPIERE-1187.sql') FROM dual
;