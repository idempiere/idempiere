-- Mar 6, 2013 5:52:10 PM SGT
-- Ticket 1002354: Price List Enhancement
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200134,194,'D','Product Cost','ee848c2c-1648-441e-a33a-c064e6fb0203','P',100,TO_TIMESTAMP('2013-03-06 17:52:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-06 17:52:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Mar 6, 2013 5:52:11 PM SGT
-- Ticket 1002354: Price List Enhancement
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200134 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Mar 6, 2013 7:08:02 PM SGT
-- Ticket 1002354: Price List Enhancement
INSERT INTO AD_ModelValidator (SeqNo,AD_ModelValidator_ID,Help,ModelValidationClass,EntityType,Description,Name,AD_ModelValidator_UU,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES (0,200002,'Auto sync corresponding price list with the base price list','org.adempiere.model.ProductPriceValidator','D','Product Price','Model Validator to Product Price','cc9a0a8e-8749-45be-a38d-61e9e61aab3d',0,0,TO_TIMESTAMP('2013-03-06 19:07:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-06 19:07:59','YYYY-MM-DD HH24:MI:SS'),100,'N')
;

-- Mar 6, 2013 7:08:42 PM SGT
-- Ticket 1002354: Price List Enhancement
UPDATE AD_ModelValidator SET SeqNo=1,Updated=TO_TIMESTAMP('2013-03-06 19:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ModelValidator_ID=200002
;

SELECT register_migration_script('201303061816_TICKET-1002354.sql') FROM dual
;
