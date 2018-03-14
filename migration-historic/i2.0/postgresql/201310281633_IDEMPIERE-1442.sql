-- Oct 28, 2013 3:46:50 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,EntityType,AD_Client_ID) VALUES ('IsConfirmOnDocClose',202625,'Show Confirmation On Document Action Close','Show Confirmation On Document Action Close','07759de2-051e-475c-a759-ba56d873a3f5',TO_TIMESTAMP('2013-10-28 15:46:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-10-28 15:46:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y','D',0)
;

-- Oct 28, 2013 3:47:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2013-10-28 15:47:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202625
;

-- Oct 28, 2013 3:49:11 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,EntityType,IsEncrypted,AD_Element_ID,AD_Client_ID,IsSecure) VALUES (0,'N',0,227,210885,'Y','N','N',0,'N',1,'N',20,'N','N','Y','054c9c50-c749-4b1c-b2f2-a11caa286680','Y','IsConfirmOnDocClose','N','Show Confirmation On Document Action Close','Y',100,TO_TIMESTAMP('2013-10-28 15:49:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-10-28 15:49:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N','D','N',202625,0,'N')
;

-- Oct 28, 2013 3:52:28 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,EntityType,AD_Client_ID) VALUES ('IsConfirmOnDocVoid',202626,'Show Confirmation On Document Action Void','Show Confirmation On Document Action Void','900e165f-ba3c-4076-a783-03463df95926',TO_TIMESTAMP('2013-10-28 15:52:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-10-28 15:52:27','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y','D',0)
;

-- Oct 28, 2013 3:52:48 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,EntityType,IsEncrypted,AD_Element_ID,AD_Client_ID,IsSecure) VALUES (0,'N',0,227,210886,'Y','N','N',0,'N',1,'N',20,'N','N','Y','501a66d4-cbd4-4494-b9e6-8676eb82190a','Y','IsConfirmOnDocVoid','N','Show Confirmation On Document Action Void','Y',100,TO_TIMESTAMP('2013-10-28 15:52:48','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-10-28 15:52:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N','D','N',202626,0,'N')
;

-- Oct 28, 2013 3:52:54 PM IST
-- Adding Flag to show Confirmation before processing Document
ALTER TABLE AD_ClientInfo ADD COLUMN IsConfirmOnDocClose CHAR(1) DEFAULT 'N' CHECK (IsConfirmOnDocClose IN ('Y','N')) NOT NULL
;

-- Oct 28, 2013 3:53:01 PM IST
-- Adding Flag to show Confirmation before processing Document
ALTER TABLE AD_ClientInfo ADD COLUMN IsConfirmOnDocVoid CHAR(1) DEFAULT 'N' CHECK (IsConfirmOnDocVoid IN ('Y','N')) NOT NULL
;

-- Oct 28, 2013 3:53:43 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,IsAdvancedField) VALUES (1,1,'N',0,'N',169,0,'N','N',210885,240,'Y',202532,'N','D','Show Confirmation On Document Action Close','N','Y','b2a62073-1371-4032-9748-95406043bc31',100,0,TO_TIMESTAMP('2013-10-28 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-28 15:53:42','YYYY-MM-DD HH24:MI:SS'),'Y','Y',340,1,0,'N')
;

-- Oct 28, 2013 3:54:08 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,IsAdvancedField) VALUES (1,1,'N',0,'N',169,0,'N','N',210886,250,'Y',202533,'N','D','Show Confirmation On Document Action Void','N','Y','0d721644-85dd-4192-bfdf-7ebbc5427730',100,0,TO_TIMESTAMP('2013-10-28 15:54:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-28 15:54:07','YYYY-MM-DD HH24:MI:SS'),'Y','Y',350,1,0,'N')
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET ColumnSpan=2, SeqNo=110, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202532
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET ColumnSpan=2, SeqNo=130, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202533
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1564
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1563
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1562
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1565
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1566
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1567
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10319
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10320
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57531
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57534
;

-- Oct 28, 2013 4:01:28 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2013-10-28 16:01:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57535
;

-- Oct 28, 2013 4:04:23 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Do you want to {0} this Document?',200237,'D','4d6b274c-1089-4083-abfd-bd5985c4cd2f','ConfirmOnDocAction','Y',TO_TIMESTAMP('2013-10-28 16:04:22','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-10-28 16:04:22','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Oct 28, 2013 4:06:27 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2013-10-28 16:06:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202626
;

-- Oct 28, 2013 4:06:37 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2013-10-28 16:06:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210886
;

-- Oct 28, 2013 4:06:47 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2013-10-28 16:06:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210885
;

-- Oct 28, 2013 4:06:52 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO t_alter_column values('ad_clientinfo','IsConfirmOnDocClose','CHAR(1)',null,'N')
;

-- Oct 28, 2013 4:06:53 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_ClientInfo SET IsConfirmOnDocClose='N' WHERE IsConfirmOnDocClose IS NULL
;

-- Oct 28, 2013 4:07:03 PM IST
-- Adding Flag to show Confirmation before processing Document
INSERT INTO t_alter_column values('ad_clientinfo','IsConfirmOnDocVoid','CHAR(1)',null,'N')
;

-- Oct 28, 2013 4:07:03 PM IST
-- Adding Flag to show Confirmation before processing Document
UPDATE AD_ClientInfo SET IsConfirmOnDocVoid='N' WHERE IsConfirmOnDocVoid IS NULL
;

SELECT register_migration_script('201310281633_IDEMPIERE-1442.sql') FROM dual
;