SET SQLBLANKLINES ON
SET DEFINE OFF

-- Generate year 2017 in GardenWorld calendar
-- Oct 29, 2016 11:50:25 AM CEST
INSERT INTO C_Year (C_Year_ID,AD_Client_ID,AD_Org_ID,IsActive,CreatedBy,Created,UpdatedBy,FiscalYear,Updated,C_Calendar_ID,Processing,C_Year_UU) VALUES (200005,11,0,'Y',100,TO_DATE('2016-10-29 11:50:25','YYYY-MM-DD HH24:MI:SS'),100,'2017',TO_DATE('2016-10-29 11:50:25','YYYY-MM-DD HH24:MI:SS'),102,'N','a3aa647b-8404-421f-bbe6-68124c9a6d30')
;

-- Oct 29, 2016 11:50:37 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Jan-17',TO_DATE('2017-01-01','YYYY-MM-DD'),200060,11,0,'Y',TO_DATE('2016-10-29 11:50:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:36','YYYY-MM-DD HH24:MI:SS'),100,1,200005,'S',TO_DATE('2017-01-31','YYYY-MM-DD'),'N','daa1151d-9edd-49e2-bfde-fd519ec650d7')
;

-- Oct 29, 2016 11:50:37 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201848,11,0,'Y',TO_DATE('2016-10-29 11:50:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:37','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MMS','223d6d96-af3e-4f36-8cf2-a41e5711526a')
;

-- Oct 29, 2016 11:50:37 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201849,11,0,'Y',TO_DATE('2016-10-29 11:50:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:37','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','PJI','8fa58f6e-6e06-40ae-99f7-d1b8c99279aa')
;

-- Oct 29, 2016 11:50:38 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201850,11,0,'Y',TO_DATE('2016-10-29 11:50:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:37','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MXI','08b924cb-493c-460e-bed6-ee2cf9351a6b')
;

-- Oct 29, 2016 11:50:38 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201851,11,0,'Y',TO_DATE('2016-10-29 11:50:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:38','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MMP','05a4e1f2-4be1-45e5-bcc2-cbbe3ec574f2')
;

-- Oct 29, 2016 11:50:39 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201852,11,0,'Y',TO_DATE('2016-10-29 11:50:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:38','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','GLD','e0f55563-711e-4bd3-8c13-99fbc3addddf')
;

-- Oct 29, 2016 11:50:39 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201853,11,0,'Y',TO_DATE('2016-10-29 11:50:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:39','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','CMC','975fdb05-03bf-435c-862a-7c6e0bedb244')
;

-- Oct 29, 2016 11:50:39 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201854,11,0,'Y',TO_DATE('2016-10-29 11:50:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:39','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MXP','4a6c25f6-0744-42fe-834c-a9b101a2997c')
;

-- Oct 29, 2016 11:50:40 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201855,11,0,'Y',TO_DATE('2016-10-29 11:50:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:39','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','ARF','4358d03a-dcc2-4ecb-917a-d886f1d46548')
;

-- Oct 29, 2016 11:50:40 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201856,11,0,'Y',TO_DATE('2016-10-29 11:50:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:40','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','CMB','735f78fa-d7b6-401f-8dd3-aaff9898da38')
;

-- Oct 29, 2016 11:50:41 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201857,11,0,'Y',TO_DATE('2016-10-29 11:50:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:40','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','API','dd486985-fea7-48bc-83d5-ff5c96fa0058')
;

-- Oct 29, 2016 11:50:41 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201858,11,0,'Y',TO_DATE('2016-10-29 11:50:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:41','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','APC','437fbd96-ab1e-4530-8558-2cae2b38fd3c')
;

-- Oct 29, 2016 11:50:41 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201859,11,0,'Y',TO_DATE('2016-10-29 11:50:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:41','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','GLJ','bb0b6c11-cba7-425c-8baa-459f040c3ed4')
;

-- Oct 29, 2016 11:50:42 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201860,11,0,'Y',TO_DATE('2016-10-29 11:50:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:41','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','ARI','35e5c823-bc6d-4897-a8b6-22bd6eea2717')
;

-- Oct 29, 2016 11:50:42 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201861,11,0,'Y',TO_DATE('2016-10-29 11:50:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:42','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','ARC','82c26c6c-141e-495c-af8a-5de9e62c2a21')
;

-- Oct 29, 2016 11:50:42 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201862,11,0,'Y',TO_DATE('2016-10-29 11:50:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:42','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','ARR','e4a77daa-2129-4e30-b495-7f6ca3b89910')
;

-- Oct 29, 2016 11:50:43 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201863,11,0,'Y',TO_DATE('2016-10-29 11:50:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:42','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','APP','6a0d6f54-79d7-450e-be05-4171468e9efc')
;

-- Oct 29, 2016 11:50:43 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201864,11,0,'Y',TO_DATE('2016-10-29 11:50:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:43','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','SOO','9c65d2af-57a0-4660-a7ff-baa4a8ef3abb')
;

-- Oct 29, 2016 11:50:43 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201865,11,0,'Y',TO_DATE('2016-10-29 11:50:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:43','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','POO','5b5bfc01-c64f-41c5-a732-1e98c8bd5d2c')
;

-- Oct 29, 2016 11:50:44 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201866,11,0,'Y',TO_DATE('2016-10-29 11:50:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:43','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','HRP','3959354b-b95c-44dc-902e-5cf8532fbc71')
;

-- Oct 29, 2016 11:50:44 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201867,11,0,'Y',TO_DATE('2016-10-29 11:50:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:44','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MOP','fe8180c5-4af2-4e5c-a52e-a50b4785bbbd')
;

-- Oct 29, 2016 11:50:45 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201868,11,0,'Y',TO_DATE('2016-10-29 11:50:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:44','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MMR','5a1d5769-c767-4b11-84f6-94cdf65b9b97')
;

-- Oct 29, 2016 11:50:45 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201869,11,0,'Y',TO_DATE('2016-10-29 11:50:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:45','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MQO','ab0c0896-8eaa-4ee8-91f5-56b4d1c46195')
;

-- Oct 29, 2016 11:50:45 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201870,11,0,'Y',TO_DATE('2016-10-29 11:50:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:45','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','DOO','ebb0abb1-9543-4998-bde7-388f6a926911')
;

-- Oct 29, 2016 11:50:46 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201871,11,0,'Y',TO_DATE('2016-10-29 11:50:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:45','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','CMA','babf5006-57c4-4eeb-8b62-61d61ac61a90')
;

-- Oct 29, 2016 11:50:46 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201872,11,0,'Y',TO_DATE('2016-10-29 11:50:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:46','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MMM','01397e3a-b542-4281-b54e-92718b7c9902')
;

-- Oct 29, 2016 11:50:46 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201873,11,0,'Y',TO_DATE('2016-10-29 11:50:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:46','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','POR','f9c02cb3-5ccd-4b6c-b843-2d775cf84f4a')
;

-- Oct 29, 2016 11:50:47 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201874,11,0,'Y',TO_DATE('2016-10-29 11:50:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:46','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MOF','64464e15-d6d3-402e-b527-69d4ce07e11d')
;

-- Oct 29, 2016 11:50:47 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201875,11,0,'Y',TO_DATE('2016-10-29 11:50:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:47','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MCC','6d8a8c91-0c57-464b-85e2-c2fdd9e359e8')
;

-- Oct 29, 2016 11:50:48 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201876,11,0,'Y',TO_DATE('2016-10-29 11:50:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:47','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','MMI','87ab167b-365b-46eb-9438-c7fcc777de4f')
;

-- Oct 29, 2016 11:50:48 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201877,11,0,'Y',TO_DATE('2016-10-29 11:50:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:48','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','FAA','99b9ff65-f88e-4bbe-9c6f-936bf39c8484')
;

-- Oct 29, 2016 11:50:48 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201878,11,0,'Y',TO_DATE('2016-10-29 11:50:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:48','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','FDP','99bc09bb-028b-46d6-8328-52344ba3bd60')
;

-- Oct 29, 2016 11:50:49 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201879,11,0,'Y',TO_DATE('2016-10-29 11:50:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:48','YYYY-MM-DD HH24:MI:SS'),100,200060,'N','N','N','FAD','8a13584a-6ee1-4283-9fd8-2405269bc439')
;

-- Oct 29, 2016 11:50:49 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Feb-17',TO_DATE('2017-02-01','YYYY-MM-DD'),200061,11,0,'Y',TO_DATE('2016-10-29 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,2,200005,'S',TO_DATE('2017-02-28','YYYY-MM-DD'),'N','4cb39124-3669-4ba8-86d5-297642e768c3')
;

-- Oct 29, 2016 11:50:49 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201880,11,0,'Y',TO_DATE('2016-10-29 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MMS','727fb64c-1db7-43de-92b5-61fad7d720d8')
;

-- Oct 29, 2016 11:50:50 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201881,11,0,'Y',TO_DATE('2016-10-29 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:49','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','PJI','dd071378-eba6-4d54-80c4-132e7e38c0df')
;

-- Oct 29, 2016 11:50:50 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201882,11,0,'Y',TO_DATE('2016-10-29 11:50:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:50','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MXI','dac8dfc9-dd97-401c-96d6-5fd548177476')
;

-- Oct 29, 2016 11:50:51 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201883,11,0,'Y',TO_DATE('2016-10-29 11:50:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:50','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MMP','6df73e58-d82a-44ef-996c-37f80107fd97')
;

-- Oct 29, 2016 11:50:51 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201884,11,0,'Y',TO_DATE('2016-10-29 11:50:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:51','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','GLD','791458db-76be-46e0-942a-dca38dbbbeb6')
;

-- Oct 29, 2016 11:50:51 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201885,11,0,'Y',TO_DATE('2016-10-29 11:50:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:51','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','CMC','7681c539-a57a-48e4-8476-b1aedf8cd236')
;

-- Oct 29, 2016 11:50:52 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201886,11,0,'Y',TO_DATE('2016-10-29 11:50:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:51','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MXP','82a35cba-8243-4ab1-b7a1-b3f9c8382b6d')
;

-- Oct 29, 2016 11:50:52 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201887,11,0,'Y',TO_DATE('2016-10-29 11:50:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:52','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','ARF','d2a98036-88b2-483d-bd5b-b191b8e9b61c')
;

-- Oct 29, 2016 11:50:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201888,11,0,'Y',TO_DATE('2016-10-29 11:50:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:52','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','CMB','4084883e-29c7-4aaa-9369-c8f07d82ced5')
;

-- Oct 29, 2016 11:50:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201889,11,0,'Y',TO_DATE('2016-10-29 11:50:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:53','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','API','5f91af47-2e6a-4703-a6a0-28b7f29b40ab')
;

-- Oct 29, 2016 11:50:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201890,11,0,'Y',TO_DATE('2016-10-29 11:50:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:53','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','APC','e0ad09d8-4c3a-4c1e-a45e-bd90ce528527')
;

-- Oct 29, 2016 11:50:54 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201891,11,0,'Y',TO_DATE('2016-10-29 11:50:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:53','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','GLJ','1bdc53b2-37c3-41df-bd88-be3f7ca6c38a')
;

