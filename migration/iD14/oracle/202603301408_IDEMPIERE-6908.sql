-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603301408_IDEMPIERE-6908.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 30, 2026, 2:08:19 PM GMT+08:00
INSERT INTO AD_Extension (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Extension_ID,ExtensionVersion,ExtensionId,IsBundled,ExtensionMetadata,ExtensionState,AD_Extension_UU,Name) VALUES (0,0,TO_TIMESTAMP('2026-03-30 14:08:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-30 14:08:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',200000,'13.0.0','org.idempiere.webservices','Y','{
  "id": "org.idempiere.webservices",
  "version": "13.0.0",
  "idempiereVersion": "12",
  "releaseDate": "2026-03-29",
  "name": "iDempiere SOAP Web Services",
  "description": "The iDempiere ADInterface providing SOAP and REST access to the Active Data Dictionary.",
  "categories": [
    "Core",
    "API",
    "Integration"
  ],
  "tags": [
    "soap",
    "rest",
    "adinterface",
    "xml",
    "json"
  ],
  "bundles": [
    {
      "symbolicName": "org.idempiere.webservices"
    },
    {
	  "symbolicName": "org.idempiere.webservices.resources"
	}
  ],
  "dependencies": []
}','IN','019d3d5b-7f78-7c86-860d-4b6a03f102ae','iDempiere SOAP Web Service')
;

-- Mar 30, 2026, 2:11:50 PM GMT+08:00
UPDATE AD_Tab SET AD_Column_ID=217466, Parent_Column_ID=NULL,Updated=TO_TIMESTAMP('2026-03-30 14:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200417
;

