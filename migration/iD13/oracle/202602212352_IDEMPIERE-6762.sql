-- IDEMPIERE-6762 Exception occurs when attempting to export a simple fact view report
SELECT register_migration_script('202602212352_IDEMPIERE-6762.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 21, 2026, 11:52:23 PM CET
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2026-02-21 23:52:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202525
;

-- Feb 22, 2026, 12:00:34 AM CET
UPDATE AD_Element SET Description='Defines if the 2Pack must include entries marked as Dictionary', Help='Defines if the 2Pack must include entries marked as Dictionary.
Be careful about this option:
- When the 2Pack is created from System tenant it is marked as UpdateDictionary="true" and consequently the dictionary is updated in the target system
- When the 2Pack is created from a non System tenant entries are exported but the 2Pack is marked as UpdateDictionary="false", this is to allow exporting tenant records, for example extra nodes of a System workflow, without affecting the target dictionary',Updated=TO_TIMESTAMP('2026-02-22 00:00:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202618
;

-- Feb 22, 2026, 12:00:34 AM CET
UPDATE AD_Column SET ColumnName='IsExportDictionaryEntity', Name='Export Dictionary Entity', Description='Defines if the 2Pack must include entries marked as Dictionary', Help='Defines if the 2Pack must include entries marked as Dictionary.
Be careful about this option:
- When the 2Pack is created from System tenant it is marked as UpdateDictionary="true" and consequently the dictionary is updated in the target system
- When the 2Pack is created from a non System tenant entries are exported but the 2Pack is marked as UpdateDictionary="false", this is to allow exporting tenant records, for example extra nodes of a System workflow, without affecting the target dictionary', Placeholder=NULL WHERE AD_Element_ID=202618
;

-- Feb 22, 2026, 12:00:34 AM CET
UPDATE AD_Process_Para SET ColumnName='IsExportDictionaryEntity', Name='Export Dictionary Entity', Description='Defines if the 2Pack must include entries marked as Dictionary', Help='Defines if the 2Pack must include entries marked as Dictionary.
Be careful about this option:
- When the 2Pack is created from System tenant it is marked as UpdateDictionary="true" and consequently the dictionary is updated in the target system
- When the 2Pack is created from a non System tenant entries are exported but the 2Pack is marked as UpdateDictionary="false", this is to allow exporting tenant records, for example extra nodes of a System workflow, without affecting the target dictionary', AD_Element_ID=202618 WHERE UPPER(ColumnName)='ISEXPORTDICTIONARYENTITY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 22, 2026, 12:00:34 AM CET
UPDATE AD_Process_Para SET ColumnName='IsExportDictionaryEntity', Name='Export Dictionary Entity', Description='Defines if the 2Pack must include entries marked as Dictionary', Help='Defines if the 2Pack must include entries marked as Dictionary.
Be careful about this option:
- When the 2Pack is created from System tenant it is marked as UpdateDictionary="true" and consequently the dictionary is updated in the target system
- When the 2Pack is created from a non System tenant entries are exported but the 2Pack is marked as UpdateDictionary="false", this is to allow exporting tenant records, for example extra nodes of a System workflow, without affecting the target dictionary', Placeholder=NULL WHERE AD_Element_ID=202618 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2026, 12:00:34 AM CET
UPDATE AD_InfoColumn SET ColumnName='IsExportDictionaryEntity', Name='Export Dictionary Entity', Description='Defines if the 2Pack must include entries marked as Dictionary', Help='Defines if the 2Pack must include entries marked as Dictionary.
Be careful about this option:
- When the 2Pack is created from System tenant it is marked as UpdateDictionary="true" and consequently the dictionary is updated in the target system
- When the 2Pack is created from a non System tenant entries are exported but the 2Pack is marked as UpdateDictionary="false", this is to allow exporting tenant records, for example extra nodes of a System workflow, without affecting the target dictionary', Placeholder=NULL WHERE AD_Element_ID=202618 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2026, 12:00:34 AM CET
UPDATE AD_Field SET Name='Export Dictionary Entity', Description='Defines if the 2Pack must include entries marked as Dictionary', Help='Defines if the 2Pack must include entries marked as Dictionary.
Be careful about this option:
- When the 2Pack is created from System tenant it is marked as UpdateDictionary="true" and consequently the dictionary is updated in the target system
- When the 2Pack is created from a non System tenant entries are exported but the 2Pack is marked as UpdateDictionary="false", this is to allow exporting tenant records, for example extra nodes of a System workflow, without affecting the target dictionary', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202618) AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2026, 12:18:25 AM CET
UPDATE AD_Field SET SeqNo=60, NumLines=5,Updated=TO_TIMESTAMP('2026-02-22 00:18:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50082
;

-- Feb 22, 2026, 12:18:25 AM CET
UPDATE AD_Field SET SeqNo=70, NumLines=5,Updated=TO_TIMESTAMP('2026-02-22 00:18:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50083
;

-- Feb 22, 2026, 12:18:25 AM CET
UPDATE AD_Field SET SeqNo=90, ColumnSpan=1,Updated=TO_TIMESTAMP('2026-02-22 00:18:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202525
;

-- Feb 22, 2026, 12:18:25 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=6, ColumnSpan=1,Updated=TO_TIMESTAMP('2026-02-22 00:18:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208976
;

