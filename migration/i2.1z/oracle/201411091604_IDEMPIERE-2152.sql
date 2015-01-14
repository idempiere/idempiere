SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 11, 2014 9:56:05 AM ICT
-- IDEMPIERE-2152 Info Window - Join related tabs on other columns than primary key
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,Name,Description,PrintName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created,Updated) VALUES ('ParentRelatedColumn_ID',202792,'default column RelatedColumn in Relate Info window will link with key column of main info window
column define in ParentRelatedColumn will replace key column','Parent Related Column','column in parent info window, link with column in this relate info','Parent Related Column','d35a2b4b-6022-4b52-bace-93f05958a77a',0,100,100,'Y',0,'D',TO_DATE('2014-09-11 09:55:54','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-09-11 09:55:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2014 9:57:38 AM ICT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Val_Rule_ID) VALUES (0,'N',0,211765,'N','N','N',0,'N',10,'N','N','N','Y','e03bf0ab-df24-4a01-80b8-92e61d11188c','Y','ParentRelatedColumn_ID','column in parent info window, link with column in this relate info','default column RelatedColumn in Relate Info window will link with key column of main info window
column define in ParentRelatedColumn will replace key column','Parent Related Column','Y',TO_DATE('2014-09-11 09:57:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-09-11 09:57:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N',202792,18,200072,200089,200065)
;

-- Sep 11, 2014 9:58:27 AM ICT
UPDATE AD_Column SET FKConstraintName='ParentRelatedColumn_ADInfoRela', FKConstraintType='N',Updated=TO_DATE('2014-09-11 09:58:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211765
;

-- Sep 11, 2014 9:58:27 AM ICT
ALTER TABLE AD_InfoRelated ADD ParentRelatedColumn_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 11, 2014 9:58:28 AM ICT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT ParentRelatedColumn_ADInfoRela FOREIGN KEY (ParentRelatedColumn_ID) REFERENCES ad_infocolumn(ad_infocolumn_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 11, 2014 10:00:39 AM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',200100,0,'N','N',110,'Y',203446,'N','default column RelatedColumn in Relate Info window will link with key column of main info window
column define in ParentRelatedColumn will replace key column','column in parent info window, link with column in this relate info','Parent Related Column','59dd442c-8596-4be5-b689-cd437ac62edf','Y','N',100,0,100,TO_DATE('2014-09-11 10:00:30','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,'N',0,1,1,'N','N',211765,'D',TO_DATE('2014-09-11 10:00:30','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 11, 2014 10:00:59 AM ICT
UPDATE AD_Field SET Name='Parent Link Column',Updated=TO_DATE('2014-09-11 10:00:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203446
;

-- Sep 11, 2014 10:01:23 AM ICT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=1, ColumnSpan=2,Updated=TO_DATE('2014-09-11 10:01:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203446
;

-- Sep 11, 2014 10:01:23 AM ICT
UPDATE AD_Field SET SeqNo=110, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-09-11 10:01:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202268
;

-- Sep 11, 2014 10:01:23 AM ICT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-09-11 10:01:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202269
;
SELECT register_migration_script('201411091604_IDEMPIERE-2152.sql') FROM dual
;
