-- IDEMPIERE-6697 Rename Master Role as Role Template and split to Role Template window
SELECT register_migration_script('202510141140_IDEMPIERE-6697.sql') FROM dual;

-- Oct 14, 2025, 11:40:42 AM MYT
UPDATE AD_Element SET Name='Role Template', Description='A role template cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', PrintName='Role Template',Updated=TO_TIMESTAMP('2025-10-14 11:40:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200117
;

-- Oct 14, 2025, 11:40:42 AM MYT
UPDATE AD_Column SET ColumnName='IsMasterRole', Name='Role Template', Description='A role template cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200117
;

-- Oct 14, 2025, 11:40:42 AM MYT
UPDATE AD_Process_Para SET ColumnName='IsMasterRole', Name='Role Template', Description='A role template cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL, AD_Element_ID=200117 WHERE UPPER(ColumnName)='ISMASTERROLE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 14, 2025, 11:40:42 AM MYT
UPDATE AD_Process_Para SET ColumnName='IsMasterRole', Name='Role Template', Description='A role template cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200117 AND IsCentrallyMaintained='Y'
;

-- Oct 14, 2025, 11:40:42 AM MYT
UPDATE AD_InfoColumn SET ColumnName='IsMasterRole', Name='Role Template', Description='A role template cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=200117 AND IsCentrallyMaintained='Y'
;

-- Oct 14, 2025, 11:40:42 AM MYT
UPDATE AD_Field SET Name='Role Template', Description='A role template cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200117) AND IsCentrallyMaintained='Y'
;

-- Oct 14, 2025, 11:40:42 AM MYT
UPDATE AD_PrintFormatItem SET PrintName='Role Template', Name='Role Template' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200117)
;

-- Oct 14, 2025, 11:41:34 AM MYT
UPDATE AD_Element SET Name='Included Role Template', PrintName='Included Role Template',Updated=TO_TIMESTAMP('2025-10-14 11:41:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53896
;

-- Oct 14, 2025, 11:41:34 AM MYT
UPDATE AD_Column SET ColumnName='Included_Role_ID', Name='Included Role Template', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53896
;

-- Oct 14, 2025, 11:41:34 AM MYT
UPDATE AD_Process_Para SET ColumnName='Included_Role_ID', Name='Included Role Template', Description=NULL, Help=NULL, AD_Element_ID=53896 WHERE UPPER(ColumnName)='INCLUDED_ROLE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 14, 2025, 11:41:34 AM MYT
UPDATE AD_Process_Para SET ColumnName='Included_Role_ID', Name='Included Role Template', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53896 AND IsCentrallyMaintained='Y'
;

-- Oct 14, 2025, 11:41:34 AM MYT
UPDATE AD_InfoColumn SET ColumnName='Included_Role_ID', Name='Included Role Template', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=53896 AND IsCentrallyMaintained='Y'
;

-- Oct 14, 2025, 11:41:34 AM MYT
UPDATE AD_Field SET Name='Included Role Template', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53896) AND IsCentrallyMaintained='Y'
;

-- Oct 14, 2025, 11:41:34 AM MYT
UPDATE AD_PrintFormatItem SET PrintName='Included Role Template', Name='Included Role Template' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53896)
;

-- Oct 14, 2025, 11:46:27 AM MYT
INSERT INTO AD_Window (AD_Window_ID,Name,Description,Help,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200158,'Role Template','Maintain role templates','The Role Template Window allows you to define role templates for inclusion by role.  
Note that access information is cached and requires re-login or reset of cache.',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:27','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','e7809ac0-6b8f-4620-86ca-fefb2acbe3d4')
;

-- Oct 14, 2025, 11:46:46 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200399,'Role','Define responsibility roles','Define the role and add the organizations the role has access to. You can give users access to this role and modify the access of this role to windows, forms, processes and reports as well as tasks. <br>
If the Role User Level is Manual, the assigned access rights are not automatically updated (e.g. if a role has a restricted number of Windows/Processes it can access). You need to add organizational access unless the role has access to all organizations. The SuperUser and the user creating a new role are assigned to the role automatically.  <br>
If you select an Organization Tree, the user has access to the leaves of  summary organizations.
Note: You cannot change the System Administrator role.',200158,10,'Y',156,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:45','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N',0,'N','D','Y','N','edfcf4b5-e27f-43a8-94e4-3bdfbbf3cbb3','B','N','Y',0)
;

