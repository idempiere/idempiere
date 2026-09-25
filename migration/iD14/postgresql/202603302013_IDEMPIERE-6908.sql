-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603302013_IDEMPIERE-6908.sql') FROM dual;

-- Mar 30, 2026, 8:13:13 PM GMT+08:00
INSERT INTO AD_Extension (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Extension_ID,ExtensionVersion,ExtensionId,IsBundled,ExtensionMetadata,ExtensionState,AD_Extension_UU,Name) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:13:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:13:13','YYYY-MM-DD HH24:MI:SS'),100,'Y',200001,'0.0.0','org.adempiere.replication','Y','{
  "id": "org.adempiere.replication",
  "version": "0.0.0",
  "idempiereVersion": "0",
  "releaseDate": "2026-03-30",
  "name": "iDempiere Data Replication",
  "description": "Core engine for synchronizing data between distributed iDempiere instances and databases.",
  "infoUrl": "https://github.com/idempiere/idempiere-extension-repository/blob/main/extensions/org.adempiere.replication/info.md",
  "categories": [
    "Core",
    "Data Management",
    "Integration"
  ],
  "tags": [
    "replication",
    "sync",
    "JMS"
  ],
  "entityType": "EE05",
  "bundles": [
    {
      "symbolicName": "org.adempiere.replication"
    },
    {
      "symbolicName": "org.adempiere.replication.server"
    }
  ],
  "dependencies": []
}','IN','019d3ea9-92c2-728b-9924-0f7065376454','iDempiere Replication')
;

-- Mar 30, 2026, 8:14:45 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:14:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:14:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',200005,200001,'019d3eaa-fa64-789c-8c1a-785049ecd3fd',116,'d4594a9f-aabc-4094-a132-accaad795f67')
;

-- Mar 30, 2026, 8:15:20 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:15:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:15:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',200006,200001,'019d3eab-8262-70e9-af12-561f65a4f8f3',116,'12f67d29-22b0-4932-85ec-2a930575a0b9')
;

-- Mar 30, 2026, 8:16:00 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:15:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:15:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',200007,200001,'019d3eac-1c5c-7afd-ac80-71955be5a3ca',116,'b3a0a570-d53a-47f3-86e9-156faac58bc4')
;

-- Mar 30, 2026, 8:16:30 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:16:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:16:30','YYYY-MM-DD HH24:MI:SS'),100,'Y',200008,200001,'019d3eac-93f5-7e6c-aa01-0e0968e29a99',116,'0727a7d9-a972-4337-a2c2-cb6a22922772')
;

-- Mar 30, 2026, 8:17:02 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:17:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:17:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',200009,200001,'019d3ead-1199-7499-9b08-7c715e5edbee',116,'0eeebd16-ba5e-40fb-8bc2-2b4cd4040d77')
;

-- Mar 30, 2026, 8:17:21 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:17:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:17:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',200010,200001,'019d3ead-5bf6-7662-bbba-590cbacd8147',116,'e846308e-6343-4ef7-8b3e-94a25a3d9a89')
;

-- Mar 30, 2026, 8:17:41 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:17:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:17:40','YYYY-MM-DD HH24:MI:SS'),100,'Y',200011,200001,'019d3ead-a6ce-7a4d-94f0-e3dfe86b1da0',116,'2ecf3a20-387b-46db-a868-405181c4d252')
;

-- Mar 30, 2026, 8:18:00 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:17:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:17:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',200012,200001,'019d3ead-f25e-70da-a9bd-e8c7a504e919',116,'33f64ce0-58a7-4b20-a641-f2195f06e10e')
;

-- Mar 30, 2026, 8:18:16 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:18:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:18:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',200013,200001,'019d3eae-3274-7e14-86bc-610d9631a155',116,'f53388d1-2d34-490c-83a8-c00bbf637ba4')
;

-- Mar 30, 2026, 8:18:40 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:18:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:18:39','YYYY-MM-DD HH24:MI:SS'),100,'Y',200014,200001,'019d3eae-8d31-70a8-b856-7677e8ad7113',116,'0f8216a9-237b-44c3-86dc-dce5de040c42')
;

-- Mar 30, 2026, 8:19:24 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:19:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:19:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',200015,200001,'019d3eaf-3b3b-72fc-ab8d-87e0f78aa28e',117,'d41bb1c6-873c-4c3d-9488-abe076544448')
;

-- Mar 30, 2026, 8:19:56 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:19:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:19:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',200016,200001,'019d3eaf-b95d-78b7-8b8c-1d4c9d152b62',105,'72973947-02f3-4e77-9557-80f52782ad39')
;

-- Mar 30, 2026, 8:20:24 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:20:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:20:24','YYYY-MM-DD HH24:MI:SS'),100,'Y',200017,200001,'019d3eb0-25ff-796c-acf7-62d171019460',105,'39af60cd-1841-4d2f-87c5-93251c9af43f')
;

-- Mar 30, 2026, 8:21:01 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:21:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:21:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',200018,200001,'019d3eb0-b734-7329-aae7-557e2d4a82b1',105,'968de4be-2d5b-4b37-bb25-ce0c2a1f724c')
;

-- Mar 30, 2026, 8:21:27 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:21:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:21:27','YYYY-MM-DD HH24:MI:SS'),100,'Y',200019,200001,'019d3eb1-1c75-7484-b6a0-d0a6080077f3',105,'7deb8438-abb4-4f2d-b2dd-43f6710bd503')
;

-- Mar 30, 2026, 8:21:55 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:21:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:21:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',200020,200001,'019d3eb1-88d7-7574-9820-b184eb562b85',105,'f154c9e0-b615-428d-9a33-d822e7dc9c26')
;

-- Mar 30, 2026, 8:22:19 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:22:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:22:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',200021,200001,'019d3eb1-e80a-746a-b35c-8dfc94bc0475',105,'b68dac1f-8d98-45a6-9699-e771ae992161')
;

-- Mar 30, 2026, 8:22:57 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:22:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:22:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',200022,200001,'019d3eb2-7934-7c2d-9fcd-88b969d3eeb3',284,'8c7b7d9f-a3b9-4c0d-8676-383a16c9cdcd')
;

-- Mar 30, 2026, 8:23:32 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:23:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:23:32','YYYY-MM-DD HH24:MI:SS'),100,'Y',200023,200001,'019d3eb3-053b-7685-be56-c4984b495908',284,'de4e553c-b7be-4064-8368-8435d7d929c9')
;

-- Mar 30, 2026, 8:23:59 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-30 20:23:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 20:23:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',200024,200001,'019d3eb3-6b34-711c-9afa-6a1897d2a65a',284,'742add0a-6858-44c7-916a-b006f9785fc9')
;

