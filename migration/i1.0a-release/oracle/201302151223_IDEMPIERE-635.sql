-- Feb 15, 2013 12:19:22 PM COT
-- IDEMPIERE-635 Reference validation behaving different than Dynamic Validation
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Description,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('EXISTS (SELECT * FROM C_BPartner bp WHERE AD_User.C_BPartner_ID=bp.C_BPartner_ID AND bp.IsSalesRep=''Y'')',200025,'D','AD_User - SalesRep','Sales Reps','S','acb880d9-586d-4139-8bfd-4f275cda2e8a',100,100,TO_DATE('2013-02-15 12:19:21','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-15 12:19:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Feb 15, 2013 12:19:43 PM COT
-- IDEMPIERE-635 Reference validation behaving different than Dynamic Validation
UPDATE AD_Column SET AD_Reference_Value_ID=110, AD_Val_Rule_ID=200025,Updated=TO_DATE('2013-02-15 12:19:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2186
;

-- Feb 15, 2013 12:20:22 PM COT
-- IDEMPIERE-635 Reference validation behaving different than Dynamic Validation
UPDATE AD_Column SET AD_Reference_Value_ID=110, AD_Val_Rule_ID=200025,Updated=TO_DATE('2013-02-15 12:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4431
;

SELECT register_migration_script('201302151223_IDEMPIERE-635.sql') FROM dual
;

