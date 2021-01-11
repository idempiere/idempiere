-- IDEMPIERE-1604 Improvement on Window Customization
-- 14/09/2018 14h56min16s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213691,0,'Sql WHERE','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".',466,'WhereClause',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2018-09-14 14:56:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 14:56:16','YYYY-MM-DD HH24:MI:SS'),100,630,'Y','N','D','N','N','N','Y','9cd3e72b-9a57-4744-9d79-386e9473e573','Y',0,'N','N')
;

-- 14/09/2018 14h56min26s BRT
ALTER TABLE AD_UserDef_Tab ADD COLUMN WhereClause VARCHAR(2000) DEFAULT NULL 
;

-- 14/09/2018 14h57min39s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205828,'Sql WHERE','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".',394,213691,'Y',2000,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-09-14 14:57:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 14:57:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','653c7f21-fdd7-4522-949e-fa9336e53e4b','Y',130,1,5,1,'N','N','Y')
;

-- 14/09/2018 15h2min36s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213692,0,'Sql ORDER BY','Fully qualified ORDER BY clause','The ORDER BY Clause indicates the SQL ORDER BY clause to use for record selection',466,'OrderByClause',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2018-09-14 15:02:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 15:02:36','YYYY-MM-DD HH24:MI:SS'),100,475,'Y','N','D','N','N','N','Y','0ec1d7fc-9ff4-4c53-a848-1c8dbafa6975','Y',0,'N','N')
;

-- 14/09/2018 15h2min43s BRT
ALTER TABLE AD_UserDef_Tab ADD COLUMN OrderByClause VARCHAR(2000) DEFAULT NULL 
;

-- 14/09/2018 15h3min40s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205830,'Sql ORDER BY','Fully qualified ORDER BY clause','The ORDER BY Clause indicates the SQL ORDER BY clause to use for record selection',394,213692,'Y',2000,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-09-14 15:03:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 15:03:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c1ededed-6887-4eaf-9c5b-7ca01da3d86a','Y',140,1,5,1,'N','N','Y')
;

-- 14/09/2018 15h12min4s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213693,0,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',466,'AD_Process_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2018-09-14 15:12:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 15:12:04','YYYY-MM-DD HH24:MI:SS'),100,117,'Y','N','D','N','N','N','Y','67634d35-a8e1-4667-8c74-529d74c36145','Y',0,'N','N','N')
;

-- 14/09/2018 15h12min22s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213694,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',466,'SeqNo',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2018-09-14 15:12:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 15:12:22','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','N','N','Y','c7e49398-e62b-46f5-8217-3f7fb82a3173','Y',0,'N','N')
;

-- 14/09/2018 15h12min26s BRT
ALTER TABLE AD_UserDef_Tab ADD COLUMN SeqNo NUMERIC(10) DEFAULT NULL 
;

-- 14/09/2018 15h12min40s BRT
UPDATE AD_Column SET FKConstraintName='ADProcess_ADUserDefTab', FKConstraintType='N',Updated=TO_TIMESTAMP('2018-09-14 15:12:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213693
;

-- 14/09/2018 15h12min40s BRT
ALTER TABLE AD_UserDef_Tab ADD COLUMN AD_Process_ID NUMERIC(10) DEFAULT NULL 
;

-- 14/09/2018 15h12min40s BRT
ALTER TABLE AD_UserDef_Tab ADD CONSTRAINT ADProcess_ADUserDefTab FOREIGN KEY (AD_Process_ID) REFERENCES ad_process(ad_process_id) DEFERRABLE INITIALLY DEFERRED
;

-- 14/09/2018 15h13min52s BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213695,0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',466,'DisplayLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2018-09-14 15:13:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 15:13:52','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','N','N','N','Y','e0cd374f-5d30-4113-be73-a8d79ef48cca','Y',0,'N','N')
;

-- 14/09/2018 15h13min56s BRT
ALTER TABLE AD_UserDef_Tab ADD COLUMN DisplayLogic VARCHAR(2000) DEFAULT NULL 
;

-- 14/09/2018 15h15min28s BRT
UPDATE AD_Column SET IsMandatory='N', AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_TIMESTAMP('2018-09-14 15:15:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6385
;

-- 14/09/2018 15h15min32s BRT
INSERT INTO t_alter_column values('ad_userdef_tab','IsReadOnly','CHAR(1)',null,'NULL')
;

-- 14/09/2018 15h15min32s BRT
INSERT INTO t_alter_column values('ad_userdef_tab','IsReadOnly',null,'NULL',null)
;

-- 14/09/2018 15h15min58s BRT
UPDATE AD_Column SET IsMandatory='N', AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_TIMESTAMP('2018-09-14 15:15:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6384
;

-- 14/09/2018 15h16min2s BRT
INSERT INTO t_alter_column values('ad_userdef_tab','IsSingleRow','CHAR(1)',null,'NULL')
;

-- 14/09/2018 15h16min2s BRT
INSERT INTO t_alter_column values('ad_userdef_tab','IsSingleRow',null,'NULL',null)
;

-- 14/09/2018 15h16min43s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205831,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',394,213693,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-09-14 15:16:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 15:16:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a6f7ec54-1d7d-4940-bc13-bfc974ea1775','Y',150,2)
;

-- 14/09/2018 15h16min43s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205832,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',394,213694,'N',22,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-09-14 15:16:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 15:16:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8648c11e-9390-4d62-8e0b-1ff0d554f092','Y',160,2)
;

-- 14/09/2018 15h16min43s BRT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (205833,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',394,213695,'Y',2000,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-09-14 15:16:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-09-14 15:16:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1af31bdc-9a18-4438-a2bd-a1677a7425ec','Y',170,5,3)
;

-- 14/09/2018 15h18min56s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5035
;

-- 14/09/2018 15h18min56s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205831
;

-- 14/09/2018 15h18min56s BRT
UPDATE AD_Field SET IsDisplayed='N', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205832
;

-- 14/09/2018 15h18min56s BRT
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5039
;

-- 14/09/2018 15h18min56s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5040
;

-- 14/09/2018 15h18min57s BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205833
;

-- 14/09/2018 15h18min57s BRT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200003
;

-- 14/09/2018 15h18min57s BRT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205828
;

-- 14/09/2018 15h18min57s BRT
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205830
;

-- 14/09/2018 15h18min57s BRT
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-09-14 15:18:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204616
;

-- 14/09/2018 15h18min57s BRT
SELECT Register_Migration_Script ('201809141624_IDEMPIERE-1604.sql') FROM DUAL
;