-- Oct 14, 2025, 11:46:46 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208848,'AD_Role_UU',200399,60489,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0c8bb2f7-fef7-48d1-b1cc-23d22850d7b8','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:47 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208849,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200399,531,'N',14,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9c55279c-c007-455f-80ad-72af13bf7c32','N',0,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:47 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208850,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200399,537,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:47','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','2366e0ea-efdb-4be6-a62f-56b39bd8b6e1','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:48 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208851,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200399,538,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f42936bf-a7ba-44ee-b78d-aaac16f64bfc','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:49 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208852,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200399,532,'Y',60,30,1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bcd706af-f269-4b3e-afd3-c8dae066e000','Y',30,1,5,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:49 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208853,'Description','Optional short description of the record','A description is limited to 255 characters.',200399,533,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','66b7e705-8941-487e-8187-a55e17d81f61','Y',40,1,5,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:50 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208854,'User Level','System Tenant Organization','The User Level field determines if users of this Role will have access to System level data, Organization level data, Tenant level data or Tenant and Organization level data.',200399,534,'Y',14,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8a4d9f0a-f479-469e-9ac0-eb8ebd946fd9','Y',60,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:50 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208855,'Manual','This is a manual process','The Manual check box indicates if the process will done manually.',200399,9593,'Y',1,60,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','703dbd9d-c491-4eea-9218-e17f64b13d52','Y',70,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:51 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208856,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200399,716,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0f0adb4a-42b3-42ea-bad3-8c1f8a809345','Y',50,6,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:52 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208857,'Role Template','A role template cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',200399,200410,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2df8447b-e5e3-4b69-9a4a-21e913d3d864','Y',80,2,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:52 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208858,'Auto expand menu','If ticked, the menu is automatically expanded',200399,200112,'Y','@IsMasterRole@=N',0,90,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a342f820-c4d6-48f6-b93f-b5d229b504bf','Y',300,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:53 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208859,'Maintain Change Log','Maintain a log of changes','If selected, a log of all changes is maintained.',200399,13025,'Y','@IsMasterRole@=N',1,100,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8cd8889f-1cb3-4ea1-a165-b7eda49f9660','Y',180,6,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:53 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208860,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200399,2046,'Y','@IsMasterRole@=N',14,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',134,'D','da2989b0-0365-455b-b7e8-a233ff39e26d','Y',80,1,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:54 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208861,'Approval Amount','The approval amount limit for this role','The Approval Amount field indicates the amount limit this Role has for approval of documents.',200399,2047,'Y','@IsMasterRole@=N',26,120,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','255149fd-ef99-4d42-8f80-b24866e88063','Y',90,3,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:55 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208862,'Approval Amount Accumulated','The approval amount limit for this role accumulated on a period','The Approval Amount field indicates the amount limit this Role has for approval of documents within a period limit.',200399,59665,'Y','@IsMasterRole@=N',14,130,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',134,'D','ff374633-abb2-4218-9dcb-1b57b5e23d0f','Y',110,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:56 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208863,'User Discount',200399,52067,'Y','@IsMasterRole@=N',22,140,'N','N','N','N',0,0,'N',TO_TIMESTAMP('2025-10-14 11:46:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','250dc16e-ae49-4752-9eed-b2390377ee47','Y',130,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:56 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208864,'Days Approval Accumulated','The days approval indicates the days to take into account to verify the accumulated approval amount.','The Days Approval Accumulated field indicates the days to take into account to verify the accumulated approval amount.',200399,59666,'Y','@IsMasterRole@=N',10,140,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6fea25f8-68ba-44a1-a59a-7e0b1b8ab4ea','Y',100,1,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:57 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208865,'Supervisor','Supervisor for this user/organization - used for escalation and approval','The Supervisor indicates who will be used for forwarding and escalating issues for this user - or for approvals.',200399,10561,'Y','@IsMasterRole@=N',26,150,'Y','N','N','N',0,0,'N',TO_TIMESTAMP('2025-10-14 11:46:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5ae76e19-e622-43d3-8698-9f46cdfb2c7d','Y',140,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:57 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208866,'Approve own Documents','Users with this role can approve their own documents','If a user cannot approve their own documents (orders, etc.), it needs to be approved by someone else.',200399,11581,'Y','@IsMasterRole@=N',1,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3e04bb93-f761-4369-8220-8aa472de374f','Y',120,4,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:58 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208867,'Role Type',200399,213856,'Y','@IsMasterRole@=N',0,160,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',135,'D','160e0264-c8f7-4d34-adf0-3d2313cde737','Y',440,1,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:59 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208868,'Preference Level','Determines what preferences the user can set','Preferences allow you to define default values.  If set to None, you cannot set any preference nor value preference. Only if set to Tenant, you can see the Record Info Change Log.',200399,13026,'Y','@IsMasterRole@=N',14,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','479364e2-52fa-43c2-b888-b5337655e40a','Y',170,3,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:46:59 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208869,'Menu Tree','Tree of the menu','Menu access tree',200399,6575,'Y','@IsMasterRole@=N',14,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',135,'D','77799b2f-5550-4932-9ea8-9f9fd84c55e3','Y',150,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:00 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208870,'Access Advanced',200399,210680,'Y','@IsMasterRole@=N',1,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:46:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:46:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','15df6cf0-7039-4d8b-abd6-b3cfb3227ba0','Y',280,2,1,1,'N','N','Y','N')
;

