SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 4, 2013 12:00:54 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202614,'af1fda99-5c72-4da1-bed5-710d59ea3e6f',0,'IsDetailBPartner',TO_DATE('2013-10-04 00:00:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Manage Business Partners','Manage Business Partners',TO_DATE('2013-10-04 00:00:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2013 12:01:06 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202615,'d995b2e6-3beb-4b20-8efd-1a021c9c0634',0,'IsDetailProduct',TO_DATE('2013-10-04 00:01:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Manage Products','Manage Products',TO_DATE('2013-10-04 00:01:05','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2013 12:01:59 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202616,'25ffab36-a5f8-46dc-92f3-a4c43a3a4601',0,'BPartnerType',TO_DATE('2013-10-04 00:01:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Business Partner Type','Business Partner Type',TO_DATE('2013-10-04 00:01:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2013 12:02:30 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Reference (AD_Client_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_UU,Created,CreatedBy,Description,EntityType,IsActive,IsOrderByValue,Name,Updated,UpdatedBy,VFormat,ValidationType) VALUES (0,0,200076,'7688770d-a2dd-428b-ac28-efcd8fe24785',TO_DATE('2013-10-04 00:02:30','YYYY-MM-DD HH24:MI:SS'),100,NULL,'D','Y','N','C_ElementValue Account BPartner Type',TO_DATE('2013-10-04 00:02:30','YYYY-MM-DD HH24:MI:SS'),100,NULL,'L')
;

-- Oct 4, 2013 12:02:43 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Org_ID,AD_Ref_List_ID,AD_Ref_List_UU,AD_Reference_ID,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,200165,'261c79ec-c7fd-458e-8823-cac29cf1ec35',200076,TO_DATE('2013-10-04 00:02:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Customer',TO_DATE('2013-10-04 00:02:42','YYYY-MM-DD HH24:MI:SS'),100,'C')
;

-- Oct 4, 2013 12:02:49 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Org_ID,AD_Ref_List_ID,AD_Ref_List_UU,AD_Reference_ID,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,200166,'b0d3a446-cb7d-4b3f-9cd0-37052c4de7f5',200076,TO_DATE('2013-10-04 00:02:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Vendor',TO_DATE('2013-10-04 00:02:48','YYYY-MM-DD HH24:MI:SS'),100,'V')
;

-- Oct 4, 2013 12:02:54 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Org_ID,AD_Ref_List_ID,AD_Ref_List_UU,AD_Reference_ID,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,Value) VALUES (0,0,200167,'5a2e2ea0-9902-4747-9eed-e6d1832544ba',200076,TO_DATE('2013-10-04 00:02:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Employee',TO_DATE('2013-10-04 00:02:53','YYYY-MM-DD HH24:MI:SS'),100,'E')
;

-- Oct 4, 2013 12:03:25 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210873,'25a5098a-b000-4b5f-9432-1a1a893a418e',202614,0,20,188,'IsDetailBPartner',TO_DATE('2013-10-04 00:03:24','YYYY-MM-DD HH24:MI:SS'),100,'N','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Y','Manage Business Partners',0,0,TO_DATE('2013-10-04 00:03:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 4, 2013 12:03:32 AM CEST
-- IDEMPIERE-1148
ALTER TABLE C_ElementValue ADD IsDetailBPartner CHAR(1) DEFAULT 'N' CHECK (IsDetailBPartner IN ('Y','N')) NOT NULL
;

-- Oct 4, 2013 12:03:36 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2013-10-04 00:03:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210873
;

-- Oct 4, 2013 12:04:15 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210874,'1ba4da15-d645-4b35-a7d3-36d073d39ac7',202615,0,20,188,'IsDetailProduct',TO_DATE('2013-10-04 00:03:53','YYYY-MM-DD HH24:MI:SS'),100,'N','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Y','Manage Products',0,0,TO_DATE('2013-10-04 00:03:53','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 4, 2013 12:05:27 AM CEST
-- IDEMPIERE-1148
ALTER TABLE C_ElementValue ADD IsDetailProduct CHAR(1) DEFAULT 'N' CHECK (IsDetailProduct IN ('Y','N')) NOT NULL
;

-- Oct 4, 2013 12:05:57 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210875,'740d84a2-55d7-4ad0-aeca-d0e1f7033e7d',202616,0,17,200076,188,'BPartnerType',TO_DATE('2013-10-04 00:05:56','YYYY-MM-DD HH24:MI:SS'),100,'D',1,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Business Partner Type',0,0,TO_DATE('2013-10-04 00:05:56','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 4, 2013 12:05:58 AM CEST
-- IDEMPIERE-1148
ALTER TABLE C_ElementValue ADD BPartnerType CHAR(1) DEFAULT NULL 
;

-- Oct 4, 2013 12:07:13 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,60657,202520,'c6b1b45a-5d93-4229-8d22-e7a66ce656fa',0,132,2,TO_DATE('2013-10-04 00:07:12','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','C_ElementValue_UU',230,TO_DATE('2013-10-04 00:07:12','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2013 12:07:14 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210873,202521,'c7634155-02a7-473d-9369-4570437b4f26',0,132,2,TO_DATE('2013-10-04 00:07:13','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','Y','Y','N','N','N','N','N','Manage Business Partners',240,TO_DATE('2013-10-04 00:07:13','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Oct 4, 2013 12:07:14 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy,XPosition) VALUES (0,210874,202522,'c5c2fa78-6f69-43ab-8e38-82e875709ea5',0,132,2,TO_DATE('2013-10-04 00:07:14','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','Y','Y','N','N','N','N','N','Manage Products',250,TO_DATE('2013-10-04 00:07:14','YYYY-MM-DD HH24:MI:SS'),100,2)
;

-- Oct 4, 2013 12:07:15 AM CEST
-- IDEMPIERE-1148
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210875,202523,'d5444222-49ed-41fc-aac9-4edb3c04b68c',0,132,2,TO_DATE('2013-10-04 00:07:14','YYYY-MM-DD HH24:MI:SS'),100,1,'D','Y','Y','Y','N','N','N','N','N','Business Partner Type',260,TO_DATE('2013-10-04 00:07:14','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=500
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=501
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=942
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=622
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=623
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2014
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=502
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=503
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=504
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=505
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=506
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=514
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=510
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=507
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=511
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=508
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=620
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=509
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=3049
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=3048
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=2077
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=2076
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=202522
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=202521
;

-- Oct 4, 2013 12:07:27 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=202523
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=500
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202520
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=942
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=622
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=623
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=501
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=2014
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=502
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=503
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=504
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=505
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=506
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=514
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=510
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=507
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=511
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=508
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=620
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=509
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=3049
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=3048
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=2077
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=2076
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=202522
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=202521
;

-- Oct 4, 2013 12:07:33 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=202523
;

-- Oct 4, 2013 12:09:31 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET DisplayLogic='@IsDetailBPartner@=Y',Updated=TO_DATE('2013-10-04 00:09:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202523
;

-- Oct 4, 2013 12:09:50 AM CEST
-- IDEMPIERE-1148
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-10-04 00:09:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202521
;

-- Jan 7, 2015 9:09:16 AM COT
UPDATE AD_Field SET DisplayLogic='@ElementType@=A & @IsSummary@=N',Updated=TO_DATE('2015-01-07 09:09:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202522
;

-- Jan 7, 2015 9:09:23 AM COT
UPDATE AD_Field SET DisplayLogic='@ElementType@=A & @IsSummary@=N',Updated=TO_DATE('2015-01-07 09:09:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202521
;

-- Jan 7, 2015 9:09:29 AM COT
UPDATE AD_Field SET DisplayLogic='@ElementType@=A & @IsSummary@=N & @IsDetailBPartner@=Y',Updated=TO_DATE('2015-01-07 09:09:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202523
;

-- Jan 7, 2015 9:10:10 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, XPosition=2,Updated=TO_DATE('2015-01-07 09:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202521
;

-- Jan 7, 2015 9:10:10 AM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=200, XPosition=4,Updated=TO_DATE('2015-01-07 09:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202523
;

-- Jan 7, 2015 9:10:10 AM COT
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2015-01-07 09:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202522
;

SELECT register_migration_script('201501070858_IDEMPIERE-1148.sql') FROM dual
;
