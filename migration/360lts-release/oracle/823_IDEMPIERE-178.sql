-- Mar 7, 2012 2:02:28 PM COT
-- IDEMPIERE-178 Orders and Invoices must disallow amount lines without product/charge
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200004,'IsChargeOrProductMandatory','D','Mandatory Charge or Product','Mandatory Charge or Product',0,TO_DATE('2012-03-07 14:02:26','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-03-07 14:02:26','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Mar 7, 2012 2:02:28 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200004 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 7, 2012 2:02:39 PM COT
UPDATE AD_Element_Trl SET IsTranslated='Y',Name='Cargo o Producto Obligatorio',PrintName='Cargo o Producto Obligatorio',Updated=TO_DATE('2012-03-07 14:02:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200004 AND AD_Language LIKE 'es_%'
;

-- Mar 7, 2012 2:03:42 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('N',200019,217,'D',0,'N','N','N',0,'N',1,'N',20,'N','N',200004,'N','Y','N','Y','N','IsChargeOrProductMandatory','Mandatory Charge or Product','Y',100,TO_DATE('2012-03-07 14:03:41','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-07 14:03:41','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 7, 2012 2:03:42 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200019 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 7, 2012 2:03:46 PM COT
ALTER TABLE C_DocType ADD IsChargeOrProductMandatory CHAR(1) DEFAULT 'N' CHECK (IsChargeOrProductMandatory IN ('Y','N'))
;

-- Mar 7, 2012 2:04:54 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',10,'Y','N','N',200019,'N',320,'Y',167,200004,'N','D','Mandatory Charge or Product',100,0,'Y',TO_DATE('2012-03-07 14:04:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-07 14:04:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 7, 2012 2:04:54 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200004 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 7, 2012 2:07:03 PM COT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=200004
;

-- Mar 7, 2012 2:07:04 PM COT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=6567
;

-- Mar 7, 2012 2:07:04 PM COT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=3125
;

-- Mar 7, 2012 2:11:22 PM COT
UPDATE AD_Field SET DisplayLogic='@DocBaseType@=''SOO'' | @DocBaseType@=''POO'' | @DocBaseType@=''MMR'' | @DocBaseType@=''MMS'' | @DocBaseType@=''API'' | @DocBaseType@=''APC'' | @DocBaseType@=''ARI'' | @DocBaseType@=''ARC'' | @DocBaseType@=''POR''',Updated=TO_DATE('2012-03-07 14:11:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200004
;

-- Mar 7, 2012 2:13:33 PM COT
UPDATE AD_Column SET ReadOnlyLogic='@M_Product_ID@!0',Updated=TO_DATE('2012-03-07 14:13:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3050
;

-- Mar 7, 2012 2:14:15 PM COT
UPDATE AD_Column SET ReadOnlyLogic='@M_Product_ID@!0',Updated=TO_DATE('2012-03-07 14:14:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13434
;

-- Mar 7, 2012 2:14:30 PM COT
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@!0',Updated=TO_DATE('2012-03-07 14:14:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3539
;

-- Mar 7, 2012 2:15:04 PM COT
UPDATE AD_Column SET ReadOnlyLogic='@M_Product_ID@!0', Updated=TO_DATE('2012-03-07 14:15:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15010
;

-- Mar 7, 2012 2:15:19 PM COT
UPDATE AD_Column SET ReadOnlyLogic='@C_Charge_ID@!0',Updated=TO_DATE('2012-03-07 14:15:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11501
;

-- Mar 7, 2012 3:18:35 PM COT
-- IDEMPIERE-178 Orders and Invoices must disallow amount lines without product/charge
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,Value,IsActive,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,Created,UpdatedBy) VALUES ('I','On this document is mandatory to fill the product or the charge',200003,'D','ChargeOrProductMandatory','Y',TO_DATE('2012-03-07 15:18:34','YYYY-MM-DD HH24:MI:SS'),0,0,100,TO_DATE('2012-03-07 15:18:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 7, 2012 3:18:35 PM COT
-- IDEMPIERE-178 Orders and Invoices must disallow amount lines without product/charge
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200003 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Mar 7, 2012 3:18:43 PM COT
-- IDEMPIERE-178 Orders and Invoices must disallow amount lines without product/charge
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='En este documento se debe diligenciar el cargo o el producto',Updated=TO_DATE('2012-03-07 15:18:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200003 AND AD_Language LIKE 'es_%'
;

