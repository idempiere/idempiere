-- IDEMPIERE-6564
SELECT register_migration_script('202506020100_IDEMPIERE-6564.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

CREATE TABLE ad_archive_blob (ad_archive_id NUMBER(10) not null references ad_archive(ad_archive_id) on delete cascade DEFERRABLE INITIALLY DEFERRED, binarydata blob, constraint ad_archive_id_unique unique (ad_archive_id));
