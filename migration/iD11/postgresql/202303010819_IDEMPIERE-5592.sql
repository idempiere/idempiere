-- IDEMPIERE-5592
SELECT register_migration_script('202303010819_IDEMPIERE-5592.sql') FROM dual;

-- Mar 1, 2023, 8:19:43 AM CET
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,DefaultValue,IsMandatory,IsKey,IsReadOnly,IsAutocomplete,IsQueryAfterChange,IsRange) VALUES (200280,0,0,'Y',TO_TIMESTAMP('2023-03-01 08:19:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-01 08:19:42','YYYY-MM-DD HH24:MI:SS'),100,'Calendar','Accounting Calendar Name','The Calendar uniquely identifies an accounting calendar.  Multiple calendars can be used.  For example you may need a standard calendar that runs from Jan 1 to Dec 31 and a fiscal calendar that runs from July 1 to June 30.',200019,'D','y.C_Calendar_ID',90,'Y','Y',190,19,'2816d437-b6ee-41d8-9da6-5c43dd63bbc8','Y','C_Calendar_ID','=','N',80,'@SQL=SELECT ci.C_Calendar_ID FROM AD_ClientInfo ci WHERE ci.AD_Client_ID=@#AD_Client_ID@','N','N','Y','N','N','N')
;

-- Mar 1, 2023, 8:19:50 AM CET
UPDATE AD_InfoWindow SET WhereClause=NULL, IsValid='Y',Updated=TO_TIMESTAMP('2023-03-01 08:19:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200019
;

-- Mar 1, 2023, 9:08:46 AM CET
UPDATE AD_InfoColumn SET SeqNo=5, SeqNoSelection=5,Updated=TO_TIMESTAMP('2023-03-01 09:08:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200280
;

-- Mar 1, 2023, 9:35:15 AM CET
UPDATE AD_InfoColumn SET IsDisplayed='N', IsMandatory='Y',Updated=TO_TIMESTAMP('2023-03-01 09:35:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200280
;

