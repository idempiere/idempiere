SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 6, 2014 7:41:43 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,AD_Val_Rule_ID) VALUES (0,'N',0,211377,'N','N','N',0,'N',22,'N','N','N','Y','eff69801-5afa-4898-bc2b-c02e2ad4f94d','Y','AD_Column_ID','Column in the table','Link to the database column of the table','Column','Y',TO_DATE('2014-06-06 19:41:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-06-06 19:41:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',104,19,200129,100)
;

-- Jun 6, 2014 7:43:12 PM ICT
UPDATE AD_Column SET Description='Name of unique column in a view. value of this column will save to t_selection table', Help='Column to resolve issue in https://idempiere.atlassian.net/browse/IDEMPIERE-1970', Name='ViewID Column', FKConstraintName='ADColumn_ADInfoProcess',Updated=TO_DATE('2014-06-06 19:43:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211377
;

-- Jun 6, 2014 7:43:23 PM ICT
ALTER TABLE AD_InfoProcess ADD AD_Column_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 6, 2014 7:43:23 PM ICT
ALTER TABLE AD_InfoProcess ADD CONSTRAINT ADColumn_ADInfoProcess FOREIGN KEY (AD_Column_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 6, 2014 7:45:32 PM ICT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES (0,'N',200142,0,'N','N',100,'N',203108,'N','Column to resolve issue in https://idempiere.atlassian.net/browse/IDEMPIERE-1970','Name of unique column in a view. value of this column will save to t_selection table','ViewID Column','5aacf0a1-baba-4bab-9b24-047b538a6f5d','Y','N',100,0,100,TO_DATE('2014-06-06 19:45:26','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,1,'N',0,1,1,'N','N',211377,'D',TO_DATE('2014-06-06 19:45:26','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 6, 2014 7:46:32 PM ICT
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2014-06-06 19:46:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203108
;

-- Jun 6, 2014 7:46:32 PM ICT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2014-06-06 19:46:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203038
;
ALTER TABLE t_selection ADD ViewID VARCHAR2(30) DEFAULT NULL
;
SELECT register_migration_script('201406061604_IDEMPIERE-1970.sql') FROM dual
;

