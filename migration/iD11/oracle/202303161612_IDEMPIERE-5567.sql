-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202303161612_IDEMPIERE-5567.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 16, 2023, 4:12:22 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200233,'Table (UU)','Table List based on UUID','D',0,0,'Y',TO_TIMESTAMP('2023-03-16 16:12:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-16 16:12:21','YYYY-MM-DD HH24:MI:SS'),100,'D','N','7a610848-25e3-4f38-ad47-5e79daf132fd','N')
;

-- Mar 16, 2023, 4:12:35 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200234,'Table Direct (UU)','Direct Table Access based on UUID','D',0,0,'Y',TO_TIMESTAMP('2023-03-16 16:12:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-16 16:12:34','YYYY-MM-DD HH24:MI:SS'),100,'D','N','52a4c2d4-3afb-47ef-b57c-8c9fc88bedff','N')
;

-- Mar 16, 2023, 4:12:53 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200235,'Search (UU)','Search Field based on UUID','D',0,0,'N',TO_TIMESTAMP('2023-03-16 16:12:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-16 16:12:53','YYYY-MM-DD HH24:MI:SS'),100,'D','N','f741f1a8-bc99-48cc-80a8-0c5d3bf85dbb','N')
;

-- Mar 16, 2023, 5:21:52 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=53370 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-16 17:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202518
;

-- Mar 16, 2023, 5:22:02 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=53370 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-16 17:22:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- Mar 16, 2023, 5:23:17 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-16 17:23:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

-- Mar 16, 2023, 5:23:24 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-16 17:23:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206091
;

-- Mar 16, 2023, 6:38:53 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-16 18:38:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Mar 24, 2023, 5:28:41 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200237,'AD_Table with ID or UU Column','T',0,0,'Y',TO_TIMESTAMP('2023-03-24 17:28:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 17:28:41','YYYY-MM-DD HH24:MI:SS'),100,'D','N','23255e3a-0bf4-43f9-afdf-419ab47e21ff','N')
;

-- Mar 24, 2023, 5:29:41 PM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,OrderByClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200237,100,100,100,'AD_Table.IsView=''N'' AND AD_Table.IsActive=''Y'' AND EXISTS (SELECT 1 FROM AD_Column c WHERE c.AD_Table_ID=AD_Table.AD_Table_ID AND (UPPER(c.ColumnName)=UPPER(AD_Table.TableName)||''_ID'' OR UPPER(c.ColumnName)=UPPER(AD_Table.TableName)||''_UU'') AND c.IsActive=''Y'')','AD_Table.TableName',0,0,'Y',TO_TIMESTAMP('2023-03-24 17:29:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 17:29:41','YYYY-MM-DD HH24:MI:SS'),100,'N','D','908b6255-4cf4-4d76-9208-acc5e36c6add')
;

-- Mar 24, 2023, 5:29:58 PM CET
UPDATE AD_Process_Para SET AD_Reference_Value_ID=200237,Updated=TO_TIMESTAMP('2023-03-24 17:29:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200264
;

-- Mar 24, 2023, 6:49:29 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','UUID Columns must end with suffix _UU',0,0,'Y',TO_TIMESTAMP('2023-03-24 18:49:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-24 18:49:28','YYYY-MM-DD HH24:MI:SS'),100,200827,'UUColumnsMustEndWithUU','D','183dfdda-b98b-4702-a942-11eaf0d5f816')
;

-- Mar 29, 2023, 6:40:54 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235 & @AttributeValueType@=''R''',Updated=TO_TIMESTAMP('2023-03-29 18:40:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206510
;

-- Mar 29, 2023, 6:41:44 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200235 & @AttributeValueType@=''R''',Updated=TO_TIMESTAMP('2023-03-29 18:41:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Mar 29, 2023, 6:42:38 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 18:42:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206409
;

-- Mar 29, 2023, 6:43:19 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 18:43:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Mar 29, 2023, 6:43:58 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 18:43:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Mar 29, 2023, 6:49:50 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 18:49:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10223
;

-- Mar 29, 2023, 6:50:27 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 18:50:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10225
;

-- Mar 29, 2023, 6:51:46 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 18:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206410
;

-- Mar 29, 2023, 6:52:53 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 18:52:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56279
;

-- Mar 29, 2023, 7:08:17 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=30 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:08:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54403
;

-- Mar 29, 2023, 7:09:03 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:09:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201895
;

-- Mar 29, 2023, 7:10:02 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:10:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206408
;

-- Mar 29, 2023, 7:10:41 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:10:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203266
;

-- Mar 29, 2023, 7:11:05 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:11:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206130
;

-- Mar 29, 2023, 7:11:47 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:11:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200855
;

-- Mar 29, 2023, 7:12:39 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:12:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54401
;

-- Mar 29, 2023, 7:13:00 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:13:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206129
;

-- Mar 29, 2023, 7:13:29 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200235',Updated=TO_TIMESTAMP('2023-03-29 19:13:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54402
;

-- Mar 29, 2023, 7:38:53 PM CEST
UPDATE AD_Val_Rule SET Code='(AD_Ref_List.Value!=''M'' OR @AD_Reference_ID@ IN (18,19,30,200233,200234,200235))',Updated=TO_TIMESTAMP('2023-03-29 19:38:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200064
;

-- Mar 29, 2023, 7:40:49 PM CEST
UPDATE AD_Val_Rule SET Code='AD_Reference.AD_Reference_ID IN (10,11,12,13,14,15,16,17,18,19,20,22,24,25,27,29,30,31,32,33,34,36,37,38,39,40,200233,200234,200235)',Updated=TO_TIMESTAMP('2023-03-29 19:40:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200090
;

