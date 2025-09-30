-- IDEMPIERE-6433 Fill Getting Started box
SELECT register_migration_script('202505021601_IDEMPIERE-6433.sql') FROM dual;

-- May 2, 2025, 4:01:01 PM CEST
INSERT INTO AD_CtxHelp (AD_Client_ID,AD_CtxHelp_ID,AD_CtxHelp_UU,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,CtxType,Name) VALUES (0,200000,'ccf8e5d0-54ef-44fb-bc34-d827a5145391',0,TO_TIMESTAMP('2025-05-02 16:01:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2025-05-02 16:01:00','YYYY-MM-DD HH24:MI:SS'),100,'H','Home - Getting Started')
;

-- May 2, 2025, 4:03:00 PM CEST
INSERT INTO AD_CtxHelpMsg (AD_Client_ID,AD_CtxHelpMsg_ID,AD_CtxHelpMsg_UU,AD_Org_ID,Created,CreatedBy,IsActive,MsgText,Updated,UpdatedBy,AD_CtxHelp_ID) VALUES (0,200000,'7d7911bb-1598-4354-8b7b-b6bc7e3d28a8',0,TO_TIMESTAMP('2025-05-02 16:02:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','<p>Welcome to iDempiere!</p>

<p>Start exploring your workspace, managing data, and customizing your experience.</p>

<p>Need help? Check out our <a href="https://docs.idempiere.org/docs/getting-started" target="_blank">Getting Started Guide</a>.</p>
',TO_TIMESTAMP('2025-05-02 16:02:59','YYYY-MM-DD HH24:MI:SS'),100,200000)
;

