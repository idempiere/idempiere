-- IDEMPIERE-498 Make BP quick entry configurable
-- Nov 1, 2012 12:10:18 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsQuickEntry',200216,'D','Quick Entry','Quick Entry','ba2d92ea-f8c5-438e-ba30-053965fdb1ff',0,TO_TIMESTAMP('2012-11-01 12:10:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-01 12:10:15','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y')
;

-- Nov 1, 2012 12:10:18 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200216 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 1, 2012 12:11:28 PM COT
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,DefaultValue,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES ('N','N',0,107,200862,'D','Y','N','N','N',0,'N',1,'N',20,'N',200216,'N','Y','54666e5d-4260-4a97-8832-d5da6da8a5aa','Y','N','IsQuickEntry','Quick Entry','Y',0,TO_TIMESTAMP('2012-11-01 12:11:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-01 12:11:25','YYYY-MM-DD HH24:MI:SS'),0,0,0,'N')
;

-- Nov 1, 2012 12:11:28 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200862 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 1, 2012 2:26:31 PM COT
INSERT INTO AD_Field (NumLines,AD_Field_UU,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (1,'222ea356-f257-413d-9724-c2b59077b94f',0,'N',107,0,'N','N',200862,305,'Y',200771,'N','D','Quick Entry','Y','N',0,0,TO_TIMESTAMP('2012-11-01 14:26:30','YYYY-MM-DD HH24:MI:SS'),0,0,TO_TIMESTAMP('2012-11-01 14:26:30','YYYY-MM-DD HH24:MI:SS'),'Y','Y',305,2,1)
;

-- Nov 1, 2012 2:27:37 PM COT
ALTER TABLE AD_Field ADD COLUMN IsQuickEntry CHAR(1) DEFAULT 'N' CHECK (IsQuickEntry IN ('Y','N')) NOT NULL
;

-- Nov 1, 2012 2:28:01 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200772 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 1, 2012 2:50:40 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 14:50:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=2156
;

-- Nov 1, 2012 2:51:33 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 14:51:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=3261
;

-- Nov 1, 2012 2:52:09 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 14:52:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=2145
;

-- Nov 1, 2012 2:52:20 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 14:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=3228
;

-- Nov 1, 2012 3:10:08 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 15:10:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=7010
;

-- Nov 1, 2012 3:11:02 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 15:11:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=7020
;

-- Nov 1, 2012 3:12:08 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 15:12:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=7028
;

-- Nov 1, 2012 3:12:51 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 15:12:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=7017
;

-- Nov 1, 2012 3:13:38 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 15:13:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=7024
;

-- Nov 1, 2012 3:13:49 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 15:13:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=7021
;

-- Nov 1, 2012 3:14:07 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 15:14:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=7025
;

-- Nov 1, 2012 3:16:56 PM COT
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2012-11-01 15:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=2185
;

-- Nov 2, 2012 3:39:54 PM COT
UPDATE AD_Field SET DisplayLogic='@AD_Tab_ID@=220 || @AD_Tab_ID@=496 || @AD_Tab_ID@=222',Updated=TO_TIMESTAMP('2012-11-02 15:39:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200772
;

-- Nov 9, 2012 9:25:56 PM COT
UPDATE AD_Column SET Callout='org.adempiere.model.CalloutBPartnerLocation.formatPhone;org.adempiere.model.CalloutBPartnerLocation.quickEntryMandatory',Updated=TO_TIMESTAMP('2012-11-09 21:25:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2959
;

SELECT register_migration_script('201211091853_IDEMPIERE-498.sql') FROM dual
;

