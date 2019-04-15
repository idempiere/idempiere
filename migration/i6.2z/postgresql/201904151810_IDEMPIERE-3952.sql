-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Apr 15, 2019, 5:55:14 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213905,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200089,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_TIMESTAMP('2019-04-15 17:55:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-04-15 17:55:13','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','dd1498af-40e4-435d-99f4-a70a65bbb150','Y',0,'N','N','N','N')
;

-- Apr 15, 2019, 5:55:16 PM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADInfoRelated', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-04-15 17:55:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213905
;

-- Apr 15, 2019, 5:55:16 PM BRT
ALTER TABLE AD_InfoRelated ADD COLUMN EntityType VARCHAR(40) DEFAULT NULL 
;

-- Apr 15, 2019, 5:55:16 PM BRT
ALTER TABLE AD_InfoRelated ADD CONSTRAINT EntityType_ADInfoRelated FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2019, 5:55:22 PM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2019-04-15 17:55:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213905
;

-- Apr 15, 2019, 5:55:36 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206043,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200100,213905,'Y',40,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-04-15 17:55:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-04-15 17:55:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7761f8ce-7944-4357-8f2f-4926b244a822','Y',90,2)
;

-- Apr 15, 2019, 5:56:11 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (213906,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200129,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_TIMESTAMP('2019-04-15 17:56:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-04-15 17:56:11','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','1c4e35cd-bd24-4b3f-b3c7-bc58b2ca7cda','Y',0,'N','N','N','N')
;

-- Apr 15, 2019, 5:56:13 PM BRT
UPDATE AD_Column SET FKConstraintName='EntityType_ADInfoProcess', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-04-15 17:56:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213906
;

-- Apr 15, 2019, 5:56:13 PM BRT
ALTER TABLE AD_InfoProcess ADD COLUMN EntityType VARCHAR(40) DEFAULT NULL 
;

-- Apr 15, 2019, 5:56:13 PM BRT
ALTER TABLE AD_InfoProcess ADD CONSTRAINT EntityType_ADInfoProcess FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2019, 5:56:19 PM BRT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2019-04-15 17:56:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213906
;

-- Apr 15, 2019, 5:57:13 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206044,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200142,213906,'Y',40,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-04-15 17:57:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-04-15 17:57:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19881ce2-9ecc-4a44-9259-6729048ef4a8','Y',80,2)
;

SELECT register_migration_script('201904151810_IDEMPIERE-3952.sql') FROM dual
;