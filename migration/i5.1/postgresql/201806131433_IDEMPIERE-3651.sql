-- IDEMPIERE-3651 Report Column Set=>Report Column=>User Element List1 not displaying User1_ID values
-- Jun 13, 2018 2:32:06 PM CEST
UPDATE AD_Val_Rule SET Code='C_ElementValue.C_Element_ID IN 
(SELECT C_Element_ID FROM C_AcctSchema_Element  WHERE IsActive=''Y'' AND AD_Client_ID=@#AD_Client_ID@ AND (ElementType=''@ElementType@'' OR (''@ElementType@''=''CO'' AND ElementType=''AC'')))',Updated=TO_TIMESTAMP('2018-06-13 14:32:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=258
;

SELECT register_migration_script('201806131433_IDEMPIERE-3651.sql') FROM dual
;

