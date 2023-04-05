-- IDEMPIERE-5567 Support of UUID on Search (FHCA-4195)
SELECT register_migration_script('202304060001_IDEMPIERE-5567.sql') FROM dual;

-- Apr 6, 2023, 12:01:14 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','UUID based table is not compatible with Record_ID',0,0,'Y',TO_TIMESTAMP('2023-04-06 00:01:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-06 00:01:13','YYYY-MM-DD HH24:MI:SS'),100,200830,'UUTableNotCompatibleWithRecordID','D','5b220b22-2a21-493c-81f0-877dbc083874')
;

ALTER TABLE t_selection ADD COLUMN t_selection_uu VARCHAR(36) NOT NULL DEFAULT '';

ALTER TABLE t_selection ALTER COLUMN t_selection_id SET DEFAULT 0;

ALTER TABLE t_selection DROP CONSTRAINT t_selection_pkey;

ALTER TABLE t_selection ADD CONSTRAINT t_selection_pkey PRIMARY KEY (ad_pinstance_id, t_selection_id, t_selection_uu);

ALTER TABLE t_selection_infowindow ADD COLUMN t_selection_uu VARCHAR(36) NOT NULL DEFAULT '';

ALTER TABLE t_selection_infowindow ALTER COLUMN t_selection_id SET DEFAULT 0;

ALTER TABLE t_selection_infowindow DROP CONSTRAINT t_selection_infowindow_key;

ALTER TABLE t_selection_infowindow ADD CONSTRAINT t_selection_infowindow_key PRIMARY KEY (ad_pinstance_id, t_selection_id, t_selection_uu, columnname);

-- Apr 6, 2023, 1:39:46 AM CEST
UPDATE AD_Reference SET IsActive='Y',Updated=TO_TIMESTAMP('2023-04-06 01:39:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200235
;

