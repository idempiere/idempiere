-- Dec 4, 2018 3:41:36 PM MYT
-- AP2-766 Implement Chosen Box control
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,Description,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType,AD_Org_ID) VALUES (200161,'Chosen Multiple Selection List','fa2c2787-e93f-42be-a5d1-7a12f6b30b72','N','Chosen multiple selection box for reference list','D',TO_TIMESTAMP('2018-12-04 15:41:35','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_TIMESTAMP('2018-12-04 15:41:35','YYYY-MM-DD HH24:MI:SS'),'D',0)
;

-- Dec 4, 2018 3:41:56 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,Description,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType,AD_Org_ID) VALUES (200162,'Chosen Multiple Selection Table','07d7bf33-8998-4538-920d-5c0e0b2d46d2','N','Chosen multiple selection box for table list','D',TO_TIMESTAMP('2018-12-04 15:41:56','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_TIMESTAMP('2018-12-04 15:41:56','YYYY-MM-DD HH24:MI:SS'),'D',0)
;

-- Dec 4, 2018 3:44:27 PM MYT
UPDATE AD_Val_Rule SET Code='AD_Reference.ValidationType=CASE WHEN  @AD_Reference_ID@ IN (17,28,200152,200161) THEN ''L'' ELSE ''T'' END',Updated=TO_TIMESTAMP('2018-12-04 15:44:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=115
;

-- Dec 4, 2018 3:48:07 PM MYT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-12-04 15:48:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Dec 4, 2018 3:48:49 PM MYT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-12-04 15:48:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

-- Dec 4, 2018 4:49:17 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,Description,ValidationType,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType,AD_Org_ID) VALUES (200163,'Chosen Multiple Selection Search','563a482c-4f06-448d-bb7f-e109d33cead9','N','Chosen multiple selection box for search','D',TO_TIMESTAMP('2018-12-04 16:49:16','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_TIMESTAMP('2018-12-04 16:49:16','YYYY-MM-DD HH24:MI:SS'),'D',0)
;

-- Dec 4, 2018 4:49:55 PM MYT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012 | @AD_Reference_ID@=31 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-12-04 16:49:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=172
;

-- Dec 4, 2018 4:50:41 PM MYT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200152 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-12-04 16:50:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Dec 5, 2018 11:18:30 AM MYT
-- AP2-766 Implement Chosen Box control
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, MandatoryLogic='@AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163', AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-12-05 11:18:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Dec 7, 2018 4:37:39 PM MYT
-- AP2-766 Implement Chosen Box control
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, MandatoryLogic='@AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163', AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-12-07 16:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2540
;

-- IDEMPIERE-3413 Multi Select List and table reference
-- Jun 22, 2019, 5:11:30 PM MYT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28 | @AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-06-22 17:11:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Jun 22, 2019, 5:12:43 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsQueryCriteria@=Y & @AD_Reference_ID@!200161 & @AD_Reference_ID@!200162 & @AD_Reference_ID@!200163', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-06-22 17:12:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Jun 22, 2019, 5:13:24 PM MYT
UPDATE AD_Field SET DisplayLogic='@IsQueryCriteria@=Y & @AD_Reference_ID@!200161 & @AD_Reference_ID@!200162 & @AD_Reference_ID@!200163', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-06-22 17:13:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- Jun 22, 2019, 5:15:39 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@AD_Reference_ID@=200161 | @AD_Reference_ID@=200162 | @AD_Reference_ID@=200163', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-06-22 17:15:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

SELECT register_migration_script('201906171811_IDEMPIERE-3413.sql') FROM dual
;

