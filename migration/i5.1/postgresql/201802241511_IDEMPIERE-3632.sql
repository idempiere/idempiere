-- IDEMPIERE-3632 Deprecated Message from Swing Time
-- Feb 24, 2018 2:59:57 PM CET
UPDATE AD_Tab SET CommitWarning='If you change the currency or costing method, you must reset all accounting transactions.
For changes to become effective, you must execute Cache Reset. ',Updated=TO_TIMESTAMP('2018-02-24 14:59:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=199
;

-- Feb 24, 2018 3:02:19 PM CET
UPDATE AD_Tab SET CommitWarning='ATTENTION: ANY CHANGES here will affect the structure of your chart of accounts!
Depending what changes you did, you should reset accounting.
For changes to become effective, you must and execute Cache Reset and re-login.
Saving/deleting the record starts processes which may take a while.',Updated=TO_TIMESTAMP('2018-02-24 15:02:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=217
;

-- Feb 24, 2018 3:02:45 PM CET
UPDATE AD_Tab SET CommitWarning='For changes to become effective, you must execute Cache Reset and re-login.',Updated=TO_TIMESTAMP('2018-02-24 15:02:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200
;

-- Feb 24, 2018 3:03:29 PM CET
UPDATE AD_Tab SET CommitWarning='Create a new client via "Initial Client Setup". You can only change information here!  You need execute Cache Reset and re-login for most changes made here to be effective.  The change of the Material Policy applies to future transactions.',Updated=TO_TIMESTAMP('2018-02-24 15:03:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=145
;

-- Feb 24, 2018 3:04:07 PM CET
UPDATE AD_Tab SET CommitWarning='You need to execute Cache Reset and re-login for most changes made here to be effective.',Updated=TO_TIMESTAMP('2018-02-24 15:04:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=169
;

-- Feb 24, 2018 3:07:42 PM CET
UPDATE AD_Tab SET CommitWarning='Please create a support request - https://idempiere.atlassian.net/secure/CreateIssue.jspa - if the region info is not correct/incomplete.',Updated=TO_TIMESTAMP('2018-02-24 15:07:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=136
;

-- Feb 24, 2018 3:08:40 PM CET
UPDATE AD_Tab SET CommitWarning='Please create a support request - https://idempiere.atlassian.net/secure/CreateIssue.jspa - if the country data is not correct.',Updated=TO_TIMESTAMP('2018-02-24 15:08:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=135
;

-- Feb 24, 2018 3:10:25 PM CET
UPDATE AD_Tab SET CommitWarning='All not manually maintained Roles will automatically have access to the new Organization.
You need execute Cache Reset and re-login for most changes made here to be effective.',Updated=TO_TIMESTAMP('2018-02-24 15:10:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=143
;

-- Feb 24, 2018 3:10:45 PM CET
UPDATE AD_Tab SET CommitWarning='You need execute Cache Reset and re-login for most changes made here to be effective.
',Updated=TO_TIMESTAMP('2018-02-24 15:10:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=170
;

SELECT register_migration_script('201802241511_IDEMPIERE-3632.sql') FROM dual
;

