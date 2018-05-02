SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2852
-- May 2, 2018 3:17:39 PM CEST
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_DATE('2018-05-02 15:17:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50039
;

-- May 2, 2018 3:18:25 PM CEST
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_DATE('2018-05-02 15:18:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200050
;

-- May 2, 2018 3:18:51 PM CEST
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_DATE('2018-05-02 15:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50024
;

update ad_sysconfig set ad_sysconfig_id=200118, ad_sysconfig_uu='4731096e-6ed8-4bc8-85d1-43d9caf8a2f8' where ad_client_id=0 and name='ALLOW_APPLY_PAYMENT_TO_CREDITMEMO';

update ad_sysconfig set ad_sysconfig_id=200119, ad_sysconfig_uu='52933d5d-d70d-432a-9d4b-037a2d940b85' where ad_client_id=0 and name='ALLOW_OVER_APPLIED_PAYMENT';

update ad_sysconfig set ad_sysconfig_id=200120, ad_sysconfig_uu='a69f35d6-3bbf-4eb6-81b6-d38be345f89c' where ad_client_id=0 and name='APPLICATION_URL';

update ad_sysconfig set ad_sysconfig_id=200121, ad_sysconfig_uu='25fad374-325e-4f62-a00b-84f76e81d3a9' where ad_client_id=0 and name='CALENDAR_ALTERNATE_TIMEZONE';

update ad_sysconfig set ad_sysconfig_id=200122, ad_sysconfig_uu='e367e204-35ca-4838-ad2a-cc096023add4' where ad_client_id=0 and name='ENABLE_PAYMENTBOX_BUTTON';

update ad_sysconfig set ad_sysconfig_id=200123, ad_sysconfig_uu='638bd8a9-e72c-45f3-877c-f6f2ffa8453e' where ad_client_id=0 and name='HTML_REPORT_THEME';

update ad_sysconfig set ad_sysconfig_id=200124, ad_sysconfig_uu='678852cf-bf78-4644-8cb5-79498785b961' where ad_client_id=0 and name='MAIL_DONT_SEND_TO_ADDRESS';

update ad_sysconfig set ad_sysconfig_id=200125, ad_sysconfig_uu='ebdef833-b08b-4cd6-a250-e1ed7969b636' where ad_client_id=0 and name='MAIL_SEND_BCC_TO_ADDRESS';

update ad_sysconfig set ad_sysconfig_id=200126, ad_sysconfig_uu='40688467-44aa-4189-b8f6-cf897d61d984' where ad_client_id=0 and name='MAX_ACTIVITIES_IN_LIST';

update ad_sysconfig set ad_sysconfig_id=200127, ad_sysconfig_uu='5432f856-85e2-46b8-9095-8c8a73d874e3' where ad_client_id=0 and name='MFG_ValidateCostsDifferenceOnCreate';

update ad_sysconfig set ad_sysconfig_id=200128, ad_sysconfig_uu='2bb77e84-41da-48ec-985e-f03223204b1d' where ad_client_id=0 and name='MFG_ValidateCostsOnCreate';

update ad_sysconfig set ad_sysconfig_id=200129, ad_sysconfig_uu='79d83d91-f4d8-4118-a22b-7d336deccaea' where ad_client_id=0 and name='STANDARD_REPORT_FOOTER_TRADEMARK_TEXT';

update ad_sysconfig set ad_sysconfig_id=200132, ad_sysconfig_uu='a6cc348b-d7c9-4af6-a5ae-416b23d9c220' where ad_client_id=0 and name='ZK_DECIMALBOX_PROCESS_DOTKEYPAD';

update ad_sysconfig set ad_sysconfig_id=200133, ad_sysconfig_uu='0cefeb0f-2c5c-4d71-87c5-85a23731a6ac' where ad_client_id=0 and name='ZK_FOOTER_SERVER_DATETIME_FORMAT';

update ad_sysconfig set ad_sysconfig_id=200134, ad_sysconfig_uu='a18d519b-eeb6-4ec6-a080-1495ad829dba' where ad_client_id=0 and name='ZK_FOOTER_SERVER_MSG';

update ad_sysconfig set ad_sysconfig_id=200135, ad_sysconfig_uu='88547d79-3b61-4648-9a16-1f4e1a14f426' where ad_client_id=0 and name='ZK_GRID_MOBILE_MAX_COLUMNS';

update ad_sysconfig set ad_sysconfig_id=200136, ad_sysconfig_uu='b535d0cb-8921-4f84-a1b5-01fb9620779e' where ad_client_id=0 and name='ZK_MOBILE_PAGING_SIZE';

update ad_sysconfig set ad_sysconfig_id=200137, ad_sysconfig_uu='0599feeb-845f-4ccb-a740-94ad04c85d64' where ad_client_id=0 and name='ZK_SESSION_TIMEOUT_IN_SECONDS';

-- May 2, 2018 3:19:49 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200118,0,0,TO_DATE('2018-05-02 15:19:49','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:19:49','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ALLOW_APPLY_PAYMENT_TO_CREDITMEMO','N','Allow applying payment to a credit memo','D','C','4731096e-6ed8-4bc8-85d1-43d9caf8a2f8')
;

-- May 2, 2018 3:20:27 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200119,0,0,TO_DATE('2018-05-02 15:20:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:20:27','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ALLOW_OVER_APPLIED_PAYMENT','N','Allow a payment to be over applied to an invoice','D','C','52933d5d-d70d-432a-9d4b-037a2d940b85')
;

-- May 2, 2018 3:22:55 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200120,0,0,TO_DATE('2018-05-02 15:22:54','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:22:54','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','APPLICATION_URL','USE_HARDCODED','Server URL to generate zoom for a record. When empty, or using the value USE_HARDCODED, the system generates an URL with current protocol, server name, port, context','D','C','a69f35d6-3bbf-4eb6-81b6-d38be345f89c')
;

-- May 2, 2018 3:24:05 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200121,0,0,TO_DATE('2018-05-02 15:24:05','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:24:05','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CALENDAR_ALTERNATE_TIMEZONE','Pacific Time=PST','Alternate time zone to show in Calendar window. It can be defined as one zone or several zones separated by comma. A zone is defined by a title =timezone, title is shown in the calendar, and the timezone must conform to timezone standard. If set empty (a ','D','C','25fad374-325e-4f62-a00b-84f76e81d3a9')
;

-- May 2, 2018 3:28:04 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200122,0,0,TO_DATE('2018-05-02 15:28:04','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:28:04','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ENABLE_PAYMENTBOX_BUTTON','Y','Defines if the payment button besides the payment rule is shown or not','D','C','e367e204-35ca-4838-ad2a-cc096023add4')
;

-- May 2, 2018 3:29:55 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200123,0,0,TO_DATE('2018-05-02 15:29:55','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:29:55','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','HTML_REPORT_THEME','/','Name of optional theme for HTML reports on webui','D','C','638bd8a9-e72c-45f3-877c-f6f2ffa8453e')
;

-- May 2, 2018 3:30:36 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200124,0,0,TO_DATE('2018-05-02 15:30:36','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:30:36','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MAIL_DONT_SEND_TO_ADDRESS','N','For test systems you can set up this key to avoid sending unwanted messages. If combined with MAIL_SEND_BCC_TO_ADDRESS, then it will send messages just to the configured address','D','C','678852cf-bf78-4644-8cb5-79498785b961')
;

-- May 2, 2018 3:31:46 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200125,0,0,TO_DATE('2018-05-02 15:31:45','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:31:45','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MAIL_SEND_BCC_TO_ADDRESS',' ','You can register an e-mail address and all the outgoing mails from the system will be sent BCC there','D','C','ebdef833-b08b-4cd6-a250-e1ed7969b636')
;

-- May 2, 2018 3:32:36 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200126,0,0,TO_DATE('2018-05-02 15:32:35','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:32:35','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MAX_ACTIVITIES_IN_LIST','200','Max number of activities in list','D','C','40688467-44aa-4189-b8f6-cf897d61d984')
;

-- May 2, 2018 3:34:16 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200127,0,0,TO_DATE('2018-05-02 15:34:16','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:34:16','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MFG_ValidateCostsDifferenceOnCreate','N','D','C','5432f856-85e2-46b8-9095-8c8a73d874e3')
;

-- May 2, 2018 3:35:00 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200128,0,0,TO_DATE('2018-05-02 15:35:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:35:00','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','MFG_ValidateCostsOnCreate','N','D','C','2bb77e84-41da-48ec-985e-f03223204b1d')
;

-- May 2, 2018 3:36:24 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200129,0,0,TO_DATE('2018-05-02 15:36:24','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:36:24','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','STANDARD_REPORT_FOOTER_TRADEMARK_TEXT',' ','Define the system information to show on report footer','D','C','79d83d91-f4d8-4118-a22b-7d336deccaea')
;

-- May 2, 2018 3:38:50 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200132,0,0,TO_DATE('2018-05-02 15:38:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:38:50','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_DECIMALBOX_PROCESS_DOTKEYPAD','Y','Defines if numeric entry must treat the dot keypad as decimal separator on language','D','C','a6cc348b-d7c9-4af6-a5ae-416b23d9c220')
;

-- May 2, 2018 3:40:06 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200133,0,0,TO_DATE('2018-05-02 15:40:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:40:06','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_FOOTER_SERVER_DATETIME_FORMAT',' ','This key can change the format that is used on the dates on footer of reports','D','C','0cefeb0f-2c5c-4d71-87c5-85a23731a6ac')
;

-- May 2, 2018 3:42:17 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200134,0,0,TO_DATE('2018-05-02 15:42:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:42:17','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_FOOTER_SERVER_MSG',' ','This key allows to change the message that is shown on report footers','D','C','a18d519b-eeb6-4ec6-a080-1495ad829dba')
;

-- May 2, 2018 3:42:54 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200135,0,0,TO_DATE('2018-05-02 15:42:53','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:42:53','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_GRID_MOBILE_MAX_COLUMNS','10','The max number of columns to show in grid view on mobile screens','D','C','88547d79-3b61-4648-9a16-1f4e1a14f426')
;

-- May 2, 2018 3:43:54 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200136,0,0,TO_DATE('2018-05-02 15:43:54','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:43:54','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_MOBILE_PAGING_SIZE','20','Default paging size for grid view in mobile screens','D','C','b535d0cb-8921-4f84-a1b5-01fb9620779e')
;

-- May 2, 2018 3:45:09 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200137,0,0,TO_DATE('2018-05-02 15:45:08','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-05-02 15:45:08','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_SESSION_TIMEOUT_IN_SECONDS','-2','ZK session timeout.  -2 meaning not set','D','O','0599feeb-845f-4ccb-a740-94ad04c85d64')
;

-- May 2, 2018 8:34:38 PM CEST
UPDATE AD_SysConfig SET Name='JASPER_SWAP_MAX_PAGES',Updated=TO_DATE('2018-05-02 20:34:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200011
;

SELECT register_migration_script('201805021545_IDEMPIERE-2852.sql') FROM dual
;

