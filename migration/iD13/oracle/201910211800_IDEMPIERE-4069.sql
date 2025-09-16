SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4069 In Report source, adding support for User1 and User2 and Adding Report Source under Report column too

SELECT register_migration_script('201910211800_IDEMPIERE-4069.sql') FROM dual
;


-- 'Cross Tab' Type Report and 'Combination' extended to use UserList1 and UserList2
-- Oct 21, 2019 12:34:44 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214095,0,'User Element List 1','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.',450,'User1_ID',22,'N','N','N','N','N',0,'N',18,134,0,0,'Y',TO_DATE('2019-10-21 12:34:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:34:43','YYYY-MM-DD HH24:MI:SS'),100,613,'Y','N','D','N','N','N','Y','8372271f-4c4a-48d1-b0e5-da4c3a97da64','Y',0,'N','N','N')
;

-- Oct 21, 2019 12:34:47 PM IST
UPDATE AD_Column SET FKConstraintName='User1_PAReportSource', FKConstraintType='N',Updated=TO_DATE('2019-10-21 12:34:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214095
;

-- Oct 21, 2019 12:34:47 PM IST
ALTER TABLE PA_ReportSource ADD User1_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2019 12:34:47 PM IST
ALTER TABLE PA_ReportSource ADD CONSTRAINT User1_PAReportSource FOREIGN KEY (User1_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2019 12:35:03 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214096,0,'User Element List 2','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.',450,'User2_ID',22,'N','N','N','N','N',0,'N',18,137,0,0,'Y',TO_DATE('2019-10-21 12:35:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:35:03','YYYY-MM-DD HH24:MI:SS'),100,614,'Y','N','D','N','N','N','Y','aba09438-471b-4b31-9e43-485217418066','Y',0,'N','N','N')
;

-- Oct 21, 2019 12:35:06 PM IST
UPDATE AD_Column SET FKConstraintName='User2_PAReportSource', FKConstraintType='N',Updated=TO_DATE('2019-10-21 12:35:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214096
;

-- Oct 21, 2019 12:35:06 PM IST
ALTER TABLE PA_ReportSource ADD User2_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2019 12:35:06 PM IST
ALTER TABLE PA_ReportSource ADD CONSTRAINT User2_PAReportSource FOREIGN KEY (User2_ID) REFERENCES c_elementvalue(c_elementvalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2019 12:36:43 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203375,0,0,'Y',TO_DATE('2019-10-21 12:36:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:36:43','YYYY-MM-DD HH24:MI:SS'),100,'IsIncludeNullsUserList1','Include Nulls in User List 1','Include nulls in the selection of the User List 1','Include Nulls in User List 1','D','68ddbeb8-d5e8-40f0-a5fa-52293d6e138c')
;

-- Oct 21, 2019 12:37:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214097,0,'Include Nulls in User List 1','Include nulls in the selection of the User List 1',450,'IsIncludeNullsUserList1','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2019-10-21 12:37:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:37:15','YYYY-MM-DD HH24:MI:SS'),100,203375,'Y','N','D','N','N','N','Y','5ca5895c-5451-4514-9d87-76f080b98d88','Y',0,'N','N')
;

-- Oct 21, 2019 12:37:26 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203376,0,0,'Y',TO_DATE('2019-10-21 12:37:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:37:25','YYYY-MM-DD HH24:MI:SS'),100,'IsIncludeNullsUserList2','Include Nulls in User List 2','Include nulls in the selection of the User List 2','Include Nulls in User List 2','D','9d28b5e1-b19c-4e32-8ee2-3edc2c9c4c7b')
;

-- Oct 21, 2019 12:37:55 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (214098,0,'Include Nulls in User List 2','Include nulls in the selection of the User List 2',450,'IsIncludeNullsUserList2','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2019-10-21 12:37:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:37:54','YYYY-MM-DD HH24:MI:SS'),100,203376,'Y','N','D','N','N','N','Y','7e1799bd-001c-4c7a-aacb-d410a50846e4','Y',0,'N','N','N')
;