-- Oct 14, 2025, 11:47:00 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208871,'Access all Orgs','Access all Organizations (no org access control) of the tenant','When selected, the role has access to all organizations of the tenant automatically. This also increases performance where you have many organizations.',200399,12800,'Y','@IsMasterRole@=N',1,200,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','75eb8f90-5441-4d8e-a80e-b8400a63e389','Y',200,3,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:01 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208872,'Use User Org Access','Use Org Access defined by user instead of Role Org Access','You can define the access to Organization either by Role or by User.  You would select this, if you have many organizations.',200399,13436,'Y','@IsAccessAllOrgs@=N & @IsMasterRole@=N',1,210,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a89fe86e-7b48-4694-84f5-7d0ac19f0e18','Y',220,4,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:02 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208873,'Personal Lock','Allow users with role to lock access to personal records','If enabled, the user with the role can prevent access of others to personal records.  If a record is locked, only the user or people who can read personal locked records can see the record.',200399,9888,'Y','@IsMasterRole@=N',1,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4b76b6b4-b8cf-4d0f-80a0-ad439a359eef','Y',250,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:02 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208874,'Personal Access','Allow access to all personal records','Users of this role have access to all records locked as personal.',200399,9886,'Y','@IsMasterRole@=N',1,230,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a89d7f61-7038-463c-b7ee-db6a57d6a932','Y',260,6,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:03 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208875,'Can Report','Users with this role can create reports','You can restrict the ability to report on data.',200399,9972,'Y','@IsMasterRole@=N',1,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ca20ed81-de3b-4cda-a030-2db8e6275410','Y',230,2,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:04 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208876,'Can Export','Users with this role can export data','You can restrict the ability to export data from iDempiere.',200399,9973,'Y','@IsMasterRole@=N',1,250,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9a9c650b-75b5-4bbb-9b9f-40dd3336ec27','Y',240,3,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:04 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208877,'Tenant Administrator','This role is a tenant administrator',200399,214711,'Y','@IsMasterRole@=N',1,260,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c41a2fdf-8f19-4bf9-8c5f-4859accc482f','Y',450,4,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:05 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208878,'Show Accounting','Users with this role can see accounting information','This allows to prevent access to any accounting information.',200399,9887,'Y','@IsMasterRole@=N',1,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1575955b-11d1-4673-8afd-a265be0dc9aa','Y',190,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:05 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208879,'Overwrite Price Limit','Overwrite Price Limit if the Price List  enforces the Price Limit','The Price List allows to enforce the Price Limit. If set, a user with this role can overwrite the price limit (i.e. enter any price).',200399,13027,'Y','@IsMasterRole@=N',1,280,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01682eec-0f39-4e4f-8161-55870100a231','Y',160,6,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:06 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208880,'Confirm Query Records','Require Confirmation if more records will be returned by the query (If not defined 500)','Enter the number of records the query will return without confirmation to avoid unnecessary system load.  If 0, the system default of 500 is used.',200399,14442,'Y','@IsMasterRole@=N',10,290,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c6fce28d-b58d-40e9-adf1-02f065391fe2','Y',270,1,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:07 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208881,'Connection Profile','How a Java Tenant connects to the server(s)','Depending on the connection profile, different protocols are used and tasks are performed on the server rather then the tenant. Usually the user can select different profiles, unless it is enforced by the User or Role definition. The User level profile overwrites the Role based profile.',200399,14618,'Y',1,300,'N','N','N','N',0,0,'N',TO_TIMESTAMP('2025-10-14 11:47:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c4dfeda8-8670-47de-9aac-d8d7f03e9493','Y',290,1,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:07 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208882,'Max Query Records','If defined, you cannot query more records as defined - the query criteria needs to be changed to query less records','Enter the number of records a user will be able to query to avoid unnecessary system load.  If 0, no restrictions are imposed.',200399,14443,'Y','@IsMasterRole@=N',10,300,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c3744cc6-ef9d-41db-a18a-25f34508907f','Y',280,3,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:08 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208883,'Organization Tree','Trees are used for (financial) reporting and security access (via role)','Trees are used for (finanial) reporting and security access (via role)',200399,13435,'Y','@IsAccessAllOrgs@=N & @IsMasterRole@=N',14,310,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19cb7b77-ff56-4fca-9ea9-5c328196e378','Y',210,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:08 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208884,'Allow Info Account',200399,50198,'Y','@IsMasterRole@=N',1,320,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','df5ca19b-ec74-4148-a55a-f03eb76715c2','Y',310,2,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:09 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208885,'Allow Info Schedule',200399,50208,'Y','@IsMasterRole@=N',1,330,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','649424fb-bf23-4863-a030-208a190bd5c9','Y',410,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:10 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208886,'Allow Info Product',200399,50206,'Y','@IsMasterRole@=N & @#UIClient@=''swing''',1,340,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','5aee9de4-0bf5-438e-ab0b-85e04c10ba95','Y',390,2,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:10 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208887,'Allow Info Cash Journal',200399,50201,'Y',1,350,'Y','N','N','N',0,0,'N',TO_TIMESTAMP('2025-10-14 11:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','6f717cd2-034d-415b-9a83-3bd662848132','Y',340,5,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:11 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208888,'Allow Info BPartner',200399,50200,'Y','@IsMasterRole@=N & @#UIClient@=''swing''',1,350,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','e1f585bb-7bac-4636-850a-fc57c99a44e7','Y',330,3,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:12 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208889,'Allow Info Order',200399,50204,'Y','@IsMasterRole@=N & @#UIClient@=''swing''',1,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','79218dc5-0685-4bdc-86be-b905ca7493fc','Y',370,4,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:12 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208890,'Allow Info Invoice',200399,50203,'Y','@IsMasterRole@=N & @#UIClient@=''swing''',1,370,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','c25ca63d-1032-46ad-bb09-958a7e9f5a26','Y',360,5,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:13 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208891,'Allow Shipment Info',200399,50202,'Y','@IsMasterRole@=N & @#UIClient@=''swing''',1,380,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','838b2d29-6dff-4a6a-a2b4-607596d4f891','Y',350,6,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:13 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208892,'Allow Info Payment',200399,50205,'Y','@IsMasterRole@=N & @#UIClient@=''swing''',1,390,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','0f23fde1-32b2-4777-96c2-19adb88e1783','Y',380,2,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:14 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208893,'Allow Info Asset',200399,50199,'Y','@IsMasterRole@=N & @#UIClient@=''swing''',1,400,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','166ab044-5d04-442b-8698-0fed45f3c15f','Y',320,3,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:15 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208894,'Allow Info Resource',200399,50207,'Y','@IsMasterRole@=N & @#UIClient@=''swing''',1,410,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',50000,'D','b2b9fb73-d87c-4b5f-b55b-1c4ae038224c','Y',400,4,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:15 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208895,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',200399,215806,'Y',4000,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200015,'D','940d4544-dfc5-48a2-9b02-f5c01fadb5d2','Y',460,1,5,5,'N','N','Y','N')
;

-- Oct 14, 2025, 11:47:16 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208896,'Allow Info CRP',200399,55333,'Y',1,430,'Y','N','N','N',0,0,'N',TO_TIMESTAMP('2025-10-14 11:47:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','026b4d2a-b357-476e-b6b2-f7f23cce686f','Y',420,5,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:17 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208897,'Allow Info MRP',200399,55332,'Y',1,440,'N','N','N','N',0,0,'N',TO_TIMESTAMP('2025-10-14 11:47:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3c8f9d72-8bd8-489d-91b9-29775ef43913','Y',430,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:17 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,TabLevel,IsSortTab,EntityType,DisplayLogic,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200400,'Org Access','Maintain Role Org Access','Add the tenant and organizations the user has access to. Entries here are ignored, if User Org Access is selected or the role has access to all roles.<br>
Note that access information is cached and requires re-login or reset of cache.',200158,20,'Y',422,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',5507,'N',1,'N','D','@IsMasterRole@=N','Y','N','9e9b039a-515a-48ef-bc00-a5a7e7ed0d8b','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:18 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208898,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200400,5509,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:17','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','572bd08d-88f8-4cb3-96ae-d6f187fa2b31','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:19 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208899,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200400,5508,'Y',14,20,1,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','904b6008-0201-4486-b205-8a315f0e4537','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:19 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208900,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200400,5507,'Y',14,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:19','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','be8f94ad-af2a-49c2-b553-5c7a2694c6be','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:20 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208901,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200400,5510,'Y',1,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','61a5656d-7984-4ea7-819c-bf21bf3b3f2f','Y',40,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:20 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208902,'Read Only','Field is read only','The Read Only indicates that this field may only be Read.  It may not be updated.',200400,13437,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2cbff21b-be2e-455a-b0d2-a4b6ef1ce0e5','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:21 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208903,'AD_Role_OrgAccess_UU',200400,60491,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','888411dd-be3e-43bd-8681-8c21930a6655','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:22 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,TabLevel,IsSortTab,EntityType,DisplayLogic,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200401,'User Assignment','Users with this Role','The User Assignment Tab displays Users who have been defined for this Role.',200158,30,'Y',157,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',542,'N',1,'N','D','@IsMasterRole@=N','Y','N','05e81a74-f4eb-445f-8614-9e02d2ddfc9a','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:22 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208904,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200401,972,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','94a12425-c41a-4dd2-b56f-d9eefd0ad08c','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:23 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208905,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200401,973,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9b955723-26f8-4cbd-b91d-bbd7328f0251','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:24 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208906,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200401,542,'Y',26,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:23','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','bb0b98b4-e9f8-4cd7-b9a4-4bc1e164c0b0','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:24 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208907,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200401,971,'Y',26,40,1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2180171c-8a14-4e5e-80e6-ed0b7e1ab22d','Y',40,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:25 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208908,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200401,721,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','950be7ee-c3bf-4fad-8e71-742c0eacd343','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:26 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208909,'AD_User_Roles_UU',200401,60536,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b6a130b6-8a76-422b-aeb5-76d00c0103e8','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:26 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200402,'Window Access','Window Access','The Window Access Tab defines the Windows and type of access that this Role is granted.',200158,40,'Y',201,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',4637,'N',1,'N','D','Y','N','a9ad8260-5064-489c-8c26-f149f7a3a4f9','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:27 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208910,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200402,1331,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:26','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','419b802d-e200-4a5f-8e8b-e808a01b0709','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:28 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208911,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200402,1332,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7eb6c3e8-02a0-4068-a6a2-924de58700be','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:28 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208912,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200402,4637,'Y',14,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:28','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','54ed1cca-68c0-4e45-b491-024e25cdb624','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:29 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208913,'Window','Data entry or display window','The Window field identifies a unique Window in the system.',200402,1330,'Y',14,40,1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','db05135d-fd8b-49fd-82ff-3bff9a8b4572','Y',40,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:30 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208914,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200402,1333,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f5442606-5159-44e6-a149-b506ad920edf','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:30 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208915,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200402,1338,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','72eece14-408f-4385-918c-b0f0d2660e73','Y',60,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:31 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208916,'AD_Window_Access_UU',200402,60552,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','73d82418-ca1e-469d-9b68-71d910ff39ff','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:32 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200403,'Process Access','Process Access','The Process Access Tab defines the Processes and type of access that this Role is granted.',200158,50,'Y',197,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',4634,'N',1,'N','D','Y','N','cf38ef41-0aaa-411a-b146-8605d4a0663a','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:32 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208917,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200403,1288,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:32','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','9527198a-8cb3-401c-9fbe-f642a22ce207','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:33 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208918,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200403,1289,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','17f8e1f9-3da3-4bb3-9976-34e143dc494b','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:34 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208919,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200403,4634,'Y',14,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:33','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','e1d00886-e8d3-4f58-86bb-2edd0b8ff442','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:34 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208920,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200403,4633,'Y',14,40,1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fe6473d0-c0ed-4ec7-976e-b241825a2220','Y',40,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:35 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208921,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200403,1290,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','26287e07-d32b-4a6e-8ee1-0b20131b7dcd','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:36 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208922,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200403,2009,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0d966ef3-7dc4-4617-a03e-2a3b90ac7ef2','Y',60,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:36 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208923,'AD_Process_Access_UU',200403,60469,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7145ac07-cc2b-40b3-8fc9-108af6fb90f1','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:37 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200404,'Form Access','Form Access','The Form Access Tab defines the Forms and type of access that this Role is granted.',200158,60,'Y',378,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:36','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',4624,'N',1,'N','D','Y','N','39e5855b-d995-44f1-afe7-a4922c46596d','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:37 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208924,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200404,4625,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:37','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','9297b61a-8e5d-469c-a8b2-634c3ffd2430','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:38 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208925,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200404,4626,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f67332f3-d65d-4974-86b4-2a237aff9aa6','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:39 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208926,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200404,4624,'Y',14,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:38','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','6ed814aa-2599-48fe-8b75-fd979b4e981c','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:39 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208927,'Special Form','Special Form','The Special Form field identifies a unique Special Form in the system.',200404,4623,'Y',14,40,1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','90db55cf-b3a2-4055-9191-5f3a0f87fcc7','Y',40,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:40 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208928,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200404,4627,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d98ebc12-9fe2-4922-ad8d-35a9bb3de29d','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:41 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208929,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200404,4632,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','07d98a65-5229-49b6-935b-bc505f8466d6','Y',60,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:41 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208930,'AD_Form_Access_UU',200404,60415,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','133a328a-d90d-45a2-9a30-cd694c631f44','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:42 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200405,'Info Access',200158,65,'Y',200054,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',208376,'N','N',1,'N','D','Y','N','3a7fdb3b-cce9-43c5-8f5f-5a32120857ae','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:43 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208931,'AD_InfoWindow_Access_UU',200405,208373,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','258f0aad-f533-4327-9bec-fab56b64a7d5','N',0,1,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:43 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208932,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200405,208367,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:43','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','52f5f063-abd2-43fa-88df-ff05275123c9','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:44 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208933,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200405,208368,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:43','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','462670e8-fe18-44cd-918a-b894d8a05920','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:44 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208934,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200405,208376,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','847c5194-f91b-470f-ba68-fbd26d1fd7c4','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:45 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208935,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200405,208377,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e0dfa7ff-6c40-4bdf-a606-f8ece9d4cbe1','Y',40,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:46 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208936,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200405,208371,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ac7dc7ec-a662-4028-b021-ebe317369283','Y',50,2,1,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:46 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200406,'Workflow Access','Workflow Access','The Workflow Access Tab defines the Workflows and type of access that this Role is granted.',200158,70,'Y',202,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',4638,'N',1,'N','D','Y','N','4c602d06-756a-42c1-b340-06a17992134e','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:47 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208937,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200406,1341,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:46','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','fc2efde4-2983-4cb2-afd0-22caff44bf19','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:47 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208938,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200406,1342,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ae841c13-2282-40b8-b280-da5aef73c256','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:49 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208939,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200406,4638,'Y',14,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:47','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','c677a5a4-4850-45bb-83c6-ee0760b319cc','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:50 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208940,'Workflow','Workflow or combination of tasks','The Workflow field identifies a unique Workflow in the system.',200406,1339,'Y',14,40,1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19ddf967-e183-4417-b05c-db1aa873935c','Y',40,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:50 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208941,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200406,1343,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bae3d562-dbc1-4193-960f-198d15e80f89','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:51 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208942,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200406,1348,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','55534569-0bd4-413c-8847-3fa1008395ba','Y',60,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:51 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208943,'AD_Workflow_Access_UU',200406,60558,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','620c7360-3278-4bc9-a41b-8cfe5ca797df','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:52 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200407,'Task Access','Task Access','The Task Access Tab defines the Task and type of access that this Role is granted.',200158,80,'Y',199,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',4638,'N',1,'N','D','Y','N','431f15e2-ecc3-4e60-b8b4-243468b3c478','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:53 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208944,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200407,1308,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:52','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','e4b16d8c-9dc4-48b5-8a31-3bb309890ea8','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:53 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208945,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200407,1309,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','43f4f1bd-8742-4171-8a3c-79d0aeefcadc','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:54 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208946,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200407,4636,'Y',14,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8e354baf-d4e8-4ece-bd28-65bcea95985d','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:54 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208947,'OS Task','Operation System Task','The Task field identifies a Operation System Task in the system.',200407,1306,'Y',14,40,1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','65936a2e-3bc4-4012-af36-f7c2c4a0ad34','Y',40,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:55 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208948,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200407,1310,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5d7dd895-7282-4151-84b4-7b0acaa5a8a5','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:56 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208949,'Read Write','Field is read / write','The Read Write indicates that this field may be read and updated.',200407,1315,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f969f176-e711-4301-8e56-a940a15027d8','Y',60,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:56 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208950,'AD_Task_Access_UU',200407,60511,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cd4f426b-c314-4665-b783-9be787070097','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:57 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200408,'Document Action Access','Define access to document type / document action / role combinations.','Define access to document type / document action / role combinations.',200158,90,'Y',53012,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:56','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',53230,'N','N',1,'N','D','Y','N','a89384c8-cd94-43ca-9d0b-cd62a4bc727d','B','N','Y',0)
;

-- Oct 14, 2025, 11:47:57 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208951,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200408,53222,'Y',20,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:57','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','33f9b1d7-ef51-434e-8f37-ef5fd22bc27e','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:58 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208952,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200408,53223,'Y',20,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2d16a2e9-632e-46bb-8ba7-c166b46814c4','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:59 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208953,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200408,53230,'Y',20,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','40f3e3c0-ae0f-45da-96e4-670b4bd0de91','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:47:59 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208954,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200408,53229,'Y',20,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','00724fb8-100b-4ff0-92d5-ebe2fd88fd72','Y',40,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:00 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208955,'Reference List','Reference List based on Table','The Reference List field indicates a list of reference values from a database tables.  Reference lists populate drop down list boxes in data entry screens',200408,53231,'Y',20,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:47:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:47:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','22463bc3-8756-4e57-8ab1-febf8c390bc5','Y',50,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:01 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208956,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200408,53224,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f7d66d47-bddc-421e-b3fe-c65f9942267e','Y',60,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:01 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208957,'AD_Document_Action_Access_UU',200408,60394,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e58f21ea-e108-4342-b2ac-c9cea0eea230','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:02 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,DisplayLogic,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200409,'Included roles',200158,100,'Y',53222,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',57942,'N','N',1,'N','D','@IsMasterRole@=N','Y','N','21d65bf8-dae0-489d-826f-1440ca93ed26','B','N','Y',0)
;

-- Oct 14, 2025, 11:48:02 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208958,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200409,57940,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:02','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','ba8bd5b0-c2aa-47d9-8c6d-f6629fd0bbc4','Y',0,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:03 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208959,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200409,57941,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','da3ee9d1-6777-4325-b853-1bdb95e3a445','Y','N',0,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:04 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208960,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200409,57950,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','646fac45-caeb-46da-9a3f-906c4977a396','N','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:04 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208961,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200409,57945,'Y',1,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c4fd5231-ff94-4360-ab68-2024eb966458','Y',20,5,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:05 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208962,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200409,57942,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ed88de38-a7e1-42c5-ac1b-459a82e951c9','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:06 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208963,'Included Role Template',200409,57949,'Y',10,40,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ebbb0c06-65bc-4eee-a542-cb4c8a9eb9fd','Y',40,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:06 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208964,'AD_Role_Included_UU',200409,60490,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9e86b1d2-19d7-4a3f-9900-9c6151f46ac7','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:07 AM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200410,'Document Status Access',200158,130,'Y',200278,0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',214530,'N','N',1,'N','D','Y','N','732ab5d0-b675-49a9-8dfd-8ab1fb1f0c5e','B','N','Y',0)
;

-- Oct 14, 2025, 11:48:08 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208965,'PA_DocumentStatusAccess_UU',200410,214529,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','21ad226a-0aa4-477b-9407-26a49d7cb737','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:08 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208966,'Document Status Access',200410,214521,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','da3fe2f8-215a-4fe6-9122-0b9003461448','N',1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:09 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208967,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200410,214522,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4e73f8b1-03b0-42d1-8f9a-9d4f371f08fe','Y',10,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:09 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208968,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200410,214523,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e823f8fb-57de-476f-92ed-4159e2f04cd5','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:10 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208969,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200410,214530,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ecd2d3e8-34ef-45ae-bdde-47038ef43752','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:11 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208970,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200410,214531,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c4977a4a-70b4-4ecc-bfa7-9a5e8548aa08','Y',40,4,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:11 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208971,'Document Status',200410,214532,'Y',10,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1422d873-7259-40c3-b667-750ff4f6f6b7','Y',50,1,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:48:12 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208972,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200410,214526,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 11:48:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 11:48:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb825486-9058-49b0-9df8-3655c661bea4','Y',60,2,2,1,'N','N','N','N')
;

-- Oct 14, 2025, 11:50:47 AM MYT
DELETE FROM AD_Tab WHERE AD_Tab_UU='9e9b039a-515a-48ef-bc00-a5a7e7ed0d8b'
;

-- Oct 14, 2025, 11:50:55 AM MYT
DELETE FROM AD_Tab WHERE AD_Tab_UU='05e81a74-f4eb-445f-8614-9e02d2ddfc9a'
;

-- Oct 14, 2025, 11:51:33 AM MYT
DELETE FROM AD_Tab WHERE AD_Tab_UU='21d65bf8-dae0-489d-826f-1440ca93ed26'
;

-- Oct 14, 2025, 11:52:35 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='a342f820-c4d6-48f6-b93f-b5d229b504bf'
;

-- Oct 14, 2025, 11:52:44 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='8cd8889f-1cb3-4ea1-a165-b7eda49f9660'
;

-- Oct 14, 2025, 11:52:54 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='da2989b0-0365-455b-b7e8-a233ff39e26d'
;

-- Oct 14, 2025, 11:52:59 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='255149fd-ef99-4d42-8f80-b24866e88063'
;

-- Oct 14, 2025, 11:53:07 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='ff374633-abb2-4218-9dcb-1b57b5e23d0f'
;

-- Oct 14, 2025, 11:53:15 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='6fea25f8-68ba-44a1-a59a-7e0b1b8ab4ea'
;

-- Oct 14, 2025, 11:53:20 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='3e04bb93-f761-4369-8220-8aa472de374f'
;

-- Oct 14, 2025, 11:53:25 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='160e0264-c8f7-4d34-adf0-3d2313cde737'
;

-- Oct 14, 2025, 11:53:33 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='479364e2-52fa-43c2-b888-b5337655e40a'
;

-- Oct 14, 2025, 11:53:40 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='77799b2f-5550-4932-9ea8-9f9fd84c55e3'
;

-- Oct 14, 2025, 11:53:45 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='15df6cf0-7039-4d8b-abd6-b3cfb3227ba0'
;

-- Oct 14, 2025, 11:53:51 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='75eb8f90-5441-4d8e-a80e-b8400a63e389'
;

-- Oct 14, 2025, 11:54:00 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='a89fe86e-7b48-4694-84f5-7d0ac19f0e18'
;

-- Oct 14, 2025, 11:54:06 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='4b76b6b4-b8cf-4d0f-80a0-ad439a359eef'
;

-- Oct 14, 2025, 11:54:15 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='a89d7f61-7038-463c-b7ee-db6a57d6a932'
;

-- Oct 14, 2025, 11:54:32 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='ca20ed81-de3b-4cda-a030-2db8e6275410'
;

-- Oct 14, 2025, 11:54:39 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='9a9c650b-75b5-4bbb-9b9f-40dd3336ec27'
;

-- Oct 14, 2025, 11:54:46 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='c41a2fdf-8f19-4bf9-8c5f-4859accc482f'
;

-- Oct 14, 2025, 11:55:05 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='1575955b-11d1-4673-8afd-a265be0dc9aa'
;

-- Oct 14, 2025, 11:55:10 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='01682eec-0f39-4e4f-8161-55870100a231'
;

-- Oct 14, 2025, 11:55:26 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='c6fce28d-b58d-40e9-adf1-02f065391fe2'
;

-- Oct 14, 2025, 11:56:00 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='c3744cc6-ef9d-41db-a18a-25f34508907f'
;

-- Oct 14, 2025, 11:56:54 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='19cb7b77-ff56-4fca-9ea9-5c328196e378'
;

-- Oct 14, 2025, 11:57:03 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='df5ca19b-ec74-4148-a55a-f03eb76715c2'
;

-- Oct 14, 2025, 11:57:33 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='649424fb-bf23-4863-a030-208a190bd5c9'
;

-- Oct 14, 2025, 11:57:39 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='5aee9de4-0bf5-438e-ab0b-85e04c10ba95'
;

-- Oct 14, 2025, 11:58:17 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='e1f585bb-7bac-4636-850a-fc57c99a44e7'
;

-- Oct 14, 2025, 11:58:22 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='79218dc5-0685-4bdc-86be-b905ca7493fc'
;

-- Oct 14, 2025, 11:58:32 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='c25ca63d-1032-46ad-bb09-958a7e9f5a26'
;

-- Oct 14, 2025, 11:59:04 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='838b2d29-6dff-4a6a-a2b4-607596d4f891'
;

-- Oct 14, 2025, 11:59:09 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='0f23fde1-32b2-4777-96c2-19adb88e1783'
;

-- Oct 14, 2025, 11:59:15 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='166ab044-5d04-442b-8698-0fed45f3c15f'
;

-- Oct 14, 2025, 11:59:21 AM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='b2b9fb73-d87c-4b5f-b55b-1c4ae038224c'
;

-- Oct 14, 2025, 12:01:30 PM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='250dc16e-ae49-4752-9eed-b2390377ee47'
;

-- Oct 14, 2025, 12:01:36 PM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='5ae76e19-e622-43d3-8698-9f46cdfb2c7d'
;

-- Oct 14, 2025, 12:04:16 PM MYT
UPDATE AD_Tab SET WhereClause='AD_Role.IsMasterRole=''Y''',Updated=TO_TIMESTAMP('2025-10-14 12:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200399
;

-- Oct 14, 2025, 12:05:54 PM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='c4dfeda8-8670-47de-9aac-d8d7f03e9493'
;

-- Oct 14, 2025, 12:05:59 PM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='6f717cd2-034d-415b-9a83-3bd662848132'
;

-- Oct 14, 2025, 12:06:03 PM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='026b4d2a-b357-476e-b6b2-f7f23cce686f'
;

-- Oct 14, 2025, 12:06:08 PM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='3c8f9d72-8bd8-489d-91b9-29775ef43913'
;

-- Oct 14, 2025, 12:08:32 PM MYT
UPDATE AD_Field SET IsDisplayed='N', DefaultValue='''Y''',Updated=TO_TIMESTAMP('2025-10-14 12:08:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208857
;

-- Oct 14, 2025, 12:08:39 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='N',Updated=TO_TIMESTAMP('2025-10-14 12:08:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208857
;

