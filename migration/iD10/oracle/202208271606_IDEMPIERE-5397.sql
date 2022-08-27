-- IDEMPIERE-5397 Refactoring of Product Attribute Grid
SELECT register_migration_script('202208271606_IDEMPIERE-5397.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 27, 2022, 4:06:04 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Same attribute selected for X and Y axis',0,0,'Y',TO_TIMESTAMP('2022-08-27 16:06:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-27 16:06:03','YYYY-MM-DD HH24:MI:SS'),100,200776,'SameAttributeSelectedForXY','D','97bf5743-25c1-4352-a755-ccf4a1da9eba')
;

-- Aug 27, 2022, 4:07:17 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No attribute values found for the selected X axis attribute',0,0,'Y',TO_TIMESTAMP('2022-08-27 16:07:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-27 16:07:15','YYYY-MM-DD HH24:MI:SS'),100,200777,'NoAttributeValuesForX','D','743c18cd-f304-4c45-b511-33dafccf9370')
;

-- Aug 27, 2022, 4:08:01 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No attribute values found for the selected Y axis attribute',0,0,'Y',TO_TIMESTAMP('2022-08-27 16:08:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-27 16:08:00','YYYY-MM-DD HH24:MI:SS'),100,200778,'NoAttributeValuesForY','D','6a9c72b5-d93d-44b6-abf7-d82756707a67')
;

-- Aug 27, 2022, 4:09:37 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No products found for the selected X axis attribute',0,0,'Y',TO_TIMESTAMP('2022-08-27 16:09:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-27 16:09:36','YYYY-MM-DD HH24:MI:SS'),100,200779,'NoProductsFoundForXAttribute','D','c83f478b-0fdc-405a-bc3e-8dbe286aca48')
;

-- Aug 27, 2022, 4:10:09 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No products found for the selected Y axis attribute',0,0,'Y',TO_TIMESTAMP('2022-08-27 16:10:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-27 16:10:08','YYYY-MM-DD HH24:MI:SS'),100,200780,'NoProductsFoundForYAttribute','D','f87b1016-0ad4-4fb6-a104-4a67315afab5')
;

