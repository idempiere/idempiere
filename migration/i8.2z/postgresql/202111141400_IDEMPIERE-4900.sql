-- Aug 2, 2021, 3:42:37 PM MSK
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214567,0,'SQLStatement',706,'SQLStatement',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-08-02 15:42:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-02 15:42:36','YYYY-MM-DD HH24:MI:SS'),100,50028,'Y','N','D','N','N','N','Y','a3885450-50d5-41b6-a7f4-8cd4bcc9e465','Y',0,'N','N','N')
;

-- Aug 2, 2021, 3:42:44 PM MSK
ALTER TABLE AD_WF_NextCondition ADD COLUMN SQLStatement VARCHAR(4000) DEFAULT NULL 
;

-- Aug 2, 2021, 3:42:59 PM MSK
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206737,'SQLStatement',644,214567,'Y',4000,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-08-02 15:42:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-02 15:42:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f78eaea8-558a-4d74-8c50-26c59468c3a2','Y',130,5)
;

-- Aug 2, 2021, 3:43:09 PM MSK
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-08-02 15:43:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206737
;

-- Aug 2, 2021, 3:43:35 PM MSK
UPDATE AD_Field SET DisplayLogic='@SQLStatement@=''''&@Operation@!''SQ''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-08-02 15:43:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10101
;

-- Aug 2, 2021, 3:44:18 PM MSK
UPDATE AD_Field SET DisplayLogic='@AD_Column_ID@=0|@Operation@=''SQ''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-08-02 15:44:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206737
;

-- Aug 2, 2021, 3:45:00 PM MSK
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2021-08-02 15:45:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11579
;

-- Aug 2, 2021, 3:45:05 PM MSK
INSERT INTO t_alter_column values('ad_wf_nextcondition','AD_Column_ID','NUMERIC(10)',null,'NULL')
;

-- Aug 2, 2021, 3:45:05 PM MSK
INSERT INTO t_alter_column values('ad_wf_nextcondition','AD_Column_ID',null,'NULL',null)
;

INSERT INTO AD_Message 
(MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) 
VALUES ('E','Please enter read-only SQL expression or statement',200259,'D','49c3be7e-16de-46ff-a2a9-f9411a6a4982','SQLReadOnly','Y',
TO_TIMESTAMP('2021-11-14 17:45:57','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2021-11-14 17:45:57','YYYY-MM-DD HH24:MI:SS'),0,0)
;

UPDATE AD_Column SET IsMandatory='N', 
MandatoryLogic='@Operation@!''SQ''&@SQLStatement@=''''',Updated=TO_TIMESTAMP('2021-11-14 17:47:52','YYYY-MM-DD HH24:MI:SS'),
UpdatedBy=100 WHERE AD_Column_ID=11579
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10102
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10094
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10105
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10095
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10096
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10098
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10103
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10104
;

-- Nov 15, 2021, 10:43:08 AM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206737
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10102
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10094
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10105
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10095
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10096
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10098
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10103
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10104
;

-- Nov 15, 2021, 10:43:22 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206737
;

-- Nov 15, 2021, 10:43:47 AM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-11-15 10:43:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10104
;

-- Nov 15, 2021, 10:50:21 AM MYT
UPDATE AD_Element SET Name='SQL Expression/Statement', PrintName='SQL Expression/Statement',Updated=TO_TIMESTAMP('2021-11-15 10:50:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=50028
;

-- Nov 15, 2021, 10:50:21 AM MYT
UPDATE AD_Column SET ColumnName='SQLStatement', Name='SQL Expression/Statement', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50028
;

-- Nov 15, 2021, 10:50:21 AM MYT
UPDATE AD_Process_Para SET ColumnName='SQLStatement', Name='SQL Expression/Statement', Description=NULL, Help=NULL, AD_Element_ID=50028 WHERE UPPER(ColumnName)='SQLSTATEMENT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 15, 2021, 10:50:21 AM MYT
UPDATE AD_Process_Para SET ColumnName='SQLStatement', Name='SQL Expression/Statement', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50028 AND IsCentrallyMaintained='Y'
;

-- Nov 15, 2021, 10:50:21 AM MYT
UPDATE AD_InfoColumn SET ColumnName='SQLStatement', Name='SQL Expression/Statement', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=50028 AND IsCentrallyMaintained='Y'
;

-- Nov 15, 2021, 10:50:21 AM MYT
UPDATE AD_Field SET Name='SQL Expression/Statement', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=50028) AND IsCentrallyMaintained='Y'
;

-- Nov 15, 2021, 10:50:21 AM MYT
UPDATE AD_PrintFormatItem SET PrintName='SQL Expression/Statement', Name='SQL Expression/Statement' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=50028)
;

-- Nov 15, 2021, 11:21:22 AM MYT
UPDATE AD_Column SET ReadOnlyLogic='@#ShowAdvanced@!''Y''',Updated=TO_TIMESTAMP('2021-11-15 11:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214567
;

SELECT register_migration_script('202111141400_IDEMPIERE-4900.sql') FROM dual
;

