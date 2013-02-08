-- IDEMPIERE-294 Maintenance / Fix wrong datatype of column on DB
ALTER TABLE ad_broadcastmessage DROP COLUMN notification_client_id
;

ALTER TABLE ad_broadcastmessage ADD (notification_client_id NUMBER(10,0) NULL)
;


SELECT register_migration_script('201301291717_IDEMPIERE-294.sql') FROM dual
;

