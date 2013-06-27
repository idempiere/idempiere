/*********** IDEMPIERE-1063 AcctProcessor Performance indexes **************/

drop index c_invoice_paid;

create index c_invoice_paid on c_invoice (ispaid, ad_client_id);

drop index c_order_processed;

create index c_order_processed on c_order (processed, ad_client_id);

create index idxc_allocationhdr_proc_on on c_allocationhdr (posted, processed, processedon, ad_client_id);

create index idxc_bankstatement_proc_on on c_bankstatement (posted, processed, processedon, ad_client_id);

create index idxc_cash_proc_on on c_cash (posted, processed, processedon, ad_client_id);

create index idxc_invoice_proc_on on c_invoice (posted, processed, processedon, ad_client_id);

create index idxc_order_proc_on on c_order (posted, processed, processedon, ad_client_id);

create index idxc_payment_proc_on on c_payment (posted, processed, processedon, ad_client_id);

create index idxc_projectissue_proc_on on c_projectissue (posted, processed, processedon, ad_client_id);

create index idxdd_order_proc_on on dd_order (posted, processed, processedon, ad_client_id);

create index idxgl_journal_proc_on on gl_journal (posted, processed, processedon, ad_client_id);

create index idxhr_process_proc_on on hr_process (posted, processed, processedon, ad_client_id);

create index idxm_inout_proc_on on m_inout (posted, processed, processedon, ad_client_id);

create index idxm_inventory_proc_on on m_inventory (posted, processed, processedon, ad_client_id);

create index idxm_matchinv_proc_on on m_matchinv (posted, processed, processedon, ad_client_id);

create index idxm_matchpo_proc_on on m_matchpo (posted, processed, processedon, ad_client_id);

create index idxm_movement_proc_on on m_movement (posted, processed, processedon, ad_client_id);

create index idxm_production_proc_on on m_production (posted, processed, processedon, ad_client_id);

create index idxm_requisition_proc_on on m_requisition (posted, processed, processedon, ad_client_id);

create index idxpp_cost_collector_proc_on on pp_cost_collector (posted, processed, processedon, ad_client_id);

create index idxpp_order_proc_on on pp_order (posted, processed, processedon, ad_client_id);

SELECT register_migration_script('201306171929_IDEMPIERE-1063.sql') FROM dual
;

