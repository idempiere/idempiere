SET SQLBLANKLINES ON
SET DEFINE OFF

-- File = 3820_Revenue_recognition.xml
-- Migration Revenue recognition, SeqNo=3820
-- Step SeqNo = 10, StepType = AD
INSERT INTO AD_Table(AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Window_ID,AccessLevel,Created,CreatedBy,Description,EntityType,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,ReplicationType,TableName,Updated,UpdatedBy,AD_Table_UU) VALUES (0,0,53888,174,'1',TO_DATE('2014-10-28 11:39:41','YYYY-MM-DD HH24:MI:SS'),100,'Plan for recognizing or recording revenue based on service','D','Y','Y','N','Y','N','N','N','135','Revenue Recognition Service','L','C_RevenueRecognition_Service',TO_DATE('2014-10-28 11:39:41','YYYY-MM-DD HH24:MI:SS'),100,'833c94dc-3df8-4105-99a6-e224969e01f7');

-- Step SeqNo = 20, StepType = AD
INSERT INTO AD_Sequence(AD_Client_ID,AD_Org_ID,AD_Sequence_ID,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy,AD_Sequence_UU) VALUES (0,0,54047,TO_DATE('2014-10-28 11:39:46','YYYY-MM-DD HH24:MI:SS'),100,'1000000','50000','Table C_RevenueRecognition_Service','1','Y','N','Y','Y','C_RevenueRecognition_Service','N','1000000',TO_DATE('2014-10-28 11:39:46','YYYY-MM-DD HH24:MI:SS'),100,'3681cc25-0bec-40f0-943a-560503ad9e3e');

