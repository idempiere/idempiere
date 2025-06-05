-- IDEMPIERE-6564
SELECT register_migration_script('202506020100_IDEMPIERE-6564.sql') FROM dual;

CREATE TABLE ad_archive_blob (ad_archive_id numeric(10, 0) not null references ad_archive(ad_archive_id) on delete cascade DEFERRABLE INITIALLY DEFERRED, binarydata oid, unique(ad_archive_id));


