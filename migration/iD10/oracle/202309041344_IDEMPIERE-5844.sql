-- IDEMPIERE-5844
SELECT register_migration_script('202309041344_IDEMPIERE-5844.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 10, 2023, 1:31:52 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200643,'Info',200084,'I',0,0,'Y',TO_TIMESTAMP('2023-08-10 13:31:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-08-10 13:31:51','YYYY-MM-DD HH24:MI:SS'),10,'D','4e05c125-8a96-4a0c-8e7a-57781c141f3a')
;

-- Sep 4, 2023, 1:44:46 PM CEST
UPDATE AD_Ref_List SET Name='Info Window',Updated=TO_TIMESTAMP('2023-09-04 13:44:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Ref_List_ID=200643
;

INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207714,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',156,211766,'Y',10,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-08-10 13:32:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-08-10 13:32:45','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','621b4e27-5931-45c2-9b1a-8adef6bedb46','Y',110,2)
;
