-- May 25, 2012 11:19:49 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 11:19:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50096
;

-- May 25, 2012 11:20:25 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 11:20:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50084
;

-- May 25, 2012 11:21:02 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 11:21:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50085
;

-- May 25, 2012 11:21:38 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 11:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50097
;

-- May 25, 2012 11:22:04 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','Description','VARCHAR(1000)',null,'NULL')
;

-- May 25, 2012 11:22:04 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','Description',null,'NULL',null)
;

-- May 25, 2012 11:22:52 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','EMail','VARCHAR(30)',null,'NULL')
;

-- May 25, 2012 11:22:52 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','EMail',null,'NULL',null)
;

-- May 25, 2012 11:22:59 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','File_Directory','VARCHAR(255)',null,'NULL')
;

-- May 25, 2012 11:22:59 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','File_Directory',null,'NULL',null)
;

-- May 25, 2012 11:23:12 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','Instructions','VARCHAR(1000)',null,'NULL')
;

-- May 25, 2012 11:23:12 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','Instructions',null,'NULL',null)
;

-- May 25, 2012 11:23:52 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 11:23:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50088
;

-- May 25, 2012 11:23:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','ReleaseNo','VARCHAR(20)',null,'NULL')
;

-- May 25, 2012 11:23:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','ReleaseNo',null,'NULL',null)
;

-- May 25, 2012 11:26:32 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (50005,'U',1,'N','N','N',0,'The Date From indicates the starting date of a range.','Starting date for a range','Date From',7,15,'N',1581,'fcecd481-35b0-4aaa-a9b5-78b08cec99b9','Y','N','DateFrom','Y','Y','N',100,TO_TIMESTAMP('2012-05-25 11:26:19','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2012-05-25 11:26:19','YYYY-MM-DD HH24:MI:SS'),100,200166)
;

-- May 25, 2012 11:26:32 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200166 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 25, 2012 11:27:16 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-05-25 11:27:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200166
;

-- May 25, 2012 11:29:38 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Window SET Name='Pack Out', Description='Create 2pack package',Updated=TO_TIMESTAMP('2012-05-25 11:29:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=50003
;

-- May 25, 2012 11:29:38 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=50003
;

-- May 25, 2012 11:29:38 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Menu SET Name='Pack Out', IsActive='Y', Description='Create 2pack package',Updated=TO_TIMESTAMP('2012-05-25 11:29:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=50004
;

-- May 25, 2012 11:29:38 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=50004
;

-- May 25, 2012 11:32:56 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50077
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50076
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50075
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50084
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50080
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50081
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50073
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50079
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50078
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=50074
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=50082
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=50083
;

-- May 25, 2012 11:32:57 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=50085
;

-- May 25, 2012 11:33:23 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,SeqNo,Help,IsActive) VALUES ('Starting date for a range',200118,'Y','N',200166,'N','Y','N','545534d7-5a66-45d1-bf55-5947a6aaad31','D',100,'Date From',100,0,TO_TIMESTAMP('2012-05-25 11:33:20','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-05-25 11:33:20','YYYY-MM-DD HH24:MI:SS'),0,'N',50005,0,'N',90,'The Date From indicates the starting date of a range.','Y')
;

-- May 25, 2012 11:33:23 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200118 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 25, 2012 11:33:28 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200118
;

-- May 25, 2012 11:33:28 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=50085
;

-- May 25, 2012 11:33:47 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 11:33:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50089
;

-- May 25, 2012 11:33:52 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','Version','VARCHAR(20)',null,'NULL')
;

-- May 25, 2012 11:33:52 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','Version',null,'NULL',null)
;

-- May 25, 2012 11:34:36 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 11:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50090
;

-- May 25, 2012 11:34:39 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','UserName','VARCHAR(30)',null,'NULL')
;

-- May 25, 2012 11:34:39 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp','UserName',null,'NULL',null)
;

-- May 25, 2012 11:38:17 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 11:38:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50114
;

-- May 25, 2012 11:38:21 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp_detail','Description','VARCHAR(1000)',null,'NULL')
;

-- May 25, 2012 11:38:21 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_exp_detail','Description',null,'NULL',null)
;

-- May 25, 2012 2:37:53 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
ALTER TABLE AD_Package_Exp ADD COLUMN DateFrom TIMESTAMP DEFAULT NULL 
;

-- May 25, 2012 3:55:40 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MAX(Line),0)+10 AS DefaultValue FROM AD_Package_Exp_Detail WHERE AD_Package_Exp_ID=@AD_Package_Exp_ID@',Updated=TO_TIMESTAMP('2012-05-25 15:55:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50128
;