-- Step SeqNo = 30, StepType = AD
INSERT INTO AD_Column(DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,AD_Val_Rule_ID,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES ('@AD_Client_ID@',74644,53888,'D','1','Y','N','N','0',100,TO_DATE('2014-10-28 11:40:47','YYYY-MM-DD HH24:MI:SS'),'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,'N','Y','22','N',19,TO_DATE('2014-10-28 11:40:47','YYYY-MM-DD HH24:MI:SS'),129,'N',102,100,'N','N','N','AD_Client_ID','Client/Tenant for this installation.','Client','N',0,'162ba895-dbf1-415a-8263-7afd1698ed42');

-- Step SeqNo = 40, StepType = AD
INSERT INTO AD_Column(DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,AD_Val_Rule_ID,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES ('@AD_Org_ID@',74645,53888,'D','1','Y','N','N','0',100,TO_DATE('2014-10-28 11:40:51','YYYY-MM-DD HH24:MI:SS'),'An organisation is a unit of your client or legal entity - examples are store, department. You can share data between organisations.',0,'N','Y','22','N',19,TO_DATE('2014-10-28 11:40:51','YYYY-MM-DD HH24:MI:SS'),130,'N',113,100,'N','N','N','AD_Org_ID','Organisational entity within client','Organisation','N',0,'a0cc2c33-4222-48f5-b976-a1a3aba834ea');

-- Step SeqNo = 80, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES (74649,53888,'D','1','Y','N','Y','1',100,TO_DATE('2014-10-28 11:41:06','YYYY-MM-DD HH24:MI:SS'),'The Revenue Recognition indicates how revenue will be recognized for this product',0,'Y','Y','22','N',19,TO_DATE('2014-10-28 11:41:06','YYYY-MM-DD HH24:MI:SS'),'N',1078,100,'N','N','N','C_RevenueRecognition_ID','Method for recording revenue','Revenue Recognition','N',0,'4678f5ff-a1cb-4cd4-8803-b1b3e38ad2fc');

-- Step SeqNo = 90, StepType = AD
INSERT INTO AD_Element(AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy,AD_Element_UU) VALUES (0,57527,0,'C_RevenueRecognition_Service_I',TO_DATE('2014-10-28 11:41:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Revenue Recognition Service','Revenue Recognition Service',TO_DATE('2014-10-28 11:41:10','YYYY-MM-DD HH24:MI:SS'),100,'11df9ee7-d5b8-44a5-88f2-dedaa9cd44df');

-- Step SeqNo = 100, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES (74650,53888,'D','1','Y','N','N','0',100,TO_DATE('2014-10-28 11:41:09','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','22','N',13,TO_DATE('2014-10-28 11:41:09','YYYY-MM-DD HH24:MI:SS'),'Y',57527,100,'N','N','N','C_RevenueRecognition_Service_I','Revenue Recognition Service','N',0,'ddada063-14b9-4a03-8f4b-6d57a5dd1ce2');

-- Step SeqNo = 110, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES (74651,53888,'D','1','Y','N','N','0',100,TO_DATE('2014-10-28 11:41:16','YYYY-MM-DD HH24:MI:SS'),'The Created field indicates the date that this record was created.',0,'N','Y','7','N',16,TO_DATE('2014-10-28 11:41:16','YYYY-MM-DD HH24:MI:SS'),'N',245,100,'N','N','N','Created','Date this record was created','Created','N',0,'0ed8bf8e-ea79-4233-a370-f51af2839fbb');

-- Step SeqNo = 120, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES (74652,53888,'D','1',110,'Y','N','N','0',100,TO_DATE('2014-10-28 11:41:20','YYYY-MM-DD HH24:MI:SS'),'The Created By field indicates the user who created this record.',0,'N','Y','22','N',18,TO_DATE('2014-10-28 11:41:20','YYYY-MM-DD HH24:MI:SS'),'N',246,100,'N','N','N','CreatedBy','User who created this records','Created By','N',0,'f5eabfcf-d99f-4cee-b0e6-f0fc0ce73e0a');

-- Step SeqNo = 130, StepType = AD
INSERT INTO AD_Column(DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES ('Y',74653,53888,'D','1','Y','N','N','0',100,TO_DATE('2014-10-28 11:41:24','YYYY-MM-DD HH24:MI:SS'),'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,'N','Y','1','N',20,TO_DATE('2014-10-28 11:41:24','YYYY-MM-DD HH24:MI:SS'),'N',348,100,'N','Y','N','IsActive','The record is active in the system','Active','N',0,'4496768c-7a55-4d49-9294-45edb4528ff6');

-- Step SeqNo = 180, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES (74658,53888,'D','1','Y','N','N','0',100,TO_DATE('2014-10-28 11:41:43','YYYY-MM-DD HH24:MI:SS'),'The Updated field indicates the date that this record was updated.',0,'N','Y','7','N',16,TO_DATE('2014-10-28 11:41:43','YYYY-MM-DD HH24:MI:SS'),'N',607,100,'N','N','N','Updated','Date this record was updated','Updated','N',0,'9384d25d-e719-4db4-b640-0b14c4ae3e58');

-- Step SeqNo = 190, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,AD_Column_UU) VALUES (74659,53888,'D','1',110,'Y','N','N','0',100,TO_DATE('2014-10-28 11:41:47','YYYY-MM-DD HH24:MI:SS'),'The Updated By field indicates the user who updated this record.',0,'N','Y','22','N',18,TO_DATE('2014-10-28 11:41:47','YYYY-MM-DD HH24:MI:SS'),'N',608,100,'N','N','N','UpdatedBy','User who updated this records','Updated By','N',0,'6a938db8-5b02-45a6-a64a-cb3af8e74352');

-- Step SeqNo = 200, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,IsSecure,AD_Column_UU) VALUES (74660,53888,'D','0','N','N','N','0',100,TO_DATE('2014-10-28 11:47:05','YYYY-MM-DD HH24:MI:SS'),'A description is limited to 255 characters.',0,'N','Y','255','Y',10,TO_DATE('2014-10-28 11:47:05','YYYY-MM-DD HH24:MI:SS'),'N',275,100,'N','Y','N','Y','N','Description','Optional short description of the record','Description','N',0,'N','f4c5aef9-310c-4c84-8f23-397c1c185dc2');

-- Step SeqNo = 210, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,IsSecure,AD_Column_UU) VALUES (74661,53888,'D','0','N','N','N','0',100,TO_DATE('2014-10-28 11:48:18','YYYY-MM-DD HH24:MI:SS'),'The Percent indicates the percentage used.',0,'N','Y','10','N',12,TO_DATE('2014-10-28 11:48:18','YYYY-MM-DD HH24:MI:SS'),'N',951,100,'N','Y','N','Y','N','Percent','Percentage','Percent','N',0,'N','82a993ff-84fc-48d1-90cf-278d8932d3d9');

-- Step SeqNo = 220, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,Help,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsSyncDatabase,AD_Org_ID,IsSecure,AD_Column_UU) VALUES (74662,53888,'D','0','N','N','N','0',100,TO_DATE('2014-10-28 11:48:54','YYYY-MM-DD HH24:MI:SS'),'Indicates the unique line for a document.  It will also control the display order of the lines within a document.',0,'N','Y','10','N',11,TO_DATE('2014-10-28 11:48:54','YYYY-MM-DD HH24:MI:SS'),'N',439,100,'N','Y','N','Y','N','Line','Unique line for this document','Line No','N',0,'N','cec34917-4f48-4420-beb5-1fc18e678ff5');

-- Step SeqNo = 230, StepType = AD
INSERT INTO AD_Tab(AD_Client_ID,AD_Column_ID,AD_Org_ID,AD_Tab_ID,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy,AD_Tab_UU) VALUES (0,74649,0,54010,53888,174,TO_DATE('2014-10-28 11:51:07','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','N','N','N','Service','N','15','1',TO_DATE('2014-10-28 11:51:07','YYYY-MM-DD HH24:MI:SS'),100,'1318769d-126e-4dff-845a-91986295d34f');

-- Step SeqNo = 240, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74653,74741,0,54010,TO_DATE('2014-10-28 11:51:16','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system','1','D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',TO_DATE('2014-10-28 11:51:16','YYYY-MM-DD HH24:MI:SS'),100,'a9be764b-77e8-43ab-aca6-3d7ebf3a431c');

-- Step SeqNo = 250, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74644,74742,0,54010,TO_DATE('2014-10-28 11:51:19','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.','22','D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','Client',TO_DATE('2014-10-28 11:51:19','YYYY-MM-DD HH24:MI:SS'),100,'89c58d7c-c56a-4325-a7e5-00d6b9993867');

-- Step SeqNo = 260, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74660,74743,0,54010,TO_DATE('2014-10-28 11:51:23','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','255','D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',TO_DATE('2014-10-28 11:51:23','YYYY-MM-DD HH24:MI:SS'),100,'61a18e8d-1a14-4335-abca-d055ec25f634');

-- Step SeqNo = 270, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74662,74744,0,54010,TO_DATE('2014-10-28 11:51:26','YYYY-MM-DD HH24:MI:SS'),100,'Unique line for this document','10','D','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','Y','Y','Y','N','N','N','N','N','Line No',TO_DATE('2014-10-28 11:51:26','YYYY-MM-DD HH24:MI:SS'),100,'30b213d1-479a-41dd-beb3-11ab483119df');

-- Step SeqNo = 280, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74645,74745,0,54010,TO_DATE('2014-10-28 11:51:29','YYYY-MM-DD HH24:MI:SS'),100,'Organisational entity within client','22','D','An organisation is a unit of your client or legal entity - examples are store, department. You can share data between organisations.','Y','Y','Y','N','N','N','N','N','Organisation',TO_DATE('2014-10-28 11:51:29','YYYY-MM-DD HH24:MI:SS'),100,'769dcd46-ed5e-462e-9c53-cc8ce1761e8c');

-- Step SeqNo = 290, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74661,74746,0,54010,TO_DATE('2014-10-28 11:51:31','YYYY-MM-DD HH24:MI:SS'),100,'Percentage','10','D','The Percent indicates the percentage used.','Y','Y','Y','N','N','N','N','N','Percent',TO_DATE('2014-10-28 11:51:31','YYYY-MM-DD HH24:MI:SS'),100,'ccfd985b-8d28-4fe7-ad04-b10a331014fe');

-- Step SeqNo = 300, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74649,74747,0,54010,TO_DATE('2014-10-28 11:51:35','YYYY-MM-DD HH24:MI:SS'),100,'Method for recording revenue','22','D','The Revenue Recognition indicates how revenue will be recognized for this product','Y','Y','Y','N','N','N','N','N','Revenue Recognition',TO_DATE('2014-10-28 11:51:35','YYYY-MM-DD HH24:MI:SS'),100,'335a8b7b-90bf-4436-8c69-cf5225b95be7');

