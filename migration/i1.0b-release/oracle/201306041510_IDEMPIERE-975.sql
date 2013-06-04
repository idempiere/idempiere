-- Jun 4, 2013 2:54:56 PM COT
-- IDEMPIERE-975 Issue in populating BP location for new sales order
UPDATE AD_InfoColumn SET SeqNo=50,Updated=TO_DATE('2013-06-04 14:54:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200038
;

-- Jun 4, 2013 2:55:01 PM COT
UPDATE AD_InfoColumn SET SeqNo=60,Updated=TO_DATE('2013-06-04 14:55:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200026
;

-- Jun 4, 2013 2:55:08 PM COT
UPDATE AD_InfoColumn SET SeqNo=70,Updated=TO_DATE('2013-06-04 14:55:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200027
;

-- Jun 4, 2013 2:55:14 PM COT
UPDATE AD_InfoColumn SET SeqNo=80,Updated=TO_DATE('2013-06-04 14:55:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200028
;

-- Jun 4, 2013 2:55:19 PM COT
UPDATE AD_InfoColumn SET SeqNo=90,Updated=TO_DATE('2013-06-04 14:55:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200029
;

-- Jun 4, 2013 2:55:23 PM COT
UPDATE AD_InfoColumn SET SeqNo=100,Updated=TO_DATE('2013-06-04 14:55:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200030
;

-- Jun 4, 2013 2:55:28 PM COT
UPDATE AD_InfoColumn SET SeqNo=110,Updated=TO_DATE('2013-06-04 14:55:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200031
;

-- Jun 4, 2013 2:55:43 PM COT
UPDATE AD_InfoColumn SET SeqNo=120,Updated=TO_DATE('2013-06-04 14:55:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200032
;

-- Jun 4, 2013 2:55:48 PM COT
UPDATE AD_InfoColumn SET SeqNo=130,Updated=TO_DATE('2013-06-04 14:55:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200033
;

-- Jun 4, 2013 2:55:53 PM COT
UPDATE AD_InfoColumn SET SeqNo=140,Updated=TO_DATE('2013-06-04 14:55:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200034
;

-- Jun 4, 2013 2:55:58 PM COT
UPDATE AD_InfoColumn SET SeqNo=150,Updated=TO_DATE('2013-06-04 14:55:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200035
;

-- Jun 4, 2013 2:56:04 PM COT
UPDATE AD_InfoColumn SET SeqNo=160,Updated=TO_DATE('2013-06-04 14:56:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200036
;

-- Jun 4, 2013 2:56:10 PM COT
UPDATE AD_InfoColumn SET SeqNo=170,Updated=TO_DATE('2013-06-04 14:56:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200037
;

-- Jun 4, 2013 2:56:20 PM COT
UPDATE AD_InfoColumn SET IsDisplayed='N',Updated=TO_DATE('2013-06-04 14:56:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200025
;

-- Jun 4, 2013 2:56:58 PM COT
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,SeqNo,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,QueryOperator,SelectClause,SeqNoSelection,IsIdentifier,AD_Client_ID) VALUES (200001,'The User identifies a unique user in the system. This could be an internal user or a business partner contact',40,'d5b8ddfa-b7d1-4f78-b1ca-b964ba3d71e5',30,200114,'N','D','User within the system - Internal or Business Partner Contact',TO_DATE('2013-06-04 14:56:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-04 14:56:57','YYYY-MM-DD HH24:MI:SS'),0,100,'User/Contact','Y','AD_User_ID','Y','Y',138,'=','c.AD_User_ID',0,'N',0)
;

-- Jun 4, 2013 2:56:58 PM COT
INSERT INTO AD_InfoColumn_Trl (AD_Language,AD_InfoColumn_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_InfoColumn_Trl_UU ) SELECT l.AD_Language,t.AD_InfoColumn_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_InfoColumn t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_InfoColumn_ID=200114 AND NOT EXISTS (SELECT * FROM AD_InfoColumn_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_InfoColumn_ID=t.AD_InfoColumn_ID)
;

-- Jun 4, 2013 2:57:29 PM COT
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,SeqNo,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,QueryOperator,SelectClause,SeqNoSelection,IsIdentifier,AD_Client_ID) VALUES (200001,'The Partner address indicates the location of a Business Partner',180,'927e1423-37d6-4930-b8b1-524ce3d53c74',30,200115,'N','D','Identifies the (ship to) address for this Business Partner',TO_DATE('2013-06-04 14:57:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-06-04 14:57:28','YYYY-MM-DD HH24:MI:SS'),0,100,'Partner Location','Y','C_BPartner_Location_ID','Y','Y',189,'=','l.C_BPartner_Location_ID',0,'N',0)
;

-- Jun 4, 2013 2:57:29 PM COT
INSERT INTO AD_InfoColumn_Trl (AD_Language,AD_InfoColumn_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_InfoColumn_Trl_UU ) SELECT l.AD_Language,t.AD_InfoColumn_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_InfoColumn t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_InfoColumn_ID=200115 AND NOT EXISTS (SELECT * FROM AD_InfoColumn_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_InfoColumn_ID=t.AD_InfoColumn_ID)
;

SELECT register_migration_script('201306041510_IDEMPIERE-975.sql') FROM dual
;