-- Oct 29, 2016 11:50:54 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201892,11,0,'Y',TO_DATE('2016-10-29 11:50:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:54','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','ARI','3a95fd20-912f-4a2e-8d59-26e4c955581d')
;

-- Oct 29, 2016 11:50:54 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201893,11,0,'Y',TO_DATE('2016-10-29 11:50:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:54','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','ARC','e34846fc-e465-4855-adbd-c9abe3818764')
;

-- Oct 29, 2016 11:50:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201894,11,0,'Y',TO_DATE('2016-10-29 11:50:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:54','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','ARR','55b7f969-617c-4f9b-a172-c6822b91482d')
;

-- Oct 29, 2016 11:50:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201895,11,0,'Y',TO_DATE('2016-10-29 11:50:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:55','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','APP','71a5e560-9c4f-46d6-a4ce-dda66fc92f05')
;

-- Oct 29, 2016 11:50:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201896,11,0,'Y',TO_DATE('2016-10-29 11:50:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:55','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','SOO','9e1913cb-1ad8-4526-a6f9-7947ad20e64e')
;

-- Oct 29, 2016 11:50:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201897,11,0,'Y',TO_DATE('2016-10-29 11:50:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:55','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','POO','9778b9a0-9da2-46f2-8cd2-c93b4d702ad1')
;

-- Oct 29, 2016 11:50:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201898,11,0,'Y',TO_DATE('2016-10-29 11:50:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:56','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','HRP','f89f9ef5-96d6-4621-bfac-3f838f32dbc1')
;

-- Oct 29, 2016 11:50:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201899,11,0,'Y',TO_DATE('2016-10-29 11:50:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:56','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MOP','24590486-85c4-4695-9ed7-705b4c08f2a1')
;

-- Oct 29, 2016 11:50:57 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201900,11,0,'Y',TO_DATE('2016-10-29 11:50:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:56','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MMR','0fdde152-683e-45c3-81d2-bd79bac7ff10')
;

-- Oct 29, 2016 11:50:57 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201901,11,0,'Y',TO_DATE('2016-10-29 11:50:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:57','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MQO','960c94c5-d685-4fad-b093-91f77ef35d80')
;

-- Oct 29, 2016 11:50:58 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201902,11,0,'Y',TO_DATE('2016-10-29 11:50:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:57','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','DOO','f797d773-27ba-4031-9835-9a8f65dc675f')
;

-- Oct 29, 2016 11:50:58 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201903,11,0,'Y',TO_DATE('2016-10-29 11:50:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:58','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','CMA','ca38725c-794f-4869-8b59-87e725c9977e')
;

-- Oct 29, 2016 11:50:58 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201904,11,0,'Y',TO_DATE('2016-10-29 11:50:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:58','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MMM','39227e86-6255-4d7c-ae59-2e30b04ead67')
;

-- Oct 29, 2016 11:50:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201905,11,0,'Y',TO_DATE('2016-10-29 11:50:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:58','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','POR','1304eb18-0492-4965-b9ed-8d227ed1bcda')
;

-- Oct 29, 2016 11:50:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201906,11,0,'Y',TO_DATE('2016-10-29 11:50:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:59','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MOF','73cbd04e-014e-49e7-8cb5-8ba8d6def591')
;

-- Oct 29, 2016 11:50:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201907,11,0,'Y',TO_DATE('2016-10-29 11:50:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:59','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MCC','6720255e-1e11-493a-ae7b-c595b140dd41')
;

-- Oct 29, 2016 11:51:00 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201908,11,0,'Y',TO_DATE('2016-10-29 11:50:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:50:59','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','MMI','2a94e97c-298a-4252-9cbb-fb1bcd2efb51')
;

-- Oct 29, 2016 11:51:00 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201909,11,0,'Y',TO_DATE('2016-10-29 11:51:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:00','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','FAA','699c7d3a-6ccf-4663-bd0a-8b53e7659d96')
;

-- Oct 29, 2016 11:51:01 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201910,11,0,'Y',TO_DATE('2016-10-29 11:51:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:00','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','FDP','adc8decb-03a8-426f-b1da-9f5d5d458035')
;

-- Oct 29, 2016 11:51:01 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201911,11,0,'Y',TO_DATE('2016-10-29 11:51:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:01','YYYY-MM-DD HH24:MI:SS'),100,200061,'N','N','N','FAD','3f744378-a4ac-48ba-9ee2-c6bdd4ad13cc')
;

-- Oct 29, 2016 11:51:01 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Mar-17',TO_DATE('2017-03-01','YYYY-MM-DD'),200062,11,0,'Y',TO_DATE('2016-10-29 11:51:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:01','YYYY-MM-DD HH24:MI:SS'),100,3,200005,'S',TO_DATE('2017-03-31','YYYY-MM-DD'),'N','164bbedc-7f45-4f16-853e-409fef6baae9')
;

-- Oct 29, 2016 11:51:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201912,11,0,'Y',TO_DATE('2016-10-29 11:51:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:01','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MMS','76d40f11-8575-40db-a69c-ffe4ebd78aba')
;

-- Oct 29, 2016 11:51:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201913,11,0,'Y',TO_DATE('2016-10-29 11:51:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:02','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','PJI','07db6299-5e76-4ed2-af90-58f1c8f2f4ae')
;

-- Oct 29, 2016 11:51:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201914,11,0,'Y',TO_DATE('2016-10-29 11:51:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:02','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MXI','9cccf2f4-6f3f-4081-837b-aec0c473b8db')
;

-- Oct 29, 2016 11:51:03 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201915,11,0,'Y',TO_DATE('2016-10-29 11:51:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:02','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MMP','9a87a30c-21b4-4502-b655-4c50c4c6a99f')
;

-- Oct 29, 2016 11:51:03 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201916,11,0,'Y',TO_DATE('2016-10-29 11:51:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:03','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','GLD','6b3f2a61-20a3-4213-be82-6b2afae3501b')
;

-- Oct 29, 2016 11:51:03 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201917,11,0,'Y',TO_DATE('2016-10-29 11:51:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:03','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','CMC','496f57aa-7ee3-43dd-a868-4d50c21206a0')
;

-- Oct 29, 2016 11:51:04 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201918,11,0,'Y',TO_DATE('2016-10-29 11:51:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:03','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MXP','ad7cd233-9890-4998-84e8-dec0efed0578')
;

-- Oct 29, 2016 11:51:04 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201919,11,0,'Y',TO_DATE('2016-10-29 11:51:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:04','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','ARF','915ca796-3617-460a-b053-cc13bdd5ac0d')
;

-- Oct 29, 2016 11:51:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201920,11,0,'Y',TO_DATE('2016-10-29 11:51:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:04','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','CMB','155c011b-11a7-4a88-bede-1da68fb4316d')
;

-- Oct 29, 2016 11:51:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201921,11,0,'Y',TO_DATE('2016-10-29 11:51:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:05','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','API','9473ae15-ea56-44aa-b6d8-c20048550e44')
;

-- Oct 29, 2016 11:51:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201922,11,0,'Y',TO_DATE('2016-10-29 11:51:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:05','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','APC','f1a60139-4b8c-4827-a040-c49bd8a82be1')
;

-- Oct 29, 2016 11:51:06 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201923,11,0,'Y',TO_DATE('2016-10-29 11:51:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:05','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','GLJ','ee998709-da3a-4860-8094-1e024dc7ae08')
;

-- Oct 29, 2016 11:51:10 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201924,11,0,'Y',TO_DATE('2016-10-29 11:51:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:06','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','ARI','dd7b5bc5-a7fe-44c8-928e-d762762cac38')
;

-- Oct 29, 2016 11:51:10 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201925,11,0,'Y',TO_DATE('2016-10-29 11:51:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:10','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','ARC','2d21588b-9c46-4cfb-bb7b-61f3b8d76835')
;

-- Oct 29, 2016 11:51:11 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201926,11,0,'Y',TO_DATE('2016-10-29 11:51:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:10','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','ARR','62c9f4b3-3898-4703-9903-de8de25d20e9')
;

-- Oct 29, 2016 11:51:11 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201927,11,0,'Y',TO_DATE('2016-10-29 11:51:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:11','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','APP','3d28f96a-bd85-48b4-a6eb-bf6ae2391cb4')
;

-- Oct 29, 2016 11:51:11 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201928,11,0,'Y',TO_DATE('2016-10-29 11:51:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:11','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','SOO','e54f26bc-1c2d-44a9-b790-4e9a85253e6a')
;

-- Oct 29, 2016 11:51:12 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201929,11,0,'Y',TO_DATE('2016-10-29 11:51:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:11','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','POO','8412cb1c-17e4-409f-9dfb-933375fcea03')
;

-- Oct 29, 2016 11:51:12 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201930,11,0,'Y',TO_DATE('2016-10-29 11:51:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:12','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','HRP','eea23ea1-a2de-4952-a9fc-518b0acafd75')
;

-- Oct 29, 2016 11:51:13 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201931,11,0,'Y',TO_DATE('2016-10-29 11:51:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:12','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MOP','8cf0da15-49bb-4758-9f96-3628799126d1')
;

-- Oct 29, 2016 11:51:13 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201932,11,0,'Y',TO_DATE('2016-10-29 11:51:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:13','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MMR','f5fd3a61-bde3-4206-846a-9c63dbddbeef')
;

-- Oct 29, 2016 11:51:13 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201933,11,0,'Y',TO_DATE('2016-10-29 11:51:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:13','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MQO','72331771-eeae-4c34-805b-b59d4f5388c1')
;

-- Oct 29, 2016 11:51:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201934,11,0,'Y',TO_DATE('2016-10-29 11:51:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:13','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','DOO','8b054c4c-ddc7-4d32-b120-12af4f535929')
;

-- Oct 29, 2016 11:51:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201935,11,0,'Y',TO_DATE('2016-10-29 11:51:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:14','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','CMA','b3f99789-0124-4bce-9715-46c660b04f32')
;

-- Oct 29, 2016 11:51:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201936,11,0,'Y',TO_DATE('2016-10-29 11:51:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:14','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MMM','12f5f828-5911-4b50-bcee-bcaecdf48649')
;

-- Oct 29, 2016 11:51:15 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201937,11,0,'Y',TO_DATE('2016-10-29 11:51:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:14','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','POR','4a56760f-3593-4546-9358-36cc688ec4cb')
;

-- Oct 29, 2016 11:51:15 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201938,11,0,'Y',TO_DATE('2016-10-29 11:51:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:15','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MOF','db59509e-182c-4e50-b8c8-035c25dfd6e9')
;

-- Oct 29, 2016 11:51:16 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201939,11,0,'Y',TO_DATE('2016-10-29 11:51:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:15','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MCC','1066a6d3-1723-4020-bf08-c5ee7a5c8f4c')
;

-- Oct 29, 2016 11:51:16 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201940,11,0,'Y',TO_DATE('2016-10-29 11:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:16','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','MMI','8e07009f-20fd-4228-83ea-79c031e9ab1d')
;

-- Oct 29, 2016 11:51:16 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201941,11,0,'Y',TO_DATE('2016-10-29 11:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:16','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','FAA','252f0f27-36ce-48c8-a9bf-2e03311bfad1')
;

-- Oct 29, 2016 11:51:17 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201942,11,0,'Y',TO_DATE('2016-10-29 11:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:16','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','FDP','934c0025-0a49-4153-b778-dcd7a1d939cf')
;

