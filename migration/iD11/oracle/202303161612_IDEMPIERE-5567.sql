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
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200235,'Search (UU)','Search Field based on UUID','D',0,0,'Y',TO_TIMESTAMP('2023-03-16 16:12:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-16 16:12:53','YYYY-MM-DD HH24:MI:SS'),100,'D','N','f741f1a8-bc99-48cc-80a8-0c5d3bf85dbb','N')
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

