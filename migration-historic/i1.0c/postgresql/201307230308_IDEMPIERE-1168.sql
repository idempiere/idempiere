-- Jul 23, 2013 7:43:57 AM MYT
-- IDEMPIERE-1168
UPDATE AD_Tab SET AD_Column_ID=200042, WhereClause='M_CostMovement_v.AD_Client_ID=@AD_Client_ID@ AND M_CostMovement_v.M_Product_ID=@M_Product_ID@ AND M_CostMovement_v.M_CostType_ID=@M_CostType_ID@ AND M_CostMovement_v.C_AcctSchema_ID=@C_AcctSchema_ID@ AND M_CostMovement_v.M_CostElement_ID=@M_CostElement_ID@ AND M_CostMovement_v.M_AttributeSetInstance_ID=@M_AttributeSetInstance_ID@',Updated=TO_TIMESTAMP('2013-07-23 07:43:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200000
;

SELECT register_migration_script('201307230308_IDEMPIERE-1168.sql') FROM dual
;
