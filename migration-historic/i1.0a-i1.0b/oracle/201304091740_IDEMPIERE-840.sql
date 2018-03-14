-- Apr 8, 2013 3:19:13 PM SGT
-- IDEMPIERE-840 Improvement to Request model class
INSERT INTO AD_ModelValidator (SeqNo,AD_ModelValidator_ID,ModelValidationClass,EntityType,Name,AD_ModelValidator_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES (0,200003,'org.compiere.model.RequestValidator','D','Model Validator to Request','999ba600-0d71-4f82-bf24-1a7876efa389',0,TO_DATE('2013-04-08 15:19:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-04-08 15:19:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

SELECT register_migration_script('201304091740_IDEMPIERE-840.sql') FROM dual
;