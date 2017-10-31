SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3338 Document Status Indicator / fix wrong example on GW
-- Oct 23, 2017 6:41:13 PM CEST
UPDATE PA_DocumentStatus SET WhereClause='M_InOut.IsSOTrx=''Y'' AND M_InOut.Processed=''N'' AND M_InOut.MovementType IN (''C-'')',Updated=TO_DATE('2017-10-23 18:41:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200001
;

SELECT register_migration_script('201710231841_IDEMPIERE-3338.sql') FROM dual
;

