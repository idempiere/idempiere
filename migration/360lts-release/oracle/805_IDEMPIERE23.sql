-- IDEMPIERE-23 Copy record present problem for some columns
UPDATE AD_Field SET IsAllowCopy='N' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE ColumnName IN (
'IsCreated',
'I_IsImported',
'SeqNo'
));

