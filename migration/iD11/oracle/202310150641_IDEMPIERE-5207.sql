SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 15, 2023, 6:41:21 AM WIB
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200358,'Table Translation',250,170,'Y',746,0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:20','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N',12715,'N','N',0,'N','D','Y','N','a2d622d5-b31e-4543-8c0e-705641c9b770','B','N','Y',0)
;

-- Oct 15, 2023, 6:41:29 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207758,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200358,12719,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:28','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:28','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','d65f7e29-cfef-495b-81fa-c2a28b15d81b','N',2)
;

-- Oct 15, 2023, 6:41:30 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207759,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200358,12720,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:29','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:29','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','ecedf080-e40f-4075-bdb5-46085b9d31db','Y','N',4,2)
;

-- Oct 15, 2023, 6:41:30 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207760,'Table','Database Table information','The Database Table provides the information of the table definition',200358,12714,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:30','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:30','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','c117928a-e9e8-458e-b8ce-5afc67631da8','Y',10,2)
;

-- Oct 15, 2023, 6:41:31 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207761,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200358,12715,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:30','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:30','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','938894e1-35af-46f8-bcc9-ddc6056cf147','Y',20,2)
;

-- Oct 15, 2023, 6:41:32 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207762,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200358,12716,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:31','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:31','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','1e3e73be-46e6-4ab9-acae-a0395a2c706b','Y',30,5)
;

-- Oct 15, 2023, 6:41:33 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207763,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200358,12724,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:32','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:32','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','c751bb1c-cbcc-4f75-837a-a7241e419186','Y',40,2,2)
;

-- Oct 15, 2023, 6:41:34 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207764,'AD_Table_Trl_UU',200358,60508,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:33','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','caae7376-6c8b-47cc-a8fb-5508296d6e61','N',2)
;

-- Oct 15, 2023, 6:41:35 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207765,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200358,12721,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:41:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:41:34','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e99d4aea-4ba2-4c03-8ab6-6d8b00429916','Y',50,2,2)
;

-- Oct 15, 2023, 6:42:12 AM WIB
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200359,'Column Translation',250,180,'Y',752,0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:12','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N',12953,'N','N',1,'N','D','Y','N','e4c00e2c-69a2-46ac-a675-b13f4dd0e719','B','N','Y',0)
;

-- Oct 15, 2023, 6:42:19 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207766,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200359,12961,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:18','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:18','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','201cc1c9-ae62-42b6-8003-5cd7cdf4b6bc','N',2)
;

-- Oct 15, 2023, 6:42:20 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207767,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200359,12951,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:19','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:19','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','9b5d914d-83b0-4f7c-a2a6-24462c3359b1','Y','N',4,2)
;

-- Oct 15, 2023, 6:42:20 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207768,'Column','Column in the table','Link to the database column of the table',200359,12955,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:20','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','34e5edee-2b21-45d8-9a58-014ab857ac1b','Y',10,2)
;

-- Oct 15, 2023, 6:42:21 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207769,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200359,12953,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:20','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','9a136562-ab76-42cf-b136-d35e3c070040','Y',20,2)
;

-- Oct 15, 2023, 6:42:23 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207770,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200359,12957,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:21','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','0ac07136-716e-4312-9ee4-efc6b00ae42c','Y',30,5)
;

-- Oct 15, 2023, 6:42:24 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207771,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200359,12954,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:23','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:23','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','8896a604-4310-4f01-94dd-4c95f75d0627','Y',40,2,2)
;

-- Oct 15, 2023, 6:42:24 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207772,'AD_Column_Trl_UU',200359,60390,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:24','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','6878e934-8c4b-4216-957e-7824ca83f6fd','N',2)
;

-- Oct 15, 2023, 6:42:25 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207773,'Placeholder',200359,213358,'Y',255,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:24','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','aefa2a5f-05fd-438b-b08e-bfe446e13131','Y',50,5)
;

-- Oct 15, 2023, 6:42:26 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207774,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200359,12959,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-15 06:42:25','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-15 06:42:25','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','18aa06c9-1abe-42fa-8d09-fd98baccf557','Y',60,2,2)
;

-- Oct 15, 2023, 6:42:41 AM WIB
UPDATE AD_Tab SET TabLevel=1,Updated=TO_TIMESTAMP('2023-10-15 06:42:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200358
;

-- IDEMPIERE-5207
SELECT register_migration_script('202310150641_IDEMPIERE-5207.sql') FROM dual;