SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2895
-- Mar 26, 2019, 9:06:37 AM BRT
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200125,'AD_Menu.Action - no Detail','S','AD_Ref_List.Value <> ''D''',0,0,'Y',TO_DATE('2019-03-26 09:06:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-26 09:06:36','YYYY-MM-DD HH24:MI:SS'),100,'D','a7067092-dff7-4e79-b277-7ee2131fcb69')
;

-- Mar 26, 2019, 9:06:48 AM BRT
UPDATE AD_Column SET AD_Val_Rule_ID=200125,Updated=TO_DATE('2019-03-26 09:06:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=232
;

SELECT register_migration_script('201903260907_IDEMPIERE-2895.sql') FROM dual
;

