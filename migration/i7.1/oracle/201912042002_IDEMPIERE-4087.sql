SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4087 Copy the link to this issue  virtual search columns
-- Dec 4, 2019, 8:01:25 PM CET
UPDATE AD_Field SET Help='You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days.<br>
It is not recommended to add complex queries in virtual columns as the impact on the database performance can be too expensive.<br>
However, you can use the prefix @SQLFIND= for virtual columns that can be used for queries and reports, they have less impact on the database, but as a field they don''t show values.<br>
Additionally, the prefix @SQL= allows to define a virtual UI column, this is calculated on the fly and can use context variables in the query, virtual UI columns are shown in grid just on the current row, they are not searchable, and not shown in reports.', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-12-04 20:46:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11264
;

SELECT register_migration_script('201912042002_IDEMPIERE-4087.sql') FROM dual
;

