-- IDEMPIERE-7134 Incremental 2pack using Change log
SELECT register_migration_script('202610062303_IDEMPIERE-7134.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 6, 2026, 11:03:20 PM IST
UPDATE AD_Column SET AD_Reference_ID=16,Updated=TO_TIMESTAMP('2026-10-06 23:03:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200166
;

-- Oct 6, 2026, 11:42:06 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Help,PrintName,EntityType,AD_Element_UU) VALUES (204129,0,0,'Y',TO_TIMESTAMP('2026-10-06 23:42:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-06 23:42:05','YYYY-MM-DD HH24:MI:SS'),100,'IsExportOnlyChangedValue','Only Value Changed','When marked then only column has changed since from time are included in 2pack','Only Value Changed','D','0205d6d9-39e3-4907-a01e-d5ef01235881')
;

-- Oct 6, 2026, 11:42:52 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217663,0,'Only Value Changed','When marked then only column has changed since from time are included in 2pack',50005,'IsExportOnlyChangedValue','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-10-06 23:42:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-06 23:42:52','YYYY-MM-DD HH24:MI:SS'),100,204129,'Y','N','D','N','N','N','Y','9cc2391c-fab9-4797-bbc9-22166e3020fd','Y',0,'N','N','N','N')
;

-- Oct 6, 2026, 11:42:56 PM IST
ALTER TABLE AD_Package_Exp ADD IsExportOnlyChangedValue CHAR(1) DEFAULT 'N' CHECK (IsExportOnlyChangedValue IN ('Y','N')) NOT NULL
;

-- Oct 6, 2026, 11:44:22 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209248,'Only Value Changed','When marked then only column has changed since from time are included in 2pack',50005,217663,'Y',1,95,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-10-06 23:44:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-06 23:44:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b7a856e5-fb85-46ad-afdc-0166f76d5ea9','Y',95,2,2)
;

-- Oct 6, 2026, 11:46:10 PM IST
UPDATE AD_Field SET DisplayLogic='@DateFrom@!''''', SeqNo=85, XPosition=5,Updated=TO_TIMESTAMP('2026-10-06 23:46:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209248
;

