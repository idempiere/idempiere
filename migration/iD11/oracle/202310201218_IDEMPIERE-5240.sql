-- IDEMPIERE-5240 UUID performance improvement considerations
SELECT register_migration_script('202310201218_IDEMPIERE-5240.sql') FROM dual;

-- First we need to drop the foreign constraints pointintg to the UUID keys that we are going to change
ALTER TABLE testuudet DROP CONSTRAINT alttestuuuu_testuudet;

ALTER TABLE testuudet DROP CONSTRAINT testuuuu_testuudet;

-- Then alter the column, oracle doesn't allow direct change, so it needs to be tricked

ALTER TABLE test ADD tmp_test_uu RAW(16) DEFAULT NULL;
UPDATE test SET tmp_test_uu = HEXTORAW(REPLACE( test_uu ,'-',''));
ALTER TABLE test DROP COLUMN test_uu;
ALTER TABLE test RENAME COLUMN tmp_test_uu TO test_uu;

ALTER TABLE testuu ADD tmp_testuu_uu RAW(16) DEFAULT NULL;
UPDATE testuu SET tmp_testuu_uu = HEXTORAW(REPLACE( testuu_uu ,'-',''));
ALTER TABLE testuu DROP COLUMN testuu_uu;
ALTER TABLE testuu RENAME COLUMN tmp_testuu_uu TO testuu_uu;

ALTER TABLE testuudet ADD tmp_testuudet_uu RAW(16) DEFAULT NULL;
UPDATE testuudet SET tmp_testuudet_uu = HEXTORAW(REPLACE( testuudet_uu ,'-',''));
ALTER TABLE testuudet DROP COLUMN testuudet_uu;
ALTER TABLE testuudet RENAME COLUMN tmp_testuudet_uu TO testuudet_uu;

ALTER TABLE testuudet ADD tmp_alttestuu_uu RAW(16) DEFAULT NULL;
UPDATE testuudet SET tmp_alttestuu_uu = HEXTORAW(REPLACE( alttestuu_uu ,'-',''));
ALTER TABLE testuudet DROP COLUMN alttestuu_uu;
ALTER TABLE testuudet RENAME COLUMN tmp_alttestuu_uu TO alttestuu_uu;

ALTER TABLE testuudet ADD tmp_testuu_uu RAW(16) DEFAULT NULL;
UPDATE testuudet SET tmp_testuu_uu = HEXTORAW(REPLACE( testuu_uu ,'-',''));
ALTER TABLE testuudet DROP COLUMN testuu_uu;
ALTER TABLE testuudet RENAME COLUMN tmp_testuu_uu TO testuu_uu;

-- Then create again the unique constraints

ALTER TABLE test ADD CONSTRAINT test_uu_idx UNIQUE (test_uu);

ALTER TABLE testuu ADD CONSTRAINT testuu_uu_idx UNIQUE (testuu_uu);

ALTER TABLE testuudet ADD CONSTRAINT testuudet_uu_idx UNIQUE (testuudet_uu);

-- And finally create again the foreign constraints

ALTER TABLE testuudet ADD CONSTRAINT testuuuu_testuudet FOREIGN KEY (testuu_uu) REFERENCES testuu(testuu_uu) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE testuudet ADD CONSTRAINT alttestuuuu_testuudet FOREIGN KEY (alttestuu_uu) REFERENCES testuu(testuu_uu) DEFERRABLE INITIALLY DEFERRED;

