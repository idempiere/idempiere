-- IDEMPIERE-6188 Read-Only Session
SELECT register_migration_script('202407061229_IDEMPIERE-6188.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 6, 2024, 12:29:56 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203938,0,0,'Y',TO_TIMESTAMP('2024-07-06 12:29:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-06 12:29:42','YYYY-MM-DD HH24:MI:SS'),100,'IsReadOnlySession','Read Only Session',NULL,NULL,'Read Only Session','D','6ee179e4-9573-4a3d-8815-23723ef241d7')
;

-- Jul 6, 2024, 12:30:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216614,0,'Read Only Session',200174,'IsReadOnlySession','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2024-07-06 12:30:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-06 12:30:18','YYYY-MM-DD HH24:MI:SS'),100,203938,'Y','N','D','N','N','N','Y','8c255baa-fbec-4a90-a43d-5461060368e9','Y',0,'N','N','N','N')
;

-- Jul 6, 2024, 12:30:29 PM CEST
ALTER TABLE AD_UserPreference ADD IsReadOnlySession CHAR(1) DEFAULT 'N' CHECK (IsReadOnlySession IN ('Y','N')) NOT NULL
;

-- Jul 6, 2024, 12:30:45 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208494,'Read Only Session',200189,216614,'Y',1,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-07-06 12:30:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-06 12:30:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f69131e7-4fca-4011-89d5-650ca506c920','Y',170,2,2)
;

-- Jul 6, 2024, 12:31:06 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2024-07-06 12:31:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206133
;

-- Jul 6, 2024, 12:31:06 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2024-07-06 12:31:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206134
;

-- Jul 6, 2024, 12:31:06 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2024-07-06 12:31:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206407
;

-- Jul 6, 2024, 12:31:06 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2024-07-06 12:31:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208189
;

-- Jul 6, 2024, 12:31:06 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=5,Updated=TO_TIMESTAMP('2024-07-06 12:31:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208494
;

-- Jul 6, 2024, 12:31:25 PM CEST
UPDATE AD_Field SET IsQuickEntry='Y',Updated=TO_TIMESTAMP('2024-07-06 12:31:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208494
;

-- Jul 9, 2024, 7:48:40 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Read-only session',0,0,'Y',TO_TIMESTAMP('2024-07-09 19:48:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-07-09 19:48:39','YYYY-MM-DD HH24:MI:SS'),100,200900,'ReadOnlySession','D','dc819f55-662d-4d30-b68d-0a93b46a8458')
;

