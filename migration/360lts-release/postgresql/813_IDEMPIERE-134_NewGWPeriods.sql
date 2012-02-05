-- Feb 4, 2012 9:29:34 PM COT
-- IDEMPIERE-134 Create 2012 periods on GardenWorld demo company
INSERT INTO C_Year (C_Year_ID,FiscalYear,C_Calendar_ID,CreatedBy,Processing,Updated,IsActive,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200000,'2012',102,100,'N',TO_TIMESTAMP('2012-02-04 21:29:33','YYYY-MM-DD HH24:MI:SS'),'Y',0,TO_TIMESTAMP('2012-02-04 21:29:33','YYYY-MM-DD HH24:MI:SS'),100,11)
;

-- Feb 4, 2012 9:29:54 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200000,200000,'S',1,TO_TIMESTAMP('2012-01-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-01-31','YYYY-MM-DD'),'Jan-12',0,TO_TIMESTAMP('2012-02-04 21:29:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:29:53','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:29:54 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200000,'N','N','MMR',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:54','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:55 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200001,'N','N','MMS',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:54','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:55 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200002,'N','N','PJI',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:55','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:55 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200003,'N','N','CMA',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:55','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:56 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200004,'N','N','MXI',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:55','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:56 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200005,'N','N','MMP',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:56','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:57 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200006,'N','N','GLD',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:56','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:57 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200007,'N','N','CMC',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:57','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:58 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200008,'N','N','MXP',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:57','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:58 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200009,'N','N','MMM',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:58','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:58 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200010,'N','N','MMI',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:58','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:59 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200011,'N','N','ARF',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:58','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:29:59 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200012,'N','N','CMB',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:59','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:00 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200013,'N','N','API',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:29:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:29:59','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:00 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200014,'N','N','APC',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:00','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:01 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200015,'N','N','GLJ',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:00','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:01 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200016,'N','N','ARI',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:01','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:02 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200017,'N','N','ARC',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:01','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:02 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200018,'N','N','ARR',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:02','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:02 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200019,'N','N','APP',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:02','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:03 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200020,'N','N','POR',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:02','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:03 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200021,'N','N','SOO',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:03','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:04 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200022,'N','N','POO',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:03','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:04 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200023,'N','N','HRP',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:04','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:05 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200024,'N','N','MOP',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:04','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:05 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200025,'N','N','MOF',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:05','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:06 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200026,'N','N','MQO',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:05','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:06 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200027,'N','N','DOO',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:06','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:06 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200028,'N','N','MCC',200000,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:06','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:07 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200001,200000,'S',2,TO_TIMESTAMP('2012-02-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-02-29','YYYY-MM-DD'),'Feb-12',0,TO_TIMESTAMP('2012-02-04 21:30:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:30:06','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:30:07 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200029,'N','N','MMR',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:07','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:08 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200030,'N','N','MMS',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:07','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:08 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200031,'N','N','PJI',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:08','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:09 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200032,'N','N','CMA',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:08','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:09 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200033,'N','N','MXI',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:09','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:10 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200034,'N','N','MMP',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:09','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:10 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200035,'N','N','GLD',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:10','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:11 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200036,'N','N','CMC',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:10','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:11 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200037,'N','N','MXP',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:11','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:11 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200038,'N','N','MMM',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:11','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:12 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200039,'N','N','MMI',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:11','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:12 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200040,'N','N','ARF',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:12','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:13 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200041,'N','N','CMB',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:12','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:13 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200042,'N','N','API',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:13','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:14 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200043,'N','N','APC',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:13','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:14 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200044,'N','N','GLJ',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:14','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:14 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200045,'N','N','ARI',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:14','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:15 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200046,'N','N','ARC',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:14','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:15 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200047,'N','N','ARR',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:15','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:16 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200048,'N','N','APP',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:15','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:16 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200049,'N','N','POR',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:16','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:17 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200050,'N','N','SOO',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:16','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:17 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200051,'N','N','POO',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:17','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:17 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200052,'N','N','HRP',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:17','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:18 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200053,'N','N','MOP',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:17','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:18 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200054,'N','N','MOF',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:18','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:19 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200055,'N','N','MQO',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:18','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:19 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200056,'N','N','DOO',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:19','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:20 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200057,'N','N','MCC',200001,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:19','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:20 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200002,200000,'S',3,TO_TIMESTAMP('2012-03-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-03-31','YYYY-MM-DD'),'Mar-12',0,TO_TIMESTAMP('2012-02-04 21:30:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:30:20','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:30:21 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200058,'N','N','MMR',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:20','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:20','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:21 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200059,'N','N','MMS',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:21','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:21 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200060,'N','N','PJI',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:21','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:22 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200061,'N','N','CMA',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:21','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:22 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200062,'N','N','MXI',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:22','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:23 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200063,'N','N','MMP',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:22','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:23 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200064,'N','N','GLD',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:23','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:24 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200065,'N','N','CMC',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:23','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:24 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200066,'N','N','MXP',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:24','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200067,'N','N','MMM',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:24','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200068,'N','N','MMI',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:25','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200069,'N','N','ARF',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:25','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:26 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200070,'N','N','CMB',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:25','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:26 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200071,'N','N','API',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:26','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:27 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200072,'N','N','APC',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:26','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:27 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200073,'N','N','GLJ',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:27','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200074,'N','N','ARI',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:27','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200075,'N','N','ARC',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200076,'N','N','ARR',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:29 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200077,'N','N','APP',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:29 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200078,'N','N','POR',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:29','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:30 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200079,'N','N','SOO',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:29','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:30 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200080,'N','N','POO',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:30','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:31 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200081,'N','N','HRP',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:30','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:31 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200082,'N','N','MOP',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:31','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:32 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200083,'N','N','MOF',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:31','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:32 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200084,'N','N','MQO',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:32','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:32 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200085,'N','N','DOO',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:32','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:33 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200086,'N','N','MCC',200002,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:32','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:33 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200003,200000,'S',4,TO_TIMESTAMP('2012-04-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-04-30','YYYY-MM-DD'),'Apr-12',0,TO_TIMESTAMP('2012-02-04 21:30:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:30:33','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:30:34 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200087,'N','N','MMR',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:33','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:33','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:34 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200088,'N','N','MMS',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:34','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:35 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200089,'N','N','PJI',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:34','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:35 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200090,'N','N','CMA',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:35','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:35','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:36 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200091,'N','N','MXI',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:35','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:35','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:36 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200092,'N','N','MMP',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:36','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:36 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200093,'N','N','GLD',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:36','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:37 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200094,'N','N','CMC',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:36','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:37 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200095,'N','N','MXP',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:37','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:38 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200096,'N','N','MMM',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:37','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:38 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200097,'N','N','MMI',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:38','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:39 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200098,'N','N','ARF',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:38','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:39 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200099,'N','N','CMB',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:39','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:39 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200100,'N','N','API',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:39','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:40 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200101,'N','N','APC',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:39','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:40 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200102,'N','N','GLJ',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:40','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:40','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:41 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200103,'N','N','ARI',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:40','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:40','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:41 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200104,'N','N','ARC',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:41','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:42 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200105,'N','N','ARR',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:41','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:42 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200106,'N','N','APP',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:42','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:43 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200107,'N','N','POR',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:42','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:43 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200108,'N','N','SOO',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:43','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:44 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200109,'N','N','POO',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:43','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:44 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200110,'N','N','HRP',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:44','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:44 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200111,'N','N','MOP',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:44','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:45 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200112,'N','N','MOF',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:44','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:45 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200113,'N','N','MQO',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:45','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:46 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200114,'N','N','DOO',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:45','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:46 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200115,'N','N','MCC',200003,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:46','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:47 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200004,200000,'S',5,TO_TIMESTAMP('2012-05-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-05-31','YYYY-MM-DD'),'May-12',0,TO_TIMESTAMP('2012-02-04 21:30:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:30:46','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:30:47 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200116,'N','N','MMR',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:47','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:48 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200117,'N','N','MMS',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:47','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:48 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200118,'N','N','PJI',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:48','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:48 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200119,'N','N','CMA',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:48','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:49 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200120,'N','N','MXI',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:48','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:49 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200121,'N','N','MMP',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:49','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:50 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200122,'N','N','GLD',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:49','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:50 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200123,'N','N','CMC',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:50','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:50','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:51 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200124,'N','N','MXP',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:50','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:50','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:51 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200125,'N','N','MMM',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:51','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:52 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200126,'N','N','MMI',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:51','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:52 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200127,'N','N','ARF',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:52','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:52 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200128,'N','N','CMB',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:52','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:53 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200129,'N','N','API',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:52','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:53 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200130,'N','N','APC',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:53','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:53','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:54 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200131,'N','N','GLJ',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:53','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:53','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:54 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200132,'N','N','ARI',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:54','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:55 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200133,'N','N','ARC',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:54','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:55 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200134,'N','N','ARR',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:55','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:55 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200135,'N','N','APP',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:55','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:56 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200136,'N','N','POR',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:55','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:56 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200137,'N','N','SOO',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:56','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:57 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200138,'N','N','POO',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:56','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:57 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200139,'N','N','HRP',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:57','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:58 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200140,'N','N','MOP',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:57','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:58 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200141,'N','N','MOF',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:58','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:58 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200142,'N','N','MQO',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:58','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:59 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200143,'N','N','DOO',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:58','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:30:59 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200144,'N','N','MCC',200004,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:30:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:30:59','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:00 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200005,200000,'S',6,TO_TIMESTAMP('2012-06-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-06-30','YYYY-MM-DD'),'Jun-12',0,TO_TIMESTAMP('2012-02-04 21:30:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:30:59','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:31:00 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200145,'N','N','MMR',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:00','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:01 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200146,'N','N','MMS',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:00','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:01 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200147,'N','N','PJI',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:01','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:02 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200148,'N','N','CMA',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:01','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:02 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200149,'N','N','MXI',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:02','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:02 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200150,'N','N','MMP',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:02','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:03 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200151,'N','N','GLD',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:02','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:03 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200152,'N','N','CMC',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:03','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:04 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200153,'N','N','MXP',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:03','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:04 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200154,'N','N','MMM',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:04','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:05 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200155,'N','N','MMI',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:04','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:05 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200156,'N','N','ARF',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:05','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:06 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200157,'N','N','CMB',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:05','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:06 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200158,'N','N','API',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:06','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:06 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200159,'N','N','APC',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:06','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:07 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200160,'N','N','GLJ',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:06','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:07 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200161,'N','N','ARI',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:07','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:08 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200162,'N','N','ARC',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:07','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:08 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200163,'N','N','ARR',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:08','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:09 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200164,'N','N','APP',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:08','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:09 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200165,'N','N','POR',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:09','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:09 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200166,'N','N','SOO',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:09','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:10 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200167,'N','N','POO',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:09','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:10 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200168,'N','N','HRP',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:10','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:11 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200169,'N','N','MOP',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:10','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:11 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200170,'N','N','MOF',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:11','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:12 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200171,'N','N','MQO',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:11','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:12 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200172,'N','N','DOO',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:12','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:12 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200173,'N','N','MCC',200005,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:12','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:13 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200006,200000,'S',7,TO_TIMESTAMP('2012-07-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-07-31','YYYY-MM-DD'),'Jul-12',0,TO_TIMESTAMP('2012-02-04 21:31:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:31:12','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:31:13 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200174,'N','N','MMR',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:13','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:14 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200175,'N','N','MMS',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:13','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:14 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200176,'N','N','PJI',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:14','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:15 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200177,'N','N','CMA',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:14','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:15 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200178,'N','N','MXI',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:15','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:15 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200179,'N','N','MMP',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:15','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:16 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200180,'N','N','GLD',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:15','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:16 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200181,'N','N','CMC',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:16','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:17 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200182,'N','N','MXP',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:16','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:17 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200183,'N','N','MMM',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:17','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:18 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200184,'N','N','MMI',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:17','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:18 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200185,'N','N','ARF',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:18','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:18 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200186,'N','N','CMB',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:18','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:19 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200187,'N','N','API',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:18','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:19 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200188,'N','N','APC',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:19','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:20 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200189,'N','N','GLJ',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:19','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:20 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200190,'N','N','ARI',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:20','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:20','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:21 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200191,'N','N','ARC',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:20','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:20','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:21 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200192,'N','N','ARR',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:21','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:21 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200193,'N','N','APP',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:21','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:22 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200194,'N','N','POR',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:22','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:22 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200195,'N','N','SOO',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:22','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:23 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200196,'N','N','POO',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:22','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:23 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200197,'N','N','HRP',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:23','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:24 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200198,'N','N','MOP',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:23','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:24 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200199,'N','N','MOF',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:24','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200200,'N','N','MQO',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:24','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200201,'N','N','DOO',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:25','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200202,'N','N','MCC',200006,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:25','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:26 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200007,200000,'S',8,TO_TIMESTAMP('2012-08-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-08-31','YYYY-MM-DD'),'Aug-12',0,TO_TIMESTAMP('2012-02-04 21:31:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:31:25','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:31:26 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200203,'N','N','MMR',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:26','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:27 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200204,'N','N','MMS',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:26','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:27 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200205,'N','N','PJI',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:27','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200206,'N','N','CMA',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:27','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200207,'N','N','MXI',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200208,'N','N','MMP',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:29 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200209,'N','N','GLD',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:29 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200210,'N','N','CMC',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:29','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:30 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200211,'N','N','MXP',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:29','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:30 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200212,'N','N','MMM',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:30','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:31 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200213,'N','N','MMI',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:30','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:31 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200214,'N','N','ARF',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:31','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:32 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200215,'N','N','CMB',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:31','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:32 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200216,'N','N','API',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:32','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:32 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200217,'N','N','APC',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:32','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:33 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200218,'N','N','GLJ',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:32','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:33 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200219,'N','N','ARI',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:33','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:33','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:34 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200220,'N','N','ARC',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:33','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:33','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:34 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200221,'N','N','ARR',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:34','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:35 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200222,'N','N','APP',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:34','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:35 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200223,'N','N','POR',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:35','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:35','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:36 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200224,'N','N','SOO',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:35','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:35','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:36 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200225,'N','N','POO',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:36','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:36 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200226,'N','N','HRP',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:36','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:37 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200227,'N','N','MOP',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:36','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:37 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200228,'N','N','MOF',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:37','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:38 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200229,'N','N','MQO',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:37','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:38 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200230,'N','N','DOO',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:38','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:39 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200231,'N','N','MCC',200007,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:38','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:39 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200008,200000,'S',9,TO_TIMESTAMP('2012-09-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-09-30','YYYY-MM-DD'),'Sep-12',0,TO_TIMESTAMP('2012-02-04 21:31:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:31:39','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:31:39 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200232,'N','N','MMR',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:39','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:40 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200233,'N','N','MMS',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:39','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:40 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200234,'N','N','PJI',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:40','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:40','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:41 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200235,'N','N','CMA',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:40','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:40','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:41 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200236,'N','N','MXI',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:41','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:42 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200237,'N','N','MMP',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:41','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:42 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200238,'N','N','GLD',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:42','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:42 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200239,'N','N','CMC',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:42','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:43 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200240,'N','N','MXP',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:42','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:43 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200241,'N','N','MMM',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:43','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:44 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200242,'N','N','MMI',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:43','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:44 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200243,'N','N','ARF',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:44','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:45 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200244,'N','N','CMB',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:44','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:45 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200245,'N','N','API',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:45','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:46 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200246,'N','N','APC',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:45','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:46 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200247,'N','N','GLJ',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:46','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:46 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200248,'N','N','ARI',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:46','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:47 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200249,'N','N','ARC',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:46','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:47 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200250,'N','N','ARR',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:47','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:48 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200251,'N','N','APP',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:47','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:48 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200252,'N','N','POR',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:48','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:49 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200253,'N','N','SOO',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:48','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:49 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200254,'N','N','POO',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:49','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:49 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200255,'N','N','HRP',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:49','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:50 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200256,'N','N','MOP',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:49','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:50 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200257,'N','N','MOF',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:50','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:50','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:51 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200258,'N','N','MQO',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:50','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:50','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:51 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200259,'N','N','DOO',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:51','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:52 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200260,'N','N','MCC',200008,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:51','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:52 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200009,200000,'S',10,TO_TIMESTAMP('2012-10-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-10-31','YYYY-MM-DD'),'Oct-12',0,TO_TIMESTAMP('2012-02-04 21:31:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:31:52','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:31:52 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200261,'N','N','MMR',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:52','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:53 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200262,'N','N','MMS',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:52','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:54 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200263,'N','N','PJI',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:53','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:53','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:54 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200264,'N','N','CMA',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:54','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:54 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200265,'N','N','MXI',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:54','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:55 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200266,'N','N','MMP',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:54','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:55 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200267,'N','N','GLD',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:55','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:56 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200268,'N','N','CMC',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:55','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:56 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200269,'N','N','MXP',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:56','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:57 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200270,'N','N','MMM',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:56','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:57 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200271,'N','N','MMI',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:57','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:57 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200272,'N','N','ARF',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:57','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:58 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200273,'N','N','CMB',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:57','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:58 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200274,'N','N','API',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:58','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:59 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200275,'N','N','APC',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:58','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:31:59 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200276,'N','N','GLJ',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:59','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:00 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200277,'N','N','ARI',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:31:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:31:59','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:00 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200278,'N','N','ARC',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:00','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:00 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200279,'N','N','ARR',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:00','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:01 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200280,'N','N','APP',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:00','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:01 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200281,'N','N','POR',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:01','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:02 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200282,'N','N','SOO',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:01','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:02 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200283,'N','N','POO',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:02','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:03 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200284,'N','N','HRP',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:02','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:03 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200285,'N','N','MOP',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:03','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:03 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200286,'N','N','MOF',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:03','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:04 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200287,'N','N','MQO',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:03','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:04 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200288,'N','N','DOO',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:04','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:05 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200289,'N','N','MCC',200009,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:04','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:05 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200010,200000,'S',11,TO_TIMESTAMP('2012-11-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-11-30','YYYY-MM-DD'),'Nov-12',0,TO_TIMESTAMP('2012-02-04 21:32:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:32:05','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:32:06 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200290,'N','N','MMR',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:05','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:06 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200291,'N','N','MMS',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:06','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:07 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200292,'N','N','PJI',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:06','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:07 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200293,'N','N','CMA',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:07','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:07 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200294,'N','N','MXI',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:07','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:08 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200295,'N','N','MMP',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:07','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:08 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200296,'N','N','GLD',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:08','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:09 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200297,'N','N','CMC',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:08','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:09 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200298,'N','N','MXP',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:09','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:10 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200299,'N','N','MMM',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:09','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:10 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200300,'N','N','MMI',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:10','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:11 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200301,'N','N','ARF',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:10','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:11 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200302,'N','N','CMB',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:11','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:11 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200303,'N','N','API',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:11','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:12 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200304,'N','N','APC',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:11','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:12 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200305,'N','N','GLJ',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:12','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:13 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200306,'N','N','ARI',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:12','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:13 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200307,'N','N','ARC',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:13','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:14 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200308,'N','N','ARR',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:13','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:14 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200309,'N','N','APP',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:14','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:15 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200310,'N','N','POR',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:14','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:15 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200311,'N','N','SOO',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:15','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:15 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200312,'N','N','POO',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:15','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:16 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200313,'N','N','HRP',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:15','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:16 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200314,'N','N','MOP',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:16','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:17 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200315,'N','N','MOF',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:16','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:17 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200316,'N','N','MQO',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:17','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:18 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200317,'N','N','DOO',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:17','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:18 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200318,'N','N','MCC',200010,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:18','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:19 PM COT
INSERT INTO C_Period (C_Period_ID,C_Year_ID,PeriodType,PeriodNo,StartDate,EndDate,Name,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,Processing,AD_Client_ID) VALUES (200011,200000,'S',12,TO_TIMESTAMP('2012-12-01','YYYY-MM-DD'),TO_TIMESTAMP('2012-12-31','YYYY-MM-DD'),'Dec-12',0,TO_TIMESTAMP('2012-02-04 21:32:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-02-04 21:32:18','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',11)
;

-- Feb 4, 2012 9:32:19 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200319,'N','N','MMR',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:19','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:19 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200320,'N','N','MMS',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:19','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:20 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200321,'N','N','PJI',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:19','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:20 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200322,'N','N','CMA',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:20','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:20','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:21 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200323,'N','N','MXI',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:20','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:20','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:21 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200324,'N','N','MMP',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:21','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:22 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200325,'N','N','GLD',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:21','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:22 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200326,'N','N','CMC',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:22','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:22 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200327,'N','N','MXP',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:22','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:23 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200328,'N','N','MMM',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:22','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:22','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:23 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200329,'N','N','MMI',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:23','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:24 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200330,'N','N','ARF',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:23','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:24 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200331,'N','N','CMB',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:24','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200332,'N','N','API',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:24','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200333,'N','N','APC',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:25','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:25 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200334,'N','N','GLJ',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:25','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:26 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200335,'N','N','ARI',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:25','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:26 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200336,'N','N','ARC',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:26','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:27 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200337,'N','N','ARR',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:26','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:27 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200338,'N','N','APP',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:27','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200339,'N','N','POR',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:27','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200340,'N','N','SOO',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:28 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200341,'N','N','POO',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:29 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200342,'N','N','HRP',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:28','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:29 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200343,'N','N','MOP',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:29','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:30 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200344,'N','N','MOF',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:29','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:30 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200345,'N','N','MQO',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:30','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:31 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200346,'N','N','DOO',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:30','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

-- Feb 4, 2012 9:32:31 PM COT
INSERT INTO C_PeriodControl (C_PeriodControl_ID,PeriodAction,PeriodStatus,DocBaseType,C_Period_ID,AD_Org_ID,Processing,IsActive,Created,Updated,UpdatedBy,CreatedBy,AD_Client_ID) VALUES (200347,'N','N','MCC',200011,0,'N','Y',TO_TIMESTAMP('2012-02-04 21:32:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-02-04 21:32:31','YYYY-MM-DD HH24:MI:SS'),100,100,11)
;

