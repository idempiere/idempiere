-- May 29, 2014 6:00:45 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=1,Updated=TO_TIMESTAMP('2014-05-29 18:00:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211254
;

-- May 29, 2014 6:02:16 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=203030
;

-- May 29, 2014 6:02:16 PM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=203036
;

-- May 29, 2014 6:02:16 PM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=203035
;

-- May 29, 2014 6:02:16 PM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=203037
;

-- May 29, 2014 6:02:16 PM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=203038
;

-- May 29, 2014 6:02:16 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=203031
;

SELECT register_migration_script('201405291802_IDEMPIERE-1334.sql') FROM dual
;

