CREATE OR REPLACE VIEW x_packagelineweight AS 
 SELECT pl.ad_client_id, pl.m_package_id, pl.qty, pl.m_inoutline_id, iol.m_inout_id, iol.m_product_id, p.weight, pl.qty * p.weight AS lineweight, pl.m_packagemps_id
   FROM m_packageline pl
   JOIN m_inoutline iol ON pl.m_inoutline_id = iol.m_inoutline_id
   JOIN m_product p ON iol.m_product_id = p.m_product_id
;
