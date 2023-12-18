-- IDEMPIERE-5567 AD_Package_Imp_Detail
SELECT register_migration_script('202311261658_IDEMPIERE-5567-PackInDetail.sql') FROM dual;

-- Nov 26, 2023, 4:58:59 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216129,0,'Record UUID',50004,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-11-26 16:58:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 16:58:58','YYYY-MM-DD HH24:MI:SS'),100,203804,'N','N','D','N','N','N','Y','a0f0e5fb-ecaf-4954-8b91-05d9eb8359b3','Y','N','N','M','N')
;

-- Nov 26, 2023, 4:59:24 PM CET
UPDATE AD_Column SET FieldLength=36, IsUpdateable='Y', IsAlwaysUpdateable='Y', IsAllowLogging='N', FKConstraintType='D',Updated=TO_TIMESTAMP('2023-11-26 16:59:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216129
;

-- Nov 26, 2023, 4:59:32 PM CET
ALTER TABLE AD_Package_Imp_Detail ADD COLUMN Record_UU VARCHAR(36) DEFAULT NULL 
;

-- Nov 26, 2023, 5:00:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207960,'Record UUID',50004,216129,'Y',36,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-11-26 17:00:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-26 17:00:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3eac3574-410a-4882-948b-c8a7ccef6a01','Y',100,2)
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50059
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50062
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50060
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=4,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207960
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50058
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50064
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50061
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50057
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206751
;

-- Nov 26, 2023, 5:01:52 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-11-26 17:01:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206752
;

-- Nov 26, 2023, 5:02:11 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4,Updated=TO_TIMESTAMP('2023-11-26 17:02:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207960
;

-- Nov 26, 2023, 5:02:11 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-11-26 17:02:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50060
;

-- Nov 26, 2023, 5:02:45 PM CET
UPDATE AD_Field SET DisplayLogic='@Record_UU@!'''' & @AD_Table_ID@!0',Updated=TO_TIMESTAMP('2023-11-26 17:02:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207960
;

-- Nov 26, 2023, 5:03:25 PM CET
UPDATE AD_Field SET DisplayLogic='@Record_UU@=''''',Updated=TO_TIMESTAMP('2023-11-26 17:03:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50060
;

-- Nov 26, 2023, 5:03:41 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Table_ID@!0',Updated=TO_TIMESTAMP('2023-11-26 17:03:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50062
;

-- Nov 26, 2023, 5:07:20 PM CET
UPDATE AD_Field SET SeqNo=50, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-11-26 17:07:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204348
;

-- Set Record_UU for existing records
DO $$
DECLARE
  cmd varchar(2000);
  r record;
  v_cnt numeric;
BEGIN
  FOR r IN
    SELECT DISTINCT t.TableName, a.AD_Table_ID
      FROM AD_Package_Imp_Detail a
	JOIN AD_Table t ON (a.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE a.Record_UU IS NULL
	AND a.AD_Table_ID > 0
	AND a.Record_ID > 0
  LOOP
    cmd := 'UPDATE AD_Package_Imp_Detail SET Record_UU=(SELECT '
      || r.TableName
      || '_UU FROM '
      || r.TableName
      || ' WHERE '
      || r.TableName
      || '_ID=AD_Package_Imp_Detail.Record_ID) WHERE AD_Table_ID='
      || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL';
    EXECUTE cmd;
    GET DIAGNOSTICS v_cnt = ROW_COUNT;
    RAISE NOTICE '% AD_Package_Imp_Detail.Record_UU set in %', v_cnt, r.TableName;
  END LOOP;
END;
$$
;

