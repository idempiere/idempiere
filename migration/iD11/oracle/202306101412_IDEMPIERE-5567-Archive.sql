-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202306101412_IDEMPIERE-5567-Archive.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 10, 2023, 2:12:27 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215850,0,'Record UUID',754,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-06-10 14:12:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-10 14:12:27','YYYY-MM-DD HH24:MI:SS'),100,203804,'Y','N','D','N','N','N','Y','85e84f16-6122-46ec-9048-39cb57718754','Y',0,'N','N','M','N')
;

-- Jun 10, 2023, 2:12:29 PM CEST
ALTER TABLE AD_Archive ADD Record_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Jun 10, 2023, 3:46:29 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201253,'9208ce54-2d15-4640-acee-6ccc5729c62e',TO_TIMESTAMP('2023-06-10 15:46:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_archive_tab_rec',TO_TIMESTAMP('2023-06-10 15:46:29','YYYY-MM-DD HH24:MI:SS'),100,754,'N','N','N','N','N')
;

-- Jun 10, 2023, 3:46:43 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201693,'1bc7c2c5-c99c-4803-94fc-1ee5c82236d4',TO_TIMESTAMP('2023-06-10 15:46:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-06-10 15:46:43','YYYY-MM-DD HH24:MI:SS'),100,13070,201253,10)
;

-- Jun 10, 2023, 3:46:48 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201694,'1ac17e80-215d-4266-9cf6-5c1bf51fbed7',TO_TIMESTAMP('2023-06-10 15:46:47','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-06-10 15:46:47','YYYY-MM-DD HH24:MI:SS'),100,215850,201253,20)
;

-- Jun 10, 2023, 3:46:51 PM CEST
CREATE INDEX ad_archive_tab_rec ON AD_Archive (AD_Table_ID,Record_UU)
;

-- Jun 10, 2023, 3:47:02 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201254,'4751d300-f63a-4ae2-b9f5-2a7309edd93f',TO_TIMESTAMP('2023-06-10 15:47:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_archive_c_bpartner',TO_TIMESTAMP('2023-06-10 15:47:02','YYYY-MM-DD HH24:MI:SS'),100,754,'N','N','N','N','N')
;

-- Jun 10, 2023, 3:47:07 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201695,'779b9d2a-f83c-4582-89f2-1a6f096bdd80',TO_TIMESTAMP('2023-06-10 15:47:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-06-10 15:47:06','YYYY-MM-DD HH24:MI:SS'),100,13075,201254,10)
;

-- Jun 10, 2023, 3:47:10 PM CEST
CREATE INDEX ad_archive_c_bpartner ON AD_Archive (C_BPartner_ID)
;


SET SERVEROUTPUT on;

-- Set Record_UU for existing records
DECLARE
  cmd varchar2(2000);
  v_cnt numeric;
BEGIN
  FOR r IN (
    SELECT DISTINCT t.TableName, a.AD_Table_ID
      FROM AD_Archive a
	JOIN AD_Table t ON (a.AD_Table_ID=t.AD_Table_ID AND EXISTS (SELECT 1 FROM AD_Column WHERE ColumnName=t.TableName||'_ID'))
      WHERE a.Record_UU IS NULL
	AND a.Record_ID > 0
  ) LOOP
    cmd := 'UPDATE AD_Archive SET Record_UU=(SELECT '
      || r.TableName
      || '_UU FROM '
      || r.TableName
      || ' WHERE '
      || r.TableName
      || '_ID=AD_Archive.Record_ID) WHERE AD_Table_ID='
      || r.AD_Table_ID
      || ' AND Record_ID IS NOT NULL AND Record_UU IS NULL';
    EXECUTE IMMEDIATE cmd;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' AD_Archive.Record_UU set in ' || r.TableName);
  END LOOP;
END;
/

