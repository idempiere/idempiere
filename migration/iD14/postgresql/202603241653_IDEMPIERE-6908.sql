-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603241653_IDEMPIERE-6908.sql') FROM dual;

-- Mar 24, 2026, 4:53:11 PM GMT+08:00
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2026-03-24 16:53:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217451
;

-- Mar 24, 2026, 4:55:13 PM GMT+08:00
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2026-03-24 16:55:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217455
;

-- Mar 24, 2026, 4:56:39 PM GMT+08:00
INSERT INTO AD_Window (AD_Window_ID,Name,Description,Help,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200160,'Extension Registry','Manages the registry of bundled and external extensions','Maintains a record of all extensions installed in the system, whether bundled or external. It stores the JSON manifest , tracks the current deployment state (e.g., Installing, Installed, Disabled) , and helps validate dependencies before deployment.',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:56:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:56:38','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','N','N',0,0,'N','019d1f0f-7382-77de-a9f8-9147dc408ee0')
;

-- Mar 24, 2026, 4:58:51 PM GMT+08:00
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200416,'Extension Registry','Manages the registry of bundled and external extensions',200160,10,'Y',200438,0,0,'Y',TO_TIMESTAMP('2026-03-24 16:58:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:58:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','Name','N','N',0,'N','D','Y','N','019d1f11-75f4-7efd-b57d-659da8922937','B','N','Y',0)
;

-- Mar 24, 2026, 4:59:01 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209056,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200416,217443,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-9dc8-73a1-a588-7154957ed3e0','N',2)
;

-- Mar 24, 2026, 4:59:02 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (209057,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200416,217444,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-a094-7e3f-ac10-f60d6675c2ba','Y','N',4,2)
;

-- Mar 24, 2026, 4:59:02 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209058,'Extension','System Extension','Internal unique identifier for a System Extension record',200416,217450,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-a3c7-7c92-b452-36a659bf54f0','N',2)
;

-- Mar 24, 2026, 4:59:03 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209059,'Version','Version of an extension','Semantic version of an extension (recommended to follow the semantic version definition at https://semver.org/)',200416,217451,'Y',30,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-a6fc-7ed1-be79-858a0c2d7c85','Y',10,2)
;

-- Mar 24, 2026, 4:59:04 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209060,'Extension Symbolic Id','Unique symbolic id of an extension',200416,217453,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-a9c7-7a85-983d-e70c4de088c0','Y',20,5)
;

-- Mar 24, 2026, 4:59:05 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209061,'Is Bundled','Indicates if the extension is bundled with the core product','A flag indicating whether this extension is distributed as part of the base iDempiere installation or if it is an externally installed extension (e.g., via a .idext archive or a GitHub repository)',200416,217454,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-acfb-7699-a180-ca07cd4b29ad','Y',30,2,2)
;

-- Mar 24, 2026, 4:59:06 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (209062,'Extension Metadata','The JSON manifest containing extension details and dependencies','Stores the complete metadata.json payload associated with the extension. This includes the unique identifier, versioning, OSGi bundle references, and prerequisite dependencies required for installation.',200416,217455,'Y',0,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-b02f-71ac-a4ac-170f624c4a08','Y',40,2,5)
;

-- Mar 24, 2026, 4:59:06 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209063,'Extension State','Current installation and deployment state of the extension','Indicates the current lifecycle status of the extension within the system, such as Installed, Disabled, Error, or Uninstalled.',200416,217456,'Y',2,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-b362-7b13-a00d-be542c8637f5','Y',50,2)
;

-- Mar 24, 2026, 4:59:07 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209064,'Extension UUID','System Extension','Internal UUID for a System Extension record',200416,217457,'Y',36,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-b62f-7a79-b273-69c98c38ce77','Y',60,2)
;

-- Mar 24, 2026, 4:59:08 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209065,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200416,217449,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 16:59:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 16:59:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f11-b8fc-7e61-beba-b1fee2640e1b','Y',70,2,2)
;

-- Mar 24, 2026, 5:00:54 PM GMT+08:00
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=10, XPosition=1,Updated=TO_TIMESTAMP('2026-03-24 17:00:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209060
;

-- Mar 24, 2026, 5:00:54 PM GMT+08:00
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2026-03-24 17:00:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209059
;

-- Mar 24, 2026, 5:00:54 PM GMT+08:00
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2026-03-24 17:00:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209061
;

-- Mar 24, 2026, 5:00:54 PM GMT+08:00
UPDATE AD_Field SET SeqNo=40, ColumnSpan=5,Updated=TO_TIMESTAMP('2026-03-24 17:00:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209062
;

-- Mar 24, 2026, 5:00:54 PM GMT+08:00
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2026-03-24 17:00:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209063
;

-- Mar 24, 2026, 5:00:55 PM GMT+08:00
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2026-03-24 17:00:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209065
;

-- Mar 24, 2026, 5:00:55 PM GMT+08:00
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-03-24 17:00:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209058
;

-- Mar 24, 2026, 5:00:55 PM GMT+08:00
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2026-03-24 17:00:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209064
;

-- Mar 24, 2026, 5:00:55 PM GMT+08:00
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2026-03-24 17:00:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209057
;

-- Mar 24, 2026, 5:00:55 PM GMT+08:00
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2026-03-24 17:00:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209056
;

-- Mar 24, 2026, 5:02:07 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2026-03-24 17:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209064
;

-- Mar 24, 2026, 5:02:07 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2026-03-24 17:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209062
;

-- Mar 24, 2026, 5:02:07 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2026-03-24 17:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209060
;

-- Mar 24, 2026, 5:02:07 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2026-03-24 17:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209059
;

-- Mar 24, 2026, 5:02:07 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2026-03-24 17:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209063
;

-- Mar 24, 2026, 5:02:07 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2026-03-24 17:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209065
;

-- Mar 24, 2026, 5:03:37 PM GMT+08:00
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200417,'Extension Entities','The database dictionary objects belonging to an installed extension',200160,20,'N',200439,0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:36','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_Table_ID','N','N',1,'N','D','Y','N','019d1f15-d44d-7d76-8e89-a801e0c2436a','B','N','Y',0)
;

-- Mar 24, 2026, 5:03:46 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209066,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200417,217458,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f15-f835-7b4f-b00a-627e1fad5d5a','N',2)
;

-- Mar 24, 2026, 5:03:47 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (209067,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200417,217459,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f15-fb25-7e4e-93c0-26b8e12752dd','Y','N',4,2)
;

-- Mar 24, 2026, 5:03:48 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209068,'Extension Entity','System Extension Entity','Internal unique identifier for a System Extension Entity record',200417,217465,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f15-fe15-73eb-b9de-63985413a28e','N',2)
;

-- Mar 24, 2026, 5:03:48 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209069,'Extension','System Extension','Internal unique identifier for a System Extension record',200417,217466,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f16-00ff-7627-9ea0-d2eeb484e1f0','Y',10,2)
;

-- Mar 24, 2026, 5:03:49 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209070,'Extension Entity UUID','System Extension Entity UUID','Internal UUID for a System Extension Entity record',200417,217467,'Y',36,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f16-03cc-78f7-a4e1-fde8e66994c1','Y',20,2)
;

-- Mar 24, 2026, 5:03:50 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209071,'Table','Database Table information','The Database Table provides the information of the table definition',200417,217468,'Y',10,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f16-06ff-740d-a2e1-6e2eddf9f9a8','Y',30,2)
;

-- Mar 24, 2026, 5:03:51 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209072,'Record UUID',200417,217469,'Y',36,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f16-0a34-72f4-bf5e-0c30e15ee5e0','Y',40,2)
;

-- Mar 24, 2026, 5:03:52 PM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209073,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200417,217464,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:03:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:03:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d1f16-0d65-7e8b-be68-5c615e778f99','Y',50,2,2)
;

-- Mar 24, 2026, 5:04:17 PM GMT+08:00
UPDATE AD_Field SET SeqNo=10,Updated=TO_TIMESTAMP('2026-03-24 17:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209069
;

-- Mar 24, 2026, 5:04:17 PM GMT+08:00
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2026-03-24 17:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209071
;

-- Mar 24, 2026, 5:04:17 PM GMT+08:00
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2026-03-24 17:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209072
;

-- Mar 24, 2026, 5:04:17 PM GMT+08:00
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2026-03-24 17:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209073
;

-- Mar 24, 2026, 5:04:17 PM GMT+08:00
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-03-24 17:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209068
;

-- Mar 24, 2026, 5:04:17 PM GMT+08:00
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2026-03-24 17:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209070
;

-- Mar 24, 2026, 5:04:17 PM GMT+08:00
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2026-03-24 17:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209067
;

-- Mar 24, 2026, 5:04:17 PM GMT+08:00
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2026-03-24 17:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209066
;

-- Mar 24, 2026, 5:04:30 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2026-03-24 17:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209070
;

-- Mar 24, 2026, 5:04:30 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2026-03-24 17:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209071
;

-- Mar 24, 2026, 5:04:30 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2026-03-24 17:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209072
;

-- Mar 24, 2026, 5:04:30 PM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2026-03-24 17:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209073
;

-- Mar 24, 2026, 5:05:48 PM GMT+08:00
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217470,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200438,'Name',255,'N','N','Y','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-03-24 17:05:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:05:47','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','019d1f17-d3e3-735b-b3b7-94c1cb04e1c2','N',50,'N','N','N','N')
;

-- Mar 24, 2026, 5:06:00 PM GMT+08:00
INSERT INTO t_alter_column values('ad_extension','ExtensionVersion','VARCHAR(30)',null,null)
;

-- Mar 24, 2026, 5:06:00 PM GMT+08:00
INSERT INTO t_alter_column values('ad_extension','ExtensionMetadata','JSONB',null,null)
;

-- Mar 24, 2026, 5:06:00 PM GMT+08:00
ALTER TABLE AD_Extension ADD COLUMN Name VARCHAR(255) NOT NULL
;

-- Mar 24, 2026, 5:07:13 PM GMT+08:00
UPDATE AD_Column SET SeqNoSelection=50,Updated=TO_TIMESTAMP('2026-03-24 17:07:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217456
;

-- Mar 24, 2026, 5:07:18 PM GMT+08:00
UPDATE AD_Column SET IsMandatory='Y', SeqNoSelection=40,Updated=TO_TIMESTAMP('2026-03-24 17:07:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217454
;

-- Mar 24, 2026, 5:07:26 PM GMT+08:00
UPDATE AD_Column SET SeqNoSelection=30,Updated=TO_TIMESTAMP('2026-03-24 17:07:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217451
;

-- Mar 24, 2026, 5:07:32 PM GMT+08:00
UPDATE AD_Column SET SeqNoSelection=20,Updated=TO_TIMESTAMP('2026-03-24 17:07:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217453
;

-- Mar 24, 2026, 5:07:36 PM GMT+08:00
UPDATE AD_Column SET SeqNoSelection=10,Updated=TO_TIMESTAMP('2026-03-24 17:07:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217470
;

-- Mar 24, 2026, 5:08:46 PM GMT+08:00
UPDATE AD_Column SET SeqNo=30,Updated=TO_TIMESTAMP('2026-03-24 17:08:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217451
;

-- Mar 24, 2026, 5:08:51 PM GMT+08:00
UPDATE AD_Column SET SeqNo=20,Updated=TO_TIMESTAMP('2026-03-24 17:08:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217453
;

-- Mar 24, 2026, 5:08:55 PM GMT+08:00
UPDATE AD_Column SET SeqNo=10,Updated=TO_TIMESTAMP('2026-03-24 17:08:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217470
;

-- Mar 24, 2026, 5:13:14 PM GMT+08:00
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200249,'Extension Registry','Manages the registry of bundled and external extensions','W',200160,0,0,'Y',TO_TIMESTAMP('2026-03-24 17:13:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:13:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','Y','019d1f1e-a188-7c9b-909e-7804577f2889')
;

-- Mar 24, 2026, 5:13:14 PM GMT+08:00
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200249, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200249)
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=1000004
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200233
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200232
;

-- Mar 24, 2026, 5:14:11 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=6,Updated=TO_TIMESTAMP('2026-03-24 17:14:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200249
;

-- Mar 24, 2026, 5:16:57 PM GMT+08:00
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200021,0,0,'Y',TO_TIMESTAMP('2026-03-24 17:16:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:16:57','YYYY-MM-DD HH24:MI:SS'),100,'Extension Management','Interface to manage the installation and status of iDempiere extensions','Use this form to manage bundled and external extensions. You can install new extensions, update installed extensions and disable or uninstall extensions that are no longer required','org.idempiere.extension.manager.form.ExtensionBrowserFormController','4','D','N','019d1f22-0abb-7106-8ba6-d8df1fa4a709')
;

-- Mar 24, 2026, 5:17:34 PM GMT+08:00
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,AD_Form_ID,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200250,'Extension Management','Interface to manage the installation and status of iDempiere extensions','X',0,0,'Y',TO_TIMESTAMP('2026-03-24 17:17:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-24 17:17:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N',200021,'N','D','Y','019d1f22-9a5d-74b5-8f7a-a100a4e426d1')
;

-- Mar 24, 2026, 5:17:34 PM GMT+08:00
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200250, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200250)
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200250
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=1000004
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200233
;

-- Mar 24, 2026, 5:18:19 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=17,Updated=TO_TIMESTAMP('2026-03-24 17:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200232
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=1000004
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200233
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200232
;

-- Mar 24, 2026, 5:18:51 PM GMT+08:00
UPDATE AD_TreeNodeMM SET Parent_ID=218, SeqNo=7,Updated=TO_TIMESTAMP('2026-03-24 17:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200250
;

