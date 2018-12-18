-- 1008281 - Implement reporting from read-only replica

CREATE TABLE dbreplicasyncverifier (lastupdate date);

INSERT INTO dbreplicasyncverifier values (to_date('1900-01-01 00:00:00', 'yyyy-mm-dd HH24:MI:SS'));

SELECT register_migration_script('201708031855_1008281.sql') FROM dual
;

