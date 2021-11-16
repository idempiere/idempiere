SET SQLBLANKLINES ON
SET DEFINE OFF

-- Fix logic fields

UPDATE AD_Field SET DisplayLogic='@IsDropShip@=''Y''', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@IsDropShip@=Y''' AND AD_Field_ID = 55427
;

UPDATE AD_Field SET DisplayLogic='@IsDropShip@=''Y''', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@IsDropShip@=Y''' AND AD_Field_ID = 57734
;

UPDATE AD_Field SET DisplayLogic='@A_SourceType@=''MAN''', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@A_SourceType@=''MAN''''' AND AD_Field_ID = 59348
;

UPDATE AD_Field SET DisplayLogic='@Processed@=Y', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='Processed=Y' AND AD_Field_ID = 10456
;

UPDATE AD_Field SET DisplayLogic='@Processed@=Y', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='Processed=Y' AND AD_Field_ID = 10457
;

UPDATE AD_Field SET DisplayLogic='@Type@=''D''|@Type@=''SQL''', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@Type@=''D''|Type@=''SQL''' AND AD_Field_ID = 50135
;

UPDATE AD_Column SET ReadOnlyLogic=NULL, Updated=getDate(), UpdatedBy=100 WHERE ReadOnlyLogic='N' AND AD_Column_ID = 200452
;

UPDATE AD_Field SET DisplayLogic='@$Element_PJ@=Y & (@C_Invoice_ID@=0 | @C_Invoice_ID@='''')', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@$Element_PJ@=Y & @C_Invoice_ID@=0 | @C_Invoice_ID@=''''' AND AD_Field_ID IN (200705,6551)
;

UPDATE AD_Field SET DisplayLogic='@OrderType@=''OB'' | @OrderType@=''SO'' | @Processed@=''Y''', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@DirectShip@=''N'' & @OrderType@=''OB'' | @OrderType@=''SO'' | @Processed@=''Y''' AND AD_Field_ID IN (1129,62343)
;

UPDATE AD_Field SET DisplayLogic='@IsSummary@=''N'' & (@ProductType@=I | @ProductType@=S)', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@IsSummary@=''N'' & @ProductType@=I | @ProductType@=S'	AND AD_Field_ID IN (3743,11782,59804,53592,53890)
;

UPDATE AD_Field SET DisplayLogic='1=0', Updated=getDate(), UpdatedBy=100 WHERE DisplayLogic='@DirectShip@=''N''' AND AD_Field_ID = 3388
;

SELECT Register_Migration_Script ('202111132224_IDEMPIERE-4956.sql') FROM DUAL
;
