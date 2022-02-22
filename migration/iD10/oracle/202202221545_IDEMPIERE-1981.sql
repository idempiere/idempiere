-- IDEMPIERE-1981 Context Help can have multiple messages
SELECT register_migration_script('202202221545_IDEMPIERE-1981.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 22, 2022, 3:45:06 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201100,'b9c5eb35-1a02-4bcf-bd03-f0df6ff94899',TO_DATE('2022-02-22 15:45:06','YYYY-MM-DD HH24:MI:SS'),100,'prevent the user from creating more than one message','D','Y','ad_ctxhelpmsg_limit',TO_DATE('2022-02-22 15:45:06','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','Y','N','N','N')
;

-- Feb 22, 2022, 3:45:54 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201450,'a57ecca3-5318-41d6-ab08-9b98d167339f',TO_DATE('2022-02-22 15:45:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2022-02-22 15:45:54','YYYY-MM-DD HH24:MI:SS'),100,208566,201100,10)
;

-- Feb 22, 2022, 3:46:13 PM CET
CREATE UNIQUE INDEX ad_ctxhelpmsg_limit ON AD_CtxHelpMsg (AD_CtxHelp_ID)
;

