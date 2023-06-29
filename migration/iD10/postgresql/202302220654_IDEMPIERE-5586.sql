-- IDEMPIERE-5586
SELECT register_migration_script('202302220654_IDEMPIERE-5586.sql') FROM dual;

CREATE OR REPLACE FUNCTION torecordid(
	p_tablename  IN 	VARCHAR,
	p_uu_value IN 	VARCHAR
)
  RETURNS INTEGER AS $body$
DECLARE
     id_column VARCHAR;
     uu_column VARCHAR;
     o_id INTEGER;
BEGIN
     SELECT a.ColumnName 
     INTO id_column
     FROM AD_Column a 
     JOIN AD_Table b ON (a.AD_Table_ID=b.AD_Table_ID) 
     WHERE a.IsActive='Y' AND a.IsKey='Y' AND  lower(b.TableName) = lower(p_tablename);

     IF (id_column IS NULL) THEN
         RAISE EXCEPTION 'ID column not found for table %', p_tablename;
     END IF;

     IF (length(p_tablename) <= 27) THEN
         uu_column = p_tablename || '_UU';
     ELSE
         SELECT a.ColumnName 
         INTO uu_column
         FROM AD_Column a 
        JOIN AD_Table b ON (a.AD_Table_ID=b.AD_Table_ID) 
         WHERE a.IsActive='Y' AND a.FieldLength=36  AND lower(ColumnName) like (lower(substring(p_tablename from 0 for 27)) || '%UU')
         AND  lower(b.TableName) = lower(p_tablename);
     END IF;
     
     IF (uu_column IS NULL) THEN
         RAISE EXCEPTION 'UUID column not found for table %', p_tablename;
     END IF;

     EXECUTE 'SELECT ' || quote_ident(lower(id_column)) || ' FROM ' || quote_ident(lower(p_tablename)) || ' WHERE ' ||  uu_column || '=$1'
     INTO STRICT o_id
     USING p_uu_value;

     RETURN o_id;
END;
$body$ LANGUAGE plpgsql
;


