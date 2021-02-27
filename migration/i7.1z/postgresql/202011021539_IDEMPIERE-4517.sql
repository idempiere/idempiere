-- IDEMPIERE-4517 Some messages missing - toolbar
-- Nov 2, 2020, 3:13:25 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Grid Toggle',0,0,'Y',TO_TIMESTAMP('2020-11-02 15:13:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-02 15:13:25','YYYY-MM-DD HH24:MI:SS'),100,200644,'Toggle','D','180ca04f-183f-459f-806e-f153f2682375')
;

-- Nov 2, 2020, 3:13:40 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Parent Record',0,0,'Y',TO_TIMESTAMP('2020-11-02 15:13:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-02 15:13:40','YYYY-MM-DD HH24:MI:SS'),100,200645,'ParentRecord','D','b278e708-8445-495a-b180-20d527025e9c')
;

-- Nov 2, 2020, 3:13:53 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Detail record',0,0,'Y',TO_TIMESTAMP('2020-11-02 15:13:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-02 15:13:52','YYYY-MM-DD HH24:MI:SS'),100,200646,'DetailRecord','D','e389b9a4-03c1-4681-aa00-573bc57515cb')
;

-- Nov 2, 2020, 3:14:04 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Active Workflows',0,0,'Y',TO_TIMESTAMP('2020-11-02 15:14:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-02 15:14:04','YYYY-MM-DD HH24:MI:SS'),100,200647,'ActiveWorkflows','D','0706bb1e-9700-42bc-92ec-3890ee22a18e')
;

-- Nov 2, 2020, 3:14:15 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Check Requests',0,0,'Y',TO_TIMESTAMP('2020-11-02 15:14:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-02 15:14:15','YYYY-MM-DD HH24:MI:SS'),100,200648,'Requests','D','8189a7f3-5e9d-432e-9c9e-7479f8352527')
;

-- Nov 2, 2020, 3:14:27 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Product Info',0,0,'Y',TO_TIMESTAMP('2020-11-02 15:14:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-11-02 15:14:27','YYYY-MM-DD HH24:MI:SS'),100,200649,'ProductInfo','D','aed93a4d-24e5-42b7-81a6-975c18b85e20')
;

SELECT register_migration_script('202011021539_IDEMPIERE-4517.sql') FROM dual
;

