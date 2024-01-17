-- IDEMPIERE-6002
SELECT register_migration_script('202401171352_IDEMPIERE-6002.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 17, 2024, 1:52:26 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208124,'PP_Product_BOM_UU',53286,60999,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 13:52:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 13:52:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','EE01','24fc9cf4-89f7-4593-a16a-e65e2ce0c71b','N',2)
;

-- Jan 17, 2024, 1:52:38 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208125,'Cost Allocation Percent','Cost allocation percent in case of a co-product.',53287,58595,'Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 13:52:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 13:52:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','EE01','f3c6b9ee-0305-41a9-a7cf-940555f8a9cb','Y',110,2)
;

-- Jan 17, 2024, 1:52:38 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208126,'PP_Product_BOMLine_UU',53287,61000,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 13:52:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 13:52:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','EE01','a2fba48d-de3d-4984-98c7-913192f32336','N',2)
;

-- Jan 17, 2024, 1:52:57 PM CET
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2024-01-17 13:52:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208125
;

-- Jan 17, 2024, 2:33:24 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208127,'C_UserRemuneration_UU',727,60785,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:33:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:33:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ac53d015-b81e-4845-8e02-a4d96c37bfd1','N',2)
;

-- Jan 17, 2024, 2:33:39 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208128,'C_Remuneration_UU',725,60748,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:33:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:33:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','22a4c7a5-1c81-474f-bfe0-5d73b99aba1a','N',2)
;

-- Jan 17, 2024, 2:34:16 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208129,'C_JobRemuneration_UU',726,60672,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:34:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','89ea5b06-db1f-4d4a-8bc9-deef934c0a99','N',2)
;

-- Jan 17, 2024, 2:34:42 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208130,'C_RevenueRecognition_UU',272,60749,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:34:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:34:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2ebbba1e-d619-4b70-a2f1-2c73f7325ab8','N',2)
;

-- Jan 17, 2024, 2:34:53 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208131,'C_RevenueRecog_Service_UU',54010,213821,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:34:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:34:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fca1c37f-d263-4f3e-aa58-3db1631fd8bd','N',2)
;

-- Jan 17, 2024, 2:35:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208132,'C_RevenueRecognition_Plan_UU',378,60750,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:35:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:35:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3dfc30f9-e6f4-4f53-b884-e6d588e6421e','N',2)
;

-- Jan 17, 2024, 2:35:36 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208133,'C_RevenueRecognition_Run_UU',379,60751,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:35:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:35:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','db5a1b37-d659-4235-bd38-90771d52a742','N',2)
;

-- Jan 17, 2024, 2:36:11 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208134,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200269,359,'Y',22,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c7a0273d-af27-465a-bbc3-4706c596aa7d','N',2)
;

-- Jan 17, 2024, 2:36:11 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208135,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200269,360,'Y',22,380,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dc1553de-a901-4194-bdf9-e17caec8d060','Y','N',4,2)
;

-- Jan 17, 2024, 2:36:12 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208136,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200269,111,'Y',60,390,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3e8be34a-04fe-49e5-9742-6fe2d88c83b7','Y',40,5)
;

-- Jan 17, 2024, 2:36:12 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208137,'Description','Optional short description of the record','A description is limited to 255 characters.',200269,112,'Y',255,400,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e1d61be1-3bc5-4c2b-929b-4511589efe5c','Y',50,5)
;

-- Jan 17, 2024, 2:36:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208138,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200269,113,'Y',2000,410,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ce6a2008-8898-4107-aa62-951f5db93137','Y',60,5,3)
;

-- Jan 17, 2024, 2:36:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208139,'Version','Version of the table definition','The Version indicates the version of this table definition.',200269,110,'Y',22,420,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dc4362fe-3aca-49bc-9836-742335d771e0','Y',70,2)
;

-- Jan 17, 2024, 2:36:13 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208140,'Dynamic Validation','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',200269,115,'Y',22,430,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7e13485a-faf8-4564-b625-a1bd94b932ca','Y',80,2)
;

-- Jan 17, 2024, 2:36:14 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208141,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Tenant_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Tenant as well as Buttons.',200269,117,'Y',2000,440,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','29fe2d18-ef00-4bcb-a79e-51af657c6350','Y',90,5,3)
;

-- Jan 17, 2024, 2:36:14 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208142,'Length','Length of the column in the database','The Length indicates the length of a column as defined in the database.',200269,118,'Y',22,450,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eef0ad83-89d2-4e32-bc0a-63e38a64394c','Y',100,2)
;

