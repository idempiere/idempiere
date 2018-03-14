-- Mar 20, 2014 2:05:38 PM CET
-- IDEMPIERE-1828
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202671,'b640b542-2f7a-4885-a212-5c60138d9480',0,'EMailFrom',TO_TIMESTAMP('2014-03-20 14:05:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','EMail sent from','EMail sent from',TO_TIMESTAMP('2014-03-20 14:05:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:06:01 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202672,'9c423548-1e6b-4899-a179-1304f30adeff',0,'RecipientTo',TO_TIMESTAMP('2014-03-20 14:06:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','To','To',TO_TIMESTAMP('2014-03-20 14:06:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:06:08 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202673,'6bc347b6-83fd-49e5-b34f-949f7e480baf',0,'RecipientCc',TO_TIMESTAMP('2014-03-20 14:06:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Cc','Cc',TO_TIMESTAMP('2014-03-20 14:06:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:06:18 PM CET
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202674,'e79d13ad-54af-4384-9b11-dc86abd1db21',0,'RecipientBcc',TO_TIMESTAMP('2014-03-20 14:06:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Bcc','Bcc',TO_TIMESTAMP('2014-03-20 14:06:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:06:26 PM CET
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2014-03-20 14:06:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202673
;

-- Mar 20, 2014 2:08:07 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210985,'63925720-89dc-4245-86e6-770564e34147',202671,0,10,782,'EMailFrom',TO_TIMESTAMP('2014-03-20 14:08:07','YYYY-MM-DD HH24:MI:SS'),100,'D','N',255,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','EMail sent from',0,0,TO_TIMESTAMP('2014-03-20 14:08:07','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 20, 2014 2:08:13 PM CET
ALTER TABLE AD_UserMail ADD COLUMN EMailFrom VARCHAR(255) DEFAULT NULL 
;

-- Mar 20, 2014 2:08:46 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210986,'6dd996b8-5e29-4bef-89b3-694bd8c1c9d6',202674,0,10,782,'RecipientBcc',TO_TIMESTAMP('2014-03-20 14:08:45','YYYY-MM-DD HH24:MI:SS'),100,'D','N',2000,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Bcc',0,0,TO_TIMESTAMP('2014-03-20 14:08:45','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 20, 2014 2:08:49 PM CET
ALTER TABLE AD_UserMail ADD COLUMN RecipientBcc VARCHAR(2000) DEFAULT NULL 
;

-- Mar 20, 2014 2:09:05 PM CET
UPDATE AD_Column SET AD_Element_ID=202673, ColumnName='RecipientCc', Description=NULL, Help=NULL, Name='Cc',Updated=TO_TIMESTAMP('2014-03-20 14:09:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210986
;

-- Mar 20, 2014 2:09:08 PM CET
ALTER TABLE AD_UserMail ADD COLUMN RecipientCc VARCHAR(2000) DEFAULT NULL 
;

-- Mar 20, 2014 2:09:23 PM CET
UPDATE AD_Column SET AD_Element_ID=202672, ColumnName='RecipientTo', Description=NULL, EntityType='D', Help=NULL, Name='To',Updated=TO_TIMESTAMP('2014-03-20 14:09:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210986
;

-- Mar 20, 2014 2:09:26 PM CET
ALTER TABLE AD_UserMail ADD COLUMN RecipientTo VARCHAR(2000) DEFAULT NULL 
;

-- Mar 20, 2014 2:10:39 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210987,'b9fd6d34-671a-46cd-8abc-589c0eb256d5',202673,0,10,782,'RecipientCc',TO_TIMESTAMP('2014-03-20 14:10:38','YYYY-MM-DD HH24:MI:SS'),100,'D','N',2000,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Cc',0,0,TO_TIMESTAMP('2014-03-20 14:10:38','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 20, 2014 2:10:41 PM CET
INSERT INTO t_alter_column values('ad_usermail','RecipientCc','VARCHAR(2000)',null,'NULL')
;

-- Mar 20, 2014 2:10:57 PM CET
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FKConstraintType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210988,'c9bb532c-3509-4791-a023-55fd661e348c',202674,0,10,782,'RecipientBcc',TO_TIMESTAMP('2014-03-20 14:10:56','YYYY-MM-DD HH24:MI:SS'),100,'D','N',2000,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Bcc',0,0,TO_TIMESTAMP('2014-03-20 14:10:56','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Mar 20, 2014 2:11:00 PM CET
INSERT INTO t_alter_column values('ad_usermail','RecipientBcc','VARCHAR(2000)',null,'NULL')
;

-- Mar 20, 2014 2:12:54 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,60533,202691,'76d0d102-0b78-44e9-a041-b38747b69ef0',0,709,2,TO_TIMESTAMP('2014-03-20 14:12:54','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','AD_UserMail_UU',120,TO_TIMESTAMP('2014-03-20 14:12:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:12:55 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210985,202692,'dd367b6d-eb5e-44ab-a317-9b73987f4b60',0,709,5,TO_TIMESTAMP('2014-03-20 14:12:55','YYYY-MM-DD HH24:MI:SS'),100,255,'D','Y','Y','Y','N','N','N','N','N','EMail sent from',130,TO_TIMESTAMP('2014-03-20 14:12:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:12:56 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210986,202693,'3aeedc4a-4272-412d-a971-2dc6e0fd7fd1',0,709,5,TO_TIMESTAMP('2014-03-20 14:12:55','YYYY-MM-DD HH24:MI:SS'),100,2000,'D','Y','Y','Y','N','N','N','N','N','To',140,TO_TIMESTAMP('2014-03-20 14:12:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:12:56 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210987,202694,'70bae5b3-9321-44b9-b645-a3d1533d50c0',0,709,5,TO_TIMESTAMP('2014-03-20 14:12:56','YYYY-MM-DD HH24:MI:SS'),100,2000,'D','Y','Y','Y','N','N','N','N','N','Cc',150,TO_TIMESTAMP('2014-03-20 14:12:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:12:57 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210988,202695,'e41d0273-fcb0-4784-a83b-ca1177532058',0,709,5,TO_TIMESTAMP('2014-03-20 14:12:56','YYYY-MM-DD HH24:MI:SS'),100,2000,'D','Y','Y','Y','N','N','N','N','N','Bcc',160,TO_TIMESTAMP('2014-03-20 14:12:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:13:40 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=1,Updated=TO_TIMESTAMP('2014-03-20 14:13:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202692
;

-- Mar 20, 2014 2:13:40 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1,Updated=TO_TIMESTAMP('2014-03-20 14:13:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202693
;

-- Mar 20, 2014 2:13:40 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=1,Updated=TO_TIMESTAMP('2014-03-20 14:13:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202694
;

-- Mar 20, 2014 2:13:41 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=1,Updated=TO_TIMESTAMP('2014-03-20 14:13:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202695
;

-- Mar 20, 2014 2:13:41 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2014-03-20 14:13:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12359
;

-- Mar 20, 2014 2:13:41 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2014-03-20 14:13:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12358
;

-- Mar 20, 2014 2:13:41 PM CET
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2014-03-20 14:13:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11542
;

-- Mar 20, 2014 2:13:41 PM CET
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2014-03-20 14:13:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11541
;

-- Mar 20, 2014 2:13:41 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-20 14:13:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202691
;

-- Mar 20, 2014 2:14:13 PM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202692
;

-- Mar 20, 2014 2:14:13 PM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202693
;

-- Mar 20, 2014 2:14:13 PM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=202694
;

-- Mar 20, 2014 2:14:13 PM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=202695
;

-- Mar 20, 2014 2:14:13 PM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=12359
;

-- Mar 20, 2014 2:14:13 PM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=12358
;

-- Mar 20, 2014 2:14:13 PM CET
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=11542
;

-- Mar 20, 2014 2:14:13 PM CET
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=11541
;

-- Mar 20, 2014 2:14:59 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,60533,202696,'ec3f809c-2519-4d75-b1c8-5e553f7fec10',0,53283,2,TO_TIMESTAMP('2014-03-20 14:14:58','YYYY-MM-DD HH24:MI:SS'),100,36,'D','Y','Y','N','N','N','N','N','N','N','AD_UserMail_UU',120,TO_TIMESTAMP('2014-03-20 14:14:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:14:59 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210985,202697,'6596a658-1014-4f79-8420-099870dfd854',0,53283,5,TO_TIMESTAMP('2014-03-20 14:14:59','YYYY-MM-DD HH24:MI:SS'),100,255,'D','Y','Y','Y','N','N','N','N','N','EMail sent from',130,TO_TIMESTAMP('2014-03-20 14:14:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:15:00 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210986,202698,'120d8134-50a7-4fa8-ab29-7a23f6f324e9',0,53283,5,TO_TIMESTAMP('2014-03-20 14:14:59','YYYY-MM-DD HH24:MI:SS'),100,2000,'D','Y','Y','Y','N','N','N','N','N','To',140,TO_TIMESTAMP('2014-03-20 14:14:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:15:00 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210987,202699,'48af28b6-9a61-4655-addd-9479206028ae',0,53283,5,TO_TIMESTAMP('2014-03-20 14:15:00','YYYY-MM-DD HH24:MI:SS'),100,2000,'D','Y','Y','Y','N','N','N','N','N','Cc',150,TO_TIMESTAMP('2014-03-20 14:15:00','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:15:01 PM CET
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210988,202700,'1c8c16bf-f451-453e-9a85-1b8651733ddf',0,53283,5,TO_TIMESTAMP('2014-03-20 14:15:00','YYYY-MM-DD HH24:MI:SS'),100,2000,'D','Y','Y','Y','N','N','N','N','N','Bcc',160,TO_TIMESTAMP('2014-03-20 14:15:00','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=1,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202697
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202698
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=1,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202699
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=1,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202700
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58024
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58025
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58026
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58027
;

-- Mar 20, 2014 2:15:55 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2014-03-20 14:15:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202696
;

-- Mar 20, 2014 2:16:28 PM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202697
;

-- Mar 20, 2014 2:16:28 PM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202698
;

-- Mar 20, 2014 2:16:28 PM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=202699
;

-- Mar 20, 2014 2:16:28 PM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=202700
;

-- Mar 20, 2014 2:16:28 PM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=58024
;

-- Mar 20, 2014 2:16:28 PM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=58025
;

-- Mar 20, 2014 2:16:28 PM CET
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=58026
;

-- Mar 20, 2014 2:16:28 PM CET
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=58027
;

SELECT register_migration_script('201403201438_IDEMPIERE-1828.sql') FROM dual
;
