/*

CREATE TABLE ad_attachment_entry (ad_attachment_id numeric(10, 0) not null references ad_attachment(ad_attachment_id) on delete cascade DEFERRABLE INITIALLY DEFERRED, seqno numeric(10, 0) not null, binarydata oid, unique(ad_attachment_id, seqno));

*/

CREATE OR REPLACE FUNCTION delete_ad_attachment_binary()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.binarydata IS NOT NULL AND OLD.binarydata <> 0 THEN
        PERFORM lo_unlink(OLD.binarydata);
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_ad_attachment_binary
BEFORE DELETE ON ad_attachment_entry
FOR EACH ROW
EXECUTE FUNCTION delete_ad_attachment_binary();

