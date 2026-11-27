-- IDEMPIERE-7231 Support Charge-based posting for manual (non-material) Cost Elements
SELECT register_migration_script('202611241110_IDEMPIERE-7231.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 24, 2026 3:46:28 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,IsHtml,IsPartitionKey) VALUES (213258,0,'N',0,'N','N','N',0,'N',10,'N','N','N','Y','1667698b-4d95-4684-8df0-e14638721356',TO_TIMESTAMP('2026-11-24 15:46:26','YYYY-MM-DD HH24:MI:SS'),'Y','C_Charge_ID','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)','Charge','Y','Y',100,100,'N',0,0,TO_TIMESTAMP('2026-11-24 15:46:26','YYYY-MM-DD HH24:MI:SS'),'D','N','N',968,770,19,'N','N','N')
;

-- Nov 24, 2026 3:46:38 PM GMT+08:00
UPDATE AD_Column SET FKConstraintName='CCharge_MCostElement', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-24 15:46:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213258
;

-- Nov 24, 2026 3:46:38 PM GMT+08:00
ALTER TABLE M_CostElement ADD C_Charge_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 24, 2026 3:46:39 PM GMT+08:00
ALTER TABLE M_CostElement ADD CONSTRAINT CCharge_MCostElement FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 24, 2026 3:57:56 PM GMT+08:00
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,DisplayLogic,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,IsQuickForm,IsHtml) VALUES (0,205245,'N',0,'N','N',80,'Y','N','The Charge indicates a type of Charge (Handling, Shipping, Restocking)','@CostingMethod@='''' & @CostElementType@!''M''',0,TO_TIMESTAMP('2026-11-24 15:57:55','YYYY-MM-DD HH24:MI:SS'),'Additional document charges','Charge','9b614cc5-ac79-4737-a482-82169187eced','Y','N',100,100,'Y','Y',80,1,'N',0,TO_TIMESTAMP('2026-11-24 15:57:55','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213258,'D',699,'N','N')
;

-- Nov 24, 2026 3:59:25 PM GMT+08:00
UPDATE AD_Field SET SeqNo=90,SeqNoGrid=90,Updated=TO_TIMESTAMP('2026-11-24 15:59:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11290
;
