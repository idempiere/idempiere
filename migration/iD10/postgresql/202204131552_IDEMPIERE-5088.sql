-- IDEMPIERE-5088 Implement Bank Transfer as Transactional Document like Payment
SELECT register_migration_script('202204131552_IDEMPIERE-5088.sql') FROM dual;

-- Apr 13, 2022, 3:52:00 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214756,1,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200246,'DateAcct','@#Date@',7,'N','N','Y','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2022-04-13 15:51:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-13 15:51:58','YYYY-MM-DD HH24:MI:SS'),100,263,'Y','N','D','N','N','N','Y','03a2ce12-1343-477c-96d1-82ebbdd7d9c7','Y',0,'N','N','N')
;

-- Apr 13, 2022, 3:52:05 PM MYT
ALTER TABLE C_BankTransfer ADD COLUMN DateAcct TIMESTAMP NOT NULL
;

-- Apr 13, 2022, 3:53:38 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214757,0,'Currency Type','Currency Conversion Rate Type','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.',200246,'C_ConversionType_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-04-13 15:53:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-13 15:53:38','YYYY-MM-DD HH24:MI:SS'),100,2278,'Y','N','D','N','N','N','Y','d6cc547a-b102-4a2e-afdc-e3a6c5adf290','Y',0,'N','N','N','N')
;

-- Apr 13, 2022, 3:53:43 PM MYT
UPDATE AD_Column SET FKConstraintName='CConversionType_CBankTransfer', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-13 15:53:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214757
;

-- Apr 13, 2022, 3:53:43 PM MYT
ALTER TABLE C_BankTransfer ADD COLUMN C_ConversionType_ID NUMERIC(10) DEFAULT NULL 
;

-- Apr 13, 2022, 3:53:43 PM MYT
ALTER TABLE C_BankTransfer ADD CONSTRAINT CConversionType_CBankTransfer FOREIGN KEY (C_ConversionType_ID) REFERENCES c_conversiontype(c_conversiontype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 13, 2022, 3:56:10 PM MYT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutBankTransfer.rate',Updated=TO_TIMESTAMP('2022-04-13 15:56:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214757
;

-- Apr 13, 2022, 4:03:52 PM MYT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200155,'C_BPartner of BankAccount Org','S','C_BPartner.AD_Org_ID IN (0, @C_BankAccount_ID.AD_Org_ID@)',0,0,'Y',TO_TIMESTAMP('2022-04-13 16:03:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-13 16:03:50','YYYY-MM-DD HH24:MI:SS'),100,'D','89ebf409-59e1-4575-8496-3d4b07797951')
;

-- Apr 13, 2022, 4:04:40 PM MYT
UPDATE AD_Val_Rule SET Name='C_BPartner of From BankAccount Org', Code='C_BPartner.AD_Org_ID IN (0, @From_C_BankAccount_ID.AD_Org_ID@)',Updated=TO_TIMESTAMP('2022-04-13 16:04:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200155
;

-- Apr 13, 2022, 4:05:21 PM MYT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200156,'C_BPartner of To BankAccount Org','S','C_BPartner.AD_Org_ID IN (0, @To_C_BankAccount_ID.AD_Org_ID@)',0,0,'Y',TO_TIMESTAMP('2022-04-13 16:05:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-13 16:05:20','YYYY-MM-DD HH24:MI:SS'),100,'D','a630438a-87ef-4720-80e8-d62e9824807d')
;

