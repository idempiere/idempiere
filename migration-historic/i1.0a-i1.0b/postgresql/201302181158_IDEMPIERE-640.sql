-- IDEMPIERE-640 Price List Versions must not allow duplicate valid from date
CREATE UNIQUE INDEX m_pricelist_version_validfrom ON m_pricelist_version(m_pricelist_id, validfrom)
;

SELECT register_migration_script('201302181158_IDEMPIERE-640.sql') FROM dual
;

