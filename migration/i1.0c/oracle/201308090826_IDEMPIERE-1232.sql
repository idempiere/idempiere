-- Aug 9, 2013 8:16:28 AM COT
-- IDEMPIERE-1232 Zoom condition fixes
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_ZoomCondition_UU',202578,'AD_ZoomCondition_UU','AD_ZoomCondition_UU','7f562afd-d2c2-40cc-8f5f-fd71597f7621',TO_DATE('2013-08-09 08:16:19','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-09 08:16:19','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 9, 2013 8:16:28 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202578 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 9, 2013 8:16:28 AM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Name,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (1.0,200066,210683,'N','N','N','N',36,'N',10,'N','4748d5ef-fbba-458e-8947-8676fce31f72','Y','AD_ZoomCondition_UU','AD_ZoomCondition_UU',TO_DATE('2013-08-09 08:16:19','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-09 08:16:19','YYYY-MM-DD HH24:MI:SS'),100,'N',0,'D','N',202578)
;

-- Aug 9, 2013 8:16:28 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210683 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 9, 2013 8:16:28 AM COT
ALTER TABLE AD_ZoomCondition ADD AD_ZoomCondition_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Aug 9, 2013 8:16:29 AM COT
ALTER TABLE AD_ZoomCondition ADD CONSTRAINT AD_ZoomCondition_UU_idx UNIQUE (AD_ZoomCondition_UU)
;

-- Aug 9, 2013 8:24:07 AM COT
UPDATE AD_ZoomCondition SET AD_ZoomCondition_UU='3962168d-caad-4057-b009-b5db798ce6d8' WHERE AD_ZoomCondition_ID=200001
;

-- Aug 9, 2013 8:24:07 AM COT
UPDATE AD_ZoomCondition SET AD_ZoomCondition_UU='9cc206f5-283f-428d-a3b5-9d8a7669d7e8' WHERE AD_ZoomCondition_ID=200002
;

-- Aug 9, 2013 9:35:21 AM COT
INSERT INTO AD_ZoomCondition (AD_Client_ID,AD_Org_ID,AD_Window_ID,AD_ZoomCondition_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,SeqNo,WhereClause,AD_Table_ID,Name,AD_ZoomCondition_UU) VALUES (0,0,53098,200003,TO_DATE('2013-08-09 09:35:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2013-08-09 09:35:14','YYYY-MM-DD HH24:MI:SS'),100,10,'M_InOut.MovementType IN (''V-'')',319,'Return to Vendor','c4403f97-5fe3-4a70-a71a-006739d5d8cc')
;

-- Aug 9, 2013 9:35:48 AM COT
INSERT INTO AD_ZoomCondition (AD_Client_ID,AD_Org_ID,AD_Window_ID,AD_ZoomCondition_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,SeqNo,WhereClause,AD_Table_ID,Name,AD_ZoomCondition_UU) VALUES (0,0,53097,200004,TO_DATE('2013-08-09 09:35:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2013-08-09 09:35:47','YYYY-MM-DD HH24:MI:SS'),100,20,'M_InOut.MovementType IN (''C+'')',319,'Customer Return','c6c7fde3-2a9c-4eaf-8d22-fc2537de1678')
;

-- Aug 9, 2013 9:38:48 AM COT
UPDATE AD_Tab SET Help='The Return to Vendor Line Tab defines the individual items in a Return to Vendor.', Name='Return to Vendor Line', Description='Return to Vendor Line',Updated=TO_DATE('2013-08-09 09:38:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53277
;

-- Aug 9, 2013 9:39:06 AM COT
UPDATE AD_Tab SET Description='Optional Confirmations of Return to Vendor Lines',Updated=TO_DATE('2013-08-09 09:39:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53278
;

-- Aug 9, 2013 9:40:05 AM COT
UPDATE AD_Field SET IsCentrallyMaintained='N', Help='The Return to Vendor', Description='Return to Vendor Document', Name='Return to Vendor',Updated=TO_DATE('2013-08-09 09:40:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57900
;

-- Aug 9, 2013 9:40:45 AM COT
UPDATE AD_Tab SET Help='The Customer Return Line Tab defines the individual items in a Customer Return.', Name='Customer Return Line', Description='Customer Return Line',Updated=TO_DATE('2013-08-09 09:40:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53272
;

-- Aug 9, 2013 9:41:08 AM COT
UPDATE AD_Field SET IsCentrallyMaintained='N', Help='The Customer Return', Description='Customer Return Document', Name='Customer Return',Updated=TO_DATE('2013-08-09 09:41:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57761
;

SELECT register_migration_script('201308090826_IDEMPIERE-1232.sql') FROM dual
;

