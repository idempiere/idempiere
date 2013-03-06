CREATE OR REPLACE VIEW RV_T_1099Extract AS 
 SELECT t.ad_pinstance_id, t.ad_client_id, t.ad_org_id, t.isactive, t.created, t.createdby, t.updated, t.updatedby, 
 t.c_bpartner_id, t.value, t.name, t.taxid, l.address1 || ' ' || l.address2 || ' ' || l.address3 || ' ' || l.address4 AS address, 
 l.address1, l.address2, l.address3, l.address4, l.city || ', ' || r.name || ' ' || l.postal AS citystatezip, 
 l.city, r.name AS region, l.postal AS zip, ctry.name AS country, t.cut_year, t.cut_date, 
 COALESCE(t.amtbucket01, 0) AS amtbucket01, COALESCE(t.amtbucket02, 0) AS amtbucket02, COALESCE(t.amtbucket03, 0) AS amtbucket03, 
 COALESCE(t.amtbucket04, 0) AS amtbucket04, COALESCE(t.amtbucket05, 0) AS amtbucket05, COALESCE(t.amtbucket06, 0) AS amtbucket06, 
 COALESCE(t.amtbucket07, 0) AS amtbucket07, COALESCE(t.amtbucket08, 0) AS amtbucket08, COALESCE(t.amtbucket09, 0) AS amtbucket09, 
 COALESCE(t.amtbucket10, 0) AS amtbucket10, COALESCE(t.amtbucket11, 0) AS amtbucket11, COALESCE(t.amtbucket12, 0) AS amtbucket12, 
 COALESCE(t.amtbucket13, 0) AS amtbucket13, COALESCE(t.amtbucket14, 0) AS amtbucket14, COALESCE(t.amtbucket15, 0) AS amtbucket15, 
 COALESCE(t.amtbucket16, 0) AS amtbucket16
   FROM t_1099extract t
   LEFT JOIN c_location l ON t.c_location_id = l.c_location_id
   LEFT JOIN c_region r ON r.c_region_id = l.c_region_id
   LEFT JOIN c_country ctry ON ctry.c_country_id = l.c_country_id
  WHERE t.ad_pinstance_id = (SELECT max(t_1099extract.ad_pinstance_id) AS max
   FROM t_1099extract)
;
