-- IDEMPIERE-6246 : User Task type workflow node
-- 29-Sep-2024, 11:14:34 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200712,'User Task',302,'U',0,0,'Y',TO_TIMESTAMP('2024-09-29 23:14:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-29 23:14:33','YYYY-MM-DD HH24:MI:SS'),100,'D','30b853d8-63ac-43d7-8abb-248c116abce3')
;

-- 31-Dec-2024, 1:22:51 PM IST
UPDATE AD_Field SET DisplayLogic='@Action@=V | @Action@=C | @Action@=U', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2024-12-31 13:27:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10088
;

SELECT register_migration_script('202411190132_IDEMPIERE-6246.sql') FROM dual
;