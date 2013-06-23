-- Jun 21, 2013 2:31:08 PM COT
-- IDEMPIERE-594 Improve positioning on windows
UPDATE AD_Field SET IsCentrallyMaintained='N', Help='You can check the valid variables and values at http://wiki.idempiere.org/en/System_Configurator_(Window_ID-50006)', Description='Value for the configuration key', Name='Configured Value',Updated=TO_TIMESTAMP('2013-06-21 14:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50166
;

-- Jun 21, 2013 2:44:12 PM COT
UPDATE AD_Field SET SeqNo=730, IsDisplayed='Y', XPosition=5,Updated=TO_TIMESTAMP('2013-06-21 14:44:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4040
;

-- Jun 21, 2013 2:44:13 PM COT
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-06-21 14:44:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52052
;

-- Jun 21, 2013 2:46:13 PM COT
UPDATE AD_Column SET IsSelectionColumn='N',Updated=TO_TIMESTAMP('2013-06-21 14:46:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5050
;

-- Jun 21, 2013 2:51:52 PM COT
UPDATE AD_Field SET IsReadOnly='Y', DisplayLogic='@Processed@=Y', IsDisplayedGrid='Y', SeqNoGrid=730,Updated=TO_TIMESTAMP('2013-06-21 14:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4040
;

SELECT register_migration_script('201306211448_IDEMPIERE-594.sql') FROM dual
;

