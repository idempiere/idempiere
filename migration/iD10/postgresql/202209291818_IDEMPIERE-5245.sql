-- IDEMPIERE-5245
SELECT register_migration_script('202209291818_IDEMPIERE-5245.sql') FROM dual;

-- Sep 29, 2022, 6:18:57 PM CEST
UPDATE AD_Element SET Name='Date Last Action', PrintName='Date Last Action',Updated=TO_TIMESTAMP('2022-09-29 18:18:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1502
;

-- Sep 29, 2022, 6:18:57 PM CEST
UPDATE AD_Column SET ColumnName='DateLastAction', Name='Date Last Action', Description='Date this request was last acted on', Help='The Date Last Action indicates that last time that the request was acted on.', Placeholder=NULL WHERE AD_Element_ID=1502
;

-- Sep 29, 2022, 6:18:57 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateLastAction', Name='Date Last Action', Description='Date this request was last acted on', Help='The Date Last Action indicates that last time that the request was acted on.', AD_Element_ID=1502 WHERE UPPER(ColumnName)='DATELASTACTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 29, 2022, 6:18:57 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateLastAction', Name='Date Last Action', Description='Date this request was last acted on', Help='The Date Last Action indicates that last time that the request was acted on.', Placeholder=NULL WHERE AD_Element_ID=1502 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:18:57 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DateLastAction', Name='Date Last Action', Description='Date this request was last acted on', Help='The Date Last Action indicates that last time that the request was acted on.', Placeholder=NULL WHERE AD_Element_ID=1502 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:18:57 PM CEST
UPDATE AD_Field SET Name='Date Last Action', Description='Date this request was last acted on', Help='The Date Last Action indicates that last time that the request was acted on.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1502) AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:18:57 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Date Last Action', Name='Date Last Action' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1502)
;

-- Sep 29, 2022, 6:19:03 PM CEST
UPDATE AD_Element SET Name='Date Last Inventory Count', PrintName='Date Last Inventory Count',Updated=TO_TIMESTAMP('2022-09-29 18:19:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1088
;

-- Sep 29, 2022, 6:19:03 PM CEST
UPDATE AD_Column SET ColumnName='DateLastInventory', Name='Date Last Inventory Count', Description='Date of Last Inventory Count', Help='The Date Last Inventory Count indicates the last time an Inventory count was done.', Placeholder=NULL WHERE AD_Element_ID=1088
;

-- Sep 29, 2022, 6:19:03 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateLastInventory', Name='Date Last Inventory Count', Description='Date of Last Inventory Count', Help='The Date Last Inventory Count indicates the last time an Inventory count was done.', AD_Element_ID=1088 WHERE UPPER(ColumnName)='DATELASTINVENTORY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 29, 2022, 6:19:03 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateLastInventory', Name='Date Last Inventory Count', Description='Date of Last Inventory Count', Help='The Date Last Inventory Count indicates the last time an Inventory count was done.', Placeholder=NULL WHERE AD_Element_ID=1088 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:03 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DateLastInventory', Name='Date Last Inventory Count', Description='Date of Last Inventory Count', Help='The Date Last Inventory Count indicates the last time an Inventory count was done.', Placeholder=NULL WHERE AD_Element_ID=1088 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:03 PM CEST
UPDATE AD_Field SET Name='Date Last Inventory Count', Description='Date of Last Inventory Count', Help='The Date Last Inventory Count indicates the last time an Inventory count was done.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1088) AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:03 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Date Last Inventory Count', Name='Date Last Inventory Count' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1088)
;

-- Sep 29, 2022, 6:19:09 PM CEST
UPDATE AD_Element SET Name='Date Last Run', PrintName='Date Last Run',Updated=TO_TIMESTAMP('2022-09-29 18:19:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1089
;

-- Sep 29, 2022, 6:19:09 PM CEST
UPDATE AD_Column SET ColumnName='DateLastRun', Name='Date Last Run', Description='Date the process was last run.', Help='The Date Last Run indicates the last time that a process was run.', Placeholder=NULL WHERE AD_Element_ID=1089
;

-- Sep 29, 2022, 6:19:09 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateLastRun', Name='Date Last Run', Description='Date the process was last run.', Help='The Date Last Run indicates the last time that a process was run.', AD_Element_ID=1089 WHERE UPPER(ColumnName)='DATELASTRUN' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 29, 2022, 6:19:09 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateLastRun', Name='Date Last Run', Description='Date the process was last run.', Help='The Date Last Run indicates the last time that a process was run.', Placeholder=NULL WHERE AD_Element_ID=1089 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:09 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DateLastRun', Name='Date Last Run', Description='Date the process was last run.', Help='The Date Last Run indicates the last time that a process was run.', Placeholder=NULL WHERE AD_Element_ID=1089 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:09 PM CEST
UPDATE AD_Field SET Name='Date Last Run', Description='Date the process was last run.', Help='The Date Last Run indicates the last time that a process was run.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1089) AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:09 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Date Last Run', Name='Date Last Run' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1089)
;

