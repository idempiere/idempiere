SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2580 Error with taxes and country groups
-- Apr 15, 2015 3:03:02 PM COT
UPDATE AD_Field SET ReadOnlyLogic=NULL,Updated=TO_DATE('2015-04-15 15:03:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203325
;

-- Apr 15, 2015 3:03:09 PM COT
UPDATE AD_Field SET ReadOnlyLogic=NULL,Updated=TO_DATE('2015-04-15 15:03:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203326
;

-- Apr 15, 2015 3:03:13 PM COT
UPDATE AD_Field SET ReadOnlyLogic=NULL,Updated=TO_DATE('2015-04-15 15:03:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=974
;

-- Apr 15, 2015 3:03:17 PM COT
UPDATE AD_Field SET ReadOnlyLogic=NULL,Updated=TO_DATE('2015-04-15 15:03:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=976
;

-- Apr 15, 2015 3:11:39 PM COT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200074,'C_Country of Country Group or All if no Group','S','@C_CountryGroupFrom_ID:0@=0 OR C_Country.C_Country_ID IN (SELECT C_Country_ID FROM C_CountryGroupCountry WHERE IsActive=''Y'' AND C_CountryGroup_ID=@C_CountryGroupFrom_ID:0@)',0,0,'Y',TO_DATE('2015-04-15 15:11:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-15 15:11:38','YYYY-MM-DD HH24:MI:SS'),100,'D','7d287aa4-e964-4d9f-8f21-5dbd2f4fc7e5')
;

-- Apr 15, 2015 3:12:43 PM COT
UPDATE AD_Column SET AD_Val_Rule_ID=200074,Updated=TO_DATE('2015-04-15 15:12:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2250
;

-- Apr 15, 2015 3:13:32 PM COT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200075,'C_Country of To Country Group or All if no Group','S','@C_CountryGroupTo_ID:0@=0 OR C_Country.C_Country_ID IN (SELECT C_Country_ID FROM C_CountryGroupCountry WHERE IsActive=''Y'' AND C_CountryGroup_ID=@C_CountryGroupTo_ID:0@)',0,0,'Y',TO_DATE('2015-04-15 15:13:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2015-04-15 15:13:31','YYYY-MM-DD HH24:MI:SS'),100,'D','cba16f68-4e2a-454b-a79b-914a15232029')
;

-- Apr 15, 2015 3:13:40 PM COT
UPDATE AD_Column SET AD_Val_Rule_ID=200075,Updated=TO_DATE('2015-04-15 15:13:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2252
;

SELECT register_migration_script('202202151738_IDEMPIERE-2580.sql') FROM dual
;

