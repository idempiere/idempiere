-- Nov 27, 2013 4:57:14 PM CET
-- IDEMPIERE-1521
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202630,'c7849ef7-da73-46b6-8f8a-448c3ffedccc',0,'DatabaseViewDrop',TO_TIMESTAMP('2013-11-27 16:57:13','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','Drop view','Drop view',TO_TIMESTAMP('2013-11-27 16:57:13','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Nov 27, 2013 4:58:14 PM CET
INSERT INTO AD_Process (AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Process_UU,AccessLevel,Classname,CopyFromProcess,Created,CreatedBy,EntityType,IsActive,IsBetaFunctionality,IsDirectPrint,IsReport,IsServerProcess,Name,ShowHelp,Statistic_Count,Statistic_Seconds,Updated,UpdatedBy,Value) VALUES (0,0,200066,'8d781c31-93a6-435d-a9c3-eb393d1cf2f3','4','org.compiere.process.DatabaseViewDrop','N',TO_TIMESTAMP('2013-11-27 16:58:14','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','N','N','N','N','Drop view','Y',0,0,TO_TIMESTAMP('2013-11-27 16:58:14','YYYY-MM-DD HH24:MI:SS'),0,'AD_ViewComponent Drop')
;

-- Nov 27, 2013 4:58:31 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210892,'2c8da8e6-1c75-4b7b-8e39-7e28c3399979',202630,0,200066,28,100,'DatabaseViewDrop',TO_TIMESTAMP('2013-11-27 16:58:30','YYYY-MM-DD HH24:MI:SS'),0,'D','N',1,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','N','Y','Drop view',0,0,TO_TIMESTAMP('2013-11-27 16:58:30','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Nov 27, 2013 4:58:33 PM CET
ALTER TABLE AD_Table ADD COLUMN DatabaseViewDrop CHAR(1) DEFAULT NULL 
;

-- Nov 27, 2013 4:59:24 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210892,202541,'e6c3fc02-67cc-4dec-b5c1-c3fe0b7fe717',0,100,2,TO_TIMESTAMP('2013-11-27 16:59:23','YYYY-MM-DD HH24:MI:SS'),0,1,'D','Y','Y','Y','N','N','N','N','N','Drop view',210,TO_TIMESTAMP('2013-11-27 16:59:23','YYYY-MM-DD HH24:MI:SS'),0,2)
;

-- Nov 27, 2013 4:59:38 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, XPosition=5,Updated=TO_TIMESTAMP('2013-11-27 16:59:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=202541
;

-- Nov 27, 2013 4:59:56 PM CET
UPDATE AD_Field SET DisplayLogic='@IsView@=''Y''',Updated=TO_TIMESTAMP('2013-11-27 16:59:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=202541
;

SELECT register_migration_script('201311271704_IDEMPIERE-1521.sql') FROM dual
;
