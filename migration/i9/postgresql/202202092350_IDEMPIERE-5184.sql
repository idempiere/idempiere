-- IDEMPIERE-5184 cost adjustment - make currency mandatory
-- Feb 9, 2022, 11:52:39 PM AEDT
UPDATE AD_Field SET IsMandatory='Y', DefaultValue='@$C_Currency_ID@', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-02-09 23:52:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204145
;

SELECT Register_Migration_Script ('202202092350_IDEMPIERE-5184.sql') FROM DUAL
;
