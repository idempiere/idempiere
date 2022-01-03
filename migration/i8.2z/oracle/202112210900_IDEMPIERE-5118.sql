SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5118 MUOMConversion fix and improvements
-- Dec 21, 2021, 3:31:26 PM MYT
UPDATE AD_IndexColumn SET SeqNo=4,Updated=TO_DATE('2021-12-21 15:31:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200656
;

-- Dec 21, 2021, 3:32:58 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201444,'9c133f49-0a9e-42ce-a8da-86ed15f7e40a',TO_DATE('2021-12-21 15:32:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2021-12-21 15:32:57','YYYY-MM-DD HH24:MI:SS'),100,1003,200562,3)
;

-- Dec 21, 2021, 3:33:18 PM MYT
DROP INDEX c_uom_conversion_product
;

-- Dec 21, 2021, 3:33:19 PM MYT
CREATE UNIQUE INDEX c_uom_conversion_product ON C_UOM_Conversion (C_UOM_ID,C_UOM_To_ID,AD_Client_ID,COALESCE(M_Product_ID,-1))
;

SELECT register_migration_script('202112210900_IDEMPIERE-5118.sql') FROM dual
;

