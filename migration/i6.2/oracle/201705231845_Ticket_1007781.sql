SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 23, 2017 6:42:29 PM SGT
-- 1007781 Fix barcode text bug
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Ref_List_UU,Name,Value,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created,Updated,EntityType,AD_Reference_ID) VALUES (200374,'af593ade-94ff-47bf-9b4e-a60c278d3541','Code 39 with Checksum','39C','Y',100,100,0,0,TO_DATE('2017-05-23 18:42:28','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2017-05-23 18:42:28','YYYY-MM-DD HH24:MI:SS'),'D',377)
;

-- May 23, 2017 6:42:30 PM SGT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Ref_List_UU,Name,Value,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created,Updated,EntityType,AD_Reference_ID) VALUES (200375,'918c6018-41f7-40ba-965b-65512ec99808','Code 39 w/o Checksum','39c','Y',100,100,0,0,TO_DATE('2017-05-23 18:42:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2017-05-23 18:42:29','YYYY-MM-DD HH24:MI:SS'),'D',377)
;

SELECT register_migration_script('201705231845_Ticket_1007781.sql') FROM dual
;
