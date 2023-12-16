-- IDEMPIERE-5943 Implement table partitioning support
SELECT register_migration_script('202312131039_IDEMPIERE-5943.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 13, 2023, 10:39:08 AM MYT
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MAX(SeqNoPartition),0)+10 AS DefaultValue FROM AD_Column WHERE AD_Table_ID=@AD_Table_ID@  AND IsActive=''Y'' AND IsPartitionKey=''Y''',Updated=TO_TIMESTAMP('2023-12-13 10:39:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216302
;

-- Dec 13, 2023, 10:41:20 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,MandatoryLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey,SeqNoPartition) VALUES (216304,0,'Range Partition Interval',101,'RangePartitionInterval',30,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-12-13 10:41:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 10:41:19','YYYY-MM-DD HH24:MI:SS'),100,203883,'Y','N','D','N','N','@IsPartition@=''Y'' & @PartitioningMethod@=''R''','N','Y','e8dff995-1857-4653-8aa2-18d6e89620fd','Y',0,'N','N','N','N','N',0)
;

-- Dec 13, 2023, 10:41:31 AM MYT
ALTER TABLE AD_Column ADD RangePartitionInterval VARCHAR2(30 CHAR) DEFAULT NULL 
;

-- Dec 13, 2023, 10:42:52 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208093,'Range Partition Interval',101,216304,'Y',30,550,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-13 10:42:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 10:42:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e4d0ddb5-cc5b-4969-96fd-718a759635ff','Y',500,2)
;

