SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 11, 2018 5:49:00 PM SGT
-- AP2-671 Make a filtering list box
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-11 17:49:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56279
;

SELECT register_migration_script('201810122100_Ticket_AP2-671.sql') FROM dual
;