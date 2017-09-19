SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 6, 2014 1:21:20 AM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Description,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,EntityType,AD_Client_ID,AD_Org_ID) VALUES (200261,302,'Show a info window','User Info','eaf4fa91-3fa3-47f9-9b7f-6ac5b475da68','I',TO_DATE('2014-08-06 01:21:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-08-06 01:21:19','YYYY-MM-DD HH24:MI:SS'),100,'Y','D',0,0)
;

-- Aug 6, 2014 1:21:21 AM ICT
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES ('Y',0,211619,'N','N','N',0,'N',10,'N','N','N','Y','85c2fb04-a9ea-48da-b8b5-f665cd351f59','Y','AD_InfoWindow_ID','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.','Info Window','Y',TO_DATE('2014-08-06 01:21:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-08-06 01:21:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','ADInfoWindow_ADWFNode','N',3068,19,129)
;

-- Aug 6, 2014 1:21:21 AM ICT
ALTER TABLE AD_WF_Node ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 6, 2014 1:21:22 AM ICT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,Created) VALUES ('N',122,14,'N','N',190,'Y',203315,'N','The Info window is used to search and select records as well as display information relevant to the selection.','@Action@=I','Info and search/select Window','Info Window','90092f42-98b1-42cc-915d-86cf77336874','Y','N',100,0,100,TO_DATE('2014-08-06 01:21:21','YYYY-MM-DD HH24:MI:SS'),'Y','Y',180,1,'N',0,2,1,'N','N',211619,'D',TO_DATE('2014-08-06 01:21:21','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 6, 2014 1:21:22 AM ICT
UPDATE AD_Field SET SeqNo=200, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1264
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=210, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3666
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=220, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10088
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=230, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10091
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=240, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10090
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=250, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12615
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=260, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12614
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=270, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12616
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=280, DisplayLogic='@Action@=C | @Action@=W | @Action@=X | @Action@=B | @Action@=I', AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8761
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=290, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1269
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=300, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1268
;

-- Aug 6, 2014 1:21:23 AM ICT
UPDATE AD_Field SET SeqNo=310, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8766
;

-- Aug 6, 2014 1:21:24 AM ICT
UPDATE AD_Field SET SeqNo=320, AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2578
;

-- Aug 6, 2014 1:21:24 AM ICT
UPDATE AD_Field SET DisplayLogic='@Action@=C | @Action@=W | @Action@=X | @Action@=B | @Action@=I', AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10920
;

-- Aug 6, 2014 1:21:24 AM ICT
UPDATE AD_Field SET DisplayLogic='@Action@=C | @Action@=W | @Action@=X | @Action@=B | @Action@=I', AD_Org_ID=0, AD_Client_ID=0,Updated=TO_DATE('2014-08-06 01:21:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10921
;
SELECT register_migration_script('201406081604_IDEMPIERE-1926.sql') FROM dual
;
