-- IDEMPIERE-3850 AP2-4 1008281 - Implement reporting from read-only replica

CREATE OR REPLACE RULE insert_dbreplicasyncverifier AS ON INSERT TO dbreplicasyncverifier DO INSTEAD NOTHING;

CREATE OR REPLACE RULE delete_dbreplicasyncverifier AS ON DELETE TO dbreplicasyncverifier DO INSTEAD NOTHING;

SELECT register_migration_script('201902281146_IDEMPIERE-3850.sql') FROM dual
;

