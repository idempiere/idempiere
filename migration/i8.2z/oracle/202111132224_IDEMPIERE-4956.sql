SET SQLBLANKLINES ON
SET DEFINE OFF

-- Fix quotes in displaylogic

UPDATE AD_Field SET DisplayLogic='@IsDropShip@=''Y''', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@IsDropShip@=Y''' AND AD_Field_ID = 55427
;

UPDATE AD_Field SET DisplayLogic='@IsDropShip@=''Y''', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@IsDropShip@=Y''' AND AD_Field_ID = 57734
;

UPDATE AD_Field SET DisplayLogic='@A_SourceType@=''MAN''', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@A_SourceType@=''MAN''''' AND AD_Field_ID = 59348
;

SELECT Register_Migration_Script ('202111132224_IDEMPIERE-4956.sql') FROM DUAL
;
