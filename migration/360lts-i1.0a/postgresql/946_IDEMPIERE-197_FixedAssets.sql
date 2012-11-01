-- Position new fixed assets fields according to new grid positioning

UPDATE AD_Field SET XPosition=3 WHERE ad_field_uu is null and seqnogrid is null AND IsSameLine='Y' AND IsActive='Y';

UPDATE AD_Field SET XPosition=1 WHERE ad_field_uu is null and seqnogrid is null AND IsSameline='N' AND IsActive='Y';

UPDATE AD_Field SET ColumnSpan=1 WHERE ad_field_uu is null and seqnogrid is null AND DisplayLength<30 AND IsActive='Y';

UPDATE AD_Field SET ColumnSpan=3 WHERE ad_field_uu is null and seqnogrid is null AND DisplayLength>=30 AND IsActive='Y';

UPDATE AD_Field SET NumLines=3 WHERE ad_field_uu is null and seqnogrid is null AND AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=14) AND IsActive='Y';

UPDATE AD_Field SET NumLines=5 WHERE ad_field_uu is null and seqnogrid is null AND AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=36) AND IsActive='Y';

UPDATE AD_Field SET NumLines=8 WHERE ad_field_uu is null and seqnogrid is null AND AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=34) AND IsActive='Y';

UPDATE AD_Field SET ColumnSpan=2 WHERE ad_field_uu is null and seqnogrid is null AND AD_Field_ID IN (SELECT AD_Field_ID FROM AD_Field WHERE XPosition=1 AND ColumnSpan=1 AND IsActive='Y');

UPDATE AD_Field SET XPosition=4,ColumnSpan=2 WHERE ad_field_uu is null and seqnogrid is null AND AD_Field_ID IN (SELECT AD_Field_ID FROM AD_Field WHERE XPosition=3 AND ColumnSpan=1 AND IsActive='Y');

UPDATE AD_Field SET XPosition=XPosition+1 WHERE ad_field_uu is null and seqnogrid is null AND AD_Field_ID IN (SELECT fi.AD_Field_ID FROM AD_Field fi INNER JOIN AD_Column c ON (fi.AD_Column_ID=C.AD_Column_ID) WHERE c.AD_Reference_ID in (20,28) AND fi.IsActive='Y');

UPDATE AD_Field SET ColumnSpan=5 WHERE ad_field_uu is null and seqnogrid is null AND AD_Field_ID IN (SELECT AD_Field_ID FROM AD_Field WHERE XPosition=1 AND ColumnSpan=3 AND IsActive='Y');

UPDATE AD_Field SET seqnogrid=seqno WHERE ad_field_uu is null and seqnogrid is null;

SELECT register_migration_script('946_IDEMPIERE-197_FixedAssets.sql') FROM dual
;

