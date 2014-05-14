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
		  AND p.IsBOM='Y'
		  AND p.IsVerified='Y'
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
  LANGUAGE plpgsql VOLATILE;

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
		  AND p.IsBOM='Y'
		  AND p.IsVerified='Y'
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
  LANGUAGE plpgsql VOLATILE;

SELECT register_migration_script('201404290949_Ticket_1003965.sql') FROM dual
;

