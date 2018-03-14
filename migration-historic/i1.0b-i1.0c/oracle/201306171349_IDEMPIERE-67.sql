-- Backward compatibility with old PO copyValues method
UPDATE AD_Column SET IsAllowCopy='N' WHERE IsAllowCopy='Y' AND ColumnName IN (
'Created',
'CreatedBy',
'Updated',
'UpdatedBy',
'IsActive',
'AD_Client_ID',
'AD_Org_ID',
'Processing'
);

-- new columns found to be problematic
UPDATE AD_Column SET IsAllowCopy='N' WHERE IsAllowCopy='Y' AND ColumnName IN (
'ProcessedOn'
);

-- key columns
UPDATE AD_Column SET IsAllowCopy='N' WHERE IsAllowCopy='Y' AND IsKey='Y';

-- virtual columns
UPDATE AD_Column SET IsAllowCopy='N' WHERE IsAllowCopy='Y' AND ColumnSQL IS NOT NULL;

-- UUID columns
UPDATE AD_Column SET IsAllowCopy='N' WHERE IsAllowCopy='Y' AND columnname = (SELECT tablename||'_UU' FROM ad_table t where t.ad_table_id=ad_column.ad_table_id);

-- allow copy of AD_Org_ID on field but not on column (for backward compatibility)
UPDATE AD_Field SET IsAllowCopy='Y' WHERE COALESCE(IsAllowCopy,'N')='N' AND AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE ColumnName = 'AD_Org_ID');

SELECT register_migration_script('201306171349_IDEMPIERE-67.sql') FROM dual
;

