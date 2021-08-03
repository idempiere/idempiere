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
UPDATE AD_Field SET DisplayLogic='@SQLStatement@ = ''''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-08-02 15:43:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10101
;

-- Aug 2, 2021, 3:44:18 PM MSK
UPDATE AD_Field SET DisplayLogic='@AD_Column_ID@ > 0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-08-02 15:44:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206737
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

SELECT register_migration_script('202108021638_IDEMPIERE-4900.sql') FROM dual
;
