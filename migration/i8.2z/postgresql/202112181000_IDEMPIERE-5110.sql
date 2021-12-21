-- Dic 18, 2021, 10:00:00 AM ART
CREATE INDEX pp_product_bom_product_id_idx ON pp_product_bom (m_product_id)
;

-- Dic 18, 2021, 10:00:00 AM ART
CREATE INDEX pp_product_bomline_pp_product_bom_id_idx ON pp_product_bomline (pp_product_bom_id)
;

-- Dic 18, 2021, 10:00:00 AM ART
INSERT INTO AD_TableIndex (ad_client_id, ad_org_id, ad_table_id, ad_tableindex_id, ad_tableindex_uu, created, createdby, description, entitytype, help, isactive, iscreateconstraint, isunique, name, processing, updated, updatedby, ad_message_id, tableindexdrop, iskey) VALUES (0, 0, 53018, 1000009, '44b8df80-dd54-4413-adb4-d727d57ab802', '2021-12-20 22:22:33.065', 0, NULL, 'U', NULL, 'Y', 'N', 'N', 'pp_product_bom_product_id_idx', 'N', '2021-12-20 22:22:33.065', 0, NULL, 'N', 'N')
;

-- Dic 18, 2021, 10:00:00 AM ART
INSERT INTO AD_IndexColumn (ad_client_id, ad_column_id, ad_indexcolumn_id, ad_indexcolumn_uu, ad_org_id, ad_tableindex_id, columnsql, created, createdby, entitytype, isactive, seqno, updated, updatedby) VALUES (0, 53333, 1000009, '25b7878a-9562-44c1-90a0-272adabc60ac', 0, 1000009, NULL, '2021-12-20 22:23:00.829', 0, 'U', 'Y', 10, '2021-12-20 22:23:00.829', 0)
;

-- Dic 18, 2021, 10:00:00 AM ART
INSERT INTO AD_TableIndex (ad_client_id, ad_org_id, ad_table_id, ad_tableindex_id, ad_tableindex_uu, created, createdby, description, entitytype, help, isactive, iscreateconstraint, isunique, name, processing, updated, updatedby, ad_message_id, tableindexdrop, iskey) VALUES (0, 0, 53019, 1000010, '2e4efcf2-16a0-4d0c-b7b5-8a621ad8a684', '2021-12-20 22:24:21.505', 0, NULL, 'U', NULL, 'Y', 'N', 'N', 'pp_product_bomline_pp_product_bom_id_idx', 'N', '2021-12-20 22:24:21.505', 0, NULL, 'N', 'N')
;

-- Dic 18, 2021, 10:00:00 AM ART
INSERT INTO AD_IndexColumn (ad_client_id, ad_column_id, ad_indexcolumn_id, ad_indexcolumn_uu, ad_org_id, ad_tableindex_id, columnsql, created, createdby, entitytype, isactive, seqno, updated, updatedby) VALUES (0, 53366, 1000010, 'b901bfea-da8b-4708-b770-dab58d94b24c', 0, 1000010, NULL, '2021-12-20 22:24:43.055', 0, 'U', 'Y', 10, '2021-12-20 22:24:43.055', 0)
;


SELECT register_migration_script('202112181000_IDEMPIERE-5110.sql') FROM dual
;
