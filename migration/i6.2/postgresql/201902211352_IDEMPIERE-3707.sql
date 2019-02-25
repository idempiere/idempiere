UPDATE AD_Column SET SeqNoSelection=SeqNoSelection*10 WHERE SeqNoSelection>0 AND IsSelectionColumn='Y' AND IsActive='Y';
SELECT register_migration_script('201902211352_IDEMPIERE-3707.sql') FROM dual
;

