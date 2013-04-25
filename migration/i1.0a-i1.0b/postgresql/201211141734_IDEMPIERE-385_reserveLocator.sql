-- Oct 19, 2012 2:07:52 PM WIT
-- Reserve Locator
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200188,'M_ReserveLocator_ID','U','M_ReserveLocator_ID','Reserve Locator',0,TO_TIMESTAMP('2012-10-19 14:07:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-19 14:07:51','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Oct 19, 2012 2:07:52 PM WIT
-- Reserve Locator
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200188 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 19, 2012 2:08:25 PM WIT
-- Reserve Locator
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (190,200704,'U',0,'N','N','N',0,'N',10,'N',31,'N','N',200188,'N','Y','N','Y','N','M_ReserveLocator_ID','M_ReserveLocator_ID','Y',100,TO_TIMESTAMP('2012-10-19 14:08:24','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-10-19 14:08:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 19, 2012 2:08:25 PM WIT
-- Reserve Locator
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200704 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 19, 2012 2:08:28 PM WIT
-- Reserve Locator
ALTER TABLE M_Warehouse ADD COLUMN M_ReserveLocator_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 19, 2012 2:08:49 PM WIT
-- Reserve Locator
INSERT INTO AD_Field (IsEncrypted,DisplayLength,AD_Tab_ID,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,177,'Y','N','N',200704,'N','Y',200649,'N','U','M_ReserveLocator_ID',100,0,'Y',TO_TIMESTAMP('2012-10-19 14:08:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-10-19 14:08:48','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 19, 2012 2:08:49 PM WIT
-- Reserve Locator
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200649 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 19, 2012 2:09:08 PM WIT
-- Reserve Locator
UPDATE AD_Field SET Name='Reserve Locator',Updated=TO_TIMESTAMP('2012-10-19 14:09:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200649
;

-- Oct 19, 2012 2:09:08 PM WIT
-- Reserve Locator
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200649
;

SELECT register_migration_script('201211141734_IDEMPIERE-385_reserveLocator.sql') FROM dual
;

