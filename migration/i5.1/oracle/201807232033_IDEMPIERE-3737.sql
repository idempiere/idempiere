SET SQLBLANKLINES ON
SET DEFINE OFF

-- I do not forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- After a year , i get the answer for a very nice question from https://groups.google.com/d/msg/idempiere/gkrkQ7gEPBI/bw-C6JTdBQAJ 

-- 2018-7-3 下午04时06分21秒
-- Update User reference of AD_Reference for System system . If using Table Direct , System cannt got other clients' user_id lead to null replace in preference window.
UPDATE AD_Column SET AD_Reference_ID=30, AD_Reference_Value_ID=200145, FKConstraintType=NULL,Updated=TO_DATE('2018-07-03 16:06:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1471
;

-- 2018-7-3 下午04时06分38秒
-- Implementing a tab sqlwhere to filter some useless preference value in other clients and display all data for system.
UPDATE AD_Tab SET WhereClause='AD_Preference.CreatedBy IN (SELECT AD_User_ID FROM AD_User WHERE AD_Client_ID = @#AD_Client_ID@) OR @#AD_Client_ID@ = 0',Updated=TO_DATE('2018-07-03 16:06:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=156
;

SELECT register_migration_script('201807232033_IDEMPIERE-3737.sql') FROM dual
;

