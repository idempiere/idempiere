-- IDEMPIERE-7226 Notify user on failed MFA
SELECT register_migration_script('202611221554_IDEMPIERE-7226.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 22, 2026, 3:54:21 PM CET
INSERT INTO R_MailText (R_MailText_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsHtml,MailHeader,MailText,R_MailText_UU) VALUES (200003,0,0,'Y',TO_TIMESTAMP('2026-11-22 15:54:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-22 15:54:21','YYYY-MM-DD HH24:MI:SS'),100,'MFA Validation Failed','Y','MFA Validation Failed for iDempiere','<p>Hello @Name@,</p>

<p>A multi-factor authentication validation attempt for your account has failed.</p>

<p><b>Details:</b><br />
Date/Time: @#_MFA_Failed_Date_@<br />
IP Address: @#_MFA_Failed_IPAddress_@<br />
Reason: @#_MFA_Failed_FailureReason_@</p>

<p>If you did not initiate this login attempt, please notify your system administrator immediately.</p>

<p>Sincerely,<br />
The iDempiere Accounts Team</p>

<p>Note: This email address does not accept replies.</p>
','01a203c0-442b-7c14-964d-35a4011b40de')
;

