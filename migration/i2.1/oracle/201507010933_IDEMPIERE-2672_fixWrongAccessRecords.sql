update ad_document_action_access set ad_client_id=(select ad_client_id from ad_role where ad_role.ad_role_id=ad_document_action_access.ad_role_id)
where ad_client_id<>(select ad_client_id from ad_role where ad_role.ad_role_id=ad_document_action_access.ad_role_id)
;

update ad_form_access set ad_client_id=(select ad_client_id from ad_role where ad_role.ad_role_id=ad_form_access.ad_role_id)
where ad_client_id<>(select ad_client_id from ad_role where ad_role.ad_role_id=ad_form_access.ad_role_id)
;

update ad_infowindow_access set ad_client_id=(select ad_client_id from ad_role where ad_role.ad_role_id=ad_infowindow_access.ad_role_id)
where ad_client_id<>(select ad_client_id from ad_role where ad_role.ad_role_id=ad_infowindow_access.ad_role_id)
;

update ad_process_access set ad_client_id=(select ad_client_id from ad_role where ad_role.ad_role_id=ad_process_access.ad_role_id)
where ad_client_id<>(select ad_client_id from ad_role where ad_role.ad_role_id=ad_process_access.ad_role_id)
;

update ad_task_access set ad_client_id=(select ad_client_id from ad_role where ad_role.ad_role_id=ad_task_access.ad_role_id)
where ad_client_id<>(select ad_client_id from ad_role where ad_role.ad_role_id=ad_task_access.ad_role_id)
;

update ad_window_access set ad_client_id=(select ad_client_id from ad_role where ad_role.ad_role_id=ad_window_access.ad_role_id)
where ad_client_id<>(select ad_client_id from ad_role where ad_role.ad_role_id=ad_window_access.ad_role_id)
;

update ad_workflow_access set ad_client_id=(select ad_client_id from ad_role where ad_role.ad_role_id=ad_workflow_access.ad_role_id)
where ad_client_id<>(select ad_client_id from ad_role where ad_role.ad_role_id=ad_workflow_access.ad_role_id)
;

SELECT register_migration_script('201507010933_IDEMPIERE-2672_fixWrongAccessRecords.sql') FROM dual
;

