SELECT register_migration_script('202309291327_IDEMPIERE-5836.sql') FROM dual;
-- IDEMPIERE-5836 Adding support for Stocked Expense type product.
-- Aug 8, 2023, 1:27:56 PM IST
UPDATE AD_Field SET DisplayLogic='@ProductType@=I | @ProductType@=E & @IsSummary@=''N''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-08-08 13:27:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1026
;

-- Aug 8, 2023, 1:29:13 PM IST
UPDATE AD_Column SET ReadOnlyLogic='@ProductType@=R | @ProductType@=O',Updated=TO_TIMESTAMP('2023-08-08 13:29:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1761
;

-- Oct 2, 2023, 3:38:33 PM IST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutProduct.productType',Updated=TO_TIMESTAMP('2023-10-02 15:38:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=7795
;

-- May 20, 2024, 11:49:26 AM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Expensed type items are not allowed!!!',0,0,'Y',TO_TIMESTAMP('2024-05-20 11:49:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-05-20 11:49:25','YYYY-MM-DD HH24:MI:SS'),100,200898,'BOMExpenseTypeComponentNotAllowed','D','8ae3b346-18ee-45e0-a245-f9222a8e8db9')
;