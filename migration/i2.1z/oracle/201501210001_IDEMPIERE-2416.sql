SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 21, 2015 2:33:53 PM UTC
-- https://idempiere.atlassian.net/browse/IDEMPIERE-2416 - Improve Generate Production from Project - add columns/fields
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211814,0,'Production','Plan for producing a product','The Production uniquely identifies a Production Plan',434,'M_Production_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2015-01-21 14:33:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:33:53','YYYY-MM-DD HH24:MI:SS'),100,1032,'N','N','U','N','N','N','Y','b7fa73b4-ea7f-4b3b-8cde-9e7d0bf31bb2','Y',0,'N','N')
;

-- Jan 21, 2015 2:34:42 PM UTC
UPDATE AD_Column SET FKConstraintName='MProduction_CProjectLine', FKConstraintType='N',Updated=TO_DATE('2015-01-21 14:34:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211814
;

-- Jan 21, 2015 2:34:42 PM UTC
ALTER TABLE C_ProjectLine ADD M_Production_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 21, 2015 2:34:42 PM UTC
ALTER TABLE C_ProjectLine ADD CONSTRAINT MProduction_CProjectLine FOREIGN KEY (M_Production_ID) REFERENCES m_production(m_production_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 21, 2015 2:34:55 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (211815,0,'Trx Organization','Performing or initiating organization','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.',203,'AD_OrgTrx_ID',22,'N','N','N','N','N',0,'N',18,130,0,0,'Y',TO_DATE('2015-01-21 14:34:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:34:55','YYYY-MM-DD HH24:MI:SS'),100,112,'Y','N','U','N','N','N','Y','01a4a630-7218-4a18-b555-9c94d3b0cbf8','Y',0,'N','N','N')
;

-- Jan 21, 2015 2:35:01 PM UTC
UPDATE AD_Column SET FKConstraintName='ADOrgTrx_CProject', FKConstraintType='N',Updated=TO_DATE('2015-01-21 14:35:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211815
;

-- Jan 21, 2015 2:35:01 PM UTC
ALTER TABLE C_Project ADD AD_OrgTrx_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 21, 2015 2:35:01 PM UTC
ALTER TABLE C_Project ADD CONSTRAINT ADOrgTrx_CProject FOREIGN KEY (AD_OrgTrx_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 21, 2015 2:35:29 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (211816,0,'Activity','Business Activity','Activities indicate tasks that are performed and used to utilize Activity based Costing',203,'C_Activity_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-01-21 14:35:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:35:29','YYYY-MM-DD HH24:MI:SS'),100,1005,'Y','N','U','N','N','N','Y','3185bbca-7ff6-48c7-8c89-85d53c4e6226','Y',0,'N','N','N')
;

-- Jan 21, 2015 2:35:36 PM UTC
UPDATE AD_Column SET FKConstraintName='CActivity_CProject', FKConstraintType='N',Updated=TO_DATE('2015-01-21 14:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211816
;

-- Jan 21, 2015 2:35:36 PM UTC
ALTER TABLE C_Project ADD C_Activity_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 21, 2015 2:35:36 PM UTC
ALTER TABLE C_Project ADD CONSTRAINT CActivity_CProject FOREIGN KEY (C_Activity_ID) REFERENCES c_activity(c_activity_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 21, 2015 2:36:11 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211817,0,'Project Phase','Phase of a Project',325,'C_ProjectPhase_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-01-21 14:36:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:36:10','YYYY-MM-DD HH24:MI:SS'),100,2073,'N','N','U','N','N','N','Y','1f63af31-8b20-4738-af31-6c6d11a4f7a6','Y',0,'N','N')
;

-- Jan 21, 2015 2:36:12 PM UTC
UPDATE AD_Column SET FKConstraintName='CProjectPhase_MProduction', FKConstraintType='N',Updated=TO_DATE('2015-01-21 14:36:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211817
;

-- Jan 21, 2015 2:36:12 PM UTC
ALTER TABLE M_Production ADD C_ProjectPhase_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 21, 2015 2:36:12 PM UTC
ALTER TABLE M_Production ADD CONSTRAINT CProjectPhase_MProduction FOREIGN KEY (C_ProjectPhase_ID) REFERENCES c_projectphase(c_projectphase_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 21, 2015 2:36:34 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211818,0,'Project Task','Actual Project Task in a Phase','A Project Task in a Project Phase represents the actual work.',325,'C_ProjectTask_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-01-21 14:36:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:36:34','YYYY-MM-DD HH24:MI:SS'),100,2074,'N','N','U','N','N','N','Y','1826bb1e-7578-4a0f-96b2-e07e7a663ea9','Y',0,'N','N')
;

-- Jan 21, 2015 2:36:40 PM UTC
UPDATE AD_Column SET FKConstraintName='CProjectTask_MProduction', FKConstraintType='N',Updated=TO_DATE('2015-01-21 14:36:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211818
;

-- Jan 21, 2015 2:36:40 PM UTC
ALTER TABLE M_Production ADD C_ProjectTask_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 21, 2015 2:36:40 PM UTC
ALTER TABLE M_Production ADD CONSTRAINT CProjectTask_MProduction FOREIGN KEY (C_ProjectTask_ID) REFERENCES c_projecttask(c_projecttask_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 21, 2015 2:38:15 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203482,'Production','Plan for producing a product','The Production uniquely identifies a Production Plan',797,211814,'Y',0,230,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-01-21 14:38:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:38:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','df80dd06-76ac-4335-a036-3778748f607b','Y',230,1,1,1,'N','N','N')
;

-- Jan 21, 2015 2:39:38 PM UTC
UPDATE AD_Field SET SeqNo=230, ColumnSpan=2,Updated=TO_DATE('2015-01-21 14:39:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203482
;

-- Jan 21, 2015 2:40:21 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203483,'Production','Plan for producing a product','The Production uniquely identifies a Production Plan',799,211814,'Y',0,230,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-01-21 14:40:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:40:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','4f1a024e-fb20-4691-ac6d-751c56952792','Y',230,1,1,1,'N','N','N')
;

-- Jan 21, 2015 2:40:34 PM UTC
UPDATE AD_Field SET SeqNo=230, ColumnSpan=2,Updated=TO_DATE('2015-01-21 14:40:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203483
;

-- Jan 21, 2015 2:40:58 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203484,'Production','Plan for producing a product','The Production uniquely identifies a Production Plan',796,211814,'Y',0,230,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-01-21 14:40:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:40:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','7ea1e1e8-6825-4064-88ae-94cedf02154c','Y',230,1,1,1,'N','N','N')
;

-- Jan 21, 2015 2:41:11 PM UTC
UPDATE AD_Field SET SeqNo=230, ColumnSpan=2,Updated=TO_DATE('2015-01-21 14:41:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203484
;

-- Jan 21, 2015 2:42:24 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203485,'Trx Organization','Performing or initiating organization','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.',157,211815,'Y',0,360,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-01-21 14:42:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:42:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','a136ba29-279f-48df-a909-882cae97769a','Y',360,1,1,1,'N','N','N')
;

-- Jan 21, 2015 2:42:42 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203486,'Activity','Business Activity','Activities indicate tasks that are performed and used to utilize Activity based Costing',157,211816,'Y',0,370,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-01-21 14:42:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:42:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','c434e4e3-4bb3-4e92-874d-e95ce9ca62fd','Y',370,1,1,1,'N','N','N')
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=250, XPosition=1, ColumnSpan=2,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203485
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, XPosition=4, ColumnSpan=2,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203486
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=270,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4455
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=280,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4457
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4456
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=300,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13024
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3066
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=320,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6550
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=330,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6544
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=340,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6547
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=350,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6549
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=360,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6545
;

-- Jan 21, 2015 2:44:55 PM UTC
UPDATE AD_Field SET SeqNo=370,Updated=TO_DATE('2015-01-21 14:44:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8237
;

-- Jan 21, 2015 2:46:18 PM UTC
UPDATE AD_Field SET DisplayLogic='@$Element_OT@=Y',Updated=TO_DATE('2015-01-21 14:46:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203485
;

-- Jan 21, 2015 2:46:52 PM UTC
UPDATE AD_Field SET DisplayLogic='@$Element_AY@=''Y''',Updated=TO_DATE('2015-01-21 14:46:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203486
;

-- Jan 21, 2015 2:48:22 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203487,'Project Phase','Phase of a Project',53344,211817,'N',0,260,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-01-21 14:48:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:48:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','ac5a3ec0-fd0f-4dc8-bda2-71c3fc5f3592','Y',230,1,1,1,'N','N','N')
;

-- Jan 21, 2015 2:48:34 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203488,'Project Task','Actual Project Task in a Phase','A Project Task in a Project Phase represents the actual work.',53344,211818,'N',0,270,0,'N','N','N','N',0,0,'Y',TO_DATE('2015-01-21 14:48:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-01-21 14:48:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','baef708a-e28b-4e9c-9667-1108f931b12e','Y',240,1,1,1,'N','N','N')
;

SELECT register_migration_script('201501210001_IDEMPIERE-2416.sql') FROM dual
;
