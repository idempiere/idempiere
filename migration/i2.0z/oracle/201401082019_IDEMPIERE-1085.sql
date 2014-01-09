-- Jun 21, 2013 1:54:40 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_SysConfig (AD_Client_ID,AD_Org_ID,AD_SysConfig_ID,AD_SysConfig_UU,ConfigurationLevel,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,200031,'3fca6e48-6809-4ede-8d73-16de172a9e1f','C',TO_DATE('2013-06-21 13:54:39','YYYY-MM-DD HH24:MI:SS'),100,'If role allow it, you can access to Info Account from DP Views dashboard','D','Y','DPViews_ShowInfoAccount',TO_DATE('2013-06-21 13:54:39','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jun 21, 2013 1:54:54 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_SysConfig (AD_Client_ID,AD_Org_ID,AD_SysConfig_ID,AD_SysConfig_UU,ConfigurationLevel,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,200032,'ee06e3d0-b424-4bbb-a34b-654563da6c72','C',TO_DATE('2013-06-21 13:54:54','YYYY-MM-DD HH24:MI:SS'),100,'If role allow it, you can access to Info Schedule from DP Views dashboard','D','Y','DPViews_ShowInfoSchedule',TO_DATE('2013-06-21 13:54:54','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jun 21, 2013 1:55:58 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210509,'9b2b4a4c-364e-4487-805a-135cb94670da',1720,0,10,895,'ImageURL',TO_DATE('2013-06-21 13:55:58','YYYY-MM-DD HH24:MI:SS'),100,'URL of  image','D',120,'URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','Y','Image URL',0,0,TO_DATE('2013-06-21 13:55:58','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 21, 2013 1:55:59 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210509 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 21, 2013 1:56:00 PM CEST
-- IDEMPIERE-1085
ALTER TABLE AD_InfoWindow ADD ImageURL NVARCHAR2(120) DEFAULT NULL 
;

-- Jun 21, 2013 1:56:25 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210510,'f0c237ac-edcd-43b2-8d40-1d5c9858680c',566,0,11,895,'SeqNo',TO_DATE('2013-06-21 13:56:24','YYYY-MM-DD HH24:MI:SS'),100,'@SQL=SELECT NVL(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_InfoWindow WHERE AD_InfoWindow_ID=@AD_InfoWindow_ID@','Method of ordering records; lowest number comes first','D',22,'The Sequence indicates the order of records','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','Y','Sequence',0,0,TO_DATE('2013-06-21 13:56:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 21, 2013 1:56:25 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210510 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 21, 2013 1:56:26 PM CEST
-- IDEMPIERE-1085
ALTER TABLE AD_InfoWindow ADD SeqNo NUMBER(10) DEFAULT NULL 
;

-- Jun 21, 2013 1:56:44 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210511,'e21b0a7e-8691-40a5-ad5a-e3f090192db5',200074,0,20,895,'IsShowInDashboard',TO_DATE('2013-06-21 13:56:43','YYYY-MM-DD HH24:MI:SS'),100,'Y','Show the dashlet in the dashboard','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','N','Y','Show in Dashboard',0,0,TO_DATE('2013-06-21 13:56:43','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jun 21, 2013 1:56:44 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210511 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jun 21, 2013 1:56:45 PM CEST
-- IDEMPIERE-1085
ALTER TABLE AD_InfoWindow ADD IsShowInDashboard CHAR(1) DEFAULT 'Y' CHECK (IsShowInDashboard IN ('Y','N')) NOT NULL
;

-- Jun 21, 2013 1:56:49 PM CEST
-- IDEMPIERE-1085
ALTER TABLE AD_InfoWindow MODIFY IsShowInDashboard CHAR(1) DEFAULT 'Y'
;

-- Jun 21, 2013 1:56:49 PM CEST
-- IDEMPIERE-1085
UPDATE AD_InfoWindow SET IsShowInDashboard='Y' WHERE IsShowInDashboard IS NULL
;

-- Jun 21, 2013 1:57:08 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210509,202196,'ebd357bf-70de-46a0-8496-8e571b412233',0,842,5,TO_DATE('2013-06-21 13:57:08','YYYY-MM-DD HH24:MI:SS'),100,'URL of  image',120,'D','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.','Y','Y','Y','N','N','N','N','N','Image URL',180,TO_DATE('2013-06-21 13:57:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jun 21, 2013 1:57:08 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202196 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 21, 2013 1:57:09 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210510,202197,'0d40ae0e-8814-432a-915c-3dde1a558771',0,842,2,TO_DATE('2013-06-21 13:57:08','YYYY-MM-DD HH24:MI:SS'),100,'Method of ordering records; lowest number comes first',22,'D','The Sequence indicates the order of records','Y','Y','Y','N','N','N','N','N','Sequence',190,TO_DATE('2013-06-21 13:57:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jun 21, 2013 1:57:09 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202197 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 21, 2013 1:57:09 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210511,202198,'43f7afaf-4ad2-45f5-a2da-1237c89ac29d',0,842,2,TO_DATE('2013-06-21 13:57:09','YYYY-MM-DD HH24:MI:SS'),100,'Show the dashlet in the dashboard',1,'D','Y','Y','Y','N','N','N','N','N','Show in Dashboard',200,TO_DATE('2013-06-21 13:57:09','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Jun 21, 2013 1:57:09 PM CEST
-- IDEMPIERE-1085
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202198 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202197
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=13582
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=13575
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=13581
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=201621
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=201634
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=13579
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=13580
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=201627
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=201628
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=201639
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=202198
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=201807
;

-- Jun 21, 2013 1:57:55 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=202196
;

-- Jun 21, 2013 1:58:05 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-06-21 13:58:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202197
;

-- Jun 21, 2013 1:58:32 PM CEST
-- IDEMPIERE-1085
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-06-21 13:58:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202198
;

-- Jun 21, 2013 1:59:01 PM CEST
-- IDEMPIERE-1085
UPDATE AD_InfoWindow SET ImageURL='InfoBPartner16.png',Updated=TO_DATE('2013-06-21 13:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200001
;

-- Jun 21, 2013 1:59:10 PM CEST
-- IDEMPIERE-1085
UPDATE AD_InfoWindow SET ImageURL='InfoProduct16.png',Updated=TO_DATE('2013-06-21 13:59:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200000
;

SELECT register_migration_script('201401082019_IDEMPIERE-1085.sql') FROM dual
;
