CREATE OR REPLACE FUNCTION register_migration_script
(
    p_script IN VARCHAR2
)
RETURN VARCHAR2
IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_return VARCHAR2(255);
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
             p_script, 'oracle/'||p_script, 0, 
             0, SYSDATE, 100, 
             SYSDATE, 100, 'Y', 
             nextidfunc(53081,'N')); 
    ELSE
        v_return := p_script || ' was already applied';
        DBMS_OUTPUT.PUT_LINE(v_return);
	UPDATE ad_migrationscript
	    SET updated=SYSDATE, description = COALESCE(description, ' ') || ' reapplied'
	    WHERE ad_migrationscript_id = v_scriptid;
    END IF;
    COMMIT;
    RETURN v_return;
END register_migration_script;
/

