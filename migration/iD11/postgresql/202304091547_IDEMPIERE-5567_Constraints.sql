-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195) -- Add unique constraint in all _UU columns
SELECT register_migration_script('202304091547_IDEMPIERE-5567_Constraints.sql') FROM dual;

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

UPDATE AD_Column SET AD_Reference_ID=200231 /* UUID */ WHERE AD_Reference_ID!=200231 AND AD_Column_ID IN (
60352 /* A_Asset.A_Asset_UU */ ,
60353 /* A_Asset_Acct.A_Asset_Acct_UU */ ,
60354 /* A_Asset_Addition.A_Asset_Addition_UU */ ,
60355 /* A_Asset_Change.A_Asset_Change_UU */ ,
200856 /* A_Asset_Class.A_Asset_Class_UU */ ,
60356 /* A_Asset_Delivery.A_Asset_Delivery_UU */ ,
60357 /* A_Asset_Disposed.A_Asset_Disposed_UU */ ,
60358 /* A_Asset_Group.A_Asset_Group_UU */ ,
60359 /* A_Asset_Group_Acct.A_Asset_Group_Acct_UU */ ,
211026 /* A_Asset_Group_Trl.A_Asset_Group_Trl_UU */ ,
60360 /* A_Asset_Info_Fin.A_Asset_Info_Fin_UU */ ,
60361 /* A_Asset_Info_Ins.A_Asset_Info_Ins_UU */ ,
60362 /* A_Asset_Info_Lic.A_Asset_Info_Lic_UU */ ,
60363 /* A_Asset_Info_Oth.A_Asset_Info_Oth_UU */ ,
60364 /* A_Asset_Info_Tax.A_Asset_Info_Tax_UU */ ,
200855 /* A_Asset_Product.A_Asset_Product_UU */ ,
60365 /* A_Asset_Retirement.A_Asset_Retirement_UU */ ,
200861 /* A_Asset_Reval.A_Asset_Reval_UU */ ,
60366 /* A_Asset_Reval_Entry.A_Asset_Reval_Entry_UU */ ,
60367 /* A_Asset_Reval_Index.A_Asset_Reval_Index_UU */ ,
60368 /* A_Asset_Split.A_Asset_Split_UU */ ,
60369 /* A_Asset_Spread.A_Asset_Spread_UU */ ,
60370 /* A_Asset_Transfer.A_Asset_Transfer_UU */ ,
200859 /* A_Asset_Type.A_Asset_Type_UU */ ,
60371 /* A_Asset_Use.A_Asset_Use_UU */ ,
60372 /* AD_AccessLog.AD_AccessLog_UU */ ,
60373 /* AD_Alert.AD_Alert_UU */ ,
60374 /* AD_AlertProcessor.AD_AlertProcessor_UU */ ,
60375 /* AD_AlertProcessorLog.AD_AlertProcessorLog_UU */ ,
60376 /* AD_AlertRecipient.AD_AlertRecipient_UU */ ,
60377 /* AD_AlertRule.AD_AlertRule_UU */ ,
60378 /* AD_Archive.AD_Archive_UU */ ,
60379 /* AD_Attachment.AD_Attachment_UU */ ,
60380 /* AD_AttachmentNote.AD_AttachmentNote_UU */ ,
60381 /* AD_Attribute.AD_Attribute_UU */ ,
60382 /* AD_Attribute_Value.AD_Attribute_Value_UU */ ,
214398 /* AD_AuthorizationAccount.AD_AuthorizationAccount_UU */ ,
214383 /* AD_AuthorizationCredential.AD_AuthorizationCredential_UU */ ,
214356 /* AD_AuthorizationProvider.AD_AuthorizationProvider_UU */ ,
214370 /* AD_AuthorizationScopeProv.AD_AuthorizationScopeProv_UU */ ,
201001 /* AD_BroadcastMessage.AD_BroadcastMessage_UU */ ,
211152 /* AD_BroadcastMessage_Trl.AD_BroadcastMessage_Trl_UU */ ,
60383 /* AD_ChangeLog.AD_ChangeLog_UU */ ,
210648 /* AD_Chart.AD_Chart_UU */ ,
210649 /* AD_ChartDatasource.AD_ChartDatasource_UU */ ,
215307 /* AD_ChartDatasource_Trl.AD_ChartDatasource_Trl_UU */ ,
211140 /* AD_Chart_Trl.AD_Chart_Trl_UU */ ,
60384 /* AD_Client.AD_Client_UU */ ,
60385 /* AD_ClientInfo.AD_ClientInfo_UU */ ,
60386 /* AD_ClientShare.AD_ClientShare_UU */ ,
60387 /* AD_Color.AD_Color_UU */ ,
211038 /* AD_Color_Trl.AD_Color_Trl_UU */ ,
60388 /* AD_Column.AD_Column_UU */ ,
60389 /* AD_Column_Access.AD_Column_Access_UU */ ,
60390 /* AD_Column_Trl.AD_Column_Trl_UU */ ,
208533 /* AD_CtxHelp.AD_CtxHelp_UU */ ,
208553 /* AD_CtxHelpMsg.AD_CtxHelpMsg_UU */ ,
208570 /* AD_CtxHelpMsg_Trl.AD_CtxHelpMsg_Trl_UU */ ,
212801 /* AD_CtxHelpSuggestion.AD_CtxHelpSuggestion_UU */ ,
60391 /* AD_Desktop.AD_Desktop_UU */ ,
60392 /* AD_Desktop_Trl.AD_Desktop_Trl_UU */ ,
60393 /* AD_DesktopWorkbench.AD_DesktopWorkbench_UU */ ,
60394 /* AD_Document_Action_Access.AD_Document_Action_Access_UU */ ,
60395 /* AD_Element.AD_Element_UU */ ,
60396 /* AD_Element_Trl.AD_Element_Trl_UU */ ,
60397 /* AD_EntityType.AD_EntityType_UU */ ,
60398 /* A_Depreciation.A_Depreciation_UU */ ,
60399 /* A_Depreciation_Build.A_Depreciation_Build_UU */ ,
60400 /* A_Depreciation_Convention.A_Depreciation_Convention_UU */ ,
60401 /* A_Depreciation_Entry.A_Depreciation_Entry_UU */ ,
60402 /* A_Depreciation_Exp.A_Depreciation_Exp_UU */ ,
60403 /* A_Depreciation_Forecast.A_Depreciation_Forecast_UU */ ,
60404 /* A_Depreciation_Method.A_Depreciation_Method_UU */ ,
60405 /* A_Depreciation_Table_Detail.A_Depreciation_Table_Detail_UU */ ,
60406 /* A_Depreciation_Table_Header.A_Depreciation_Table_Header_UU */ ,
60407 /* A_Depreciation_Workfile.A_Depreciation_Workfile_UU */ ,
60408 /* AD_Error.AD_Error_UU */ ,
60409 /* AD_Field.AD_Field_UU */ ,
60410 /* AD_FieldGroup.AD_FieldGroup_UU */ ,
60411 /* AD_FieldGroup_Trl.AD_FieldGroup_Trl_UU */ ,
212778 /* AD_FieldSuggestion.AD_FieldSuggestion_UU */ ,
60412 /* AD_Field_Trl.AD_Field_Trl_UU */ ,
60413 /* AD_Find.AD_Find_UU */ ,
60414 /* AD_Form.AD_Form_UU */ ,
60415 /* AD_Form_Access.AD_Form_Access_UU */ ,
60416 /* AD_Form_Trl.AD_Form_Trl_UU */ ,
60417 /* AD_HouseKeeping.AD_HouseKeeping_UU */ ,
60418 /* AD_Image.AD_Image_UU */ ,
60419 /* AD_ImpFormat.AD_ImpFormat_UU */ ,
60420 /* AD_ImpFormat_Row.AD_ImpFormat_Row_UU */ ,
211770 /* AD_ImportTemplate.AD_ImportTemplate_UU */ ,
211791 /* AD_ImportTemplateAccess.AD_ImportTemplateAccess_UU */ ,
210534 /* AD_IndexColumn.AD_IndexColumn_UU */ ,
60421 /* AD_InfoColumn.AD_InfoColumn_UU */ ,
60422 /* AD_InfoColumn_Trl.AD_InfoColumn_Trl_UU */ ,
211242 /* AD_InfoProcess.AD_InfoProcess_UU */ ,
210612 /* AD_InfoRelated.AD_InfoRelated_UU */ ,
60423 /* AD_InfoWindow.AD_InfoWindow_UU */ ,
208373 /* AD_InfoWindow_Access.AD_InfoWindow_Access_UU */ ,
60424 /* AD_InfoWindow_Trl.AD_InfoWindow_Trl_UU */ ,
60425 /* AD_Issue.AD_Issue_UU */ ,
214866 /* AD_Label.AD_Label_UU */ ,
214892 /* AD_LabelAssignment.AD_LabelAssignment_UU */ ,
214841 /* AD_LabelCategory.AD_LabelCategory_UU */ ,
214905 /* AD_LabelCategoryTable.AD_LabelCategoryTable_UU */ ,
214860 /* AD_LabelCategory_Trl.AD_LabelCategory_Trl_UU */ ,
60426 /* AD_LabelPrinter.AD_LabelPrinter_UU */ ,
60427 /* AD_LabelPrinterFunction.AD_LabelPrinterFunction_UU */ ,
214886 /* AD_Label_Trl.AD_Label_Trl_UU */ ,
60428 /* AD_Language.AD_Language_UU */ ,
60429 /* AD_LdapAccess.AD_LdapAccess_UU */ ,
60430 /* AD_LdapProcessor.AD_LdapProcessor_UU */ ,
60431 /* AD_LdapProcessorLog.AD_LdapProcessorLog_UU */ ,
60432 /* AD_Menu.AD_Menu_UU */ ,
60433 /* AD_Menu_Trl.AD_Menu_Trl_UU */ ,
60434 /* AD_Message.AD_Message_UU */ ,
60435 /* AD_Message_Trl.AD_Message_Trl_UU */ ,
60436 /* AD_MigrationScript.AD_MigrationScript_UU */ ,
60437 /* AD_ModelValidator.AD_ModelValidator_UU */ ,
60438 /* AD_Modification.AD_Modification_UU */ ,
60439 /* AD_Note.AD_Note_UU */ ,
60440 /* AD_Org.AD_Org_UU */ ,
60441 /* AD_OrgInfo.AD_OrgInfo_UU */ ,
60442 /* AD_OrgType.AD_OrgType_UU */ ,
60443 /* AD_Package_Exp.AD_Package_Exp_UU */ ,
60444 /* AD_Package_Exp_Common.AD_Package_Exp_Common_UU */ ,
60445 /* AD_Package_Exp_Detail.AD_Package_Exp_Detail_UU */ ,
60446 /* AD_Package_Imp.AD_Package_Imp_UU */ ,
60447 /* AD_Package_Imp_Backup.AD_Package_Imp_Backup_UU */ ,
60448 /* AD_Package_Imp_Detail.AD_Package_Imp_Detail_UU */ ,
60449 /* AD_Package_Imp_Inst.AD_Package_Imp_Inst_UU */ ,
60450 /* AD_Package_Imp_Proc.AD_Package_Imp_Proc_UU */ ,
210835 /* AD_Package_UUID_Map.AD_Package_UUID_Map_UU */ ,
212112 /* AD_Password_History.AD_Password_History_UU */ ,
200239 /* AD_PasswordRule.AD_PasswordRule_UU */ ,
60451 /* AD_PInstance.AD_PInstance_UU */ ,
60452 /* AD_PInstance_Log.AD_PInstance_Log_UU */ ,
60453 /* AD_PInstance_Para.AD_PInstance_Para_UU */ ,
212933 /* AD_PostIt.AD_PostIt_UU */ ,
60454 /* AD_Preference.AD_Preference_UU */ ,
60455 /* AD_PrintColor.AD_PrintColor_UU */ ,
211050 /* AD_PrintColor_Trl.AD_PrintColor_Trl_UU */ ,
60456 /* AD_PrintFont.AD_PrintFont_UU */ ,
60457 /* AD_PrintForm.AD_PrintForm_UU */ ,
60458 /* AD_PrintFormat.AD_PrintFormat_UU */ ,
60459 /* AD_PrintFormatItem.AD_PrintFormatItem_UU */ ,
60460 /* AD_PrintFormatItem_Trl.AD_PrintFormatItem_Trl_UU */ ,
211271 /* AD_PrintFormat_Trl.AD_PrintFormat_Trl_UU */ ,
60461 /* AD_PrintGraph.AD_PrintGraph_UU */ ,
213510 /* AD_PrintHeaderFooter.AD_PrintHeaderFooter_UU */ ,
60462 /* AD_PrintLabel.AD_PrintLabel_UU */ ,
60463 /* AD_PrintLabelLine.AD_PrintLabelLine_UU */ ,
60464 /* AD_PrintLabelLine_Trl.AD_PrintLabelLine_Trl_UU */ ,
60465 /* AD_PrintPaper.AD_PrintPaper_UU */ ,
60466 /* AD_PrintTableFormat.AD_PrintTableFormat_UU */ ,
60467 /* AD_Private_Access.AD_Private_Access_UU */ ,
60468 /* AD_Process.AD_Process_UU */ ,
60469 /* AD_Process_Access.AD_Process_Access_UU */ ,
214738 /* AD_Process_DrillRule.AD_Process_DrillRule_UU */ ,
214750 /* AD_Process_DrillRule_Para.AD_Process_DrillRule_Para_UU */ ,
214925 /* AD_Process_DrillRule_Trl.AD_Process_DrillRule_Trl_UU */ ,
60470 /* AD_Process_Para.AD_Process_Para_UU */ ,
60471 /* AD_Process_Para_Trl.AD_Process_Para_Trl_UU */ ,
60472 /* AD_Process_Trl.AD_Process_Trl_UU */ ,
200203 /* AD_RecentItem.AD_RecentItem_UU */ ,
60473 /* AD_Record_Access.AD_Record_Access_UU */ ,
60474 /* AD_Reference.AD_Reference_UU */ ,
60475 /* AD_Reference_Trl.AD_Reference_Trl_UU */ ,
60476 /* AD_Ref_List.AD_Ref_List_UU */ ,
60477 /* AD_Ref_List_Trl.AD_Ref_List_Trl_UU */ ,
60478 /* AD_Ref_Table.AD_Ref_Table_UU */ ,
60479 /* AD_Registration.AD_Registration_UU */ ,
60480 /* AD_RelationType.AD_RelationType_UU */ ,
60481 /* AD_Replication.AD_Replication_UU */ ,
60482 /* AD_ReplicationDocument.AD_ReplicationDocument_UU */ ,
60483 /* AD_Replication_Log.AD_Replication_Log_UU */ ,
60484 /* AD_Replication_Run.AD_Replication_Run_UU */ ,
60485 /* AD_ReplicationStrategy.AD_ReplicationStrategy_UU */ ,
60486 /* AD_ReplicationTable.AD_ReplicationTable_UU */ ,
60487 /* AD_ReportView.AD_ReportView_UU */ ,
60488 /* AD_ReportView_Col.AD_ReportView_Col_UU */ ,
210937 /* AD_ReportView_Column.AD_ReportView_Column_UU */ ,
60489 /* AD_Role.AD_Role_UU */ ,
60490 /* AD_Role_Included.AD_Role_Included_UU */ ,
60491 /* AD_Role_OrgAccess.AD_Role_OrgAccess_UU */ ,
60492 /* AD_Rule.AD_Rule_UU */ ,
200559 /* AD_Schedule.AD_Schedule_UU */ ,
60493 /* AD_Scheduler.AD_Scheduler_UU */ ,
60494 /* AD_SchedulerLog.AD_SchedulerLog_UU */ ,
60495 /* AD_Scheduler_Para.AD_Scheduler_Para_UU */ ,
60496 /* AD_SchedulerRecipient.AD_SchedulerRecipient_UU */ ,
60497 /* AD_SearchDefinition.AD_SearchDefinition_UU */ ,
60498 /* AD_Sequence.AD_Sequence_UU */ ,
60499 /* AD_Sequence_Audit.AD_Sequence_Audit_UU */ ,
60500 /* AD_Sequence_No.AD_Sequence_No_UU */ ,
60501 /* AD_Session.AD_Session_UU */ ,
214555 /* AD_SMTP.AD_SMTP_UU */ ,
210901 /* AD_StatusLine.AD_StatusLine_UU */ ,
210914 /* AD_StatusLineUsedIn.AD_StatusLineUsedIn_UU */ ,
200975 /* AD_StorageProvider.AD_StorageProvider_UU */ ,
212735 /* AD_Style.AD_Style_UU */ ,
212747 /* AD_StyleLine.AD_StyleLine_UU */ ,
60502 /* AD_SysConfig.AD_SysConfig_UU */ ,
60503 /* AD_System.AD_System_UU */ ,
60504 /* AD_Tab.AD_Tab_UU */ ,
200853 /* AD_Tab_Customization.AD_Tab_Customization_UU */ ,
60505 /* AD_Table.AD_Table_UU */ ,
60506 /* AD_Table_Access.AD_Table_Access_UU */ ,
210515 /* AD_TableIndex.AD_TableIndex_UU */ ,
60507 /* AD_Table_ScriptValidator.AD_Table_ScriptValidator_UU */ ,
60508 /* AD_Table_Trl.AD_Table_Trl_UU */ ,
60509 /* AD_Tab_Trl.AD_Tab_Trl_UU */ ,
60510 /* AD_Task.AD_Task_UU */ ,
60511 /* AD_Task_Access.AD_Task_Access_UU */ ,
60512 /* AD_TaskInstance.AD_TaskInstance_UU */ ,
60513 /* AD_Task_Trl.AD_Task_Trl_UU */ ,
200204 /* AD_ToolBarButton.AD_ToolBarButton_UU */ ,
200205 /* AD_ToolBarButtonRestrict.AD_ToolBarButtonRestrict_UU */ ,
60514 /* AD_Tree.AD_Tree_UU */ ,
60515 /* AD_TreeBar.AD_TreeBar_UU */ ,
213057 /* AD_Tree_Favorite.AD_Tree_Favorite_UU */ ,
213068 /* AD_Tree_Favorite_Node.AD_Tree_Favorite_Node_UU */ ,
60516 /* AD_TreeNode.AD_TreeNode_UU */ ,
60517 /* AD_TreeNodeBP.AD_TreeNodeBP_UU */ ,
60518 /* AD_TreeNodeCMC.AD_TreeNodeCMC_UU */ ,
60519 /* AD_TreeNodeCMM.AD_TreeNodeCMM_UU */ ,
60520 /* AD_TreeNodeCMS.AD_TreeNodeCMS_UU */ ,
60521 /* AD_TreeNodeCMT.AD_TreeNodeCMT_UU */ ,
60522 /* AD_TreeNodeMM.AD_TreeNodeMM_UU */ ,
60523 /* AD_TreeNodePR.AD_TreeNodePR_UU */ ,
60524 /* AD_TreeNodeU1.AD_TreeNodeU1_UU */ ,
60525 /* AD_TreeNodeU2.AD_TreeNodeU2_UU */ ,
60526 /* AD_TreeNodeU3.AD_TreeNodeU3_UU */ ,
60527 /* AD_TreeNodeU4.AD_TreeNodeU4_UU */ ,
60528 /* AD_User.AD_User_UU */ ,
60529 /* AD_UserBPAccess.AD_UserBPAccess_UU */ ,
60530 /* AD_UserDef_Field.AD_UserDef_Field_UU */ ,
214245 /* AD_UserDef_Info.AD_UserDef_Info_UU */ ,
214283 /* AD_UserDef_Info_Column.AD_UserDef_Info_Column_UU */ ,
214261 /* AD_UserDef_Info_Related.AD_UserDef_Info_Related_UU */ ,
213261 /* AD_UserDef_Proc.AD_UserDef_Proc_UU */ ,
213279 /* AD_UserDef_Proc_Parameter.AD_UserDef_Proc_Parameter_UU */ ,
60531 /* AD_UserDef_Tab.AD_UserDef_Tab_UU */ ,
60532 /* AD_UserDef_Win.AD_UserDef_Win_UU */ ,
60533 /* AD_UserMail.AD_UserMail_UU */ ,
60534 /* AD_User_OrgAccess.AD_User_OrgAccess_UU */ ,
212167 /* AD_UserPreference.AD_UserPreference_UU */ ,
60535 /* AD_UserQuery.AD_UserQuery_UU */ ,
60536 /* AD_User_Roles.AD_User_Roles_UU */ ,
60537 /* AD_User_Substitute.AD_User_Substitute_UU */ ,
60538 /* AD_Val_Rule.AD_Val_Rule_UU */ ,
215749 /* AD_VerifyMigration.AD_VerifyMigration_UU */ ,
210573 /* AD_ViewColumn.AD_ViewColumn_UU */ ,
210552 /* AD_ViewComponent.AD_ViewComponent_UU */ ,
60539 /* AD_WF_Activity.AD_WF_Activity_UU */ ,
213228 /* AD_WF_ActivityApprover.AD_WF_ActivityApprover_UU */ ,
60540 /* AD_WF_ActivityResult.AD_WF_ActivityResult_UU */ ,
60541 /* AD_WF_Block.AD_WF_Block_UU */ ,
60542 /* AD_WF_EventAudit.AD_WF_EventAudit_UU */ ,
60543 /* AD_WF_NextCondition.AD_WF_NextCondition_UU */ ,
60544 /* AD_WF_Node.AD_WF_Node_UU */ ,
60545 /* AD_WF_NodeNext.AD_WF_NodeNext_UU */ ,
60546 /* AD_WF_Node_Para.AD_WF_Node_Para_UU */ ,
60547 /* AD_WF_Node_Trl.AD_WF_Node_Trl_UU */ ,
60548 /* AD_WF_Process.AD_WF_Process_UU */ ,
60549 /* AD_WF_ProcessData.AD_WF_ProcessData_UU */ ,
60550 /* AD_WF_Responsible.AD_WF_Responsible_UU */ ,
60551 /* AD_Window.AD_Window_UU */ ,
60552 /* AD_Window_Access.AD_Window_Access_UU */ ,
60553 /* AD_Window_Trl.AD_Window_Trl_UU */ ,
200314 /* AD_WizardProcess.AD_WizardProcess_UU */ ,
214544 /* AD_Wlistbox_Customization.AD_Wlistbox_Customization_UU */ ,
60554 /* AD_Workbench.AD_Workbench_UU */ ,
60555 /* AD_Workbench_Trl.AD_Workbench_Trl_UU */ ,
60556 /* AD_WorkbenchWindow.AD_WorkbenchWindow_UU */ ,
60557 /* AD_Workflow.AD_Workflow_UU */ ,
60558 /* AD_Workflow_Access.AD_Workflow_Access_UU */ ,
60559 /* AD_WorkflowProcessor.AD_WorkflowProcessor_UU */ ,
60560 /* AD_WorkflowProcessorLog.AD_WorkflowProcessorLog_UU */ ,
60561 /* AD_Workflow_Trl.AD_Workflow_Trl_UU */ ,
210683 /* AD_ZoomCondition.AD_ZoomCondition_UU */ ,
200857 /* A_FundingMode.A_FundingMode_UU */ ,
200858 /* A_FundingMode_Acct.A_FundingMode_Acct_UU */ ,
60562 /* A_Registration.A_Registration_UU */ ,
60563 /* A_RegistrationAttribute.A_RegistrationAttribute_UU */ ,
60564 /* A_RegistrationProduct.A_RegistrationProduct_UU */ ,
60565 /* A_RegistrationValue.A_RegistrationValue_UU */ ,
60566 /* ASP_ClientException.ASP_ClientException_UU */ ,
60567 /* ASP_ClientLevel.ASP_ClientLevel_UU */ ,
60568 /* ASP_Field.ASP_Field_UU */ ,
60569 /* ASP_Form.ASP_Form_UU */ ,
60570 /* ASP_Level.ASP_Level_UU */ ,
60571 /* ASP_Module.ASP_Module_UU */ ,
60572 /* ASP_Process.ASP_Process_UU */ ,
60573 /* ASP_Process_Para.ASP_Process_Para_UU */ ,
200300 /* ASP_Ref_List.ASP_Ref_List_UU */ ,
60574 /* ASP_Tab.ASP_Tab_UU */ ,
60575 /* ASP_Task.ASP_Task_UU */ ,
60576 /* ASP_Window.ASP_Window_UU */ ,
60577 /* ASP_Workflow.ASP_Workflow_UU */ ,
60578 /* B_Bid.B_Bid_UU */ ,
60579 /* B_BidComment.B_BidComment_UU */ ,
60580 /* B_Buyer.B_Buyer_UU */ ,
60581 /* B_BuyerFunds.B_BuyerFunds_UU */ ,
60582 /* B_Offer.B_Offer_UU */ ,
60583 /* B_Seller.B_Seller_UU */ ,
60584 /* B_SellerFunds.B_SellerFunds_UU */ ,
60585 /* B_Topic.B_Topic_UU */ ,
60586 /* B_TopicCategory.B_TopicCategory_UU */ ,
60587 /* B_TopicType.B_TopicType_UU */ ,
208689 /* C_1099Box.C_1099Box_UU */ ,
60588 /* C_AcctProcessor.C_AcctProcessor_UU */ ,
60589 /* C_AcctProcessorLog.C_AcctProcessorLog_UU */ ,
60590 /* C_AcctSchema.C_AcctSchema_UU */ ,
60591 /* C_AcctSchema_Default.C_AcctSchema_Default_UU */ ,
60592 /* C_AcctSchema_Element.C_AcctSchema_Element_UU */ ,
60593 /* C_AcctSchema_GL.C_AcctSchema_GL_UU */ ,
60594 /* C_Activity.C_Activity_UU */ ,
211064 /* C_Activity_Trl.C_Activity_Trl_UU */ ,
210776 /* C_AddressTransaction.C_AddressTransaction_UU */ ,
210761 /* C_AddressValidation.C_AddressValidation_UU */ ,
210742 /* C_AddressValidationCfg.C_AddressValidationCfg_UU */ ,
60595 /* C_AllocationHdr.C_AllocationHdr_UU */ ,
60596 /* C_AllocationLine.C_AllocationLine_UU */ ,
60597 /* C_Bank.C_Bank_UU */ ,
60598 /* C_BankAccount.C_BankAccount_UU */ ,
60599 /* C_BankAccount_Acct.C_BankAccount_Acct_UU */ ,
60600 /* C_BankAccountDoc.C_BankAccountDoc_UU */ ,
200695 /* C_BankAccount_Processor.C_BankAccount_Processor_UU */ ,
60601 /* C_BankStatement.C_BankStatement_UU */ ,
60602 /* C_BankStatementLine.C_BankStatementLine_UU */ ,
60603 /* C_BankStatementLoader.C_BankStatementLoader_UU */ ,
60604 /* C_BankStatementMatcher.C_BankStatementMatcher_UU */ ,
213646 /* C_BankTransfer.C_BankTransfer_UU */ ,
60605 /* C_BPartner.C_BPartner_UU */ ,
60606 /* C_BPartner_Location.C_BPartner_Location_UU */ ,
60607 /* C_BPartner_Product.C_BPartner_Product_UU */ ,
60608 /* C_BP_BankAccount.C_BP_BankAccount_UU */ ,
60609 /* C_BP_Customer_Acct.C_BP_Customer_Acct_UU */ ,
60610 /* C_BP_EDI.C_BP_EDI_UU */ ,
60611 /* C_BP_Employee_Acct.C_BP_Employee_Acct_UU */ ,
60612 /* C_BP_Group.C_BP_Group_UU */ ,
60613 /* C_BP_Group_Acct.C_BP_Group_Acct_UU */ ,
60614 /* C_BP_Relation.C_BP_Relation_UU */ ,
201156 /* C_BP_ShippingAcct.C_BP_ShippingAcct_UU */ ,
60615 /* C_BP_Vendor_Acct.C_BP_Vendor_Acct_UU */ ,
60616 /* C_BP_Withholding.C_BP_Withholding_UU */ ,
60617 /* C_Calendar.C_Calendar_UU */ ,
60618 /* C_Campaign.C_Campaign_UU */ ,
211077 /* C_Campaign_Trl.C_Campaign_Trl_UU */ ,
60619 /* C_Cash.C_Cash_UU */ ,
60620 /* C_CashBook.C_CashBook_UU */ ,
60621 /* C_CashBook_Acct.C_CashBook_Acct_UU */ ,
60622 /* C_CashLine.C_CashLine_UU */ ,
60623 /* C_CashPlan.C_CashPlan_UU */ ,
60624 /* C_CashPlanLine.C_CashPlanLine_UU */ ,
60625 /* C_Channel.C_Channel_UU */ ,
60626 /* C_Charge.C_Charge_UU */ ,
60627 /* C_Charge_Acct.C_Charge_Acct_UU */ ,
60628 /* C_Charge_Trl.C_Charge_Trl_UU */ ,
60629 /* C_ChargeType.C_ChargeType_UU */ ,
60630 /* C_ChargeType_DocType.C_ChargeType_DocType_UU */ ,
60631 /* C_City.C_City_UU */ ,
60632 /* C_Commission.C_Commission_UU */ ,
60633 /* C_CommissionAmt.C_CommissionAmt_UU */ ,
60634 /* C_CommissionDetail.C_CommissionDetail_UU */ ,
60635 /* C_CommissionLine.C_CommissionLine_UU */ ,
60636 /* C_CommissionRun.C_CommissionRun_UU */ ,
210846 /* C_ContactActivity.C_ContactActivity_UU */ ,
60637 /* C_Conversion_Rate.C_Conversion_Rate_UU */ ,
60638 /* C_ConversionType.C_ConversionType_UU */ ,
60639 /* C_Country.C_Country_UU */ ,
211628 /* C_CountryGroup.C_CountryGroup_UU */ ,
211608 /* C_CountryGroupCountry.C_CountryGroupCountry_UU */ ,
211637 /* C_CountryGroup_Trl.C_CountryGroup_Trl_UU */ ,
60640 /* C_Country_Trl.C_Country_Trl_UU */ ,
60641 /* C_Currency.C_Currency_UU */ ,
60642 /* C_Currency_Acct.C_Currency_Acct_UU */ ,
60643 /* C_Currency_Trl.C_Currency_Trl_UU */ ,
60644 /* C_Cycle.C_Cycle_UU */ ,
60645 /* C_CyclePhase.C_CyclePhase_UU */ ,
60646 /* C_CycleStep.C_CycleStep_UU */ ,
208411 /* C_DepositBatch.C_DepositBatch_UU */ ,
208435 /* C_DepositBatchLine.C_DepositBatchLine_UU */ ,
60647 /* C_DocType.C_DocType_UU */ ,
60648 /* C_DocTypeCounter.C_DocTypeCounter_UU */ ,
60649 /* C_DocType_Trl.C_DocType_Trl_UU */ ,
60650 /* C_Dunning.C_Dunning_UU */ ,
60651 /* C_DunningLevel.C_DunningLevel_UU */ ,
60652 /* C_DunningLevel_Trl.C_DunningLevel_Trl_UU */ ,
60653 /* C_DunningRun.C_DunningRun_UU */ ,
60654 /* C_DunningRunEntry.C_DunningRunEntry_UU */ ,
60655 /* C_DunningRunLine.C_DunningRunLine_UU */ ,
60656 /* C_Element.C_Element_UU */ ,
60657 /* C_ElementValue.C_ElementValue_UU */ ,
60658 /* C_ElementValue_Trl.C_ElementValue_Trl_UU */ ,
60659 /* C_Greeting.C_Greeting_UU */ ,
60660 /* C_Greeting_Trl.C_Greeting_Trl_UU */ ,
60661 /* C_InterOrg_Acct.C_InterOrg_Acct_UU */ ,
60662 /* C_Invoice.C_Invoice_UU */ ,
60663 /* C_InvoiceBatch.C_InvoiceBatch_UU */ ,
60664 /* C_InvoiceBatchLine.C_InvoiceBatchLine_UU */ ,
60665 /* C_InvoiceLine.C_InvoiceLine_UU */ ,
60666 /* C_InvoicePaySchedule.C_InvoicePaySchedule_UU */ ,
60667 /* C_InvoiceSchedule.C_InvoiceSchedule_UU */ ,
60668 /* C_InvoiceTax.C_InvoiceTax_UU */ ,
60669 /* C_Job.C_Job_UU */ ,
60670 /* C_JobAssignment.C_JobAssignment_UU */ ,
60671 /* C_JobCategory.C_JobCategory_UU */ ,
60672 /* C_JobRemuneration.C_JobRemuneration_UU */ ,
60673 /* C_LandedCost.C_LandedCost_UU */ ,
60674 /* C_LandedCostAllocation.C_LandedCostAllocation_UU */ ,
60675 /* C_Location.C_Location_UU */ ,
60676 /* CM_AccessContainer.CM_AccessContainer_UU */ ,
60677 /* CM_AccessListBPGroup.CM_AccessListBPGroup_UU */ ,
60678 /* CM_AccessListRole.CM_AccessListRole_UU */ ,
60679 /* CM_AccessMedia.CM_AccessMedia_UU */ ,
60680 /* CM_AccessNewsChannel.CM_AccessNewsChannel_UU */ ,
60681 /* CM_AccessProfile.CM_AccessProfile_UU */ ,
60682 /* CM_AccessStage.CM_AccessStage_UU */ ,
60683 /* CM_Ad.CM_Ad_UU */ ,
60684 /* CM_Ad_Cat.CM_Ad_Cat_UU */ ,
60685 /* CM_BroadcastServer.CM_BroadcastServer_UU */ ,
60686 /* CM_Chat.CM_Chat_UU */ ,
60687 /* CM_ChatEntry.CM_ChatEntry_UU */ ,
60688 /* CM_ChatType.CM_ChatType_UU */ ,
60689 /* CM_ChatTypeUpdate.CM_ChatTypeUpdate_UU */ ,
60690 /* CM_ChatUpdate.CM_ChatUpdate_UU */ ,
60691 /* CM_Container.CM_Container_UU */ ,
60692 /* CM_Container_Element.CM_Container_Element_UU */ ,
60693 /* CM_Container_Element_Trl.CM_Container_Element_Trl_UU */ ,
60694 /* CM_Container_Trl.CM_Container_Trl_UU */ ,
60695 /* CM_ContainerTTable.CM_ContainerTTable_UU */ ,
60696 /* CM_Container_URL.CM_Container_URL_UU */ ,
60697 /* CM_CStage.CM_CStage_UU */ ,
60698 /* CM_CStage_Element.CM_CStage_Element_UU */ ,
60699 /* CM_CStage_Element_Trl.CM_CStage_Element_Trl_UU */ ,
60700 /* CM_CStage_Trl.CM_CStage_Trl_UU */ ,
60701 /* CM_CStageTTable.CM_CStageTTable_UU */ ,
60702 /* CM_Media.CM_Media_UU */ ,
60703 /* CM_MediaDeploy.CM_MediaDeploy_UU */ ,
60704 /* CM_Media_Server.CM_Media_Server_UU */ ,
60705 /* CM_NewsChannel.CM_NewsChannel_UU */ ,
60706 /* CM_NewsItem.CM_NewsItem_UU */ ,
60707 /* CM_Template.CM_Template_UU */ ,
60708 /* CM_Template_Ad_Cat.CM_Template_Ad_Cat_UU */ ,
60709 /* CM_TemplateTable.CM_TemplateTable_UU */ ,
60710 /* CM_WebAccessLog.CM_WebAccessLog_UU */ ,
60711 /* CM_WebProject.CM_WebProject_UU */ ,
60712 /* CM_WebProject_Domain.CM_WebProject_Domain_UU */ ,
60713 /* CM_WikiToken.CM_WikiToken_UU */ ,
60714 /* C_NonBusinessDay.C_NonBusinessDay_UU */ ,
200833 /* C_OnlineTrxHistory.C_OnlineTrxHistory_UU */ ,
210845 /* C_Opportunity.C_Opportunity_UU */ ,
60715 /* C_Order.C_Order_UU */ ,
210790 /* C_OrderLandedCost.C_OrderLandedCost_UU */ ,
210807 /* C_OrderLandedCostAllocation.C_OrderLandedCostAllocation_UU */ ,
60716 /* C_OrderLine.C_OrderLine_UU */ ,
60717 /* C_OrderPaySchedule.C_OrderPaySchedule_UU */ ,
60718 /* C_OrderSource.C_OrderSource_UU */ ,
60719 /* C_OrderTax.C_OrderTax_UU */ ,
60720 /* C_OrgAssignment.C_OrgAssignment_UU */ ,
60721 /* C_Payment.C_Payment_UU */ ,
60722 /* C_PaymentAllocate.C_PaymentAllocate_UU */ ,
60723 /* C_PaymentBatch.C_PaymentBatch_UU */ ,
60724 /* C_PaymentProcessor.C_PaymentProcessor_UU */ ,
60725 /* C_PaymentTerm.C_PaymentTerm_UU */ ,
60726 /* C_PaymentTerm_Trl.C_PaymentTerm_Trl_UU */ ,
200736 /* C_PaymentTransaction.C_PaymentTransaction_UU */ ,
60727 /* C_PaySchedule.C_PaySchedule_UU */ ,
60728 /* C_PaySelection.C_PaySelection_UU */ ,
60729 /* C_PaySelectionCheck.C_PaySelectionCheck_UU */ ,
60730 /* C_PaySelectionLine.C_PaySelectionLine_UU */ ,
60731 /* C_Period.C_Period_UU */ ,
60732 /* C_PeriodControl.C_PeriodControl_UU */ ,
60733 /* C_Phase.C_Phase_UU */ ,
60734 /* C_POS.C_POS_UU */ ,
60735 /* C_POSKey.C_POSKey_UU */ ,
60736 /* C_POSKeyLayout.C_POSKeyLayout_UU */ ,
200435 /* C_POSPayment.C_POSPayment_UU */ ,
200419 /* C_POSTenderType.C_POSTenderType_UU */ ,
60737 /* C_Project.C_Project_UU */ ,
60738 /* C_Project_Acct.C_Project_Acct_UU */ ,
60739 /* C_ProjectIssue.C_ProjectIssue_UU */ ,
60740 /* C_ProjectIssueMA.C_ProjectIssueMA_UU */ ,
60741 /* C_ProjectLine.C_ProjectLine_UU */ ,
60742 /* C_ProjectPhase.C_ProjectPhase_UU */ ,
60743 /* C_ProjectTask.C_ProjectTask_UU */ ,
60744 /* C_ProjectType.C_ProjectType_UU */ ,
60745 /* C_Recurring.C_Recurring_UU */ ,
211580 /* C_RecurringGroup.C_RecurringGroup_UU */ ,
60746 /* C_Recurring_Run.C_Recurring_Run_UU */ ,
60747 /* C_Region.C_Region_UU */ ,
211089 /* C_Region_Trl.C_Region_Trl_UU */ ,
60748 /* C_Remuneration.C_Remuneration_UU */ ,
60749 /* C_RevenueRecognition.C_RevenueRecognition_UU */ ,
60750 /* C_RevenueRecognition_Plan.C_RevenueRecognition_Plan_UU */ ,
60751 /* C_RevenueRecognition_Run.C_RevenueRecognition_Run_UU */ ,
213821 /* C_RevenueRecog_Service.C_RevenueRecog_Service_UU */ ,
60752 /* C_RfQ.C_RfQ_UU */ ,
60753 /* C_RfQLine.C_RfQLine_UU */ ,
60754 /* C_RfQLineQty.C_RfQLineQty_UU */ ,
60755 /* C_RfQResponse.C_RfQResponse_UU */ ,
60756 /* C_RfQResponseLine.C_RfQResponseLine_UU */ ,
60757 /* C_RfQResponseLineQty.C_RfQResponseLineQty_UU */ ,
60758 /* C_RfQ_Topic.C_RfQ_Topic_UU */ ,
60759 /* C_RfQ_TopicSubscriber.C_RfQ_TopicSubscriber_UU */ ,
60760 /* C_RfQ_TopicSubscriberOnly.C_RfQ_TopicSubscriberOnly_UU */ ,
60761 /* C_SalesRegion.C_SalesRegion_UU */ ,
211102 /* C_SalesRegion_Trl.C_SalesRegion_Trl_UU */ ,
210848 /* C_SalesStage.C_SalesStage_UU */ ,
211167 /* C_SalesStage_Trl.C_SalesStage_Trl_UU */ ,
60762 /* C_ServiceLevel.C_ServiceLevel_UU */ ,
60763 /* C_ServiceLevelLine.C_ServiceLevelLine_UU */ ,
60764 /* C_SubAcct.C_SubAcct_UU */ ,
60765 /* C_Subscription.C_Subscription_UU */ ,
60766 /* C_Subscription_Delivery.C_Subscription_Delivery_UU */ ,
60767 /* C_SubscriptionType.C_SubscriptionType_UU */ ,
60768 /* C_Task.C_Task_UU */ ,
60769 /* C_Tax.C_Tax_UU */ ,
60770 /* C_Tax_Acct.C_Tax_Acct_UU */ ,
60771 /* C_TaxBase.C_TaxBase_UU */ ,
60772 /* C_TaxCategory.C_TaxCategory_UU */ ,
60773 /* C_TaxCategory_Trl.C_TaxCategory_Trl_UU */ ,
60774 /* C_TaxDeclaration.C_TaxDeclaration_UU */ ,
60775 /* C_TaxDeclarationAcct.C_TaxDeclarationAcct_UU */ ,
60776 /* C_TaxDeclarationLine.C_TaxDeclarationLine_UU */ ,
60777 /* C_TaxDefinition.C_TaxDefinition_UU */ ,
60778 /* C_TaxGroup.C_TaxGroup_UU */ ,
60779 /* C_TaxPostal.C_TaxPostal_UU */ ,
210708 /* C_TaxProvider.C_TaxProvider_UU */ ,
210693 /* C_TaxProviderCfg.C_TaxProviderCfg_UU */ ,
60780 /* C_Tax_Trl.C_Tax_Trl_UU */ ,
60781 /* C_TaxType.C_TaxType_UU */ ,
60782 /* C_UOM.C_UOM_UU */ ,
60783 /* C_UOM_Conversion.C_UOM_Conversion_UU */ ,
60784 /* C_UOM_Trl.C_UOM_Trl_UU */ ,
60785 /* C_UserRemuneration.C_UserRemuneration_UU */ ,
60786 /* C_ValidCombination.C_ValidCombination_UU */ ,
60787 /* C_Withholding.C_Withholding_UU */ ,
60788 /* C_Withholding_Acct.C_Withholding_Acct_UU */ ,
60789 /* C_Year.C_Year_UU */ ,
60790 /* DD_NetworkDistribution.DD_NetworkDistribution_UU */ ,
60791 /* DD_NetworkDistributionLine.DD_NetworkDistributionLine_UU */ ,
60792 /* DD_Order.DD_Order_UU */ ,
60793 /* DD_OrderLine.DD_OrderLine_UU */ ,
60794 /* EXP_Format.EXP_Format_UU */ ,
60795 /* EXP_FormatLine.EXP_FormatLine_UU */ ,
60796 /* EXP_Processor.EXP_Processor_UU */ ,
60797 /* EXP_ProcessorParameter.EXP_ProcessorParameter_UU */ ,
60798 /* EXP_Processor_Type.EXP_Processor_Type_UU */ ,
60799 /* Fact_Acct.Fact_Acct_UU */ ,
60800 /* Fact_Acct_Summary.Fact_Acct_Summary_UU */ ,
200206 /* Fact_Reconciliation.Fact_Reconciliation_UU */ ,
60801 /* GL_Budget.GL_Budget_UU */ ,
60802 /* GL_BudgetControl.GL_BudgetControl_UU */ ,
60803 /* GL_Category.GL_Category_UU */ ,
210998 /* GL_Category_Trl.GL_Category_Trl_UU */ ,
60804 /* GL_Distribution.GL_Distribution_UU */ ,
60805 /* GL_DistributionLine.GL_DistributionLine_UU */ ,
60806 /* GL_Fund.GL_Fund_UU */ ,
60807 /* GL_FundRestriction.GL_FundRestriction_UU */ ,
60808 /* GL_Journal.GL_Journal_UU */ ,
60809 /* GL_JournalBatch.GL_JournalBatch_UU */ ,
200554 /* GL_JournalGenerator.GL_JournalGenerator_UU */ ,
200555 /* GL_JournalGeneratorLine.GL_JournalGeneratorLine_UU */ ,
200556 /* GL_JournalGeneratorSource.GL_JournalGeneratorSource_UU */ ,
60810 /* GL_JournalLine.GL_JournalLine_UU */ ,
60811 /* HR_Attribute.HR_Attribute_UU */ ,
60812 /* HR_Concept.HR_Concept_UU */ ,
60813 /* HR_Concept_Acct.HR_Concept_Acct_UU */ ,
60814 /* HR_Concept_Category.HR_Concept_Category_UU */ ,
60815 /* HR_Contract.HR_Contract_UU */ ,
60816 /* HR_Department.HR_Department_UU */ ,
60817 /* HR_Employee.HR_Employee_UU */ ,
60818 /* HR_Job.HR_Job_UU */ ,
60819 /* HR_List.HR_List_UU */ ,
60820 /* HR_ListLine.HR_ListLine_UU */ ,
60821 /* HR_ListType.HR_ListType_UU */ ,
60822 /* HR_ListVersion.HR_ListVersion_UU */ ,
60823 /* HR_Movement.HR_Movement_UU */ ,
60824 /* HR_Payroll.HR_Payroll_UU */ ,
60825 /* HR_PayrollConcept.HR_PayrollConcept_UU */ ,
60826 /* HR_Period.HR_Period_UU */ ,
60827 /* HR_Process.HR_Process_UU */ ,
60828 /* HR_Year.HR_Year_UU */ ,
60829 /* I_Asset.I_Asset_UU */ ,
60830 /* I_BankStatement.I_BankStatement_UU */ ,
60831 /* I_BPartner.I_BPartner_UU */ ,
60832 /* I_Conversion_Rate.I_Conversion_Rate_UU */ ,
60833 /* I_ElementValue.I_ElementValue_UU */ ,
60834 /* I_FAJournal.I_FAJournal_UU */ ,
200860 /* I_FixedAsset.I_FixedAsset_UU */ ,
60835 /* I_GLJournal.I_GLJournal_UU */ ,
60836 /* I_HR_Movement.I_HR_Movement_UU */ ,
60837 /* I_InOutLineConfirm.I_InOutLineConfirm_UU */ ,
60838 /* I_Inventory.I_Inventory_UU */ ,
60839 /* I_Invoice.I_Invoice_UU */ ,
60840 /* I_Movement.I_Movement_UU */ ,
60841 /* IMP_Processor.IMP_Processor_UU */ ,
60842 /* IMP_ProcessorLog.IMP_ProcessorLog_UU */ ,
60843 /* IMP_ProcessorParameter.IMP_ProcessorParameter_UU */ ,
60844 /* IMP_Processor_Type.IMP_Processor_Type_UU */ ,
60845 /* I_Order.I_Order_UU */ ,
60846 /* I_Payment.I_Payment_UU */ ,
60847 /* I_PriceList.I_PriceList_UU */ ,
60848 /* I_Product.I_Product_UU */ ,
60849 /* I_ProductPlanning.I_ProductPlanning_UU */ ,
60850 /* I_ReportLine.I_ReportLine_UU */ ,
60851 /* K_Category.K_Category_UU */ ,
60852 /* K_CategoryValue.K_CategoryValue_UU */ ,
60853 /* K_Comment.K_Comment_UU */ ,
60854 /* K_Entry.K_Entry_UU */ ,
60855 /* K_EntryCategory.K_EntryCategory_UU */ ,
60856 /* K_EntryRelated.K_EntryRelated_UU */ ,
60857 /* K_Index.K_Index_UU */ ,
60858 /* K_IndexLog.K_IndexLog_UU */ ,
60859 /* K_IndexStop.K_IndexStop_UU */ ,
60860 /* K_Source.K_Source_UU */ ,
60861 /* K_Synonym.K_Synonym_UU */ ,
60862 /* K_Topic.K_Topic_UU */ ,
60863 /* K_Type.K_Type_UU */ ,
60864 /* M_Attribute.M_Attribute_UU */ ,
60865 /* M_AttributeInstance.M_AttributeInstance_UU */ ,
60866 /* M_AttributeSearch.M_AttributeSearch_UU */ ,
60867 /* M_AttributeSet.M_AttributeSet_UU */ ,
60868 /* M_AttributeSetExclude.M_AttributeSetExclude_UU */ ,
60869 /* M_AttributeSetInstance.M_AttributeSetInstance_UU */ ,
60870 /* M_AttributeUse.M_AttributeUse_UU */ ,
60871 /* M_AttributeValue.M_AttributeValue_UU */ ,
60872 /* M_BOM.M_BOM_UU */ ,
60873 /* M_BOMAlternative.M_BOMAlternative_UU */ ,
60874 /* M_BOMProduct.M_BOMProduct_UU */ ,
210847 /* M_BP_Price.M_BP_Price_UU */ ,
60875 /* M_ChangeNotice.M_ChangeNotice_UU */ ,
60876 /* M_ChangeRequest.M_ChangeRequest_UU */ ,
201229 /* M_CommodityShipment.M_CommodityShipment_UU */ ,
60877 /* M_Cost.M_Cost_UU */ ,
60878 /* M_CostDetail.M_CostDetail_UU */ ,
60879 /* M_CostElement.M_CostElement_UU */ ,
200029 /* M_CostHistory.M_CostHistory_UU */ ,
60880 /* M_CostQueue.M_CostQueue_UU */ ,
60881 /* M_CostType.M_CostType_UU */ ,
60882 /* M_Demand.M_Demand_UU */ ,
60883 /* M_DemandDetail.M_DemandDetail_UU */ ,
60884 /* M_DemandLine.M_DemandLine_UU */ ,
60885 /* M_DiscountSchema.M_DiscountSchema_UU */ ,
60886 /* M_DiscountSchemaBreak.M_DiscountSchemaBreak_UU */ ,
60887 /* M_DiscountSchemaLine.M_DiscountSchemaLine_UU */ ,
60888 /* M_DistributionList.M_DistributionList_UU */ ,
60889 /* M_DistributionListLine.M_DistributionListLine_UU */ ,
60890 /* M_DistributionRun.M_DistributionRun_UU */ ,
60891 /* M_DistributionRunLine.M_DistributionRunLine_UU */ ,
214437 /* MFA_Method.MFA_Method_UU */ ,
214456 /* MFA_RegisteredDevice.MFA_RegisteredDevice_UU */ ,
214471 /* MFA_Registration.MFA_Registration_UU */ ,
214490 /* MFA_Rule.MFA_Rule_UU */ ,
60892 /* M_Forecast.M_Forecast_UU */ ,
60893 /* M_ForecastLine.M_ForecastLine_UU */ ,
60894 /* M_Freight.M_Freight_UU */ ,
60895 /* M_FreightCategory.M_FreightCategory_UU */ ,
60896 /* M_InOut.M_InOut_UU */ ,
60897 /* M_InOutConfirm.M_InOutConfirm_UU */ ,
60898 /* M_InOutLine.M_InOutLine_UU */ ,
60899 /* M_InOutLineConfirm.M_InOutLineConfirm_UU */ ,
60900 /* M_InOutLineMA.M_InOutLineMA_UU */ ,
60901 /* M_Inventory.M_Inventory_UU */ ,
60902 /* M_InventoryLine.M_InventoryLine_UU */ ,
60903 /* M_InventoryLineMA.M_InventoryLineMA_UU */ ,
60904 /* M_Locator.M_Locator_UU */ ,
212189 /* M_LocatorType.M_LocatorType_UU */ ,
60905 /* M_Lot.M_Lot_UU */ ,
60906 /* M_LotCtl.M_LotCtl_UU */ ,
60907 /* M_LotCtlExclude.M_LotCtlExclude_UU */ ,
60908 /* M_MatchInv.M_MatchInv_UU */ ,
60909 /* M_MatchPO.M_MatchPO_UU */ ,
60910 /* M_Movement.M_Movement_UU */ ,
60911 /* M_MovementConfirm.M_MovementConfirm_UU */ ,
60912 /* M_MovementLine.M_MovementLine_UU */ ,
60913 /* M_MovementLineConfirm.M_MovementLineConfirm_UU */ ,
60914 /* M_MovementLineMA.M_MovementLineMA_UU */ ,
60915 /* M_OperationResource.M_OperationResource_UU */ ,
60916 /* M_Package.M_Package_UU */ ,
60917 /* M_PackageLine.M_PackageLine_UU */ ,
201193 /* M_PackageMPS.M_PackageMPS_UU */ ,
200851 /* M_PartType.M_PartType_UU */ ,
60918 /* M_PerpetualInv.M_PerpetualInv_UU */ ,
60919 /* M_PriceList.M_PriceList_UU */ ,
211115 /* M_PriceList_Trl.M_PriceList_Trl_UU */ ,
60920 /* M_PriceList_Version.M_PriceList_Version_UU */ ,
211127 /* M_PriceList_Version_Trl.M_PriceList_Version_Trl_UU */ ,
60921 /* M_Product.M_Product_UU */ ,
60922 /* M_Product_Acct.M_Product_Acct_UU */ ,
60924 /* M_Product_Category.M_Product_Category_UU */ ,
60925 /* M_Product_Category_Acct.M_Product_Category_Acct_UU */ ,
211012 /* M_Product_Category_Trl.M_Product_Category_Trl_UU */ ,
60927 /* M_ProductDownload.M_ProductDownload_UU */ ,
60928 /* M_Production.M_Production_UU */ ,
60929 /* M_ProductionLine.M_ProductionLine_UU */ ,
60930 /* M_ProductionLineMA.M_ProductionLineMA_UU */ ,
60931 /* M_ProductionPlan.M_ProductionPlan_UU */ ,
60932 /* M_ProductOperation.M_ProductOperation_UU */ ,
60933 /* M_Product_PO.M_Product_PO_UU */ ,
60934 /* M_ProductPrice.M_ProductPrice_UU */ ,
60935 /* M_ProductPriceVendorBreak.M_ProductPriceVendorBreak_UU */ ,
200850 /* M_Product_QualityTest.M_Product_QualityTest_UU */ ,
60936 /* M_Product_Trl.M_Product_Trl_UU */ ,
60937 /* M_Promotion.M_Promotion_UU */ ,
60938 /* M_PromotionDistribution.M_PromotionDistribution_UU */ ,
60939 /* M_PromotionGroup.M_PromotionGroup_UU */ ,
60940 /* M_PromotionGroupLine.M_PromotionGroupLine_UU */ ,
60941 /* M_PromotionLine.M_PromotionLine_UU */ ,
60942 /* M_PromotionPreCondition.M_PromotionPreCondition_UU */ ,
60943 /* M_PromotionReward.M_PromotionReward_UU */ ,
200849 /* M_QualityTest.M_QualityTest_UU */ ,
200848 /* M_QualityTestResult.M_QualityTestResult_UU */ ,
60944 /* M_RelatedProduct.M_RelatedProduct_UU */ ,
60945 /* M_Replenish.M_Replenish_UU */ ,
60946 /* M_Requisition.M_Requisition_UU */ ,
60947 /* M_RequisitionLine.M_RequisitionLine_UU */ ,
60948 /* M_RMA.M_RMA_UU */ ,
60949 /* M_RMALine.M_RMALine_UU */ ,
208386 /* M_RMATax.M_RMATax_UU */ ,
60950 /* M_RMAType.M_RMAType_UU */ ,
60951 /* M_SerNoCtl.M_SerNoCtl_UU */ ,
60952 /* M_SerNoCtlExclude.M_SerNoCtlExclude_UU */ ,
60953 /* M_Shipper.M_Shipper_UU */ ,
202085 /* M_ShipperCfg.M_ShipperCfg_UU */ ,
201095 /* M_ShipperLabels.M_ShipperLabels_UU */ ,
202104 /* M_ShipperLabelsCfg.M_ShipperLabelsCfg_UU */ ,
201119 /* M_ShipperPackaging.M_ShipperPackaging_UU */ ,
202119 /* M_ShipperPackagingCfg.M_ShipperPackagingCfg_UU */ ,
201134 /* M_ShipperPickupTypes.M_ShipperPickupTypes_UU */ ,
202134 /* M_ShipperPickupTypesCfg.M_ShipperPickupTypesCfg_UU */ ,
201019 /* M_ShippingProcessor.M_ShippingProcessor_UU */ ,
202062 /* M_ShippingProcessorCfg.M_ShippingProcessorCfg_UU */ ,
202200 /* M_ShippingTransaction.M_ShippingTransaction_UU */ ,
202305 /* M_ShippingTransactionLine.M_ShippingTransactionLine_UU */ ,
200917 /* M_StorageOnHand.M_StorageOnHand_UU */ ,
200918 /* M_StorageReservation.M_StorageReservation_UU */ ,
214605 /* M_StorageReservationLog.M_StorageReservationLog_UU */ ,
60955 /* M_Substitute.M_Substitute_UU */ ,
60956 /* M_Transaction.M_Transaction_UU */ ,
60957 /* M_TransactionAllocation.M_TransactionAllocation_UU */ ,
60958 /* M_Warehouse.M_Warehouse_UU */ ,
60959 /* M_Warehouse_Acct.M_Warehouse_Acct_UU */ ,
60960 /* PA_Achievement.PA_Achievement_UU */ ,
60961 /* PA_Benchmark.PA_Benchmark_UU */ ,
60962 /* PA_BenchmarkData.PA_BenchmarkData_UU */ ,
60963 /* PA_ColorSchema.PA_ColorSchema_UU */ ,
60964 /* PA_DashboardContent.PA_DashboardContent_UU */ ,
210852 /* PA_DashboardContent_Access.PA_DashboardContent_Access_UU */ ,
60965 /* PA_DashboardContent_Trl.PA_DashboardContent_Trl_UU */ ,
200854 /* PA_DashboardPreference.PA_DashboardPreference_UU */ ,
213007 /* PA_DocumentStatus.PA_DocumentStatus_UU */ ,
214529 /* PA_DocumentStatusAccess.PA_DocumentStatusAccess_UU */ ,
213010 /* PA_DocumentStatus_Trl.PA_DocumentStatus_Trl_UU */ ,
60966 /* PA_Goal.PA_Goal_UU */ ,
60967 /* PA_GoalRestriction.PA_GoalRestriction_UU */ ,
60968 /* PA_Hierarchy.PA_Hierarchy_UU */ ,
60969 /* PA_Measure.PA_Measure_UU */ ,
60970 /* PA_MeasureCalc.PA_MeasureCalc_UU */ ,
60971 /* PA_Ratio.PA_Ratio_UU */ ,
60972 /* PA_RatioElement.PA_RatioElement_UU */ ,
60973 /* PA_Report.PA_Report_UU */ ,
60974 /* PA_ReportColumn.PA_ReportColumn_UU */ ,
60975 /* PA_ReportColumnSet.PA_ReportColumnSet_UU */ ,
214012 /* PA_ReportColumn_Trl.PA_ReportColumn_Trl_UU */ ,
60976 /* PA_ReportCube.PA_ReportCube_UU */ ,
60977 /* PA_ReportLine.PA_ReportLine_UU */ ,
60978 /* PA_ReportLineSet.PA_ReportLineSet_UU */ ,
213999 /* PA_ReportLine_Trl.PA_ReportLine_Trl_UU */ ,
60979 /* PA_ReportSource.PA_ReportSource_UU */ ,
60980 /* PA_SLA_Criteria.PA_SLA_Criteria_UU */ ,
60981 /* PA_SLA_Goal.PA_SLA_Goal_UU */ ,
60982 /* PA_SLA_Measure.PA_SLA_Measure_UU */ ,
60983 /* PP_Cost_Collector.PP_Cost_Collector_UU */ ,
60984 /* PP_Cost_CollectorMA.PP_Cost_CollectorMA_UU */ ,
60985 /* PP_MRP.PP_MRP_UU */ ,
60986 /* PP_Order.PP_Order_UU */ ,
60987 /* PP_Order_BOM.PP_Order_BOM_UU */ ,
60988 /* PP_Order_BOMLine.PP_Order_BOMLine_UU */ ,
60989 /* PP_Order_BOMLine_Trl.PP_Order_BOMLine_Trl_UU */ ,
60990 /* PP_Order_BOM_Trl.PP_Order_BOM_Trl_UU */ ,
60991 /* PP_Order_Cost.PP_Order_Cost_UU */ ,
60992 /* PP_Order_Node.PP_Order_Node_UU */ ,
60993 /* PP_Order_Node_Asset.PP_Order_Node_Asset_UU */ ,
60994 /* PP_Order_NodeNext.PP_Order_NodeNext_UU */ ,
60995 /* PP_Order_Node_Product.PP_Order_Node_Product_UU */ ,
60996 /* PP_Order_Node_Trl.PP_Order_Node_Trl_UU */ ,
60997 /* PP_Order_Workflow.PP_Order_Workflow_UU */ ,
60998 /* PP_Order_Workflow_Trl.PP_Order_Workflow_Trl_UU */ ,
60999 /* PP_Product_BOM.PP_Product_BOM_UU */ ,
61000 /* PP_Product_BOMLine.PP_Product_BOMLine_UU */ ,
61001 /* PP_Product_BOMLine_Trl.PP_Product_BOMLine_Trl_UU */ ,
61002 /* PP_Product_BOM_Trl.PP_Product_BOM_Trl_UU */ ,
61003 /* PP_Product_Planning.PP_Product_Planning_UU */ ,
61004 /* PP_WF_Node_Asset.PP_WF_Node_Asset_UU */ ,
61005 /* PP_WF_Node_Product.PP_WF_Node_Product_UU */ ,
61006 /* QM_Specification.QM_Specification_UU */ ,
61007 /* QM_SpecificationLine.QM_SpecificationLine_UU */ ,
61008 /* R_Category.R_Category_UU */ ,
61009 /* R_CategoryUpdates.R_CategoryUpdates_UU */ ,
61010 /* R_ContactInterest.R_ContactInterest_UU */ ,
61011 /* R_Group.R_Group_UU */ ,
61012 /* R_GroupUpdates.R_GroupUpdates_UU */ ,
61013 /* R_InterestArea.R_InterestArea_UU */ ,
61014 /* R_IssueKnown.R_IssueKnown_UU */ ,
61015 /* R_IssueProject.R_IssueProject_UU */ ,
61016 /* R_IssueRecommendation.R_IssueRecommendation_UU */ ,
61017 /* R_IssueStatus.R_IssueStatus_UU */ ,
61018 /* R_IssueSystem.R_IssueSystem_UU */ ,
61019 /* R_IssueUser.R_IssueUser_UU */ ,
61020 /* R_MailText.R_MailText_UU */ ,
61021 /* R_MailText_Trl.R_MailText_Trl_UU */ ,
61022 /* R_Request.R_Request_UU */ ,
61023 /* R_RequestAction.R_RequestAction_UU */ ,
61024 /* R_RequestProcessor.R_RequestProcessor_UU */ ,
61025 /* R_RequestProcessorLog.R_RequestProcessorLog_UU */ ,
61026 /* R_RequestProcessor_Route.R_RequestProcessor_Route_UU */ ,
61027 /* R_RequestType.R_RequestType_UU */ ,
61028 /* R_RequestTypeUpdates.R_RequestTypeUpdates_UU */ ,
61029 /* R_RequestUpdate.R_RequestUpdate_UU */ ,
61030 /* R_RequestUpdates.R_RequestUpdates_UU */ ,
61031 /* R_Resolution.R_Resolution_UU */ ,
61032 /* R_StandardResponse.R_StandardResponse_UU */ ,
61033 /* R_Status.R_Status_UU */ ,
61034 /* R_StatusCategory.R_StatusCategory_UU */ ,
61035 /* S_ExpenseType.S_ExpenseType_UU */ ,
61036 /* S_Resource.S_Resource_UU */ ,
61037 /* S_ResourceAssignment.S_ResourceAssignment_UU */ ,
61038 /* S_ResourceType.S_ResourceType_UU */ ,
61039 /* S_ResourceUnAvailable.S_ResourceUnAvailable_UU */ ,
61040 /* S_TimeExpense.S_TimeExpense_UU */ ,
61041 /* S_TimeExpenseLine.S_TimeExpenseLine_UU */ ,
61042 /* S_TimeType.S_TimeType_UU */ ,
61043 /* S_Training.S_Training_UU */ ,
61044 /* S_Training_Class.S_Training_Class_UU */ ,
208620 /* T_1099Extract.T_1099Extract_UU */ ,
61045 /* T_Aging.T_Aging_UU */ ,
210244 /* T_BankRegister.T_BankRegister_UU */ ,
200852 /* T_BOM_Indented.T_BOM_Indented_UU */ ,
61046 /* T_BOMLine.T_BOMLine_UU */ ,
61047 /* T_CashFlow.T_CashFlow_UU */ ,
61048 /* T_DistributionRunDetail.T_DistributionRunDetail_UU */ ,
61049 /* Test.Test_UU */ ,
61050 /* T_InventoryValue.T_InventoryValue_UU */ ,
61051 /* T_InvoiceGL.T_InvoiceGL_UU */ ,
61052 /* T_MRP_CRP.T_MRP_CRP_UU */ ,
200207 /* T_Reconciliation.T_Reconciliation_UU */ ,
61053 /* T_Replenish.T_Replenish_UU */ ,
61054 /* T_Report.T_Report_UU */ ,
61055 /* T_ReportStatement.T_ReportStatement_UU */ ,
61056 /* T_Transaction.T_Transaction_UU */ ,
215730 /* T_TrialBalance.T_TrialBalance_UU */ ,
61057 /* U_BlackListCheque.U_BlackListCheque_UU */ ,
61058 /* U_POSTerminal.U_POSTerminal_UU */ ,
61059 /* U_RoleMenu.U_RoleMenu_UU */ ,
61060 /* U_WebMenu.U_WebMenu_UU */ ,
61061 /* U_Web_Properties.U_Web_Properties_UU */ ,
61062 /* W_Advertisement.W_Advertisement_UU */ ,
61063 /* W_Basket.W_Basket_UU */ ,
61064 /* W_BasketLine.W_BasketLine_UU */ ,
61065 /* W_Click.W_Click_UU */ ,
61066 /* W_ClickCount.W_ClickCount_UU */ ,
61067 /* W_Counter.W_Counter_UU */ ,
61068 /* W_CounterCount.W_CounterCount_UU */ ,
61069 /* W_MailMsg.W_MailMsg_UU */ ,
61070 /* W_MailMsg_Trl.W_MailMsg_Trl_UU */ ,
61071 /* W_Store.W_Store_UU */ ,
61072 /* W_Store_Trl.W_Store_Trl_UU */ ,
210245 /* WS_WebService.WS_WebService_UU */ ,
202048 /* WS_WebServiceFieldInput.WS_WebServiceFieldInput_UU */ ,
202049 /* WS_WebServiceFieldOutput.WS_WebServiceFieldOutput_UU */ ,
210246 /* WS_WebServiceMethod.WS_WebServiceMethod_UU */ ,
202047 /* WS_WebService_Para.WS_WebService_Para_UU */ ,
202046 /* WS_WebServiceType.WS_WebServiceType_UU */ ,
202050 /* WS_WebServiceTypeAccess.WS_WebServiceTypeAccess_UU */
)
;

