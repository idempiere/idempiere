SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4086 avoid product dependency on price list
-- Oct 9, 2021, 12:13:26 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Help,PrintName,EntityType,AD_Element_UU) VALUES (203543,0,0,'Y',TO_DATE('2021-10-09 00:13:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-09 00:13:25','YYYY-MM-DD HH24:MI:SS'),100,'IsNoPriceListCheck','Allow Product Without Pricelist','Allow product without pricelist on this document type.','Allow Product Without Pricelist','D','a82fd279-9714-457b-8723-5bf8b5f58c63')
;

-- Oct 9, 2021, 12:17:03 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214593,0,'Allow Product Without Pricelist','Allow product without pricelist on this document type.',217,'IsNoPriceListCheck','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-10-09 00:17:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-09 00:17:02','YYYY-MM-DD HH24:MI:SS'),100,203543,'Y','N','D','N','N','N','Y','ff5dcc56-c1da-47d6-b233-c7e7308bf6e2','Y',0,'N','N','N','N')
;

-- Oct 9, 2021, 1:04:07 AM IST
ALTER TABLE C_DocType ADD IsNoPriceListCheck CHAR(1) DEFAULT 'N' CHECK (IsNoPriceListCheck IN ('Y','N'))
;

-- Oct 9, 2021, 12:21:45 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206753,'Allow Product Without Pricelist','Allow product without pricelist on this document type.',167,214593,'Y',1,240,'N','N','N','N',0,0,'Y',TO_DATE('2021-10-09 00:21:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-10-09 00:21:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9b91a693-daa0-4402-b1ff-cb9a9502ed7d','Y',240,5,2)
;

-- 09-Oct-2021, 9:21:21 AM IST
UPDATE AD_Field SET DisplayLogic='@DocBaseType@=''SOO'' | @DocBaseType@=''POO''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 09:21:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206753
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206753
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10345
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10346
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10481
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10480
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58859
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10371
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10528
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10340
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200004
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205278
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206430
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6567
;

-- Oct 9, 2021, 10:51:52 PM IST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-10-09 22:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3125
;

SELECT register_migration_script('202110090932_IDEMPIERE-4086.sql') FROM dual
;
