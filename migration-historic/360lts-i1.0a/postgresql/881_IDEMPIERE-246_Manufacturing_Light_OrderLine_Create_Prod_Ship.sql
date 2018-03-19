-- Aug 10, 2012 1:37:19 PM CEST
-- Manufacturing Light
INSERT INTO AD_Process (AD_Client_ID,AD_Org_ID,AD_Process_ID,AccessLevel,CopyFromProcess,Created,CreatedBy,Description,EntityType,IsActive,IsBetaFunctionality,IsDirectPrint,IsReport,IsServerProcess,Name,ShowHelp,Statistic_Count,Statistic_Seconds,Updated,UpdatedBy,Value) VALUES (0,0,200006,'3','N',TO_TIMESTAMP('2012-08-10 13:37:16','YYYY-MM-DD HH24:MI:SS'),100,'Create Production Header and Plan for single ordered product','U','Y','N','N','N','N','OrderLineCreateProduction','Y',0,0,TO_TIMESTAMP('2012-08-10 13:37:16','YYYY-MM-DD HH24:MI:SS'),100,'10000000')
;

-- Aug 10, 2012 1:37:19 PM CEST
-- Manufacturing Light
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200006 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Aug 10, 2012 1:37:43 PM CEST
-- Manufacturing Light
UPDATE AD_Process SET Classname='org.compiere.process.OrderLineCreateProduction',Updated=TO_TIMESTAMP('2012-08-10 13:37:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200006
;

-- Aug 10, 2012 1:40:28 PM CEST
-- Manufacturing Light
UPDATE AD_Process SET Name='OrderLine Create Production', Value='C_OrderLine_CreateProduction',Updated=TO_TIMESTAMP('2012-08-10 13:40:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200006
;

-- Aug 10, 2012 1:40:28 PM CEST
-- Manufacturing Light
UPDATE AD_Process_Trl SET IsTranslated='N' WHERE AD_Process_ID=200006
;

-- Aug 10, 2012 1:43:51 PM CEST
-- Manufacturing Light
INSERT INTO AD_Process (AD_Client_ID,AD_Org_ID,AD_Process_ID,AccessLevel,Classname,CopyFromProcess,Created,CreatedBy,Description,EntityType,IsActive,IsBetaFunctionality,IsDirectPrint,IsReport,IsServerProcess,Name,ShowHelp,Statistic_Count,Statistic_Seconds,Updated,UpdatedBy,Value) VALUES (0,0,200007,'3','org.compiere.process.OrderLineCreateShipment','N',TO_TIMESTAMP('2012-08-10 13:43:50','YYYY-MM-DD HH24:MI:SS'),100,'Create Shipment for single ordered product','U','Y','N','N','N','N','OrderLine Create Shipment','S',0,0,TO_TIMESTAMP('2012-08-10 13:43:50','YYYY-MM-DD HH24:MI:SS'),100,'C_OrderLine_CreateShipment')
;

-- Aug 10, 2012 1:43:51 PM CEST
-- Manufacturing Light
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200007 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Aug 10, 2012 1:44:01 PM CEST
-- Manufacturing Light
UPDATE AD_Process SET ShowHelp='S',Updated=TO_TIMESTAMP('2012-08-10 13:44:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200006
;

-- Aug 10, 2012 1:49:23 PM CEST
-- Manufacturing Light
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200079,0,'CreateProduction',TO_TIMESTAMP('2012-08-10 13:49:22','YYYY-MM-DD HH24:MI:SS'),100,'U','Y','Create Production','Create Production',TO_TIMESTAMP('2012-08-10 13:49:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 10, 2012 1:49:24 PM CEST
-- Manufacturing Light
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200079 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 10, 2012 1:50:36 PM CEST
-- Manufacturing Light
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200252,200079,0,200006,28,260,'CreateProduction',TO_TIMESTAMP('2012-08-10 13:50:35','YYYY-MM-DD HH24:MI:SS'),100,'U',1,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Create Production',0,TO_TIMESTAMP('2012-08-10 13:50:35','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 1:50:36 PM CEST
-- Manufacturing Light
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200252 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 1:51:18 PM CEST
-- Manufacturing Light
UPDATE AD_Column SET Description='Create Production Header and Plan for single ordered product', Help='Create Production Header and Plan for single ordered product.',Updated=TO_TIMESTAMP('2012-08-10 13:51:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200252
;

-- Aug 10, 2012 1:51:18 PM CEST
-- Manufacturing Light
UPDATE AD_Field SET Name='Create Production', Description='Create Production Header and Plan for single ordered product', Help='Create Production Header and Plan for single ordered product.' WHERE AD_Column_ID=200252 AND IsCentrallyMaintained='Y'
;

-- Aug 10, 2012 1:51:58 PM CEST
-- Manufacturing Light
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200080,0,'CreateShipment',TO_TIMESTAMP('2012-08-10 13:51:58','YYYY-MM-DD HH24:MI:SS'),100,'U','Y','Create Shipment','Create Shipment',TO_TIMESTAMP('2012-08-10 13:51:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 10, 2012 1:51:58 PM CEST
-- Manufacturing Light
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200080 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 10, 2012 1:52:37 PM CEST
-- Manufacturing Light
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200253,200080,0,200007,28,260,'CreateShipment',TO_TIMESTAMP('2012-08-10 13:52:36','YYYY-MM-DD HH24:MI:SS'),100,'U',1,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Create Shipment',0,TO_TIMESTAMP('2012-08-10 13:52:36','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 1:52:37 PM CEST
-- Manufacturing Light
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200253 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 1:53:14 PM CEST
-- Manufacturing Light
UPDATE AD_Column SET Description='Create Shipment for single ordered product', Help='Create Shipment for single ordered product',Updated=TO_TIMESTAMP('2012-08-10 13:53:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200253
;

-- Aug 10, 2012 1:53:14 PM CEST
-- Manufacturing Light
UPDATE AD_Field SET Name='Create Shipment', Description='Create Shipment for single ordered product', Help='Create Shipment for single ordered product' WHERE AD_Column_ID=200253 AND IsCentrallyMaintained='Y'
;

-- Aug 10, 2012 1:53:30 PM CEST
-- Manufacturing Light
ALTER TABLE C_OrderLine ADD COLUMN CreateShipment CHAR(1) DEFAULT NULL 
;

-- Aug 10, 2012 1:53:58 PM CEST
-- Manufacturing Light
UPDATE AD_Column SET DefaultValue='N',Updated=TO_TIMESTAMP('2012-08-10 13:53:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200252
;

-- Aug 10, 2012 1:54:02 PM CEST
-- Manufacturing Light
ALTER TABLE C_OrderLine ADD COLUMN CreateProduction CHAR(1) DEFAULT 'N' 
;

-- Aug 10, 2012 1:54:21 PM CEST
-- Manufacturing Light
UPDATE AD_Column SET DefaultValue='N',Updated=TO_TIMESTAMP('2012-08-10 13:54:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200253
;

-- Aug 10, 2012 1:54:25 PM CEST
-- Manufacturing Light
INSERT INTO t_alter_column values('c_orderline','CreateShipment','CHAR(1)',null,'N')
;

-- Aug 10, 2012 1:56:53 PM CEST
-- Manufacturing Light
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200252,200271,0,187,TO_TIMESTAMP('2012-08-10 13:56:52','YYYY-MM-DD HH24:MI:SS'),100,1,'U','Y','Y','Y','N','N','N','N','N','Create Production',TO_TIMESTAMP('2012-08-10 13:56:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 10, 2012 1:56:54 PM CEST
-- Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200271 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 10, 2012 1:56:54 PM CEST
-- Manufacturing Light
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,200253,200272,0,187,TO_TIMESTAMP('2012-08-10 13:56:54','YYYY-MM-DD HH24:MI:SS'),100,1,'U','Y','Y','Y','N','N','N','N','N','Create Shipment',TO_TIMESTAMP('2012-08-10 13:56:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 10, 2012 1:56:54 PM CEST
-- Manufacturing Light
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200272 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 10, 2012 1:57:34 PM CEST
-- Manufacturing Light
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-10 13:57:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200272
;

-- Aug 10, 2012 1:58:44 PM CEST
-- Manufacturing Light
UPDATE AD_Field SET DisplayLogic='@Processed@=Y',Updated=TO_TIMESTAMP('2012-08-10 13:58:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200271
;

-- Aug 10, 2012 1:58:50 PM CEST
-- Manufacturing Light
UPDATE AD_Field SET DisplayLogic='@Processed@=Y',Updated=TO_TIMESTAMP('2012-08-10 13:58:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200272
;

-- Aug 10, 2012 2:01:33 PM CEST
-- Manufacturing Light
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2012-08-10 14:01:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200252
;

-- Aug 10, 2012 2:01:37 PM CEST
-- Manufacturing Light
UPDATE AD_Column SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2012-08-10 14:01:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200253
;

UPDATE AD_System
  SET LastMigrationScriptApplied='881_IDEMPIERE-246_Manufacturing_Light_OrderLine_Create_Prod_Ship.sql'
WHERE LastMigrationScriptApplied<'881_IDEMPIERE-246_Manufacturing_Light_OrderLine_Create_Prod_Ship.sql'
   OR LastMigrationScriptApplied IS NULL
;
