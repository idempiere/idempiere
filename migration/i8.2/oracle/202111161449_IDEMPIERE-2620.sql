CREATE OR REPLACE VIEW M_INOUT_CANDIDATE_V
(AD_CLIENT_ID, AD_ORG_ID, C_BPARTNER_ID, C_ORDER_ID, DOCUMENTNO, 
 DATEORDERED, C_DOCTYPE_ID, POREFERENCE, DESCRIPTION, SALESREP_ID, 
 M_WAREHOUSE_ID, TOTALLINES)
AS 
SELECT	
	o.AD_Client_ID, o.AD_Org_ID, o.C_BPartner_ID, o.C_Order_ID,
	o.DocumentNo, o.DateOrdered, o.C_DocType_ID, 
    o.POReference, o.Description, o.SalesRep_ID,
    l.M_Warehouse_ID,
	SUM((l.QtyOrdered-l.QtyDelivered)*l.PriceActual) AS TotalLines
FROM C_Order o
  INNER JOIN C_OrderLine l ON (o.C_Order_ID=l.C_Order_ID)
WHERE	(o.DocStatus = 'CO' AND o.IsDelivered='N')  --  Status must be CO - not CL/RE
	--	not Offers and open Walkin-Receipts
	AND o.C_DocType_ID IN (SELECT C_DocType_ID FROM C_DocType
		WHERE DocBaseType='SOO' AND DocSubTypeSO NOT IN ('ON','OB','WR'))
    --  Delivery Rule - not manual
    AND o.DeliveryRule<>'M'
    AND (l.M_Product_ID IS NULL OR EXISTS 
        (SELECT * FROM M_Product p 
        WHERE l.M_Product_ID=p.M_Product_ID AND p.IsExcludeAutoDelivery='N'))
	--	we need to ship
	AND	l.QtyOrdered <> l.QtyDelivered
    AND (l.M_Product_ID IS NOT NULL OR l.C_Charge_ID IS NOT NULL)
    --  Not confirmed shipment
    AND NOT EXISTS (SELECT * FROM M_InOutLine iol 
        INNER JOIN M_InOut io ON (iol.M_InOut_ID=io.M_InOut_ID)
        WHERE iol.C_OrderLine_ID=l.C_OrderLine_ID AND io.DocStatus IN ('DR','IN','IP','WC'))
	--
GROUP BY o.AD_Client_ID, o.AD_Org_ID, o.C_BPartner_ID, o.C_Order_ID,
	o.DocumentNo, o.DateOrdered, o.C_DocType_ID,
    o.POReference, o.Description, o.SalesRep_ID, l.M_Warehouse_ID;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Element SET Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.',Updated=TO_DATE('2021-11-16 15:13:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2466
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Column SET ColumnName='IsDropShip', Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', Placeholder=NULL WHERE AD_Element_ID=2466
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Process_Para SET ColumnName='IsDropShip', Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', AD_Element_ID=2466 WHERE UPPER(ColumnName)='ISDROPSHIP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Process_Para SET ColumnName='IsDropShip', Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', Placeholder=NULL WHERE AD_Element_ID=2466 AND IsCentrallyMaintained='Y'
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_InfoColumn SET ColumnName='IsDropShip', Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', Placeholder=NULL WHERE AD_Element_ID=2466 AND IsCentrallyMaintained='Y'
;

-- Nov 16, 2021, 3:13:12 PM CET
UPDATE AD_Field SET Name='Drop Shipment', Description='Drop Shipments are sent directly to the Drop Shipment Location', Help='Drop Shipments are sent directly to the Drop Shipment Location using the Drop Ship Business Partner name and contact.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2466) AND IsCentrallyMaintained='Y'
;

-- Nov 16, 2021, 3:51:54 PM CET
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-16 15:51:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10124
;

SELECT register_migration_script('202111161449_IDEMPIERE-2620.sql') FROM dual
;

