-- Aug 16, 2010 6:30:05 PM COT
-- Prevent invoice split to circumvent role approval amount
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,Help,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54266,0,'AmtApprovalAccum',TO_TIMESTAMP('2010-08-16 18:30:04','YYYY-MM-DD HH24:MI:SS'),100,'The approval amount limit for this role accumulated on a period','D','The Approval Amount field indicates the amount limit this Role has for approval of documents within a period limit.','Y','Approval Amount Accumulated','Approval Amt Accumulated',TO_TIMESTAMP('2010-08-16 18:30:04','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 16, 2010 6:30:05 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=54266 AND EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Element_ID!=t.AD_Element_ID)
;

-- Aug 16, 2010 6:31:43 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,Description,EntityType,Help,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,54267,0,'DaysApprovalAccum',TO_TIMESTAMP('2010-08-16 18:31:43','YYYY-MM-DD HH24:MI:SS'),100,'The days approval indicates the days to take into account to verify the accumulated approval amount.','D','The Days Approval Accumulated field indicates the days to take into account to verify the accumulated approval amount.','Y','Days Approval Accumulated','Days Approval Accumulated',TO_TIMESTAMP('2010-08-16 18:31:43','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 16, 2010 6:31:43 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=54267 AND EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Element_ID!=t.AD_Element_ID)
;

-- Aug 16, 2010 6:32:38 PM COT
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,59665,54266,0,12,156,'AmtApprovalAccum',TO_TIMESTAMP('2010-08-16 18:32:37','YYYY-MM-DD HH24:MI:SS'),100,'The approval amount limit for this role accumulated on a period','D',22,'The Approval Amount field indicates the amount limit this Role has for approval of documents within a period limit.','Y','N','N','N','N','N','N','N','N','N','Y','Approval Amount Accumulated',0,TO_TIMESTAMP('2010-08-16 18:32:37','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2010 6:32:38 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=59665 AND EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Column_ID!=t.AD_Column_ID)
;

-- Aug 16, 2010 6:32:43 PM COT
ALTER TABLE AD_Role ADD AmtApprovalAccum NUMBER(10) DEFAULT NULL
;

-- Aug 16, 2010 6:33:14 PM COT
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAlwaysUpdateable,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,59666,54267,0,11,156,'DaysApprovalAccum',TO_TIMESTAMP('2010-08-16 18:33:13','YYYY-MM-DD HH24:MI:SS'),100,'The days approval indicates the days to take into account to verify the accumulated approval amount.','D',10,'The Days Approval Accumulated field indicates the days to take into account to verify the accumulated approval amount.','Y','N','N','N','N','N','N','N','N','N','Y','Days Approval Accumulated',0,TO_TIMESTAMP('2010-08-16 18:33:13','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2010 6:33:14 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=59666 AND EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Column_ID!=t.AD_Column_ID)
;

-- Aug 16, 2010 6:33:17 PM COT
ALTER TABLE AD_Role ADD DaysApprovalAccum NUMBER(10) DEFAULT NULL
;

-- Aug 16, 2010 6:34:56 PM COT
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_FieldGroup_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,59665,134,59591,0,119,TO_TIMESTAMP('2010-08-16 18:34:56','YYYY-MM-DD HH24:MI:SS'),100,'The approval amount limit for this role accumulated on a period',14,'D','The Approval Amount field indicates the amount limit this Role has for approval of documents within a period limit.','Y','Y','Y','N','N','N','N','N','Approval Amount Accumulated',380,0,TO_TIMESTAMP('2010-08-16 18:34:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 16, 2010 6:34:56 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=59591 AND EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Field_ID!=t.AD_Field_ID)
;

-- Aug 16, 2010 6:35:17 PM COT
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,59666,59592,0,119,TO_TIMESTAMP('2010-08-16 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,'The days approval indicates the days to take into account to verify the accumulated approval amount.',10,'D','The Days Approval Accumulated field indicates the days to take into account to verify the accumulated approval amount.','Y','Y','Y','N','N','N','N','Y','Days Approval Accumulated',390,0,TO_TIMESTAMP('2010-08-16 18:35:16','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 16, 2010 6:35:17 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=59592 AND EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language!=l.AD_Language OR tt.AD_Field_ID!=t.AD_Field_ID)
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=59592
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=59591
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=10126
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=52018
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=8740
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=5227
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=11006
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=11003
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=11002
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=8311
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=10813
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=11256
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=11257
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=8313
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=8314
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=8312
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=8310
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=12367
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=12368
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=12641
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=50168
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=50169
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=50170
;

-- Aug 16, 2010 6:41:12 PM COT
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=50171
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=50172
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=50173
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=50174
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=50175
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=50176
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=50177
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=50178
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=55432
;

-- Aug 16, 2010 6:41:13 PM COT
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=55433
;

-- Aug 16, 2010 6:41:23 PM COT
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2010-08-16 18:41:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59592
;

-- Aug 16, 2010 6:41:25 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2010-08-16 18:41:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59591
;

-- Nov 30, 2010 2:34:58 PM COT
UPDATE AD_Element_Trl SET IsTranslated='Y',Name='Total Aprobación Acumulado',PrintName='Total Aprobación Acumulado',Description='Total límite de aprobación para este perfil acumulados en un período',Help='El campo total aprobación acumulado indica el total límite que este perfil tiene para aprobación de documentos durante un período limitado.',Updated=TO_DATE('2010-11-30 14:34:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54266 AND AD_Language LIKE 'es_%'
;

-- Nov 30, 2010 2:36:02 PM COT
UPDATE AD_Element_Trl SET IsTranslated='Y',Name='Días Aprobación Acumulado',PrintName='Días Aprobación Acumulado',Description='Los días de aprobación acumulados indican los días a tener en cuenta para verificar el total de aprobación acumulado.',Help='El campo días de aprobación acumulado indican los días a tener en cuenta para verificar el total de aprobación acumulado.',Updated=TO_DATE('2010-11-30 14:36:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54267 AND AD_Language LIKE 'es_%'
;

