-- Apr 13, 2013 2:39:11 PM COT
-- IDEMPIERE-794 Ticket #1001025 - Expand the views to provide more information
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,516,210217,'U','N','N','N','N',10,'N',19,'N',200976,'8a5428d7-a189-41c0-b463-fbcd5baa9d6b','N','bp_bpartner_parent_id','bp_bpartner_parent_id',TO_TIMESTAMP('2013-04-13 14:39:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:39:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:39:11 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210217 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:39:11 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID) VALUES ('bp_c_dunning_id',202507,'U','bp_c_dunning_id','bp_c_dunning_id','f41500eb-afc6-4ded-927b-a304709929c6',TO_TIMESTAMP('2013-04-13 14:39:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-04-13 14:39:11','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0)
;

-- Apr 13, 2013 2:39:11 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202507 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 13, 2013 2:39:12 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,516,210218,'U','N','N','N','N',10,'N',19,'N',202507,'e1e394b3-5ba4-468f-9c72-f46498c4e7dd','N','bp_c_dunning_id','bp_c_dunning_id',TO_TIMESTAMP('2013-04-13 14:39:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:39:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:39:12 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210218 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:39:12 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,516,210219,'U','N','N','N','N',10,'N',19,'N',200980,'55f02d1d-5283-46a4-8a96-fddd9baad530','N','bp_c_invoiceschedule_id','C_BPartner_InvoiceSchedule_ID',TO_TIMESTAMP('2013-04-13 14:39:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:39:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:39:12 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210219 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:39:12 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,516,210220,'U','N','N','N','N',10,'N',19,'N',201018,'ff03bf8c-b3dc-4c83-8627-296cc2a79a4b','N','bp_salesrep_id','bp_salesrep_id',TO_TIMESTAMP('2013-04-13 14:39:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:39:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:39:12 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210220 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:39:13 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID) VALUES ('ad_user_ad_ad_orgtrx_id',202508,'U','ad_user_ad_ad_orgtrx_id','ad_user_ad_ad_orgtrx_id','a03a6695-f47d-49a1-b5b0-4ab7f9023da2',TO_TIMESTAMP('2013-04-13 14:39:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-04-13 14:39:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0)
;

-- Apr 13, 2013 2:39:13 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202508 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 13, 2013 2:39:13 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,516,210221,'U','N','N','N','N',10,'N',19,'N',202508,'b49260d8-c4d4-4e40-89aa-603776c57c45','N','ad_user_ad_ad_orgtrx_id','ad_user_ad_ad_orgtrx_id',TO_TIMESTAMP('2013-04-13 14:39:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:39:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:39:13 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210221 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:39:14 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,516,210222,'U','N','N','N','N',10,'N',10,'N',250,'898f107b-c06a-466b-be73-611cd259039b','N','CurSymbol','Symbol of the currency (opt used for printing only)','The Currency Symbol defines the symbol that will print when this currency is used.','Symbol',TO_TIMESTAMP('2013-04-13 14:39:13','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:39:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:39:14 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210222 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:39:14 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID) VALUES ('cur_description',202509,'U','cur_description','cur_description','eca51543-f194-45b8-9c04-050b3028c1ec',TO_TIMESTAMP('2013-04-13 14:39:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-04-13 14:39:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0)
;

-- Apr 13, 2013 2:39:14 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202509 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 13, 2013 2:39:15 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,516,210223,'U','N','N','N','N',255,'N',10,'N',202509,'e54ca6fb-80e8-4747-b972-99ef15ca03cf','N','cur_description','cur_description',TO_TIMESTAMP('2013-04-13 14:39:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:39:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:39:15 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210223 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:42:56 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=124, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:42:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210217
;

-- Apr 13, 2013 2:43:12 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200044, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:43:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210218
;

-- Apr 13, 2013 2:43:28 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200046, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:43:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210219
;

-- Apr 13, 2013 2:43:53 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=110, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:43:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210220
;

-- Apr 13, 2013 2:44:32 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=130, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:44:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210221
;

-- Apr 13, 2013 2:45:30 PM COT
UPDATE AD_Element SET EntityType='D', Name='Currency Description', PrintName='Currency Description',Updated=TO_TIMESTAMP('2013-04-13 14:45:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202509
;

-- Apr 13, 2013 2:45:30 PM COT
UPDATE AD_Column SET ColumnName='cur_description', Name='Currency Description', Description=NULL, Help=NULL WHERE AD_Element_ID=202509
;

-- Apr 13, 2013 2:45:30 PM COT
UPDATE AD_Process_Para SET ColumnName='cur_description', Name='Currency Description', Description=NULL, Help=NULL, AD_Element_ID=202509 WHERE UPPER(ColumnName)='CUR_DESCRIPTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 13, 2013 2:45:30 PM COT
UPDATE AD_Process_Para SET ColumnName='cur_description', Name='Currency Description', Description=NULL, Help=NULL WHERE AD_Element_ID=202509 AND IsCentrallyMaintained='Y'
;

-- Apr 13, 2013 2:45:30 PM COT
UPDATE AD_InfoColumn SET ColumnName='cur_description', Name='Currency Description', Description=NULL, Help=NULL WHERE AD_Element_ID=202509 AND IsCentrallyMaintained='Y'
;

-- Apr 13, 2013 2:45:30 PM COT
UPDATE AD_Field SET Name='Currency Description', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202509) AND IsCentrallyMaintained='Y'
;

-- Apr 13, 2013 2:45:30 PM COT
UPDATE AD_PrintFormatItem SET PrintName='Currency Description', Name='Currency Description' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202509)
;

-- Apr 13, 2013 2:45:37 PM COT
UPDATE AD_Column SET EntityType='D', IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:45:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210223
;

-- Apr 13, 2013 2:46:02 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210224,'U','N','N','N','N',10,'N',19,'N',200974,'9fe59660-5896-49f8-85ea-02c99612c998','N','bp_ad_orgbp_id','bp_ad_orgbp_id',TO_TIMESTAMP('2013-04-13 14:46:01','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210224 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:02 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210225,'U','N','N','N','N',10,'N',19,'N',200975,'81e4b5a4-1633-4243-9e55-16fa81b74754','N','bp_ad_org_id','bp_ad_org_id',TO_TIMESTAMP('2013-04-13 14:46:02','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210225 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:03 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210226,'U','N','N','N','N',10,'N',19,'N',200976,'fc37b29b-7112-4b76-8d01-7f28074fe09d','N','bp_bpartner_parent_id','bp_bpartner_parent_id',TO_TIMESTAMP('2013-04-13 14:46:02','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210226 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:03 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210227,'U','N','N','N','N',10,'N',19,'N',200977,'b28c8267-84dd-487f-8377-127b7adaedd5','N','bp_c_bp_group_id','bp_c_bp_group_id',TO_TIMESTAMP('2013-04-13 14:46:03','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210227 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:04 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210228,'U','N','N','N','N',10,'N',19,'N',202507,'f963bec3-9370-41bf-b143-b1ef1c0c3542','N','bp_c_dunning_id','bp_c_dunning_id',TO_TIMESTAMP('2013-04-13 14:46:03','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:04 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210228 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:04 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210229,'U','N','N','N','N',10,'N',19,'N',200979,'f867a688-b864-4b74-938b-174d85242623','N','bp_c_greeting_id','bp_c_greeting_id',TO_TIMESTAMP('2013-04-13 14:46:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:04 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210229 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:04 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210230,'U','N','N','N','N',10,'N',19,'N',200980,'d9815838-cad2-423a-8c9c-37a256f566e3','N','bp_c_invoiceschedule_id','C_BPartner_InvoiceSchedule_ID',TO_TIMESTAMP('2013-04-13 14:46:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:04 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210230 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:05 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210231,'U','N','N','N','N',10,'N',19,'N',200981,'8f16bd74-260c-44ce-88cc-850f3a43f66d','N','bp_c_paymentterm_id','bp_c_paymentterm_id',TO_TIMESTAMP('2013-04-13 14:46:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:05 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210231 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:05 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210232,'U','N','N','N','N',10,'N',19,'N',200984,'64fc66c6-9107-4480-9a42-5f054c47fd2a','N','bp_c_taxgroup_id','bp_c_taxgroup_id',TO_TIMESTAMP('2013-04-13 14:46:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:05 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210232 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:06 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210233,'U','N','N','N','N',10,'N',19,'N',201005,'3af4c269-69ea-430d-bbb8-4d42119d7713','N','bp_logo_id','bp_logo_id',TO_TIMESTAMP('2013-04-13 14:46:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:06 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210233 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:06 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210234,'U','N','N','N','N',10,'N',19,'N',201006,'9caafb7d-2c62-4977-96fb-ccaba093dfbf','N','bp_m_discountschema_id','bp_m_discountschema_id',TO_TIMESTAMP('2013-04-13 14:46:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:06 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210234 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:07 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210235,'U','N','N','N','N',10,'N',19,'N',201007,'c14fb274-5874-4e0b-8e00-7c6247d246c9','N','bp_m_pricelist_id','bp_m_pricelist_id',TO_TIMESTAMP('2013-04-13 14:46:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:07 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210235 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:07 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210236,'U','N','N','N','N',10,'N',19,'N',201012,'fb314bcb-fb12-4f58-8c74-e8f78697e594','N','bp_po_discountschema_id','bp_po_discountschema_id',TO_TIMESTAMP('2013-04-13 14:46:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:07','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:07 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210236 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:08 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210237,'U','N','N','N','N',10,'N',19,'N',201013,'d627722c-1bdf-49d9-9c19-7d4cbdc32a78','N','bp_po_paymentterm_id','bp_po_paymentterm_id',TO_TIMESTAMP('2013-04-13 14:46:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:07','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:08 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210237 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:08 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210238,'U','N','N','N','N',10,'N',19,'N',201014,'8638c73a-276a-4c13-8087-49942268a50c','N','bp_po_pricelist_id','bp_po_pricelist_id',TO_TIMESTAMP('2013-04-13 14:46:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:08 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210238 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:08 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210239,'U','N','N','N','N',10,'N',19,'N',201018,'8aa509f6-dbb2-47b8-a5d5-7c835374087b','N','bp_salesrep_id','bp_salesrep_id',TO_TIMESTAMP('2013-04-13 14:46:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:08 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210239 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:09 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210240,'U','N','N','N','N',10,'N',19,'N',201033,'49ca0e51-d50d-4a36-98bc-2f5b661d97b9','N','bp_location_ad_org_id','bp_location_ad_org_id',TO_TIMESTAMP('2013-04-13 14:46:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:09 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210240 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:09 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210241,'U','N','N','N','N',10,'N',19,'N',200423,'c5aa52b4-d9be-4d9d-b8de-7f6f36ab8d0f','N','AD_User_AD_OrgTrx_ID','AD_User_AD_OrgTrx_ID',TO_TIMESTAMP('2013-04-13 14:46:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:09 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210241 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:10 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210242,'U','N','N','N','N',10,'N',10,'N',250,'b7bdc4a6-bd41-4b80-8499-5ae8b183e7ff','N','CurSymbol','Symbol of the currency (opt used for printing only)','The Currency Symbol defines the symbol that will print when this currency is used.','Symbol',TO_TIMESTAMP('2013-04-13 14:46:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:10 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210242 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:46:10 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID) VALUES (0.0,496,210243,'U','N','N','N','N',255,'N',10,'N',202509,'77e21b24-4565-44f9-82c6-c9c1844ec920','N','cur_description','Currency Description',TO_TIMESTAMP('2013-04-13 14:46:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-04-13 14:46:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0)
;

-- Apr 13, 2013 2:46:10 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210243 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 13, 2013 2:47:08 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=276, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:47:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210224
;

-- Apr 13, 2013 2:47:28 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=276, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:47:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210225
;

-- Apr 13, 2013 2:47:38 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=124, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:47:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210226
;

-- Apr 13, 2013 2:47:54 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200045, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:47:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210227
;

-- Apr 13, 2013 2:48:14 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200044, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210228
;

-- Apr 13, 2013 2:49:18 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=356, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:49:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210229
;

-- Apr 13, 2013 2:49:28 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200046, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:49:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210230
;

-- Apr 13, 2013 2:49:40 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=227, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:49:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210231
;

-- Apr 13, 2013 2:49:52 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200047, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:49:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210232
;

-- Apr 13, 2013 2:50:34 PM COT
UPDATE AD_Column SET AD_Reference_ID=32, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:50:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210233
;

-- Apr 13, 2013 2:50:46 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=249, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:50:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210234
;

-- Apr 13, 2013 2:50:53 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=166, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:50:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210235
;

-- Apr 13, 2013 2:51:07 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=249, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:51:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210236
;

-- Apr 13, 2013 2:51:16 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=227, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:51:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210237
;

-- Apr 13, 2013 2:51:28 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=166, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:51:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210238
;

-- Apr 13, 2013 2:51:47 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=110, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:51:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210239
;

-- Apr 13, 2013 2:52:10 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=276, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:52:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210240
;

-- Apr 13, 2013 2:52:34 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=130, AD_Reference_ID=18, IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-13 14:52:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210241
;

DROP VIEW c_invoice_header_v;

CREATE OR REPLACE VIEW c_invoice_header_v AS 
SELECT i.ad_client_id,
    i.ad_org_id,
    i.isactive,
    i.created,
    i.createdby,
    i.updated,
    i.updatedby,
    'en_US'::character varying       AS ad_language,
    i.c_invoice_id,
    i.issotrx,
    i.documentno,
    i.docstatus,
    i.c_doctype_id,
    i.c_bpartner_id,
    bp.value                         AS bpvalue,
    bp.taxid                         AS bptaxid,
    bp.naics,
    bp.duns,
    oi.c_location_id                 AS org_location_id,
    oi.taxid,
    dt.printname                     AS documenttype,
    dt.documentnote                  AS documenttypenote,
    i.c_order_id,
    i.salesrep_id,
    COALESCE(ubp.name, u.name)       AS salesrep_name,
    i.dateinvoiced,
    bpg.greeting                     AS bpgreeting,
    bp.name,
    bp.name2,
    bpcg.greeting                    AS bpcontactgreeting,
    bpc.title,
    bpc.phone,
    NULLIF(bpc.name, bp.name)        AS contactname,
    bpl.c_location_id,
    bp.referenceno,
    l.postal || l.postal_add         AS postal,
    i.description,
    i.poreference,
    i.dateordered,
    i.c_currency_id,
    pt.name                          AS paymentterm,
    pt.documentnote                  AS paymenttermnote,
    i.c_charge_id,
    i.chargeamt,
    i.totallines,
    i.grandtotal,
    i.grandtotal                     AS amtinwords,
    i.m_pricelist_id,
    i.istaxincluded,
    i.c_campaign_id,
    i.c_project_id,
    i.c_activity_id,
    i.ispaid,
    COALESCE(oi.logo_id, ci.logo_id) AS logo_id,
    i.ad_orgtrx_id                   AS c_invoice_ad_orgtrx_id,
    i.ad_user_id,
    i.c_bpartner_location_id,
    i.c_conversiontype_id,
    i.c_doctypetarget_id,
    i.c_dunninglevel_id,
    i.c_payment_id,
    i.dateacct,
    i.dateprinted,
    i.docaction,
    i.dunninggrace,
    i.generateto,
    i.invoicecollectiontype,
    i.isapproved,
    i.isdiscountprinted,
    i.isindispute,
    i.ispayschedulevalid,
    i.isprinted,
    i.isselfservice                  AS c_invoice_isselfservice,
    i.istransferred,
    i.m_rma_id,
    i.paymentrule,
    i.posted,
    i.processedon,
    i.processing,
    i.ref_invoice_id,
    i.reversal_id,
    i.sendemail,
    i.user1_id,
    i.user2_id,
    pt.ad_org_id                     AS c_paymentterm_ad_org_id,
    pt.afterdelivery,
    pt.c_paymentterm_id,
    pt.description                   AS c_paymentterm_description,
    pt.discount,
    pt.discount2,
    pt.discountdays,
    pt.discountdays2,
    pt.fixmonthcutoff,
    pt.fixmonthday,
    pt.fixmonthoffset,
    pt.gracedays,
    pt.isactive                      AS c_paymentterm_isactive,
    pt.isdefault,
    pt.isduefixed,
    pt.isnextbusinessday,
    pt.isvalid,
    pt.netday,
    pt.netdays,
    pt.paymenttermusage,
    pt.value                         AS c_paymentterm_value,
    bp.acqusitioncost                AS bp_acqusitioncost,
    bp.actuallifetimevalue           AS bp_actuallifetimevalue,
    bp.ad_language                   AS bp_ad_language,
    bp.ad_orgbp_id                   AS bp_ad_orgbp_id,
    bp.ad_org_id                     AS bp_ad_org_id,
    bp.bpartner_parent_id            AS bp_bpartner_parent_id,
    bp.c_bp_group_id                 AS bp_c_bp_group_id,
    bp.c_dunning_id                  AS bp_c_dunning_id,
    bp.c_greeting_id                 AS bp_c_greeting_id,
    bp.c_invoiceschedule_id          AS bp_c_invoiceschedule_id,
    bp.c_paymentterm_id              AS bp_c_paymentterm_id,
    bp.created                       AS bp_created,
    bp.createdby                     AS bp_createdby,
    bp.c_taxgroup_id                 AS bp_c_taxgroup_id,
    bp.deliveryrule                  AS bp_deliveryrule,
    bp.deliveryviarule               AS bp_deliveryviarule,
    bp.description                   AS bp_description,
    bp.dunninggrace                  AS bp_dunninggrace,
    bp.firstsale                     AS bp_firstsale,
    bp.flatdiscount                  AS bp_flatdiscount,
    bp.freightcostrule               AS bp_freightcostrule,
    bp.invoicerule                   AS bp_invoicerule,
    bp.isactive                      AS bp_isactive,
    bp.iscustomer                    AS bp_iscustomer,
    bp.isdiscountprinted             AS bp_isdiscountprinted,
    bp.isemployee                    AS bp_isemployee,
    bp.ismanufacturer                AS bp_ismanufacturer,
    bp.isonetime                     AS bp_isonetime,
    bp.ispotaxexempt                 AS bp_ispotaxexempt,
    bp.isprospect                    AS bp_isprospect,
    bp.issalesrep                    AS bp_issalesrep,
    bp.issummary                     AS bp_issummary,
    bp.istaxexempt                   AS bp_istaxexempt,
    bp.isvendor                      AS bp_isvendor,
    bp.logo_id                       AS bp_logo_id,
    bp.m_discountschema_id           AS bp_m_discountschema_id,
    bp.m_pricelist_id                AS bp_m_pricelist_id,
    bp.naics                         AS bp_naics,
    bp.numberemployees               AS bp_numberemployees,
    bp.paymentrule                   AS bp_paymentrule,
    bp.paymentrulepo                 AS bp_paymentrulepo,
    bp.po_discountschema_id          AS bp_po_discountschema_id,
    bp.po_paymentterm_id             AS bp_po_paymentterm_id,
    bp.po_pricelist_id               AS bp_po_pricelist_id,
    bp.poreference                   AS bp_poreference,
    bp.potentiallifetimevalue        AS bp_potentiallifetimevalue,
    bp.rating                        AS bp_rating,
    bp.salesrep_id                   AS bp_salesrep_id,
    bp.salesvolume                   AS bp_salesvolume,
    bp.sendemail                     AS bp_sendemail,
    bp.shareofcustomer               AS bp_shareofcustomer,
    bp.shelflifeminpct               AS bp_shelflifeminpct,
    bp.so_creditlimit                AS bp_so_creditlimit,
    bp.socreditstatus                AS bp_socreditstatus,
    bp.so_creditused                 AS bp_so_creditused,
    bp.so_description                AS bp_so_description,
    bp.totalopenbalance              AS bp_totalopenbalance,
    bp.updated                       AS bp_updated,
    bp.updatedby                     AS bp_updatedby,
    bp.url                           AS bp_url,
    bpg.isactive                     AS c_greeting_isactive,
    bpg.isfirstnameonly,
    bpg.name                         AS c_greeting_name,
    bpl.ad_org_id                    AS bp_location_ad_org_id,
    bpl.c_bpartner_id                AS bp_location_c_bpartner_id,
    bpl.created                      AS bp_location_created,
    bpl.createdby                    AS bp_location_createdby,
    bpl.c_salesregion_id,
    bpl.fax                          AS bp_location_fax,
    bpl.isactive                     AS bp_location_isactive,
    bpl.isbillto,
    bpl.isdn,
    bpl.ispayfrom,
    bpl.isremitto,
    bpl.isshipto,
    bpl.name                         AS bp_location_name,
    bpl.phone                        AS bp_location_phone,
    bpl.phone2                       AS bp_location_phone2,
    bpl.updated                      AS bp_location_updated,
    bpl.updatedby                    AS bp_location_updatedby,
    l.address1,
    l.address2,
    l.address3,
    l.address4,
    l.ad_org_id                      AS c_location_ad_org_id,
    l.c_city_id,
    l.c_country_id,
    l.city,
    l.created                        AS c_location_created,
    l.createdby                      AS c_location_createdby,
    l.c_region_id,
    l.isactive                       AS c_location_isactive,
    l.regionname,
    l.updated                        AS c_location_updated,
    l.updatedby                      AS c_location_updatedby,
    bpc.ad_org_id                    AS ad_user_ad_org_id,
    bpc.ad_orgtrx_id                 AS ad_user_ad_ad_orgtrx_id,
    bpc.birthday                     AS ad_user_ad_birthday,
    bpc.c_bpartner_id                AS ad_user_c_bpartner_id,
    bpc.c_bpartner_location_id       AS ad_user_c_bpartner_location_id,
    bpc.c_greeting_id                AS ad_user_c_greeting_id,
    bpc.comments                     AS ad_user_comments,
    bpc.created                      AS ad_user_created,
    bpc.createdby                    AS ad_user_createdby,
    bpc.description                  AS ad_user_description,
    bpc.email                        AS ad_user_email,
    bpc.fax                          AS ad_user_fax,
    bpc.isactive                     AS ad_user_isactive,
    bpc.lastcontact                  AS ad_user_lastcontact,
    bpc.lastresult                   AS ad_user_lastresult,
    bpc.phone2                       AS ad_user_phone2,
    bpc.supervisor_id                AS ad_user_supervisor_id,
    bpc.updated                      AS ad_user_updated,
    bpc.updatedby                    AS ad_user_updatedby,
    bpc.value                        AS ad_user_value,
    bpcg.isactive                    AS user_greeting_isactive,
    bpcg.isfirstnameonly             AS user_greeting_isfirstnameonly,
    bpcg.name                        AS user_greeting_name,
    oi.ad_org_id                     AS ad_orginfo_ad_org_id,
    oi.ad_orgtype_id,
    oi.c_calendar_id,
    oi.created                       AS ad_orginfo_created,
    oi.createdby                     AS ad_orginfo_createdby,
    oi.dropship_warehouse_id,
    oi.duns                          AS ad_orginfo_duns,
    oi.email                         AS ad_orginfo_email,
    oi.fax                           AS ad_orginfo_fax,
    oi.isactive                      AS ad_orginfo_isactive,
    oi.m_warehouse_id,
    oi.parent_org_id,
    oi.phone                         AS ad_orginfo_phone,
    oi.phone2                        AS ad_orginfo_phone2,
    oi.receiptfootermsg,
    oi.supervisor_id,
    oi.updated                       AS ad_orginfo_updated,
    oi.updatedby                     AS ad_orginfo_updatedby,
    u.ad_org_id                      AS salesrep_ad_org_id,
    u.ad_orgtrx_id                   AS salesrep_ad_ad_orgtrx_id,
    u.birthday                       AS salesrep_ad_birthday,
    u.c_bpartner_id                  AS salesrep_c_bpartner_id,
    u.c_bpartner_location_id         AS salesrep_c_bp_location_id,
    u.c_greeting_id                  AS salesrep_c_greeting_id,
    u.comments                       AS salesrep_comments,
    u.created                        AS salesrep_created,
    u.createdby                      AS salesrep_createdby,
    u.description                    AS salesrep_description,
    u.email                          AS salesrep_email,
    u.fax                            AS salesrep_fax,
    u.isactive                       AS salesrep_isactive,
    u.lastcontact                    AS salesrep_lastcontact,
    u.lastresult                     AS salesrep_lastresult,
    u.phone                          AS salesrep_phone,
    u.phone2                         AS salesrep_phone2,
    u.supervisor_id                  AS salesrep_supervisor_id,
    u.title                          AS salesrep_title,
    u.updated                        AS salesrep_updated,
    u.updatedby                      AS salesrep_updatedby,
    u.value                          AS salesrep_value,
    ubp.acqusitioncost               AS bpartner_acqusitioncost,
    ubp.actuallifetimevalue          AS bpartner_actuallifetimevalue,
    ubp.ad_language                  AS bpartner_ad_language,
    ubp.ad_orgbp_id                  AS bpartner_ad_orgbp_id,
    ubp.ad_org_id                    AS bpartner_ad_org_id,
    ubp.bpartner_parent_id           AS bpartner_bpartner_parent_id,
    ubp.c_bp_group_id                AS bpartner_c_bp_group_id,
    ubp.c_dunning_id                 AS bpartner_c_dunning_id,
    ubp.c_greeting_id                AS bpartner_c_greeting_id,
    ubp.c_invoiceschedule_id         AS bpartner_c_invoiceschedule_id,
    ubp.c_paymentterm_id             AS bpartner_c_paymentterm_id,
    ubp.created                      AS bpartner_created,
    ubp.createdby                    AS bpartner_createdby,
    ubp.c_taxgroup_id                AS bpartner_c_taxgroup_id,
    ubp.deliveryrule                 AS bpartner_deliveryrule,
    ubp.deliveryviarule              AS bpartner_deliveryviarule,
    ubp.description                  AS bpartner_description,
    ubp.dunninggrace                 AS bpartner_dunninggrace,
    ubp.duns                         AS bpartner_duns,
    ubp.firstsale                    AS bpartner_firstsale,
    ubp.flatdiscount                 AS bpartner_flatdiscount,
    ubp.freightcostrule              AS bpartner_freightcostrule,
    ubp.invoicerule                  AS bpartner_invoicerule,
    ubp.isactive                     AS bpartner_isactive,
    ubp.iscustomer                   AS bpartner_iscustomer,
    ubp.isdiscountprinted            AS bpartner_isdiscountprinted,
    ubp.isemployee                   AS bpartner_isemployee,
    ubp.ismanufacturer               AS bpartner_ismanufacturer,
    ubp.isonetime                    AS bpartner_isonetime,
    ubp.ispotaxexempt                AS bpartner_ispotaxexempt,
    ubp.isprospect                   AS bpartner_isprospect,
    ubp.issalesrep                   AS bpartner_issalesrep,
    ubp.issummary                    AS bpartner_issummary,
    ubp.istaxexempt                  AS bpartner_istaxexempt,
    ubp.isvendor                     AS bpartner_isvendor,
    ubp.logo_id                      AS bpartner_logo_id,
    ubp.m_discountschema_id          AS bpartner_m_discountschema_id,
    ubp.m_pricelist_id               AS bpartner_m_pricelist_id,
    ubp.naics                        AS bpartner_naics,
    ubp.name2                        AS bpartner_name2,
    ubp.numberemployees              AS bpartner_numberemployees,
    ubp.paymentrule                  AS bpartner_paymentrule,
    ubp.paymentrulepo                AS bpartner_paymentrulepo,
    ubp.po_discountschema_id         AS bpartner_po_discountschema_id,
    ubp.po_paymentterm_id            AS bpartner_po_paymentterm_id,
    ubp.po_pricelist_id              AS bpartner_po_pricelist_id,
    ubp.poreference                  AS bpartner_poreference,
    ubp.potentiallifetimevalue       AS bpartner_potentiallifetimeval,
    ubp.rating                       AS bpartner_rating,
    ubp.referenceno                  AS bpartner_referenceno,
    ubp.salesrep_id                  AS bpartner_salesrep_id,
    ubp.salesvolume                  AS bpartner_salesvolume,
    ubp.sendemail                    AS bpartner_sendemail,
    ubp.shareofcustomer              AS bpartner_shareofcustomer,
    ubp.shelflifeminpct              AS bpartner_shelflifeminpct,
    ubp.so_creditlimit               AS bpartner_so_creditlimit,
    ubp.socreditstatus               AS bpartner_socreditstatus,
    ubp.so_creditused                AS bpartner_so_creditused,
    ubp.so_description               AS bpartner_so_description,
    ubp.taxid                        AS bpartner_taxid,
    ubp.totalopenbalance             AS bpartner_totalopenbalance,
    ubp.updated                      AS bpartner_updated,
    ubp.updatedby                    AS bpartner_updatedby,
    ubp.url                          AS bpartner_url,
    ubp.value                        AS bpartner_value,
    cur.cursymbol,
    cur.description                  AS cur_description
FROM c_invoice i 
        JOIN c_doctype dt 
        ON i.c_doctype_id = dt.c_doctype_id 
        JOIN c_paymentterm pt 
        ON i.c_paymentterm_id = pt.c_paymentterm_id 
        JOIN c_bpartner bp 
        ON i.c_bpartner_id = bp.c_bpartner_id 
        LEFT JOIN c_greeting bpg 
        ON bp.c_greeting_id = bpg.c_greeting_id 
        JOIN c_bpartner_location bpl 
        ON i.c_bpartner_location_id = bpl.c_bpartner_location_id 
        JOIN c_location l 
        ON bpl.c_location_id = l.c_location_id 
        LEFT JOIN ad_user bpc 
        ON i.ad_user_id = bpc.ad_user_id 
        LEFT JOIN c_greeting bpcg 
        ON bpc.c_greeting_id = bpcg.c_greeting_id 
        JOIN ad_orginfo oi 
        ON i.ad_org_id = oi.ad_org_id 
        JOIN ad_clientinfo ci 
        ON i.ad_client_id = ci.ad_client_id 
        LEFT JOIN ad_user u 
        ON i.salesrep_id = u.ad_user_id 
        LEFT JOIN c_bpartner ubp 
        ON u.c_bpartner_id = ubp.c_bpartner_id
        LEFT JOIN c_currency cur
        ON i.c_currency_id = cur.c_currency_id
;
DROP VIEW c_invoice_header_vt;

CREATE OR REPLACE VIEW c_invoice_header_vt AS 
SELECT i.ad_client_id,
    i.ad_org_id,
    i.isactive,
    i.created,
    i.createdby,
    i.updated,
    i.updatedby,
    dt.ad_language,
    i.c_invoice_id,
    i.issotrx,
    i.documentno,
    i.docstatus,
    i.c_doctype_id,
    i.c_bpartner_id,
    bp.value                         AS bpvalue,
    bp.taxid                         AS bptaxid,
    bp.naics,
    bp.duns,
    oi.c_location_id                 AS org_location_id,
    oi.taxid,
    dt.printname                     AS documenttype,
    dt.documentnote                  AS documenttypenote,
    i.c_order_id,
    i.salesrep_id,
    COALESCE(ubp.name, u.name)       AS salesrep_name,
    i.dateinvoiced,
    bpgt.greeting                    AS bpgreeting,
    bp.name,
    bp.name2,
    bpcgt.greeting                   AS bpcontactgreeting,
    bpc.title,
    bpc.phone,
    NULLIF(bpc.name, bp.name)        AS contactname,
    bpl.c_location_id,
    bp.referenceno,
    l.postal || l.postal_add         AS postal,
    i.description,
    i.poreference,
    i.dateordered,
    i.c_currency_id,
    ptt.name                         AS paymentterm,
    ptt.documentnote                 AS paymenttermnote,
    i.c_charge_id,
    i.chargeamt,
    i.totallines,
    i.grandtotal,
    i.grandtotal                     AS amtinwords,
    i.m_pricelist_id,
    i.istaxincluded,
    i.c_campaign_id,
    i.c_project_id,
    i.c_activity_id,
    i.ispaid,
    COALESCE(oi.logo_id, ci.logo_id) AS logo_id,
    i.ad_orgtrx_id                   AS c_invoice_ad_orgtrx_id,
    i.ad_user_id,
    i.c_bpartner_location_id,
    i.c_conversiontype_id,
    i.c_doctypetarget_id,
    i.c_dunninglevel_id,
    i.c_payment_id,
    i.dateacct,
    i.dateprinted,
    i.docaction,
    i.dunninggrace,
    i.generateto,
    i.invoicecollectiontype,
    i.isapproved,
    i.isdiscountprinted,
    i.isindispute,
    i.ispayschedulevalid,
    i.isprinted,
    i.isselfservice                  AS c_invoice_isselfservice,
    i.istransferred,
    i.m_rma_id,
    i.paymentrule,
    i.posted,
    i.processedon,
    i.processing,
    i.ref_invoice_id,
    i.reversal_id,
    i.sendemail,
    i.user1_id,
    i.user2_id,
    ptt.ad_org_id                    AS c_paymentterm_ad_org_id,
    pt.afterdelivery,
    pt.c_paymentterm_id,
    ptt.description                  AS c_paymentterm_description,
    pt.discount,
    pt.discount2,
    pt.discountdays,
    pt.discountdays2,
    pt.fixmonthcutoff,
    pt.fixmonthday,
    pt.fixmonthoffset,
    pt.gracedays,
    ptt.isactive                     AS c_paymentterm_isactive,
    pt.isdefault,
    pt.isduefixed,
    pt.isnextbusinessday,
    pt.isvalid,
    pt.netday,
    pt.netdays,
    pt.paymenttermusage,
    pt.value                         AS c_paymentterm_value,
    bp.acqusitioncost                AS bp_acqusitioncost,
    bp.actuallifetimevalue           AS bp_actuallifetimevalue,
    bp.ad_language                   AS bp_ad_language,
    bp.ad_orgbp_id                   AS bp_ad_orgbp_id,
    bp.ad_org_id                     AS bp_ad_org_id,
    bp.bpartner_parent_id            AS bp_bpartner_parent_id,
    bp.c_bp_group_id                 AS bp_c_bp_group_id,
    bp.c_dunning_id                  AS bp_c_dunning_id,
    bp.c_greeting_id                 AS bp_c_greeting_id,
    bp.c_invoiceschedule_id          AS bp_c_invoiceschedule_id,
    bp.c_paymentterm_id              AS bp_c_paymentterm_id,
    bp.created                       AS bp_created,
    bp.createdby                     AS bp_createdby,
    bp.c_taxgroup_id                 AS bp_c_taxgroup_id,
    bp.deliveryrule                  AS bp_deliveryrule,
    bp.deliveryviarule               AS bp_deliveryviarule,
    bp.description                   AS bp_description,
    bp.dunninggrace                  AS bp_dunninggrace,
    bp.firstsale                     AS bp_firstsale,
    bp.flatdiscount                  AS bp_flatdiscount,
    bp.freightcostrule               AS bp_freightcostrule,
    bp.invoicerule                   AS bp_invoicerule,
    bp.isactive                      AS bp_isactive,
    bp.iscustomer                    AS bp_iscustomer,
    bp.isdiscountprinted             AS bp_isdiscountprinted,
    bp.isemployee                    AS bp_isemployee,
    bp.ismanufacturer                AS bp_ismanufacturer,
    bp.isonetime                     AS bp_isonetime,
    bp.ispotaxexempt                 AS bp_ispotaxexempt,
    bp.isprospect                    AS bp_isprospect,
    bp.issalesrep                    AS bp_issalesrep,
    bp.issummary                     AS bp_issummary,
    bp.istaxexempt                   AS bp_istaxexempt,
    bp.isvendor                      AS bp_isvendor,
    bp.logo_id                       AS bp_logo_id,
    bp.m_discountschema_id           AS bp_m_discountschema_id,
    bp.m_pricelist_id                AS bp_m_pricelist_id,
    bp.naics                         AS bp_naics,
    bp.numberemployees               AS bp_numberemployees,
    bp.paymentrule                   AS bp_paymentrule,
    bp.paymentrulepo                 AS bp_paymentrulepo,
    bp.po_discountschema_id          AS bp_po_discountschema_id,
    bp.po_paymentterm_id             AS bp_po_paymentterm_id,
    bp.po_pricelist_id               AS bp_po_pricelist_id,
    bp.poreference                   AS bp_poreference,
    bp.potentiallifetimevalue        AS bp_potentiallifetimevalue,
    bp.rating                        AS bp_rating,
    bp.salesrep_id                   AS bp_salesrep_id,
    bp.salesvolume                   AS bp_salesvolume,
    bp.sendemail                     AS bp_sendemail,
    bp.shareofcustomer               AS bp_shareofcustomer,
    bp.shelflifeminpct               AS bp_shelflifeminpct,
    bp.so_creditlimit                AS bp_so_creditlimit,
    bp.socreditstatus                AS bp_socreditstatus,
    bp.so_creditused                 AS bp_so_creditused,
    bp.so_description                AS bp_so_description,
    bp.totalopenbalance              AS bp_totalopenbalance,
    bp.updated                       AS bp_updated,
    bp.updatedby                     AS bp_updatedby,
    bp.url                           AS bp_url,
    bpgt.isactive                    AS c_greeting_isactive,
    bpg.isfirstnameonly,
    bpgt.name                        AS c_greeting_name,
    bpl.ad_org_id                    AS bp_location_ad_org_id,
    bpl.c_bpartner_id                AS bp_location_c_bpartner_id,
    bpl.created                      AS bp_location_created,
    bpl.createdby                    AS bp_location_createdby,
    bpl.c_salesregion_id,
    bpl.fax                          AS bp_location_fax,
    bpl.isactive                     AS bp_location_isactive,
    bpl.isbillto,
    bpl.isdn,
    bpl.ispayfrom,
    bpl.isremitto,
    bpl.isshipto,
    bpl.name                         AS bp_location_name,
    bpl.phone                        AS bp_location_phone,
    bpl.phone2                       AS bp_location_phone2,
    bpl.updated                      AS bp_location_updated,
    bpl.updatedby                    AS bp_location_updatedby,
    l.address1,
    l.address2,
    l.address3,
    l.address4,
    l.ad_org_id                      AS c_location_ad_org_id,
    l.c_city_id,
    l.c_country_id,
    l.city,
    l.created                        AS c_location_created,
    l.createdby                      AS c_location_createdby,
    l.c_region_id,
    l.isactive                       AS c_location_isactive,
    l.regionname,
    l.updated                        AS c_location_updated,
    l.updatedby                      AS c_location_updatedby,
    bpc.ad_org_id                    AS ad_user_ad_org_id,
    bpc.ad_orgtrx_id                 AS ad_user_ad_ad_orgtrx_id,
    bpc.birthday                     AS ad_user_ad_birthday,
    bpc.c_bpartner_id                AS ad_user_c_bpartner_id,
    bpc.c_bpartner_location_id       AS ad_user_c_bpartner_location_id,
    bpc.c_greeting_id                AS ad_user_c_greeting_id,
    bpc.comments                     AS ad_user_comments,
    bpc.created                      AS ad_user_created,
    bpc.createdby                    AS ad_user_createdby,
    bpc.description                  AS ad_user_description,
    bpc.email                        AS ad_user_email,
    bpc.fax                          AS ad_user_fax,
    bpc.isactive                     AS ad_user_isactive,
    bpc.lastcontact                  AS ad_user_lastcontact,
    bpc.lastresult                   AS ad_user_lastresult,
    bpc.phone2                       AS ad_user_phone2,
    bpc.supervisor_id                AS ad_user_supervisor_id,
    bpc.updated                      AS ad_user_updated,
    bpc.updatedby                    AS ad_user_updatedby,
    bpc.value                        AS ad_user_value,
    bpcgt.isactive                   AS user_greeting_isactive,
    bpcg.isfirstnameonly             AS user_greeting_isfirstnameonly,
    bpcgt.name                       AS user_greeting_name,
    oi.ad_org_id                     AS ad_orginfo_ad_org_id,
    oi.ad_orgtype_id,
    oi.c_calendar_id,
    oi.created                       AS ad_orginfo_created,
    oi.createdby                     AS ad_orginfo_createdby,
    oi.dropship_warehouse_id,
    oi.duns                          AS ad_orginfo_duns,
    oi.email                         AS ad_orginfo_email,
    oi.fax                           AS ad_orginfo_fax,
    oi.isactive                      AS ad_orginfo_isactive,
    oi.m_warehouse_id,
    oi.parent_org_id,
    oi.phone                         AS ad_orginfo_phone,
    oi.phone2                        AS ad_orginfo_phone2,
    oi.receiptfootermsg,
    oi.supervisor_id,
    oi.updated                       AS ad_orginfo_updated,
    oi.updatedby                     AS ad_orginfo_updatedby,
    u.ad_org_id                      AS salesrep_ad_org_id,
    u.ad_orgtrx_id                   AS salesrep_ad_ad_orgtrx_id,
    u.birthday                       AS salesrep_ad_birthday,
    u.c_bpartner_id                  AS salesrep_c_bpartner_id,
    u.c_bpartner_location_id         AS salesrep_c_bp_location_id,
    u.c_greeting_id                  AS salesrep_c_greeting_id,
    u.comments                       AS salesrep_comments,
    u.created                        AS salesrep_created,
    u.createdby                      AS salesrep_createdby,
    u.description                    AS salesrep_description,
    u.email                          AS salesrep_email,
    u.fax                            AS salesrep_fax,
    u.isactive                       AS salesrep_isactive,
    u.lastcontact                    AS salesrep_lastcontact,
    u.lastresult                     AS salesrep_lastresult,
    u.phone                          AS salesrep_phone,
    u.phone2                         AS salesrep_phone2,
    u.supervisor_id                  AS salesrep_supervisor_id,
    u.title                          AS salesrep_title,
    u.updated                        AS salesrep_updated,
    u.updatedby                      AS salesrep_updatedby,
    u.value                          AS salesrep_value,
    ubp.acqusitioncost               AS bpartner_acqusitioncost,
    ubp.actuallifetimevalue          AS bpartner_actuallifetimevalue,
    ubp.ad_language                  AS bpartner_ad_language,
    ubp.ad_orgbp_id                  AS bpartner_ad_orgbp_id,
    ubp.ad_org_id                    AS bpartner_ad_org_id,
    ubp.bpartner_parent_id           AS bpartner_bpartner_parent_id,
    ubp.c_bp_group_id                AS bpartner_c_bp_group_id,
    ubp.c_dunning_id                 AS bpartner_c_dunning_id,
    ubp.c_greeting_id                AS bpartner_c_greeting_id,
    ubp.c_invoiceschedule_id         AS bpartner_c_invoiceschedule_id,
    ubp.c_paymentterm_id             AS bpartner_c_paymentterm_id,
    ubp.created                      AS bpartner_created,
    ubp.createdby                    AS bpartner_createdby,
    ubp.c_taxgroup_id                AS bpartner_c_taxgroup_id,
    ubp.deliveryrule                 AS bpartner_deliveryrule,
    ubp.deliveryviarule              AS bpartner_deliveryviarule,
    ubp.description                  AS bpartner_description,
    ubp.dunninggrace                 AS bpartner_dunninggrace,
    ubp.duns                         AS bpartner_duns,
    ubp.firstsale                    AS bpartner_firstsale,
    ubp.flatdiscount                 AS bpartner_flatdiscount,
    ubp.freightcostrule              AS bpartner_freightcostrule,
    ubp.invoicerule                  AS bpartner_invoicerule,
    ubp.isactive                     AS bpartner_isactive,
    ubp.iscustomer                   AS bpartner_iscustomer,
    ubp.isdiscountprinted            AS bpartner_isdiscountprinted,
    ubp.isemployee                   AS bpartner_isemployee,
    ubp.ismanufacturer               AS bpartner_ismanufacturer,
    ubp.isonetime                    AS bpartner_isonetime,
    ubp.ispotaxexempt                AS bpartner_ispotaxexempt,
    ubp.isprospect                   AS bpartner_isprospect,
    ubp.issalesrep                   AS bpartner_issalesrep,
    ubp.issummary                    AS bpartner_issummary,
    ubp.istaxexempt                  AS bpartner_istaxexempt,
    ubp.isvendor                     AS bpartner_isvendor,
    ubp.logo_id                      AS bpartner_logo_id,
    ubp.m_discountschema_id          AS bpartner_m_discountschema_id,
    ubp.m_pricelist_id               AS bpartner_m_pricelist_id,
    ubp.naics                        AS bpartner_naics,
    ubp.name2                        AS bpartner_name2,
    ubp.numberemployees              AS bpartner_numberemployees,
    ubp.paymentrule                  AS bpartner_paymentrule,
    ubp.paymentrulepo                AS bpartner_paymentrulepo,
    ubp.po_discountschema_id         AS bpartner_po_discountschema_id,
    ubp.po_paymentterm_id            AS bpartner_po_paymentterm_id,
    ubp.po_pricelist_id              AS bpartner_po_pricelist_id,
    ubp.poreference                  AS bpartner_poreference,
    ubp.potentiallifetimevalue       AS bpartner_potentiallifetimeval,
    ubp.rating                       AS bpartner_rating,
    ubp.referenceno                  AS bpartner_referenceno,
    ubp.salesrep_id                  AS bpartner_salesrep_id,
    ubp.salesvolume                  AS bpartner_salesvolume,
    ubp.sendemail                    AS bpartner_sendemail,
    ubp.shareofcustomer              AS bpartner_shareofcustomer,
    ubp.shelflifeminpct              AS bpartner_shelflifeminpct,
    ubp.so_creditlimit               AS bpartner_so_creditlimit,
    ubp.socreditstatus               AS bpartner_socreditstatus,
    ubp.so_creditused                AS bpartner_so_creditused,
    ubp.so_description               AS bpartner_so_description,
    ubp.taxid                        AS bpartner_taxid,
    ubp.totalopenbalance             AS bpartner_totalopenbalance,
    ubp.updated                      AS bpartner_updated,
    ubp.updatedby                    AS bpartner_updatedby,
    ubp.url                          AS bpartner_url,
    ubp.value                        AS bpartner_value,
    cur.cursymbol,
    cur.description                  AS cur_description
FROM c_invoice i 
        JOIN c_doctype_trl dt 
        ON i.c_doctype_id = dt.c_doctype_id 
        JOIN c_paymentterm pt 
        ON i.c_paymentterm_id = pt.c_paymentterm_id 
        JOIN c_paymentterm_trl ptt 
        ON i.c_paymentterm_id = ptt.c_paymentterm_id AND dt.ad_language = ptt.ad_language 
        JOIN c_bpartner bp 
        ON i.c_bpartner_id = bp.c_bpartner_id 
        LEFT JOIN c_greeting bpg 
        ON bp.c_greeting_id = bpg.c_greeting_id 
        LEFT JOIN c_greeting_trl bpgt 
        ON bp.c_greeting_id = bpgt.c_greeting_id AND dt.ad_language = bpgt.ad_language 
        JOIN c_bpartner_location bpl 
        ON i.c_bpartner_location_id = bpl.c_bpartner_location_id 
        JOIN c_location l 
        ON bpl.c_location_id = l.c_location_id 
        LEFT JOIN ad_user bpc 
        ON i.ad_user_id = bpc.ad_user_id 
        LEFT JOIN c_greeting bpcg 
        ON bpc.c_greeting_id = bpcg.c_greeting_id 
        LEFT JOIN c_greeting_trl bpcgt 
        ON bpc.c_greeting_id = bpcgt.c_greeting_id AND dt.ad_language = bpcgt.ad_language 
        JOIN ad_orginfo oi 
        ON i.ad_org_id = oi.ad_org_id 
        JOIN ad_clientinfo ci 
        ON i.ad_client_id = ci.ad_client_id 
        LEFT JOIN ad_user u 
        ON i.salesrep_id = u.ad_user_id 
        LEFT JOIN c_bpartner ubp 
        ON u.c_bpartner_id = ubp.c_bpartner_id
        LEFT JOIN c_currency_trl cur
        ON i.c_currency_id = cur.c_currency_id AND dt.ad_language = cur.ad_language 
;
DROP VIEW c_order_header_v;

CREATE OR REPLACE VIEW c_order_header_v AS 
SELECT o.ad_client_id,
    o.ad_org_id,
    o.isactive,
    o.created,
    o.createdby,
    o.updated,
    o.updatedby,
    'en_US'::character varying       AS ad_language,
    o.c_order_id,
    o.issotrx,
    o.documentno,
    o.docstatus,
    o.c_doctype_id,
    o.c_bpartner_id,
    bp.value                         AS bpvalue,
    bp.taxid                         AS bptaxid,
    bp.naics,
    bp.duns,
    oi.c_location_id                 AS org_location_id,
    oi.taxid,
    o.m_warehouse_id,
    wh.c_location_id                 AS warehouse_location_id,
    dt.printname                     AS documenttype,
    dt.documentnote                  AS documenttypenote,
    o.salesrep_id,
    COALESCE(ubp.name, u.name)       AS salesrep_name,
    o.dateordered,
    o.datepromised,
    bpg.greeting                     AS bpgreeting,
    bp.name,
    bp.name2,
    bpcg.greeting                    AS bpcontactgreeting,
    bpc.title,
    bpc.phone,
    NULLIF(bpc.name, bp.name)        AS contactname,
    bpl.c_location_id,
    l.postal || l.postal_add         AS postal,
    bp.referenceno,
    o.bill_bpartner_id,
    o.bill_location_id,
    o.bill_user_id,
    bbp.value                        AS bill_bpvalue,
    bbp.taxid                        AS bill_bptaxid,
    bbp.name                         AS bill_name,
    bbp.name2                        AS bill_name2,
    bbpc.title                       AS bill_title,
    bbpc.phone                       AS bill_phone,
    NULLIF(bbpc.name, bbp.name)      AS bill_contactname,
    bbpl.c_location_id               AS bill_c_location_id,
    o.description,
    o.poreference,
    o.c_currency_id,
    pt.name                          AS paymentterm,
    pt.documentnote                  AS paymenttermnote,
    o.c_charge_id,
    o.chargeamt,
    o.totallines,
    o.grandtotal,
    o.grandtotal                     AS amtinwords,
    o.m_pricelist_id,
    o.istaxincluded,
    o.volume,
    o.weight,
    o.c_campaign_id,
    o.c_project_id,
    o.c_activity_id,
    o.m_shipper_id,
    o.deliveryrule,
    o.deliveryviarule,
    o.priorityrule,
    o.invoicerule,
    COALESCE(oi.logo_id, ci.logo_id) AS logo_id,
    o.ad_orgtrx_id,
    o.ad_user_id,
    o.amountrefunded,
    o.amounttendered,
    o.c_bpartner_location_id,
    o.c_cashline_id,
    o.c_cashplanline_id,
    o.c_conversiontype_id,
    o.c_doctypetarget_id,
    o.copyfrom,
    o.c_payment_id,
    o.c_paymentterm_id,
    o.c_pos_id,
    o.dateacct,
    o.dateprinted,
    o.docaction,
    o.dropship_bpartner_id,
    o.dropship_location_id,
    o.dropship_user_id,
    o.freightamt,
    o.freightcostrule,
    o.isapproved,
    o.iscreditapproved,
    o.isdelivered,
    o.isdiscountprinted,
    o.isdropship,
    o.isinvoiced,
    o.ispayschedulevalid,
    o.isprinted,
    o.isselected,
    o.isselfservice,
    o.istransferred,
    o.link_order_id,
    o.m_freightcategory_id,
    o.ordertype,
    o.pay_bpartner_id,
    o.pay_location_id,
    o.paymentrule,
    o.posted,
    o.processed,
    o.processedon,
    o.promotioncode,
    o.ref_order_id,
    o.sendemail,
    o.user1_id,
    o.user2_id,
    wh.ad_org_id                     AS m_warehouse_ad_org_id,
    wh.description                   AS m_warehouse_description,
    wh.isactive                      AS m_warehouse_isactive,
    wh.isdisallownegativeinv,
    wh.isintransit,
    wh.m_warehousesource_id,
    wh.name                          AS m_warehouse_name,
    wh.replenishmentclass,
    wh.separator,
    wh.value                         AS m_warehouse_value,
    pt.ad_org_id                     AS c_paymentterm_ad_org_id,
    pt.afterdelivery,
    pt.description                   AS c_paymentterm_description,
    pt.discount,
    pt.discount2,
    pt.discountdays,
    pt.discountdays2,
    pt.fixmonthcutoff,
    pt.fixmonthday,
    pt.fixmonthoffset,
    pt.gracedays,
    pt.isactive                      AS c_paymentterm_isactive,
    pt.isdefault,
    pt.isduefixed,
    pt.isnextbusinessday,
    pt.isvalid,
    pt.netday,
    pt.netdays,
    pt.paymenttermusage,
    pt.value                         AS m_paymentterm_value,
    bp.acqusitioncost                AS bp_acqusitioncost,
    bp.actuallifetimevalue           AS bp_actuallifetimevalue,
    bp.ad_language                   AS bp_ad_language,
    bp.ad_orgbp_id                   AS bp_ad_orgbp_id,
    bp.ad_org_id                     AS bp_ad_org_id,
    bp.bpartner_parent_id            AS bp_bpartner_parent_id,
    bp.c_bp_group_id                 AS bp_c_bp_group_id,
    bp.c_dunning_id                  AS bp_c_dunning_id,
    bp.c_greeting_id                 AS bp_c_greeting_id,
    bp.c_invoiceschedule_id          AS bp_c_invoiceschedule_id,
    bp.c_paymentterm_id              AS bp_c_paymentterm_id,
    bp.created                       AS bp_created,
    bp.createdby                     AS bp_createdby,
    bp.c_taxgroup_id                 AS bp_c_taxgroup_id,
    bp.deliveryrule                  AS bp_deliveryrule,
    bp.deliveryviarule               AS bp_deliveryviarule,
    bp.description                   AS bp_description,
    bp.dunninggrace                  AS bp_dunninggrace,
    bp.firstsale                     AS bp_firstsale,
    bp.flatdiscount                  AS bp_flatdiscount,
    bp.freightcostrule               AS bp_freightcostrule,
    bp.invoicerule                   AS bp_invoicerule,
    bp.isactive                      AS bp_isactive,
    bp.iscustomer                    AS bp_iscustomer,
    bp.isdiscountprinted             AS bp_isdiscountprinted,
    bp.isemployee                    AS bp_isemployee,
    bp.ismanufacturer                AS bp_ismanufacturer,
    bp.isonetime                     AS bp_isonetime,
    bp.ispotaxexempt                 AS bp_ispotaxexempt,
    bp.isprospect                    AS bp_isprospect,
    bp.issalesrep                    AS bp_issalesrep,
    bp.issummary                     AS bp_issummary,
    bp.istaxexempt                   AS bp_istaxexempt,
    bp.isvendor                      AS bp_isvendor,
    bp.logo_id                       AS bp_logo_id,
    bp.m_discountschema_id           AS bp_m_discountschema_id,
    bp.m_pricelist_id                AS bp_m_pricelist_id,
    bp.numberemployees               AS bp_numberemployees,
    bp.paymentrule                   AS bp_paymentrule,
    bp.paymentrulepo                 AS bp_paymentrulepo,
    bp.po_discountschema_id          AS bp_po_discountschema_id,
    bp.po_paymentterm_id             AS bp_po_paymentterm_id,
    bp.po_pricelist_id               AS bp_po_pricelist_id,
    bp.poreference                   AS bp_poreference,
    bp.potentiallifetimevalue        AS bp_potentiallifetimevalue,
    bp.rating                        AS bp_rating,
    bp.salesrep_id                   AS bp_salesrep_id,
    bp.salesvolume                   AS bp_salesvolume,
    bp.sendemail                     AS bp_sendemail,
    bp.shareofcustomer               AS bp_shareofcustomer,
    bp.shelflifeminpct               AS bp_shelflifeminpct,
    bp.so_creditlimit                AS bp_so_creditlimit,
    bp.socreditstatus                AS bp_socreditstatus,
    bp.so_creditused                 AS bp_so_creditused,
    bp.so_description                AS bp_so_description,
    bp.totalopenbalance              AS bp_totalopenbalance,
    bp.updated                       AS bp_updated,
    bp.updatedby                     AS bp_updatedby,
    bp.url                           AS bp_url,
    bpg.ad_org_id                    AS c_greeting_ad_org_id,
    bpg.isactive                     AS c_greeting_isactive,
    bpg.isfirstnameonly,
    bpg.name                         AS c_greeting_name,
    bpl.ad_org_id                    AS bp_location_ad_org_id,
    bpl.c_bpartner_id                AS bp_location_c_bpartner_id,
    bpl.created                      AS bp_location_created,
    bpl.createdby                    AS bp_location_createdby,
    bpl.c_salesregion_id             AS bp_location_c_salesregion_id,
    bpl.fax                          AS bp_location_fax,
    bpl.isactive                     AS bp_location_isactive,
    bpl.isbillto                     AS bp_location_isbillto,
    bpl.isdn                         AS bp_location_isdn,
    bpl.ispayfrom                    AS bp_location_ispayfrom,
    bpl.isremitto                    AS bp_location_isremitto,
    bpl.isshipto                     AS bp_location_isshipto,
    bpl.name                         AS bp_location_name,
    bpl.phone                        AS bp_location_phone,
    bpl.phone2                       AS bp_location_phone2,
    bpl.updated                      AS bp_location_updated,
    bpl.updatedby                    AS bp_location_updatedby,
    l.address1,
    l.address2,
    l.address3,
    l.address4,
    l.ad_org_id                      AS c_location_ad_org_id,
    l.c_city_id,
    l.c_country_id,
    l.city,
    l.created                        AS c_location_created,
    l.createdby                      AS c_location_createdby,
    l.c_region_id,
    l.isactive                       AS c_location_isactive,
    l.regionname,
    l.updated                        AS c_location_updated,
    l.updatedby                      AS c_location_updatedby,
    bpc.ad_org_id                    AS ad_user_ad_org_id,
    bpc.ad_orgtrx_id                 AS ad_user_ad_orgtrx_id,
    bpc.birthday                     AS ad_user_ad_birthday,
    bpc.c_bpartner_id                AS ad_user_c_bpartner_id,
    bpc.c_bpartner_location_id       AS ad_user_c_bpartner_location_id,
    bpc.c_greeting_id                AS ad_user_c_greeting_id,
    bpc.comments                     AS ad_user_comments,
    bpc.created                      AS ad_user_created,
    bpc.createdby                    AS ad_user_createdby,
    bpc.description                  AS ad_user_description,
    bpc.email                        AS ad_user_email,
    bpc.fax                          AS ad_user_fax,
    bpc.isactive                     AS ad_user_isactive,
    bpc.lastcontact                  AS ad_user_lastcontact,
    bpc.lastresult                   AS ad_user_lastresult,
    bpc.phone2                       AS ad_user_phone2,
    bpc.supervisor_id                AS ad_user_supervisor_id,
    bpc.updated                      AS ad_user_updated,
    bpc.updatedby                    AS ad_user_updatedby,
    bpc.value                        AS ad_user_value,
    bpcg.ad_org_id                   AS c_user_greeting_ad_org_id,
    bpcg.isactive                    AS c_user_greeting_isactive,
    bpcg.isfirstnameonly             AS c_user_greeting_isfnameonly,
    bpcg.name                        AS c_user_greeting_name,
    oi.ad_org_id                     AS ad_orginfo_ad_org_id,
    oi.ad_orgtype_id,
    oi.c_calendar_id,
    oi.created                       AS ad_orginfo_created,
    oi.createdby                     AS ad_orginfo_createdby,
    oi.dropship_warehouse_id,
    oi.duns                          AS ad_orginfo_duns,
    oi.email                         AS ad_orginfo_email,
    oi.fax                           AS ad_orginfo_fax,
    oi.isactive                      AS ad_orginfo_isactive,
    oi.m_warehouse_id                AS ad_orginfo_m_warehouse_id,
    oi.parent_org_id,
    oi.phone                         AS ad_orginfo_phone,
    oi.phone2                        AS ad_orginfo_phone2,
    oi.receiptfootermsg,
    oi.supervisor_id,
    oi.updated                       AS ad_orginfo_updated,
    oi.updatedby                     AS ad_orginfo_updatedby,
    u.ad_org_id                      AS salesrep_ad_org_id,
    u.ad_orgtrx_id                   AS salesrep_ad_orgtrx_id,
    u.birthday                       AS salesrep_ad_birthday,
    u.c_bpartner_id                  AS salesrep_c_bpartner_id,
    u.c_bpartner_location_id         AS salesrep_c_bp_location_id,
    u.c_greeting_id                  AS salesrep_c_greeting_id,
    u.comments                       AS salesrep_comments,
    u.created                        AS salesrep_created,
    u.createdby                      AS salesrep_createdby,
    u.description                    AS salesrep_description,
    u.email                          AS salesrep_email,
    u.fax                            AS salesrep_fax,
    u.isactive                       AS salesrep_isactive,
    u.lastcontact                    AS salesrep_lastcontact,
    u.lastresult                     AS salesrep_lastresult,
    u.phone                          AS salesrep_phone,
    u.phone2                         AS salesrep_phone2,
    u.supervisor_id                  AS salesrep_supervisor_id,
    u.title                          AS salesrep_title,
    u.updated                        AS salesrep_updated,
    u.updatedby                      AS salesrep_updatedby,
    u.value                          AS salesrep_value,
    ubp.acqusitioncost               AS salesrep_bp_acqusitioncost,
    ubp.actuallifetimevalue          AS salesrep_bp_actuallifetimeval,
    ubp.ad_language                  AS salesrep_bp_ad_language,
    ubp.ad_orgbp_id                  AS salesrep_bp_ad_orgbp_id,
    ubp.ad_org_id                    AS salesrep_bp_ad_org_id,
    ubp.bpartner_parent_id           AS salesrep_bp_bpartner_parent_id,
    ubp.c_bp_group_id                AS salesrep_bp_c_bp_group_id,
    ubp.c_dunning_id                 AS salesrep_bp_c_dunning_id,
    ubp.c_greeting_id                AS salesrep_bp_c_greeting_id,
    ubp.c_invoiceschedule_id         AS salesrep_bp_c_invoicesched_id,
    ubp.c_paymentterm_id             AS salesrep_bp_c_paymentterm_id,
    ubp.created                      AS salesrep_bp_created,
    ubp.createdby                    AS salesrep_bp_createdby,
    ubp.c_taxgroup_id                AS salesrep_bp_c_taxgroup_id,
    ubp.deliveryrule                 AS salesrep_bp_deliveryrule,
    ubp.deliveryviarule              AS salesrep_bp_deliveryviarule,
    ubp.description                  AS salesrep_bp_description,
    ubp.dunninggrace                 AS salesrep_bp_dunninggrace,
    ubp.duns                         AS salesrep_bp_duns,
    ubp.firstsale                    AS salesrep_bp_firstsale,
    ubp.flatdiscount                 AS salesrep_bp_flatdiscount,
    ubp.freightcostrule              AS salesrep_bp_freightcostrule,
    ubp.invoicerule                  AS salesrep_bp_invoicerule,
    ubp.isactive                     AS salesrep_bp_isactive,
    ubp.iscustomer                   AS salesrep_bp_iscustomer,
    ubp.isdiscountprinted            AS salesrep_bp_isdiscountprinted,
    ubp.isemployee                   AS salesrep_bp_isemployee,
    ubp.ismanufacturer               AS salesrep_bp_ismanufacturer,
    ubp.isonetime                    AS salesrep_bp_isonetime,
    ubp.ispotaxexempt                AS salesrep_bp_ispotaxexempt,
    ubp.isprospect                   AS salesrep_bp_isprospect,
    ubp.issalesrep                   AS salesrep_bp_issalesrep,
    ubp.issummary                    AS salesrep_bp_issummary,
    ubp.istaxexempt                  AS salesrep_bp_istaxexempt,
    ubp.isvendor                     AS salesrep_bp_isvendor,
    ubp.logo_id                      AS salesrep_bp_logo_id,
    ubp.m_discountschema_id          AS salesrep_bp_m_discountschm_id,
    ubp.m_pricelist_id               AS salesrep_bp_m_pricelist_id,
    ubp.naics                        AS salesrep_bp_naics,
    ubp.name2                        AS salesrep_bp_name2,
    ubp.numberemployees              AS salesrep_bp_numberemployees,
    ubp.paymentrule                  AS salesrep_bp_paymentrule,
    ubp.paymentrulepo                AS salesrep_bp_paymentrulepo,
    ubp.po_discountschema_id         AS salesrep_bp_po_discountschm_id,
    ubp.po_paymentterm_id            AS salesrep_bp_po_paymentterm_id,
    ubp.po_pricelist_id              AS salesrep_bp_po_pricelist_id,
    ubp.poreference                  AS salesrep_bp_poreference,
    ubp.potentiallifetimevalue       AS salesrep_bp_potentiallifetime,
    ubp.rating                       AS salesrep_bp_rating,
    ubp.referenceno                  AS salesrep_bp_referenceno,
    ubp.salesrep_id                  AS salesrep_bp_salesrep_id,
    ubp.salesvolume                  AS salesrep_bp_salesvolume,
    ubp.sendemail                    AS salesrep_bp_sendemail,
    ubp.shareofcustomer              AS salesrep_bp_shareofcustomer,
    ubp.shelflifeminpct              AS salesrep_bp_shelflifeminpct,
    ubp.so_creditlimit               AS salesrep_bp_so_creditlimit,
    ubp.socreditstatus               AS salesrep_bp_socreditstatus,
    ubp.so_creditused                AS salesrep_bp_so_creditused,
    ubp.so_description               AS salesrep_bp_so_description,
    ubp.taxid                        AS salesrep_bp_taxid,
    ubp.totalopenbalance             AS salesrep_bp_totalopenbalance,
    ubp.updated                      AS salesrep_bp_updated,
    ubp.updatedby                    AS salesrep_bp_updatedby,
    ubp.url                          AS salesrep_bp_url,
    ubp.value                        AS salesrep_bp_value,
    bbp.acqusitioncost               AS bill_bp_acqusitioncost,
    bbp.actuallifetimevalue          AS bill_bp_actuallifetimevalue,
    bbp.ad_language                  AS bill_bp_ad_language,
    bbp.ad_orgbp_id                  AS bill_bp_ad_orgbp_id,
    bbp.ad_org_id                    AS bill_bp_ad_org_id,
    bbp.bpartner_parent_id           AS bill_bp_bpartner_parent_id,
    bbp.c_bp_group_id                AS bill_bp_c_bp_group_id,
    bbp.c_dunning_id                 AS bill_bp_c_dunning_id,
    bbp.c_greeting_id                AS bill_bp_c_greeting_id,
    bbp.c_invoiceschedule_id         AS bill_bp_c_invoiceschedule_id,
    bbp.c_paymentterm_id             AS bill_bp_c_paymentterm_id,
    bbp.created                      AS bill_bp_created,
    bbp.createdby                    AS bill_bp_createdby,
    bbp.c_taxgroup_id                AS bill_bp_c_taxgroup_id,
    bbp.deliveryrule                 AS bill_bp_deliveryrule,
    bbp.deliveryviarule              AS bill_bp_deliveryviarule,
    bbp.description                  AS bill_bp_description,
    bbp.dunninggrace                 AS bill_bp_dunninggrace,
    bbp.duns                         AS bill_bp_duns,
    bbp.firstsale                    AS bill_bp_firstsale,
    bbp.flatdiscount                 AS bill_bp_flatdiscount,
    bbp.freightcostrule              AS bill_bp_freightcostrule,
    bbp.invoicerule                  AS bill_bp_invoicerule,
    bbp.isactive                     AS bill_bp_isactive,
    bbp.iscustomer                   AS bill_bp_iscustomer,
    bbp.isdiscountprinted            AS bill_bp_isdiscountprinted,
    bbp.isemployee                   AS bill_bp_isemployee,
    bbp.ismanufacturer               AS bill_bp_ismanufacturer,
    bbp.isonetime                    AS bill_bp_isonetime,
    bbp.ispotaxexempt                AS bill_bp_ispotaxexempt,
    bbp.isprospect                   AS bill_bp_isprospect,
    bbp.issalesrep                   AS bill_bp_issalesrep,
    bbp.issummary                    AS bill_bp_issummary,
    bbp.istaxexempt                  AS bill_bp_istaxexempt,
    bbp.isvendor                     AS bill_bp_isvendor,
    bbp.logo_id                      AS bill_bp_logo_id,
    bbp.m_discountschema_id          AS bill_bp_m_discountschema_id,
    bbp.m_pricelist_id               AS bill_bp_m_pricelist_id,
    bbp.naics                        AS bill_bp_naics,
    bbp.numberemployees              AS bill_bp_numberemployees,
    bbp.paymentrule                  AS bill_bp_paymentrule,
    bbp.paymentrulepo                AS bill_bp_paymentrulepo,
    bbp.po_discountschema_id         AS bill_bp_po_discountschema_id,
    bbp.po_paymentterm_id            AS bill_bp_po_paymentterm_id,
    bbp.po_pricelist_id              AS bill_bp_po_pricelist_id,
    bbp.poreference                  AS bill_bp_poreference,
    bbp.potentiallifetimevalue       AS bill_bp_potentiallifetimevalue,
    bbp.rating                       AS bill_bp_rating,
    bbp.referenceno                  AS bill_bp_referenceno,
    bbp.salesrep_id                  AS bill_bp_salesrep_id,
    bbp.salesvolume                  AS bill_bp_salesvolume,
    bbp.sendemail                    AS bill_bp_sendemail,
    bbp.shareofcustomer              AS bill_bp_shareofcustomer,
    bbp.shelflifeminpct              AS bill_bp_shelflifeminpct,
    bbp.so_creditlimit               AS bill_bp_so_creditlimit,
    bbp.socreditstatus               AS bill_bp_socreditstatus,
    bbp.so_creditused                AS bill_bp_so_creditused,
    bbp.so_description               AS bill_bp_so_description,
    bbp.totalopenbalance             AS bill_bp_totalopenbalance,
    bbp.updated                      AS bill_bp_updated,
    bbp.updatedby                    AS bill_bp_updatedby,
    bbp.url                          AS bill_bp_url,
    bbpl.ad_org_id                   AS bill_bp_location_ad_org_id,
    bbpl.c_bpartner_id               AS bill_bp_location_c_bpartner_id,
    bbpl.created                     AS bill_bp_location_created,
    bbpl.createdby                   AS bill_bp_location_createdby,
    bbpl.c_salesregion_id            AS bill_bp_location_c_salesreg_id,
    bbpl.fax                         AS bill_bp_location_fax,
    bbpl.isactive                    AS bill_bp_location_isactive,
    bbpl.isbillto                    AS bill_bp_location_isbillto,
    bbpl.isdn                        AS bill_bp_location_isdn,
    bbpl.ispayfrom                   AS bill_bp_location_ispayfrom,
    bbpl.isremitto                   AS bill_bp_location_isremitto,
    bbpl.isshipto                    AS bill_bp_location_isshipto,
    bbpl.name                        AS bill_bp_location_name,
    bbpl.phone                       AS bill_bp_location_phone,
    bbpl.phone2                      AS bill_bp_location_phone2,
    bbpl.updated                     AS bill_bp_location_updated,
    bbpl.updatedby                   AS bill_bp_location_updatedby,
    bbpc.ad_org_id                   AS bill_user_ad_org_id,
    bbpc.ad_orgtrx_id                AS bill_user_ad_orgtrx_id,
    bbpc.birthday                    AS bill_user_ad_birthday,
    bbpc.c_bpartner_id               AS bill_user_c_bpartner_id,
    bbpc.c_bpartner_location_id      AS bill_user_c_bp_location_id,
    bbpc.c_greeting_id               AS bill_user_c_greeting_id,
    bbpc.comments                    AS bill_user_comments,
    bbpc.created                     AS bill_user_created,
    bbpc.createdby                   AS bill_user_createdby,
    bbpc.description                 AS bill_user_description,
    bbpc.email                       AS bill_user_email,
    bbpc.fax                         AS bill_user_fax,
    bbpc.isactive                    AS bill_user_isactive,
    bbpc.lastcontact                 AS bill_user_lastcontact,
    bbpc.lastresult                  AS bill_user_lastresult,
    bbpc.phone2                      AS bill_user_phone2,
    bbpc.supervisor_id               AS bill_user_supervisor_id,
    bbpc.updated                     AS bill_user_updated,
    bbpc.updatedby                   AS bill_user_updatedby,
    bbpc.value                       AS bill_user_value,
    cur.cursymbol,
    cur.description                  AS cur_description
FROM c_order o 
        JOIN c_doctype dt 
        ON o.c_doctype_id = dt.c_doctype_id 
        JOIN m_warehouse wh 
        ON o.m_warehouse_id = wh.m_warehouse_id 
        JOIN c_paymentterm pt 
        ON o.c_paymentterm_id = pt.c_paymentterm_id 
        JOIN c_bpartner bp 
        ON o.c_bpartner_id = bp.c_bpartner_id 
        LEFT JOIN c_greeting bpg 
        ON bp.c_greeting_id = bpg.c_greeting_id 
        JOIN c_bpartner_location bpl 
        ON o.c_bpartner_location_id = bpl.c_bpartner_location_id 
        JOIN c_location l 
        ON bpl.c_location_id = l.c_location_id 
        LEFT JOIN ad_user bpc 
        ON o.ad_user_id = bpc.ad_user_id 
        LEFT JOIN c_greeting bpcg 
        ON bpc.c_greeting_id = bpcg.c_greeting_id 
        JOIN ad_orginfo oi 
        ON o.ad_org_id = oi.ad_org_id 
        JOIN ad_clientinfo ci 
        ON o.ad_client_id = ci.ad_client_id 
        LEFT JOIN ad_user u 
        ON o.salesrep_id = u.ad_user_id 
        LEFT JOIN c_bpartner ubp 
        ON u.c_bpartner_id = ubp.c_bpartner_id 
        JOIN c_bpartner bbp 
        ON o.bill_bpartner_id = bbp.c_bpartner_id 
        JOIN c_bpartner_location bbpl 
        ON o.bill_location_id = bbpl.c_bpartner_location_id 
        LEFT JOIN ad_user bbpc 
        ON o.bill_user_id = bbpc.ad_user_id
        LEFT JOIN c_currency cur
        ON o.c_currency_id = cur.c_currency_id
;
DROP VIEW c_order_header_vt;

CREATE OR REPLACE VIEW c_order_header_vt AS 
SELECT o.ad_client_id,
    o.ad_org_id,
    o.isactive,
    o.created,
    o.createdby,
    o.updated,
    o.updatedby,
    dt.ad_language,
    o.c_order_id,
    o.issotrx,
    o.documentno,
    o.docstatus,
    o.c_doctype_id,
    o.c_bpartner_id,
    bp.value                         AS bpvalue,
    bp.taxid                         AS bptaxid,
    bp.naics,
    bp.duns,
    oi.c_location_id                 AS org_location_id,
    oi.taxid,
    o.m_warehouse_id,
    wh.c_location_id                 AS warehouse_location_id,
    dt.printname                     AS documenttype,
    dt.documentnote                  AS documenttypenote,
    o.salesrep_id,
    COALESCE(ubp.name, u.name)       AS salesrep_name,
    o.dateordered,
    o.datepromised,
    bpgt.greeting                    AS bpgreeting,
    bp.name,
    bp.name2,
    bpcgt.greeting                   AS bpcontactgreeting,
    bpc.title,
    bpc.phone,
    NULLIF(bpc.name, bp.name)        AS contactname,
    bpl.c_location_id,
    l.postal || l.postal_add         AS postal,
    bp.referenceno,
    o.bill_bpartner_id,
    o.bill_location_id,
    o.bill_user_id,
    bbp.value                        AS bill_bpvalue,
    bbp.taxid                        AS bill_bptaxid,
    bbp.name                         AS bill_name,
    bbp.name2                        AS bill_name2,
    bbpc.title                       AS bill_title,
    bbpc.phone                       AS bill_phone,
    NULLIF(bbpc.name, bbp.name)      AS bill_contactname,
    bbpl.c_location_id               AS bill_c_location_id,
    o.description,
    o.poreference,
    o.c_currency_id,
    ptt.name                         AS paymentterm,
    ptt.documentnote                 AS paymenttermnote,
    o.c_charge_id,
    o.chargeamt,
    o.totallines,
    o.grandtotal,
    o.grandtotal                     AS amtinwords,
    o.m_pricelist_id,
    o.istaxincluded,
    o.volume,
    o.weight,
    o.c_campaign_id,
    o.c_project_id,
    o.c_activity_id,
    o.m_shipper_id,
    o.deliveryrule,
    o.deliveryviarule,
    o.priorityrule,
    o.invoicerule,
    COALESCE(oi.logo_id, ci.logo_id) AS logo_id,
    o.ad_orgtrx_id,
    o.ad_user_id,
    o.amountrefunded,
    o.amounttendered,
    o.c_bpartner_location_id,
    o.c_cashline_id,
    o.c_cashplanline_id,
    o.c_conversiontype_id,
    o.c_doctypetarget_id,
    o.copyfrom,
    o.c_payment_id,
    o.c_paymentterm_id,
    o.c_pos_id,
    o.dateacct,
    o.dateprinted,
    o.docaction,
    o.dropship_bpartner_id,
    o.dropship_location_id,
    o.dropship_user_id,
    o.freightamt,
    o.freightcostrule,
    o.isapproved,
    o.iscreditapproved,
    o.isdelivered,
    o.isdiscountprinted,
    o.isdropship,
    o.isinvoiced,
    o.ispayschedulevalid,
    o.isprinted,
    o.isselected,
    o.isselfservice,
    o.istransferred,
    o.link_order_id,
    o.m_freightcategory_id,
    o.ordertype,
    o.pay_bpartner_id,
    o.pay_location_id,
    o.paymentrule,
    o.posted,
    o.processed,
    o.processedon,
    o.promotioncode,
    o.ref_order_id,
    o.sendemail,
    o.user1_id,
    o.user2_id,
    wh.ad_org_id                     AS m_warehouse_ad_org_id,
    wh.description                   AS m_warehouse_description,
    wh.isactive                      AS m_warehouse_isactive,
    wh.isdisallownegativeinv,
    wh.isintransit,
    wh.m_warehousesource_id,
    wh.name                          AS m_warehouse_name,
    wh.replenishmentclass,
    wh.separator,
    wh.value                         AS m_warehouse_value,
    ptt.ad_org_id                    AS c_paymentterm_ad_org_id,
    pt.afterdelivery,
    ptt.description                  AS c_paymentterm_description,
    pt.discount,
    pt.discount2,
    pt.discountdays,
    pt.discountdays2,
    pt.fixmonthcutoff,
    pt.fixmonthday,
    pt.fixmonthoffset,
    pt.gracedays,
    ptt.isactive                     AS c_paymentterm_isactive,
    pt.isdefault,
    pt.isduefixed,
    pt.isnextbusinessday,
    pt.isvalid,
    pt.netday,
    pt.netdays,
    pt.paymenttermusage,
    pt.value                         AS m_paymentterm_value,
    bp.acqusitioncost                AS bp_acqusitioncost,
    bp.actuallifetimevalue           AS bp_actuallifetimevalue,
    bp.ad_language                   AS bp_ad_language,
    bp.ad_orgbp_id                   AS bp_ad_orgbp_id,
    bp.ad_org_id                     AS bp_ad_org_id,
    bp.bpartner_parent_id            AS bp_bpartner_parent_id,
    bp.c_bp_group_id                 AS bp_c_bp_group_id,
    bp.c_dunning_id                  AS bp_c_dunning_id,
    bp.c_greeting_id                 AS bp_c_greeting_id,
    bp.c_invoiceschedule_id          AS bp_c_invoiceschedule_id,
    bp.c_paymentterm_id              AS bp_c_paymentterm_id,
    bp.created                       AS bp_created,
    bp.createdby                     AS bp_createdby,
    bp.c_taxgroup_id                 AS bp_c_taxgroup_id,
    bp.deliveryrule                  AS bp_deliveryrule,
    bp.deliveryviarule               AS bp_deliveryviarule,
    bp.description                   AS bp_description,
    bp.dunninggrace                  AS bp_dunninggrace,
    bp.firstsale                     AS bp_firstsale,
    bp.flatdiscount                  AS bp_flatdiscount,
    bp.freightcostrule               AS bp_freightcostrule,
    bp.invoicerule                   AS bp_invoicerule,
    bp.isactive                      AS bp_isactive,
    bp.iscustomer                    AS bp_iscustomer,
    bp.isdiscountprinted             AS bp_isdiscountprinted,
    bp.isemployee                    AS bp_isemployee,
    bp.ismanufacturer                AS bp_ismanufacturer,
    bp.isonetime                     AS bp_isonetime,
    bp.ispotaxexempt                 AS bp_ispotaxexempt,
    bp.isprospect                    AS bp_isprospect,
    bp.issalesrep                    AS bp_issalesrep,
    bp.issummary                     AS bp_issummary,
    bp.istaxexempt                   AS bp_istaxexempt,
    bp.isvendor                      AS bp_isvendor,
    bp.logo_id                       AS bp_logo_id,
    bp.m_discountschema_id           AS bp_m_discountschema_id,
    bp.m_pricelist_id                AS bp_m_pricelist_id,
    bp.numberemployees               AS bp_numberemployees,
    bp.paymentrule                   AS bp_paymentrule,
    bp.paymentrulepo                 AS bp_paymentrulepo,
    bp.po_discountschema_id          AS bp_po_discountschema_id,
    bp.po_paymentterm_id             AS bp_po_paymentterm_id,
    bp.po_pricelist_id               AS bp_po_pricelist_id,
    bp.poreference                   AS bp_poreference,
    bp.potentiallifetimevalue        AS bp_potentiallifetimevalue,
    bp.rating                        AS bp_rating,
    bp.salesrep_id                   AS bp_salesrep_id,
    bp.salesvolume                   AS bp_salesvolume,
    bp.sendemail                     AS bp_sendemail,
    bp.shareofcustomer               AS bp_shareofcustomer,
    bp.shelflifeminpct               AS bp_shelflifeminpct,
    bp.so_creditlimit                AS bp_so_creditlimit,
    bp.socreditstatus                AS bp_socreditstatus,
    bp.so_creditused                 AS bp_so_creditused,
    bp.so_description                AS bp_so_description,
    bp.totalopenbalance              AS bp_totalopenbalance,
    bp.updated                       AS bp_updated,
    bp.updatedby                     AS bp_updatedby,
    bp.url                           AS bp_url,
    bpgt.ad_org_id                   AS c_greeting_ad_org_id,
    bpgt.isactive                    AS c_greeting_isactive,
    bpg.isfirstnameonly,
    bpgt.name                        AS c_greeting_name,
    bpl.ad_org_id                    AS bp_location_ad_org_id,
    bpl.c_bpartner_id                AS bp_location_c_bpartner_id,
    bpl.created                      AS bp_location_created,
    bpl.createdby                    AS bp_location_createdby,
    bpl.c_salesregion_id             AS bp_location_c_salesregion_id,
    bpl.fax                          AS bp_location_fax,
    bpl.isactive                     AS bp_location_isactive,
    bpl.isbillto                     AS bp_location_isbillto,
    bpl.isdn                         AS bp_location_isdn,
    bpl.ispayfrom                    AS bp_location_ispayfrom,
    bpl.isremitto                    AS bp_location_isremitto,
    bpl.isshipto                     AS bp_location_isshipto,
    bpl.name                         AS bp_location_name,
    bpl.phone                        AS bp_location_phone,
    bpl.phone2                       AS bp_location_phone2,
    bpl.updated                      AS bp_location_updated,
    bpl.updatedby                    AS bp_location_updatedby,
    l.address1,
    l.address2,
    l.address3,
    l.address4,
    l.ad_org_id                      AS c_location_ad_org_id,
    l.c_city_id,
    l.c_country_id,
    l.city,
    l.created                        AS c_location_created,
    l.createdby                      AS c_location_createdby,
    l.c_region_id,
    l.isactive                       AS c_location_isactive,
    l.regionname,
    l.updated                        AS c_location_updated,
    l.updatedby                      AS c_location_updatedby,
    bpc.ad_org_id                    AS ad_user_ad_org_id,
    bpc.ad_orgtrx_id                 AS ad_user_ad_orgtrx_id,
    bpc.birthday                     AS ad_user_ad_birthday,
    bpc.c_bpartner_id                AS ad_user_c_bpartner_id,
    bpc.c_bpartner_location_id       AS ad_user_c_bpartner_location_id,
    bpc.c_greeting_id                AS ad_user_c_greeting_id,
    bpc.comments                     AS ad_user_comments,
    bpc.created                      AS ad_user_created,
    bpc.createdby                    AS ad_user_createdby,
    bpc.description                  AS ad_user_description,
    bpc.email                        AS ad_user_email,
    bpc.fax                          AS ad_user_fax,
    bpc.isactive                     AS ad_user_isactive,
    bpc.lastcontact                  AS ad_user_lastcontact,
    bpc.lastresult                   AS ad_user_lastresult,
    bpc.phone2                       AS ad_user_phone2,
    bpc.supervisor_id                AS ad_user_supervisor_id,
    bpc.updated                      AS ad_user_updated,
    bpc.updatedby                    AS ad_user_updatedby,
    bpc.value                        AS ad_user_value,
    bpcgt.ad_org_id                  AS c_user_greeting_ad_org_id,
    bpcgt.isactive                   AS c_user_greeting_isactive,
    bpcg.isfirstnameonly             AS c_user_greeting_isfnameonly,
    bpcgt.name                       AS c_user_greeting_name,
    oi.ad_org_id                     AS ad_orginfo_ad_org_id,
    oi.ad_orgtype_id,
    oi.c_calendar_id,
    oi.created                       AS ad_orginfo_created,
    oi.createdby                     AS ad_orginfo_createdby,
    oi.dropship_warehouse_id,
    oi.duns                          AS ad_orginfo_duns,
    oi.email                         AS ad_orginfo_email,
    oi.fax                           AS ad_orginfo_fax,
    oi.isactive                      AS ad_orginfo_isactive,
    oi.m_warehouse_id                AS ad_orginfo_m_warehouse_id,
    oi.parent_org_id,
    oi.phone                         AS ad_orginfo_phone,
    oi.phone2                        AS ad_orginfo_phone2,
    oi.receiptfootermsg,
    oi.supervisor_id,
    oi.updated                       AS ad_orginfo_updated,
    oi.updatedby                     AS ad_orginfo_updatedby,
    u.ad_org_id                      AS salesrep_ad_org_id,
    u.ad_orgtrx_id                   AS salesrep_ad_orgtrx_id,
    u.birthday                       AS salesrep_ad_birthday,
    u.c_bpartner_id                  AS salesrep_c_bpartner_id,
    u.c_bpartner_location_id         AS salesrep_c_bp_location_id,
    u.c_greeting_id                  AS salesrep_c_greeting_id,
    u.comments                       AS salesrep_comments,
    u.created                        AS salesrep_created,
    u.createdby                      AS salesrep_createdby,
    u.description                    AS salesrep_description,
    u.email                          AS salesrep_email,
    u.fax                            AS salesrep_fax,
    u.isactive                       AS salesrep_isactive,
    u.lastcontact                    AS salesrep_lastcontact,
    u.lastresult                     AS salesrep_lastresult,
    u.phone                          AS salesrep_phone,
    u.phone2                         AS salesrep_phone2,
    u.supervisor_id                  AS salesrep_supervisor_id,
    u.title                          AS salesrep_title,
    u.updated                        AS salesrep_updated,
    u.updatedby                      AS salesrep_updatedby,
    u.value                          AS salesrep_value,
    ubp.acqusitioncost               AS salesrep_bp_acqusitioncost,
    ubp.actuallifetimevalue          AS salesrep_bp_actuallifetimeval,
    ubp.ad_language                  AS salesrep_bp_ad_language,
    ubp.ad_orgbp_id                  AS salesrep_bp_ad_orgbp_id,
    ubp.ad_org_id                    AS salesrep_bp_ad_org_id,
    ubp.bpartner_parent_id           AS salesrep_bp_bpartner_parent_id,
    ubp.c_bp_group_id                AS salesrep_bp_c_bp_group_id,
    ubp.c_dunning_id                 AS salesrep_bp_c_dunning_id,
    ubp.c_greeting_id                AS salesrep_bp_c_greeting_id,
    ubp.c_invoiceschedule_id         AS salesrep_bp_c_invoicesched_id,
    ubp.c_paymentterm_id             AS salesrep_bp_c_paymentterm_id,
    ubp.created                      AS salesrep_bp_created,
    ubp.createdby                    AS salesrep_bp_createdby,
    ubp.c_taxgroup_id                AS salesrep_bp_c_taxgroup_id,
    ubp.deliveryrule                 AS salesrep_bp_deliveryrule,
    ubp.deliveryviarule              AS salesrep_bp_deliveryviarule,
    ubp.description                  AS salesrep_bp_description,
    ubp.dunninggrace                 AS salesrep_bp_dunninggrace,
    ubp.duns                         AS salesrep_bp_duns,
    ubp.firstsale                    AS salesrep_bp_firstsale,
    ubp.flatdiscount                 AS salesrep_bp_flatdiscount,
    ubp.freightcostrule              AS salesrep_bp_freightcostrule,
    ubp.invoicerule                  AS salesrep_bp_invoicerule,
    ubp.isactive                     AS salesrep_bp_isactive,
    ubp.iscustomer                   AS salesrep_bp_iscustomer,
    ubp.isdiscountprinted            AS salesrep_bp_isdiscountprinted,
    ubp.isemployee                   AS salesrep_bp_isemployee,
    ubp.ismanufacturer               AS salesrep_bp_ismanufacturer,
    ubp.isonetime                    AS salesrep_bp_isonetime,
    ubp.ispotaxexempt                AS salesrep_bp_ispotaxexempt,
    ubp.isprospect                   AS salesrep_bp_isprospect,
    ubp.issalesrep                   AS salesrep_bp_issalesrep,
    ubp.issummary                    AS salesrep_bp_issummary,
    ubp.istaxexempt                  AS salesrep_bp_istaxexempt,
    ubp.isvendor                     AS salesrep_bp_isvendor,
    ubp.logo_id                      AS salesrep_bp_logo_id,
    ubp.m_discountschema_id          AS salesrep_bp_m_discountschm_id,
    ubp.m_pricelist_id               AS salesrep_bp_m_pricelist_id,
    ubp.naics                        AS salesrep_bp_naics,
    ubp.name2                        AS salesrep_bp_name2,
    ubp.numberemployees              AS salesrep_bp_numberemployees,
    ubp.paymentrule                  AS salesrep_bp_paymentrule,
    ubp.paymentrulepo                AS salesrep_bp_paymentrulepo,
    ubp.po_discountschema_id         AS salesrep_bp_po_discountsch_id,
    ubp.po_paymentterm_id            AS salesrep_bp_po_paymentterm_id,
    ubp.po_pricelist_id              AS salesrep_bp_po_pricelist_id,
    ubp.poreference                  AS salesrep_bp_poreference,
    ubp.potentiallifetimevalue       AS salesrep_bp_potentiallifetime,
    ubp.rating                       AS salesrep_bp_rating,
    ubp.referenceno                  AS salesrep_bp_referenceno,
    ubp.salesrep_id                  AS salesrep_bp_salesrep_id,
    ubp.salesvolume                  AS salesrep_bp_salesvolume,
    ubp.sendemail                    AS salesrep_bp_sendemail,
    ubp.shareofcustomer              AS salesrep_bp_shareofcustomer,
    ubp.shelflifeminpct              AS salesrep_bp_shelflifeminpct,
    ubp.so_creditlimit               AS salesrep_bp_so_creditlimit,
    ubp.socreditstatus               AS salesrep_bp_socreditstatus,
    ubp.so_creditused                AS salesrep_bp_so_creditused,
    ubp.so_description               AS salesrep_bp_so_description,
    ubp.taxid                        AS salesrep_bp_taxid,
    ubp.totalopenbalance             AS salesrep_bp_totalopenbalance,
    ubp.updated                      AS salesrep_bp_updated,
    ubp.updatedby                    AS salesrep_bp_updatedby,
    ubp.url                          AS salesrep_bp_url,
    ubp.value                        AS salesrep_bp_value,
    bbp.acqusitioncost               AS bill_bp_acqusitioncost,
    bbp.actuallifetimevalue          AS bill_bp_actuallifetimevalue,
    bbp.ad_language                  AS bill_bp_ad_language,
    bbp.ad_orgbp_id                  AS bill_bp_ad_orgbp_id,
    bbp.ad_org_id                    AS bill_bp_ad_org_id,
    bbp.bpartner_parent_id           AS bill_bp_bpartner_parent_id,
    bbp.c_bp_group_id                AS bill_bp_c_bp_group_id,
    bbp.c_dunning_id                 AS bill_bp_c_dunning_id,
    bbp.c_greeting_id                AS bill_bp_c_greeting_id,
    bbp.c_invoiceschedule_id         AS bill_bp_c_invoiceschedule_id,
    bbp.c_paymentterm_id             AS bill_bp_c_paymentterm_id,
    bbp.created                      AS bill_bp_created,
    bbp.createdby                    AS bill_bp_createdby,
    bbp.c_taxgroup_id                AS bill_bp_c_taxgroup_id,
    bbp.deliveryrule                 AS bill_bp_deliveryrule,
    bbp.deliveryviarule              AS bill_bp_deliveryviarule,
    bbp.description                  AS bill_bp_description,
    bbp.dunninggrace                 AS bill_bp_dunninggrace,
    bbp.duns                         AS bill_bp_duns,
    bbp.firstsale                    AS bill_bp_firstsale,
    bbp.flatdiscount                 AS bill_bp_flatdiscount,
    bbp.freightcostrule              AS bill_bp_freightcostrule,
    bbp.invoicerule                  AS bill_bp_invoicerule,
    bbp.isactive                     AS bill_bp_isactive,
    bbp.iscustomer                   AS bill_bp_iscustomer,
    bbp.isdiscountprinted            AS bill_bp_isdiscountprinted,
    bbp.isemployee                   AS bill_bp_isemployee,
    bbp.ismanufacturer               AS bill_bp_ismanufacturer,
    bbp.isonetime                    AS bill_bp_isonetime,
    bbp.ispotaxexempt                AS bill_bp_ispotaxexempt,
    bbp.isprospect                   AS bill_bp_isprospect,
    bbp.issalesrep                   AS bill_bp_issalesrep,
    bbp.issummary                    AS bill_bp_issummary,
    bbp.istaxexempt                  AS bill_bp_istaxexempt,
    bbp.isvendor                     AS bill_bp_isvendor,
    bbp.logo_id                      AS bill_bp_logo_id,
    bbp.m_discountschema_id          AS bill_bp_m_discountschema_id,
    bbp.m_pricelist_id               AS bill_bp_m_pricelist_id,
    bbp.naics                        AS bill_bp_naics,
    bbp.numberemployees              AS bill_bp_numberemployees,
    bbp.paymentrule                  AS bill_bp_paymentrule,
    bbp.paymentrulepo                AS bill_bp_paymentrulepo,
    bbp.po_discountschema_id         AS bill_bp_po_discountschema_id,
    bbp.po_paymentterm_id            AS bill_bp_po_paymentterm_id,
    bbp.po_pricelist_id              AS bill_bp_po_pricelist_id,
    bbp.poreference                  AS bill_bp_poreference,
    bbp.potentiallifetimevalue       AS bill_bp_potentiallifetimevalue,
    bbp.rating                       AS bill_bp_rating,
    bbp.referenceno                  AS bill_bp_referenceno,
    bbp.salesrep_id                  AS bill_bp_salesrep_id,
    bbp.salesvolume                  AS bill_bp_salesvolume,
    bbp.sendemail                    AS bill_bp_sendemail,
    bbp.shareofcustomer              AS bill_bp_shareofcustomer,
    bbp.shelflifeminpct              AS bill_bp_shelflifeminpct,
    bbp.so_creditlimit               AS bill_bp_so_creditlimit,
    bbp.socreditstatus               AS bill_bp_socreditstatus,
    bbp.so_creditused                AS bill_bp_so_creditused,
    bbp.so_description               AS bill_bp_so_description,
    bbp.totalopenbalance             AS bill_bp_totalopenbalance,
    bbp.updated                      AS bill_bp_updated,
    bbp.updatedby                    AS bill_bp_updatedby,
    bbp.url                          AS bill_bp_url,
    bbpl.ad_org_id                   AS bill_bp_location_ad_org_id,
    bbpl.c_bpartner_id               AS bill_bp_location_c_bpartner_id,
    bbpl.created                     AS bill_bp_location_created,
    bbpl.createdby                   AS bill_bp_location_createdby,
    bbpl.c_salesregion_id            AS bill_bp_location_c_salesreg_id,
    bbpl.fax                         AS bill_bp_location_fax,
    bbpl.isactive                    AS bill_bp_location_isactive,
    bbpl.isbillto                    AS bill_bp_location_isbillto,
    bbpl.isdn                        AS bill_bp_location_isdn,
    bbpl.ispayfrom                   AS bill_bp_location_ispayfrom,
    bbpl.isremitto                   AS bill_bp_location_isremitto,
    bbpl.isshipto                    AS bill_bp_location_isshipto,
    bbpl.name                        AS bill_bp_location_name,
    bbpl.phone                       AS bill_bp_location_phone,
    bbpl.phone2                      AS bill_bp_location_phone2,
    bbpl.updated                     AS bill_bp_location_updated,
    bbpl.updatedby                   AS bill_bp_location_updatedby,
    bbpc.ad_org_id                   AS bill_user_ad_org_id,
    bbpc.ad_orgtrx_id                AS bill_user_ad_orgtrx_id,
    bbpc.birthday                    AS bill_user_ad_birthday,
    bbpc.c_bpartner_id               AS bill_user_c_bpartner_id,
    bbpc.c_bpartner_location_id      AS bill_user_c_bp_location_id,
    bbpc.c_greeting_id               AS bill_user_c_greeting_id,
    bbpc.comments                    AS bill_user_comments,
    bbpc.created                     AS bill_user_created,
    bbpc.createdby                   AS bill_user_createdby,
    bbpc.description                 AS bill_user_description,
    bbpc.email                       AS bill_user_email,
    bbpc.fax                         AS bill_user_fax,
    bbpc.isactive                    AS bill_user_isactive,
    bbpc.lastcontact                 AS bill_user_lastcontact,
    bbpc.lastresult                  AS bill_user_lastresult,
    bbpc.phone2                      AS bill_user_phone2,
    bbpc.supervisor_id               AS bill_user_supervisor_id,
    bbpc.updated                     AS bill_user_updated,
    bbpc.updatedby                   AS bill_user_updatedby,
    bbpc.value                       AS bill_user_value,
    cur.cursymbol,
    cur.description                  AS cur_description
FROM c_order o 
        JOIN c_doctype_trl dt 
        ON o.c_doctype_id = dt.c_doctype_id 
        JOIN m_warehouse wh 
        ON o.m_warehouse_id = wh.m_warehouse_id 
        JOIN c_paymentterm pt 
        ON o.c_paymentterm_id = pt.c_paymentterm_id 
        JOIN c_paymentterm_trl ptt 
        ON o.c_paymentterm_id = ptt.c_paymentterm_id AND dt.ad_language = ptt.ad_language 
        JOIN c_bpartner bp 
        ON o.c_bpartner_id = bp.c_bpartner_id 
        LEFT JOIN c_greeting bpg 
        ON bp.c_greeting_id = bpg.c_greeting_id 
        LEFT JOIN c_greeting_trl bpgt 
        ON bp.c_greeting_id = bpgt.c_greeting_id AND dt.ad_language = bpgt.ad_language 
        JOIN c_bpartner_location bpl 
        ON o.c_bpartner_location_id = bpl.c_bpartner_location_id 
        JOIN c_location l 
        ON bpl.c_location_id = l.c_location_id 
        LEFT JOIN ad_user bpc 
        ON o.ad_user_id = bpc.ad_user_id 
        LEFT JOIN c_greeting bpcg 
        ON bpc.c_greeting_id = bpcg.c_greeting_id 
        LEFT JOIN c_greeting_trl bpcgt 
        ON bpc.c_greeting_id = bpcgt.c_greeting_id AND dt.ad_language = bpcgt.ad_language 
        JOIN ad_orginfo oi 
        ON o.ad_org_id = oi.ad_org_id 
        JOIN ad_clientinfo ci 
        ON o.ad_client_id = ci.ad_client_id 
        LEFT JOIN ad_user u 
        ON o.salesrep_id = u.ad_user_id 
        LEFT JOIN c_bpartner ubp 
        ON u.c_bpartner_id = ubp.c_bpartner_id 
        JOIN c_bpartner bbp 
        ON o.bill_bpartner_id = bbp.c_bpartner_id 
        JOIN c_bpartner_location bbpl 
        ON o.bill_location_id = bbpl.c_bpartner_location_id 
        LEFT JOIN ad_user bbpc 
        ON o.bill_user_id = bbpc.ad_user_id
        LEFT JOIN c_currency_trl cur
        ON o.c_currency_id = cur.c_currency_id AND dt.ad_language = cur.ad_language 
;

SELECT register_migration_script('201304131454_IDEMPIERE-794.sql') FROM dual
;