-- Jan 17, 2024, 2:36:15 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208143,'Key column','This column is the key in this table','The key column must also be display sequence 0 in the field definition and may be hidden.',200269,119,'Y',1,460,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9b833849-2657-4013-9be0-fbfa171dcaeb','Y',110,2,2)
;

-- Jan 17, 2024, 2:36:15 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208144,'Parent link column','This column is a link to the parent table (e.g. header from lines) - incl. Association key columns','The Parent checkbox indicates if this column is a link to the parent table.',200269,120,'Y',1,470,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6573897b-76a5-4d0d-b902-c4038cdc1f61','Y',120,2,2)
;

-- Jan 17, 2024, 2:36:15 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208145,'Mandatory','Data entry is required in this column','The field must have a value for the record to be saved to the database.',200269,124,'Y',1,480,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c174afb5-0806-4eb9-a003-cac694a6d2ea','Y',130,2,2)
;

-- Jan 17, 2024, 2:36:16 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208146,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200269,125,'Y',1,490,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3c7a8fa8-9f06-42ce-99fa-e4dd8358cd4a','Y',140,2,2)
;

-- Jan 17, 2024, 2:36:16 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208147,'Identifier','This column is part of the record identifier','The Identifier checkbox indicates that this column is part of the identifier or key for this table.  ',200269,126,'Y',1,500,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5f8cca17-9361-456d-9c3f-2a2c9c21488c','Y',150,2,2)
;

-- Jan 17, 2024, 2:36:17 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208148,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200269,127,'Y',22,510,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','387efe9c-dd4b-426d-979b-9af8a8a368dc','Y',160,2)
;

-- Jan 17, 2024, 2:36:17 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208149,'Encrypted','Display or Storage is encrypted','Display encryption (in Window/Tab/Field) - all characters are displayed as ''*'' - in the database it is stored in clear text. You will not be able to report on these columns.<br>
Data storage encryption (in Table/Column) - data is stored encrypted in the database (dangerous!) and you will not be able to report on those columns. Independent from Display encryption.',200269,128,'Y',1,520,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','92080883-239a-4ca2-b6b8-5139b04a5256','Y',170,2,2)
;

-- Jan 17, 2024, 2:36:17 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208150,'Reference','System Reference and Validation','The Reference could be a display type, list or table validation.',200269,226,'Y',22,530,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5baf4cfd-3025-401e-8f55-0b8e1c35798c','Y',180,2)
;

-- Jan 17, 2024, 2:36:18 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208151,'Reference Key','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',200269,227,'Y',22,540,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d7c407ad-a88d-4e15-a927-8ec59e415b66','Y',190,2)
;

-- Jan 17, 2024, 2:36:18 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208152,'Value Format','Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"','<B>Validation elements:</B>
 	(Space) any character
_	Space (fixed character)
l	any Letter a..Z NO space
L	any Letter a..Z NO space converted to upper case
o	any Letter a..Z or space
O	any Letter a..Z or space converted to upper case
a	any Letters & Digits NO space
A	any Letters & Digits NO space converted to upper case
c	any Letters & Digits or space
C	any Letters & Digits or space converted to upper case
0	Digits 0..9 NO space
9	Digits 0..9 or space

Example of format "(000)_000-0000"',200269,1179,'Y',255,550,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','80b85fb9-05d5-4eca-a3e0-d7dc8211e9e0','Y',200,5)
;

-- Jan 17, 2024, 2:36:19 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208153,'Callout','Fully qualified class names and method - separated by semicolons','A Callout allow you to create Java extensions to perform certain tasks always after a value changed. Callouts should not be used for validation but consequences of a user selecting a certain value.
The callout is a Java class implementing org.compiere.model.Callout and a method name to call.  Example: "org.compiere.model.CalloutRequest.copyText" instantiates the class "CalloutRequest" and calls the method "copyText". You can have multiple callouts by separating them via a semicolon',200269,1692,'Y',255,560,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1d0afb8f-8347-4394-9097-1966d6094e8d','Y',210,5)
;

-- Jan 17, 2024, 2:36:19 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208154,'System Element','System Element enables the central maintenance of column description and help.','The System Element allows for the central maintenance of help, descriptions and terminology for a database column.',200269,2608,'Y',22,570,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2b105f0d-a7d5-412e-b227-d390bbd12dc7','Y',220,2)
;

-- Jan 17, 2024, 2:36:19 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208155,'Updatable','Determines, if the field can be updated','The Updatable checkbox indicates if a field can be updated by the user.',200269,3360,'Y',1,580,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','64bd0fc8-55a9-4257-8f4c-babd4de422d0','Y',230,2,2)
;

