--IDEMPIERE-6570
SELECT register_migration_script('202506050700_IDEMPIERE-6570.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

CREATE TABLE ad_attachment_entry (ad_attachment_id number(10) not null references ad_attachment(ad_attachment_id) on delete cascade DEFERRABLE INITIALLY DEFERRED, seqno number(10) not null, binarydata blob, constraint ad_attachment_entry_unique unique(ad_attachment_id, seqno));
