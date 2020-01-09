SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2836 SQL Searches for advanced users
-- Nov 21, 2019, 10:28:50 PM CET
UPDATE AD_Field SET Help='The Validation Code displays the date, time and message of the error.

You can add advanced SQL queries to your searches by filling this field with @SQL=[WHERE CLAUSE].
Do not include the WHERE statement and use Fully qualified SQL statements. F.e:

'||chr(64)||'SQL=C_Order.isActive=''Y'' AND SalesRep_ID=@AD_User_ID@ 

will filter orders by active and where the sales representative is the current user.', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-21 22:28:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12249
;

-- Nov 21, 2019, 6:54:31 PM CET
UPDATE AD_Field SET Help='The Validation Code displays the date, time and message of the error.

You can add advanced SQL queries to your searches by filling this field with @SQL=[WHERE CLAUSE].
Do not include the WHERE statement and use Fully qualified SQL statements. F.e:

'||chr(64)||'SQL=C_Order.isActive=''Y'' AND SalesRep_ID=@AD_User_ID@ 

will filter orders by active and where the sales representative is the current user.', IsCentrallyMaintained='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-11-21 18:54:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206305
;

SELECT register_migration_script('201911211857_IDEMPIERE-2836.sql') FROM dual
;
