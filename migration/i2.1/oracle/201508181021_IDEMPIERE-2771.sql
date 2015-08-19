SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2771 Improve 2pack tracing for errors
-- Aug 13, 2015 7:42:06 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212222,0,'Package Imp. Proc.',50003,'AD_Package_Imp_Proc_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2015-08-13 19:42:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:42:05','YYYY-MM-DD HH24:MI:SS'),100,50034,'Y','N','D','N','N','N','Y','1b15ffd2-2148-4337-9e59-652b0e91b73f','Y',0,'N','N')
;

-- Aug 13, 2015 7:42:13 PM COT
UPDATE AD_Column SET FKConstraintName='ADPackageImpProc_ADPackageImp', FKConstraintType='N',Updated=TO_DATE('2015-08-13 19:42:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212222
;

-- Aug 13, 2015 7:42:13 PM COT
ALTER TABLE AD_Package_Imp ADD AD_Package_Imp_Proc_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 13, 2015 7:42:13 PM COT
ALTER TABLE AD_Package_Imp ADD CONSTRAINT ADPackageImpProc_ADPackageImp FOREIGN KEY (AD_Package_Imp_Proc_ID) REFERENCES ad_package_imp_proc(ad_package_imp_proc_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 13, 2015 7:45:44 PM COT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200191,'Package Installation',50005,20,'Y',50003,0,0,'Y',TO_DATE('2015-08-13 19:45:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:44','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y',212222,'AD_Package_Imp_Proc.Created DESC','N','N',0,'N','D','N','N','9290ca4f-1650-4c88-9507-7a843f45384d','B')
;

-- Aug 13, 2015 7:45:53 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203837,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200191,50041,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d8078cb4-d8cb-4fa3-a97b-d8e8fba93fc9','Y',10,2)
;

-- Aug 13, 2015 7:45:53 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (203838,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200191,50061,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f4c81ec0-cbf4-4119-b8f7-89999cc8998f','Y','N',4,2)
;

-- Aug 13, 2015 7:45:53 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203839,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200191,50046,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9fd4405f-28a3-4ac8-ae71-8794275c63b5','Y',20,5)
;

-- Aug 13, 2015 7:45:53 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (203840,'Description','Optional short description of the record','A description is limited to 255 characters.',200191,50058,'Y',1000,40,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ca832890-27e6-48e0-9686-33c6ad75acda','Y',30,5,8)
;

-- Aug 13, 2015 7:45:54 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203841,'Package Imp.',200191,50040,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bf3180bc-3adf-4b46-8f36-418374f1b8e6','N',2)
;

-- Aug 13, 2015 7:45:54 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203842,'CreatorContact',200191,50044,'Y',255,50,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aebd79e4-0933-4f5b-aed1-726879e31c65','Y',40,5)
;

-- Aug 13, 2015 7:45:54 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203843,'EMail Address','Electronic Mail Address','The Email Address is the Electronic Mail ID for this User and should be fully qualified (e.g. joe.smith@company.com). The Email Address is used to access the self service application functionality from the web.',200191,50045,'Y',60,60,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5d64032c-a33d-409d-b758-5e95d6a7f19a','Y',50,5)
;

-- Aug 13, 2015 7:45:54 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203844,'Package Version',200191,50047,'Y',20,70,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2bb66736-4f30-4d79-9a6e-2f0a35d16fe5','Y',60,2)
;

-- Aug 13, 2015 7:45:55 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203845,'Process Now',200191,50048,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0ee8bac8-b589-4f66-b57f-cad79cf4828b','Y',70,2,2)
;

-- Aug 13, 2015 7:45:55 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203846,'Version','Version of the table definition','The Version indicates the version of this table definition.',200191,50049,'Y',20,90,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f70e7a70-cf2e-43b3-a5a4-c3996d872359','Y',80,2)
;

-- Aug 13, 2015 7:45:55 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203847,'Uninstall',200191,50053,'Y',1,100,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','037e4eaa-fefa-449b-bf9b-b8c1f4ffb1f8','Y',90,2,2)
;

-- Aug 13, 2015 7:45:55 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203848,'Release No','Internal Release Number',200191,50054,'Y',20,110,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f5f66967-57b0-4d39-896f-e06bdab02e80','Y',100,2)
;

-- Aug 13, 2015 7:45:55 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203849,'Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.',200191,50055,'Y',1,120,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8ef4b72f-c9ed-49ab-bccb-2023d48c7913','Y',110,2,2)
;

-- Aug 13, 2015 7:45:56 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203850,'Package Status',200191,50056,'Y',22,130,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c630875b-162c-4058-b9da-cb6f82fa5ca1','Y',120,2)
;

-- Aug 13, 2015 7:45:57 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203851,'Creator',200191,50059,'Y',60,140,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e830521e-be76-4627-8a35-c7ac09bfd596','Y',130,5)
;

-- Aug 13, 2015 7:45:57 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203852,'AD_Package_Imp_UU',200191,60446,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','32204dd9-2efa-4a55-89df-4f4a505381d6','N',2)
;

-- Aug 13, 2015 7:45:57 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203853,'Package Imp. Proc.',200191,212222,'Y',10,150,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ffd6eb2b-4af3-4954-98dc-848cb85d867f','Y',140,2)
;

-- Aug 13, 2015 7:45:58 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203854,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200191,50057,'Y',1,160,'N','N','N','N',0,0,'Y',TO_DATE('2015-08-13 19:45:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-08-13 19:45:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','82331802-b0f8-47b5-a860-1879b135d071','Y',150,2,2)
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203853
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET SeqNo=40, ColumnSpan=3,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203839
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=5, ColumnSpan=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203844
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1, ColumnSpan=3,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203850
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203840
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=5, ColumnSpan=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203849
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=6, ColumnSpan=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203854
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203852
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203851
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203842
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203843
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203841
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203848
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203847
;

-- Aug 13, 2015 7:54:55 PM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1, ColumnSpan=1,Updated=TO_DATE('2015-08-13 19:54:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203846
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203853
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203851
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203849
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203845
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203843
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203842
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203848
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203847
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203846
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203837
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=203839
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=203844
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=203850
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=203840
;

-- Aug 13, 2015 7:57:10 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=203854
;

-- Aug 13, 2015 7:58:07 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=203841
;

-- Aug 13, 2015 7:58:07 PM COT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=203854
;

-- Aug 13, 2015 7:58:26 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_DATE('2015-08-13 19:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203841
;

-- Aug 13, 2015 7:58:26 PM COT
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2015-08-13 19:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203839
;

-- Aug 13, 2015 7:58:26 PM COT
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2015-08-13 19:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203844
;

-- Aug 13, 2015 7:58:26 PM COT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2015-08-13 19:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203850
;

-- Aug 13, 2015 7:58:26 PM COT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2015-08-13 19:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203840
;

-- Aug 13, 2015 7:58:26 PM COT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2015-08-13 19:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203845
;

-- Aug 13, 2015 7:58:26 PM COT
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2015-08-13 19:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203849
;

-- Aug 13, 2015 7:58:26 PM COT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2015-08-13 19:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203854
;

-- Aug 14, 2015 10:42:44 AM COT
UPDATE AD_Tab SET TabLevel=1,Updated=TO_DATE('2015-08-14 10:42:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200191
;

-- Aug 14, 2015 10:45:01 AM COT
UPDATE AD_Tab SET OrderByClause='AD_Package_Imp.Created DESC',Updated=TO_DATE('2015-08-14 10:45:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200191
;

-- Aug 14, 2015 10:45:18 AM COT
UPDATE AD_Tab SET OrderByClause='AD_Package_Imp_Proc.Created DESC',Updated=TO_DATE('2015-08-14 10:45:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50008
;

-- Aug 14, 2015 10:49:45 AM COT
UPDATE AD_Field SET AD_Reference_ID=19,Updated=TO_DATE('2015-08-14 10:49:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203841
;

-- Aug 18, 2015 11:23:06 AM COT
UPDATE AD_Column SET AD_Reference_ID=30, IsUpdateable='N',Updated=TO_DATE('2015-08-18 11:23:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50066
;

-- Aug 18, 2015 11:23:13 AM COT
UPDATE AD_Column SET AD_Reference_ID=19,Updated=TO_DATE('2015-08-18 11:23:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50067
;

-- Aug 18, 2015 11:25:05 AM COT
UPDATE AD_Column SET Name='Record ID', Description='Direct internal record ID', Help='The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.', ColumnName='Record_ID', AD_Reference_ID=28, AD_Element_ID=538, IsAlwaysUpdateable='Y', IsToolbarButton='B',Updated=TO_DATE('2015-08-18 11:25:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50064
;

ALTER TABLE AD_PACKAGE_IMP_DETAIL RENAME COLUMN AD_ORIGINAL_ID TO RECORD_ID
;

-- Aug 18, 2015 11:27:08 AM COT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2015-08-18 11:27:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50045
;

-- Aug 18, 2015 11:27:08 AM COT
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2015-08-18 11:27:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50050
;

-- Aug 18, 2015 11:27:08 AM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-18 11:27:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50051
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, XPosition=4,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50054
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET SeqNo=30, ColumnSpan=2,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50055
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=1,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50062
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4, ColumnSpan=1,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50059
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=6, ColumnSpan=1,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50060
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50058
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=1, ColumnSpan=2,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50064
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=4,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50061
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=1,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50057
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50063
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50056
;

-- Aug 18, 2015 11:29:04 AM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-18 11:29:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50065
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50065
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50063
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50056
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50055
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50054
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50053
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=50062
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=50059
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=50060
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=50064
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=50058
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=50061
;

-- Aug 18, 2015 11:29:38 AM COT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=50057
;

-- Aug 18, 2015 11:45:42 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, XPosition=4,Updated=TO_DATE('2015-08-18 11:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50021
;

-- Aug 18, 2015 11:45:42 AM COT
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2015-08-18 11:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50023
;

-- Aug 18, 2015 11:45:42 AM COT
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2015-08-18 11:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50025
;

-- Aug 18, 2015 11:45:42 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=4,Updated=TO_DATE('2015-08-18 11:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50026
;

-- Aug 18, 2015 11:45:42 AM COT
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2015-08-18 11:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50027
;

-- Aug 18, 2015 11:45:42 AM COT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2015-08-18 11:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50028
;

-- Aug 18, 2015 11:45:42 AM COT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2015-08-18 11:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50030
;

-- Aug 18, 2015 11:45:42 AM COT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2015-08-18 11:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50031
;

-- Aug 18, 2015 11:45:43 AM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-18 11:45:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50024
;

-- Aug 18, 2015 11:45:43 AM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-18 11:45:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50022
;

-- Aug 18, 2015 11:45:43 AM COT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_DATE('2015-08-18 11:45:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50029
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50029
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50024
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50023
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50022
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50021
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=50020
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=50025
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=50026
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=50027
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=50028
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=50030
;

-- Aug 18, 2015 11:47:17 AM COT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=50031
;

-- Aug 18, 2015 8:16:24 PM COT
UPDATE AD_Tab SET IsReadOnly='N',Updated=TO_DATE('2015-08-18 20:16:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200191
;

-- Aug 18, 2015 8:16:39 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:16:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203837
;

-- Aug 18, 2015 8:16:41 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:16:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203838
;

-- Aug 18, 2015 8:16:42 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:16:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203853
;

-- Aug 18, 2015 8:16:44 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203841
;

-- Aug 18, 2015 8:16:51 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:16:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203839
;

-- Aug 18, 2015 8:16:55 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:16:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203850
;

-- Aug 18, 2015 8:16:57 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:16:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203840
;

-- Aug 18, 2015 8:16:59 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:16:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203845
;

-- Aug 18, 2015 8:17:04 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:17:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203849
;

-- Aug 18, 2015 8:17:09 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2015-08-18 20:17:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203854
;

-- Aug 18, 2015 8:17:45 PM COT
UPDATE AD_Field SET IsUpdateable='Y', IsAlwaysUpdateable='Y',Updated=TO_DATE('2015-08-18 20:17:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203844
;

SELECT register_migration_script('201508181021_IDEMPIERE-2771.sql') FROM dual
;

