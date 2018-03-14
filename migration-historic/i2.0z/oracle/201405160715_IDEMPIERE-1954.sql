SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 16, 2014 1:53:34 PM MYT
-- IDEMPIERE-1954 Implement MaxQueryRecords for AD_InfoWindow
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Table_ID) VALUES (0,'N',1,211240,'Y','N','N',0,'N',10,'N',11,'N','N','Y','8266be38-9b40-4d93-99cb-81cbe10035b5','Y','MaxQueryRecords','If defined, you cannot query more records as defined - the query criteria needs to be changed to query less records','0','Enter the number of records a user will be able to query to avoid unnecessary system load.  If 0, no restrictions are imposed.','Max Query Records','Y',TO_DATE('2014-05-16 13:53:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-05-16 13:53:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N',2854,895)
;

-- May 16, 2014 1:54:51 PM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,EntityType,Created) VALUES (0,'N',842,0,'N','N',211240,180,'Y',203024,'N','Enter the number of records a user will be able to query to avoid unnecessary system load.  If 0, no restrictions are imposed.','If defined, you cannot query more records as defined - the query criteria needs to be changed to query less records','Max Query Records','ad1bced3-2965-45be-8982-fd64639b6863','Y','N',100,0,100,TO_DATE('2014-05-16 13:54:50','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,2,'N',0,2,1,'N','N','D',TO_DATE('2014-05-16 13:54:50','YYYY-MM-DD HH24:MI:SS'))
;

-- May 16, 2014 1:55:27 PM MYT
UPDATE AD_Field SET XPosition=1,Updated=TO_DATE('2014-05-16 13:55:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203024
;

-- May 16, 2014 2:16:23 PM MYT
-- IDEMPIERE-1954 Implement MaxQueryRecords for AD_InfoWindow
ALTER TABLE AD_InfoWindow ADD MaxQueryRecords NUMBER(10) DEFAULT 0 NOT NULL
;

-- May 16, 2014 3:01:57 PM MYT
-- IDEMPIERE-1954 Implement MaxQueryRecords for AD_InfoWindow
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Your search returned more than the maximum number of results allowed.<br>Please narrow down your search criteria and try your search again.',200274,'D','62341bf3-576c-4c9a-9cd3-4cb88b9bb989','InfoFindOverMax','Y',TO_DATE('2014-05-16 15:01:56','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2014-05-16 15:01:56','YYYY-MM-DD HH24:MI:SS'))
;

SELECT register_migration_script('201405160715_IDEMPIERE-1954.sql') FROM dual
;

