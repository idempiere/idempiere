CREATE UNIQUE INDEX cm_chat_record ON cm_chat (ad_table_id, record_id);


SELECT register_migration_script('201212131100_IDEMPIERE-530.sql') FROM dual
;

