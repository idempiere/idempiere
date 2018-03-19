SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 18, 2015 10:47:07 AM IST
INSERT INTO AD_Column (SeqNoSelection,AD_Column_ID,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,UpdatedBy,EntityType,IsSecure,IsEncrypted,IsParent,IsMandatory,IsIdentifier,SeqNo,Help,Version,FieldLength,IsKey,IsTranslated,Created,IsUpdateable,IsAutocomplete,IsAllowLogging,IsAllowCopy,Description,ColumnName,Name,IsSelectionColumn,AD_Column_UU,IsActive,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,212212,'N','N',0,0,100,TO_DATE('2015-06-18 10:47:06','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','N','N','N',0,'The Database Table provides the information of the table definition',0,10,'N','N',TO_DATE('2015-06-18 10:47:06','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y','Y','Database Table information','AD_Table_ID','Table','N','cd639a6d-243f-4737-80b7-e953534cafa6','Y','N','N',126,19,288)
;

-- Jun 18, 2015 10:47:12 AM IST
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADTable_ADTree',Updated=TO_DATE('2015-06-18 10:47:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212212
;

-- Jun 18, 2015 10:47:12 AM IST
ALTER TABLE AD_Tree ADD AD_Table_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 18, 2015 10:47:12 AM IST
ALTER TABLE AD_Tree ADD CONSTRAINT ADTable_ADTree FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 18, 2015 10:47:46 AM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,CreatedBy,UpdatedBy,Created,Updated,EntityType,AD_Client_ID,AD_Org_ID,Description,Value,Name,IsActive,AD_Ref_List_UU,AD_Reference_ID) VALUES (200310,100,100,TO_DATE('2015-06-18 10:47:45','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2015-06-18 10:47:45','YYYY-MM-DD HH24:MI:SS'),'D',0,0,'Custom Table','TL','Custom Table','Y','e3104c45-9a71-4ea1-bd24-9125d33f07db',120)
;

-- Jun 18, 2015 10:48:11 AM IST
INSERT INTO AD_Field (ColumnSpan,AD_Field_ID,AD_Client_ID,CreatedBy,AD_Org_ID,Updated,UpdatedBy,IsHeading,IsDisplayed,IsFieldOnly,IsSameLine,IsDisplayedGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,Name,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,AD_Column_ID,AD_Tab_ID) VALUES (2,203825,0,100,0,TO_DATE('2015-06-18 10:48:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',100,'N','Y',TO_DATE('2015-06-18 10:48:05','YYYY-MM-DD HH24:MI:SS'),'D','AD_Tree_UU','N',36,'13075486-eba0-4882-8270-9205a2440b6f','Y',60514,243)
;

-- Jun 18, 2015 10:48:11 AM IST
INSERT INTO AD_Field (ColumnSpan,AD_Field_ID,AD_Client_ID,CreatedBy,AD_Org_ID,Updated,UpdatedBy,IsHeading,Help,IsDisplayed,IsFieldOnly,IsSameLine,SeqNo,IsReadOnly,IsCentrallyMaintained,Created,EntityType,Name,Description,IsEncrypted,DisplayLength,AD_Field_UU,IsActive,AD_Column_ID,AD_Tab_ID) VALUES (2,203826,0,100,0,TO_DATE('2015-06-18 10:48:11','YYYY-MM-DD HH24:MI:SS'),100,'N','The Database Table provides the information of the table definition','Y','N','N',110,'N','Y',TO_DATE('2015-06-18 10:48:11','YYYY-MM-DD HH24:MI:SS'),'D','Table','Database Table information','N',10,'f7ca6a1b-4a96-48fe-938e-6784af276493','Y',212212,243)
;

-- Jun 18, 2015 10:48:40 AM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=203825
;

-- Jun 18, 2015 10:48:40 AM IST
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=203826
;

-- Jun 18, 2015 10:48:40 AM IST
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=5228
;

-- Jun 18, 2015 10:48:40 AM IST
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=12421
;

-- Jun 18, 2015 10:48:40 AM IST
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=8371
;

-- Jun 18, 2015 10:49:23 AM IST
UPDATE AD_Field SET DisplayLogic='@TreeType@=''TL''',Updated=TO_DATE('2015-06-18 10:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203826
;


SELECT register_migration_script('201506241206_IDEMPIERE-2675.sql') FROM dual
;