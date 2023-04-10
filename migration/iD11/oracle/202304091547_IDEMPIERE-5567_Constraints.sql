-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195) -- Add unique constraint in all _UU columns
SELECT register_migration_script('202304091547_IDEMPIERE-5567_Constraints.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

DROP INDEX a_asset_uu_idx
;

ALTER TABLE a_asset ADD CONSTRAINT a_asset_uu_idx UNIQUE (a_asset_uu)
;

DROP INDEX a_asset_acct_uu_idx
;

ALTER TABLE a_asset_acct ADD CONSTRAINT a_asset_acct_uu_idx UNIQUE (a_asset_acct_uu)
;

DROP INDEX a_asset_addition_uu_idx
;

ALTER TABLE a_asset_addition ADD CONSTRAINT a_asset_addition_uu_idx UNIQUE (a_asset_addition_uu)
;

DROP INDEX a_asset_change_uu_idx
;

ALTER TABLE a_asset_change ADD CONSTRAINT a_asset_change_uu_idx UNIQUE (a_asset_change_uu)
;

DROP INDEX a_asset_class_uu_idx
;

ALTER TABLE a_asset_class ADD CONSTRAINT a_asset_class_uu_idx UNIQUE (a_asset_class_uu)
;

DROP INDEX a_asset_delivery_uu_idx
;

ALTER TABLE a_asset_delivery ADD CONSTRAINT a_asset_delivery_uu_idx UNIQUE (a_asset_delivery_uu)
;

DROP INDEX a_asset_disposed_uu_idx
;

ALTER TABLE a_asset_disposed ADD CONSTRAINT a_asset_disposed_uu_idx UNIQUE (a_asset_disposed_uu)
;

DROP INDEX a_asset_group_uu_idx
;

ALTER TABLE a_asset_group ADD CONSTRAINT a_asset_group_uu_idx UNIQUE (a_asset_group_uu)
;

DROP INDEX a_asset_group_acct_uu_idx
;

ALTER TABLE a_asset_group_acct ADD CONSTRAINT a_asset_group_acct_uu_idx UNIQUE (a_asset_group_acct_uu)
;

DROP INDEX a_asset_info_fin_uu_idx
;

ALTER TABLE a_asset_info_fin ADD CONSTRAINT a_asset_info_fin_uu_idx UNIQUE (a_asset_info_fin_uu)
;

DROP INDEX a_asset_info_ins_uu_idx
;

ALTER TABLE a_asset_info_ins ADD CONSTRAINT a_asset_info_ins_uu_idx UNIQUE (a_asset_info_ins_uu)
;

DROP INDEX a_asset_info_lic_uu_idx
;

ALTER TABLE a_asset_info_lic ADD CONSTRAINT a_asset_info_lic_uu_idx UNIQUE (a_asset_info_lic_uu)
;

DROP INDEX a_asset_info_oth_uu_idx
;

ALTER TABLE a_asset_info_oth ADD CONSTRAINT a_asset_info_oth_uu_idx UNIQUE (a_asset_info_oth_uu)
;

DROP INDEX a_asset_info_tax_uu_idx
;

ALTER TABLE a_asset_info_tax ADD CONSTRAINT a_asset_info_tax_uu_idx UNIQUE (a_asset_info_tax_uu)
;

DROP INDEX a_asset_product_uu_idx
;

ALTER TABLE a_asset_product ADD CONSTRAINT a_asset_product_uu_idx UNIQUE (a_asset_product_uu)
;

DROP INDEX a_asset_retirement_uu_idx
;

ALTER TABLE a_asset_retirement ADD CONSTRAINT a_asset_retirement_uu_idx UNIQUE (a_asset_retirement_uu)
;

DROP INDEX a_asset_reval_uu_idx
;

ALTER TABLE a_asset_reval ADD CONSTRAINT a_asset_reval_uu_idx UNIQUE (a_asset_reval_uu)
;

DROP INDEX a_asset_reval_entry_uu_idx
;

ALTER TABLE a_asset_reval_entry ADD CONSTRAINT a_asset_reval_entry_uu_idx UNIQUE (a_asset_reval_entry_uu)
;

DROP INDEX a_asset_reval_index_uu_idx
;

ALTER TABLE a_asset_reval_index ADD CONSTRAINT a_asset_reval_index_uu_idx UNIQUE (a_asset_reval_index_uu)
;

DROP INDEX a_asset_split_uu_idx
;

ALTER TABLE a_asset_split ADD CONSTRAINT a_asset_split_uu_idx UNIQUE (a_asset_split_uu)
;

DROP INDEX a_asset_spread_uu_idx
;

ALTER TABLE a_asset_spread ADD CONSTRAINT a_asset_spread_uu_idx UNIQUE (a_asset_spread_uu)
;

DROP INDEX a_asset_transfer_uu_idx
;

ALTER TABLE a_asset_transfer ADD CONSTRAINT a_asset_transfer_uu_idx UNIQUE (a_asset_transfer_uu)
;

DROP INDEX a_asset_type_uu_idx
;

ALTER TABLE a_asset_type ADD CONSTRAINT a_asset_type_uu_idx UNIQUE (a_asset_type_uu)
;

DROP INDEX a_asset_use_uu_idx
;

ALTER TABLE a_asset_use ADD CONSTRAINT a_asset_use_uu_idx UNIQUE (a_asset_use_uu)
;

DROP INDEX a_depreciation_uu_idx
;

ALTER TABLE a_depreciation ADD CONSTRAINT a_depreciation_uu_idx UNIQUE (a_depreciation_uu)
;

DROP INDEX a_depreciation_build_uu_idx
;

ALTER TABLE a_depreciation_build ADD CONSTRAINT a_depreciation_build_uu_idx UNIQUE (a_depreciation_build_uu)
;

DROP INDEX a_depreciation_conventi_uu_idx
;

ALTER TABLE a_depreciation_convention ADD CONSTRAINT a_depreciation_conventi_uu_idx UNIQUE (a_depreciation_convention_uu)
;

DROP INDEX a_depreciation_entry_uu_idx
;

ALTER TABLE a_depreciation_entry ADD CONSTRAINT a_depreciation_entry_uu_idx UNIQUE (a_depreciation_entry_uu)
;

DROP INDEX a_depreciation_exp_uu_idx
;

ALTER TABLE a_depreciation_exp ADD CONSTRAINT a_depreciation_exp_uu_idx UNIQUE (a_depreciation_exp_uu)
;

DROP INDEX a_depreciation_forecast_uu_idx
;

ALTER TABLE a_depreciation_forecast ADD CONSTRAINT a_depreciation_forecast_uu_idx UNIQUE (a_depreciation_forecast_uu)
;

DROP INDEX a_depreciation_method_uu_idx
;

ALTER TABLE a_depreciation_method ADD CONSTRAINT a_depreciation_method_uu_idx UNIQUE (a_depreciation_method_uu)
;

DROP INDEX a_depreciation_table_de_uu_idx
;

ALTER TABLE a_depreciation_table_detail ADD CONSTRAINT a_depreciation_table_de_uu_idx UNIQUE (a_depreciation_table_detail_uu)
;

DROP INDEX a_depreciation_table_he_uu_idx
;

ALTER TABLE a_depreciation_table_header ADD CONSTRAINT a_depreciation_table_he_uu_idx UNIQUE (a_depreciation_table_header_uu)
;

DROP INDEX a_depreciation_workfile_uu_idx
;

ALTER TABLE a_depreciation_workfile ADD CONSTRAINT a_depreciation_workfile_uu_idx UNIQUE (a_depreciation_workfile_uu)
;

DROP INDEX a_fundingmode_uu_idx
;

ALTER TABLE a_fundingmode ADD CONSTRAINT a_fundingmode_uu_idx UNIQUE (a_fundingmode_uu)
;

DROP INDEX a_fundingmode_acct_uu_idx
;

ALTER TABLE a_fundingmode_acct ADD CONSTRAINT a_fundingmode_acct_uu_idx UNIQUE (a_fundingmode_acct_uu)
;

DROP INDEX a_registration_uu_idx
;

ALTER TABLE a_registration ADD CONSTRAINT a_registration_uu_idx UNIQUE (a_registration_uu)
;

DROP INDEX a_registrationattribute_uu_idx
;

ALTER TABLE a_registrationattribute ADD CONSTRAINT a_registrationattribute_uu_idx UNIQUE (a_registrationattribute_uu)
;

DROP INDEX a_registrationproduct_uu_idx
;

ALTER TABLE a_registrationproduct ADD CONSTRAINT a_registrationproduct_uu_idx UNIQUE (a_registrationproduct_uu)
;

DROP INDEX a_registrationvalue_uu_idx
;

ALTER TABLE a_registrationvalue ADD CONSTRAINT a_registrationvalue_uu_idx UNIQUE (a_registrationvalue_uu)
;

DROP INDEX ad_accesslog_uu_idx
;

ALTER TABLE ad_accesslog ADD CONSTRAINT ad_accesslog_uu_idx UNIQUE (ad_accesslog_uu)
;

DROP INDEX ad_alert_uu_idx
;

ALTER TABLE ad_alert ADD CONSTRAINT ad_alert_uu_idx UNIQUE (ad_alert_uu)
;

DROP INDEX ad_alertprocessor_uu_idx
;

ALTER TABLE ad_alertprocessor ADD CONSTRAINT ad_alertprocessor_uu_idx UNIQUE (ad_alertprocessor_uu)
;

DROP INDEX ad_alertprocessorlog_uu_idx
;

ALTER TABLE ad_alertprocessorlog ADD CONSTRAINT ad_alertprocessorlog_uu_idx UNIQUE (ad_alertprocessorlog_uu)
;

DROP INDEX ad_alertrecipient_uu_idx
;

ALTER TABLE ad_alertrecipient ADD CONSTRAINT ad_alertrecipient_uu_idx UNIQUE (ad_alertrecipient_uu)
;

DROP INDEX ad_alertrule_uu_idx
;

ALTER TABLE ad_alertrule ADD CONSTRAINT ad_alertrule_uu_idx UNIQUE (ad_alertrule_uu)
;

DROP INDEX ad_archive_uu_idx
;

ALTER TABLE ad_archive ADD CONSTRAINT ad_archive_uu_idx UNIQUE (ad_archive_uu)
;

DROP INDEX ad_attachment_uu_idx
;

ALTER TABLE ad_attachment ADD CONSTRAINT ad_attachment_uu_idx UNIQUE (ad_attachment_uu)
;

DROP INDEX ad_attachmentnote_uu_idx
;

ALTER TABLE ad_attachmentnote ADD CONSTRAINT ad_attachmentnote_uu_idx UNIQUE (ad_attachmentnote_uu)
;

DROP INDEX ad_attribute_uu_idx
;

ALTER TABLE ad_attribute ADD CONSTRAINT ad_attribute_uu_idx UNIQUE (ad_attribute_uu)
;

DROP INDEX ad_attribute_value_uu_idx
;

ALTER TABLE ad_attribute_value ADD CONSTRAINT ad_attribute_value_uu_idx UNIQUE (ad_attribute_value_uu)
;

DROP INDEX ad_broadcastmessage_uu_idx
;

ALTER TABLE ad_broadcastmessage ADD CONSTRAINT ad_broadcastmessage_uu_idx UNIQUE (ad_broadcastmessage_uu)
;

DROP INDEX ad_changelog_uu_idx
;

ALTER TABLE ad_changelog ADD CONSTRAINT ad_changelog_uu_idx UNIQUE (ad_changelog_uu)
;

DROP INDEX ad_client_uu_idx
;

ALTER TABLE ad_client ADD CONSTRAINT ad_client_uu_idx UNIQUE (ad_client_uu)
;

DROP INDEX ad_clientinfo_uu_idx
;

ALTER TABLE ad_clientinfo ADD CONSTRAINT ad_clientinfo_uu_idx UNIQUE (ad_clientinfo_uu)
;

DROP INDEX ad_clientshare_uu_idx
;

ALTER TABLE ad_clientshare ADD CONSTRAINT ad_clientshare_uu_idx UNIQUE (ad_clientshare_uu)
;

DROP INDEX ad_color_uu_idx
;

ALTER TABLE ad_color ADD CONSTRAINT ad_color_uu_idx UNIQUE (ad_color_uu)
;

DROP INDEX ad_column_uu_idx
;

ALTER TABLE ad_column ADD CONSTRAINT ad_column_uu_idx UNIQUE (ad_column_uu)
;

DROP INDEX ad_column_access_uu_idx
;

ALTER TABLE ad_column_access ADD CONSTRAINT ad_column_access_uu_idx UNIQUE (ad_column_access_uu)
;

DROP INDEX ad_column_trl_uu_idx
;

ALTER TABLE ad_column_trl ADD CONSTRAINT ad_column_trl_uu_idx UNIQUE (ad_column_trl_uu)
;

DROP INDEX ad_ctxhelp_uu_idx
;

ALTER TABLE ad_ctxhelp ADD CONSTRAINT ad_ctxhelp_uu_idx UNIQUE (ad_ctxhelp_uu)
;

DROP INDEX ad_ctxhelpmsg_uu_idx
;

ALTER TABLE ad_ctxhelpmsg ADD CONSTRAINT ad_ctxhelpmsg_uu_idx UNIQUE (ad_ctxhelpmsg_uu)
;

DROP INDEX ad_ctxhelpmsg_trl_uu_idx
;

ALTER TABLE ad_ctxhelpmsg_trl ADD CONSTRAINT ad_ctxhelpmsg_trl_uu_idx UNIQUE (ad_ctxhelpmsg_trl_uu)
;

DROP INDEX ad_desktop_uu_idx
;

ALTER TABLE ad_desktop ADD CONSTRAINT ad_desktop_uu_idx UNIQUE (ad_desktop_uu)
;

DROP INDEX ad_desktop_trl_uu_idx
;

ALTER TABLE ad_desktop_trl ADD CONSTRAINT ad_desktop_trl_uu_idx UNIQUE (ad_desktop_trl_uu)
;

DROP INDEX ad_desktopworkbench_uu_idx
;

ALTER TABLE ad_desktopworkbench ADD CONSTRAINT ad_desktopworkbench_uu_idx UNIQUE (ad_desktopworkbench_uu)
;

DROP INDEX ad_document_action_acce_uu_idx
;

ALTER TABLE ad_document_action_access ADD CONSTRAINT ad_document_action_acce_uu_idx UNIQUE (ad_document_action_access_uu)
;

DROP INDEX ad_element_uu_idx
;

ALTER TABLE ad_element ADD CONSTRAINT ad_element_uu_idx UNIQUE (ad_element_uu)
;

DROP INDEX ad_element_trl_uu_idx
;

ALTER TABLE ad_element_trl ADD CONSTRAINT ad_element_trl_uu_idx UNIQUE (ad_element_trl_uu)
;

DROP INDEX ad_entitytype_uu_idx
;

ALTER TABLE ad_entitytype ADD CONSTRAINT ad_entitytype_uu_idx UNIQUE (ad_entitytype_uu)
;

DROP INDEX ad_error_uu_idx
;

ALTER TABLE ad_error ADD CONSTRAINT ad_error_uu_idx UNIQUE (ad_error_uu)
;

DROP INDEX ad_field_uu_idx
;

ALTER TABLE ad_field ADD CONSTRAINT ad_field_uu_idx UNIQUE (ad_field_uu)
;

DROP INDEX ad_field_trl_uu_idx
;

ALTER TABLE ad_field_trl ADD CONSTRAINT ad_field_trl_uu_idx UNIQUE (ad_field_trl_uu)
;

DROP INDEX ad_fieldgroup_uu_idx
;

ALTER TABLE ad_fieldgroup ADD CONSTRAINT ad_fieldgroup_uu_idx UNIQUE (ad_fieldgroup_uu)
;

DROP INDEX ad_fieldgroup_trl_uu_idx
;

ALTER TABLE ad_fieldgroup_trl ADD CONSTRAINT ad_fieldgroup_trl_uu_idx UNIQUE (ad_fieldgroup_trl_uu)
;

DROP INDEX ad_find_uu_idx
;

ALTER TABLE ad_find ADD CONSTRAINT ad_find_uu_idx UNIQUE (ad_find_uu)
;

DROP INDEX ad_form_uu_idx
;

ALTER TABLE ad_form ADD CONSTRAINT ad_form_uu_idx UNIQUE (ad_form_uu)
;

DROP INDEX ad_form_access_uu_idx
;

ALTER TABLE ad_form_access ADD CONSTRAINT ad_form_access_uu_idx UNIQUE (ad_form_access_uu)
;

DROP INDEX ad_form_trl_uu_idx
;

ALTER TABLE ad_form_trl ADD CONSTRAINT ad_form_trl_uu_idx UNIQUE (ad_form_trl_uu)
;

DROP INDEX ad_housekeeping_uu_idx
;

ALTER TABLE ad_housekeeping ADD CONSTRAINT ad_housekeeping_uu_idx UNIQUE (ad_housekeeping_uu)
;

DROP INDEX ad_image_uu_idx
;

ALTER TABLE ad_image ADD CONSTRAINT ad_image_uu_idx UNIQUE (ad_image_uu)
;

DROP INDEX ad_impformat_uu_idx
;

ALTER TABLE ad_impformat ADD CONSTRAINT ad_impformat_uu_idx UNIQUE (ad_impformat_uu)
;

DROP INDEX ad_impformat_row_uu_idx
;

ALTER TABLE ad_impformat_row ADD CONSTRAINT ad_impformat_row_uu_idx UNIQUE (ad_impformat_row_uu)
;

DROP INDEX ad_infocolumn_uu_idx
;

ALTER TABLE ad_infocolumn ADD CONSTRAINT ad_infocolumn_uu_idx UNIQUE (ad_infocolumn_uu)
;

DROP INDEX ad_infocolumn_trl_uu_idx
;

ALTER TABLE ad_infocolumn_trl ADD CONSTRAINT ad_infocolumn_trl_uu_idx UNIQUE (ad_infocolumn_trl_uu)
;

DROP INDEX ad_infowindow_uu_idx
;

ALTER TABLE ad_infowindow ADD CONSTRAINT ad_infowindow_uu_idx UNIQUE (ad_infowindow_uu)
;

DROP INDEX ad_infowindow_access_uu_idx
;

ALTER TABLE ad_infowindow_access ADD CONSTRAINT ad_infowindow_access_uu_idx UNIQUE (ad_infowindow_access_uu)
;

DROP INDEX ad_infowindow_trl_uu_idx
;

ALTER TABLE ad_infowindow_trl ADD CONSTRAINT ad_infowindow_trl_uu_idx UNIQUE (ad_infowindow_trl_uu)
;

DROP INDEX ad_issue_uu_idx
;

ALTER TABLE ad_issue ADD CONSTRAINT ad_issue_uu_idx UNIQUE (ad_issue_uu)
;

DROP INDEX ad_labelprinter_uu_idx
;

ALTER TABLE ad_labelprinter ADD CONSTRAINT ad_labelprinter_uu_idx UNIQUE (ad_labelprinter_uu)
;

DROP INDEX ad_labelprinterfunction_uu_idx
;

ALTER TABLE ad_labelprinterfunction ADD CONSTRAINT ad_labelprinterfunction_uu_idx UNIQUE (ad_labelprinterfunction_uu)
;

DROP INDEX ad_language_uu_idx
;

ALTER TABLE ad_language ADD CONSTRAINT ad_language_uu_idx UNIQUE (ad_language_uu)
;

DROP INDEX ad_ldapaccess_uu_idx
;

ALTER TABLE ad_ldapaccess ADD CONSTRAINT ad_ldapaccess_uu_idx UNIQUE (ad_ldapaccess_uu)
;

DROP INDEX ad_ldapprocessor_uu_idx
;

ALTER TABLE ad_ldapprocessor ADD CONSTRAINT ad_ldapprocessor_uu_idx UNIQUE (ad_ldapprocessor_uu)
;

DROP INDEX ad_ldapprocessorlog_uu_idx
;

ALTER TABLE ad_ldapprocessorlog ADD CONSTRAINT ad_ldapprocessorlog_uu_idx UNIQUE (ad_ldapprocessorlog_uu)
;

DROP INDEX ad_menu_uu_idx
;

ALTER TABLE ad_menu ADD CONSTRAINT ad_menu_uu_idx UNIQUE (ad_menu_uu)
;

DROP INDEX ad_menu_trl_uu_idx
;

ALTER TABLE ad_menu_trl ADD CONSTRAINT ad_menu_trl_uu_idx UNIQUE (ad_menu_trl_uu)
;

DROP INDEX ad_message_uu_idx
;

ALTER TABLE ad_message ADD CONSTRAINT ad_message_uu_idx UNIQUE (ad_message_uu)
;

DROP INDEX ad_message_trl_uu_idx
;

ALTER TABLE ad_message_trl ADD CONSTRAINT ad_message_trl_uu_idx UNIQUE (ad_message_trl_uu)
;

DROP INDEX ad_migrationscript_uu_idx
;

ALTER TABLE ad_migrationscript ADD CONSTRAINT ad_migrationscript_uu_idx UNIQUE (ad_migrationscript_uu)
;

DROP INDEX ad_modelvalidator_uu_idx
;

ALTER TABLE ad_modelvalidator ADD CONSTRAINT ad_modelvalidator_uu_idx UNIQUE (ad_modelvalidator_uu)
;

DROP INDEX ad_modification_uu_idx
;

ALTER TABLE ad_modification ADD CONSTRAINT ad_modification_uu_idx UNIQUE (ad_modification_uu)
;

DROP INDEX ad_note_uu_idx
;

ALTER TABLE ad_note ADD CONSTRAINT ad_note_uu_idx UNIQUE (ad_note_uu)
;

DROP INDEX ad_org_uu_idx
;

ALTER TABLE ad_org ADD CONSTRAINT ad_org_uu_idx UNIQUE (ad_org_uu)
;

DROP INDEX ad_orginfo_uu_idx
;

ALTER TABLE ad_orginfo ADD CONSTRAINT ad_orginfo_uu_idx UNIQUE (ad_orginfo_uu)
;

DROP INDEX ad_orgtype_uu_idx
;

ALTER TABLE ad_orgtype ADD CONSTRAINT ad_orgtype_uu_idx UNIQUE (ad_orgtype_uu)
;

DROP INDEX ad_package_exp_uu_idx
;

ALTER TABLE ad_package_exp ADD CONSTRAINT ad_package_exp_uu_idx UNIQUE (ad_package_exp_uu)
;

DROP INDEX ad_package_exp_common_uu_idx
;

ALTER TABLE ad_package_exp_common ADD CONSTRAINT ad_package_exp_common_uu_idx UNIQUE (ad_package_exp_common_uu)
;

DROP INDEX ad_package_exp_detail_uu_idx
;

ALTER TABLE ad_package_exp_detail ADD CONSTRAINT ad_package_exp_detail_uu_idx UNIQUE (ad_package_exp_detail_uu)
;

DROP INDEX ad_package_imp_uu_idx
;

ALTER TABLE ad_package_imp ADD CONSTRAINT ad_package_imp_uu_idx UNIQUE (ad_package_imp_uu)
;

DROP INDEX ad_package_imp_backup_uu_idx
;

ALTER TABLE ad_package_imp_backup ADD CONSTRAINT ad_package_imp_backup_uu_idx UNIQUE (ad_package_imp_backup_uu)
;

DROP INDEX ad_package_imp_detail_uu_idx
;

ALTER TABLE ad_package_imp_detail ADD CONSTRAINT ad_package_imp_detail_uu_idx UNIQUE (ad_package_imp_detail_uu)
;

DROP INDEX ad_package_imp_inst_uu_idx
;

ALTER TABLE ad_package_imp_inst ADD CONSTRAINT ad_package_imp_inst_uu_idx UNIQUE (ad_package_imp_inst_uu)
;

DROP INDEX ad_package_imp_proc_uu_idx
;

ALTER TABLE ad_package_imp_proc ADD CONSTRAINT ad_package_imp_proc_uu_idx UNIQUE (ad_package_imp_proc_uu)
;

DROP INDEX ad_passwordrule_uu_idx
;

ALTER TABLE ad_passwordrule ADD CONSTRAINT ad_passwordrule_uu_idx UNIQUE (ad_passwordrule_uu)
;

DROP INDEX ad_pinstance_uu_idx
;

ALTER TABLE ad_pinstance ADD CONSTRAINT ad_pinstance_uu_idx UNIQUE (ad_pinstance_uu)
;

DROP INDEX ad_pinstance_log_uu_idx
;

ALTER TABLE ad_pinstance_log ADD CONSTRAINT ad_pinstance_log_uu_idx UNIQUE (ad_pinstance_log_uu)
;

DROP INDEX ad_pinstance_para_uu_idx
;

ALTER TABLE ad_pinstance_para ADD CONSTRAINT ad_pinstance_para_uu_idx UNIQUE (ad_pinstance_para_uu)
;

DROP INDEX ad_preference_uu_idx
;

ALTER TABLE ad_preference ADD CONSTRAINT ad_preference_uu_idx UNIQUE (ad_preference_uu)
;

DROP INDEX ad_printcolor_uu_idx
;

ALTER TABLE ad_printcolor ADD CONSTRAINT ad_printcolor_uu_idx UNIQUE (ad_printcolor_uu)
;

DROP INDEX ad_printfont_uu_idx
;

ALTER TABLE ad_printfont ADD CONSTRAINT ad_printfont_uu_idx UNIQUE (ad_printfont_uu)
;

DROP INDEX ad_printform_uu_idx
;

ALTER TABLE ad_printform ADD CONSTRAINT ad_printform_uu_idx UNIQUE (ad_printform_uu)
;

DROP INDEX ad_printformat_uu_idx
;

ALTER TABLE ad_printformat ADD CONSTRAINT ad_printformat_uu_idx UNIQUE (ad_printformat_uu)
;

DROP INDEX ad_printformatitem_uu_idx
;

ALTER TABLE ad_printformatitem ADD CONSTRAINT ad_printformatitem_uu_idx UNIQUE (ad_printformatitem_uu)
;

DROP INDEX ad_printformatitem_trl_uu_idx
;

ALTER TABLE ad_printformatitem_trl ADD CONSTRAINT ad_printformatitem_trl_uu_idx UNIQUE (ad_printformatitem_trl_uu)
;

DROP INDEX ad_printgraph_uu_idx
;

ALTER TABLE ad_printgraph ADD CONSTRAINT ad_printgraph_uu_idx UNIQUE (ad_printgraph_uu)
;

DROP INDEX ad_printlabel_uu_idx
;

ALTER TABLE ad_printlabel ADD CONSTRAINT ad_printlabel_uu_idx UNIQUE (ad_printlabel_uu)
;

DROP INDEX ad_printlabelline_uu_idx
;

ALTER TABLE ad_printlabelline ADD CONSTRAINT ad_printlabelline_uu_idx UNIQUE (ad_printlabelline_uu)
;

DROP INDEX ad_printlabelline_trl_uu_idx
;

ALTER TABLE ad_printlabelline_trl ADD CONSTRAINT ad_printlabelline_trl_uu_idx UNIQUE (ad_printlabelline_trl_uu)
;

DROP INDEX ad_printpaper_uu_idx
;

ALTER TABLE ad_printpaper ADD CONSTRAINT ad_printpaper_uu_idx UNIQUE (ad_printpaper_uu)
;

DROP INDEX ad_printtableformat_uu_idx
;

ALTER TABLE ad_printtableformat ADD CONSTRAINT ad_printtableformat_uu_idx UNIQUE (ad_printtableformat_uu)
;

DROP INDEX ad_private_access_uu_idx
;

ALTER TABLE ad_private_access ADD CONSTRAINT ad_private_access_uu_idx UNIQUE (ad_private_access_uu)
;

DROP INDEX ad_process_uu_idx
;

ALTER TABLE ad_process ADD CONSTRAINT ad_process_uu_idx UNIQUE (ad_process_uu)
;

DROP INDEX ad_process_access_uu_idx
;

ALTER TABLE ad_process_access ADD CONSTRAINT ad_process_access_uu_idx UNIQUE (ad_process_access_uu)
;

DROP INDEX ad_process_para_uu_idx
;

ALTER TABLE ad_process_para ADD CONSTRAINT ad_process_para_uu_idx UNIQUE (ad_process_para_uu)
;

DROP INDEX ad_process_para_trl_uu_idx
;

ALTER TABLE ad_process_para_trl ADD CONSTRAINT ad_process_para_trl_uu_idx UNIQUE (ad_process_para_trl_uu)
;

DROP INDEX ad_process_trl_uu_idx
;

ALTER TABLE ad_process_trl ADD CONSTRAINT ad_process_trl_uu_idx UNIQUE (ad_process_trl_uu)
;

DROP INDEX ad_recentitem_uu_idx
;

ALTER TABLE ad_recentitem ADD CONSTRAINT ad_recentitem_uu_idx UNIQUE (ad_recentitem_uu)
;

DROP INDEX ad_record_access_uu_idx
;

ALTER TABLE ad_record_access ADD CONSTRAINT ad_record_access_uu_idx UNIQUE (ad_record_access_uu)
;

DROP INDEX ad_ref_list_uu_idx
;

ALTER TABLE ad_ref_list ADD CONSTRAINT ad_ref_list_uu_idx UNIQUE (ad_ref_list_uu)
;

DROP INDEX ad_ref_list_trl_uu_idx
;

ALTER TABLE ad_ref_list_trl ADD CONSTRAINT ad_ref_list_trl_uu_idx UNIQUE (ad_ref_list_trl_uu)
;

DROP INDEX ad_ref_table_uu_idx
;

ALTER TABLE ad_ref_table ADD CONSTRAINT ad_ref_table_uu_idx UNIQUE (ad_ref_table_uu)
;

DROP INDEX ad_reference_uu_idx
;

ALTER TABLE ad_reference ADD CONSTRAINT ad_reference_uu_idx UNIQUE (ad_reference_uu)
;

DROP INDEX ad_reference_trl_uu_idx
;

ALTER TABLE ad_reference_trl ADD CONSTRAINT ad_reference_trl_uu_idx UNIQUE (ad_reference_trl_uu)
;

DROP INDEX ad_registration_uu_idx
;

ALTER TABLE ad_registration ADD CONSTRAINT ad_registration_uu_idx UNIQUE (ad_registration_uu)
;

DROP INDEX ad_relationtype_uu_idx
;

ALTER TABLE ad_relationtype ADD CONSTRAINT ad_relationtype_uu_idx UNIQUE (ad_relationtype_uu)
;

DROP INDEX ad_replication_uu_idx
;

ALTER TABLE ad_replication ADD CONSTRAINT ad_replication_uu_idx UNIQUE (ad_replication_uu)
;

DROP INDEX ad_replication_log_uu_idx
;

ALTER TABLE ad_replication_log ADD CONSTRAINT ad_replication_log_uu_idx UNIQUE (ad_replication_log_uu)
;

DROP INDEX ad_replication_run_uu_idx
;

ALTER TABLE ad_replication_run ADD CONSTRAINT ad_replication_run_uu_idx UNIQUE (ad_replication_run_uu)
;

DROP INDEX ad_replicationdocument_uu_idx
;

ALTER TABLE ad_replicationdocument ADD CONSTRAINT ad_replicationdocument_uu_idx UNIQUE (ad_replicationdocument_uu)
;

DROP INDEX ad_replicationstrategy_uu_idx
;

ALTER TABLE ad_replicationstrategy ADD CONSTRAINT ad_replicationstrategy_uu_idx UNIQUE (ad_replicationstrategy_uu)
;

DROP INDEX ad_replicationtable_uu_idx
;

ALTER TABLE ad_replicationtable ADD CONSTRAINT ad_replicationtable_uu_idx UNIQUE (ad_replicationtable_uu)
;

DROP INDEX ad_reportview_uu_idx
;

ALTER TABLE ad_reportview ADD CONSTRAINT ad_reportview_uu_idx UNIQUE (ad_reportview_uu)
;

DROP INDEX ad_reportview_col_uu_idx
;

ALTER TABLE ad_reportview_col ADD CONSTRAINT ad_reportview_col_uu_idx UNIQUE (ad_reportview_col_uu)
;

DROP INDEX ad_role_uu_idx
;

ALTER TABLE ad_role ADD CONSTRAINT ad_role_uu_idx UNIQUE (ad_role_uu)
;

DROP INDEX ad_role_included_uu_idx
;

ALTER TABLE ad_role_included ADD CONSTRAINT ad_role_included_uu_idx UNIQUE (ad_role_included_uu)
;

DROP INDEX ad_role_orgaccess_uu_idx
;

ALTER TABLE ad_role_orgaccess ADD CONSTRAINT ad_role_orgaccess_uu_idx UNIQUE (ad_role_orgaccess_uu)
;

DROP INDEX ad_rule_uu_idx
;

ALTER TABLE ad_rule ADD CONSTRAINT ad_rule_uu_idx UNIQUE (ad_rule_uu)
;

DROP INDEX ad_schedule_uu_idx
;

ALTER TABLE ad_schedule ADD CONSTRAINT ad_schedule_uu_idx UNIQUE (ad_schedule_uu)
;

DROP INDEX ad_scheduler_uu_idx
;

ALTER TABLE ad_scheduler ADD CONSTRAINT ad_scheduler_uu_idx UNIQUE (ad_scheduler_uu)
;

DROP INDEX ad_scheduler_para_uu_idx
;

ALTER TABLE ad_scheduler_para ADD CONSTRAINT ad_scheduler_para_uu_idx UNIQUE (ad_scheduler_para_uu)
;

DROP INDEX ad_schedulerlog_uu_idx
;

ALTER TABLE ad_schedulerlog ADD CONSTRAINT ad_schedulerlog_uu_idx UNIQUE (ad_schedulerlog_uu)
;

DROP INDEX ad_schedulerrecipient_uu_idx
;

ALTER TABLE ad_schedulerrecipient ADD CONSTRAINT ad_schedulerrecipient_uu_idx UNIQUE (ad_schedulerrecipient_uu)
;

DROP INDEX ad_searchdefinition_uu_idx
;

ALTER TABLE ad_searchdefinition ADD CONSTRAINT ad_searchdefinition_uu_idx UNIQUE (ad_searchdefinition_uu)
;

DROP INDEX ad_sequence_uu_idx
;

ALTER TABLE ad_sequence ADD CONSTRAINT ad_sequence_uu_idx UNIQUE (ad_sequence_uu)
;

DROP INDEX ad_sequence_audit_uu_idx
;

ALTER TABLE ad_sequence_audit ADD CONSTRAINT ad_sequence_audit_uu_idx UNIQUE (ad_sequence_audit_uu)
;

DROP INDEX ad_sequence_no_uu_idx
;

ALTER TABLE ad_sequence_no ADD CONSTRAINT ad_sequence_no_uu_idx UNIQUE (ad_sequence_no_uu)
;

DROP INDEX ad_session_uu_idx
;

ALTER TABLE ad_session ADD CONSTRAINT ad_session_uu_idx UNIQUE (ad_session_uu)
;

DROP INDEX ad_storageprovider_uu_idx
;

ALTER TABLE ad_storageprovider ADD CONSTRAINT ad_storageprovider_uu_idx UNIQUE (ad_storageprovider_uu)
;

DROP INDEX ad_sysconfig_uu_idx
;

ALTER TABLE ad_sysconfig ADD CONSTRAINT ad_sysconfig_uu_idx UNIQUE (ad_sysconfig_uu)
;

DROP INDEX ad_system_uu_idx
;

ALTER TABLE ad_system ADD CONSTRAINT ad_system_uu_idx UNIQUE (ad_system_uu)
;

DROP INDEX ad_tab_uu_idx
;

ALTER TABLE ad_tab ADD CONSTRAINT ad_tab_uu_idx UNIQUE (ad_tab_uu)
;

DROP INDEX ad_tab_customization_uu_idx
;

ALTER TABLE ad_tab_customization ADD CONSTRAINT ad_tab_customization_uu_idx UNIQUE (ad_tab_customization_uu)
;

DROP INDEX ad_tab_trl_uu_idx
;

ALTER TABLE ad_tab_trl ADD CONSTRAINT ad_tab_trl_uu_idx UNIQUE (ad_tab_trl_uu)
;

DROP INDEX ad_table_uu_idx
;

ALTER TABLE ad_table ADD CONSTRAINT ad_table_uu_idx UNIQUE (ad_table_uu)
;

DROP INDEX ad_table_access_uu_idx
;

ALTER TABLE ad_table_access ADD CONSTRAINT ad_table_access_uu_idx UNIQUE (ad_table_access_uu)
;

DROP INDEX ad_table_scriptvalidato_uu_idx
;

ALTER TABLE ad_table_scriptvalidator ADD CONSTRAINT ad_table_scriptvalidato_uu_idx UNIQUE (ad_table_scriptvalidator_uu)
;

DROP INDEX ad_table_trl_uu_idx
;

ALTER TABLE ad_table_trl ADD CONSTRAINT ad_table_trl_uu_idx UNIQUE (ad_table_trl_uu)
;

DROP INDEX ad_task_uu_idx
;

ALTER TABLE ad_task ADD CONSTRAINT ad_task_uu_idx UNIQUE (ad_task_uu)
;

DROP INDEX ad_task_access_uu_idx
;

ALTER TABLE ad_task_access ADD CONSTRAINT ad_task_access_uu_idx UNIQUE (ad_task_access_uu)
;

DROP INDEX ad_task_trl_uu_idx
;

ALTER TABLE ad_task_trl ADD CONSTRAINT ad_task_trl_uu_idx UNIQUE (ad_task_trl_uu)
;

DROP INDEX ad_taskinstance_uu_idx
;

ALTER TABLE ad_taskinstance ADD CONSTRAINT ad_taskinstance_uu_idx UNIQUE (ad_taskinstance_uu)
;

DROP INDEX ad_toolbarbutton_uu_idx
;

ALTER TABLE ad_toolbarbutton ADD CONSTRAINT ad_toolbarbutton_uu_idx UNIQUE (ad_toolbarbutton_uu)
;

DROP INDEX ad_toolbarbuttonrestric_uu_idx
;

ALTER TABLE ad_toolbarbuttonrestrict ADD CONSTRAINT ad_toolbarbuttonrestric_uu_idx UNIQUE (ad_toolbarbuttonrestrict_uu)
;

DROP INDEX ad_tree_uu_idx
;

ALTER TABLE ad_tree ADD CONSTRAINT ad_tree_uu_idx UNIQUE (ad_tree_uu)
;

DROP INDEX ad_treebar_uu_idx
;

ALTER TABLE ad_treebar ADD CONSTRAINT ad_treebar_uu_idx UNIQUE (ad_treebar_uu)
;

DROP INDEX ad_treenode_uu_idx
;

ALTER TABLE ad_treenode ADD CONSTRAINT ad_treenode_uu_idx UNIQUE (ad_treenode_uu)
;

DROP INDEX ad_treenodebp_uu_idx
;

ALTER TABLE ad_treenodebp ADD CONSTRAINT ad_treenodebp_uu_idx UNIQUE (ad_treenodebp_uu)
;

DROP INDEX ad_treenodecmc_uu_idx
;

ALTER TABLE ad_treenodecmc ADD CONSTRAINT ad_treenodecmc_uu_idx UNIQUE (ad_treenodecmc_uu)
;

DROP INDEX ad_treenodecmm_uu_idx
;

ALTER TABLE ad_treenodecmm ADD CONSTRAINT ad_treenodecmm_uu_idx UNIQUE (ad_treenodecmm_uu)
;

DROP INDEX ad_treenodecms_uu_idx
;

ALTER TABLE ad_treenodecms ADD CONSTRAINT ad_treenodecms_uu_idx UNIQUE (ad_treenodecms_uu)
;

DROP INDEX ad_treenodecmt_uu_idx
;

ALTER TABLE ad_treenodecmt ADD CONSTRAINT ad_treenodecmt_uu_idx UNIQUE (ad_treenodecmt_uu)
;

DROP INDEX ad_treenodemm_uu_idx
;

ALTER TABLE ad_treenodemm ADD CONSTRAINT ad_treenodemm_uu_idx UNIQUE (ad_treenodemm_uu)
;

DROP INDEX ad_treenodepr_uu_idx
;

ALTER TABLE ad_treenodepr ADD CONSTRAINT ad_treenodepr_uu_idx UNIQUE (ad_treenodepr_uu)
;

DROP INDEX ad_treenodeu1_uu_idx
;

ALTER TABLE ad_treenodeu1 ADD CONSTRAINT ad_treenodeu1_uu_idx UNIQUE (ad_treenodeu1_uu)
;

DROP INDEX ad_treenodeu2_uu_idx
;

ALTER TABLE ad_treenodeu2 ADD CONSTRAINT ad_treenodeu2_uu_idx UNIQUE (ad_treenodeu2_uu)
;

DROP INDEX ad_treenodeu3_uu_idx
;

ALTER TABLE ad_treenodeu3 ADD CONSTRAINT ad_treenodeu3_uu_idx UNIQUE (ad_treenodeu3_uu)
;

DROP INDEX ad_treenodeu4_uu_idx
;

ALTER TABLE ad_treenodeu4 ADD CONSTRAINT ad_treenodeu4_uu_idx UNIQUE (ad_treenodeu4_uu)
;

DROP INDEX ad_user_uu_idx
;

ALTER TABLE ad_user ADD CONSTRAINT ad_user_uu_idx UNIQUE (ad_user_uu)
;

DROP INDEX ad_user_orgaccess_uu_idx
;

ALTER TABLE ad_user_orgaccess ADD CONSTRAINT ad_user_orgaccess_uu_idx UNIQUE (ad_user_orgaccess_uu)
;

DROP INDEX ad_user_roles_uu_idx
;

ALTER TABLE ad_user_roles ADD CONSTRAINT ad_user_roles_uu_idx UNIQUE (ad_user_roles_uu)
;

DROP INDEX ad_user_substitute_uu_idx
;

ALTER TABLE ad_user_substitute ADD CONSTRAINT ad_user_substitute_uu_idx UNIQUE (ad_user_substitute_uu)
;

DROP INDEX ad_userbpaccess_uu_idx
;

ALTER TABLE ad_userbpaccess ADD CONSTRAINT ad_userbpaccess_uu_idx UNIQUE (ad_userbpaccess_uu)
;

DROP INDEX ad_userdef_field_uu_idx
;

ALTER TABLE ad_userdef_field ADD CONSTRAINT ad_userdef_field_uu_idx UNIQUE (ad_userdef_field_uu)
;

DROP INDEX ad_userdef_tab_uu_idx
;

ALTER TABLE ad_userdef_tab ADD CONSTRAINT ad_userdef_tab_uu_idx UNIQUE (ad_userdef_tab_uu)
;

DROP INDEX ad_userdef_win_uu_idx
;

ALTER TABLE ad_userdef_win ADD CONSTRAINT ad_userdef_win_uu_idx UNIQUE (ad_userdef_win_uu)
;

DROP INDEX ad_usermail_uu_idx
;

ALTER TABLE ad_usermail ADD CONSTRAINT ad_usermail_uu_idx UNIQUE (ad_usermail_uu)
;

DROP INDEX ad_userquery_uu_idx
;

ALTER TABLE ad_userquery ADD CONSTRAINT ad_userquery_uu_idx UNIQUE (ad_userquery_uu)
;

DROP INDEX ad_val_rule_uu_idx
;

ALTER TABLE ad_val_rule ADD CONSTRAINT ad_val_rule_uu_idx UNIQUE (ad_val_rule_uu)
;

DROP INDEX ad_wf_activity_uu_idx
;

ALTER TABLE ad_wf_activity ADD CONSTRAINT ad_wf_activity_uu_idx UNIQUE (ad_wf_activity_uu)
;

DROP INDEX ad_wf_activityresult_uu_idx
;

ALTER TABLE ad_wf_activityresult ADD CONSTRAINT ad_wf_activityresult_uu_idx UNIQUE (ad_wf_activityresult_uu)
;

DROP INDEX ad_wf_block_uu_idx
;

ALTER TABLE ad_wf_block ADD CONSTRAINT ad_wf_block_uu_idx UNIQUE (ad_wf_block_uu)
;

DROP INDEX ad_wf_eventaudit_uu_idx
;

ALTER TABLE ad_wf_eventaudit ADD CONSTRAINT ad_wf_eventaudit_uu_idx UNIQUE (ad_wf_eventaudit_uu)
;

DROP INDEX ad_wf_nextcondition_uu_idx
;

ALTER TABLE ad_wf_nextcondition ADD CONSTRAINT ad_wf_nextcondition_uu_idx UNIQUE (ad_wf_nextcondition_uu)
;

DROP INDEX ad_wf_node_uu_idx
;

ALTER TABLE ad_wf_node ADD CONSTRAINT ad_wf_node_uu_idx UNIQUE (ad_wf_node_uu)
;

DROP INDEX ad_wf_node_para_uu_idx
;

ALTER TABLE ad_wf_node_para ADD CONSTRAINT ad_wf_node_para_uu_idx UNIQUE (ad_wf_node_para_uu)
;

DROP INDEX ad_wf_node_trl_uu_idx
;

ALTER TABLE ad_wf_node_trl ADD CONSTRAINT ad_wf_node_trl_uu_idx UNIQUE (ad_wf_node_trl_uu)
;

DROP INDEX ad_wf_nodenext_uu_idx
;

ALTER TABLE ad_wf_nodenext ADD CONSTRAINT ad_wf_nodenext_uu_idx UNIQUE (ad_wf_nodenext_uu)
;

DROP INDEX ad_wf_process_uu_idx
;

ALTER TABLE ad_wf_process ADD CONSTRAINT ad_wf_process_uu_idx UNIQUE (ad_wf_process_uu)
;

DROP INDEX ad_wf_processdata_uu_idx
;

ALTER TABLE ad_wf_processdata ADD CONSTRAINT ad_wf_processdata_uu_idx UNIQUE (ad_wf_processdata_uu)
;

DROP INDEX ad_wf_responsible_uu_idx
;

ALTER TABLE ad_wf_responsible ADD CONSTRAINT ad_wf_responsible_uu_idx UNIQUE (ad_wf_responsible_uu)
;

DROP INDEX ad_window_uu_idx
;

ALTER TABLE ad_window ADD CONSTRAINT ad_window_uu_idx UNIQUE (ad_window_uu)
;

DROP INDEX ad_window_access_uu_idx
;

ALTER TABLE ad_window_access ADD CONSTRAINT ad_window_access_uu_idx UNIQUE (ad_window_access_uu)
;

DROP INDEX ad_window_trl_uu_idx
;

ALTER TABLE ad_window_trl ADD CONSTRAINT ad_window_trl_uu_idx UNIQUE (ad_window_trl_uu)
;

DROP INDEX ad_wizardprocess_uu_idx
;

ALTER TABLE ad_wizardprocess ADD CONSTRAINT ad_wizardprocess_uu_idx UNIQUE (ad_wizardprocess_uu)
;

DROP INDEX ad_workbench_uu_idx
;

ALTER TABLE ad_workbench ADD CONSTRAINT ad_workbench_uu_idx UNIQUE (ad_workbench_uu)
;

DROP INDEX ad_workbench_trl_uu_idx
;

ALTER TABLE ad_workbench_trl ADD CONSTRAINT ad_workbench_trl_uu_idx UNIQUE (ad_workbench_trl_uu)
;

DROP INDEX ad_workbenchwindow_uu_idx
;

ALTER TABLE ad_workbenchwindow ADD CONSTRAINT ad_workbenchwindow_uu_idx UNIQUE (ad_workbenchwindow_uu)
;

DROP INDEX ad_workflow_uu_idx
;

ALTER TABLE ad_workflow ADD CONSTRAINT ad_workflow_uu_idx UNIQUE (ad_workflow_uu)
;

DROP INDEX ad_workflow_access_uu_idx
;

ALTER TABLE ad_workflow_access ADD CONSTRAINT ad_workflow_access_uu_idx UNIQUE (ad_workflow_access_uu)
;

DROP INDEX ad_workflow_trl_uu_idx
;

ALTER TABLE ad_workflow_trl ADD CONSTRAINT ad_workflow_trl_uu_idx UNIQUE (ad_workflow_trl_uu)
;

DROP INDEX ad_workflowprocessor_uu_idx
;

ALTER TABLE ad_workflowprocessor ADD CONSTRAINT ad_workflowprocessor_uu_idx UNIQUE (ad_workflowprocessor_uu)
;

DROP INDEX ad_workflowprocessorlog_uu_idx
;

ALTER TABLE ad_workflowprocessorlog ADD CONSTRAINT ad_workflowprocessorlog_uu_idx UNIQUE (ad_workflowprocessorlog_uu)
;

DROP INDEX asp_clientexception_uu_idx
;

ALTER TABLE asp_clientexception ADD CONSTRAINT asp_clientexception_uu_idx UNIQUE (asp_clientexception_uu)
;

DROP INDEX asp_clientlevel_uu_idx
;

ALTER TABLE asp_clientlevel ADD CONSTRAINT asp_clientlevel_uu_idx UNIQUE (asp_clientlevel_uu)
;

DROP INDEX asp_field_uu_idx
;

ALTER TABLE asp_field ADD CONSTRAINT asp_field_uu_idx UNIQUE (asp_field_uu)
;

DROP INDEX asp_form_uu_idx
;

ALTER TABLE asp_form ADD CONSTRAINT asp_form_uu_idx UNIQUE (asp_form_uu)
;

DROP INDEX asp_level_uu_idx
;

ALTER TABLE asp_level ADD CONSTRAINT asp_level_uu_idx UNIQUE (asp_level_uu)
;

DROP INDEX asp_module_uu_idx
;

ALTER TABLE asp_module ADD CONSTRAINT asp_module_uu_idx UNIQUE (asp_module_uu)
;

DROP INDEX asp_process_uu_idx
;

ALTER TABLE asp_process ADD CONSTRAINT asp_process_uu_idx UNIQUE (asp_process_uu)
;

DROP INDEX asp_process_para_uu_idx
;

ALTER TABLE asp_process_para ADD CONSTRAINT asp_process_para_uu_idx UNIQUE (asp_process_para_uu)
;

DROP INDEX asp_ref_list_uu_idx
;

ALTER TABLE asp_ref_list ADD CONSTRAINT asp_ref_list_uu_idx UNIQUE (asp_ref_list_uu)
;

DROP INDEX asp_tab_uu_idx
;

ALTER TABLE asp_tab ADD CONSTRAINT asp_tab_uu_idx UNIQUE (asp_tab_uu)
;

DROP INDEX asp_task_uu_idx
;

ALTER TABLE asp_task ADD CONSTRAINT asp_task_uu_idx UNIQUE (asp_task_uu)
;

DROP INDEX asp_window_uu_idx
;

ALTER TABLE asp_window ADD CONSTRAINT asp_window_uu_idx UNIQUE (asp_window_uu)
;

DROP INDEX asp_workflow_uu_idx
;

ALTER TABLE asp_workflow ADD CONSTRAINT asp_workflow_uu_idx UNIQUE (asp_workflow_uu)
;

DROP INDEX b_bid_uu_idx
;

ALTER TABLE b_bid ADD CONSTRAINT b_bid_uu_idx UNIQUE (b_bid_uu)
;

DROP INDEX b_bidcomment_uu_idx
;

ALTER TABLE b_bidcomment ADD CONSTRAINT b_bidcomment_uu_idx UNIQUE (b_bidcomment_uu)
;

DROP INDEX b_buyer_uu_idx
;

ALTER TABLE b_buyer ADD CONSTRAINT b_buyer_uu_idx UNIQUE (b_buyer_uu)
;

DROP INDEX b_buyerfunds_uu_idx
;

ALTER TABLE b_buyerfunds ADD CONSTRAINT b_buyerfunds_uu_idx UNIQUE (b_buyerfunds_uu)
;

DROP INDEX b_offer_uu_idx
;

ALTER TABLE b_offer ADD CONSTRAINT b_offer_uu_idx UNIQUE (b_offer_uu)
;

DROP INDEX b_seller_uu_idx
;

ALTER TABLE b_seller ADD CONSTRAINT b_seller_uu_idx UNIQUE (b_seller_uu)
;

DROP INDEX b_sellerfunds_uu_idx
;

ALTER TABLE b_sellerfunds ADD CONSTRAINT b_sellerfunds_uu_idx UNIQUE (b_sellerfunds_uu)
;

DROP INDEX b_topic_uu_idx
;

ALTER TABLE b_topic ADD CONSTRAINT b_topic_uu_idx UNIQUE (b_topic_uu)
;

DROP INDEX b_topiccategory_uu_idx
;

ALTER TABLE b_topiccategory ADD CONSTRAINT b_topiccategory_uu_idx UNIQUE (b_topiccategory_uu)
;

DROP INDEX b_topictype_uu_idx
;

ALTER TABLE b_topictype ADD CONSTRAINT b_topictype_uu_idx UNIQUE (b_topictype_uu)
;

DROP INDEX c_1099box_uu_idx
;

ALTER TABLE c_1099box ADD CONSTRAINT c_1099box_uu_idx UNIQUE (c_1099box_uu)
;

DROP INDEX c_acctprocessor_uu_idx
;

ALTER TABLE c_acctprocessor ADD CONSTRAINT c_acctprocessor_uu_idx UNIQUE (c_acctprocessor_uu)
;

DROP INDEX c_acctprocessorlog_uu_idx
;

ALTER TABLE c_acctprocessorlog ADD CONSTRAINT c_acctprocessorlog_uu_idx UNIQUE (c_acctprocessorlog_uu)
;

DROP INDEX c_acctschema_uu_idx
;

ALTER TABLE c_acctschema ADD CONSTRAINT c_acctschema_uu_idx UNIQUE (c_acctschema_uu)
;

DROP INDEX c_acctschema_default_uu_idx
;

ALTER TABLE c_acctschema_default ADD CONSTRAINT c_acctschema_default_uu_idx UNIQUE (c_acctschema_default_uu)
;

DROP INDEX c_acctschema_element_uu_idx
;

ALTER TABLE c_acctschema_element ADD CONSTRAINT c_acctschema_element_uu_idx UNIQUE (c_acctschema_element_uu)
;

DROP INDEX c_acctschema_gl_uu_idx
;

ALTER TABLE c_acctschema_gl ADD CONSTRAINT c_acctschema_gl_uu_idx UNIQUE (c_acctschema_gl_uu)
;

DROP INDEX c_activity_uu_idx
;

ALTER TABLE c_activity ADD CONSTRAINT c_activity_uu_idx UNIQUE (c_activity_uu)
;

DROP INDEX c_allocationhdr_uu_idx
;

ALTER TABLE c_allocationhdr ADD CONSTRAINT c_allocationhdr_uu_idx UNIQUE (c_allocationhdr_uu)
;

DROP INDEX c_allocationline_uu_idx
;

ALTER TABLE c_allocationline ADD CONSTRAINT c_allocationline_uu_idx UNIQUE (c_allocationline_uu)
;

DROP INDEX c_bank_uu_idx
;

ALTER TABLE c_bank ADD CONSTRAINT c_bank_uu_idx UNIQUE (c_bank_uu)
;

DROP INDEX c_bankaccount_uu_idx
;

ALTER TABLE c_bankaccount ADD CONSTRAINT c_bankaccount_uu_idx UNIQUE (c_bankaccount_uu)
;

DROP INDEX c_bankaccount_acct_uu_idx
;

ALTER TABLE c_bankaccount_acct ADD CONSTRAINT c_bankaccount_acct_uu_idx UNIQUE (c_bankaccount_acct_uu)
;

DROP INDEX c_bankaccount_processor_uu_idx
;

ALTER TABLE c_bankaccount_processor ADD CONSTRAINT c_bankaccount_processor_uu_idx UNIQUE (c_bankaccount_processor_uu)
;

DROP INDEX c_bankaccountdoc_uu_idx
;

ALTER TABLE c_bankaccountdoc ADD CONSTRAINT c_bankaccountdoc_uu_idx UNIQUE (c_bankaccountdoc_uu)
;

DROP INDEX c_bankstatement_uu_idx
;

ALTER TABLE c_bankstatement ADD CONSTRAINT c_bankstatement_uu_idx UNIQUE (c_bankstatement_uu)
;

DROP INDEX c_bankstatementline_uu_idx
;

ALTER TABLE c_bankstatementline ADD CONSTRAINT c_bankstatementline_uu_idx UNIQUE (c_bankstatementline_uu)
;

DROP INDEX c_bankstatementloader_uu_idx
;

ALTER TABLE c_bankstatementloader ADD CONSTRAINT c_bankstatementloader_uu_idx UNIQUE (c_bankstatementloader_uu)
;

DROP INDEX c_bankstatementmatcher_uu_idx
;

ALTER TABLE c_bankstatementmatcher ADD CONSTRAINT c_bankstatementmatcher_uu_idx UNIQUE (c_bankstatementmatcher_uu)
;

DROP INDEX c_bp_bankaccount_uu_idx
;

ALTER TABLE c_bp_bankaccount ADD CONSTRAINT c_bp_bankaccount_uu_idx UNIQUE (c_bp_bankaccount_uu)
;

DROP INDEX c_bp_customer_acct_uu_idx
;

ALTER TABLE c_bp_customer_acct ADD CONSTRAINT c_bp_customer_acct_uu_idx UNIQUE (c_bp_customer_acct_uu)
;

DROP INDEX c_bp_edi_uu_idx
;

ALTER TABLE c_bp_edi ADD CONSTRAINT c_bp_edi_uu_idx UNIQUE (c_bp_edi_uu)
;

DROP INDEX c_bp_employee_acct_uu_idx
;

ALTER TABLE c_bp_employee_acct ADD CONSTRAINT c_bp_employee_acct_uu_idx UNIQUE (c_bp_employee_acct_uu)
;

DROP INDEX c_bp_group_uu_idx
;

ALTER TABLE c_bp_group ADD CONSTRAINT c_bp_group_uu_idx UNIQUE (c_bp_group_uu)
;

DROP INDEX c_bp_group_acct_uu_idx
;

ALTER TABLE c_bp_group_acct ADD CONSTRAINT c_bp_group_acct_uu_idx UNIQUE (c_bp_group_acct_uu)
;

DROP INDEX c_bp_relation_uu_idx
;

ALTER TABLE c_bp_relation ADD CONSTRAINT c_bp_relation_uu_idx UNIQUE (c_bp_relation_uu)
;

DROP INDEX c_bp_shippingacct_uu_idx
;

ALTER TABLE c_bp_shippingacct ADD CONSTRAINT c_bp_shippingacct_uu_idx UNIQUE (c_bp_shippingacct_uu)
;

DROP INDEX c_bp_vendor_acct_uu_idx
;

ALTER TABLE c_bp_vendor_acct ADD CONSTRAINT c_bp_vendor_acct_uu_idx UNIQUE (c_bp_vendor_acct_uu)
;

DROP INDEX c_bp_withholding_uu_idx
;

ALTER TABLE c_bp_withholding ADD CONSTRAINT c_bp_withholding_uu_idx UNIQUE (c_bp_withholding_uu)
;

DROP INDEX c_bpartner_uu_idx
;

ALTER TABLE c_bpartner ADD CONSTRAINT c_bpartner_uu_idx UNIQUE (c_bpartner_uu)
;

DROP INDEX c_bpartner_location_uu_idx
;

ALTER TABLE c_bpartner_location ADD CONSTRAINT c_bpartner_location_uu_idx UNIQUE (c_bpartner_location_uu)
;

DROP INDEX c_bpartner_product_uu_idx
;

ALTER TABLE c_bpartner_product ADD CONSTRAINT c_bpartner_product_uu_idx UNIQUE (c_bpartner_product_uu)
;

DROP INDEX c_calendar_uu_idx
;

ALTER TABLE c_calendar ADD CONSTRAINT c_calendar_uu_idx UNIQUE (c_calendar_uu)
;

DROP INDEX c_campaign_uu_idx
;

ALTER TABLE c_campaign ADD CONSTRAINT c_campaign_uu_idx UNIQUE (c_campaign_uu)
;

DROP INDEX c_cash_uu_idx
;

ALTER TABLE c_cash ADD CONSTRAINT c_cash_uu_idx UNIQUE (c_cash_uu)
;

DROP INDEX c_cashbook_uu_idx
;

ALTER TABLE c_cashbook ADD CONSTRAINT c_cashbook_uu_idx UNIQUE (c_cashbook_uu)
;

DROP INDEX c_cashbook_acct_uu_idx
;

ALTER TABLE c_cashbook_acct ADD CONSTRAINT c_cashbook_acct_uu_idx UNIQUE (c_cashbook_acct_uu)
;

DROP INDEX c_cashline_uu_idx
;

ALTER TABLE c_cashline ADD CONSTRAINT c_cashline_uu_idx UNIQUE (c_cashline_uu)
;

DROP INDEX c_cashplan_uu_idx
;

ALTER TABLE c_cashplan ADD CONSTRAINT c_cashplan_uu_idx UNIQUE (c_cashplan_uu)
;

DROP INDEX c_cashplanline_uu_idx
;

ALTER TABLE c_cashplanline ADD CONSTRAINT c_cashplanline_uu_idx UNIQUE (c_cashplanline_uu)
;

DROP INDEX c_channel_uu_idx
;

ALTER TABLE c_channel ADD CONSTRAINT c_channel_uu_idx UNIQUE (c_channel_uu)
;

DROP INDEX c_charge_uu_idx
;

ALTER TABLE c_charge ADD CONSTRAINT c_charge_uu_idx UNIQUE (c_charge_uu)
;

DROP INDEX c_charge_acct_uu_idx
;

ALTER TABLE c_charge_acct ADD CONSTRAINT c_charge_acct_uu_idx UNIQUE (c_charge_acct_uu)
;

DROP INDEX c_charge_trl_uu_idx
;

ALTER TABLE c_charge_trl ADD CONSTRAINT c_charge_trl_uu_idx UNIQUE (c_charge_trl_uu)
;

DROP INDEX c_chargetype_uu_idx
;

ALTER TABLE c_chargetype ADD CONSTRAINT c_chargetype_uu_idx UNIQUE (c_chargetype_uu)
;

DROP INDEX c_chargetype_doctype_uu_idx
;

ALTER TABLE c_chargetype_doctype ADD CONSTRAINT c_chargetype_doctype_uu_idx UNIQUE (c_chargetype_doctype_uu)
;

DROP INDEX c_city_uu_idx
;

ALTER TABLE c_city ADD CONSTRAINT c_city_uu_idx UNIQUE (c_city_uu)
;

DROP INDEX c_commission_uu_idx
;

ALTER TABLE c_commission ADD CONSTRAINT c_commission_uu_idx UNIQUE (c_commission_uu)
;

DROP INDEX c_commissionamt_uu_idx
;

ALTER TABLE c_commissionamt ADD CONSTRAINT c_commissionamt_uu_idx UNIQUE (c_commissionamt_uu)
;

DROP INDEX c_commissiondetail_uu_idx
;

ALTER TABLE c_commissiondetail ADD CONSTRAINT c_commissiondetail_uu_idx UNIQUE (c_commissiondetail_uu)
;

DROP INDEX c_commissionline_uu_idx
;

ALTER TABLE c_commissionline ADD CONSTRAINT c_commissionline_uu_idx UNIQUE (c_commissionline_uu)
;

DROP INDEX c_commissionrun_uu_idx
;

ALTER TABLE c_commissionrun ADD CONSTRAINT c_commissionrun_uu_idx UNIQUE (c_commissionrun_uu)
;

DROP INDEX c_conversion_rate_uu_idx
;

ALTER TABLE c_conversion_rate ADD CONSTRAINT c_conversion_rate_uu_idx UNIQUE (c_conversion_rate_uu)
;

DROP INDEX c_conversiontype_uu_idx
;

ALTER TABLE c_conversiontype ADD CONSTRAINT c_conversiontype_uu_idx UNIQUE (c_conversiontype_uu)
;

DROP INDEX c_country_uu_idx
;

ALTER TABLE c_country ADD CONSTRAINT c_country_uu_idx UNIQUE (c_country_uu)
;

DROP INDEX c_country_trl_uu_idx
;

ALTER TABLE c_country_trl ADD CONSTRAINT c_country_trl_uu_idx UNIQUE (c_country_trl_uu)
;

DROP INDEX c_currency_uu_idx
;

ALTER TABLE c_currency ADD CONSTRAINT c_currency_uu_idx UNIQUE (c_currency_uu)
;

DROP INDEX c_currency_acct_uu_idx
;

ALTER TABLE c_currency_acct ADD CONSTRAINT c_currency_acct_uu_idx UNIQUE (c_currency_acct_uu)
;

DROP INDEX c_currency_trl_uu_idx
;

ALTER TABLE c_currency_trl ADD CONSTRAINT c_currency_trl_uu_idx UNIQUE (c_currency_trl_uu)
;

DROP INDEX c_cycle_uu_idx
;

ALTER TABLE c_cycle ADD CONSTRAINT c_cycle_uu_idx UNIQUE (c_cycle_uu)
;

DROP INDEX c_cyclephase_uu_idx
;

ALTER TABLE c_cyclephase ADD CONSTRAINT c_cyclephase_uu_idx UNIQUE (c_cyclephase_uu)
;

DROP INDEX c_cyclestep_uu_idx
;

ALTER TABLE c_cyclestep ADD CONSTRAINT c_cyclestep_uu_idx UNIQUE (c_cyclestep_uu)
;

DROP INDEX c_depositbatch_uu_idx
;

ALTER TABLE c_depositbatch ADD CONSTRAINT c_depositbatch_uu_idx UNIQUE (c_depositbatch_uu)
;

DROP INDEX c_depositbatchline_uu_idx
;

ALTER TABLE c_depositbatchline ADD CONSTRAINT c_depositbatchline_uu_idx UNIQUE (c_depositbatchline_uu)
;

DROP INDEX c_doctype_uu_idx
;

ALTER TABLE c_doctype ADD CONSTRAINT c_doctype_uu_idx UNIQUE (c_doctype_uu)
;

DROP INDEX c_doctype_trl_uu_idx
;

ALTER TABLE c_doctype_trl ADD CONSTRAINT c_doctype_trl_uu_idx UNIQUE (c_doctype_trl_uu)
;

DROP INDEX c_doctypecounter_uu_idx
;

ALTER TABLE c_doctypecounter ADD CONSTRAINT c_doctypecounter_uu_idx UNIQUE (c_doctypecounter_uu)
;

DROP INDEX c_dunning_uu_idx
;

ALTER TABLE c_dunning ADD CONSTRAINT c_dunning_uu_idx UNIQUE (c_dunning_uu)
;

DROP INDEX c_dunninglevel_uu_idx
;

ALTER TABLE c_dunninglevel ADD CONSTRAINT c_dunninglevel_uu_idx UNIQUE (c_dunninglevel_uu)
;

DROP INDEX c_dunninglevel_trl_uu_idx
;

ALTER TABLE c_dunninglevel_trl ADD CONSTRAINT c_dunninglevel_trl_uu_idx UNIQUE (c_dunninglevel_trl_uu)
;

DROP INDEX c_dunningrun_uu_idx
;

ALTER TABLE c_dunningrun ADD CONSTRAINT c_dunningrun_uu_idx UNIQUE (c_dunningrun_uu)
;

DROP INDEX c_dunningrunentry_uu_idx
;

ALTER TABLE c_dunningrunentry ADD CONSTRAINT c_dunningrunentry_uu_idx UNIQUE (c_dunningrunentry_uu)
;

DROP INDEX c_dunningrunline_uu_idx
;

ALTER TABLE c_dunningrunline ADD CONSTRAINT c_dunningrunline_uu_idx UNIQUE (c_dunningrunline_uu)
;

DROP INDEX c_element_uu_idx
;

ALTER TABLE c_element ADD CONSTRAINT c_element_uu_idx UNIQUE (c_element_uu)
;

DROP INDEX c_elementvalue_uu_idx
;

ALTER TABLE c_elementvalue ADD CONSTRAINT c_elementvalue_uu_idx UNIQUE (c_elementvalue_uu)
;

DROP INDEX c_elementvalue_trl_uu_idx
;

ALTER TABLE c_elementvalue_trl ADD CONSTRAINT c_elementvalue_trl_uu_idx UNIQUE (c_elementvalue_trl_uu)
;

DROP INDEX c_greeting_uu_idx
;

ALTER TABLE c_greeting ADD CONSTRAINT c_greeting_uu_idx UNIQUE (c_greeting_uu)
;

DROP INDEX c_greeting_trl_uu_idx
;

ALTER TABLE c_greeting_trl ADD CONSTRAINT c_greeting_trl_uu_idx UNIQUE (c_greeting_trl_uu)
;

DROP INDEX c_interorg_acct_uu_idx
;

ALTER TABLE c_interorg_acct ADD CONSTRAINT c_interorg_acct_uu_idx UNIQUE (c_interorg_acct_uu)
;

DROP INDEX c_invoice_uu_idx
;

ALTER TABLE c_invoice ADD CONSTRAINT c_invoice_uu_idx UNIQUE (c_invoice_uu)
;

DROP INDEX c_invoicebatch_uu_idx
;

ALTER TABLE c_invoicebatch ADD CONSTRAINT c_invoicebatch_uu_idx UNIQUE (c_invoicebatch_uu)
;

DROP INDEX c_invoicebatchline_uu_idx
;

ALTER TABLE c_invoicebatchline ADD CONSTRAINT c_invoicebatchline_uu_idx UNIQUE (c_invoicebatchline_uu)
;

DROP INDEX c_invoiceline_uu_idx
;

ALTER TABLE c_invoiceline ADD CONSTRAINT c_invoiceline_uu_idx UNIQUE (c_invoiceline_uu)
;

DROP INDEX c_invoicepayschedule_uu_idx
;

ALTER TABLE c_invoicepayschedule ADD CONSTRAINT c_invoicepayschedule_uu_idx UNIQUE (c_invoicepayschedule_uu)
;

DROP INDEX c_invoiceschedule_uu_idx
;

ALTER TABLE c_invoiceschedule ADD CONSTRAINT c_invoiceschedule_uu_idx UNIQUE (c_invoiceschedule_uu)
;

DROP INDEX c_invoicetax_uu_idx
;

ALTER TABLE c_invoicetax ADD CONSTRAINT c_invoicetax_uu_idx UNIQUE (c_invoicetax_uu)
;

DROP INDEX c_job_uu_idx
;

ALTER TABLE c_job ADD CONSTRAINT c_job_uu_idx UNIQUE (c_job_uu)
;

DROP INDEX c_jobassignment_uu_idx
;

ALTER TABLE c_jobassignment ADD CONSTRAINT c_jobassignment_uu_idx UNIQUE (c_jobassignment_uu)
;

DROP INDEX c_jobcategory_uu_idx
;

ALTER TABLE c_jobcategory ADD CONSTRAINT c_jobcategory_uu_idx UNIQUE (c_jobcategory_uu)
;

DROP INDEX c_jobremuneration_uu_idx
;

ALTER TABLE c_jobremuneration ADD CONSTRAINT c_jobremuneration_uu_idx UNIQUE (c_jobremuneration_uu)
;

DROP INDEX c_landedcost_uu_idx
;

ALTER TABLE c_landedcost ADD CONSTRAINT c_landedcost_uu_idx UNIQUE (c_landedcost_uu)
;

DROP INDEX c_landedcostallocation_uu_idx
;

ALTER TABLE c_landedcostallocation ADD CONSTRAINT c_landedcostallocation_uu_idx UNIQUE (c_landedcostallocation_uu)
;

DROP INDEX c_location_uu_idx
;

ALTER TABLE c_location ADD CONSTRAINT c_location_uu_idx UNIQUE (c_location_uu)
;

DROP INDEX c_nonbusinessday_uu_idx
;

ALTER TABLE c_nonbusinessday ADD CONSTRAINT c_nonbusinessday_uu_idx UNIQUE (c_nonbusinessday_uu)
;

DROP INDEX c_onlinetrxhistory_uu_idx
;

ALTER TABLE c_onlinetrxhistory ADD CONSTRAINT c_onlinetrxhistory_uu_idx UNIQUE (c_onlinetrxhistory_uu)
;

DROP INDEX c_order_uu_idx
;

ALTER TABLE c_order ADD CONSTRAINT c_order_uu_idx UNIQUE (c_order_uu)
;

DROP INDEX c_orderline_uu_idx
;

ALTER TABLE c_orderline ADD CONSTRAINT c_orderline_uu_idx UNIQUE (c_orderline_uu)
;

DROP INDEX c_orderpayschedule_uu_idx
;

ALTER TABLE c_orderpayschedule ADD CONSTRAINT c_orderpayschedule_uu_idx UNIQUE (c_orderpayschedule_uu)
;

DROP INDEX c_ordersource_uu_idx
;

ALTER TABLE c_ordersource ADD CONSTRAINT c_ordersource_uu_idx UNIQUE (c_ordersource_uu)
;

DROP INDEX c_ordertax_uu_idx
;

ALTER TABLE c_ordertax ADD CONSTRAINT c_ordertax_uu_idx UNIQUE (c_ordertax_uu)
;

DROP INDEX c_orgassignment_uu_idx
;

ALTER TABLE c_orgassignment ADD CONSTRAINT c_orgassignment_uu_idx UNIQUE (c_orgassignment_uu)
;

DROP INDEX c_payment_uu_idx
;

ALTER TABLE c_payment ADD CONSTRAINT c_payment_uu_idx UNIQUE (c_payment_uu)
;

DROP INDEX c_paymentallocate_uu_idx
;

ALTER TABLE c_paymentallocate ADD CONSTRAINT c_paymentallocate_uu_idx UNIQUE (c_paymentallocate_uu)
;

DROP INDEX c_paymentbatch_uu_idx
;

ALTER TABLE c_paymentbatch ADD CONSTRAINT c_paymentbatch_uu_idx UNIQUE (c_paymentbatch_uu)
;

DROP INDEX c_paymentprocessor_uu_idx
;

ALTER TABLE c_paymentprocessor ADD CONSTRAINT c_paymentprocessor_uu_idx UNIQUE (c_paymentprocessor_uu)
;

DROP INDEX c_paymentterm_uu_idx
;

ALTER TABLE c_paymentterm ADD CONSTRAINT c_paymentterm_uu_idx UNIQUE (c_paymentterm_uu)
;

DROP INDEX c_paymentterm_trl_uu_idx
;

ALTER TABLE c_paymentterm_trl ADD CONSTRAINT c_paymentterm_trl_uu_idx UNIQUE (c_paymentterm_trl_uu)
;

DROP INDEX c_paymenttransaction_uu_idx
;

ALTER TABLE c_paymenttransaction ADD CONSTRAINT c_paymenttransaction_uu_idx UNIQUE (c_paymenttransaction_uu)
;

DROP INDEX c_payschedule_uu_idx
;

ALTER TABLE c_payschedule ADD CONSTRAINT c_payschedule_uu_idx UNIQUE (c_payschedule_uu)
;

DROP INDEX c_payselection_uu_idx
;

ALTER TABLE c_payselection ADD CONSTRAINT c_payselection_uu_idx UNIQUE (c_payselection_uu)
;

DROP INDEX c_payselectioncheck_uu_idx
;

ALTER TABLE c_payselectioncheck ADD CONSTRAINT c_payselectioncheck_uu_idx UNIQUE (c_payselectioncheck_uu)
;

DROP INDEX c_payselectionline_uu_idx
;

ALTER TABLE c_payselectionline ADD CONSTRAINT c_payselectionline_uu_idx UNIQUE (c_payselectionline_uu)
;

DROP INDEX c_period_uu_idx
;

ALTER TABLE c_period ADD CONSTRAINT c_period_uu_idx UNIQUE (c_period_uu)
;

DROP INDEX c_periodcontrol_uu_idx
;

ALTER TABLE c_periodcontrol ADD CONSTRAINT c_periodcontrol_uu_idx UNIQUE (c_periodcontrol_uu)
;

DROP INDEX c_phase_uu_idx
;

ALTER TABLE c_phase ADD CONSTRAINT c_phase_uu_idx UNIQUE (c_phase_uu)
;

DROP INDEX c_pos_uu_idx
;

ALTER TABLE c_pos ADD CONSTRAINT c_pos_uu_idx UNIQUE (c_pos_uu)
;

DROP INDEX c_poskey_uu_idx
;

ALTER TABLE c_poskey ADD CONSTRAINT c_poskey_uu_idx UNIQUE (c_poskey_uu)
;

DROP INDEX c_poskeylayout_uu_idx
;

ALTER TABLE c_poskeylayout ADD CONSTRAINT c_poskeylayout_uu_idx UNIQUE (c_poskeylayout_uu)
;

DROP INDEX c_pospayment_uu_idx
;

ALTER TABLE c_pospayment ADD CONSTRAINT c_pospayment_uu_idx UNIQUE (c_pospayment_uu)
;

DROP INDEX c_postendertype_uu_idx
;

ALTER TABLE c_postendertype ADD CONSTRAINT c_postendertype_uu_idx UNIQUE (c_postendertype_uu)
;

DROP INDEX c_project_uu_idx
;

ALTER TABLE c_project ADD CONSTRAINT c_project_uu_idx UNIQUE (c_project_uu)
;

DROP INDEX c_project_acct_uu_idx
;

ALTER TABLE c_project_acct ADD CONSTRAINT c_project_acct_uu_idx UNIQUE (c_project_acct_uu)
;

DROP INDEX c_projectissue_uu_idx
;

ALTER TABLE c_projectissue ADD CONSTRAINT c_projectissue_uu_idx UNIQUE (c_projectissue_uu)
;

DROP INDEX c_projectissuema_uu_idx
;

ALTER TABLE c_projectissuema ADD CONSTRAINT c_projectissuema_uu_idx UNIQUE (c_projectissuema_uu)
;

DROP INDEX c_projectline_uu_idx
;

ALTER TABLE c_projectline ADD CONSTRAINT c_projectline_uu_idx UNIQUE (c_projectline_uu)
;

DROP INDEX c_projectphase_uu_idx
;

ALTER TABLE c_projectphase ADD CONSTRAINT c_projectphase_uu_idx UNIQUE (c_projectphase_uu)
;

DROP INDEX c_projecttask_uu_idx
;

ALTER TABLE c_projecttask ADD CONSTRAINT c_projecttask_uu_idx UNIQUE (c_projecttask_uu)
;

DROP INDEX c_projecttype_uu_idx
;

ALTER TABLE c_projecttype ADD CONSTRAINT c_projecttype_uu_idx UNIQUE (c_projecttype_uu)
;

DROP INDEX c_recurring_uu_idx
;

ALTER TABLE c_recurring ADD CONSTRAINT c_recurring_uu_idx UNIQUE (c_recurring_uu)
;

DROP INDEX c_recurring_run_uu_idx
;

ALTER TABLE c_recurring_run ADD CONSTRAINT c_recurring_run_uu_idx UNIQUE (c_recurring_run_uu)
;

DROP INDEX c_region_uu_idx
;

ALTER TABLE c_region ADD CONSTRAINT c_region_uu_idx UNIQUE (c_region_uu)
;

DROP INDEX c_remuneration_uu_idx
;

ALTER TABLE c_remuneration ADD CONSTRAINT c_remuneration_uu_idx UNIQUE (c_remuneration_uu)
;

DROP INDEX c_revenuerecognition_uu_idx
;

ALTER TABLE c_revenuerecognition ADD CONSTRAINT c_revenuerecognition_uu_idx UNIQUE (c_revenuerecognition_uu)
;

DROP INDEX c_revenuerecognition_pl_uu_idx
;

ALTER TABLE c_revenuerecognition_plan ADD CONSTRAINT c_revenuerecognition_pl_uu_idx UNIQUE (c_revenuerecognition_plan_uu)
;

DROP INDEX c_revenuerecognition_ru_uu_idx
;

ALTER TABLE c_revenuerecognition_run ADD CONSTRAINT c_revenuerecognition_ru_uu_idx UNIQUE (c_revenuerecognition_run_uu)
;

DROP INDEX c_rfq_uu_idx
;

ALTER TABLE c_rfq ADD CONSTRAINT c_rfq_uu_idx UNIQUE (c_rfq_uu)
;

DROP INDEX c_rfq_topic_uu_idx
;

ALTER TABLE c_rfq_topic ADD CONSTRAINT c_rfq_topic_uu_idx UNIQUE (c_rfq_topic_uu)
;

DROP INDEX c_rfq_topicsubscriber_uu_idx
;

ALTER TABLE c_rfq_topicsubscriber ADD CONSTRAINT c_rfq_topicsubscriber_uu_idx UNIQUE (c_rfq_topicsubscriber_uu)
;

DROP INDEX c_rfq_topicsubscriberon_uu_idx
;

ALTER TABLE c_rfq_topicsubscriberonly ADD CONSTRAINT c_rfq_topicsubscriberon_uu_idx UNIQUE (c_rfq_topicsubscriberonly_uu)
;

DROP INDEX c_rfqline_uu_idx
;

ALTER TABLE c_rfqline ADD CONSTRAINT c_rfqline_uu_idx UNIQUE (c_rfqline_uu)
;

DROP INDEX c_rfqlineqty_uu_idx
;

ALTER TABLE c_rfqlineqty ADD CONSTRAINT c_rfqlineqty_uu_idx UNIQUE (c_rfqlineqty_uu)
;

DROP INDEX c_rfqresponse_uu_idx
;

ALTER TABLE c_rfqresponse ADD CONSTRAINT c_rfqresponse_uu_idx UNIQUE (c_rfqresponse_uu)
;

DROP INDEX c_rfqresponseline_uu_idx
;

ALTER TABLE c_rfqresponseline ADD CONSTRAINT c_rfqresponseline_uu_idx UNIQUE (c_rfqresponseline_uu)
;

DROP INDEX c_rfqresponselineqty_uu_idx
;

ALTER TABLE c_rfqresponselineqty ADD CONSTRAINT c_rfqresponselineqty_uu_idx UNIQUE (c_rfqresponselineqty_uu)
;

DROP INDEX c_salesregion_uu_idx
;

ALTER TABLE c_salesregion ADD CONSTRAINT c_salesregion_uu_idx UNIQUE (c_salesregion_uu)
;

DROP INDEX c_servicelevel_uu_idx
;

ALTER TABLE c_servicelevel ADD CONSTRAINT c_servicelevel_uu_idx UNIQUE (c_servicelevel_uu)
;

DROP INDEX c_servicelevelline_uu_idx
;

ALTER TABLE c_servicelevelline ADD CONSTRAINT c_servicelevelline_uu_idx UNIQUE (c_servicelevelline_uu)
;

DROP INDEX c_subacct_uu_idx
;

ALTER TABLE c_subacct ADD CONSTRAINT c_subacct_uu_idx UNIQUE (c_subacct_uu)
;

DROP INDEX c_subscription_uu_idx
;

ALTER TABLE c_subscription ADD CONSTRAINT c_subscription_uu_idx UNIQUE (c_subscription_uu)
;

DROP INDEX c_subscription_delivery_uu_idx
;

ALTER TABLE c_subscription_delivery ADD CONSTRAINT c_subscription_delivery_uu_idx UNIQUE (c_subscription_delivery_uu)
;

DROP INDEX c_subscriptiontype_uu_idx
;

ALTER TABLE c_subscriptiontype ADD CONSTRAINT c_subscriptiontype_uu_idx UNIQUE (c_subscriptiontype_uu)
;

DROP INDEX c_task_uu_idx
;

ALTER TABLE c_task ADD CONSTRAINT c_task_uu_idx UNIQUE (c_task_uu)
;

DROP INDEX c_tax_uu_idx
;

ALTER TABLE c_tax ADD CONSTRAINT c_tax_uu_idx UNIQUE (c_tax_uu)
;

DROP INDEX c_tax_acct_uu_idx
;

ALTER TABLE c_tax_acct ADD CONSTRAINT c_tax_acct_uu_idx UNIQUE (c_tax_acct_uu)
;

DROP INDEX c_tax_trl_uu_idx
;

ALTER TABLE c_tax_trl ADD CONSTRAINT c_tax_trl_uu_idx UNIQUE (c_tax_trl_uu)
;

DROP INDEX c_taxbase_uu_idx
;

ALTER TABLE c_taxbase ADD CONSTRAINT c_taxbase_uu_idx UNIQUE (c_taxbase_uu)
;

DROP INDEX c_taxcategory_uu_idx
;

ALTER TABLE c_taxcategory ADD CONSTRAINT c_taxcategory_uu_idx UNIQUE (c_taxcategory_uu)
;

DROP INDEX c_taxcategory_trl_uu_idx
;

ALTER TABLE c_taxcategory_trl ADD CONSTRAINT c_taxcategory_trl_uu_idx UNIQUE (c_taxcategory_trl_uu)
;

DROP INDEX c_taxdeclaration_uu_idx
;

ALTER TABLE c_taxdeclaration ADD CONSTRAINT c_taxdeclaration_uu_idx UNIQUE (c_taxdeclaration_uu)
;

DROP INDEX c_taxdeclarationacct_uu_idx
;

ALTER TABLE c_taxdeclarationacct ADD CONSTRAINT c_taxdeclarationacct_uu_idx UNIQUE (c_taxdeclarationacct_uu)
;

DROP INDEX c_taxdeclarationline_uu_idx
;

ALTER TABLE c_taxdeclarationline ADD CONSTRAINT c_taxdeclarationline_uu_idx UNIQUE (c_taxdeclarationline_uu)
;

DROP INDEX c_taxdefinition_uu_idx
;

ALTER TABLE c_taxdefinition ADD CONSTRAINT c_taxdefinition_uu_idx UNIQUE (c_taxdefinition_uu)
;

DROP INDEX c_taxgroup_uu_idx
;

ALTER TABLE c_taxgroup ADD CONSTRAINT c_taxgroup_uu_idx UNIQUE (c_taxgroup_uu)
;

DROP INDEX c_taxpostal_uu_idx
;

ALTER TABLE c_taxpostal ADD CONSTRAINT c_taxpostal_uu_idx UNIQUE (c_taxpostal_uu)
;

DROP INDEX c_taxtype_uu_idx
;

ALTER TABLE c_taxtype ADD CONSTRAINT c_taxtype_uu_idx UNIQUE (c_taxtype_uu)
;

DROP INDEX c_uom_uu_idx
;

ALTER TABLE c_uom ADD CONSTRAINT c_uom_uu_idx UNIQUE (c_uom_uu)
;

DROP INDEX c_uom_conversion_uu_idx
;

ALTER TABLE c_uom_conversion ADD CONSTRAINT c_uom_conversion_uu_idx UNIQUE (c_uom_conversion_uu)
;

DROP INDEX c_uom_trl_uu_idx
;

ALTER TABLE c_uom_trl ADD CONSTRAINT c_uom_trl_uu_idx UNIQUE (c_uom_trl_uu)
;

DROP INDEX c_userremuneration_uu_idx
;

ALTER TABLE c_userremuneration ADD CONSTRAINT c_userremuneration_uu_idx UNIQUE (c_userremuneration_uu)
;

DROP INDEX c_validcombination_uu_idx
;

ALTER TABLE c_validcombination ADD CONSTRAINT c_validcombination_uu_idx UNIQUE (c_validcombination_uu)
;

DROP INDEX c_withholding_uu_idx
;

ALTER TABLE c_withholding ADD CONSTRAINT c_withholding_uu_idx UNIQUE (c_withholding_uu)
;

DROP INDEX c_withholding_acct_uu_idx
;

ALTER TABLE c_withholding_acct ADD CONSTRAINT c_withholding_acct_uu_idx UNIQUE (c_withholding_acct_uu)
;

DROP INDEX c_year_uu_idx
;

ALTER TABLE c_year ADD CONSTRAINT c_year_uu_idx UNIQUE (c_year_uu)
;

DROP INDEX cm_accesscontainer_uu_idx
;

ALTER TABLE cm_accesscontainer ADD CONSTRAINT cm_accesscontainer_uu_idx UNIQUE (cm_accesscontainer_uu)
;

DROP INDEX cm_accesslistbpgroup_uu_idx
;

ALTER TABLE cm_accesslistbpgroup ADD CONSTRAINT cm_accesslistbpgroup_uu_idx UNIQUE (cm_accesslistbpgroup_uu)
;

DROP INDEX cm_accesslistrole_uu_idx
;

ALTER TABLE cm_accesslistrole ADD CONSTRAINT cm_accesslistrole_uu_idx UNIQUE (cm_accesslistrole_uu)
;

DROP INDEX cm_accessmedia_uu_idx
;

ALTER TABLE cm_accessmedia ADD CONSTRAINT cm_accessmedia_uu_idx UNIQUE (cm_accessmedia_uu)
;

DROP INDEX cm_accessnewschannel_uu_idx
;

ALTER TABLE cm_accessnewschannel ADD CONSTRAINT cm_accessnewschannel_uu_idx UNIQUE (cm_accessnewschannel_uu)
;

DROP INDEX cm_accessprofile_uu_idx
;

ALTER TABLE cm_accessprofile ADD CONSTRAINT cm_accessprofile_uu_idx UNIQUE (cm_accessprofile_uu)
;

DROP INDEX cm_accessstage_uu_idx
;

ALTER TABLE cm_accessstage ADD CONSTRAINT cm_accessstage_uu_idx UNIQUE (cm_accessstage_uu)
;

DROP INDEX cm_ad_uu_idx
;

ALTER TABLE cm_ad ADD CONSTRAINT cm_ad_uu_idx UNIQUE (cm_ad_uu)
;

DROP INDEX cm_ad_cat_uu_idx
;

ALTER TABLE cm_ad_cat ADD CONSTRAINT cm_ad_cat_uu_idx UNIQUE (cm_ad_cat_uu)
;

DROP INDEX cm_broadcastserver_uu_idx
;

ALTER TABLE cm_broadcastserver ADD CONSTRAINT cm_broadcastserver_uu_idx UNIQUE (cm_broadcastserver_uu)
;

DROP INDEX cm_chat_uu_idx
;

ALTER TABLE cm_chat ADD CONSTRAINT cm_chat_uu_idx UNIQUE (cm_chat_uu)
;

DROP INDEX cm_chatentry_uu_idx
;

ALTER TABLE cm_chatentry ADD CONSTRAINT cm_chatentry_uu_idx UNIQUE (cm_chatentry_uu)
;

DROP INDEX cm_chattype_uu_idx
;

ALTER TABLE cm_chattype ADD CONSTRAINT cm_chattype_uu_idx UNIQUE (cm_chattype_uu)
;

DROP INDEX cm_chattypeupdate_uu_idx
;

ALTER TABLE cm_chattypeupdate ADD CONSTRAINT cm_chattypeupdate_uu_idx UNIQUE (cm_chattypeupdate_uu)
;

DROP INDEX cm_chatupdate_uu_idx
;

ALTER TABLE cm_chatupdate ADD CONSTRAINT cm_chatupdate_uu_idx UNIQUE (cm_chatupdate_uu)
;

DROP INDEX cm_container_uu_idx
;

ALTER TABLE cm_container ADD CONSTRAINT cm_container_uu_idx UNIQUE (cm_container_uu)
;

DROP INDEX cm_container_element_uu_idx
;

ALTER TABLE cm_container_element ADD CONSTRAINT cm_container_element_uu_idx UNIQUE (cm_container_element_uu)
;

DROP INDEX cm_container_element_tr_uu_idx
;

ALTER TABLE cm_container_element_trl ADD CONSTRAINT cm_container_element_tr_uu_idx UNIQUE (cm_container_element_trl_uu)
;

DROP INDEX cm_container_trl_uu_idx
;

ALTER TABLE cm_container_trl ADD CONSTRAINT cm_container_trl_uu_idx UNIQUE (cm_container_trl_uu)
;

DROP INDEX cm_container_url_uu_idx
;

ALTER TABLE cm_container_url ADD CONSTRAINT cm_container_url_uu_idx UNIQUE (cm_container_url_uu)
;

DROP INDEX cm_containerttable_uu_idx
;

ALTER TABLE cm_containerttable ADD CONSTRAINT cm_containerttable_uu_idx UNIQUE (cm_containerttable_uu)
;

DROP INDEX cm_cstage_uu_idx
;

ALTER TABLE cm_cstage ADD CONSTRAINT cm_cstage_uu_idx UNIQUE (cm_cstage_uu)
;

DROP INDEX cm_cstage_element_uu_idx
;

ALTER TABLE cm_cstage_element ADD CONSTRAINT cm_cstage_element_uu_idx UNIQUE (cm_cstage_element_uu)
;

DROP INDEX cm_cstage_element_trl_uu_idx
;

ALTER TABLE cm_cstage_element_trl ADD CONSTRAINT cm_cstage_element_trl_uu_idx UNIQUE (cm_cstage_element_trl_uu)
;

DROP INDEX cm_cstage_trl_uu_idx
;

ALTER TABLE cm_cstage_trl ADD CONSTRAINT cm_cstage_trl_uu_idx UNIQUE (cm_cstage_trl_uu)
;

DROP INDEX cm_cstagettable_uu_idx
;

ALTER TABLE cm_cstagettable ADD CONSTRAINT cm_cstagettable_uu_idx UNIQUE (cm_cstagettable_uu)
;

DROP INDEX cm_media_uu_idx
;

ALTER TABLE cm_media ADD CONSTRAINT cm_media_uu_idx UNIQUE (cm_media_uu)
;

DROP INDEX cm_media_server_uu_idx
;

ALTER TABLE cm_media_server ADD CONSTRAINT cm_media_server_uu_idx UNIQUE (cm_media_server_uu)
;

DROP INDEX cm_mediadeploy_uu_idx
;

ALTER TABLE cm_mediadeploy ADD CONSTRAINT cm_mediadeploy_uu_idx UNIQUE (cm_mediadeploy_uu)
;

DROP INDEX cm_newschannel_uu_idx
;

ALTER TABLE cm_newschannel ADD CONSTRAINT cm_newschannel_uu_idx UNIQUE (cm_newschannel_uu)
;

DROP INDEX cm_newsitem_uu_idx
;

ALTER TABLE cm_newsitem ADD CONSTRAINT cm_newsitem_uu_idx UNIQUE (cm_newsitem_uu)
;

DROP INDEX cm_template_uu_idx
;

ALTER TABLE cm_template ADD CONSTRAINT cm_template_uu_idx UNIQUE (cm_template_uu)
;

DROP INDEX cm_template_ad_cat_uu_idx
;

ALTER TABLE cm_template_ad_cat ADD CONSTRAINT cm_template_ad_cat_uu_idx UNIQUE (cm_template_ad_cat_uu)
;

DROP INDEX cm_templatetable_uu_idx
;

ALTER TABLE cm_templatetable ADD CONSTRAINT cm_templatetable_uu_idx UNIQUE (cm_templatetable_uu)
;

DROP INDEX cm_webaccesslog_uu_idx
;

ALTER TABLE cm_webaccesslog ADD CONSTRAINT cm_webaccesslog_uu_idx UNIQUE (cm_webaccesslog_uu)
;

DROP INDEX cm_webproject_uu_idx
;

ALTER TABLE cm_webproject ADD CONSTRAINT cm_webproject_uu_idx UNIQUE (cm_webproject_uu)
;

DROP INDEX cm_webproject_domain_uu_idx
;

ALTER TABLE cm_webproject_domain ADD CONSTRAINT cm_webproject_domain_uu_idx UNIQUE (cm_webproject_domain_uu)
;

DROP INDEX cm_wikitoken_uu_idx
;

ALTER TABLE cm_wikitoken ADD CONSTRAINT cm_wikitoken_uu_idx UNIQUE (cm_wikitoken_uu)
;

DROP INDEX dd_networkdistribution_uu_idx
;

ALTER TABLE dd_networkdistribution ADD CONSTRAINT dd_networkdistribution_uu_idx UNIQUE (dd_networkdistribution_uu)
;

DROP INDEX dd_networkdistributionl_uu_idx
;

ALTER TABLE dd_networkdistributionline ADD CONSTRAINT dd_networkdistributionl_uu_idx UNIQUE (dd_networkdistributionline_uu)
;

DROP INDEX dd_order_uu_idx
;

ALTER TABLE dd_order ADD CONSTRAINT dd_order_uu_idx UNIQUE (dd_order_uu)
;

DROP INDEX dd_orderline_uu_idx
;

ALTER TABLE dd_orderline ADD CONSTRAINT dd_orderline_uu_idx UNIQUE (dd_orderline_uu)
;

DROP INDEX exp_format_uu_idx
;

ALTER TABLE exp_format ADD CONSTRAINT exp_format_uu_idx UNIQUE (exp_format_uu)
;

DROP INDEX exp_formatline_uu_idx
;

ALTER TABLE exp_formatline ADD CONSTRAINT exp_formatline_uu_idx UNIQUE (exp_formatline_uu)
;

DROP INDEX exp_processor_uu_idx
;

ALTER TABLE exp_processor ADD CONSTRAINT exp_processor_uu_idx UNIQUE (exp_processor_uu)
;

DROP INDEX exp_processor_type_uu_idx
;

ALTER TABLE exp_processor_type ADD CONSTRAINT exp_processor_type_uu_idx UNIQUE (exp_processor_type_uu)
;

DROP INDEX exp_processorparameter_uu_idx
;

ALTER TABLE exp_processorparameter ADD CONSTRAINT exp_processorparameter_uu_idx UNIQUE (exp_processorparameter_uu)
;

DROP INDEX fact_acct_uu_idx
;

ALTER TABLE fact_acct ADD CONSTRAINT fact_acct_uu_idx UNIQUE (fact_acct_uu)
;

DROP INDEX fact_acct_summary_uu_idx
;

ALTER TABLE fact_acct_summary ADD CONSTRAINT fact_acct_summary_uu_idx UNIQUE (fact_acct_summary_uu)
;

DROP INDEX fact_reconciliation_uu_idx
;

ALTER TABLE fact_reconciliation ADD CONSTRAINT fact_reconciliation_uu_idx UNIQUE (fact_reconciliation_uu)
;

DROP INDEX gl_budget_uu_idx
;

ALTER TABLE gl_budget ADD CONSTRAINT gl_budget_uu_idx UNIQUE (gl_budget_uu)
;

DROP INDEX gl_budgetcontrol_uu_idx
;

ALTER TABLE gl_budgetcontrol ADD CONSTRAINT gl_budgetcontrol_uu_idx UNIQUE (gl_budgetcontrol_uu)
;

DROP INDEX gl_category_uu_idx
;

ALTER TABLE gl_category ADD CONSTRAINT gl_category_uu_idx UNIQUE (gl_category_uu)
;

DROP INDEX gl_distribution_uu_idx
;

ALTER TABLE gl_distribution ADD CONSTRAINT gl_distribution_uu_idx UNIQUE (gl_distribution_uu)
;

DROP INDEX gl_distributionline_uu_idx
;

ALTER TABLE gl_distributionline ADD CONSTRAINT gl_distributionline_uu_idx UNIQUE (gl_distributionline_uu)
;

DROP INDEX gl_fund_uu_idx
;

ALTER TABLE gl_fund ADD CONSTRAINT gl_fund_uu_idx UNIQUE (gl_fund_uu)
;

DROP INDEX gl_fundrestriction_uu_idx
;

ALTER TABLE gl_fundrestriction ADD CONSTRAINT gl_fundrestriction_uu_idx UNIQUE (gl_fundrestriction_uu)
;

DROP INDEX gl_journal_uu_idx
;

ALTER TABLE gl_journal ADD CONSTRAINT gl_journal_uu_idx UNIQUE (gl_journal_uu)
;

DROP INDEX gl_journalbatch_uu_idx
;

ALTER TABLE gl_journalbatch ADD CONSTRAINT gl_journalbatch_uu_idx UNIQUE (gl_journalbatch_uu)
;

DROP INDEX gl_journalgenerator_uu_idx
;

ALTER TABLE gl_journalgenerator ADD CONSTRAINT gl_journalgenerator_uu_idx UNIQUE (gl_journalgenerator_uu)
;

DROP INDEX gl_journalgeneratorline_uu_idx
;

ALTER TABLE gl_journalgeneratorline ADD CONSTRAINT gl_journalgeneratorline_uu_idx UNIQUE (gl_journalgeneratorline_uu)
;

DROP INDEX gl_journalgeneratorsour_uu_idx
;

ALTER TABLE gl_journalgeneratorsource ADD CONSTRAINT gl_journalgeneratorsour_uu_idx UNIQUE (gl_journalgeneratorsource_uu)
;

DROP INDEX gl_journalline_uu_idx
;

ALTER TABLE gl_journalline ADD CONSTRAINT gl_journalline_uu_idx UNIQUE (gl_journalline_uu)
;

DROP INDEX hr_attribute_uu_idx
;

ALTER TABLE hr_attribute ADD CONSTRAINT hr_attribute_uu_idx UNIQUE (hr_attribute_uu)
;

DROP INDEX hr_concept_uu_idx
;

ALTER TABLE hr_concept ADD CONSTRAINT hr_concept_uu_idx UNIQUE (hr_concept_uu)
;

DROP INDEX hr_concept_acct_uu_idx
;

ALTER TABLE hr_concept_acct ADD CONSTRAINT hr_concept_acct_uu_idx UNIQUE (hr_concept_acct_uu)
;

DROP INDEX hr_concept_category_uu_idx
;

ALTER TABLE hr_concept_category ADD CONSTRAINT hr_concept_category_uu_idx UNIQUE (hr_concept_category_uu)
;

DROP INDEX hr_contract_uu_idx
;

ALTER TABLE hr_contract ADD CONSTRAINT hr_contract_uu_idx UNIQUE (hr_contract_uu)
;

DROP INDEX hr_department_uu_idx
;

ALTER TABLE hr_department ADD CONSTRAINT hr_department_uu_idx UNIQUE (hr_department_uu)
;

DROP INDEX hr_employee_uu_idx
;

ALTER TABLE hr_employee ADD CONSTRAINT hr_employee_uu_idx UNIQUE (hr_employee_uu)
;

DROP INDEX hr_job_uu_idx
;

ALTER TABLE hr_job ADD CONSTRAINT hr_job_uu_idx UNIQUE (hr_job_uu)
;

DROP INDEX hr_list_uu_idx
;

ALTER TABLE hr_list ADD CONSTRAINT hr_list_uu_idx UNIQUE (hr_list_uu)
;

DROP INDEX hr_listline_uu_idx
;

ALTER TABLE hr_listline ADD CONSTRAINT hr_listline_uu_idx UNIQUE (hr_listline_uu)
;

DROP INDEX hr_listtype_uu_idx
;

ALTER TABLE hr_listtype ADD CONSTRAINT hr_listtype_uu_idx UNIQUE (hr_listtype_uu)
;

DROP INDEX hr_listversion_uu_idx
;

ALTER TABLE hr_listversion ADD CONSTRAINT hr_listversion_uu_idx UNIQUE (hr_listversion_uu)
;

DROP INDEX hr_movement_uu_idx
;

ALTER TABLE hr_movement ADD CONSTRAINT hr_movement_uu_idx UNIQUE (hr_movement_uu)
;

DROP INDEX hr_payroll_uu_idx
;

ALTER TABLE hr_payroll ADD CONSTRAINT hr_payroll_uu_idx UNIQUE (hr_payroll_uu)
;

DROP INDEX hr_payrollconcept_uu_idx
;

ALTER TABLE hr_payrollconcept ADD CONSTRAINT hr_payrollconcept_uu_idx UNIQUE (hr_payrollconcept_uu)
;

DROP INDEX hr_period_uu_idx
;

ALTER TABLE hr_period ADD CONSTRAINT hr_period_uu_idx UNIQUE (hr_period_uu)
;

DROP INDEX hr_process_uu_idx
;

ALTER TABLE hr_process ADD CONSTRAINT hr_process_uu_idx UNIQUE (hr_process_uu)
;

DROP INDEX hr_year_uu_idx
;

ALTER TABLE hr_year ADD CONSTRAINT hr_year_uu_idx UNIQUE (hr_year_uu)
;

DROP INDEX i_asset_uu_idx
;

ALTER TABLE i_asset ADD CONSTRAINT i_asset_uu_idx UNIQUE (i_asset_uu)
;

DROP INDEX i_bankstatement_uu_idx
;

ALTER TABLE i_bankstatement ADD CONSTRAINT i_bankstatement_uu_idx UNIQUE (i_bankstatement_uu)
;

DROP INDEX i_bpartner_uu_idx
;

ALTER TABLE i_bpartner ADD CONSTRAINT i_bpartner_uu_idx UNIQUE (i_bpartner_uu)
;

DROP INDEX i_conversion_rate_uu_idx
;

ALTER TABLE i_conversion_rate ADD CONSTRAINT i_conversion_rate_uu_idx UNIQUE (i_conversion_rate_uu)
;

DROP INDEX i_elementvalue_uu_idx
;

ALTER TABLE i_elementvalue ADD CONSTRAINT i_elementvalue_uu_idx UNIQUE (i_elementvalue_uu)
;

DROP INDEX i_fajournal_uu_idx
;

ALTER TABLE i_fajournal ADD CONSTRAINT i_fajournal_uu_idx UNIQUE (i_fajournal_uu)
;

DROP INDEX i_fixedasset_uu_idx
;

ALTER TABLE i_fixedasset ADD CONSTRAINT i_fixedasset_uu_idx UNIQUE (i_fixedasset_uu)
;

DROP INDEX i_gljournal_uu_idx
;

ALTER TABLE i_gljournal ADD CONSTRAINT i_gljournal_uu_idx UNIQUE (i_gljournal_uu)
;

DROP INDEX i_hr_movement_uu_idx
;

ALTER TABLE i_hr_movement ADD CONSTRAINT i_hr_movement_uu_idx UNIQUE (i_hr_movement_uu)
;

DROP INDEX i_inoutlineconfirm_uu_idx
;

ALTER TABLE i_inoutlineconfirm ADD CONSTRAINT i_inoutlineconfirm_uu_idx UNIQUE (i_inoutlineconfirm_uu)
;

DROP INDEX i_inventory_uu_idx
;

ALTER TABLE i_inventory ADD CONSTRAINT i_inventory_uu_idx UNIQUE (i_inventory_uu)
;

DROP INDEX i_invoice_uu_idx
;

ALTER TABLE i_invoice ADD CONSTRAINT i_invoice_uu_idx UNIQUE (i_invoice_uu)
;

DROP INDEX i_movement_uu_idx
;

ALTER TABLE i_movement ADD CONSTRAINT i_movement_uu_idx UNIQUE (i_movement_uu)
;

DROP INDEX i_order_uu_idx
;

ALTER TABLE i_order ADD CONSTRAINT i_order_uu_idx UNIQUE (i_order_uu)
;

DROP INDEX i_payment_uu_idx
;

ALTER TABLE i_payment ADD CONSTRAINT i_payment_uu_idx UNIQUE (i_payment_uu)
;

DROP INDEX i_pricelist_uu_idx
;

ALTER TABLE i_pricelist ADD CONSTRAINT i_pricelist_uu_idx UNIQUE (i_pricelist_uu)
;

DROP INDEX i_product_uu_idx
;

ALTER TABLE i_product ADD CONSTRAINT i_product_uu_idx UNIQUE (i_product_uu)
;

DROP INDEX i_productplanning_uu_idx
;

ALTER TABLE i_productplanning ADD CONSTRAINT i_productplanning_uu_idx UNIQUE (i_productplanning_uu)
;

DROP INDEX i_reportline_uu_idx
;

ALTER TABLE i_reportline ADD CONSTRAINT i_reportline_uu_idx UNIQUE (i_reportline_uu)
;

DROP INDEX imp_processor_uu_idx
;

ALTER TABLE imp_processor ADD CONSTRAINT imp_processor_uu_idx UNIQUE (imp_processor_uu)
;

DROP INDEX imp_processor_type_uu_idx
;

ALTER TABLE imp_processor_type ADD CONSTRAINT imp_processor_type_uu_idx UNIQUE (imp_processor_type_uu)
;

DROP INDEX imp_processorlog_uu_idx
;

ALTER TABLE imp_processorlog ADD CONSTRAINT imp_processorlog_uu_idx UNIQUE (imp_processorlog_uu)
;

DROP INDEX imp_processorparameter_uu_idx
;

ALTER TABLE imp_processorparameter ADD CONSTRAINT imp_processorparameter_uu_idx UNIQUE (imp_processorparameter_uu)
;

DROP INDEX k_category_uu_idx
;

ALTER TABLE k_category ADD CONSTRAINT k_category_uu_idx UNIQUE (k_category_uu)
;

DROP INDEX k_categoryvalue_uu_idx
;

ALTER TABLE k_categoryvalue ADD CONSTRAINT k_categoryvalue_uu_idx UNIQUE (k_categoryvalue_uu)
;

DROP INDEX k_comment_uu_idx
;

ALTER TABLE k_comment ADD CONSTRAINT k_comment_uu_idx UNIQUE (k_comment_uu)
;

DROP INDEX k_entry_uu_idx
;

ALTER TABLE k_entry ADD CONSTRAINT k_entry_uu_idx UNIQUE (k_entry_uu)
;

DROP INDEX k_entrycategory_uu_idx
;

ALTER TABLE k_entrycategory ADD CONSTRAINT k_entrycategory_uu_idx UNIQUE (k_entrycategory_uu)
;

DROP INDEX k_entryrelated_uu_idx
;

ALTER TABLE k_entryrelated ADD CONSTRAINT k_entryrelated_uu_idx UNIQUE (k_entryrelated_uu)
;

DROP INDEX k_index_uu_idx
;

ALTER TABLE k_index ADD CONSTRAINT k_index_uu_idx UNIQUE (k_index_uu)
;

DROP INDEX k_indexlog_uu_idx
;

ALTER TABLE k_indexlog ADD CONSTRAINT k_indexlog_uu_idx UNIQUE (k_indexlog_uu)
;

DROP INDEX k_indexstop_uu_idx
;

ALTER TABLE k_indexstop ADD CONSTRAINT k_indexstop_uu_idx UNIQUE (k_indexstop_uu)
;

DROP INDEX k_source_uu_idx
;

ALTER TABLE k_source ADD CONSTRAINT k_source_uu_idx UNIQUE (k_source_uu)
;

DROP INDEX k_synonym_uu_idx
;

ALTER TABLE k_synonym ADD CONSTRAINT k_synonym_uu_idx UNIQUE (k_synonym_uu)
;

DROP INDEX k_topic_uu_idx
;

ALTER TABLE k_topic ADD CONSTRAINT k_topic_uu_idx UNIQUE (k_topic_uu)
;

DROP INDEX k_type_uu_idx
;

ALTER TABLE k_type ADD CONSTRAINT k_type_uu_idx UNIQUE (k_type_uu)
;

DROP INDEX m_attribute_uu_idx
;

ALTER TABLE m_attribute ADD CONSTRAINT m_attribute_uu_idx UNIQUE (m_attribute_uu)
;

DROP INDEX m_attributeinstance_uu_idx
;

ALTER TABLE m_attributeinstance ADD CONSTRAINT m_attributeinstance_uu_idx UNIQUE (m_attributeinstance_uu)
;

DROP INDEX m_attributesearch_uu_idx
;

ALTER TABLE m_attributesearch ADD CONSTRAINT m_attributesearch_uu_idx UNIQUE (m_attributesearch_uu)
;

DROP INDEX m_attributeset_uu_idx
;

ALTER TABLE m_attributeset ADD CONSTRAINT m_attributeset_uu_idx UNIQUE (m_attributeset_uu)
;

DROP INDEX m_attributesetexclude_uu_idx
;

ALTER TABLE m_attributesetexclude ADD CONSTRAINT m_attributesetexclude_uu_idx UNIQUE (m_attributesetexclude_uu)
;

DROP INDEX m_attributesetinstance_uu_idx
;

ALTER TABLE m_attributesetinstance ADD CONSTRAINT m_attributesetinstance_uu_idx UNIQUE (m_attributesetinstance_uu)
;

DROP INDEX m_attributeuse_uu_idx
;

ALTER TABLE m_attributeuse ADD CONSTRAINT m_attributeuse_uu_idx UNIQUE (m_attributeuse_uu)
;

DROP INDEX m_attributevalue_uu_idx
;

ALTER TABLE m_attributevalue ADD CONSTRAINT m_attributevalue_uu_idx UNIQUE (m_attributevalue_uu)
;

DROP INDEX m_bom_uu_idx
;

ALTER TABLE m_bom ADD CONSTRAINT m_bom_uu_idx UNIQUE (m_bom_uu)
;

DROP INDEX m_bomalternative_uu_idx
;

ALTER TABLE m_bomalternative ADD CONSTRAINT m_bomalternative_uu_idx UNIQUE (m_bomalternative_uu)
;

DROP INDEX m_bomproduct_uu_idx
;

ALTER TABLE m_bomproduct ADD CONSTRAINT m_bomproduct_uu_idx UNIQUE (m_bomproduct_uu)
;

DROP INDEX m_changenotice_uu_idx
;

ALTER TABLE m_changenotice ADD CONSTRAINT m_changenotice_uu_idx UNIQUE (m_changenotice_uu)
;

DROP INDEX m_changerequest_uu_idx
;

ALTER TABLE m_changerequest ADD CONSTRAINT m_changerequest_uu_idx UNIQUE (m_changerequest_uu)
;

DROP INDEX m_commodityshipment_uu_idx
;

ALTER TABLE m_commodityshipment ADD CONSTRAINT m_commodityshipment_uu_idx UNIQUE (m_commodityshipment_uu)
;

DROP INDEX m_cost_uu_idx
;

ALTER TABLE m_cost ADD CONSTRAINT m_cost_uu_idx UNIQUE (m_cost_uu)
;

DROP INDEX m_costdetail_uu_idx
;

ALTER TABLE m_costdetail ADD CONSTRAINT m_costdetail_uu_idx UNIQUE (m_costdetail_uu)
;

DROP INDEX m_costelement_uu_idx
;

ALTER TABLE m_costelement ADD CONSTRAINT m_costelement_uu_idx UNIQUE (m_costelement_uu)
;

DROP INDEX m_costhistory_uu_idx
;

ALTER TABLE m_costhistory ADD CONSTRAINT m_costhistory_uu_idx UNIQUE (m_costhistory_uu)
;

DROP INDEX m_costqueue_uu_idx
;

ALTER TABLE m_costqueue ADD CONSTRAINT m_costqueue_uu_idx UNIQUE (m_costqueue_uu)
;

DROP INDEX m_costtype_uu_idx
;

ALTER TABLE m_costtype ADD CONSTRAINT m_costtype_uu_idx UNIQUE (m_costtype_uu)
;

DROP INDEX m_demand_uu_idx
;

ALTER TABLE m_demand ADD CONSTRAINT m_demand_uu_idx UNIQUE (m_demand_uu)
;

DROP INDEX m_demanddetail_uu_idx
;

ALTER TABLE m_demanddetail ADD CONSTRAINT m_demanddetail_uu_idx UNIQUE (m_demanddetail_uu)
;

DROP INDEX m_demandline_uu_idx
;

ALTER TABLE m_demandline ADD CONSTRAINT m_demandline_uu_idx UNIQUE (m_demandline_uu)
;

DROP INDEX m_discountschema_uu_idx
;

ALTER TABLE m_discountschema ADD CONSTRAINT m_discountschema_uu_idx UNIQUE (m_discountschema_uu)
;

DROP INDEX m_discountschemabreak_uu_idx
;

ALTER TABLE m_discountschemabreak ADD CONSTRAINT m_discountschemabreak_uu_idx UNIQUE (m_discountschemabreak_uu)
;

DROP INDEX m_discountschemaline_uu_idx
;

ALTER TABLE m_discountschemaline ADD CONSTRAINT m_discountschemaline_uu_idx UNIQUE (m_discountschemaline_uu)
;

DROP INDEX m_distributionlist_uu_idx
;

ALTER TABLE m_distributionlist ADD CONSTRAINT m_distributionlist_uu_idx UNIQUE (m_distributionlist_uu)
;

DROP INDEX m_distributionlistline_uu_idx
;

ALTER TABLE m_distributionlistline ADD CONSTRAINT m_distributionlistline_uu_idx UNIQUE (m_distributionlistline_uu)
;

DROP INDEX m_distributionrun_uu_idx
;

ALTER TABLE m_distributionrun ADD CONSTRAINT m_distributionrun_uu_idx UNIQUE (m_distributionrun_uu)
;

DROP INDEX m_distributionrunline_uu_idx
;

ALTER TABLE m_distributionrunline ADD CONSTRAINT m_distributionrunline_uu_idx UNIQUE (m_distributionrunline_uu)
;

DROP INDEX m_forecast_uu_idx
;

ALTER TABLE m_forecast ADD CONSTRAINT m_forecast_uu_idx UNIQUE (m_forecast_uu)
;

DROP INDEX m_forecastline_uu_idx
;

ALTER TABLE m_forecastline ADD CONSTRAINT m_forecastline_uu_idx UNIQUE (m_forecastline_uu)
;

DROP INDEX m_freight_uu_idx
;

ALTER TABLE m_freight ADD CONSTRAINT m_freight_uu_idx UNIQUE (m_freight_uu)
;

DROP INDEX m_freightcategory_uu_idx
;

ALTER TABLE m_freightcategory ADD CONSTRAINT m_freightcategory_uu_idx UNIQUE (m_freightcategory_uu)
;

DROP INDEX m_inout_uu_idx
;

ALTER TABLE m_inout ADD CONSTRAINT m_inout_uu_idx UNIQUE (m_inout_uu)
;

DROP INDEX m_inoutconfirm_uu_idx
;

ALTER TABLE m_inoutconfirm ADD CONSTRAINT m_inoutconfirm_uu_idx UNIQUE (m_inoutconfirm_uu)
;

DROP INDEX m_inoutline_uu_idx
;

ALTER TABLE m_inoutline ADD CONSTRAINT m_inoutline_uu_idx UNIQUE (m_inoutline_uu)
;

DROP INDEX m_inoutlineconfirm_uu_idx
;

ALTER TABLE m_inoutlineconfirm ADD CONSTRAINT m_inoutlineconfirm_uu_idx UNIQUE (m_inoutlineconfirm_uu)
;

DROP INDEX m_inoutlinema_uu_idx
;

ALTER TABLE m_inoutlinema ADD CONSTRAINT m_inoutlinema_uu_idx UNIQUE (m_inoutlinema_uu)
;

DROP INDEX m_inventory_uu_idx
;

ALTER TABLE m_inventory ADD CONSTRAINT m_inventory_uu_idx UNIQUE (m_inventory_uu)
;

DROP INDEX m_inventoryline_uu_idx
;

ALTER TABLE m_inventoryline ADD CONSTRAINT m_inventoryline_uu_idx UNIQUE (m_inventoryline_uu)
;

DROP INDEX m_inventorylinema_uu_idx
;

ALTER TABLE m_inventorylinema ADD CONSTRAINT m_inventorylinema_uu_idx UNIQUE (m_inventorylinema_uu)
;

DROP INDEX m_locator_uu_idx
;

ALTER TABLE m_locator ADD CONSTRAINT m_locator_uu_idx UNIQUE (m_locator_uu)
;

DROP INDEX m_lot_uu_idx
;

ALTER TABLE m_lot ADD CONSTRAINT m_lot_uu_idx UNIQUE (m_lot_uu)
;

DROP INDEX m_lotctl_uu_idx
;

ALTER TABLE m_lotctl ADD CONSTRAINT m_lotctl_uu_idx UNIQUE (m_lotctl_uu)
;

DROP INDEX m_lotctlexclude_uu_idx
;

ALTER TABLE m_lotctlexclude ADD CONSTRAINT m_lotctlexclude_uu_idx UNIQUE (m_lotctlexclude_uu)
;

DROP INDEX m_matchinv_uu_idx
;

ALTER TABLE m_matchinv ADD CONSTRAINT m_matchinv_uu_idx UNIQUE (m_matchinv_uu)
;

DROP INDEX m_matchpo_uu_idx
;

ALTER TABLE m_matchpo ADD CONSTRAINT m_matchpo_uu_idx UNIQUE (m_matchpo_uu)
;

DROP INDEX m_movement_uu_idx
;

ALTER TABLE m_movement ADD CONSTRAINT m_movement_uu_idx UNIQUE (m_movement_uu)
;

DROP INDEX m_movementconfirm_uu_idx
;

ALTER TABLE m_movementconfirm ADD CONSTRAINT m_movementconfirm_uu_idx UNIQUE (m_movementconfirm_uu)
;

DROP INDEX m_movementline_uu_idx
;

ALTER TABLE m_movementline ADD CONSTRAINT m_movementline_uu_idx UNIQUE (m_movementline_uu)
;

DROP INDEX m_movementlineconfirm_uu_idx
;

ALTER TABLE m_movementlineconfirm ADD CONSTRAINT m_movementlineconfirm_uu_idx UNIQUE (m_movementlineconfirm_uu)
;

DROP INDEX m_movementlinema_uu_idx
;

ALTER TABLE m_movementlinema ADD CONSTRAINT m_movementlinema_uu_idx UNIQUE (m_movementlinema_uu)
;

DROP INDEX m_operationresource_uu_idx
;

ALTER TABLE m_operationresource ADD CONSTRAINT m_operationresource_uu_idx UNIQUE (m_operationresource_uu)
;

DROP INDEX m_package_uu_idx
;

ALTER TABLE m_package ADD CONSTRAINT m_package_uu_idx UNIQUE (m_package_uu)
;

DROP INDEX m_packageline_uu_idx
;

ALTER TABLE m_packageline ADD CONSTRAINT m_packageline_uu_idx UNIQUE (m_packageline_uu)
;

DROP INDEX m_packagemps_uu_idx
;

ALTER TABLE m_packagemps ADD CONSTRAINT m_packagemps_uu_idx UNIQUE (m_packagemps_uu)
;

DROP INDEX m_parttype_uu_idx
;

ALTER TABLE m_parttype ADD CONSTRAINT m_parttype_uu_idx UNIQUE (m_parttype_uu)
;

DROP INDEX m_perpetualinv_uu_idx
;

ALTER TABLE m_perpetualinv ADD CONSTRAINT m_perpetualinv_uu_idx UNIQUE (m_perpetualinv_uu)
;

DROP INDEX m_pricelist_uu_idx
;

ALTER TABLE m_pricelist ADD CONSTRAINT m_pricelist_uu_idx UNIQUE (m_pricelist_uu)
;

DROP INDEX m_pricelist_version_uu_idx
;

ALTER TABLE m_pricelist_version ADD CONSTRAINT m_pricelist_version_uu_idx UNIQUE (m_pricelist_version_uu)
;

DROP INDEX m_product_uu_idx
;

ALTER TABLE m_product ADD CONSTRAINT m_product_uu_idx UNIQUE (m_product_uu)
;

DROP INDEX m_product_acct_uu_idx
;

ALTER TABLE m_product_acct ADD CONSTRAINT m_product_acct_uu_idx UNIQUE (m_product_acct_uu)
;

DROP INDEX m_product_category_uu_idx
;

ALTER TABLE m_product_category ADD CONSTRAINT m_product_category_uu_idx UNIQUE (m_product_category_uu)
;

DROP INDEX m_product_category_acct_uu_idx
;

ALTER TABLE m_product_category_acct ADD CONSTRAINT m_product_category_acct_uu_idx UNIQUE (m_product_category_acct_uu)
;

DROP INDEX m_product_po_uu_idx
;

ALTER TABLE m_product_po ADD CONSTRAINT m_product_po_uu_idx UNIQUE (m_product_po_uu)
;

DROP INDEX m_product_qualitytest_uu_idx
;

ALTER TABLE m_product_qualitytest ADD CONSTRAINT m_product_qualitytest_uu_idx UNIQUE (m_product_qualitytest_uu)
;

DROP INDEX m_product_trl_uu_idx
;

ALTER TABLE m_product_trl ADD CONSTRAINT m_product_trl_uu_idx UNIQUE (m_product_trl_uu)
;

DROP INDEX m_productdownload_uu_idx
;

ALTER TABLE m_productdownload ADD CONSTRAINT m_productdownload_uu_idx UNIQUE (m_productdownload_uu)
;

DROP INDEX m_production_uu_idx
;

ALTER TABLE m_production ADD CONSTRAINT m_production_uu_idx UNIQUE (m_production_uu)
;

DROP INDEX m_productionline_uu_idx
;

ALTER TABLE m_productionline ADD CONSTRAINT m_productionline_uu_idx UNIQUE (m_productionline_uu)
;

DROP INDEX m_productionlinema_uu_idx
;

ALTER TABLE m_productionlinema ADD CONSTRAINT m_productionlinema_uu_idx UNIQUE (m_productionlinema_uu)
;

DROP INDEX m_productionplan_uu_idx
;

ALTER TABLE m_productionplan ADD CONSTRAINT m_productionplan_uu_idx UNIQUE (m_productionplan_uu)
;

DROP INDEX m_productoperation_uu_idx
;

ALTER TABLE m_productoperation ADD CONSTRAINT m_productoperation_uu_idx UNIQUE (m_productoperation_uu)
;

DROP INDEX m_productprice_uu_idx
;

ALTER TABLE m_productprice ADD CONSTRAINT m_productprice_uu_idx UNIQUE (m_productprice_uu)
;

DROP INDEX m_productpricevendorbre_uu_idx
;

ALTER TABLE m_productpricevendorbreak ADD CONSTRAINT m_productpricevendorbre_uu_idx UNIQUE (m_productpricevendorbreak_uu)
;

DROP INDEX m_promotion_uu_idx
;

ALTER TABLE m_promotion ADD CONSTRAINT m_promotion_uu_idx UNIQUE (m_promotion_uu)
;

DROP INDEX m_promotiondistribution_uu_idx
;

ALTER TABLE m_promotiondistribution ADD CONSTRAINT m_promotiondistribution_uu_idx UNIQUE (m_promotiondistribution_uu)
;

DROP INDEX m_promotiongroup_uu_idx
;

ALTER TABLE m_promotiongroup ADD CONSTRAINT m_promotiongroup_uu_idx UNIQUE (m_promotiongroup_uu)
;

DROP INDEX m_promotiongroupline_uu_idx
;

ALTER TABLE m_promotiongroupline ADD CONSTRAINT m_promotiongroupline_uu_idx UNIQUE (m_promotiongroupline_uu)
;

DROP INDEX m_promotionline_uu_idx
;

ALTER TABLE m_promotionline ADD CONSTRAINT m_promotionline_uu_idx UNIQUE (m_promotionline_uu)
;

DROP INDEX m_promotionprecondition_uu_idx
;

ALTER TABLE m_promotionprecondition ADD CONSTRAINT m_promotionprecondition_uu_idx UNIQUE (m_promotionprecondition_uu)
;

DROP INDEX m_promotionreward_uu_idx
;

ALTER TABLE m_promotionreward ADD CONSTRAINT m_promotionreward_uu_idx UNIQUE (m_promotionreward_uu)
;

DROP INDEX m_qualitytest_uu_idx
;

ALTER TABLE m_qualitytest ADD CONSTRAINT m_qualitytest_uu_idx UNIQUE (m_qualitytest_uu)
;

DROP INDEX m_qualitytestresult_uu_idx
;

ALTER TABLE m_qualitytestresult ADD CONSTRAINT m_qualitytestresult_uu_idx UNIQUE (m_qualitytestresult_uu)
;

DROP INDEX m_relatedproduct_uu_idx
;

ALTER TABLE m_relatedproduct ADD CONSTRAINT m_relatedproduct_uu_idx UNIQUE (m_relatedproduct_uu)
;

DROP INDEX m_replenish_uu_idx
;

ALTER TABLE m_replenish ADD CONSTRAINT m_replenish_uu_idx UNIQUE (m_replenish_uu)
;

DROP INDEX m_requisition_uu_idx
;

ALTER TABLE m_requisition ADD CONSTRAINT m_requisition_uu_idx UNIQUE (m_requisition_uu)
;

DROP INDEX m_requisitionline_uu_idx
;

ALTER TABLE m_requisitionline ADD CONSTRAINT m_requisitionline_uu_idx UNIQUE (m_requisitionline_uu)
;

DROP INDEX m_rma_uu_idx
;

ALTER TABLE m_rma ADD CONSTRAINT m_rma_uu_idx UNIQUE (m_rma_uu)
;

DROP INDEX m_rmaline_uu_idx
;

ALTER TABLE m_rmaline ADD CONSTRAINT m_rmaline_uu_idx UNIQUE (m_rmaline_uu)
;

DROP INDEX m_rmatax_uu_idx
;

ALTER TABLE m_rmatax ADD CONSTRAINT m_rmatax_uu_idx UNIQUE (m_rmatax_uu)
;

DROP INDEX m_rmatype_uu_idx
;

ALTER TABLE m_rmatype ADD CONSTRAINT m_rmatype_uu_idx UNIQUE (m_rmatype_uu)
;

DROP INDEX m_sernoctl_uu_idx
;

ALTER TABLE m_sernoctl ADD CONSTRAINT m_sernoctl_uu_idx UNIQUE (m_sernoctl_uu)
;

DROP INDEX m_sernoctlexclude_uu_idx
;

ALTER TABLE m_sernoctlexclude ADD CONSTRAINT m_sernoctlexclude_uu_idx UNIQUE (m_sernoctlexclude_uu)
;

DROP INDEX m_shipper_uu_idx
;

ALTER TABLE m_shipper ADD CONSTRAINT m_shipper_uu_idx UNIQUE (m_shipper_uu)
;

DROP INDEX m_shippercfg_uu_idx
;

ALTER TABLE m_shippercfg ADD CONSTRAINT m_shippercfg_uu_idx UNIQUE (m_shippercfg_uu)
;

DROP INDEX m_shipperlabels_uu_idx
;

ALTER TABLE m_shipperlabels ADD CONSTRAINT m_shipperlabels_uu_idx UNIQUE (m_shipperlabels_uu)
;

DROP INDEX m_shipperlabelscfg_uu_idx
;

ALTER TABLE m_shipperlabelscfg ADD CONSTRAINT m_shipperlabelscfg_uu_idx UNIQUE (m_shipperlabelscfg_uu)
;

DROP INDEX m_shipperpackaging_uu_idx
;

ALTER TABLE m_shipperpackaging ADD CONSTRAINT m_shipperpackaging_uu_idx UNIQUE (m_shipperpackaging_uu)
;

DROP INDEX m_shipperpackagingcfg_uu_idx
;

ALTER TABLE m_shipperpackagingcfg ADD CONSTRAINT m_shipperpackagingcfg_uu_idx UNIQUE (m_shipperpackagingcfg_uu)
;

DROP INDEX m_shipperpickuptypes_uu_idx
;

ALTER TABLE m_shipperpickuptypes ADD CONSTRAINT m_shipperpickuptypes_uu_idx UNIQUE (m_shipperpickuptypes_uu)
;

DROP INDEX m_shipperpickuptypescfg_uu_idx
;

ALTER TABLE m_shipperpickuptypescfg ADD CONSTRAINT m_shipperpickuptypescfg_uu_idx UNIQUE (m_shipperpickuptypescfg_uu)
;

DROP INDEX m_shippingprocessor_uu_idx
;

ALTER TABLE m_shippingprocessor ADD CONSTRAINT m_shippingprocessor_uu_idx UNIQUE (m_shippingprocessor_uu)
;

DROP INDEX m_shippingprocessorcfg_uu_idx
;

ALTER TABLE m_shippingprocessorcfg ADD CONSTRAINT m_shippingprocessorcfg_uu_idx UNIQUE (m_shippingprocessorcfg_uu)
;

DROP INDEX m_shippingtransaction_uu_idx
;

ALTER TABLE m_shippingtransaction ADD CONSTRAINT m_shippingtransaction_uu_idx UNIQUE (m_shippingtransaction_uu)
;

DROP INDEX m_shippingtransactionli_uu_idx
;

ALTER TABLE m_shippingtransactionline ADD CONSTRAINT m_shippingtransactionli_uu_idx UNIQUE (m_shippingtransactionline_uu)
;

DROP INDEX m_storageonhand_uu_idx
;

ALTER TABLE m_storageonhand ADD CONSTRAINT m_storageonhand_uu_idx UNIQUE (m_storageonhand_uu)
;

DROP INDEX m_storagereservation_uu_idx
;

ALTER TABLE m_storagereservation ADD CONSTRAINT m_storagereservation_uu_idx UNIQUE (m_storagereservation_uu)
;

DROP INDEX m_substitute_uu_idx
;

ALTER TABLE m_substitute ADD CONSTRAINT m_substitute_uu_idx UNIQUE (m_substitute_uu)
;

DROP INDEX m_transaction_uu_idx
;

ALTER TABLE m_transaction ADD CONSTRAINT m_transaction_uu_idx UNIQUE (m_transaction_uu)
;

DROP INDEX m_transactionallocation_uu_idx
;

ALTER TABLE m_transactionallocation ADD CONSTRAINT m_transactionallocation_uu_idx UNIQUE (m_transactionallocation_uu)
;

DROP INDEX m_warehouse_uu_idx
;

ALTER TABLE m_warehouse ADD CONSTRAINT m_warehouse_uu_idx UNIQUE (m_warehouse_uu)
;

DROP INDEX m_warehouse_acct_uu_idx
;

ALTER TABLE m_warehouse_acct ADD CONSTRAINT m_warehouse_acct_uu_idx UNIQUE (m_warehouse_acct_uu)
;

DROP INDEX pa_achievement_uu_idx
;

ALTER TABLE pa_achievement ADD CONSTRAINT pa_achievement_uu_idx UNIQUE (pa_achievement_uu)
;

DROP INDEX pa_benchmark_uu_idx
;

ALTER TABLE pa_benchmark ADD CONSTRAINT pa_benchmark_uu_idx UNIQUE (pa_benchmark_uu)
;

DROP INDEX pa_benchmarkdata_uu_idx
;

ALTER TABLE pa_benchmarkdata ADD CONSTRAINT pa_benchmarkdata_uu_idx UNIQUE (pa_benchmarkdata_uu)
;

DROP INDEX pa_colorschema_uu_idx
;

ALTER TABLE pa_colorschema ADD CONSTRAINT pa_colorschema_uu_idx UNIQUE (pa_colorschema_uu)
;

DROP INDEX pa_dashboardcontent_uu_idx
;

ALTER TABLE pa_dashboardcontent ADD CONSTRAINT pa_dashboardcontent_uu_idx UNIQUE (pa_dashboardcontent_uu)
;

DROP INDEX pa_dashboardcontent_trl_uu_idx
;

ALTER TABLE pa_dashboardcontent_trl ADD CONSTRAINT pa_dashboardcontent_trl_uu_idx UNIQUE (pa_dashboardcontent_trl_uu)
;

DROP INDEX pa_dashboardpreference_uu_idx
;

ALTER TABLE pa_dashboardpreference ADD CONSTRAINT pa_dashboardpreference_uu_idx UNIQUE (pa_dashboardpreference_uu)
;

DROP INDEX pa_goal_uu_idx
;

ALTER TABLE pa_goal ADD CONSTRAINT pa_goal_uu_idx UNIQUE (pa_goal_uu)
;

DROP INDEX pa_goalrestriction_uu_idx
;

ALTER TABLE pa_goalrestriction ADD CONSTRAINT pa_goalrestriction_uu_idx UNIQUE (pa_goalrestriction_uu)
;

DROP INDEX pa_hierarchy_uu_idx
;

ALTER TABLE pa_hierarchy ADD CONSTRAINT pa_hierarchy_uu_idx UNIQUE (pa_hierarchy_uu)
;

DROP INDEX pa_measure_uu_idx
;

ALTER TABLE pa_measure ADD CONSTRAINT pa_measure_uu_idx UNIQUE (pa_measure_uu)
;

DROP INDEX pa_measurecalc_uu_idx
;

ALTER TABLE pa_measurecalc ADD CONSTRAINT pa_measurecalc_uu_idx UNIQUE (pa_measurecalc_uu)
;

DROP INDEX pa_ratio_uu_idx
;

ALTER TABLE pa_ratio ADD CONSTRAINT pa_ratio_uu_idx UNIQUE (pa_ratio_uu)
;

DROP INDEX pa_ratioelement_uu_idx
;

ALTER TABLE pa_ratioelement ADD CONSTRAINT pa_ratioelement_uu_idx UNIQUE (pa_ratioelement_uu)
;

DROP INDEX pa_report_uu_idx
;

ALTER TABLE pa_report ADD CONSTRAINT pa_report_uu_idx UNIQUE (pa_report_uu)
;

DROP INDEX pa_reportcolumn_uu_idx
;

ALTER TABLE pa_reportcolumn ADD CONSTRAINT pa_reportcolumn_uu_idx UNIQUE (pa_reportcolumn_uu)
;

DROP INDEX pa_reportcolumnset_uu_idx
;

ALTER TABLE pa_reportcolumnset ADD CONSTRAINT pa_reportcolumnset_uu_idx UNIQUE (pa_reportcolumnset_uu)
;

DROP INDEX pa_reportcube_uu_idx
;

ALTER TABLE pa_reportcube ADD CONSTRAINT pa_reportcube_uu_idx UNIQUE (pa_reportcube_uu)
;

DROP INDEX pa_reportline_uu_idx
;

ALTER TABLE pa_reportline ADD CONSTRAINT pa_reportline_uu_idx UNIQUE (pa_reportline_uu)
;

DROP INDEX pa_reportlineset_uu_idx
;

ALTER TABLE pa_reportlineset ADD CONSTRAINT pa_reportlineset_uu_idx UNIQUE (pa_reportlineset_uu)
;

DROP INDEX pa_reportsource_uu_idx
;

ALTER TABLE pa_reportsource ADD CONSTRAINT pa_reportsource_uu_idx UNIQUE (pa_reportsource_uu)
;

DROP INDEX pa_sla_criteria_uu_idx
;

ALTER TABLE pa_sla_criteria ADD CONSTRAINT pa_sla_criteria_uu_idx UNIQUE (pa_sla_criteria_uu)
;

DROP INDEX pa_sla_goal_uu_idx
;

ALTER TABLE pa_sla_goal ADD CONSTRAINT pa_sla_goal_uu_idx UNIQUE (pa_sla_goal_uu)
;

DROP INDEX pa_sla_measure_uu_idx
;

ALTER TABLE pa_sla_measure ADD CONSTRAINT pa_sla_measure_uu_idx UNIQUE (pa_sla_measure_uu)
;

DROP INDEX pp_cost_collector_uu_idx
;

ALTER TABLE pp_cost_collector ADD CONSTRAINT pp_cost_collector_uu_idx UNIQUE (pp_cost_collector_uu)
;

DROP INDEX pp_cost_collectorma_uu_idx
;

ALTER TABLE pp_cost_collectorma ADD CONSTRAINT pp_cost_collectorma_uu_idx UNIQUE (pp_cost_collectorma_uu)
;

DROP INDEX pp_mrp_uu_idx
;

ALTER TABLE pp_mrp ADD CONSTRAINT pp_mrp_uu_idx UNIQUE (pp_mrp_uu)
;

DROP INDEX pp_order_uu_idx
;

ALTER TABLE pp_order ADD CONSTRAINT pp_order_uu_idx UNIQUE (pp_order_uu)
;

DROP INDEX pp_order_bom_uu_idx
;

ALTER TABLE pp_order_bom ADD CONSTRAINT pp_order_bom_uu_idx UNIQUE (pp_order_bom_uu)
;

DROP INDEX pp_order_bom_trl_uu_idx
;

ALTER TABLE pp_order_bom_trl ADD CONSTRAINT pp_order_bom_trl_uu_idx UNIQUE (pp_order_bom_trl_uu)
;

DROP INDEX pp_order_bomline_uu_idx
;

ALTER TABLE pp_order_bomline ADD CONSTRAINT pp_order_bomline_uu_idx UNIQUE (pp_order_bomline_uu)
;

DROP INDEX pp_order_bomline_trl_uu_idx
;

ALTER TABLE pp_order_bomline_trl ADD CONSTRAINT pp_order_bomline_trl_uu_idx UNIQUE (pp_order_bomline_trl_uu)
;

DROP INDEX pp_order_cost_uu_idx
;

ALTER TABLE pp_order_cost ADD CONSTRAINT pp_order_cost_uu_idx UNIQUE (pp_order_cost_uu)
;

DROP INDEX pp_order_node_uu_idx
;

ALTER TABLE pp_order_node ADD CONSTRAINT pp_order_node_uu_idx UNIQUE (pp_order_node_uu)
;

DROP INDEX pp_order_node_asset_uu_idx
;

ALTER TABLE pp_order_node_asset ADD CONSTRAINT pp_order_node_asset_uu_idx UNIQUE (pp_order_node_asset_uu)
;

DROP INDEX pp_order_node_product_uu_idx
;

ALTER TABLE pp_order_node_product ADD CONSTRAINT pp_order_node_product_uu_idx UNIQUE (pp_order_node_product_uu)
;

DROP INDEX pp_order_node_trl_uu_idx
;

ALTER TABLE pp_order_node_trl ADD CONSTRAINT pp_order_node_trl_uu_idx UNIQUE (pp_order_node_trl_uu)
;

DROP INDEX pp_order_nodenext_uu_idx
;

ALTER TABLE pp_order_nodenext ADD CONSTRAINT pp_order_nodenext_uu_idx UNIQUE (pp_order_nodenext_uu)
;

DROP INDEX pp_order_workflow_uu_idx
;

ALTER TABLE pp_order_workflow ADD CONSTRAINT pp_order_workflow_uu_idx UNIQUE (pp_order_workflow_uu)
;

DROP INDEX pp_order_workflow_trl_uu_idx
;

ALTER TABLE pp_order_workflow_trl ADD CONSTRAINT pp_order_workflow_trl_uu_idx UNIQUE (pp_order_workflow_trl_uu)
;

DROP INDEX pp_product_bom_uu_idx
;

ALTER TABLE pp_product_bom ADD CONSTRAINT pp_product_bom_uu_idx UNIQUE (pp_product_bom_uu)
;

DROP INDEX pp_product_bom_trl_uu_idx
;

ALTER TABLE pp_product_bom_trl ADD CONSTRAINT pp_product_bom_trl_uu_idx UNIQUE (pp_product_bom_trl_uu)
;

DROP INDEX pp_product_bomline_uu_idx
;

ALTER TABLE pp_product_bomline ADD CONSTRAINT pp_product_bomline_uu_idx UNIQUE (pp_product_bomline_uu)
;

DROP INDEX pp_product_bomline_trl_uu_idx
;

ALTER TABLE pp_product_bomline_trl ADD CONSTRAINT pp_product_bomline_trl_uu_idx UNIQUE (pp_product_bomline_trl_uu)
;

DROP INDEX pp_product_planning_uu_idx
;

ALTER TABLE pp_product_planning ADD CONSTRAINT pp_product_planning_uu_idx UNIQUE (pp_product_planning_uu)
;

DROP INDEX pp_wf_node_asset_uu_idx
;

ALTER TABLE pp_wf_node_asset ADD CONSTRAINT pp_wf_node_asset_uu_idx UNIQUE (pp_wf_node_asset_uu)
;

DROP INDEX pp_wf_node_product_uu_idx
;

ALTER TABLE pp_wf_node_product ADD CONSTRAINT pp_wf_node_product_uu_idx UNIQUE (pp_wf_node_product_uu)
;

DROP INDEX qm_specification_uu_idx
;

ALTER TABLE qm_specification ADD CONSTRAINT qm_specification_uu_idx UNIQUE (qm_specification_uu)
;

DROP INDEX qm_specificationline_uu_idx
;

ALTER TABLE qm_specificationline ADD CONSTRAINT qm_specificationline_uu_idx UNIQUE (qm_specificationline_uu)
;

DROP INDEX r_category_uu_idx
;

ALTER TABLE r_category ADD CONSTRAINT r_category_uu_idx UNIQUE (r_category_uu)
;

DROP INDEX r_categoryupdates_uu_idx
;

ALTER TABLE r_categoryupdates ADD CONSTRAINT r_categoryupdates_uu_idx UNIQUE (r_categoryupdates_uu)
;

DROP INDEX r_contactinterest_uu_idx
;

ALTER TABLE r_contactinterest ADD CONSTRAINT r_contactinterest_uu_idx UNIQUE (r_contactinterest_uu)
;

DROP INDEX r_group_uu_idx
;

ALTER TABLE r_group ADD CONSTRAINT r_group_uu_idx UNIQUE (r_group_uu)
;

DROP INDEX r_groupupdates_uu_idx
;

ALTER TABLE r_groupupdates ADD CONSTRAINT r_groupupdates_uu_idx UNIQUE (r_groupupdates_uu)
;

DROP INDEX r_interestarea_uu_idx
;

ALTER TABLE r_interestarea ADD CONSTRAINT r_interestarea_uu_idx UNIQUE (r_interestarea_uu)
;

DROP INDEX r_issueknown_uu_idx
;

ALTER TABLE r_issueknown ADD CONSTRAINT r_issueknown_uu_idx UNIQUE (r_issueknown_uu)
;

DROP INDEX r_issueproject_uu_idx
;

ALTER TABLE r_issueproject ADD CONSTRAINT r_issueproject_uu_idx UNIQUE (r_issueproject_uu)
;

DROP INDEX r_issuerecommendation_uu_idx
;

ALTER TABLE r_issuerecommendation ADD CONSTRAINT r_issuerecommendation_uu_idx UNIQUE (r_issuerecommendation_uu)
;

DROP INDEX r_issuestatus_uu_idx
;

ALTER TABLE r_issuestatus ADD CONSTRAINT r_issuestatus_uu_idx UNIQUE (r_issuestatus_uu)
;

DROP INDEX r_issuesystem_uu_idx
;

ALTER TABLE r_issuesystem ADD CONSTRAINT r_issuesystem_uu_idx UNIQUE (r_issuesystem_uu)
;

DROP INDEX r_issueuser_uu_idx
;

ALTER TABLE r_issueuser ADD CONSTRAINT r_issueuser_uu_idx UNIQUE (r_issueuser_uu)
;

DROP INDEX r_mailtext_uu_idx
;

ALTER TABLE r_mailtext ADD CONSTRAINT r_mailtext_uu_idx UNIQUE (r_mailtext_uu)
;

DROP INDEX r_mailtext_trl_uu_idx
;

ALTER TABLE r_mailtext_trl ADD CONSTRAINT r_mailtext_trl_uu_idx UNIQUE (r_mailtext_trl_uu)
;

DROP INDEX r_request_uu_idx
;

ALTER TABLE r_request ADD CONSTRAINT r_request_uu_idx UNIQUE (r_request_uu)
;

DROP INDEX r_requestaction_uu_idx
;

ALTER TABLE r_requestaction ADD CONSTRAINT r_requestaction_uu_idx UNIQUE (r_requestaction_uu)
;

DROP INDEX r_requestprocessor_uu_idx
;

ALTER TABLE r_requestprocessor ADD CONSTRAINT r_requestprocessor_uu_idx UNIQUE (r_requestprocessor_uu)
;

DROP INDEX r_requestprocessor_rout_uu_idx
;

ALTER TABLE r_requestprocessor_route ADD CONSTRAINT r_requestprocessor_rout_uu_idx UNIQUE (r_requestprocessor_route_uu)
;

DROP INDEX r_requestprocessorlog_uu_idx
;

ALTER TABLE r_requestprocessorlog ADD CONSTRAINT r_requestprocessorlog_uu_idx UNIQUE (r_requestprocessorlog_uu)
;

DROP INDEX r_requesttype_uu_idx
;

ALTER TABLE r_requesttype ADD CONSTRAINT r_requesttype_uu_idx UNIQUE (r_requesttype_uu)
;

DROP INDEX r_requesttypeupdates_uu_idx
;

ALTER TABLE r_requesttypeupdates ADD CONSTRAINT r_requesttypeupdates_uu_idx UNIQUE (r_requesttypeupdates_uu)
;

DROP INDEX r_requestupdate_uu_idx
;

ALTER TABLE r_requestupdate ADD CONSTRAINT r_requestupdate_uu_idx UNIQUE (r_requestupdate_uu)
;

DROP INDEX r_requestupdates_uu_idx
;

ALTER TABLE r_requestupdates ADD CONSTRAINT r_requestupdates_uu_idx UNIQUE (r_requestupdates_uu)
;

DROP INDEX r_resolution_uu_idx
;

ALTER TABLE r_resolution ADD CONSTRAINT r_resolution_uu_idx UNIQUE (r_resolution_uu)
;

DROP INDEX r_standardresponse_uu_idx
;

ALTER TABLE r_standardresponse ADD CONSTRAINT r_standardresponse_uu_idx UNIQUE (r_standardresponse_uu)
;

DROP INDEX r_status_uu_idx
;

ALTER TABLE r_status ADD CONSTRAINT r_status_uu_idx UNIQUE (r_status_uu)
;

DROP INDEX r_statuscategory_uu_idx
;

ALTER TABLE r_statuscategory ADD CONSTRAINT r_statuscategory_uu_idx UNIQUE (r_statuscategory_uu)
;

DROP INDEX s_expensetype_uu_idx
;

ALTER TABLE s_expensetype ADD CONSTRAINT s_expensetype_uu_idx UNIQUE (s_expensetype_uu)
;

DROP INDEX s_resource_uu_idx
;

ALTER TABLE s_resource ADD CONSTRAINT s_resource_uu_idx UNIQUE (s_resource_uu)
;

DROP INDEX s_resourceassignment_uu_idx
;

ALTER TABLE s_resourceassignment ADD CONSTRAINT s_resourceassignment_uu_idx UNIQUE (s_resourceassignment_uu)
;

DROP INDEX s_resourcetype_uu_idx
;

ALTER TABLE s_resourcetype ADD CONSTRAINT s_resourcetype_uu_idx UNIQUE (s_resourcetype_uu)
;

DROP INDEX s_resourceunavailable_uu_idx
;

ALTER TABLE s_resourceunavailable ADD CONSTRAINT s_resourceunavailable_uu_idx UNIQUE (s_resourceunavailable_uu)
;

DROP INDEX s_timeexpense_uu_idx
;

ALTER TABLE s_timeexpense ADD CONSTRAINT s_timeexpense_uu_idx UNIQUE (s_timeexpense_uu)
;

DROP INDEX s_timeexpenseline_uu_idx
;

ALTER TABLE s_timeexpenseline ADD CONSTRAINT s_timeexpenseline_uu_idx UNIQUE (s_timeexpenseline_uu)
;

DROP INDEX s_timetype_uu_idx
;

ALTER TABLE s_timetype ADD CONSTRAINT s_timetype_uu_idx UNIQUE (s_timetype_uu)
;

DROP INDEX s_training_uu_idx
;

ALTER TABLE s_training ADD CONSTRAINT s_training_uu_idx UNIQUE (s_training_uu)
;

DROP INDEX s_training_class_uu_idx
;

ALTER TABLE s_training_class ADD CONSTRAINT s_training_class_uu_idx UNIQUE (s_training_class_uu)
;

DROP INDEX t_1099extract_uu_idx
;

ALTER TABLE t_1099extract ADD CONSTRAINT t_1099extract_uu_idx UNIQUE (t_1099extract_uu)
;

DROP INDEX t_aging_uu_idx
;

ALTER TABLE t_aging ADD CONSTRAINT t_aging_uu_idx UNIQUE (t_aging_uu)
;

DROP INDEX t_bankregister_uu_idx
;

ALTER TABLE t_bankregister ADD CONSTRAINT t_bankregister_uu_idx UNIQUE (t_bankregister_uu)
;

DROP INDEX t_bom_indented_uu_idx
;

ALTER TABLE t_bom_indented ADD CONSTRAINT t_bom_indented_uu_idx UNIQUE (t_bom_indented_uu)
;

DROP INDEX t_bomline_uu_idx
;

ALTER TABLE t_bomline ADD CONSTRAINT t_bomline_uu_idx UNIQUE (t_bomline_uu)
;

DROP INDEX t_cashflow_uu_idx
;

ALTER TABLE t_cashflow ADD CONSTRAINT t_cashflow_uu_idx UNIQUE (t_cashflow_uu)
;

DROP INDEX t_distributionrundetail_uu_idx
;

ALTER TABLE t_distributionrundetail ADD CONSTRAINT t_distributionrundetail_uu_idx UNIQUE (t_distributionrundetail_uu)
;

DROP INDEX t_inventoryvalue_uu_idx
;

ALTER TABLE t_inventoryvalue ADD CONSTRAINT t_inventoryvalue_uu_idx UNIQUE (t_inventoryvalue_uu)
;

DROP INDEX t_invoicegl_uu_idx
;

ALTER TABLE t_invoicegl ADD CONSTRAINT t_invoicegl_uu_idx UNIQUE (t_invoicegl_uu)
;

DROP INDEX t_mrp_crp_uu_idx
;

ALTER TABLE t_mrp_crp ADD CONSTRAINT t_mrp_crp_uu_idx UNIQUE (t_mrp_crp_uu)
;

DROP INDEX t_reconciliation_uu_idx
;

ALTER TABLE t_reconciliation ADD CONSTRAINT t_reconciliation_uu_idx UNIQUE (t_reconciliation_uu)
;

DROP INDEX t_replenish_uu_idx
;

ALTER TABLE t_replenish ADD CONSTRAINT t_replenish_uu_idx UNIQUE (t_replenish_uu)
;

DROP INDEX t_report_uu_idx
;

ALTER TABLE t_report ADD CONSTRAINT t_report_uu_idx UNIQUE (t_report_uu)
;

DROP INDEX t_reportstatement_uu_idx
;

ALTER TABLE t_reportstatement ADD CONSTRAINT t_reportstatement_uu_idx UNIQUE (t_reportstatement_uu)
;

DROP INDEX t_transaction_uu_idx
;

ALTER TABLE t_transaction ADD CONSTRAINT t_transaction_uu_idx UNIQUE (t_transaction_uu)
;

DROP INDEX test_uu_idx
;

ALTER TABLE test ADD CONSTRAINT test_uu_idx UNIQUE (test_uu)
;

DROP INDEX u_blacklistcheque_uu_idx
;

ALTER TABLE u_blacklistcheque ADD CONSTRAINT u_blacklistcheque_uu_idx UNIQUE (u_blacklistcheque_uu)
;

DROP INDEX u_posterminal_uu_idx
;

ALTER TABLE u_posterminal ADD CONSTRAINT u_posterminal_uu_idx UNIQUE (u_posterminal_uu)
;

DROP INDEX u_rolemenu_uu_idx
;

ALTER TABLE u_rolemenu ADD CONSTRAINT u_rolemenu_uu_idx UNIQUE (u_rolemenu_uu)
;

DROP INDEX u_web_properties_uu_idx
;

ALTER TABLE u_web_properties ADD CONSTRAINT u_web_properties_uu_idx UNIQUE (u_web_properties_uu)
;

DROP INDEX u_webmenu_uu_idx
;

ALTER TABLE u_webmenu ADD CONSTRAINT u_webmenu_uu_idx UNIQUE (u_webmenu_uu)
;

DROP INDEX w_advertisement_uu_idx
;

ALTER TABLE w_advertisement ADD CONSTRAINT w_advertisement_uu_idx UNIQUE (w_advertisement_uu)
;

DROP INDEX w_basket_uu_idx
;

ALTER TABLE w_basket ADD CONSTRAINT w_basket_uu_idx UNIQUE (w_basket_uu)
;

DROP INDEX w_basketline_uu_idx
;

ALTER TABLE w_basketline ADD CONSTRAINT w_basketline_uu_idx UNIQUE (w_basketline_uu)
;

DROP INDEX w_click_uu_idx
;

ALTER TABLE w_click ADD CONSTRAINT w_click_uu_idx UNIQUE (w_click_uu)
;

DROP INDEX w_clickcount_uu_idx
;

ALTER TABLE w_clickcount ADD CONSTRAINT w_clickcount_uu_idx UNIQUE (w_clickcount_uu)
;

DROP INDEX w_counter_uu_idx
;

ALTER TABLE w_counter ADD CONSTRAINT w_counter_uu_idx UNIQUE (w_counter_uu)
;

DROP INDEX w_countercount_uu_idx
;

ALTER TABLE w_countercount ADD CONSTRAINT w_countercount_uu_idx UNIQUE (w_countercount_uu)
;

DROP INDEX w_mailmsg_uu_idx
;

ALTER TABLE w_mailmsg ADD CONSTRAINT w_mailmsg_uu_idx UNIQUE (w_mailmsg_uu)
;

DROP INDEX w_mailmsg_trl_uu_idx
;

ALTER TABLE w_mailmsg_trl ADD CONSTRAINT w_mailmsg_trl_uu_idx UNIQUE (w_mailmsg_trl_uu)
;

DROP INDEX w_store_uu_idx
;

ALTER TABLE w_store ADD CONSTRAINT w_store_uu_idx UNIQUE (w_store_uu)
;

DROP INDEX w_store_trl_uu_idx
;

ALTER TABLE w_store_trl ADD CONSTRAINT w_store_trl_uu_idx UNIQUE (w_store_trl_uu)
;

DROP INDEX ws_webservice_uu_idx
;

ALTER TABLE ws_webservice ADD CONSTRAINT ws_webservice_uu_idx UNIQUE (ws_webservice_uu)
;

DROP INDEX ws_webservice_para_uu_idx
;

ALTER TABLE ws_webservice_para ADD CONSTRAINT ws_webservice_para_uu_idx UNIQUE (ws_webservice_para_uu)
;

DROP INDEX ws_webservicefieldinput_uu_idx
;

ALTER TABLE ws_webservicefieldinput ADD CONSTRAINT ws_webservicefieldinput_uu_idx UNIQUE (ws_webservicefieldinput_uu)
;

DROP INDEX ws_webservicefieldoutpu_uu_idx
;

ALTER TABLE ws_webservicefieldoutput ADD CONSTRAINT ws_webservicefieldoutpu_uu_idx UNIQUE (ws_webservicefieldoutput_uu)
;

DROP INDEX ws_webservicemethod_uu_idx
;

ALTER TABLE ws_webservicemethod ADD CONSTRAINT ws_webservicemethod_uu_idx UNIQUE (ws_webservicemethod_uu)
;

DROP INDEX ws_webservicetype_uu_idx
;

ALTER TABLE ws_webservicetype ADD CONSTRAINT ws_webservicetype_uu_idx UNIQUE (ws_webservicetype_uu)
;

DROP INDEX ws_webservicetypeaccess_uu_idx
;

ALTER TABLE ws_webservicetypeaccess ADD CONSTRAINT ws_webservicetypeaccess_uu_idx UNIQUE (ws_webservicetypeaccess_uu)
;

UPDATE AD_TableIndex SET IsCreateConstraint='Y' WHERE IsCreateConstraint!='Y' AND AD_TableIndex_ID IN (
200001 /* a_asset_acct_uu_idx */ ,
200002 /* a_asset_addition_uu_idx */ ,
200003 /* a_asset_change_uu_idx */ ,
200004 /* a_asset_class_uu_idx */ ,
200005 /* a_asset_delivery_uu_idx */ ,
200006 /* a_asset_disposed_uu_idx */ ,
200008 /* a_asset_group_acct_uu_idx */ ,
200007 /* a_asset_group_uu_idx */ ,
200009 /* a_asset_info_fin_uu_idx */ ,
200010 /* a_asset_info_ins_uu_idx */ ,
200011 /* a_asset_info_lic_uu_idx */ ,
200012 /* a_asset_info_oth_uu_idx */ ,
200013 /* a_asset_info_tax_uu_idx */ ,
200014 /* a_asset_product_uu_idx */ ,
200015 /* a_asset_retirement_uu_idx */ ,
200017 /* a_asset_reval_entry_uu_idx */ ,
200018 /* a_asset_reval_index_uu_idx */ ,
200016 /* a_asset_reval_uu_idx */ ,
200019 /* a_asset_split_uu_idx */ ,
200020 /* a_asset_spread_uu_idx */ ,
200021 /* a_asset_transfer_uu_idx */ ,
200022 /* a_asset_type_uu_idx */ ,
200023 /* a_asset_use_uu_idx */ ,
200000 /* a_asset_uu_idx */ ,
200040 /* ad_accesslog_uu_idx */ ,
200043 /* ad_alertprocessorlog_uu_idx */ ,
200042 /* ad_alertprocessor_uu_idx */ ,
200044 /* ad_alertrecipient_uu_idx */ ,
200045 /* ad_alertrule_uu_idx */ ,
200041 /* ad_alert_uu_idx */ ,
200046 /* ad_archive_uu_idx */ ,
200049 /* ad_attachmentnote_uu_idx */ ,
200048 /* ad_attachment_uu_idx */ ,
200050 /* ad_attribute_uu_idx */ ,
200051 /* ad_attribute_value_uu_idx */ ,
200052 /* ad_broadcastmessage_uu_idx */ ,
200053 /* ad_changelog_uu_idx */ ,
200056 /* ad_chartdatasource_uu_idx */ ,
200055 /* ad_chart_uu_idx */ ,
200059 /* ad_clientinfo_uu_idx */ ,
200061 /* ad_clientshare_uu_idx */ ,
200058 /* ad_client_uu_idx */ ,
200062 /* ad_color_uu_idx */ ,
200065 /* ad_column_access_uu_idx */ ,
200066 /* ad_column_trl_uu_idx */ ,
200063 /* ad_column_uu_idx */ ,
200069 /* ad_ctxhelpmsg_trl_uu_idx */ ,
200068 /* ad_ctxhelpmsg_uu_idx */ ,
200067 /* ad_ctxhelp_uu_idx */ ,
200071 /* ad_desktop_trl_uu_idx */ ,
200070 /* ad_desktop_uu_idx */ ,
200072 /* ad_desktopworkbench_uu_idx */ ,
200073 /* ad_document_action_acce_uu_idx */ ,
200078 /* ad_element_trl_uu_idx */ ,
200074 /* ad_element_uu_idx */ ,
200079 /* ad_entitytype_uu_idx */ ,
200025 /* a_depreciation_build_uu_idx */ ,
200026 /* a_depreciation_conventi_uu_idx */ ,
200027 /* a_depreciation_entry_uu_idx */ ,
200028 /* a_depreciation_exp_uu_idx */ ,
200029 /* a_depreciation_forecast_uu_idx */ ,
200030 /* a_depreciation_method_uu_idx */ ,
200031 /* a_depreciation_table_de_uu_idx */ ,
200032 /* a_depreciation_table_he_uu_idx */ ,
200024 /* a_depreciation_uu_idx */ ,
200033 /* a_depreciation_workfile_uu_idx */ ,
200080 /* ad_error_uu_idx */ ,
200086 /* ad_fieldgroup_trl_uu_idx */ ,
200084 /* ad_fieldgroup_uu_idx */ ,
200083 /* ad_field_trl_uu_idx */ ,
200081 /* ad_field_uu_idx */ ,
200087 /* ad_find_uu_idx */ ,
200089 /* ad_form_access_uu_idx */ ,
200090 /* ad_form_trl_uu_idx */ ,
200088 /* ad_form_uu_idx */ ,
200091 /* ad_housekeeping_uu_idx */ ,
200092 /* ad_image_uu_idx */ ,
200095 /* ad_impformat_row_uu_idx */ ,
200094 /* ad_impformat_uu_idx */ ,
201030 /* ad_importtemplateaccess_uu_idx */ ,
201029 /* ad_importtemplate_uu_idx */ ,
200096 /* ad_indexcolumn_uu_idx */ ,
200098 /* ad_infocolumn_trl_uu_idx */ ,
200097 /* ad_infocolumn_uu_idx */ ,
200101 /* ad_infowindow_access_uu_idx */ ,
200102 /* ad_infowindow_trl_uu_idx */ ,
200100 /* ad_infowindow_uu_idx */ ,
200103 /* ad_issue_uu_idx */ ,
201119 /* ad_labelcategory_trl_uu_idx */ ,
200105 /* ad_labelprinterfunction_uu_idx */ ,
200104 /* ad_labelprinter_uu_idx */ ,
201121 /* ad_label_trl_uu_idx */ ,
200106 /* ad_language_uu_idx */ ,
200107 /* ad_ldapaccess_uu_idx */ ,
200110 /* ad_ldapprocessorlog_uu_idx */ ,
200109 /* ad_ldapprocessor_uu_idx */ ,
200112 /* ad_menu_trl_uu_idx */ ,
200111 /* ad_menu_uu_idx */ ,
200115 /* ad_message_trl_uu_idx */ ,
200113 /* ad_message_uu_idx */ ,
200116 /* ad_migrationscript_uu_idx */ ,
200117 /* ad_modelvalidator_uu_idx */ ,
200118 /* ad_modification_uu_idx */ ,
200119 /* ad_note_uu_idx */ ,
200123 /* ad_orginfo_uu_idx */ ,
200124 /* ad_orgtype_uu_idx */ ,
200121 /* ad_org_uu_idx */ ,
200126 /* ad_package_exp_common_uu_idx */ ,
200127 /* ad_package_exp_detail_uu_idx */ ,
200125 /* ad_package_exp_uu_idx */ ,
200129 /* ad_package_imp_backup_uu_idx */ ,
200130 /* ad_package_imp_detail_uu_idx */ ,
200131 /* ad_package_imp_inst_uu_idx */ ,
200132 /* ad_package_imp_proc_uu_idx */ ,
200128 /* ad_package_imp_uu_idx */ ,
200133 /* ad_package_uuid_map_uu_idx */ ,
201031 /* AD_Password_History_uu_idx */ ,
200135 /* ad_passwordrule_uu_idx */ ,
200138 /* ad_pinstance_log_uu_idx */ ,
200139 /* ad_pinstance_para_uu_idx */ ,
200136 /* ad_pinstance_uu_idx */ ,
200140 /* ad_preference_uu_idx */ ,
200143 /* ad_printcolor_uu_idx */ ,
200145 /* ad_printfont_uu_idx */ ,
200153 /* ad_printformatitem_trl_uu_idx */ ,
200151 /* ad_printformatitem_uu_idx */ ,
200150 /* ad_printformat_uu_idx */ ,
200147 /* ad_printform_uu_idx */ ,
200154 /* ad_printgraph_uu_idx */ ,
200157 /* ad_printlabelline_trl_uu_idx */ ,
200156 /* ad_printlabelline_uu_idx */ ,
200155 /* ad_printlabel_uu_idx */ ,
200159 /* ad_printpaper_uu_idx */ ,
200160 /* ad_printtableformat_uu_idx */ ,
200161 /* ad_private_access_uu_idx */ ,
200163 /* ad_process_access_uu_idx */ ,
201126 /* ad_process_drillrule_para_uu_idx */ ,
201125 /* ad_process_drillrule_uu_idx */ ,
200167 /* ad_process_para_trl_uu_idx */ ,
200164 /* ad_process_para_uu_idx */ ,
200168 /* ad_process_trl_uu_idx */ ,
200162 /* ad_process_uu_idx */ ,
200169 /* ad_recentitem_uu_idx */ ,
200170 /* ad_record_access_uu_idx */ ,
200177 /* ad_reference_trl_uu_idx */ ,
200175 /* ad_reference_uu_idx */ ,
200173 /* ad_ref_list_trl_uu_idx */ ,
200171 /* ad_ref_list_uu_idx */ ,
200174 /* ad_ref_table_uu_idx */ ,
200178 /* ad_registration_uu_idx */ ,
200179 /* ad_relationtype_uu_idx */ ,
200183 /* ad_replicationdocument_uu_idx */ ,
200181 /* ad_replication_log_uu_idx */ ,
200182 /* ad_replication_run_uu_idx */ ,
200184 /* ad_replicationstrategy_uu_idx */ ,
200186 /* ad_replicationtable_uu_idx */ ,
200180 /* ad_replication_uu_idx */ ,
200188 /* ad_reportview_col_uu_idx */ ,
200187 /* ad_reportview_uu_idx */ ,
200190 /* ad_role_included_uu_idx */ ,
200191 /* ad_role_orgaccess_uu_idx */ ,
200189 /* ad_role_uu_idx */ ,
200192 /* ad_rule_uu_idx */ ,
200196 /* ad_schedulerlog_uu_idx */ ,
200195 /* ad_scheduler_para_uu_idx */ ,
200197 /* ad_schedulerrecipient_uu_idx */ ,
200194 /* ad_scheduler_uu_idx */ ,
200193 /* ad_schedule_uu_idx */ ,
200198 /* ad_searchdefinition_uu_idx */ ,
200201 /* ad_sequence_audit_uu_idx */ ,
200202 /* ad_sequence_no_uu_idx */ ,
200200 /* ad_sequence_uu_idx */ ,
200203 /* ad_session_uu_idx */ ,
200204 /* ad_storageprovider_uu_idx */ ,
200206 /* ad_sysconfig_uu_idx */ ,
200207 /* ad_system_uu_idx */ ,
200211 /* ad_tab_customization_uu_idx */ ,
200215 /* ad_table_access_uu_idx */ ,
200218 /* ad_tableindex_uu_idx */ ,
200216 /* ad_table_scriptvalidato_uu_idx */ ,
200217 /* ad_table_trl_uu_idx */ ,
200214 /* ad_table_uu_idx */ ,
200212 /* ad_tab_trl_uu_idx */ ,
200209 /* ad_tab_uu_idx */ ,
200221 /* ad_task_access_uu_idx */ ,
200224 /* ad_taskinstance_uu_idx */ ,
200222 /* ad_task_trl_uu_idx */ ,
200219 /* ad_task_uu_idx */ ,
200226 /* ad_toolbarbuttonrestric_uu_idx */ ,
200225 /* ad_toolbarbutton_uu_idx */ ,
200229 /* ad_treebar_uu_idx */ ,
200233 /* ad_treenodebp_uu_idx */ ,
200234 /* ad_treenodecmc_uu_idx */ ,
200235 /* ad_treenodecmm_uu_idx */ ,
200236 /* ad_treenodecms_uu_idx */ ,
200237 /* ad_treenodecmt_uu_idx */ ,
200239 /* ad_treenodemm_uu_idx */ ,
200241 /* ad_treenodepr_uu_idx */ ,
200242 /* ad_treenodeu1_uu_idx */ ,
200243 /* ad_treenodeu2_uu_idx */ ,
200244 /* ad_treenodeu3_uu_idx */ ,
200245 /* ad_treenodeu4_uu_idx */ ,
200231 /* ad_treenode_uu_idx */ ,
200227 /* ad_tree_uu_idx */ ,
200251 /* ad_userbpaccess_uu_idx */ ,
200252 /* ad_userdef_field_uu_idx */ ,
200253 /* ad_userdef_tab_uu_idx */ ,
200254 /* ad_userdef_win_uu_idx */ ,
200255 /* ad_usermail_uu_idx */ ,
200248 /* ad_user_orgaccess_uu_idx */ ,
200256 /* ad_userquery_uu_idx */ ,
200249 /* ad_user_roles_uu_idx */ ,
200250 /* ad_user_substitute_uu_idx */ ,
200246 /* ad_user_uu_idx */ ,
200257 /* ad_val_rule_uu_idx */ ,
200258 /* ad_viewcolumn_uu_idx */ ,
200259 /* ad_viewcomponent_uu_idx */ ,
200264 /* ad_wf_activityresult_uu_idx */ ,
200262 /* ad_wf_activity_uu_idx */ ,
200265 /* ad_wf_block_uu_idx */ ,
200267 /* ad_wf_eventaudit_uu_idx */ ,
200268 /* ad_wf_nextcondition_uu_idx */ ,
200273 /* ad_wf_nodenext_uu_idx */ ,
200271 /* ad_wf_node_para_uu_idx */ ,
200272 /* ad_wf_node_trl_uu_idx */ ,
200270 /* ad_wf_node_uu_idx */ ,
200276 /* ad_wf_processdata_uu_idx */ ,
200275 /* ad_wf_process_uu_idx */ ,
200278 /* ad_wf_responsible_uu_idx */ ,
200281 /* ad_window_access_uu_idx */ ,
200282 /* ad_window_trl_uu_idx */ ,
200280 /* ad_window_uu_idx */ ,
200283 /* ad_wizardprocess_uu_idx */ ,
201090 /* ad_wlistbox_customizationuuidx */ ,
200285 /* ad_workbench_trl_uu_idx */ ,
200284 /* ad_workbench_uu_idx */ ,
200286 /* ad_workbenchwindow_uu_idx */ ,
200289 /* ad_workflow_access_uu_idx */ ,
200292 /* ad_workflowprocessorlog_uu_idx */ ,
200291 /* ad_workflowprocessor_uu_idx */ ,
200290 /* ad_workflow_trl_uu_idx */ ,
200288 /* ad_workflow_uu_idx */ ,
200293 /* ad_zoomcondition_uu_idx */ ,
200035 /* a_fundingmode_acct_uu_idx */ ,
200034 /* a_fundingmode_uu_idx */ ,
200037 /* a_registrationattribute_uu_idx */ ,
200038 /* a_registrationproduct_uu_idx */ ,
200036 /* a_registration_uu_idx */ ,
200039 /* a_registrationvalue_uu_idx */ ,
200294 /* asp_clientexception_uu_idx */ ,
200295 /* asp_clientlevel_uu_idx */ ,
200296 /* asp_field_uu_idx */ ,
200297 /* asp_form_uu_idx */ ,
200298 /* asp_level_uu_idx */ ,
200299 /* asp_module_uu_idx */ ,
200301 /* asp_process_para_uu_idx */ ,
200300 /* asp_process_uu_idx */ ,
200302 /* asp_ref_list_uu_idx */ ,
200303 /* asp_tab_uu_idx */ ,
200304 /* asp_task_uu_idx */ ,
200305 /* asp_window_uu_idx */ ,
200306 /* asp_workflow_uu_idx */ ,
200308 /* b_bidcomment_uu_idx */ ,
200307 /* b_bid_uu_idx */ ,
200310 /* b_buyerfunds_uu_idx */ ,
200309 /* b_buyer_uu_idx */ ,
200311 /* b_offer_uu_idx */ ,
200313 /* b_sellerfunds_uu_idx */ ,
200312 /* b_seller_uu_idx */ ,
200315 /* b_topiccategory_uu_idx */ ,
200316 /* b_topictype_uu_idx */ ,
200314 /* b_topic_uu_idx */ ,
200317 /* c_1099box_uu_idx */ ,
200319 /* c_acctprocessorlog_uu_idx */ ,
200318 /* c_acctprocessor_uu_idx */ ,
200322 /* c_acctschema_default_uu_idx */ ,
200323 /* c_acctschema_element_uu_idx */ ,
200325 /* c_acctschema_gl_uu_idx */ ,
200321 /* c_acctschema_uu_idx */ ,
200326 /* c_activity_uu_idx */ ,
200328 /* c_addresstransaction_uu_idx */ ,
200330 /* c_addressvalidationcfg_uu_idx */ ,
200329 /* c_addressvalidation_uu_idx */ ,
200332 /* c_allocationhdr_uu_idx */ ,
200333 /* c_allocationline_uu_idx */ ,
200339 /* c_bankaccount_acct_uu_idx */ ,
200341 /* c_bankaccountdoc_uu_idx */ ,
200340 /* c_bankaccount_processor_uu_idx */ ,
200338 /* c_bankaccount_uu_idx */ ,
200345 /* c_bankstatementline_uu_idx */ ,
200346 /* c_bankstatementloader_uu_idx */ ,
200347 /* c_bankstatementmatcher_uu_idx */ ,
200342 /* c_bankstatement_uu_idx */ ,
200336 /* c_bank_uu_idx */ ,
200366 /* c_bpartner_location_uu_idx */ ,
200367 /* c_bpartner_product_uu_idx */ ,
200363 /* c_bpartner_uu_idx */ ,
200349 /* c_bp_bankaccount_uu_idx */ ,
200350 /* c_bp_customer_acct_uu_idx */ ,
200351 /* c_bp_edi_uu_idx */ ,
200352 /* c_bp_employee_acct_uu_idx */ ,
200355 /* c_bp_group_acct_uu_idx */ ,
200353 /* c_bp_group_uu_idx */ ,
200356 /* c_bp_relation_uu_idx */ ,
200357 /* c_bp_shippingacct_uu_idx */ ,
200358 /* c_bp_vendor_acct_uu_idx */ ,
200359 /* c_bp_withholding_uu_idx */ ,
200369 /* c_calendar_uu_idx */ ,
200371 /* c_campaign_uu_idx */ ,
200375 /* c_cashbook_acct_uu_idx */ ,
200374 /* c_cashbook_uu_idx */ ,
200376 /* c_cashline_uu_idx */ ,
200379 /* c_cashplanline_uu_idx */ ,
200378 /* c_cashplan_uu_idx */ ,
200372 /* c_cash_uu_idx */ ,
200381 /* c_channel_uu_idx */ ,
200385 /* c_charge_acct_uu_idx */ ,
200386 /* c_charge_trl_uu_idx */ ,
200388 /* c_chargetype_doctype_uu_idx */ ,
200387 /* c_chargetype_uu_idx */ ,
200384 /* c_charge_uu_idx */ ,
200389 /* c_city_uu_idx */ ,
200391 /* c_commissionamt_uu_idx */ ,
200394 /* c_commissiondetail_uu_idx */ ,
200396 /* c_commissionline_uu_idx */ ,
200397 /* c_commissionrun_uu_idx */ ,
200390 /* c_commission_uu_idx */ ,
200398 /* c_contactactivity_uu_idx */ ,
200399 /* c_conversion_rate_uu_idx */ ,
200401 /* c_conversiontype_uu_idx */ ,
201028 /* c_countrygroup_trl_uu_idx */ ,
200404 /* c_country_trl_uu_idx */ ,
200403 /* c_country_uu_idx */ ,
200407 /* c_currency_acct_uu_idx */ ,
200408 /* c_currency_trl_uu_idx */ ,
200405 /* c_currency_uu_idx */ ,
200411 /* c_cyclephase_uu_idx */ ,
200412 /* c_cyclestep_uu_idx */ ,
200410 /* c_cycle_uu_idx */ ,
200414 /* c_depositbatchline_uu_idx */ ,
200413 /* c_depositbatch_uu_idx */ ,
200418 /* c_doctypecounter_uu_idx */ ,
200417 /* c_doctype_trl_uu_idx */ ,
200415 /* c_doctype_uu_idx */ ,
200421 /* c_dunninglevel_trl_uu_idx */ ,
200420 /* c_dunninglevel_uu_idx */ ,
200423 /* c_dunningrunentry_uu_idx */ ,
200424 /* c_dunningrunline_uu_idx */ ,
200422 /* c_dunningrun_uu_idx */ ,
200419 /* c_dunning_uu_idx */ ,
200426 /* c_element_uu_idx */ ,
200430 /* c_elementvalue_trl_uu_idx */ ,
200429 /* c_elementvalue_uu_idx */ ,
200432 /* c_greeting_trl_uu_idx */ ,
200431 /* c_greeting_uu_idx */ ,
200433 /* c_interorg_acct_uu_idx */ ,
200442 /* c_invoicebatchline_uu_idx */ ,
200441 /* c_invoicebatch_uu_idx */ ,
200444 /* c_invoiceline_uu_idx */ ,
200448 /* c_invoicepayschedule_uu_idx */ ,
200449 /* c_invoiceschedule_uu_idx */ ,
200450 /* c_invoicetax_uu_idx */ ,
200437 /* c_invoice_uu_idx */ ,
200452 /* c_jobassignment_uu_idx */ ,
200453 /* c_jobcategory_uu_idx */ ,
200454 /* c_jobremuneration_uu_idx */ ,
200451 /* c_job_uu_idx */ ,
200456 /* c_landedcostallocation_uu_idx */ ,
200455 /* c_landedcost_uu_idx */ ,
200457 /* c_location_uu_idx */ ,
200572 /* cm_accesscontainer_uu_idx */ ,
200573 /* cm_accesslistbpgroup_uu_idx */ ,
200574 /* cm_accesslistrole_uu_idx */ ,
200575 /* cm_accessmedia_uu_idx */ ,
200576 /* cm_accessnewschannel_uu_idx */ ,
200577 /* cm_accessprofile_uu_idx */ ,
200578 /* cm_accessstage_uu_idx */ ,
200580 /* cm_ad_cat_uu_idx */ ,
200579 /* cm_ad_uu_idx */ ,
200581 /* cm_broadcastserver_uu_idx */ ,
200584 /* cm_chatentry_uu_idx */ ,
200587 /* cm_chattypeupdate_uu_idx */ ,
200585 /* cm_chattype_uu_idx */ ,
200588 /* cm_chatupdate_uu_idx */ ,
200583 /* cm_chat_uu_idx */ ,
200591 /* cm_container_element_tr_uu_idx */ ,
200590 /* cm_container_element_uu_idx */ ,
200592 /* cm_container_trl_uu_idx */ ,
200594 /* cm_containerttable_uu_idx */ ,
200593 /* cm_container_url_uu_idx */ ,
200589 /* cm_container_uu_idx */ ,
200598 /* cm_cstage_element_trl_uu_idx */ ,
200596 /* cm_cstage_element_uu_idx */ ,
200599 /* cm_cstage_trl_uu_idx */ ,
200600 /* cm_cstagettable_uu_idx */ ,
200595 /* cm_cstage_uu_idx */ ,
200603 /* cm_mediadeploy_uu_idx */ ,
200602 /* cm_media_server_uu_idx */ ,
200601 /* cm_media_uu_idx */ ,
200604 /* cm_newschannel_uu_idx */ ,
200605 /* cm_newsitem_uu_idx */ ,
200607 /* cm_template_ad_cat_uu_idx */ ,
200608 /* cm_templatetable_uu_idx */ ,
200606 /* cm_template_uu_idx */ ,
200609 /* cm_webaccesslog_uu_idx */ ,
200611 /* cm_webproject_domain_uu_idx */ ,
200610 /* cm_webproject_uu_idx */ ,
200612 /* cm_wikitoken_uu_idx */ ,
200458 /* c_nonbusinessday_uu_idx */ ,
200459 /* c_onlinetrxhistory_uu_idx */ ,
200460 /* c_opportunity_uu_idx */ ,
200467 /* c_orderlandedcostalloc_uu_idx */ ,
200466 /* c_orderlandedcost_uu_idx */ ,
200470 /* c_orderline_uu_idx */ ,
200471 /* c_orderpayschedule_uu_idx */ ,
200473 /* c_ordersource_uu_idx */ ,
200474 /* c_ordertax_uu_idx */ ,
200461 /* c_order_uu_idx */ ,
200475 /* c_orgassignment_uu_idx */ ,
200480 /* c_paymentallocate_uu_idx */ ,
200481 /* c_paymentbatch_uu_idx */ ,
200482 /* c_paymentprocessor_uu_idx */ ,
200486 /* c_paymentterm_trl_uu_idx */ ,
200484 /* c_paymentterm_uu_idx */ ,
200487 /* c_paymenttransaction_uu_idx */ ,
200476 /* c_payment_uu_idx */ ,
200488 /* c_payschedule_uu_idx */ ,
200490 /* c_payselectioncheck_uu_idx */ ,
200492 /* c_payselectionline_uu_idx */ ,
200489 /* c_payselection_uu_idx */ ,
200495 /* c_periodcontrol_uu_idx */ ,
200494 /* c_period_uu_idx */ ,
200496 /* c_phase_uu_idx */ ,
200499 /* c_poskeylayout_uu_idx */ ,
200498 /* c_poskey_uu_idx */ ,
200500 /* c_pospayment_uu_idx */ ,
200501 /* c_postendertype_uu_idx */ ,
200497 /* c_pos_uu_idx */ ,
200504 /* c_project_acct_uu_idx */ ,
200507 /* c_projectissuema_uu_idx */ ,
200505 /* c_projectissue_uu_idx */ ,
200508 /* c_projectline_uu_idx */ ,
200509 /* c_projectphase_uu_idx */ ,
200510 /* c_projecttask_uu_idx */ ,
200511 /* c_projecttype_uu_idx */ ,
200503 /* c_project_uu_idx */ ,
200513 /* c_recurring_run_uu_idx */ ,
200512 /* c_recurring_uu_idx */ ,
200514 /* c_region_uu_idx */ ,
200516 /* c_remuneration_uu_idx */ ,
200519 /* c_revenuerecognition_pl_uu_idx */ ,
200520 /* c_revenuerecognition_ru_uu_idx */ ,
200517 /* c_revenuerecognition_uu_idx */ ,
200526 /* c_rfqlineqty_uu_idx */ ,
200525 /* c_rfqline_uu_idx */ ,
200529 /* c_rfqresponselineqty_uu_idx */ ,
200528 /* c_rfqresponseline_uu_idx */ ,
200527 /* c_rfqresponse_uu_idx */ ,
200524 /* c_rfq_topicsubscriberon_uu_idx */ ,
200523 /* c_rfq_topicsubscriber_uu_idx */ ,
200522 /* c_rfq_topic_uu_idx */ ,
200521 /* c_rfq_uu_idx */ ,
200530 /* c_salesregion_uu_idx */ ,
200532 /* c_salesstage_uu_idx */ ,
200534 /* c_servicelevelline_uu_idx */ ,
200533 /* c_servicelevel_uu_idx */ ,
200535 /* c_subacct_uu_idx */ ,
200537 /* c_subscription_delivery_uu_idx */ ,
200538 /* c_subscriptiontype_uu_idx */ ,
200536 /* c_subscription_uu_idx */ ,
200539 /* c_task_uu_idx */ ,
200543 /* c_tax_acct_uu_idx */ ,
200545 /* c_taxbase_uu_idx */ ,
200548 /* c_taxcategory_trl_uu_idx */ ,
200547 /* c_taxcategory_uu_idx */ ,
200550 /* c_taxdeclarationacct_uu_idx */ ,
200551 /* c_taxdeclarationline_uu_idx */ ,
200549 /* c_taxdeclaration_uu_idx */ ,
200552 /* c_taxdefinition_uu_idx */ ,
200553 /* c_taxgroup_uu_idx */ ,
200554 /* c_taxpostal_uu_idx */ ,
200556 /* c_taxprovidercfg_uu_idx */ ,
200555 /* c_taxprovider_uu_idx */ ,
200544 /* c_tax_trl_uu_idx */ ,
200557 /* c_taxtype_uu_idx */ ,
200540 /* c_tax_uu_idx */ ,
200561 /* c_uom_conversion_uu_idx */ ,
200563 /* c_uom_trl_uu_idx */ ,
200559 /* c_uom_uu_idx */ ,
200564 /* c_userremuneration_uu_idx */ ,
200566 /* c_validcombination_uu_idx */ ,
200569 /* c_withholding_acct_uu_idx */ ,
200568 /* c_withholding_uu_idx */ ,
200570 /* c_year_uu_idx */ ,
200614 /* dd_networkdistributionl_uu_idx */ ,
200613 /* dd_networkdistribution_uu_idx */ ,
200617 /* dd_orderline_uu_idx */ ,
200616 /* dd_order_uu_idx */ ,
200619 /* exp_formatline_uu_idx */ ,
200618 /* exp_format_uu_idx */ ,
200622 /* exp_processorparameter_uu_idx */ ,
200621 /* exp_processor_type_uu_idx */ ,
200620 /* exp_processor_uu_idx */ ,
200631 /* fact_acct_summary_uu_idx */ ,
200624 /* fact_acct_uu_idx */ ,
200632 /* fact_reconciliation_uu_idx */ ,
200636 /* gl_budgetcontrol_uu_idx */ ,
200634 /* gl_budget_uu_idx */ ,
200637 /* gl_category_uu_idx */ ,
200640 /* gl_distributionline_uu_idx */ ,
200639 /* gl_distribution_uu_idx */ ,
200642 /* gl_fundrestriction_uu_idx */ ,
200641 /* gl_fund_uu_idx */ ,
200646 /* gl_journalbatch_uu_idx */ ,
200649 /* gl_journalgeneratorline_uu_idx */ ,
200650 /* gl_journalgeneratorsour_uu_idx */ ,
200648 /* gl_journalgenerator_uu_idx */ ,
200651 /* gl_journalline_uu_idx */ ,
200643 /* gl_journal_uu_idx */ ,
200653 /* hr_attribute_uu_idx */ ,
200655 /* hr_concept_acct_uu_idx */ ,
200656 /* hr_concept_category_uu_idx */ ,
200654 /* hr_concept_uu_idx */ ,
200658 /* hr_contract_uu_idx */ ,
200659 /* hr_department_uu_idx */ ,
200661 /* hr_employee_uu_idx */ ,
200663 /* hr_job_uu_idx */ ,
200665 /* hr_listline_uu_idx */ ,
200666 /* hr_listtype_uu_idx */ ,
200664 /* hr_list_uu_idx */ ,
200667 /* hr_listversion_uu_idx */ ,
200668 /* hr_movement_uu_idx */ ,
200670 /* hr_payrollconcept_uu_idx */ ,
200669 /* hr_payroll_uu_idx */ ,
200671 /* hr_period_uu_idx */ ,
200672 /* hr_process_uu_idx */ ,
200674 /* hr_year_uu_idx */ ,
200675 /* i_asset_uu_idx */ ,
200676 /* i_bankstatement_uu_idx */ ,
200677 /* i_bpartner_uu_idx */ ,
200678 /* i_conversion_rate_uu_idx */ ,
200679 /* i_elementvalue_uu_idx */ ,
200680 /* i_fajournal_uu_idx */ ,
200681 /* i_fixedasset_uu_idx */ ,
200682 /* i_gljournal_uu_idx */ ,
200683 /* i_hr_movement_uu_idx */ ,
200684 /* i_inoutlineconfirm_uu_idx */ ,
200685 /* i_inventory_uu_idx */ ,
200686 /* i_invoice_uu_idx */ ,
200687 /* i_movement_uu_idx */ ,
200696 /* imp_processorlog_uu_idx */ ,
200697 /* imp_processorparameter_uu_idx */ ,
200695 /* imp_processor_type_uu_idx */ ,
200694 /* imp_processor_uu_idx */ ,
200688 /* i_order_uu_idx */ ,
200689 /* i_payment_uu_idx */ ,
200690 /* i_pricelist_uu_idx */ ,
200692 /* i_productplanning_uu_idx */ ,
200691 /* i_product_uu_idx */ ,
200693 /* i_reportline_uu_idx */ ,
200698 /* k_category_uu_idx */ ,
200699 /* k_categoryvalue_uu_idx */ ,
200700 /* k_comment_uu_idx */ ,
200702 /* k_entrycategory_uu_idx */ ,
200703 /* k_entryrelated_uu_idx */ ,
200701 /* k_entry_uu_idx */ ,
200706 /* k_indexlog_uu_idx */ ,
200707 /* k_indexstop_uu_idx */ ,
200704 /* k_index_uu_idx */ ,
200709 /* k_source_uu_idx */ ,
200710 /* k_synonym_uu_idx */ ,
200711 /* k_topic_uu_idx */ ,
200712 /* k_type_uu_idx */ ,
200714 /* m_attributeinstance_uu_idx */ ,
200715 /* m_attributesearch_uu_idx */ ,
200717 /* m_attributesetexclude_uu_idx */ ,
200718 /* m_attributesetinstance_uu_idx */ ,
200716 /* m_attributeset_uu_idx */ ,
200719 /* m_attributeuse_uu_idx */ ,
200713 /* m_attribute_uu_idx */ ,
200720 /* m_attributevalue_uu_idx */ ,
200723 /* m_bomalternative_uu_idx */ ,
200724 /* m_bomproduct_uu_idx */ ,
200721 /* m_bom_uu_idx */ ,
200725 /* m_bp_price_uu_idx */ ,
200726 /* m_changenotice_uu_idx */ ,
200727 /* m_changerequest_uu_idx */ ,
200728 /* m_commodityshipment_uu_idx */ ,
200730 /* m_costdetail_uu_idx */ ,
200733 /* m_costelement_uu_idx */ ,
200734 /* m_costhistory_uu_idx */ ,
200735 /* m_costqueue_uu_idx */ ,
200737 /* m_costtype_uu_idx */ ,
200729 /* m_cost_uu_idx */ ,
200739 /* m_demanddetail_uu_idx */ ,
200740 /* m_demandline_uu_idx */ ,
200738 /* m_demand_uu_idx */ ,
200742 /* m_discountschemabreak_uu_idx */ ,
200743 /* m_discountschemaline_uu_idx */ ,
200741 /* m_discountschema_uu_idx */ ,
200745 /* m_distributionlistline_uu_idx */ ,
200744 /* m_distributionlist_uu_idx */ ,
200747 /* m_distributionrunline_uu_idx */ ,
200746 /* m_distributionrun_uu_idx */ ,
200750 /* m_forecastline_uu_idx */ ,
200749 /* m_forecast_uu_idx */ ,
200752 /* m_freightcategory_uu_idx */ ,
200751 /* m_freight_uu_idx */ ,
200759 /* m_inoutconfirm_uu_idx */ ,
200763 /* m_inoutlineconfirm_uu_idx */ ,
200764 /* m_inoutlinema_uu_idx */ ,
200762 /* m_inoutline_uu_idx */ ,
200755 /* m_inout_uu_idx */ ,
200769 /* m_inventorylinema_uu_idx */ ,
200767 /* m_inventoryline_uu_idx */ ,
200766 /* m_inventory_uu_idx */ ,
201037 /* m_locatortype_uu_idx */ ,
200771 /* m_locator_uu_idx */ ,
200774 /* m_lotctlexclude_uu_idx */ ,
200773 /* m_lotctl_uu_idx */ ,
200772 /* m_lot_uu_idx */ ,
200776 /* m_matchinv_uu_idx */ ,
200778 /* m_matchpo_uu_idx */ ,
200783 /* m_movementconfirm_uu_idx */ ,
200786 /* m_movementlineconfirm_uu_idx */ ,
200787 /* m_movementlinema_uu_idx */ ,
200784 /* m_movementline_uu_idx */ ,
200781 /* m_movement_uu_idx */ ,
200788 /* m_operationresource_uu_idx */ ,
200790 /* m_packageline_uu_idx */ ,
200791 /* m_packagemps_uu_idx */ ,
200789 /* m_package_uu_idx */ ,
200792 /* m_parttype_uu_idx */ ,
200793 /* m_perpetualinv_uu_idx */ ,
200795 /* m_pricelist_uu_idx */ ,
200797 /* m_pricelist_version_uu_idx */ ,
200805 /* m_product_acct_uu_idx */ ,
200809 /* m_product_category_acct_uu_idx */ ,
200808 /* m_product_category_uu_idx */ ,
200814 /* m_productdownload_uu_idx */ ,
200820 /* m_productionlinema_uu_idx */ ,
200817 /* m_productionline_uu_idx */ ,
200821 /* m_productionplan_uu_idx */ ,
200815 /* m_production_uu_idx */ ,
200823 /* m_productoperation_uu_idx */ ,
200811 /* m_product_po_uu_idx */ ,
200824 /* m_productprice_uu_idx */ ,
200825 /* m_productpricevendorbre_uu_idx */ ,
200812 /* m_product_qualitytest_uu_idx */ ,
200813 /* m_product_trl_uu_idx */ ,
200800 /* m_product_uu_idx */ ,
200827 /* m_promotiondistribution_uu_idx */ ,
200829 /* m_promotiongroupline_uu_idx */ ,
200828 /* m_promotiongroup_uu_idx */ ,
200830 /* m_promotionline_uu_idx */ ,
200831 /* m_promotionprecondition_uu_idx */ ,
200832 /* m_promotionreward_uu_idx */ ,
200826 /* m_promotion_uu_idx */ ,
200834 /* m_qualitytestresult_uu_idx */ ,
200833 /* m_qualitytest_uu_idx */ ,
200835 /* m_relatedproduct_uu_idx */ ,
200836 /* m_replenish_uu_idx */ ,
200839 /* m_requisitionline_uu_idx */ ,
200838 /* m_requisition_uu_idx */ ,
200841 /* m_rmaline_uu_idx */ ,
200842 /* m_rmatax_uu_idx */ ,
200843 /* m_rmatype_uu_idx */ ,
200840 /* m_rma_uu_idx */ ,
200845 /* m_sernoctlexclude_uu_idx */ ,
200844 /* m_sernoctl_uu_idx */ ,
200847 /* m_shippercfg_uu_idx */ ,
200852 /* m_shipperlabelscfg_uu_idx */ ,
200850 /* m_shipperlabels_uu_idx */ ,
200856 /* m_shipperpackagingcfg_uu_idx */ ,
200853 /* m_shipperpackaging_uu_idx */ ,
200860 /* m_shipperpickuptypescfg_uu_idx */ ,
200857 /* m_shipperpickuptypes_uu_idx */ ,
200846 /* m_shipper_uu_idx */ ,
200863 /* m_shippingprocessorcfg_uu_idx */ ,
200861 /* m_shippingprocessor_uu_idx */ ,
200866 /* m_shippingtransactionli_uu_idx */ ,
200865 /* m_shippingtransaction_uu_idx */ ,
200867 /* m_storageonhand_uu_idx */ ,
200868 /* m_storagereservation_uu_idx */ ,
200869 /* m_substitute_uu_idx */ ,
200872 /* m_transactionallocation_uu_idx */ ,
200870 /* m_transaction_uu_idx */ ,
200876 /* m_warehouse_acct_uu_idx */ ,
200875 /* m_warehouse_uu_idx */ ,
200877 /* pa_achievement_uu_idx */ ,
200879 /* pa_benchmarkdata_uu_idx */ ,
200878 /* pa_benchmark_uu_idx */ ,
200880 /* pa_colorschema_uu_idx */ ,
200882 /* padashboardcontentacces_uu_idx */ ,
200883 /* pa_dashboardcontent_trl_uu_idx */ ,
200881 /* pa_dashboardcontent_uu_idx */ ,
200884 /* pa_dashboardpreference_uu_idx */ ,
200886 /* pa_goalrestriction_uu_idx */ ,
200885 /* pa_goal_uu_idx */ ,
200887 /* pa_hierarchy_uu_idx */ ,
200889 /* pa_measurecalc_uu_idx */ ,
200888 /* pa_measure_uu_idx */ ,
200891 /* pa_ratioelement_uu_idx */ ,
200890 /* pa_ratio_uu_idx */ ,
200894 /* pa_reportcolumnset_uu_idx */ ,
201075 /* pa_reportcolumn_trl_uu_idx */ ,
200893 /* pa_reportcolumn_uu_idx */ ,
200895 /* pa_reportcube_uu_idx */ ,
200897 /* pa_reportlineset_uu_idx */ ,
201076 /* pa_reportline_trl_uu_idx */ ,
200896 /* pa_reportline_uu_idx */ ,
200898 /* pa_reportsource_uu_idx */ ,
200892 /* pa_report_uu_idx */ ,
200899 /* pa_sla_criteria_uu_idx */ ,
200900 /* pa_sla_goal_uu_idx */ ,
200901 /* pa_sla_measure_uu_idx */ ,
200904 /* pp_cost_collectorma_uu_idx */ ,
200903 /* pp_cost_collector_uu_idx */ ,
200905 /* pp_mrp_uu_idx */ ,
200911 /* pp_order_bomline_trl_uu_idx */ ,
200910 /* pp_order_bomline_uu_idx */ ,
200909 /* pp_order_bom_trl_uu_idx */ ,
200908 /* pp_order_bom_uu_idx */ ,
200912 /* pp_order_cost_uu_idx */ ,
200914 /* pp_order_node_asset_uu_idx */ ,
200917 /* pp_order_nodenext_uu_idx */ ,
200915 /* pp_order_node_product_uu_idx */ ,
200916 /* pp_order_node_trl_uu_idx */ ,
200913 /* pp_order_node_uu_idx */ ,
200907 /* pp_order_uu_idx */ ,
200919 /* pp_order_workflow_trl_uu_idx */ ,
200918 /* pp_order_workflow_uu_idx */ ,
200924 /* pp_product_bomline_trl_uu_idx */ ,
200923 /* pp_product_bomline_uu_idx */ ,
200922 /* pp_product_bom_trl_uu_idx */ ,
200920 /* pp_product_bom_uu_idx */ ,
200925 /* pp_product_planning_uu_idx */ ,
200926 /* pp_wf_node_asset_uu_idx */ ,
200927 /* pp_wf_node_product_uu_idx */ ,
200929 /* qm_specificationline_uu_idx */ ,
200928 /* qm_specification_uu_idx */ ,
200931 /* r_categoryupdates_uu_idx */ ,
200930 /* r_category_uu_idx */ ,
200932 /* r_contactinterest_uu_idx */ ,
200934 /* r_groupupdates_uu_idx */ ,
200933 /* r_group_uu_idx */ ,
200935 /* r_interestarea_uu_idx */ ,
200937 /* r_issueknown_uu_idx */ ,
200939 /* r_issueproject_uu_idx */ ,
200940 /* r_issuerecommendation_uu_idx */ ,
200941 /* r_issuestatus_uu_idx */ ,
200942 /* r_issuesystem_uu_idx */ ,
200944 /* r_issueuser_uu_idx */ ,
200947 /* r_mailtext_trl_uu_idx */ ,
200946 /* r_mailtext_uu_idx */ ,
200951 /* r_requestaction_uu_idx */ ,
200954 /* r_requestprocessorlog_uu_idx */ ,
200953 /* r_requestprocessor_rout_uu_idx */ ,
200952 /* r_requestprocessor_uu_idx */ ,
200956 /* r_requesttypeupdates_uu_idx */ ,
200955 /* r_requesttype_uu_idx */ ,
200958 /* r_requestupdates_uu_idx */ ,
200957 /* r_requestupdate_uu_idx */ ,
200950 /* r_request_uu_idx */ ,
200959 /* r_resolution_uu_idx */ ,
200960 /* r_standardresponse_uu_idx */ ,
200962 /* r_statuscategory_uu_idx */ ,
200961 /* r_status_uu_idx */ ,
200963 /* s_expensetype_uu_idx */ ,
200965 /* s_resourceassignment_uu_idx */ ,
200966 /* s_resourcetype_uu_idx */ ,
200967 /* s_resourceunavailable_uu_idx */ ,
200964 /* s_resource_uu_idx */ ,
200969 /* s_timeexpenseline_uu_idx */ ,
200968 /* s_timeexpense_uu_idx */ ,
200970 /* s_timetype_uu_idx */ ,
200972 /* s_training_class_uu_idx */ ,
200971 /* s_training_uu_idx */ ,
200973 /* t_1099extract_uu_idx */ ,
200974 /* t_aging_uu_idx */ ,
200975 /* t_bankregister_uu_idx */ ,
200976 /* t_bom_indented_uu_idx */ ,
200977 /* t_bomline_uu_idx */ ,
200978 /* t_cashflow_uu_idx */ ,
200980 /* t_distributionrundetail_uu_idx */ ,
200990 /* test_uu_idx */ ,
200981 /* t_inventoryvalue_uu_idx */ ,
200982 /* t_invoicegl_uu_idx */ ,
200983 /* t_mrp_crp_uu_idx */ ,
200984 /* t_reconciliation_uu_idx */ ,
200986 /* t_replenish_uu_idx */ ,
200988 /* t_reportstatement_uu_idx */ ,
200987 /* t_report_uu_idx */ ,
200989 /* t_transaction_uu_idx */ ,
200991 /* u_blacklistcheque_uu_idx */ ,
200993 /* u_posterminal_uu_idx */ ,
200994 /* u_rolemenu_uu_idx */ ,
200996 /* u_webmenu_uu_idx */ ,
200995 /* u_web_properties_uu_idx */ ,
200997 /* w_advertisement_uu_idx */ ,
201001 /* w_basketline_uu_idx */ ,
201000 /* w_basket_uu_idx */ ,
201003 /* w_clickcount_uu_idx */ ,
201002 /* w_click_uu_idx */ ,
201007 /* w_countercount_uu_idx */ ,
201005 /* w_counter_uu_idx */ ,
201010 /* w_mailmsg_trl_uu_idx */ ,
201008 /* w_mailmsg_uu_idx */ ,
201013 /* w_store_trl_uu_idx */ ,
201012 /* w_store_uu_idx */ ,
201016 /* ws_webservicefieldinput_uu_idx */ ,
201017 /* ws_webservicefieldoutpu_uu_idx */ ,
201018 /* ws_webservicemethod_uu_idx */ ,
201015 /* ws_webservice_para_uu_idx */ ,
201020 /* ws_webservicetypeaccess_uu_idx */ ,
201019 /* ws_webservicetype_uu_idx */ ,
201014 /* ws_webservice_uu_idx */
);

-- Apr 10, 2023, 12:27:56 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201181,'c8ed771e-ab78-4437-85c2-9bf1ea398db0',TO_TIMESTAMP('2023-04-10 12:27:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','A_Asset_Group_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:27:56','YYYY-MM-DD HH24:MI:SS'),100,200113,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:27:56 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201619,'e4b6beb8-363b-48d6-b29b-f46df2f69929',TO_TIMESTAMP('2023-04-10 12:27:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:27:56','YYYY-MM-DD HH24:MI:SS'),100,211026,201181,10)
;

