-- Nov 1, 2014 1:24:42 AM CET
-- IDEMPIERE-2290 Error trying delete Window definition when the window is on ad_recentitem table
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2014-11-01 01:24:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200003
;

-- Nov 1, 2014 1:24:44 AM CET
INSERT INTO t_alter_column values('ad_recentitem','AD_Role_ID','NUMERIC(10)',null,null)
;

-- Nov 1, 2014 1:24:44 AM CET
ALTER TABLE AD_RecentItem DROP CONSTRAINT adrole_adrecentitem
;

-- Nov 1, 2014 1:24:44 AM CET
ALTER TABLE AD_RecentItem ADD CONSTRAINT adrole_adrecentitem FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2014 1:24:54 AM CET
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2014-11-01 01:24:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200004
;

-- Nov 1, 2014 1:24:56 AM CET
INSERT INTO t_alter_column values('ad_recentitem','AD_Tab_ID','NUMERIC(10)',null,'NULL')
;

-- Nov 1, 2014 1:24:56 AM CET
ALTER TABLE AD_RecentItem DROP CONSTRAINT adtab_adrecentitem
;

-- Nov 1, 2014 1:24:56 AM CET
ALTER TABLE AD_RecentItem ADD CONSTRAINT adtab_adrecentitem FOREIGN KEY (AD_Tab_ID) REFERENCES ad_tab(ad_tab_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2014 1:25:03 AM CET
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2014-11-01 01:25:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200005
;

-- Nov 1, 2014 1:25:05 AM CET
INSERT INTO t_alter_column values('ad_recentitem','AD_Table_ID','NUMERIC(10)',null,null)
;

-- Nov 1, 2014 1:25:05 AM CET
ALTER TABLE AD_RecentItem DROP CONSTRAINT adtable_adrecentitem
;

-- Nov 1, 2014 1:25:05 AM CET
ALTER TABLE AD_RecentItem ADD CONSTRAINT adtable_adrecentitem FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2014 1:25:11 AM CET
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2014-11-01 01:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200006
;

-- Nov 1, 2014 1:25:13 AM CET
INSERT INTO t_alter_column values('ad_recentitem','AD_User_ID','NUMERIC(10)',null,'NULL')
;

-- Nov 1, 2014 1:25:13 AM CET
ALTER TABLE AD_RecentItem DROP CONSTRAINT aduser_adrecentitem
;

-- Nov 1, 2014 1:25:13 AM CET
ALTER TABLE AD_RecentItem ADD CONSTRAINT aduser_adrecentitem FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2014 1:25:20 AM CET
UPDATE AD_Column SET FKConstraintType='C',Updated=TO_TIMESTAMP('2014-11-01 01:25:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200007
;

-- Nov 1, 2014 1:25:22 AM CET
INSERT INTO t_alter_column values('ad_recentitem','AD_Window_ID','NUMERIC(10)',null,'NULL')
;

-- Nov 1, 2014 1:25:22 AM CET
ALTER TABLE AD_RecentItem DROP CONSTRAINT adwindow_adrecentitem
;

-- Nov 1, 2014 1:25:22 AM CET
ALTER TABLE AD_RecentItem ADD CONSTRAINT adwindow_adrecentitem FOREIGN KEY (AD_Window_ID) REFERENCES ad_window(ad_window_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201410311927_IDEMPIERE-2290.sql') FROM dual
;

