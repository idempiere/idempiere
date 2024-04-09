-- IDEMPIERE-6040 Improvements for CSV import template
SELECT register_migration_script('202404041545_IDEMPIERE-6040.sql') FROM dual;

-- Apr 4, 2024, 3:45:17 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','CSV Alias Header is not valid, it must have the same number of columns as the CSV Header',0,0,'Y',TO_TIMESTAMP('2024-04-04 15:45:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-04 15:45:16','YYYY-MM-DD HH24:MI:SS'),100,200885,'CSVAliasHeaderNotValid','D','c0f8a304-5ff2-4503-95a0-13d61aa391a3')
;