-- Oct 29, 2016 11:51:17 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201943,11,0,'Y',TO_DATE('2016-10-29 11:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:17','YYYY-MM-DD HH24:MI:SS'),100,200062,'N','N','N','FAD','aa24f1d2-d0fc-4f2a-a341-ac8dc0504107')
;

-- Oct 29, 2016 11:51:18 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Apr-17',TO_DATE('2017-04-01','YYYY-MM-DD'),200063,11,0,'Y',TO_DATE('2016-10-29 11:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:17','YYYY-MM-DD HH24:MI:SS'),100,4,200005,'S',TO_DATE('2017-04-30','YYYY-MM-DD'),'N','64a9ddd7-d22b-4ede-9bfd-452c28daed38')
;

-- Oct 29, 2016 11:51:18 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201944,11,0,'Y',TO_DATE('2016-10-29 11:51:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:18','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MMS','ab01ca6b-bbdf-46f8-84de-07f5387bf3d2')
;

-- Oct 29, 2016 11:51:18 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201945,11,0,'Y',TO_DATE('2016-10-29 11:51:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:18','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','PJI','0116251a-551d-4bb0-9804-d1972cc0f0ae')
;

-- Oct 29, 2016 11:51:19 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201946,11,0,'Y',TO_DATE('2016-10-29 11:51:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:18','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MXI','b7e979b5-cd86-43db-8f15-1e50524c61a0')
;

-- Oct 29, 2016 11:51:19 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201947,11,0,'Y',TO_DATE('2016-10-29 11:51:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:19','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MMP','29161bfa-32a7-41e7-8a8d-890eef4d58a5')
;

-- Oct 29, 2016 11:51:20 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201948,11,0,'Y',TO_DATE('2016-10-29 11:51:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:19','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','GLD','7e245fbd-7f96-447a-a6a3-1436257fb731')
;

-- Oct 29, 2016 11:51:20 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201949,11,0,'Y',TO_DATE('2016-10-29 11:51:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:20','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','CMC','a82dfcb0-db1b-4637-8970-d60e5f2d76b2')
;

-- Oct 29, 2016 11:51:20 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201950,11,0,'Y',TO_DATE('2016-10-29 11:51:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:20','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MXP','6c43e6f9-8484-4c06-a372-fbcd08a2e889')
;

-- Oct 29, 2016 11:51:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201951,11,0,'Y',TO_DATE('2016-10-29 11:51:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:20','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','ARF','3fbe808a-2e2e-4a8f-907a-ee62db1da171')
;

-- Oct 29, 2016 11:51:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201952,11,0,'Y',TO_DATE('2016-10-29 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','CMB','da40ea65-6f6d-4c13-8be8-2e09c267fdbc')
;

-- Oct 29, 2016 11:51:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201953,11,0,'Y',TO_DATE('2016-10-29 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','API','e0392683-09a5-4f70-a5b1-7c706b965010')
;

-- Oct 29, 2016 11:51:22 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201954,11,0,'Y',TO_DATE('2016-10-29 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:21','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','APC','3879cee7-d91d-42be-b3bf-140af12773a2')
;

-- Oct 29, 2016 11:51:22 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201955,11,0,'Y',TO_DATE('2016-10-29 11:51:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:22','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','GLJ','f1ab9063-0659-4d1c-9cb4-8396d34cc3ac')
;

-- Oct 29, 2016 11:51:23 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201956,11,0,'Y',TO_DATE('2016-10-29 11:51:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:22','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','ARI','f017914a-4057-4f79-a18d-79caf9711b8b')
;

-- Oct 29, 2016 11:51:23 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201957,11,0,'Y',TO_DATE('2016-10-29 11:51:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:23','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','ARC','74db4a0c-b77c-4f07-8ee7-604b0fc0f908')
;

-- Oct 29, 2016 11:51:27 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201958,11,0,'Y',TO_DATE('2016-10-29 11:51:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:23','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','ARR','408bacac-2169-4b67-8606-8a9183cf8e82')
;

-- Oct 29, 2016 11:51:27 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201959,11,0,'Y',TO_DATE('2016-10-29 11:51:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:27','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','APP','205dde6f-f46c-4af1-80bd-1a1f6fecff08')
;

-- Oct 29, 2016 11:51:28 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201960,11,0,'Y',TO_DATE('2016-10-29 11:51:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:27','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','SOO','24487961-4622-4d85-b36a-f569c5d50160')
;

-- Oct 29, 2016 11:51:28 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201961,11,0,'Y',TO_DATE('2016-10-29 11:51:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:28','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','POO','12f1672c-dc59-47d4-80fe-adee5a1b501c')
;

-- Oct 29, 2016 11:51:28 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201962,11,0,'Y',TO_DATE('2016-10-29 11:51:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:28','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','HRP','94d0872a-5ac0-42fd-95c0-34bfbac94c9e')
;

-- Oct 29, 2016 11:51:29 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201963,11,0,'Y',TO_DATE('2016-10-29 11:51:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:28','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MOP','ecfd658e-2f8a-4b11-a14a-8ee5bd77125b')
;

-- Oct 29, 2016 11:51:29 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201964,11,0,'Y',TO_DATE('2016-10-29 11:51:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:29','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MMR','ada26c23-00ab-46de-bb58-69ebb7ee1073')
;

-- Oct 29, 2016 11:51:29 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201965,11,0,'Y',TO_DATE('2016-10-29 11:51:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:29','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MQO','ac034ecd-f74c-40b1-9dc1-7e41639de2ed')
;

-- Oct 29, 2016 11:51:30 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201966,11,0,'Y',TO_DATE('2016-10-29 11:51:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:29','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','DOO','7a4ade9b-6dd0-40b3-8a3b-0549fcf52e7c')
;

-- Oct 29, 2016 11:51:30 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201967,11,0,'Y',TO_DATE('2016-10-29 11:51:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:30','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','CMA','5c55ad3b-a872-45eb-9a54-11fef060d6e2')
;

-- Oct 29, 2016 11:51:30 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201968,11,0,'Y',TO_DATE('2016-10-29 11:51:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:30','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MMM','dd398e6c-7844-46fa-b43a-d9d36593c3b5')
;

-- Oct 29, 2016 11:51:31 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201969,11,0,'Y',TO_DATE('2016-10-29 11:51:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:30','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','POR','313dbab6-9e8a-4e78-a807-6df69cb27d58')
;

-- Oct 29, 2016 11:51:31 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201970,11,0,'Y',TO_DATE('2016-10-29 11:51:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:31','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MOF','865ca92f-64f6-41c1-8471-8f8398e0ff63')
;

-- Oct 29, 2016 11:51:32 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201971,11,0,'Y',TO_DATE('2016-10-29 11:51:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:31','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MCC','362233cf-1372-478e-9db0-77da8ed975bb')
;

-- Oct 29, 2016 11:51:32 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201972,11,0,'Y',TO_DATE('2016-10-29 11:51:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:32','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','MMI','7a7f3a29-9c17-4893-a407-9d62ae83aca2')
;

-- Oct 29, 2016 11:51:32 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201973,11,0,'Y',TO_DATE('2016-10-29 11:51:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:32','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','FAA','2c6fad30-a569-4347-a4c9-b28c29069cfa')
;

-- Oct 29, 2016 11:51:33 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201974,11,0,'Y',TO_DATE('2016-10-29 11:51:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:32','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','FDP','e77d4b6f-12ef-4980-873e-4d98cfd0c4ce')
;

-- Oct 29, 2016 11:51:33 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201975,11,0,'Y',TO_DATE('2016-10-29 11:51:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:33','YYYY-MM-DD HH24:MI:SS'),100,200063,'N','N','N','FAD','476dbf1b-2159-4283-b2e0-96971aeb6124')
;

-- Oct 29, 2016 11:51:33 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('May-17',TO_DATE('2017-05-01','YYYY-MM-DD'),200064,11,0,'Y',TO_DATE('2016-10-29 11:51:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:33','YYYY-MM-DD HH24:MI:SS'),100,5,200005,'S',TO_DATE('2017-05-31','YYYY-MM-DD'),'N','856dbf6b-03bb-451a-bdd6-df7aa4c5bf73')
;

-- Oct 29, 2016 11:51:34 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201976,11,0,'Y',TO_DATE('2016-10-29 11:51:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:33','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MMS','02030eb0-fe20-4006-8ff5-9c251b19b8ef')
;

-- Oct 29, 2016 11:51:34 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201977,11,0,'Y',TO_DATE('2016-10-29 11:51:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:34','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','PJI','866dd3bc-ef71-473a-b8a6-85cf47125a82')
;

-- Oct 29, 2016 11:51:35 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201978,11,0,'Y',TO_DATE('2016-10-29 11:51:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:34','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MXI','14c1285f-0f34-44e0-b5ca-6d25cd35e903')
;

-- Oct 29, 2016 11:51:35 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201979,11,0,'Y',TO_DATE('2016-10-29 11:51:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:35','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MMP','4aaa0aa3-23ae-497a-8417-b458970cff95')
;

-- Oct 29, 2016 11:51:35 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201980,11,0,'Y',TO_DATE('2016-10-29 11:51:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:35','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','GLD','b9f4259b-a133-40e4-93a3-2354997b5f60')
;

-- Oct 29, 2016 11:51:36 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201981,11,0,'Y',TO_DATE('2016-10-29 11:51:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:35','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','CMC','2909c846-104d-4258-a8a4-3c4b35918125')
;

-- Oct 29, 2016 11:51:36 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201982,11,0,'Y',TO_DATE('2016-10-29 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MXP','57d96bff-872b-4ab3-abc7-f635493fa9de')
;

-- Oct 29, 2016 11:51:36 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201983,11,0,'Y',TO_DATE('2016-10-29 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','ARF','771a288f-df47-4956-b3c9-676bdf6fad22')
;

-- Oct 29, 2016 11:51:37 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201984,11,0,'Y',TO_DATE('2016-10-29 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:36','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','CMB','b758dfcb-4223-45ad-b48f-754fb35cffec')
;

-- Oct 29, 2016 11:51:37 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201985,11,0,'Y',TO_DATE('2016-10-29 11:51:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:37','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','API','21019cad-dea8-46cd-92fc-3a831ea63677')
;

-- Oct 29, 2016 11:51:38 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201986,11,0,'Y',TO_DATE('2016-10-29 11:51:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:37','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','APC','23a69eed-5d31-4b56-becc-d3871ab72a0c')
;

-- Oct 29, 2016 11:51:38 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201987,11,0,'Y',TO_DATE('2016-10-29 11:51:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:38','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','GLJ','395fc092-588d-40ef-ba22-cf8e6d9cccdc')
;

-- Oct 29, 2016 11:51:38 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201988,11,0,'Y',TO_DATE('2016-10-29 11:51:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:38','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','ARI','21cb6d9e-26c6-4f72-b5d0-5bc4e7efae86')
;

-- Oct 29, 2016 11:51:39 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201989,11,0,'Y',TO_DATE('2016-10-29 11:51:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:38','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','ARC','eb1763e3-52e8-4e25-aed0-2283624ae22d')
;