-- Sep 29, 2022, 6:19:15 PM CEST
UPDATE AD_Element SET Name='Date Next Action', PrintName='Date Next Action',Updated=TO_TIMESTAMP('2022-09-29 18:19:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1503
;

-- Sep 29, 2022, 6:19:15 PM CEST
UPDATE AD_Column SET ColumnName='DateNextAction', Name='Date Next Action', Description='Date that this request should be acted on', Help='The Date Next Action indicates the next scheduled date for an action to occur for this request.', Placeholder=NULL WHERE AD_Element_ID=1503
;

-- Sep 29, 2022, 6:19:15 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateNextAction', Name='Date Next Action', Description='Date that this request should be acted on', Help='The Date Next Action indicates the next scheduled date for an action to occur for this request.', AD_Element_ID=1503 WHERE UPPER(ColumnName)='DATENEXTACTION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 29, 2022, 6:19:15 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateNextAction', Name='Date Next Action', Description='Date that this request should be acted on', Help='The Date Next Action indicates the next scheduled date for an action to occur for this request.', Placeholder=NULL WHERE AD_Element_ID=1503 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:15 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DateNextAction', Name='Date Next Action', Description='Date that this request should be acted on', Help='The Date Next Action indicates the next scheduled date for an action to occur for this request.', Placeholder=NULL WHERE AD_Element_ID=1503 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:15 PM CEST
UPDATE AD_Field SET Name='Date Next Action', Description='Date that this request should be acted on', Help='The Date Next Action indicates the next scheduled date for an action to occur for this request.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1503) AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:15 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Date Next Action', Name='Date Next Action' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1503)
;

-- Sep 29, 2022, 6:19:20 PM CEST
UPDATE AD_Element SET Name='Date Next Run', PrintName='Date Next Run',Updated=TO_TIMESTAMP('2022-09-29 18:19:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1090
;

-- Sep 29, 2022, 6:19:20 PM CEST
UPDATE AD_Column SET ColumnName='DateNextRun', Name='Date Next Run', Description='Date the process will run next', Help='The Date Next Run indicates the next time this process will run.', Placeholder=NULL WHERE AD_Element_ID=1090
;

-- Sep 29, 2022, 6:19:20 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateNextRun', Name='Date Next Run', Description='Date the process will run next', Help='The Date Next Run indicates the next time this process will run.', AD_Element_ID=1090 WHERE UPPER(ColumnName)='DATENEXTRUN' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 29, 2022, 6:19:20 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateNextRun', Name='Date Next Run', Description='Date the process will run next', Help='The Date Next Run indicates the next time this process will run.', Placeholder=NULL WHERE AD_Element_ID=1090 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:20 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DateNextRun', Name='Date Next Run', Description='Date the process will run next', Help='The Date Next Run indicates the next time this process will run.', Placeholder=NULL WHERE AD_Element_ID=1090 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:20 PM CEST
UPDATE AD_Field SET Name='Date Next Run', Description='Date the process will run next', Help='The Date Next Run indicates the next time this process will run.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1090) AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:20 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Date Next Run', Name='Date Next Run' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1090)
;

-- Sep 29, 2022, 6:19:23 PM CEST
UPDATE AD_Element SET Name='Date Printed',Updated=TO_TIMESTAMP('2022-09-29 18:19:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1091
;

-- Sep 29, 2022, 6:19:23 PM CEST
UPDATE AD_Column SET ColumnName='DatePrinted', Name='Date Printed', Description='Date the document was printed.', Help='Indicates the Date that a document was printed.', Placeholder=NULL WHERE AD_Element_ID=1091
;

-- Sep 29, 2022, 6:19:23 PM CEST
UPDATE AD_Process_Para SET ColumnName='DatePrinted', Name='Date Printed', Description='Date the document was printed.', Help='Indicates the Date that a document was printed.', AD_Element_ID=1091 WHERE UPPER(ColumnName)='DATEPRINTED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 29, 2022, 6:19:23 PM CEST
UPDATE AD_Process_Para SET ColumnName='DatePrinted', Name='Date Printed', Description='Date the document was printed.', Help='Indicates the Date that a document was printed.', Placeholder=NULL WHERE AD_Element_ID=1091 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:23 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DatePrinted', Name='Date Printed', Description='Date the document was printed.', Help='Indicates the Date that a document was printed.', Placeholder=NULL WHERE AD_Element_ID=1091 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:23 PM CEST
UPDATE AD_Field SET Name='Date Printed', Description='Date the document was printed.', Help='Indicates the Date that a document was printed.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1091) AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:23 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Date printed', Name='Date Printed' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1091)
;

-- Sep 29, 2022, 6:19:27 PM CEST
UPDATE AD_Element SET Name='Date Received', PrintName='Date Received',Updated=TO_TIMESTAMP('2022-09-29 18:19:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1324
;

-- Sep 29, 2022, 6:19:27 PM CEST
UPDATE AD_Column SET ColumnName='DateReceived', Name='Date Received', Description='Date a product was received', Help='The Date Received indicates the date that product was received.', Placeholder=NULL WHERE AD_Element_ID=1324
;

-- Sep 29, 2022, 6:19:27 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateReceived', Name='Date Received', Description='Date a product was received', Help='The Date Received indicates the date that product was received.', AD_Element_ID=1324 WHERE UPPER(ColumnName)='DATERECEIVED' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 29, 2022, 6:19:27 PM CEST
UPDATE AD_Process_Para SET ColumnName='DateReceived', Name='Date Received', Description='Date a product was received', Help='The Date Received indicates the date that product was received.', Placeholder=NULL WHERE AD_Element_ID=1324 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:27 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DateReceived', Name='Date Received', Description='Date a product was received', Help='The Date Received indicates the date that product was received.', Placeholder=NULL WHERE AD_Element_ID=1324 AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:27 PM CEST
UPDATE AD_Field SET Name='Date Received', Description='Date a product was received', Help='The Date Received indicates the date that product was received.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1324) AND IsCentrallyMaintained='Y'
;

-- Sep 29, 2022, 6:19:27 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Date Received', Name='Date Received' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1324)
;

-- Sep 29, 2022, 6:19:34 PM CEST
UPDATE AD_Element SET PrintName='Date Printed',Updated=TO_TIMESTAMP('2022-09-29 18:19:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1091
;

-- Sep 29, 2022, 6:19:34 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Date Printed', Name='Date Printed' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1091)
;

