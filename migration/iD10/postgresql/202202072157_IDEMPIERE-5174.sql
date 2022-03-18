-- IDEMPIERE-5174 Deactivate System user

insert into ad_user (ad_user_id,ad_client_id,ad_org_id,isactive,created,createdby,updated,updatedby,name,description,password,email,supervisor_id,c_bpartner_id,processing,emailuser,emailuserpw,c_bpartner_location_id,c_greeting_id,title,comments,phone,phone2,fax,lastcontact,lastresult,birthday,ad_orgtrx_id,emailverify,emailverifydate,notificationtype,isfullbpaccess,c_job_id,ldapuser,connectionprofile,value,userpin,isinpayroll,ad_user_uu,ismenuautoexpand,salt,islocked,dateaccountlocked,failedlogincount,datepasswordchanged,datelastlogin,isnopasswordreset,isexpired,securityquestion,answer,issaleslead,c_location_id,leadsource,leadstatus,leadsourcedescription,leadstatusdescription,c_campaign_id,salesrep_id,bpname,bp_location_id,isaddmailtextautomatically,r_defaultmailtext_id,ad_image_id,isnoexpire,issupportuser,isbillto,isshipto,isvendorlead)
select
10,ad_client_id,ad_org_id,isactive,created,createdby,updated,updatedby,name,description,password,email,supervisor_id,c_bpartner_id,processing,emailuser,emailuserpw,c_bpartner_location_id,c_greeting_id,title,comments,phone,phone2,fax,lastcontact,lastresult,birthday,ad_orgtrx_id,emailverify,emailverifydate,notificationtype,isfullbpaccess,c_job_id,ldapuser,connectionprofile,value,userpin,isinpayroll,'98acf599-bd19-4439-a8b6-958ac247d680',ismenuautoexpand,salt,islocked,dateaccountlocked,failedlogincount,datepasswordchanged,datelastlogin,isnopasswordreset,isexpired,securityquestion,answer,issaleslead,c_location_id,leadsource,leadstatus,leadsourcedescription,leadstatusdescription,c_campaign_id,salesrep_id,bpname,bp_location_id,isaddmailtextautomatically,r_defaultmailtext_id,ad_image_id,isnoexpire,issupportuser,isbillto,isshipto,isvendorlead
from ad_user
where ad_user_id=0
;

-- Feb 7, 2022, 9:52:47 PM CET
UPDATE AD_User SET name='System (deprecated)',email='system deprecated @ idempiere.com',value='systemdeprecated',IsActive='N',password=NULL,Updated=TO_TIMESTAMP('2022-02-07 21:52:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_User_ID=0
;

UPDATE AD_AlertProcessor SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE AD_AlertRecipient SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_AttachmentNote SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_AuthorizationAccount SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_BroadcastMessage SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_LdapProcessor SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE AD_Note SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_OrgInfo SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE AD_Password_History SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_Preference SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_Private_Access SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_RecentItem SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_Role SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE AD_Scheduler SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE AD_SchedulerRecipient SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_Tab_Customization SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_Tree_Favorite SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_User SET SalesRep_ID=10 WHERE SalesRep_ID=0;

UPDATE AD_User SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE AD_User_Roles SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_User_Substitute SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_User_Substitute SET Substitute_ID=10 WHERE Substitute_ID=0;

UPDATE AD_UserPreference SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_UserQuery SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_Wlistbox_Customization SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE AD_WorkflowProcessor SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE C_AcctProcessor SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE MFA_RegisteredDevice SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE MFA_Registration SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE PA_DashboardContent SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE PA_DashboardContent_Access SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE PA_DashboardPreference SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE PA_DocumentStatus SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE PA_DocumentStatusAccess SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE R_Request SET AD_User_ID=10 WHERE AD_User_ID=0;

UPDATE R_Request SET SalesRep_ID=10 WHERE SalesRep_ID=0;

UPDATE R_RequestProcessor SET Supervisor_ID=10 WHERE Supervisor_ID=0;

UPDATE R_RequestProcessor_Route SET AD_User_ID=10 WHERE AD_User_ID=0;

SELECT register_migration_script('202202072157_IDEMPIERE-5174.sql') FROM dual
;