-- Step SeqNo = 310, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74650,74748,0,54010,TO_DATE('2014-10-28 11:51:38','YYYY-MM-DD HH24:MI:SS'),100,'22','D','Y','Y','N','N','N','N','N','N','Revenue Recognition Service',TO_DATE('2014-10-28 11:51:38','YYYY-MM-DD HH24:MI:SS'),100,'df66a794-719b-426e-82a7-e67bf0b636b5');

-- Step SeqNo = 320, StepType = AD
UPDATE AD_Field SET IsDisplayed='N',SeqNo='0' WHERE AD_Field_ID=74741;

-- Step SeqNo = 330, StepType = AD
UPDATE AD_Field SET SeqNo='10' WHERE AD_Field_ID=74742;

-- Step SeqNo = 340, StepType = AD
UPDATE AD_Field SET SeqNo='20' WHERE AD_Field_ID=74745;

-- Step SeqNo = 350, StepType = AD
UPDATE AD_Field SET SeqNo='30' WHERE AD_Field_ID=74747;

-- Step SeqNo = 360, StepType = AD
UPDATE AD_Field SET SeqNo='40' WHERE AD_Field_ID=74744;

-- Step SeqNo = 370, StepType = AD
UPDATE AD_Field SET SeqNo='50' WHERE AD_Field_ID=74746;

