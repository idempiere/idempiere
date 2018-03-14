-- Nov 20, 2013 10:07:29 AM CET
-- IDEMPIERE-1520 Ability to delete an index within AD
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202628,'e7399236-2b73-40af-a72e-16158c2df11f',0,'TableIndexDrop',TO_TIMESTAMP('2013-11-20 10:07:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Drop table index','Drop table index',TO_TIMESTAMP('2013-11-20 10:07:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 20, 2013 10:08:06 AM CET
INSERT INTO AD_Process (AD_Client_ID,AD_Org_ID,AD_Process_ID,AD_Process_UU,AccessLevel,Classname,CopyFromProcess,Created,CreatedBy,EntityType,IsActive,IsBetaFunctionality,IsDirectPrint,IsReport,IsServerProcess,Name,ShowHelp,Statistic_Count,Statistic_Seconds,Updated,UpdatedBy,Value) VALUES (0,0,200065,'e93b81bb-e3a1-4fb4-b825-39ebfbbe212f','4','org.compiere.process.TableIndexDrop','N',TO_TIMESTAMP('2013-11-20 10:08:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','N','N','N','N','Drop Table Index','Y',0,0,TO_TIMESTAMP('2013-11-20 10:08:06','YYYY-MM-DD HH24:MI:SS'),100,'TableIndexDrop')
;

-- Nov 20, 2013 10:08:30 AM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210889,'5a7e6f14-4e5f-4051-ae2d-88cc6642fa24',202628,0,200065,28,200085,'TableIndexDrop',TO_TIMESTAMP('2013-11-20 10:08:30','YYYY-MM-DD HH24:MI:SS'),100,'D','N',1,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','N','Y','Drop table index',0,0,TO_TIMESTAMP('2013-11-20 10:08:30','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Nov 20, 2013 10:08:33 AM CET
ALTER TABLE AD_TableIndex ADD COLUMN TableIndexDrop CHAR(1) DEFAULT NULL 
;

-- Nov 20, 2013 10:09:27 AM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210889,202535,'25be136d-efd6-4afc-8792-c47e3e0b53ef',0,200096,2,TO_TIMESTAMP('2013-11-20 10:09:26','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','Y','Y','N','N','N','N','N','Drop table index',130,TO_TIMESTAMP('2013-11-20 10:09:26','YYYY-MM-DD HH24:MI:SS'),100,2)
;

SELECT register_migration_script('201311201011_IDEMPIERE-1520.sql') FROM dual
;
