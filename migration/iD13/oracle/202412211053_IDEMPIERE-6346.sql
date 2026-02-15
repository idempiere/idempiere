SET SQLBLANKLINES ON
SET DEFINE OFF

-- Workflow responsible type Initiator and Supervisor
-- Dec 21, 2024, 10:57:43 AM IST
UPDATE AD_Column SET FieldLength=2,Updated=TO_DATE('2024-12-21 10:57:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10473
;

-- 21-Dec-2024, 12:00:17 PM IST
ALTER TABLE AD_WF_Responsible MODIFY ResponsibleType VARCHAR2(2 CHAR)
;

-- Dec 21, 2024, 10:51:06 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200713,'Initiator',304,'I',0,0,'Y',TO_DATE('2024-12-21 10:51:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-12-21 10:51:04','YYYY-MM-DD HH24:MI:SS'),100,'D','c7bf3a3c-1d5f-4bd2-919e-5e96e857348c')
;

-- Dec 21, 2024, 10:57:01 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200715,'Supervisor',304,'SV',0,0,'Y',TO_DATE('2024-12-21 10:57:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-12-21 10:57:00','YYYY-MM-DD HH24:MI:SS'),100,'D','bf1ce615-473f-41f4-a818-dd60fc2debf3')
;

-- 21-Dec-2024, 2:16:22 PM IST
INSERT INTO AD_WF_Responsible (IsActive,ResponsibleType,CreatedBy,Name,Created,AD_Role_ID,Description,AD_Client_ID,Updated,AD_Org_ID,AD_WF_Responsible_ID,UpdatedBy,EntityType,AD_WF_Responsible_UU) VALUES ('Y','I',100,'Initiator',TO_DATE('2024-12-21 14:16:21','YYYY-MM-DD HH24:MI:SS'),0,'This will be the user who initiated workflow. Currently we have invoker, which considered as current login user who invoke action',0,TO_DATE('2024-12-21 14:16:21','YYYY-MM-DD HH24:MI:SS'),0,200000,100,'D','d8edbd53-1674-40e3-ac50-c7a461f7cef4')
;

-- 21-Dec-2024, 2:20:42 PM IST
INSERT INTO AD_WF_Responsible (IsActive,ResponsibleType,CreatedBy,Name,Created,AD_Role_ID,Description,AD_Client_ID,Updated,AD_Org_ID,AD_WF_Responsible_ID,UpdatedBy,EntityType,AD_WF_Responsible_UU) VALUES ('Y','SV',100,'Supervisor',TO_DATE('2024-12-21 14:20:42','YYYY-MM-DD HH24:MI:SS'),0,'This will be the either immediate supervisor of User who has started workflow or Organization’s supervisor if the initiator don’t have supervisor set.',0,TO_DATE('2024-12-21 14:20:42','YYYY-MM-DD HH24:MI:SS'),0,200001,100,'D','888725bc-348b-483b-86cb-eb3f4e6567b6')
;

SELECT register_migration_script('202412211053_IDEMPIERE-6346.sql') FROM dual
;