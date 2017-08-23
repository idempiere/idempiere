SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3424 table m_movement / constraint cbpartnerlocation_mmovement incorrect
-- Jul 20, 2017 20:13:32 PM CEST
ALTER TABLE m_movement DROP CONSTRAINT cbpartnerlocation_mmovement
;

ALTER TABLE M_Movement ADD CONSTRAINT cbpartnerlocation_mmovement FOREIGN KEY (C_BPartner_Location_ID) REFERENCES c_bpartner_location(c_bpartner_location_id) DEFERRABLE INITIALLY DEFERRED
;


SELECT register_migration_script('201707202213_IDEMPIERE-3424.sql') FROM dual
;

