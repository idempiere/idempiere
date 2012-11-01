-- Jun 6, 2012 10:46:51 PM COT
-- Generate new UUID Columns
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_RecentItem_UU',200055,'U','AD_RecentItem_UU','AD_RecentItem_UU','1031b1b5-ada2-458b-a788-6cb8ca0a2178',0,TO_DATE('2012-06-06 22:46:49','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-06-06 22:46:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jun 6, 2012 10:46:52 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200055 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jun 6, 2012 10:46:53 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200000,200203,'U','N','N','N','N',36,'N',10,'N',200055,'f0d928f6-6a45-410d-8e14-862540f032e1','N','Y','N','AD_RecentItem_UU','AD_RecentItem_UU',100,TO_DATE('2012-06-06 22:46:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-06-06 22:46:49','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 6, 2012 10:46:53 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200203 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 6, 2012 10:46:53 PM COT
ALTER TABLE AD_RecentItem ADD AD_RecentItem_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Jun 6, 2012 10:46:53 PM COT
CREATE UNIQUE INDEX AD_RecentItem_UU_idx ON ad_recentitem(AD_RecentItem_UU)
;

-- Jun 6, 2012 10:46:54 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_ToolBarButton_UU',200056,'U','AD_ToolBarButton_UU','AD_ToolBarButton_UU','ca7c14e2-f9d3-4364-bb1a-2b1a928501d7',0,TO_DATE('2012-06-06 22:46:54','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-06-06 22:46:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jun 6, 2012 10:46:54 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200056 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jun 6, 2012 10:46:55 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200003,200204,'U','N','N','N','N',36,'N',10,'N',200056,'9359048a-5b83-456d-a5a2-13cd7aa86647','N','Y','N','AD_ToolBarButton_UU','AD_ToolBarButton_UU',100,TO_DATE('2012-06-06 22:46:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-06-06 22:46:53','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 6, 2012 10:46:55 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200204 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 6, 2012 10:46:55 PM COT
ALTER TABLE AD_ToolBarButton ADD AD_ToolBarButton_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Jun 6, 2012 10:46:55 PM COT
CREATE UNIQUE INDEX AD_ToolBarButton_UU_idx ON ad_toolbarbutton(AD_ToolBarButton_UU)
;

-- Jun 6, 2012 10:46:56 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_ToolBarButtonRestrict_UU',200057,'U','AD_ToolBarButtonRestrict_UU','AD_ToolBarButtonRestrict_UU','e1dc0adf-98d6-44e6-985a-7d5ab96e1bc8',0,TO_DATE('2012-06-06 22:46:55','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-06-06 22:46:55','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jun 6, 2012 10:46:56 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200057 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jun 6, 2012 10:46:57 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200004,200205,'U','N','N','N','N',36,'N',10,'N',200057,'ad426dc5-b6d1-40dd-a2fe-e22c6f0e8110','N','Y','N','AD_ToolBarButtonRestrict_UU','AD_ToolBarButtonRestrict_UU',100,TO_DATE('2012-06-06 22:46:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-06-06 22:46:55','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 6, 2012 10:46:57 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200205 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 6, 2012 10:46:57 PM COT
ALTER TABLE AD_ToolBarButtonRestrict ADD AD_ToolBarButtonRestrict_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Jun 6, 2012 10:46:57 PM COT
CREATE UNIQUE INDEX AD_ToolBarButtonRestric_UU_idx ON ad_toolbarbuttonrestrict(AD_ToolBarButtonRestrict_UU)
;

-- Jun 6, 2012 10:46:58 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Fact_Reconciliation_UU',200058,'U','Fact_Reconciliation_UU','Fact_Reconciliation_UU','46ec8163-53f3-4972-9ef4-806e71aa9b3a',0,TO_DATE('2012-06-06 22:46:58','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-06-06 22:46:58','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jun 6, 2012 10:46:58 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200058 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jun 6, 2012 10:46:59 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,53286,200206,'U','N','N','N','N',36,'N',10,'N',200058,'531b7110-79d6-4eef-aaf2-50d1ef31c646','N','Y','N','Fact_Reconciliation_UU','Fact_Reconciliation_UU',100,TO_DATE('2012-06-06 22:46:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-06-06 22:46:58','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 6, 2012 10:46:59 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200206 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 6, 2012 10:46:59 PM COT
ALTER TABLE Fact_Reconciliation ADD Fact_Reconciliation_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Jun 6, 2012 10:46:59 PM COT
CREATE UNIQUE INDEX Fact_Reconciliation_UU_idx ON fact_reconciliation(Fact_Reconciliation_UU)
;

-- Jun 6, 2012 10:47:01 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('T_Reconciliation_UU',200059,'U','T_Reconciliation_UU','T_Reconciliation_UU','466be9cb-65bd-4a1b-a17b-c64f5af64d1a',0,TO_DATE('2012-06-06 22:47:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-06-06 22:47:00','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jun 6, 2012 10:47:01 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200059 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jun 6, 2012 10:47:01 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,53287,200207,'U','N','N','N','N',36,'N',10,'N',200059,'56c24b4e-98f5-4e2c-9fdf-49a0855ef662','N','Y','N','T_Reconciliation_UU','T_Reconciliation_UU',100,TO_DATE('2012-06-06 22:47:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-06-06 22:47:00','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 6, 2012 10:47:01 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200207 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 6, 2012 10:47:02 PM COT
ALTER TABLE T_Reconciliation ADD T_Reconciliation_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Jun 6, 2012 10:47:02 PM COT
CREATE UNIQUE INDEX T_Reconciliation_UU_idx ON t_reconciliation(T_Reconciliation_UU)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='846_GenerateNewUUIDColumns.sql'
WHERE LastMigrationScriptApplied<'846_GenerateNewUUIDColumns.sql'
   OR LastMigrationScriptApplied IS NULL
;

