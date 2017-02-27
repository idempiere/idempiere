SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 27, 2017 12:25:32 PM GMT+08:00
-- 1007607 Implement generic UOM conversions
UPDATE AD_IndexColumn SET ColumnSQL='COALESCE(M_Product_ID,-1)',Updated=TO_DATE('2017-02-27 12:25:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200656
;

-- Feb 27, 2017 12:25:46 PM GMT+08:00
DROP INDEX c_uom_conversion_product
;

-- Feb 27, 2017 12:25:46 PM GMT+08:00
CREATE UNIQUE INDEX c_uom_conversion_product ON C_UOM_Conversion (C_UOM_ID,C_UOM_To_ID,COALESCE(M_Product_ID,-1))
;

-- Feb 27, 2017 12:29:47 PM GMT+08:00
UPDATE AD_Field SET IsMandatory=NULL, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-02-27 12:29:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10831
;

-- Feb 27, 2017 12:49:10 PM GMT+08:00
UPDATE AD_Val_Rule SET Code='(
EXISTS (
	/* UOM is a default UOM and no product selected */
	SELECT * 
	FROM C_UOM uu 
	WHERE C_UOM.C_UOM_ID=uu.C_UOM_ID AND IsActive =''Y'' AND IsDefault=''Y'' AND @M_Product_ID@=0
)
OR EXISTS (
	/* UOM is the products UOM */
	SELECT * 
	FROM M_Product p 
	WHERE C_UOM.C_UOM_ID=p.C_UOM_ID AND @M_Product_ID@=p.M_Product_ID
)
OR EXISTS (
	/* For the products UOM there is a conversion that is explicitly bound to the product */
	SELECT * 
	FROM M_Product p INNER JOIN C_UOM_Conversion c ON (p.C_UOM_ID=c.C_UOM_ID AND p.M_PRODUCT_ID=c.M_Product_ID AND c.IsActive =''Y'' )
	WHERE C_UOM.C_UOM_ID=c.C_UOM_TO_ID AND @M_Product_ID@=p.M_Product_ID
)
OR EXISTS (
	/* For the products UOM there is a conversion that is not bound to any product explicitly */
	SELECT * 
	FROM M_Product p INNER JOIN C_UOM_Conversion c ON (p.C_UOM_ID=c.C_UOM_ID AND c.M_Product_ID IS NULL AND c.IsActive =''Y'' )
	WHERE C_UOM.C_UOM_ID=c.C_UOM_TO_ID AND @M_Product_ID@=p.M_Product_ID
	AND NOT EXISTS (
		SELECT *
		FROM M_Product p1 INNER JOIN C_UOM_Conversion c1 ON (p1.C_UOM_ID=c1.C_UOM_ID AND p1.M_PRODUCT_ID=c1.M_Product_ID AND c1.IsActive =''Y'' )
		WHERE c.C_UOM_ID=c1.C_UOM_TO_ID AND c.C_UOM_TO_ID=c1.C_UOM_TO_ID AND p1.M_Product_ID=@M_Product_ID@
	)
)
)',Updated=TO_DATE('2017-02-27 12:49:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=210
;

SELECT register_migration_script('201702271800_Ticket_1007607.sql') FROM dual
;

