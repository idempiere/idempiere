SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 4, 2016 4:32:10 PM CEST
-- osef
UPDATE AD_Column SET AD_Element_ID=110, AD_Reference_ID=30, ColumnName='AD_Menu_ID', ColumnSQL='Node_ID', Description='Identifies a Menu', FKConstraintType=NULL, FieldLength=22, Help='The Menu identifies a unique Menu.  Menus are used to control the display of those screens a user has access to.', IsIdentifier='N', Name='Menu',Updated=TO_DATE('2016-10-04 16:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212589
;

-- Oct 4, 2016 4:32:39 PM CEST
UPDATE AD_Field SET EntityType='D',Updated=TO_DATE('2016-10-04 16:32:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=204112
;

-- Oct 4, 2016 4:32:43 PM CEST
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2016-10-04 16:32:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=212589
;

SELECT register_migration_script('201610041640_IDEMPIERE-3000_fix.sql') FROM dual
;