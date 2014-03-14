-- Feb 12, 2014 7:25:09 PM SGT
-- IDEMPIERE-1599 Correct naming for acct wildcard dimensions
UPDATE AD_Element SET Name='User Element List 1',Updated=TO_TIMESTAMP('2014-02-12 19:25:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=613
;

-- Feb 12, 2014 7:25:09 PM SGT
UPDATE AD_Column SET ColumnName='User1_ID', Name='User Element List 1', Description='User defined list element #1', Help='The user defined element displays the optional elements that have been defined for this account combination.' WHERE AD_Element_ID=613
;

-- Feb 12, 2014 7:25:09 PM SGT
UPDATE AD_Process_Para SET ColumnName='User1_ID', Name='User Element List 1', Description='User defined list element #1', Help='The user defined element displays the optional elements that have been defined for this account combination.', AD_Element_ID=613 WHERE UPPER(ColumnName)='USER1_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 12, 2014 7:25:09 PM SGT
UPDATE AD_Process_Para SET ColumnName='User1_ID', Name='User Element List 1', Description='User defined list element #1', Help='The user defined element displays the optional elements that have been defined for this account combination.' WHERE AD_Element_ID=613 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:25:09 PM SGT
UPDATE AD_InfoColumn SET ColumnName='User1_ID', Name='User Element List 1', Description='User defined list element #1', Help='The user defined element displays the optional elements that have been defined for this account combination.' WHERE AD_Element_ID=613 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:25:09 PM SGT
UPDATE AD_Field SET Name='User Element List 1', Description='User defined list element #1', Help='The user defined element displays the optional elements that have been defined for this account combination.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=613) AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:25:09 PM SGT
UPDATE AD_PrintFormatItem SET PrintName='User 1', Name='User Element List 1' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=613)
;

-- Feb 12, 2014 7:25:15 PM SGT
UPDATE AD_Element SET Name='User Element List 2',Updated=TO_TIMESTAMP('2014-02-12 19:25:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=614
;

-- Feb 12, 2014 7:25:15 PM SGT
UPDATE AD_Column SET ColumnName='User2_ID', Name='User Element List 2', Description='User defined list element #2', Help='The user defined element displays the optional elements that have been defined for this account combination.' WHERE AD_Element_ID=614
;

-- Feb 12, 2014 7:25:15 PM SGT
UPDATE AD_Process_Para SET ColumnName='User2_ID', Name='User Element List 2', Description='User defined list element #2', Help='The user defined element displays the optional elements that have been defined for this account combination.', AD_Element_ID=614 WHERE UPPER(ColumnName)='USER2_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 12, 2014 7:25:15 PM SGT
UPDATE AD_Process_Para SET ColumnName='User2_ID', Name='User Element List 2', Description='User defined list element #2', Help='The user defined element displays the optional elements that have been defined for this account combination.' WHERE AD_Element_ID=614 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:25:15 PM SGT
UPDATE AD_InfoColumn SET ColumnName='User2_ID', Name='User Element List 2', Description='User defined list element #2', Help='The user defined element displays the optional elements that have been defined for this account combination.' WHERE AD_Element_ID=614 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:25:15 PM SGT
UPDATE AD_Field SET Name='User Element List 2', Description='User defined list element #2', Help='The user defined element displays the optional elements that have been defined for this account combination.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=614) AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:25:16 PM SGT
UPDATE AD_PrintFormatItem SET PrintName='User 2', Name='User Element List 2' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=614)
;

-- Feb 12, 2014 7:33:06 PM SGT
UPDATE AD_Element SET Name='User Column 2', PrintName='User Column 2',Updated=TO_TIMESTAMP('2014-02-12 19:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2878
;

-- Feb 12, 2014 7:33:06 PM SGT
UPDATE AD_Column SET ColumnName='UserElement2_ID', Name='User Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested) ' WHERE AD_Element_ID=2878
;

-- Feb 12, 2014 7:33:06 PM SGT
UPDATE AD_Process_Para SET ColumnName='UserElement2_ID', Name='User Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested) ', AD_Element_ID=2878 WHERE UPPER(ColumnName)='USERELEMENT2_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 12, 2014 7:33:06 PM SGT
UPDATE AD_Process_Para SET ColumnName='UserElement2_ID', Name='User Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested) ' WHERE AD_Element_ID=2878 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:06 PM SGT
UPDATE AD_InfoColumn SET ColumnName='UserElement2_ID', Name='User Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested) ' WHERE AD_Element_ID=2878 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:06 PM SGT
UPDATE AD_Field SET Name='User Column 2', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested) ' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2878) AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:06 PM SGT
UPDATE AD_PrintFormatItem SET PrintName='User Column 2', Name='User Column 2' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2878)
;

