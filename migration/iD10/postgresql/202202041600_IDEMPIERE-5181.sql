-- IDEMPIERE-5181
-- Feb 4, 2022, 4:07:00 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,AD_Val_Rule_Lookup_ID) VALUES (214666,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',282,'AD_Role_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-02-04 16:07:00','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-04 16:07:00','YYYY-MM-DD HH24:MI:SS'),0,123,'Y','N','D','N','N','N','Y','7f5f142d-5712-4870-8e2c-c3abcf29b4b3','Y',0,'N','N','C','N',158)
;

-- Feb 4, 2022, 4:07:04 PM CET
UPDATE AD_Column SET FKConstraintName='ADRole_ADPInstance', FKConstraintType='C',Updated=TO_TIMESTAMP('2022-02-04 16:07:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214666
;

-- Feb 4, 2022, 4:07:04 PM CET
ALTER TABLE AD_PInstance ADD COLUMN AD_Role_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 4, 2022, 4:07:04 PM CET
ALTER TABLE AD_PInstance ADD CONSTRAINT ADRole_ADPInstance FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Feb 7, 2022, 10:57:17 AM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200121,'Saved Process Parameters',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:57:16','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:57:16','YYYY-MM-DD HH24:MI:SS'),0,'M','N','D','Y','N',0,0,'N','b8aad4f2-e8a3-49c2-8e01-effde94c003c')
;

-- Feb 7, 2022, 10:58:07 AM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,WhereClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200303,'Process',200121,10,'Y',282,0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:07','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:07','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N','N','AD_PInstance.Name IS NOT NULL','N','N',0,'N','D','Y','N','0bac95a9-7946-4cd8-a2d9-6ec0309c1c37','B','N','Y',0)
;

-- Feb 7, 2022, 10:58:22 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206838,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200303,8221,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:21','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:21','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','77fafd9d-3aea-459f-8586-38ce8d28c023','Y',10,2)
;

-- Feb 7, 2022, 10:58:22 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (206839,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200303,8223,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:22','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:22','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','8c349ce8-d66a-42b5-a276-7ff9c07737b0','Y','N',4,2)
;

-- Feb 7, 2022, 10:58:22 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206840,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200303,210890,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:22','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:22','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','e60f3ec9-3730-4c7d-8ce4-c37f8351ebf3','Y',20,5)
;

-- Feb 7, 2022, 10:58:23 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206841,'Process Instance','Instance of the process',200303,2780,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:22','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:22','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','aaf0d1e5-f9a5-405b-9655-c54995beea61','N',2)
;

-- Feb 7, 2022, 10:58:23 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206842,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200303,2781,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:23','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:23','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','35d65c6e-a558-4cce-b8b9-6eb6968a31e8','Y',30,2)
;

-- Feb 7, 2022, 10:58:23 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206843,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200303,2782,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:23','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:23','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','6fb718f6-6e7f-40cd-8bfb-e5fd95013f7d','Y',40,2)
;

-- Feb 7, 2022, 10:58:23 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206844,'Processing',200303,2783,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:23','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:23','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','0957e1cd-d693-4c01-9ee4-ad9e68132095','Y',50,2,2)
;

-- Feb 7, 2022, 10:58:24 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206845,'Result','Result of the action taken','The Result indicates the result of any action taken on this request.',200303,2786,'Y',22,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:23','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:23','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','3f14f8c8-fce3-4083-8f21-9576cd588ec7','Y',60,2)
;

-- Feb 7, 2022, 10:58:24 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206846,'Error Msg',200303,3433,'Y',2000,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:24','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:24','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','5778a427-90ed-4e27-a5f5-cc6eb1b5acb1','Y',70,5)
;

-- Feb 7, 2022, 10:58:24 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206847,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200303,5951,'Y',22,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:24','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:24','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','937da547-693b-45da-a2a0-1d8ad4762df1','Y',80,2)
;

-- Feb 7, 2022, 10:58:25 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206848,'AD_PInstance_UU',200303,60451,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:24','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:24','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','be7da8a4-d7db-4287-9b3e-7ba1f9c47f2e','N',2)
;

-- Feb 7, 2022, 10:58:25 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206849,'Run as Job',200303,211199,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:25','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:25','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','22cdc27a-c49a-459e-9fb4-654370bee7db','Y',90,2,2)
;

-- Feb 7, 2022, 10:58:25 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206850,'Notification Type','Type of Notifications','Emails or Notification sent out for Request Updates, etc.',200303,211201,'Y',2,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:25','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:25','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','96fead63-f748-4287-9eae-94bab34aa5e3','Y',100,2)
;

-- Feb 7, 2022, 10:58:26 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206851,'Report Type',200303,211830,'Y',5,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:25','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:25','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','db71d28e-f940-44f7-a792-048926bf4afc','Y',110,2)
;

-- Feb 7, 2022, 10:58:26 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206852,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200303,211834,'Y',22,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:26','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:26','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','2ca162d7-5f2a-4fb6-8943-d3b862259815','Y',120,2)
;

-- Feb 7, 2022, 10:58:26 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206853,'Summary Level','This is a summary entity','A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.',200303,211837,'Y',1,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:26','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:26','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','d75a4ad5-75b8-4542-affa-ef48377c917f','Y',130,2,2)
;

-- Feb 7, 2022, 10:58:26 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206854,'Language ID',200303,211868,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:26','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:26','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','9c228238-8e73-4c9a-869c-49a17a69fb16','Y',140,2)
;

-- Feb 7, 2022, 10:58:27 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206855,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200303,214666,'Y',22,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:26','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:26','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','5937d8ad-b7fb-4a79-b6f8-fdb9d2453d16','Y',150,2)
;

-- Feb 7, 2022, 10:58:27 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206856,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200303,8225,'Y',1,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 10:58:27','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 10:58:27','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','7e7ce516-9b46-4099-966c-a2aeabef8ff2','Y',160,2,2)
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206840
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206856
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206842
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206847
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206855
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206851
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206852
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206854
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206853
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206848
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206846
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206850
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206841
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206844
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206843
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206845
;

-- Feb 7, 2022, 10:59:26 AM CET
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-07 10:59:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206849
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206850
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206849
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206846
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206845
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206844
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206843
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206839
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206840
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206842
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206855
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206847
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206851
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206852
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206854
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206853
;

-- Feb 7, 2022, 11:00:21 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206856
;

-- Feb 7, 2022, 11:00:58 AM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200304,'Parameters',200121,20,'Y',283,0,0,'Y',TO_TIMESTAMP('2022-02-07 11:00:58','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:00:58','YYYY-MM-DD HH24:MI:SS'),0,'N','N','N','N','N','N',1,'N','D','Y','N','3647929b-b485-4401-9014-59c878d55ca3','B','N','Y',0)
;

-- Feb 7, 2022, 11:01:08 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206857,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200304,8229,'N',1,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:08','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:08','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','8998fffc-dc4a-4705-bc8b-9e96cbf61cb0','N',0,2,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:09 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206858,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200304,8232,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:08','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:08','YYYY-MM-DD HH24:MI:SS'),0,'Y','Y','D','ed23ec1a-a823-4945-aed1-f5dcd6525958','Y',10,1,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:09 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206859,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200304,8231,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:09','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:09','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','5f00ba5e-6568-4150-9847-6020c720c01e','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:09 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206860,'Process Instance','Instance of the process',200304,2787,'Y',14,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:09','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:09','YYYY-MM-DD HH24:MI:SS'),0,'Y','Y','D','131854a1-a0e7-4305-a2d5-5995154e3711','Y',30,1,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:10 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206861,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200304,3733,'Y',14,40,1,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:09','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:09','YYYY-MM-DD HH24:MI:SS'),0,'Y','Y','D','bb0f567c-0fc1-4c12-aa17-486fd0979b78','N','Y',40,4,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:10 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206862,'Parameter Name',200304,4213,'Y',26,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:10','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:10','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','2ce5f253-a4fc-4b3f-a154-bad66af02103','Y',50,1,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:10 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206863,'Info','Information','The Information displays data from the source document line.',200304,5664,'Y',20,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:10','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:10','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','3b21e44e-2f41-48bf-a652-dae74065fffd','Y',60,1,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:11 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206864,'Info To',200304,5665,'Y',20,70,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:10','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:10','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','92bd55e7-3188-4a58-82f9-e6655576817c','Y',70,4,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:11 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206865,'Process String','Process Parameter',200304,2791,'Y',20,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:11','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:11','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','c651ab9d-5a05-4b16-9721-cf9aa50747fe','Y',80,1,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:11 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206866,'Process String To','Process Parameter',200304,2792,'Y',20,90,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:11','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:11','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','fbd1b771-b60a-430d-9a77-39fa63810ab6','Y',90,4,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:12 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206867,'Process Date','Process Parameter',200304,2797,'Y',14,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:11','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:11','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','3ca67658-e633-4778-94c5-3dd7df6c0545','Y',100,1,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:12 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206868,'Process Date To','Process Parameter',200304,2798,'Y',14,110,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:12','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:12','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','cf81eebc-7c81-4629-aa20-2cb38c631cf0','Y',110,4,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:12 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206869,'Process Number','Process Parameter',200304,3734,'Y',26,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:12','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:12','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','41c482cd-0f63-4004-817f-a8e08dd4207c','Y',120,1,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:12 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206870,'Process Number To','Process Parameter',200304,3735,'Y',26,130,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:12','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:12','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','d03a1a21-dee6-4169-baff-1ec2d246450c','Y',130,4,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:13 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206871,'AD_PInstance_Para_UU',200304,60453,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-02-07 11:01:13','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:01:13','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','948e05fe-7b4b-470b-9c04-98a70778747f','N',1,2,1,'N','N','N','N')
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206860
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206859
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206858
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206861
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206862
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206863
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206864
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206865
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206866
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206867
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206868
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206869
;