-- Jan 17, 2024, 2:36:20 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208156,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200269,3369,'Y',22,590,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','28d7031c-6557-4952-8895-03fdb3e53d22','Y',240,2)
;

-- Jan 17, 2024, 2:36:20 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208157,'Min. Value','Minimum Value for a field','The Minimum Value indicates the lowest  allowable value for a field. use format yyyy-mm-dd for Date',200269,3388,'Y',20,600,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4cd9427f-f478-44f0-b6bc-e3fd4b1b7692','Y',250,2)
;

-- Jan 17, 2024, 2:36:21 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208158,'Max. Value','Maximum Value for a field','The Maximum Value indicates the highest allowable value for a field. use format yyyy-mm-dd for Date',200269,3389,'Y',20,610,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a8f2b418-bcd5-4ae6-aa8c-e586d07dbb45','Y',260,2)
;

-- Jan 17, 2024, 2:36:21 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208159,'Selection Column','Is this column used for finding rows in windows','If selected, the column is listed in the first find window tab and in the selection part of the window',200269,6244,'Y',1,620,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a659ef03-45a2-4476-b7b5-317f1f22eb3b','Y',270,2,2)
;

-- Jan 17, 2024, 2:36:21 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208160,'Read Only Logic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',200269,6245,'Y',2000,630,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','76b15dae-90e6-4784-a0c3-74e57010ed46','Y',280,5,3)
;

-- Jan 17, 2024, 2:36:22 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208161,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',200269,6482,'Y',40,640,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','985ef011-02b3-4e2c-a2dc-fa25725d2504','Y',290,2)
;

-- Jan 17, 2024, 2:36:22 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208162,'Synchronize Database','Change database table definition when changing dictionary definition','When selected, the database column definition is updated based on your entries in the Column definition of the Application Dictionary.',200269,6483,'Y',1,650,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bc480712-a590-4cf8-a8fe-35141ea9afb6','Y',300,2,2)
;

-- Jan 17, 2024, 2:36:23 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208163,'Always Updatable','The column is always updateable, even if the record is not active or processed','If selected and if the window / tab is not read only, you can always update the column.  This might be useful for comments, etc.',200269,11617,'Y',1,660,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','92fae35b-2d3e-4314-a38a-59410f57bfd1','Y',310,2,2)
;

-- Jan 17, 2024, 2:36:23 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208164,'Column SQL','Virtual Column (r/o)','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days',200269,13448,'Y',4000,670,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','20055ba5-de3f-40f5-a9c6-d0d54e429afa','Y',320,5)
;

-- Jan 17, 2024, 2:36:23 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208165,'Mandatory Logic',200269,50218,'Y',2000,680,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0c98e55b-f4ce-48dc-a8d1-8e447d9119c1','Y',330,5,3)
;

-- Jan 17, 2024, 2:36:24 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208166,'Auto complete','Automatic completion for text fields','The autocompletion uses all existing values (from the same tenant and organization) of the field.',200269,56149,'Y',1,690,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ecb201ec-e1bd-485f-8aff-2bd1a7d1584c','Y',340,2,2)
;

-- Jan 17, 2024, 2:36:24 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208167,'Allow Logging','Determine if a column must be recorded into the change log',200269,56187,'Y',1,700,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3f71c3fd-ffa7-4621-a8e9-677db4a7519e','Y',350,2,2)
;

-- Jan 17, 2024, 2:36:25 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208168,'Format Pattern','The pattern used to format a number or date.','A string complying with either Java SimpleDateFormat or DecimalFormat pattern syntax used to override the default presentation format of a date or number type field.',200269,56352,'Y',22,710,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','15243d4f-dc48-4ef0-b6b6-30a5d548bda3','Y',360,2)
;

-- Jan 17, 2024, 2:36:25 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208169,'Chart',200269,59702,'Y',22,720,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f6f33ce9-99f2-4223-b62f-7029164969a8','Y',370,2)
;

-- Jan 17, 2024, 2:36:25 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208170,'AD_Column_UU',200269,60388,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b98179ad-9664-4692-beb5-bc6953fe0678','N',2)
;

-- Jan 17, 2024, 2:36:26 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208171,'Allow Copy','Determine if a column must be copied when pushing the button to copy record',200269,62199,'Y',1,730,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9750565c-8586-44ab-ac7d-512f4f265dfa','Y',380,2,2)
;

