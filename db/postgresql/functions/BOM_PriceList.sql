CREATE OR REPLACE FUNCTION adempiere.bompricelist(product_id numeric, pricelist_version_id numeric)
 RETURNS numeric
 LANGUAGE plpgsql
 STABLE
AS $function$
DECLARE
	v_Price	NUMERIC;
	v_ProductPrice	NUMERIC;
	v_RecordExists BOOLEAN;
	v_IsBOMPriceOverride CHAR(1);
	bom RECORD;

BEGIN
	--	Try to get price from pricelist directly and check configuration
	SELECT	
		SUM(pp.PriceList),
		COUNT(*) > 0,
		p.IsBOMPriceOverride
	INTO	
		v_Price,
		v_RecordExists,
		v_IsBOMPriceOverride
	FROM	M_ProductPrice pp
	INNER JOIN M_Product p ON pp.M_Product_ID = p.M_Product_ID
	WHERE pp.IsActive='Y' 
		AND pp.M_PriceList_Version_ID=PriceList_Version_ID 
		AND pp.M_Product_ID=Product_ID
	GROUP BY p.IsBOMPriceOverride;

	-- Set defaults if null
	v_RecordExists := COALESCE(v_RecordExists, 'N');
	v_IsBOMPriceOverride := COALESCE(v_IsBOMPriceOverride, 'Y');

	--	Determine if BOM calculation is needed
	--	Calculate BOM when:
	--	  1. No record exists, OR
	--	  2. Record exists with 0 price AND IsBOMPriceOverride = 'Y' (backward compatible - calculate from components)
	IF (NOT v_RecordExists OR (v_RecordExists AND COALESCE(v_Price, 0) = 0 AND v_IsBOMPriceOverride = 'Y')) THEN
		v_Price := 0;
		FOR bom IN
			SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM
			FROM M_Product_BOM b, M_Product p
			WHERE b.M_ProductBOM_ID=p.M_Product_ID
			AND b.M_Product_ID=Product_ID
			AND b.M_ProductBOM_ID != Product_ID
			AND (p.IsBOM='N' OR p.IsVerified='Y')
			AND b.IsActive='Y'
		LOOP
			v_ProductPrice := bomPriceList (bom.M_ProductBOM_ID, PriceList_Version_ID);
			v_Price := v_Price + (bom.BOMQty * v_ProductPrice);
		END LOOP;
	ELSE
		-- Record exists and either price > 0 OR (price = 0 AND IsBOMPriceOverride = 'N')
		v_Price := COALESCE(v_Price, 0);
	END IF;
	--
	RETURN v_Price;

END;
$BODY$
LANGUAGE 'plpgsql' STABLE
;

