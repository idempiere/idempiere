-- IDEMPIERE-6177
SELECT register_migration_script('202406181038_IDEMPIERE-6177.sql') FROM dual;

-- Jun 18, 2024, 10:38:51 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203936,0,0,'Y',TO_TIMESTAMP('2024-06-18 10:38:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-06-18 10:38:51','YYYY-MM-DD HH24:MI:SS'),100,'IsAutoGenerateInout','Generate Shipment','Automatically Generate Shipment after (Sales/Purchase) Order completed','When selected the Order will generate Shipment automatically. Note that only Orders with document subtype Standard and Prepay Order can be applied!','Generate Shipment','D','0e8d505c-b548-44c6-838b-765717e6de3e')
;

-- Jun 18, 2024, 10:40:23 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203937,0,0,'Y',TO_TIMESTAMP('2024-06-18 10:40:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-06-18 10:40:22','YYYY-MM-DD HH24:MI:SS'),100,'IsAutoGenerateInvoice','Generate Invoice','Automatically Generate Invoice after (Sales/Purchase) Order completed','When selected the Order will generate Invoice automatically. Note that only Orders with document subtype Standard and Prepay Order can be applied!','Generate Invoice','D','2c094bef-6468-4dea-9daf-c9b87795105e')
;

-- Jun 18, 2024, 10:42:18 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216612,0,'Generate Invoice','Automatically Generate Invoice after (Sales/Purchase) Order completed','When selected the Order will generate Invoice automatically. Note that only Orders with document subtype Standard and Prepay Order can be applied!',217,'IsAutoGenerateInvoice','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-06-18 10:42:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-06-18 10:42:18','YYYY-MM-DD HH24:MI:SS'),100,203937,'Y','N','D','N','N','N','Y','f1049fb6-356b-4768-be8a-5a2928bcb405','Y',0,'N','N','N','N')
;

-- Jun 18, 2024, 10:43:10 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216613,0,'Generate Shipment','Automatically Generate Shipment after (Sales/Purchase) Order completed','When selected the Order will generate Shipment automatically. Note that only Orders with document subtype Standard and Prepay Order can be applied!',217,'IsAutoGenerateInout','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-06-18 10:43:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-06-18 10:43:10','YYYY-MM-DD HH24:MI:SS'),100,203936,'Y','N','D','N','N','N','Y','dfb1cf89-a1a2-49c1-8389-0c60502e831c','Y',0,'N','N','N','N')
;

-- Jun 18, 2024, 10:43:12 AM CEST
ALTER TABLE C_DocType ADD COLUMN IsAutoGenerateInout CHAR(1) DEFAULT 'N' CHECK (IsAutoGenerateInout IN ('Y','N')) NOT NULL
;

-- Jun 18, 2024, 10:43:27 AM CEST
ALTER TABLE C_DocType ADD COLUMN IsAutoGenerateInvoice CHAR(1) DEFAULT 'N' CHECK (IsAutoGenerateInvoice IN ('Y','N')) NOT NULL
;

-- Jun 18, 2024, 10:44:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208492,'Generate Invoice','Automatically Generate Invoice after (Sales/Purchase) Order completed','When selected the Order will generate Invoice automatically. Note that only Orders with document subtype Standard and Prepay Order can be applied!',167,216612,'Y',1,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-06-18 10:44:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-06-18 10:44:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','78a968cd-135c-42a3-9da7-a75057cc703d','Y',330,2,2)
;

-- Jun 18, 2024, 10:44:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208493,'Generate Shipment','Automatically Generate Shipment after (Sales/Purchase) Order completed','When selected the Order will generate Shipment automatically. Note that only Orders with document subtype Standard and Prepay Order can be applied!',167,216613,'Y',1,380,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-06-18 10:44:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-06-18 10:44:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fbb23049-e37b-40ad-b414-93b789dff9ed','Y',340,2,2)
;

-- Jun 18, 2024, 10:46:25 AM CEST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2024-06-18 10:46:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6567
;

-- Jun 18, 2024, 10:46:25 AM CEST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2024-06-18 10:46:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3125
;

-- Jun 18, 2024, 10:46:25 AM CEST
UPDATE AD_Field SET DisplayLogic='@DocBaseType@=''SOO'' | @DocBaseType@=''POO''', SeqNo=350,Updated=TO_TIMESTAMP('2024-06-18 10:46:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208492
;

-- Jun 18, 2024, 10:46:25 AM CEST
UPDATE AD_Field SET DisplayLogic='@DocBaseType@=''SOO'' | @DocBaseType@=''POO''', SeqNo=360,Updated=TO_TIMESTAMP('2024-06-18 10:46:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208493
;

-- Jun 18, 2024, 10:46:25 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-06-18 10:46:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204719
;

-- Jun 18, 2024, 10:56:01 AM CEST
UPDATE AD_Field SET DisplayLogic='@OrderType@=''SO'' | @OrderType@=''PR''', SeqNo=90,Updated=TO_TIMESTAMP('2024-06-18 10:56:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1094
;

-- Jun 18, 2024, 10:56:01 AM CEST
UPDATE AD_Field SET DisplayLogic='@OrderType@=''PR'' | @OrderType@=''SO''', SeqNo=160,Updated=TO_TIMESTAMP('2024-06-18 10:56:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2877
;

-- Jun 18, 2024, 10:56:01 AM CEST
UPDATE AD_Field SET DisplayLogic='@OrderType@=''SO'' | @OrderType@=''WP'' | @OrderType@=''OB''', SeqNo=300,Updated=TO_TIMESTAMP('2024-06-18 10:56:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1104
;

-- Jun 18, 2024, 10:56:01 AM CEST
UPDATE AD_Field SET SeqNo=580,Updated=TO_TIMESTAMP('2024-06-18 10:56:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201611
;

-- Jun 18, 2024, 10:59:31 AM CEST
UPDATE AD_Field SET DisplayLogic='@OrderType@=''SO'' | @OrderType@=''WP'' | @OrderType@=''PR''', SeqNo=300,Updated=TO_TIMESTAMP('2024-06-18 10:59:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1104
;

-- set IsAutoGenerateInout for existing documents (Y for OnCredit, Warehouse, POS, Prepay)
UPDATE C_DocType 
SET IsAutoGenerateInout = 'Y' 
WHERE DocSubTypeSO IN ('WI', 'WP', 'WR', 'PR')
;

-- set IsAutoGenerateInvoice for existing documents (Y for OnCredit, POS, Prepay)
UPDATE C_DocType 
SET IsAutoGenerateInvoice = 'Y' 
WHERE DocSubTypeSO IN ('WI', 'WR', 'PR')
;