-- Apr 10, 2023, 12:27:57 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201182,'9e451ffe-351d-46bd-a071-625a52bc9325',TO_TIMESTAMP('2023-04-10 12:27:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AuthorizationAccount_uu_idx',TO_TIMESTAMP('2023-04-10 12:27:56','YYYY-MM-DD HH24:MI:SS'),100,200272,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:27:57 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201620,'4196ed05-a972-4370-9e3d-483a5e5e2b25',TO_TIMESTAMP('2023-04-10 12:27:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:27:57','YYYY-MM-DD HH24:MI:SS'),100,214398,201182,10)
;

-- Apr 10, 2023, 12:27:57 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201183,'a202326e-f42e-41bf-bb70-e9bdb4cb84c6',TO_TIMESTAMP('2023-04-10 12:27:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_authorizationcredentiauuidx',TO_TIMESTAMP('2023-04-10 12:27:57','YYYY-MM-DD HH24:MI:SS'),100,200271,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:27:58 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201621,'3a46364e-7fa2-4980-a4ec-6170042e31bb',TO_TIMESTAMP('2023-04-10 12:27:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:27:57','YYYY-MM-DD HH24:MI:SS'),100,214383,201183,10)
;

-- Apr 10, 2023, 12:27:58 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201184,'c5d3bdc8-19dd-43d6-8a8a-c14cedc40a9b',TO_TIMESTAMP('2023-04-10 12:27:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_authorizationprovider_uuidx',TO_TIMESTAMP('2023-04-10 12:27:58','YYYY-MM-DD HH24:MI:SS'),100,200269,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:27:58 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201622,'c2e758fe-1e1b-4dd4-ad96-6993112c2a89',TO_TIMESTAMP('2023-04-10 12:27:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:27:58','YYYY-MM-DD HH24:MI:SS'),100,214356,201184,10)
;

