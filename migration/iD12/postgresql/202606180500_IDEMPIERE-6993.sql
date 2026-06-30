-- IDEMPIERE-6993 Match Invoice wrong GL account and posting
-- Fix existing Invoice Price Variance M_CostDetail ASI values to match linked M_MatchInv rows
SELECT register_migration_script('202606180500_IDEMPIERE-6993.sql') FROM dual;

CREATE TABLE adempiere.M_CostDetail_6993 AS 
SELECT * FROM adempiere.M_CostDetail
WHERE M_CostDetail_ID IN (
    SELECT cd.M_CostDetail_ID
    FROM adempiere.M_CostDetail cd
    JOIN adempiere.M_MatchInv mi ON cd.M_MatchInv_ID = mi.M_MatchInv_ID
    WHERE cd.M_AttributeSetInstance_ID <> mi.M_AttributeSetInstance_ID
    AND cd.Description = 'Invoice Price Variance'
    AND cd.M_CostElement_ID IS NULL
);

UPDATE adempiere.M_CostDetail
SET M_AttributeSetInstance_ID = (
    SELECT mi.M_AttributeSetInstance_ID
    FROM adempiere.M_MatchInv mi
    WHERE M_CostDetail.M_MatchInv_ID = mi.M_MatchInv_ID
)
WHERE M_CostDetail_ID IN (
    SELECT cd.M_CostDetail_ID
    FROM adempiere.M_CostDetail cd
    JOIN adempiere.M_MatchInv mi ON cd.M_MatchInv_ID = mi.M_MatchInv_ID
    WHERE cd.M_AttributeSetInstance_ID <> mi.M_AttributeSetInstance_ID
    AND cd.Description = 'Invoice Price Variance'
    AND cd.M_CostElement_ID IS NULL
);