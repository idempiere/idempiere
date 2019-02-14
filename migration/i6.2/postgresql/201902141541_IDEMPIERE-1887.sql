-- IDEMPIERE-1887 can make inconsistent data from physical inventory window
-- Feb 14, 2019, 3:40:50 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Warehouse cannot be changed because there are lines.',0,0,'Y',TO_TIMESTAMP('2019-02-14 15:40:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-02-14 15:40:49','YYYY-MM-DD HH24:MI:SS'),100,200487,'CannotChangeWarehouse','D','2a9c7a1b-35b2-464c-a2ba-0aa60be3d81d')
;

SELECT register_migration_script('201902141541_IDEMPIERE-1887.sql') FROM dual
;

