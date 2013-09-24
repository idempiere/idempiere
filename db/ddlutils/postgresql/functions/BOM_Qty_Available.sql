CREATE OR REPLACE FUNCTION bomqtyavailable (in product_id numeric, in warehouse_id numeric, in locator_id numeric) RETURNS numeric AS
$BODY$
BEGIN
	RETURN bomQtyOnHand(Product_ID, Warehouse_ID, Locator_ID) - bomQtyReserved(Product_ID, Warehouse_ID, Locator_ID);
END;
$BODY$
LANGUAGE 'plpgsql'
;

