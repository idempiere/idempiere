-- IDEMPIERE-4224 Create Window - Table Attributes AD
SELECT register_migration_script('202506181518_IDEMPIERE-4224.sql') FROM dual;



-- Jun 18, 2025, 3:19:57 PM IST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200157,'Table Attribute Instance',0,0,'Y',TO_TIMESTAMP('2025-06-18 15:19:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:19:56','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','6949502d-0fa4-446f-b1c6-d5810344abcf')
;

-- Jun 18, 2025, 3:20:39 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200396,'Table Attribute Set',200157,10,'Y',200423,0,0,'Y',TO_TIMESTAMP('2025-06-18 15:20:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:20:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','6cb5b19e-fbb8-451b-8100-2f80f95b36cb','B','N','Y',0)
;

-- Jun 18, 2025, 3:20:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208802,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200396,217014,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 15:20:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:20:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5de94be5-ceff-4bc7-9099-910ab07f7144','N',2)
;

-- Jun 18, 2025, 3:20:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208803,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200396,217015,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 15:20:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:20:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','91a8f922-ee27-4504-8148-a89fad5e0a4b','Y','N',4,2)
;

-- Jun 18, 2025, 3:20:51 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,IsAlwaysUpdateable) VALUES (208804,'Table','Database Table information','The Database Table provides the information of the table definition',200396,217024,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 15:20:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:20:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b7ac0963-a067-4c6b-a851-6363c5c01c78','Y',10,2,'Y')
;

-- Jun 18, 2025, 3:20:51 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208805,'Table Attribute Set',200396,217021,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 15:20:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:20:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','617583ce-2baa-4ab0-9e75-7cb7bb763cf2','N',2)
;

-- Jun 18, 2025, 3:20:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208806,'AD_TableAttributeSet_UU',200396,217022,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 15:20:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:20:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','479a0024-155e-483f-9f9f-b22a7fc94089','N',2)
;

-- Jun 18, 2025, 3:20:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208807,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',200396,217023,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 15:20:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:20:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2841757f-a286-4217-b3b4-7709fd9fde5a','Y',20,2)
;

-- Jun 18, 2025, 3:20:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208808,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200396,217020,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 15:20:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:20:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','73f967cb-d7f5-4847-bb4f-fbcd9f1af872','Y',30,2,2)
;

-- Jun 18, 2025, 3:21:00 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2025-06-18 15:21:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208807
;

-- Jun 18, 2025, 3:21:00 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-06-18 15:21:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208806
;

-- Jun 18, 2025, 3:21:00 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-06-18 15:21:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208805
;

-- Jun 27, 2025, 3:42:29 PM IST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=44,Updated=TO_TIMESTAMP('2025-06-27 15:42:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Jun 18, 2025, 3:21:39 PM IST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200246,'Table Attribute Instance','W',200157,0,0,'Y',TO_TIMESTAMP('2025-06-18 15:36:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 15:36:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','f6c635db-15ba-496a-8c92-f0616fc5a407')
;

-- Jun 18, 2025, 3:21:39 PM IST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200246, 153, 43, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200246)
;

-- Jun 24, 2025, 11:19:34 AM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,WhereClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200397,'Table Attribute Value',200157,20,'Y',200390,0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',215944,'AD_Table_ID = @AD_Table_ID@','N','N',1,'N','D','Y','N','1b320d42-2be0-4e33-bfbd-c2b89ad41ea5','B','N','Y',0)
;

-- Jun 24, 2025, 11:19:51 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208811,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200397,215933,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4775ced1-076a-4669-a754-91d9e9373c1d','Y',10,2)
;

-- Jun 24, 2025, 11:19:52 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208812,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200397,215934,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','38a037ba-698f-45fa-b5a3-9bc21f3ace8a','Y','N',4,2)
;

-- Jun 24, 2025, 11:19:53 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208813,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200397,215941,'Y',2000,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eabf4cb2-570d-4add-adb1-c21c754f50d4','Y',20,5,3)
;

-- Jun 24, 2025, 11:19:53 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208814,'AD_TableAttribute_ID',200397,215931,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9d876849-c385-47b7-87e3-f270f0ccfcfd','N',2)
;

-- Jun 24, 2025, 11:19:54 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208815,'AD_TableAttribute_UU',200397,215932,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','41527175-0007-4f70-8bee-a46191917f48','N',2)
;