-- Oct 29, 2016 11:51:39 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201990,11,0,'Y',TO_DATE('2016-10-29 11:51:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:39','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','ARR','997167d9-2d2f-4af3-bcb6-e959ea239d7f')
;

-- Oct 29, 2016 11:51:39 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201991,11,0,'Y',TO_DATE('2016-10-29 11:51:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:39','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','APP','1cb3e0f6-87bc-489a-b966-bcf0c2b300ff')
;

-- Oct 29, 2016 11:51:40 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201992,11,0,'Y',TO_DATE('2016-10-29 11:51:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:39','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','SOO','61e965a4-3a61-418b-9098-3976bc87c0ba')
;

-- Oct 29, 2016 11:51:40 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201993,11,0,'Y',TO_DATE('2016-10-29 11:51:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:40','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','POO','3f7e7b77-46d6-4bb3-9ae7-4455b2ca1484')
;

-- Oct 29, 2016 11:51:41 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201994,11,0,'Y',TO_DATE('2016-10-29 11:51:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:40','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','HRP','fe059625-e432-437e-a029-2db6c5d99cd7')
;

-- Oct 29, 2016 11:51:41 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201995,11,0,'Y',TO_DATE('2016-10-29 11:51:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:41','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MOP','4246bed5-adad-42cd-8fec-5304e5f3ec0d')
;

-- Oct 29, 2016 11:51:41 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201996,11,0,'Y',TO_DATE('2016-10-29 11:51:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:41','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MMR','9a9e3114-67c0-447d-9fc2-40f979232043')
;

-- Oct 29, 2016 11:51:42 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201997,11,0,'Y',TO_DATE('2016-10-29 11:51:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:41','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MQO','29f00800-a57d-4561-82f9-70537bdcd10d')
;

-- Oct 29, 2016 11:51:47 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201998,11,0,'Y',TO_DATE('2016-10-29 11:51:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:42','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','DOO','ef882b74-11b2-4162-8e68-907b2d507d67')
;

-- Oct 29, 2016 11:51:48 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (201999,11,0,'Y',TO_DATE('2016-10-29 11:51:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:47','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','CMA','bdd926e5-f495-441b-973e-055de2c6620b')
;

-- Oct 29, 2016 11:51:48 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202000,11,0,'Y',TO_DATE('2016-10-29 11:51:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:48','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MMM','7f287275-2d18-4be7-b5c2-812a8ca89f83')
;

-- Oct 29, 2016 11:51:49 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202001,11,0,'Y',TO_DATE('2016-10-29 11:51:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:48','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','POR','398ce69d-4ebe-4efa-b797-bf0f060711c2')
;

-- Oct 29, 2016 11:51:49 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202002,11,0,'Y',TO_DATE('2016-10-29 11:51:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:49','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MOF','4541aeb3-6cee-417b-b1b5-462506b0cb81')
;

-- Oct 29, 2016 11:51:49 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202003,11,0,'Y',TO_DATE('2016-10-29 11:51:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:49','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MCC','3593bac5-50d7-4cc8-bdbe-27943be245fd')
;

-- Oct 29, 2016 11:51:50 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202004,11,0,'Y',TO_DATE('2016-10-29 11:51:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:49','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','MMI','b7ea73cf-097b-4936-86e0-8bcf85612fea')
;

-- Oct 29, 2016 11:51:50 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202005,11,0,'Y',TO_DATE('2016-10-29 11:51:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:50','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','FAA','24bf13f2-0c93-4ef3-9c3c-2eb3852e1ce3')
;

-- Oct 29, 2016 11:51:50 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202006,11,0,'Y',TO_DATE('2016-10-29 11:51:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:50','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','FDP','8545d1b2-539d-4ae5-832e-d52e8f7b8885')
;

-- Oct 29, 2016 11:51:51 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202007,11,0,'Y',TO_DATE('2016-10-29 11:51:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:50','YYYY-MM-DD HH24:MI:SS'),100,200064,'N','N','N','FAD','2d22dfb5-b806-4767-ab29-74653369e9db')
;

-- Oct 29, 2016 11:51:51 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Jun-17',TO_DATE('2017-06-01','YYYY-MM-DD'),200065,11,0,'Y',TO_DATE('2016-10-29 11:51:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:51','YYYY-MM-DD HH24:MI:SS'),100,6,200005,'S',TO_DATE('2017-06-30','YYYY-MM-DD'),'N','fee8871e-1fc1-4d9f-b2e9-f54ce404e764')
;

-- Oct 29, 2016 11:51:52 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202008,11,0,'Y',TO_DATE('2016-10-29 11:51:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:51','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MMS','beb6f7f3-25f7-4eb6-99c8-9564e50b2124')
;

-- Oct 29, 2016 11:51:52 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202009,11,0,'Y',TO_DATE('2016-10-29 11:51:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:52','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','PJI','d118da5d-7c7d-4cad-9126-a665a49c8348')
;

-- Oct 29, 2016 11:51:52 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202010,11,0,'Y',TO_DATE('2016-10-29 11:51:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:52','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MXI','2262a2b7-050c-4fef-a21c-4bc89cbe78e5')
;

-- Oct 29, 2016 11:51:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202011,11,0,'Y',TO_DATE('2016-10-29 11:51:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:52','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MMP','92103ab3-759c-476c-9099-faa762b4155b')
;

-- Oct 29, 2016 11:51:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202012,11,0,'Y',TO_DATE('2016-10-29 11:51:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:53','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','GLD','e75b8807-9a86-439e-86e6-fed68e16f5f0')
;

-- Oct 29, 2016 11:51:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202013,11,0,'Y',TO_DATE('2016-10-29 11:51:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:53','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','CMC','6c9008a2-ac2c-4c85-b050-36274e5e92cc')
;

-- Oct 29, 2016 11:51:54 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202014,11,0,'Y',TO_DATE('2016-10-29 11:51:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:53','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MXP','b42f8878-3882-4285-97ff-2859f00ba5ad')
;

-- Oct 29, 2016 11:51:54 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202015,11,0,'Y',TO_DATE('2016-10-29 11:51:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:54','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','ARF','4eb53923-fdec-4b6d-997e-885131c529a9')
;

-- Oct 29, 2016 11:51:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202016,11,0,'Y',TO_DATE('2016-10-29 11:51:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:54','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','CMB','9ffaef2d-b7c0-48a8-9fe4-7829b1d6c961')
;

-- Oct 29, 2016 11:51:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202017,11,0,'Y',TO_DATE('2016-10-29 11:51:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:55','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','API','0129b37c-24ba-4b5d-a9e8-21254ca32ef0')
;

-- Oct 29, 2016 11:51:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202018,11,0,'Y',TO_DATE('2016-10-29 11:51:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:55','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','APC','dcd2f947-af62-43b0-8f64-e3c15daf30a4')
;

-- Oct 29, 2016 11:51:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202019,11,0,'Y',TO_DATE('2016-10-29 11:51:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:55','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','GLJ','bf266ac5-f00f-43dc-81df-0aa37a343e1e')
;

-- Oct 29, 2016 11:51:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202020,11,0,'Y',TO_DATE('2016-10-29 11:51:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:56','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','ARI','28c26bf8-5f6d-404b-a79b-adff63de6d7e')
;

-- Oct 29, 2016 11:51:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202021,11,0,'Y',TO_DATE('2016-10-29 11:51:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:56','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','ARC','e4b8abcf-6bfe-4102-8d13-24b6fbfcb4f5')
;

-- Oct 29, 2016 11:51:57 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202022,11,0,'Y',TO_DATE('2016-10-29 11:51:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:56','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','ARR','29af47c0-e8fc-4194-ab61-beabff194266')
;

-- Oct 29, 2016 11:51:57 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202023,11,0,'Y',TO_DATE('2016-10-29 11:51:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:57','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','APP','58a4e407-3369-481f-a4f2-195bf1d8c2e9')
;

-- Oct 29, 2016 11:51:58 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202024,11,0,'Y',TO_DATE('2016-10-29 11:51:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:57','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','SOO','6f753308-8bb2-4b36-960f-6fb7c7f09cc7')
;

-- Oct 29, 2016 11:51:58 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202025,11,0,'Y',TO_DATE('2016-10-29 11:51:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:58','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','POO','ccf5aca6-71ca-4e4a-83c0-42d7f3f954f9')
;

-- Oct 29, 2016 11:51:58 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202026,11,0,'Y',TO_DATE('2016-10-29 11:51:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:58','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','HRP','a821c061-07ff-4e3d-84bf-24cc5a97633e')
;

-- Oct 29, 2016 11:51:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202027,11,0,'Y',TO_DATE('2016-10-29 11:51:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:58','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MOP','e40df66a-96cc-4860-8460-f333401e8653')
;

-- Oct 29, 2016 11:51:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202028,11,0,'Y',TO_DATE('2016-10-29 11:51:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:59','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MMR','9f0b4ebb-c145-4354-931b-8dce594bc878')
;

-- Oct 29, 2016 11:51:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202029,11,0,'Y',TO_DATE('2016-10-29 11:51:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:59','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MQO','9ff1573c-7974-40c7-a2f1-df4c8c47565d')
;

-- Oct 29, 2016 11:52:00 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202030,11,0,'Y',TO_DATE('2016-10-29 11:51:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:51:59','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','DOO','c3d51e20-25ce-4e05-9045-f35c69480fce')
;

-- Oct 29, 2016 11:52:00 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202031,11,0,'Y',TO_DATE('2016-10-29 11:52:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:00','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','CMA','1315589d-0b70-411b-82e8-2912fee18ce8')
;

-- Oct 29, 2016 11:52:01 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202032,11,0,'Y',TO_DATE('2016-10-29 11:52:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:00','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MMM','2824f808-2d80-48fd-90a3-7574c664c5a8')
;

-- Oct 29, 2016 11:52:01 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202033,11,0,'Y',TO_DATE('2016-10-29 11:52:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:01','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','POR','2d6aa39c-e153-4b8f-bee3-d906f57f183a')
;

-- Oct 29, 2016 11:52:01 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202034,11,0,'Y',TO_DATE('2016-10-29 11:52:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:01','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MOF','422317d9-cb0c-462e-a3ad-3c71667c1157')
;

-- Oct 29, 2016 11:52:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202035,11,0,'Y',TO_DATE('2016-10-29 11:52:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:01','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MCC','d71ef337-452d-42b2-80ae-6673c3b82712')
;

-- Oct 29, 2016 11:52:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202036,11,0,'Y',TO_DATE('2016-10-29 11:52:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:02','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','MMI','8df80db7-5835-45ac-b9fb-13ba2e6bfc1b')
;

-- Oct 29, 2016 11:52:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202037,11,0,'Y',TO_DATE('2016-10-29 11:52:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:02','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','FAA','0a9e8171-3418-4449-871b-7c636783cb17')
;

-- Oct 29, 2016 11:52:03 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202038,11,0,'Y',TO_DATE('2016-10-29 11:52:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:02','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','FDP','dca69795-d9ef-46ed-bedd-0bffe1d49ff8')
;

-- Oct 29, 2016 11:52:03 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202039,11,0,'Y',TO_DATE('2016-10-29 11:52:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:03','YYYY-MM-DD HH24:MI:SS'),100,200065,'N','N','N','FAD','9c550ed3-6f85-4f34-8ef7-0e7137974036')
;

