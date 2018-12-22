-- 1008281 - Implement reporting from read-only replica

CREATE TABLE dbreplicasyncverifier (lastupdate timestamp);

INSERT INTO dbreplicasyncverifier values (to_timestamp('1900-01-01 00:00:00', 'yyyy-mm-dd HH24:MI:SS'));

CREATE OR REPLACE RULE insert_dual AS ON INSERT TO dual DO INSTEAD NOTHING;

CREATE OR REPLACE RULE delete_dual AS ON DELETE TO dual DO INSTEAD NOTHING;

SELECT register_migration_script('201708031855_1008281.sql') FROM dual
;