-- Jun 24, 2025, 11:19:55 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208816,'Attribute','Product Attribute','Product Attribute like Color, Size',200397,215940,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4150066a-4de9-404a-848d-4e91ad760870','Y',30,2)
;

-- Jun 24, 2025, 11:19:56 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208817,'Value Date',200397,215942,'Y',7,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ec5a3ca8-a415-4316-8aa7-91c9c39aa2b4','Y',40,2)
;

-- Jun 24, 2025, 11:19:56 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208818,'Value','Numeric Value',200397,215943,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','535883c0-a778-4cbe-b690-470a8d9e22dc','Y',50,2)
;

-- Jun 24, 2025, 11:19:57 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208819,'Table','Database Table information','The Database Table provides the information of the table definition',200397,215944,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb69aa4a-5f12-451a-8cde-fe28d2c83045','Y',60,2)
;

-- Jun 24, 2025, 11:19:58 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208820,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200397,215945,'Y',22,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e92d9300-ed89-409c-929e-93f232c77fa9','Y',70,2)
;

-- Jun 24, 2025, 11:19:58 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208821,'Attribute Value','Product Attribute Value','Individual value of a product attribute (e.g. green, large, ..)',200397,215946,'Y',22,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8ae81bd5-60f8-4e7d-9761-dc67277588a8','Y',80,2)
;

-- Jun 24, 2025, 11:20:00 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208823,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200397,215937,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-06-24 11:19:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-24 11:19:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5b01675a-aa72-4e09-985e-d16679dd6e74','Y',100,2,2)
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208819
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208820
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208816
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=4,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208821
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET Name='Value', IsCentrallyMaintained = 'Y', SeqNo=80, NumLines=1,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208813
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208818
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208817
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208814
;

-- Jun 24, 2025, 11:21:26 AM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-06-24 11:21:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208815
;

-- Jun 24, 2025, 11:23:41 AM IST
UPDATE AD_Field SET IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2025-06-24 11:23:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208820
;

-- Jun 25, 2025, 6:40:00 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Duplicate entries found in the Attribute Set. Each attribute must have a unique value for the associated table.',0,0,'Y',TO_TIMESTAMP('2025-06-25 18:39:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-25 18:39:59','YYYY-MM-DD HH24:MI:SS'),100,200949,'DuplicateAttribute','D','6d66970d-1da7-453b-87b4-3ad243592d37')
;

-- Jun 27, 2025, 2:17:49 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Each Table Attribute Set Type must have a unique attribute assigned. Attribute "{0}" is already used in Attribute Set "{1}".',0,0,'Y',TO_TIMESTAMP('2025-06-27 14:17:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-27 14:17:49','YYYY-MM-DD HH24:MI:SS'),100,200950,'UniqueAttribute','D','c7ba0f5a-8ca1-4d87-83e7-87f0cfae58d9')
;


-- Jun 27, 2025, 4:59:27 PM IST
UPDATE AD_Column SET IsMandatory='Y',IsUpdateable='N',Updated=TO_TIMESTAMP('2025-06-27 16:59:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215944
;

-- Jun 27, 2025, 5:08:10 PM IST
UPDATE AD_Val_Rule SET Name='M_Attribute of M_AttributeSet ( M_AttributeUse )', Code='M_Attribute.M_Attribute_ID IN ( SELECT M_Attribute_ID FROM M_AttributeUse WHERE M_AttributeUse.M_AttributeSet_ID=@M_AttributeSet_ID@)',Updated=TO_TIMESTAMP('2025-06-27 17:08:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200099
;

-- Jun 27, 2025, 5:09:16 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200099, IsMandatory='Y',Updated=TO_TIMESTAMP('2025-06-27 17:09:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215940
;

-- Jun 27, 2025, 5:14:35 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200100, IsUpdateable='Y',Updated=TO_TIMESTAMP('2025-06-27 17:14:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215946
;

-- Jun 27, 2025, 5:14:55 PM IST
UPDATE AD_Column SET IsMandatory='Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2025-06-27 17:14:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215945
;

-- Jun 27, 2025, 5:29:15 PM IST
UPDATE AD_Tab SET WhereClause='AD_TableAttribute.M_Attribute_ID IN (select M_Attribute_ID from M_AttributeUse where M_AttributeUse.M_AttributeSet_ID=@M_AttributeSet_ID@)',Updated=TO_TIMESTAMP('2025-06-27 17:29:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200397
;

