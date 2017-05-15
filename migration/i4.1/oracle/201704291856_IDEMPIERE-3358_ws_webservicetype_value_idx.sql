SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3358 Dictionary fixes / index ws_webservicetype_value_idx
-- Apr 29, 2017 6:55:12 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201042,'9e3c5317-e7c8-4155-9b25-8f1af5b15f76',TO_DATE('2017-04-29 18:55:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ws_webservicetype_value_idx',TO_DATE('2017-04-29 18:55:11','YYYY-MM-DD HH24:MI:SS'),100,53164,'N','Y','N','N','N')
;

-- Apr 29, 2017 6:55:32 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201278,'09dd0866-bd1d-4c25-9d5b-2a89822d52ee',TO_DATE('2017-04-29 18:55:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 18:55:31','YYYY-MM-DD HH24:MI:SS'),100,56730,201042,1)
;

-- Apr 29, 2017 6:55:41 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201279,'5b5d5d85-442e-4bd0-9b2b-fbe36d8b67c1',TO_DATE('2017-04-29 18:55:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-04-29 18:55:41','YYYY-MM-DD HH24:MI:SS'),100,56719,201042,2)
;

-- Apr 29, 2017 6:55:46 PM CEST
CREATE UNIQUE INDEX ws_webservicetype_value_idx ON WS_WebServiceType (Value,AD_Client_ID)
;

SELECT register_migration_script('201704291856_IDEMPIERE-3358_ws_webservicetype_value_idx.sql') FROM dual
;

