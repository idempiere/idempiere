-- Aug 25, 2013 12:48:32 PM COT
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_DATE('2013-08-25 12:48:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59701
;

-- Aug 25, 2013 12:48:54 PM COT
ALTER TABLE AD_ChartDatasource MODIFY CategoryColumn NVARCHAR2(60) DEFAULT NULL 
;

-- Aug 25, 2013 12:48:54 PM COT
ALTER TABLE AD_ChartDatasource MODIFY CategoryColumn NULL
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=170
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56374
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=310
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2526
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=180, IsDisplayed='Y', XPosition=1, ColumnSpan=2,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59619
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=290,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2370
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=300,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=169
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=310,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10128
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=320,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4941
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=330,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50188
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=340,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=168
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=350,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=159
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=360,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=825
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=370,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4940
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=380,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=167
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=390,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5121
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=400,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200288
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=410,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56317
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=420,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62467
;

-- Aug 25, 2013 12:50:10 PM COT
UPDATE AD_Field SET SeqNo=430,Updated=TO_DATE('2013-08-25 12:50:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5122
;

-- Aug 25, 2013 12:52:36 PM COT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,53284,210849,389,'Y','N','N',0,'N',40,'N',18,'N','@EntityType@=D','N','Y','8a078474-3a0c-4228-b06c-afaa05409314','Y','EntityType','Dictionary Entity Type; Determines ownership and synchronization','U','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Entity Type','Y',TO_DATE('2013-08-25 12:52:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-25 12:52:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',1682,'N')
;

-- Aug 25, 2013 12:52:36 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210849 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 25, 2013 12:52:40 PM COT
ALTER TABLE AD_Chart ADD EntityType VARCHAR2(40) DEFAULT 'U' NOT NULL
;

-- Aug 25, 2013 12:53:06 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',53339,36,'N','N',210648,150,'Y',202478,'N','U','AD_Chart_UU','7cd65f88-348e-413d-b4d0-3c92322cc02f','N','N',100,0,TO_DATE('2013-08-25 12:53:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-25 12:53:06','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 25, 2013 12:53:06 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202478 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 25, 2013 12:53:14 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',53339,40,'N','N',210849,160,'Y',202479,'N','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','U','Dictionary Entity Type; Determines ownership and synchronization','Entity Type','7a919c20-e3b8-4887-a553-c854430895ff','Y','N',100,0,TO_DATE('2013-08-25 12:53:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-25 12:53:06','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 25, 2013 12:53:14 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202479 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 25, 2013 12:53:45 PM COT
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-08-25 12:53:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202479
;

-- Aug 25, 2013 12:53:45 PM COT
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2013-08-25 12:53:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59596
;

-- Aug 25, 2013 12:53:45 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-08-25 12:53:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202478
;

SELECT register_migration_script('201308251256_IDEMPIERE-1157.sql') FROM dual
;

