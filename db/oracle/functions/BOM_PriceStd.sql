CREATE OR REPLACE FUNCTION BOMPRICESTD
(
	Product_ID 		IN NUMBER,
	PriceList_Version_ID	IN NUMBER
)
RETURN NUMBER
/*************************************************************************
 * The contents of this file are subject to the Compiere License.  You may
 * obtain a copy of the License at    http://www.compiere.org/license.html
 * Software is on an  "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either
 * express or implied. See the License for details. Code: Compiere ERP+CRM
 * Copyright (C) 1999-2002 Jorg Janke, ComPiere, Inc. All Rights Reserved.
 *************************************************************************
 * $Id: BOM_PriceStd.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
 * Title:	Return Standard Price of Product/BOM
 * Description:
 *			if not found: 0
 ************************************************************************/
AS
	v_Price			NUMBER;
	v_ProductPrice	NUMBER;
	v_RecordExists BOOLEAN;
	v_IsBOMPriceOverride CHAR(1);
	--	Get BOM Product info
	CURSOR CUR_BOM IS
		SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM
		FROM M_PRODUCT_BOM b, M_PRODUCT p
		WHERE b.M_ProductBOM_ID=p.M_Product_ID
		  AND b.M_Product_ID=Product_ID
		  AND b.M_ProductBOM_ID != Product_ID
		  AND (p.IsBOM='N' OR p.IsVerified='Y')
		  AND b.IsActive='Y';
	--
BEGIN
	--	Try to get price from pricelist directly
	SELECT	
		SUM(pp.PriceStd),
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
--	DBMS_OUTPUT.PUT_LINE('Price=' || v_Price);

	-- Set defaults if null
	v_RecordExists := COALESCE(v_RecordExists, 'N');
	v_IsBOMPriceOverride := COALESCE(v_IsBOMPriceOverride, 'Y');

	--	Determine if BOM calculation is needed
	--	Calculate BOM when:
	--	  1. No record exists, OR
	--	  2. Record exists with 0 price AND IsBOMPriceOverride = 'Y' (backward compatible - calculate from components)
	IF (NOT v_RecordExists OR (v_RecordExists AND COALESCE(v_Price, 0) = 0 AND v_IsBOMPriceOverride = 'Y')) THEN
		v_Price := 0;
		FOR bom IN CUR_BOM LOOP
			v_ProductPrice := Bompricestd (bom.M_ProductBOM_ID, PriceList_Version_ID);
			v_Price := v_Price + (bom.BOMQty * v_ProductPrice);
		--	DBMS_OUTPUT.PUT_LINE('Price=' || v_Price);
		END LOOP;	--	BOM
	ELSE
		-- Record exists and either price > 0 OR IsBOMPriceOverride = 'N'
		v_Price := COALESCE(v_Price, 0);
	END IF;
	--
	RETURN v_Price;
END Bompricestd;
/

