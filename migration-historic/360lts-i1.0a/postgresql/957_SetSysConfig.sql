update ad_sysconfig set value='N' where ad_sysconfig_id=50041 /* 'ALogin_ShowOneRole' */
;

update ad_sysconfig set value='N' where ad_sysconfig_id=200019 /* 'LOGIN_SHOW_RESETPASSWORD' */
;

update ad_sysconfig set value='HTML' where ad_sysconfig_id=200003 /* ZK_REPORT_TABLE_OUTPUT_TYPE */
;

UPDATE R_RequestProcessor SET IsActive='N' WHERE R_RequestProcessor_ID=100
;

update ad_field set isdisplayedgrid='N' where ad_column_id in (select ad_column_id from ad_column where ad_element_id=102) /* ad_client_id */
and ad_column_id not in (315, 904, 12629) /* except client window */
and ad_field_id < 1000000
;

update ad_field set isdisplayed='N', isdisplayedgrid='N'
where ad_field_id in (
200508,
200510,
200280,
200504,
200505,
200605,
200638)
;

update ad_field set isdisplayedgrid='N'
where isdisplayedgrid='Y' and isdisplayed='N'
and ad_field_id < 1000000
;

SELECT register_migration_script('957_SetSysConfig.sql') FROM dual
;

