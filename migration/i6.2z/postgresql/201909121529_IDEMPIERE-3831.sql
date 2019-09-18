-- IDEMPIERE-3831 Implement AD_FieldStyle for Info Windows
-- Sep 17, 2019, 3:25:02 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214051,0,'Field Style','Field CSS Style ',897,'AD_FieldStyle_ID',10,'N','N','N','N','N',0,'N',18,200121,0,0,'Y',TO_TIMESTAMP('2019-09-17 15:25:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-09-17 15:25:02','YYYY-MM-DD HH24:MI:SS'),100,203012,'Y','N','D','N','N','N','Y','f70da853-fe44-41e9-9c68-62638cfc90d8','Y',0,'N','N','N','N')
;

-- Sep 17, 2019, 3:25:08 PM BRT
UPDATE AD_Column SET FKConstraintName='ADFieldStyle_ADInfoColumn', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-09-17 15:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214051
;

-- Sep 17, 2019, 3:25:08 PM BRT
ALTER TABLE AD_InfoColumn ADD COLUMN AD_FieldStyle_ID NUMERIC(10) DEFAULT NULL
;

-- Sep 17, 2019, 3:25:08 PM BRT
ALTER TABLE AD_InfoColumn ADD CONSTRAINT ADFieldStyle_ADInfoColumn FOREIGN KEY (AD_FieldStyle_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 17, 2019, 3:26:02 PM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-09-17 15:26:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214051
;

-- Sep 17, 2019, 3:26:12 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206178,'Field Style','Field CSS Style ',844,214051,'Y',10,310,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-09-17 15:26:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-09-17 15:26:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d6b6f5e1-1436-49fc-b57a-12bb4b0c247c','Y',10280,2)
;


SELECT register_migration_script('201909121529_IDEMPIERE-3831.sql') FROM dual
;

