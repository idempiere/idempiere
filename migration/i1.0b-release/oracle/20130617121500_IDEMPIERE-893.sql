-- Jun 14, 2013 6:22:47 PM COT
-- IDEMPIERE-893 Use AD_InfoWindow_Access instead of DPViews for access to info windows
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N & @#UIClient@=''swing''',Updated=TO_DATE('2013-06-14 18:22:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50176
;

-- Jun 14, 2013 6:22:57 PM COT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N & @#UIClient@=''swing''',Updated=TO_DATE('2013-06-14 18:22:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50170
;

-- Jun 14, 2013 6:23:06 PM COT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N & @#UIClient@=''swing''',Updated=TO_DATE('2013-06-14 18:23:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50169
;

-- Jun 14, 2013 6:23:17 PM COT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N & @#UIClient@=''swing''',Updated=TO_DATE('2013-06-14 18:23:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50172
;

-- Jun 14, 2013 6:23:27 PM COT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N & @#UIClient@=''swing''',Updated=TO_DATE('2013-06-14 18:23:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50173
;

-- Jun 14, 2013 6:23:37 PM COT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N & @#UIClient@=''swing''',Updated=TO_DATE('2013-06-14 18:23:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50174
;

-- Jun 14, 2013 6:23:50 PM COT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N & @#UIClient@=''swing''',Updated=TO_DATE('2013-06-14 18:23:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50175
;

-- Jun 14, 2013 6:24:04 PM COT
UPDATE AD_Field SET DisplayLogic='@IsMasterRole@=N & @#UIClient@=''swing''',Updated=TO_DATE('2013-06-14 18:24:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50177
;

-- Jun 17, 2013 6:34:24 PM COT
UPDATE AD_Field SET SeqNo=300, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2013-06-17 18:34:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50178
;

-- Jun 17, 2013 6:34:24 PM COT
UPDATE AD_Field SET SeqNo=310, AD_FieldGroup_ID=50000, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-06-17 18:34:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50176
;

-- Jun 17, 2013 6:34:24 PM COT
UPDATE AD_Field SET SeqNo=320, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2013-06-17 18:34:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50170
;

-- Jun 17, 2013 6:34:24 PM COT
UPDATE AD_Field SET SeqNo=330, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-06-17 18:34:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50174
;

-- Jun 17, 2013 6:34:25 PM COT
UPDATE AD_Field SET SeqNo=350, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-06-17 18:34:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50172
;

-- Jun 17, 2013 6:34:25 PM COT
UPDATE AD_Field SET SeqNo=370, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-06-17 18:34:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50169
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

SELECT register_migration_script('20130617121500_IDEMPIERE-893.sql') FROM dual
;

