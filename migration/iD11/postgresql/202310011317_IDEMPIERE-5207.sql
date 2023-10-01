-- Oct 1, 2023, 1:17:59 PM WIB
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200355,'Info Window Translation',250,150,'Y',896,0,0,'Y',TO_TIMESTAMP('2023-10-01 13:17:58','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:17:58','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N',15761,'N','N',1,'N','D','Y','N','a77a01a7-d78d-4e61-845d-f764b1e167ce','B','N','Y',0)
;

-- Oct 1, 2023, 1:18:11 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207726,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200355,15762,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:10','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','8b0324fc-5e2d-4999-ac6d-e96e25cc7a5f','N',2)
;

-- Oct 1, 2023, 1:18:11 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207727,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200355,15763,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:11','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','2ce65d07-ebbc-4014-b7ac-909011c6d340','Y','N',4,2)
;

-- Oct 1, 2023, 1:18:12 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207728,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200355,15760,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:11','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','750347a2-97d0-443c-9525-474afd33e456','Y',10,2)
;

-- Oct 1, 2023, 1:18:13 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207729,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200355,15761,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:12','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','488e99bd-8391-4117-aefa-5b55d9cfd051','Y',20,2)
;

-- Oct 1, 2023, 1:18:14 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207730,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200355,15770,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:13','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','9ac10c53-8c86-49f7-bd82-1871c6b675d3','Y',30,5)
;

-- Oct 1, 2023, 1:18:15 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207731,'Description','Optional short description of the record','A description is limited to 255 characters.',200355,15771,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:14','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:14','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','d63da683-ca4d-46e7-9afb-45d96467f923','Y',40,5)
;

-- Oct 1, 2023, 1:18:15 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (207732,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200355,15772,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:15','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:15','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','feee8ec3-20de-4548-93f7-cca1b1865f2e','Y',50,5,3)
;

-- Oct 1, 2023, 1:18:16 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207733,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200355,15769,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:15','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:15','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','d7839a9b-58d5-4da6-891a-9864f78392a5','Y',60,2,2)
;

-- Oct 1, 2023, 1:18:16 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207734,'AD_InfoWindow_Trl_UU',200355,60424,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:16','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:16','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','5af0a74d-deb8-41d2-9654-705eae508fa1','N',2)
;

-- Oct 1, 2023, 1:18:17 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207735,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200355,15764,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:18:17','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:18:17','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','54c8ab42-e920-46f1-917c-5efb40b71428','Y',70,2,2)
;

-- Oct 1, 2023, 1:18:56 PM WIB
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2023-10-01 13:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207729
;

-- Oct 1, 2023, 1:18:56 PM WIB
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=5,Updated=TO_TIMESTAMP('2023-10-01 13:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207735
;

-- Oct 1, 2023, 1:18:56 PM WIB
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-10-01 13:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207734
;

-- Oct 1, 2023, 1:20:28 PM WIB
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200356,'Info Column Translation',250,160,'Y',898,0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:27','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:27','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N',15793,'N','N',1,'N','D','Y','N','28dff2eb-73b0-46ba-af64-329cfab43eb1','B','N','Y',0)
;

-- Oct 1, 2023, 1:20:33 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207736,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200356,15794,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:32','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:32','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','ab5d9282-a2d3-4e90-a746-ebab49afadb1','N',2)
;

-- Oct 1, 2023, 1:20:34 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (207737,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200356,15795,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:33','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:33','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','2533ee99-13cb-4580-a57f-90f134504f70','Y','N',4,2)
;

-- Oct 1, 2023, 1:20:35 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207738,'Info Column','Info Window Column','Column in the Info Window for display and/or selection.  If used for selection, the column cannot be a SQL expression. The SQL clause must be fully qualified based on the FROM clause in the Info Window definition',200356,15792,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:34','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','11428a0a-249a-4d45-a346-7f13dcc26d24','Y',10,2)
;

-- Oct 1, 2023, 1:20:36 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207739,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200356,15793,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:35','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:35','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','1c2db787-9afa-4f2f-b7cb-822b57a294fe','Y',20,2)
;

-- Oct 1, 2023, 1:20:36 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207740,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200356,15802,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:36','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e19187e3-b9f3-45c3-9bf0-365f78d4a0ad','Y',30,5)
;

-- Oct 1, 2023, 1:20:37 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207741,'Description','Optional short description of the record','A description is limited to 255 characters.',200356,15803,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:36','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','88f6f560-0091-42b6-96c9-601f388c5386','Y',40,5)
;

-- Oct 1, 2023, 1:20:38 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (207742,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200356,15804,'Y',2000,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:37','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','c1578a63-7a01-4bdd-b28b-5475647256a5','Y',50,5,3)
;

-- Oct 1, 2023, 1:20:38 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207743,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200356,15801,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:38','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:38','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','c16893b3-ca32-4607-84b9-75b227ab3d75','Y',60,2,2)
;

-- Oct 1, 2023, 1:20:39 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (207744,'AD_InfoColumn_Trl_UU',200356,60422,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:38','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:38','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','15cdacf4-67ed-4d61-9ef2-3163d1bb520b','N',2)
;

-- Oct 1, 2023, 1:20:40 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207745,'Placeholder',200356,213364,'Y',255,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:39','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:39','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','2b8c2cb9-b4d6-4d6a-ba7a-0f5a05a6c295','Y',70,5)
;

-- Oct 1, 2023, 1:20:41 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207746,'Placeholder2',200356,215636,'Y',255,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','44cb40cd-6037-46f0-afef-cd84b827204d','Y',80,5)
;

-- Oct 1, 2023, 1:20:42 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207747,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200356,15796,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-01 13:20:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-01 13:20:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','8db3de01-caea-4e9b-9b31-b43c293de851','Y',90,2,2)
;

-- Oct 1, 2023, 1:21:42 PM WIB
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2023-10-01 13:21:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207739
;

-- Oct 1, 2023, 1:21:42 PM WIB
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=5,Updated=TO_TIMESTAMP('2023-10-01 13:21:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207747
;

-- Oct 1, 2023, 1:21:42 PM WIB
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-10-01 13:21:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207745
;

-- Oct 1, 2023, 1:21:42 PM WIB
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-10-01 13:21:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207746
;

-- Oct 1, 2023, 1:21:42 PM WIB
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-10-01 13:21:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207744
;

-- IDEMPIERE-5207
SELECT register_migration_script('202310011317_IDEMPIERE-5207.sql') FROM dual;