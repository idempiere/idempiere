-- IDEMPIERE-5346 SSO Support
SELECT register_migration_script('202303281510_IDEMPIERE-5346.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 28, 2023, 3:10:00 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203798,0,0,'Y',TO_TIMESTAMP('2023-03-28 15:09:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-28 15:09:59','YYYY-MM-DD HH24:MI:SS'),100,'AuthenticationType','Authentication Type','Authentication Type','D','b1c28755-ae35-4567-8912-c1a91e98bca4')
;

-- Mar 28, 2023, 3:10:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215808,0,'Authentication Type',114,'AuthenticationType',10,'N','N','N','N','N',0,'N',17,0,0,'Y',TO_TIMESTAMP('2023-03-28 15:10:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-28 15:10:30','YYYY-MM-DD HH24:MI:SS'),100,203798,'Y','N','D','N','N','N','Y','b887af64-55cf-48f0-91e2-48b57c228c81','Y',0,'N','N','N','N')
;

-- Mar 28, 2023, 3:11:05 PM IST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200239,'Authentication Type List','L',0,0,'Y',TO_TIMESTAMP('2023-03-28 15:11:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-28 15:11:04','YYYY-MM-DD HH24:MI:SS'),100,'D','N','8bf2b11e-71f7-4b40-b4fb-4b6dfd7d767e')
;

-- Mar 28, 2023, 3:13:37 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200632,'SSO Only',200239,'SSO',0,0,'Y',TO_TIMESTAMP('2023-03-28 15:13:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-28 15:13:36','YYYY-MM-DD HH24:MI:SS'),100,'D','d726bc83-5d69-4082-b224-e0803b5c234d')
;

-- Mar 28, 2023, 3:14:19 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200633,'Application Only',200239,'APO',0,0,'Y',TO_TIMESTAMP('2023-03-28 15:14:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-28 15:14:18','YYYY-MM-DD HH24:MI:SS'),100,'D','32f2269c-8c71-40f1-a128-d6f805030a69')
;

-- Mar 28, 2023, 3:16:08 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200634,'Application and SSO',200239,'AAS',0,0,'Y',TO_TIMESTAMP('2023-03-28 15:16:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-28 15:16:08','YYYY-MM-DD HH24:MI:SS'),100,'D','7cd3af94-1e49-4d9f-9e33-dbdc0dfce7bb')
;

-- Mar 28, 2023, 3:16:21 PM IST
UPDATE AD_Column SET AD_Reference_Value_ID=200239,Updated=TO_TIMESTAMP('2023-03-28 15:16:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215808
;

-- Mar 28, 2023, 3:16:23 PM IST
ALTER TABLE AD_User ADD AuthenticationType VARCHAR2(10 CHAR) DEFAULT NULL 
;

-- Mar 28, 2023, 3:41:55 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207598,'Authentication Type',118,215808,'Y',10,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-28 15:41:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-28 15:41:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','65779dd6-818c-40f4-9f73-eda819697164','Y',440,2)
;

-- May 22, 2023, 1:50:43 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215840,0,'Authentication Type',112,'AuthenticationType',10,'N','N','N','N','N',0,'N',17,200239,0,0,'Y',TO_TIMESTAMP('2023-05-22 13:50:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-22 13:50:42','YYYY-MM-DD HH24:MI:SS'),100,203798,'Y','N','D','N','N','N','Y','33738ece-b095-44eb-a032-5564d47a04ca','Y',0,'N','N','N','N')
;

-- May 22, 2023, 1:53:39 PM IST
ALTER TABLE AD_Client ADD AuthenticationType VARCHAR2(10 CHAR) DEFAULT NULL 
;

-- May 22, 2023, 2:49:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207626,'Authentication Type',145,215840,'Y',0,240,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-05-22 14:49:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-22 14:49:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1fbf8620-b944-4be9-b60f-f9bf4fcff4c8','Y',280,2,2,1,'N','N','N','N')
;

-- May 22, 2023, 2:49:38 PM IST
UPDATE AD_Field SET SeqNo=240, XPosition=1,Updated=TO_TIMESTAMP('2023-05-22 14:49:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207626
;