-- Dec 13, 2023, 10:44:43 AM MYT
UPDATE AD_Field SET DisplayLogic='@IsPartition@=Y & @IsPartitionKey@=Y & @PartitioningMethod@=R',Updated=TO_TIMESTAMP('2023-12-13 10:44:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208093
;
-- Dec 13, 2023, 10:54:43 AM MYT
UPDATE AD_Element SET Description='This is a partitioned table',Updated=TO_TIMESTAMP('2023-12-13 10:54:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203881
;

-- Dec 13, 2023, 10:54:44 AM MYT
UPDATE AD_Column SET ColumnName='IsPartition', Name='Partition', Description='This is a partitioned table', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203881
;

-- Dec 13, 2023, 10:54:44 AM MYT
UPDATE AD_Process_Para SET ColumnName='IsPartition', Name='Partition', Description='This is a partitioned table', Help=NULL, AD_Element_ID=203881 WHERE UPPER(ColumnName)='ISPARTITION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 13, 2023, 10:54:44 AM MYT
UPDATE AD_Process_Para SET ColumnName='IsPartition', Name='Partition', Description='This is a partitioned table', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203881 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 10:54:44 AM MYT
UPDATE AD_InfoColumn SET ColumnName='IsPartition', Name='Partition', Description='This is a partitioned table', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203881 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 10:54:44 AM MYT
UPDATE AD_Field SET Name='Partition', Description='This is a partitioned table', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203881) AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:02:03 AM MYT
UPDATE AD_Element SET Description='Indicates how the Table is partitioned', Help='The Partitioning Method indicates how the Table is partitioned (List or Range). List partitioning - The data distribution is defined by a discrete list of values. Range Partitioning - The data is distributed based on a range of values.',Updated=TO_TIMESTAMP('2023-12-13 11:02:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203882
;

-- Dec 13, 2023, 11:02:03 AM MYT
UPDATE AD_Column SET ColumnName='PartitioningMethod', Name='Partitioning Method', Description='Indicates how the Table is partitioned', Help='The Partitioning Method indicates how the Table is partitioned (List or Range). List partitioning - The data distribution is defined by a discrete list of values. Range Partitioning - The data is distributed based on a range of values.', Placeholder=NULL WHERE AD_Element_ID=203882
;

-- Dec 13, 2023, 11:02:04 AM MYT
UPDATE AD_Process_Para SET ColumnName='PartitioningMethod', Name='Partitioning Method', Description='Indicates how the Table is partitioned', Help='The Partitioning Method indicates how the Table is partitioned (List or Range). List partitioning - The data distribution is defined by a discrete list of values. Range Partitioning - The data is distributed based on a range of values.', AD_Element_ID=203882 WHERE UPPER(ColumnName)='PARTITIONINGMETHOD' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 13, 2023, 11:02:04 AM MYT
UPDATE AD_Process_Para SET ColumnName='PartitioningMethod', Name='Partitioning Method', Description='Indicates how the Table is partitioned', Help='The Partitioning Method indicates how the Table is partitioned (List or Range). List partitioning - The data distribution is defined by a discrete list of values. Range Partitioning - The data is distributed based on a range of values.', Placeholder=NULL WHERE AD_Element_ID=203882 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:05:16 AM MYT
UPDATE AD_Element SET Description='This is a partition key',Updated=TO_TIMESTAMP('2023-12-13 11:05:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203885
;

-- Dec 13, 2023, 11:05:16 AM MYT
UPDATE AD_Column SET ColumnName='IsPartitionKey', Name='Partition Key', Description='This is a partition key', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203885
;

-- Dec 13, 2023, 11:05:16 AM MYT
UPDATE AD_Process_Para SET ColumnName='IsPartitionKey', Name='Partition Key', Description='This is a partition key', Help=NULL, AD_Element_ID=203885 WHERE UPPER(ColumnName)='ISPARTITIONKEY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 13, 2023, 11:05:16 AM MYT
UPDATE AD_Process_Para SET ColumnName='IsPartitionKey', Name='Partition Key', Description='This is a partition key', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203885 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:05:16 AM MYT
UPDATE AD_InfoColumn SET ColumnName='IsPartitionKey', Name='Partition Key', Description='This is a partition key', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203885 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:05:16 AM MYT
UPDATE AD_Field SET Name='Partition Key', Description='This is a partition key', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203885) AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:08:03 AM MYT
UPDATE AD_Element SET Description='Indicates the order of partition keys', Help='The Partition Key Sequence indicates the order of the partition keys where the lowest number comes first',Updated=TO_TIMESTAMP('2023-12-13 11:08:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203886
;

-- Dec 13, 2023, 11:08:03 AM MYT
UPDATE AD_Column SET ColumnName='SeqNoPartition', Name='Partition Key Sequence', Description='Indicates the order of partition keys', Help='The Partition Key Sequence indicates the order of the partition keys where the lowest number comes first', Placeholder=NULL WHERE AD_Element_ID=203886
;

-- Dec 13, 2023, 11:08:03 AM MYT
UPDATE AD_Process_Para SET ColumnName='SeqNoPartition', Name='Partition Key Sequence', Description='Indicates the order of partition keys', Help='The Partition Key Sequence indicates the order of the partition keys where the lowest number comes first', AD_Element_ID=203886 WHERE UPPER(ColumnName)='SEQNOPARTITION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 13, 2023, 11:08:03 AM MYT
UPDATE AD_Process_Para SET ColumnName='SeqNoPartition', Name='Partition Key Sequence', Description='Indicates the order of partition keys', Help='The Partition Key Sequence indicates the order of the partition keys where the lowest number comes first', Placeholder=NULL WHERE AD_Element_ID=203886 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:08:03 AM MYT
UPDATE AD_InfoColumn SET ColumnName='SeqNoPartition', Name='Partition Key Sequence', Description='Indicates the order of partition keys', Help='The Partition Key Sequence indicates the order of the partition keys where the lowest number comes first', Placeholder=NULL WHERE AD_Element_ID=203886 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:08:03 AM MYT
UPDATE AD_Field SET Name='Partition Key Sequence', Description='Indicates the order of partition keys', Help='The Partition Key Sequence indicates the order of the partition keys where the lowest number comes first', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203886) AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:24:16 AM MYT
UPDATE AD_Element SET Description='Indicates the interval used in a range partitioning', Help='The Range Partition Interval indicates the interval used in a range partitioning (date or number). Examples of date intervals: 1 year; 6 months; Examples of number intervals: 5000; 100000;',Updated=TO_TIMESTAMP('2023-12-13 11:24:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203883
;

-- Dec 13, 2023, 11:24:16 AM MYT
UPDATE AD_Column SET ColumnName='RangePartitionInterval', Name='Range Partition Interval', Description='Indicates the interval used in a range partitioning', Help='The Range Partition Interval indicates the interval used in a range partitioning (date or number). Examples of date intervals: 1 year; 6 months; Examples of number intervals: 5000; 100000;', Placeholder=NULL WHERE AD_Element_ID=203883
;

-- Dec 13, 2023, 11:24:16 AM MYT
UPDATE AD_Process_Para SET ColumnName='RangePartitionInterval', Name='Range Partition Interval', Description='Indicates the interval used in a range partitioning', Help='The Range Partition Interval indicates the interval used in a range partitioning (date or number). Examples of date intervals: 1 year; 6 months; Examples of number intervals: 5000; 100000;', AD_Element_ID=203883 WHERE UPPER(ColumnName)='RANGEPARTITIONINTERVAL' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 13, 2023, 11:24:16 AM MYT
UPDATE AD_Process_Para SET ColumnName='RangePartitionInterval', Name='Range Partition Interval', Description='Indicates the interval used in a range partitioning', Help='The Range Partition Interval indicates the interval used in a range partitioning (date or number). Examples of date intervals: 1 year; 6 months; Examples of number intervals: 5000; 100000;', Placeholder=NULL WHERE AD_Element_ID=203883 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:24:16 AM MYT
UPDATE AD_InfoColumn SET ColumnName='RangePartitionInterval', Name='Range Partition Interval', Description='Indicates the interval used in a range partitioning', Help='The Range Partition Interval indicates the interval used in a range partitioning (date or number). Examples of date intervals: 1 year; 6 months; Examples of number intervals: 5000; 100000;', Placeholder=NULL WHERE AD_Element_ID=203883 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:24:16 AM MYT
UPDATE AD_Field SET Name='Range Partition Interval', Description='Indicates the interval used in a range partitioning', Help='The Range Partition Interval indicates the interval used in a range partitioning (date or number). Examples of date intervals: 1 year; 6 months; Examples of number intervals: 5000; 100000;', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203883) AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:28:17 AM MYT
UPDATE AD_Element SET Description='Process which create or update table partitions based on the table and column records', Help='The Create/update partition process will create or update table partitions based on the information in the table and column records',Updated=TO_TIMESTAMP('2023-12-13 11:28:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203884
;

-- Dec 13, 2023, 11:28:17 AM MYT
UPDATE AD_Column SET ColumnName='CreatePartition', Name='Create/update partition', Description='Process which create or update table partitions based on the table and column records', Help='The Create/update partition process will create or update table partitions based on the information in the table and column records', Placeholder=NULL WHERE AD_Element_ID=203884
;

-- Dec 13, 2023, 11:28:17 AM MYT
UPDATE AD_Process_Para SET ColumnName='CreatePartition', Name='Create/update partition', Description='Process which create or update table partitions based on the table and column records', Help='The Create/update partition process will create or update table partitions based on the information in the table and column records', AD_Element_ID=203884 WHERE UPPER(ColumnName)='CREATEPARTITION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 13, 2023, 11:28:17 AM MYT
UPDATE AD_Process_Para SET ColumnName='CreatePartition', Name='Create/update partition', Description='Process which create or update table partitions based on the table and column records', Help='The Create/update partition process will create or update table partitions based on the information in the table and column records', Placeholder=NULL WHERE AD_Element_ID=203884 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:28:17 AM MYT
UPDATE AD_InfoColumn SET ColumnName='CreatePartition', Name='Create/update partition', Description='Process which create or update table partitions based on the table and column records', Help='The Create/update partition process will create or update table partitions based on the information in the table and column records', Placeholder=NULL WHERE AD_Element_ID=203884 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:28:17 AM MYT
UPDATE AD_Field SET Name='Create/update partition', Description='Process which create or update table partitions based on the table and column records', Help='The Create/update partition process will create or update table partitions based on the information in the table and column records', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203884) AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:30:42 AM MYT
UPDATE AD_Element SET Description='Database Table Partition information', Help='The Database Table Partition provides the information of the table partition definition',Updated=TO_TIMESTAMP('2023-12-13 11:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203887
;

-- Dec 13, 2023, 11:30:42 AM MYT
UPDATE AD_Column SET ColumnName='AD_TablePartition_ID', Name='Table Partition', Description='Database Table Partition information', Help='The Database Table Partition provides the information of the table partition definition', Placeholder=NULL WHERE AD_Element_ID=203887
;

-- Dec 13, 2023, 11:30:42 AM MYT
UPDATE AD_Process_Para SET ColumnName='AD_TablePartition_ID', Name='Table Partition', Description='Database Table Partition information', Help='The Database Table Partition provides the information of the table partition definition', AD_Element_ID=203887 WHERE UPPER(ColumnName)='AD_TABLEPARTITION_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Dec 13, 2023, 11:30:42 AM MYT
UPDATE AD_Process_Para SET ColumnName='AD_TablePartition_ID', Name='Table Partition', Description='Database Table Partition information', Help='The Database Table Partition provides the information of the table partition definition', Placeholder=NULL WHERE AD_Element_ID=203887 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:30:42 AM MYT
UPDATE AD_InfoColumn SET ColumnName='AD_TablePartition_ID', Name='Table Partition', Description='Database Table Partition information', Help='The Database Table Partition provides the information of the table partition definition', Placeholder=NULL WHERE AD_Element_ID=203887 AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:30:42 AM MYT
UPDATE AD_Field SET Name='Table Partition', Description='Database Table Partition information', Help='The Database Table Partition provides the information of the table partition definition', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203887) AND IsCentrallyMaintained='Y'
;

-- Dec 13, 2023, 11:34:57 AM MYT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,IsShowNegateButton) VALUES (200448,0,0,'Y',TO_TIMESTAMP('2023-12-13 11:34:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 11:34:56','YYYY-MM-DD HH24:MI:SS'),100,'Partitioning Method',200157,10,17,200261,'N',2,'N','PartitioningMethod','N','D','@AD_Table_ID@=0 & @Record_ID@=0','c323eb12-5b81-456a-8f23-26a3865bc0f5','N','N','N')
;

-- Dec 13, 2023, 11:35:47 AM MYT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,IsShowNegateButton) VALUES (200449,0,0,'Y',TO_TIMESTAMP('2023-12-13 11:35:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 11:35:46','YYYY-MM-DD HH24:MI:SS'),100,'Table Name',200157,20,10,'N',27,'N',NULL,'TableName','N','D',NULL,'8cc028d6-fd10-4def-8181-bd8acb9e22c4','N','N','N')
;