-- Oct 29, 2016 11:52:04 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Jul-17',TO_DATE('2017-07-01','YYYY-MM-DD'),200066,11,0,'Y',TO_DATE('2016-10-29 11:52:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:03','YYYY-MM-DD HH24:MI:SS'),100,7,200005,'S',TO_DATE('2017-07-31','YYYY-MM-DD'),'N','7954a48e-3cb5-49d6-9b35-fd906adfa462')
;

-- Oct 29, 2016 11:52:04 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202040,11,0,'Y',TO_DATE('2016-10-29 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MMS','d641b095-c405-4ca3-8cfd-ea4c22cbad6c')
;

-- Oct 29, 2016 11:52:04 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202041,11,0,'Y',TO_DATE('2016-10-29 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','PJI','896b93bf-758d-4ac0-b725-959cdae20b1c')
;

-- Oct 29, 2016 11:52:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202042,11,0,'Y',TO_DATE('2016-10-29 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:04','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MXI','87f1dc15-a3da-4656-ad28-9214ff4cfc0d')
;

-- Oct 29, 2016 11:52:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202043,11,0,'Y',TO_DATE('2016-10-29 11:52:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:05','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MMP','72ce510b-c588-40b4-a311-fb7f1f84e46d')
;

-- Oct 29, 2016 11:52:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202044,11,0,'Y',TO_DATE('2016-10-29 11:52:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:05','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','GLD','779af537-c226-482d-a6bb-f3c965964486')
;

-- Oct 29, 2016 11:52:06 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202045,11,0,'Y',TO_DATE('2016-10-29 11:52:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:05','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','CMC','5bb899fd-1bca-4fd4-b6b2-9a918dbda104')
;

-- Oct 29, 2016 11:52:06 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202046,11,0,'Y',TO_DATE('2016-10-29 11:52:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:06','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MXP','286bfb72-4c1e-4dc6-820a-1de60dbebeac')
;

-- Oct 29, 2016 11:52:07 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202047,11,0,'Y',TO_DATE('2016-10-29 11:52:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:06','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','ARF','5065b815-4a15-4a44-bcb5-6dbae8bad413')
;

-- Oct 29, 2016 11:52:07 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202048,11,0,'Y',TO_DATE('2016-10-29 11:52:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:07','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','CMB','67705145-81b2-4203-944a-641945dbb797')
;

-- Oct 29, 2016 11:52:07 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202049,11,0,'Y',TO_DATE('2016-10-29 11:52:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:07','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','API','735c6527-ce69-493a-af10-5bbc7dac855e')
;

-- Oct 29, 2016 11:52:08 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202050,11,0,'Y',TO_DATE('2016-10-29 11:52:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:07','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','APC','38115877-2382-414d-aedc-83d8da0caa97')
;

-- Oct 29, 2016 11:52:08 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202051,11,0,'Y',TO_DATE('2016-10-29 11:52:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:08','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','GLJ','4898d4d7-d0ca-4c71-bb8b-ccdf15adecc8')
;

-- Oct 29, 2016 11:52:08 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202052,11,0,'Y',TO_DATE('2016-10-29 11:52:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:08','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','ARI','98b800dc-af85-45ee-8dfb-abce0237b603')
;

-- Oct 29, 2016 11:52:09 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202053,11,0,'Y',TO_DATE('2016-10-29 11:52:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:08','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','ARC','55f4cf68-ca33-4819-ba6c-f241414b5f83')
;

-- Oct 29, 2016 11:52:09 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202054,11,0,'Y',TO_DATE('2016-10-29 11:52:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:09','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','ARR','84b562f9-b1bf-49eb-89fa-eabc4dadd0f1')
;

-- Oct 29, 2016 11:52:10 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202055,11,0,'Y',TO_DATE('2016-10-29 11:52:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:09','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','APP','d8b1adfa-661a-4104-a2c6-30dfe2aaec68')
;

-- Oct 29, 2016 11:52:10 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202056,11,0,'Y',TO_DATE('2016-10-29 11:52:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:10','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','SOO','2141c2af-28fd-47d4-958b-283b63142604')
;

-- Oct 29, 2016 11:52:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202057,11,0,'Y',TO_DATE('2016-10-29 11:52:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:10','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','POO','cce2ecfb-81ec-4af4-86d2-0f9157a2c1d3')
;

-- Oct 29, 2016 11:52:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202058,11,0,'Y',TO_DATE('2016-10-29 11:52:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:14','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','HRP','e9cfbc05-32a3-49c8-869a-685b73134f5e')
;

-- Oct 29, 2016 11:52:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202059,11,0,'Y',TO_DATE('2016-10-29 11:52:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:14','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MOP','d695d27d-d890-4548-8bae-42e134b2af64')
;

-- Oct 29, 2016 11:52:15 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202060,11,0,'Y',TO_DATE('2016-10-29 11:52:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:14','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MMR','4a089351-3290-4558-bb30-e64b1342b1ef')
;

-- Oct 29, 2016 11:52:15 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202061,11,0,'Y',TO_DATE('2016-10-29 11:52:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:15','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MQO','96b9831a-348b-48df-8756-bf6ee2aef17f')
;

-- Oct 29, 2016 11:52:15 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202062,11,0,'Y',TO_DATE('2016-10-29 11:52:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:15','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','DOO','552a94b8-0acf-4d98-97ca-09b24175f694')
;

-- Oct 29, 2016 11:52:16 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202063,11,0,'Y',TO_DATE('2016-10-29 11:52:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:15','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','CMA','4804c733-87ac-435a-875d-da5b2c1aed49')
;

-- Oct 29, 2016 11:52:16 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202064,11,0,'Y',TO_DATE('2016-10-29 11:52:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:16','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MMM','a63ec6e8-88e7-4b42-ac52-2fbd0e740da2')
;

-- Oct 29, 2016 11:52:17 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202065,11,0,'Y',TO_DATE('2016-10-29 11:52:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:16','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','POR','8130f858-ca7d-4073-b067-efb3ca376579')
;

-- Oct 29, 2016 11:52:17 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202066,11,0,'Y',TO_DATE('2016-10-29 11:52:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:17','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MOF','bf4aa57c-29ea-45b6-9436-6fa5e94b515f')
;

-- Oct 29, 2016 11:52:17 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202067,11,0,'Y',TO_DATE('2016-10-29 11:52:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:17','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MCC','3ac3d290-13dd-4962-aa42-c473d6ffd588')
;

-- Oct 29, 2016 11:52:18 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202068,11,0,'Y',TO_DATE('2016-10-29 11:52:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:17','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','MMI','4bbb2a65-d9f5-44a1-b58e-7aaa408e7e0d')
;

-- Oct 29, 2016 11:52:18 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202069,11,0,'Y',TO_DATE('2016-10-29 11:52:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:18','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','FAA','333b0fc5-6a84-452c-94b3-3a75b76f275a')
;

-- Oct 29, 2016 11:52:20 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202070,11,0,'Y',TO_DATE('2016-10-29 11:52:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:18','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','FDP','e8385811-4707-4872-a5f5-37417ecd94e6')
;

-- Oct 29, 2016 11:52:20 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202071,11,0,'Y',TO_DATE('2016-10-29 11:52:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:20','YYYY-MM-DD HH24:MI:SS'),100,200066,'N','N','N','FAD','b49a4a0a-e583-47d2-891f-b9e43eca1f13')
;

-- Oct 29, 2016 11:52:20 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Aug-17',TO_DATE('2017-08-01','YYYY-MM-DD'),200067,11,0,'Y',TO_DATE('2016-10-29 11:52:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:20','YYYY-MM-DD HH24:MI:SS'),100,8,200005,'S',TO_DATE('2017-08-31','YYYY-MM-DD'),'N','ef2b52b3-36e2-484e-a1a0-8a2921ea4e72')
;

-- Oct 29, 2016 11:52:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202072,11,0,'Y',TO_DATE('2016-10-29 11:52:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:20','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MMS','ea027bde-e294-4c14-947b-2d1b5b4485fe')
;

-- Oct 29, 2016 11:52:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202073,11,0,'Y',TO_DATE('2016-10-29 11:52:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:21','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','PJI','4c2dcd79-9afb-451c-98ea-54cbf73d4fb4')
;

-- Oct 29, 2016 11:52:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202074,11,0,'Y',TO_DATE('2016-10-29 11:52:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:21','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MXI','04be769b-d4b3-4163-be8a-5e22c45f5e96')
;

-- Oct 29, 2016 11:52:22 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202075,11,0,'Y',TO_DATE('2016-10-29 11:52:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:21','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MMP','d3e99b2e-cf36-49d7-a827-7a224893720d')
;

-- Oct 29, 2016 11:52:22 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202076,11,0,'Y',TO_DATE('2016-10-29 11:52:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:22','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','GLD','5671a711-e399-4975-ba68-c939cb7a4f28')
;

-- Oct 29, 2016 11:52:23 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202077,11,0,'Y',TO_DATE('2016-10-29 11:52:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:22','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','CMC','f49d51d6-e472-4284-aa8d-3e1dfe594ef0')
;

-- Oct 29, 2016 11:52:23 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202078,11,0,'Y',TO_DATE('2016-10-29 11:52:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:23','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MXP','dd94ae8e-d28f-43f7-a46d-961442cb9947')
;

-- Oct 29, 2016 11:52:23 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202079,11,0,'Y',TO_DATE('2016-10-29 11:52:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:23','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','ARF','fa1258ab-2df6-4273-9953-3af178a777d3')
;

-- Oct 29, 2016 11:52:24 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202080,11,0,'Y',TO_DATE('2016-10-29 11:52:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:23','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','CMB','3e14c260-f6a6-4357-9dd7-79ee448298e7')
;

-- Oct 29, 2016 11:52:24 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202081,11,0,'Y',TO_DATE('2016-10-29 11:52:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:24','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','API','b834298f-650a-466e-ba14-e56f09dd087b')
;

-- Oct 29, 2016 11:52:25 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202082,11,0,'Y',TO_DATE('2016-10-29 11:52:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:24','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','APC','e8183dc7-e24b-44fa-aa60-573d69cf6650')
;

-- Oct 29, 2016 11:52:25 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202083,11,0,'Y',TO_DATE('2016-10-29 11:52:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:25','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','GLJ','7ccdee96-3fde-490b-a244-0ede30023010')
;

-- Oct 29, 2016 11:52:25 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202084,11,0,'Y',TO_DATE('2016-10-29 11:52:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:25','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','ARI','62e51c65-6393-4551-a943-f155878c6cea')
;

-- Oct 29, 2016 11:52:26 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202085,11,0,'Y',TO_DATE('2016-10-29 11:52:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:25','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','ARC','ae86fb80-c844-4552-83a9-a4acf393ce87')
;

-- Oct 29, 2016 11:52:26 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202086,11,0,'Y',TO_DATE('2016-10-29 11:52:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:26','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','ARR','f4b5e1fd-4f3e-48bc-a4b9-2a878acb081a')
;

-- Oct 29, 2016 11:52:27 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202087,11,0,'Y',TO_DATE('2016-10-29 11:52:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:26','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','APP','b0d6fa39-3342-4b8b-99c8-3e9934b22e19')
;