-- Feb 12, 2014 7:33:23 PM SGT
UPDATE AD_Element SET Name='User Column 1', PrintName='User Column 1',Updated=TO_TIMESTAMP('2014-02-12 19:33:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=2877
;

-- Feb 12, 2014 7:33:23 PM SGT
UPDATE AD_Column SET ColumnName='UserElement1_ID', Name='User Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)' WHERE AD_Element_ID=2877
;

-- Feb 12, 2014 7:33:23 PM SGT
UPDATE AD_Process_Para SET ColumnName='UserElement1_ID', Name='User Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)', AD_Element_ID=2877 WHERE UPPER(ColumnName)='USERELEMENT1_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 12, 2014 7:33:23 PM SGT
UPDATE AD_Process_Para SET ColumnName='UserElement1_ID', Name='User Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)' WHERE AD_Element_ID=2877 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:23 PM SGT
UPDATE AD_InfoColumn SET ColumnName='UserElement1_ID', Name='User Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)' WHERE AD_Element_ID=2877 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:23 PM SGT
UPDATE AD_Field SET Name='User Column 1', Description='User defined accounting Element', Help='A user defined accounting element referres to a iDempiere table. This allows to use any table content as an accounting dimension (e.g. Project Task).  Note that User Elements are optional and are populated from the context of the document (i.e. not requested)' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=2877) AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:23 PM SGT
UPDATE AD_PrintFormatItem SET PrintName='User Column 1', Name='User Column 1' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=2877)
;

-- Feb 12, 2014 7:33:29 PM SGT
UPDATE AD_Element SET Name='User Column 2 Dimension', PrintName='User Column 2 Dimension',Updated=TO_TIMESTAMP('2014-02-12 19:33:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53897
;

-- Feb 12, 2014 7:33:29 PM SGT
UPDATE AD_Column SET ColumnName='IsUserElement2Dim', Name='User Column 2 Dimension', Description='Include User Element 2 as a cube dimension', Help=NULL WHERE AD_Element_ID=53897
;

-- Feb 12, 2014 7:33:29 PM SGT
UPDATE AD_Process_Para SET ColumnName='IsUserElement2Dim', Name='User Column 2 Dimension', Description='Include User Element 2 as a cube dimension', Help=NULL, AD_Element_ID=53897 WHERE UPPER(ColumnName)='ISUSERELEMENT2DIM' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 12, 2014 7:33:29 PM SGT
UPDATE AD_Process_Para SET ColumnName='IsUserElement2Dim', Name='User Column 2 Dimension', Description='Include User Element 2 as a cube dimension', Help=NULL WHERE AD_Element_ID=53897 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:29 PM SGT
UPDATE AD_InfoColumn SET ColumnName='IsUserElement2Dim', Name='User Column 2 Dimension', Description='Include User Element 2 as a cube dimension', Help=NULL WHERE AD_Element_ID=53897 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:29 PM SGT
UPDATE AD_Field SET Name='User Column 2 Dimension', Description='Include User Element 2 as a cube dimension', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53897) AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:29 PM SGT
UPDATE AD_PrintFormatItem SET PrintName='User Column 2 Dimension', Name='User Column 2 Dimension' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53897)
;

-- Feb 12, 2014 7:33:32 PM SGT
UPDATE AD_Element SET Name='User Column 1 Dimension', PrintName='User Column 1 Dimension',Updated=TO_TIMESTAMP('2014-02-12 19:33:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53898
;

-- Feb 12, 2014 7:33:32 PM SGT
UPDATE AD_Column SET ColumnName='IsUserElement1Dim', Name='User Column 1 Dimension', Description='Include User Element 1 as a cube dimension', Help=NULL WHERE AD_Element_ID=53898
;

-- Feb 12, 2014 7:33:32 PM SGT
UPDATE AD_Process_Para SET ColumnName='IsUserElement1Dim', Name='User Column 1 Dimension', Description='Include User Element 1 as a cube dimension', Help=NULL, AD_Element_ID=53898 WHERE UPPER(ColumnName)='ISUSERELEMENT1DIM' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 12, 2014 7:33:32 PM SGT
UPDATE AD_Process_Para SET ColumnName='IsUserElement1Dim', Name='User Column 1 Dimension', Description='Include User Element 1 as a cube dimension', Help=NULL WHERE AD_Element_ID=53898 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:32 PM SGT
UPDATE AD_InfoColumn SET ColumnName='IsUserElement1Dim', Name='User Column 1 Dimension', Description='Include User Element 1 as a cube dimension', Help=NULL WHERE AD_Element_ID=53898 AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:32 PM SGT
UPDATE AD_Field SET Name='User Column 1 Dimension', Description='Include User Element 1 as a cube dimension', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53898) AND IsCentrallyMaintained='Y'
;

-- Feb 12, 2014 7:33:32 PM SGT
UPDATE AD_PrintFormatItem SET PrintName='User Column 1 Dimension', Name='User Column 1 Dimension' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53898)
;

