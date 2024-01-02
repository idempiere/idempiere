-- IDEMPIERE-5567 Support of UUID - ChangeLog (FHCA-4195)
SELECT register_migration_script('202304151832_IDEMPIERE-5567.sql') FROM dual;

-- Apr 15, 2023, 6:32:28 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215835,0,'Record UUID',580,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-04-15 18:32:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-15 18:32:27','YYYY-MM-DD HH24:MI:SS'),100,203804,'N','N','D','N','N','N','Y','42c26432-ba61-4375-901b-5573a94b3ca3','Y',0,'N','N','N','N')
;

-- Apr 15, 2023, 6:32:30 PM CEST
ALTER TABLE AD_ChangeLog ADD COLUMN Record_UU VARCHAR(36) DEFAULT NULL 
;

-- Apr 15, 2023, 6:34:30 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2023-04-15 18:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8817
;

-- Apr 15, 2023, 6:34:32 PM CEST
INSERT INTO t_alter_column values('ad_changelog','Record_ID','NUMERIC(10)',null,'NULL')
;

-- Apr 15, 2023, 6:34:32 PM CEST
INSERT INTO t_alter_column values('ad_changelog','Record_ID',null,'NULL',null)
;

-- Apr 15, 2023, 6:34:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207619,'Record UUID',488,215835,'Y',36,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-15 18:34:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-15 18:34:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','863e5828-5d78-43d9-bfd6-ef0bd26c6980','Y',190,2)
;

-- Apr 15, 2023, 6:34:50 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207620,'Record UUID',487,215835,'Y',36,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-04-15 18:34:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-15 18:34:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dab3415a-c850-401f-8b9a-891e60e2999e','Y',190,2)
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207619
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=1,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6779
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6774
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10946
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54397
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6780
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6773
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12356
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10948
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10947
;

-- Apr 15, 2023, 6:35:45 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-04-15 18:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204473
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207620
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=1,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6769
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6764
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10949
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54396
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6770
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6763
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12357
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10951
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10950
;

-- Apr 15, 2023, 6:35:59 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-04-15 18:35:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204474
;

-- May 21, 2023, 4:07:46 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=53370 | @AD_Reference_ID@=200233 | @AD_Reference_ID@=200234 | @AD_Reference_ID@=200235 | @AD_Reference_ID@=200202 | @AD_Reference_ID@=200240',Updated=TO_TIMESTAMP('2023-05-21 16:07:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- May 21, 2023, 4:13:15 PM CEST
UPDATE AD_Val_Rule SET Code='(
    AD_Ref_List.Value = ''D''
/* Cascade/SetNull/Forbid supported for all DB constraints */
OR (AD_Ref_List.Value IN (''C'',''S'',''N'') AND @AD_Reference_ID@ IN (18,19,21,25,30,31,32,33,35,53370,200233,200234,200235))
/* ModelCascade supported for Table/TableDir/Search/RecordID */
OR (AD_Ref_List.Value = ''M''            AND @AD_Reference_ID@ IN (18,19,30,200202,200240))
/* ModelSetNull/ModelForbid supported for RecordID */
OR (AD_Ref_List.Value IN (''T'',''O'')     AND @AD_Reference_ID@ IN (200202,200240))
)',Updated=TO_TIMESTAMP('2023-05-21 16:13:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200064
;

-- May 21, 2023, 4:14:25 PM CEST
UPDATE AD_Column SET FieldLength=36, FKConstraintType='D',Updated=TO_TIMESTAMP('2023-05-21 16:14:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215833
;

-- May 22, 2023, 5:37:16 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200228,0,0,TO_TIMESTAMP('2023-05-22 17:37:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-05-22 17:37:15','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','AD_CHANGELOG_SAVE_UUID','B','Save the AD_ChangeLog.Record_UU ->  B | Just for UUID based tables , A | Always , U | just UUID not ID','D','S','32161230-22c9-43eb-a327-f3b4841eeace')
;

-- May 23, 2023, 5:17:25 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201247,'d0ab3ee4-418c-42e9-acfe-618750685bcc',TO_TIMESTAMP('2023-05-23 17:17:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_changelog_record_uu',TO_TIMESTAMP('2023-05-23 17:17:24','YYYY-MM-DD HH24:MI:SS'),100,580,'N','N','N','N')
;

-- May 23, 2023, 5:17:48 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201686,'6ce73812-0b30-4145-a9c5-ab1c73d4c386',TO_TIMESTAMP('2023-05-23 17:17:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-23 17:17:47','YYYY-MM-DD HH24:MI:SS'),100,215835,201247,10)
;

-- May 23, 2023, 5:17:53 PM CEST
CREATE INDEX ad_changelog_record_uu ON AD_ChangeLog (Record_UU)
;

/*
-- Set Record_UU for existing records
DO $$
DECLARE
  cmd varchar(2000);
  r record;
  v_cnt numeric;
BEGIN
  FOR r IN
    SELECT DISTINCT t.TableName, cl.AD_Table_ID
      FROM AD_ChangeLog cl
	JOIN AD_Table t ON (cl.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE cl.Record_UU IS NULL
	AND cl.Record_ID IS NOT NULL
	AND cl.EventChangeLog!='D'
  LOOP
    cmd := 'UPDATE AD_ChangeLog SET Record_UU=(SELECT '
      || r.TableName
      || '_UU FROM '
      || r.TableName
      || ' WHERE '
      || r.TableName
      || '_ID=AD_ChangeLog.Record_ID) WHERE AD_Table_ID='
      || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL AND EventChangeLog!=''D''';
    EXECUTE cmd;
    GET DIAGNOSTICS v_cnt = ROW_COUNT;
    RAISE NOTICE '% AD_ChangeLog.Record_UU set in %', v_cnt, r.TableName;
  END LOOP;
END;
$$
;
*/

