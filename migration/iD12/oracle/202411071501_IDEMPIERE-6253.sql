-- IDEMPIERE-6253 Allow Define Document  Global search result layout with custom html layout
SELECT register_migration_script('202411071501_IDEMPIERE-6253.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 7, 2024, 3:01:22 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216892,0,'Message','System Message','Information and Error messages',53169,'AD_Message_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2024-11-07 15:01:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-07 15:01:21','YYYY-MM-DD HH24:MI:SS'),100,1752,'Y','N','D','N','N','N','Y','8c25c439-a475-4989-a89f-3694151d7d59','Y',0,'N','N','N','N','N')
;

-- Nov 7, 2024, 3:01:36 PM MYT
UPDATE AD_Column SET FKConstraintName='ADMessage_ADSearchDefinition', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-07 15:01:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216892
;

-- Nov 7, 2024, 3:01:36 PM MYT
ALTER TABLE AD_SearchDefinition ADD AD_Message_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 7, 2024, 3:01:36 PM MYT
ALTER TABLE AD_SearchDefinition ADD CONSTRAINT ADMessage_ADSearchDefinition FOREIGN KEY (AD_Message_ID) REFERENCES ad_message(ad_message_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 7, 2024, 3:07:19 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208524,'Message','System Message','Information and Error messages',53193,216892,'Y','@SearchType@=Q',0,160,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-07 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-07 15:07:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6022e92c-3d5c-43e8-9c38-4ffa6a988f94','Y',160,1,5,1,'N','N','N','N','N')
;

-- Nov 7, 2024, 3:07:52 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=1,Updated=TO_TIMESTAMP('2024-11-07 15:07:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208524
;

-- Nov 7, 2024, 3:07:52 PM MYT
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2024-11-07 15:07:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56714
;

-- Nov 7, 2024, 3:07:52 PM MYT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2024-11-07 15:07:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56717
;

