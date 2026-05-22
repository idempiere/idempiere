-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603311328_IDEMPIERE-6908.sql') FROM dual;

-- Mar 31, 2026, 1:28:30 PM GMT+08:00
INSERT INTO AD_Extension (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Extension_ID,ExtensionVersion,ExtensionId,IsBundled,ExtensionMetadata,ExtensionState,AD_Extension_UU,Name) VALUES (0,0,TO_TIMESTAMP('2026-03-31 13:28:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-31 13:28:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',200003,'0.0.0','org.adempiere.payment.processor','Y','{
  "id": "org.adempiere.payment.processor",
  "version": "0.0.0",
  "idempiereVersion": "0",
  "releaseDate": "2026-03-30",
  "name": "iDempiere Payment Processor",
  "description": "Payment processor implementations for payment gateways.",
  "infoUrl": "https://github.com/idempiere/idempiere-extension-repository/blob/main/extensions/org.adempiere.payment.processor/info.md",
  "categories": [
    "Payments"
  ],
  "tags": [
    "payments",
    "credit-card",
    "gateway",
    "ach",
    "pci"
  ],
  "bundles": [
    {
      "symbolicName": "org.adempiere.payment.processor"
    }
  ],
  "dependencies": []
}','IN','019d425d-6799-79d2-b2f1-c552a7b52ef0','iDempiere Payment Processor')
;

-- Mar 31, 2026, 1:29:06 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-31 13:29:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-31 13:29:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',200066,200003,'019d425d-f0dd-7f7e-a91e-a0d4d901f6aa',398,'54ba3998-5ea8-4c86-9226-a6934d02cdea')
;

-- Mar 31, 2026, 1:29:22 PM GMT+08:00
INSERT INTO AD_ExtensionEntity (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_ExtensionEntity_ID,AD_Extension_ID,AD_ExtensionEntity_UU,AD_Table_ID,Record_UU) VALUES (0,0,TO_TIMESTAMP('2026-03-31 13:29:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-31 13:29:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',200067,200003,'019d425e-3075-7173-bef9-cb36744cfb90',398,'0bf51c1c-4b90-4134-9381-8a13fc5b0ca2')
;

