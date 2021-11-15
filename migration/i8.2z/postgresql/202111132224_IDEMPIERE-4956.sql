-- Fix logic fields

UPDATE AD_Field SET DisplayLogic='@IsDropShip@=''Y''', Updated=statement_timestamp(), UpdatedBy=100 WHERE DisplayLogic='@IsDropShip@=Y''' AND AD_Field_ID = 55427
;

UPDATE AD_Field SET DisplayLogic='@IsDropShip@=''Y''', Updated=statement_timestamp(), UpdatedBy=100 WHERE DisplayLogic='@IsDropShip@=Y''' AND AD_Field_ID = 57734
;

UPDATE AD_Field SET DisplayLogic='@A_SourceType@=''MAN''', Updated=statement_timestamp(), UpdatedBy=100 WHERE DisplayLogic='@A_SourceType@=''MAN''''' AND AD_Field_ID = 59348
;

UPDATE AD_Field SET DisplayLogic='@Processed@=Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE DisplayLogic='Processed=Y' AND AD_Field_ID = 10456
;

UPDATE AD_Field SET DisplayLogic='@Processed@=Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE DisplayLogic='Processed=Y' AND AD_Field_ID = 10457
;

UPDATE AD_Field SET DisplayLogic='@Type@=''D''|@Type@=''SQL''', Updated=statement_timestamp(), UpdatedBy=100 WHERE DisplayLogic='@Type@=''D''|Type@=''SQL''' AND AD_Field_ID = 50135
;

UPDATE AD_Column SET ReadOnlyLogic='', Updated=statement_timestamp(), UpdatedBy=100 WHERE ReadOnlyLogic='N' AND AD_Column_ID = 200452
;

SELECT Register_Migration_Script ('202111132224_IDEMPIERE-4956.sql') FROM DUAL
;
