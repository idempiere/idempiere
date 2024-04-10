-- IDEMPIERE-5859
SELECT register_migration_script('202402270843_IDEMPIERE-5859.sql') FROM dual;

-- Feb 27, 2024, 8:43:37 AM CET
UPDATE AD_Tab SET ReadOnlyLogic='@AttributeValueType@!L & @AttributeValueType@!C',Updated=TO_TIMESTAMP('2024-02-27 08:43:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=463
;

-- Feb 27, 2024, 8:44:39 AM CET
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=L | @AttributeValueType@=C',Updated=TO_TIMESTAMP('2024-02-27 08:44:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6370
;

-- Feb 27, 2024, 8:44:43 AM CET
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=L | @AttributeValueType@=C',Updated=TO_TIMESTAMP('2024-02-27 08:44:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6367
;

-- Feb 27, 2024, 8:44:45 AM CET
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=L | @AttributeValueType@=C',Updated=TO_TIMESTAMP('2024-02-27 08:44:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6371
;

-- Feb 27, 2024, 8:44:47 AM CET
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=L | @AttributeValueType@=C',Updated=TO_TIMESTAMP('2024-02-27 08:44:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6368
;

-- Feb 27, 2024, 8:44:50 AM CET
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=L | @AttributeValueType@=C',Updated=TO_TIMESTAMP('2024-02-27 08:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6373
;

-- Feb 27, 2024, 8:44:52 AM CET
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=L | @AttributeValueType@=C',Updated=TO_TIMESTAMP('2024-02-27 08:44:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6369
;

-- Feb 27, 2024, 8:44:55 AM CET
UPDATE AD_Field SET DisplayLogic='@AttributeValueType@=L | @AttributeValueType@=C',Updated=TO_TIMESTAMP('2024-02-27 08:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6372
;

