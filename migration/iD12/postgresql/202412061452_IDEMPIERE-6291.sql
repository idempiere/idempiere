-- IDEMPIERE-6291
SELECT register_migration_script('202412061452_IDEMPIERE-6291.sql') FROM dual;

-- Dec 6, 2024, 2:52:05 PM WIB
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216926,0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',53295,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2024-12-06 14:52:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-06 14:52:04','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','N','N','Y','fdac9c69-19e9-4edd-9591-a44eeef08f0d','Y',0,'N','N','N','N')
;

-- Dec 6, 2024, 2:52:08 PM WIB
ALTER TABLE PA_DashboardContent_Trl ADD COLUMN Help VARCHAR(2000) DEFAULT NULL 
;

-- Dec 6, 2024, 2:52:30 PM WIB
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208548,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',53372,216926,'Y',0,100,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-06 14:52:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-06 14:52:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e57ff46a-4536-48a8-8b7b-0931342a7ee4','Y',100,1,1,1,'N','N','N','N','N')
;

-- Dec 6, 2024, 2:52:45 PM WIB
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1, ColumnSpan=5, NumLines=5,Updated=TO_TIMESTAMP('2024-12-06 14:52:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208548
;

-- Dec 6, 2024, 2:52:45 PM WIB
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2024-12-06 14:52:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202495
;

-- Dec 6, 2024, 3:05:13 PM WIB
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2024-12-06 15:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216923
;

-- Dec 6, 2024, 3:05:13 PM WIB
UPDATE PA_DashboardContent_Trl SET Help='Establezca su menú favorito desde el panel del árbol de menús o arrastre y suelte el elemento del menú en el panel de favoritos. Haga clic derecho en el elemento favorito para eliminarlo. Puede organizar sus favoritos por carpeta.' WHERE AD_Language='es_CO' AND PA_DashboardContent_ID=50001
;

-- Dec 6, 2024, 3:05:13 PM WIB
UPDATE PA_DashboardContent_Trl SET Help='Muestra el último documento abierto. Arrastra y suelta un elemento reciente en la papelera para eliminarlo.' WHERE AD_Language='es_CO' AND PA_DashboardContent_ID=200000
;