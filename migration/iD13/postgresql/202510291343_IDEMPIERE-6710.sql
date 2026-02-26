-- IDEMPIERE-6710 - Read Only Logic ignored when field is marked as Always Updatable
SELECT register_migration_script('202510291343_IDEMPIERE-6710.sql') FROM dual;

-- Oct 29, 2025, 1:43:40 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','A field marked as Always Updatable cannot have Read Only Logic',0,0,'Y',TO_TIMESTAMP('2025-10-29 13:43:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-29 13:43:39','YYYY-MM-DD HH24:MI:SS'),100,200984,'UpdateReadOnlyConflict','D','019a2ffe-d11f-7230-8d85-c2fb9a92a9b1')
;