-- Apr 10, 2023, 12:27:59 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201185,'f2cb693f-7c0a-48dd-8cf1-f1c8f87261c1',TO_TIMESTAMP('2023-04-10 12:27:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_authorizationscopeprovuuidx',TO_TIMESTAMP('2023-04-10 12:27:58','YYYY-MM-DD HH24:MI:SS'),100,200270,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:27:59 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201623,'cb09dff7-b202-4c6f-9faa-5f86db325b0c',TO_TIMESTAMP('2023-04-10 12:27:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:27:59','YYYY-MM-DD HH24:MI:SS'),100,214370,201185,10)
;

-- Apr 10, 2023, 12:27:59 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201186,'59da4738-cada-4420-958c-b7f0ca51b410',TO_TIMESTAMP('2023-04-10 12:27:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_BroadcastMessage_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:27:59','YYYY-MM-DD HH24:MI:SS'),100,200123,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:00 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201624,'a2027ee0-f4e8-46df-9d37-ea3a6aa19111',TO_TIMESTAMP('2023-04-10 12:27:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:27:59','YYYY-MM-DD HH24:MI:SS'),100,211152,201186,10)
;

-- Apr 10, 2023, 12:28:00 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201187,'e14d90f1-ec6a-49a7-8734-fe5f0d4a4ad0',TO_TIMESTAMP('2023-04-10 12:28:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ChartDatasource_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:00','YYYY-MM-DD HH24:MI:SS'),100,200361,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:00 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201625,'0131a23a-fd17-449c-8adb-343d7e78e841',TO_TIMESTAMP('2023-04-10 12:28:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:00','YYYY-MM-DD HH24:MI:SS'),100,215307,201187,10)
;

