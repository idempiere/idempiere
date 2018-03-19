-- Nov 22, 2013 3:55:16 PM COT
-- IDEMPIERE-325 Complete AD based info window
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,AD_Column_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','Y',151,50,'N','N',897,'N','N','Y',15790,'N','N',1,'9bad0b5e-9dc9-421f-9156-c6ee736f6f46','D','Used in Info Column',200113,0,TO_TIMESTAMP('2013-11-22 15:55:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-11-22 15:55:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Nov 22, 2013 3:58:20 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES (0,'N',200113,14,'N','N',15784,10,'Y',202536,'Y','The Info window is used to search and select records as well as display information relevant to the selection.','D','Info and search/select Window','Info Window','6ca76b42-60e2-42fd-b0da-d1139bcc2dbf','Y','N',100,0,TO_TIMESTAMP('2013-11-22 15:58:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-11-22 15:58:11','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,'N',0,2,1,'N')
;

-- Nov 22, 2013 4:00:15 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Reference_ID,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES (0,'N',200113,10,'N','N',15773,20,'Y',202537,'Y','Column in the Info Window for display and/or selection.  If used for selection, the column cannot be a SQL expression. The SQL clause must be fully qualified based on the FROM clause in the Info Window definition',19,'D','Info Window Column','Info Column','77dbd70f-6abb-4853-8d4d-f500e69d6bf6','Y','N',100,0,TO_TIMESTAMP('2013-11-22 16:00:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-11-22 16:00:07','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,'N',0,2,1,'N')
;

-- Nov 22, 2013 4:01:08 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES (0,'N',200113,10,'N','N',208350,30,'Y',202538,'N','The Column Name indicates the name of a column on a table as defined in the database.','D','Name of the column in the database','DB Column Name','fbf25dc2-a23a-481b-8578-73d6e3ed4fcb','Y','N',100,0,TO_TIMESTAMP('2013-11-22 16:01:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-11-22 16:01:00','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,4,'N',0,2,1,'N')
;

SELECT register_migration_script('201311221611_IDEMPIERE-325.sql') FROM dual
;

