ALTER TABLE m_inoutline ADD COLUMN c_invoiceline_id NUMERIC(10) DEFAULT NULL 
;

ALTER TABLE m_inoutline
  ADD CONSTRAINT c_invoiceLine_minoutline FOREIGN KEY (c_invoiceline_id)
  REFERENCES c_invoiceline (c_invoiceline_id)
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
  DEFERRABLE INITIALLY DEFERRED;
