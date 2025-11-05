-- IDEMPIERE-6697 Rename Master Role as Role Template and split to Role Template window
SELECT register_migration_script('202510141535_IDEMPIERE-6697.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 14, 2025, 3:35:16 PM MYT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2025-10-14 15:35:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=534
;

-- Oct 14, 2025, 3:35:21 PM MYT
ALTER TABLE AD_Role MODIFY UserLevel NULL
;

-- Oct 14, 2025, 3:35:48 PM MYT
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_TIMESTAMP('2025-10-14 15:35:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=364
;

-- Oct 14, 2025, 3:36:10 PM MYT
DELETE FROM AD_Field WHERE AD_Field_UU='8a4d9f0a-f479-469e-9ac0-eb8ebd946fd9'
;

-- Oct 14, 2025, 3:42:02 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208974,'Role Template','A role template cannot be assigned to users, it is intended to define access to menu option and documents and inherit to other roles',485,200410,'Y',0,130,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-14 15:42:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-14 15:42:01','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','f9e394d8-91a3-4cf7-8465-79bdba8fae41','Y',130,2,2,1,'N','N','N','N','N')
;

-- Oct 14, 2025, 3:42:50 PM MYT
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_TIMESTAMP('2025-10-14 15:42:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=485
;

-- Oct 14, 2025, 7:26:58 PM MYT
UPDATE AD_Tab SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2025-10-14 19:26:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=485
;
