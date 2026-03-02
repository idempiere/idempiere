-- IDEMPIERE-6820 Add multi tenant support to SSO (DAD-209)
SELECT register_migration_script('202603021832_IDEMPIERE-6820.sql') FROM dual;

-- Mar 2, 2026, 6:32:24 PM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Application Discovery URI must end with /.well-known/openid-configuration',0,0,'Y',TO_TIMESTAMP('2026-03-02 18:32:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-02 18:32:23','YYYY-MM-DD HH24:MI:SS'),100,200994,'DiscoveryURIMustEndWith','D','019cae1b-33bb-7374-906b-e04970bc991f')
;

