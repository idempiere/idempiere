-- Jan 25, 2013 5:26:22 PM PST
-- IDEMPIERE-594 Improve positioning on windows
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200025,'D','C','N','Show Action Name on DocAction button','ee66f3e4-8fed-4591-97dd-ae1ba1219fdc',TO_DATE('2013-01-25 17:26:21','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-25 17:26:21','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'DOCACTIONBUTTON_SHOWACTIONNAME')
;

-- Jan 25, 2013 5:26:37 PM PST
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_Element SET Name='Action',Updated=TO_DATE('2013-01-25 17:26:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=287
;

-- Jan 25, 2013 5:26:38 PM PST
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=287
;

-- Jan 25, 2013 5:26:38 PM PST
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_Column SET ColumnName='DocAction', Name='Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup' WHERE AD_Element_ID=287
;

-- Jan 25, 2013 5:26:38 PM PST
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_Process_Para SET ColumnName='DocAction', Name='Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup', AD_Element_ID=287 WHERE UPPER(ColumnName)='DOCACTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 25, 2013 5:26:38 PM PST
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_Process_Para SET ColumnName='DocAction', Name='Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup' WHERE AD_Element_ID=287 AND IsCentrallyMaintained='Y'
;

-- Jan 25, 2013 5:26:38 PM PST
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_InfoColumn SET ColumnName='DocAction', Name='Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup' WHERE AD_Element_ID=287 AND IsCentrallyMaintained='Y'
;

-- Jan 25, 2013 5:26:38 PM PST
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_Field SET Name='Action', Description='The targeted status of the document', Help='You find the current status in the Document Status field. The options are listed in a popup' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=287) AND IsCentrallyMaintained='Y'
;

-- Jan 25, 2013 5:26:38 PM PST
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_PrintFormatItem pi SET PrintName='Doc Action', Name='Action' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=287)
;

SELECT register_migration_script('201301251726_IDEMPIERE-594_DocAction.sql') FROM dual
;