-- Oct 21, 2019 12:54:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206248,'User Element List 1','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.',377,214095,'Y','@ElementType@=CO',0,310,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 12:53:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:53:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bb579cdf-2a1a-4b18-bd72-cdeb28989bda','Y',310,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 12:54:17 PM IST
UPDATE AD_Field SET Name='User List 1', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 12:54:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206248
;

-- Oct 21, 2019 12:55:03 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206249,'Include Nulls in User List 1','Include nulls in the selection of the User List 1',377,214097,'Y','@ElementType@=CO',0,320,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 12:55:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:55:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','809b27ce-b047-4bef-a0f2-061b7af2f7c3','Y',320,4,2,1,'N','N','N','N')
;

-- Oct 21, 2019 12:55:34 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206250,'User Element List 2','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.',377,214096,'Y','@ElementType@=CO',0,330,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 12:55:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:55:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5eff8173-8c8f-4413-8090-213b8b6ff4e9','Y',330,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 12:56:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206251,'Include Nulls in User List 2','Include nulls in the selection of the User List 2',377,214098,'Y','@ElementType@=CO',0,340,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 12:56:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:56:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e778946b-fb28-45b0-83e6-fbf693ea6bbd','Y',340,1,1,1,'N','N','N','N')
;

-- Oct 21, 2019 12:57:52 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200274,'Report Source',217,30,'Y',450,0,0,'Y',TO_DATE('2019-10-21 12:57:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:57:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',2,'N','D','Y','N','a346d74b-dd39-433e-a8aa-cd6985019718','B')
;

-- Oct 21, 2019 12:59:24 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214099,0,'Report Column','Column in Report',450,'PA_ReportColumn_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2019-10-21 12:59:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 12:59:23','YYYY-MM-DD HH24:MI:SS'),100,1601,'Y','N','D','N','N','N','Y','2f6d32ed-98c6-4353-a1a3-fae02e0f1620','Y',0,'N','N')
;