-- May 25, 2012 3:56:15 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Ref_List SET IsActive='N',Updated=TO_TIMESTAMP('2012-05-25 15:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=50020
;

-- May 25, 2012 3:59:25 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 15:59:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50170
;

-- May 25, 2012 3:59:29 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_imp_proc','AD_Package_Dir','VARCHAR(255)',null,'NULL')
;

-- May 25, 2012 3:59:51 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 15:59:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50172
;

-- May 25, 2012 3:59:54 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_imp_proc','AD_Package_Source','VARCHAR(255)',null,'NULL')
;

-- May 25, 2012 4:00:51 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET DefaultValue='''File''',Updated=TO_TIMESTAMP('2012-05-25 16:00:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50173
;

-- May 25, 2012 4:11:51 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('DateProcessed','Date Processed','Date Processed','beba52cc-977e-4f2f-b77e-eb9582bd09c0','D',0,200035,TO_TIMESTAMP('2012-05-25 16:11:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_TIMESTAMP('2012-05-25 16:11:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- May 25, 2012 4:11:51 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200035 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- May 25, 2012 4:12:59 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (50008,'D',1,'N','N','N',0,'Date Processed',7,16,'N',200035,'6a425741-bf77-4d17-8fd0-771e6afd9390','Y','N','DateProcessed','Y','N','N',100,TO_TIMESTAMP('2012-05-25 16:12:58','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2012-05-25 16:12:58','YYYY-MM-DD HH24:MI:SS'),100,200167)
;

-- May 25, 2012 4:12:59 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200167 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 25, 2012 4:13:09 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
ALTER TABLE AD_Package_Imp_Proc ADD COLUMN DateProcessed TIMESTAMP DEFAULT NULL 
;

-- May 25, 2012 4:15:48 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50151
;

-- May 25, 2012 4:15:48 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50150
;

-- May 25, 2012 4:15:48 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50149
;

-- May 25, 2012 4:15:48 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=50152
;

-- May 25, 2012 4:15:48 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=50153
;

-- May 25, 2012 4:16:46 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,SeqNo,Help,IsActive) VALUES ('Date this record was created',200119,'Y','N',50174,'N','Y','Y','c5ad7875-81a3-4b18-a2c5-39949dd1b031','U',100,'Created',100,0,TO_TIMESTAMP('2012-05-25 16:16:39','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-05-25 16:16:39','YYYY-MM-DD HH24:MI:SS'),0,'N',50008,0,'N',50,'The Created field indicates the date that this record was created.','Y')
;

-- May 25, 2012 4:16:46 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200119 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 25, 2012 4:16:53 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET EntityType='D',Updated=TO_TIMESTAMP('2012-05-25 16:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200119
;

-- May 25, 2012 4:17:59 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field (AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,SeqNo,IsActive) VALUES (200120,'Y','N',200167,'N','Y','Y','073f64b7-c535-4812-8346-3fe40d5e8e1a','D',100,'Date Processed',100,0,TO_TIMESTAMP('2012-05-25 16:17:47','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-05-25 16:17:47','YYYY-MM-DD HH24:MI:SS'),0,'N',50008,0,'N',60,'Y')
;

-- May 25, 2012 4:17:59 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200120 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 25, 2012 4:20:38 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (50008,'U',1,'N','N','N',0,'Process Message',2000,14,'N',2068,'538030f1-d937-4a37-b573-466560fba693','Y','N','P_Msg','Y','N','N',100,TO_TIMESTAMP('2012-05-25 16:20:37','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2012-05-25 16:20:37','YYYY-MM-DD HH24:MI:SS'),100,200168)
;

-- May 25, 2012 4:20:38 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200168 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 25, 2012 4:20:52 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
ALTER TABLE AD_Package_Imp_Proc ADD COLUMN P_Msg VARCHAR(2000) DEFAULT NULL 
;

-- May 25, 2012 4:21:40 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-05-25 16:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200168
;

-- May 25, 2012 4:22:08 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field (AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,SeqNo,IsActive) VALUES (200121,'Y','N',200168,'N','Y','Y','03d4a015-1245-40e8-abde-46b696034059','D',100,'Process Message',100,0,TO_TIMESTAMP('2012-05-25 16:22:07','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-05-25 16:22:07','YYYY-MM-DD HH24:MI:SS'),0,'N',50008,255,'N',70,'Y')
;

-- May 25, 2012 4:22:08 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200121 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 25, 2012 4:25:50 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (50008,'U',1,'Y','N','Y',0,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name',60,10,'N',469,'9165c781-852e-4479-9a1f-7976c560b5ec','Y','N','Name','Y','Y','N',100,TO_TIMESTAMP('2012-05-25 16:25:49','YYYY-MM-DD HH24:MI:SS'),'N','Y','N','N',0,0,'Y',TO_TIMESTAMP('2012-05-25 16:25:49','YYYY-MM-DD HH24:MI:SS'),100,200169)
;

-- May 25, 2012 4:25:50 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200169 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- May 25, 2012 4:25:56 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
-- ALTER TABLE AD_Package_Imp_Proc ADD COLUMN Name VARCHAR(60) NOT NULL
-- Changed to cover the case where the AD_Package_Imp_Proc table has rows as noted by Daniel Tamn

-- Aug 19, 2012 10:42:12 AM COT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
ALTER TABLE AD_Package_Imp_Proc ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

UPDATE AD_Package_Imp_Proc SET Name='Default';

-- Aug 19, 2012 10:42:29 AM COT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_imp_proc','Name','VARCHAR(60)',null,null)
;

-- Aug 19, 2012 10:42:29 AM COT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_imp_proc','Name',null,'NOT NULL',null)
;

-- May 25, 2012 4:26:38 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-05-25 16:26:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200169
;

-- May 25, 2012 4:26:58 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,SeqNo,Help,IsActive) VALUES ('Alphanumeric identifier of the entity',200122,'Y','N',200169,'N','Y','N','ac8db584-463f-48e4-915e-18a77fa6e4e4','D',100,'Name',100,0,TO_TIMESTAMP('2012-05-25 16:26:56','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-05-25 16:26:56','YYYY-MM-DD HH24:MI:SS'),0,'N',50008,40,'N',80,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Y')
;

-- May 25, 2012 4:26:58 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200122 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- May 25, 2012 4:27:52 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200122
;

-- May 25, 2012 4:27:52 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200119
;

-- May 25, 2012 4:27:52 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=50152
;

-- May 25, 2012 4:27:52 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=50153
;

-- May 25, 2012 4:28:52 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2012-05-25 16:28:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50008
;

-- May 25, 2012 4:30:31 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET DisplayLogic='@AD_Client_ID@=0',Updated=TO_TIMESTAMP('2012-05-25 16:30:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50152
;

-- May 25, 2012 4:32:14 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2012-05-25 16:32:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50005
;

-- May 25, 2012 4:39:43 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2012-05-25 16:39:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50007
;

-- May 25, 2012 4:40:30 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2012-05-25 16:40:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50006
;

-- May 25, 2012 4:41:33 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET AccessLevel='6', Name='Package Import Log',Updated=TO_TIMESTAMP('2012-05-25 16:41:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50003
;

-- May 25, 2012 4:41:33 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=50003
;

-- May 25, 2012 4:42:34 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2012-05-25 16:42:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50002
;

-- May 25, 2012 4:45:16 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2012-05-25 16:45:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50004
;

-- May 25, 2012 4:45:32 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2012-05-25 16:45:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50001
;

-- May 25, 2012 5:02:20 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-05-25 17:02:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50058
;

-- May 25, 2012 5:02:24 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_imp','Description','VARCHAR(1000)',null,'NULL')
;

-- May 25, 2012 5:02:24 PM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
INSERT INTO t_alter_column values('ad_package_imp','Description',null,'NULL',null)
;

-- May 28, 2012 11:33:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Element SET Name='Package Status', PrintName='Package Status',Updated=TO_TIMESTAMP('2012-05-28 11:33:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50006
;

-- May 28, 2012 11:33:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=50006
;

-- May 28, 2012 11:33:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET ColumnName='PK_Status', Name='Package Status', Description=NULL, Help=NULL WHERE AD_Element_ID=50006
;

-- May 28, 2012 11:33:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Process_Para SET ColumnName='PK_Status', Name='Package Status', Description=NULL, Help=NULL, AD_Element_ID=50006 WHERE UPPER(ColumnName)='PK_STATUS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- May 28, 2012 11:33:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Process_Para SET ColumnName='PK_Status', Name='Package Status', Description=NULL, Help=NULL WHERE AD_Element_ID=50006 AND IsCentrallyMaintained='Y'
;

-- May 28, 2012 11:33:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET Name='Package Status', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50006) AND IsCentrallyMaintained='Y'
;

-- May 28, 2012 11:33:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_PrintFormatItem SET PrintName='Package Status', Name='Package Status' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=50006)
;

-- May 28, 2012 11:34:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50044
;

-- May 28, 2012 11:34:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50046
;

-- May 28, 2012 11:34:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50047
;

-- May 28, 2012 11:34:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50048
;

-- May 28, 2012 11:34:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50049
;

-- May 28, 2012 11:34:27 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=50032
;

-- May 28, 2012 11:34:28 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=50041
;

-- May 28, 2012 11:34:28 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=50042
;

-- May 28, 2012 11:34:28 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=50043
;

-- May 28, 2012 11:34:28 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=50045
;

-- May 28, 2012 11:35:12 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET Name='Pack Out',Updated=TO_TIMESTAMP('2012-05-28 11:35:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50005
;

-- May 28, 2012 11:35:12 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=50005
;

-- May 28, 2012 11:35:21 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET Name='Pack Out', IsUpdateable='N',Updated=TO_TIMESTAMP('2012-05-28 11:35:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50080
;

-- May 28, 2012 11:35:21 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=50080
;

-- May 28, 2012 11:35:21 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET Name='Pack Out', Description=NULL, Help=NULL WHERE AD_Column_ID=50080 AND IsCentrallyMaintained='Y'
;

-- May 28, 2012 11:35:26 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column SET Name='Pack Out UUID',Updated=TO_TIMESTAMP('2012-05-28 11:35:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=60443
;

-- May 28, 2012 11:35:26 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=60443
;

-- May 28, 2012 11:35:26 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Field SET Name='Pack Out UUID', Description=NULL, Help=NULL WHERE AD_Column_ID=60443 AND IsCentrallyMaintained='Y'
;

-- May 28, 2012 11:35:53 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Window SET Name='Pack In',Updated=TO_TIMESTAMP('2012-05-28 11:35:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=50005
;

-- May 28, 2012 11:35:53 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=50005
;

-- May 28, 2012 11:35:53 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Menu SET Name='Pack In', Description='Imports a package', IsActive='Y',Updated=TO_TIMESTAMP('2012-05-28 11:35:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=50006
;

-- May 28, 2012 11:35:53 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=50006
;

-- May 28, 2012 11:36:34 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2012-05-28 11:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50003
;

-- May 28, 2012 11:36:39 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2012-05-28 11:36:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50004
;

-- May 28, 2012 11:36:43 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2012-05-28 11:36:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50002
;

-- May 28, 2012 11:37:02 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Tab SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-05-28 11:37:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50002
;

-- May 28, 2012 11:37:05 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Tab SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-05-28 11:37:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50004
;

-- May 28, 2012 11:37:09 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Tab SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2012-05-28 11:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50003
;

-- May 28, 2012 11:45:59 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
DELETE FROM AD_Menu_Trl WHERE AD_Menu_ID=50005
;

-- May 28, 2012 11:45:59 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
DELETE FROM AD_Menu WHERE AD_Menu_ID=50005
;

-- May 28, 2012 11:45:59 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
DELETE FROM AD_TreeNodeMM WHERE Node_ID=50005 AND EXISTS (SELECT * FROM AD_Tree t WHERE t.AD_Tree_ID=AD_TreeNodeMM.AD_Tree_ID AND t.TreeType='MM')
;

-- May 28, 2012 11:47:17 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Window SET IsActive='N',Updated=TO_TIMESTAMP('2012-05-28 11:47:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=50004
;

-- May 28, 2012 11:47:39 AM MYT
-- IDEMPIERE-254 2Pack Stabilization and Enhancement
UPDATE AD_Table SET IsActive='N',Updated=TO_TIMESTAMP('2012-05-28 11:47:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=50007
;

UPDATE AD_System
  SET LastMigrationScriptApplied='841_IDEMPIERE-254.sql'
WHERE LastMigrationScriptApplied<'841_IDEMPIERE-254.sql'
   OR LastMigrationScriptApplied IS NULL
;

