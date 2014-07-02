-- Apr 14, 2014 5:56:06 PM IST
-- IDEMPIERE-1770 Making Attribute tab Manually editable
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID) VALUES ('I','More than line qty on attribute tab for line ',200270,'D','4726e9ac-3831-4ca4-b860-23b2364160f0','Over_Qty_On_Attribute_Tab','Y',TO_TIMESTAMP('2014-04-14 17:56:04','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2014-04-14 17:56:04','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Apr 14, 2014 5:56:27 PM IST
UPDATE AD_Tab SET IsReadOnly='N',Updated=TO_TIMESTAMP('2014-04-14 17:56:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=751
;

-- Apr 14, 2014 6:01:47 PM IST
UPDATE AD_Tab SET IsInsertRecord='Y',Updated=TO_TIMESTAMP('2014-04-14 18:01:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=751
;

-- Apr 14, 2014 6:15:24 PM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_TIMESTAMP('2014-04-14 18:15:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12194
;

-- Apr 14, 2014 6:15:38 PM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_TIMESTAMP('2014-04-14 18:15:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12196
;

-- Apr 14, 2014 7:48:10 PM IST
-- IDEMPIERE-1770 Making Attribute tab Manually editable
UPDATE AD_Column SET DefaultValue='@AD_Org_ID@',Updated=TO_TIMESTAMP('2014-04-14 19:48:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13325
;

-- Apr 14, 2014 7:54:02 PM IST
UPDATE AD_Column SET IsParent='N',Updated=TO_TIMESTAMP('2014-04-14 19:54:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208342
;

-- Apr 14, 2014 7:56:15 PM IST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2014-04-14 19:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208342
;

-- Apr 15, 2014 4:26:24 PM IST
-- IDEMPIERE-1770 Making Attribute tab Manually editable
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Table_ID,AD_Client_ID,AD_Window_ID,TreeDisplayedOn) VALUES ('N','N','Y',40,'N','N','N','N','N','Y','N',2,'d771d2e8-42a0-426e-ba58-c4f459bbbc1e','D','Attributes','Product Instance Attribute Material Allocation',200137,0,TO_TIMESTAMP('2014-04-15 16:26:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:26:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',762,0,184,'B')
;

-- Apr 15, 2014 4:27:05 PM IST
UPDATE AD_Tab SET SeqNo=50,Updated=TO_TIMESTAMP('2014-04-15 16:27:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=688
;

-- Apr 15, 2014 4:27:20 PM IST
UPDATE AD_Tab SET SeqNo=60,Updated=TO_TIMESTAMP('2014-04-15 16:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=689
;

-- Apr 15, 2014 4:27:56 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13324,10,'Y',202855,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','59fa77cd-26e2-4603-abf3-371353ba0006','Y','N',100,0,TO_TIMESTAMP('2014-04-15 16:27:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:27:55','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D',200137)
;

-- Apr 15, 2014 4:27:57 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13325,20,'Y',202856,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','e46f8fd7-d445-4664-8232-cef0e6bc362b','Y','N','Y',100,0,TO_TIMESTAMP('2014-04-15 16:27:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:27:56','YYYY-MM-DD HH24:MI:SS'),'Y',4,0,2,'D',200137)
;

-- Apr 15, 2014 4:27:59 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13322,30,'Y',202857,'N','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document','Line on Shipment or Receipt document','Shipment/Receipt Line','726ab1f8-fd3f-49b1-a927-b33abb65747e','Y','N',100,0,TO_TIMESTAMP('2014-04-15 16:27:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:27:57','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',200137)
;

-- Apr 15, 2014 4:27:59 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13323,40,'Y',202858,'N','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','Product Attribute Set Instance','Attribute Set Instance','b9e93296-2cd5-47d0-81e3-0923434e82c2','Y','N',100,0,TO_TIMESTAMP('2014-04-15 16:27:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:27:59','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',200137)
;

-- Apr 15, 2014 4:28:00 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13331,50,'Y',202859,'N','The Movement Quantity indicates the quantity of a product that has been moved.','Quantity of a product moved.','Movement Quantity','92faf768-01a2-4ad7-b4f4-44161d9c6460','Y','N',100,0,TO_TIMESTAMP('2014-04-15 16:27:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:27:59','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',200137)
;

-- Apr 15, 2014 4:28:01 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',36,'N','N',60900,60,'Y',202860,'N','M_InOutLineMA_UU','0c446edf-38f0-4948-8871-591260db1db9','N','N',100,0,TO_TIMESTAMP('2014-04-15 16:28:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:28:00','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D',200137)
;

-- Apr 15, 2014 4:28:01 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',7,'N','N',208342,70,'Y',202861,'N','This field is used to record time used for LIFO and FIFO material policy','Time used for LIFO and FIFO Material Policy','Date  Material Policy','92265f55-892e-4814-9922-9bf1c35fd43b','Y','N',100,0,TO_TIMESTAMP('2014-04-15 16:28:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:28:01','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',200137)
;

-- Apr 15, 2014 4:28:02 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',1,'N','N',13326,80,'Y',202862,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','13f448e6-c398-4ea2-97e8-89c901f24124','Y','N',100,0,TO_TIMESTAMP('2014-04-15 16:28:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-15 16:28:01','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D',200137)
;

-- Apr 15, 2014 4:28:44 PM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202862
;

-- Apr 15, 2014 4:28:44 PM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202860
;

-- Apr 15, 2014 4:28:44 PM IST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202861
;

-- Apr 15, 2014 4:29:26 PM IST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202862
;

-- Apr 15, 2014 4:29:26 PM IST
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202858
;

-- Apr 15, 2014 4:29:26 PM IST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202861
;

-- Apr 15, 2014 4:29:26 PM IST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202859
;

-- Apr 15, 2014 4:29:26 PM IST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202856
;

-- Apr 15, 2014 4:29:26 PM IST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202857
;

-- Apr 15, 2014 4:30:34 PM IST
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-04-15 16:30:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202857
;

-- Apr 15, 2014 4:53:49 PM IST
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2014-04-15 16:53:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202858
;

-- Apr 15, 2014 4:54:23 PM IST
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2014-04-15 16:54:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202861
;

-- Apr 16, 2014 6:24:54 PM IST
-- IDEMPIERE-1770 Making Attribute tab Manually editable
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,SeqNo,IsTranslationTab,IsSortTab,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Table_ID,AD_Client_ID,AD_Window_ID,TreeDisplayedOn) VALUES ('N','N','Y',40,'N','N','N','N','N','Y','N',2,'8cf5abeb-4146-4581-b353-24ee510bcaff','D','Attributes','Product Instance Attribute Material Allocation',200138,0,TO_TIMESTAMP('2014-04-16 18:24:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:24:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',762,0,53097,'B')
;

-- Apr 16, 2014 6:25:03 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13324,10,'Y',202863,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','490b0733-4890-4e19-af23-acd31c1adb2e','Y','N',100,0,TO_TIMESTAMP('2014-04-16 18:25:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:25:02','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D',200138)
;

-- Apr 16, 2014 6:25:04 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13325,20,'Y',202864,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','b4f28546-657c-47cc-9d41-0631c71c1616','Y','N','Y',100,0,TO_TIMESTAMP('2014-04-16 18:25:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:25:03','YYYY-MM-DD HH24:MI:SS'),'Y',4,0,2,'D',200138)
;

-- Apr 16, 2014 6:25:04 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13322,30,'Y',202865,'N','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document','Line on Shipment or Receipt document','Shipment/Receipt Line','f83a86f6-472d-494f-8abf-6b5b84f71f99','Y','N',100,0,TO_TIMESTAMP('2014-04-16 18:25:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:25:04','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',200138)
;

-- Apr 16, 2014 6:25:05 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13323,40,'Y',202866,'N','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','Product Attribute Set Instance','Attribute Set Instance','a81d331b-79d1-450d-9856-945b0d713556','Y','N',100,0,TO_TIMESTAMP('2014-04-16 18:25:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:25:04','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',200138)
;

-- Apr 16, 2014 6:25:06 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',22,'N','N',13331,50,'Y',202867,'N','The Movement Quantity indicates the quantity of a product that has been moved.','Quantity of a product moved.','Movement Quantity','637b8625-8cba-4a2c-b67e-fb6d2537e3ae','Y','N',100,0,TO_TIMESTAMP('2014-04-16 18:25:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:25:05','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',200138)
;

-- Apr 16, 2014 6:25:07 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',36,'N','N',60900,60,'Y',202868,'N','M_InOutLineMA_UU','153a008e-e046-4014-b466-7c03e7694ff1','N','N',100,0,TO_TIMESTAMP('2014-04-16 18:25:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:25:06','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D',200138)
;

-- Apr 16, 2014 6:25:07 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',7,'N','N',208342,70,'Y',202869,'N','This field is used to record time used for LIFO and FIFO material policy','Time used for LIFO and FIFO Material Policy','Date  Material Policy','74d11884-f339-481d-a278-3eadc2c7cfde','Y','N',100,0,TO_TIMESTAMP('2014-04-16 18:25:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:25:07','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',200138)
;

-- Apr 16, 2014 6:25:08 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',1,'N','N',13326,80,'Y',202870,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','381c7afe-31bd-4499-a5b5-fbdae4afefaf','Y','N',100,0,TO_TIMESTAMP('2014-04-16 18:25:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 18:25:07','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D',200138)
;

-- Apr 16, 2014 6:25:49 PM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202870
;

-- Apr 16, 2014 6:25:49 PM IST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202868
;

-- Apr 16, 2014 6:25:49 PM IST
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202869
;

-- Apr 16, 2014 6:27:46 PM IST
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-04-16 18:27:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202863
;

-- Apr 16, 2014 6:28:41 PM IST
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-04-16 18:28:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202864
;

-- Apr 16, 2014 6:29:03 PM IST
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2014-04-16 18:29:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202865
;

-- Apr 16, 2014 6:29:21 PM IST
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2014-04-16 18:29:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202866
;

-- Apr 16, 2014 6:29:45 PM IST
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2014-04-16 18:29:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202869
;

-- Apr 16, 2014 6:30:00 PM IST
UPDATE AD_Tab SET SeqNo=50,Updated=TO_TIMESTAMP('2014-04-16 18:30:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53274
;

-- Apr 16, 2014 6:30:21 PM IST
UPDATE AD_Tab SET SeqNo=30,Updated=TO_TIMESTAMP('2014-04-16 18:30:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200138
;

-- Apr 16, 2014 6:30:27 PM IST
UPDATE AD_Tab SET SeqNo=40,Updated=TO_TIMESTAMP('2014-04-16 18:30:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53273
;

-- Apr 16, 2014 6:30:48 PM IST
UPDATE AD_Tab SET SeqNo=60,Updated=TO_TIMESTAMP('2014-04-16 18:30:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53275
;

-- Apr 16, 2014 7:52:20 PM IST
-- IDEMPIERE-1770 Making Attribute tab Manually editable
UPDATE AD_Tab SET IsReadOnly='N', IsInsertRecord='Y',Updated=TO_TIMESTAMP('2014-04-16 19:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53279
;

-- Apr 16, 2014 7:52:44 PM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_TIMESTAMP('2014-04-16 19:52:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57942
;

-- Apr 16, 2014 7:52:52 PM IST
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_TIMESTAMP('2014-04-16 19:52:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57943
;

-- Apr 16, 2014 7:53:07 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',36,'N','N',60900,60,'Y',202871,'N','M_InOutLineMA_UU','966b40fa-a67b-4014-adf6-6e4e549357e2','N','N',100,0,TO_TIMESTAMP('2014-04-16 19:53:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 19:53:06','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D',53279)
;

-- Apr 16, 2014 7:53:08 PM IST
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType,AD_Tab_ID) VALUES ('N',7,'N','N',208342,70,'Y',202872,'N','This field is used to record time used for LIFO and FIFO material policy','Time used for LIFO and FIFO Material Policy','Date  Material Policy','1a789397-4670-40f6-9dfd-2f366bd1deb7','Y','N',100,0,TO_TIMESTAMP('2014-04-16 19:53:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2014-04-16 19:53:07','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D',53279)
;

-- Apr 16, 2014 7:53:43 PM IST
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2014-04-16 19:53:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202872
;

-- Apr 16, 2014 8:16:21 PM IST
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2014-04-16 20:16:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57942
;

-- Apr 16, 2014 8:17:03 PM IST
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2014-04-16 20:17:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57943
;

SELECT register_migration_script('201407010830_IDEMPIERE-1770.sql') FROM dual
;
