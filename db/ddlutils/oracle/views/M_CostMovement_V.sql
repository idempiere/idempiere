CREATE OR REPLACE VIEW m_costmovement_v AS 
SELECT a.ad_client_id, a.ad_org_id, b.c_acctschema_id, a.m_costhistory_id, a.m_costtype_id, a.m_costelement_id, a.m_attributesetinstance_id, 
   b.m_product_id, a.oldqty, a.newqty, a.oldcostprice, a.newcostprice, a.oldcqty, a.newcqty, a.oldcamt, a.newcamt, b.qty, b.amt, b.deltaqty, 
   b.deltaamt, b.c_orderline_id, b.m_inoutline_id, b.c_invoiceline_id, b.m_movementline_id, b.m_inventoryline_id, b.m_productionline_id, 
   b.c_projectissue_id, b.m_matchinv_id, a.m_costdetail_id, b.description, a.created, a.createdby, a.updated, a.updatedby, a.isactive
   FROM m_costhistory a
   JOIN m_costdetail b ON a.m_costdetail_id = b.m_costdetail_id
   ORDER BY a.m_costhistory_id
;

