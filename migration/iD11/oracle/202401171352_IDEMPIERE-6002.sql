-- IDEMPIERE-6002
SELECT register_migration_script('202401171352_IDEMPIERE-6002.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 17, 2024, 1:52:26 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208124,'PP_Product_BOM_UU',53286,60999,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 13:52:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 13:52:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','EE01','24fc9cf4-89f7-4593-a16a-e65e2ce0c71b','N',2)
;

-- Jan 17, 2024, 1:52:38 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208126,'PP_Product_BOMLine_UU',53287,61000,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 13:52:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 13:52:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','EE01','a2fba48d-de3d-4984-98c7-913192f32336','N',2)
;

-- Jan 17, 2024, 2:33:24 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208127,'C_UserRemuneration_UU',727,60785,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:33:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:33:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ac53d015-b81e-4845-8e02-a4d96c37bfd1','N',2)
;

-- Jan 17, 2024, 2:33:39 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208128,'C_Remuneration_UU',725,60748,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:33:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:33:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','22a4c7a5-1c81-474f-bfe0-5d73b99aba1a','N',2)
;

-- Jan 17, 2024, 2:34:16 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208129,'C_JobRemuneration_UU',726,60672,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:34:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','89ea5b06-db1f-4d4a-8bc9-deef934c0a99','N',2)
;

-- Jan 17, 2024, 2:34:42 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208130,'C_RevenueRecognition_UU',272,60749,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:34:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:34:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2ebbba1e-d619-4b70-a2f1-2c73f7325ab8','N',2)
;

-- Jan 17, 2024, 2:34:53 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208131,'C_RevenueRecog_Service_UU',54010,213821,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:34:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:34:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fca1c37f-d263-4f3e-aa58-3db1631fd8bd','N',2)
;

-- Jan 17, 2024, 2:35:29 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208132,'C_RevenueRecognition_Plan_UU',378,60750,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:35:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:35:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3dfc30f9-e6f4-4f53-b884-e6d588e6421e','N',2)
;

-- Jan 17, 2024, 2:35:36 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208133,'C_RevenueRecognition_Run_UU',379,60751,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:35:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:35:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','db5a1b37-d659-4235-bd38-90771d52a742','N',2)
;

-- Jan 17, 2024, 2:36:25 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208170,'AD_Column_UU',200269,60388,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-17 14:36:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-17 14:36:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b98179ad-9664-4692-beb5-bc6953fe0678','N',2)
;

