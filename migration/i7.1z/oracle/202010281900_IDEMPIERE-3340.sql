SET SQLBLANKLINES ON
SET DEFINE OFF

-- 
-- Oct 27, 2020, 1:09:51 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214329,0,'Favourite','This record is a favourite',200221,'IsFavourite','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2020-10-27 13:09:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:09:50','YYYY-MM-DD HH24:MI:SS'),100,202958,'Y','N','D','N','N','N','Y','708ea949-31bc-4f53-8dba-12877cc92d14','Y',0,'N','N','N','N')
;

-- Oct 27, 2020, 1:09:53 PM IST
ALTER TABLE AD_Tree_Favorite_Node ADD IsFavourite VARCHAR2(1 CHAR) DEFAULT 'N' CHECK (IsFavourite IN ('Y','N')) NOT NULL
;

-- Oct 27, 2020, 1:10:41 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214330,0,'Login automatic open sequence','Determine the order items will be automatically opened when user logs in',200221,'LoginOpenSeqNo',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2020-10-27 13:10:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:10:40','YYYY-MM-DD HH24:MI:SS'),100,202959,'Y','N','D','N','N','N','Y','011087cb-d674-410d-80dc-aed66be6c9e7','Y',0,'N','N','N','N')
;

-- Oct 27, 2020, 1:10:42 PM IST
ALTER TABLE AD_Tree_Favorite_Node ADD LoginOpenSeqNo NUMBER(10) DEFAULT NULL 
;

-- Oct 27, 2020, 1:12:22 PM IST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200111,'Menu user favourites',0,0,'Y',TO_DATE('2020-10-27 13:12:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:12:21','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','349d39cf-af9c-4fbe-81d8-3b295dc9f27b')
;

-- Oct 27, 2020, 1:14:26 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200282,'Menu user tree entries','In this tab, you will be able to manage user and role wise favorite tree reference. ',200111,10,'N',200220,0,0,'Y',TO_DATE('2020-10-27 13:14:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:14:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','768d15d3-e60d-4074-ad47-8d632111ae4e','B','N','Y',0)
;

-- Oct 27, 2020, 1:14:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206522,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200282,213049,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:14:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:14:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','20f2b60f-ed58-49ed-9c8d-f256bb772e9a','N',2)
;

-- Oct 27, 2020, 1:14:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206523,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200282,213050,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:14:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:14:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a0bc8024-f2aa-47d2-ab16-e01d09d46639','Y','Y',10,4,2)
;

-- Oct 27, 2020, 1:14:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206524,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200282,213058,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:14:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:14:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','422b6a7d-fc62-437f-8be6-11e78eb1fb21','Y',20,2)
;

-- Oct 27, 2020, 1:14:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206525,'Favorite Tree',200282,213056,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:14:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:14:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','46f335ae-8aca-4167-b011-3f3f64ededc0','N',2)
;

-- Oct 27, 2020, 1:14:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206526,'Favorite Tree',200282,213057,'Y',36,40,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:14:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:14:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f65e13bc-742b-4e90-820b-c5c750dae66b','Y',30,2)
;

-- Oct 27, 2020, 1:14:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206527,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200282,213059,'Y',22,50,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:14:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:14:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ae35b9e6-0a27-4cdf-8c02-e91133ca7ce9','Y',40,2)
;

-- Oct 27, 2020, 1:15:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206528,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200282,213053,'Y',1,60,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:14:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:14:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','521637bc-19e5-4236-9093-d223f19d28a9','Y',50,2,2)
;

-- Oct 27, 2020, 1:15:37 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206527
;

-- Oct 27, 2020, 1:15:37 PM IST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206526
;

-- Oct 27, 2020, 1:15:37 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206528
;

-- Oct 27, 2020, 1:15:37 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206525
;

-- Oct 27, 2020, 1:18:35 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,Parent_Column_ID,AD_Tab_UU,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200283,'Menu user tree node',200111,20,'N',200221,0,0,'Y',TO_DATE('2020-10-27 13:18:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','N','N',1,'N','D','N','N',213056,'cbd7fc14-c206-4cb0-a827-168fb792f470','N','Y',0)
;

-- Oct 27, 2020, 1:18:47 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206529,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200283,213060,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f0b86ed8-7b7e-4278-8aa0-4f4bb16fc0fc','N',2)
;

-- Oct 27, 2020, 1:18:48 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206530,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200283,213061,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f12031fe-075c-4848-a880-d7a582857e54','Y','Y',10,4,2)
;

-- Oct 27, 2020, 1:18:48 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206531,'Favorite Tree',200283,213069,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','db41ef17-3eb3-43d2-a149-1bb61a810619','Y',20,2)
;

-- Oct 27, 2020, 1:18:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206532,'Menu','Identifies a Menu','The Menu identifies a unique Menu.  Menus are used to control the display of those screens a user has access to.',200283,213072,'Y',10,40,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c7ef010b-f045-4ee3-a2bc-4ec6bddd4d76','Y',30,2)
;

-- Oct 27, 2020, 1:18:51 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206533,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200283,213075,'Y',120,50,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','822ea6ba-2e63-4f41-a8ff-38dd61586e03','Y',40,5)
;

-- Oct 27, 2020, 1:18:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206534,'Favorite Node Tree',200283,213067,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7fc05af5-1916-4d07-a5ef-36e9494b2ca6','N',2)
;

