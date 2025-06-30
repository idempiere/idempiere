--IDEMPIERE-6570
SELECT register_migration_script('202506050700_IDEMPIERE-6570.sql') FROM dual;

CREATE TABLE ad_attachment_entry (ad_attachment_id numeric(10, 0) not null references ad_attachment(ad_attachment_id) on delete cascade DEFERRABLE INITIALLY DEFERRED, seqno numeric(10, 0) not null, binarydata oid, unique(ad_attachment_id, seqno));
