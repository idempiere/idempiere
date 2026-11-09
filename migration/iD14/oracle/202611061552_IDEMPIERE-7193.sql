-- IDEMPIERE-7193
SELECT register_migration_script('202611061552_IDEMPIERE-7193.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 6, 2026, 3:52:24 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217673,0,'Sql WHERE','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".',200266,'WhereClause',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2026-11-06 15:52:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-06 15:52:24','YYYY-MM-DD HH24:MI:SS'),10,630,'Y','N','D','N','N','N','Y','01a1b158-b954-74d6-9f2e-f2a406b7ce31','Y',0,'N','N','N','N')
;

-- Nov 6, 2026, 3:52:31 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217674,0,'Other SQL Clause','Other SQL Clause','Any other complete clause like GROUP BY, HAVING, ORDER BY, etc. after WHERE clause.',200266,'OtherClause',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2026-11-06 15:52:31','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-06 15:52:31','YYYY-MM-DD HH24:MI:SS'),10,2642,'Y','N','D','N','N','N','Y','01a1b158-d52f-739b-b330-ff41d23dfca8','Y',0,'N','N','N','N')
;

-- Nov 6, 2026, 3:52:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217675,0,'Sql ORDER BY','Fully qualified ORDER BY clause','The ORDER BY Clause indicates the SQL ORDER BY clause to use for record selection',200266,'OrderByClause',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2026-11-06 15:52:38','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-06 15:52:38','YYYY-MM-DD HH24:MI:SS'),10,475,'Y','N','D','N','N','N','Y','01a1b158-efe3-719c-a17b-f6569e7a1f2b','Y',0,'N','N','N','N')
;

-- Nov 6, 2026, 3:52:39 PM CET
ALTER TABLE AD_UserDef_Info ADD WhereClause VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Nov 6, 2026, 3:52:39 PM CET
ALTER TABLE AD_UserDef_Info ADD OtherClause VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Nov 6, 2026, 3:52:39 PM CET
ALTER TABLE AD_UserDef_Info ADD OrderByClause VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Nov 6, 2026, 3:52:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (209257,'Sql WHERE','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".',200280,217673,'Y',2000,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-11-06 15:52:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-06 15:52:50','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','01a1b159-2098-72c7-909d-5455535a5ce9','Y',190,5,3)
;

-- Nov 6, 2026, 3:52:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (209258,'Other SQL Clause','Other SQL Clause','Any other complete clause like GROUP BY, HAVING, ORDER BY, etc. after WHERE clause.',200280,217674,'Y',2000,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-11-06 15:52:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-06 15:52:50','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','01a1b159-21a1-7e1a-b4b1-81d61743d73f','Y',200,5,3)
;

-- Nov 6, 2026, 3:52:51 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209259,'Sql ORDER BY','Fully qualified ORDER BY clause','The ORDER BY Clause indicates the SQL ORDER BY clause to use for record selection',200280,217675,'Y',2000,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-11-06 15:52:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-06 15:52:50','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','01a1b159-228f-79a4-b07e-892b16f3594b','Y',210,5)
;

-- Nov 6, 2026, 4:21:06 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217676,0,'Sql SELECT','SQL SELECT clause','The Select Clause indicates the SQL SELECT clause to use for selecting the record for a measure calculation. Do not include the SELECT itself.',200268,'SelectClause',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2026-11-06 16:21:06','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-06 16:21:06','YYYY-MM-DD HH24:MI:SS'),10,1599,'Y','N','D','N','N','N','Y','01a1b173-0018-7ed3-bf57-b6f6a027772e','Y',0,'N','N','N','N')
;

-- Nov 6, 2026, 4:21:09 PM CET
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2026-11-06 16:21:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217676
;

-- Nov 6, 2026, 4:21:10 PM CET
ALTER TABLE AD_UserDef_Info_Column ADD SelectClause VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Nov 6, 2026, 4:21:21 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (209260,'Sql SELECT','SQL SELECT clause','The Select Clause indicates the SQL SELECT clause to use for selecting the record for a measure calculation. Do not include the SELECT itself.',200279,217676,'Y',2000,270,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-11-06 16:21:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-11-06 16:21:21','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','01a1b173-3d38-74c7-bb95-a508517c4fed','Y',260,5,3)
;

-- Nov 6, 2026, 4:21:48 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=200, AD_FieldGroup_ID=200004, XPosition=1, NumLines=1,Updated=TO_TIMESTAMP('2026-11-06 16:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209260
;

-- Nov 6, 2026, 4:21:48 PM CET
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-11-06 16:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206445
;

-- Nov 6, 2026, 4:21:48 PM CET
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-11-06 16:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206448
;

-- Nov 6, 2026, 4:21:48 PM CET
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-11-06 16:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206447
;

-- Nov 6, 2026, 4:21:48 PM CET
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2026-11-06 16:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206453
;

-- Nov 6, 2026, 4:21:48 PM CET
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2026-11-06 16:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206452
;

-- Nov 6, 2026, 4:21:48 PM CET
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2026-11-06 16:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206469
;

-- Nov 6, 2026, 4:21:48 PM CET
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2026-11-06 16:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206466
;

-- Nov 6, 2026, 4:35:01 PM CET
UPDATE AD_Process SET ShowHelp='S',Updated=TO_TIMESTAMP('2026-11-06 16:35:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_ID=349
;

-- Nov 9, 2026, 9:15:31 AM CET
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_TIMESTAMP('2026-11-09 09:15:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209257
;

-- Nov 9, 2026, 9:15:35 AM CET
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_TIMESTAMP('2026-11-09 09:15:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209258
;

-- Nov 9, 2026, 9:15:40 AM CET
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_TIMESTAMP('2026-11-09 09:15:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209259
;