-- Oct 27, 2020, 1:18:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206535,'Favorite Node Tree',200283,213068,'Y',36,60,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f2348f88-0c43-484f-8ab7-a4309b6d5b41','Y',50,2)
;

-- Oct 27, 2020, 1:18:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206536,'Parent','Parent of Entity','The Parent indicates the value used to represent the next level in a hierarchy or report to level for a record',200283,213070,'Y',10,70,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','38cbaac4-c899-43aa-bdc7-1b6a440f7cfb','Y',60,2)
;

-- Oct 27, 2020, 1:18:54 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206537,'Summary Level','This is a summary entity','A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.',200283,213071,'Y',1,80,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9f36b258-b1c9-4240-b2f8-43374a9bfdf7','Y',70,2,2)
;

-- Oct 27, 2020, 1:18:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206538,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200283,213073,'Y',22,90,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','69126a11-32e9-4c12-9333-de17e44a870e','Y',80,2)
;

-- Oct 27, 2020, 1:18:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206539,'Collapsible','Flag to indicate the state of the dashboard panel','Flag to indicate the state of the dashboard panel (i.e. collapsible or static)',200283,213074,'Y',1,100,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ebf3e753-4775-4f37-b3fb-7697c0463963','Y',90,2,2)
;

-- Oct 27, 2020, 1:18:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206540,'Favourite','This record is a favourite',200283,214329,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','25793ae9-b08a-44cf-b3f4-a00cd2fbf0b5','Y',100,2,2)
;

-- Oct 27, 2020, 1:18:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206541,'Login automatic open sequence','Determine the order items will be automatically opened when user logs in',200283,214330,'Y',10,120,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e655d21c-470e-4e25-9ea4-c87482922324','Y',110,2)
;

-- Oct 27, 2020, 1:18:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206542,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200283,213064,'Y',1,130,'N','N','N','N',0,0,'Y',TO_DATE('2020-10-27 13:18:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:18:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','05e112f8-121f-4364-9ec2-e43730bf8f13','Y',120,2,2)
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206542
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206532
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206536
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206533
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206535
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206539
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206538
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206540
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206537
;

-- Oct 27, 2020, 1:21:09 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-27 13:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206534
;

-- Oct 27, 2020, 1:22:27 PM IST
UPDATE AD_Tab SET IsReadOnly='Y', IsInsertRecord='N',Updated=TO_DATE('2020-10-27 13:22:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200282
;

-- Oct 27, 2020, 1:25:50 PM IST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200175,'Menu user favourites','User favourites menu','W',200111,0,0,'Y',TO_DATE('2020-10-27 13:25:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-10-27 13:25:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','9b0c1e47-4fae-4cbd-80d5-66119ca4ed94')
;

-- Oct 27, 2020, 1:25:50 PM IST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200175, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200175)
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=334
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=498
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=224
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=145
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=336
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=341
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=144
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=170
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=465
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200137
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200175
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=101
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=294
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=395
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=14, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=296
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=15, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=221
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=16, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=233
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=17, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=290
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=18, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=109
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=19, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200093
;

-- Oct 27, 2020, 1:26:37 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=20, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=50008
;



-- Oct 28, 2020, 5:08:25 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-28 17:08:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206525
;

-- Oct 28, 2020, 5:08:25 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-28 17:08:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206526
;

-- Oct 28, 2020, 5:09:44 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-28 17:09:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206534
;

-- Oct 28, 2020, 5:09:44 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-28 17:09:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206542
;

-- Oct 28, 2020, 5:09:44 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-10-28 17:09:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206535
;

-- Oct 28, 2020, 5:10:22 PM IST
UPDATE AD_Tab SET Name='Favorite tree node',Updated=TO_DATE('2020-10-28 17:10:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200283
;

-- Oct 28, 2020, 5:11:56 PM IST
UPDATE AD_Tab SET Name='User favourite tree', Description='In this tab, you can see to manage user and role wise favourite tree references',Updated=TO_DATE('2020-10-28 17:11:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200282
;

-- Oct 28, 2020, 5:20:17 PM IST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206526
;

-- Oct 28, 2020, 5:20:17 PM IST
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206522
;

-- Oct 28, 2020, 5:20:17 PM IST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206523
;

-- Oct 28, 2020, 5:20:17 PM IST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206525
;

-- Oct 28, 2020, 5:20:17 PM IST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206524
;

-- Oct 28, 2020, 5:20:17 PM IST
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206528
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206535
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206529
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206530
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206531
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206534
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206532
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206533
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206536
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206537
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206538
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206539
;
0
-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206540
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206541
;

-- Oct 28, 2020, 5:20:55 PM IST
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206542
;

-- IDEMPIERE-3340 InActive existing AD_TreeBar table
-- Oct 30, 2020, 11:37:24 AM IST
UPDATE AD_Table SET IsActive='N',Updated=TO_DATE('2020-10-30 11:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=456
;

-- Oct 30, 2020, 11:37:39 AM IST
UPDATE AD_Window SET IsActive='N',Updated=TO_DATE('2020-10-30 11:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200083
;

-- Oct 30, 2020, 11:37:39 AM IST
UPDATE AD_Menu SET Name='Menu favourites', Description=NULL, IsActive='N',Updated=TO_DATE('2020-10-30 11:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200137
;

SELECT register_migration_script('202010281900_IDEMPIERE-3340.sql') FROM dual
;