-- Jan 17, 2024, 2:36:26 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208172,'Selection Column Sequence','Selection Column Sequence','For ordering sequence of selection column',200269,200323,'Y',14,740,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','de09dd6b-c76b-4d0c-8600-4890af516623','Y',390,2)
;

-- Jan 17, 2024, 2:36:27 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208173,'Toolbar Button','Show the button on the toolbar, the window, or both','The IsToolbarButton field indicates if this button is part of the toolbar''s process button popup list, or render as field in window, or both.',200269,200703,'Y',1,750,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','94893f16-938d-467c-8602-976e2605dd94','Y',400,2)
;

-- Jan 17, 2024, 2:36:27 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208174,'Secure content','Defines whether content must be treated as secure',200269,210596,'Y',1,760,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','97b3dfad-27c9-4ae1-8e95-871dc7d0f8c6','Y',410,2,2)
;

-- Jan 17, 2024, 2:36:27 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208175,'Constraint Name',200269,210871,'Y',30,770,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5fbaac63-7cfe-4c01-a25b-eff84d0b30c8','Y',420,2)
;

-- Jan 17, 2024, 2:36:28 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208176,'Constraint Type',200269,210872,'Y',1,780,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a4913b99-3aa1-462f-8298-fdbefb1f8cf9','Y',430,2)
;

-- Jan 17, 2024, 2:36:28 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208177,'Dashboard Content',200269,212762,'Y',22,790,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','55c429d9-46af-4189-9508-6ddca0223cad','Y',440,2)
;

-- Jan 17, 2024, 2:36:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208178,'Placeholder',200269,213357,'Y',255,800,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6bc151bb-778e-448e-83a8-10266573196a','Y',450,5)
;

-- Jan 17, 2024, 2:36:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208179,'HTML','Text has HTML tags',200269,213622,'Y',1,810,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','64d3fad5-12d3-46e3-a344-ba1d83cd4ac2','Y',460,2,2)
;

-- Jan 17, 2024, 2:36:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208180,'Dynamic Validation (Lookup)','Override Dynamic Validation Rule for Lookup Window','For some situations the dynamic validation rule for a Lookup window should be different from user data entry window. ',200269,213962,'Y',22,820,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a5da7385-e606-482e-8c91-1e14eddc8c13','Y',470,2)
;

-- Jan 17, 2024, 2:36:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (208181,'Always Updatable Logic','Logic to determine if field is Updatable irrespective if record''s active status or processed status. This logic Applicable only if Always Updatable is N.','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := |&()<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',200269,215059,'Y',2000,830,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fa00f572-198f-407e-8da5-fb6097033f08','Y',480,5,3)
;

-- Jan 17, 2024, 2:36:30 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208182,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200269,215126,'Y',10,840,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','94e946ae-1b18-485d-966a-6d792ed9b7b8','Y',490,2)
;

-- Jan 17, 2024, 2:36:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208183,'Constraint Message',200269,215961,'Y',10,850,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e2594e6e-2b6f-4baa-b9eb-7c69e359741b','Y',500,2)
;

-- Jan 17, 2024, 2:36:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208184,'Partitioning Method','Indicates how the Table is partitioned','The Partitioning Method indicates how the Table is partitioned (List or Range). List partitioning - The data distribution is defined by a discrete list of values. Range Partitioning - The data is distributed based on a range of values.',200269,216283,'Y',2,860,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d4a1a71a-c983-41a6-9fd8-605bfbb42ebc','Y',510,2)
;

-- Jan 17, 2024, 2:36:31 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208185,'Partition Key','This is a partition key',200269,216286,'Y',1,870,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a99dea49-7607-4e20-9a1e-1544c4e47c38','Y',520,2,2)
;

-- Jan 17, 2024, 2:36:32 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208186,'Partition Key Sequence','Indicates the order of partition keys','The Partition Key Sequence indicates the order of the partition keys where the lowest number comes first',200269,216302,'Y',14,880,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','24457390-d1de-407e-aa7f-9661665135a3','Y',530,2)
;

-- Jan 17, 2024, 2:36:32 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208187,'Range Partition Interval','Indicates the interval used in a range partitioning','The Range Partition Interval indicates the interval used in a range partitioning (date or number). Examples of date intervals: 1 year; 6 months; Examples of number intervals: 5000; 100000;',200269,216304,'Y',30,890,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d71d2dba-1dfb-41d5-a834-6a6d8284ae82','Y',540,2)
;

-- Jan 17, 2024, 2:36:33 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208188,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200269,548,'Y',1,900,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7896f9c5-7798-4e39-ab47-a90328308580','Y',550,2,2)
;

