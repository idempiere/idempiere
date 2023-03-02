-- IDEMPIERE-5470
SELECT register_migration_script('202302060840_IDEMPIERE-5470.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 6, 2023, 8:40:29 AM CET
UPDATE AD_Element SET ColumnName='DateRangeOption', Name='Date Range Option', Description='Options, how the date editor will be displayed.', PrintName='Date Range Option',Updated=TO_TIMESTAMP('2023-02-06 08:40:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203739
;

-- Feb 6, 2023, 8:40:29 AM CET
UPDATE AD_Column SET ColumnName='DateRangeOption', Name='Date Range Option', Description='Options, how the date editor will be displayed.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203739
;

-- Feb 6, 2023, 8:40:29 AM CET
UPDATE AD_Process_Para SET ColumnName='DateRangeOption', Name='Date Range Option', Description='Options, how the date editor will be displayed.', Help=NULL, AD_Element_ID=203739 WHERE UPPER(ColumnName)='DATERANGEOPTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 6, 2023, 8:40:29 AM CET
UPDATE AD_Process_Para SET ColumnName='DateRangeOption', Name='Date Range Option', Description='Options, how the date editor will be displayed.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203739 AND IsCentrallyMaintained='Y'
;

-- Feb 6, 2023, 8:40:29 AM CET
UPDATE AD_InfoColumn SET ColumnName='DateRangeOption', Name='Date Range Option', Description='Options, how the date editor will be displayed.', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203739 AND IsCentrallyMaintained='Y'
;

-- Feb 6, 2023, 8:40:29 AM CET
UPDATE AD_Field SET Name='Date Range Option', Description='Options, how the date editor will be displayed.', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203739) AND IsCentrallyMaintained='Y'
;

-- Feb 6, 2023, 8:40:29 AM CET
UPDATE AD_PrintFormatItem SET PrintName='Date Range Option', Name='Date Range Option' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203739)
;

-- Feb 6, 2023, 8:52:12 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200228,'Date Range Option','Options, how the date editor will be displayed.','L',0,0,'Y',TO_TIMESTAMP('2023-02-06 08:52:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-06 08:52:11','YYYY-MM-DD HH24:MI:SS'),100,'D','N','299b9200-3e9e-4923-8c32-5273dd17e7b4')
;

-- Feb 6, 2023, 8:53:29 AM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200622,'Date Editor and Range Picker',200228,'D',0,0,'Y',TO_TIMESTAMP('2023-02-06 08:53:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-06 08:53:28','YYYY-MM-DD HH24:MI:SS'),100,'D','e56a4c96-0480-4c0e-9f25-e68d1d70d082')
;

-- Feb 6, 2023, 8:53:42 AM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200623,'Text and Range Picker',200228,'T',0,0,'Y',TO_TIMESTAMP('2023-02-06 08:53:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-06 08:53:42','YYYY-MM-DD HH24:MI:SS'),100,'D','6ee1efd4-d59f-4efb-b0ca-722d2dd39ce5')
;

-- Feb 6, 2023, 8:54:33 AM CET
UPDATE AD_Column SET DefaultValue='D', AD_Reference_ID=17, AD_Reference_Value_ID=200228,Updated=TO_TIMESTAMP('2023-02-06 08:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215695
;

-- Feb 6, 2023, 8:54:33 AM CET
ALTER TABLE AD_Process_Para DROP COLUMN IsDisplayDateInWords
;

-- Feb 6, 2023, 8:54:33 AM CET
ALTER TABLE AD_Process_Para ADD DateRangeOption CHAR(1) DEFAULT 'D' NOT NULL
;

-- Feb 6, 2023, 9:18:45 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=230, XPosition=4,Updated=TO_TIMESTAMP('2023-02-06 09:18:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207456
;

