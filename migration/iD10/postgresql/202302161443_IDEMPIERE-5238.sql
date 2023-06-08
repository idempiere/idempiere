-- IDEMPIERE-5238 Record_ID editor
SELECT register_migration_script('202302161443_IDEMPIERE-5238.sql') FROM dual;

-- Feb 16, 2023, 2:43:55 PM CET
UPDATE AD_Column SET AD_Reference_ID=200202,Updated=TO_TIMESTAMP('2023-02-16 14:43:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=60265
;

-- Feb 16, 2023, 2:49:07 PM CET
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_TIMESTAMP('2023-02-16 14:49:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60992
;

-- Feb 16, 2023, 2:49:35 PM CET
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-02-16 14:49:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=135
;

-- Feb 16, 2023, 2:49:53 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215774,0,'Table','Database Table information','The Database Table provides the information of the table definition',135,'AD_Table_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-02-16 14:49:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-16 14:49:53','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','N','N','Y','3d04d37e-89a5-4352-9837-ffeda51edaa3','Y',0,'N','N','N','N')
;

-- Feb 16, 2023, 2:49:57 PM CET
UPDATE AD_Column SET FKConstraintName='ADTable_Test', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-02-16 14:49:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215774
;

-- Feb 16, 2023, 2:49:57 PM CET
ALTER TABLE Test ADD COLUMN AD_Table_ID NUMERIC(10) DEFAULT NULL
;

-- Feb 16, 2023, 2:49:57 PM CET
ALTER TABLE Test ADD CONSTRAINT ADTable_Test FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 16, 2023, 2:50:15 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215775,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',135,'Record_ID',22,'N','N','N','N','N',0,'N',200202,0,0,'Y',TO_TIMESTAMP('2023-02-16 14:50:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-16 14:50:15','YYYY-MM-DD HH24:MI:SS'),100,538,'Y','N','D','N','N','N','Y','354a15e3-4479-4629-b646-5c79887757ee','Y',0,'N','N','N')
;

-- Feb 16, 2023, 2:50:17 PM CET
ALTER TABLE Test ADD COLUMN Record_ID NUMERIC(10) DEFAULT NULL
;

-- Feb 16, 2023, 2:50:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207569,'Table','Database Table information','The Database Table provides the information of the table definition',152,215774,'Y',10,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-02-16 14:50:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-16 14:50:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fdaecd3b-5f1b-4f18-9896-da425c7862eb','Y',260,2)
;

-- Feb 16, 2023, 2:50:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207570,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',152,215775,'Y',22,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-02-16 14:50:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-16 14:50:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bdc4c637-6066-479d-a606-9dd6cb6bbb36','Y',270,2)
;

-- Feb 16, 2023, 2:51:43 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=220, XPosition=1,Updated=TO_TIMESTAMP('2023-02-16 14:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207569
;

-- Feb 16, 2023, 2:51:43 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=230, XPosition=4,Updated=TO_TIMESTAMP('2023-02-16 14:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207570
;

-- Feb 16, 2023, 2:51:43 PM CET
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2023-02-16 14:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205590
;

-- Feb 16, 2023, 2:51:43 PM CET
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2023-02-16 14:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8351
;

-- Feb 16, 2023, 2:51:43 PM CET
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2023-02-16 14:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8352
;

-- Feb 16, 2023, 2:51:43 PM CET
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2023-02-16 14:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3060
;

-- Feb 16, 2023, 2:51:43 PM CET
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2023-02-16 14:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3061
;

-- Feb 16, 2023, 2:51:43 PM CET
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2023-02-16 14:51:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206818
;

-- Feb 16, 2023, 3:03:55 PM CET
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_TIMESTAMP('2023-02-16 15:03:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207570
;


UPDATE AD_Field SET XPosition=XPosition-1, IsReadOnly='Y'
WHERE AD_Field_ID < 10000000 AND AD_Column_ID IN
(SELECT AD_Column_ID FROM AD_Column
WHERE  ColumnName='Record_ID' AND AD_Reference_ID = 28 AND AD_Column_ID < 1000000
)
;

UPDATE AD_Column SET AD_Reference_ID = 200202
WHERE  ColumnName='Record_ID' AND AD_Reference_ID = 28 AND AD_Column_ID < 1000000
;
