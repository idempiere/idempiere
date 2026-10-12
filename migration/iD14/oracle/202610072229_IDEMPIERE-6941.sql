-- IDEMPIERE-6941 Validate vendor role when creating PO from requisition

SELECT register_migration_script('202610072229_IDEMPIERE-6941.sql') FROM dual;


SET SQLBLANKLINES ON
SET DEFINE OFF


-- Add translatable message for invalid vendor Business Partner
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU)
VALUES ('E','Business Partner {0} is not a Vendor.',0,0,'Y',
TO_TIMESTAMP('2026-10-07 22:28:52','YYYY-MM-DD HH24:MI:SS'),
100,
TO_TIMESTAMP('2026-10-07 22:28:52','YYYY-MM-DD HH24:MI:SS'),
100,
201070,'NotVendor','D','01a11737-537d-7c67-b121-100110de7fb8')
;
