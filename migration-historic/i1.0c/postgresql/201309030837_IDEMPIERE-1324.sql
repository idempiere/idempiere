-- IDEMPIERE-1324 Menu entries with summary and centrally maintained are not translated
update ad_menu set iscentrallymaintained='N' where issummary='Y'
;

SELECT register_migration_script('201309030837_IDEMPIERE-1324.sql') FROM dual
;

