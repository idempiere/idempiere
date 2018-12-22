-- IDEMPIERE-2933
-- Nov 28, 2018, 9:51:40 PM CET
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2018-11-28 21:51:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200258
;

-- Nov 28, 2018, 9:51:42 PM CET
INSERT INTO t_alter_column values('ad_tab_customization','AD_User_ID','NUMERIC(10)',null,null)
;

-- Nov 28, 2018, 9:51:42 PM CET
ALTER TABLE AD_Tab_Customization DROP CONSTRAINT aduser_adtabcustomization
;

-- Nov 28, 2018, 9:51:42 PM CET
ALTER TABLE AD_Tab_Customization ADD CONSTRAINT aduser_adtabcustomization FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201811282152_IDEMPIERE-2933.sql') FROM dual
;

