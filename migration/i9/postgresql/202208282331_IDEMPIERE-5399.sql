DO $$
<<fix_times>>
DECLARE
  cmd varchar;
  cnt integer;
BEGIN
  FOR cmd IN 
    SELECT 'UPDATE '||t.tablename
        ||' SET '||c.columnname||' = to_timestamp(''1970-01-01 '' || to_char('||c.columnname||', ''HH24:MI:SS''), ''yyyy-mm-dd HH24:MI:SS'')::timestamp '
        ||'WHERE '||c.columnname||' IS NOT NULL AND '
        ||c.columnname||' != to_timestamp(''1970-01-01 '' || to_char('||c.columnname||', ''HH24:MI:SS''), ''yyyy-mm-dd HH24:MI:SS'')::timestamp'
        AS cmd
    FROM ad_table t JOIN ad_column c USING (ad_table_id)
    WHERE c.ad_reference_id = 24
    AND t.isview='N'
    ORDER BY t.tablename, c.columnname
  LOOP
	EXECUTE cmd;
    GET DIAGNOSTICS cnt = ROW_COUNT;
    RAISE NOTICE '%', cmd;
    RAISE NOTICE '% rows updated', cnt;
  END LOOP;
END fix_times
$$;

SELECT register_migration_script('202208282331_IDEMPIERE-5399.sql') FROM dual
;