-- Apr 10, 2023, 12:28:01 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201188,'2c2d2131-d67a-499c-a517-b6e1390e1bec',TO_TIMESTAMP('2023-04-10 12:28:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Chart_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:00','YYYY-MM-DD HH24:MI:SS'),100,200122,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:01 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201626,'47279e75-ac84-4245-baf0-dccc8a527393',TO_TIMESTAMP('2023-04-10 12:28:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:01','YYYY-MM-DD HH24:MI:SS'),100,211140,201188,10)
;

-- Apr 10, 2023, 12:28:01 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201189,'55b43b58-3555-4079-a7ab-fe7dc33270d0',TO_TIMESTAMP('2023-04-10 12:28:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Color_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:01','YYYY-MM-DD HH24:MI:SS'),100,200114,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:02 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201627,'a0540ee9-d4b6-48e4-8528-e1ca750aa5ea',TO_TIMESTAMP('2023-04-10 12:28:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:01','YYYY-MM-DD HH24:MI:SS'),100,211038,201189,10)
;

-- Apr 10, 2023, 12:28:02 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201190,'91ced12f-7683-431e-989c-8c67ae323f95',TO_TIMESTAMP('2023-04-10 12:28:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_CtxHelpSuggestion_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:02','YYYY-MM-DD HH24:MI:SS'),100,200210,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:02 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201628,'b4612c49-1519-40da-a8e5-7bb737421542',TO_TIMESTAMP('2023-04-10 12:28:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:02','YYYY-MM-DD HH24:MI:SS'),100,212801,201190,10)
;