-- Oct 29, 2016 11:52:32 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202088,11,0,'Y',TO_DATE('2016-10-29 11:52:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:27','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','SOO','5e8b7732-6691-46e7-a738-f713bbe146af')
;

-- Oct 29, 2016 11:52:33 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202089,11,0,'Y',TO_DATE('2016-10-29 11:52:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:32','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','POO','dd130af4-0d86-42b2-878f-43aa31a0a5b1')
;

-- Oct 29, 2016 11:52:33 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202090,11,0,'Y',TO_DATE('2016-10-29 11:52:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:33','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','HRP','4bfd0f43-a5a7-450c-8625-63f3009c0942')
;

-- Oct 29, 2016 11:52:34 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202091,11,0,'Y',TO_DATE('2016-10-29 11:52:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:33','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MOP','bc37bc81-fa92-4354-9122-19da7c504836')
;

-- Oct 29, 2016 11:52:34 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202092,11,0,'Y',TO_DATE('2016-10-29 11:52:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:34','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MMR','adcb61c3-15dd-4356-8170-868e6bfb1c12')
;

-- Oct 29, 2016 11:52:34 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202093,11,0,'Y',TO_DATE('2016-10-29 11:52:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:34','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MQO','dcb5a78c-8b2e-41ee-beb7-93fb7dc43d45')
;

-- Oct 29, 2016 11:52:35 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202094,11,0,'Y',TO_DATE('2016-10-29 11:52:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:34','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','DOO','7038ce62-9e60-4eed-add5-4f0c50728446')
;

-- Oct 29, 2016 11:52:35 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202095,11,0,'Y',TO_DATE('2016-10-29 11:52:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:35','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','CMA','2f4b00a9-50dc-438f-94cf-711c24d90e1a')
;

-- Oct 29, 2016 11:52:36 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202096,11,0,'Y',TO_DATE('2016-10-29 11:52:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:35','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MMM','7ed23f30-9aa9-45a5-8921-b6c17fa39e82')
;

-- Oct 29, 2016 11:52:36 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202097,11,0,'Y',TO_DATE('2016-10-29 11:52:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:36','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','POR','0cc5ee18-67bd-4857-88d5-c0b55ff82176')
;

-- Oct 29, 2016 11:52:36 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202098,11,0,'Y',TO_DATE('2016-10-29 11:52:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:36','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MOF','ac92fc14-c0c3-4c0a-9940-99ce6654dcd2')
;

-- Oct 29, 2016 11:52:37 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202099,11,0,'Y',TO_DATE('2016-10-29 11:52:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:36','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MCC','276430a0-9a75-43e7-92e6-e497473f8983')
;

-- Oct 29, 2016 11:52:37 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202100,11,0,'Y',TO_DATE('2016-10-29 11:52:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:37','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','MMI','0f4bed5d-bd03-40a6-887c-f867eef42643')
;

-- Oct 29, 2016 11:52:37 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202101,11,0,'Y',TO_DATE('2016-10-29 11:52:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:37','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','FAA','b079cb51-2362-4b5f-9333-c07679b1abaf')
;

-- Oct 29, 2016 11:52:38 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202102,11,0,'Y',TO_DATE('2016-10-29 11:52:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:37','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','FDP','36a3098f-4031-47fe-a2ab-65dcb9f08e37')
;

-- Oct 29, 2016 11:52:38 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202103,11,0,'Y',TO_DATE('2016-10-29 11:52:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:38','YYYY-MM-DD HH24:MI:SS'),100,200067,'N','N','N','FAD','7129ba11-527d-47fc-9b7b-3a3ff129d3e6')
;

-- Oct 29, 2016 11:52:39 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Sep-17',TO_DATE('2017-09-01','YYYY-MM-DD'),200068,11,0,'Y',TO_DATE('2016-10-29 11:52:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:38','YYYY-MM-DD HH24:MI:SS'),100,9,200005,'S',TO_DATE('2017-09-30','YYYY-MM-DD'),'N','bcf06528-f114-4214-baf5-499f750c84d4')
;

-- Oct 29, 2016 11:52:39 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202104,11,0,'Y',TO_DATE('2016-10-29 11:52:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:39','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MMS','b578a0a0-a93d-4b13-b949-9ba4d671130c')
;

-- Oct 29, 2016 11:52:39 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202105,11,0,'Y',TO_DATE('2016-10-29 11:52:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:39','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','PJI','432e156a-8a9b-489b-bcf6-05363d31bbc0')
;

-- Oct 29, 2016 11:52:40 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202106,11,0,'Y',TO_DATE('2016-10-29 11:52:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:39','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MXI','67a90841-ccf6-4686-904b-73fee3617d13')
;

-- Oct 29, 2016 11:52:40 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202107,11,0,'Y',TO_DATE('2016-10-29 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MMP','5dcea647-c5b4-4761-b4cd-ddb46f69e3c8')
;

-- Oct 29, 2016 11:52:40 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202108,11,0,'Y',TO_DATE('2016-10-29 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','GLD','06e64348-be14-468f-8a28-50a63a9f6a58')
;

-- Oct 29, 2016 11:52:41 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202109,11,0,'Y',TO_DATE('2016-10-29 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:40','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','CMC','983c0489-7710-44e2-a25f-12a802d5165e')
;

-- Oct 29, 2016 11:52:41 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202110,11,0,'Y',TO_DATE('2016-10-29 11:52:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:41','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MXP','b81975de-5cf3-4a9b-9b3e-eeac610bd77d')
;

-- Oct 29, 2016 11:52:42 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202111,11,0,'Y',TO_DATE('2016-10-29 11:52:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:41','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','ARF','87dedccf-b5b0-4949-9225-e3eb49298b60')
;

-- Oct 29, 2016 11:52:42 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202112,11,0,'Y',TO_DATE('2016-10-29 11:52:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:42','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','CMB','94c60a01-2d3e-49d6-8c6b-38607300619c')
;

-- Oct 29, 2016 11:52:42 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202113,11,0,'Y',TO_DATE('2016-10-29 11:52:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:42','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','API','c97e9481-5ba1-4a71-a895-c0acebef9fd2')
;

-- Oct 29, 2016 11:52:43 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202114,11,0,'Y',TO_DATE('2016-10-29 11:52:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:42','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','APC','3674ab32-b933-4b3d-9ecc-72e1a4d25996')
;

-- Oct 29, 2016 11:52:43 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202115,11,0,'Y',TO_DATE('2016-10-29 11:52:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:43','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','GLJ','5c42e4d7-1823-4bef-bd2d-4df6b4d1e487')
;

-- Oct 29, 2016 11:52:43 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202116,11,0,'Y',TO_DATE('2016-10-29 11:52:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:43','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','ARI','4fa8a3b9-edbb-4fc5-8aea-f74bd476937a')
;

-- Oct 29, 2016 11:52:44 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202117,11,0,'Y',TO_DATE('2016-10-29 11:52:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:43','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','ARC','ea4ab307-e1cd-43a6-8ef1-087d07e5d44e')
;

-- Oct 29, 2016 11:52:44 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202118,11,0,'Y',TO_DATE('2016-10-29 11:52:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:44','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','ARR','e9995bd1-6e58-40f0-95da-3dde35bb9559')
;

-- Oct 29, 2016 11:52:44 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202119,11,0,'Y',TO_DATE('2016-10-29 11:52:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:44','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','APP','8fda4e99-95b6-44e6-980e-3c6d6a168226')
;

-- Oct 29, 2016 11:52:45 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202120,11,0,'Y',TO_DATE('2016-10-29 11:52:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:44','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','SOO','2da9d4f6-d4ad-4a77-a5d8-f0fecde3a457')
;

-- Oct 29, 2016 11:52:45 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202121,11,0,'Y',TO_DATE('2016-10-29 11:52:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:45','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','POO','9df2cfaf-975a-4be6-82ae-3648d1c24ad5')
;

-- Oct 29, 2016 11:52:46 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202122,11,0,'Y',TO_DATE('2016-10-29 11:52:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:45','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','HRP','241e896f-e18d-42c1-8fac-8495fe3167ba')
;

-- Oct 29, 2016 11:52:46 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202123,11,0,'Y',TO_DATE('2016-10-29 11:52:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:46','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MOP','0590ae07-e1cd-4140-bfc0-1f9a55650918')
;

-- Oct 29, 2016 11:52:46 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202124,11,0,'Y',TO_DATE('2016-10-29 11:52:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:46','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MMR','b175292e-cc43-4961-9f2b-ed772c6c36f7')
;

-- Oct 29, 2016 11:52:47 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202125,11,0,'Y',TO_DATE('2016-10-29 11:52:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:46','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MQO','f110a962-3196-4aa3-89d9-b698e377d61d')
;

-- Oct 29, 2016 11:52:47 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202126,11,0,'Y',TO_DATE('2016-10-29 11:52:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:47','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','DOO','169e2a8a-927a-4a0a-87cd-480a58712eeb')
;

-- Oct 29, 2016 11:52:47 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202127,11,0,'Y',TO_DATE('2016-10-29 11:52:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:47','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','CMA','b7246ab9-93bf-4d92-bf2e-82c4cc88a3be')
;

-- Oct 29, 2016 11:52:48 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202128,11,0,'Y',TO_DATE('2016-10-29 11:52:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:47','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MMM','87544901-5115-4800-99ae-589dcc5b8d1b')
;

-- Oct 29, 2016 11:52:48 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202129,11,0,'Y',TO_DATE('2016-10-29 11:52:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:48','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','POR','f6f8ee31-f352-4a8f-b1f5-e1cd94524750')
;

-- Oct 29, 2016 11:52:49 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202130,11,0,'Y',TO_DATE('2016-10-29 11:52:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:48','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MOF','99520aaa-d728-4f3f-bd5a-e4dd9ea1dc5c')
;

-- Oct 29, 2016 11:52:49 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202131,11,0,'Y',TO_DATE('2016-10-29 11:52:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:49','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MCC','2b90e681-ff18-4fdb-9a1a-fc163a595c13')
;

-- Oct 29, 2016 11:52:49 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202132,11,0,'Y',TO_DATE('2016-10-29 11:52:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:49','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','MMI','09274451-224b-4b6f-a0f4-2a3dacf2c51b')
;

-- Oct 29, 2016 11:52:50 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202133,11,0,'Y',TO_DATE('2016-10-29 11:52:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:49','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','FAA','3913c002-152f-4d76-b660-ce885b3fc73b')
;

-- Oct 29, 2016 11:52:50 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202134,11,0,'Y',TO_DATE('2016-10-29 11:52:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:50','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','FDP','54098fc7-9a76-4def-a393-888e2c101cab')
;

-- Oct 29, 2016 11:52:50 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202135,11,0,'Y',TO_DATE('2016-10-29 11:52:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:50','YYYY-MM-DD HH24:MI:SS'),100,200068,'N','N','N','FAD','e9952f1b-9055-420b-b8fd-32438206a334')
;

-- Oct 29, 2016 11:52:51 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Oct-17',TO_DATE('2017-10-01','YYYY-MM-DD'),200069,11,0,'Y',TO_DATE('2016-10-29 11:52:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:50','YYYY-MM-DD HH24:MI:SS'),100,10,200005,'S',TO_DATE('2017-10-31','YYYY-MM-DD'),'N','c476fcdc-c43d-4966-aed1-7b4e35db0606')
;