-- Feb 7, 2022, 11:01:57 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=206870
;

-- Feb 7, 2022, 11:02:17 AM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200199,'Saved Process Parameters','W',200121,0,0,'Y',TO_TIMESTAMP('2022-02-07 11:02:17','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-02-07 11:02:17','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','N','D','Y','a50fbdf0-f63a-4710-b533-045c6943a1a7')
;

-- Feb 7, 2022, 11:02:17 AM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 0, statement_timestamp(), 0,t.AD_Tree_ID, 200199, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200199)
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=1000000
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=1,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200199
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=2,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200002
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=3,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=147
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=4,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=150
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=5,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=53246
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=6,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=495
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=7,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200017
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=8,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=50007
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=9,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200012
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=10,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=362
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=11,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=366
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=12,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=483
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=13,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=368
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=14,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=508
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=15,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200001
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=16,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=53201
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=17,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=475
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=18,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200022
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=19,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=53348
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=20,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=21,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200147
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=22,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200148
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=23,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200170
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=24,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200165
;

-- Feb 7, 2022, 11:02:57 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=25,Updated=TO_TIMESTAMP('2022-02-07 11:02:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tree_ID=10 AND Node_ID=200171
;

SELECT register_migration_script('202202041600_IDEMPIERE-5181.sql') FROM dual
;
