-- Apr 10, 2018 7:56:35 PM GMT+08:00
-- Radio Group List
INSERT INTO AD_Reference (AD_Client_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_UU,Created,CreatedBy,EntityType,IsActive,IsOrderByValue,Name,Updated,UpdatedBy,ValidationType) VALUES (0,0,200152,'bde88a42-3601-499e-a2ee-2185eb6fc785',TO_TIMESTAMP('2018-04-10 19:56:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','N','Radio Group List',TO_TIMESTAMP('2018-04-10 19:56:29','YYYY-MM-DD HH24:MI:SS'),100,'D')
;

-- Apr 10, 2018 7:57:56 PM GMT+08:00
UPDATE AD_Val_Rule SET Code='AD_Reference.ValidationType=CASE WHEN  @AD_Reference_ID@ IN (17,28,200152) THEN ''L'' ELSE ''T'' END',Updated=TO_TIMESTAMP('2018-04-10 19:57:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=115
;

-- Apr 10, 2018 8:00:03 PM GMT+08:00
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-10 20:00:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Apr 10, 2018 8:01:28 PM GMT+08:00
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-10 20:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Apr 10, 2018 8:02:27 PM GMT+08:00
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-04-10 20:02:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200855
;

SELECT register_migration_script('201804111700_TicketAP2-19.sql') FROM dual
;