-- Oct 29, 2016 11:52:51 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202136,11,0,'Y',TO_DATE('2016-10-29 11:52:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:51','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MMS','b41627d3-38d0-4c72-8cb0-cd4a11ae4a63')
;

-- Oct 29, 2016 11:52:52 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202137,11,0,'Y',TO_DATE('2016-10-29 11:52:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:51','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','PJI','51e9c405-b285-4ab6-9f0a-79e12f99c01e')
;

-- Oct 29, 2016 11:52:52 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202138,11,0,'Y',TO_DATE('2016-10-29 11:52:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:52','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MXI','961ccd00-d8e8-4bb4-963f-2c1356895752')
;

-- Oct 29, 2016 11:52:52 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202139,11,0,'Y',TO_DATE('2016-10-29 11:52:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:52','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MMP','e9755199-33ad-4dbe-a75a-2b573fb09c19')
;

-- Oct 29, 2016 11:52:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202140,11,0,'Y',TO_DATE('2016-10-29 11:52:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:52','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','GLD','542a7050-b3e4-415f-98c9-5d443c2c396a')
;

-- Oct 29, 2016 11:52:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202141,11,0,'Y',TO_DATE('2016-10-29 11:52:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:53','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','CMC','8d075a10-6ed1-4ee9-a32b-a921b8c2ac2a')
;

-- Oct 29, 2016 11:52:53 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202142,11,0,'Y',TO_DATE('2016-10-29 11:52:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:53','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MXP','25c911cf-7610-49ac-be6e-8fc8f42ef340')
;

-- Oct 29, 2016 11:52:54 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202143,11,0,'Y',TO_DATE('2016-10-29 11:52:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:53','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','ARF','4a659373-65f5-4252-9b40-733068b9cb9e')
;

-- Oct 29, 2016 11:52:54 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202144,11,0,'Y',TO_DATE('2016-10-29 11:52:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:54','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','CMB','05cf01b8-4e45-43ff-8fc1-d9e0c68827a4')
;

-- Oct 29, 2016 11:52:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202145,11,0,'Y',TO_DATE('2016-10-29 11:52:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:54','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','API','70a1dd5c-1cf1-4889-bac5-91f900cd45a0')
;

-- Oct 29, 2016 11:52:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202146,11,0,'Y',TO_DATE('2016-10-29 11:52:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:55','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','APC','64699502-d8dd-49a8-b7e5-98bc17d13d75')
;

-- Oct 29, 2016 11:52:55 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202147,11,0,'Y',TO_DATE('2016-10-29 11:52:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:55','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','GLJ','81da6d4c-fe52-44d0-9297-0d7fca033400')
;

-- Oct 29, 2016 11:52:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202148,11,0,'Y',TO_DATE('2016-10-29 11:52:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:55','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','ARI','7b08def1-4df9-4292-b816-d67d6c3f54ff')
;

-- Oct 29, 2016 11:52:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202149,11,0,'Y',TO_DATE('2016-10-29 11:52:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:56','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','ARC','a157a136-40db-4214-8d0a-db3592706b11')
;

-- Oct 29, 2016 11:52:56 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202150,11,0,'Y',TO_DATE('2016-10-29 11:52:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:56','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','ARR','4ce86347-874b-4719-8a33-cfa9b5e5c0dd')
;

-- Oct 29, 2016 11:52:57 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202151,11,0,'Y',TO_DATE('2016-10-29 11:52:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:56','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','APP','210963ad-2d2a-41f8-8460-69e8cf072538')
;

-- Oct 29, 2016 11:52:57 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202152,11,0,'Y',TO_DATE('2016-10-29 11:52:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:57','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','SOO','9d51661b-1761-4ec3-b4d9-efd64876b70b')
;

-- Oct 29, 2016 11:52:57 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202153,11,0,'Y',TO_DATE('2016-10-29 11:52:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:57','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','POO','dff30030-27d5-4582-aa8a-8247f5d2988f')
;

-- Oct 29, 2016 11:52:58 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202154,11,0,'Y',TO_DATE('2016-10-29 11:52:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:57','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','HRP','1260ed51-b8d7-4826-bf36-d3a38a282991')
;

-- Oct 29, 2016 11:52:58 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202155,11,0,'Y',TO_DATE('2016-10-29 11:52:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:58','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MOP','b5e6f50f-278d-47e1-9c2f-6ae025a6e879')
;

-- Oct 29, 2016 11:52:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202156,11,0,'Y',TO_DATE('2016-10-29 11:52:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:58','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MMR','b5de5fab-386a-47c5-9786-2c95d73f2d44')
;

-- Oct 29, 2016 11:52:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202157,11,0,'Y',TO_DATE('2016-10-29 11:52:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:59','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MQO','c0a103ec-50c4-470a-8611-cc2a5e34e4ab')
;

-- Oct 29, 2016 11:52:59 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202158,11,0,'Y',TO_DATE('2016-10-29 11:52:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:59','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','DOO','b322bb06-f250-4ef2-a920-55d0c92ad5bd')
;

-- Oct 29, 2016 11:53:00 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202159,11,0,'Y',TO_DATE('2016-10-29 11:52:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:52:59','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','CMA','5c35eb91-5cc3-417b-9ead-42dc60b6f8a6')
;

-- Oct 29, 2016 11:53:00 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202160,11,0,'Y',TO_DATE('2016-10-29 11:53:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:00','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MMM','f9e014f0-1b29-42f1-bc83-efa78aa481d5')
;

-- Oct 29, 2016 11:53:00 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202161,11,0,'Y',TO_DATE('2016-10-29 11:53:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:00','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','POR','922750fd-6f12-4c98-8a40-d7e03b45cd5f')
;

-- Oct 29, 2016 11:53:01 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202162,11,0,'Y',TO_DATE('2016-10-29 11:53:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:00','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MOF','fd426a85-9534-4704-93c8-ffd7598afd31')
;

-- Oct 29, 2016 11:53:01 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202163,11,0,'Y',TO_DATE('2016-10-29 11:53:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:01','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MCC','0fa6d7ac-6f5f-4337-9b27-dbf26af8f175')
;

-- Oct 29, 2016 11:53:01 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202164,11,0,'Y',TO_DATE('2016-10-29 11:53:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:01','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','MMI','526cb187-23a3-40f8-b461-a79b361c546d')
;

-- Oct 29, 2016 11:53:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202165,11,0,'Y',TO_DATE('2016-10-29 11:53:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:01','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','FAA','315cc5a2-7303-42cb-b5ab-aac49666879c')
;

-- Oct 29, 2016 11:53:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202166,11,0,'Y',TO_DATE('2016-10-29 11:53:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:02','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','FDP','e724e01c-004d-4c96-8c97-fb8941ab35d9')
;

-- Oct 29, 2016 11:53:02 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202167,11,0,'Y',TO_DATE('2016-10-29 11:53:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:02','YYYY-MM-DD HH24:MI:SS'),100,200069,'N','N','N','FAD','a947f8a9-8b18-48d9-bb2c-42b73f887c4f')
;

-- Oct 29, 2016 11:53:03 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Nov-17',TO_DATE('2017-11-01','YYYY-MM-DD'),200070,11,0,'Y',TO_DATE('2016-10-29 11:53:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:03','YYYY-MM-DD HH24:MI:SS'),100,11,200005,'S',TO_DATE('2017-11-30','YYYY-MM-DD'),'N','0968b7f8-0b8a-4042-b667-fa50e36a5ad7')
;

-- Oct 29, 2016 11:53:03 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202168,11,0,'Y',TO_DATE('2016-10-29 11:53:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:03','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MMS','3aa5a4ee-a8a5-447d-8fb6-42eb0a3f065e')
;

-- Oct 29, 2016 11:53:04 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202169,11,0,'Y',TO_DATE('2016-10-29 11:53:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:03','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','PJI','fb39ba8e-2e83-4908-87be-0cf06c35f3fd')
;

-- Oct 29, 2016 11:53:04 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202170,11,0,'Y',TO_DATE('2016-10-29 11:53:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:04','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MXI','0c2ebb08-67d0-4072-932d-0bd4f5f31508')
;

-- Oct 29, 2016 11:53:04 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202171,11,0,'Y',TO_DATE('2016-10-29 11:53:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:04','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MMP','fa9ffe21-e4d7-4959-b1b0-6adc091cf3e9')
;

-- Oct 29, 2016 11:53:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202172,11,0,'Y',TO_DATE('2016-10-29 11:53:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:04','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','GLD','13a9477f-07f2-4ea0-ab06-6d879ebf8558')
;

-- Oct 29, 2016 11:53:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202173,11,0,'Y',TO_DATE('2016-10-29 11:53:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:05','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','CMC','33bc348f-2f71-4da8-b50f-f1cb5591158c')
;

-- Oct 29, 2016 11:53:05 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202174,11,0,'Y',TO_DATE('2016-10-29 11:53:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:05','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MXP','0af9e6b8-175b-4e4a-a099-9393ed0377e7')
;

-- Oct 29, 2016 11:53:06 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202175,11,0,'Y',TO_DATE('2016-10-29 11:53:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:05','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','ARF','32b99a5b-d0b8-4ed1-b685-386d3e86a8b8')
;

-- Oct 29, 2016 11:53:08 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202176,11,0,'Y',TO_DATE('2016-10-29 11:53:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:06','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','CMB','0b6607fa-f7d4-4d7d-839b-22d9f556329f')
;

-- Oct 29, 2016 11:53:08 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202177,11,0,'Y',TO_DATE('2016-10-29 11:53:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:08','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','API','73ccda6b-0272-4eb6-9792-89dcfe7d7d1e')
;

-- Oct 29, 2016 11:53:09 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202178,11,0,'Y',TO_DATE('2016-10-29 11:53:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:08','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','APC','c01f9e13-09b2-45ea-b85e-5e08d2a84465')
;

-- Oct 29, 2016 11:53:09 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202179,11,0,'Y',TO_DATE('2016-10-29 11:53:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:09','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','GLJ','70285cfe-5908-4e45-8c56-006622ef66df')
;

-- Oct 29, 2016 11:53:09 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202180,11,0,'Y',TO_DATE('2016-10-29 11:53:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:09','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','ARI','2fe0e575-131b-4823-931e-892ec3d7c88c')
;

-- Oct 29, 2016 11:53:10 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202181,11,0,'Y',TO_DATE('2016-10-29 11:53:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:09','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','ARC','3a57739b-044b-4263-92dd-01ebb4c749d2')
;

-- Oct 29, 2016 11:53:10 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202182,11,0,'Y',TO_DATE('2016-10-29 11:53:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:10','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','ARR','c9107016-258f-4a70-8748-75b300625a7f')
;

-- Oct 29, 2016 11:53:10 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202183,11,0,'Y',TO_DATE('2016-10-29 11:53:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:10','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','APP','00798310-e2a8-46d1-96a8-4e27e126c388')
;

-- Oct 29, 2016 11:53:11 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202184,11,0,'Y',TO_DATE('2016-10-29 11:53:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:10','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','SOO','500c68b4-0981-4d65-95be-de0ea6b71b4b')
;