-- Apr 10, 2023, 12:28:03 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201191,'80d3df1a-d7f8-4442-948b-139af51e31fb',TO_TIMESTAMP('2023-04-10 12:28:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_FieldSuggestion_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:02','YYYY-MM-DD HH24:MI:SS'),100,200209,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:03 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201629,'0ee1b620-2e9e-4a58-8eeb-3c98af06fbe1',TO_TIMESTAMP('2023-04-10 12:28:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:03','YYYY-MM-DD HH24:MI:SS'),100,212778,201191,10)
;

-- Apr 10, 2023, 12:28:04 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201192,'48e46157-25a8-434a-aeb3-f556b21888d7',TO_TIMESTAMP('2023-04-10 12:28:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_InfoProcess_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:03','YYYY-MM-DD HH24:MI:SS'),100,200129,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:04 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201630,'af597585-4ae3-4958-a0c9-47d97f5d2c86',TO_TIMESTAMP('2023-04-10 12:28:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:04','YYYY-MM-DD HH24:MI:SS'),100,211242,201192,10)
;

-- Apr 10, 2023, 12:28:04 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201193,'f4054740-e506-48fc-943d-a5a50f8334b8',TO_TIMESTAMP('2023-04-10 12:28:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_InfoRelated_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:04','YYYY-MM-DD HH24:MI:SS'),100,200089,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:04 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201631,'127d72ac-73cb-4d7f-ba60-25965765f7ca',TO_TIMESTAMP('2023-04-10 12:28:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:04','YYYY-MM-DD HH24:MI:SS'),100,210612,201193,10)
;

