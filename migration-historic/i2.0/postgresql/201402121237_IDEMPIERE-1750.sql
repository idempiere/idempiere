-- Feb 12, 2014 2:30:48 PM MYT
-- IDEMPIERE-1750 Restore M_ProductionPlan backward compatibility
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202669,'5bdb1aeb-6657-4477-b9e3-ca967fe6fec7',0,'IsUseProductionPlan',TO_TIMESTAMP('2014-02-12 14:30:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Use Production Plan','Use Production Plan',TO_TIMESTAMP('2014-02-12 14:30:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 12, 2014 2:31:42 PM MYT
INSERT INTO AD_Column (SeqNoSelection,IsAlwaysUpdateable,IsSyncDatabase,AD_Client_ID,EntityType,IsSecure,IsEncrypted,AD_Column_ID,IsParent,IsMandatory,IsIdentifier,SeqNo,Version,FieldLength,IsKey,IsTranslated,IsUpdateable,IsAutocomplete,IsAllowLogging,IsAllowCopy,ColumnName,Name,DefaultValue,IsSelectionColumn,AD_Column_UU,AD_Org_ID,CreatedBy,Updated,Created,IsActive,UpdatedBy,IsToolbarButton,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (0,'N','N',0,'D','N','N',210981,'N','Y','N',0,0,1,'N','N','Y','N','Y','Y','IsUseProductionPlan','Use Production Plan','N','N','46c42278-5188-4e22-9564-44954437f3f8',0,100,TO_TIMESTAMP('2014-02-12 14:31:35','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-02-12 14:31:35','YYYY-MM-DD HH24:MI:SS'),'Y',100,'N','N',202669,20,325)
;

-- Feb 12, 2014 2:31:51 PM MYT
ALTER TABLE M_Production ADD COLUMN IsUseProductionPlan CHAR(1) DEFAULT 'N' CHECK (IsUseProductionPlan IN ('Y','N')) NOT NULL
;

-- Feb 12, 2014 2:34:02 PM MYT
UPDATE AD_Tab SET WhereClause='M_Production.IsUseProductionPlan=''Y''',Updated=TO_TIMESTAMP('2014-02-12 14:34:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=319
;

-- Feb 12, 2014 2:35:04 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,AD_Client_ID,IsHeading,AD_Field_ID,IsDisplayed,IsFieldOnly,AD_Tab_ID,IsSameLine,IsDisplayedGrid,SeqNoGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,DefaultValue,EntityType,Name,SortNo,IsEncrypted,DisplayLength,CreatedBy,Created,AD_Org_ID,Updated,UpdatedBy,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID) VALUES (1,1,'N',0,'N',202628,'N','N',319,'N','N',210,210,'N','Y','Y','D','Use Production Plan',0,'N',0,100,TO_TIMESTAMP('2014-02-12 14:35:02','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2014-02-12 14:35:02','YYYY-MM-DD HH24:MI:SS'),100,'e4845d93-6a9e-41d6-a044-0619e27c2065','Y',1,'N','N',210981)
;

-- Feb 12, 2014 2:37:21 PM MYT
UPDATE AD_Tab SET WhereClause='M_Production.IsUseProductionPlan=''N''',Updated=TO_TIMESTAMP('2014-02-12 14:37:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53344
;

-- Feb 12, 2014 2:38:29 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,AD_Client_ID,IsHeading,AD_Field_ID,IsDisplayed,IsFieldOnly,AD_Tab_ID,IsSameLine,IsDisplayedGrid,SeqNoGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,DefaultValue,EntityType,Name,SortNo,IsEncrypted,DisplayLength,CreatedBy,Created,AD_Org_ID,Updated,UpdatedBy,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID) VALUES (1,1,'N',0,'N',202629,'N','N',53344,'N','N',210,250,'N','Y','N','D','Use Production Plan',0,'N',0,100,TO_TIMESTAMP('2014-02-12 14:38:23','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2014-02-12 14:38:23','YYYY-MM-DD HH24:MI:SS'),100,'b1b2a592-9681-420c-bdfa-c164c8ca51f8','Y',1,'N','N',210981)
;

-- Feb 12, 2014 5:06:14 PM MYT
-- IDEMPIERE-1750 Restore M_ProductionPlan backward compatibility
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,AD_Client_ID,IsHeading,AD_Field_ID,IsDisplayed,IsFieldOnly,AD_Tab_ID,IsSameLine,IsDisplayedGrid,SeqNoGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,EntityType,Name,SortNo,IsEncrypted,DisplayLength,DisplayLogic,CreatedBy,Created,AD_Org_ID,Updated,UpdatedBy,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID) VALUES (2,1,'N',0,'N',202630,'Y','N',321,'N','Y',130,140,'N','Y','D','Quantity Used',0,'N',0,'@IsEndProduct@=N',100,TO_TIMESTAMP('2014-02-12 17:06:11','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2014-02-12 17:06:11','YYYY-MM-DD HH24:MI:SS'),100,'70e099b3-284b-4617-8e3b-684e541bc1af','Y',1,'N','N',61944)
;

-- Feb 12, 2014 5:06:50 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsEndProduct@=Y',Updated=TO_TIMESTAMP('2014-02-12 17:06:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3807
;

-- Feb 12, 2014 5:07:57 PM MYT
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,AD_Client_ID,IsHeading,AD_Field_ID,IsDisplayed,IsFieldOnly,AD_Tab_ID,IsSameLine,IsDisplayedGrid,SeqNoGrid,SeqNo,IsReadOnly,IsCentrallyMaintained,EntityType,Name,Description,SortNo,IsEncrypted,DisplayLength,CreatedBy,Created,AD_Org_ID,Updated,UpdatedBy,AD_Field_UU,IsActive,XPosition,IsAdvancedField,IsDefaultFocus,AD_Column_ID) VALUES (2,1,'N',0,'N',202631,'Y','N',321,'N','Y',140,150,'N','Y','D','End Product','End Product of production',0,'N',0,100,TO_TIMESTAMP('2014-02-12 17:07:56','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2014-02-12 17:07:56','YYYY-MM-DD HH24:MI:SS'),100,'c879fc0d-d134-41a5-81fd-565b22118d66','Y',1,'N','N',61945)
;

-- Feb 12, 2014 5:09:09 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202335
;

-- Feb 12, 2014 5:09:09 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=10338
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=3801
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=3802
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=3803
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=3809
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=3811
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=3806
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202631
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=6556
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=3804
;

-- Feb 12, 2014 5:09:10 PM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202630
;

-- Feb 12, 2014 5:10:09 PM MYT
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2014-02-12 17:10:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202631
;

-- Feb 12, 2014 8:30:35 PM MYT
-- IDEMPIERE-1750 Restore M_ProductionPlan backward compatibility
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=6556
;

-- Feb 12, 2014 8:30:35 PM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202631
;

-- Feb 12, 2014 8:31:19 PM MYT
UPDATE AD_Tab SET AD_Column_ID=4753,Updated=TO_TIMESTAMP('2014-02-12 20:31:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=321
;

UPDATE M_Production
SET IsUseProductionPlan='Y'
WHERE M_Product_ID IS NULL
;

UPDATE M_ProductionLine
SET QtyUsed = 0 WHERE QtyUsed IS NULL
;

UPDATE M_ProductionLine
SET QtyUsed = MovementQty * -1
WHERE QtyUsed = 0 AND MovementQty <> 0
AND M_ProductionPlan_ID IN
( SELECT M_ProductionPlan_ID FROM M_ProductionPlan 
  WHERE M_ProductionPlan.M_ProductionPlan_ID=M_ProductionLine.M_ProductionPlan_ID
  AND M_ProductionPlan.M_Product_ID != M_ProductionLine.M_Product_ID)
;

UPDATE M_ProductionLine
SET IsEndProduct='Y'
WHERE M_ProductionPlan_ID IN
( SELECT M_ProductionPlan_ID FROM M_ProductionPlan 
  WHERE M_ProductionPlan.M_ProductionPlan_ID=M_ProductionLine.M_ProductionPlan_ID
  AND M_ProductionPlan.M_Product_ID = M_ProductionLine.M_Product_ID)
;

UPDATE M_ProductionLine
SET IsEndProduct='N'
WHERE M_ProductionPlan_ID IN
( SELECT M_ProductionPlan_ID FROM M_ProductionPlan 
  WHERE M_ProductionPlan.M_ProductionPlan_ID=M_ProductionLine.M_ProductionPlan_ID
  AND M_ProductionPlan.M_Product_ID != M_ProductionLine.M_Product_ID)
;

-- Feb 12, 2014 9:14:39 PM MYT
-- IDEMPIERE-1750 Restore M_ProductionPlan backward compatibility
UPDATE AD_Process_Para SET DisplayLogic='@IsUseProductionPlan@=N', IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2014-02-12 21:14:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53517
;

SELECT register_migration_script('201402121237_IDEMPIERE-1750.sql') FROM dual
;

