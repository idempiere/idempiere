-- IDEMPIERE-5443
SELECT register_migration_script('202210041053_IDEMPIERE-5443.sql') FROM dual;

-- Oct 4, 2022, 4:07:25 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200217,'DateSelectionMode','Date Selection Mode','L',0,0,'Y',TO_TIMESTAMP('2022-10-04 16:07:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-04 16:07:25','YYYY-MM-DD HH24:MI:SS'),100,'D','N','c7a6eae8-e3af-4072-aced-cdd10a18f8da')
;

-- Oct 4, 2022, 4:08:11 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200561,'Previous',200217,'P',0,0,'Y',TO_TIMESTAMP('2022-10-04 16:08:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-04 16:08:11','YYYY-MM-DD HH24:MI:SS'),100,'D','573c8cf3-0c70-4a89-b7fc-595eba982c6d')
;

-- Oct 4, 2022, 4:08:21 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200562,'Next',200217,'N',0,0,'Y',TO_TIMESTAMP('2022-10-04 16:08:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-04 16:08:21','YYYY-MM-DD HH24:MI:SS'),100,'D','e7a8b7ad-c970-4a5e-85a5-fe6b1bb004b9')
;

-- Oct 4, 2022, 4:08:36 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200563,'Current',200217,'C',0,0,'Y',TO_TIMESTAMP('2022-10-04 16:08:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-04 16:08:36','YYYY-MM-DD HH24:MI:SS'),100,'D','1344c204-9744-4473-89ae-3188183ebc89')
;

-- Oct 4, 2022, 4:08:47 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200564,'Before',200217,'B',0,0,'Y',TO_TIMESTAMP('2022-10-04 16:08:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-04 16:08:47','YYYY-MM-DD HH24:MI:SS'),100,'D','603e46ea-12e6-4c4b-86bc-0b07924f9534')
;

-- Oct 4, 2022, 4:08:56 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200565,'After',200217,'A',0,0,'Y',TO_TIMESTAMP('2022-10-04 16:08:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-04 16:08:55','YYYY-MM-DD HH24:MI:SS'),100,'D','ca9abc44-80eb-4f22-abcc-9161af2e3057')
;

-- Oct 4, 2022, 4:09:09 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200566,'On',200217,'O',0,0,'Y',TO_TIMESTAMP('2022-10-04 16:09:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-04 16:09:08','YYYY-MM-DD HH24:MI:SS'),100,'D','7c20abd1-fabf-44ca-9b6f-e55a4af06e46')
;

-- Oct 4, 2022, 4:09:22 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200567,'Between',200217,'BW',0,0,'Y',TO_TIMESTAMP('2022-10-04 16:09:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-04 16:09:22','YYYY-MM-DD HH24:MI:SS'),100,'D','30b8b6bd-631d-4c23-924b-691f840041ed')
;

-- Oct 6, 2022, 4:18:39 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','After {0}',0,0,'Y',TO_TIMESTAMP('2022-10-06 16:18:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-06 16:18:39','YYYY-MM-DD HH24:MI:SS'),100,200790,'AfterDate','D','cf7ace7d-a6d0-4ef5-a7e4-84409100e6aa')
;

-- Oct 6, 2022, 4:19:20 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Before {0}',0,0,'Y',TO_TIMESTAMP('2022-10-06 16:19:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-06 16:19:20','YYYY-MM-DD HH24:MI:SS'),100,200791,'BeforeDate','D','280bb6a6-0d19-4c54-946c-d60b712093b6')
;

-- Oct 6, 2022, 4:20:06 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','On {0}',0,0,'Y',TO_TIMESTAMP('2022-10-06 16:20:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-06 16:20:06','YYYY-MM-DD HH24:MI:SS'),100,200792,'OnDate','D','f229dfef-7775-450f-be84-dc84c13ea7ff')
;

