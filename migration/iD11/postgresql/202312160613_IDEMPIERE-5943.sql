-- IDEMPIERE-5943 Implement table partitioning support
SELECT register_migration_script('202312160613_IDEMPIERE-5943.sql') FROM dual;

-- Dec 16, 2023, 6:13:11 AM MYT
UPDATE AD_Field SET SeqNo=560, SeqNoGrid=510,Updated=TO_TIMESTAMP('2023-12-16 06:13:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208093
;

-- Dec 16, 2023, 6:14:08 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208094,'Partitioning Method','Indicates how the Table is partitioned','The Partitioning Method indicates how the Table is partitioned (List or Range). List partitioning - The data distribution is defined by a discrete list of values. Range Partitioning - The data is distributed based on a range of values.',101,216283,'Y','@IsPartition@=Y & @IsPartitionKey@=Y',0,550,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-16 06:14:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-16 06:14:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','46ea66ce-849a-4e6e-a9e5-cd54efee2d78','Y',500,1,2,1,'N','N','N','N')
;

-- Dec 16, 2023, 6:15:38 AM MYT
UPDATE AD_Column SET MandatoryLogic='@IsPartition@=Y & @IsPartitionKey@=Y',Updated=TO_TIMESTAMP('2023-12-16 06:15:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216283
;

-- Dec 17, 2023, 9:50:42 AM MYT
UPDATE AD_Scheduler SET IsActive='N', Record_ID=NULL,Updated=TO_TIMESTAMP('2023-12-17 09:50:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Scheduler_ID=200003
;

-- Dec 18, 2023, 1:51:19 PM MYT
UPDATE AD_Message SET MsgText='Your changes to the current table partition configuration are not supported',Updated=TO_TIMESTAMP('2023-12-18 13:51:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200853
;

-- Dec 18, 2023, 1:51:40 PM MYT
UPDATE AD_Message SET MsgText='At least one partition key column is required',Updated=TO_TIMESTAMP('2023-12-18 13:51:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200852
;

-- Dec 18, 2023, 1:52:33 PM MYT
UPDATE AD_Message SET MsgText='Failed to attach default partition',Updated=TO_TIMESTAMP('2023-12-18 13:52:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200848
;

-- Dec 18, 2023, 1:54:36 PM MYT
UPDATE AD_Message SET MsgText='Only one partition key column is allowed',Updated=TO_TIMESTAMP('2023-12-18 13:54:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200858
;
