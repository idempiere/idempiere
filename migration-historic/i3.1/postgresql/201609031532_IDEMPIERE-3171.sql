-- IDEMPIERE-3171 Can't add record on POS Terminal, IDEMPIERE-170
-- Sep 3, 2016 2:31:03 PM GMT+01:00
UPDATE AD_Field SET IsDisplayed='N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2016-09-03 14:31:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10802
;

-- Sep 3, 2016 2:31:33 PM GMT+01:00
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2016-09-03 14:31:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12750
;

-- Sep 3, 2016 2:31:40 PM GMT+01:00
UPDATE AD_Field SET DefaultValue='-1', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2016-09-03 14:31:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10802
;

-- Sep 3, 2016 2:39:09 PM GMT+01:00
INSERT INTO t_alter_column values('c_pos','C_CashBook_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 3, 2016 2:39:09 PM GMT+01:00
INSERT INTO t_alter_column values('c_pos','C_CashBook_ID',null,'NULL',null)
;

SELECT register_migration_script('201609031532_IDEMPIERE-3171.sql') FROM dual
;

