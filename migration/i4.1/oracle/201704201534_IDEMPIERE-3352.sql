SET SQLBLANKLINES ON
SET DEFINE OFF

-- Add IsAutoGenerateLot to M_AttributeSet.
-- Apr 20, 2017 3:34:42 PM SGT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203078,0,0,'Y',TO_DATE('2017-04-20 15:34:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 15:34:41','YYYY-MM-DD HH24:MI:SS'),100,'IsAutoGenerateLot','IsAutoGenerateLot','Auto Generate Lot','D','01487993-345a-4ddf-8da7-50d88581686b')
;

-- Apr 20, 2017 3:37:18 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213024,0,'IsAutoGenerateLot',560,'IsAutoGenerateLot',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2017-04-20 15:37:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 15:37:17','YYYY-MM-DD HH24:MI:SS'),100,203078,'Y','N','U','N','N','N','Y','ac7ab79e-7b73-48ac-ae20-bec945663a19','Y',0,'N','N')
;

-- Apr 20, 2017 3:37:27 PM SGT
ALTER TABLE M_AttributeSet ADD IsAutoGenerateLot CHAR(1) DEFAULT 'N'  CHECK (IsAutoGenerateLot IN ('Y','N'))
;

-- Apr 20, 2017 3:37:50 PM SGT
UPDATE AD_Column SET DefaultValue='N',Updated=TO_DATE('2017-04-20 15:37:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213024
;

-- Apr 20, 2017 3:45:39 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204432,'IsAutoGenerateLot',461,213024,'Y',0,220,0,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 15:45:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 15:45:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','9e9451eb-37c7-4766-9546-97bab80a2478','Y',210,2,2,1,'N','N','N')
;

-- Apr 20, 2017 4:02:13 PM SGT
UPDATE AD_Field SET DisplayLogic='@IsLot@=Y& @M_LotCtl_ID@ > 0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 16:02:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204432
;

-- Apr 20, 2017 4:06:48 PM SGT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200224,'Attributes',53127,40,'Y',765,0,0,'Y',TO_DATE('2017-04-20 16:06:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:06:47','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','U','Y','N','9eced926-7d62-4fb8-9820-75039a2e9856','B')
;

-- Apr 20, 2017 4:07:04 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (204433,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200224,13286,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 16:07:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:07:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','b69238c1-336d-48fb-977e-9a9191a1f849','N',2)
;

-- Apr 20, 2017 4:07:04 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204434,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200224,13285,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 16:07:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:07:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','24234f73-569c-499c-8209-f910b6f69050','Y','Y',10,4,2)
;

-- Apr 20, 2017 4:07:05 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204435,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200224,13287,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 16:07:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:07:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','e328aac8-688c-4229-8a7d-181ebf0e8a38','Y',20,2)
;

-- Apr 20, 2017 4:07:06 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204436,'Production Line','Document Line representing a production','The Production Line indicates the production document line (if applicable) for this transaction',200224,13288,'Y',22,40,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 16:07:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:07:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','9d166382-f494-4a29-a01d-160b4621bd6e','Y',30,2)
;

-- Apr 20, 2017 4:07:06 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204437,'Movement Quantity','Quantity of a product moved.','The Movement Quantity indicates the quantity of a product that has been moved.',200224,13289,'Y',22,50,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 16:07:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:07:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','50884b2d-9f35-4711-b80e-af2fe5bbe00a','Y',40,2)
;

-- Apr 20, 2017 4:07:07 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (204438,'M_ProductionLineMA_UU',200224,60930,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 16:07:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:07:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','5b9195b5-cb16-4e93-bbf5-b0631871e425','N',2)
;

-- Apr 20, 2017 4:07:08 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (204439,'Date  Material Policy','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy',200224,210658,'Y',7,60,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 16:07:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:07:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','698b6efa-db36-4eb4-bc9d-411d34557bfb','Y',50,2)
;

-- Apr 20, 2017 4:07:09 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204440,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200224,13284,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2017-04-20 16:07:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-04-20 16:07:08','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','3dc9c715-7866-4b2c-ac0b-62cdd3620097','Y',60,2,2)
;


-- Apr 20, 2017 8:17:51 PM SGT
UPDATE AD_Tab SET DisplayLogic='@IsEndProduct@ =''N''',Updated=TO_DATE('2017-04-20 20:17:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200224
;

-- Apr 20, 2017 8:18:16 PM SGT
UPDATE AD_Tab SET EntityType='D',Updated=TO_DATE('2017-04-20 20:18:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200224
;

-- Apr 20, 2017 8:18:29 PM SGT
UPDATE AD_Tab SET TabLevel=2,Updated=TO_DATE('2017-04-20 20:18:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200224
;

-- Apr 20, 2017 8:18:47 PM SGT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 20:18:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204433
;

-- Apr 20, 2017 8:18:50 PM SGT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 20:18:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204434
;

-- Apr 20, 2017 8:18:54 PM SGT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 20:18:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204435
;

-- Apr 20, 2017 8:18:56 PM SGT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 20:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204436
;

-- Apr 20, 2017 8:18:59 PM SGT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 20:18:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204437
;

-- Apr 20, 2017 8:19:03 PM SGT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 20:19:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204439
;

-- Apr 20, 2017 8:19:06 PM SGT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 20:19:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204440
;

-- Apr 20, 2017 8:20:05 PM SGT
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-04-20 20:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204432
;

-- Apr 20, 2017 8:20:21 PM SGT
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2017-04-20 20:20:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213024
;

SELECT register_migration_script('201704201534_IDEMPIERE-3352.sql') FROM dual
;
