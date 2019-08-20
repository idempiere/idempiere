DELETE FROM AD_InfoWindow_Access WHERE ad_infowindow_id IN (SELECT ad_infowindow_id FROM ad_infowindow iw JOIN ad_table t ON (iw.ad_table_id=t.ad_table_id) WHERE t.AccessLevel='4') AND ad_role_id IN (SELECT ad_role_id FROM ad_role WHERE ismanual='N' AND isactive='Y' AND userlevel!='S  ');

DELETE FROM AD_InfoWindow_Access WHERE ad_infowindow_id IN (SELECT ad_infowindow_id FROM ad_infowindow iw JOIN ad_table t ON (iw.ad_table_id=t.ad_table_id) WHERE t.AccessLevel IN ('1','2','3')) AND ad_role_id IN (SELECT ad_role_id FROM ad_role WHERE ismanual='N' AND isactive='Y' AND userlevel='S  ');

SELECT register_migration_script('201908201457_IDEMPIERE-3936.sql') FROM dual
;

