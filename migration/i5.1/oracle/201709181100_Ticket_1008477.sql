SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 18, 2017 12:37:19 PM GMT+08:00
-- 1008477 List on Position field in Lead window is blank even if there are position options configured.
UPDATE AD_Val_Rule SET Code='((C_Job.IsEmployee=(SELECT IsEmployee FROM C_BPartner WHERE C_BPartner_ID=@C_BPartner_ID:0@)) OR (C_Job.IsEmployee=''N'' AND @C_BPartner_ID:0@=0))',Updated=TO_DATE('2017-09-18 12:37:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=243
;

SELECT register_migration_script('201709181100_Ticket_1008477.sql') FROM dual
;

