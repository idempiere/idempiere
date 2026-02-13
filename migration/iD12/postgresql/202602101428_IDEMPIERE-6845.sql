-- IDEMPIERE-6845 - BOM Price Functions Should Distinguish Between Explicit Zero and Missing Price
SELECT register_migration_script('202602101428_IDEMPIERE-6845.sql') FROM dual;

-- Feb 10, 2026, 2:28:35 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Help,PrintName,EntityType,AD_Element_UU) VALUES (204031,0,0,'Y',TO_TIMESTAMP('2026-02-10 14:28:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 14:28:35','YYYY-MM-DD HH24:MI:SS'),100,'IsBOMPriceOverride','Calculate BOM price if Zero','BOM Price Override. When Y, zero prices in price lists trigger BOM component calculation (legacy behavior). When N, explicit zero prices are respected as free items. Only affects behavior when price record exists with zero value; missing records always calculate from BOM.','Calculate BOM price if Zero','D','019c47bd-5316-744b-8a9c-d24883df83d8')
;

-- Feb 10, 2026, 2:28:53 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217379,0,'Calculate BOM price if Zero','BOM Price Override. When Y, zero prices in price lists trigger BOM component calculation (legacy behavior). When N, explicit zero prices are respected as free items. Only affects behavior when price record exists with zero value; missing records always calculate from BOM.',208,'IsBOMPriceOverride','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-02-10 14:28:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 14:28:53','YYYY-MM-DD HH24:MI:SS'),100,204031,'Y','N','D','N','N','N','Y','019c47bd-9820-70b7-8c36-5f672f48b9a2','Y',0,'N','N','N','N')
;

-- Feb 10, 2026, 2:28:59 PM CET
ALTER TABLE M_Product ADD COLUMN IsBOMPriceOverride CHAR(1) DEFAULT 'Y' CHECK (IsBOMPriceOverride IN ('Y','N')) NOT NULL
;

-- Feb 10, 2026, 2:30:34 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (209004,'Calculate BOM price if Zero','BOM Price Override. When Y, zero prices in price lists trigger BOM component calculation (legacy behavior). When N, explicit zero prices are respected as free items. Only affects behavior when price record exists with zero value; missing records always calculate from BOM.',180,217379,'Y',0,620,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-02-10 14:30:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-10 14:30:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019c47bf-20d2-7995-abf4-5cbb14cf4161','Y',610,1,1,1,'N','N','N','N','N')
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@IsBOM@=Y', SeqNo=410, XPosition=2, ColumnSpan=2,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209004
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3744
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=430,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3745
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=440,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1027
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=450,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1028
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=460,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1568
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=470,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1569
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=480,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5381
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=490,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5383
;

-- Feb 10, 2026, 2:32:16 PM CET
UPDATE AD_Field SET SeqNo=500,Updated=TO_TIMESTAMP('2026-02-10 14:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12418
;

CREATE OR REPLACE FUNCTION bompricelimit (in product_id numeric, in pricelist_version_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	v_Price	NUMERIC;
	v_ProductPrice	NUMERIC;
	v_RecordExists NUMERIC;
	v_IsBOMPriceOverride CHAR(1);
	bom RECORD;

BEGIN
	--	Try to get price from priceLimit directly and check configuration
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
	    AND pp.M_PriceList_Version_ID=PriceList_Version_ID 
	    AND pp.M_Product_ID=Product_ID;

	-- Set defaults if null
	v_RecordExists := COALESCE(v_RecordExists, 0);
	v_IsBOMPriceOverride := COALESCE(v_IsBOMPriceOverride, 'Y');

	--	Determine if BOM calculation is needed
	--	Calculate BOM when:
	--	  1. No record exists, OR
	--	  2. Record exists with 0 price AND IsBOMPriceOverride = 'Y' (backward compatible - calculate from components)
	IF (v_RecordExists = 0 OR (v_RecordExists = 1 AND COALESCE(v_Price, 0) = 0 AND v_IsBOMPriceOverride = 'Y')) THEN
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
			v_ProductPrice := bomPriceLimit (bom.M_ProductBOM_ID, PriceList_Version_ID);
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

CREATE OR REPLACE FUNCTION bompricelist (in product_id numeric, in pricelist_version_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	v_Price	NUMERIC;
	v_ProductPrice	NUMERIC;
	v_RecordExists NUMERIC;
	v_IsBOMPriceOverride CHAR(1);
	bom RECORD;

BEGIN
	--	Try to get price from pricelist directly and check configuration
	SELECT
	    SUM(pp.PriceList),
	    CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END,
	    MAX(p.IsBOMPriceOverride)
	INTO
	    v_Price,
	    v_RecordExists,
	    v_IsBOMPriceOverride
	FROM M_ProductPrice pp
	INNER JOIN M_Product p ON pp.M_Product_ID = p.M_Product_ID
	WHERE pp.IsActive = 'Y'
		AND pp.M_PriceList_Version_ID=PriceList_Version_ID 
		AND pp.M_Product_ID=Product_ID;

	-- Set defaults if null
	v_RecordExists := COALESCE(v_RecordExists, 0);
	v_IsBOMPriceOverride := COALESCE(v_IsBOMPriceOverride, 'Y');

	--	Determine if BOM calculation is needed
	--	Calculate BOM when:
	--	  1. No record exists, OR
	--	  2. Record exists with 0 price AND IsBOMPriceOverride = 'Y' (backward compatible - calculate from components)
	IF (v_RecordExists = 0 OR (v_RecordExists = 1 AND COALESCE(v_Price, 0) = 0 AND v_IsBOMPriceOverride = 'Y')) THEN
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

CREATE OR REPLACE FUNCTION bompricestd (in product_id numeric, in pricelist_version_id numeric) RETURNS numeric AS
$BODY$
DECLARE
	v_Price	NUMERIC;
	v_ProductPrice	NUMERIC;
	v_RecordExists NUMERIC;
	v_IsBOMPriceOverride CHAR(1);
	bom RECORD;

BEGIN
	--	Try to get price from priceStd directly
	SELECT
	    SUM(pp.PriceStd),
	    CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END,
	    MAX(p.IsBOMPriceOverride)
	INTO
	    v_Price,
	    v_RecordExists,
	    v_IsBOMPriceOverride
	FROM M_ProductPrice pp
	INNER JOIN M_Product p ON pp.M_Product_ID = p.M_Product_ID
	WHERE pp.IsActive = 'Y'
		AND pp.M_PriceList_Version_ID=PriceList_Version_ID 
		AND pp.M_Product_ID=Product_ID;

	-- Set defaults if null
	v_RecordExists := COALESCE(v_RecordExists, 0);
	v_IsBOMPriceOverride := COALESCE(v_IsBOMPriceOverride, 'Y');

	--	Determine if BOM calculation is needed
	--	Calculate BOM when:
	--	  1. No record exists, OR
	--	  2. Record exists with 0 price AND IsBOMPriceOverride = 'Y' (backward compatible - calculate from components)
	IF (v_RecordExists = 0 OR (v_RecordExists = 1 AND COALESCE(v_Price, 0) = 0 AND v_IsBOMPriceOverride = 'Y')) THEN
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
			v_ProductPrice := bomPriceStd (bom.M_ProductBOM_ID, PriceList_Version_ID);
			v_Price := v_Price + (bom.BOMQty * v_ProductPrice);
		END LOOP;
	ELSE
		-- Record exists and either price > 0 OR IsBOMPriceOverride = 'N'
		v_Price := COALESCE(v_Price, 0);
	END IF;
	--
	RETURN v_Price;

END;
$BODY$
LANGUAGE 'plpgsql' STABLE
;

