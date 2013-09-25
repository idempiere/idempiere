-- Sep 12, 2013 12:33:05 AM CEST
-- IDEMPIERE-1328 Change tab name dynamically
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202611,'ee851d43-325a-4dd4-8145-8e678ad2438c',0,'TitleLogic',TO_TIMESTAMP('2013-09-12 00:33:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Title Logic','Title Logic',TO_TIMESTAMP('2013-09-12 00:33:04','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 12, 2013 12:33:20 AM CEST
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSecure,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,210870,'3eda4c98-a396-4f5e-9ee3-1871f2715ea2',202611,0,10,105,'TitleLogic',TO_TIMESTAMP('2013-09-12 00:33:20','YYYY-MM-DD HH24:MI:SS'),100,'D',255,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','N','Y','Title Logic',0,0,TO_TIMESTAMP('2013-09-12 00:33:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 12, 2013 12:33:21 AM CEST
ALTER TABLE AD_Window ADD COLUMN TitleLogic VARCHAR(255) DEFAULT NULL 
;

-- Sep 12, 2013 12:33:33 AM CEST
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,ColumnSpan,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,Updated,UpdatedBy) VALUES (0,210870,202516,'fddaf61f-aed7-4dcb-b53c-9706b10f134c',0,105,5,TO_TIMESTAMP('2013-09-12 00:33:33','YYYY-MM-DD HH24:MI:SS'),100,255,'D','Y','Y','Y','N','N','N','N','N','Title Logic',180,TO_TIMESTAMP('2013-09-12 00:33:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 12, 2013 12:33:41 AM CEST
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202514
;

-- Sep 12, 2013 12:33:41 AM CEST
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=202516
;

-- Sep 12, 2013 12:33:41 AM CEST
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=3203
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=269
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=1988
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=114
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=115
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=116
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=268
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=10569
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=267
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=5379
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=4942
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=4943
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=5124
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=8194
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=10397
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=10396
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=202516
;

-- Sep 12, 2013 12:33:47 AM CEST
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=3203
;

-- Sep 25, 2013 12:42:02 PM COT
UPDATE AD_Element SET Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
@TaxID@
@DocumentNo@
@Value@ @Name@
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.', Description='The result determines the title to be displayed for this window',Updated=TO_TIMESTAMP('2013-09-25 12:42:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202611
;

-- Sep 25, 2013 12:42:02 PM COT
UPDATE AD_Column SET ColumnName='TitleLogic', Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
@TaxID@
@DocumentNo@
@Value@ @Name@
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.' WHERE AD_Element_ID=202611
;

-- Sep 25, 2013 12:42:02 PM COT
UPDATE AD_Process_Para SET ColumnName='TitleLogic', Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
@TaxID@
@DocumentNo@
@Value@ @Name@
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.', AD_Element_ID=202611 WHERE UPPER(ColumnName)='TITLELOGIC' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 25, 2013 12:42:02 PM COT
UPDATE AD_Process_Para SET ColumnName='TitleLogic', Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
@TaxID@
@DocumentNo@
@Value@ @Name@
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.' WHERE AD_Element_ID=202611 AND IsCentrallyMaintained='Y'
;

-- Sep 25, 2013 12:42:02 PM COT
UPDATE AD_InfoColumn SET ColumnName='TitleLogic', Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
@TaxID@
@DocumentNo@
@Value@ @Name@
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.' WHERE AD_Element_ID=202611 AND IsCentrallyMaintained='Y'
;

-- Sep 25, 2013 12:42:02 PM COT
UPDATE AD_Field SET Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
@TaxID@
@DocumentNo@
@Value@ @Name@
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202611) AND IsCentrallyMaintained='Y'
;

SELECT register_migration_script('201309120100_IDEMPIERE-1328.sql') FROM dual
;
