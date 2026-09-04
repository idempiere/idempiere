-- IDEMPIERE-7091 Workflow Editor does not display all transition arrows
-- GardenWorld test workflow: fully packed 4x6 grid with hub node, blocked corridors,
-- bidirectional pairs, back edges and self-referencing transitions
-- Dictionary IDs reserved at developer.idempiere.com for IDEMPIERE-7091
SELECT register_migration_script('202609041100_IDEMPIERE-7091.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 2026-09-04 11:00:00
INSERT INTO AD_Workflow (Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AccessLevel,EntityType,Author,WorkingTime,Duration,Version,Cost,DurationUnit,WaitingTime,PublishStatus,IsDefault,Value,WorkflowType,IsValid,IsBetaFunctionality,Yield,AD_Workflow_UU) VALUES ('IDEMPIERE-7091 Test Workflow','Test workflow for IDEMPIERE-7091 - 24 nodes in a fully packed 4x6 grid with blocked corridors, hub node, bidirectional pairs, back edges and self references',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'3','D','Markus Bozem',0,1,0,0,'D',0,'R','N','IDEMPIERE-7091-TestWF','G','Y','N',100,'7091fa9d-c694-48b3-ba4d-cb201f036384')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200042,'7091 Start',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',1,'D',1,0,0,0,0,0,0,'X','X',0,'7091Start','70911595-3f43-46e1-9ae5-80290f4080a6')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200043,'7091 Block A',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',1,'D',2,0,0,0,0,0,0,'X','X',0,'7091BlockA','70914e91-597f-499d-b168-0f8291cce351')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200044,'7091 Block B',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',1,'D',3,0,0,0,0,0,0,'X','X',0,'7091BlockB','709149af-202f-492e-b6cd-86e6bda5687c')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200045,'7091 Hub',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',1,'D',4,0,0,0,0,0,0,'X','X',0,'7091Hub','7091cdf5-fceb-4079-a67b-b3c88c833dad')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200046,'7091 In A',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',2,'D',1,0,0,0,0,0,0,'X','X',0,'7091InA','709156a6-5197-4f51-abda-ecdb9e5ee8db')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200047,'7091 Block C',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',2,'D',2,0,0,0,0,0,0,'X','X',0,'7091BlockC','7091d9be-3b4b-45f8-ac66-2322601445ec')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200048,'7091 Block D',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',2,'D',3,0,0,0,0,0,0,'X','X',0,'7091BlockD','70916da5-256c-4243-a20b-59cd203c5460')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200049,'7091 Pair A',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',2,'D',4,0,0,0,0,0,0,'X','X',0,'7091PairA','7091bc91-3cff-47dc-a836-a0766dbbf804')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200050,'7091 In B',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',3,'D',1,0,0,0,0,0,0,'X','X',0,'7091InB','70919769-12c6-47dc-83c7-5e4ce5514dbd')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200051,'7091 Block E',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',3,'D',2,0,0,0,0,0,0,'X','X',0,'7091BlockE','7091c81b-e44e-4f51-8390-5097355bb009')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200052,'7091 Block F',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',3,'D',3,0,0,0,0,0,0,'X','X',0,'7091BlockF','709141ca-6449-4ed2-81d1-2ef4d5849851')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200053,'7091 Pair B',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',3,'D',4,0,0,0,0,0,0,'X','X',0,'7091PairB','7091f4a5-ca54-46e3-a6b9-26baca79726b')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200054,'7091 In C',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',4,'D',1,0,0,0,0,0,0,'X','X',0,'7091InC','7091252a-dd19-4cd6-b909-70b23732eacc')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200055,'7091 Self 1',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',4,'D',2,0,0,0,0,0,0,'X','X',0,'7091Self1','7091dd11-aa44-4324-a5c8-9521065bd26e')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200056,'7091 Self 2',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',4,'D',3,0,0,0,0,0,0,'X','X',0,'7091Self2','709124db-fbc4-4a41-afb8-ea30d12704d1')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200057,'7091 Out A',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',4,'D',4,0,0,0,0,0,0,'X','X',0,'7091OutA','7091475f-2c2a-4499-b40c-15636578c234')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200058,'7091 In D',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',5,'D',1,0,0,0,0,0,0,'X','X',0,'7091InD','7091722d-9f08-4d7f-95b6-e6d3f67a7be0')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200059,'7091 Block G',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',5,'D',2,0,0,0,0,0,0,'X','X',0,'7091BlockG','7091b9ee-9d0f-41ff-a3ae-0cceaf8503eb')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200060,'7091 Block H',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',5,'D',3,0,0,0,0,0,0,'X','X',0,'7091BlockH','7091278d-58ab-42fe-be2d-ab4eea366de2')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200061,'7091 Out B',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',5,'D',4,0,0,0,0,0,0,'X','X',0,'7091OutB','7091f501-87be-4560-8322-03077b42109d')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200062,'7091 Sink',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',6,'D',1,0,0,0,0,0,0,'X','X',0,'7091Sink','7091bbf3-97ba-4e0c-9743-e807478a83d7')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200063,'7091 Block I',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',6,'D',2,0,0,0,0,0,0,'X','X',0,'7091BlockI','70914ce3-be45-4caf-8b52-7286476c1f6d')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200064,'7091 Block J',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',6,'D',3,0,0,0,0,0,0,'X','X',0,'7091BlockJ','70919e84-b058-4006-9e81-0137b5cd6b2b')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,Value,AD_WF_Node_UU) VALUES (200065,'7091 Out C',200016,11,0,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',6,'D',4,0,0,0,0,0,0,'X','X',0,'7091OutC','70918941-f4fa-4307-90c0-d64009fca9cc')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200042,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200045,'D',10,'Straight line across row 1 over blocked nodes',200034,'N','70913cd1-7703-4895-9ba6-cf795347a145')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200042,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200046,'D',20,'Start down left column',200035,'N','7091b061-d20f-43cf-b1da-3c8faed91394')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200042,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200043,'D',30,'Start to Block A',200071,'N','7091232e-4500-4a7d-b56e-a0abe0244293')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200043,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200044,'D',10,'Row 1 block corridor',200036,'N','709175ae-367c-4036-853b-0ba009adacff')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200044,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200045,'D',10,'Row 1 block corridor into hub',200037,'N','70915778-f9e9-48f1-a019-f4fce020e389')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200045,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200049,'D',10,'Hub straight down',200038,'N','7091789a-7067-4eee-a8a7-1a8bf8910243')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200045,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200046,'D',20,'Hub diagonal',200039,'N','709171c4-5db3-47bd-9136-2f355376b5fb')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200045,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200057,'D',30,'Hub blocked vertical',200040,'N','7091c80a-860c-4b75-9185-2902d8abda8a')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200045,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200050,'D',40,'Hub long diagonal',200041,'N','7091daf2-583a-44fb-87c7-f5b647d34362')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200045,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200061,'D',50,'Hub blocked vertical',200042,'N','7091ee34-279b-4264-9acd-e221e7d6bc99')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200045,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200062,'D',60,'Hub long diagonal',200043,'N','70917a2a-ce80-4c1e-a20a-8df01a174a1e')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200046,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200050,'D',10,'Left column down',200044,'N','70915c69-a689-4d40-ac10-94ab2310604e')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200046,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200042,'D',20,'Back edge to Start',200045,'N','709144f6-e200-449d-ae1f-d4475bf8bda2')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200046,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200047,'D',30,'In A to Block C',200072,'N','70914d62-0bb8-4cde-a291-d76c70b2c446')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200047,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200048,'D',10,'Row 2 block corridor',200046,'N','709187da-edc3-46a5-97f3-88c13e8b0cf4')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200048,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200049,'D',10,'Row 2 into Pair A',200047,'N','7091adc7-15de-463e-9839-a87bb7b43fc7')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200049,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200053,'D',10,'Pair A to Pair B',200048,'N','7091bddd-9632-4719-9a63-524ad3ce51b1')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200049,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200045,'D',20,'Bidirectional Pair A to Hub',200049,'N','7091cc4f-19ac-48f2-a65b-7df98326dc60')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200050,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200054,'D',10,'Left column down',200050,'N','7091164d-8d9d-4101-a3e9-d5f2cc872070')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200050,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200051,'D',20,'Row 3 block corridor',200051,'N','70915850-15c1-48af-adce-fbd673e8e7b8')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200051,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200052,'D',10,'Row 3 block corridor',200052,'N','709191f5-4e93-4755-8b40-15a859df6db9')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200052,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200053,'D',10,'Row 3 into Pair B',200053,'N','7091d384-bc7c-442b-92f9-7f17d557addd')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200053,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200057,'D',10,'Pair B to Out A',200054,'N','70916faa-dd0a-4a9e-87fe-4620d4261979')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200053,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200049,'D',20,'Bidirectional Pair B to Pair A',200055,'N','709117f5-5151-4df7-beec-0fa8505b9028')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200054,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200055,'D',10,'Into Self 1',200056,'N','7091e17d-06c0-488a-b761-7825ab5ee2ae')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200054,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200058,'D',20,'Left column down',200057,'N','70910c48-9dd3-4f75-aa36-e1759e3d3ac3')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200055,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200055,'D',10,'Self reference',200058,'N','709165a4-91a4-4487-a92e-a7a7bd4446de')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200055,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200056,'D',20,'Self 1 to Self 2',200059,'N','70912bd2-e4a6-4288-a4a7-d742f399d5c1')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200056,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200056,'D',10,'Self reference',200060,'N','709161a8-ad1f-4007-aeef-96f544d479a5')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200057,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200061,'D',10,'Out column down',200061,'N','709129f2-37ee-4573-835f-01609a6f9e65')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200058,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200062,'D',10,'Left column down',200062,'N','70913993-32c6-443b-9021-f541889ba950')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200058,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200045,'D',20,'Long back edge to Hub',200063,'N','7091efb7-f27e-4596-bd5c-525254b1e470')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200058,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200059,'D',30,'In D to Block G',200073,'N','7091acb7-60da-4e23-af4b-3f8b238445e8')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200059,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200060,'D',10,'Row 5 block corridor',200064,'N','70918121-0257-4f55-873e-b5b2e3f390df')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200060,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200061,'D',10,'Row 5 into Out B',200065,'N','70917c36-736d-4b3a-bab2-959176042058')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200061,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200065,'D',10,'Out column down',200066,'N','70915fa9-bd37-4094-bcad-f5d007a3a4f6')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200062,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200042,'D',10,'Back edge to Start closes cycle',200067,'N','7091d870-377c-499f-a10d-a43353594501')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200062,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200063,'D',20,'Sink to Block I',200074,'N','709188d2-0b3b-4d40-b8c2-3eaadd23877d')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200063,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200064,'D',10,'Row 6 block corridor',200068,'N','7091367e-6c02-4a4f-a453-c09617d787a0')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200064,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200065,'D',10,'Row 6 into Out C',200069,'N','709191be-39ea-465f-9909-9098cbff7aac')
;
-- 2026-09-04 11:00:00
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200065,'Y',TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),100,11,0,200062,'D',10,'Out C back to Sink',200070,'N','7091a197-918f-4368-9d45-72041c2197f6')
;
-- 2026-09-04 11:00:00
UPDATE AD_Workflow SET AD_WF_Node_ID=200042, IsValid='Y',Updated=TO_DATE('2026-09-04 11:00:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=200016
;
