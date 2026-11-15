-- IDEMPIERE-7167
SELECT register_migration_script('202610270950_IDEMPIERE-7167.sql') FROM dual;

-- Oct 27, 2026, 9:50:00 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217671,0,'Sql FROM','SQL FROM clause','The Select Clause indicates the SQL FROM clause to use for selecting the record for a measure calculation. It can have JOIN clauses. Do not include the FROM itself.',200266,'FromClause',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2026-10-27 09:50:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-27 09:50:00','YYYY-MM-DD HH24:MI:SS'),100,2101,'Y','N','D','N','N','N','Y','01a17c8d-58e4-7e37-87a6-087cad295e9b','Y',0,'N','N','N','N')
;

-- Oct 27, 2026, 9:50:02 AM CET
ALTER TABLE AD_UserDef_Info ADD COLUMN FromClause VARCHAR(2000) DEFAULT NULL 
;

-- Oct 27, 2026, 9:50:12 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (209255,'Sql FROM','SQL FROM clause','The Select Clause indicates the SQL FROM clause to use for selecting the record for a measure calculation. It can have JOIN clauses. Do not include the FROM itself.',200280,217671,'Y',2000,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-10-27 09:50:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-27 09:50:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a17c8d-8964-7250-98d5-9b76c2772ab8','Y',180,5,3)
;

-- Oct 27, 2026, 10:51:02 AM CET
UPDATE AD_Process SET AccessLevel='6',Updated=TO_TIMESTAMP('2026-10-27 10:51:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_ID=349
;

-- Oct 27, 2026, 10:51:31 AM CET
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2026-10-27 10:51:31','YYYY-MM-DD HH24:MI:SS'),10,'AD_InfoWindow_Validate','Y',200141,'AD_InfoWindow_Validate',TO_TIMESTAMP('2026-10-27 10:51:31','YYYY-MM-DD HH24:MI:SS'),10,'N','01a17cc5-aaa8-790d-b3c3-bfa288430f24','W',200280,349,10,'D')
;
