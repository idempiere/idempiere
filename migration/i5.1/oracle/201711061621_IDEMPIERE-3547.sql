SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3547 Mismatches in oracle foreign keys delete rule
-- Nov 6, 2017 4:21:15 PM CET
ALTER TABLE C_OrderLine DROP CONSTRAINT linkorderline_corderline
;

-- Nov 6, 2017 4:21:15 PM CET
ALTER TABLE C_OrderLine ADD CONSTRAINT linkorderline_corderline FOREIGN KEY (Link_OrderLine_ID) REFERENCES c_orderline(c_orderline_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 6, 2017 4:21:26 PM CET
ALTER TABLE A_Asset_Acct DROP CONSTRAINT aasset_aassetacct
;

-- Nov 6, 2017 4:21:26 PM CET
ALTER TABLE A_Asset_Acct ADD CONSTRAINT aasset_aassetacct FOREIGN KEY (A_Asset_ID) REFERENCES a_asset(a_asset_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Nov 6, 2017 4:21:36 PM CET
ALTER TABLE A_Asset_Group_Acct DROP CONSTRAINT aassetgroup_aassetgroupacct
;

-- Nov 6, 2017 4:21:36 PM CET
ALTER TABLE A_Asset_Group_Acct ADD CONSTRAINT aassetgroup_aassetgroupacct FOREIGN KEY (A_Asset_Group_ID) REFERENCES a_asset_group(a_asset_group_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201711061621_IDEMPIERE-3547.sql') FROM dual
;