-- Oct 6, 2022, 4:21:16 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Update Filter',0,0,'Y',TO_TIMESTAMP('2022-10-06 16:21:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-06 16:21:15','YYYY-MM-DD HH24:MI:SS'),100,200793,'UpdateFilter','D','252c9784-e2ec-4cca-87b8-3a5d1b5b73e2')
;

-- Oct 6, 2022, 5:25:59 PM CEST
UPDATE AD_Ref_List SET Value='01',Updated=TO_TIMESTAMP('2022-10-06 17:25:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200561
;

-- Oct 6, 2022, 5:26:02 PM CEST
UPDATE AD_Ref_List SET Value='02',Updated=TO_TIMESTAMP('2022-10-06 17:26:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200562
;

-- Oct 6, 2022, 5:26:07 PM CEST
UPDATE AD_Ref_List SET Value='03',Updated=TO_TIMESTAMP('2022-10-06 17:26:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200563
;

-- Oct 6, 2022, 5:26:20 PM CEST
UPDATE AD_Ref_List SET Value='04',Updated=TO_TIMESTAMP('2022-10-06 17:26:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200564
;

-- Oct 6, 2022, 5:26:23 PM CEST
UPDATE AD_Ref_List SET Value='05',Updated=TO_TIMESTAMP('2022-10-06 17:26:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200565
;

-- Oct 6, 2022, 5:26:27 PM CEST
UPDATE AD_Ref_List SET Value='07',Updated=TO_TIMESTAMP('2022-10-06 17:26:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200567
;

-- Oct 6, 2022, 5:26:39 PM CEST
UPDATE AD_Ref_List SET Value='06',Updated=TO_TIMESTAMP('2022-10-06 17:26:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200566
;

-- Oct 6, 2022, 5:31:25 PM CEST
UPDATE AD_Reference SET IsOrderByValue='Y',Updated=TO_TIMESTAMP('2022-10-06 17:31:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200217
;

-- Oct 7, 2022, 4:45:08 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200568,'Quick',200217,'08',0,0,'Y',TO_TIMESTAMP('2022-10-07 16:45:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-07 16:45:07','YYYY-MM-DD HH24:MI:SS'),100,'D','b7e5adb3-b9ce-4bae-bd19-8c8e60413d18')
;

-- Oct 11, 2022, 3:21:59 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200221,'Months','L',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:21:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:21:59','YYYY-MM-DD HH24:MI:SS'),100,'D','N','bbabc9d6-241d-4cb9-b5b5-2b02e37abdf1')
;

-- Oct 11, 2022, 3:22:32 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200600,'January',200221,'01',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:22:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:22:32','YYYY-MM-DD HH24:MI:SS'),100,'D','d4575089-ba8d-4438-84e7-9e0ef0381f3e')
;

-- Oct 11, 2022, 3:22:41 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200601,'February',200221,'02',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:22:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:22:40','YYYY-MM-DD HH24:MI:SS'),100,'D','d553098d-4e18-490c-ba35-3735e0546a77')
;

-- Oct 11, 2022, 3:22:55 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200602,'March',200221,'03',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:22:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:22:55','YYYY-MM-DD HH24:MI:SS'),100,'D','7be305ae-1774-4200-b30d-8c62b896759c')
;

-- Oct 11, 2022, 3:23:04 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200603,'April',200221,'04',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:23:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:23:03','YYYY-MM-DD HH24:MI:SS'),100,'D','f612d5c5-89d7-4abe-8f6b-387587a35386')
;

-- Oct 11, 2022, 3:23:11 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200604,'May',200221,'05',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:23:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:23:11','YYYY-MM-DD HH24:MI:SS'),100,'D','50bbeb15-5ad4-490d-86a9-c3a892ca8ee8')
;

-- Oct 11, 2022, 3:23:19 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200605,'June',200221,'06',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:23:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:23:18','YYYY-MM-DD HH24:MI:SS'),100,'D','38a38a15-233e-43ab-86e5-1ce87416f7f9')
;

-- Oct 11, 2022, 3:23:27 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200606,'July',200221,'07',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:23:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:23:26','YYYY-MM-DD HH24:MI:SS'),100,'D','ea6cc9a3-80ca-439b-be9b-8bf261e0eeec')
;

-- Oct 11, 2022, 3:23:43 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200607,'August',200221,'08',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:23:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:23:43','YYYY-MM-DD HH24:MI:SS'),100,'D','d15ff0d4-0997-4f49-a49a-fb197a38b090')
;

-- Oct 11, 2022, 3:24:10 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200608,'September',200221,'09',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:24:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:24:10','YYYY-MM-DD HH24:MI:SS'),100,'D','289db278-fab8-43d6-a83d-621f1c0ef71d')
;

-- Oct 11, 2022, 3:24:18 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200609,'October',200221,'10',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:24:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:24:18','YYYY-MM-DD HH24:MI:SS'),100,'D','d9bcc45a-dcb1-4c2b-bc90-581ea527625d')
;

-- Oct 11, 2022, 3:24:25 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200610,'November',200221,'11',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:24:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:24:25','YYYY-MM-DD HH24:MI:SS'),100,'D','5d8b3451-0d70-4912-842d-dd19c40a681e')
;

-- Oct 11, 2022, 3:24:33 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200611,'December',200221,'12',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:24:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:24:33','YYYY-MM-DD HH24:MI:SS'),100,'D','01cdce86-aa1b-4b80-9849-bc2df988ad4c')
;

-- Oct 11, 2022, 3:24:41 PM CEST
UPDATE AD_Reference SET IsOrderByValue='Y',Updated=TO_TIMESTAMP('2022-10-11 15:24:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200221
;

-- Oct 11, 2022, 3:24:53 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200222,'Quarters','L',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:24:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:24:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','c045f9d5-379c-490f-b96d-920c5ac59d50')
;

-- Oct 11, 2022, 3:25:08 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200612,'First Quarter',200222,'01',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:25:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:25:08','YYYY-MM-DD HH24:MI:SS'),100,'D','3d5d0b5c-2239-41f9-ac3b-5f6f931357c3')
;

-- Oct 11, 2022, 3:25:18 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200613,'Second Quarter',200222,'02',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:25:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:25:17','YYYY-MM-DD HH24:MI:SS'),100,'D','417f6b55-1451-4f85-bfbf-7fa3153a5473')
;

-- Oct 11, 2022, 3:25:27 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200614,'Third Quarter',200222,'03',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:25:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:25:27','YYYY-MM-DD HH24:MI:SS'),100,'D','d984daa5-7b2b-4233-8860-a03ee0e72c7c')
;

-- Oct 11, 2022, 3:25:35 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200615,'Fourth Quarter',200222,'04',0,0,'Y',TO_TIMESTAMP('2022-10-11 15:25:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 15:25:34','YYYY-MM-DD HH24:MI:SS'),100,'D','95ecec3c-9829-488a-b376-d7af83ba9448')
;

-- Oct 11, 2022, 4:51:05 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Current Year Months',0,0,'Y',TO_TIMESTAMP('2022-10-11 16:51:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 16:51:05','YYYY-MM-DD HH24:MI:SS'),100,200794,'CurrentYearMonths','D','6bd493c4-79a8-4a50-8eb0-c45b4a58bfa6')
;

-- Oct 11, 2022, 4:51:30 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Current Year Quarters',0,0,'Y',TO_TIMESTAMP('2022-10-11 16:51:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 16:51:30','YYYY-MM-DD HH24:MI:SS'),100,200795,'CurrentYearQuarters','D','83a2c54d-6282-4a05-a016-19da13fdf681')
;

-- Oct 11, 2022, 5:00:16 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Selected Time Range',0,0,'Y',TO_TIMESTAMP('2022-10-11 17:00:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-10-11 17:00:16','YYYY-MM-DD HH24:MI:SS'),100,200796,'SelectedTimeRange','D','16d9cce7-fff1-4375-8bbb-af300c3c1a18')
;

