INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_ID, AD_Role_ID, AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy)
SELECT i.AD_InfoWindow_ID, r.ad_role_id, r.ad_client_id, r.ad_org_id, 'Y', statement_timestamp(), 0, statement_timestamp(), 0 
FROM AD_InfoWindow i
JOIN AD_Role r ON (r.isactive='Y')
LEFT JOIN AD_InfoWindow_Access ia ON (ia.AD_Role_ID=r.ad_role_id AND i.AD_InfoWindow_ID = ia.AD_InfoWindow_ID)
WHERE ia.AD_InfoWindow_ID IS NULL
;

update ad_infowindow_access set isactive='N'
where ad_role_id in (select ad_role_id from ad_role where allow_info_asset='N')
and ad_infowindow_id in (select ad_infowindow_id from ad_infowindow where ad_table_id=(select ad_table_id from ad_table where tablename='A_Asset'))
;

update ad_infowindow_access set isactive='N'
where ad_role_id in (select ad_role_id from ad_role where allow_info_bpartner='N')
and ad_infowindow_id in (select ad_infowindow_id from ad_infowindow where ad_table_id=(select ad_table_id from ad_table where tablename='C_BPartner'))
;

update ad_infowindow_access set isactive='N'
where ad_role_id in (select ad_role_id from ad_role where allow_info_inout='N')
and ad_infowindow_id in (select ad_infowindow_id from ad_infowindow where ad_table_id=(select ad_table_id from ad_table where tablename='M_InOut'))
;

update ad_infowindow_access set isactive='N'
where ad_role_id in (select ad_role_id from ad_role where allow_info_invoice='N')
and ad_infowindow_id in (select ad_infowindow_id from ad_infowindow where ad_table_id=(select ad_table_id from ad_table where tablename='C_Invoice'))
;

update ad_infowindow_access set isactive='N'
where ad_role_id in (select ad_role_id from ad_role where allow_info_order='N')
and ad_infowindow_id in (select ad_infowindow_id from ad_infowindow where ad_table_id=(select ad_table_id from ad_table where tablename='C_Order'))
;

update ad_infowindow_access set isactive='N'
where ad_role_id in (select ad_role_id from ad_role where allow_info_payment='N')
and ad_infowindow_id in (select ad_infowindow_id from ad_infowindow where ad_table_id=(select ad_table_id from ad_table where tablename='C_Payment'))
;

update ad_infowindow_access set isactive='N'
where ad_role_id in (select ad_role_id from ad_role where allow_info_product='N')
and ad_infowindow_id in (select ad_infowindow_id from ad_infowindow where ad_table_id=(select ad_table_id from ad_table where tablename='M_Product'))
;

update ad_infowindow_access set isactive='N'
where ad_role_id in (select ad_role_id from ad_role where allow_info_resource='N')
and ad_infowindow_id in (select ad_infowindow_id from ad_infowindow where ad_table_id=(select ad_table_id from ad_table where tablename='S_ResourceAssignment'))
;

SELECT register_migration_script('201306182217_IDEMPIERE-893.sql') FROM dual
;

