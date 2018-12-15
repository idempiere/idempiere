-- IDEMPIERE-3780 : AD_User.IsNoExpire to override MAX_INACTIVE_PERIOD_DAY
-- Aug 31, 2018 11:49:36 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203266,0,0,'Y',TO_TIMESTAMP('2018-08-31 11:49:36','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2018-08-31 11:49:36','YYYY-MM-DD HH24:MI:SS'),0,'IsNoExpire','No Expire','No Expire','D','86e9d8d5-35c5-4ba1-85d3-d674d8f48a2f')
;

-- Aug 31, 2018 11:50:17 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213690,0,'No Expire',114,'IsNoExpire','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2018-08-31 11:50:17','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2018-08-31 11:50:17','YYYY-MM-DD HH24:MI:SS'),0,203266,'Y','N','D','N','N','N','Y','27a982d2-604b-4efe-982c-6e5004e62072','N',0,'N','Y','N')
;

-- Aug 31, 2018 11:50:19 AM CEST
ALTER TABLE AD_User ADD COLUMN IsNoExpire CHAR(1) DEFAULT 'N' CHECK (IsNoExpire IN ('Y','N')) NOT NULL
;

-- Aug 31, 2018 11:50:38 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205827,'No Expire',118,213690,'Y',1,440,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-08-31 11:50:38','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2018-08-31 11:50:38','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','f96b4141-f3b9-45da-917f-23f9ddc80071','Y',3220,2,2)
;

-- Aug 31, 2018 11:51:05 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-08-31 11:51:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=205827
;

SELECT register_migration_script('201808311200_IDEMPIERE-3780.sql') FROM dual
;