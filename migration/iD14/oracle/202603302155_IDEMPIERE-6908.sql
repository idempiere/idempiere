-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603302155_IDEMPIERE-6908.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 30, 2026, 9:55:04 PM GMT+08:00
INSERT INTO AD_Extension (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Extension_ID,ExtensionVersion,ExtensionId,IsBundled,ExtensionMetadata,ExtensionState,AD_Extension_UU,Name) VALUES (0,0,TO_TIMESTAMP('2026-03-30 21:55:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 21:55:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',200002,'0.0.0','org.idempiere.acct','Y','{
  "id": "org.idempiere.acct",
  "version": "0.0.0",
  "idempiereVersion": "0",
  "releaseDate": "2026-03-30",
  "name": "iDempiere Accounting Engine",
  "description": "Core accounting logic responsible for generating Fact ACCT entries from documents.",
  "infoUrl": "https://github.com/idempiere/idempiere-extension-repository/blob/main/extensions/org.idempiere.acct/info.md",
  "categories": [
    "Core",
    "Financial",
    "Accounting"
  ],
  "tags": [
    "accounting",
    "ledger",
    "gl",
    "posting",
    "multi-schema"
  ],
  "bundles": [
    {
      "symbolicName": "org.idempiere.acct"
    }
  ],
  "dependencies": []
}','IN','019d3f06-d07d-724a-a6ff-8f36df853d9c','iDempiere Accounting')
;

-- Mar 30, 2026, 10:03:59 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:03:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:03:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',200025,200002,'019d3f0e-f951-7dcf-8b10-8aac7231d962',117,'a7247855-4766-4e5c-9d85-085d22746dba')
;

-- Mar 30, 2026, 10:05:26 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:05:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:05:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',200026,200002,'019d3f10-4dd1-7fcb-8b9f-f761365c47a0',105,'9ec59fb9-07d4-42ce-a566-4f9e1d05fb82')
;

-- Mar 30, 2026, 10:06:26 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:06:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:06:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',200027,200002,'019d3f11-3754-7517-a8dc-f410ce6785b1',105,'8b0bb4c9-2a04-4d98-95a8-d3139bab7f51')
;

-- Mar 30, 2026, 10:06:57 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:06:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:06:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',200028,200002,'019d3f11-b160-78f4-aa98-cb181d9b7d74',105,'3a6e99a4-c565-4361-8eae-c48a9f7e33ee')
;

-- Mar 30, 2026, 10:07:28 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:07:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:07:27','YYYY-MM-DD HH24:MI:SS'),100,'Y',200029,200002,'019d3f12-2add-75db-a164-1e8e5d14253b',105,'56056642-00b9-4dd4-8f36-22d5c669fa6a')
;

-- Mar 30, 2026, 10:07:46 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:07:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:07:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',200030,200002,'019d3f12-708f-760a-b84a-d4d33892b073',105,'a7291d89-91fc-4ea7-bb72-2c2ed21ad4a5')
;

-- Mar 30, 2026, 10:08:06 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:08:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:08:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',200031,200002,'019d3f12-bf71-7a64-93a5-cee293be37f6',105,'a16be98d-270c-4655-86ae-d4fc04241fd6')
;

-- Mar 30, 2026, 10:08:26 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:08:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',200032,200002,'019d3f13-0cee-7954-a9d0-8cde3316ad36',105,'0379cee7-feae-4534-9800-5769e45da8f7')
;

-- Mar 30, 2026, 10:09:24 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:09:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:09:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',200033,200002,'019d3f13-f024-7d79-8d35-1ec5b5552646',105,'ecdd9bbc-b3a9-44e0-926a-07b4b929c845')
;

-- Mar 30, 2026, 10:09:38 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:09:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:09:38','YYYY-MM-DD HH24:MI:SS'),100,'Y',200034,200002,'019d3f14-28a3-74c5-9063-f551241c72ba',105,'e57cd978-bfeb-45e1-be0e-c62ef96c128a')
;

-- Mar 30, 2026, 10:09:56 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:09:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:09:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',200035,200002,'019d3f14-6e8a-751d-b150-e14b3aab450d',105,'8e2b7062-5cd8-48c1-a4ea-33e3da78de04')
;

-- Mar 30, 2026, 10:10:38 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:10:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:10:38','YYYY-MM-DD HH24:MI:SS'),100,'Y',200036,200002,'019d3f15-11ea-7d21-b54a-32afbcc0dabd',105,'1b7a6495-7270-4ae0-bd9c-4523d387b32b')
;

-- Mar 30, 2026, 10:10:56 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:10:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:10:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',200037,200002,'019d3f15-5625-75c7-bdce-31ccdd6c21e3',105,'8dfdae8e-3696-484b-8ce6-d3c5e6566399')
;

-- Mar 30, 2026, 10:11:11 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:11:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:11:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',200038,200002,'019d3f15-9143-7591-847b-c5de0fba1506',105,'c71f6172-b7a1-4b31-b3ad-64b159e36f6d')
;

-- Mar 30, 2026, 10:12:41 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:12:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:12:41','YYYY-MM-DD HH24:MI:SS'),100,'Y',200039,200002,'019d3f16-f35b-7376-98f7-1b4daac77668',284,'ceaf2c38-bc4b-49f1-8c9a-3e9c6d596c1f')
;

-- Mar 30, 2026, 10:13:20 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:13:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:13:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',200040,200002,'019d3f17-8ada-7ddc-8492-ff45fcb3413e',284,'34a14235-fcad-4cc1-8c75-3c6e667666b5')
;

-- Mar 30, 2026, 10:13:47 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:13:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:13:46','YYYY-MM-DD HH24:MI:SS'),100,'Y',200041,200002,'019d3f17-f1c1-7e02-9317-c45b8e8bf652',284,'c5dd36fd-f9c3-4e52-b4ee-9bf5dfaba537')
;

-- Mar 30, 2026, 10:14:56 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:14:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:14:55','YYYY-MM-DD HH24:MI:SS'),100,'Y',200042,200002,'019d3f18-ff1f-7db4-b173-827a6b55e3bb',105,'5841e304-8d9e-477a-bd02-56bef971bff6')
;

-- Mar 30, 2026, 10:15:15 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:15:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:15:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',200043,200002,'019d3f19-4bd2-74bf-9428-5e36570bb598',105,'b7a23fc3-85ca-470d-999a-2c78c782676f')
;

-- Mar 30, 2026, 10:16:24 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:16:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:16:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',200044,200002,'019d3f1a-582c-7621-ac92-65ca90cb80d3',105,'9ad07fdc-3cd5-4d2c-b7fe-e32a3c3ac664')
;

-- Mar 30, 2026, 10:16:42 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:16:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:16:41','YYYY-MM-DD HH24:MI:SS'),100,'Y',200045,200002,'019d3f1a-9e2f-75e5-85c7-0e3888140b9b',105,'e1a8b891-002b-4f73-bb6e-d3def59c5373')
;

-- Mar 30, 2026, 10:17:14 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:17:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:17:14','YYYY-MM-DD HH24:MI:SS'),100,'Y',200046,200002,'019d3f1b-1c94-7711-99e0-bba2ea1d89c2',284,'d6794edd-6197-4257-9325-9553d7e59911')
;

-- Mar 30, 2026, 10:17:37 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:17:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:17:36','YYYY-MM-DD HH24:MI:SS'),100,'Y',200047,200002,'019d3f1b-7500-7cbb-af13-36a8677653c4',105,'8c75e4cb-f4de-432b-a1b7-2a52c0eda499')
;

-- Mar 30, 2026, 10:18:23 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:18:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:18:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',200048,200002,'019d3f1c-29cd-7319-a068-ed5e31a35a91',284,'3a302df9-24eb-4d20-b116-e28f3823d361')
;

-- Mar 30, 2026, 10:18:46 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:18:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:18:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',200049,200002,'019d3f1c-830d-75fe-bc72-a24fbc0391e8',284,'307cb7bd-5630-404c-bc99-aaa880c91800')
;

-- Mar 30, 2026, 10:20:44 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:20:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:20:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',200050,200002,'019d3f1e-4e97-701c-83c2-38ceb1a1e21b',284,'0fba261a-be3f-4852-9354-55f14d80d55f')
;

-- Mar 30, 2026, 10:22:10 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:22:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:22:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',200051,200002,'019d3f1f-9f08-76a7-9264-51c80ad64fd8',376,'3230279b-f05c-4beb-be42-a11c77d625bd')
;

-- Mar 30, 2026, 10:22:42 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:22:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:22:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',200052,200002,'019d3f20-1e2c-7024-aba2-94911c5f6a27',284,'4b30febc-2599-4eac-96c7-cc6328b24cd8')
;

-- Mar 30, 2026, 10:23:48 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:23:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:23:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',200053,200002,'019d3f21-1e34-7a28-b9e3-e72934902b9e',284,'bdbf3bf9-caac-48e1-812b-cb42c0d6e716')
;

-- Mar 30, 2026, 10:24:07 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:24:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:24:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',200054,200002,'019d3f21-67cd-7a4f-b6a7-f8e2443a034a',284,'aace9d5d-b05d-474a-aec6-d2303daf85ca')
;

-- Mar 30, 2026, 10:25:44 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 22:25:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 22:25:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',200055,200002,'019d3f22-e291-7b20-8e50-1cf9e8e110df',284,'e6d33f36-e200-4ab2-95f8-884959210b7e')
;

-- Mar 30, 2026, 11:05:34 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:05:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:05:33','YYYY-MM-DD HH24:MI:SS'),100,'Y',200056,200002,'019d3f47-5ba0-76f1-8667-fa5232da254a',284,'48c2742a-be9f-40fb-94eb-85297a7fca49')
;

-- Mar 30, 2026, 11:07:11 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:07:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:07:10','YYYY-MM-DD HH24:MI:SS'),100,'Y',200057,200002,'019d3f48-d53c-7a71-8afc-196a4a28a6ae',105,'c3c9032d-9a15-43b1-af4b-c32e9003a9ac')
;

-- Mar 30, 2026, 11:07:30 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:07:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:07:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200058,200002,'019d3f49-20db-79c3-a228-aab2b725581e',105,'919e3db7-e796-478e-8ea4-6e567cb8b9d8')
;

