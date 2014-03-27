-- Mar 24, 2014 8:09:18 PM COT
-- IDEMPIERE-1852 Translation: Accounting Fact Reconcilation (manual)
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','DR',200260,'D','40c2b5df-fe62-4d94-9376-fa82bfe99969','DR','Y',TO_TIMESTAMP('2014-03-24 20:09:17','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2014-03-24 20:09:17','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Mar 24, 2014 8:09:35 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','CR',200261,'D','c4c434ec-7516-46c0-ad29-122c2b871b04','CR','Y',TO_TIMESTAMP('2014-03-24 20:09:35','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2014-03-24 20:09:35','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Mar 24, 2014 8:10:25 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','DR/CR',200262,'D','41ceddd4-a1d0-4387-8d64-f10391a9badf','DR/CR','Y',TO_TIMESTAMP('2014-03-24 20:10:24','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2014-03-24 20:10:24','YYYY-MM-DD HH24:MI:SS'),0,0)
;

SELECT register_migration_script('201403242011_IDEMPIERE-1852.sql') FROM dual
;

