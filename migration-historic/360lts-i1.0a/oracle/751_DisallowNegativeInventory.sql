-- 29-nov-2010 12:13:39 COT
-- Disallow Negative Inventory - configurable per warehouse
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,Help,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54377,0,'IsDisallowNegativeInv',TO_DATE('2010-11-29 12:13:38','YYYY-MM-DD HH24:MI:SS'),100,'Negative Inventory is not allowed in this warehouse','D','If checked, any transaction that results in the onhand inventory being driven negative will be prevented.','Y','Disallow Negative Inventory','Disallow Negative Inventory',TO_DATE('2010-11-29 12:13:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 29-nov-2010 12:13:40 COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=54377 AND EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Element_ID!=t.AD_Element_ID)
;

-- 29-nov-2010 12:14:57 COT
UPDATE AD_Element_Trl SET IsTranslated='Y',Name='No Permitir Inventario Negativo',PrintName='No Permitir Inventario Negativo',Description='Inventario negativo no es permitido en esta bodega',Help='Si se marca, no se permiten transacciones que resulte en una cantidad de inventario negativa.',Updated=TO_DATE('2010-11-29 12:14:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54377 AND AD_Language LIKE 'es_%'
;

-- 29-nov-2010 12:15:48 COT
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,60108,54377,0,20,190,'IsDisallowNegativeInv',TO_DATE('2010-11-29 12:15:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Negative Inventory is not allowed in this warehouse','D',1,'If checked, any transaction that results in the onhand inventory being driven negative will be prevented.','Y','N','N','N','N','Y','N','N','N','N','Y','Disallow Negative Inventory',0,TO_DATE('2010-11-29 12:15:47','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- 29-nov-2010 12:15:48 COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=60108 AND EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Column_ID!=t.AD_Column_ID)
;

-- 29-nov-2010 12:15:52 COT
ALTER TABLE M_Warehouse ADD IsDisallowNegativeInv CHAR(1) DEFAULT 'N' CHECK (IsDisallowNegativeInv IN ('Y','N')) NOT NULL
;

-- 29-nov-2010 12:16:58 COT
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,60108,60864,0,177,TO_DATE('2010-11-29 12:16:57','YYYY-MM-DD HH24:MI:SS'),100,'Negative Inventory is not allowed in this warehouse',1,'D','If checked, any transaction that results in the onhand inventory being driven negative will be prevented.','Y','Y','Y','N','N','N','N','N','Disallow Negative Inventory',110,0,TO_DATE('2010-11-29 12:16:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 29-nov-2010 12:16:58 COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=60864 AND EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Field_ID!=t.AD_Field_ID)
;

-- Nov 29, 2010 12:28:56 PM COT
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,53118,0,TO_DATE('2010-11-29 12:28:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Negative on hand exists in this warehouse','E',TO_DATE('2010-11-29 12:28:55','YYYY-MM-DD HH24:MI:SS'),100,'NegativeOnhandExists')
;

-- Nov 29, 2010 12:28:56 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=53118 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 29, 2010 12:29:10 PM COT
UPDATE AD_Message_Trl SET IsTranslated='Y',MsgText='Existen inventarios negativos en esta bodega',Updated=TO_DATE('2010-11-29 12:29:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53118 AND AD_Language LIKE 'es_%'
;

-- Nov 29, 2010 12:35:26 PM COT
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2010-11-29 12:35:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60864
;

-- Nov 29, 2010 12:44:58 PM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutOrder.warehouse',Updated=TO_DATE('2010-11-29 12:44:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2202
;

-- Nov 29, 2010 1:03:25 PM COT
UPDATE AD_Message_Trl SET MsgText='Existen inventarios negativos en este almacén',Updated=TO_DATE('2010-11-29 13:03:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53118 AND AD_Language LIKE 'es_%'
;

-- Nov 29, 2010 1:03:57 PM COT
UPDATE AD_Element_Trl SET Description='Inventario negativo no es permitido en este almacén',Updated=TO_DATE('2010-11-29 13:03:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54377 AND AD_Language LIKE 'es_%'
;

