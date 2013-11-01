-- Aug 6, 2013 1:35:12 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Column SET AD_Val_Rule_ID=158, IsToolbarButton='N',Updated=TO_DATE('2013-08-06 13:35:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200990
;

-- Aug 6, 2013 1:36:09 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,IsActive,AD_Org_ID,AD_Client_ID) VALUES ('AD_User.AD_User_ID IN (SELECT AD_User_ID FROM AD_User_Roles WHERE IsActive=''Y'' AND AD_User_Roles.AD_Client_ID=@#AD_Client_ID@)',200052,'D','AD_User of Client','S','db84ffe3-27c1-4a81-85f5-dcb3effecadd',100,100,TO_DATE('2013-08-06 13:36:08','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-06 13:36:08','YYYY-MM-DD HH24:MI:SS'),'Y',0,0)
;

-- Aug 6, 2013 1:36:29 PM COT
-- IDEMPIERE-1138 Broadcast Message Problems
UPDATE AD_Column SET AD_Val_Rule_ID=200052, IsToolbarButton='N',Updated=TO_DATE('2013-08-06 13:36:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200991
;

SELECT register_migration_script('20130608133825_IDEMPIERE-1138.sql') FROM dual
;
