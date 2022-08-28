SET SERVEROUTPUT ON

BEGIN
   FOR r IN (
SELECT 'UPDATE '||t.tablename
        ||' SET '||c.columnname||' = TO_DATE(''1970-01-01 '' || to_char('||c.columnname||', ''HH24:MI:SS''), ''yyyy-mm-dd HH24:MI:SS'') '
        ||'WHERE '||c.columnname||' IS NOT NULL AND '
        ||c.columnname||' != TO_DATE(''1970-01-01 '' || to_char('||c.columnname||', ''HH24:MI:SS''), ''yyyy-mm-dd HH24:MI:SS'')'
        AS cmd
    FROM ad_table t JOIN ad_column c USING (ad_table_id)
    WHERE c.ad_reference_id = 24
    AND t.isview='N'
    ORDER BY t.tablename, c.columnname
)
   LOOP
      EXECUTE IMMEDIATE r.cmd;
      DBMS_OUTPUT.PUT_LINE(r.cmd);
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SQL%ROWCOUNT) || ' rows affected');
   END LOOP;
END;
/

SELECT register_migration_script('202208282331_IDEMPIERE-5399.sql') FROM dual
;

