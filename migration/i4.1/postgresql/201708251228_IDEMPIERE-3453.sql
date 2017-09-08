-- IDEMPIERE-3453

CREATE OR REPLACE FUNCTION trunc(datetime TIMESTAMP WITHOUT TIME ZONE)
RETURNS TIMESTAMP WITHOUT TIME ZONE AS $$
BEGIN
        RETURN CAST(datetime AS DATE);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Aug 25, 2017 12:23:30 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='TRUNC(DateAcct)',Updated=TO_TIMESTAMP('2017-08-25 12:23:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200741
;

-- Aug 25, 2017 12:23:35 PM CEST
DROP INDEX fact_acct_trunc_dateacct
;

-- Aug 25, 2017 12:23:35 PM CEST
CREATE INDEX fact_acct_trunc_dateacct ON Fact_Acct (TRUNC(DateAcct))
;

-- Aug 25, 2017 12:27:32 PM CEST
UPDATE AD_IndexColumn SET ColumnSQL='upper(columnname)',Updated=TO_TIMESTAMP('2017-08-25 12:27:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200079
;

-- Aug 25, 2017 12:27:46 PM CEST
DROP INDEX ad_element_uppercolumnname
;

-- Aug 25, 2017 12:27:46 PM CEST
CREATE UNIQUE INDEX ad_element_uppercolumnname ON AD_Element (upper(columnname))
;

SELECT register_migration_script('201708251228_IDEMPIERE-3453.sql') FROM dual
;

