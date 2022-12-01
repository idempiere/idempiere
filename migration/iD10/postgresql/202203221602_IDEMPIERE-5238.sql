-- IDEMPIERE-5238
SELECT register_migration_script('202203221602_IDEMPIERE-5238.sql') FROM dual;

-- Mar 22, 2022, 4:02:23 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200202,'Related To','D',0,0,'Y',TO_TIMESTAMP('2022-03-22 16:02:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-22 16:02:23','YYYY-MM-DD HH24:MI:SS'),100,'D','N','55330dab-f2b6-499d-af8b-187848c47a40')
;

-- Mar 22, 2022, 4:03:11 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214719,0,'Table','Database Table information','The Database Table provides the information of the table definition',53354,'AD_Table_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-03-22 16:03:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-22 16:03:11','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','N','N','Y','b1ca962e-b18c-4b5e-8a04-a4b861f9289a','Y',0,'N','N','N','N')
;

-- Mar 22, 2022, 4:03:16 PM CET
UPDATE AD_Column SET FKConstraintName='ADTable_CContactActivity', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-03-22 16:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214719
;

-- Mar 22, 2022, 4:03:16 PM CET
ALTER TABLE C_ContactActivity ADD COLUMN AD_Table_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 22, 2022, 4:03:16 PM CET
ALTER TABLE C_ContactActivity ADD CONSTRAINT ADTable_CContactActivity FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 22, 2022, 4:04:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214720,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',53354,'Record_ID',22,'N','N','N','N','N',0,'N',200202,0,0,'Y',TO_TIMESTAMP('2022-03-22 16:04:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-22 16:04:08','YYYY-MM-DD HH24:MI:SS'),100,538,'N','N','D','N','N','N','Y','b6f4fa3f-27dd-4c51-878b-a747d9995cea','Y',0,'N','N','N')
;

-- Mar 22, 2022, 4:04:12 PM CET
ALTER TABLE C_ContactActivity ADD COLUMN Record_ID NUMERIC(10) DEFAULT NULL 
;

-- Mar 22, 2022, 4:11:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206918,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',53454,214720,'Y',0,120,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-03-22 16:11:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-22 16:11:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b5c7c74b-555f-4dab-a0fe-772bf726bc76','Y',120,1,1,1,'N','N','N','N')
;

-- Mar 22, 2022, 4:20:12 PM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2022-03-22 16:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214720
;

-- Mar 23, 2022, 9:37:19 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206919,'Table','Database Table information','The Database Table provides the information of the table definition',53454,214719,'N',0,130,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-03-23 09:37:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-23 09:37:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','243d1496-05b5-487f-a000-e5b8e0ab7f00','N',130,1,1,1,'N','N','N','N')
;

