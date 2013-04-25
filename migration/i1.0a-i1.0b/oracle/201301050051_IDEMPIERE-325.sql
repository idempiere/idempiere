-- Jan 5, 2013 12:28:29 AM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',1,895,208362,'D','N','N','N',0,'N',2000,'N',14,'N',475,'N','Y','373b505f-1b5e-4ea1-9f0c-3d753724c772','Y','OrderByClause','Fully qualified ORDER BY clause','The ORDER BY Clause indicates the SQL ORDER BY clause to use for record selection','Sql ORDER BY','Y',TO_DATE('2013-01-05 00:28:27','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-01-05 00:28:27','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 5, 2013 12:29:22 AM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (5,1,0,'N',842,0,'N','N',208362,150,'Y',201634,'N','The ORDER BY Clause indicates the SQL ORDER BY clause to use for record selection','D','Fully qualified ORDER BY clause','Sql ORDER BY','Y','N','efcf0c8a-9b23-48fd-b131-8fa963c146d6',100,0,TO_DATE('2013-01-05 00:29:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-05 00:29:21','YYYY-MM-DD HH24:MI:SS'),'Y','N',80,1,'N')
;

-- Jan 5, 2013 12:29:33 AM MYT
-- IDEMPIERE-325 AD_InfoWindow
ALTER TABLE AD_InfoWindow ADD OrderByClause NVARCHAR2(2000) DEFAULT NULL 
;

-- Jan 5, 2013 12:30:28 AM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET NumLines=3, SeqNo=110, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-01-05 00:30:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201634
;

-- Jan 5, 2013 12:30:28 AM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2013-01-05 00:30:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13579
;

-- Jan 5, 2013 12:30:28 AM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2013-01-05 00:30:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13580
;

-- Jan 5, 2013 12:30:28 AM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2013-01-05 00:30:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201627
;

-- Jan 5, 2013 12:30:28 AM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2013-01-05 00:30:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201628
;

SELECT register_migration_script('201301050051_IDEMPIERE-325.sql') FROM dual
;