-- Apr 10, 2023, 12:28:05 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201194,'533d8bd7-f815-4b44-bd00-5ac6144d6326',TO_TIMESTAMP('2023-04-10 12:28:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Label_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:04','YYYY-MM-DD HH24:MI:SS'),100,200345,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:05 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201632,'49d9b607-e77c-408c-b7c7-19406e9ce334',TO_TIMESTAMP('2023-04-10 12:28:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:05','YYYY-MM-DD HH24:MI:SS'),100,214866,201194,10)
;

-- Apr 10, 2023, 12:28:06 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201195,'0e15b563-debb-4da6-aefc-563d1ec2b381',TO_TIMESTAMP('2023-04-10 12:28:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_LabelAssignment_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:05','YYYY-MM-DD HH24:MI:SS'),100,200347,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:06 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201633,'06001e0f-f79f-4949-99cc-cbc125a059f9',TO_TIMESTAMP('2023-04-10 12:28:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:06','YYYY-MM-DD HH24:MI:SS'),100,214892,201195,10)
;

-- Apr 10, 2023, 12:28:07 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201196,'779fa30e-5eac-4c46-8f53-28de68141ccb',TO_TIMESTAMP('2023-04-10 12:28:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_LabelCategory_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:06','YYYY-MM-DD HH24:MI:SS'),100,200343,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:07 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201634,'fd68c3fd-2dda-4d96-b771-ada78112695c',TO_TIMESTAMP('2023-04-10 12:28:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:07','YYYY-MM-DD HH24:MI:SS'),100,214841,201196,10)
;

