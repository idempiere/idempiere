-- IDEMPIERE-6617
SELECT register_migration_script('202507100820_IDEMPIERE-6617.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

CREATE TABLE ad_image_blob (ad_image_id NUMBER(10) not null references ad_image(ad_image_id) on delete cascade DEFERRABLE INITIALLY DEFERRED, binarydata blob, constraint ad_image_id_unique unique (ad_image_id));
