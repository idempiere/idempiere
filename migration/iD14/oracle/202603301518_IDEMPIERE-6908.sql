-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603301518_IDEMPIERE-6908.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 30, 2026, 3:18:56 PM GMT+08:00
UPDATE AD_Extension SET ExtensionMetadata='{
  "id": "org.idempiere.webservices",
  "version": "0.0.0",
  "idempiereVersion": "0",
  "releaseDate": "2026-03-29",
  "name": "iDempiere SOAP Web Services",
  "description": "The iDempiere ADInterface providing SOAP and REST access to the Active Data Dictionary.",
  "infoUrl": "https://github.com/idempiere/idempiere-extension-repository/blob/main/extensions/org.idempiere.webservices/info.md",
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
}',ExtensionVersion='0.0.0',Updated=TO_TIMESTAMP('2026-03-30 15:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Extension_ID=200000
;

