-- IDEMPIERE-5586
SELECT register_migration_script('202302220654_IDEMPIERE-5586.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

CREATE OR REPLACE FUNCTION torecordid (
   p_tablename IN VARCHAR2,
   p_uu_value IN VARCHAR2
)
RETURN NUMBER AS 
  id_column VARCHAR2(200);
  uu_column VARCHAR2(200);
  o_id NUMBER;
BEGIN
  SELECT a.ColumnName 
  INTO id_column
  FROM AD_Column a 
  JOIN AD_Table b ON (a.AD_Table_ID=b.AD_Table_ID) 
  WHERE a.IsActive='Y' AND a.IsKey='Y' AND lower(b.TableName) = lower(p_tablename);

  IF (id_column IS NULL) THEN
    raise_application_error(-20001, 'ID column not found for table ' || p_tablename);
  END IF;

  IF (length(p_tablename) <= 27) THEN
    uu_column := p_tablename || '_UU';
  ELSE
    SELECT a.ColumnName 
    INTO uu_column
    FROM AD_Column a 
    JOIN AD_Table b ON (a.AD_Table_ID=b.AD_Table_ID) 
    WHERE a.IsActive='Y' AND a.FieldLength=36 AND lower(a.ColumnName) LIKE (lower(SUBSTR(p_tablename, 1, 27)) || '%UU')
      AND lower(b.TableName) = lower(p_tablename);
  END IF;

  IF (uu_column IS NULL) THEN
    raise_application_error(-20002, 'UUID column not found for table ' || p_tablename);
  END IF;

  EXECUTE IMMEDIATE 'SELECT ' || id_column || ' FROM ' || p_tablename || ' WHERE ' || uu_column || '=:1'
  INTO o_id
  USING p_uu_value;

  RETURN o_id;
END;
/
