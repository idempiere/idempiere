-- new columns found to be problematic
UPDATE AD_Column SET IsAllowCopy='N' WHERE ColumnName IN (
'Reversal_ID'
);
