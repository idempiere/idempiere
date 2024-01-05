-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202305231609_IDEMPIERE-5567.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 23, 2023, 4:09:37 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215841,0,'Record UUID',200000,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-05-23 16:09:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-23 16:09:37','YYYY-MM-DD HH24:MI:SS'),100,203804,'N','N','D','N','N','N','N','e4000430-78d0-42f3-bb99-d4cf8d32df5f','N','N','N','M','N')
;

-- May 23, 2023, 4:09:45 PM CEST
ALTER TABLE AD_RecentItem ADD Record_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;


SET SERVEROUTPUT on;

-- Set Record_UU for existing records
DECLARE
  cmd varchar2(2000);
  v_cnt numeric;
BEGIN
  FOR r IN (
    SELECT DISTINCT t.TableName, ri.AD_Table_ID
      FROM AD_RecentItem ri
	JOIN AD_Table t ON (ri.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE ri.Record_UU IS NULL
	AND ri.Record_ID IS NOT NULL
  ) LOOP
    cmd := 'UPDATE AD_RecentItem SET Record_UU=(SELECT '
      || r.TableName
      || '_UU FROM '
      || r.TableName
      || ' WHERE '
      || r.TableName
      || '_ID=AD_RecentItem.Record_ID) WHERE AD_Table_ID='
      || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL';
    EXECUTE IMMEDIATE cmd;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' AD_RecentItem.Record_UU set in ' || r.TableName);
  END LOOP;
END;
/

-- May 23, 2023, 7:17:27 PM CEST
DROP INDEX AD_RecentItem_Record_ID_AD_Table_ID
;

-- May 23, 2023, 7:17:34 PM CEST
UPDATE AD_TableIndex SET Name='AD_RecentItem_Record_UU_AD_Table_ID',Updated=TO_TIMESTAMP('2023-05-23 19:17:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201116
;

-- May 23, 2023, 7:17:39 PM CEST
UPDATE AD_IndexColumn SET AD_Column_ID=215841,Updated=TO_TIMESTAMP('2023-05-23 19:17:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201489
;

-- May 23, 2023, 7:17:44 PM CEST
CREATE INDEX AD_RecentItem_Record_UU_AD_Table_ID ON AD_RecentItem (Record_UU,AD_Table_ID)
;

-- May 23, 2023, 7:18:09 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201248,'3247c587-b7fb-4b66-93a5-ad05d386e0c5',TO_TIMESTAMP('2023-05-23 19:18:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_RecentItem_AD_User_ID',TO_TIMESTAMP('2023-05-23 19:18:08','YYYY-MM-DD HH24:MI:SS'),100,200000,'N','N','N','N','N')
;

-- May 23, 2023, 7:18:19 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201687,'a10d5fdb-351f-4798-a4d8-4e5f3de4995b',TO_TIMESTAMP('2023-05-23 19:18:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-23 19:18:17','YYYY-MM-DD HH24:MI:SS'),100,200006,201248,10)
;

-- May 23, 2023, 7:18:27 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201688,'a06c4a1d-b923-479c-9415-e2d049e2ac90',TO_TIMESTAMP('2023-05-23 19:18:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-05-23 19:18:27','YYYY-MM-DD HH24:MI:SS'),100,200000,201248,20)
;

-- May 23, 2023, 7:18:32 PM CEST
CREATE INDEX AD_RecentItem_AD_User_ID ON AD_RecentItem (AD_User_ID,AD_Client_ID)
;

-- May 26, 2023, 7:30:07 PM CEST
UPDATE AD_Column SET IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2023-05-26 19:30:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200011
;

-- May 26, 2023, 7:30:10 PM CEST
ALTER TABLE AD_RecentItem MODIFY Record_ID NUMBER(10) DEFAULT NULL 
;

-- May 26, 2023, 7:30:10 PM CEST
ALTER TABLE AD_RecentItem MODIFY Record_ID NULL
;