-- Step SeqNo = 380, StepType = AD
UPDATE AD_Field SET SeqNo='60' WHERE AD_Field_ID=74743;

-- Step SeqNo = 390, StepType = AD
UPDATE AD_Field SET IsSameLine='Y' WHERE AD_Field_ID=74745;

-- Step SeqNo = 400, StepType = AD
UPDATE AD_Field SET IsSameLine='Y' WHERE AD_Field_ID=74746;

-- Step SeqNo = 410, StepType = AD
UPDATE AD_Field SET IsReadOnly='Y' WHERE AD_Field_ID=74742;

-- Step SeqNo = 420, StepType = AD
UPDATE AD_Field SET IsReadOnly='Y' WHERE AD_Field_ID=74745;

-- Step SeqNo = 430, StepType = AD
UPDATE AD_Tab SET Parent_Column_ID=3918 WHERE AD_Tab_ID=54010;

-- Step SeqNo = 440, StepType = AD
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MAX(Line),0)+10 FROM C_RevenueRecognition_Service WHERE C_RevenueRecognition_ID=@C_RevenueRecognition_ID@' WHERE AD_Column_ID=74662;

-- Step SeqNo = 450, StepType = AD
UPDATE AD_Tab SET DisplayLogic='@IsTimeBased@=''N''' WHERE AD_Tab_ID=54010;

-- Step SeqNo = 460, StepType = AD
UPDATE AD_Field SET IsSameLine='Y' WHERE AD_Field_ID=4834;

-- Step SeqNo = 470, StepType = AD
UPDATE AD_Field SET IsSameLine='Y' WHERE AD_Field_ID=4832;

-- Step SeqNo = 480, StepType = AD
UPDATE AD_Window SET WinHeight='500',WinWidth='1000' WHERE AD_Window_ID=174;

-- Step SeqNo = 490, StepType = AD
UPDATE AD_Element SET ColumnName='C_RevenueRecog_Service_ID' WHERE AD_Element_ID=57527;

-- Step SeqNo = 500, StepType = AD
UPDATE AD_Table SET TableName='C_RevenueRecog_Service' WHERE AD_Table_ID=53888;

