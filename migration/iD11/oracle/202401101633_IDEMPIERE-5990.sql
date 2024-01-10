-- IDEMPIERE-5990
SELECT register_migration_script('202401101633_IDEMPIERE-5990.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF



-- Jan 10, 2024, 4:35:16 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Business Partner has no Location',0,0,'Y',TO_TIMESTAMP('2024-01-10 16:35:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-10 16:35:16','YYYY-MM-DD HH24:MI:SS'),100,200863,'BPartnerHasNoLocation','D','7c582d77-f65f-4bbe-8bbe-a894754f8b34')
;

-- Jan 10, 2024, 4:35:40 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Business Partner Location has no Address',0,0,'Y',TO_TIMESTAMP('2024-01-10 16:35:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-10 16:35:40','YYYY-MM-DD HH24:MI:SS'),100,200864,'BPartnerLocationHasNoAddress','D','5f931e06-751a-4b18-8f7a-83dade057d0d')
;

-- Jan 10, 2024, 4:36:19 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Organization not saved',0,0,'Y',TO_TIMESTAMP('2024-01-10 16:36:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-10 16:36:19','YYYY-MM-DD HH24:MI:SS'),100,200865,'OrganizationNotSaved','D','656ac3ec-9e56-434a-963c-5adb7bd5b8e2')
;

-- Jan 10, 2024, 4:36:57 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Warehouse not saved',0,0,'Y',TO_TIMESTAMP('2024-01-10 16:36:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-10 16:36:57','YYYY-MM-DD HH24:MI:SS'),100,200866,'WarehouseNotSaved','D','935f1626-c36a-4779-878b-ab6caba4596f')
;

-- Jan 10, 2024, 4:37:04 PM BRT
UPDATE AD_Message SET MsgType='E',Updated=TO_TIMESTAMP('2024-01-10 16:37:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200866
;

-- Jan 10, 2024, 4:37:23 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Organization Info not saved',0,0,'Y',TO_TIMESTAMP('2024-01-10 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-10 16:37:23','YYYY-MM-DD HH24:MI:SS'),100,200867,'OrganizationInfoNotSaved','D','8960d75b-f16c-4541-b54e-f0789450bd8f')
;

-- Jan 10, 2024, 4:37:41 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Business Partner not updated',0,0,'Y',TO_TIMESTAMP('2024-01-10 16:37:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-10 16:37:41','YYYY-MM-DD HH24:MI:SS'),100,200868,'BPartnerNotUpdated','D','d80b80bb-1ec9-426a-b001-7da173756847')
;

-- Jan 10, 2024, 4:37:58 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Business Partner - Organization Link created',0,0,'Y',TO_TIMESTAMP('2024-01-10 16:37:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-10 16:37:58','YYYY-MM-DD HH24:MI:SS'),100,200869,'BPartnerOrganizationLinkCreated','D','52d110f7-2740-4631-905b-8efa7d1725dd')
;

-- Jan 10, 2024, 4:38:01 PM BRT
UPDATE AD_Message SET MsgType='E',Updated=TO_TIMESTAMP('2024-01-10 16:38:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200869
;

-- Jan 10, 2024, 4:40:26 PM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Organization {0} already linked Business Partner {1}',0,0,'Y',TO_TIMESTAMP('2024-01-10 16:40:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-10 16:40:26','YYYY-MM-DD HH24:MI:SS'),100,200870,'OrganizationAlreadyLinkedBusinessPartner','D','6b3757e7-bdeb-43ba-82e1-040cc9d2143b')
;

