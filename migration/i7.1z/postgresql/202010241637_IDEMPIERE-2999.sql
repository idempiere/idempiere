-- IDEMPIERE-2999 Attribute, Table Direct and date field support
-- Oct 24, 2020, 4:33:46 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200142,'M_Attribute.AttributeValueType','S','(''@#ShowAdvanced:N@''=''Y'' OR Value!=''R'')',0,0,'Y',TO_TIMESTAMP('2020-10-24 16:33:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-10-24 16:33:46','YYYY-MM-DD HH24:MI:SS'),100,'D','5610a6c5-c804-40b6-9fac-40a564ce1996')
;

-- Oct 24, 2020, 4:33:57 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200142,Updated=TO_TIMESTAMP('2020-10-24 16:33:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12662
;

-- Oct 24, 2020, 4:34:06 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200143,'M_AttributeUse.M_Attribute_ID','S','(''@#ShowAdvanced:N@''=''Y'' OR AttributeValueType!=''R'')',0,0,'Y',TO_TIMESTAMP('2020-10-24 16:34:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-10-24 16:34:06','YYYY-MM-DD HH24:MI:SS'),100,'D','199a88e4-ddcc-4b32-9d92-baadba49ab4e')
;

-- Oct 24, 2020, 4:34:20 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200143, IsUpdateable='N',Updated=TO_TIMESTAMP('2020-10-24 16:34:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8527
;

-- Oct 24, 2020, 4:36:04 PM CEST
UPDATE AD_Column SET ReadOnlyLogic='@AttributeValueType@=R & @#ShowAdvanced:N@!Y',Updated=TO_TIMESTAMP('2020-10-24 16:36:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=12662
;

-- Oct 24, 2020, 4:36:09 PM CEST
UPDATE AD_Column SET ReadOnlyLogic='@#ShowAdvanced:N@!Y',Updated=TO_TIMESTAMP('2020-10-24 16:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212643
;

-- Oct 24, 2020, 4:36:17 PM CEST
UPDATE AD_Column SET ReadOnlyLogic='@#ShowAdvanced:N@!Y',Updated=TO_TIMESTAMP('2020-10-24 16:36:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212644
;

-- Oct 24, 2020, 4:36:28 PM CEST
UPDATE AD_Column SET ReadOnlyLogic='@#ShowAdvanced:N@!Y',Updated=TO_TIMESTAMP('2020-10-24 16:36:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214317
;

SELECT register_migration_script('202010241637_IDEMPIERE-2999.sql') FROM dual
;

