SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 3, 2014 3:26:22 PM COT
-- IDEMPIERE-2060 Move some Delete Cascade Constraints to Model classes
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Updated,UpdatedBy,IsActive,EntityType,AD_Client_ID,AD_Org_ID,Created) VALUES (200278,200075,'c0542a52-fe58-4b87-8bd4-9dc2fe3afa7a','Model Cascade','M',100,TO_DATE('2014-09-03 15:26:21','YYYY-MM-DD HH24:MI:SS'),100,'Y','D',0,0,TO_DATE('2014-09-03 15:26:21','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 3, 2014 3:44:58 PM COT
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='M',Updated=TO_DATE('2014-09-03 15:44:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2213
;

-- Sep 3, 2014 3:46:37 PM COT
ALTER TABLE C_OrderLine MODIFY C_Order_ID NUMBER(10)
;

-- Sep 3, 2014 3:46:37 PM COT
ALTER TABLE C_OrderLine DROP CONSTRAINT corder_corderline
;

-- Sep 3, 2014 3:46:37 PM COT
ALTER TABLE C_OrderLine ADD CONSTRAINT corder_corderline FOREIGN KEY (C_Order_ID) REFERENCES c_order(c_order_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 3, 2014 4:36:39 PM COT
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Description,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,AD_Org_ID,IsActive,AD_Client_ID,Created) VALUES ('(AD_Ref_List.Value!=''M'' OR @AD_Reference_ID@ IN (18,19,30))',200064,'D','FKConstraintType Model just for Direct Foreign Keys','Ref List by Reference','S','a56bce78-de21-4cfa-b18d-2dd367464c01',100,100,TO_DATE('2014-09-03 16:36:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',0,TO_DATE('2014-09-03 16:36:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 3, 2014 4:36:48 PM COT
UPDATE AD_Column SET AD_Val_Rule_ID=200064,Updated=TO_DATE('2014-09-03 16:36:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210872
;

SELECT register_migration_script('201409031529_IDEMPIERE-2060.sql') FROM dual
;

