CREATE OR REPLACE FUNCTION add_missing_translations() RETURNS void as $func$
DECLARE
   suffix     VARCHAR (3);
   ins        VARCHAR (2000);
   sel        VARCHAR (2000);
   inssel     VARCHAR (4001);
   table_id   NUMERIC;
   t	      RECORD;
   c	      RECORD;
BEGIN

   FOR t IN (SELECT ad_table_id,
                    SUBSTR (tablename, 1, LENGTH (tablename) - 4) as tablename
               FROM AD_TABLE
              WHERE tablename LIKE '%_Trl' AND isactive = 'Y'
                    AND isview = 'N'
              ORDER BY tablename)
   LOOP
      IF EXISTS (
          SELECT 1
              FROM AD_Column cl
              JOIN AD_Table tb ON (cl.AD_Table_ID=tb.AD_Table_ID)
              WHERE tb.TableName=t.tablename AND cl.IsKey='Y' AND cl.ColumnName LIKE '%_ID') THEN
          suffix := '_id';
      ELSE
          suffix := '_uu';
      END IF;
      ins :=
            'INSERT INTO '
         || t.tablename
         || '_Trl ('
         || 'ad_language,ad_client_id,ad_org_id,created,createdby,updated,updatedby,isactive,istranslated,'
         || t.tablename
         || '_Trl_UU,'
         || t.tablename
         || suffix;
      sel :=
            'SELECT l.ad_language,t.ad_client_id,t.ad_org_id,statement_timestamp(),10,statement_timestamp(),10,t.isactive,''N'' as istranslated,generate_uuid(),'
         || t.tablename
         || suffix;

      SELECT ad_table_id
        INTO table_id
        FROM AD_TABLE
       WHERE tablename = t.tablename;

      FOR c IN (SELECT   col.columnname
                    FROM AD_COLUMN col INNER JOIN AD_TABLE tab
                         ON (col.ad_table_id = tab.ad_table_id)
                   WHERE col.ad_table_id = table_id
                     AND col.istranslated = 'Y'
                     AND col.isactive = 'Y'
                ORDER BY 1)
      LOOP
         ins := TRIM (ins) || ',' || TRIM (c.columnname);
         sel := TRIM (sel) || ',t.' || TRIM (c.columnname);
      END LOOP;

      ins := TRIM (ins) || ')';
      sel :=
            TRIM (sel)
         || ' from '
         || t.tablename
         || ' t, ad_language l WHERE l.issystemlanguage=''Y'' AND NOT EXISTS (SELECT 1 FROM '
         || t.tablename
         || '_Trl b WHERE b.'
         || t.tablename
         || suffix || '=t.'
         || t.tablename
         || suffix || ' AND b.AD_LANGUAGE=l.AD_LANGUAGE)';
      inssel := TRIM (ins) || ' ' || TRIM (sel);

      EXECUTE inssel;
   END LOOP;

END;
$func$ LANGUAGE plpgsql;

select add_missing_translations();

