--Fix GL Journal line posting to incorrect org

DELETE FROM Fact_Acct WHERE AD_Table_ID = 224 AND Record_ID = 100;

UPDATE GL_JournalLine SET AD_Org_ID = 12 WHERE GL_JournalLine_ID = 101;

UPDATE GL_Journal set Posted = 'N' WHERE GL_Journal_ID = 100;

-- Replace missing ADempiere image with iDempiere image
UPDATE AD_PrintFormatItem SET ImageURL = 'images/header-logo.png' 
WHERE ImageURL = 'org/compiere/images/C10030HR.png' AND AD_Client_ID IN (0,11);

-- Replace ADempiere image with iDempiere image
UPDATE M_Product SET ImageURL = 'images/iD32.png' 
WHERE ImageURL = 'http://www.adempiere.com/images/f/f5/C32.png' AND AD_Client_ID = 11;

-- Replace 'http://www.adempiere.com/index.php/SampleProductDescriptionForDocumentation' with 'https://wiki.idempiere.org/wiki/Main_Page'
UPDATE M_Product SET DescriptionURL = 'https://wiki.idempiere.org/wiki/Main_Page' 
WHERE DescriptionURL = 'http://www.adempiere.com/index.php/SampleProductDescriptionForDocumentation' AND AD_Client_ID = 11;

-- No longer used, but update anyway
UPDATE AD_Process_Para SET DefaultValue = 'http://localhost' 
WHERE DefaultValue = 'http://www.adempiere.org' AND AD_Process_Para_ID = 53023;


SELECT Register_Migration_Script ('202202072001_IDEMPIERE-4297.sql') FROM DUAL
;
