CREATE OR REPLACE FUNCTION bompricelist (in product_id numeric, in pricelist_version_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	v_Price	NUMERIC;
	v_ProductPrice	NUMERIC;
	bom RECORD;

BEGIN
	--	Try to get price from pricelist directly
	SELECT	COALESCE (SUM(PriceList), 0)
	INTO	v_Price
	FROM	M_ProductPrice
	WHERE M_PriceList_Version_ID=PriceList_Version_ID AND M_Product_ID=Product_ID;

	--	No Price - Check if BOM
	IF (v_Price = 0) THEN
		FOR bom IN  
			SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM
			FROM M_Product_BOM b, M_Product p
			WHERE b.M_ProductBOM_ID=p.M_Product_ID
			AND b.M_Product_ID=Product_ID
			AND p.IsBOM='Y'
			AND p.IsVerified='Y'
		LOOP
			v_ProductPrice := bomPriceList (bom.M_ProductBOM_ID, PriceList_Version_ID);
			v_Price := v_Price + (bom.BOMQty * v_ProductPrice);
		END LOOP;
	END IF;
	--
	RETURN v_Price;
	
END;

$BODY$
LANGUAGE 'plpgsql'
;