-- Apr 10, 2023, 12:28:07 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201197,'067d3b99-4ba2-47ca-8a78-2001dd9f6164',TO_TIMESTAMP('2023-04-10 12:28:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_LabelCategoryTable_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:07','YYYY-MM-DD HH24:MI:SS'),100,200348,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:08 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201635,'ed427d07-21cc-49f6-87ab-2dd8224051e7',TO_TIMESTAMP('2023-04-10 12:28:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:07','YYYY-MM-DD HH24:MI:SS'),100,214905,201197,10)
;

-- Apr 10, 2023, 12:28:08 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201198,'f894e354-ab0a-4879-a2c0-a248be2a53c4',TO_TIMESTAMP('2023-04-10 12:28:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PostIt_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:08','YYYY-MM-DD HH24:MI:SS'),100,200215,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:09 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201636,'2ef6e882-81e4-4d8e-8284-92479f30800a',TO_TIMESTAMP('2023-04-10 12:28:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:08','YYYY-MM-DD HH24:MI:SS'),100,212933,201198,10)
;

-- Apr 10, 2023, 12:28:09 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201199,'98d85b3d-5681-488d-b46d-611dd6956554',TO_TIMESTAMP('2023-04-10 12:28:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintColor_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:09','YYYY-MM-DD HH24:MI:SS'),100,200115,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:09 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201637,'a1e6459f-1913-4c42-8004-d52d4a7f780a',TO_TIMESTAMP('2023-04-10 12:28:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:09','YYYY-MM-DD HH24:MI:SS'),100,211050,201199,10)
;

