-- IDEMPIERE-6169 Performance on AD_ChangeLog with Record_UU
SELECT register_migration_script('202406131736_IDEMPIERE-6169.sql') FROM dual;

ALTER TABLE ad_changelog DROP CONSTRAINT ad_changelog_pkey
;

ALTER TABLE ad_changelog ADD CONSTRAINT ad_changelog_pkey PRIMARY KEY (ad_session_id, ad_column_id, ad_changelog_id)
;

