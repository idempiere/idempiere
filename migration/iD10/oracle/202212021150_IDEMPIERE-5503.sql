SELECT register_migration_script('202212021150_IDEMPIERE-5503.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

UPDATE M_CostDetail SET Amt = Amt * -1 WHERE Qty < 0 AND Amt > 0 AND M_InOutLine_ID IS NOT NULL
;

UPDATE M_CostDetail SET Amt = Amt * -1 WHERE Qty > 0 AND Amt < 0 AND M_InOutLine_ID IS NOT NULL
;