-- Oct 21, 2019 1:00:13 PM IST
UPDATE AD_Tab SET AD_Column_ID=214099, Parent_Column_ID=5999,Updated=TO_DATE('2019-10-21 13:00:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200274
;

-- Oct 21, 2019 1:00:38 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206252,'Report Source','Restriction of what will be shown in Report Line',200274,6095,'N',14,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a74c9e76-3ee6-4f8a-a742-efd13eda14d0','N',0,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:39 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206253,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200274,6096,'Y',14,10,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:38','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','36951e62-de77-4183-83b8-71ce5931f7ec','N',10,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:40 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206254,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200274,6077,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','af532b9e-ffbd-4aac-8e9c-491d4eabcbe3','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:40 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206255,'Report Line',200274,6084,'Y',14,30,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:40','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','d747a199-9c19-4330-b099-f3c0698f5528','Y',30,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:41 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206256,'Description','Optional short description of the record','A description is limited to 255 characters.',200274,6083,'Y','@LineType@=S',60,40,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a34e2037-d07c-4dc1-954e-2cda92f01c69','Y',40,1,5,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206257,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200274,6078,'Y','@LineType@=S',1,50,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ef19ceaf-d958-4f8b-a04d-1b71f4253f52','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206258,'Type','Element Type (account or user defined)','The Element Type indicates if this element is the Account element or is a User Defined element.  ',200274,6085,'Y','@LineType@=S',14,60,1,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f2d2c532-0371-42b7-a317-8ef6925b34e9','Y',60,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:43 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206259,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department.',200274,6086,'Y','@ElementType@=OO | @ElementType@=OT | @ElementType@=CO',14,70,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7d7feb3f-83f7-4bc6-893f-6e9874897caa','Y',70,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:43 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206260,'Include Nulls in Org','Include nulls in the selection of the organization',200274,56155,'Y','@ElementType@=CO',1,80,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3205c276-575e-4cae-9080-7a0b61b96d65','Y',80,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:44 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206261,'Trx Organization','Performing or initiating organization','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.',200274,56536,'Y','@ElementType@=OO | @ElementType@=OT | @ElementType@=CO',22,90,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8d57ae7c-53d5-4c37-b5f2-92795b70bbfb','Y',90,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:45 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206262,'Include Nulls in Org Trx','Include nulls in the selection of the organization transaction',200274,56535,'Y','@ElementType@=CO',1,100,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','769270bf-32a6-4d7a-810b-582bc5510ed7','Y',100,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:45 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206263,'Account Element','Account Element','Account Elements can be natural accounts or user defined values.',200274,6087,'Y','@ElementType@=AC | @ElementType@=U1 | @ElementType@=U2 | @ElementType@=CO',14,110,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','804257d9-6f11-4ff9-b941-8c65ce34e37c','Y',110,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:46 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206264,'Include Nulls in Account','Include nulls in the selection of the account',200274,56156,'Y','@ElementType@=CO',1,120,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dac7c021-8f43-4e5d-b2f9-cdeb98c93157','Y',120,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:47 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206265,'Business Partner ','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200274,6089,'Y','@ElementType@=BP | @ElementType@=CO',14,130,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a66ea270-9b39-4f0e-a61d-c03526300f02','Y',130,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:47 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206266,'Include Nulls in BPartner','Include nulls in the selection of the business partner',200274,56157,'Y','@ElementType@=CO',1,140,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b77a20e7-82e8-4291-a433-7530817e8a54','Y',140,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:48 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206267,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200274,6090,'Y','@ElementType@=PR | @ElementType@=CO',14,150,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','531c16b5-28b7-46d4-ab60-53c592ff1043','Y',150,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:48 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206268,'Include Nulls in Product','Include nulls in the selection of the product',200274,56158,'Y','@ElementType@=CO',1,160,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f3af1020-fda7-4c4c-b754-3f3149046c41','Y',160,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206269,'Address','Location or Address','The Location / Address field defines the location of an entity.',200274,6092,'Y','@ElementType@=LF | @ElementType@=LT | @ElementType@=CO',14,170,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','14190232-9ed3-4a02-a02b-93841bf5805c','Y',170,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206270,'Include Nulls in Location','Include nulls in the selection of the location',200274,56159,'Y','@ElementType@=CO',1,180,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dc8b5fea-ddb7-452e-b2a7-4b17114ad860','Y',180,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206271,'Project','Financial Project','A Project allows you to track and control internal or external activities.',200274,6088,'Y','@ElementType@=PJ | @ElementType@=CO',14,190,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0a91e8a5-0072-4785-bb5f-e8c98bc6f335','Y',190,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:51 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206272,'Include Nulls in Project','Include nulls in the selection of the project',200274,56160,'Y','@ElementType@=CO',1,200,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ba9bfef9-e4a8-4157-a41a-be21fd557acb','Y',200,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206273,'Sales Region','Sales coverage region','The Sales Region indicates a specific area of sales coverage.',200274,6093,'Y','@ElementType@=SR | @ElementType@=CO',14,210,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','30316083-1692-428f-86eb-1881fe89d0e7','Y',210,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206274,'Include Nulls in Sales Region','Include nulls in the selection of the sales region',200274,56161,'Y','@ElementType@=CO',1,220,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5dec3a7b-e13a-4598-b794-46b0522ff866','Y',220,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206275,'Activity','Business Activity','Activities indicate tasks that are performed and used to utilize Activity based Costing',200274,6094,'Y','@ElementType@=AY | @ElementType@=CO',14,230,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c616430e-1270-4533-9977-1a2518f61610','Y',230,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206276,'Include Nulls in Activity','Include nulls in the selection of the activity',200274,56162,'Y','@ElementType@=CO',1,240,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','87429ff1-b0a9-4168-9844-0480ce1779a1','Y',240,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:54 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206277,'Campaign','Marketing Campaign','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',200274,6091,'Y','@ElementType@=MC | @ElementType@=CO',14,250,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','601d117b-a022-41ac-a1b4-76ec68bf97a7','Y',250,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206278,'Include Nulls in Campaign','Include nulls in the selection of the campaign',200274,56163,'Y','@ElementType@=CO',1,260,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bc4821ac-7f25-4885-a411-5342f892e91b','Y',260,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206279,'User Column 1','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)',200274,56153,'Y','@ElementType@=X1 | @ElementType@=CO & @$Element_X1@=Y',14,270,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c53ffe8e-d2f3-41fc-b9b5-73bbf9ea3694','Y',270,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206280,'Include Nulls in User Element 1','Include nulls in the selection of the user element 1',200274,56164,'Y','@ElementType@=CO & @$Element_X1@=Y',1,280,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','76c7b710-d8a6-482e-aea7-d1aa404438b6','Y',280,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206281,'User Column 2','User defined accounting Element','A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested) ',200274,56154,'Y','@ElementType@=X2 | @ElementType@=CO & @$Element_X2@=Y',14,290,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','396720d3-c288-42b5-b308-ea1ad014d50b','Y',290,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206282,'Include Nulls in User Element 2','Include nulls in the selection of the user element 2',200274,56165,'Y','@ElementType@=CO & @$Element_X2@=Y',1,300,'Y','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bedb6bd0-d6d6-4570-8b99-062f243bf441','Y',300,5,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206283,'User Element List 1','User defined list element #1','The user defined element displays the optional elements that have been defined for this account combination.',200274,214095,'Y','@ElementType@=CO',0,310,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2fa4819a-da2f-4efe-a222-95a217b31749','Y',310,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:58 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206284,'Include Nulls in User List 1','Include nulls in the selection of the User List 1',200274,214097,'Y','@ElementType@=CO',0,320,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ecd59b25-dcd7-46d7-9455-ada3fc0fc6e6','Y',320,4,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:00:59 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206285,'User Element List 2','User defined list element #2','The user defined element displays the optional elements that have been defined for this account combination.',200274,214096,'Y','@ElementType@=CO',0,330,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5aa6deab-785c-476e-a061-185333bd8a02','Y',330,1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:01:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206286,'Include Nulls in User List 2','Include nulls in the selection of the User List 2',200274,214098,'Y','@ElementType@=CO',0,340,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:00:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:00:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','16fbb14e-6ee8-46f9-a49c-3883bef5cbb5','Y',340,1,1,1,'N','N','N','N')
;

