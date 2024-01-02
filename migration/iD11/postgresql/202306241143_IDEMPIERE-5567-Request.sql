-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195) Request
SELECT register_migration_script('202306241143_IDEMPIERE-5567-Request.sql') FROM dual;

-- Jun 24, 2023, 11:43:21 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215854,1,'Record UUID',417,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-06-24 11:43:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-24 11:43:21','YYYY-MM-DD HH24:MI:SS'),100,203804,'N','N','D','Y','N','N','Y','bc1cf1fc-c939-40ec-812f-616fbe68189e','Y','N','N','O','N')
;

-- Jun 24, 2023, 11:43:24 AM CEST
ALTER TABLE R_Request ADD COLUMN Record_UU VARCHAR(36) DEFAULT NULL 
;

-- Jun 24, 2023, 11:46:05 AM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Table_ID@!0',Updated=TO_TIMESTAMP('2023-06-24 11:46:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11179
;

-- Jun 24, 2023, 11:46:22 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207655,'Change Request','BOM (Engineering) Change Request','Change requests for a Bill of Materials. They can be automatically created from Requests, if enabled in the Request Type and the Request Group refers to a Bill of Materials',402,13952,'Y',10,570,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-24 11:46:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-24 11:46:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6ed163da-2362-47dd-ab2c-00336bc392b5','Y',570,2)
;

-- Jun 24, 2023, 11:46:22 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207656,'Quantity Plan','Planned Quantity','Planned Quantity',402,14727,'Y',22,580,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-24 11:46:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-24 11:46:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ec6b1107-4581-45a0-8d93-75d47fdf4af3','Y',580,2)
;

-- Jun 24, 2023, 11:46:23 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207657,'Fixed in','Fixed in Change Notice',402,14981,'Y',10,590,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-24 11:46:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-24 11:46:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8de7366d-03fa-424c-9b0e-91e5a07893ce','Y',590,2)
;

-- Jun 24, 2023, 11:46:23 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207658,'Record UUID',402,215854,'Y',36,600,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-24 11:46:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-24 11:46:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','79804c32-87c3-434c-985d-85350f6d902a','Y',600,2)
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@=''''', SeqNo=470, IsReadOnly='Y', XPosition=4,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207658
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=480, XPosition=4,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11179
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=490,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5176
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=500,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10906
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=510,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5180
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=520,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5842
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=530,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5841
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=540,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5844
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=550,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5843
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=560,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5184
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=570,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11450
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207655
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207657
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0, XPosition=1,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207656
;

-- Jun 24, 2023, 11:49:15 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-06-24 11:49:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205036
;

-- Jun 24, 2023, 11:49:25 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207659,'Record UUID',344,215854,'Y',36,600,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-24 11:49:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-24 11:49:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dc2ce699-ed8c-47de-ae7a-3559af264c73','Y',590,2)
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@!''''', SeqNo=490, IsReadOnly='Y', XPosition=4,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207659
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@=''''', SeqNo=500,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11177
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=510,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4292
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=520,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10905
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=530,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4298
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=540,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5846
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=550,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5845
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=560,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5848
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=570,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5847
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=580,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12748
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=590,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11414
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=600,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4303
;

-- Jun 24, 2023, 11:50:31 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-06-24 11:50:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205035
;

-- Jun 24, 2023, 11:57:32 AM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@='''' & @AD_Table_ID@!0', SeqNo=470,Updated=TO_TIMESTAMP('2023-06-24 11:57:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207658
;

-- Jun 24, 2023, 11:57:32 AM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@='''' & @AD_Table_ID@!0', SeqNo=480,Updated=TO_TIMESTAMP('2023-06-24 11:57:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11179
;

-- Jun 24, 2023, 11:57:58 AM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@!'''' & @AD_Table_ID@!0', SeqNo=490,Updated=TO_TIMESTAMP('2023-06-24 11:57:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207659
;

-- Jun 24, 2023, 11:57:58 AM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@='''' & @AD_Table_ID@!0', SeqNo=500,Updated=TO_TIMESTAMP('2023-06-24 11:57:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11177
;

-- Jun 24, 2023, 12:02:54 PM CEST
UPDATE AD_Field SET DisplayLogic='@Record_UU@!'''' & @AD_Table_ID@!0',Updated=TO_TIMESTAMP('2023-06-24 12:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207658
;

-- Jun 24, 2023, 12:10:06 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201255,'5a052f32-d102-4397-a44b-4684d89cd0eb',TO_TIMESTAMP('2023-06-24 12:10:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','r_request_table_recorduu_idx',TO_TIMESTAMP('2023-06-24 12:10:06','YYYY-MM-DD HH24:MI:SS'),100,417,'N','N','N','N','N')
;

-- Jun 24, 2023, 12:10:29 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201696,'eec90d65-d247-40e2-84b4-bce888dbee11',TO_TIMESTAMP('2023-06-24 12:10:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-06-24 12:10:29','YYYY-MM-DD HH24:MI:SS'),100,13078,201255,10)
;

-- Jun 24, 2023, 12:10:35 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201697,'c2f68e3d-8183-46cc-a896-bbae326aafbb',TO_TIMESTAMP('2023-06-24 12:10:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-06-24 12:10:34','YYYY-MM-DD HH24:MI:SS'),100,215854,201255,20)
;

-- Jun 24, 2023, 12:10:43 PM CEST
CREATE INDEX r_request_table_recorduu_idx ON R_Request (AD_Table_ID,Record_UU)
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
      FROM R_Request a
	JOIN AD_Table t ON (a.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE a.Record_UU IS NULL
	AND a.Record_ID > 0
  LOOP
    cmd := 'UPDATE R_Request SET Record_UU=(SELECT '
      || r.TableName
      || '_UU FROM '
      || r.TableName
      || ' WHERE '
      || r.TableName
      || '_ID=R_Request.Record_ID) WHERE AD_Table_ID='
      || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL';
    EXECUTE cmd;
    GET DIAGNOSTICS v_cnt = ROW_COUNT;
    RAISE NOTICE '% R_Request.Record_UU set in %', v_cnt, r.TableName;
  END LOOP;
END;
$$
;

