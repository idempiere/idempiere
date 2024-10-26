CREATE OR REPLACE FUNCTION register_migration_script(IN p_script character varying) RETURNS character varying AS
$BODY$
DECLARE
    v_return CHARACTER VARYING;
    v_scriptid INTEGER;
BEGIN
    v_return := p_script || ' successfully registered';
    UPDATE AD_System
      SET LastMigrationScriptApplied=p_script
    WHERE LastMigrationScriptApplied<p_script
       OR LastMigrationScriptApplied IS NULL;
    SELECT MAX(AD_MigrationScript_ID)
	INTO v_scriptid
        FROM AD_MigrationScript
	WHERE Name = p_script;
    IF (v_scriptid IS NULL)
    THEN
        INSERT INTO ad_migrationscript 
            (isapply, scriptroll, ad_migrationscript_uu, 
             status, projectname, releaseno, 
             name, filename, ad_client_id, 
             ad_org_id, created, createdby, 
             updated, updatedby, isactive, 
             ad_migrationscript_id) 
        VALUES
            ('Y', 'N', generate_uuid(),
             'CO', 'iDempiere', (select releaseno from ad_system), 
             p_script, 'postgresql/'||p_script, 0, 
             0, now(), 100, 
             now(), 100, 'Y', 
             nextidfunc(53081,'N')); 
    ELSE
        v_return := p_script || ' was already applied';
        RAISE NOTICE '%', v_return;
	UPDATE ad_migrationscript
	    SET updated=now(), description = COALESCE(description, ' ') || ' reapplied'
	    WHERE ad_migrationscript_id = v_scriptid;
    END IF;
    RETURN v_return;
END;
$BODY$
LANGUAGE plpgsql;

CREATE VIEW dual AS SELECT 'X'::varchar AS dummy
;

