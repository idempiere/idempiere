
-- Jan 3, 2019 4:20:27 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203288,0,0,'Y',TO_TIMESTAMP('2019-01-03 16:20:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-03 16:20:25','YYYY-MM-DD HH24:MI:SS'),100,'IsOnePaymentPerInvoice','One Payment Per Invoice','One Payment Per Invoice','D','695d48e7-7a98-4c18-bd31-dc3fa0748ff4')
;

-- Jan 3, 2019 4:22:43 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted) VALUES (200253,0,0,'Y',TO_TIMESTAMP('2019-01-03 16:22:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-03 16:22:42','YYYY-MM-DD HH24:MI:SS'),100,'One Payment Per Invoice',155,20,20,'N',0,'N','@IsOnePaymentPerInvoice@','IsOnePaymentPerInvoice','Y','D',203288,'1=2','acbf3fcd-f9bd-41d6-a1f8-d6e4bdff8820','N')
;

-- Jan 3, 2019 4:25:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (213824,0,'One Payment Per Invoice',426,'IsOnePaymentPerInvoice',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2019-01-03 16:25:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-03 16:25:15','YYYY-MM-DD HH24:MI:SS'),100,203288,'Y','N','D','N','N','N','Y','80292698-a92a-42a0-9b91-62fb55ee8ad3','Y',0,'N','N','N')
;

-- Jan 3, 2019 4:25:19 PM IST
ALTER TABLE C_PaySelection ADD COLUMN IsOnePaymentPerInvoice CHAR(1) DEFAULT NULL CHECK (IsOnePaymentPerInvoice IN ('Y','N'))
;

-- Jan 3, 2019 4:25:28 PM IST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_TIMESTAMP('2019-01-03 16:25:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213824
;

-- Jan 3, 2019 4:25:31 PM IST
INSERT INTO t_alter_column values('c_payselection','IsOnePaymentPerInvoice','CHAR(1)',null,'N')
;

-- Jan 3, 2019 4:27:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205900,'One Payment Per Invoice',352,213824,'Y',0,95,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-01-03 16:27:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-01-03 16:27:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6989ca75-b5bc-4b84-ad0c-8209fcc0697a','Y',140,5,2,1,'N','N','N')
;

SELECT register_migration_script('201901031640_IDEMPIERE-3858.sql') FROM dual
;

