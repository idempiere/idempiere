-- Jul 30, 2013 3:02:24 PM COT
-- IDEMPIERE-1162
UPDATE R_MailText SET MailText='Dear @Name@,

You are receiving this email because you (or somebody pretending to be you) said you have lost your iDempiere password.

To access your iDempiere, use the temporary password from @AD_Client_ID<Name>@ below:
@#NewPassword@

Once you login, you will be directed to change password screen. Please change your password to something you can remember.

Sincerely,
The iDempiere Accounts Team

Note: This email address cannot accept replies.',Updated=TO_DATE('2013-07-30 15:02:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE R_MailText_ID=200000
;

-- Jul 30, 2013 3:02:24 PM COT
-- IDEMPIERE-1162
UPDATE R_MailText_Trl SET IsTranslated='N' WHERE R_MailText_ID=200000
;

SELECT register_migration_script('201307301502_IDEMPIERE-1162.sql') FROM dual
;