-- Oct 29, 2016 11:53:11 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202185,11,0,'Y',TO_DATE('2016-10-29 11:53:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:11','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','POO','ad232c05-0e45-4ba9-b28c-82c74061766f')
;

-- Oct 29, 2016 11:53:11 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202186,11,0,'Y',TO_DATE('2016-10-29 11:53:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:11','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','HRP','d4cf9f44-6aa3-43ec-931e-eab9b44301c3')
;

-- Oct 29, 2016 11:53:12 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202187,11,0,'Y',TO_DATE('2016-10-29 11:53:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:11','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MOP','86866704-07d0-4449-ad8f-a6048585490b')
;

-- Oct 29, 2016 11:53:12 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202188,11,0,'Y',TO_DATE('2016-10-29 11:53:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:12','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MMR','c1b835fb-93b0-4c76-81d9-c7fd4e8358c7')
;

-- Oct 29, 2016 11:53:13 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202189,11,0,'Y',TO_DATE('2016-10-29 11:53:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:12','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MQO','2ec7e948-cd99-4a5b-bc69-991c251662e8')
;

-- Oct 29, 2016 11:53:13 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202190,11,0,'Y',TO_DATE('2016-10-29 11:53:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:13','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','DOO','96cb395a-ad65-499b-9b2e-06de7f61eb07')
;

-- Oct 29, 2016 11:53:13 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202191,11,0,'Y',TO_DATE('2016-10-29 11:53:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:13','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','CMA','4725b4c8-d152-46e7-8659-dc4a0a679073')
;

-- Oct 29, 2016 11:53:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202192,11,0,'Y',TO_DATE('2016-10-29 11:53:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:13','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MMM','8c3bb2aa-a4be-4161-86a3-e7b430537dce')
;

-- Oct 29, 2016 11:53:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202193,11,0,'Y',TO_DATE('2016-10-29 11:53:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:14','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','POR','5f035396-7e54-4cd6-85c6-62587f5817f6')
;

-- Oct 29, 2016 11:53:14 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202194,11,0,'Y',TO_DATE('2016-10-29 11:53:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:14','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MOF','19ef9c85-742c-42bd-a2fd-9418d66b2410')
;

-- Oct 29, 2016 11:53:15 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202195,11,0,'Y',TO_DATE('2016-10-29 11:53:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:14','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MCC','ea789c26-d513-49a9-b5eb-ab08675c3a60')
;

-- Oct 29, 2016 11:53:15 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202196,11,0,'Y',TO_DATE('2016-10-29 11:53:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:15','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','MMI','7d790120-42b3-47a5-902d-6a834a3b42c5')
;

-- Oct 29, 2016 11:53:16 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202197,11,0,'Y',TO_DATE('2016-10-29 11:53:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:15','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','FAA','4919ef9b-9010-420b-bb8f-4956657d242f')
;

-- Oct 29, 2016 11:53:16 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202198,11,0,'Y',TO_DATE('2016-10-29 11:53:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:16','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','FDP','f94b1475-97a6-43d1-a21b-76a63bdf4332')
;

-- Oct 29, 2016 11:53:16 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202199,11,0,'Y',TO_DATE('2016-10-29 11:53:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:16','YYYY-MM-DD HH24:MI:SS'),100,200070,'N','N','N','FAD','aab4402a-ba2f-44e8-944c-8c97a278818b')
;

-- Oct 29, 2016 11:53:17 AM CEST
INSERT INTO C_Period (Name,StartDate,C_Period_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,PeriodNo,C_Year_ID,PeriodType,EndDate,Processing,C_Period_UU) VALUES ('Dec-17',TO_DATE('2017-12-01','YYYY-MM-DD'),200071,11,0,'Y',TO_DATE('2016-10-29 11:53:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:16','YYYY-MM-DD HH24:MI:SS'),100,12,200005,'S',TO_DATE('2017-12-31','YYYY-MM-DD'),'N','3427b14b-00af-4c2a-9f00-94ad34e8061b')
;

-- Oct 29, 2016 11:53:17 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202200,11,0,'Y',TO_DATE('2016-10-29 11:53:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:17','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MMS','091ae5c9-cc0e-4782-8af0-8d6689d63078')
;

-- Oct 29, 2016 11:53:17 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202201,11,0,'Y',TO_DATE('2016-10-29 11:53:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:17','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','PJI','48465ce6-b1f9-43d4-a73c-e37dbc9228ba')
;

-- Oct 29, 2016 11:53:18 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202202,11,0,'Y',TO_DATE('2016-10-29 11:53:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:17','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MXI','a6db84fc-aad7-461c-963a-54d6bf68576a')
;

-- Oct 29, 2016 11:53:18 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202203,11,0,'Y',TO_DATE('2016-10-29 11:53:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:18','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MMP','7e1ebd6b-c558-45e5-82e7-e661d78e872d')
;

-- Oct 29, 2016 11:53:19 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202204,11,0,'Y',TO_DATE('2016-10-29 11:53:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:18','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','GLD','205bb482-30a6-4b08-a13e-a79997206ebc')
;

-- Oct 29, 2016 11:53:19 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202205,11,0,'Y',TO_DATE('2016-10-29 11:53:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:19','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','CMC','5b176beb-96e5-4631-b2cd-77dea1a41a8f')
;

-- Oct 29, 2016 11:53:19 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202206,11,0,'Y',TO_DATE('2016-10-29 11:53:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:19','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MXP','efd1dddf-c144-4a17-8e09-ff5e4106e154')
;

-- Oct 29, 2016 11:53:20 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202207,11,0,'Y',TO_DATE('2016-10-29 11:53:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:19','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','ARF','1b1297fb-f739-42f4-92a7-c30ec04b02eb')
;

-- Oct 29, 2016 11:53:20 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202208,11,0,'Y',TO_DATE('2016-10-29 11:53:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:20','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','CMB','080fb95e-bd53-43cc-8539-5ddb0dc4c9d2')
;

-- Oct 29, 2016 11:53:20 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202209,11,0,'Y',TO_DATE('2016-10-29 11:53:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:20','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','API','e40c4430-1b63-4bfe-8b72-b5611c0997e6')
;

-- Oct 29, 2016 11:53:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202210,11,0,'Y',TO_DATE('2016-10-29 11:53:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:20','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','APC','0ffb5e39-c14d-40bf-82a4-caeb9c958920')
;

-- Oct 29, 2016 11:53:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202211,11,0,'Y',TO_DATE('2016-10-29 11:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:21','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','GLJ','5d43ea87-aacb-4d80-b0c7-e6f0011607de')
;

-- Oct 29, 2016 11:53:21 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202212,11,0,'Y',TO_DATE('2016-10-29 11:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:21','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','ARI','0640abcc-4a1a-437f-9972-287d45395b42')
;

-- Oct 29, 2016 11:53:22 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202213,11,0,'Y',TO_DATE('2016-10-29 11:53:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:21','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','ARC','f941db32-f545-44f2-9d69-51218e4e55f6')
;

-- Oct 29, 2016 11:53:22 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202214,11,0,'Y',TO_DATE('2016-10-29 11:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:22','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','ARR','9af7bf41-52c3-4f0e-8e46-8d801127a070')
;

-- Oct 29, 2016 11:53:23 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202215,11,0,'Y',TO_DATE('2016-10-29 11:53:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:22','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','APP','d173f112-2762-4f74-bde4-c4068a921085')
;

-- Oct 29, 2016 11:53:23 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202216,11,0,'Y',TO_DATE('2016-10-29 11:53:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:23','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','SOO','e3cfc5e4-f725-4096-b98e-2bc590b42196')
;

-- Oct 29, 2016 11:53:23 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202217,11,0,'Y',TO_DATE('2016-10-29 11:53:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:23','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','POO','274ca258-1b23-4c3a-9f93-65cc82652263')
;

-- Oct 29, 2016 11:53:24 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202218,11,0,'Y',TO_DATE('2016-10-29 11:53:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:23','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','HRP','e45724ea-0dbc-44c0-9348-8dfeba9a0f26')
;

-- Oct 29, 2016 11:53:24 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202219,11,0,'Y',TO_DATE('2016-10-29 11:53:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:24','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MOP','4ad32210-498f-4249-88ef-5f426b57d143')
;

-- Oct 29, 2016 11:53:24 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202220,11,0,'Y',TO_DATE('2016-10-29 11:53:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:24','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MMR','5f00a51f-d82c-49ab-a0f2-36a9668fc0ae')
;

-- Oct 29, 2016 11:53:25 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202221,11,0,'Y',TO_DATE('2016-10-29 11:53:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:24','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MQO','5f5c1557-83c9-45dd-9259-d96bcfb70f5a')
;

-- Oct 29, 2016 11:53:25 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202222,11,0,'Y',TO_DATE('2016-10-29 11:53:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:25','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','DOO','16fa6bc1-cfc0-4788-ae62-e486433fae96')
;

-- Oct 29, 2016 11:53:25 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202223,11,0,'Y',TO_DATE('2016-10-29 11:53:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:25','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','CMA','6a45b02d-8505-4567-a385-0ea3d4b438a2')
;

-- Oct 29, 2016 11:53:26 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202224,11,0,'Y',TO_DATE('2016-10-29 11:53:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:25','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MMM','b2ffa3ef-ac33-42ce-85e8-c74945525aa2')
;

-- Oct 29, 2016 11:53:26 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202225,11,0,'Y',TO_DATE('2016-10-29 11:53:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:26','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','POR','99ed2926-12e4-4193-9da4-7a92ac3ee73c')
;

-- Oct 29, 2016 11:53:27 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202226,11,0,'Y',TO_DATE('2016-10-29 11:53:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:26','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MOF','ee57bef0-ee6a-4f27-a410-46e61e71ddb0')
;

-- Oct 29, 2016 11:53:27 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202227,11,0,'Y',TO_DATE('2016-10-29 11:53:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:27','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MCC','76ef5a1c-d434-4f67-9ae6-6aabb4020d92')
;

-- Oct 29, 2016 11:53:27 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202228,11,0,'Y',TO_DATE('2016-10-29 11:53:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:27','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','MMI','28954fef-dd23-45b3-91ca-9539adddc83f')
;

-- Oct 29, 2016 11:53:28 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202229,11,0,'Y',TO_DATE('2016-10-29 11:53:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:27','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','FAA','7b82eea7-cd8b-4a8f-b00a-2517cd5e5092')
;

-- Oct 29, 2016 11:53:28 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202230,11,0,'Y',TO_DATE('2016-10-29 11:53:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:28','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','FDP','0d37497b-46a7-4d35-be84-a2eb59507215')
;

-- Oct 29, 2016 11:53:28 AM CEST
INSERT INTO C_PeriodControl (C_PeriodControl_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_Period_ID,PeriodStatus,PeriodAction,Processing,DocBaseType,C_PeriodControl_UU) VALUES (202231,11,0,'Y',TO_DATE('2016-10-29 11:53:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-10-29 11:53:28','YYYY-MM-DD HH24:MI:SS'),100,200071,'N','N','N','FAD','ec754ea9-6608-460b-96dd-06ddd138fce5')
;

SELECT register_migration_script('201610291154_Generate2017GardenWorld.sql') FROM dual
;

