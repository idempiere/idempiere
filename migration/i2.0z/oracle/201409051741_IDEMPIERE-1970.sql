SET SQLBLANKLINES ON
SET DEFINE OFF

update ad_infoprocess set ad_column_id=null where ad_column_id is not null;

ALTER TABLE AD_INFOPROCESS RENAME COLUMN AD_COLUMN_ID TO AD_INFOCOLUMN_ID;

ALTER TABLE AD_INFOPROCESS DROP CONSTRAINT ADCOLUMN_ADINFOPROCESS;

-- Sep 5, 2014 5:40:41 PM COT
-- IDEMPIERE-1970 Improve t_selection logic for info window
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,AD_Org_ID,IsActive,AD_Client_ID,Created) VALUES ('AD_InfoColumn.AD_InfoWindow_ID=@AD_InfoWindow_ID@',200065,'D','AD_InfoColumn from Info Window','S','010f3e1f-dd6c-48c7-8fe1-945e0a2482a2',100,100,TO_DATE('2014-09-05 17:40:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',0,TO_DATE('2014-09-05 17:40:37','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 5, 2014 5:40:55 PM COT
UPDATE AD_Column SET FieldLength=10, IsUpdateable='N', ColumnName='AD_InfoColumn_ID', Description='Info Window Column', Help='Column in the Info Window for display and/or selection.  If used for selection, the column cannot be a SQL expression. The SQL clause must be fully qualified based on the FROM clause in the Info Window definition', Name='Info Column', FKConstraintName=NULL, AD_Element_ID=3069, AD_Val_Rule_ID=200065,Updated=TO_DATE('2014-09-05 17:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211377
;

-- Sep 5, 2014 5:41:00 PM COT
UPDATE AD_Column SET FKConstraintName='ADInfoColumn_ADInfoProcess', FKConstraintType='N',Updated=TO_DATE('2014-09-05 17:41:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211377
;

-- Sep 5, 2014 5:41:00 PM COT
ALTER TABLE AD_InfoProcess MODIFY AD_InfoColumn_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 5, 2014 5:41:00 PM COT
ALTER TABLE AD_InfoProcess ADD CONSTRAINT ADInfoColumn_ADInfoProcess FOREIGN KEY (AD_InfoColumn_ID) REFERENCES ad_infocolumn(ad_infocolumn_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 5, 2014 5:44:01 PM COT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2014-09-05 17:44:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211377
;

SELECT register_migration_script('201409051741_IDEMPIERE-1970.sql') FROM dual
;

