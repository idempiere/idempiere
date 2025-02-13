-- IDEMPIERE-6177
SELECT register_migration_script('202406250930_IDEMPIERE-6177.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 25, 2024, 9:30:19 AM CEST
UPDATE AD_Field SET SeqNo=160, ReadOnlyLogic='@DocSubTypeSO@=''WR'' | @DocSubTypeSO@=''WI'' | @DocSubTypeSO@=''WP''',Updated=TO_TIMESTAMP('2024-06-25 09:30:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208492
;

-- Jun 25, 2024, 9:30:19 AM CEST
UPDATE AD_Field SET SeqNo=180, ReadOnlyLogic='@DocSubTypeSO@=''WR'' | @DocSubTypeSO@=''WI''',Updated=TO_TIMESTAMP('2024-06-25 09:30:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208493
;

-- Jun 25, 2024, 9:45:35 AM CEST
UPDATE AD_Field SET DisplayLogic='(@DocBaseType@=''SOO'' | @DocBaseType@=''POO'') & (@DocSubTypeSO@=''WR'' | @DocSubTypeSO@=''WI'' | @DocSubTypeSO@=''PR'')', SeqNo=160,Updated=TO_TIMESTAMP('2024-06-25 09:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208492
;

-- Jun 25, 2024, 9:45:35 AM CEST
UPDATE AD_Field SET DisplayLogic='(@DocBaseType@=''SOO'' | @DocBaseType@=''POO'') & (@DocSubTypeSO@=''WR'' | @DocSubTypeSO@=''WI'' | @DocSubTypeSO@=''PR'' | @DocSubTypeSO@=''WP'')', SeqNo=180,Updated=TO_TIMESTAMP('2024-06-25 09:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208493
;

-- Jun 25, 2024, 9:47:35 AM CEST
UPDATE AD_Field SET SeqNo=160, ReadOnlyLogic='@DocSubTypeSO@=''WR'' | @DocSubTypeSO@=''WI''',Updated=TO_TIMESTAMP('2024-06-25 09:47:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208492
;

-- Jun 25, 2024, 9:47:35 AM CEST
UPDATE AD_Field SET SeqNo=180, ReadOnlyLogic='@DocSubTypeSO@=''WR'' | @DocSubTypeSO@=''WI'' | @DocSubTypeSO@=''WP''',Updated=TO_TIMESTAMP('2024-06-25 09:47:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208493
;

