-- IDEMPIERE-4060 Implement change scheduler state at scheduler window
-- Oct 7, 2019, 5:15:42 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214058,0,'System Element','System Element enables the central maintenance of column description and help.','The System Element allows for the central maintenance of help, descriptions and terminology for a database column.',102,'AD_Element_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2019-10-07 17:15:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-07 17:15:41','YYYY-MM-DD HH24:MI:SS'),100,106,'Y','N','D','N','N','N','Y','403c387b-fc05-48d3-8bfa-4bff1d84ebe0','Y',0,'N','N','N','N')
;

-- Oct 7, 2019, 5:15:52 PM MYT
UPDATE AD_Column SET FKConstraintName='ADElement_ADReference', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-10-07 17:15:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214058
;

-- Oct 7, 2019, 5:15:52 PM MYT
ALTER TABLE AD_Reference ADD COLUMN AD_Element_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 7, 2019, 5:15:52 PM MYT
ALTER TABLE AD_Reference ADD CONSTRAINT ADElement_ADReference FOREIGN KEY (AD_Element_ID) REFERENCES ad_element(ad_element_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 7, 2019, 5:18:40 PM MYT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200137,'AD_Reference of AD_Element','S','(AD_Reference.AD_Element_ID IS NULL OR AD_Reference.AD_Element_ID=@AD_Element_ID:0@)',0,0,'Y',TO_TIMESTAMP('2019-10-07 17:18:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-07 17:18:39','YYYY-MM-DD HH24:MI:SS'),100,'D','30490e6b-25df-44ed-b12f-1f0c9858a9c4')
;

-- Oct 7, 2019, 5:21:29 PM MYT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=120, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-07 17:21:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54400
;

-- Oct 7, 2019, 5:21:38 PM MYT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=110, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-10-07 17:21:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=314
;

-- Oct 7, 2019, 5:23:39 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206184,'System Element','System Element enables the central maintenance of column description and help.','The System Element allows for the central maintenance of help, descriptions and terminology for a database column.',102,214058,'Y','@ValidationType@=''D''',0,100,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-07 17:23:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-07 17:23:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1f1ae42b-f779-4b83-bdcd-7c562f93821e','Y',100,4,2,1,'N','N','N')
;

-- Oct 7, 2019, 5:25:33 PM MYT
UPDATE AD_Column SET AD_Val_Rule_ID=200137,Updated=TO_TIMESTAMP('2019-10-07 17:25:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=226
;

-- Oct 7, 2019, 5:26:02 PM MYT
UPDATE AD_Column SET AD_Val_Rule_ID=200137,Updated=TO_TIMESTAMP('2019-10-07 17:26:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15011
;

-- Oct 7, 2019, 5:26:28 PM MYT
UPDATE AD_Column SET AD_Val_Rule_ID=200137,Updated=TO_TIMESTAMP('2019-10-07 17:26:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2827
;

-- Oct 7, 2019, 5:26:54 PM MYT
UPDATE AD_Column SET AD_Val_Rule_ID=200137,Updated=TO_TIMESTAMP('2019-10-07 17:26:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200959
;

-- Oct 7, 2019, 5:30:43 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203368,0,0,'Y',TO_TIMESTAMP('2019-10-07 17:30:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-07 17:30:42','YYYY-MM-DD HH24:MI:SS'),100,'SchedulerState','Scheduler State','State of this scheduler record (not scheduled, started or stopped)','Scheduler State','D','e266c453-619a-4ac8-bf2c-a3826cf5e3ea')
;

-- Oct 7, 2019, 5:34:10 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,AD_Element_ID) VALUES (200173,'Scheduler State','View and change the state of a scheduler','D',0,0,'Y',TO_TIMESTAMP('2019-10-07 17:34:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-07 17:34:09','YYYY-MM-DD HH24:MI:SS'),100,'D','N','6b31c7a3-12ee-40d6-ae12-e5d16dc854b4',203368)
;

-- Oct 7, 2019, 5:37:01 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,ColumnSQL,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214059,0,'Scheduler State','State of this scheduler record (not scheduled, started or stopped)',688,'SchedulerState',10,'N','N','N','N','N',0,'N',200173,0,0,'Y',TO_TIMESTAMP('2019-10-07 17:37:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-07 17:37:00','YYYY-MM-DD HH24:MI:SS'),100,203368,'N','N','D','N','N','AD_Scheduler_ID','N','N','43da28ea-8c13-4c0a-a61c-c6a27311a986','N',0,'N','N','N','N')
;

-- Oct 7, 2019, 5:38:37 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206185,'Scheduler State','State of this scheduler record (not scheduled, started or stopped)',589,214059,'Y',0,150,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-07 17:38:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-07 17:38:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4f57d49d-c334-44e8-98bc-a725007e5032','Y',160,1,2,1,'N','N','N')
;

-- IDEMPIERE-4060 Implement change scheduler state at scheduler window
-- Oct 7, 2019, 9:54:33 PM MYT
UPDATE AD_ToolBarButton SET IsActive='N',Updated=TO_TIMESTAMP('2019-10-07 21:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200099
;

SELECT register_migration_script('201910081000_IDEMPIERE-4060.sql') FROM dual
;
