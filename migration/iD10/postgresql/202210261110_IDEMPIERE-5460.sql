-- IDEMPIERE-5460
SELECT register_migration_script('202210261110_IDEMPIERE-5460.sql') FROM dual;

-- Oct 26, 2022, 11:10:42 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207405,'Report Type',663,211830,'Y',0,130,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-26 11:10:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 11:10:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','93d34f06-05a8-469a-a012-b0f61763dd58','Y',130,1,1,1,'N','N','N','N')
;

-- Oct 26, 2022, 11:11:13 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207406,'Print Format','Data Print Format','The print format determines how data is rendered for print.',663,211834,'Y',0,140,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-26 11:11:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 11:11:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b7932bde-bef5-4233-8135-e82add84805d','Y',140,1,1,1,'N','N','N','N')
;

-- Oct 26, 2022, 11:11:32 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207407,'Language ID',663,211868,'Y',0,150,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-26 11:11:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 11:11:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01b827e1-545d-4fa7-a9c3-070e1e9af97d','Y',150,1,1,1,'N','N','N','N')
;

-- Oct 26, 2022, 11:12:29 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207408,'Summary Level','This is a summary entity','A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.',663,211837,'Y',0,160,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-10-26 11:12:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 11:12:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','00fa8185-63ee-4f49-914d-0d18ed342cc9','Y',160,1,1,1,'N','N','N','N')
;

-- Oct 26, 2022, 11:13:49 AM CEST
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,EntityType,FieldGroupType,IsCollapsedByDefault,AD_FieldGroup_UU) VALUES (200030,0,0,'Y',TO_TIMESTAMP('2022-10-26 11:13:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-26 11:13:49','YYYY-MM-DD HH24:MI:SS'),100,'Printing','D','C','N','1f19e42f-dfb1-4375-b8ff-783947b37944')
;

-- Oct 26, 2022, 11:15:00 AM CEST
UPDATE AD_Field SET SeqNo=130, AD_FieldGroup_ID=200030, ColumnSpan=2,Updated=TO_TIMESTAMP('2022-10-26 11:15:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207405
;

-- Oct 26, 2022, 11:15:00 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2022-10-26 11:15:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207407
;

-- Oct 26, 2022, 11:15:00 AM CEST
UPDATE AD_Field SET SeqNo=150, ColumnSpan=2,Updated=TO_TIMESTAMP('2022-10-26 11:15:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207406
;

-- Oct 26, 2022, 11:15:00 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, XPosition=5,Updated=TO_TIMESTAMP('2022-10-26 11:15:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207408
;

