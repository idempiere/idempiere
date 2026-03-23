CREATE OR REPLACE FUNCTION BOMPRICELIMIT
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
 * $Id: BOM_PriceLimit.sql,v 1.1 2006/04/21 17:51:58 jjanke Exp $
 ***
 * Title:	Return Limit Price of Product/BOM
 * Description:
 *			if not found: 0
 ************************************************************************/
AS
    v_Price             NUMBER;
    v_ProductPrice      NUMBER;
    v_RecordExists      NUMBER;
    v_IsBOMPriceOverride CHAR(1);
    
    CURSOR bom_cur IS
        SELECT b.M_ProductBOM_ID, b.BOMQty, p.IsBOM
        FROM M_Product_BOM b, M_Product p
        WHERE b.M_ProductBOM_ID = p.M_Product_ID
        AND b.M_Product_ID = product_id
        AND b.M_ProductBOM_ID != product_id
        AND (p.IsBOM = 'N' OR p.IsVerified = 'Y')
        AND b.IsActive = 'Y';

BEGIN
    -- Try to get price from priceLimit directly and check configuration
    SELECT
        SUM(pp.PriceLimit),
        CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END,
        MAX(p.IsBOMPriceOverride)
    INTO
        v_Price,
        v_RecordExists,
        v_IsBOMPriceOverride
    FROM M_ProductPrice pp
    INNER JOIN M_Product p ON pp.M_Product_ID = p.M_Product_ID
    WHERE pp.IsActive = 'Y'
        AND pp.M_PriceList_Version_ID = pricelist_version_id
        AND pp.M_Product_ID = product_id;

    -- Set defaults if null
    v_RecordExists := NVL(v_RecordExists, 0);
    v_IsBOMPriceOverride := NVL(v_IsBOMPriceOverride, 'Y');

    -- Determine if BOM calculation is needed
    -- Calculate BOM when:
    --   1. No record exists, OR
    --   2. Record exists with 0 price AND IsBOMPriceOverride = 'Y' (backward compatible - calculate from components)
    IF (v_RecordExists = 0 OR (v_RecordExists = 1 AND NVL(v_Price, 0) = 0 AND v_IsBOMPriceOverride = 'Y')) THEN
        v_Price := 0;
        FOR bom IN bom_cur LOOP
            v_ProductPrice := bomPriceLimit(bom.M_ProductBOM_ID, pricelist_version_id);
            v_Price := v_Price + (bom.BOMQty * v_ProductPrice);
        END LOOP;
    ELSE
        -- Record exists and either price > 0 OR (price = 0 AND IsBOMPriceOverride = 'N')
        v_Price := NVL(v_Price, 0);
    END IF;

    RETURN v_Price;
END bompricelimit;
/

