-- IDEMPIERE-5240 UUID performance improvement considerations
SELECT register_migration_script('202310201218_IDEMPIERE-5240.sql') FROM dual;

-- First we need to drop the foreign constraints pointintg to the UUID keys that we are going to change
ALTER TABLE testuudet DROP CONSTRAINT alttestuuuu_testuudet;

ALTER TABLE testuudet DROP CONSTRAINT testuuuu_testuudet;

-- Then defaults must be changed to ::uuid instead of ::varchar

ALTER TABLE test ALTER COLUMN test_uu SET DEFAULT NULL::uuid;

ALTER TABLE testuu ALTER COLUMN testuu_uu SET DEFAULT NULL::uuid;

ALTER TABLE testuudet ALTER COLUMN testuudet_uu SET DEFAULT NULL::uuid;

-- Then alter the column, postgresql takes care of the migration

ALTER TABLE test ALTER COLUMN test_uu TYPE uuid USING test_uu::uuid::uuid;

ALTER TABLE testuu ALTER COLUMN testuu_uu TYPE uuid USING testuu_uu::uuid::uuid;

ALTER TABLE testuudet ALTER COLUMN testuudet_uu TYPE uuid USING testuudet_uu::uuid::uuid;

ALTER TABLE testuudet ALTER COLUMN alttestuu_uu TYPE uuid USING alttestuu_uu::uuid::uuid;

ALTER TABLE testuudet ALTER COLUMN testuu_uu TYPE uuid USING testuu_uu::uuid::uuid;

-- And finally create again the foreign constraints

ALTER TABLE testuudet ADD CONSTRAINT testuuuu_testuudet FOREIGN KEY (testuu_uu) REFERENCES testuu(testuu_uu) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE testuudet ADD CONSTRAINT alttestuuuu_testuudet FOREIGN KEY (alttestuu_uu) REFERENCES testuu(testuu_uu) DEFERRABLE INITIALLY DEFERRED;

