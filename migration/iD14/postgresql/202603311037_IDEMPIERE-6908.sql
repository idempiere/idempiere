-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603311037_IDEMPIERE-6908.sql') FROM dual;

-- Mar 31, 2026, 10:37:56 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Extension metadata (metadata.json) is missing required fields (name, version, idempiereVersion, bundles)',0,0,'Y',TO_TIMESTAMP('2026-03-31 10:37:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-31 10:37:55','YYYY-MM-DD HH24:MI:SS'),100,201033,'ExtensionMetadataMissingRequiredFields','D','019d41c1-3cd0-746f-9dca-2da4968fdedd')
;

-- Mar 31, 2026, 10:39:01 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Installing extension bundle from {0}',0,0,'Y',TO_TIMESTAMP('2026-03-31 10:39:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-31 10:39:00','YYYY-MM-DD HH24:MI:SS'),100,201034,'InstallingExtensionBundle','D','019d41c2-3b34-7dfc-b2b6-57fdc8439509')
;

-- Mar 31, 2026, 10:39:46 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Starting extension bundle {0}',0,0,'Y',TO_TIMESTAMP('2026-03-31 10:39:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-31 10:39:45','YYYY-MM-DD HH24:MI:SS'),100,201035,'StartingExtensionBundle','D','019d41c2-eb9e-73d8-8b63-fe154276aab9')
;

-- Mar 31, 2026, 10:40:18 AM GMT+08:00
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Importing extension data in the background…',0,0,'Y',TO_TIMESTAMP('2026-03-31 10:40:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-31 10:40:17','YYYY-MM-DD HH24:MI:SS'),100,201036,'ImportingExtensionDataInBackground','D','019d41c3-6675-7910-a238-5f4abc4fdaae')
;

