-- Feb 26, 2011 11:03:15 PM COT
-- Fix importer inventory move, create sample format
INSERT INTO AD_ImpFormat (AD_Client_ID,AD_ImpFormat_ID,AD_Org_ID,AD_Table_ID,Created,CreatedBy,Description,FormatType,IsActive,Name,Processing,Updated,UpdatedBy) VALUES (11,50003,0,53278,TO_DATE('2011-02-26 23:03:11','YYYY-MM-DD HH24:MI:SS'),100,'GardenWorld Inventory Movements','C','Y','Example Inventory Move','N',TO_DATE('2011-02-26 23:03:11','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:03:41 PM COT
INSERT INTO AD_ImpFormat_Row (AD_Client_ID,AD_Column_ID,AD_ImpFormat_ID,AD_ImpFormat_Row_ID,AD_Org_ID,Created,CreatedBy,DataType,DecimalPoint,DivideBy100,EndNo,IsActive,Name,SeqNo,StartNo,Updated,UpdatedBy) VALUES (11,59559,50003,50086,0,TO_DATE('2011-02-26 23:03:39','YYYY-MM-DD HH24:MI:SS'),100,'S','.','N',0,'Y','Organization',10,1,TO_DATE('2011-02-26 23:03:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:03:54 PM COT
INSERT INTO AD_ImpFormat_Row (AD_Client_ID,AD_Column_ID,AD_ImpFormat_ID,AD_ImpFormat_Row_ID,AD_Org_ID,Created,CreatedBy,DataType,DecimalPoint,DivideBy100,EndNo,IsActive,Name,SeqNo,StartNo,Updated,UpdatedBy) VALUES (11,59552,50003,50087,0,TO_DATE('2011-02-26 23:03:53','YYYY-MM-DD HH24:MI:SS'),100,'S','.','N',0,'Y','ProductKey',20,2,TO_DATE('2011-02-26 23:03:53','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:04:26 PM COT
INSERT INTO AD_ImpFormat_Row (AD_Client_ID,AD_Column_ID,AD_ImpFormat_ID,AD_ImpFormat_Row_ID,AD_Org_ID,Created,CreatedBy,DataType,DecimalPoint,DivideBy100,EndNo,IsActive,Name,SeqNo,StartNo,Updated,UpdatedBy) VALUES (11,59556,50003,50088,0,TO_DATE('2011-02-26 23:04:25','YYYY-MM-DD HH24:MI:SS'),100,'S','.','N',0,'Y','LocatorFrom',30,3,TO_DATE('2011-02-26 23:04:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:04:35 PM COT
INSERT INTO AD_ImpFormat_Row (AD_Client_ID,AD_Column_ID,AD_ImpFormat_ID,AD_ImpFormat_Row_ID,AD_Org_ID,Created,CreatedBy,DataType,DecimalPoint,DivideBy100,EndNo,IsActive,Name,SeqNo,StartNo,Updated,UpdatedBy) VALUES (11,59558,50003,50089,0,TO_DATE('2011-02-26 23:04:34','YYYY-MM-DD HH24:MI:SS'),100,'S','.','N',0,'Y','LocatorTo',40,4,TO_DATE('2011-02-26 23:04:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:04:51 PM COT
INSERT INTO AD_ImpFormat_Row (AD_Client_ID,AD_Column_ID,AD_ImpFormat_ID,AD_ImpFormat_Row_ID,AD_Org_ID,Created,CreatedBy,DataType,DecimalPoint,DivideBy100,EndNo,IsActive,Name,SeqNo,StartNo,Updated,UpdatedBy) VALUES (11,59560,50003,50090,0,TO_DATE('2011-02-26 23:04:50','YYYY-MM-DD HH24:MI:SS'),100,'N','.','N',0,'Y','MovementQty',50,5,TO_DATE('2011-02-26 23:04:50','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:06:29 PM COT
INSERT INTO AD_ImpFormat_Row (AD_Client_ID,AD_Column_ID,AD_ImpFormat_ID,AD_ImpFormat_Row_ID,AD_Org_ID,Created,CreatedBy,DataFormat,DataType,DecimalPoint,DivideBy100,EndNo,IsActive,Name,SeqNo,StartNo,Updated,UpdatedBy) VALUES (11,59554,50003,50091,0,TO_DATE('2011-02-26 23:06:23','YYYY-MM-DD HH24:MI:SS'),100,'MMddyyyy','D','.','N',0,'Y','MovementDate',60,6,TO_DATE('2011-02-26 23:06:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:06:39 PM COT
INSERT INTO AD_ImpFormat_Row (AD_Client_ID,AD_Column_ID,AD_ImpFormat_ID,AD_ImpFormat_Row_ID,AD_Org_ID,Created,CreatedBy,DataType,DecimalPoint,DivideBy100,EndNo,IsActive,Name,SeqNo,StartNo,Updated,UpdatedBy) VALUES (11,59563,50003,50092,0,TO_DATE('2011-02-26 23:06:39','YYYY-MM-DD HH24:MI:SS'),100,'S','.','N',0,'Y','DocTypeName',70,7,TO_DATE('2011-02-26 23:06:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:06:51 PM COT
INSERT INTO AD_ImpFormat_Row (AD_Client_ID,AD_Column_ID,AD_ImpFormat_ID,AD_ImpFormat_Row_ID,AD_Org_ID,Created,CreatedBy,DataType,DecimalPoint,DivideBy100,EndNo,IsActive,Name,SeqNo,StartNo,Updated,UpdatedBy) VALUES (11,59561,50003,50093,0,TO_DATE('2011-02-26 23:06:51','YYYY-MM-DD HH24:MI:SS'),100,'S','.','N',0,'Y','DocumentNo',80,8,TO_DATE('2011-02-26 23:06:51','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 26, 2011 11:12:44 PM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2011-02-26 23:12:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59561
;

-- Feb 26, 2011 11:12:47 PM COT
ALTER TABLE I_Movement MODIFY DocumentNo NVARCHAR2(40) DEFAULT NULL 
;

-- Feb 26, 2011 11:12:47 PM COT
ALTER TABLE I_Movement MODIFY DocumentNo NULL
;