-- Oct 21, 2019 1:01:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206287,'PA_ReportSource_UU',200274,60979,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:01:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:01:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','733c5052-bdd4-4107-90cf-3f2a502d2ce0','N',1,2,1,'N','N','N','N')
;

-- Oct 21, 2019 1:01:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206288,'Report Column','Column in Report',200274,214099,'Y',0,350,0,'N','N','N','N',0,0,'Y',TO_DATE('2019-10-21 13:01:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 13:01:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9493e39d-edc2-4014-a0b2-3e7c4aef2df3','Y',350,1,1,1,'N','N','N','N')
;

-- Oct 21, 2019 1:03:06 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206288
;

-- Oct 21, 2019 1:03:06 PM IST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206284
;

-- Oct 21, 2019 1:03:06 PM IST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206286
;

-- Oct 21, 2019 1:03:06 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206287
;

-- Oct 21, 2019 1:03:06 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:03:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206255
;

-- Oct 21, 2019 1:24:14 PM IST
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:24:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206256
;

-- Oct 21, 2019 1:24:17 PM IST
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:24:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206257
;

-- Oct 21, 2019 1:24:20 PM IST
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:24:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206258
;

-- Oct 21, 2019 1:25:06 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:25:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206284
;

-- Oct 21, 2019 1:25:06 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:25:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206286
;

-- Oct 21, 2019 1:25:06 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:25:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206283
;

-- Oct 21, 2019 1:25:06 PM IST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:25:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206285
;

