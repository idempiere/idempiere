
-- Mar 26, 2013 12:07:36 AM IST
-- IDEMPIERE-460 Adding Lookup override for web service
INSERT INTO AD_Column (AD_Reference_Value_ID,IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Column_ID,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,SeqNoSelection) VALUES (4,'N','N','N',0,210215,53166,'U','N','N','N',0,'N',10,'N',18,115,'N',121,'N','Y','965ef095-ae2e-47cf-a376-d4c0768389b4','Y','AD_Reference_Value_ID','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ','Reference Key','Y',100,TO_TIMESTAMP('2013-03-26 00:07:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-26 00:07:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0)
;

-- Mar 26, 2013 12:07:36 AM IST
-- IDEMPIERE-460 Adding Lookup override for web service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210215 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 26, 2013 12:07:44 AM IST
-- IDEMPIERE-460 Adding Lookup override for web service
ALTER TABLE WS_WebServiceFieldInput ADD COLUMN AD_Reference_Value_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 26, 2013 12:08:01 AM IST
-- IDEMPIERE-460 Adding Lookup override for web service
INSERT INTO AD_Field (AD_Tab_ID,IsEncrypted,AD_Column_ID,DisplayLength,IsSameLine,IsHeading,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES (53189,'N',210215,10,'N','N','Y',201895,'N','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ','U','Required to specify, if data type is Table or List','Reference Key','N','Y','1113ff58-7523-4a3e-bf5c-36d22e14e959',100,0,TO_TIMESTAMP('2013-03-26 00:08:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-26 00:08:00','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 26, 2013 12:08:01 AM IST
-- IDEMPIERE-460 Adding Lookup override for web service
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201895 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 26, 2013 12:15:20 AM IST
-- IDEMPIERE-460 Adding Lookup override for web service
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-03-26 00:15:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201895
;

-- Mar 26, 2013 12:18:40 AM IST
-- IDEMPIERE-460 Adding Lookup override for web service
UPDATE AD_Column SET MandatoryLogic=NULL,Updated=TO_TIMESTAMP('2013-03-26 00:18:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1000004
;

SELECT register_migration_script('201303290245_IDEMPIERE-460-LookupOverride.sql') FROM dual
;