-- Step SeqNo = 520, StepType = AD
INSERT INTO AD_Element(AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy,AD_Element_UU) VALUES (0,57528,0,'DateRecognized',TO_DATE('2014-10-28 12:14:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Recognition Date','Recognition Date',TO_DATE('2014-10-28 12:14:14','YYYY-MM-DD HH24:MI:SS'),100,'1af0f323-b3d0-4750-9da9-fc96cc248aa6');

-- Step SeqNo = 530, StepType = AD
INSERT INTO AD_Column(AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,CreatedBy,Updated,AD_Client_ID,IsParent,IsActive,FieldLength,IsSelectionColumn,AD_Reference_ID,Created,IsKey,AD_Element_ID,UpdatedBy,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsSyncDatabase,AD_Org_ID,IsSecure,AD_Column_UU) VALUES (74663,444,'D','0','N','N','N','0',100,TO_DATE('2014-10-28 12:14:41','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','7','N',15,TO_DATE('2014-10-28 12:14:41','YYYY-MM-DD HH24:MI:SS'),'N',57528,100,'N','Y','N','Y','N','DateRecognized','Recognition Date','N',0,'N','a2a2f66a-e6da-4858-bdae-68f8b3f6798c');

-- Step SeqNo = 540, StepType = AD
INSERT INTO AD_Field(AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy,AD_Field_UU) VALUES (0,74663,74749,0,379,TO_DATE('2014-10-28 12:47:32','YYYY-MM-DD HH24:MI:SS'),100,'7','D','Y','Y','Y','N','N','N','N','N','Recognition Date',TO_DATE('2014-10-28 12:47:32','YYYY-MM-DD HH24:MI:SS'),100,'a27b2876-5b35-4325-9013-6553458347a8');

-- Step SeqNo = 550, StepType = AD
UPDATE AD_Field SET SeqNo='0' WHERE AD_Field_ID=4829;

-- Step SeqNo = 560, StepType = AD
UPDATE AD_Field SET SeqNo='10' WHERE AD_Field_ID=4830;

-- Step SeqNo = 570, StepType = AD
UPDATE AD_Field SET SeqNo='20' WHERE AD_Field_ID=4834;

-- Step SeqNo = 580, StepType = AD
UPDATE AD_Field SET SeqNo='30' WHERE AD_Field_ID=4831;

-- Step SeqNo = 590, StepType = AD
UPDATE AD_Field SET SeqNo='40' WHERE AD_Field_ID=4835;

-- Step SeqNo = 600, StepType = AD
UPDATE AD_Field SET SeqNo='50' WHERE AD_Field_ID=74749;

-- Step SeqNo = 610, StepType = AD
UPDATE AD_Field SET SeqNo='60' WHERE AD_Field_ID=4832;

-- Step SeqNo = 620, StepType = AD
UPDATE AD_Field SET SeqNo='70' WHERE AD_Field_ID=4833;

-- Step SeqNo = 630, StepType = AD
UPDATE AD_Tab SET IsReadOnly='N' WHERE AD_Tab_ID=379;

-- Step SeqNo = 640, StepType = AD
INSERT INTO AD_Process(AD_Client_ID,AD_Org_ID,AD_Process_ID,AccessLevel,Classname,CopyFromProcess,Created,CreatedBy,Description,EntityType,IsActive,IsBetaFunctionality,IsDirectPrint,IsReport,IsServerProcess,Name,ShowHelp,Statistic_Count,Statistic_Seconds,Updated,UpdatedBy,Value,AD_Process_UU) VALUES (0,0,53710,'3','org.compiere.process.RevenueRecognition','N',TO_DATE('2014-10-28 13:14:54','YYYY-MM-DD HH24:MI:SS'),100,'Generate journal entries based on valid revenue recognition run entries','D','Y','N','N','N','N','Revenue Recognition Run','Y','0','0',TO_DATE('2014-10-28 13:14:54','YYYY-MM-DD HH24:MI:SS'),100,'C_RevenueRecognition','48c2742a-be9f-40fb-94eb-85297a7fca49');

-- Step SeqNo = 650, StepType = AD
INSERT INTO AD_Process_Para(AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,AD_Reference_Value_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy,AD_Process_Para_UU) VALUES (0,196,0,53710,55002,18,170,'C_DocType_ID',TO_DATE('2014-10-28 13:15:43','YYYY-MM-DD HH24:MI:SS'),100,'D','10','Y','Y','Y','N','Document Type','10',TO_DATE('2014-10-28 13:15:43','YYYY-MM-DD HH24:MI:SS'),100,'b21af721-dab7-4632-a49c-a9f3cbef22b1');

-- Step SeqNo = 660, StepType = AD
INSERT INTO AD_Process_Para(AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy,AD_Process_Para_UU) VALUES (0,263,0,53710,55003,15,'DateAcct',TO_DATE('2014-10-28 13:16:14','YYYY-MM-DD HH24:MI:SS'),100,'D','0','Y','Y','Y','N','Date','20',TO_DATE('2014-10-28 13:16:14','YYYY-MM-DD HH24:MI:SS'),100,'9d9daf55-fe52-4b7d-896e-6d45880e6566');

-- Step SeqNo = 670, StepType = AD
UPDATE AD_Process_Para SET FieldLength='7' WHERE AD_Process_Para_ID=55003;

-- Step SeqNo = 680, StepType = AD
INSERT INTO AD_Process_Para(AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy,AD_Process_Para_UU) VALUES (0,1078,0,53710,55004,19,'C_RevenueRecognition_ID',TO_DATE('2014-10-28 13:17:03','YYYY-MM-DD HH24:MI:SS'),100,'D','10','Y','Y','N','N','Revenue Recognition','30',TO_DATE('2014-10-28 13:17:03','YYYY-MM-DD HH24:MI:SS'),100,'c5723c3d-419a-406c-a33f-b5edf481e652');

-- Step SeqNo = 690, StepType = AD
INSERT INTO AD_Menu(AD_Client_ID,AD_Menu_ID,AD_Org_ID,AD_Process_ID,Action,Created,CreatedBy,EntityType,IsActive,IsCentrallyMaintained,IsReadOnly,IsSOTrx,IsSummary,Name,Updated,UpdatedBy,AD_Menu_UU) VALUES (0,53885,0,53710,'P',TO_DATE('2014-10-28 13:17:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Y','N','N','N','Revenue Recognition Run',TO_DATE('2014-10-28 13:17:37','YYYY-MM-DD HH24:MI:SS'),100,'7e9b6837-4f50-4fb7-b7ae-78bbb2a77ba0');

-- Step SeqNo = 700, StepType = AD
UPDATE AD_Process SET Description='Generate revenue recognition journal',Help='Generate GL journal based on valid revenue recognition run entries' WHERE AD_Process_ID=53710;

-- Step SeqNo = 710, StepType = AD
UPDATE AD_Menu SET Description='Generate revenue recognition journal' WHERE AD_Menu_ID=53885;

-- Step SeqNo = 720, StepType = AD
UPDATE AD_Tab SET OrderByClause='C_RevenueRecognition_Run.C_RevenueRecognition_Run_ID' WHERE AD_Tab_ID=379;

-- Step SeqNo = 730, StepType = AD
UPDATE AD_Tab SET AD_Column_ID=5983 WHERE AD_Tab_ID=379;

-- Step SeqNo = 740, StepType = SQL
--ALTER TABLE c_revenuerecognition_run ALTER COLUMN gl_journal_id DROP NOT NULL;


-- File = 3830_revenue_recognition_process.xml
-- Migration Revenue recognition process, SeqNo=3830
-- Step SeqNo = 10, StepType = AD
--INSERT INTO AD_Process(AD_Client_ID,AD_Org_ID,AD_Process_ID,AccessLevel,Classname,CopyFromProcess,Created,CreatedBy,Description,EntityType,IsActive,IsBetaFunctionality,IsDirectPrint,IsReport,IsServerProcess,Name,ShowHelp,Statistic_Count,Statistic_Seconds,Updated,UpdatedBy,Value,AD_Process_UU) VALUES (0,0,53710,'3','org.compiere.process.RevenueRecognition','N',TO_DATE('2014-10-28 13:14:54','YYYY-MM-DD HH24:MI:SS'),100,'Generate journal entries based on valid revenue recognition run entries','D','Y','N','N','N','N','Revenue Recognition Run','Y','0','0',TO_DATE('2014-10-28 13:14:54','YYYY-MM-DD HH24:MI:SS'),100,'C_RevenueRecognition','6b4adee2-46d2-422e-9dc7-4ab88b4caacb');

-- Step SeqNo = 20, StepType = AD
--INSERT INTO AD_Process_Para(AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,AD_Reference_Value_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy,AD_Process_Para_UU) VALUES (0,196,0,53710,55002,18,170,'C_DocType_ID',TO_DATE('2014-10-28 13:15:43','YYYY-MM-DD HH24:MI:SS'),100,'D','10','Y','Y','Y','N','Document Type','10',TO_DATE('2014-10-28 13:15:43','YYYY-MM-DD HH24:MI:SS'),100,'e96484b3-b7de-4217-9337-be9ff72da09b');

-- Step SeqNo = 30, StepType = AD
--INSERT INTO AD_Process_Para(AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy,AD_Process_Para_UU) VALUES (0,263,0,53710,55003,15,'DateAcct',TO_DATE('2014-10-28 13:16:14','YYYY-MM-DD HH24:MI:SS'),100,'D','0','Y','Y','Y','N','Date','20',TO_DATE('2014-10-28 13:16:14','YYYY-MM-DD HH24:MI:SS'),100,'c0f66c1a-59b6-4e54-a09e-cd9fc6acf4bc');

-- Step SeqNo = 40, StepType = AD
--UPDATE AD_Process_Para SET FieldLength='7' WHERE AD_Process_Para_ID=55003;

-- Step SeqNo = 50, StepType = AD
--INSERT INTO AD_Process_Para(AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy,AD_Process_Para_UU) VALUES (0,1078,0,53710,55004,19,'C_RevenueRecognition_ID',TO_DATE('2014-10-28 13:17:03','YYYY-MM-DD HH24:MI:SS'),100,'D','10','Y','Y','N','N','Revenue Recognition','30',TO_DATE('2014-10-28 13:17:03','YYYY-MM-DD HH24:MI:SS'),100,'ef1332d8-a888-43fb-b0d8-99ff37e05ac0');

-- Step SeqNo = 60, StepType = AD
--INSERT INTO AD_Menu(AD_Client_ID,AD_Menu_ID,AD_Org_ID,AD_Process_ID,Action,Created,CreatedBy,EntityType,IsActive,IsCentrallyMaintained,IsReadOnly,IsSOTrx,IsSummary,Name,Updated,UpdatedBy,AD_Menu_UU) VALUES (0,53885,0,53710,'P',TO_DATE('2014-10-28 13:17:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Y','N','N','N','Revenue Recognition Run',TO_DATE('2014-10-28 13:17:37','YYYY-MM-DD HH24:MI:SS'),100,'63ae1179-1642-4529-ad26-0cfa0f4226c6');

-- Step SeqNo = 70, StepType = AD
UPDATE AD_Process SET Description='Generate revenue recognition journal',Help='Generate GL journal based on valid revenue recognition run entries' WHERE AD_Process_ID=53710;

-- Step SeqNo = 80, StepType = AD
UPDATE AD_Menu SET Description='Generate revenue recognition journal' WHERE AD_Menu_ID=53885;

-- File = 4760_Rev_recog_update.xml
-- Migration Revenue recognition changes, SeqNo=4760
-- Step SeqNo = 10, StepType = AD
UPDATE AD_Column SET IsMandatory='N' WHERE AD_Column_ID=5984;

-- Step SeqNo = 20, StepType = AD
UPDATE AD_Field SET IsDisplayed='Y',SeqNo='40' WHERE AD_Field_ID=74741;

-- Step SeqNo = 30, StepType = AD
UPDATE AD_Field SET SeqNo='50' WHERE AD_Field_ID=74744;

-- Step SeqNo = 40, StepType = AD
UPDATE AD_Field SET SeqNo='60' WHERE AD_Field_ID=74746;

-- Step SeqNo = 50, StepType = AD
UPDATE AD_Field SET SeqNo='70' WHERE AD_Field_ID=74743;

-- Step SeqNo = 60, StepType = AD
UPDATE AD_Field SET IsSameLine='Y' WHERE AD_Field_ID=74741;

-- Step SeqNo = 70, StepType = AD
UPDATE AD_Field SET IsDisplayedGrid='Y' WHERE AD_Field_ID=74742;

-- Step SeqNo = 80, StepType = AD
UPDATE AD_Field SET IsDisplayedGrid='Y' WHERE AD_Field_ID=74745;

-- Step SeqNo = 90, StepType = AD
UPDATE AD_Field SET IsDisplayedGrid='Y' WHERE AD_Field_ID=74747;

-- Step SeqNo = 100, StepType = AD
UPDATE AD_Field SET IsDisplayedGrid='Y' WHERE AD_Field_ID=74741;

-- Step SeqNo = 110, StepType = AD
UPDATE AD_Field SET IsDisplayedGrid='Y' WHERE AD_Field_ID=74744;

-- Step SeqNo = 120, StepType = AD
UPDATE AD_Field SET IsDisplayedGrid='Y' WHERE AD_Field_ID=74746;

-- Step SeqNo = 130, StepType = AD
UPDATE AD_Field SET IsDisplayedGrid='Y' WHERE AD_Field_ID=74743;

-- Step SeqNo = 140, StepType = AD
UPDATE AD_Field SET IsDisplayedGrid='Y' WHERE AD_Field_ID=74749;

-- Step SeqNo = 150, StepType = AD
INSERT INTO AD_Column(AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSecure,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,IsActive,Created,UpdatedBy,AD_Column_ID,AD_Org_ID,AD_Column_UU) VALUES (444,'D','0','N','N','N','0','N','10','N',19,'N','N','N',57527,'N','Y','N','Y','N','C_RevenueRecog_Service_ID','Revenue Recognition Service','Y',100,TO_DATE('2015-08-26 00:38:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2015-08-26 00:38:16','YYYY-MM-DD HH24:MI:SS'),100,77928,0,'e3f17477-6545-4694-bac4-6280147344f3');

-- Step SeqNo = 160, StepType = AD
INSERT INTO AD_Field(IsEncrypted,Created,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,IsReadOnly,EntityType,Name,UpdatedBy,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Field_ID,AD_Org_ID,AD_Field_UU) VALUES ('N',TO_DATE('2015-08-26 00:38:27','YYYY-MM-DD HH24:MI:SS'),'10','Y','N','N',77928,'N','Y',379,'N','D','Revenue Recognition Service',100,'Y',0,100,TO_DATE('2015-08-26 00:38:27','YYYY-MM-DD HH24:MI:SS'),77047,0,'a186c69e-44d7-45dc-a461-98dfd8238f1c');

-- Step SeqNo = 170, StepType = AD
UPDATE AD_Field SET SeqNo='50' WHERE AD_Field_ID=77047;

-- Step SeqNo = 180, StepType = AD
UPDATE AD_Field SET SeqNo='60' WHERE AD_Field_ID=74749;

-- Step SeqNo = 190, StepType = AD
UPDATE AD_Field SET SeqNo='70' WHERE AD_Field_ID=4832;

-- Step SeqNo = 200, StepType = AD
UPDATE AD_Field SET SeqNo='80' WHERE AD_Field_ID=4833;

-- Step SeqNo = 210, StepType = AD
UPDATE AD_Field SET IsReadOnly='Y' WHERE AD_Field_ID=77047;

-- Step SeqNo = 220, StepType = AD
UPDATE AD_Column SET IsIdentifier='Y',SeqNo='2' WHERE AD_Column_ID=74662;

-- Step SeqNo = 230, StepType = AD
UPDATE AD_Column SET IsIdentifier='Y',SeqNo='3' WHERE AD_Column_ID=74660;

-- Step SeqNo = 240, StepType = AD
INSERT INTO AD_Element(ColumnName,AD_Client_ID,Help,EntityType,Name,Description,PrintName,Created,Updated,IsActive,CreatedBy,UpdatedBy,AD_Element_ID,AD_Org_ID,AD_Element_UU) VALUES ('FixedRecogDay',0,'The Fix Recognition Day indicates the day of the period that unearned revenue is recognised. If zero, the invoice date is used.','D','Fixed recognition day','Day of the period recognition occurs','Fixed recognition day',TO_DATE('2015-08-26 11:13:46','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2015-08-26 11:13:46','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,58294,0,'06ed8fd6-89bf-4596-9a7a-6040bf80cebf');

-- Step SeqNo = 250, StepType = AD
INSERT INTO AD_Column(AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSecure,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,IsActive,Created,UpdatedBy,AD_Column_ID,AD_Org_ID,AD_Column_UU) VALUES (336,'D','0','N','N','N','0','The Fix Recognition Day indicates the day of the period that unearned revenue is recognised. If zero, the invoice date is used.','N','22','N',11,'N','N','N',58294,'N','Y','N','Y','N','FixedRecogDay','Day of the period recognition occurs','Fixed recognition day','Y',100,TO_DATE('2015-08-26 11:14:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2015-08-26 11:14:02','YYYY-MM-DD HH24:MI:SS'),100,77929,0,'8ec4b7bc-4426-44c1-b42c-6f4be1ee02bd');

-- Step SeqNo = 260, StepType = AD
INSERT INTO AD_Field(IsEncrypted,Created,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Field_ID,AD_Org_ID,AD_Field_UU) VALUES ('N',TO_DATE('2015-08-26 11:14:16','YYYY-MM-DD HH24:MI:SS'),'22','Y','N','N',77929,'N','Y',272,'N','The Fix Recognition Day indicates the day of the period that unearned revenue is recognised. If zero, the invoice date is used.','D','Day of the period recognition occurs','Fixed recognition day',100,'Y',0,100,TO_DATE('2015-08-26 11:14:16','YYYY-MM-DD HH24:MI:SS'),77048,0,'d361f6e4-0597-4ab6-b511-cfdda309ed36');

-- Step SeqNo = 270, StepType = AD
UPDATE AD_Field SET DisplayLogic='@IsTimeBased@=Y' WHERE AD_Field_ID=77048;

SELECT register_migration_script('201811271750_RevenueRecognitionAdaxa.sql') FROM dual
;