-- Apr 10, 2023, 12:28:10 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201200,'25ceccca-cfc1-479b-b247-ece414876809',TO_TIMESTAMP('2023-04-10 12:28:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintFormat_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:10','YYYY-MM-DD HH24:MI:SS'),100,200130,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:10 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201638,'dea6bd61-2829-4d69-8176-ef9cd2ccb02e',TO_TIMESTAMP('2023-04-10 12:28:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:10','YYYY-MM-DD HH24:MI:SS'),100,211271,201200,10)
;

-- Apr 10, 2023, 12:28:11 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201201,'7c977636-d1fc-429a-afe1-3caa95f17c07',TO_TIMESTAMP('2023-04-10 12:28:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_PrintHeaderFooter_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:10','YYYY-MM-DD HH24:MI:SS'),100,200240,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:11 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201639,'05895bdb-339c-46d3-8325-a3382fb168c3',TO_TIMESTAMP('2023-04-10 12:28:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:11','YYYY-MM-DD HH24:MI:SS'),100,213510,201201,10)
;

-- Apr 10, 2023, 12:28:11 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201202,'48197807-8007-454d-b4ce-0258f12fdf53',TO_TIMESTAMP('2023-04-10 12:28:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_process_drillrule_trl_uuidx',TO_TIMESTAMP('2023-04-10 12:28:11','YYYY-MM-DD HH24:MI:SS'),100,200349,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:12 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201640,'0f63396b-fdc4-4822-8376-d16ba4f9b3e8',TO_TIMESTAMP('2023-04-10 12:28:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:11','YYYY-MM-DD HH24:MI:SS'),100,214925,201202,10)
;

-- Apr 10, 2023, 12:28:12 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201203,'b453fe5f-4ce2-4738-916e-bdc8ebaa325b',TO_TIMESTAMP('2023-04-10 12:28:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ReportView_Column_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:12','YYYY-MM-DD HH24:MI:SS'),100,200109,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:12 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201641,'d4240e69-5764-4d04-a4cd-4f0e1b1f92cd',TO_TIMESTAMP('2023-04-10 12:28:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:12','YYYY-MM-DD HH24:MI:SS'),100,210937,201203,10)
;

-- Apr 10, 2023, 12:28:13 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201204,'d0c0f776-979c-4a05-9fc8-dd46d54e82a8',TO_TIMESTAMP('2023-04-10 12:28:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_SMTP_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:12','YYYY-MM-DD HH24:MI:SS'),100,200280,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:13 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201642,'7863155f-a829-4278-ad44-cc2a0bd14a60',TO_TIMESTAMP('2023-04-10 12:28:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:13','YYYY-MM-DD HH24:MI:SS'),100,214555,201204,10)
;

-- Apr 10, 2023, 12:28:14 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201205,'f3956787-a4f8-4173-9c98-f8068bb94b5f',TO_TIMESTAMP('2023-04-10 12:28:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_StatusLine_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:13','YYYY-MM-DD HH24:MI:SS'),100,200107,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:14 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201643,'cb9036ad-4dd5-457d-8acf-7916802a1ac0',TO_TIMESTAMP('2023-04-10 12:28:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:14','YYYY-MM-DD HH24:MI:SS'),100,210901,201205,10)
;

-- Apr 10, 2023, 12:28:14 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201206,'b5aeb883-03fa-4613-a212-77fa5f18eb0c',TO_TIMESTAMP('2023-04-10 12:28:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_StatusLineUsedIn_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:14','YYYY-MM-DD HH24:MI:SS'),100,200108,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:15 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201644,'04adda9c-063f-40b9-ab20-042fb0c9fb00',TO_TIMESTAMP('2023-04-10 12:28:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:14','YYYY-MM-DD HH24:MI:SS'),100,210914,201206,10)
;

-- Apr 10, 2023, 12:28:15 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201207,'cc5ce507-3b90-4206-a117-442285d41a5b',TO_TIMESTAMP('2023-04-10 12:28:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Style_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:15','YYYY-MM-DD HH24:MI:SS'),100,200207,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:15 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201645,'cf3305ce-ec36-4da3-98ef-7a54cfa9f48a',TO_TIMESTAMP('2023-04-10 12:28:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:15','YYYY-MM-DD HH24:MI:SS'),100,212735,201207,10)
;

-- Apr 10, 2023, 12:28:16 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201208,'ad50beb7-8c6d-4d6c-9f87-0c77bc6cce0e',TO_TIMESTAMP('2023-04-10 12:28:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_StyleLine_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:15','YYYY-MM-DD HH24:MI:SS'),100,200208,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:16 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201646,'dc637eb5-1b40-410a-9770-3faf176f04d7',TO_TIMESTAMP('2023-04-10 12:28:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:16','YYYY-MM-DD HH24:MI:SS'),100,212747,201208,10)
;

-- Apr 10, 2023, 12:28:16 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201209,'2374d962-6434-42b1-940e-c88d988e91a7',TO_TIMESTAMP('2023-04-10 12:28:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Tree_Favorite_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:16','YYYY-MM-DD HH24:MI:SS'),100,200220,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:17 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201647,'3be534b7-de18-42fa-895f-390b0a2d408e',TO_TIMESTAMP('2023-04-10 12:28:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:16','YYYY-MM-DD HH24:MI:SS'),100,213057,201209,10)
;

-- Apr 10, 2023, 12:28:17 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201210,'dd2d5cb4-22b7-4b0f-ac2a-434647c4c417',TO_TIMESTAMP('2023-04-10 12:28:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Tree_Favorite_Node_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:17','YYYY-MM-DD HH24:MI:SS'),100,200221,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:17 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201648,'d64ca537-b484-4ce3-9235-dbb23552626a',TO_TIMESTAMP('2023-04-10 12:28:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:17','YYYY-MM-DD HH24:MI:SS'),100,213068,201210,10)
;

-- Apr 10, 2023, 12:28:18 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201211,'28922182-880f-4562-b1ad-e82597bcf0c3',TO_TIMESTAMP('2023-04-10 12:28:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserDef_Info_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:17','YYYY-MM-DD HH24:MI:SS'),100,200266,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:18 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201649,'f15c4856-8ac5-4060-9017-0e911b319f6c',TO_TIMESTAMP('2023-04-10 12:28:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:18','YYYY-MM-DD HH24:MI:SS'),100,214245,201211,10)
;

-- Apr 10, 2023, 12:28:18 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201212,'077c06e5-7dee-4a31-815b-7807683d6d7c',TO_TIMESTAMP('2023-04-10 12:28:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserDef_Info_Column_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:18','YYYY-MM-DD HH24:MI:SS'),100,200268,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:19 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201650,'2edd6f4a-d5d3-41b4-b4eb-a7e27676b149',TO_TIMESTAMP('2023-04-10 12:28:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:18','YYYY-MM-DD HH24:MI:SS'),100,214283,201212,10)
;

-- Apr 10, 2023, 12:28:19 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201213,'3497b836-7a2f-45c3-93fd-9f80e58d241a',TO_TIMESTAMP('2023-04-10 12:28:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserDef_Info_Related_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:19','YYYY-MM-DD HH24:MI:SS'),100,200267,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:19 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201651,'71eaca16-ec27-4ff4-901c-bdc85ac7cb50',TO_TIMESTAMP('2023-04-10 12:28:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:19','YYYY-MM-DD HH24:MI:SS'),100,214261,201213,10)
;

-- Apr 10, 2023, 12:28:20 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201214,'611cb316-50f4-48f7-ba69-19c2ef3a5632',TO_TIMESTAMP('2023-04-10 12:28:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserDef_Proc_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:19','YYYY-MM-DD HH24:MI:SS'),100,200232,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:20 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201652,'40782a2d-ce2f-4ecc-b61d-9e973e84afc1',TO_TIMESTAMP('2023-04-10 12:28:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:20','YYYY-MM-DD HH24:MI:SS'),100,213261,201214,10)
;

-- Apr 10, 2023, 12:28:20 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201215,'bb1ba939-d33c-405a-86c6-034f4acf2759',TO_TIMESTAMP('2023-04-10 12:28:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_userdef_proc_parameteruuidx',TO_TIMESTAMP('2023-04-10 12:28:20','YYYY-MM-DD HH24:MI:SS'),100,200233,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:21 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201653,'d93adead-25aa-4c68-8e71-cf77cb367d35',TO_TIMESTAMP('2023-04-10 12:28:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:20','YYYY-MM-DD HH24:MI:SS'),100,213279,201215,10)
;

-- Apr 10, 2023, 12:28:21 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201216,'837047ab-db14-48f0-9231-e3c859250f75',TO_TIMESTAMP('2023-04-10 12:28:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_UserPreference_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:21','YYYY-MM-DD HH24:MI:SS'),100,200174,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:21 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201654,'45e78d46-9c4f-4166-9246-52da3b6de2ac',TO_TIMESTAMP('2023-04-10 12:28:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:21','YYYY-MM-DD HH24:MI:SS'),100,212167,201216,10)
;

-- Apr 10, 2023, 12:28:21 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201217,'bf7d3555-7930-41cd-8499-11f8c116f93e',TO_TIMESTAMP('2023-04-10 12:28:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_VerifyMigration_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:21','YYYY-MM-DD HH24:MI:SS'),100,200382,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:22 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201655,'f877511d-264e-4570-861f-df2fe7ed1e7c',TO_TIMESTAMP('2023-04-10 12:28:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:21','YYYY-MM-DD HH24:MI:SS'),100,215749,201217,10)
;

-- Apr 10, 2023, 12:28:22 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201218,'449ffe1f-15f6-4c92-b271-fbf5d2ae1a38',TO_TIMESTAMP('2023-04-10 12:28:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_WF_ActivityApprover_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:22','YYYY-MM-DD HH24:MI:SS'),100,200226,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:22 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201656,'e80bc6bf-b6d0-4e30-ac12-7848d1916cae',TO_TIMESTAMP('2023-04-10 12:28:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:22','YYYY-MM-DD HH24:MI:SS'),100,213228,201218,10)
;

-- Apr 10, 2023, 12:28:23 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201219,'996200c6-14bd-4741-8ec4-28ed978c518a',TO_TIMESTAMP('2023-04-10 12:28:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Activity_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:22','YYYY-MM-DD HH24:MI:SS'),100,200116,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:23 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201657,'2243f374-b39d-49ce-8059-f9b43891a053',TO_TIMESTAMP('2023-04-10 12:28:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:23','YYYY-MM-DD HH24:MI:SS'),100,211064,201219,10)
;

-- Apr 10, 2023, 12:28:23 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201220,'5291495c-2f73-4204-a4fc-0be93c494026',TO_TIMESTAMP('2023-04-10 12:28:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_BankTransfer_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:23','YYYY-MM-DD HH24:MI:SS'),100,200246,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:24 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201658,'bb33caf9-d31e-4a62-b121-ff01e1de6c31',TO_TIMESTAMP('2023-04-10 12:28:23','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:23','YYYY-MM-DD HH24:MI:SS'),100,213646,201220,10)
;

-- Apr 10, 2023, 12:28:24 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201221,'e8405818-9860-4730-b472-56b9fa5631b9',TO_TIMESTAMP('2023-04-10 12:28:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Campaign_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:24','YYYY-MM-DD HH24:MI:SS'),100,200117,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:24 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201659,'3fa97672-8d3f-4901-84e8-d784e72f4564',TO_TIMESTAMP('2023-04-10 12:28:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:24','YYYY-MM-DD HH24:MI:SS'),100,211077,201221,10)
;

-- Apr 10, 2023, 12:28:25 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201222,'673043f6-3a5a-4e28-8780-6e479dc10e4d',TO_TIMESTAMP('2023-04-10 12:28:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CountryGroup_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:24','YYYY-MM-DD HH24:MI:SS'),100,200146,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:25 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201660,'52143da2-973b-485c-b3f2-9d1c07c28b4f',TO_TIMESTAMP('2023-04-10 12:28:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:25','YYYY-MM-DD HH24:MI:SS'),100,211628,201222,10)
;

-- Apr 10, 2023, 12:28:25 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201223,'59ba41c3-6c85-4370-89d7-de3cc97bb5fc',TO_TIMESTAMP('2023-04-10 12:28:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_CountryGroupCountry_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:25','YYYY-MM-DD HH24:MI:SS'),100,200145,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:26 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201661,'6fdc4bf8-87df-4e15-ad2c-f3fdfabea94b',TO_TIMESTAMP('2023-04-10 12:28:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:25','YYYY-MM-DD HH24:MI:SS'),100,211608,201223,10)
;

-- Apr 10, 2023, 12:28:26 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201224,'5dd56dc0-91e7-47c1-a9e8-78513fe9bffc',TO_TIMESTAMP('2023-04-10 12:28:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DocBaseGroup_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:26','YYYY-MM-DD HH24:MI:SS'),100,200385,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:26 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201662,'7e8bc861-e705-4740-866b-a8e0e2841f32',TO_TIMESTAMP('2023-04-10 12:28:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:26','YYYY-MM-DD HH24:MI:SS'),100,215818,201224,10)
;

-- Apr 10, 2023, 12:28:27 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201225,'2933034d-9c1d-41e4-bb45-da6ddf5e9a36',TO_TIMESTAMP('2023-04-10 12:28:26','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_DocBaseGroupLine_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:26','YYYY-MM-DD HH24:MI:SS'),100,200386,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:27 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201663,'41ae3ba1-2dac-477c-8882-680b49199f68',TO_TIMESTAMP('2023-04-10 12:28:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:27','YYYY-MM-DD HH24:MI:SS'),100,215830,201225,10)
;

-- Apr 10, 2023, 12:28:27 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201226,'c5ef98ae-9a74-4f4c-8e31-4081917f6856',TO_TIMESTAMP('2023-04-10 12:28:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RecurringGroup_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:27','YYYY-MM-DD HH24:MI:SS'),100,200143,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:28 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201664,'a709a44d-b280-4970-9403-b21fcc937cee',TO_TIMESTAMP('2023-04-10 12:28:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:27','YYYY-MM-DD HH24:MI:SS'),100,211580,201226,10)
;

-- Apr 10, 2023, 12:28:28 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201227,'8bab0d89-a4e6-471c-b49b-239e0a80a7aa',TO_TIMESTAMP('2023-04-10 12:28:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Region_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:28','YYYY-MM-DD HH24:MI:SS'),100,200118,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:28 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201665,'1a6d9d83-4cff-4bee-b89a-41d1c3b5f99d',TO_TIMESTAMP('2023-04-10 12:28:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:28','YYYY-MM-DD HH24:MI:SS'),100,211089,201227,10)
;

-- Apr 10, 2023, 12:28:29 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201228,'770587d0-7f88-40e8-8e50-203fc8986176',TO_TIMESTAMP('2023-04-10 12:28:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_RevenueRecog_Service_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:28','YYYY-MM-DD HH24:MI:SS'),100,53888,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:29 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201666,'6931a7f1-2150-43c3-acdc-5befcdb76814',TO_TIMESTAMP('2023-04-10 12:28:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:29','YYYY-MM-DD HH24:MI:SS'),100,213821,201228,10)
;

-- Apr 10, 2023, 12:28:29 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201229,'5164e2bd-632d-4eeb-a1d5-db90428ae96c',TO_TIMESTAMP('2023-04-10 12:28:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SalesRegion_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:29','YYYY-MM-DD HH24:MI:SS'),100,200119,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:30 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201667,'adcbe450-3431-4dd7-b51d-e39362341761',TO_TIMESTAMP('2023-04-10 12:28:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:29','YYYY-MM-DD HH24:MI:SS'),100,211102,201229,10)
;

-- Apr 10, 2023, 12:28:30 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201230,'03742937-635a-49d7-a173-22c6117a9161',TO_TIMESTAMP('2023-04-10 12:28:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SalesStage_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:30','YYYY-MM-DD HH24:MI:SS'),100,200124,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:30 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201668,'78e1222d-1076-416d-8543-eff31710a40f',TO_TIMESTAMP('2023-04-10 12:28:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:30','YYYY-MM-DD HH24:MI:SS'),100,211167,201230,10)
;

-- Apr 10, 2023, 12:28:30 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201231,'343032ca-c833-4236-8c81-4a813b29fb8f',TO_TIMESTAMP('2023-04-10 12:28:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','GL_Category_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:30','YYYY-MM-DD HH24:MI:SS'),100,200111,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:31 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201669,'3d496d0b-6248-4748-967d-6d1d40cd3828',TO_TIMESTAMP('2023-04-10 12:28:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:30','YYYY-MM-DD HH24:MI:SS'),100,210998,201231,10)
;

-- Apr 10, 2023, 12:28:31 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201232,'1539babd-5cd0-43bc-bdb6-7cfc5143fb4d',TO_TIMESTAMP('2023-04-10 12:28:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','MFA_Method_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:31','YYYY-MM-DD HH24:MI:SS'),100,200273,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:32 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201670,'0b313020-ead9-4d5e-bd76-bc8a8c396722',TO_TIMESTAMP('2023-04-10 12:28:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:31','YYYY-MM-DD HH24:MI:SS'),100,214437,201232,10)
;

-- Apr 10, 2023, 12:28:32 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201233,'74660870-9b82-4cc9-b909-2f18e3f74d44',TO_TIMESTAMP('2023-04-10 12:28:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','MFA_RegisteredDevice_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:32','YYYY-MM-DD HH24:MI:SS'),100,200274,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:32 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201671,'455b75f6-1ffc-45b2-9aa8-a64a3808986a',TO_TIMESTAMP('2023-04-10 12:28:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:32','YYYY-MM-DD HH24:MI:SS'),100,214456,201233,10)
;

-- Apr 10, 2023, 12:28:32 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201234,'5ec6f87b-7300-4079-8911-62c2cb4f35fa',TO_TIMESTAMP('2023-04-10 12:28:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','MFA_Registration_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:32','YYYY-MM-DD HH24:MI:SS'),100,200275,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:33 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201672,'b454ec37-6750-4b66-a84e-d623cdaa6c38',TO_TIMESTAMP('2023-04-10 12:28:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:32','YYYY-MM-DD HH24:MI:SS'),100,214471,201234,10)
;

-- Apr 10, 2023, 12:28:33 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201235,'3b105bef-6bae-4be3-9ed0-84752d2beaa5',TO_TIMESTAMP('2023-04-10 12:28:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','MFA_Rule_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:33','YYYY-MM-DD HH24:MI:SS'),100,200276,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:33 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201673,'d2e64f14-d904-4649-816d-7bf640629f75',TO_TIMESTAMP('2023-04-10 12:28:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:33','YYYY-MM-DD HH24:MI:SS'),100,214490,201235,10)
;

-- Apr 10, 2023, 12:28:34 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201236,'6aebc586-1283-4524-9e6d-d2c56411c3aa',TO_TIMESTAMP('2023-04-10 12:28:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PriceList_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:33','YYYY-MM-DD HH24:MI:SS'),100,200120,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:34 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201674,'456c0bce-fa86-42d9-85c9-ab60f57e991e',TO_TIMESTAMP('2023-04-10 12:28:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:34','YYYY-MM-DD HH24:MI:SS'),100,211115,201236,10)
;

-- Apr 10, 2023, 12:28:34 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201237,'0e017668-e6c0-4357-873e-ec6738821111',TO_TIMESTAMP('2023-04-10 12:28:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_PriceList_Version_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:34','YYYY-MM-DD HH24:MI:SS'),100,200121,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:35 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201675,'e9449225-72f6-4638-b488-6eae87b267b6',TO_TIMESTAMP('2023-04-10 12:28:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:34','YYYY-MM-DD HH24:MI:SS'),100,211127,201237,10)
;

-- Apr 10, 2023, 12:28:35 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201238,'d277d731-0ecc-434c-99d4-8cf5f49bf14d',TO_TIMESTAMP('2023-04-10 12:28:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_Product_Category_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:35','YYYY-MM-DD HH24:MI:SS'),100,200112,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:35 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201676,'58e4634e-6a01-465d-b96c-451db6480c51',TO_TIMESTAMP('2023-04-10 12:28:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:35','YYYY-MM-DD HH24:MI:SS'),100,211012,201238,10)
;

-- Apr 10, 2023, 12:28:36 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201239,'ef7384cc-31d0-4b25-bd21-fc84cb39f840',TO_TIMESTAMP('2023-04-10 12:28:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_StorageReservationLog_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:36','YYYY-MM-DD HH24:MI:SS'),100,200281,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:36 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201677,'29c2fa87-7582-4fda-92b3-827dc21ab984',TO_TIMESTAMP('2023-04-10 12:28:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:36','YYYY-MM-DD HH24:MI:SS'),100,214605,201239,10)
;

-- Apr 10, 2023, 12:28:37 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201240,'f5455196-57a3-4c7d-851b-ab2232dcc71e',TO_TIMESTAMP('2023-04-10 12:28:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_DocumentStatus_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:36','YYYY-MM-DD HH24:MI:SS'),100,200216,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:37 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201678,'cf627622-c6aa-4518-b619-f9474a3cb254',TO_TIMESTAMP('2023-04-10 12:28:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:37','YYYY-MM-DD HH24:MI:SS'),100,213007,201240,10)
;

-- Apr 10, 2023, 12:28:37 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201241,'37c3f556-1baf-4dbd-8a3a-fd416cfdc9b3',TO_TIMESTAMP('2023-04-10 12:28:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_DocumentStatusAccess_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:37','YYYY-MM-DD HH24:MI:SS'),100,200278,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:37 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201679,'9b51bde4-32c4-4d9a-b29a-af420b890d08',TO_TIMESTAMP('2023-04-10 12:28:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:37','YYYY-MM-DD HH24:MI:SS'),100,214529,201241,10)
;

-- Apr 10, 2023, 12:28:38 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201242,'b4ef1f86-7829-41cd-828c-95a341b76c9c',TO_TIMESTAMP('2023-04-10 12:28:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','PA_DocumentStatus_Trl_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:37','YYYY-MM-DD HH24:MI:SS'),100,200217,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:38 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201680,'20cfd6cd-2581-4392-ab0e-1e6c9a0ec9b7',TO_TIMESTAMP('2023-04-10 12:28:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:38','YYYY-MM-DD HH24:MI:SS'),100,213010,201242,10)
;

-- Apr 10, 2023, 12:28:38 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201243,'e5e55d21-cdb4-403c-a940-3df970d59728',TO_TIMESTAMP('2023-04-10 12:28:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','TestUU_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:38','YYYY-MM-DD HH24:MI:SS'),100,200383,'Y','Y','N','Y')
;

-- Apr 10, 2023, 12:28:39 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201681,'2704f844-fd63-485e-8ae5-9b27080a229c',TO_TIMESTAMP('2023-04-10 12:28:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:38','YYYY-MM-DD HH24:MI:SS'),100,215785,201243,10)
;

-- Apr 10, 2023, 12:28:39 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201244,'a8fe46d6-949a-4cf1-b383-c1267917276d',TO_TIMESTAMP('2023-04-10 12:28:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','TestUUDet_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:39','YYYY-MM-DD HH24:MI:SS'),100,200384,'Y','Y','N','Y')
;

-- Apr 10, 2023, 12:28:39 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201682,'0bb1ec9a-a75b-4f25-be3d-8dc34b25786e',TO_TIMESTAMP('2023-04-10 12:28:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:39','YYYY-MM-DD HH24:MI:SS'),100,215802,201244,10)
;

-- Apr 10, 2023, 12:28:40 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201245,'74f168d1-8007-4e77-9b29-c5f200f369e5',TO_TIMESTAMP('2023-04-10 12:28:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','T_TrialBalance_uu_idx',TO_TIMESTAMP('2023-04-10 12:28:39','YYYY-MM-DD HH24:MI:SS'),100,753,'Y','Y','N','N')
;

-- Apr 10, 2023, 12:28:40 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201683,'d1f19e90-0342-4a9f-86bb-32b7d6f1e14b',TO_TIMESTAMP('2023-04-10 12:28:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-04-10 12:28:40','YYYY-MM-DD HH24:MI:SS'),100,215730,201245,10)
;

