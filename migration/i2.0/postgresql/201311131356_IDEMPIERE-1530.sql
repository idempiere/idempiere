-- Nov 13, 2013 5:26:33 PM MYT
-- Make validation of purchase order quantity against invoice and receipt quantity optional
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200039,'C','Y','Set this to false (N) to allow material receipt and invoice with quantity more than purchase order quantity.','f473c472-1285-4936-8bb8-2f36f68de12e',TO_TIMESTAMP('2013-11-13 17:26:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-11-13 17:26:26','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'VALIDATE_MATCHING_TO_ORDERED_QTY',0,'D')
;

-- Nov 13, 2013 7:44:29 PM MYT
-- Make validation of purchase order quantity against invoice and receipt quantity optional
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,Name,Description,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('QtyOverReceipt',202627,'Calculated: Receipt - ordered quantity','Over Receipt','Over Receipt Quantity','Over Receipt','6872e34a-74bc-4590-b8e3-da15b6d365ba',TO_TIMESTAMP('2013-11-13 19:44:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-11-13 19:44:25','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Nov 13, 2013 7:45:25 PM MYT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,320,210888,'N','N','N',0,'N',22,'N',29,'N','N','Y','8a1f15d1-412e-464e-9797-b547a152b54b','Y','QtyOverReceipt','Over Receipt Quantity','0','Calculated: Receipt - ordered quantity','Over Receipt','N',TO_TIMESTAMP('2013-11-13 19:45:22','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-11-13 19:45:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202627,'N')
;

-- Nov 13, 2013 7:45:55 PM MYT
ALTER TABLE M_InOutLine ADD COLUMN QtyOverReceipt NUMERIC DEFAULT 0 
;

SELECT register_migration_script('201311131356_IDEMPIERE-1530.sql') FROM dual
;