-- Apr 13, 2022, 4:05:41 PM MYT
UPDATE AD_Column SET AD_Val_Rule_ID=200155,Updated=TO_TIMESTAMP('2022-04-13 16:05:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213676
;

-- Apr 13, 2022, 4:06:06 PM MYT
UPDATE AD_Column SET AD_Val_Rule_ID=200156,Updated=TO_TIMESTAMP('2022-04-13 16:06:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213663
;

-- Apr 14, 2022, 11:00:50 AM MYT
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:00:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205817
;

-- Apr 14, 2022, 11:01:04 AM MYT
UPDATE AD_Field SET IsReadOnly='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:01:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- Apr 14, 2022, 11:02:09 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206946,'Currency Type','Currency Conversion Rate Type','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.',200255,214757,'Y','@From_C_Currency_ID@!@To_C_Currency_ID@',0,210,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-14 11:02:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-14 11:02:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ab8e070c-a8af-49b2-97fc-641c6f4a22b2','Y',220,1,2,1,'N','N','N','N')
;

-- Apr 14, 2022, 11:03:30 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206947,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200255,214756,'Y',0,220,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-14 11:03:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-14 11:03:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3965ebd9-79c8-4f7c-8037-5c7601b31caa','Y',230,1,2,1,'N','N','N','N')
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206947
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205693
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205694
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205817
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205695
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205696
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205697
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205810
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205698
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205699
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205700
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205701
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206946
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205686
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205685
;

-- Apr 14, 2022, 11:05:59 AM MYT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 11:05:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205690
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205817
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205692
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206947
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205693
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205694
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205695
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205696
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205697
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205810
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205698
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205699
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205700
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205701
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205704
;

-- Apr 14, 2022, 11:06:26 AM MYT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- Apr 14, 2022, 11:07:20 AM MYT
UPDATE AD_Window SET Name='Bank/Cash Transfer',Updated=TO_TIMESTAMP('2022-04-14 11:07:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200105
;

-- Apr 14, 2022, 11:07:20 AM MYT
UPDATE AD_Menu SET Name='Bank/Cash Transfer', Description='Manage Bank Transfer', IsActive='Y',Updated=TO_TIMESTAMP('2022-04-14 11:07:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200160
;

-- Apr 14, 2022, 11:08:02 AM MYT
UPDATE AD_Process SET IsActive='N',Updated=TO_TIMESTAMP('2022-04-14 11:08:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53153
;

-- Apr 14, 2022, 11:08:02 AM MYT
UPDATE AD_Menu SET Name='Bank/Cash Transfer', Description='Bank/Cash Transfer let money tranfer between Banks', IsActive='N',Updated=TO_TIMESTAMP('2022-04-14 11:08:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53190
;

-- Apr 14, 2022, 11:08:22 AM MYT
UPDATE AD_Menu SET PredefinedContextVariables='IgnoreIsSOTrxInBPInfo=Y',Updated=TO_TIMESTAMP('2022-04-14 11:08:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200160
;

-- Apr 14, 2022, 11:10:50 AM MYT
UPDATE AD_Window SET IsSOTrx='N',Updated=TO_TIMESTAMP('2022-04-14 11:10:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200105
;

-- Apr 14, 2022, 11:48:25 AM MYT
UPDATE AD_Val_Rule SET Name='C_BPartner of From Organization', Code='C_BPartner.AD_Org_ID IN (0, @From_AD_Org_ID@)',Updated=TO_TIMESTAMP('2022-04-14 11:48:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200155
;

-- Apr 14, 2022, 11:49:09 AM MYT
UPDATE AD_Val_Rule SET Name='C_BPartner of To Organization', Code='C_BPartner.AD_Org_ID IN (0, @To_AD_Org_ID@)',Updated=TO_TIMESTAMP('2022-04-14 11:49:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200156
;

-- Apr 14, 2022, 11:49:17 AM MYT
UPDATE AD_System SET SupportUnits=1, DBAddress='jdbc:postgresql://localhost:5432/idempiere?encoding=unicode&applicationname=idempiere', NoProcessors=4, StatisticsInfo='C2U9B18P55I8L24M28', ProfileInfo='GardenWorld|SYSTEM|',Updated=TO_TIMESTAMP('2022-04-14 11:49:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_System_ID=0
;

-- Apr 14, 2022, 3:52:50 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214758,0,'Override Currency Conversion Rate','Override Currency Conversion Rate',200246,'IsOverrideCurrencyRate','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-04-14 15:52:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-14 15:52:48','YYYY-MM-DD HH24:MI:SS'),100,203258,'Y','N','D','N','N','N','Y','582c15b1-c7a1-4f6b-acd1-95156c2e5385','N',0,'N','N','N','N')
;

-- Apr 14, 2022, 3:52:55 PM MYT
INSERT INTO t_alter_column values('c_banktransfer','To_C_BPartner_ID','NUMERIC(10)',null,null)
;

-- Apr 14, 2022, 3:52:55 PM MYT
INSERT INTO t_alter_column values('c_banktransfer','From_C_BPartner_ID','NUMERIC(10)',null,null)
;

-- Apr 14, 2022, 3:52:55 PM MYT
INSERT INTO t_alter_column values('c_banktransfer','C_ConversionType_ID','NUMERIC(10)',null,'NULL')
;

-- Apr 14, 2022, 3:52:55 PM MYT
ALTER TABLE C_BankTransfer ADD COLUMN IsOverrideCurrencyRate CHAR(1) DEFAULT 'N' CHECK (IsOverrideCurrencyRate IN ('Y','N')) NOT NULL
;

-- Apr 14, 2022, 3:54:51 PM MYT
UPDATE AD_Field SET DisplayLogic='@From_C_Currency_ID@=@To_C_Currency_ID@& @IsOverrideCurrencyRate@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 15:54:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 14, 2022, 3:56:00 PM MYT
UPDATE AD_Field SET DisplayLogic='@From_C_Currency_ID@!@To_C_Currency_ID@& @IsOverrideCurrencyRate@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 15:56:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 14, 2022, 3:56:40 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206948,'Override Currency Conversion Rate','Override Currency Conversion Rate',200255,214758,'Y','@From_C_Currency_ID@!@To_C_Currency_ID@',0,260,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-14 15:56:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-14 15:56:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b3340877-88f6-43ad-b04b-1f02a46d0d0a','Y',270,1,2,1,'N','N','N','N')
;

-- Apr 14, 2022, 3:57:29 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 15:57:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206948
;

-- Apr 14, 2022, 3:57:29 PM MYT
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 15:57:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 14, 2022, 3:57:29 PM MYT
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 15:57:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Apr 14, 2022, 3:57:29 PM MYT
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 15:57:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205686
;

-- Apr 14, 2022, 3:57:29 PM MYT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 15:57:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205685
;

-- Apr 14, 2022, 3:57:29 PM MYT
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-14 15:57:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205690
;

-- Apr 14, 2022, 4:02:30 PM MYT
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2022-04-14 16:02:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214757
;

-- Apr 14, 2022, 4:02:40 PM MYT
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2022-04-14 16:02:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213656
;

-- Apr 14, 2022, 4:02:46 PM MYT
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2022-04-14 16:02:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213652
;

-- Apr 14, 2022, 4:02:53 PM MYT
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2022-04-14 16:02:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213662
;

-- Apr 14, 2022, 4:02:59 PM MYT
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2022-04-14 16:02:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213661
;

-- Apr 14, 2022, 4:03:04 PM MYT
UPDATE AD_Column SET Callout=NULL,Updated=TO_TIMESTAMP('2022-04-14 16:03:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213657
;

-- Apr 15, 2022, 11:18:58 AM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ReadOnlyLogic='@From_C_Currency_ID@=@To_C_Currency_ID@|@IsOverrideCurrencyRate@=N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 11:18:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Apr 15, 2022, 11:19:12 AM MYT
UPDATE AD_Field SET DisplayLogic='@From_C_Currency_ID@!@To_C_Currency_ID@&@IsOverrideCurrencyRate@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 11:19:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 15, 2022, 11:20:25 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 11:20:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206946
;

-- Apr 15, 2022, 11:20:25 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 11:20:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206948
;

-- Apr 15, 2022, 11:20:25 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 11:20:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 15, 2022, 11:20:25 AM MYT
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 11:20:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205698
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205699
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205700
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205701
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206948
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Apr 15, 2022, 11:21:37 AM MYT
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205704
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205691
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205687
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205684
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205685
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205817
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205692
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206947
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205693
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205694
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205695
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205696
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205697
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205810
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205705
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205698
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205699
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205700
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205701
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206946
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206948
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205702
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Apr 15, 2022, 11:22:48 AM MYT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205704
;

-- Apr 15, 2022, 3:25:07 PM MYT
UPDATE AD_Field SET DisplayLogic='@From_C_Currency_ID@!@To_C_Currency_ID@', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 15:25:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 15, 2022, 3:25:59 PM MYT
UPDATE AD_Column SET ReadOnlyLogic='@From_C_Currency_ID@=@To_C_Currency_ID@|@IsOverrideCurrencyRate@=N',Updated=TO_TIMESTAMP('2022-04-15 15:25:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213662
;

