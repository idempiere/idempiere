SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 18, 2023, 9:36:43 AM WIB
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200361,'Tax Rate',138,30,'Y',261,0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:42','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N',2254,'N','N',1,'N','D','Y','N','0e084f60-bce3-45bc-a7c6-af8100415f59','B','N','Y',0)
;

-- Oct 18, 2023, 9:36:54 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207804,'C_Tax_UU',200361,60769,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:54','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:54','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','d1f68eac-119b-45a3-9162-d6ca91c0ab7d','N',1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:36:55 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207805,'Tax','Tax identifier','The Tax indicates the type of tax used in document line.',200361,2240,'N',14,0,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:54','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:54','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e8d55066-63bc-4b04-a393-b58be8ddaba2','N',0,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:36:56 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207806,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200361,2241,'Y',14,10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:55','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:55','YYYY-MM-DD HH24:MI:SS'),10,'Y','Y','D','d2807cac-35b8-4545-983c-843e8ca7b190','N',10,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:36:56 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207807,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200361,2242,'Y',14,20,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:56','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:56','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4e85aad4-7d53-49cf-b75c-73f6087c2387','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:36:57 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207808,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200361,2246,'Y',60,30,1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:56','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:56','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','29ab0b7e-c21c-40be-b74a-35732dae4c91','Y',30,1,5,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:36:58 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207809,'Description','Optional short description of the record','A description is limited to 255 characters.',200361,2247,'Y',60,40,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:57','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:57','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','fb88a73e-bf19-4221-93b6-3fb14784394e','Y',40,1,5,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:36:58 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207810,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200361,2243,'Y',1,50,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:58','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:58','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','dc4307eb-972c-4f37-b408-ecaafb65ba7b','Y',50,2,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:00 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207811,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200361,4211,'Y',1,60,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:36:58','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:36:58','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','7c7dbf40-51f4-41c7-9301-e163f0852c1d','Y',60,5,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:01 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207812,'Tax Category','Tax Category','The Tax Category provides a method of grouping similar taxes.  For example, Sales Tax or Value Added Tax.',200361,2254,'Y',14,70,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:00','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:00','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','9a48c612-1158-4777-b608-7be5d882fd55','Y',70,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:01 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207813,'Valid from','Valid from including this date (first day)','The Valid From date indicates the first day of a date range',200361,3054,'Y',14,80,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:01','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:01','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','0c3ea732-00f2-4b95-8a28-a128f5f33023','Y',80,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:02 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207814,'SO Tax exempt','Business partner is exempt from tax on sales','If a business partner is exempt from tax on sales, the exempt tax rate is used. For this, you need to set up a tax rate with a 0% rate and indicate that this is your tax exempt rate.  This is required for tax reporting, so that you can track tax exempt transactions.',200361,7971,'Y',1,90,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:01','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:01','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','2401f2db-f77d-43b7-8918-e7a19a45a69c','Y',90,2,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:02 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207815,'Requires Tax Certificate','This tax rate requires the Business Partner to be tax exempt','The Requires Tax Certificate indicates that a tax certificate is required for a Business Partner to be tax exempt.',200361,3695,'Y',1,100,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:02','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','868f2aec-666d-4fb3-b7be-7866ada9985a','Y',100,5,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:03 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207816,'Document Level','Tax is calculated on document level (rather than line by line)','If the tax is calculated on document level, all lines with that tax rate are added before calculating the total tax for the document.
Otherwise the tax is calculated per line and then added.
Due to rounding, the tax amount can differ.',200361,3053,'Y',1,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:02','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4f1487d9-44aa-43a7-a225-67139a9bdc28','Y',110,2,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:04 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207817,'Sales Tax','This is a sales tax (i.e. not a value added tax)','If selected AP tax is handled as expense, otherwise it is handled as a VAT credit.',200361,14528,'Y',1,120,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:03','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:03','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','031c236b-0a8d-448f-930e-d2052205ab96','Y',120,5,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:05 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207818,'Summary Level','This is a summary entity','A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.',200361,3055,'Y',1,130,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:04','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:04','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','0b19ba25-4167-4f9f-adcc-b1448620d050','Y',130,2,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:06 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207819,'Parent Tax','Parent Tax indicates a tax that is made up of multiple taxes','The Parent Tax indicates a tax that is a reference for multiple taxes.  This allows you to charge multiple taxes on a document by entering the Parent Tax',200361,2249,'Y','@IsSummary@=''N''',14,140,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:05','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:05','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e4967748-dee9-4f20-b23e-0a62ff5b6f50','Y',140,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:06 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207820,'SO/PO Type','Sales Tax applies to sales situations, Purchase Tax to purchase situations','Sales Tax: charged when selling - examples: Sales Tax, Output VAT (payable)
Purchase Tax: tax charged when purchasing - examples: Use Tax, Input VAT (receivable)',200361,9767,'Y',14,150,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:06','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','6357cc4c-4499-4525-8f62-ada3124052dd','Y',150,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:07 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207821,'Tax Indicator','Short form for Tax to be printed on documents','The Tax Indicator identifies the short name that will print on documents referencing this tax.',200361,3724,'Y',5,160,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:06','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','fa235fb1-945d-4e60-a964-9fa581b86840','Y',160,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:08 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207822,'Rate','Rate or Tax or Exchange','The Rate indicates the percentage to be multiplied by the source to arrive at the tax or exchange amount.',200361,3693,'Y',26,170,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:07','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','2d627d63-ed27-41e8-a518-735bc01cef21','Y',170,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:08 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207823,'Posting Indicator','Type of input tax (deductible and non deductible)','Separate Tax Posting: Tax is calculated on the full amount of the item and posted separately.
Distribute Tax with Relevant Expense: Tax amount is added to the item amount during account posting time and for updating of Product Cost.',200361,213805,'Y','@IsDocumentLevel@=N & @IsSummary@=N & @SOPOType@!S',0,180,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:08','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','2d53b2fa-24ab-4701-9c8d-835b812b13da','Y',180,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:09 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207824,'Rule',200361,54408,'Y',22,180,0,'Y','N','N','N',0,0,'N',TO_TIMESTAMP('2023-10-18 09:37:08','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:08','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','2ff74ee4-7b01-4a93-90a6-bd29d43fcc18','Y',180,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:10 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207825,'Country Group',200361,211647,'Y',10,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:09','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:09','YYYY-MM-DD HH24:MI:SS'),10,'N','N','D','16dc0aa8-8c33-41db-b661-42e8670aaafc','Y',190,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:10 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207826,'To',200361,211646,'Y',10,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:10','YYYY-MM-DD HH24:MI:SS'),10,'N','N','D','5d1cd770-5531-4104-911f-9519cacdcf01','Y',200,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:11 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207827,'Country','Country ','The Country defines a Country.  Each Country must be defined before it can be used in any document.',200361,2250,'Y',14,210,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:10','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','904b4db4-4878-443b-95cb-06ea43942051','Y',210,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:12 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207828,'To','Receiving Country','The To Country indicates the receiving country on a document',200361,2252,'Y',14,220,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:11','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:11','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','92716fd4-7671-44be-b450-9b8630752dc7','Y',220,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:12 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207829,'Region','Identifies a geographical Region','The Region identifies a unique Region for this Country.',200361,2251,'Y',14,230,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:12','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','ac94ea19-3095-4fb7-8093-625640fb0b91','Y',230,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:13 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207830,'To','Receiving Region','The To Region indicates the receiving region on a document',200361,2253,'Y',14,240,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:12','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','f7ea9138-936d-41ad-8e76-3c446d9d5a9e','Y',240,4,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:37:14 AM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207831,'Tax Provider',200361,210724,'Y',22,250,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-18 09:37:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-10-18 09:37:13','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','abb2a474-88be-4edd-bea0-e887ecf5b2e5','Y',250,1,2,1,'N','N','N','N')
;

-- Oct 18, 2023, 9:53:48 AM WIB
UPDATE AD_Tab SET SeqNo=15,Updated=TO_TIMESTAMP('2023-10-18 09:53:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200361
;

-- IDEMPIERE-4648
SELECT register_migration_script('202310180934_IDEMPIERE-4648.sql') FROM dual;