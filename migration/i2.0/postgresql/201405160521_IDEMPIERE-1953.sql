CREATE OR REPLACE FUNCTION bompricelimit (in product_id numeric, in pricelist_version_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	v_Price	NUMERIC;
	v_ProductPrice	NUMERIC;
	bom RECORD;

BEGIN
	--	Try to get price from PriceList directly
	SELECT	COALESCE (SUM(PriceLimit), 0)
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
			AND b.M_ProductBOM_ID != Product_ID
			AND p.IsBOM='Y'
			AND p.IsVerified='Y'
			AND b.IsActive='Y'
		LOOP
			v_ProductPrice := bomPriceLimit (bom.M_ProductBOM_ID, PriceList_Version_ID);
			v_Price := v_Price + (bom.BOMQty * v_ProductPrice);
		END LOOP;
	END IF;
	--
	RETURN v_Price;
	
END;

$BODY$
LANGUAGE 'plpgsql' STABLE
;

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
			AND b.M_ProductBOM_ID != Product_ID
			AND p.IsBOM='Y'
			AND p.IsVerified='Y'
			AND b.IsActive='Y'
		LOOP
			v_ProductPrice := bomPriceList (bom.M_ProductBOM_ID, PriceList_Version_ID);
			v_Price := v_Price + (bom.BOMQty * v_ProductPrice);
		END LOOP;
	END IF;
	--
	RETURN v_Price;
	
END;

$BODY$
LANGUAGE 'plpgsql' STABLE
;

CREATE OR REPLACE FUNCTION bompricestd (in product_id numeric, in pricelist_version_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	v_Price	NUMERIC;
	v_ProductPrice	NUMERIC;
	bom RECORD;

BEGIN
	--	Try to get price from PriceList directly
	SELECT	COALESCE(SUM(PriceStd), 0)
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
			AND b.M_ProductBOM_ID != Product_ID
			AND p.IsBOM='Y'
			AND p.IsVerified='Y'
			AND b.IsActive='Y'
		LOOP
			v_ProductPrice := bomPriceStd (bom.M_ProductBOM_ID, PriceList_Version_ID);
			v_Price := v_Price + (bom.BOMQty * v_ProductPrice);
		END LOOP;
	END IF;
	--
	RETURN v_Price;
	
END;

$BODY$
LANGUAGE 'plpgsql' STABLE
;

CREATE OR REPLACE FUNCTION bomqtyavailable (in product_id numeric, in warehouse_id numeric, in locator_id numeric) RETURNS numeric AS
$BODY$
BEGIN
	RETURN bomQtyOnHand(Product_ID, Warehouse_ID, Locator_ID) - bomQtyReserved(Product_ID, Warehouse_ID, Locator_ID);
END;
$BODY$
LANGUAGE 'plpgsql' STABLE
;

CREATE OR REPLACE FUNCTION bomqtyonhand (in product_id numeric, in warehouse_id numeric, in locator_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	myWarehouse_ID		numeric;
 	v_Quantity		numeric := 99999;	--	unlimited
	v_IsBOM			CHAR(1);
	v_IsStocked		CHAR(1);
	v_ProductType		CHAR(1);
 	v_ProductQty		numeric;
	v_StdPrecision		int;
	bom			record;
	
BEGIN
	--	Check Parameters
	myWarehouse_ID := Warehouse_ID;
	IF (myWarehouse_ID IS NULL) THEN
		IF (Locator_ID IS NULL) THEN
			RETURN 0;
		ELSE
			SELECT 	SUM(M_Warehouse_ID) INTO myWarehouse_ID
			FROM	M_LOCATOR
			WHERE	M_Locator_ID=Locator_ID;
		END IF;
	END IF;
	IF (myWarehouse_ID IS NULL) THEN
		RETURN 0;
	END IF;

	--	Check, if product exists and if it is stocked
	BEGIN
		SELECT	IsBOM, ProductType, IsStocked
	 	  INTO	v_IsBOM, v_ProductType, v_IsStocked
		FROM M_PRODUCT
		WHERE M_Product_ID=Product_ID;
		--
	EXCEPTION	--	not found
		WHEN OTHERS THEN
			RETURN 0;
	END;
	--	Unimited capacity if no item
	IF (v_IsBOM='N' AND (v_ProductType<>'I' OR v_IsStocked='N')) THEN
		RETURN v_Quantity;
	--	Stocked item
	ELSIF (v_IsStocked='Y') THEN
		--	Get ProductQty
		SELECT 	COALESCE(SUM(QtyOnHand), 0)
		  INTO	v_ProductQty
		FROM 	M_STORAGE s
		WHERE M_Product_ID=Product_ID
		  AND EXISTS (SELECT * FROM M_LOCATOR l WHERE s.M_Locator_ID=l.M_Locator_ID
		  	AND l.M_Warehouse_ID=myWarehouse_ID);
		--
		RETURN v_ProductQty;
	END IF;

	--	Go though BOM
	FOR bom IN 	--	Get BOM Product info
		SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM, p.IsStocked, p.ProductType
		FROM M_PRODUCT_BOM b, M_PRODUCT p
		WHERE b.M_ProductBOM_ID=p.M_Product_ID
		  AND b.M_Product_ID=product_ID
		  AND b.M_ProductBOM_ID != Product_ID
		  AND p.IsBOM='Y'
		  AND p.IsVerified='Y'
		  AND b.IsActive='Y'
	LOOP
		--	Stocked Items "leaf node"
		IF (bom.ProductType = 'I' AND bom.IsStocked = 'Y') THEN
			--	Get v_ProductQty
			SELECT 	COALESCE(SUM(QtyOnHand), 0)
			  INTO	v_ProductQty
			FROM 	M_STORAGE s
			WHERE M_Product_ID=bom.M_ProductBOM_ID
			  AND EXISTS (SELECT * FROM M_LOCATOR l WHERE s.M_Locator_ID=l.M_Locator_ID
			  	AND l.M_Warehouse_ID=myWarehouse_ID);
			--	Get Rounding Precision
			SELECT 	COALESCE(MAX(u.StdPrecision), 0)
			  INTO	v_StdPrecision
			FROM 	C_UOM u, M_PRODUCT p
			WHERE u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=bom.M_ProductBOM_ID;
			--	How much can we make with this product
			v_ProductQty := ROUND (v_ProductQty/bom.BOMQty, v_StdPrecision);
			--	How much can we make overall
			IF (v_ProductQty < v_Quantity) THEN
				v_Quantity := v_ProductQty;
			END IF;
		--	Another BOM
		ELSIF (bom.IsBOM = 'Y') THEN
			v_ProductQty := Bomqtyonhand (bom.M_ProductBOM_ID, myWarehouse_ID, Locator_ID);
			--	How much can we make overall
			IF (v_ProductQty < v_Quantity) THEN
				v_Quantity := v_ProductQty;
			END IF;
		END IF;
	END LOOP;	--	BOM

	IF (v_Quantity > 0) THEN
		--	Get Rounding Precision for Product
		SELECT 	COALESCE(MAX(u.StdPrecision), 0)
		  INTO	v_StdPrecision
		FROM 	C_UOM u, M_PRODUCT p
		WHERE u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=Product_ID;
		--
		RETURN ROUND (v_Quantity, v_StdPrecision);
	END IF;
	RETURN 0;
END;
$BODY$
LANGUAGE 'plpgsql' STABLE
;

CREATE OR REPLACE FUNCTION bomqtyordered (in p_product_id numeric, in p_warehouse_id numeric, in p_locator_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	v_Warehouse_ID		numeric;
 	v_Quantity		numeric := 99999;	--	unlimited
	v_IsBOM			CHAR(1);
	v_IsStocked		CHAR(1);
	v_ProductType		CHAR(1);
 	v_ProductQty		numeric;
	v_StdPrecision		int;
	bom 			record;	
BEGIN
	--	Check Parameters
	v_Warehouse_ID := p_Warehouse_ID;
	IF (v_Warehouse_ID IS NULL) THEN
		IF (p_Locator_ID IS NULL) THEN
			RETURN 0;
		ELSE
			SELECT 	MAX(M_Warehouse_ID) INTO v_Warehouse_ID
			FROM	M_LOCATOR
			WHERE	M_Locator_ID=p_Locator_ID;
		END IF;
	END IF;
	IF (v_Warehouse_ID IS NULL) THEN
		RETURN 0;
	END IF;

	--	Check, if product exists and if it is stocked
	BEGIN
		SELECT	IsBOM, ProductType, IsStocked
		  INTO	v_IsBOM, v_ProductType, v_IsStocked
		FROM 	M_PRODUCT
		WHERE 	M_Product_ID=p_Product_ID;
		--
	EXCEPTION	--	not found
		WHEN OTHERS THEN
			RETURN 0;
	END;

	--	No reservation for non-stocked
	IF (v_IsBOM='N' AND (v_ProductType<>'I' OR v_IsStocked='N')) THEN
		RETURN 0;
	--	Stocked item
	ELSIF (v_IsStocked='Y') THEN
		--	Get ProductQty
		SELECT 	COALESCE(SUM(Qty), 0)
		  INTO	v_ProductQty
		FROM 	M_StorageReservation
		WHERE M_Product_ID=p_Product_ID
		  AND M_Warehouse_ID=v_Warehouse_ID
		  AND IsSOTrx='N'
		  AND IsActive='Y';
		--
		RETURN v_ProductQty;
	END IF;

	--	Go though BOM
	FOR bom IN  		
	--	Get BOM Product info
		SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM, p.IsStocked, p.ProductType
		FROM M_PRODUCT_BOM b, M_PRODUCT p
		WHERE b.M_ProductBOM_ID=p.M_Product_ID
		  AND b.M_Product_ID=p_Product_ID
		  AND b.M_ProductBOM_ID != p_Product_ID
		  AND p.IsBOM='Y'
		  AND p.IsVerified='Y'
		  AND b.IsActive='Y'
	LOOP
		--	Stocked Items "leaf node"
		IF (bom.ProductType = 'I' AND bom.IsStocked = 'Y') THEN
			--	Get ProductQty
			SELECT 	COALESCE(SUM(Qty), 0)
			  INTO	v_ProductQty
			FROM 	M_StorageReservation
			WHERE M_Product_ID=p_Product_ID
			  AND M_Warehouse_ID=v_Warehouse_ID
			  AND IsSOTrx='N'
			  AND IsActive='Y';
			--	Get Rounding Precision
			SELECT 	COALESCE(MAX(u.StdPrecision), 0)
			  INTO	v_StdPrecision
			FROM 	C_UOM u, M_PRODUCT p
			WHERE 	u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=bom.M_ProductBOM_ID;
			--	How much can we make with this product
			v_ProductQty := ROUND (v_ProductQty/bom.BOMQty, v_StdPrecision );

			--	How much can we make overall
			IF (v_ProductQty < v_Quantity) THEN
				v_Quantity := v_ProductQty;
			END IF;
		--	Another BOM
		ELSIF (bom.IsBOM = 'Y') THEN
			v_ProductQty := Bomqtyordered (bom.M_ProductBOM_ID, v_Warehouse_ID, p_Locator_ID);
			--	How much can we make overall
			IF (v_ProductQty < v_Quantity) THEN
				v_Quantity := v_ProductQty;
			END IF;
		END IF;
	END LOOP;	--	BOM

	--	Unlimited (e.g. only services)
	IF (v_Quantity = 99999) THEN
		RETURN 0;
	END IF;

	IF (v_Quantity > 0) THEN
		--	Get Rounding Precision for Product
		SELECT 	COALESCE(MAX(u.StdPrecision), 0)
		  INTO	v_StdPrecision
		FROM 	C_UOM u, M_PRODUCT p
		WHERE 	u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=p_Product_ID;
		--
		RETURN ROUND (v_Quantity, v_StdPrecision );
	END IF;
	--
	RETURN 0;
END;
$BODY$
  LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION bomqtyreserved (in p_product_id numeric, in p_warehouse_id numeric, in p_locator_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	v_Warehouse_ID			numeric;
 	v_Quantity			numeric := 99999;	--	unlimited
	v_IsBOM				CHAR(1);
	v_IsStocked			CHAR(1);
	v_ProductType			CHAR(1);
 	v_ProductQty			numeric;
	v_StdPrecision			int;
	bom				record;
BEGIN
	--	Check Parameters
	v_Warehouse_ID := p_Warehouse_ID;
	IF (v_Warehouse_ID IS NULL) THEN
		IF (p_Locator_ID IS NULL) THEN
			RETURN 0;
		ELSE
			SELECT 	MAX(M_Warehouse_ID) INTO v_Warehouse_ID
			FROM	M_LOCATOR
			WHERE	M_Locator_ID=p_Locator_ID;
		END IF;
	END IF;
	IF (v_Warehouse_ID IS NULL) THEN
		RETURN 0;
	END IF;

	--	Check, if product exists and if it is stocked
	BEGIN
		SELECT	IsBOM, ProductType, IsStocked
		  INTO	v_IsBOM, v_ProductType, v_IsStocked
		FROM M_PRODUCT
		WHERE M_Product_ID=p_Product_ID;
		--
	EXCEPTION	--	not found
		WHEN OTHERS THEN
			RETURN 0;
	END;

	--	No reservation for non-stocked
	IF (v_IsBOM='N' AND (v_ProductType<>'I' OR v_IsStocked='N')) THEN
		RETURN 0;
	--	Stocked item
	ELSIF (v_IsStocked='Y') THEN
		--	Get ProductQty
		SELECT 	COALESCE(SUM(Qty), 0)
		  INTO	v_ProductQty
		FROM 	M_StorageReservation
		WHERE M_Product_ID=p_Product_ID
		  AND M_Warehouse_ID=v_Warehouse_ID
		  AND IsSOTrx='Y'
		  AND IsActive='Y';
		--
		RETURN v_ProductQty;
	END IF;

	--	Go though BOM
	FOR bom IN 
	--	Get BOM Product info
		SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM, p.IsStocked, p.ProductType
		FROM M_PRODUCT_BOM b, M_PRODUCT p
		WHERE b.M_ProductBOM_ID=p.M_Product_ID
		  AND b.M_Product_ID=p_Product_ID
		  AND b.M_ProductBOM_ID != p_Product_ID
		  AND p.IsBOM='Y'
		  AND p.IsVerified='Y'
		  AND b.IsActive='Y'
	LOOP
		--	Stocked Items "leaf node"
		IF (bom.ProductType = 'I' AND bom.IsStocked = 'Y') THEN
			--	Get ProductQty
			SELECT 	COALESCE(SUM(Qty), 0)
			  INTO	v_ProductQty
			FROM 	M_StorageReservation
			WHERE 	M_Product_ID=bom.M_ProductBOM_ID
			  AND   M_Warehouse_ID =v_Warehouse_ID
			  AND	IsSOTrx='Y'
			  AND	IsActive='Y';
			--	Get Rounding Precision
			SELECT 	COALESCE(MAX(u.StdPrecision), 0)
			  INTO	v_StdPrecision
			FROM 	C_UOM u, M_PRODUCT p
			WHERE 	u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=bom.M_ProductBOM_ID;
			--	How much can we make with this product
			v_ProductQty := ROUND (v_ProductQty/bom.BOMQty, v_StdPrecision);
			--	How much can we make overall
			IF (v_ProductQty < v_Quantity) THEN
				v_Quantity := v_ProductQty;
			END IF;
		--	Another BOM
		ELSIF (bom.IsBOM = 'Y') THEN
			v_ProductQty := Bomqtyreserved (bom.M_ProductBOM_ID, v_Warehouse_ID, p_Locator_ID);
			--	How much can we make overall
			IF (v_ProductQty < v_Quantity) THEN
				v_Quantity := v_ProductQty;
			END IF;
		END IF;
	END LOOP;	--	BOM

	--	Unlimited (e.g. only services)
	IF (v_Quantity = 99999) THEN
		RETURN 0;
	END IF;

	IF (v_Quantity > 0) THEN
		--	Get Rounding Precision for Product
		SELECT 	COALESCE(MAX(u.StdPrecision), 0)
		  INTO	v_StdPrecision
		FROM 	C_UOM u, M_PRODUCT p
		WHERE 	u.C_UOM_ID=p.C_UOM_ID AND p.M_Product_ID=p_Product_ID;
		--
		RETURN ROUND (v_Quantity, v_StdPrecision);
	END IF;
	RETURN 0;
END;
$BODY$
  LANGUAGE plpgsql STABLE;


SELECT register_migration_script('201405160521_IDEMPIERE-1953.sql') FROM dual
;