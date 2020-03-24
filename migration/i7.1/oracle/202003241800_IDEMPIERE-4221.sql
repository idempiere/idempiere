SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4221 PackOut type Data Single (FHCA-1198)
-- Mar 24, 2020, 6:00:23 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200492,'Data Single',50004,'DS',0,0,'Y',TO_DATE('2020-03-24 18:00:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-03-24 18:00:23','YYYY-MM-DD HH24:MI:SS'),100,'D','bb6620c6-4cef-4796-90d6-007b83fe213f')
;

-- Mar 24, 2020, 6:26:24 PM CET
UPDATE AD_Field SET DisplayLogic='@Type@=''T''|@Type@=''D''|@Type@=''DS''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-03-24 18:26:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50103
;

-- Mar 24, 2020, 6:28:56 PM CET
UPDATE AD_Field SET DisplayLogic='@Type@=''D''|@Type@=''DS''|Type@=''SQL''|Type@=''SQM''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-03-24 18:28:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50105
;

SELECT register_migration_script('202003241800_IDEMPIERE-4221.sql') FROM dual
;

