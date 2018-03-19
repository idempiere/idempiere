-- Mar 25, 2013 6:11:15 PM SGT
-- Ticket #1001984: Avoiding Payment profile ID mess
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',0,298,210214,'D','N','N','N',0,'N',10,'N',19,'N',1385,'N','Y','93cbf467-dbe3-4c00-b105-959b405e6106','Y','C_PaymentProcessor_ID','Payment processor for electronic payments','The Payment Processor indicates the processor to be used for electronic payments','Payment Processor','Y',TO_TIMESTAMP('2013-03-25 18:11:13','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-03-25 18:11:13','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 25, 2013 6:11:16 PM SGT
-- Ticket #1001984: Avoiding Payment profile ID mess
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210214 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 25, 2013 6:11:21 PM SGT
-- Ticket #1001984: Avoiding Payment profile ID mess
ALTER TABLE C_BP_BankAccount ADD COLUMN C_PaymentProcessor_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 25, 2013 6:11:53 PM SGT
-- Ticket #1001984: Avoiding Payment profile ID mess
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',226,10,'N','N',210214,'Y',201894,'N','The Payment Processor indicates the processor to be used for electronic payments','D','Payment processor for electronic payments','Payment Processor','bb23275a-069d-4436-8af3-d612e42dd4e6','Y','N',100,0,TO_TIMESTAMP('2013-03-25 18:11:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-03-25 18:11:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 25, 2013 6:11:54 PM SGT
-- Ticket #1001984: Avoiding Payment profile ID mess
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201894 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 25, 2013 6:12:32 PM SGT
-- Ticket #1001984: Avoiding Payment profile ID mess
UPDATE AD_Field SET ColumnSpan=2, IsSameLine='Y', IsReadOnly='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-03-25 18:12:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201894
;

SELECT register_migration_script('201304021807_TICKET-1001984.sql') FROM dual
;