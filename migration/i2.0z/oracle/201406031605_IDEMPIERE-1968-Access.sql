SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 3, 2014 5:05:09 PM ICT
-- IDEMPIERE-1968 valid check box in info window can manual editable
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='C',Updated=TO_DATE('2014-06-03 17:05:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208377
;

-- Jun 3, 2014 5:05:16 PM ICT
ALTER TABLE AD_InfoWindow_Access DROP CONSTRAINT adinfowindow_adinfowindowacces
;

-- Jun 3, 2014 5:05:16 PM ICT
ALTER TABLE AD_InfoWindow_Access ADD CONSTRAINT adinfowindow_adinfowindowacces FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Jun 3, 2014 5:13:25 PM ICT
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Column_ID,AD_Table_ID,AD_Client_ID,TreeDisplayedOn) VALUES ('N','N','Y',385,70,'N','N','N','N','N','Y','N',0,'d7868d02-46bc-4112-af34-35df9e13a79f','D','Role Access',200144,0,TO_DATE('2014-06-03 17:13:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-06-03 17:13:24','YYYY-MM-DD HH24:MI:SS'),100,'Y',208377,200054,0,'B')
;

-- Jun 3, 2014 5:13:52 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200144,36,'N','N',0,'Y',203051,'N','AD_InfoWindow_Access_UU','ff201a9f-6ce6-4554-8fbf-111507465b96','N','N',100,0,100,TO_DATE('2014-06-03 17:13:51','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,'N',0,1,1,'N','N',208373,'D',TO_DATE('2014-06-03 17:13:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 3, 2014 5:13:53 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200144,22,'N','N',10,'Y',203052,'Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','7bdd6c94-f7dd-4a1d-8188-bd56e3ffe0a6','Y','N',100,0,100,TO_DATE('2014-06-03 17:13:52','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N','N',208367,'D',TO_DATE('2014-06-03 17:13:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 3, 2014 5:13:54 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200144,22,'N','N',20,'Y',203053,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','7f47d673-3e32-4b73-bbeb-9409fd67b5ee','Y','N','Y',100,0,100,TO_DATE('2014-06-03 17:13:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,4,'N',0,2,1,'N','N',208368,'D',TO_DATE('2014-06-03 17:13:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 3, 2014 5:13:55 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200144,10,'N','N',30,'Y',203054,'N','The Role determines security and access a user who has this Role will have in the System.','Responsibility Role','Role','71b84a87-093a-483e-ae29-19bf3b29f107','Y','N',100,0,100,TO_DATE('2014-06-03 17:13:54','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,'N',0,2,1,'N','N',208376,'D',TO_DATE('2014-06-03 17:13:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 3, 2014 5:13:56 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200144,10,'N','N',40,'Y',203055,'N','The Info window is used to search and select records as well as display information relevant to the selection.','Info and search/select Window','Info Window','a1d6782a-7f0e-4261-b018-83bb3299c382','Y','N',100,0,100,TO_DATE('2014-06-03 17:13:55','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,'N',0,2,1,'N','N',208377,'D',TO_DATE('2014-06-03 17:13:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 3, 2014 5:13:57 PM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',200144,1,'N','N',50,'Y',203056,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','2fde0d03-3be0-4df2-bd56-56efd4d40008','Y','N',100,0,100,TO_DATE('2014-06-03 17:13:56','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,2,'N',0,1,1,'N','N',208371,'D',TO_DATE('2014-06-03 17:13:56','YYYY-MM-DD HH24:MI:SS'))
;

-- Jun 3, 2014 5:14:23 PM ICT
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-06-03 17:14:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203055
;

-- Jun 3, 2014 5:16:04 PM ICT
UPDATE AD_Field SET IsReadOnly='Y', DisplayLogic='@AD_InfoWindow_ID@',Updated=TO_DATE('2014-06-03 17:16:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203055
;

-- Jun 3, 2014 5:17:05 PM ICT
UPDATE AD_Field SET DisplayLogic=NULL, DefaultValue='@AD_InfoWindow_ID@',Updated=TO_DATE('2014-06-03 17:17:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203055
;

-- Jun 3, 2014 5:21:06 PM ICT
UPDATE AD_Tab SET TabLevel=1,Updated=TO_DATE('2014-06-03 17:21:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200144
;

-- Jun 3, 2014 5:25:34 PM ICT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2014-06-03 17:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201645
;

-- Jun 3, 2014 5:26:17 PM ICT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2014-06-03 17:26:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203053
;

SELECT register_migration_script('201406031605_IDEMPIERE-1968-Access.sql') FROM dual
;