-- Dec 13, 2023, 11:36:02 AM MYT
UPDATE AD_Process_Para SET DisplayLogic='@AD_Table_ID@=0 & @Record_ID@=0',Updated=TO_TIMESTAMP('2023-12-13 11:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200449
;

-- Dec 13, 2023, 11:36:46 AM MYT
UPDATE AD_Process SET Description='Process which create or update table partitions based on the table and column records', Help='The Create/update partition process will create or update table partitions based on the information in the table and column records',Updated=TO_TIMESTAMP('2023-12-13 11:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200157
;

-- Dec 13, 2023, 11:46:35 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to rename the original table',0,0,'Y',TO_TIMESTAMP('2023-12-13 11:46:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 11:46:34','YYYY-MM-DD HH24:MI:SS'),100,200845,'FailedRenameOriginalTable','D','6c2227d1-4fb9-40df-aefe-d11065aebca4')
;

-- Dec 13, 2023, 11:48:37 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Partitioning Method not supported: {0}',0,0,'Y',TO_TIMESTAMP('2023-12-13 11:48:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 11:48:36','YYYY-MM-DD HH24:MI:SS'),100,200846,'PartitioningMethodNotSupported','D','df6db5b6-7fee-4fa0-b759-3a94a22592b2')
;

-- Dec 13, 2023, 11:54:29 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to migrate database constraints',0,0,'Y',TO_TIMESTAMP('2023-12-13 11:54:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 11:54:28','YYYY-MM-DD HH24:MI:SS'),100,200847,'FailedMigrateDatabaseConstraints','D','21993b03-485c-4c0c-a90a-e9f9faf453b4')
;

-- Dec 13, 2023, 11:55:14 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to attach to the default partition',0,0,'Y',TO_TIMESTAMP('2023-12-13 11:55:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 11:55:13','YYYY-MM-DD HH24:MI:SS'),100,200848,'FailedAttachDefaultPartition','D','e9c6c9ad-9d2f-4d10-9e86-668dce78e10b')
;

-- Dec 13, 2023, 11:58:55 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to create the partitioned table',0,0,'Y',TO_TIMESTAMP('2023-12-13 11:58:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 11:58:54','YYYY-MM-DD HH24:MI:SS'),100,200849,'FailedCreatePartitionedTable','D','aba471b7-75ac-404a-aaba-49af561d32cc')
;

-- Dec 13, 2023, 12:00:12 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to migrate data',0,0,'Y',TO_TIMESTAMP('2023-12-13 12:00:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 12:00:11','YYYY-MM-DD HH24:MI:SS'),100,200850,'FailedMigrateData','D','9e23b23b-c339-441e-ad0b-0c12e9f494df')
;

-- Dec 13, 2023, 12:01:26 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to run post migration data',0,0,'Y',TO_TIMESTAMP('2023-12-13 12:01:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 12:01:25','YYYY-MM-DD HH24:MI:SS'),100,200851,'FailedRunPostMigrationData','D','393cf32e-97e0-4550-8cd7-ccb79899095c')
;

-- Dec 13, 2023, 12:02:44 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','At least one partition key is required',0,0,'Y',TO_TIMESTAMP('2023-12-13 12:02:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 12:02:44','YYYY-MM-DD HH24:MI:SS'),100,200852,'PartitionKeyRequired','D','73b18dec-f7f4-460f-8461-795a78e8fa7a')
;

-- Dec 13, 2023, 12:09:23 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Changed in the partitioning method or partition key(s)',0,0,'Y',TO_TIMESTAMP('2023-12-13 12:09:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 12:09:22','YYYY-MM-DD HH24:MI:SS'),100,200853,'PartitionConfigurationChanged','D','b4ccf587-4631-42ae-a6c5-0e0d005b3f27')
;

