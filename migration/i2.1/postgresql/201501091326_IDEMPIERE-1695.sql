drop view t_invoicegl_vt
;

SELECT register_migration_script('201501091326_IDEMPIERE-1695.sql') FROM dual
;

