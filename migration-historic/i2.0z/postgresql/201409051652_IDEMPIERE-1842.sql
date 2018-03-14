update ad_column set callout = 'org.compiere.model.CalloutOrder.organization' where ad_column_id = 2163;

SELECT register_migration_script('201409051652_IDEMPIERE-1842.sql') FROM dual;
