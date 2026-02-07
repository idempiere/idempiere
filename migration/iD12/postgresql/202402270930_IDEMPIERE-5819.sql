-- IDEMPIERE-5819
SELECT register_migration_script('202402270930_IDEMPIERE-5819.sql') FROM dual;

CREATE OR REPLACE FUNCTION adempiere.alter_view(p_viewname NAME)
    RETURNS TEXT
    LANGUAGE plpgsql
AS $function$
DECLARE
    i                   INT     := 0;
    table_id            INT;
    view_component      RECORD;
    view_column         RECORD;
    view_selects        TEXT    := '';
    view_ddl            TEXT    := '';
BEGIN

    SELECT AD_Table_ID INTO table_id FROM AD_Table WHERE LOWER(TableName) = LOWER(p_viewname) AND IsView = 'Y';

    view_ddl := 'CREATE OR REPLACE VIEW adempiere.' || p_viewname || ' (';

    FOR view_component IN
        SELECT AD_ViewComponent_ID, FromClause, WhereClause, OtherClause, IsUnionAll
        FROM AD_ViewComponent
        WHERE AD_Table_ID = table_id
        ORDER BY SeqNo, Created
    LOOP
        IF i > 0 THEN
            IF view_component.IsUnionAll THEN
                view_selects := view_selects || ' UNION ALL ';
            ELSE
                view_selects := view_selects || ' UNION ';
            END IF;
        END IF;

        view_selects := view_selects || '( SELECT ';

        FOR view_column IN
            SELECT ColumnSQL, ColumnName
            FROM AD_ViewColumn
            WHERE AD_ViewComponent_ID = view_component.AD_ViewComponent_ID
            ORDER BY SeqNo, Created
        LOOP
            IF i = 0 THEN
                view_ddl := view_ddl || view_column.ColumnName || ', ';
            END IF;

            view_selects := view_selects || view_column.ColumnSQL || ' AS ' || view_column.ColumnName || ', ';
        END LOOP;

        IF i = 0 THEN
            view_ddl := TRIM(', ' FROM view_ddl);
            view_ddl := view_ddl || ') AS ';
        END IF;

        view_selects := TRIM(', ' FROM view_selects);
        view_selects := view_selects || ' ' || view_component.FromClause || ' ' || COALESCE(view_component.WhereClause, '') || ' ' || COALESCE(view_component.OtherClause, '') || ') ';
        i := i + 1;
    END LOOP;

    view_ddl := view_ddl || view_selects;
    PERFORM adempiere.alter_view(p_viewname, view_ddl);

    RETURN view_ddl;

END
$function$
;

CREATE OR REPLACE FUNCTION adempiere.alter_view(p_viewname NAME, p_viewddl TEXT)
    RETURNS void
    LANGUAGE plpgsql
AS $function$
DECLARE
    depencencies_names      TEXT[];
    depencencies_ddl        TEXT[];
    i                       INT;
    dependency              RECORD;
BEGIN

    i := 0;
    FOR dependency IN
        WITH RECURSIVE depv(relname, depth) AS (
            SELECT DISTINCT a.relname, 1
                FROM pg_class a, pg_depend b, pg_depend c, pg_class d
                WHERE a.oid = b.refobjid
                AND b.objid = c.objid
                AND b.refobjid <> c.refobjid
                AND c.refobjid = d.oid
                AND d.relname = lower(p_viewname)
                AND c.refobjsubid > 0
                AND d.relkind = 'v'
                AND a.relkind = 'v'
            UNION ALL
            SELECT DISTINCT dependee.relname, depv.depth+1
                FROM pg_depend 
                JOIN pg_rewrite ON pg_depend.objid = pg_rewrite.oid 
                JOIN pg_class AS dependee ON pg_rewrite.ev_class = dependee.oid 
                JOIN pg_class AS dependent ON pg_depend.refobjid = dependent.oid 
                JOIN depv ON dependent.relname = depv.relname
            WHERE pg_depend.refobjsubid > 0
        )
        SELECT relname, MAX(depth) FROM depv GROUP BY relname ORDER BY 2 DESC
    LOOP
        i := i + 1;
        depencencies_names[i] := dependency.relname;
        depencencies_ddl[i] := pg_get_viewdef(dependency.relname);
    END LOOP;

    BEGIN
        FOR j IN 1..i
        LOOP
            EXECUTE 'DROP VIEW ' || depencencies_names[j];
        END LOOP;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPTION '%. Failed to drop % dependent view.', SQLERRM, depencencies_names[j];
    END;

    BEGIN
        EXECUTE 'DROP VIEW IF EXISTS ' || p_viewname;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPTION '%. Failed to drop % view.', SQLERRM, p_viewname;
    END;

    BEGIN
        EXECUTE p_viewddl;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPTION '%. Failed to create % view: %', SQLERRM, p_viewname, p_viewddl;
    END;

    BEGIN
        FOR j IN REVERSE i..1
        LOOP
            EXECUTE 'CREATE VIEW ' || depencencies_names[j] || ' AS ' || depencencies_ddl[j];
        END LOOP;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE EXCEPTION '%. Failed to recreate % dependent view: %', SQLERRM, depencencies_names[j], depencencies_ddl[j];
    END;

END
$function$
;

CREATE TABLE t_alter_view(viewname NAME);

CREATE RULE alter_view_rule AS ON INSERT TO t_alter_view
DO INSTEAD SELECT adempiere.alter_view(new.viewname);