-- Feb 17, 2014 11:25:22 AM SGT
-- IDEMPIERE-1599 Correct naming for acct wildcard dimensions
UPDATE AD_Element SET Description='Include User Element List 1 as a cube dimension', Name='User Element List 1 Dimension', PrintName='User Element List 1 Dimension',Updated=TO_TIMESTAMP('2014-02-17 11:25:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53835
;

-- Feb 17, 2014 11:25:22 AM SGT
UPDATE AD_Column SET ColumnName='IsUser1Dim', Name='User Element List 1 Dimension', Description='Include User Element List 1 as a cube dimension', Help=NULL WHERE AD_Element_ID=53835
;

-- Feb 17, 2014 11:25:22 AM SGT
UPDATE AD_Process_Para SET ColumnName='IsUser1Dim', Name='User Element List 1 Dimension', Description='Include User Element List 1 as a cube dimension', Help=NULL, AD_Element_ID=53835 WHERE UPPER(ColumnName)='ISUSER1DIM' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 17, 2014 11:25:22 AM SGT
UPDATE AD_Process_Para SET ColumnName='IsUser1Dim', Name='User Element List 1 Dimension', Description='Include User Element List 1 as a cube dimension', Help=NULL WHERE AD_Element_ID=53835 AND IsCentrallyMaintained='Y'
;

-- Feb 17, 2014 11:25:22 AM SGT
UPDATE AD_InfoColumn SET ColumnName='IsUser1Dim', Name='User Element List 1 Dimension', Description='Include User Element List 1 as a cube dimension', Help=NULL WHERE AD_Element_ID=53835 AND IsCentrallyMaintained='Y'
;

-- Feb 17, 2014 11:25:22 AM SGT
UPDATE AD_Field SET Name='User Element List 1 Dimension', Description='Include User Element List 1 as a cube dimension', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53835) AND IsCentrallyMaintained='Y'
;

-- Feb 17, 2014 11:25:22 AM SGT
UPDATE AD_PrintFormatItem SET PrintName='User Element List 1 Dimension', Name='User Element List 1 Dimension' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53835)
;

-- Feb 17, 2014 11:25:46 AM SGT
UPDATE AD_Element SET Description='Include User Element List 2 as a cube dimension', Name='User Element List 2 Dimension', PrintName='User Element List 2 Dimension',Updated=TO_TIMESTAMP('2014-02-17 11:25:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=53836
;

-- Feb 17, 2014 11:25:46 AM SGT
UPDATE AD_Column SET ColumnName='IsUser2Dim', Name='User Element List 2 Dimension', Description='Include User Element List 2 as a cube dimension', Help=NULL WHERE AD_Element_ID=53836
;

-- Feb 17, 2014 11:25:46 AM SGT
UPDATE AD_Process_Para SET ColumnName='IsUser2Dim', Name='User Element List 2 Dimension', Description='Include User Element List 2 as a cube dimension', Help=NULL, AD_Element_ID=53836 WHERE UPPER(ColumnName)='ISUSER2DIM' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 17, 2014 11:25:46 AM SGT
UPDATE AD_Process_Para SET ColumnName='IsUser2Dim', Name='User Element List 2 Dimension', Description='Include User Element List 2 as a cube dimension', Help=NULL WHERE AD_Element_ID=53836 AND IsCentrallyMaintained='Y'
;

-- Feb 17, 2014 11:25:46 AM SGT
UPDATE AD_InfoColumn SET ColumnName='IsUser2Dim', Name='User Element List 2 Dimension', Description='Include User Element List 2 as a cube dimension', Help=NULL WHERE AD_Element_ID=53836 AND IsCentrallyMaintained='Y'
;

-- Feb 17, 2014 11:25:46 AM SGT
UPDATE AD_Field SET Name='User Element List 2 Dimension', Description='Include User Element List 2 as a cube dimension', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=53836) AND IsCentrallyMaintained='Y'
;

-- Feb 17, 2014 11:25:47 AM SGT
UPDATE AD_PrintFormatItem SET PrintName='User Element List 2 Dimension', Name='User Element List 2 Dimension' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=53836)
;

-- Feb 17, 2014 11:26:47 AM SGT
UPDATE AD_Element SET PrintName='User Element List 1',Updated=TO_TIMESTAMP('2014-02-17 11:26:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=613
;

-- Feb 17, 2014 11:26:47 AM SGT
UPDATE AD_PrintFormatItem SET PrintName='User Element List 1', Name='User Element List 1' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=613)
;

-- Feb 17, 2014 11:26:54 AM SGT
UPDATE AD_Element SET PrintName='User Element List 2',Updated=TO_TIMESTAMP('2014-02-17 11:26:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=614
;

-- Feb 17, 2014 11:26:54 AM SGT
UPDATE AD_PrintFormatItem SET PrintName='User Element List 2', Name='User Element List 2' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=614)
;

SELECT register_migration_script('201402171130_IDEMPIERE-1599.sql') FROM dual
;