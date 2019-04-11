-- Oct 11, 2018 8:41:01 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213700,0,'Accounting Schema','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',53116,'C_AcctSchema_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2018-10-11 20:40:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-10-11 20:40:59','YYYY-MM-DD HH24:MI:SS'),100,181,'N','N','D','N','N','N','Y','c62177d9-97f4-4c03-bc74-05a9f5609c95','Y',0,'N','N','C')
;

-- Oct 11, 2018 8:41:16 PM SGT
UPDATE AD_Column SET FKConstraintName='CAcctSchema_ADepreciationWorkf', FKConstraintType='C',Updated=TO_TIMESTAMP('2018-10-11 20:41:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213700
;

-- Oct 11, 2018 8:41:16 PM SGT
ALTER TABLE A_Depreciation_Workfile ADD COLUMN C_AcctSchema_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 11, 2018 8:41:17 PM SGT
ALTER TABLE A_Depreciation_Workfile ADD CONSTRAINT CAcctSchema_ADepreciationWorkf FOREIGN KEY (C_AcctSchema_ID) REFERENCES c_acctschema(c_acctschema_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Oct 11, 2018 8:46:13 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213701,0,'Accounting Schema','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',53115,'C_AcctSchema_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2018-10-11 20:46:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-10-11 20:46:12','YYYY-MM-DD HH24:MI:SS'),100,181,'N','N','D','N','N','N','Y','b0851cce-d266-461b-a47c-4cf19ad6b3af','Y',0,'N','N','C')
;

-- Oct 11, 2018 8:46:18 PM SGT
UPDATE AD_Column SET FKConstraintName='CAcctSchema_ADepreciationExp', FKConstraintType='C',Updated=TO_TIMESTAMP('2018-10-11 20:46:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213701
;

-- Oct 11, 2018 8:46:18 PM SGT
ALTER TABLE A_Depreciation_Exp ADD COLUMN C_AcctSchema_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 11, 2018 8:46:18 PM SGT
ALTER TABLE A_Depreciation_Exp ADD CONSTRAINT CAcctSchema_ADepreciationExp FOREIGN KEY (C_AcctSchema_ID) REFERENCES c_acctschema(c_acctschema_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Oct 11, 2018 8:55:01 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205838,'Accounting Schema','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',53322,213701,'Y',0,260,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-10-11 20:55:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-10-11 20:55:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','010b6a0d-e47f-4a41-a6f7-0368373a9e62','Y',260,1,1,1,'N','N','N')
;

-- Oct 11, 2018 8:57:59 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205839,'Accounting Schema','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',53162,213700,'Y',0,240,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-10-11 20:57:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-10-11 20:57:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','266fd230-5a9e-4d4e-83d5-9a5a62c6b753','Y',230,1,1,1,'N','N','N')
;

-- Oct 23, 2018 12:01:33 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-23 12:01:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59384
;

-- Oct 23, 2018 12:01:41 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-23 12:01:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59385
;

-- Oct 23, 2018 12:01:47 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-23 12:01:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59386
;

-- Oct 23, 2018 12:02:02 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-23 12:02:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59387
;

-- Oct 23, 2018 12:02:10 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-23 12:02:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59388
;

-- Oct 23, 2018 12:02:16 PM SGT
UPDATE AD_Field SET IsActive='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-23 12:02:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59389
;

-- Oct 23, 2018 12:06:01 PM SGT
UPDATE AD_Column SET IsActive='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2018-10-23 12:06:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59463
;

-- Oct 23, 2018 12:06:31 PM SGT
UPDATE AD_Column SET IsActive='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2018-10-23 12:06:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59464
;

-- Oct 23, 2018 12:07:20 PM SGT
UPDATE AD_Column SET IsActive='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2018-10-23 12:07:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59475
;

-- Oct 23, 2018 12:09:27 PM SGT
UPDATE AD_Column SET IsActive='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2018-10-23 12:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59469
;

-- Oct 23, 2018 12:09:45 PM SGT
UPDATE AD_Column SET IsActive='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2018-10-23 12:09:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59470
;

-- Oct 23, 2018 12:09:55 PM SGT
UPDATE AD_Column SET IsActive='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2018-10-23 12:09:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59478
;

SELECT register_migration_script('201904101655_IDEMPIERE-3947.sql') FROM dual
;