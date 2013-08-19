-- Aug 14, 2013 9:52:38 AM COT
-- IDEMPIERE-1219 Error message when saving 2 default Tax Rates are not translated
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Only one @C_Tax_ID@ per @C_TaxCategory_ID@ can be marked as Default!',200220,'D','84a60603-8500-40be-a90f-f6c1bc16e827','OnlyOneTaxPerCategoryMarkedDefault','Y',TO_TIMESTAMP('2013-08-14 09:52:37','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-08-14 09:52:37','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Aug 14, 2013 9:52:38 AM COT
-- IDEMPIERE-1219 Error message when saving 2 default Tax Rates are not translated
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200220 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201308141001_IDEMPIERE-1269.sql') FROM dual
;

