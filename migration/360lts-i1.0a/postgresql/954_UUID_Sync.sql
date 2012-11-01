-- Oct 31, 2012 10:18:58 AM COT
-- UUID Sync
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('M_QualityTestResult_UU',200202,'U','M_QualityTestResult_UU','M_QualityTestResult_UU','9d41aaf2-0571-4582-a3e9-c3c1eaee2b31',0,TO_TIMESTAMP('2012-10-31 10:18:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:18:57','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:18:58 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200202 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:18:59 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53331,200848,'U','N','N','N','N',36,'N',10,'N',200202,'39e6d72f-7b8d-4fc1-bc39-850235495e87','Y','N','M_QualityTestResult_UU','M_QualityTestResult_UU',TO_TIMESTAMP('2012-10-31 10:18:57','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:18:57','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:18:59 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200848 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:18:59 AM COT
ALTER TABLE M_QualityTestResult ADD COLUMN M_QualityTestResult_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:18:59 AM COT
CREATE UNIQUE INDEX M_QualityTestResult_UU_idx ON m_qualitytestresult(M_QualityTestResult_UU)
;

-- Oct 31, 2012 10:19:00 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('M_QualityTest_UU',200203,'U','M_QualityTest_UU','M_QualityTest_UU','8e275428-511a-48a2-948f-425b1296507c',0,TO_TIMESTAMP('2012-10-31 10:19:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:00','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:00 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200203 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:01 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53332,200849,'U','N','N','N','N',36,'N',10,'N',200203,'ec4f96c4-d079-42e9-8c9a-8b683f905b8d','Y','N','M_QualityTest_UU','M_QualityTest_UU',TO_TIMESTAMP('2012-10-31 10:19:00','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:00','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:01 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200849 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:01 AM COT
ALTER TABLE M_QualityTest ADD COLUMN M_QualityTest_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:01 AM COT
CREATE UNIQUE INDEX M_QualityTest_UU_idx ON m_qualitytest(M_QualityTest_UU)
;

-- Oct 31, 2012 10:19:01 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('M_Product_QualityTest_UU',200204,'U','M_Product_QualityTest_UU','M_Product_QualityTest_UU','f5b424e5-1672-4292-af7b-71d54f6bbf7f',0,TO_TIMESTAMP('2012-10-31 10:19:01','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:01','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:02 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200204 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:02 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53333,200850,'U','N','N','N','N',36,'N',10,'N',200204,'2b8bd6b2-1693-43d4-9a0c-a4bd1dce1876','Y','N','M_Product_QualityTest_UU','M_Product_QualityTest_UU',TO_TIMESTAMP('2012-10-31 10:19:01','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:01','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:02 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200850 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:02 AM COT
ALTER TABLE M_Product_QualityTest ADD COLUMN M_Product_QualityTest_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:02 AM COT
CREATE UNIQUE INDEX M_Product_QualityTest_UU_idx ON m_product_qualitytest(M_Product_QualityTest_UU)
;

-- Oct 31, 2012 10:19:03 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('M_PartType_UU',200205,'U','M_PartType_UU','M_PartType_UU','546c8ee1-a973-4f52-b345-4ff31bc99bca',0,TO_TIMESTAMP('2012-10-31 10:19:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:03 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200205 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:03 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53334,200851,'U','N','N','N','N',36,'N',10,'N',200205,'49198395-d3ef-4828-a464-0c92b5b31bf2','Y','N','M_PartType_UU','M_PartType_UU',TO_TIMESTAMP('2012-10-31 10:19:02','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:02','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:03 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200851 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:03 AM COT
ALTER TABLE M_PartType ADD COLUMN M_PartType_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:04 AM COT
CREATE UNIQUE INDEX M_PartType_UU_idx ON m_parttype(M_PartType_UU)
;

-- Oct 31, 2012 10:19:04 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('T_BOM_Indented_UU',200206,'U','T_BOM_Indented_UU','T_BOM_Indented_UU','2b8d1f8f-1e80-4a17-9bab-1eaa17435d9c',0,TO_TIMESTAMP('2012-10-31 10:19:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:04','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:04 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200206 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:05 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53335,200852,'U','N','N','N','N',36,'N',10,'N',200206,'1ba153f7-173b-4963-9f3c-cd4f047eb39f','Y','N','T_BOM_Indented_UU','T_BOM_Indented_UU',TO_TIMESTAMP('2012-10-31 10:19:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:04','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:05 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200852 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:05 AM COT
ALTER TABLE T_BOM_Indented ADD COLUMN T_BOM_Indented_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:05 AM COT
CREATE UNIQUE INDEX T_BOM_Indented_UU_idx ON t_bom_indented(T_BOM_Indented_UU)
;

-- Oct 31, 2012 10:19:06 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_Tab_Customization_UU',200207,'U','AD_Tab_Customization_UU','AD_Tab_Customization_UU','82cb368d-5b4d-4cb8-ae56-64a0e295ced6',0,TO_TIMESTAMP('2012-10-31 10:19:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:05','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:06 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200207 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:06 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,200008,200853,'U','N','N','N','N',36,'N',10,'N',200207,'990da79f-1e68-40e6-9546-0b1228439073','Y','N','AD_Tab_Customization_UU','AD_Tab_Customization_UU',TO_TIMESTAMP('2012-10-31 10:19:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:06 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200853 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:06 AM COT
ALTER TABLE AD_Tab_Customization ADD COLUMN AD_Tab_Customization_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:06 AM COT
CREATE UNIQUE INDEX AD_Tab_Customization_UU_idx ON ad_tab_customization(AD_Tab_Customization_UU)
;

-- Oct 31, 2012 10:19:07 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('PA_DashboardPreference_UU',200208,'U','PA_DashboardPreference_UU','PA_DashboardPreference_UU','16ec8487-fb7f-455e-97d2-9d4c4027cd0b',0,TO_TIMESTAMP('2012-10-31 10:19:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:07','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:07 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200208 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:08 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,200013,200854,'U','N','N','N','N',36,'N',10,'N',200208,'10e9cb0f-132a-4f69-96f0-ec26789bf059','Y','N','PA_DashboardPreference_UU','PA_DashboardPreference_UU',TO_TIMESTAMP('2012-10-31 10:19:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:07','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:08 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200854 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:08 AM COT
ALTER TABLE PA_DashboardPreference ADD COLUMN PA_DashboardPreference_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:08 AM COT
CREATE UNIQUE INDEX PA_DashboardPreference_UU_idx ON pa_dashboardpreference(PA_DashboardPreference_UU)
;

-- Oct 31, 2012 10:19:08 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('A_Asset_Product_UU',200209,'U','A_Asset_Product_UU','A_Asset_Product_UU','d1005ada-66d3-4d29-94f4-0401bdefa063',0,TO_TIMESTAMP('2012-10-31 10:19:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:08','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:08 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200209 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:09 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53270,200855,'U','N','N','N','N',36,'N',10,'N',200209,'6a783ff8-4c8e-45ee-b15a-0636b97a985a','Y','N','A_Asset_Product_UU','A_Asset_Product_UU',TO_TIMESTAMP('2012-10-31 10:19:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:08','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:09 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200855 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:09 AM COT
ALTER TABLE A_Asset_Product ADD COLUMN A_Asset_Product_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:09 AM COT
CREATE UNIQUE INDEX A_Asset_Product_UU_idx ON a_asset_product(A_Asset_Product_UU)
;

-- Oct 31, 2012 10:19:10 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('A_Asset_Class_UU',200210,'U','A_Asset_Class_UU','A_Asset_Class_UU','5f13032a-b9e1-467f-bc7a-96a255502fa3',0,TO_TIMESTAMP('2012-10-31 10:19:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:10 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200210 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:10 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53269,200856,'U','N','N','N','N',36,'N',10,'N',200210,'2dc7a9bd-cf8f-4867-b94d-989e76bd0a45','Y','N','A_Asset_Class_UU','A_Asset_Class_UU',TO_TIMESTAMP('2012-10-31 10:19:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:09','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:10 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200856 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:10 AM COT
ALTER TABLE A_Asset_Class ADD COLUMN A_Asset_Class_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:11 AM COT
CREATE UNIQUE INDEX A_Asset_Class_UU_idx ON a_asset_class(A_Asset_Class_UU)
;

-- Oct 31, 2012 10:19:11 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('A_FundingMode_UU',200211,'U','A_FundingMode_UU','A_FundingMode_UU','205a3722-9a92-496c-bc14-e21edc0314d1',0,TO_TIMESTAMP('2012-10-31 10:19:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:11','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:11 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200211 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:12 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53273,200857,'U','N','N','N','N',36,'N',10,'N',200211,'b75dd803-c6b4-4cb4-837b-ec666b7778ad','Y','N','A_FundingMode_UU','A_FundingMode_UU',TO_TIMESTAMP('2012-10-31 10:19:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:11','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:12 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200857 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:12 AM COT
ALTER TABLE A_FundingMode ADD COLUMN A_FundingMode_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:12 AM COT
CREATE UNIQUE INDEX A_FundingMode_UU_idx ON a_fundingmode(A_FundingMode_UU)
;

-- Oct 31, 2012 10:19:12 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('A_FundingMode_Acct_UU',200212,'U','A_FundingMode_Acct_UU','A_FundingMode_Acct_UU','e8dcc9e7-e57a-4b53-9b66-5ed4c186794e',0,TO_TIMESTAMP('2012-10-31 10:19:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:12 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200212 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:13 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53274,200858,'U','N','N','N','N',36,'N',10,'N',200212,'cf79037c-8d0b-450e-b421-c30a2eb135ba','Y','N','A_FundingMode_Acct_UU','A_FundingMode_Acct_UU',TO_TIMESTAMP('2012-10-31 10:19:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:12','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:13 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200858 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:13 AM COT
ALTER TABLE A_FundingMode_Acct ADD COLUMN A_FundingMode_Acct_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:13 AM COT
CREATE UNIQUE INDEX A_FundingMode_Acct_UU_idx ON a_fundingmode_acct(A_FundingMode_Acct_UU)
;

-- Oct 31, 2012 10:19:13 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('A_Asset_Type_UU',200213,'U','A_Asset_Type_UU','A_Asset_Type_UU','e6e7930d-4be4-4ecd-8f54-5d67186e6894',0,TO_TIMESTAMP('2012-10-31 10:19:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:13 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200213 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:14 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53276,200859,'U','N','N','N','N',36,'N',10,'N',200213,'aa8b4c0b-7c61-47cd-8b85-9a290b97af2d','Y','N','A_Asset_Type_UU','A_Asset_Type_UU',TO_TIMESTAMP('2012-10-31 10:19:13','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:13','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:14 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200859 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:14 AM COT
ALTER TABLE A_Asset_Type ADD COLUMN A_Asset_Type_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:14 AM COT
CREATE UNIQUE INDEX A_Asset_Type_UU_idx ON a_asset_type(A_Asset_Type_UU)
;

-- Oct 31, 2012 10:19:14 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('I_FixedAsset_UU',200214,'U','I_FixedAsset_UU','I_FixedAsset_UU','3a525ba0-af20-42dc-bc10-eeb70b22a703',0,TO_TIMESTAMP('2012-10-31 10:19:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:14 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200214 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:15 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53277,200860,'U','N','N','N','N',36,'N',10,'N',200214,'1b18223e-0c22-42fa-b7fd-92671fc20e90','Y','N','I_FixedAsset_UU','I_FixedAsset_UU',TO_TIMESTAMP('2012-10-31 10:19:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:14','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:15 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200860 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:15 AM COT
ALTER TABLE I_FixedAsset ADD COLUMN I_FixedAsset_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:15 AM COT
CREATE UNIQUE INDEX I_FixedAsset_UU_idx ON i_fixedasset(I_FixedAsset_UU)
;

-- Oct 31, 2012 10:19:16 AM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('A_Asset_Reval_UU',200215,'U','A_Asset_Reval_UU','A_Asset_Reval_UU','f4bd422b-9c8f-457b-88ad-8a5a1fe6576d',0,TO_TIMESTAMP('2012-10-31 10:19:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-31 10:19:15','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 31, 2012 10:19:16 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200215 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 31, 2012 10:19:16 AM COT
INSERT INTO AD_Column (IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES ('N',1.00,53275,200861,'U','N','N','N','N',36,'N',10,'N',200215,'ac49c3db-0ef1-4830-a535-5f8553dea212','Y','N','A_Asset_Reval_UU','A_Asset_Reval_UU',TO_TIMESTAMP('2012-10-31 10:19:15','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2012-10-31 10:19:15','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 31, 2012 10:19:16 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200861 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 31, 2012 10:19:16 AM COT
ALTER TABLE A_Asset_Reval ADD COLUMN A_Asset_Reval_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:19:17 AM COT
CREATE UNIQUE INDEX A_Asset_Reval_UU_idx ON a_asset_reval(A_Asset_Reval_UU)
;

-- Oct 31, 2012 10:27:40 AM COT
ALTER TABLE A_Asset_Acct ADD A_Asset_Acct_UU VARCHAR(36) DEFAULT NULL 
;

-- Oct 31, 2012 10:28:31 AM COT
ALTER TABLE A_Asset_Group_Acct ADD A_Asset_Group_Acct_UU VARCHAR(36) DEFAULT NULL 
;

CREATE UNIQUE INDEX a_asset_acct_uu_idx ON a_asset_acct (a_asset_acct_uu);

CREATE UNIQUE INDEX a_asset_group_acct_uu_idx ON a_asset_group_acct (a_asset_group_acct_uu);

CREATE UNIQUE INDEX ad_passwordrule_uu_idx ON ad_passwordrule (ad_passwordrule_uu);

CREATE UNIQUE INDEX asp_ref_list_uu_idx ON asp_ref_list (asp_ref_list_uu);

CREATE UNIQUE INDEX c_bankaccount_processor_uu_idx ON c_bankaccount_processor (c_bankaccount_processor_uu);

CREATE UNIQUE INDEX c_pospayment_uu_idx ON c_pospayment (c_pospayment_uu);

CREATE UNIQUE INDEX c_postendertype_uu_idx ON c_postendertype (c_postendertype_uu);

CREATE UNIQUE INDEX m_costhistory_uu_idx ON m_costhistory (m_costhistory_uu);

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='dc9682fc-0bb4-4d55-a865-5c419d3ae0a0' WHERE AD_Column_ID=59254
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='020f0a6f-9157-4140-82f1-48777975aa3b' WHERE AD_Column_ID=59255
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='f8ff3ef7-8207-469c-b81f-e68886d47031' WHERE AD_Column_ID=59256
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='8a3728a2-bfc2-4429-a6d1-efd42ea16eea' WHERE AD_Column_ID=59257
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='9a708d3f-a18b-46db-9033-b3fecdc1143a' WHERE AD_Column_ID=59258
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='bd81a383-45c0-4d41-8324-d217498d2f36' WHERE AD_Column_ID=59259
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='d246e51f-9dee-433b-9558-ec5fd785f8e3' WHERE AD_Column_ID=59261
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='52f8fd28-db8b-4fda-8c1b-499b22014b3c' WHERE AD_Column_ID=59262
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='f356f23e-b83a-4719-9173-d4ffdfbc0c65' WHERE AD_Column_ID=59263
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='2a125b14-861e-4d29-b433-60abf2d1452b' WHERE AD_Column_ID=59264
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='6cb1f93d-d287-42b6-ace7-97d5d5b285eb' WHERE AD_Column_ID=59265
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='ec617866-4605-475a-912f-b92877ffabbf' WHERE AD_Column_ID=59266
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='b48788ba-59a1-46e3-947a-8f121ee5713b' WHERE AD_Column_ID=59267
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='32d0bda3-7137-4da2-9ef1-756087b96d4d' WHERE AD_Column_ID=59268
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='2ac77fc4-5cae-4b81-a0c3-93cc960beae5' WHERE AD_Column_ID=59269
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='5573a73d-a911-414a-bb79-7ba04cff84f5' WHERE AD_Column_ID=59270
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='f2133c2b-819a-412f-97a4-cccc70bda1b9' WHERE AD_Column_ID=59271
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='69f28f2b-b87f-4404-8971-4c439f0aacc5' WHERE AD_Column_ID=59272
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='8c4ad81a-01b4-4b5b-a2d4-27c1b43e10c0' WHERE AD_Column_ID=59273
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='fc1feacd-ab7e-4c5a-860f-cad172f0f023' WHERE AD_Column_ID=59274
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='62be85e2-d51f-466f-a4a6-49bfaddebf57' WHERE AD_Column_ID=59275
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='605e2c94-bd65-45ec-a9f1-ba2944d9bc7a' WHERE AD_Column_ID=59276
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='36a06484-044c-490e-9454-89ade8cc0085' WHERE AD_Column_ID=59277
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='dcbf4fbf-53f9-48de-81a7-8ff829cd752e' WHERE AD_Column_ID=59260
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='e743a1dd-75b1-45ff-b99c-8f8f9885b555' WHERE AD_Column_ID=59278
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='c38fe117-ee8d-41b5-b09f-f9cef3a1a507' WHERE AD_Column_ID=59279
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='a354e598-0fdf-476c-bd39-96b31db1f2db' WHERE AD_Column_ID=59280
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='2fc4eb96-093f-4544-acdc-71caa233f049' WHERE AD_Column_ID=59281
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='30aec249-6a07-4bfc-bf49-3b694e0314a1' WHERE AD_Column_ID=59285
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='d7f6feef-cd75-46d2-84de-b2d1de32a8d3' WHERE AD_Column_ID=59286
;

-- Oct 31, 2012 12:37:32 PM COT
UPDATE AD_Column SET AD_Column_UU='65d887fd-1d79-4504-88ba-ee26811b3df0' WHERE AD_Column_ID=59287
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='341c4899-2ac0-461d-b227-5d6f98d19e3f' WHERE AD_Column_ID=59288
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='143c9024-44bb-456b-a361-371a5ac717ad' WHERE AD_Column_ID=59289
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='a96eb188-5b69-4ece-aa64-4a896d8385c0' WHERE AD_Column_ID=59290
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='b364a2f4-1bec-4ca9-b34d-366f0a9cc868' WHERE AD_Column_ID=59291
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='f9305162-dd81-4bd3-aaef-d218d820d9e9' WHERE AD_Column_ID=59293
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='aa9ed860-1662-40d7-98e3-930e7ee61edf' WHERE AD_Column_ID=59294
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='97ca1e1f-e5e0-47fe-9bd9-8c0f7a2311d1' WHERE AD_Column_ID=59295
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='038fd89f-c23e-4cdb-8562-7885ffa755f4' WHERE AD_Column_ID=59296
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='0e1a7120-609f-4eed-a572-18be3ea92221' WHERE AD_Column_ID=59297
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='3e81b397-261b-413f-b202-c41ccca51ab4' WHERE AD_Column_ID=59298
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='68ad6ed5-37b6-45b0-a2a9-18195134ce06' WHERE AD_Column_ID=59299
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='65794203-22fa-493a-852a-448ec208a743' WHERE AD_Column_ID=59300
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='ff341449-1906-493a-ab49-8aa8e7a9aeac' WHERE AD_Column_ID=59301
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='51df61c6-e308-458f-af6a-65bf05696193' WHERE AD_Column_ID=59303
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='67ca92e3-c873-46ed-8eff-40539e5f9ff8' WHERE AD_Column_ID=59304
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='988d23ee-044c-4ec6-9f1a-5502e098d891' WHERE AD_Column_ID=59305
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='12063627-930a-4301-87c2-b69f0ae16155' WHERE AD_Column_ID=59306
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='f2e38977-6584-4d4b-8463-59933eecfc46' WHERE AD_Column_ID=59308
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='01244d80-f963-43e9-81f1-e358f7e049ae' WHERE AD_Column_ID=59309
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='33ee5f9e-a823-43f0-916f-211119e57bba' WHERE AD_Column_ID=59312
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='2df3c8eb-5b9c-49d5-9ace-b1d6a6a4a888' WHERE AD_Column_ID=59313
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='b9490dde-a0de-4c2b-8050-01ce9534735f' WHERE AD_Column_ID=59314
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='034ca7f8-44f6-4fe1-9edf-84bc001fb22a' WHERE AD_Column_ID=59315
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='15c428e2-d2b3-44b6-9ea8-b545c24f4d1f' WHERE AD_Column_ID=59316
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='110d49e0-e388-42f6-b97f-bd286d3261e0' WHERE AD_Column_ID=59317
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='424e35d6-125e-4e05-9825-dd42fda202fc' WHERE AD_Column_ID=59318
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='3dbc7d9c-c29a-4b02-aae1-92dadab26dfa' WHERE AD_Column_ID=59319
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='7ef8ace9-efa6-4be1-bcd8-e6dbfe23a0f0' WHERE AD_Column_ID=59320
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='5ae1e340-a0d9-4f74-ab7a-04e864000f37' WHERE AD_Column_ID=59321
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='94417e10-fce7-4d0f-99cd-b972774c542f' WHERE AD_Column_ID=59322
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='a108694b-7720-4a25-81f8-a333aeaf5920' WHERE AD_Column_ID=59323
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='1e0322ec-ed48-42c9-9aca-fc5b4d4bfa71' WHERE AD_Column_ID=59324
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='17a49663-67b0-4c86-8313-c802b32b8aae' WHERE AD_Column_ID=59325
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='fb8a21a3-37c6-494b-87e9-541cf115fdb7' WHERE AD_Column_ID=59327
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='faca241a-b1c1-4763-bd34-3fbbea9e6169' WHERE AD_Column_ID=59328
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='e57328ad-d478-49de-92dc-7490e8fa55d0' WHERE AD_Column_ID=59329
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='7c2106fc-fa55-44d7-b530-542078549c30' WHERE AD_Column_ID=59330
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='9d0615ab-7cf1-4a55-8040-fd6cf5628e73' WHERE AD_Column_ID=59331
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='9239e878-cc01-4b8b-b989-c9684c8ad893' WHERE AD_Column_ID=59332
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='c69b59c4-7333-4fed-b452-43e3f1ff0808' WHERE AD_Column_ID=59333
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='bba8a754-d399-4cce-83d3-d990885fbf8b' WHERE AD_Column_ID=59334
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='c5f8c629-a473-4197-aced-2676f4ff6527' WHERE AD_Column_ID=59335
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='964709d4-603b-48b0-8e06-de08feef7e6f' WHERE AD_Column_ID=59336
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='594a6f2a-3e00-4920-9875-5f465f42918d' WHERE AD_Column_ID=59337
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='902f350a-ea79-4473-92d4-29913a0d7192' WHERE AD_Column_ID=59338
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='01a45054-abbb-49e3-8475-0b0af5d21391' WHERE AD_Column_ID=59339
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='c122cece-79d0-4377-9aed-369debffa8bf' WHERE AD_Column_ID=59340
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='d9ce99ae-9d0c-4742-aef3-6c410cc309ac' WHERE AD_Column_ID=59341
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='a7bbd20b-0ca9-476c-a1c1-5e72ee83464e' WHERE AD_Column_ID=59342
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='04829e81-2129-4896-92db-079c0f85fe8f' WHERE AD_Column_ID=59344
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='6574007c-46c2-45ad-a360-9977188c7e21' WHERE AD_Column_ID=59345
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='edaf0a44-892f-4200-8be1-6f6836ce2f85' WHERE AD_Column_ID=59346
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='7514a215-e070-4510-a654-cfed38795366' WHERE AD_Column_ID=59347
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='fa10f536-f4e7-4eb7-924b-c433d2cb95fb' WHERE AD_Column_ID=59348
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='25ddb871-74e0-4c2e-972b-dfcb3340fb9a' WHERE AD_Column_ID=59349
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='14a045e0-ce18-481e-a343-a4a440b91e04' WHERE AD_Column_ID=59350
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='b524fa9a-223d-4dc3-9f0b-f59d9d8cc76c' WHERE AD_Column_ID=59351
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='9239af9f-4b0e-4b40-8b67-183e5cc740d2' WHERE AD_Column_ID=59353
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='e2ef7326-6c87-44f4-b781-f12204da445e' WHERE AD_Column_ID=59354
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='4f2b3fe6-11ca-4fa5-bf77-0f0c57d71ef6' WHERE AD_Column_ID=59355
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='488aec70-a7f2-40a4-b135-ca61d3b0e510' WHERE AD_Column_ID=59356
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='a7c90b99-967b-4a48-b465-ca4a969d89f8' WHERE AD_Column_ID=59357
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='3470e7f3-90ee-4398-bfbc-c3267a7a1ff0' WHERE AD_Column_ID=59358
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='6b97a541-3e97-4163-9358-a83b76b63293' WHERE AD_Column_ID=59359
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='b39798fe-a780-4090-ac36-78ab6cef4cea' WHERE AD_Column_ID=59360
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='7acdf11e-157c-4b00-9353-a32fb5497b50' WHERE AD_Column_ID=59361
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='5e581604-27c0-499b-9467-b72da247c014' WHERE AD_Column_ID=59362
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='b96f5239-d029-482b-9284-219775f8cf26' WHERE AD_Column_ID=59363
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='b6c480b7-d1fc-41af-a470-4f7706794c75' WHERE AD_Column_ID=59364
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='aa50a913-bc8d-4e9e-92e9-f379d5bcdcfe' WHERE AD_Column_ID=59365
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='d717f00a-6b4a-4eb1-b86e-e51e58ddc4fc' WHERE AD_Column_ID=59366
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='54bfe28d-c43a-43f7-b760-7817c6abdfed' WHERE AD_Column_ID=59367
;

-- Oct 31, 2012 12:37:33 PM COT
UPDATE AD_Column SET AD_Column_UU='eb883da7-9e1a-40e7-9ff2-ada2976bf213' WHERE AD_Column_ID=59368
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='8699258a-77ac-4a16-828b-c816e47707fc' WHERE AD_Column_ID=59369
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='85a66f88-fffa-4c9b-8183-481bc72890c3' WHERE AD_Column_ID=59370
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='8a099125-edbe-4b63-847f-04005f75561d' WHERE AD_Column_ID=59371
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='5b6267b7-5115-492b-9c72-965061b50d13' WHERE AD_Column_ID=59372
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='c5dc406d-28e9-4ed6-8885-223543db7a33' WHERE AD_Column_ID=59373
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='24ae9e8a-039d-41d1-80c7-2a8ecff6b805' WHERE AD_Column_ID=59374
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='5439283c-0039-4823-8a1a-047d06a79bed' WHERE AD_Column_ID=59375
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='afcf3af6-5802-48f0-a168-fec1f999cb9c' WHERE AD_Column_ID=59376
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='759eb462-d43a-4d7b-9405-4ee8b688ee30' WHERE AD_Column_ID=59377
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='f3aef3d9-78d9-46c0-ba65-20f41843a2c4' WHERE AD_Column_ID=59378
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='efb15f6e-bd58-4c29-b859-0e1959531dea' WHERE AD_Column_ID=59379
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='057c184a-e87e-4135-b9a4-c9c6833bae7e' WHERE AD_Column_ID=59380
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='9bfbbd2d-05a7-4667-a851-9f87fb9dfb1a' WHERE AD_Column_ID=59381
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='e2f86183-daee-4cf9-bbbf-53921a77fa54' WHERE AD_Column_ID=59382
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='78ffc54d-bfb8-44c9-b6dd-4cf3692be4cd' WHERE AD_Column_ID=59383
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='45154a17-8892-437b-85ee-e2f726970afa' WHERE AD_Column_ID=59384
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='546c3cb5-4284-44a2-b7cb-a7a657201fa5' WHERE AD_Column_ID=59385
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='0defabcb-5830-4bb8-9e2f-a80361c65e7e' WHERE AD_Column_ID=59386
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='37563b27-3151-4a6d-80ef-b5b0c4c8205e' WHERE AD_Column_ID=59387
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='e154363a-a760-465e-ac7b-39d396921b8f' WHERE AD_Column_ID=59388
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='0f7de766-3eee-4743-b3a9-20443653308e' WHERE AD_Column_ID=59389
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='c72cb1f1-860a-4467-a42b-88ea50efa56c' WHERE AD_Column_ID=59390
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='1b9239bb-5a02-4a91-b876-8bdd28a9229b' WHERE AD_Column_ID=59391
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='2da8e020-9939-4245-90dc-b46f4a820878' WHERE AD_Column_ID=59392
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='12b4069b-c14e-4fb8-b525-8cb7abe17037' WHERE AD_Column_ID=59393
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='6c01e886-d68e-46a8-a0f0-97c04e86b93c' WHERE AD_Column_ID=59394
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='504fe566-7ed4-4de0-912e-fa57129ece3a' WHERE AD_Column_ID=59395
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='aa08d432-af27-4917-a21e-dd5f9861f252' WHERE AD_Column_ID=59396
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='1a321008-3f51-4eb5-ade9-52dcb9db5ad4' WHERE AD_Column_ID=59397
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='58a84e54-f23f-48f7-8f15-59b81ccce241' WHERE AD_Column_ID=59398
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='dd013b0b-82db-4b4c-bff4-906f86cb3e82' WHERE AD_Column_ID=59399
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='55417c6d-be77-42ee-9ccb-ff21b502469f' WHERE AD_Column_ID=59401
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='9f7dd18b-98db-4ae7-a2cb-91ec5bafc95b' WHERE AD_Column_ID=59402
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='2882f4a9-2ed5-4034-b490-027ef3560d11' WHERE AD_Column_ID=59403
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='42636b21-2172-416d-b5c6-c96c4e886b91' WHERE AD_Column_ID=59404
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='51b57e26-f1ea-4bb5-b652-f381c1bdcdc8' WHERE AD_Column_ID=59405
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='441b111e-6d81-4084-936d-699d7bca6a47' WHERE AD_Column_ID=59406
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='5d72e905-06ac-49cc-84fc-1f13840c87b3' WHERE AD_Column_ID=59407
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='c130413e-55e5-4d6f-8c8b-939920afb9ea' WHERE AD_Column_ID=59408
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='d6a45992-b37f-4c78-85b1-1586ee68b648' WHERE AD_Column_ID=59409
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='0da7a8f2-e811-4026-a61b-b706acfa88fe' WHERE AD_Column_ID=59410
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='35a693cf-6673-4600-b13e-3130c4fbf6a9' WHERE AD_Column_ID=59411
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='b36e50dc-22d4-4a42-8e57-21b607f8a5f3' WHERE AD_Column_ID=59412
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='03b7e235-ad37-4c74-9ebc-6ece51a791da' WHERE AD_Column_ID=59413
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='61396dfd-e6a7-4eef-8e97-2f813ec7524d' WHERE AD_Column_ID=59414
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='9657eb6c-a382-4207-9d17-fd8774e44994' WHERE AD_Column_ID=59415
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='88dc1582-efc0-49ad-b62b-0a3ce6c0db74' WHERE AD_Column_ID=59416
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='7493794d-5b84-4571-85ca-bf09e2cfcd86' WHERE AD_Column_ID=59417
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='27e3643c-48c1-47d0-b0ab-c805cf77af74' WHERE AD_Column_ID=59418
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='8c8703ca-15b0-4928-a498-353da75db383' WHERE AD_Column_ID=59419
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='b0b94f1d-cc40-4f8e-89fa-5e138ae3d6c9' WHERE AD_Column_ID=59420
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='f31d9f92-824b-4cc7-a6f5-b0bb4d3499b3' WHERE AD_Column_ID=59421
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='e3565a98-5997-448c-893c-c6e94c3d95f7' WHERE AD_Column_ID=59422
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='a32564ca-4b9b-4fdc-af83-1422b6e2b400' WHERE AD_Column_ID=59423
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='ffacb7a1-a48b-48dd-81a1-32923f7095fb' WHERE AD_Column_ID=59424
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='35f84f29-be10-43a8-b089-a4d843bc33bf' WHERE AD_Column_ID=59425
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='10dc4b8d-48ed-417c-a4fa-c746e8b14847' WHERE AD_Column_ID=59426
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='6642d215-5cbc-4f7c-af3b-2224e529aa4c' WHERE AD_Column_ID=59429
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='dfb6ff96-d0ee-49f5-8307-f71fee5c8e18' WHERE AD_Column_ID=59430
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='16be4721-5dc1-4836-915f-70305ed12c3c' WHERE AD_Column_ID=59431
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='d958899f-ecb8-480f-802a-d023448c5790' WHERE AD_Column_ID=59432
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='e3f0c8a6-85cd-45c7-991f-b00410d323b8' WHERE AD_Column_ID=59433
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='13be8f20-602b-4c6e-aea9-1eafc57d45ba' WHERE AD_Column_ID=59434
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='d8679cdc-0cf2-4f8b-a136-f9c407e3a494' WHERE AD_Column_ID=59435
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='1bda6fca-d377-45e5-9f6a-8804b632ce50' WHERE AD_Column_ID=59436
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='9cb50904-d20d-4c30-b0a4-b1ede46bda11' WHERE AD_Column_ID=59437
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='21a57cd4-83c7-4300-b026-e8832df82c5b' WHERE AD_Column_ID=59438
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='43915668-b1bc-40bc-bf47-337edb03ab20' WHERE AD_Column_ID=59439
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='387dbf8b-8792-4f7e-be40-ac44f34284ba' WHERE AD_Column_ID=59440
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='dbb13bda-3420-462e-985b-af0367391639' WHERE AD_Column_ID=59441
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='7648a4f7-e0de-4c06-ae1d-8cc2da03cd10' WHERE AD_Column_ID=59442
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='d0bd2b01-9cb6-4e34-a65a-1cf8f3d1d7e3' WHERE AD_Column_ID=59443
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='0a153fce-f56b-45ab-8f35-c39cbfe49e6e' WHERE AD_Column_ID=59444
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='bf23fab2-fd03-43e3-ab74-18165ac0040b' WHERE AD_Column_ID=59445
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='6301b5b8-3468-4d87-b5f0-621f5e2c5377' WHERE AD_Column_ID=59446
;

-- Oct 31, 2012 12:37:34 PM COT
UPDATE AD_Column SET AD_Column_UU='1a3b5d3e-9fce-4d9c-a1ca-7d614617e623' WHERE AD_Column_ID=59447
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='17cd0205-063e-417c-b195-330326f32454' WHERE AD_Column_ID=59448
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='7bc4f553-f6b3-4e68-bda0-dd015749c385' WHERE AD_Column_ID=59449
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='6b184fef-7dd7-404c-ba87-dedaad03da92' WHERE AD_Column_ID=59450
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='f444aa52-b934-4ac6-8e5c-e368691819f1' WHERE AD_Column_ID=59451
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='1bb25aa7-44f0-4786-becf-88621661bb51' WHERE AD_Column_ID=59452
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='3068ef16-821b-40a6-be25-cab6cc4e8f7a' WHERE AD_Column_ID=59453
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='f11abfd4-1e08-4143-9bb4-3053267e40db' WHERE AD_Column_ID=59454
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='0d31481b-96df-4ad9-9b13-d1c03d84107e' WHERE AD_Column_ID=59455
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='38aaaaaa-1f44-48b7-b9e1-592c1b938cf7' WHERE AD_Column_ID=59456
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='72405c67-2703-498b-b7d5-b680d689ed5a' WHERE AD_Column_ID=59457
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='001d1c41-d761-41dd-b19d-15e28c41831f' WHERE AD_Column_ID=59458
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='2661aec9-ef88-4d8a-a832-ab34ad6bd524' WHERE AD_Column_ID=59459
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='87c20b5e-f35f-4711-b334-c57a2c04e60c' WHERE AD_Column_ID=59460
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='c0d727aa-97a9-4991-950d-43c976cc2620' WHERE AD_Column_ID=59463
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='8eb740cb-841b-4e87-97fd-81dfbf795311' WHERE AD_Column_ID=59464
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='ab0ae479-dc31-4b76-8258-6be621c86d2c' WHERE AD_Column_ID=59465
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='cfc0112c-c0a7-4b28-ab6c-ee7c458e0e45' WHERE AD_Column_ID=59466
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='e0b870a1-c724-4c2a-a310-3b361bdea87c' WHERE AD_Column_ID=59467
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='6a776f4e-3372-4527-a6ad-99e806cb1573' WHERE AD_Column_ID=59468
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='21ea0faf-d65f-4c0a-9fd8-fa24902eb1e9' WHERE AD_Column_ID=59470
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='d2ace51a-cb99-4ec4-ba18-43297d2098c8' WHERE AD_Column_ID=59471
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='4a5a79b8-09b6-43cc-b8f8-bb80a848ac2b' WHERE AD_Column_ID=59472
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='15e76bb0-a635-44b3-a46a-bbe90e966d52' WHERE AD_Column_ID=59473
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='e5515444-0f6e-4449-a1b2-90403f30facf' WHERE AD_Column_ID=59474
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='8824d0e8-9e8e-4681-b9e2-6127b192bd60' WHERE AD_Column_ID=59475
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='450c55b5-9d1a-41be-9a6d-d25338b09f77' WHERE AD_Column_ID=59477
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='02c0c8cf-33c8-433f-9f6c-6b43edd75839' WHERE AD_Column_ID=59478
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='5011e5ba-8b6c-40ac-96dc-10b3dd422c22' WHERE AD_Column_ID=59479
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='dd174fd6-82c1-4f5d-a53d-874690163180' WHERE AD_Column_ID=59480
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='03d5c8c3-1d7d-441b-9878-4b35ea30ddd3' WHERE AD_Column_ID=59481
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='c54e9435-3805-4dc9-90ba-a7eb6e738247' WHERE AD_Column_ID=59482
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='0aecd37e-3d30-4b3c-9f6a-b1faf20937ef' WHERE AD_Column_ID=59483
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='f8dbfbb0-943c-4dd4-adef-077aaf86bfd3' WHERE AD_Column_ID=59484
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='7424fdf8-04cb-47f7-ac3c-014f2af5a8be' WHERE AD_Column_ID=59485
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='466094dd-ca70-466b-891b-9c1d65070db6' WHERE AD_Column_ID=59486
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='d3a7a1b6-9925-49e8-8524-e9bf88021ac1' WHERE AD_Column_ID=59487
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='d95f9139-458b-4dbd-91a6-4c1c0c3f00e8' WHERE AD_Column_ID=59488
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='b9bc9dc9-3ab1-432c-a207-61ad8bcbe2f4' WHERE AD_Column_ID=59489
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='85cc9785-3dea-4251-8c0e-e2db6044280a' WHERE AD_Column_ID=59491
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='f8523d32-64ba-40df-a04b-396eb784e240' WHERE AD_Column_ID=59492
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='04b1dae5-f1e7-4afb-9299-eb7499799eb0' WHERE AD_Column_ID=59493
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='9c65a8b0-7feb-48f8-a52a-189fafcaeb94' WHERE AD_Column_ID=59302
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='97df3ab9-6421-476b-98fd-d31e73ea71fe' WHERE AD_Column_ID=59343
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='520f6f68-bf0f-422c-a087-dc0c0b9cfbba' WHERE AD_Column_ID=59326
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='8eb67f70-1ba3-42c2-9f70-e5d68499e72f' WHERE AD_Column_ID=59427
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='ef606d00-512f-4719-b280-579d595a0235' WHERE AD_Column_ID=59496
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='d0e90a7e-e0f1-4dd7-97bc-c4251b5f5b39' WHERE AD_Column_ID=59497
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='44c448e5-e0f5-4ea2-be82-86a08db1e5b6' WHERE AD_Column_ID=59499
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='69c747ea-40ac-4c01-be66-2662b5a9379b' WHERE AD_Column_ID=59500
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='338de78b-7109-4340-8a8c-1e757ce300c5' WHERE AD_Column_ID=59501
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='1d51fcd6-3bd8-45af-b2d8-e8f12a71ed34' WHERE AD_Column_ID=59502
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='41b99a0f-cacf-4e85-b082-5c5b17d7357e' WHERE AD_Column_ID=59503
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='03f54cf3-d7f4-4d5b-9324-65c270ad3c00' WHERE AD_Column_ID=59504
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='28a4d18e-9bbf-4a94-8ea0-c51d111f2ad3' WHERE AD_Column_ID=59505
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='741df0fd-2023-480f-b69a-5ecd92e610cf' WHERE AD_Column_ID=59506
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='185b82da-d061-4031-a1cb-4e1accf08ea3' WHERE AD_Column_ID=59507
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='3fece34b-697e-470d-85f5-3834076ba4da' WHERE AD_Column_ID=59508
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='6cedc429-f088-4182-bb62-0b9fb0f67eec' WHERE AD_Column_ID=59509
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='0fd59656-e7a8-400d-a972-360fcba5b685' WHERE AD_Column_ID=59510
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='e58d36c1-00d2-4bb9-bdb4-d3505c18b45c' WHERE AD_Column_ID=59511
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='dabcdc75-076c-4c1c-8fbe-9121a6f8a685' WHERE AD_Column_ID=59512
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='5cf6151a-268a-425e-8918-ce3d8db3e969' WHERE AD_Column_ID=59513
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='d6d72317-4702-4cdb-9078-60c10c7c9aa7' WHERE AD_Column_ID=59514
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='97a71fcb-c8f5-4f27-a507-f1337c6b1a9f' WHERE AD_Column_ID=59515
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='4732d14d-84c3-4be7-b8fb-76af9ba545f8' WHERE AD_Column_ID=59516
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='36f6f9e5-b0b5-4da2-ba83-727d75950d71' WHERE AD_Column_ID=59517
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='59bed226-9290-4e96-954a-b6c2efd510e5' WHERE AD_Column_ID=59518
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='06ec5c2a-67ec-4cf9-83cc-cd70c4d6f7d7' WHERE AD_Column_ID=59519
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='efa00c3f-1cee-4736-8dd1-8d46d8d10874' WHERE AD_Column_ID=59520
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='fff7025c-4102-4df8-b380-cf10f7b3dc13' WHERE AD_Column_ID=59521
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='3291523d-20fc-491b-8261-07032f78e9ae' WHERE AD_Column_ID=59523
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='b6576e98-2c0b-440f-9c4b-fb809cd26a19' WHERE AD_Column_ID=59524
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='bb57aecd-685c-4bf0-a2cd-4c7c671fbada' WHERE AD_Column_ID=59525
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='2ac489fd-1132-4740-bf81-09cae8422f32' WHERE AD_Column_ID=59526
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='4adfee09-1005-426d-9296-264c88d61730' WHERE AD_Column_ID=59527
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='e037bbe6-712a-4d46-b603-33c4acc95122' WHERE AD_Column_ID=59528
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='4f747c84-d5bc-44cb-ac74-13ba7f66cca3' WHERE AD_Column_ID=59529
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='d9cdc7f2-4670-4fb2-a24d-3bb8832c49d6' WHERE AD_Column_ID=59530
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='25f9e30a-2d2c-4001-8bb3-6c997f8491dd' WHERE AD_Column_ID=59531
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='d78efb00-d832-45e0-80bb-49900cb5be5d' WHERE AD_Column_ID=59532
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='ea5e18f7-feeb-4264-930b-8fe7e026874a' WHERE AD_Column_ID=59533
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='d529a53d-55f9-4a91-bf4e-13a07e3f3275' WHERE AD_Column_ID=59534
;

-- Oct 31, 2012 12:37:35 PM COT
UPDATE AD_Column SET AD_Column_UU='2cbb016c-fcb8-42b5-a726-2c211db0b5a3' WHERE AD_Column_ID=59535
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='51ccdfd3-d31a-44a9-b3a8-1a58ef8056f2' WHERE AD_Column_ID=59536
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='eeb66667-9f54-4c8a-af0a-bdb2caee20a5' WHERE AD_Column_ID=59537
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='4559c48d-0a51-4ed6-b4f7-e749523a7893' WHERE AD_Column_ID=59538
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='7d3017b9-d488-466e-9d26-0193d65cfa03' WHERE AD_Column_ID=59539
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='18ec800c-e5cf-4f3b-b62f-2e7a6ec39f9a' WHERE AD_Column_ID=59522
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='7cbeb7a3-ec4c-41c9-8436-7d4d32744cac' WHERE AD_Column_ID=59498
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='99841acf-37b1-431e-a7eb-1012e2cbb03c' WHERE AD_Column_ID=59587
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='71df6d55-510c-436f-a091-ff0b2901d3c9' WHERE AD_Column_ID=59588
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='2b9e1567-7bdf-4bfb-b974-b923b6cd0cd1' WHERE AD_Column_ID=59589
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='0dd23954-8131-4cbb-a136-301cecbeac70' WHERE AD_Column_ID=59590
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='8a164482-25af-408c-99b8-155c19c6ec07' WHERE AD_Column_ID=59591
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='46d56e7f-ab4c-4cf6-b968-49daf7241df7' WHERE AD_Column_ID=59592
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='892e8823-c153-48a6-9f65-dbc2ad924e9a' WHERE AD_Column_ID=59593
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='2899493a-b2ce-47c7-8f7c-6da56d18d18d' WHERE AD_Column_ID=61470
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='ca6fb628-83d9-4e54-9377-70ce9800c37b' WHERE AD_Column_ID=59307
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='2fe1610b-fbcf-4281-b91c-4245365d618e' WHERE AD_Column_ID=59292
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='c744f58e-5e8f-480e-b65b-0c4d84799f2b' WHERE AD_Column_ID=59400
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='9eae08aa-ddd3-4ed3-bcf4-00700121dd3c' WHERE AD_Column_ID=59461
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='2392fae3-09e3-4d47-b5d8-fe23ef664172' WHERE AD_Column_ID=59462
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='e46aba37-b92b-498e-85ca-611fefbd5dad' WHERE AD_Column_ID=59469
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='05c86b88-d985-4f39-8454-159fcfaba602' WHERE AD_Column_ID=59476
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='98154498-34b2-4808-94b3-e4379914da8f' WHERE AD_Column_ID=59352
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='0f8ffecb-b4d2-4f88-889a-2498d3f558f5' WHERE AD_Column_ID=59283
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='371f6b39-b57b-4f4e-ac1b-5aa2e7c8bb42' WHERE AD_Column_ID=59284
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='ca384cd3-b6bf-41a6-bd35-c664e5997ce4' WHERE AD_Column_ID=200210
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='744551cd-44ef-43fa-af71-0db6f7e1f2d4' WHERE AD_Column_ID=200211
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='b25be366-718c-4528-bea7-5d1fb73904d9' WHERE AD_Column_ID=59282
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='ed4550ef-c554-469f-8f7e-c53bace3e977' WHERE AD_Column_ID=200587
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='28fffb91-c096-46d1-b759-d01bdb8134e1' WHERE AD_Column_ID=59494
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='7ee7e48c-6e7c-4d9c-9eae-5ca450b751ff' WHERE AD_Column_ID=59428
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='2cce08e1-00f5-49e8-a57e-75b213d32223' WHERE AD_Column_ID=59490
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='85bde74e-57f3-46d3-89c1-fe0107715860' WHERE AD_Column_ID=61471
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='f3c77fce-ded4-4efa-a65c-569671ada957' WHERE AD_Column_ID=200075
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='5e01f2e2-e886-4441-943c-c72831140bda' WHERE AD_Column_ID=200076
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='eeeb71ea-8ee1-4e7b-bf4b-dc6662f04652' WHERE AD_Column_ID=200252
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='d215cbb6-bc77-4a4e-a41a-dd934d828fee' WHERE AD_Column_ID=61943
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='43e25d02-ce57-4195-b12a-5772083c26b1' WHERE AD_Column_ID=61940
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='6ae8572b-c133-4546-8033-17ac51f40564' WHERE AD_Column_ID=61983
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='769cc5d2-7929-40bb-86a3-253cd2dd3678' WHERE AD_Column_ID=200509
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='225becbb-1224-461b-a47e-d7710ebcb8be' WHERE AD_Column_ID=200253
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='8c98f44c-0745-4d4c-baf7-bba4f6115ac6' WHERE AD_Column_ID=61945
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='d70554a1-9f2a-4696-a716-31af1689a807' WHERE AD_Column_ID=61971
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='b7e9bdb0-6667-4066-b31a-03c760959d5a' WHERE AD_Column_ID=61972
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='288325e0-2ef8-421a-80e6-654e26ba1058' WHERE AD_Column_ID=61973
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='4b5c6e18-f2c8-43db-9369-5c13e6dd34a3' WHERE AD_Column_ID=61974
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='57e08074-2723-4d85-9221-9a48502e251b' WHERE AD_Column_ID=62014
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='7acd1736-9c34-4fb6-b7ae-8ba3cbd9d266' WHERE AD_Column_ID=62015
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='33765c16-0fcc-401c-a398-5f14a80739ca' WHERE AD_Column_ID=62020
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='e9e7a69a-595b-4910-bee5-0b9461d29771' WHERE AD_Column_ID=62022
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='cb67b782-2660-4faf-9ad1-68f42501ccbf' WHERE AD_Column_ID=62023
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='05aac944-e26a-4062-92c3-c60749a2dd33' WHERE AD_Column_ID=200213
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='58e36cff-7cf5-4374-b415-59acd8a3f56b' WHERE AD_Column_ID=62019
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='707d999c-0701-41cb-9a79-924e2a961561' WHERE AD_Column_ID=200214
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='29d54d37-e729-4cf0-a3df-c8f9c9100fb0' WHERE AD_Column_ID=62026
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='8e240462-76ba-4b8d-83cc-ba2636cbb29d' WHERE AD_Column_ID=200212
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='2fc7b9d9-f7bd-48fb-a006-630f6bc1aef9' WHERE AD_Column_ID=59962
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='60056d6d-0d84-433e-a686-0b441918b804' WHERE AD_Column_ID=59963
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='244a5ed0-d5a2-4513-b2ce-1f8936591161' WHERE AD_Column_ID=59964
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='947336cc-c4cd-49d8-90b1-ae6880de39ab' WHERE AD_Column_ID=59966
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='70aeafc6-60b9-421f-9597-5c681e7c671e' WHERE AD_Column_ID=59960
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='2708310e-5aab-42f9-9633-ed0d10e3d604' WHERE AD_Column_ID=59967
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='350948b5-954f-4ddb-8767-14e890d48cb6' WHERE AD_Column_ID=61944
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='11711850-ff10-4a1a-8d3c-5e16acf144d3' WHERE AD_Column_ID=200241
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='a3d4b525-ee1a-4d45-9215-8a708448543e' WHERE AD_Column_ID=61941
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='31a956e6-84eb-4d8c-a123-8cfded8b7861' WHERE AD_Column_ID=61942
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='78b6bb32-be4a-479f-933c-f71f397a331d' WHERE AD_Column_ID=62017
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='d35a6f87-00ae-4e29-8896-47f3eb49945b' WHERE AD_Column_ID=62018
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='1365d70b-3b32-42a5-9ec1-df2df53f2e79' WHERE AD_Column_ID=61970
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='3ff8b7b6-c8ce-4226-9efc-856ecd3703b7' WHERE AD_Column_ID=61992
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='b786c056-d65e-41af-9604-e30eb5e67609' WHERE AD_Column_ID=61946
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='c195455d-eec9-4112-b8e6-f1426300bc55' WHERE AD_Column_ID=61947
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='1f6c2a80-dd7e-4af8-a55d-36973d784859' WHERE AD_Column_ID=61948
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='80f49c1f-739d-4fed-85a8-281fabdbfa1e' WHERE AD_Column_ID=61981
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='ac56ad55-230b-423a-bfb2-6c1bb7fefc06' WHERE AD_Column_ID=61949
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='47539e97-5160-420a-84f8-0b3e7ded9b97' WHERE AD_Column_ID=61951
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='e992dca2-7108-4556-b95f-0c089de50116' WHERE AD_Column_ID=61952
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='ad119262-eee6-4741-9e26-bd32f1f9001e' WHERE AD_Column_ID=61954
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='5e85cb6a-d0fc-4ae7-8e28-09a22b1ebf50' WHERE AD_Column_ID=61955
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='f4b61026-232f-46d4-885c-2605dd5eacab' WHERE AD_Column_ID=61956
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='54acdec8-b814-451d-b9cb-ae63dc29d42c' WHERE AD_Column_ID=61957
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='3df0c541-1031-4592-96c8-67c052064777' WHERE AD_Column_ID=61958
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='654b89e2-5c8d-490d-9e5b-efe58f54a92a' WHERE AD_Column_ID=61959
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='da724dcf-78e2-48bd-a125-fe5db1b37615' WHERE AD_Column_ID=61960
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='f242e745-374b-47b6-9d31-c360405ea902' WHERE AD_Column_ID=61961
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='64809848-0628-46ad-b50a-8f05f9a75acd' WHERE AD_Column_ID=61962
;

-- Oct 31, 2012 12:37:36 PM COT
UPDATE AD_Column SET AD_Column_UU='07a0fd6d-21fc-4d32-bcf0-29772ebfae7a' WHERE AD_Column_ID=61963
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='0b9391b4-e2e4-4052-a098-7876e77c458d' WHERE AD_Column_ID=61964
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='50f287a0-ae6d-455d-8936-d84f8238bacc' WHERE AD_Column_ID=61966
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='5bff0b33-b7f7-455e-b078-5310815d2848' WHERE AD_Column_ID=61967
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='f56a9cfe-63e6-4656-a15e-f0df76f9587a' WHERE AD_Column_ID=61968
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='6364c53a-99bf-49e4-a4d8-c93b2593a041' WHERE AD_Column_ID=61993
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='49adee10-01d5-4cf0-aa22-b9c831b3d21a' WHERE AD_Column_ID=61975
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='0c5b70db-a69b-42ec-97f7-6d2a32952a7e' WHERE AD_Column_ID=61977
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='5f4d7f11-6b31-4186-bcb9-93df0820610c' WHERE AD_Column_ID=61978
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='b31eb59b-9fb4-4b9a-b697-ca54cdcc2a45' WHERE AD_Column_ID=61980
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='9a95f2e3-fcf4-4b2b-9be5-bbd840520c99' WHERE AD_Column_ID=61982
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='e7db1d89-5c8d-4a80-b745-ec8a037161f2' WHERE AD_Column_ID=61984
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='a43b3f02-af9d-4658-ba38-8a42c75e813f' WHERE AD_Column_ID=61985
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='9df2f863-d9c5-46e9-8456-930fafb76d3d' WHERE AD_Column_ID=61986
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='8022dddf-0ca3-4d26-9c8b-6601775db485' WHERE AD_Column_ID=61988
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='27d39df7-126b-4557-ae54-4bdc44ac37f1' WHERE AD_Column_ID=61989
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='872b740c-9473-4b8a-9c4b-c0e5da22fa5e' WHERE AD_Column_ID=61991
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='cb7ca15d-5322-4c86-b822-7e80c48d6469' WHERE AD_Column_ID=61994
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='787e3cee-81e1-4fda-a146-e928b78f8887' WHERE AD_Column_ID=61995
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='43bee906-7866-4cbe-b74f-2b1b5f4197c1' WHERE AD_Column_ID=61996
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='3fc4363d-bf42-4e45-b203-603ac57abc49' WHERE AD_Column_ID=61997
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='8503d6a1-0efc-4d9e-9270-e8a4cfe54b02' WHERE AD_Column_ID=61998
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='2396e7e2-c2ee-4ef2-a538-c52acb69787b' WHERE AD_Column_ID=62000
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='aea2a0dc-f01a-4be0-9ddf-cb8d0d49d206' WHERE AD_Column_ID=62001
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='8d321329-bc4e-4136-a100-32c9c49a3d9e' WHERE AD_Column_ID=62002
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='741f4a1f-85a4-413a-8d7d-dd2cb21bcc27' WHERE AD_Column_ID=62003
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='1220b3ba-9f16-4049-a46f-d5b5de4980c7' WHERE AD_Column_ID=62004
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='d71214b9-c8a5-4ed2-b6e3-bea109cccabb' WHERE AD_Column_ID=62005
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='01e50f3a-7823-45dc-b88d-59771322d4f1' WHERE AD_Column_ID=62007
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='24dd7c71-2509-49ab-b90b-c366273cd706' WHERE AD_Column_ID=62008
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='812d6e92-91c9-456d-bdd9-e2e1b34a1011' WHERE AD_Column_ID=62009
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='cccffb77-508a-4ba6-829c-8b8d5874b8d6' WHERE AD_Column_ID=62010
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='4999e158-3c89-4831-8fde-ed897a100d6e' WHERE AD_Column_ID=62011
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='dba9a056-0f2f-447c-8bcc-863030737397' WHERE AD_Column_ID=62012
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='db79afa1-7b3d-4f80-88f4-20815723ef66' WHERE AD_Column_ID=62024
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='441d7847-f9ed-4c7f-9016-0a082964e2e9' WHERE AD_Column_ID=62025
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='9ab694f7-1b65-4635-951f-8cf6d21e10f9' WHERE AD_Column_ID=62027
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='0bc58aa9-4520-452a-8279-0570d65cb5a7' WHERE AD_Column_ID=61804
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='32f75810-4445-4b71-88c6-b8c5781abda4' WHERE AD_Column_ID=200517
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='f56dc78d-d993-472b-be45-4a62ff0f4e80' WHERE AD_Column_ID=200518
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='c09aae82-a556-42c3-9c5e-33946b8a8fa0' WHERE AD_Column_ID=200519
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='0c4dd1fc-6471-46c2-b3cf-53a406054583' WHERE AD_Column_ID=200520
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='3feba486-d1b4-44ad-97b7-bffc12f67022' WHERE AD_Column_ID=200524
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='06980c54-58d1-45f3-988c-5a0bf982b464' WHERE AD_Column_ID=200521
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='31ee6634-8742-4616-9e26-aa3213eb384e' WHERE AD_Column_ID=200525
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='039a6b4e-1d08-4904-9ee9-740aa8ac353b' WHERE AD_Column_ID=200526
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='6e4e92c9-c261-4fe6-83e6-f3cc0466833b' WHERE AD_Column_ID=200522
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='39b50957-05dc-407b-8124-70afbd54ebbf' WHERE AD_Column_ID=200523
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='2feff17e-fe9e-4c7b-a210-07985738e9e1' WHERE AD_Column_ID=200529
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='23ef2dee-0091-4e40-a085-5f93c3c97385' WHERE AD_Column_ID=200527
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='6af8d3e7-a235-480b-a2b1-fb27151318ae' WHERE AD_Column_ID=200530
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='b596aa59-8b61-4555-ab2e-50dfaca33281' WHERE AD_Column_ID=200531
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='2de254fb-8ab7-40f1-b9c0-a289cf7a4f53' WHERE AD_Column_ID=200532
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='227aabdb-dbc5-438a-bb8b-7d52dd36071e' WHERE AD_Column_ID=200533
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='13da0b8a-a652-49b1-bdcf-45aefeb637e7' WHERE AD_Column_ID=200534
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='13e00eda-f924-4d05-96bf-0de0657b16ba' WHERE AD_Column_ID=200535
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='93c2f3bd-f544-43af-8fde-82033e30326a' WHERE AD_Column_ID=200536
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='b39725ba-2ab0-4b14-ba0b-d8e99e48fd87' WHERE AD_Column_ID=200537
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='e8b078bb-3377-4a06-98c3-95dd46cb97d4' WHERE AD_Column_ID=200497
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='c92c027c-577d-4a47-b023-2374f068f981' WHERE AD_Column_ID=200538
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='6d5b7d9b-0ed1-4271-82c5-db241c459387' WHERE AD_Column_ID=200494
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='e84f507e-ac82-4b09-b298-227135b19346' WHERE AD_Column_ID=200495
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='5f3e6eac-4868-44c9-acff-3e1af4b51503' WHERE AD_Column_ID=200496
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='30d0d946-aadc-4997-aa94-4f35d6f4e277' WHERE AD_Column_ID=200498
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='80a68c3c-0a9c-45e1-9159-9e0b571e8e96' WHERE AD_Column_ID=200499
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='9693c2d6-7755-45ae-80b1-1587fd3f56a3' WHERE AD_Column_ID=200500
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='bb2d3678-ad44-49fe-aa1b-dc8fe9e5f742' WHERE AD_Column_ID=200501
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='f1c7ad68-9473-45ae-9e7a-4d4d6b6552fe' WHERE AD_Column_ID=200502
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='74586716-f39d-4dac-bc28-dfd6732c59d3' WHERE AD_Column_ID=200503
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='19e08a98-f527-4bc5-81e2-b51975dc44f4' WHERE AD_Column_ID=200504
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='6c4c9f5f-1db4-480b-b039-66bad1439b8d' WHERE AD_Column_ID=200505
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='990f459c-e8ba-4093-9715-b8c2d0a8dbb0' WHERE AD_Column_ID=200506
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='4b73d330-1869-4c38-b88e-f1e24a53c1fc' WHERE AD_Column_ID=200507
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='4ccf117a-00a4-492b-92dd-ca777105390d' WHERE AD_Column_ID=200508
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='818069c9-4fc1-4057-86b0-caf69e5b3b3c' WHERE AD_Column_ID=200510
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='325da436-8934-4143-bb91-ca8c5c207ee3' WHERE AD_Column_ID=200511
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='96d16f72-09c9-4fb7-9b96-9ce8bae8c2be' WHERE AD_Column_ID=200512
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='1f70bd7a-1023-45cd-a643-b517a1377057' WHERE AD_Column_ID=200513
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='e4e599f4-f705-48ad-8903-957bbf463faf' WHERE AD_Column_ID=200514
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='f0909a4f-b1a7-4645-a6cf-10473510fcde' WHERE AD_Column_ID=200515
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='59b3afbb-dd74-45bc-b954-8f6b9c122f65' WHERE AD_Column_ID=200516
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='a1f6bd6f-4e0f-478d-b0d0-5e224e0025db' WHERE AD_Column_ID=200539
;

-- Oct 31, 2012 12:37:37 PM COT
UPDATE AD_Column SET AD_Column_UU='0b4697d7-b8c3-49ad-8e0c-b0c5bc766e1f' WHERE AD_Column_ID=200540
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='5c91bf21-b6e3-4db3-b88e-91f66a1a98fe' WHERE AD_Column_ID=200541
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='3f4918da-e253-4f42-9c26-6badae2ee4ca' WHERE AD_Column_ID=200542
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='6020f4ed-d7ee-439e-98fa-92a491304d9b' WHERE AD_Column_ID=200543
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='82db4896-7b84-4734-ac5b-313da2aab663' WHERE AD_Column_ID=200544
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='182169a3-4a26-490a-b3d6-87141d33d8ce' WHERE AD_Column_ID=200545
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='17c3f64f-6f9b-4896-851a-0fb36de85bb9' WHERE AD_Column_ID=200546
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='2a6a2719-ba27-4834-a5c7-b16422c97eb7' WHERE AD_Column_ID=200528
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='8baf3ea2-9355-4e76-b204-8dcd99ec21d8' WHERE AD_Column_ID=59961
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='4190130f-9488-440f-9de9-0fbb75f4cdab' WHERE AD_Column_ID=200242
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='ddaf01c7-e4a7-4aff-8d73-30782fc264cc' WHERE AD_Column_ID=61950
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='7ba4bc1d-05b0-489b-8cb4-334e8518b62b' WHERE AD_Column_ID=61953
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='9af63eea-3f75-4e1e-b3d3-9afb97f10fb6' WHERE AD_Column_ID=61965
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='17ed35d9-b696-437f-97d0-25eca611b274' WHERE AD_Column_ID=61969
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='0bd12687-c0c0-4cb7-a7da-1d474cb00ccc' WHERE AD_Column_ID=61976
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='89d2a934-64dd-450b-8fa4-71217920ba8a' WHERE AD_Column_ID=61979
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='b3256d65-cd61-406e-b299-70b5295cb5c7' WHERE AD_Column_ID=61987
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='fb689b27-b5f6-413e-aae7-18a1054dac1a' WHERE AD_Column_ID=61990
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='1b65b99c-1b91-418c-9211-28e34dbeb9fd' WHERE AD_Column_ID=61999
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='8c220003-0462-4306-bbcd-c2ab77a08e58' WHERE AD_Column_ID=62006
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='5573c58f-48be-42a4-8ecb-a03319274bbe' WHERE AD_Column_ID=62013
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='449a0f11-654e-471b-b33d-23dd67149552' WHERE AD_Column_ID=62016
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='f0709181-ffeb-494a-a9d4-a42b8603f967' WHERE AD_Column_ID=62021
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='adca00a1-58b5-4620-9525-0f2d5e69011f' WHERE AD_Column_ID=59251
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='e20d124f-1b41-489c-a33c-7dd7b5c87f38' WHERE AD_Column_ID=59252
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Column SET AD_Column_UU='6d59ada1-a9e8-406f-845b-255d7ec94c6f' WHERE AD_Column_ID=59253
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='99a103d1-6790-49b6-b75b-9b7a0aa7e6f9' WHERE AD_Element_ID=55245
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='f0d4937f-56e7-465a-bfe2-720b436d4cd4' WHERE AD_Element_ID=200060
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='528f17a6-0e1f-4a34-8b22-290aae34ec1c' WHERE AD_Element_ID=200061
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='6baa93cb-422c-4eae-a595-0ffb1e734d1e' WHERE AD_Element_ID=200062
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='f0d67a54-4f2a-43ff-8b42-3013caeda7fa' WHERE AD_Element_ID=55243
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='5eb7a9bb-9bb0-4c2c-9b25-b2751b7cae22' WHERE AD_Element_ID=55236
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='eaff36db-ab9b-4a89-8f83-d6e61020ac6e' WHERE AD_Element_ID=55237
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='a9547a2c-99ed-4d2f-9934-ba060c40ec27' WHERE AD_Element_ID=55238
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='edcc00f2-cde6-4bd4-a4e2-5b4b62a28bf6' WHERE AD_Element_ID=55239
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='c6c38450-1d10-4255-a5a8-22e4065eea3a' WHERE AD_Element_ID=55240
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='f7d8b869-fbdb-4c33-83ec-7aa9ee596f65' WHERE AD_Element_ID=55241
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='7b16217b-44e7-483b-b4f9-398c3f767f1a' WHERE AD_Element_ID=55242
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='288503f5-199b-4d4d-9b97-f961dd6f7a30' WHERE AD_Element_ID=55244
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='3100ea04-b3cf-467f-a838-8e46f306c870' WHERE AD_Element_ID=55246
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='30e3c7e4-51b4-480e-aff6-dcf38bfcdd53' WHERE AD_Element_ID=55247
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='abf42d84-e750-481e-b7ce-982bf760fc74' WHERE AD_Element_ID=55248
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='5117b821-b38d-4075-97e8-c6e6b5b8ecda' WHERE AD_Element_ID=200080
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='7230545e-e974-412f-8312-79fd4fcbb721' WHERE AD_Element_ID=200134
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='e0a11afc-9a96-4176-bc44-cb68ee6ae2be' WHERE AD_Element_ID=200135
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='7f9725a7-fce3-46ee-850a-7c6639b80ba4' WHERE AD_Element_ID=200136
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='e603e57e-44a1-4941-b686-fd71603a3118' WHERE AD_Element_ID=200137
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='ce08f4fa-8224-46f7-b4ca-b7ef0c28aee1' WHERE AD_Element_ID=200138
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='d01e15bd-0187-42eb-9447-901afdbc266f' WHERE AD_Element_ID=200139
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='cdec36c7-7056-4e96-b7c7-9b63c2f807f8' WHERE AD_Element_ID=200140
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='881406a9-446f-480f-8e21-b18fbcd843fa' WHERE AD_Element_ID=200141
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='db54dbc1-5bd7-425b-a034-8b24d727603b' WHERE AD_Element_ID=200142
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='746b6910-798b-4101-b5d7-e148a79c8a20' WHERE AD_Element_ID=200143
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='0e4cd5fa-e01d-4573-8bfa-020c2faaf1b6' WHERE AD_Element_ID=200144
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='a7c65caa-1e20-419b-95a3-e33403424b94' WHERE AD_Element_ID=200145
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='bb67e466-b30b-4b21-a2f3-0e5fec1da09a' WHERE AD_Element_ID=200146
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='d362f729-7a90-4bf2-934c-51953c74954a' WHERE AD_Element_ID=54165
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='b92d9612-cc75-4bfd-b380-2fa06d54aa4e' WHERE AD_Element_ID=54166
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='24778f4b-e57e-48d1-89d8-3c29b0a0ec8c' WHERE AD_Element_ID=54167
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='d6944a27-6702-4116-a983-d336a7cc69f1' WHERE AD_Element_ID=54168
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='ceecb012-3cef-40ac-b342-c53f41a6b9ab' WHERE AD_Element_ID=54169
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='52ce6e5c-ace3-4eb7-a855-f6645fdff89b' WHERE AD_Element_ID=54170
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='b124bd67-39ed-4819-9010-bfa057bba0e1' WHERE AD_Element_ID=54172
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='c862f067-69af-4c40-9918-9837130eb74a' WHERE AD_Element_ID=54173
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='c7a75427-08dd-47f4-ad74-ccbd9df13b2d' WHERE AD_Element_ID=54174
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='d00a01f7-9edf-4047-a472-487e3689f998' WHERE AD_Element_ID=54175
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='e718ec0f-55ee-42b7-b4ef-a40b1dff7fd1' WHERE AD_Element_ID=54176
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='729f29bb-0374-48e0-aa7e-2941ff36e7b7' WHERE AD_Element_ID=54177
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='52977e4f-de04-4bf7-b27a-4a5bc5f7daac' WHERE AD_Element_ID=54178
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='3cfea474-6e44-4ea6-9b40-2fc31a193ea3' WHERE AD_Element_ID=54179
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='9bc4d835-6e59-41f1-b4dc-b0cf1a94bcd9' WHERE AD_Element_ID=54180
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='6f2298a4-fd2f-4c98-a39c-9ad619cee230' WHERE AD_Element_ID=54181
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='d9402fc7-7cb4-45e0-aadc-c6c74340d055' WHERE AD_Element_ID=54182
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='926a1290-7f75-49d9-975b-a3cff9edd87a' WHERE AD_Element_ID=54183
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='4b24b0bf-5b86-4e7b-aaf9-84c938734357' WHERE AD_Element_ID=54184
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='bcdb846a-0e66-4fde-b676-894b066c0a27' WHERE AD_Element_ID=54185
;

-- Oct 31, 2012 12:37:38 PM COT
UPDATE AD_Element SET AD_Element_UU='2f40fded-6c1c-4984-aa29-ce9cb7218ace' WHERE AD_Element_ID=54189
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='8d64b35f-08e1-446e-a727-b5c2ef730351' WHERE AD_Element_ID=54190
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='a4151a44-f0a6-4bde-ba56-01d05bf75c9a' WHERE AD_Element_ID=54191
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='a1521771-b409-4d15-8de5-0a342db4a5ac' WHERE AD_Element_ID=54192
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='66934992-bb6d-4109-9c59-308d982c0a1d' WHERE AD_Element_ID=54193
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='ce4d30ef-961b-4498-9ba1-0e2f018bcf58' WHERE AD_Element_ID=54194
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='5fcb4eb3-2b38-4b83-93b5-b0e2b54d93e0' WHERE AD_Element_ID=54196
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='5eeb9d01-913f-4a8f-8110-3585b49a2e63' WHERE AD_Element_ID=54197
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='7b2c2821-4399-44d8-910d-a73af07d791d' WHERE AD_Element_ID=54198
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='8179e80d-1c41-4286-ba89-5607c0c32f24' WHERE AD_Element_ID=54199
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='d3750c78-4f39-40a9-842a-df0e59a8b735' WHERE AD_Element_ID=54200
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='04023360-b7fd-40cf-be60-9aa4da62963a' WHERE AD_Element_ID=54201
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='609bbd6f-fa69-490e-9957-ed7c5e5bf252' WHERE AD_Element_ID=54188
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='c9866577-8e81-413e-bdd7-af2d613f04f7' WHERE AD_Element_ID=54187
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='328bf53c-cd56-4ec4-b470-4bffdde508a4' WHERE AD_Element_ID=54186
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='f4d4b72e-3b43-4507-a619-26bf5e955592' WHERE AD_Element_ID=54195
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='7b19f9e1-e913-4271-8665-14c56893d6fd' WHERE AD_Element_ID=54171
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='ddeca23f-738e-4f18-b839-49a0becd76d7' WHERE AD_Element_ID=54202
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='cdf56abe-8aae-419e-a227-d11e7183fea6' WHERE AD_Element_ID=54203
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='24c8c328-3637-4da0-bef3-8e21ad5a881b' WHERE AD_Element_ID=54204
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='bc8dc29d-2306-47b3-9698-21c023571bc5' WHERE AD_Element_ID=54205
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='ccc6c860-4649-491d-a713-103db8efcc22' WHERE AD_Element_ID=54206
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='b4d87e87-1a62-4c27-9543-cc1632db20a2' WHERE AD_Element_ID=54207
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='eca981d9-87f5-4aa0-b8de-908bc528921e' WHERE AD_Element_ID=54208
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='23ea7f4b-35d5-4bb9-a4f3-d539d803c8c9' WHERE AD_Element_ID=54209
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='fcb8aa99-14da-4155-902a-f23a16d48cc5' WHERE AD_Element_ID=54210
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='89257618-9a69-47e7-8f38-f50500881656' WHERE AD_Element_ID=54211
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='5b5018c0-ac23-4ada-b973-fca9b4eda8c3' WHERE AD_Element_ID=54212
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='f1ae1dd6-6499-440c-a039-8eaefb3ee63b' WHERE AD_Element_ID=54213
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='ff4b7661-e014-4dd8-92e1-7854be6c99bc' WHERE AD_Element_ID=54214
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='68365552-5257-4afd-afc2-7c01cf8f6be4' WHERE AD_Element_ID=54215
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='c2415533-bb0c-44b1-8619-122376c7b4f7' WHERE AD_Element_ID=54216
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='855a740a-c1b9-4bf0-9546-6d3781d7f203' WHERE AD_Element_ID=54217
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='2d3feb44-5855-4529-a89d-f755c869921d' WHERE AD_Element_ID=54218
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='c87fd47b-2a7c-4270-a210-299988e3f9fe' WHERE AD_Element_ID=54219
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='dc9808bc-75bd-4a44-b0ed-02844b58b794' WHERE AD_Element_ID=54220
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='876d035d-b6a8-4fc2-a463-c26819267b63' WHERE AD_Element_ID=54221
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='0494630e-93f9-4006-ae49-edae24494d46' WHERE AD_Element_ID=54222
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='11b1cabc-bcd3-4943-a55d-52f5350883c7' WHERE AD_Element_ID=54223
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='d7c8de47-d8dd-45d1-ab63-7cca874d7b02' WHERE AD_Element_ID=54224
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='c6b957c2-33f6-4b50-bfd5-5e15da1b2150' WHERE AD_Element_ID=54225
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='7bdacf37-0c45-4c0e-9038-ffee4656537a' WHERE AD_Element_ID=54226
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='33218840-96eb-46c1-9153-170d838d46f8' WHERE AD_Element_ID=54227
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='059ec1ab-7e4f-46e7-9ec1-fa19261f4abf' WHERE AD_Element_ID=54231
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='dbdd7a05-796d-4691-ac4a-a78ed0df8438' WHERE AD_Element_ID=54229
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='8e7d7983-3e6b-4b27-ab4f-31ea0ce8c98f' WHERE AD_Element_ID=54228
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='978839d9-9926-4c64-8d7c-be6eba061c96' WHERE AD_Element_ID=54230
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='d2286051-5fb9-43ac-bd9b-dd760deb1402' WHERE AD_Element_ID=54233
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='b5a7dc7f-7d44-47fb-aec8-e111c1a37314' WHERE AD_Element_ID=54234
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='97b8e15d-59b6-43fb-bb46-e408f0072656' WHERE AD_Element_ID=54235
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='51d5d2d0-2218-4cfe-8ddf-121460e16f13' WHERE AD_Element_ID=54236
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='69b8c90b-b34a-4857-9439-ea57a9fa6818' WHERE AD_Element_ID=54237
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='8a1da7c0-a24d-4538-b019-970fa8cb8271' WHERE AD_Element_ID=54244
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='798a24ee-b601-4a46-9a87-016e90809d1c' WHERE AD_Element_ID=55168
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='307889f9-597f-41aa-99d1-2e6ebdb58ce4' WHERE AD_Element_ID=200015
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='4a3e9eef-5f5e-4110-b61b-2cd5dfffbe66' WHERE AD_Element_ID=200176
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Element SET AD_Element_UU='6a91f10b-45a4-4d7c-8c1c-ab5401e08343' WHERE AD_Element_ID=200079
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='1389b4d0-de95-4060-baa2-df37cd9bfab5' WHERE AD_Field_ID=59827
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='61c6d57c-d1bb-4850-a844-e3771ae35199' WHERE AD_Field_ID=200511
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='e8e9106b-1844-4dda-8ba5-8d776d86d17c' WHERE AD_Field_ID=200516
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='888e22ec-61f2-45ba-9c3d-3355b0e37660' WHERE AD_Field_ID=200520
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='f3ea7baf-268b-4b44-bb41-7f30e6b77704' WHERE AD_Field_ID=200512
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='36a25ec6-dffb-430c-a351-1ee449e70f7d' WHERE AD_Field_ID=200513
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='49fd1997-b262-4e9b-8c9a-40797d6efeff' WHERE AD_Field_ID=200514
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='6ed3b030-bf4b-4731-af84-2e8d1f2d0278' WHERE AD_Field_ID=200515
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='22e88f43-b5be-4892-9584-cf7f7f8e53f8' WHERE AD_Field_ID=200539
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='f0173a89-e4e5-4560-9269-64babe898752' WHERE AD_Field_ID=200521
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='7c20f055-1adb-4a78-8474-e8738401d4d5' WHERE AD_Field_ID=200542
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='20881e4a-7052-4883-9a85-7346c6e1a6f7' WHERE AD_Field_ID=200537
;

-- Oct 31, 2012 12:37:39 PM COT
UPDATE AD_Field SET AD_Field_UU='961fdfd9-1b61-4c06-b692-d50fad95a222' WHERE AD_Field_ID=59825
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='eef8f7d5-8455-4cce-b187-8d1d165c02cf' WHERE AD_Field_ID=200546
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='3cfea46d-fe9f-4d06-9f57-da31331ef485' WHERE AD_Field_ID=200522
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='5d19ead3-3b72-411c-854f-4375a383175d' WHERE AD_Field_ID=62011
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='e053084f-eb01-415a-ae42-43d3e1cb6bff' WHERE AD_Field_ID=59816
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='ada404a4-1d81-475d-adbe-88a2383bb15a' WHERE AD_Field_ID=200258
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='6136ddf3-69b2-4d6e-911e-6a135a6b5089' WHERE AD_Field_ID=61975
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='44c30f54-b844-4c11-bf33-1604bac48b95' WHERE AD_Field_ID=59760
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='8fb0db78-bd63-44d2-b408-0eec6486a5d5' WHERE AD_Field_ID=61995
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='469f81f2-a590-485f-9bf9-5ed4a0924b5a' WHERE AD_Field_ID=62002
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='c4e1a6d5-209e-4bf9-8f5e-43dc053ed9e4' WHERE AD_Field_ID=59321
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='2f5c51ab-dddf-4275-a197-fce5714e509d' WHERE AD_Field_ID=59780
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='4639adb7-4ee1-4ee2-bb98-6702194fb6e0' WHERE AD_Field_ID=59830
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='9d95b9c2-7d23-45f1-a61b-72e0e7d61607' WHERE AD_Field_ID=62007
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='c1f594ee-9c03-4c14-9a7a-6a4314b1c318' WHERE AD_Field_ID=59815
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='795a80f2-5874-49bb-9cac-1e551fef0f40' WHERE AD_Field_ID=62003
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='075b1df7-5cce-487c-afcf-447003aa466a' WHERE AD_Field_ID=59834
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='82731773-518f-41a2-9e4d-1552e7595362' WHERE AD_Field_ID=59748
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='e6b8a1f4-5efa-4d9f-a997-6d7df764c4ab' WHERE AD_Field_ID=59737
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='d4c00088-23ae-4ef8-bf1d-6478908e5d1c' WHERE AD_Field_ID=200164
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='10a85648-7c4b-49b8-b0d4-a57e3ee295f5' WHERE AD_Field_ID=200162
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='89595c8a-8a63-41c4-abf7-fd55b2b7848a' WHERE AD_Field_ID=59739
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='dda984b7-c0c9-4527-9747-01bcd5c7375e' WHERE AD_Field_ID=59738
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='38c7760c-60f0-4a66-87ad-d0b9aec5130f' WHERE AD_Field_ID=59751
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='95a02a2b-af90-4819-911a-2cd9244ece9f' WHERE AD_Field_ID=59736
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='8ae202d5-6ff1-4e00-b9ad-f06e61208237' WHERE AD_Field_ID=59740
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='27cefb10-dc48-44fe-abc0-a4a1703babc0' WHERE AD_Field_ID=59754
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='8ebf9674-4a0b-4ba5-a99b-3c43d9866ea4' WHERE AD_Field_ID=59758
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='84a6f5c1-be89-418e-9ae8-774542c341ee' WHERE AD_Field_ID=59752
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='578d1bad-2804-4542-a871-3f61779fc487' WHERE AD_Field_ID=59756
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='9550c2cc-219b-4110-9508-3aacf7613e66' WHERE AD_Field_ID=59800
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='af44b95e-a11c-440c-9be6-4b4bca93a942' WHERE AD_Field_ID=59796
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='a4455677-ec3c-4002-8259-2f742a8046c7' WHERE AD_Field_ID=59778
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='33934334-37a6-4b63-9305-15611583faec' WHERE AD_Field_ID=59779
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='4ea489eb-8d46-4fcb-812c-81d0c6555859' WHERE AD_Field_ID=59784
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='7cfefd60-aaaf-40c0-8636-54deccae945b' WHERE AD_Field_ID=59806
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='63721d52-ef4b-4f91-ab6a-04d92a1aad6b' WHERE AD_Field_ID=59781
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='59c1e198-f1aa-43fb-a3f5-05a95add6c4e' WHERE AD_Field_ID=59821
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='993920dd-a8bd-445b-bb80-32725ec4e244' WHERE AD_Field_ID=59786
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='5753e9be-d851-470d-bc19-71ef301f0603' WHERE AD_Field_ID=59782
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='b4afe7c4-6100-474a-b7e6-0076466b14ac' WHERE AD_Field_ID=59832
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='593f26bc-3b75-4dec-acf4-c2d68604b2a6' WHERE AD_Field_ID=59819
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='94a7b0af-e17b-4dd4-a20a-03f00c09e754' WHERE AD_Field_ID=59817
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='b72798ea-2732-44cd-87fe-6d0f89a0547b' WHERE AD_Field_ID=200257
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='db2abd4e-fd5b-4975-8243-432c9d9f4668' WHERE AD_Field_ID=59828
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='01886d8a-f5e1-4440-9542-7f6fba58b7e5' WHERE AD_Field_ID=62013
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='6d30155f-b00f-4a89-a774-b70483ce03f7' WHERE AD_Field_ID=62010
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='76f8a9e1-f439-4825-8df1-40d88c7e500a' WHERE AD_Field_ID=61974
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='00108bc7-add7-4b2f-9e80-2c8d42e509b0' WHERE AD_Field_ID=62015
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='b9349d50-cce9-4ccf-bf93-a13fb425335c' WHERE AD_Field_ID=61976
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='984732a2-2d64-4dd3-a588-da893666f0a0' WHERE AD_Field_ID=61973
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='e78ff29f-0878-4bd2-8670-701f6abf31bb' WHERE AD_Field_ID=62017
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='7607ea9e-2884-4e3c-9174-967a26a3510d' WHERE AD_Field_ID=61972
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='0e2503f6-e976-4943-bdb0-ad821a4cd9b3' WHERE AD_Field_ID=61986
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='c6b6d3a2-0306-4dd0-a8ae-1e713080575b' WHERE AD_Field_ID=62001
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='c1470d0f-3772-488d-8263-3ac75d96455f' WHERE AD_Field_ID=61997
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='367d5bb6-91e9-4f37-9885-a9e869133a7a' WHERE AD_Field_ID=61998
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='ad1b1605-5e58-43b6-983f-1a89c76813ab' WHERE AD_Field_ID=62009
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='3d6991f4-14f8-419e-aed2-14f252417aac' WHERE AD_Field_ID=62000
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='9ade46cd-2a16-4d2e-9d4c-eea8bb9a8a23' WHERE AD_Field_ID=200272
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='c166d7fe-ab6f-4336-8294-5f269248515f' WHERE AD_Field_ID=200290
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='be68cb57-1549-44a5-9d93-0469a6f34b88' WHERE AD_Field_ID=61876
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='0b726243-1656-47dc-93af-f00bcadf6155' WHERE AD_Field_ID=59745
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='fac1da38-485e-4598-8121-1fb4dd8ac1f1' WHERE AD_Field_ID=59741
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='87bd80a3-b0af-4a92-9e11-1b308dfabcbb' WHERE AD_Field_ID=59826
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='e5793584-4bc1-4b5c-a99a-530fa7f5fe1d' WHERE AD_Field_ID=59833
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='bdf440e4-6720-4c46-a45f-9f23ac44dcdd' WHERE AD_Field_ID=59763
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='5be9ed6a-7176-43ae-9d66-6b8c5e724308' WHERE AD_Field_ID=61988
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='873f8af0-5170-4fc1-b020-2e762cbfd2c5' WHERE AD_Field_ID=61989
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='e7631a3a-6409-49eb-be41-908877ab500f' WHERE AD_Field_ID=61978
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='27c148c2-3697-40cc-9156-ac021f2da00a' WHERE AD_Field_ID=200271
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='7860ccd2-c41d-4b78-beca-56b2214f9514' WHERE AD_Field_ID=59776
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='aabb0a61-a390-43ea-840b-5aa88df97886' WHERE AD_Field_ID=59802
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='116a8f3f-1002-4919-91f9-29fd8643ad94' WHERE AD_Field_ID=59755
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='0060be94-b31a-4f8a-aec8-0bb6cd16a716' WHERE AD_Field_ID=59812
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='505324dc-48a6-46ff-93b3-88a6d5e152e0' WHERE AD_Field_ID=200293
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='43620f3c-a6d2-485f-819b-13ccf5204f37' WHERE AD_Field_ID=61993
;

-- Oct 31, 2012 12:37:40 PM COT
UPDATE AD_Field SET AD_Field_UU='953cbf85-ceab-4f0b-89d6-4ca2279b530b' WHERE AD_Field_ID=59814
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='9dc56e55-e073-4172-9f03-8d7586c9ad4d' WHERE AD_Field_ID=59770
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='27921204-6944-458b-afa7-b1f9971fef0f' WHERE AD_Field_ID=59790
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='8d821e48-6deb-418d-a012-d076578d3396' WHERE AD_Field_ID=59813
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='44ff71f2-18f9-4ac6-8dca-0011ca9c143b' WHERE AD_Field_ID=61982
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='a692682a-cf5c-490f-903f-3a552945f654' WHERE AD_Field_ID=59831
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='0a693a1d-850a-471f-b0d9-1637df4d87d2' WHERE AD_Field_ID=59773
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='9677cf48-074c-4f54-8c28-11c72690482f' WHERE AD_Field_ID=62004
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='70016ef5-b5a2-4121-9b1d-af1079586d06' WHERE AD_Field_ID=59037
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='c855308b-bbad-4bf4-a669-6aaa010435ef' WHERE AD_Field_ID=59039
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='52646bbb-f8eb-4a8a-a8d0-2d2baa2d82bc' WHERE AD_Field_ID=59040
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='f9911021-0e9c-4fd2-8368-9cc58dbc9699' WHERE AD_Field_ID=59764
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='89b5fa8f-8713-479d-ab44-a44d4f6c37d1' WHERE AD_Field_ID=59094
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='28bee03f-ce08-4824-b605-6f73a9106526' WHERE AD_Field_ID=59753
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='349d5b17-6c78-48eb-b907-661c99fe2e4d' WHERE AD_Field_ID=59742
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='ccc48f4e-b742-4944-9a83-e106d97fea95' WHERE AD_Field_ID=59794
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='2616a0ba-da3c-45e0-97b2-5595637ac88f' WHERE AD_Field_ID=59837
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='b411d339-004c-4c33-9446-c2405629a610' WHERE AD_Field_ID=59769
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='5c9d8fbe-7b63-4fff-bef1-5d2c41e24f42' WHERE AD_Field_ID=59762
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='a7ea1f16-17a5-4362-9e37-173b7c91ca16' WHERE AD_Field_ID=59750
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='0def8eb2-ff58-4ca0-8cd1-301f64e1688a' WHERE AD_Field_ID=59835
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='e84d2444-b558-4e4f-93f5-be45a1121664' WHERE AD_Field_ID=61987
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='e6e47d05-b39f-4c0f-b7b1-7c9e77656785' WHERE AD_Field_ID=62005
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='f3be2bf2-adc3-49f6-a099-776e5e1a17fb' WHERE AD_Field_ID=61991
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='3aad0d15-8c36-484c-a44f-42b4b90a37a4' WHERE AD_Field_ID=61994
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='bb73b788-5eee-4bc2-abfd-5d0276d8926e' WHERE AD_Field_ID=62008
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='e83c1aef-474a-4cc1-ba13-7ca92af2009d' WHERE AD_Field_ID=61977
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='3a39a3f3-bc0a-4833-a4a6-87f6e44f4ef9' WHERE AD_Field_ID=61979
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='edd9018a-9f8e-436c-8944-6a006ffb60e5' WHERE AD_Field_ID=59771
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='67826d78-5329-4ee3-b7d5-70523999f7ad' WHERE AD_Field_ID=59792
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='57cb4a95-b464-4519-8a49-fbd713f2bb4e' WHERE AD_Field_ID=59836
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='885c8d24-afc1-4bdb-854f-f53ae80c90c0' WHERE AD_Field_ID=59486
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='080639ed-4c9c-4370-a527-26f4d41a176d' WHERE AD_Field_ID=59765
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='9c371d3e-7e9b-463d-91e3-e7f8bea7165f' WHERE AD_Field_ID=61990
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='55054436-966c-444e-a818-9e84720dc1e8' WHERE AD_Field_ID=61996
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='a29ff295-23c8-4d08-9e21-8595a4316ad3' WHERE AD_Field_ID=59772
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='cd0a08f5-4396-4d1e-a920-faffb082245f' WHERE AD_Field_ID=200292
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='68438a00-2762-4ca8-a5d6-cc6dfe88897e' WHERE AD_Field_ID=59788
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='6d796942-1f94-4975-993c-06977724da18' WHERE AD_Field_ID=59774
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='7d83ebc2-4fcf-46ae-84b5-3f07a453c176' WHERE AD_Field_ID=61984
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='30f4494f-337e-427a-b4fc-84aa73254a5e' WHERE AD_Field_ID=59743
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='9ec6f2ee-3471-47b3-a7b9-47e3ea3585ce' WHERE AD_Field_ID=61999
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='cbc82583-cf9b-490a-a1d1-65b3a2fef1a5' WHERE AD_Field_ID=59744
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='9bca7a3f-5057-42ec-8c13-1c155d5cc112' WHERE AD_Field_ID=59803
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='9bb6937e-3598-4c65-a012-2cd91f9ca0a3' WHERE AD_Field_ID=61985
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='7c47c820-3a41-4729-b9e8-03b6fdb26083' WHERE AD_Field_ID=59793
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='41434cde-9492-4458-a17b-2dddf19735ee' WHERE AD_Field_ID=59820
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='f08fb176-7eff-451d-9d4c-350cf0d4013f' WHERE AD_Field_ID=59783
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='312cf41b-2d14-495c-b87b-15a2d509539b' WHERE AD_Field_ID=59775
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='9bf15f84-82b0-4af3-b067-9bb25b01866d' WHERE AD_Field_ID=61992
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='b8fb81aa-4e1f-4777-8ca5-57db48bede23' WHERE AD_Field_ID=59767
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='39d59c50-b9d7-4701-9f40-276f78fd9afa' WHERE AD_Field_ID=59829
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='1abd5d29-68d1-432e-8660-b9863c2ad5aa' WHERE AD_Field_ID=59777
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='c4024259-6aaf-4336-99ff-41d505c4eb2c' WHERE AD_Field_ID=59801
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='7d9bd807-9a3c-4fbf-8165-604fb6cf3937' WHERE AD_Field_ID=62018
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='961e9ee0-d0ab-479d-848a-30f6af6fb01f' WHERE AD_Field_ID=59759
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='6d8d5d7a-7b7d-4f72-b197-0a366b5e560c' WHERE AD_Field_ID=200163
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='b04c136b-4b2c-48e6-9934-0edf741e292a' WHERE AD_Field_ID=59766
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='6cb0ff81-572b-4804-a8ce-c1ea790020b1' WHERE AD_Field_ID=59746
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='fadabee1-d3bb-4c08-9947-aca374e923dc' WHERE AD_Field_ID=59757
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='a281fcef-b613-4033-ba3f-76a2008576ca' WHERE AD_Field_ID=59761
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='1ee15b4c-da89-47b7-b0b1-a703714eedd5' WHERE AD_Field_ID=59799
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='89fa959e-e537-4ec3-9a1f-45e5983d7a0b' WHERE AD_Field_ID=59787
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='e73616bd-23e0-4928-9051-b89eed8248f6' WHERE AD_Field_ID=61971
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='fe2e9565-08f9-419d-bc46-8d5a0a19060f' WHERE AD_Field_ID=59795
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='b61e2592-9496-4769-b49d-7cd0d6d1e423' WHERE AD_Field_ID=59818
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='1cf89d5a-ba23-4f4b-8b1c-1460e62691ab' WHERE AD_Field_ID=61970
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='97127b38-96a0-448b-9fa3-b8e6d371a830' WHERE AD_Field_ID=59789
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='963efdbb-26e7-42d8-81b8-0f47a1648791' WHERE AD_Field_ID=59822
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='58e6cce6-aecb-45fd-8451-6934312484a5' WHERE AD_Field_ID=62014
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='563e096a-d120-4f41-8695-870d77da2d46' WHERE AD_Field_ID=61980
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='af1f0f59-8984-4cda-9cb8-ae1a705a8fdf' WHERE AD_Field_ID=59220
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='b512cac1-40ec-42ae-9635-a9c567519dcf' WHERE AD_Field_ID=61981
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='e776e895-030f-48b1-908a-23427e9c3439' WHERE AD_Field_ID=62006
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='0ab80277-a013-4f8f-8e5f-4c35d6dec4c3' WHERE AD_Field_ID=59222
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='bad06bb6-c3ae-4b8d-b7f7-3d47b3cb071c' WHERE AD_Field_ID=59475
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='428e82da-5783-499d-9b24-0213e27ea1f9' WHERE AD_Field_ID=59476
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='52d83189-bb10-43bf-9c62-db24ab37a34a' WHERE AD_Field_ID=59074
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='be3dc881-3833-4e49-83dd-d8e489c5d7c2' WHERE AD_Field_ID=62012
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='ff35988a-b301-427a-9859-967b2e66e185' WHERE AD_Field_ID=61969
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='36738000-2829-49e0-ba57-89582b007821' WHERE AD_Field_ID=59809
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='68620ee4-4c05-4113-8be2-1f281addbc50' WHERE AD_Field_ID=59804
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='87e63e44-0928-46cf-b9c0-28616d237305' WHERE AD_Field_ID=59811
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='8875680d-2fc7-4ce9-99cd-b0ab98690139' WHERE AD_Field_ID=59823
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='0f41745a-2b89-43bc-8b4e-76003b6a358e' WHERE AD_Field_ID=200296
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='1067459e-5e28-4ad9-a235-1c9d05e78caf' WHERE AD_Field_ID=59768
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='6712ea36-9774-4a08-bebb-c75c879dfb6c' WHERE AD_Field_ID=200289
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='f22da098-a58a-4d1e-8087-4dd3e1cc4347' WHERE AD_Field_ID=59807
;

-- Oct 31, 2012 12:37:41 PM COT
UPDATE AD_Field SET AD_Field_UU='6868e927-0fb8-47c1-86e7-28106fcd2813' WHERE AD_Field_ID=59798
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='5cde469b-268d-4169-9035-158f47b3cc97' WHERE AD_Field_ID=59808
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='bb9473d1-f43a-4d7e-a00f-1ef395f54d96' WHERE AD_Field_ID=59810
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='4c79251c-573e-4e90-bc45-ee3b1cfaa7f7' WHERE AD_Field_ID=59749
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='1b4695b3-55c0-4207-9ec5-a02cbd9e3e4e' WHERE AD_Field_ID=59824
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='273f7bb5-05e5-42fb-9226-e3460f204ec0' WHERE AD_Field_ID=62016
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='e15f5286-0da1-47c0-b6d9-42934b6c8a79' WHERE AD_Field_ID=59797
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='820bebf2-f997-441e-814b-8fe879f8ee3c' WHERE AD_Field_ID=59805
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='4e8ac01e-f73c-44df-9fd9-8d322b538510' WHERE AD_Field_ID=61983
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='5dd77c4e-5eec-46b2-88e4-ee2bb9fd33ff' WHERE AD_Field_ID=59785
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='1f0bdb65-60b6-4bf7-bd90-a3e9971e80b1' WHERE AD_Field_ID=58987
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='a1474466-b5b5-4fa0-bb45-3414b564dd61' WHERE AD_Field_ID=58988
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='d6508ba3-eb13-4dde-9439-8de913396875' WHERE AD_Field_ID=58990
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='0b9a3faa-eefd-4f95-be0a-9d956da63a59' WHERE AD_Field_ID=58991
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='90a6fac4-96e5-45c2-a79d-5ba6e20d783a' WHERE AD_Field_ID=58992
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='d680943e-5b8a-432c-8783-74ea14e71d58' WHERE AD_Field_ID=58993
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='455e677e-c2f2-41e7-8b2b-4de9cf956c17' WHERE AD_Field_ID=58994
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='18455496-0099-4959-b7e3-04329251d00a' WHERE AD_Field_ID=58995
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='5071fbc0-9ba1-4d97-a3f0-40396f4aae6e' WHERE AD_Field_ID=58996
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='e13ccc7c-fb80-4fdc-b240-1aa1297af135' WHERE AD_Field_ID=58997
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='d4301dfd-59e0-44f6-8d6a-821f156ef720' WHERE AD_Field_ID=58998
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='0f47d83a-295a-44f8-914d-b3cdf616df70' WHERE AD_Field_ID=58999
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='e2a7d4b0-e793-44cd-9e39-282e77b21438' WHERE AD_Field_ID=59000
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='40735792-9b69-4822-892f-60426b1b88d9' WHERE AD_Field_ID=59003
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='cbbe3205-a414-4ada-a160-c32cca81cf89' WHERE AD_Field_ID=59008
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='f1361c89-5b16-47f0-a372-14487baaa73c' WHERE AD_Field_ID=59009
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='e80d5486-f20e-42a3-b731-b2dff84fecac' WHERE AD_Field_ID=59010
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='dd7b9aea-b6b1-44fb-b5cf-0a989137a1fd' WHERE AD_Field_ID=59011
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='695a5ded-6aec-4c51-9d59-d8800b8993db' WHERE AD_Field_ID=59012
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='fb213039-0ecf-4e0c-bb76-adbe8324d34d' WHERE AD_Field_ID=59013
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='a1dc50d4-aefe-4b44-8173-32cc4cf3a6c3' WHERE AD_Field_ID=59014
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='dcebb922-e754-451b-ac10-71a97bed6b3a' WHERE AD_Field_ID=59015
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='71751ab6-7d70-4512-a8ca-d34737b59bca' WHERE AD_Field_ID=59016
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='cc949914-64fb-43e2-bc01-cd30e46cef2c' WHERE AD_Field_ID=59017
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='eeb8c586-6804-4309-8ad3-11f30487708e' WHERE AD_Field_ID=59018
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='bb7418e9-c46e-464b-8566-ec5f6f136e4e' WHERE AD_Field_ID=59029
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='27a13407-742b-4da6-b860-35eb68a15322' WHERE AD_Field_ID=59030
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='51be1786-9fcc-4742-bccc-7b88d362ec37' WHERE AD_Field_ID=59031
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='99e01b7d-b5ff-4337-bea2-32d8aa9a70a6' WHERE AD_Field_ID=59032
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='92347772-8be5-4119-9529-d96941df67df' WHERE AD_Field_ID=59041
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='2c775614-926c-4468-82cb-7fdb6c069b2f' WHERE AD_Field_ID=59042
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='d6c6d9ae-519f-443d-970f-7195befa505f' WHERE AD_Field_ID=59043
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='fb75f42a-f077-4839-8ee5-4b14d4127e39' WHERE AD_Field_ID=59044
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='fd7bfb43-22df-4f9e-88a7-e93cd3d9a1fa' WHERE AD_Field_ID=59045
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='fedb3fd6-8040-4e13-b3fd-ea321e768bb5' WHERE AD_Field_ID=59051
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='d6f4bc59-4a1e-406f-b21b-6502fa5749cd' WHERE AD_Field_ID=59052
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='b11f6f1b-f209-4a67-b017-0e76d96b7b4b' WHERE AD_Field_ID=59053
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='4f1c3f54-a319-4254-b6a2-cf1d63652695' WHERE AD_Field_ID=59055
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='bd214421-afb8-4bb7-b31d-9903b721c349' WHERE AD_Field_ID=59056
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='cd5fffc6-611a-44ef-a58b-640ff480722c' WHERE AD_Field_ID=59057
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='d8a84830-56b4-450a-9d4b-c2c9415f04f0' WHERE AD_Field_ID=59058
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='d8d08c37-0f41-46c8-8f06-2517ea535200' WHERE AD_Field_ID=59063
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='0362a9a4-7f4b-4031-aaa5-4bd01a7bc970' WHERE AD_Field_ID=59091
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='cba59bda-1b3a-410e-8676-58f0aac6764e' WHERE AD_Field_ID=59092
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='7582a40d-a5d5-4d5b-8e70-0176da385ec5' WHERE AD_Field_ID=59064
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='0bd383d7-1519-454d-974c-3f9378501aef' WHERE AD_Field_ID=59065
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='927ba4e5-a72c-40f6-90af-ef5fe913d7c0' WHERE AD_Field_ID=59066
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='6b9128f9-5ba6-43c2-9370-3e192567b465' WHERE AD_Field_ID=59068
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='284563f6-89cd-4529-84a5-54e2520cc34e' WHERE AD_Field_ID=59069
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='463cf541-ab51-4c34-9284-3cbffd6b9116' WHERE AD_Field_ID=59070
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='2930d104-f0d7-4fb7-b9df-a474b77dad39' WHERE AD_Field_ID=59071
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='36ea3848-430c-4114-9044-74d4112237c4' WHERE AD_Field_ID=59072
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='598a77b9-d823-4874-b9cd-ac6886776200' WHERE AD_Field_ID=59085
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='c27e356a-ed1e-446f-accf-c141de931925' WHERE AD_Field_ID=58989
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='3b053af2-a8c2-4a03-b4f4-57b644c9064c' WHERE AD_Field_ID=59033
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='1007d083-dbe7-4a18-88f2-3ec5d29bcd77' WHERE AD_Field_ID=59034
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='b26c099d-0725-4a39-aac9-288edcc4dab8' WHERE AD_Field_ID=59036
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='426a70fc-5162-4292-a733-51f146f723d6' WHERE AD_Field_ID=59038
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='a8db7502-be0f-480b-9576-faf989e71ca3' WHERE AD_Field_ID=59098
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='ee79f071-fded-41be-92c4-b1c203681d55' WHERE AD_Field_ID=59099
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='7fdb4ae4-91eb-4330-9b07-e2c078850b41' WHERE AD_Field_ID=59100
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='843eb550-ba17-489b-a70d-4795a787b2cc' WHERE AD_Field_ID=59101
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='1039de61-be67-489d-b541-8fca9d1b2fd5' WHERE AD_Field_ID=59105
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='07f8bfe9-824c-4764-a5d4-2d42aa2394fe' WHERE AD_Field_ID=59108
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='09d38e83-9ac4-4cd9-9e2d-ec3923385b19' WHERE AD_Field_ID=59110
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='e0653c6f-0161-4ab4-bc36-82fe68280881' WHERE AD_Field_ID=59093
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='689a1cd3-90c7-48bc-ae1d-c8934d3f9ad5' WHERE AD_Field_ID=59095
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='c66e74c2-1d8d-40da-8275-1d3ab67eebb8' WHERE AD_Field_ID=59117
;

-- Oct 31, 2012 12:37:42 PM COT
UPDATE AD_Field SET AD_Field_UU='4664c28e-24aa-4d23-904e-78736dc865ba' WHERE AD_Field_ID=59118
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='85056266-ad2a-4d25-abc8-4cc3bb652044' WHERE AD_Field_ID=59120
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='a503accc-1da2-43e8-bc12-490c544bd12b' WHERE AD_Field_ID=59124
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='3f714bcb-b1f1-4ec5-85ad-eea5506c58ba' WHERE AD_Field_ID=59145
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='f889c582-b8f3-475a-b527-01962ba65aeb' WHERE AD_Field_ID=59146
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='3d75d894-8ad6-4c82-badf-1a1623214848' WHERE AD_Field_ID=59147
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='88af4b5f-6a9f-4111-9169-5dd2d71f8969' WHERE AD_Field_ID=59148
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='bc0f97ab-932b-46fe-8001-900886e99d63' WHERE AD_Field_ID=59149
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='aec1745a-f29d-41a7-9a16-4a5b0d65d151' WHERE AD_Field_ID=59150
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='b7ea89d4-c1ea-45a6-ba75-32ed170157a6' WHERE AD_Field_ID=59152
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='ba1346f4-09b5-41f6-9f88-13b21cfe9977' WHERE AD_Field_ID=59154
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='522fc825-f020-48cc-9d59-6c94050d4002' WHERE AD_Field_ID=59157
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='aba76498-50b1-451d-b885-210720635cae' WHERE AD_Field_ID=59172
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='9811b3c4-7851-49f3-b186-de3d440d5cee' WHERE AD_Field_ID=59173
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='d47dbc91-72d0-4a68-8cf7-b8412a03615f' WHERE AD_Field_ID=59174
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='dc48fb36-fe66-4a00-9d0f-3f91f20b7c25' WHERE AD_Field_ID=59176
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='620f9c9e-e584-4b8c-885d-f99e581bc2ff' WHERE AD_Field_ID=59177
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='02296fe6-7339-4554-af2d-ee34e26246f6' WHERE AD_Field_ID=59178
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='f7559f79-87fc-4017-bfd6-1dc9972d990c' WHERE AD_Field_ID=59205
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='93a0bbf5-5b99-40cf-be3f-68cab73410bc' WHERE AD_Field_ID=59206
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='e0007d09-05dc-4458-9560-27f40ce90c4a' WHERE AD_Field_ID=59207
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='23a3920d-d100-4680-8b7a-2c9ecc836ce5' WHERE AD_Field_ID=59208
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='c00149ec-3b62-4fef-8c88-c98e5ddd27a5' WHERE AD_Field_ID=59210
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='ac1b7d94-09ac-4f85-b194-f4c4297e4166' WHERE AD_Field_ID=59211
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='d0fb40db-0c47-48dc-acbf-9aaceedadd29' WHERE AD_Field_ID=59232
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='74c83d1c-2357-46e2-9b31-e25d15801698' WHERE AD_Field_ID=59233
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='5d5009be-cd12-4af2-8752-1015c426e36c' WHERE AD_Field_ID=59234
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='8208fadc-9336-4fac-8fe1-539535d8de36' WHERE AD_Field_ID=59242
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='da26004c-6e90-4468-a756-9489ab90982a' WHERE AD_Field_ID=59251
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='af6b0040-affa-481c-957b-e2a2076e76ac' WHERE AD_Field_ID=59252
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='36c2a0ad-34a8-424b-ba2e-5eaed96d0c65' WHERE AD_Field_ID=59253
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='4e4b4ab2-c761-4b98-83ae-0e0b342665ae' WHERE AD_Field_ID=59254
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='813e05ae-563c-4dc4-937e-4f43e3d9854e' WHERE AD_Field_ID=59255
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='f1475386-943a-4efa-8afe-bbce8759db8f' WHERE AD_Field_ID=59256
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='b90561bd-ae4f-4a10-89d0-4be8065397c9' WHERE AD_Field_ID=59258
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='73f6ce5c-8ee9-40e1-9c1e-53d26f5f9216' WHERE AD_Field_ID=59265
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='3334a6e8-5e80-4999-a120-2e572c44fc81' WHERE AD_Field_ID=59266
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='9a6c29ec-2c6a-474c-b2a9-d34438247711' WHERE AD_Field_ID=59267
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='952eef84-f93e-4aa6-aabe-714f4bafad22' WHERE AD_Field_ID=59268
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='f16f5098-82bb-46c4-860f-7a58157bf590' WHERE AD_Field_ID=59269
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='3c6b1cfc-3780-4bff-b184-b0f252889c3b' WHERE AD_Field_ID=59270
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='1198b088-94b9-4de8-b281-365602d1ffeb' WHERE AD_Field_ID=59271
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='d2807812-0c22-4300-b1d8-523428de30fa' WHERE AD_Field_ID=59279
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='0f91c316-dff8-42a6-bccc-65abbd6b95fe' WHERE AD_Field_ID=59289
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='ec8bb386-4ca2-4387-828e-504ef2116f36' WHERE AD_Field_ID=59292
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='23c57eb7-88af-4551-9018-e25a5ba87333' WHERE AD_Field_ID=59296
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='6d9eb62e-7f1d-4170-8a47-32cd550f3f23' WHERE AD_Field_ID=59299
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='b126fe04-2c7e-4fd3-bc16-24643ea49f11' WHERE AD_Field_ID=59300
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='05021a0a-a55f-4b23-bf8e-426c8be3392d' WHERE AD_Field_ID=59301
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='e569c2cd-e634-470f-9866-2c20ea2d8974' WHERE AD_Field_ID=59305
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='3da84d4f-033f-4106-ae97-c23464f93f3b' WHERE AD_Field_ID=59322
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='5fc174e1-6a55-4388-a1bd-7b8c1407f787' WHERE AD_Field_ID=59323
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='3c23a346-6557-4e76-8c71-94689e39c2b9' WHERE AD_Field_ID=59324
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='02046e9c-e6ab-4bcd-b929-9b4993b7f53c' WHERE AD_Field_ID=59345
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='a6f535ed-8e7a-414e-b14a-a608f44589cf' WHERE AD_Field_ID=59346
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='2e1642ec-a661-4af7-9fbb-2992f8442fd0' WHERE AD_Field_ID=59347
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='c9547eda-f1b5-4f74-bc09-252a61a07633' WHERE AD_Field_ID=59348
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='76aedf34-b80b-4f55-8b0e-1ce3ff1cc330' WHERE AD_Field_ID=59349
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='d7182b08-adc4-45c4-8821-9dcb1194e251' WHERE AD_Field_ID=59350
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='0927931e-1d8c-4725-9edd-9b32383e70b0' WHERE AD_Field_ID=59352
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='c44df213-c5c3-46f7-b8f1-aa59133e4047' WHERE AD_Field_ID=59353
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='b8e23f21-b77d-4d49-8b16-8682548f6dc6' WHERE AD_Field_ID=59354
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='891fa7e4-2be6-413b-a5c3-c65d84fd6d86' WHERE AD_Field_ID=59356
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='f057ca0a-b9e1-4f99-8d1d-d5bce5a6ee9f' WHERE AD_Field_ID=59371
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='13f325d5-1e82-4061-979c-c396e0a4388a' WHERE AD_Field_ID=59372
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='806ad270-ac4f-45bc-82da-f3b909c243de' WHERE AD_Field_ID=59373
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='e2bfb23f-fd25-4188-b225-c0e54bed4ecb' WHERE AD_Field_ID=59374
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='b68c5008-bcd5-47e2-9fa0-13544da55b76' WHERE AD_Field_ID=59375
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='4ecf8276-2bc4-47a1-b005-d5040daa36c9' WHERE AD_Field_ID=59376
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='0d88ba8a-2db2-4d01-9561-d76a740610d9' WHERE AD_Field_ID=59378
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='ce03c4f6-67f7-4973-ac3e-639dc571aec4' WHERE AD_Field_ID=59403
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='45603a84-6ae6-415b-8653-99039bd49740' WHERE AD_Field_ID=59404
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='09afcca9-248c-4bee-8c9f-f928e232cf13' WHERE AD_Field_ID=59405
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='840587e5-2fae-4d22-9e10-242bdd9a9bcd' WHERE AD_Field_ID=59395
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='fd2fff47-8312-41f9-acf5-0097e88e674a' WHERE AD_Field_ID=59402
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='0c8d042e-76b7-449e-812a-39be9c0c9b32' WHERE AD_Field_ID=59224
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='2f9ec34c-2273-484a-8f1f-9d7bebc4abe9' WHERE AD_Field_ID=59501
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='1a01676f-5667-4023-aaef-7dda866fc518' WHERE AD_Field_ID=59502
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='602afc0a-7a1f-419a-9e5c-7bdd35008c43' WHERE AD_Field_ID=59503
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='f47eb94f-953e-4c7d-9736-d8063a67896b' WHERE AD_Field_ID=59504
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='7d9af76e-d674-4529-85d7-3ef3b838adf1' WHERE AD_Field_ID=59505
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='4bf91347-c39c-47f8-a06b-8d44e8bde36e' WHERE AD_Field_ID=59506
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='a2e8e831-47b6-4085-b9f2-7bcd09c71e79' WHERE AD_Field_ID=59507
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='38e01ab4-ab97-419d-a7c5-58950422c47d' WHERE AD_Field_ID=59508
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='c4e6c57c-eb5d-467d-b25f-f59ddf926713' WHERE AD_Field_ID=59509
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='3f72f390-e566-4b45-ac49-c8e4148d011a' WHERE AD_Field_ID=59485
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='7a58ddc4-02a4-441d-b578-fa37f9dbbef2' WHERE AD_Field_ID=59510
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='bb8aab2c-7a95-4247-b77c-715ffc9f3415' WHERE AD_Field_ID=200048
;

-- Oct 31, 2012 12:37:43 PM COT
UPDATE AD_Field SET AD_Field_UU='2b9e0be5-f35c-4655-ba76-4d3d7c9fbfd8' WHERE AD_Field_ID=59511
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='0d7d209c-c5a1-4e5c-bf8f-f1643f354727' WHERE AD_Field_ID=200035
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='4ba85fdd-2353-4a41-b757-aeb1dc439bf1' WHERE AD_Field_ID=200159
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='2546301e-d118-4ddb-88f0-3b81b5289a9c' WHERE AD_Field_ID=200160
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='61e28fb8-4b65-4f75-a866-e0983f5f881a' WHERE AD_Field_ID=200161
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='68ece19a-acdb-47cd-8e89-12b17b06b484' WHERE AD_Field_ID=200602
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='bdcc7085-a163-4e67-b126-da30a654e6e0' WHERE AD_Field_ID=200532
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='b1457202-8eef-4743-b8d1-846347e69442' WHERE AD_Field_ID=200535
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='1b2e86cf-9d53-4568-bc35-e5690446ed23' WHERE AD_Field_ID=59035
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='0ceffb0b-1aae-410e-a266-cf693ad36baf' WHERE AD_Field_ID=59494
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='770265df-137b-4963-9dfa-a3847d60df52' WHERE AD_Field_ID=59496
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='61088b44-20cc-4835-bc16-6a843b95711b' WHERE AD_Field_ID=59479
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='00e3ff75-d2c7-4955-bbb2-6fd013c8d548' WHERE AD_Field_ID=59482
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='dc60731c-6a03-4361-bf59-88275545f00b' WHERE AD_Field_ID=59484
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='0cd04f51-3eda-4cd5-9ca7-c5483962b728' WHERE AD_Field_ID=200529
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='17c6132a-3fbb-4f76-846e-4cdc8ce5d115' WHERE AD_Field_ID=200530
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='96bfa02e-92f1-438d-9fc4-69d29caa2007' WHERE AD_Field_ID=200549
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='3278295b-273f-4546-a7fe-36f3f36c58ad' WHERE AD_Field_ID=59007
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='5b9da0b0-2c81-42ba-a864-9cb5f4097797' WHERE AD_Field_ID=59083
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='bd8692d0-b210-4369-8d0d-8fbe597bb08b' WHERE AD_Field_ID=59102
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='47f17227-6483-401f-b5ff-a6b0a8652986' WHERE AD_Field_ID=59109
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='b049e9d6-3501-4b08-a522-afbe38ed2552' WHERE AD_Field_ID=59171
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='6e43d035-55f0-46bf-9374-3034431aa347' WHERE AD_Field_ID=59125
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='ae48853e-9deb-42f5-a5c9-a1ca5c0929ab' WHERE AD_Field_ID=59229
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='8459875c-3818-41cb-87fe-eab23276ddbd' WHERE AD_Field_ID=59230
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='34392f90-4dd9-4520-861f-42c386a64924' WHERE AD_Field_ID=59245
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='72e0a88f-8574-4392-b96d-9a104a5d5a9b' WHERE AD_Field_ID=59246
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='cf06075f-7d49-4fad-a4a5-7772b1e54040' WHERE AD_Field_ID=59273
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='46e58d2a-459a-4c41-869c-baab1b2251e2' WHERE AD_Field_ID=59276
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='b30139b0-0861-4927-a807-c695ea409cbb' WHERE AD_Field_ID=59291
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='a7a7a9c5-1300-4e1f-8c38-71d0fc37f979' WHERE AD_Field_ID=59315
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='8431e208-fb76-4116-97e0-0838449ba976' WHERE AD_Field_ID=59396
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='233debb9-6d1a-478d-b804-87ce0560798a' WHERE AD_Field_ID=59497
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='f55a873b-552b-48db-89b9-f6a6f705b425' WHERE AD_Field_ID=59490
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='9c9afc07-b54a-45c1-bf5c-2a9be87f120a' WHERE AD_Field_ID=200538
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='c9a9945f-6b9e-4b90-8c81-95bad0f8b32b' WHERE AD_Field_ID=59198
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='85e812f9-89c5-44de-b395-7f9d35bc619d' WHERE AD_Field_ID=59199
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='1b548f7f-95b4-47e5-a28d-fdbebce491d8' WHERE AD_Field_ID=59200
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='278ed627-40f1-42b7-9ee4-72e5fcab7e6f' WHERE AD_Field_ID=59259
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='501ed669-b742-4051-93ba-cfe4b8aefb4a' WHERE AD_Field_ID=59261
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='43178e00-84b2-4331-b32e-02b5a51db566' WHERE AD_Field_ID=59262
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='9bb715d9-1bb7-464d-8e35-ebb919714c2f' WHERE AD_Field_ID=59263
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='7917d727-25bb-4652-a295-06e9a6cb3a0c' WHERE AD_Field_ID=59221
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='c84fc498-2093-4ca9-b9b5-a57f9ca16735' WHERE AD_Field_ID=59364
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='22617d0f-48ea-44e2-a06f-49bf40a2f906' WHERE AD_Field_ID=59367
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='88d9519e-1114-4885-b180-6e6aa5a0f091' WHERE AD_Field_ID=59369
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='d3b0ca88-0cc0-4c1f-a05e-86b14fd5d989' WHERE AD_Field_ID=59397
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='dd513240-15f7-47c1-b632-73478defdb01' WHERE AD_Field_ID=59400
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='db7f809d-6e00-4a37-97b7-78b43d351079' WHERE AD_Field_ID=59401
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='78bdfa1f-a3ff-47dd-96ad-371bf3e72673' WHERE AD_Field_ID=59393
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='d3812496-12b6-4d91-8dc0-9f7dd87fcd65' WHERE AD_Field_ID=59138
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='eed36323-6d7d-4b78-9ea8-b5c6e6351cbe' WHERE AD_Field_ID=59499
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='352fb0d8-758f-478c-b70e-41faa7da9a94' WHERE AD_Field_ID=59487
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='de4459bc-1562-4ab6-9a8d-8374a75b50be' WHERE AD_Field_ID=59498
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='cb810e21-c816-4c07-be68-6df7fca2bca4' WHERE AD_Field_ID=59470
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='255ae907-8846-4d37-bf8a-e3f1ea759b97' WHERE AD_Field_ID=200541
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='79f6cbb8-164b-4bdc-8c92-222acce17f05' WHERE AD_Field_ID=59193
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='3d0dc40b-231a-4ff5-8467-371c896fa549' WHERE AD_Field_ID=59179
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='86123b40-b6fc-4116-82d4-2c13f3629a59' WHERE AD_Field_ID=59398
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='d57e830a-4377-49d0-80d4-e5bc3ad3cc8c' WHERE AD_Field_ID=59488
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='534dbb4f-a778-46b0-bbcb-077b153077c6' WHERE AD_Field_ID=59067
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='e92d43f5-5825-4df3-8965-c707bc68719b' WHERE AD_Field_ID=59073
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='ccfb391e-9cc1-444f-ab52-1f007c038563' WHERE AD_Field_ID=59075
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='f0614076-1eb9-446a-9d4b-60a4eaab0365' WHERE AD_Field_ID=59077
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='5c3769d7-74b2-46c7-9e10-4e2dcdc2bb7a' WHERE AD_Field_ID=59358
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='f830c00f-0815-45b1-b185-cbd89624a5bb' WHERE AD_Field_ID=59391
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='056a3192-ee59-4bc2-891a-11674b05e3f3' WHERE AD_Field_ID=59201
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='5f29c6c0-e866-46a2-9d63-d18447549dfc' WHERE AD_Field_ID=59202
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='1d2003a4-3dee-4dcc-bf58-1e1aac3e79f1' WHERE AD_Field_ID=59203
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='9d14ea47-0fa3-4ab9-b209-7fca6de5a0ee' WHERE AD_Field_ID=59204
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='fd3458ae-7fa1-4cb6-96d4-5e2974724cea' WHERE AD_Field_ID=59006
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='f0b00529-7da3-4680-a1d9-2bfd7c0b26c9' WHERE AD_Field_ID=59240
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='061d5de3-8437-445e-8e27-d46149bbf198' WHERE AD_Field_ID=59241
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='66364357-901a-4370-bdef-bca1e5bf8cf4' WHERE AD_Field_ID=59335
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='909cef45-eeec-46e1-b40f-adcb6328de45' WHERE AD_Field_ID=59481
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='98c097c6-7795-4464-8c1b-0e109ee04e51' WHERE AD_Field_ID=59483
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='12e436e9-d9ca-4fd1-b370-f50d486bf829' WHERE AD_Field_ID=59020
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='5b8b719d-089c-4de7-9758-84900f71ebd1' WHERE AD_Field_ID=59022
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='f6da9719-b3fa-4eab-a4f9-e205a284a09a' WHERE AD_Field_ID=59024
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='61cd42f2-7fa1-4cd9-b1f8-cbdc9247cd04' WHERE AD_Field_ID=59026
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='60c1a8e4-9a4b-4822-932b-a77186f13225' WHERE AD_Field_ID=59260
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='1a0da8f7-b786-4b00-bdf0-643b040bc843' WHERE AD_Field_ID=200517
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='5a7bf8b0-2ec5-4536-ace9-cf3502783e90' WHERE AD_Field_ID=59050
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='3da4529f-8e07-47bc-b068-0449d0760cc5' WHERE AD_Field_ID=59059
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='7b737833-7e5d-4f10-8334-0bfbcae591d1' WHERE AD_Field_ID=59060
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='87d0ef8f-bbdd-4f21-9165-c4b56e0dab01' WHERE AD_Field_ID=59061
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='02cf215f-0b2f-4250-8fcf-e191048f7648' WHERE AD_Field_ID=59062
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='c349b183-7b22-4c1f-a427-feaf35ae579b' WHERE AD_Field_ID=59079
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='023befd7-e276-4938-8233-40e6eebc0f87' WHERE AD_Field_ID=59084
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='c43a4378-b328-4da4-8352-ad5f3bc2d789' WHERE AD_Field_ID=59090
;

-- Oct 31, 2012 12:37:44 PM COT
UPDATE AD_Field SET AD_Field_UU='d9c4daa6-ba13-4730-8902-86cad08095f2' WHERE AD_Field_ID=59134
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='3402cc47-5c91-4925-828d-7bc862e8d9be' WHERE AD_Field_ID=59136
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='a1e85219-d6e1-4163-b581-fbcccaee7e42' WHERE AD_Field_ID=59137
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='e65d1d31-062c-4dba-b2c1-e2a6eb91dacd' WHERE AD_Field_ID=59139
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='3a47df87-44bf-4f5b-b017-d5e52f4c0744' WHERE AD_Field_ID=59155
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='f738fa2f-8386-4c9e-ba85-232bc9aa9230' WHERE AD_Field_ID=59161
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='2b1fbae4-a90c-4d5f-826e-f89a33e3ff17' WHERE AD_Field_ID=59163
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='7f473968-b09e-43b0-8441-7dab1a0849c0' WHERE AD_Field_ID=59168
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='8f83cac7-372b-4d7a-9ea2-d329b8ed7f46' WHERE AD_Field_ID=59170
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='a29bfaef-bfbf-4c74-b062-d43b7b4626a6' WHERE AD_Field_ID=59182
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='f4034a43-7aea-4b53-8be8-ac6ce1b18b72' WHERE AD_Field_ID=59183
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='7d9feb11-0812-48f6-8de1-1ea393c4bc41' WHERE AD_Field_ID=59184
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='bceb34ac-f45e-40ae-9756-a9f36c777374' WHERE AD_Field_ID=59187
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='44f683b8-dba9-47cf-9ab8-3b45423e35ff' WHERE AD_Field_ID=59225
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='9a5ab3df-bd44-4bf3-95de-3470782db61f' WHERE AD_Field_ID=59228
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='d1f98e2d-7523-41c6-a6c7-695c32c37d44' WHERE AD_Field_ID=59231
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='3905c7d5-b2ef-4aa4-b4ca-f8b84c23135f' WHERE AD_Field_ID=59236
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='542410e4-719a-4739-b86f-a5a56161b4dc' WHERE AD_Field_ID=59237
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='cb41cff5-5be2-4af9-819e-24bfe5d02b0a' WHERE AD_Field_ID=59238
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='fe1c3efb-1678-445d-a881-82ede086f587' WHERE AD_Field_ID=59239
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='bc4469ac-06cf-438a-b387-701b9fbca646' WHERE AD_Field_ID=59243
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='cced5061-8eff-49f2-8e08-093363c550ec' WHERE AD_Field_ID=59249
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='54f212b1-dc21-45b7-8f20-ef29a83ea3c7' WHERE AD_Field_ID=59274
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='9dae21e9-dc85-4980-867d-b21eaf83489b' WHERE AD_Field_ID=59277
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='5b5d7aec-2603-400b-adbd-e59381f78c30' WHERE AD_Field_ID=59281
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='0db58679-78de-42a8-a3d1-ec28b05dc233' WHERE AD_Field_ID=59283
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='02010263-22d7-4536-8ac2-ea89da9c9253' WHERE AD_Field_ID=59288
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='1ee2b497-aa6e-44f1-8a82-a1b07dfbabe1' WHERE AD_Field_ID=59319
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='d7a16d7d-28dc-40c4-a968-97849c03b86a' WHERE AD_Field_ID=59295
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='5caf9ac3-29e8-47e8-86ff-ebf389055b7e' WHERE AD_Field_ID=59297
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='00722135-5e81-467b-a8d1-ae7e8994897d' WHERE AD_Field_ID=59303
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='6e12e1a0-a11e-4765-94ac-6bba90b39dce' WHERE AD_Field_ID=59306
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='55565bb7-0632-4fc2-b1e0-0f54911c3d5c' WHERE AD_Field_ID=59310
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='1530ed2a-f7b1-4234-b720-ecc64147cb0a' WHERE AD_Field_ID=59311
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='181ac990-8fe4-4070-b5c5-6e5fad669f2f' WHERE AD_Field_ID=59312
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='2275776c-242e-4321-951b-fc6ba2a590fa' WHERE AD_Field_ID=59313
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='72f7e577-b4dd-4799-a94f-1a9a74bf2c72' WHERE AD_Field_ID=59314
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='07811174-084d-44d4-b427-26dfd1af0cea' WHERE AD_Field_ID=59316
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='a24fc0c4-3637-4455-b9db-c10ad610bcbb' WHERE AD_Field_ID=59317
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='46fe299d-4cba-43ac-989f-e4c45615e993' WHERE AD_Field_ID=59318
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='6c76cec0-f557-4ae4-b14b-3a0c371e25a6' WHERE AD_Field_ID=59320
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='0af21310-7dd2-435d-8ad9-9f6c566d26c6' WHERE AD_Field_ID=59114
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='a285bdb7-43a3-4a25-9f4a-7f2aaae87a6d' WHERE AD_Field_ID=59127
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='db71f061-b8b6-4bc1-9c5c-5de1f1090bc5' WHERE AD_Field_ID=59338
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='5a233a25-3469-400c-a6d1-ca76c0d41d57' WHERE AD_Field_ID=59366
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='9c57bd2f-58c2-4c55-ba17-a0c4fbabe096' WHERE AD_Field_ID=59368
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='a6c7962d-fcfd-477e-bd56-a35fcc66d7f3' WHERE AD_Field_ID=59370
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='08f78449-4ec0-4094-b8ba-933b6ad69771' WHERE AD_Field_ID=59380
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='479d167a-d2dc-4be0-a4b4-6f6c0c694a77' WHERE AD_Field_ID=59382
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='0027330d-b9e7-449b-a43c-51b319dd658d' WHERE AD_Field_ID=59384
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='7415258d-b2d8-4455-a8cd-a52e8215a4da' WHERE AD_Field_ID=59387
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='a191e0c0-2462-4190-b054-8f630f259c9f' WHERE AD_Field_ID=59389
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='772f3bea-1aa2-4726-a713-71941c2efeb1' WHERE AD_Field_ID=200534
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='6ab36ff9-173a-4e6d-9d52-adf8d1f19cb2' WHERE AD_Field_ID=200543
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='43285f8c-b8f1-4e0e-adb6-d9e29093b743' WHERE AD_Field_ID=200548
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='4261b70d-120b-4da6-b8d4-a18dfed4ede2' WHERE AD_Field_ID=200291
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='a4d4f7a2-c8ac-4869-9c57-038f11090ceb' WHERE AD_Field_ID=59004
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='d22748f5-d007-45af-b6cb-32510f57c2f7' WHERE AD_Field_ID=59019
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='e245ddbd-2069-44dc-a7d8-8f6de62eebc8' WHERE AD_Field_ID=59153
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='c9f34493-f15a-4734-9d87-ecf7f1e6531f' WHERE AD_Field_ID=59156
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='fea86b13-ef28-4b3a-abe4-a3a42ff58cd0' WHERE AD_Field_ID=59158
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='cfc5f30c-259b-477a-a3fa-15dc341a3468' WHERE AD_Field_ID=59160
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='57d15fb2-dd0f-4c69-bcf5-0352a27dc106' WHERE AD_Field_ID=59186
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='543e899c-214f-4103-8325-799c05cc68c6' WHERE AD_Field_ID=200518
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='078345dd-4fdb-4033-be4f-c405b6af921a' WHERE AD_Field_ID=200536
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='91377f74-4424-4ac1-be8e-2bad8a0539cf' WHERE AD_Field_ID=59005
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='586e7f08-be60-426d-b714-9bcefccf21bf' WHERE AD_Field_ID=59195
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='64be8b64-3c67-4861-a70f-a0888af151d8' WHERE AD_Field_ID=59196
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='7859295c-385d-4b0c-8fc2-2ab9c1b005d4' WHERE AD_Field_ID=59492
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='fc5fe7c8-e698-471d-8edd-c856f7e14bf9' WHERE AD_Field_ID=200297
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='3724a262-6f2c-4f77-857d-ef9a17c5e886' WHERE AD_Field_ID=59197
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='ccf0e1b2-9368-4f7a-9a3b-1834d33c54d0' WHERE AD_Field_ID=59048
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='fedae2d2-2fc8-4412-84de-b25dda76519a' WHERE AD_Field_ID=59049
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='66ce9fba-8ef5-49ef-8bec-002c84bb5f03' WHERE AD_Field_ID=59126
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='6b7ab24b-a1eb-42e8-86c3-5a4900417517' WHERE AD_Field_ID=59128
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='255994a9-4ced-45f4-8886-7e62957b0751' WHERE AD_Field_ID=59129
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='47639edd-a4e4-429c-8d11-eceb5c0b306c' WHERE AD_Field_ID=59130
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='6bb2238c-6ff6-4866-85d4-8548a84a4d4a' WHERE AD_Field_ID=59131
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='8bc6a5a2-167d-4e6c-8617-8888b60563dd' WHERE AD_Field_ID=59218
;

-- Oct 31, 2012 12:37:45 PM COT
UPDATE AD_Field SET AD_Field_UU='3dda0766-ac96-45eb-8464-fae0e0cbcf4e' WHERE AD_Field_ID=59359
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='6a145a50-696e-46ba-8e65-edaeffa007ab' WHERE AD_Field_ID=59361
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='084c33d1-3309-4bcc-bab8-2d5db7d34d8e' WHERE AD_Field_ID=200294
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='a4858dcc-1187-434e-bafc-177495e9c9a4' WHERE AD_Field_ID=59132
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='ba7a0d77-0ded-4eac-930b-8a48378cc6e9' WHERE AD_Field_ID=200050
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='8ad08d38-7ab2-4f6f-ab57-012e383a4e1c' WHERE AD_Field_ID=59001
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='65ebd17a-170b-4070-b992-4aad4badaaad' WHERE AD_Field_ID=59046
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='6216057c-3867-4a6e-83d3-013da0869ecd' WHERE AD_Field_ID=59047
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='f7228048-9028-4f14-8806-9e81e25f9684' WHERE AD_Field_ID=59298
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='8244801c-73fe-4568-a03f-5c02f5062420' WHERE AD_Field_ID=59325
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='5dd53ed6-6ee3-4e1f-b774-d9d7ebb21d37' WHERE AD_Field_ID=59326
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='38224e38-4397-4ccf-af79-dc10bcfd626d' WHERE AD_Field_ID=59327
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='c8262c92-42b9-451c-b111-42709615598a' WHERE AD_Field_ID=59329
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='860b68d0-6be2-40aa-bd61-a29ed583bc0b' WHERE AD_Field_ID=59333
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='aad6f741-dc36-45e4-b540-91defee8e8b1' WHERE AD_Field_ID=59097
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='d60043f2-45e8-4117-8d4a-b4088ce234a0' WHERE AD_Field_ID=59342
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='a499d918-5f54-4fa2-8890-f1e6f1323823' WHERE AD_Field_ID=59377
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='4172cd04-5068-41a8-bcde-644f0c95e65f' WHERE AD_Field_ID=59379
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='a6a691cf-bf48-4ae5-9212-a8787967bc9c' WHERE AD_Field_ID=59381
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='68c9173d-feee-48d8-834d-473f2620e964' WHERE AD_Field_ID=59383
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='b9efec1f-c65f-473d-bdd6-7bc729eb914e' WHERE AD_Field_ID=59385
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='a5f3ccd8-e1a2-4f17-9a47-1e66bf2036ac' WHERE AD_Field_ID=59406
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='9ab884e9-5986-4f87-bc8c-283afbaffb9f' WHERE AD_Field_ID=59407
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='3404bbeb-221e-4dbf-961b-c94953c6297a' WHERE AD_Field_ID=59408
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='d9fc3cb3-332b-4589-b779-60cc2f72f0ea' WHERE AD_Field_ID=59409
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='8ccf0736-2f0f-4cb0-96e6-e282d2793a5b' WHERE AD_Field_ID=59290
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='d27193fe-988a-477d-8fec-8b6d2bea80e5' WHERE AD_Field_ID=59244
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='5834201d-49cb-4d3a-b50a-f45f34cb3130' WHERE AD_Field_ID=59248
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='ec26ba3e-2b5e-42db-aeb3-06a01f381d48' WHERE AD_Field_ID=59472
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='b6522e0e-244c-4831-aa73-1114e9cc46ea' WHERE AD_Field_ID=59477
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='40bcf2e4-038a-4b6c-a1f9-61bcfdd16aaf' WHERE AD_Field_ID=59223
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='d059ada9-07e3-4da8-9c71-ab006b949a42' WHERE AD_Field_ID=59226
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='c0e3a9c0-570c-43a3-8e45-d294d19518d7' WHERE AD_Field_ID=200526
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='61eccd77-067b-44c9-95b6-9d0dc4ca1a59' WHERE AD_Field_ID=200519
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='e1602081-6875-4c27-94f8-d96155b3a3bc' WHERE AD_Field_ID=200524
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='35653d7e-2244-461b-858f-3cf83b0dde5b' WHERE AD_Field_ID=200525
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='aad442dc-924d-4214-bd89-9d40e5c7cf32' WHERE AD_Field_ID=200527
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='2cab662c-eb60-44eb-b23a-be131d3c91ec' WHERE AD_Field_ID=200531
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='1fd34aeb-3461-4e84-9c59-5217f46735ba' WHERE AD_Field_ID=200533
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='555942f4-3688-4bda-b2cb-10219beef192' WHERE AD_Field_ID=200544
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='1906a8ed-43a5-42e3-86a2-f0b760c78ffb' WHERE AD_Field_ID=200545
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='c92655e5-9932-4f17-bbcc-8a7ef514cc11' WHERE AD_Field_ID=200547
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='396fbb2d-0fa5-462e-b850-fcb6aa5000ca' WHERE AD_Field_ID=200551
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='d8206036-2f94-4dff-8cc1-930f9f803020' WHERE AD_Field_ID=200528
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='7e2ab708-23b4-4f19-a99e-985ab61c1b0b' WHERE AD_Field_ID=59194
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='34d871dc-a9b9-403f-940b-cffdbc84e9a8' WHERE AD_Field_ID=59088
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='ffbc0420-7200-47d4-bb53-30e2e327521d' WHERE AD_Field_ID=59103
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='64b20ff5-d850-4604-b45a-d210679a5bb2' WHERE AD_Field_ID=59104
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='17a709e3-2aaa-41fb-8d24-566403cf215d' WHERE AD_Field_ID=59106
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='490fb370-1b66-4f85-bb67-d04406869e9f' WHERE AD_Field_ID=59107
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='026b8cde-1b56-4835-aa29-a404bae246b1' WHERE AD_Field_ID=59111
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='4a9d03d4-6cf2-4316-b8d3-a359236bc8f2' WHERE AD_Field_ID=59143
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='0580c295-e800-4d1d-8079-aa51f9467d4d' WHERE AD_Field_ID=59166
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='6b8d25b8-dde1-49db-9a9c-5fc8fe2843b7' WHERE AD_Field_ID=59113
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='74f696dd-13fd-4b4a-aaab-631139d6626f' WHERE AD_Field_ID=59115
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='7f0b56bf-20e0-42c8-b340-33db39c8ca05' WHERE AD_Field_ID=59119
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='d2b400cc-a6af-453b-974f-d1f61c197c9d' WHERE AD_Field_ID=59121
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='add71b29-a59c-43a3-ac9e-6329f5c4bd78' WHERE AD_Field_ID=59122
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='8efc6901-ee7e-4250-b6fb-0e63d799cbdc' WHERE AD_Field_ID=59123
;

-- Oct 31, 2012 12:37:46 PM COT
UPDATE AD_Field SET AD_Field_UU='2c697c39-30d5-443e-94a3-bd9ec5304d36' WHERE AD_Field_ID=59191
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='6ae8b111-b3e2-43f9-9b14-2b65f12ec9ba' WHERE AD_Field_ID=59192
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='8163450b-d82c-4da2-8ea4-2bb2775512a0' WHERE AD_Field_ID=59212
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='7388f5c4-902d-4c5f-b1e7-8067e320100b' WHERE AD_Field_ID=59214
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='955c574f-1162-40c0-bb43-1833b53b3069' WHERE AD_Field_ID=59216
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='b9ce27ce-fb88-4942-9a11-96927717fe49' WHERE AD_Field_ID=59363
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='3fe7cd92-5ecf-4f86-add9-39f4f3a01b87' WHERE AD_Field_ID=59341
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='622cb2b4-3651-403c-beac-3bf7dee1a4b7' WHERE AD_Field_ID=59343
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='f194c091-6e56-4937-ac0b-0e7afd181dc4' WHERE AD_Field_ID=59360
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='31050300-0f28-4e9b-8b2e-0e2c1d00cf65' WHERE AD_Field_ID=59388
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='ab69847a-1f3b-4abe-b2a4-c406515a5f62' WHERE AD_Field_ID=59390
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='e1ebdb1e-cf66-4a73-9950-decc851e486a' WHERE AD_Field_ID=59159
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='1a2a0423-6025-4963-b27f-fb4bf3c9a12c' WHERE AD_Field_ID=59264
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='4dd4f3ea-2f4e-41e5-b6fa-26b8b9c73eaa' WHERE AD_Field_ID=59185
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='04bc2f91-d50e-44a2-8144-e5ec94ec17f6' WHERE AD_Field_ID=59493
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='43829dd9-215d-4e2c-9ff6-563f08e72211' WHERE AD_Field_ID=59495
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='c8f1c3d1-540a-4358-9be5-2075044e9419' WHERE AD_Field_ID=59471
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='5190ebb5-8c06-4dd5-a835-a9ab867f0704' WHERE AD_Field_ID=59474
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='28e69336-826d-4a91-8cde-695f115a00c9' WHERE AD_Field_ID=59478
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='7540432a-799d-4a97-9cbb-d5ed1cb39265' WHERE AD_Field_ID=59480
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='753a1b7f-4359-42ff-b5ff-c0c0e2e87391' WHERE AD_Field_ID=59489
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='164d1c0f-d1ec-4747-8bba-ca610d827bfe' WHERE AD_Field_ID=59140
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='19364181-2d11-4258-9e76-8131473a274d' WHERE AD_Field_ID=59141
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='5ff9536e-36dd-45a2-ad2a-427e29272b65' WHERE AD_Field_ID=59021
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='e1249300-04e1-4174-b76f-3330048f4b72' WHERE AD_Field_ID=59023
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='df4fcba5-8bed-45a9-bdac-a69841b7816c' WHERE AD_Field_ID=59025
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='747e41b7-8a3f-4eb1-b353-d8b02510e904' WHERE AD_Field_ID=59027
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='125f9efe-b1ae-45dc-9bf8-37617983205f' WHERE AD_Field_ID=59028
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='48883773-241c-434e-b3a0-ee226f03df9f' WHERE AD_Field_ID=59076
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='7f026cc7-2237-481c-a01e-6a348a451c78' WHERE AD_Field_ID=59078
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='bae31ae2-d685-4e56-816a-b441037f3ab8' WHERE AD_Field_ID=59080
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='e255bc41-96e4-4493-8ed4-fcb92dc4e740' WHERE AD_Field_ID=59087
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='82373575-c3c6-4e6a-98ee-ba2161b3e465' WHERE AD_Field_ID=59089
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='16eddf29-9d20-428e-beed-19d3ddbc4af9' WHERE AD_Field_ID=59144
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='80038126-c397-4472-836a-275606daec2c' WHERE AD_Field_ID=59116
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='841632ff-e277-416e-adaa-00a8ec6e7b84' WHERE AD_Field_ID=59135
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='8934f832-8e94-4787-91dc-83dfc33acebf' WHERE AD_Field_ID=59162
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='d449226e-1c0d-471a-bbfa-c4c95750e972' WHERE AD_Field_ID=59167
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='a658ee43-67e2-4374-8c6b-975da82dd907' WHERE AD_Field_ID=59169
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='02b9916b-aedb-4744-aa9e-d3added6e918' WHERE AD_Field_ID=59175
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='34633e95-3276-42a4-936a-d72cfe260a8c' WHERE AD_Field_ID=59180
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='f2815212-916d-40c6-9090-62fa21a13662' WHERE AD_Field_ID=59209
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='2ba472dc-8c29-4ab5-b2e3-2d125a4ce3db' WHERE AD_Field_ID=59213
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='0661c008-dcd5-496e-a8ad-cd94e1e7ca98' WHERE AD_Field_ID=59215
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='4cbcea17-67df-41f4-889d-2d7ee71857df' WHERE AD_Field_ID=59217
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='8ecf54bf-7e6f-4bc3-940f-65b9fb657569' WHERE AD_Field_ID=59219
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='226159f7-bbf3-4521-9404-15e4350c1023' WHERE AD_Field_ID=59272
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='9ff692bb-6624-46a0-ba0d-4cc04f01df10' WHERE AD_Field_ID=59275
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='adf0740f-5f28-4840-84d2-35bcb70175fd' WHERE AD_Field_ID=59282
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='112574df-6423-4a8c-95d4-c893f6d81ecd' WHERE AD_Field_ID=59304
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='8f6abdb6-68aa-490d-92b0-ee7712d25000' WHERE AD_Field_ID=59328
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='4855d028-7875-4c8c-ac0e-ac55f403423a' WHERE AD_Field_ID=59330
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='f35ae2c2-0f5e-4b87-b0f5-3d80e039b78b' WHERE AD_Field_ID=59344
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='727b4c8e-1553-4f12-9ca7-d10518e4ea5c' WHERE AD_Field_ID=59351
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='a83818ae-d477-481e-9a94-597ecc09c499' WHERE AD_Field_ID=59355
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='fb7437e8-0b54-4fc3-a924-e01c4c26bc1c' WHERE AD_Field_ID=59357
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='03b95f2e-cb68-41aa-8995-73c48f8a3b3d' WHERE AD_Field_ID=200540
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='5c6bbd70-5086-4184-b8a3-82f98115fb68' WHERE AD_Field_ID=200523
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='024f3d53-49c1-46fc-83bd-a25156404ba6' WHERE AD_Field_ID=200550
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='2ce672c9-512f-4a5d-be45-8aa308eeb3e9' WHERE AD_Field_ID=59081
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='57ef582b-1582-4f60-92f1-5a23e47d1fcf' WHERE AD_Field_ID=59054
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='c1b75178-85f5-4c28-860a-ca379454390e' WHERE AD_Field_ID=59112
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='430c8bae-1ff8-4eb2-bba5-b103fce21d50' WHERE AD_Field_ID=59133
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='7ddf56c6-4c6e-45ff-8622-dab90049e8a8' WHERE AD_Field_ID=59142
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='1df4e8c3-6a49-459c-8324-47ca5941e5a9' WHERE AD_Field_ID=59151
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='0d05282e-3225-46ba-a5c1-d1155b74f4c9' WHERE AD_Field_ID=59164
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='949076fe-c626-4c7d-9911-de8aca48102f' WHERE AD_Field_ID=59181
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='a332cee6-669e-49d3-b6cb-09d20e9479c6' WHERE AD_Field_ID=59188
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='be5cc822-3bf6-43dc-9a42-0ff3811e63b3' WHERE AD_Field_ID=59189
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='e8c4b6b3-f3c9-4595-ac11-7bed43bba8bf' WHERE AD_Field_ID=59339
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='97a3869c-ed35-4a42-ada0-d8ad5dedf13d' WHERE AD_Field_ID=59340
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='df774b8b-e18a-4788-948c-4940302b2833' WHERE AD_Field_ID=59190
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='5d3115a0-c188-4e29-bd09-04a4eba6ea6a' WHERE AD_Field_ID=59227
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='b922d108-3e0d-4642-ba65-7de41b7d17df' WHERE AD_Field_ID=59235
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='d7d225e3-c0a2-4446-8609-c09dcb24fe3b' WHERE AD_Field_ID=59392
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='15685b4c-20d0-4d9d-934f-c91653f58c67' WHERE AD_Field_ID=59247
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='e6466d91-1056-4b6c-914a-0031af1e65c9' WHERE AD_Field_ID=59250
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='ae2c5531-0db1-4b8f-8833-44803a07d311' WHERE AD_Field_ID=59278
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='0517f35a-7ac1-4fd4-bbe3-7f24e90e6491' WHERE AD_Field_ID=59284
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='b97607b7-fb84-483a-b1de-07a5fbe1364d' WHERE AD_Field_ID=59287
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='0d5b688d-dc2d-452e-87aa-25a7bc098d19' WHERE AD_Field_ID=59362
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='aea0170e-2b3f-4b69-b956-61a41e06afae' WHERE AD_Field_ID=59294
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='a5463438-1ce0-41a2-b3f6-a92394d28c33' WHERE AD_Field_ID=59302
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='79340292-ae1a-4f86-9a11-8e452c34e4c7' WHERE AD_Field_ID=59331
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='66e39ec3-3486-4a37-8d38-1fcf9e6c3394' WHERE AD_Field_ID=59334
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='4ac7d00e-cd74-4bc3-b2e1-8ac7ffa9dd4b' WHERE AD_Field_ID=59096
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='e0a5cecf-a910-4202-ab9b-81cd9c5194e6' WHERE AD_Field_ID=59336
;

-- Oct 31, 2012 12:37:47 PM COT
UPDATE AD_Field SET AD_Field_UU='224f2b7f-e993-4bc8-b325-79564574355f' WHERE AD_Field_ID=59337
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='f93768e3-9fb0-4ece-a283-5cd6a9358cb7' WHERE AD_Field_ID=59365
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='6f1531a0-02c8-4c31-b512-6b00396ac51c' WHERE AD_Field_ID=59386
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='dc9ffe5d-1ac7-4898-bb60-6eb5a7cdd5af' WHERE AD_Field_ID=59394
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='1cd3249a-2f58-4cbc-89e1-ca6468232aea' WHERE AD_Field_ID=59285
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='91445888-0466-422e-9aae-c64542460a64' WHERE AD_Field_ID=59500
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='ff8a9a31-08cc-43be-865d-3210c3971e58' WHERE AD_Field_ID=59491
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='6d434671-b354-4c3f-84f0-82085eb5ac9a' WHERE AD_Field_ID=59473
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='94428f57-ec3e-4dd8-976d-21085c4168d6' WHERE AD_Field_ID=200295
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='8f5039db-0330-4bfb-ad9d-146fa7de687c' WHERE AD_Field_ID=59082
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='e665a552-0a13-40b1-b8f4-6ab7d6b75a28' WHERE AD_Field_ID=59002
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='ef0ea194-c3fb-4a94-a224-00975dfd0cfd' WHERE AD_Field_ID=59165
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='69808185-7dca-4ef2-bd13-8675aa2bd336' WHERE AD_Field_ID=59286
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='14d3f616-f675-4ea5-b607-acf9c0e7aa28' WHERE AD_Field_ID=59307
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='380fdee5-841b-4ad5-8154-a3abccf50e6f' WHERE AD_Field_ID=59332
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='ea2e7f68-0a48-48ae-baaf-7896f206b27f' WHERE AD_Field_ID=59293
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='07c176fd-0835-40d8-907f-7eb238f45717' WHERE AD_Field_ID=59309
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='21d9cad2-b4ec-4b52-8d25-aa527967447a' WHERE AD_Field_ID=59280
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='4c2aed51-b526-4e41-81d8-8550f00350d5' WHERE AD_Field_ID=59399
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='d7222c2b-24c2-432d-bbea-07cdc45d136b' WHERE AD_Field_ID=59086
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='299bdea0-8b22-45a7-82a5-bb267fdf0b81' WHERE AD_Field_ID=59308
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Field SET AD_Field_UU='50695433-efb4-4ac0-b77c-049edaa47054' WHERE AD_Field_ID=59791
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_FieldGroup SET AD_FieldGroup_UU='ebf4f40b-28c2-4ab0-bd85-db514674f47a' WHERE AD_FieldGroup_ID=50016
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_FieldGroup SET AD_FieldGroup_UU='56a0dc0a-527e-4aff-824a-8436a3042afe' WHERE AD_FieldGroup_ID=50017
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_FieldGroup SET AD_FieldGroup_UU='2dd35686-1ba3-472c-afa0-2802b8815528' WHERE AD_FieldGroup_ID=50018
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_FieldGroup SET AD_FieldGroup_UU='70bf682c-e641-4ae1-9413-2389e3660651' WHERE AD_FieldGroup_ID=50019
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_FieldGroup SET AD_FieldGroup_UU='45faed4b-7422-430f-9853-40bf9eab1c3e' WHERE AD_FieldGroup_ID=50020
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Form SET AD_Form_UU='a8a8abd8-04f5-4e4f-959d-e47103e78b01' WHERE AD_Form_ID=53017
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='8d102ae1-dd14-4885-a281-b6120431fa9e' WHERE AD_Menu_ID=53280
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='aafea22c-4783-4862-9e53-8c2efd2a46d9' WHERE AD_Menu_ID=53284
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='7b501a12-7dd6-472f-9f38-536e2842d4ea' WHERE AD_Menu_ID=53297
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='4672fef9-7133-4a74-97b8-40e79f88c258' WHERE AD_Menu_ID=53298
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='53e73ccd-132f-4706-9373-c122868bd872' WHERE AD_Menu_ID=53296
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='7a1b7b3b-0f4d-4b35-bb8d-1636303c84f3' WHERE AD_Menu_ID=53350
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='9b581c1b-0681-47c7-8084-4707bd67f01b' WHERE AD_Menu_ID=53351
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='d6a77fa4-4574-4979-8c13-700d1cc64c23' WHERE AD_Menu_ID=200019
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='0f7fff58-5677-49cf-b5fe-e8b796dafabb' WHERE AD_Menu_ID=53277
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='0cc6f014-a176-424c-a4af-64bf209a3d93' WHERE AD_Menu_ID=53278
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='68b7da8a-0d9f-4a89-9acb-deb42a227e27' WHERE AD_Menu_ID=53275
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='00eaf907-755e-4b70-87ce-b3f7eae67d88' WHERE AD_Menu_ID=53299
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='273996cb-d938-4111-bcf2-11b585e866ea' WHERE AD_Menu_ID=53352
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='db9a8755-1212-4657-9a65-265448f4f5ac' WHERE AD_Menu_ID=53353
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='9d5047b7-be8a-4d84-b91a-147e6ef181d3' WHERE AD_Menu_ID=53354
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='4905acb8-435f-477e-93ea-cc9b3828db2a' WHERE AD_Menu_ID=53301
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='45cd5f4b-01e4-4f71-84c3-17f4681cbb7b' WHERE AD_Menu_ID=53302
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='e1daab44-0127-4862-bd0e-4cdf8b14e34b' WHERE AD_Menu_ID=53273
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='678991cf-c5bd-4e07-9078-1d9064b7917c' WHERE AD_Menu_ID=53274
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='9ee1cf7a-cc44-4d87-bef4-245194479184' WHERE AD_Menu_ID=200006
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Menu SET AD_Menu_UU='848b0d57-4408-4aa0-b3dd-e16f3b9940cb' WHERE AD_Menu_ID=53300
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_Message SET AD_Message_UU='7e929055-9808-46d4-a932-7e20d2f0a24b' WHERE AD_Message_ID=53137
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_ModelValidator SET AD_ModelValidator_UU='661c5a08-4d59-4192-a6c8-5e0269e773ec' WHERE AD_ModelValidator_ID=50004
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_PrintFormat SET AD_PrintFormat_UU='bf914950-4e5e-41ef-a547-7977879eb1d4' WHERE AD_PrintFormat_ID=50057
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_PrintFormat SET AD_PrintFormat_UU='d8688c25-d8ef-4a77-96b7-21a269a3435d' WHERE AD_PrintFormat_ID=200000
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_PrintFormat SET AD_PrintFormat_UU='062bcd68-d50d-4a9b-8641-79a565dea7e3' WHERE AD_PrintFormat_ID=200001
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='27a5f048-fe87-4f62-93e9-6c6c4312bfb0' WHERE AD_PrintFormatItem_ID=51709
;

-- Oct 31, 2012 12:37:48 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='b2d3414a-0103-435d-be10-30b0231a7edd' WHERE AD_PrintFormatItem_ID=51710
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='0f0b7962-bb77-46b8-a946-09a4a95cb23c' WHERE AD_PrintFormatItem_ID=51711
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='49d7e1ba-f2f6-4bb8-9d10-11dbd7fad643' WHERE AD_PrintFormatItem_ID=51712
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='e935ad92-db5c-4006-9472-fd3c8228ba60' WHERE AD_PrintFormatItem_ID=51713
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='5166c1e2-3786-4494-89de-b61e584aadd0' WHERE AD_PrintFormatItem_ID=51714
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='8196662d-e96e-4b5f-adef-430eba48d212' WHERE AD_PrintFormatItem_ID=51715
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='8a71dc53-d2f1-4bda-953f-7a1bba5972a6' WHERE AD_PrintFormatItem_ID=51716
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='50ac3b81-cc66-4f75-b783-9d67f5b061d6' WHERE AD_PrintFormatItem_ID=51718
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='06a980df-ac11-4165-af95-733a45733819' WHERE AD_PrintFormatItem_ID=51720
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='11524b97-fe07-4c57-90b8-9d87f60fe61e' WHERE AD_PrintFormatItem_ID=51721
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='ba805f41-1ffb-4fbc-b9fd-f1d6190cba2a' WHERE AD_PrintFormatItem_ID=51722
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='09f2f297-fd12-4563-a9f3-1e645f0a1bb1' WHERE AD_PrintFormatItem_ID=51723
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='7db18ed5-0b13-4bbb-be6b-5158bbe384f1' WHERE AD_PrintFormatItem_ID=51717
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='d5b65a82-61a0-4966-b2a5-b92c8d1a9b6c' WHERE AD_PrintFormatItem_ID=51724
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='f6f287c2-5d0d-4529-82e3-8ac81f3e521c' WHERE AD_PrintFormatItem_ID=51725
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='eca8afc4-51da-4111-b110-08747a97e219' WHERE AD_PrintFormatItem_ID=51726
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='bc96a664-66a5-4d39-bcfb-5efd27bef0d1' WHERE AD_PrintFormatItem_ID=51727
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='ae08b040-ead2-47c4-b4f0-693306ac0115' WHERE AD_PrintFormatItem_ID=51728
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='d0f325bf-3029-41cc-82e0-26e0461475c5' WHERE AD_PrintFormatItem_ID=51729
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='992762c0-f247-4cf4-bfb7-3476cc7198ef' WHERE AD_PrintFormatItem_ID=51730
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='619880f4-c673-4592-8c7b-b3777660944f' WHERE AD_PrintFormatItem_ID=200002
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='5baaf657-2034-45a1-8362-5509a05bdb11' WHERE AD_PrintFormatItem_ID=200003
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='1b1cf064-df12-4a5f-af66-0f35cedc13d5' WHERE AD_PrintFormatItem_ID=200005
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='0b9a9015-7ada-47f8-bfb3-cd48d8a8aff6' WHERE AD_PrintFormatItem_ID=200009
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='4f5c6734-d236-483f-82f1-b905a20e85b6' WHERE AD_PrintFormatItem_ID=200007
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='fddd10df-273e-4660-9430-143e93708efe' WHERE AD_PrintFormatItem_ID=200004
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='d6718646-8009-4c8a-a67b-ced6f5aee911' WHERE AD_PrintFormatItem_ID=200006
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='de9f5daf-96ed-473b-9327-cb8e028acbd0' WHERE AD_PrintFormatItem_ID=200023
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='b7a7eb36-7a5b-4510-9c6f-b61b15e31a1f' WHERE AD_PrintFormatItem_ID=200001
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='e822e936-559f-4815-9836-5f074ed38c65' WHERE AD_PrintFormatItem_ID=200000
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='0597ab68-9c96-4e08-b606-7b8f4059cd49' WHERE AD_PrintFormatItem_ID=200008
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='de1edff6-6777-4726-aaf2-b84171ee7069' WHERE AD_PrintFormatItem_ID=200010
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='df91b0ae-bd54-4e87-aa04-36acfa0a7461' WHERE AD_PrintFormatItem_ID=200011
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='f11704eb-7729-415d-919b-f9491dcbb772' WHERE AD_PrintFormatItem_ID=200014
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='0d2493d0-da96-4116-9056-c4dc5e534d4f' WHERE AD_PrintFormatItem_ID=200015
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='6d734aee-1799-4022-a021-617a76925d45' WHERE AD_PrintFormatItem_ID=200025
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='f193f8e1-df02-4169-ae46-b73acd77220f' WHERE AD_PrintFormatItem_ID=200020
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='bc92b97f-5071-4c94-8521-9f03e6537d20' WHERE AD_PrintFormatItem_ID=200018
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='effa540a-f3b9-47d2-ad1d-6fbfbfe8a691' WHERE AD_PrintFormatItem_ID=200032
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='0ede66ba-d99a-4cfc-a58d-f8607dc1a8f3' WHERE AD_PrintFormatItem_ID=200016
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='773e01bb-b336-4826-9f05-960f3e6aeadf' WHERE AD_PrintFormatItem_ID=200030
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='b34d8bc9-6338-404d-be39-0054dc371007' WHERE AD_PrintFormatItem_ID=200027
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='bae6529a-93c0-446d-8f7d-635927b61cc0' WHERE AD_PrintFormatItem_ID=200029
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='d30864ee-7cf6-4f80-b3ad-c10e04db165e' WHERE AD_PrintFormatItem_ID=200019
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='29056c23-dfd6-4075-ac35-b24c28ce6a1b' WHERE AD_PrintFormatItem_ID=200021
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='32013b19-0199-49e9-aa73-dce431086e36' WHERE AD_PrintFormatItem_ID=200022
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='016149f4-6df2-4b1b-8a6b-c80aae2b63db' WHERE AD_PrintFormatItem_ID=200017
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='da3b0244-df9e-4e92-a5f6-b06fd15ab430' WHERE AD_PrintFormatItem_ID=200024
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='19f6763c-23b3-47fb-99c8-d00c93942b61' WHERE AD_PrintFormatItem_ID=200028
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='ee950dbf-8fe0-45d3-aa7f-e3df52ba5286' WHERE AD_PrintFormatItem_ID=200031
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='8c3f047e-6c20-463b-968f-89647c51439a' WHERE AD_PrintFormatItem_ID=200026
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='fdaa384c-a771-41b0-800c-73d95c181c13' WHERE AD_PrintFormatItem_ID=200045
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='7ca70573-930f-43b2-8553-355e50c930dd' WHERE AD_PrintFormatItem_ID=200049
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='39173248-dd4a-4083-8dd8-302f173cb067' WHERE AD_PrintFormatItem_ID=200033
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='4b9373b2-011b-4b84-ae71-db6c01fb730e' WHERE AD_PrintFormatItem_ID=200064
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='eab7d6cf-d23a-4c2d-bb1f-d1e4e70a9142' WHERE AD_PrintFormatItem_ID=200055
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='baf7f2ad-8950-4c1c-9b52-a0548e858b1b' WHERE AD_PrintFormatItem_ID=200054
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='c1c3a5b3-d8ce-4cf0-a984-52d73451d66d' WHERE AD_PrintFormatItem_ID=200038
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='7b53faf9-dccc-44ea-ad51-5a1ff33428ae' WHERE AD_PrintFormatItem_ID=200037
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='1f8d744d-d8de-4f11-afaf-71d6c1ca380d' WHERE AD_PrintFormatItem_ID=200039
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='6b8a2719-d0a1-4f57-848a-8211a70e3eb5' WHERE AD_PrintFormatItem_ID=200040
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='84bbd538-fd73-4ffe-b8d7-91de16806443' WHERE AD_PrintFormatItem_ID=200034
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='ee40e17d-89e6-4ddb-acf7-f10d15f2eacb' WHERE AD_PrintFormatItem_ID=200043
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='93e8ca1c-106a-4266-af4e-2d251351d7a5' WHERE AD_PrintFormatItem_ID=200048
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='2038c387-3115-4c59-8326-a5083c4aa740' WHERE AD_PrintFormatItem_ID=200053
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='cae22754-0c4b-4e04-b38a-96fd9e08b9a4' WHERE AD_PrintFormatItem_ID=200044
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='46f76e49-59b3-4b18-bda2-a0bf65ce47e6' WHERE AD_PrintFormatItem_ID=200051
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='8c6704ab-2195-47e9-bba7-1a1c8faf5ee8' WHERE AD_PrintFormatItem_ID=200036
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='8e948bc3-75d7-4736-8a2d-f283e7b11b82' WHERE AD_PrintFormatItem_ID=200062
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='f11b9bc4-8a55-4aec-80e1-b0adcb619594' WHERE AD_PrintFormatItem_ID=200063
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='3a1c4cb0-22c1-480c-9a36-8721b9ce6933' WHERE AD_PrintFormatItem_ID=200042
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='239c02ad-314d-40b6-9e5f-edab86efb719' WHERE AD_PrintFormatItem_ID=200052
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='9ee204cc-5d4d-44e9-ba37-912e1d92e58d' WHERE AD_PrintFormatItem_ID=200047
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='1629004b-33ef-4162-9b35-3cb7323f0ec4' WHERE AD_PrintFormatItem_ID=200050
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='0184a219-cd08-40d3-aa64-1107ef55930f' WHERE AD_PrintFormatItem_ID=200056
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='9b699129-7fe1-42e0-ae8a-471594409701' WHERE AD_PrintFormatItem_ID=200061
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='c9fa513b-6653-4d6c-814e-29fd8513561d' WHERE AD_PrintFormatItem_ID=200057
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='5785fc70-b879-4f93-bace-4147cbcfa63d' WHERE AD_PrintFormatItem_ID=200035
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='8f79c732-78a1-4bd2-b93a-69f7b2fb72e6' WHERE AD_PrintFormatItem_ID=200041
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='ecbb0987-806a-4620-b7dd-79bf5e057fdf' WHERE AD_PrintFormatItem_ID=200058
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='7f855535-663a-44f8-b3af-8a0c7c5497f5' WHERE AD_PrintFormatItem_ID=200060
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='4f888e22-17bd-492f-8a8b-73bb0692bf33' WHERE AD_PrintFormatItem_ID=200066
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='41eefe9c-d14f-48fa-b6f5-6f673288c1eb' WHERE AD_PrintFormatItem_ID=200059
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='60ce45c2-00ad-4e50-ad7d-e2baa1b3713d' WHERE AD_PrintFormatItem_ID=200078
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='b562f258-9951-4b4b-b48d-b4db81c6d551' WHERE AD_PrintFormatItem_ID=200065
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='6b7939eb-e4de-4131-8421-50794fa5daa3' WHERE AD_PrintFormatItem_ID=200046
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='c29145d8-1009-459c-972b-5926a714fd0e' WHERE AD_PrintFormatItem_ID=200079
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='e9ab7c1e-9600-43d9-9948-ce10713a401b' WHERE AD_PrintFormatItem_ID=200012
;

-- Oct 31, 2012 12:37:49 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='4f68bb94-19d4-4a39-ac52-9b88ca80a62d' WHERE AD_PrintFormatItem_ID=200068
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='1c50ac71-5be2-4a09-8927-5f02ae2b0f7a' WHERE AD_PrintFormatItem_ID=200070
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='77e89572-31ad-4574-aedc-96af47e81c3d' WHERE AD_PrintFormatItem_ID=200069
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='0a558791-99df-4698-af3c-49cebf7f7fa4' WHERE AD_PrintFormatItem_ID=200071
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='e9d433ad-2c41-4079-83e3-dc9e24904fe8' WHERE AD_PrintFormatItem_ID=200072
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='a7817071-b186-45de-81ff-211e228568cf' WHERE AD_PrintFormatItem_ID=200073
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='9fd5b010-3337-4c84-9095-aa99baea1a13' WHERE AD_PrintFormatItem_ID=200074
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='dc4237db-8745-4ce2-b730-21460219fe60' WHERE AD_PrintFormatItem_ID=51719
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='1c602e1c-cb4d-4a48-bf20-144c6f6fb9b8' WHERE AD_PrintFormatItem_ID=200084
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='d666e9eb-fafd-4b6c-94e1-cd6e7f5f43c8' WHERE AD_PrintFormatItem_ID=200077
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='e1e39277-128f-4ce9-b2ca-29bc92c11f8a' WHERE AD_PrintFormatItem_ID=200080
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='100715a1-6e05-495c-998b-f70966c630d2' WHERE AD_PrintFormatItem_ID=200082
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='4e5aaecb-c53f-4c2b-bf54-4aea3dbf5485' WHERE AD_PrintFormatItem_ID=200076
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='10b9caa9-fafa-4da9-a399-b99187a30037' WHERE AD_PrintFormatItem_ID=200075
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='c6e3cfd3-7846-416c-99f8-0853830afd2d' WHERE AD_PrintFormatItem_ID=200013
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='14aad2a3-8a8a-4685-b210-52fca315b43e' WHERE AD_PrintFormatItem_ID=200085
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='1749b891-78a0-4f76-9353-2838722f7842' WHERE AD_PrintFormatItem_ID=200081
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='8741733a-b1ce-41f0-b40a-b733014ac2f3' WHERE AD_PrintFormatItem_ID=200067
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_PrintFormatItem SET AD_PrintFormatItem_UU='6f8ac12a-6f9a-4760-a4cf-2957b75a03c1' WHERE AD_PrintFormatItem_ID=200083
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='01dad84b-1d2c-4965-ae32-2ffdb7758e5c' WHERE AD_Process_ID=53229
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='e355de9c-6c81-4cac-ac8e-5d12d34fe75c' WHERE AD_Process_ID=53230
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='08bf9a66-cd12-431c-b8eb-6ffb8f9be39a' WHERE AD_Process_ID=53265
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='d081800b-458d-468c-b99f-fa3f8f5fcd9b' WHERE AD_Process_ID=53227
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='93f9a3f1-91a2-4e64-bed6-96464e30037c' WHERE AD_Process_ID=53226
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='dffb0add-700b-4a61-b69f-f772da1d1378' WHERE AD_Process_ID=53228
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='191be2cc-9bb9-4ca0-b280-36edaf51c610' WHERE AD_Process_ID=53264
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='8498cbf2-63fe-4ebf-b3c7-e2146c7d5b0e' WHERE AD_Process_ID=200010
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='38ad0704-5ba9-4a6a-83e2-a65054b4c080' WHERE AD_Process_ID=53208
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='10d75dce-5b1c-427f-bc1d-d6884dc679ad' WHERE AD_Process_ID=53210
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='bcd08a2b-4699-4f40-aa41-fa95eede237b' WHERE AD_Process_ID=53212
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='fc7ef5a4-dca3-4f2a-a542-ca5473990d3f' WHERE AD_Process_ID=53214
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='8d1334c7-213b-4ec2-b532-cfc1fa9300db' WHERE AD_Process_ID=53213
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='b48a9168-4ed0-4f4b-b291-a0c50fd93ecf' WHERE AD_Process_ID=53215
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='1c33a3db-41e3-427d-b001-10b00a70575b' WHERE AD_Process_ID=53207
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='3719aed9-c68b-46b3-b313-9d57cdb77805' WHERE AD_Process_ID=53211
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='55d410ae-0308-4d6a-8a0c-b91b184f097c' WHERE AD_Process_ID=53266
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='9fa8bfaa-3709-46c9-93be-19a9983c73e2' WHERE AD_Process_ID=53267
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='780bfd00-d0d0-4bff-a34d-69939ab05269' WHERE AD_Process_ID=200007
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='bdd3b2a7-26a0-426b-bd08-632c31635d1f' WHERE AD_Process_ID=200006
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process SET AD_Process_UU='090ab380-b479-4b31-a8f5-ad883aebe1ef' WHERE AD_Process_ID=200000
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='a7ef5332-3edd-4594-af42-13e58c9eb7b8' WHERE AD_Process_Para_ID=53466
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='d8ac1956-92a7-42d6-9d65-b7e131ce5e31' WHERE AD_Process_Para_ID=53459
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='9f15521a-2745-4aef-b204-3b1ed7fbd401' WHERE AD_Process_Para_ID=53461
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='73f4a9c0-4ee6-4523-8357-0ce09e34a634' WHERE AD_Process_Para_ID=53462
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='2039eb9c-7fd5-4f56-90f5-ea1e0b443a85' WHERE AD_Process_Para_ID=53463
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='150caa91-f916-4137-9d0d-a09b9a0d0870' WHERE AD_Process_Para_ID=53464
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='6c8cf1c6-956a-42d1-9af0-f674057fdb04' WHERE AD_Process_Para_ID=53465
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='978a0811-69d9-4f89-8555-44a14b38d1b6' WHERE AD_Process_Para_ID=53460
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='827e086c-5f1b-4aa4-90aa-61fc8d0322de' WHERE AD_Process_Para_ID=53526
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='b3b419dc-d061-497a-8182-2e3f4e207257' WHERE AD_Process_Para_ID=53527
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='63faac5e-4521-4651-96dc-b7f9c06083a5' WHERE AD_Process_Para_ID=53528
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='61a34161-c8bb-4e58-9a82-2a187455b3e5' WHERE AD_Process_Para_ID=53525
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='4a82d150-e2cf-4cc2-aa0b-648551c8243d' WHERE AD_Process_Para_ID=53524
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='6e2b7294-e8d4-467a-9379-389c5ed16118' WHERE AD_Process_Para_ID=53523
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='4da38235-105f-4067-99af-c523fc05cab1' WHERE AD_Process_Para_ID=53517
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='f9338c01-6cd2-499b-8562-3355d4922fcc' WHERE AD_Process_Para_ID=53518
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='cff5e281-7ba4-4c5d-b40c-9da9c2bc879b' WHERE AD_Process_Para_ID=53519
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='78272acd-c8d5-4177-a619-610bc0ccaf3b' WHERE AD_Process_Para_ID=53521
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='47d7a84a-32d2-46a7-b7c1-e63ecfbc1d2e' WHERE AD_Process_Para_ID=200041
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='d1e76a8d-5771-4104-bb4a-008d25722588' WHERE AD_Process_Para_ID=200042
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='55d972ee-2341-48d0-90d9-c383daace692' WHERE AD_Process_Para_ID=53520
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='054faa84-27d8-4fb3-9c64-1e81ead1ab3c' WHERE AD_Process_Para_ID=53522
;

-- Oct 31, 2012 12:37:50 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='5b9f4efd-a1a3-4046-a534-a0a7e1b09c19' WHERE AD_Process_Para_ID=200036
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='222c7938-9b8e-4301-9363-611c6d6cc729' WHERE AD_Process_Para_ID=200037
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='b95cc651-a05d-482c-8e10-392cceb3874d' WHERE AD_Process_Para_ID=200038
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='27d315be-1ca0-4393-9ee7-b600a9b7bc15' WHERE AD_Process_Para_ID=200039
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='07033e00-6aa0-4796-aed4-d9a21cac579e' WHERE AD_Process_Para_ID=53516
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='933bf575-bfb5-41ae-9a06-480cc000d058' WHERE AD_Process_Para_ID=200040
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='9758dc2c-bf41-4a61-ac89-0c7721dba370' WHERE AD_Process_Para_ID=53412
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='5cbbd447-7a37-48c6-b06f-60dd8be2ba02' WHERE AD_Process_Para_ID=53413
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='50518da6-1a2a-4fa6-8de6-e4743dbff4a3' WHERE AD_Process_Para_ID=53414
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='ba3a79b3-57a1-4c78-a240-a9f2a2e11ec5' WHERE AD_Process_Para_ID=53415
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='effbc323-d585-47f9-ad23-8cf491ec1a35' WHERE AD_Process_Para_ID=53416
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='6d4f59ed-5f47-4761-9a0a-b956b21aa6da' WHERE AD_Process_Para_ID=53417
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='cfea5f2d-5d51-4c0e-bf6c-5494dffdf65b' WHERE AD_Process_Para_ID=53418
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='b4288d43-069d-4fcd-81cb-3d2d0d582d47' WHERE AD_Process_Para_ID=200000
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='97118695-b8f5-4600-bb60-27812d462fc9' WHERE AD_Process_Para_ID=200001
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Process_Para SET AD_Process_Para_UU='49d4339e-02b3-4e15-964f-e9bba7dd2d51' WHERE AD_Process_Para_ID=200002
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='eca497f3-bfd7-4b8b-b861-1e510877f605' WHERE AD_Reference_ID=53412
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='fecfd227-3c55-4ca7-bec7-bd66a7406005' WHERE AD_Reference_ID=200008
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='7b48dd14-d089-400c-b16d-50031f6727b8' WHERE AD_Reference_ID=53357
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='21572c14-4801-499a-a2cd-0c1c9c1230ba' WHERE AD_Reference_ID=53358
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='f973985f-3064-40de-b097-baed00bb8d5d' WHERE AD_Reference_ID=53359
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='4d85e435-2f2b-4b11-b080-6b71c7fc2acd' WHERE AD_Reference_ID=53360
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='4fa96274-d213-4780-85dd-8c5109c7e1bf' WHERE AD_Reference_ID=53361
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='b09cf99b-4e59-4062-916a-fdb5a3bbb49e' WHERE AD_Reference_ID=53362
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='e4da3901-4a0f-409b-a84a-ec00d064d287' WHERE AD_Reference_ID=53363
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='e792608b-74cb-456f-9fcd-4735b1860a59' WHERE AD_Reference_ID=53364
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='559c5ec8-a55d-4145-ac12-8058aa9dfd93' WHERE AD_Reference_ID=53365
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Reference SET AD_Reference_UU='a3ea7a5e-3270-48c7-8d62-fcbd8a6a0b74' WHERE AD_Reference_ID=53366
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='b1964785-5ba4-4522-8661-5d34d78452e3' WHERE AD_Ref_List_ID=53708
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='571f15cf-8cb1-49a4-b1ad-997905b5acd8' WHERE AD_Ref_List_ID=53709
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='e0e8a2fc-a8ad-486f-957c-4c8417d5f5e6' WHERE AD_Ref_List_ID=53710
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='20e2b476-b0fd-48ae-85ac-cf6d165a8012' WHERE AD_Ref_List_ID=200027
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='ae07960f-9620-4c40-bff7-3171d1f52a10' WHERE AD_Ref_List_ID=200028
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='f17a68c5-0488-4718-a249-dd1f96c0f77f' WHERE AD_Ref_List_ID=200029
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='d2cdd31e-4373-4f35-8d01-22946c3c6211' WHERE AD_Ref_List_ID=53587
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='dd8c1848-6fb8-4829-8855-7c3b314514fd' WHERE AD_Ref_List_ID=53588
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='583c5228-ad5d-48cd-819b-97673805b1fa' WHERE AD_Ref_List_ID=53589
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='3f742175-42b0-4775-9eb3-ed5fefd0ca7a' WHERE AD_Ref_List_ID=53590
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='785b94f6-fbd7-49a7-b752-45a6d0df3888' WHERE AD_Ref_List_ID=53591
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='9ac1f818-4159-463f-81c4-b55923e94c9e' WHERE AD_Ref_List_ID=53592
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='b2aa86a9-566c-4762-98d5-c4b5c243a2cd' WHERE AD_Ref_List_ID=53593
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='fee6717e-7137-4035-9a83-bb96a6d111f8' WHERE AD_Ref_List_ID=53594
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='538261b3-5e19-445d-b54d-350c9b9fac92' WHERE AD_Ref_List_ID=53595
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='c72b48b9-f248-4e9d-9fd8-4afae918bef8' WHERE AD_Ref_List_ID=53596
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='c81b8475-74d3-41d5-8ff5-6de9e2db2436' WHERE AD_Ref_List_ID=53597
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='084daa2e-0720-47e2-8923-01793426c9a2' WHERE AD_Ref_List_ID=53598
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='3a74baee-45d7-4d09-84eb-37efa01e9ca0' WHERE AD_Ref_List_ID=53599
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='194f5d34-a04e-48c2-8e5a-8a81c326657c' WHERE AD_Ref_List_ID=53600
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='1bddac4c-bcc8-4758-8630-d80555b14a62' WHERE AD_Ref_List_ID=53601
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='2d7b24ae-5735-41a6-88f6-7aa5cc143493' WHERE AD_Ref_List_ID=53602
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='51a1b186-6af4-4373-9788-f9105aa65cfa' WHERE AD_Ref_List_ID=53603
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='3773d29e-2de2-42bb-a4f9-8b5bfbe771ac' WHERE AD_Ref_List_ID=53604
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='b689ef67-35b6-40c2-b0cb-18417d71b3dc' WHERE AD_Ref_List_ID=53605
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='6fafcbd4-e411-4d4e-ae98-6eb7b5f74f1c' WHERE AD_Ref_List_ID=53606
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='542d4bc6-837a-456a-8fb4-70ab76215909' WHERE AD_Ref_List_ID=53607
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='90cce63c-ef32-4917-97cc-e98bf04c7378' WHERE AD_Ref_List_ID=53608
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='31cd23ed-e20c-43e6-a12a-635f675e23d9' WHERE AD_Ref_List_ID=53609
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='6939008f-29e0-49b8-a30b-206b28c0d2b1' WHERE AD_Ref_List_ID=53610
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='934235d6-5b13-477f-a2b9-0b194a048d91' WHERE AD_Ref_List_ID=53611
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='44c8053c-dead-4cd4-97a8-920ef2aa7919' WHERE AD_Ref_List_ID=53612
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='09f9094c-2674-4f58-878b-a32e5a38b4d4' WHERE AD_Ref_List_ID=53613
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='3392ad55-541f-4a2e-ba62-c92a28f6421d' WHERE AD_Ref_List_ID=53614
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='a45dcc33-c973-4744-955e-dd24518ef099' WHERE AD_Ref_List_ID=200039
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='755ad6f9-b471-4e05-830d-45724bea861a' WHERE AD_Ref_List_ID=53711
;

-- Oct 31, 2012 12:37:51 PM COT
UPDATE AD_Ref_List SET AD_Ref_List_UU='177e543a-45ef-4cb6-bf4e-b957f711ae41' WHERE AD_Ref_List_ID=53712
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Ref_Table SET AD_Ref_Table_UU='2e639216-f95e-4383-b0e2-cc14cf44217c',Updated=TO_TIMESTAMP('2012-10-31 12:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53357
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Ref_Table SET AD_Ref_Table_UU='7b06011c-d8e4-4250-8136-020621be36f0',Updated=TO_TIMESTAMP('2012-10-31 12:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53358
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Ref_Table SET AD_Ref_Table_UU='c174d0f0-b41d-44c6-bc3b-b5720be8e040',Updated=TO_TIMESTAMP('2012-10-31 12:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53362
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Ref_Table SET AD_Ref_Table_UU='35c39fa8-c329-49be-b7c1-4ad24a2ff53c',Updated=TO_TIMESTAMP('2012-10-31 12:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53366
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Ref_Table SET AD_Ref_Table_UU='e6fb8d40-0bc7-4c17-9c4a-117515ca3bdc',Updated=TO_TIMESTAMP('2012-10-31 12:37:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=53363
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_ReportView SET AD_ReportView_UU='42709692-254a-42c7-976e-ace3c57ba296' WHERE AD_ReportView_ID=53038
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_ReportView SET AD_ReportView_UU='7274b1e6-2041-4276-bf29-f6e76262b2e8' WHERE AD_ReportView_ID=53039
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Schedule SET AD_Schedule_UU='5a06dc76-704e-40f5-bfcf-724829332c50' WHERE AD_Schedule_ID=200000
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Schedule SET AD_Schedule_UU='4f00c688-f09e-4de1-bf8f-843eb880b0b8' WHERE AD_Schedule_ID=200001
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Schedule SET AD_Schedule_UU='7e846d4a-4493-4672-a764-1f34a9d0166f' WHERE AD_Schedule_ID=200002
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Schedule SET AD_Schedule_UU='611de4e7-beef-4914-a826-30d9b9e1be6d' WHERE AD_Schedule_ID=200003
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Schedule SET AD_Schedule_UU='d113fb57-99fd-4ced-98be-40f59ad6b0d6' WHERE AD_Schedule_ID=200004
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='934d6b0f-5206-405b-8d13-b2960e6e39df' WHERE AD_Sequence_ID=200021
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='4da6d4d5-23da-4563-9e5b-4b64c33c0358' WHERE AD_Sequence_ID=200022
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='f9e4cea4-6bfb-479f-9ec0-edc4a0631053' WHERE AD_Sequence_ID=200023
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='cc18290e-4601-4741-a9d0-cb868f710966' WHERE AD_Sequence_ID=53381
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='39e05cd2-73a3-4db6-a362-098e222aa366' WHERE AD_Sequence_ID=53386
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='5d902ee3-1184-45ba-8447-8c53c2859c30' WHERE AD_Sequence_ID=53382
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='2165541e-5001-46f7-80c3-82076cdc06c4' WHERE AD_Sequence_ID=53387
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='8733e529-cfa8-4390-a859-93a99d51bb2c' WHERE AD_Sequence_ID=53388
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='4d4bae0e-f7f3-413a-b477-7031d0596bc6' WHERE AD_Sequence_ID=53385
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='99c378f6-73c8-478f-a3d8-147230624ee5' WHERE AD_Sequence_ID=53391
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='c4d5f799-c3aa-4c30-9d57-751dd37738f1' WHERE AD_Sequence_ID=53445
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='b6662c9f-d215-4fa8-9d20-44d07a62bade' WHERE AD_Sequence_ID=53444
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='d6bbf8b7-659a-43a1-97c7-ff8fb13d2520' WHERE AD_Sequence_ID=53443
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='380ef91b-d162-49c9-8763-fc4581c7552b' WHERE AD_Sequence_ID=53442
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Sequence SET AD_Sequence_UU='83633895-36cf-4b72-ba78-47bc3df1e62c' WHERE AD_Sequence_ID=53446
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='b02502df-4de3-4249-9b5e-9c98ec4aabb7' WHERE AD_Tab_ID=53424
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='1b80c9c3-9773-4138-870c-96487f25bdc8' WHERE AD_Tab_ID=53421
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='68fee7b9-f80d-48a6-8a9f-679dbbb3ac97' WHERE AD_Tab_ID=53422
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='93387805-3a24-4c13-af43-72a7356e0930' WHERE AD_Tab_ID=53423
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='bae1dc79-bd36-4935-954d-9378114c3bdd' WHERE AD_Tab_ID=53344
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='8cc500ac-bb02-48c1-a5dc-4c3ddc345979' WHERE AD_Tab_ID=53345
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='f30d9e5b-a2f4-4259-a819-680ddcf2aa33' WHERE AD_Tab_ID=53346
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='59b33b9c-85d2-48ee-a22b-a4b2c91d4cbb' WHERE AD_Tab_ID=53347
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='1344f3e1-f59e-43b3-bfd2-98241a142397' WHERE AD_Tab_ID=200020
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='30d7b4da-8e61-4d22-9038-a26a27dab00e' WHERE AD_Tab_ID=200022
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='736a5f16-ec33-406b-8b8d-917a1cd214ce' WHERE AD_Tab_ID=200021
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='9a599cee-85ca-45e5-a3d0-6c51a45bc83e' WHERE AD_Tab_ID=53320
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='d072f6c0-cc39-4960-9de9-3c0c8effc804' WHERE AD_Tab_ID=53321
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='f640b449-8371-40e1-b7ac-9111a1f89f25' WHERE AD_Tab_ID=53322
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='65faeec2-d493-4df0-8b4f-2ac2623cc572' WHERE AD_Tab_ID=53323
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='e20d585b-44e5-4faf-9353-cbe7fdf929ba' WHERE AD_Tab_ID=53324
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='7375c1e1-a713-4769-8087-c9da6c47fd7b' WHERE AD_Tab_ID=53325
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='3da7ff79-21ec-453a-9237-f098767aa255' WHERE AD_Tab_ID=53326
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='2433e0ad-a36d-4d31-a4f2-e8d8cc29d3f9' WHERE AD_Tab_ID=53327
;

-- Oct 31, 2012 12:37:52 PM COT
UPDATE AD_Tab SET AD_Tab_UU='527a9f85-2887-4172-a21d-db9e6f573dc2' WHERE AD_Tab_ID=53328
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Tab SET AD_Tab_UU='eac71ce6-ecd4-4e6a-9a54-492c476de399' WHERE AD_Tab_ID=53329
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Tab SET AD_Tab_UU='0871c486-143b-44a7-b0db-eb1eee42317b' WHERE AD_Tab_ID=53330
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Tab SET AD_Tab_UU='3ea88d92-a7fe-4273-8920-83ebc12bb6c9' WHERE AD_Tab_ID=53331
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Tab SET AD_Tab_UU='329793b0-2b48-44bd-9434-4f1da74b0ad8' WHERE AD_Tab_ID=53332
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Tab SET AD_Tab_UU='d4623147-7c29-4e47-aa67-b83ed6a429dc' WHERE AD_Tab_ID=53333
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Tab SET AD_Tab_UU='11f10490-012f-41cf-8cdf-181714e4bbfa' WHERE AD_Tab_ID=53334
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='d021a6e4-17ae-4795-bc44-ed34a19a6510' WHERE AD_Table_ID=53331
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='2371504c-e412-4f54-bd37-cc9404bb1549' WHERE AD_Table_ID=53332
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='6cf11163-e551-401a-bf94-38a8d702bf26' WHERE AD_Table_ID=53333
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='3c62e8d7-88d3-4b43-a390-e3b0c045596d' WHERE AD_Table_ID=200021
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='8592177a-29a3-47bc-bc53-ccf1e5ad3066' WHERE AD_Table_ID=200022
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='98d91406-da1c-4f84-bb28-19fb7fb50954' WHERE AD_Table_ID=200023
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='e9d44e81-683a-45d4-9c7a-1de113749c2e' WHERE AD_Table_ID=53269
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='1cfd77a4-f1ae-401b-8419-6e6b159cae30' WHERE AD_Table_ID=53270
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='dbed41a4-356a-42b0-bfbb-35b02a02c0a6' WHERE AD_Table_ID=53273
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='84fd14f9-63f1-4032-bf56-81985711a622' WHERE AD_Table_ID=53274
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='2e0ef211-84d9-4f6f-9cd9-dd6f8d9e4fb6' WHERE AD_Table_ID=53276
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='80a3b143-dc22-4c02-a316-1200d2d2223c' WHERE AD_Table_ID=53277
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='4e27b936-4655-4645-8ff5-910aae71458a' WHERE AD_Table_ID=53275
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='09464288-b31a-4d96-a035-9830676fb7a8' WHERE AD_Table_ID=53334
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Table SET AD_Table_UU='2e394589-4dd9-4618-882b-c72763b6ada8' WHERE AD_Table_ID=53335
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='9972e3b4-8204-41b5-9626-f92953ea4e7e',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53350
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='bdc95980-5b49-4aee-a3eb-860670c48004',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53351
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='fb1c0edd-05fb-4111-81d0-892d324f8411',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53298
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='a5d5f564-aabd-442b-a468-f263945f5df2',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53299
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='b13155e9-05a6-4995-9d3b-43322786fe75',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53300
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='5239b566-b165-416f-9261-2fc9ab184e1b',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53301
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='a8bf7e8e-7651-44fb-86d8-866087c96fc1',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53352
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='72b6262a-3b70-4623-b30b-f6330d64c890',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53302
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='dd1d7547-2207-4112-a310-232ac3fd5eac',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53353
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='76ab48f1-b874-419a-857a-534056460eab',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53354
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='e0b7f711-d653-4530-8a16-b96f87e813aa',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53297
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='d4be133b-8ef1-44aa-a9d4-72132d806e1e',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='17d9565c-1b03-4003-909a-bb72ef060870',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200019
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='bb059ad7-e620-4e7f-8308-700c4cda7145',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53284
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='15b4a04c-7d43-400f-a928-05b4cd1c6fc8',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53275
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='4df6d60d-3822-40ee-8403-b1a895388c87',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200022
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='acc028a2-c5e4-4c23-aeec-5b8c9b3adabe',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53278
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='f8ea14b2-18fa-4e44-9588-2bbe70804aeb',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53280
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='19b67207-87f5-4ad4-98e6-a36713327a23',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53273
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='7664ff03-aaf3-461c-9650-eafa934d2dba',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53274
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='22bd605e-0292-4c65-b4ea-04b1cd9d94de',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53277
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_TreeNodeMM SET AD_TreeNodeMM_UU='efda1cf3-37d5-422d-8d10-1cb0f48989cf',Updated=TO_TIMESTAMP('2012-10-31 12:37:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200006
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Val_Rule SET AD_Val_Rule_UU='e91138fe-02be-4550-a416-a7789271e1f3' WHERE AD_Val_Rule_ID=52107
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Val_Rule SET AD_Val_Rule_UU='20ab7244-5ef5-4e36-89b0-dffbb6aea710' WHERE AD_Val_Rule_ID=52103
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Val_Rule SET AD_Val_Rule_UU='1d20954f-a861-4cf2-9faf-41e02cdbe492' WHERE AD_Val_Rule_ID=52085
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Val_Rule SET AD_Val_Rule_UU='39d7e0b5-fd71-40f6-896e-0b4890042e26' WHERE AD_Val_Rule_ID=52086
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Val_Rule SET AD_Val_Rule_UU='d9faac16-89ab-436c-825a-93c6ef67b856' WHERE AD_Val_Rule_ID=52087
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_Val_Rule SET AD_Val_Rule_UU='210605aa-cb67-4f67-9b2c-6afef55c5db8' WHERE AD_Val_Rule_ID=52088
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='7bc9a1ea-b3bd-47a3-b3d7-779122d35e19' WHERE AD_WF_Node_ID=50119
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='03e0a743-98f5-4c1c-b063-d21a6a32a223' WHERE AD_WF_Node_ID=50118
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='0d0a12ea-17b9-435a-b899-4f43c3b1feae' WHERE AD_WF_Node_ID=50117
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='b96fb19e-f4aa-41b2-a606-80610993d312' WHERE AD_WF_Node_ID=50116
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='f46db649-e7ed-4418-9db2-f801b3ed1de1' WHERE AD_WF_Node_ID=50115
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='d26db474-ddd1-4e0e-a8fa-80c7d2ed3c7c' WHERE AD_WF_Node_ID=50114
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='9a48251f-6df2-4c12-bf98-a5eb389092e5' WHERE AD_WF_Node_ID=50113
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='0ca15c22-dea4-49d3-9a45-6453598cba0c' WHERE AD_WF_Node_ID=50112
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='21db49c7-d167-4541-9dd6-9c3dfb14bce0' WHERE AD_WF_Node_ID=50111
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='d9b46b02-1a4a-4a6e-b93f-e3e633e4a48f' WHERE AD_WF_Node_ID=50110
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='a69e80d5-3410-47ed-81d6-429d4665d5f4' WHERE AD_WF_Node_ID=50109
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='706799c2-ad46-449a-b1b9-eb935c924fda' WHERE AD_WF_Node_ID=50108
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='92eed90a-24b4-49f7-a2d4-f7eb02110886' WHERE AD_WF_Node_ID=50107
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='ae4fba70-bc1b-4a5d-b3ed-7051f7e9e242' WHERE AD_WF_Node_ID=50106
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='e9d115ef-345a-4776-9760-ea1879bdbab3' WHERE AD_WF_Node_ID=50105
;

-- Oct 31, 2012 12:37:53 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='f8c995c5-2fcd-4dc0-9b64-c8038a738977' WHERE AD_WF_Node_ID=50104
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='e30aad8c-7285-4cbf-a1ac-8e77123538dc' WHERE AD_WF_Node_ID=50103
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='f19c7bfb-fa3f-4a80-a5df-7d1c07eac822' WHERE AD_WF_Node_ID=50102
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='91862fab-23dc-49fa-b8a3-fe52a1683958' WHERE AD_WF_Node_ID=50101
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='65454e3e-e8e1-474a-9f87-4f090f1111a5' WHERE AD_WF_Node_ID=50100
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_Node SET AD_WF_Node_UU='7ed25afb-93ff-43b1-b3ec-833cacdc2277' WHERE AD_WF_Node_ID=50099
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='0e78b468-b218-4ee4-99c3-897718208577' WHERE AD_WF_NodeNext_ID=50076
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='e5f362e7-01d3-41f2-ac64-13dfaec28b98' WHERE AD_WF_NodeNext_ID=50077
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='c25a08ea-f5d4-4f5c-81ac-fb2dafaeba3c' WHERE AD_WF_NodeNext_ID=50078
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='f4d807bb-34b7-4555-a590-540f21e4f40c' WHERE AD_WF_NodeNext_ID=50079
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='fd0d064d-2a73-4463-bbf5-150b895be7ed' WHERE AD_WF_NodeNext_ID=50080
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='3306692d-0be7-4069-99ec-70deaf01b828' WHERE AD_WF_NodeNext_ID=50081
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='d37e285d-4567-4df8-b72c-7c8fbf11a297' WHERE AD_WF_NodeNext_ID=50082
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='aea5ff87-23fb-4730-84ba-6006878ecf6b' WHERE AD_WF_NodeNext_ID=50083
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='c203bdbb-f27e-49c2-afc5-ea475abdf560' WHERE AD_WF_NodeNext_ID=50084
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='f2f4f328-6dc9-4758-a450-da23ab6b6143' WHERE AD_WF_NodeNext_ID=50085
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='28029f3d-7cd4-4f91-b118-88fc22e68d11' WHERE AD_WF_NodeNext_ID=50086
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='d2be1873-599d-457f-8cb4-7190238dbeef' WHERE AD_WF_NodeNext_ID=50087
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='ae51336b-69d5-4dea-975c-c3d0fcd0fa87' WHERE AD_WF_NodeNext_ID=50088
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='089b9d8f-597d-49cb-b04d-9c77bff08f46' WHERE AD_WF_NodeNext_ID=50089
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_WF_NodeNext SET AD_WF_NodeNext_UU='eaa48812-9c88-48c7-ad5e-fbbf8d4ea20a' WHERE AD_WF_NodeNext_ID=50090
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='2b7e7326-03e2-4cda-b08f-9bdb1ffdfc76' WHERE AD_Window_ID=53127
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='10c8b478-026c-4271-9718-5af0e7508809' WHERE AD_Window_ID=53149
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='f57c0ae5-ffd8-4204-a06d-81dd92afe970' WHERE AD_Window_ID=53150
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='54caabc1-2c76-428d-aa3a-67bc0f2b0f01' WHERE AD_Window_ID=53128
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='c71f6172-b7a1-4b31-b3ad-64b159e36f6d' WHERE AD_Window_ID=200013
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='ab45042b-d29e-480a-87f2-0e37ed6009b4' WHERE AD_Window_ID=53113
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='cd319295-edb3-45c9-937d-994bf4eef911' WHERE AD_Window_ID=53114
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='5201561c-7f0c-4616-9af6-b2677131f369' WHERE AD_Window_ID=53115
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='a3b6f7bb-d7c7-4e6a-9fe9-d9cd36b330c3' WHERE AD_Window_ID=53116
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='d53bfb77-65a5-46d0-b5da-e2fae2780813' WHERE AD_Window_ID=53117
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='5ef56311-286f-486c-9e76-9bd4d35b45c6' WHERE AD_Window_ID=53118
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='152fb55d-1202-44af-b9fe-e58ca79afee6' WHERE AD_Window_ID=53119
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Window SET AD_Window_UU='09015076-dbe5-414a-aa75-9349e7b293a1' WHERE AD_Window_ID=53120
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Workflow SET AD_Workflow_UU='08d3aa3b-93af-4315-b48d-2d3b67d2dbf4' WHERE AD_Workflow_ID=50020
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Workflow SET AD_Workflow_UU='2ca718db-2a56-4129-bca6-d8d2f4771d6a' WHERE AD_Workflow_ID=50021
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Workflow SET AD_Workflow_UU='660d41be-1e1e-4aef-b8d8-d4561739795a' WHERE AD_Workflow_ID=50022
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Workflow SET AD_Workflow_UU='d644a5d9-eb86-4364-b139-052d6f13eeb1' WHERE AD_Workflow_ID=50023
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE AD_Workflow SET AD_Workflow_UU='c5b88966-f5fb-4172-bf28-8430df246ef3' WHERE AD_Workflow_ID=50024
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE C_BankAccount_Processor SET C_BankAccount_Processor_UU='f4a64026-bf68-4c8c-b238-8cdf006aae04',Updated=TO_TIMESTAMP('2012-10-31 12:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_BankAccount_ID=100 AND C_PaymentProcessor_ID=100
;

-- Oct 31, 2012 12:37:54 PM COT
UPDATE C_BankAccount_Processor SET C_BankAccount_Processor_UU='f8f892f0-36ab-4b4d-9dd3-c3bbe12cf455',Updated=TO_TIMESTAMP('2012-10-31 12:37:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_BankAccount_ID=101 AND C_PaymentProcessor_ID=101
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='93d7ed15-c0f0-485b-b1f9-92b2b4632e05' WHERE M_Product_BOM_ID=200004
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='aeaa80f1-cc81-4ef0-8d59-7a29da1b95bb' WHERE M_Product_BOM_ID=200005
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='47d7e300-ba02-466c-ab7c-486efe32c638' WHERE M_Product_BOM_ID=200006
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='d3f8f3de-d1c6-4e5c-ac1e-bf1a187a5817' WHERE M_Product_BOM_ID=200007
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='b601ee07-07ca-495c-906b-732c901326a0' WHERE M_Product_BOM_ID=200008
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='04fb5679-f8d0-4f4d-a6e2-e57dc7a8fdaa' WHERE M_Product_BOM_ID=200009
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='839618d6-10ba-4b94-8d10-7f333a39bad9' WHERE M_Product_BOM_ID=200010
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='f63ae4e9-fff4-4c28-8db2-c7dbcf3766ef' WHERE M_Product_BOM_ID=200011
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='cd9153bc-4c6a-4a09-9e56-7646ddcb2a4f' WHERE M_Product_BOM_ID=200012
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='67587202-c34b-4c3d-9dc2-57329c2b76d2' WHERE M_Product_BOM_ID=200013
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='64901e8f-0013-4b6a-a518-3294c26e1eec' WHERE M_Product_BOM_ID=200014
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='f8fea7e3-d0c4-49cb-a606-31d4d688720b' WHERE M_Product_BOM_ID=200015
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='a382444d-7295-474b-be8a-5b8d8e9c5532' WHERE M_Product_BOM_ID=200016
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='e5f40e8e-7f33-4f6a-a1ba-1217bc6ac360' WHERE M_Product_BOM_ID=200017
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='8c886e3e-e14c-4088-a49d-79e0e95149d0' WHERE M_Product_BOM_ID=200018
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='00ed7504-44e9-495c-864d-42e6551d6d6a' WHERE M_Product_BOM_ID=200019
;

-- Oct 31, 2012 12:37:55 PM COT
UPDATE M_Product_BOM SET M_Product_BOM_UU='0977d78b-df7f-43c2-acbd-b02b7d4a1f9d' WHERE M_Product_BOM_ID=200020
;

SELECT register_migration_script('954_UUID_Sync.sql') FROM dual
;