-- Mar 30, 2026, 11:07:53 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:07:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:07:53','YYYY-MM-DD HH24:MI:SS'),100,'Y',200059,200002,'019d3f49-7b91-7abf-91d7-801923513ed6',105,'01b9278c-c9b2-4885-8ad9-0828c892ce2d')
;

-- Mar 30, 2026, 11:08:19 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:08:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:08:18','YYYY-MM-DD HH24:MI:SS'),100,'Y',200060,200002,'019d3f49-df9f-731e-93e2-8a0ea806beff',284,'afc8a073-001e-4a83-a8e1-16d57cc79cd5')
;

-- Mar 30, 2026, 11:08:42 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:08:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:08:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',200061,200002,'019d3f4a-3c16-7339-b5d7-947dcf69f58d',284,'643c17ba-baea-416b-8308-a2738935ecc2')
;

-- Mar 30, 2026, 11:09:01 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:09:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:09:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',200062,200002,'019d3f4a-858a-7cef-988a-b2dff3cf7b91',284,'753a0513-709b-476a-be96-d36501fd9ea7')
;

-- Mar 30, 2026, 11:09:21 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:09:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:09:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',200063,200002,'019d3f4a-d4ae-7a9e-afce-61403f290ab9',284,'23f0bfb2-3b6f-40d0-9458-123cdcb50f9a')
;

-- Mar 30, 2026, 11:09:39 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:09:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:09:38','YYYY-MM-DD HH24:MI:SS'),100,'Y',200064,200002,'019d3f4b-181a-7e0e-bdfe-b0495a410db8',284,'76ec3c8c-5c3e-4948-bbc1-8cc9f42214d6')
;

-- Mar 30, 2026, 11:14:36 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 23:14:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 23:14:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',200065,200002,'019d3f4f-a20c-79e4-861f-2df69d5426f1',284,'4d430895-aab5-42d5-b427-3e5a1c850887')
;