-- Oct 21, 2019 1:30:40 PM IST
UPDATE AD_Column SET FKConstraintName='PAReportColumn_PAReportSource', FKConstraintType='N',Updated=TO_DATE('2019-10-21 13:30:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214099
;

-- Oct 21, 2019 1:30:40 PM IST
ALTER TABLE PA_ReportSource ADD PA_ReportColumn_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2019 1:30:40 PM IST
ALTER TABLE PA_ReportSource ADD CONSTRAINT PAReportColumn_PAReportSource FOREIGN KEY (PA_ReportColumn_ID) REFERENCES pa_reportcolumn(pa_reportcolumn_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 21, 2019 1:31:32 PM IST
ALTER TABLE PA_ReportSource ADD IsIncludeNullsUserList1 CHAR(1) DEFAULT 'N' CHECK (IsIncludeNullsUserList1 IN ('Y','N')) NOT NULL
;

-- Oct 21, 2019 1:31:36 PM IST
ALTER TABLE PA_ReportSource ADD IsIncludeNullsUserList2 CHAR(1) DEFAULT 'N' CHECK (IsIncludeNullsUserList2 IN ('Y','N')) NOT NULL
;

-- Oct 21, 2019 1:32:19 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:32:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206251
;

-- Oct 21, 2019 1:32:25 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:32:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206249
;

-- Oct 21, 2019 1:33:05 PM IST
UPDATE AD_Field SET Name='User List 2', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2019-10-21 13:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206250
;

UPDATE AD_Column SET IsMandatory='N', IsUpdateable='N',Updated=TO_DATE('2019-10-21 18:28:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6084
;

-- Oct 21, 2019 6:28:26 PM IST
ALTER TABLE PA_ReportSource MODIFY PA_ReportLine_ID NUMBER(10) DEFAULT NULL 
;

-- Oct 21, 2019 6:28:26 PM IST
ALTER TABLE PA_ReportSource MODIFY PA_ReportLine_ID NULL
;

-- Oct 21, 2019 4:58:27 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214101,0,'Combination','Valid Account Combination','The Combination identifies a valid combination of element which represent a GL account.',544,'C_ValidCombination_ID','0',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2019-10-21 16:58:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-10-21 16:58:26','YYYY-MM-DD HH24:MI:SS'),100,222,'Y','N','D','N','N','N','Y','87bc79a1-771a-4932-aca1-f5307be1c747','Y',0,'N','N')
;

-- Oct 21, 2019 7:43:11 PM IST
UPDATE AD_Column SET MandatoryLogic='@ElementType@=CO',Updated=TO_DATE('2019-10-21 19:43:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6087
;

-- Oct 21, 2019 4:58:37 PM IST
UPDATE AD_Column SET FKConstraintName='CValidCombination_TReport', FKConstraintType='N',Updated=TO_DATE('2019-10-21 16:58:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214101
;

-- Oct 21, 2019 4:58:37 PM IST
ALTER TABLE T_Report ADD C_ValidCombination_ID NUMBER(10) DEFAULT 0
;

-- Oct 21, 2019 4:58:37 PM IST
ALTER TABLE T_Report DROP CONSTRAINT T_Report_Pkey
;
-- Oct 21, 2019 4:58:37 PM IST
ALTER TABLE T_Report ADD CONSTRAINT T_Report_Pkey PRIMARY KEY(AD_PInstance_ID, PA_ReportLine_ID, Record_ID, Fact_Acct_ID, C_Validcombination_ID)
;


-- Default Values

-- Oct 25, 2019 11:48:20 AM IST
UPDATE AD_Process_Para SET DefaultValue='Y',IsCentrallyMaintained='N',Updated=TO_DATE('2019-10-25 11:48:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=547
;

-- Oct 25, 2019 11:48:29 AM IST
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2019-10-25 11:48:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8176
;

-- Oct 25, 2019 1:23:22 PM IST
UPDATE AD_Ref_Table SET OrderByClause='C_Period.StartDate DESC',Updated=TO_DATE('2019-10-25 13:23:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=275
;


-- Indenting financial report detail rows, DisplaySQL for T_Report.Name Column

-- Nov 1, 2019 7:30:56 PM IST
UPDATE AD_Column SET Help='The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.length.(repeat(''....''::text, abs(levelno)::int) || name)', ColumnSQL='(repeat(''....''::text, abs(levelno)::int) || name)', IsAllowCopy='N',Updated=TO_DATE('2019-11-01 19:30:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8179
;
