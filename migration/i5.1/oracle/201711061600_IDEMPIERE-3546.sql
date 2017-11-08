SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3546 - Use specific messages for range process parameters placeholder
-- Nov 6, 2017 4:07:29 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','From',0,0,'Y',TO_DATE('2017-11-06 16:07:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2017-11-06 16:07:28','YYYY-MM-DD HH24:MI:SS'),0,200438,'ProcessParameterRangeFrom','D','44852250-153e-462a-b206-897d0c2cd1ab')
;

-- Nov 6, 2017 4:07:42 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','To',0,0,'Y',TO_DATE('2017-11-06 16:07:42','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2017-11-06 16:07:42','YYYY-MM-DD HH24:MI:SS'),0,200439,'ProcessParameterRangeTo','D','07220887-ecb2-42e9-9665-260041080b52')
;

INSERT INTO ad_message_trl
(ad_message_id, ad_language, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, msgtext, msgtip, istranslated, ad_message_trl_uu)
SELECT 200438, ad_language, ad_client_id, ad_org_id, isactive, SysDate, 100, SysDate, 100, msgtext, msgtip, istranslated, generate_uuid()
FROM ad_message_trl
WHERE ad_message_id=280;

INSERT INTO ad_message_trl
(ad_message_id, ad_language, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, msgtext, msgtip, istranslated, ad_message_trl_uu)
SELECT 200439, ad_language, ad_client_id, ad_org_id, isactive, SysDate, 100, SysDate, 100, msgtext, msgtip, istranslated, generate_uuid()
FROM ad_message_trl
WHERE ad_message_id=565;

SELECT register_migration_script('201711061600_IDEMPIERE-3546.sql') FROM dual
;
