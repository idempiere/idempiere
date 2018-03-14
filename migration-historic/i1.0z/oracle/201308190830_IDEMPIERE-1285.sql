-- Aug 19, 2013 11:33:20 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Name,Description,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID) VALUES ('P_LandedCostClearing_Acct',202587,'Account used for posting of estimated and actual landed cost amount.  The balance on the clearing account should be zero and accounts for the timing difference between material receipt and landed cost invoice.','D','Landed Cost Clearing','Product Landed Cost Clearing Account','Landed Cost Clearing','b701e5a5-c94b-4298-8dab-3b93da803e24',TO_DATE('2013-08-19 11:33:03','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-19 11:33:03','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0)
;

-- Aug 19, 2013 11:33:21 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202587 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 11:35:43 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,315,210730,'N','N','N',0,'N',22,'N',25,'N','N','Y','d2b7f7a6-cf25-4bb6-aac8-c765fff73349','Y','P_LandedCostClearing_Acct','Product Landed Cost Clearing Account','Account used for posting of estimated and actual landed cost amount.  The balance on the clearing account should be zero and accounts for the timing difference between material receipt and landed cost invoice.','Landed Cost Clearing','Y',TO_DATE('2013-08-19 11:35:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 11:35:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202587,'N')
;

-- Aug 19, 2013 11:35:43 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210730 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 11:35:50 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_AcctSchema_Default ADD P_LandedCostClearing_Acct NUMBER(10) DEFAULT NULL 
;

-- Aug 19, 2013 11:37:32 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,273,210731,'N','N','N',0,'N',22,'N',25,'N','N','Y','9d37c254-f88a-4d7b-b3a0-03edacd8c1dc','Y','P_LandedCostClearing_Acct','Product Landed Cost Clearing Account','Account used for posting of estimated and actual landed cost amount.  The balance on the clearing account should be zero and accounts for the timing difference between material receipt and landed cost invoice.','Landed Cost Clearing','Y',TO_DATE('2013-08-19 11:37:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 11:37:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202587,'N')
;

-- Aug 19, 2013 11:37:32 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210731 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 11:37:43 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE M_Product_Acct ADD P_LandedCostClearing_Acct NUMBER(10) DEFAULT NULL 
;

-- Aug 19, 2013 11:38:40 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,401,210732,'N','N','N',0,'N',22,'N',25,'N','N','Y','9de1b9e9-202c-4e62-8bc9-e0e6c9b0be94','Y','P_LandedCostClearing_Acct','Product Landed Cost Clearing Account','Account used for posting of estimated and actual landed cost amount.  The balance on the clearing account should be zero and accounts for the timing difference between material receipt and landed cost invoice.','Landed Cost Clearing','Y',TO_DATE('2013-08-19 11:38:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 11:38:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202587,'N')
;

-- Aug 19, 2013 11:38:40 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210732 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 11:38:57 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE M_Product_Category_Acct ADD P_LandedCostClearing_Acct NUMBER(10) DEFAULT NULL 
;

-- Aug 19, 2013 11:45:17 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,IsAdvancedField) VALUES (1,0,'N',252,0,'N','N',210730,680,'Y',202403,'N','Account used for posting of estimated and actual landed cost amount.  The balance on the clearing account should be zero and accounts for the timing difference between material receipt and landed cost invoice.',200013,'D','Product Landed Cost Clearing Account','Landed Cost Clearing','Y','N','7226a38b-d3a2-42a3-aa56-c60f6670582b',100,0,TO_DATE('2013-08-19 11:45:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 11:45:16','YYYY-MM-DD HH24:MI:SS'),'Y','Y',780,1,'N',0,1,'N')
;

-- Aug 19, 2013 11:45:17 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202403 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=280, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202403
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2662
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=300,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3842
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3841
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=320,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5132
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=330,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5133
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=340,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3845
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=350,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3844
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=360,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3839
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=370,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3840
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=380,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3836
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=390,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3851
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=400,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2654
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=410,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3835
;

-- Aug 19, 2013 11:46:39 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=420,Updated=TO_DATE('2013-08-19 11:46:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3823
;

-- Aug 19, 2013 2:20:24 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID) VALUES ('N','N','N','1',0,200103,'N','N','Y','D','L','a4b95653-aef2-435a-a605-8ad71c8b7be8','Y','Y','C_OrderLandedCost','Estimated Landed Cost for Purchase Order','Estimated Landed Cost','Y',0,100,TO_DATE('2013-08-19 14:20:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:13','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Aug 19, 2013 2:20:24 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200103 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 19, 2013 2:20:24 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Sequence_UU,IncrementNo,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200140,'Table C_OrderLandedCost','C_OrderLandedCost','df1316a8-37eb-41cf-8cb8-d13fb414fbeb',1,0,TO_DATE('2013-08-19 14:20:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:24','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 19, 2013 2:20:25 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_OrderLandedCost_ID',202595,'Estimated Landed Cost','Estimated Landed Cost','45c5a103-7fb1-4578-916d-41c846432446',TO_DATE('2013-08-19 14:20:24','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-19 14:20:24','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Aug 19, 2013 2:20:25 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202595 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 2:20:26 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200103,210787,'Y','N','N',0,'N',22,'N',13,'Y','N','Y','a01b1596-4225-4fc4-824a-ce971fdb4521','N','C_OrderLandedCost_ID','Estimated Landed Cost','N',TO_DATE('2013-08-19 14:20:25','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202595,'N')
;

-- Aug 19, 2013 2:20:26 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210787 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:26 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
CREATE TABLE C_OrderLandedCost (C_OrderLandedCost_ID NUMBER(10) NOT NULL, CONSTRAINT C_OrderLandedCost_Key PRIMARY KEY (C_OrderLandedCost_ID))
;

-- Aug 19, 2013 2:20:26 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200103,210788,'Y','N','N',0,'N',22,'N',19,129,'N','N','Y','82ae1d27-29ef-43b6-bd9b-1d9ca02d7143','N','AD_Client_ID','Client/Tenant for this installation.','@AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2013-08-19 14:20:26','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102,'N')
;

-- Aug 19, 2013 2:20:26 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210788 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:26 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:20:27 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200103,210789,'Y','N','N',0,'N',22,'N',19,104,'N','N','Y','57a258fb-8006-4357-9d2f-634a65b97a33','N','AD_Org_ID','Organizational entity within client','@AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2013-08-19 14:20:26','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113,'N')
;

-- Aug 19, 2013 2:20:27 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210789 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:27 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:20:28 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_OrderLandedCost_UU',202596,'C_OrderLandedCost_UU','C_OrderLandedCost_UU','3111982b-fc8b-4fd1-80bc-9e177c161e4a',TO_DATE('2013-08-19 14:20:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-19 14:20:27','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Aug 19, 2013 2:20:28 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202596 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 2:20:28 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1.00,200103,210790,'N','N','N','N',36,'N',10,'N','N','Y','f81bff83-676c-40bd-9b81-c6177acb9b36','Y','C_OrderLandedCost_UU','C_OrderLandedCost_UU','N',TO_DATE('2013-08-19 14:20:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202596,'N')
;

-- Aug 19, 2013 2:20:28 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210790 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:28 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD C_OrderLandedCost_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Aug 19, 2013 2:20:29 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD CONSTRAINT C_OrderLandedCost_UU_idx UNIQUE (C_OrderLandedCost_UU)
;

-- Aug 19, 2013 2:20:29 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200103,210791,'Y','N','N',0,'N',7,'N',16,'N','N','Y','232d3fb6-a457-4275-b1fc-3a1cd397524d','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2013-08-19 14:20:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245,'N')
;

-- Aug 19, 2013 2:20:29 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210791 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:29 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD Created DATE NOT NULL
;

-- Aug 19, 2013 2:20:30 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200103,210792,110,'Y','N','N',0,'N',22,'N',18,'N','N','Y','a2aa6895-00e8-4403-a4e3-392e92a41e6a','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2013-08-19 14:20:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246,'N')
;

-- Aug 19, 2013 2:20:30 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210792 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:30 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD CreatedBy NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:20:31 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200103,210793,'N','N','N',0,'N',255,'Y',10,'N','N','Y','b8a1d6f4-b738-4577-be7b-78030d4cfdad','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_DATE('2013-08-19 14:20:30','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:30','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',275,'N')
;

-- Aug 19, 2013 2:20:31 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210793 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:31 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD Description NVARCHAR2(255) DEFAULT NULL 
;

-- Aug 19, 2013 2:20:32 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',0,200103,210794,339,'Y','N','N','N',1,'N',17,'N','N','Y','42c95ca0-d55e-4f26-9125-0b6f0edab662','Y','LandedCostDistribution','Landed Cost Distribution','Q','How landed costs are distributed to material receipts','Cost Distribution','Y',TO_DATE('2013-08-19 14:20:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2703,'N')
;

-- Aug 19, 2013 2:20:32 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210794 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:32 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD LandedCostDistribution CHAR(1) DEFAULT 'Q' NOT NULL
;

-- Aug 19, 2013 2:20:33 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',0,200103,210795,'Y','N','N','N',10,'N',19,222,'N','N','Y','e68cfb06-ce8a-4434-81fb-1c10997298a5','Y','M_CostElement_ID','Product Cost Element','Cost Element','Y',TO_DATE('2013-08-19 14:20:32','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:32','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2700,'N')
;

-- Aug 19, 2013 2:20:33 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210795 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:33 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD M_CostElement_ID NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:20:33 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200103,210796,'Y','N','N',0,'N',7,'N',16,'N','N','Y','de3237e4-d938-4a21-9ed5-016163598ee2','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2013-08-19 14:20:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607,'N')
;

-- Aug 19, 2013 2:20:33 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210796 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:33 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD Updated DATE NOT NULL
;

-- Aug 19, 2013 2:20:34 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200103,210797,110,'Y','N','N',0,'N',22,'N',18,'N','N','Y','b02e0d84-eb4d-4109-be67-b1cfa9b057de','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2013-08-19 14:20:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608,'N')
;

-- Aug 19, 2013 2:20:34 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210797 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:34 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:20:35 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',0,200103,210798,'Y','N','N',0,'Y',22,'N',30,'N','N','Y','6b95895b-ceed-4d8c-909e-b2366e2b3ded','N','C_Order_ID','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','Order','Y',TO_DATE('2013-08-19 14:20:34','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',558,'N')
;

-- Aug 19, 2013 2:20:35 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210798 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:35 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD C_Order_ID NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:20:35 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',0,200103,210799,'Y','N','N',0,'N',22,'N',12,'N','N','Y','21f22033-fa5a-48d4-b283-f4dd591cb904','Y','Amt','Amount','0','Amount','Amount','N',TO_DATE('2013-08-19 14:20:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',160,'N')
;

-- Aug 19, 2013 2:20:35 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210799 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:35 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD Amt NUMBER DEFAULT 0 NOT NULL
;

-- Aug 19, 2013 2:20:36 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',1,200103,210800,'Y','N','N',0,'N',1,'N',20,'N','N','Y','6200b3be-e355-4e75-9a1b-3301a27262ed','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2013-08-19 14:20:36','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:36','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348,'N')
;

-- Aug 19, 2013 2:20:36 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210800 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:36 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Aug 19, 2013 2:20:37 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',1,200103,210801,'Y','N','N',0,'N',1,'N',20,'N','N','Y','9103b1f1-9614-4c0b-bb19-e57446201fc0','Y','Processed','The document has been processed','N','The Processed checkbox indicates that a document has been processed.','Processed','Y',TO_DATE('2013-08-19 14:20:37','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:37','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1047,'N')
;

-- Aug 19, 2013 2:20:37 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210801 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:37 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCost ADD Processed CHAR(1) DEFAULT 'N' CHECK (Processed IN ('Y','N')) NOT NULL
;

-- Aug 19, 2013 2:20:38 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','Y',181,70,'N','N',200103,'N','N','N','Y','N',1,'92141899-a52e-4902-bf11-fae2907fd747','D','Estimated Landed Cost',200109,0,TO_DATE('2013-08-19 14:20:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:38','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Aug 19, 2013 2:20:38 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200109 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Aug 19, 2013 2:20:39 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,36,'N','N',210790,0,'Y',202429,'N','D','C_OrderLandedCost_UU','23995911-ee7e-49ad-929f-5e73a5ae691f','N','N',100,0,TO_DATE('2013-08-19 14:20:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:38','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:20:39 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202429 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:40 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,22,'N','N',210787,0,'Y',202430,'N','D','Estimated Landed Cost','923e4e19-4b63-41cb-a257-1c96c684a6c6','N','N',100,0,TO_DATE('2013-08-19 14:20:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:39','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:20:40 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202430 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:40 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,22,'N','N',210788,10,'Y',202431,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','1ae8b7aa-07c6-46b7-906d-4dbbc5ee2671','Y','N',100,0,TO_DATE('2013-08-19 14:20:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:40','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:20:40 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202431 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:41 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,22,'N','N',210789,20,'Y',202432,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','7b8c644e-7b17-4923-9958-519e1257ff7b','Y','N','Y',100,0,TO_DATE('2013-08-19 14:20:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:40','YYYY-MM-DD HH24:MI:SS'),'Y','Y',4,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:20:41 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202432 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:42 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,22,'N','N',210798,30,'Y',202433,'N','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','D','Order','Order','d95e1a8d-1a99-42d1-b5fb-8f0df85c2f46','Y','N',100,0,TO_DATE('2013-08-19 14:20:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:41','YYYY-MM-DD HH24:MI:SS'),'Y','Y',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:20:42 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202433 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:42 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,10,'N','N',210795,40,'Y',202434,'N','D','Product Cost Element','Cost Element','34d9ce77-6e18-4183-9531-470af17e5263','Y','N',100,0,TO_DATE('2013-08-19 14:20:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:20:42 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202434 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:43 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,255,'N','N',210793,50,'Y',202435,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','3a05203b-c7b0-43f0-9a74-602598d54985','Y','N',100,0,TO_DATE('2013-08-19 14:20:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',1,'N',0,5,1,'N')
;

-- Aug 19, 2013 2:20:43 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202435 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:44 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,1,'N','N',210794,60,'Y',202436,'N','How landed costs are distributed to material receipts','D','Landed Cost Distribution','Cost Distribution','00631adb-d3f6-49dc-ab42-6becd6eeec33','Y','N',100,0,TO_DATE('2013-08-19 14:20:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:43','YYYY-MM-DD HH24:MI:SS'),'Y','Y',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:20:44 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202436 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:44 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200109,22,'N','N',210799,70,'Y',202437,'N','Amount','D','Amount','Amount','17d760d6-f4d6-4702-834e-cb76c7442ac2','Y','N',100,0,TO_DATE('2013-08-19 14:20:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:44','YYYY-MM-DD HH24:MI:SS'),'Y','Y',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:20:44 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202437 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:20:45 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID) VALUES ('N','N','N','1',0,200104,'N','N','Y','D','L','2daed095-c101-4922-b05a-1587562a85bb','Y','Y','C_OrderLandedCostAllocation','Estimate landed cost allocation for order line','Estimated Landed Cost Allocation','Y',0,100,TO_DATE('2013-08-19 14:20:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:44','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Aug 19, 2013 2:20:45 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200104 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 19, 2013 2:20:46 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Sequence_UU,IncrementNo,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200141,'Table C_OrderLandedCostAllocation','C_OrderLandedCostAllocation','61ef937d-bf27-46e5-8a1f-ca8748f56732',1,0,TO_DATE('2013-08-19 14:20:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:20:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 19, 2013 2:20:46 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_OrderLandedCostAllocation_ID',202597,'Estimated Landed Cost Allocation','Estimated Landed Cost Allocation','742abb97-fd35-4d73-a6f6-400de13e1972',TO_DATE('2013-08-19 14:20:46','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-19 14:20:46','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Aug 19, 2013 2:20:46 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202597 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 2:20:47 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',0,200104,210802,'Y','N','N','N',10,'N',13,'Y','N','Y','300b4467-3258-4aa7-a23a-f8945df71ddc','N','C_OrderLandedCostAllocation_ID','Estimated Landed Cost Allocation','N',TO_DATE('2013-08-19 14:20:46','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202597,'N')
;

-- Aug 19, 2013 2:20:47 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210802 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:47 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
CREATE TABLE C_OrderLandedCostAllocation (C_OrderLandedCostAllocation_ID NUMBER(10) NOT NULL, CONSTRAINT C_OrderLandedCostAllocatio_Key PRIMARY KEY (C_OrderLandedCostAllocation_ID))
;

-- Aug 19, 2013 2:20:48 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200104,210803,'Y','N','N',0,'N',22,'N',19,129,'N','N','Y','515d51df-fb8f-48cf-9cc1-09888ce70895','N','AD_Client_ID','Client/Tenant for this installation.','@AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2013-08-19 14:20:47','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102,'N')
;

-- Aug 19, 2013 2:20:48 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210803 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:48 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:20:49 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200104,210804,'Y','N','N',0,'N',22,'N',19,104,'N','N','Y','d306fcb8-a551-4cba-a089-4276979e1ba4','N','AD_Org_ID','Organizational entity within client','@AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2013-08-19 14:20:48','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113,'N')
;

-- Aug 19, 2013 2:20:49 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210804 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:49 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:20:49 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200104,210805,'Y','N','N',0,'N',22,'N',12,'N','N','Y','0ab4a43c-f93b-4465-a334-3dedddc33e73','Y','Amt','Amount','Amount','Amount','Y',TO_DATE('2013-08-19 14:20:49','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:49','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',160,'N')
;

-- Aug 19, 2013 2:20:49 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210805 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:49 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD Amt NUMBER NOT NULL
;

-- Aug 19, 2013 2:20:50 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',0,200104,210806,'Y','N','N','N',22,'N',22,'N','N','Y','daed0386-9b97-4ef0-bb69-642674c687c2','Y','Base','Calculation Base','Base','Y',TO_DATE('2013-08-19 14:20:49','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:49','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2818,'N')
;

-- Aug 19, 2013 2:20:50 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210806 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:50 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD Base NUMBER NOT NULL
;

-- Aug 19, 2013 2:20:51 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_OrderLandedCostAllocation_UU',202598,'C_OrderLandedCostAllocation_UU','C_OrderLandedCostAllocation_UU','5a57282b-b393-4888-bef7-828b4e733160',TO_DATE('2013-08-19 14:20:50','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-19 14:20:50','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Aug 19, 2013 2:20:51 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202598 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 2:20:51 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1.00,200104,210807,'N','N','N','N',36,'N',10,'N','N','Y','695fd3aa-79e4-448b-b805-f324c81d4fd9','Y','C_OrderLandedCostAllocation_UU','C_OrderLandedCostAllocation_UU','N',TO_DATE('2013-08-19 14:20:51','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202598,'N')
;

-- Aug 19, 2013 2:20:51 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210807 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:52 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD C_OrderLandedCostAllocation_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Aug 19, 2013 2:20:52 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD CONSTRAINT C_OrderLandedCostAlloc_uu_idx UNIQUE (C_OrderLandedCostAllocation_UU)
;

-- Aug 19, 2013 2:20:52 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200104,210808,'Y','N','N',0,'N',7,'N',16,'N','N','Y','e59adeb1-4235-41d5-a0e6-720d44ba00a1','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2013-08-19 14:20:52','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245,'N')
;

-- Aug 19, 2013 2:20:52 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210808 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:52 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD Created DATE NOT NULL
;

-- Aug 19, 2013 2:20:53 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200104,210809,110,'Y','N','N',0,'N',22,'N',18,'N','N','Y','50d2d00f-76e9-412f-ae58-da8204f7f12a','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2013-08-19 14:20:52','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246,'N')
;

-- Aug 19, 2013 2:20:53 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210809 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:20:53 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD CreatedBy NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:21:08 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200104,210810,'Y','N','N',0,'N',22,'N',29,'N','N','Y','7d69150f-57f8-4ee7-8f08-65ca9af2a62c','Y','Qty','Quantity','The Quantity indicates the number of a specific product or item for this document.','Quantity','Y',TO_DATE('2013-08-19 14:20:53','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:20:53','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',526,'N')
;

-- Aug 19, 2013 2:21:08 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210810 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:08 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD Qty NUMBER NOT NULL
;

-- Aug 19, 2013 2:21:08 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200104,210811,'Y','N','N',0,'N',7,'N',16,'N','N','Y','b2ebea38-4227-416f-9ddb-7107811be05e','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2013-08-19 14:21:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:21:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607,'N')
;

-- Aug 19, 2013 2:21:08 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210811 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:08 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD Updated DATE NOT NULL
;

-- Aug 19, 2013 2:21:09 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200104,210812,110,'Y','N','N',0,'N',22,'N',18,'N','N','Y','3d8627b7-e083-4d5d-a7a4-6557dca512b4','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2013-08-19 14:21:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:21:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608,'N')
;

-- Aug 19, 2013 2:21:09 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210812 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:09 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:21:10 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',0,200104,210813,'Y','N','N',0,'Y',22,'N',30,'N','N','Y','b9a55455-cb48-42ff-b52b-5037a7deca75','N','C_OrderLandedCost_ID','Estimated Landed Cost','Y',TO_DATE('2013-08-19 14:21:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:21:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202595,'N')
;

-- Aug 19, 2013 2:21:10 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210813 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:10 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD C_OrderLandedCost_ID NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:21:11 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',0,200104,210815,'Y','N','N',0,'N',10,'N',19,203,'N','N','Y','30a85b9a-2dba-4a25-9b46-8ac2b0671369','N','C_OrderLine_ID','Sales Order Line','The Sales Order Line is a unique identifier for a line in an order.','Sales Order Line','N',TO_DATE('2013-08-19 14:21:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:21:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',561,'N')
;

-- Aug 19, 2013 2:21:11 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210815 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:11 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD C_OrderLine_ID NUMBER(10) NOT NULL
;

-- Aug 19, 2013 2:21:11 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',1,200104,210816,'Y','N','N',0,'N',1,'N',20,'N','N','Y','f5aa9b00-359a-4a53-a5ab-521d57b77ff5','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2013-08-19 14:21:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:21:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348,'N')
;

-- Aug 19, 2013 2:21:11 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210816 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:11 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Aug 19, 2013 2:21:12 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',1,200104,210817,'Y','N','N',0,'N',1,'N',20,'N','N','Y','7c8519a2-9f39-48bc-b3f4-97fd526a3783','Y','Processed','The document has been processed','N','The Processed checkbox indicates that a document has been processed.','Processed','Y',TO_DATE('2013-08-19 14:21:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:21:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1047,'N')
;

-- Aug 19, 2013 2:21:12 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210817 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:12 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_OrderLandedCostAllocation ADD Processed CHAR(1) DEFAULT 'N' CHECK (Processed IN ('Y','N')) NOT NULL
;

-- Aug 19, 2013 2:21:13 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','Y',181,80,'N','N',200104,'N','N','N','Y','N',2,'d91b0ef9-ff2a-4836-b9d8-7ea8ccb7c40c','D','Estimated Landed Cost Allocation',200110,0,TO_DATE('2013-08-19 14:21:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Aug 19, 2013 2:21:13 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200110 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Aug 19, 2013 2:21:14 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,36,'N','N',210807,0,'Y',202438,'N','D','C_OrderLandedCostAllocation_UU','e5af5151-1438-40b6-8d25-3ee3750149d6','N','N',100,0,TO_DATE('2013-08-19 14:21:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:13','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:14 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202438 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:15 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,10,'N','N',210802,0,'Y',202439,'N','D','Estimated Landed Cost Allocation','bb7c5e71-68e0-444b-a03f-80d87dd35277','N','N',100,0,TO_DATE('2013-08-19 14:21:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:14','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:15 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202439 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:15 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,22,'N','N',210803,10,'Y',202440,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','821a8736-1e23-4570-9089-629391e3418d','Y','N',100,0,TO_DATE('2013-08-19 14:21:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:15 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202440 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:16 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,22,'N','N',210804,20,'Y',202441,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','86fb439b-38c1-45cb-9052-ab93607f36b9','Y','N','Y',100,0,TO_DATE('2013-08-19 14:21:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,4,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:16 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202441 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:17 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,22,'N','N',210813,30,'Y',202442,'N','D','Estimated Landed Cost','5984bc56-9945-4223-bcac-dc215d48e472','Y','N',100,0,TO_DATE('2013-08-19 14:21:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:16','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:17 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202442 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:17 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,10,'N','N',210815,40,'N',202443,'N','The Purchase Order Line is a unique identifier for a line in an order.','D','Purchase Order Line','Purchase Order Line','d0f72770-0e17-40bd-be7c-a33e523fcbe0','Y','N',100,0,TO_DATE('2013-08-19 14:21:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:17','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:17 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202443 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:18 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,22,'N','N',210806,50,'Y',202444,'Y','D','Calculation Base','Base','61094f01-e51a-4a14-bb1d-c9e6de6e1e55','Y','N',100,0,TO_DATE('2013-08-19 14:21:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:17','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:18 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202444 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:19 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,22,'N','N',210810,60,'Y',202445,'Y','The Quantity indicates the number of a specific product or item for this document.','D','Quantity','Quantity','742c6628-ee79-475c-91e5-21cdbe4b12b2','Y','N',100,0,TO_DATE('2013-08-19 14:21:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:18','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:19 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202445 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:19 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES ('N',200110,22,'N','N',210805,70,'Y',202446,'Y','Amount','D','Amount','Amount','b67089e2-a8e5-473f-86d8-f2c50ed17ad9','Y','N',100,0,TO_DATE('2013-08-19 14:21:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:21:19','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,2,1,'N')
;

-- Aug 19, 2013 2:21:19 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202446 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:21:20 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'Y',0,760,210818,'N','N','N',0,'N',22,'N',30,'N','N','Y','ca6ad084-ba7f-4204-8ffc-2fbda8bcc41c','N','M_InOutLine_ID','Line on Shipment or Receipt document','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document','Shipment/Receipt Line','N',TO_DATE('2013-08-19 14:21:19','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-19 14:21:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1026,'N')
;

-- Aug 19, 2013 2:21:20 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210818 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:20 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
ALTER TABLE C_LandedCostAllocation ADD M_InOutLine_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 19, 2013 2:31:25 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_FieldGroup_ID,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES (0,'N',324,0,'N','N',210732,310,'Y',202467,'N','Account used for posting of estimated and actual landed cost amount.  The balance on the clearing account should be zero and accounts for the timing difference between material receipt and landed cost invoice.',200011,'D','Product Landed Cost Clearing Account','Landed Cost Clearing','d2f20ec0-e107-44d9-a88d-4099484eb213','Y','N',100,0,TO_DATE('2013-08-19 14:31:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:31:10','YYYY-MM-DD HH24:MI:SS'),'Y','Y',320,1,'N',0,1,1,'N')
;

-- Aug 19, 2013 2:31:25 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202467 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:32:08 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=200, IsDisplayed='Y', XPosition=1, ColumnSpan=2,Updated=TO_DATE('2013-08-19 14:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202467
;

-- Aug 19, 2013 2:32:08 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2013-08-19 14:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3945
;

-- Aug 19, 2013 2:33:41 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES (0,'N',210,0,'N','N',210731,290,'Y',202469,'N','Account used for posting of estimated and actual landed cost amount.  The balance on the clearing account should be zero and accounts for the timing difference between material receipt and landed cost invoice.','D','Product Landed Cost Clearing Account','Landed Cost Clearing','1d627daa-21d8-4bbe-9250-d069e2ea8971','Y','N',100,0,TO_DATE('2013-08-19 14:33:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:33:20','YYYY-MM-DD HH24:MI:SS'),'Y','Y',290,1,'N',0,1,1,'N')
;

-- Aug 19, 2013 2:33:41 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202469 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:34:00 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=180, ColumnSpan=2,Updated=TO_DATE('2013-08-19 14:34:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202469
;

-- Aug 19, 2013 2:58:23 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO C_ElementValue (IsSummary,PostEncumbrance,AccountSign,IsDocControlled,C_ElementValue_ID,PostStatistical,C_Element_ID,AccountType,PostActual,IsForeignCurrency,C_Currency_ID,IsBankAccount,PostBudget,C_BankAccount_ID,Name,Description,C_ElementValue_UU,Value,Updated,UpdatedBy,CreatedBy,AD_Client_ID,Created,IsActive,AD_Org_ID) VALUES ('N','Y','N','Y',200000,'Y',105,'E','Y','N',100,'N','Y',100,'Landed Cost Clearing','Account for Landed Cost Clearing','15b486d5-8ce6-42a1-9dbf-e111e77a1581','58900',TO_DATE('2013-08-19 14:58:18','YYYY-MM-DD HH24:MI:SS'),100,100,11,TO_DATE('2013-08-19 14:58:18','YYYY-MM-DD HH24:MI:SS'),'Y',0)
;

-- Aug 19, 2013 2:58:23 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO C_ElementValue_Trl (AD_Language,C_ElementValue_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,C_ElementValue_Trl_UU ) SELECT l.AD_Language,t.C_ElementValue_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, C_ElementValue t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_ElementValue_ID=200000 AND NOT EXISTS (SELECT * FROM C_ElementValue_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_ElementValue_ID=t.C_ElementValue_ID)
;

-- Aug 19, 2013 2:58:23 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200000, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=11 AND t.IsActive='Y' AND EXISTS (SELECT * FROM C_Element ae WHERE ae.C_Element_ID=105 AND t.AD_Tree_ID=ae.AD_Tree_ID) AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200000)
;

-- Aug 19, 2013 2:59:14 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
INSERT INTO C_ValidCombination (C_ValidCombination_ID,IsFullyQualified,Combination,C_AcctSchema_ID,Account_ID,Description,C_ValidCombination_UU,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Org_ID,AD_Client_ID) VALUES (200000,'Y','HQ-58900-_-_-_-_',101,200000,'HQ-Landed Cost Clearing-_-_-_-_','7a7e6f38-b914-471f-a23b-9ad79b853073','Y',TO_DATE('2013-08-19 14:59:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-19 14:59:08','YYYY-MM-DD HH24:MI:SS'),100,11,11)
;

-- Aug 19, 2013 2:59:25 PM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE C_AcctSchema_Default SET P_LandedCostClearing_Acct=200000,Updated=TO_DATE('2013-08-19 14:59:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_AcctSchema_ID=101
;

Update M_Product_Category_Acct Set P_LandedCostClearing_Acct=200000 WHERE P_LandedCostClearing_Acct IS NULL AND C_AcctSchema_ID=101 AND AD_Client_ID=11
;

Update M_Product_Acct Set P_LandedCostClearing_Acct=200000 WHERE P_LandedCostClearing_Acct IS NULL AND C_AcctSchema_ID=101  AND AD_Client_ID=11
;

SELECT register_migration_script('201308190830_IDEMPIERE-1285.sql') FROM dual
;

