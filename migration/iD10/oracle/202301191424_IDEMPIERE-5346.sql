-- IDEMPIERE-5346 SSO Support
SELECT register_migration_script('202301191424_IDEMPIERE-5346.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 19, 2023, 2:24:15 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203784,0,0,'Y',TO_TIMESTAMP('2023-01-19 14:24:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-19 14:24:15','YYYY-MM-DD HH24:MI:SS'),100,'SSO_OSGIRedirectURIs','Felix Web Console Redirect URIs','Apache Felix Web Console Bundles Redirect URIs','Felix Web Console Redirect URIs','D','5a19b1a3-6fb1-4aea-937b-cf976ba5f4fd')
;

-- Jan 19, 2023, 2:25:23 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203785,0,0,'Y',TO_TIMESTAMP('2023-01-19 14:25:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-19 14:25:23','YYYY-MM-DD HH24:MI:SS'),100,'SSO_IDempMonitorRedirectURIs','iDempiere Monitor Redirect URIs','iDempiere Monitor Redirect URIs','iDempiere Monitor Redirect URIs','D','4bb92dd4-0082-4d0e-be88-053e6f28e90c')
;

-- Jan 19, 2023, 2:25:52 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215764,0,'iDempiere Monitor Redirect URIs','iDempiere Monitor Redirect URIs',200360,'SSO_IDempMonitorRedirectURIs',1000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-01-19 14:25:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-19 14:25:51','YYYY-MM-DD HH24:MI:SS'),100,203785,'Y','N','D','N','N','N','Y','258c99b4-3d49-4b31-acf1-3ca2cd7588ee','Y',0,'N','N','N','N')
;

-- Jan 19, 2023, 2:25:54 PM IST
ALTER TABLE SSO_PrincipleConfig ADD SSO_IDempMonitorRedirectURIs VARCHAR2(1000 CHAR) DEFAULT NULL 
;

-- Jan 19, 2023, 2:26:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215765,0,'Felix Web Console Redirect URIs','Apache Felix Web Console Bundles Redirect URIs',200360,'SSO_OSGIRedirectURIs',1000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-01-19 14:26:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-19 14:26:16','YYYY-MM-DD HH24:MI:SS'),100,203784,'Y','N','D','N','N','N','Y','6e3224ea-9fe9-4129-bece-6d1863f75ca3','Y',0,'N','N','N','N')
;

-- Jan 19, 2023, 2:26:18 PM IST
ALTER TABLE SSO_PrincipleConfig ADD SSO_OSGIRedirectURIs VARCHAR2(1000 CHAR) DEFAULT NULL 
;

-- Jan 19, 2023, 2:26:44 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207564,'iDempiere Monitor Redirect URIs','iDempiere Monitor Redirect URIs',200328,215764,'Y',1000,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-19 14:26:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-19 14:26:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f24ccf3b-b2c8-4e79-92b9-3cb645ef643a','Y',130,5)
;

-- Jan 19, 2023, 2:26:45 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207565,'Felix Web Console Redirect URIs','Apache Felix Web Console Bundles Redirect URIs',200328,215765,'Y',1000,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-19 14:26:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-19 14:26:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','21fba3e0-7bd6-4415-a17c-e95021e0caef','Y',140,5)
;

-- Jan 19, 2023, 2:27:10 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=1,Updated=TO_TIMESTAMP('2023-01-19 14:27:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207564
;

-- Jan 19, 2023, 2:27:10 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, XPosition=1,Updated=TO_TIMESTAMP('2023-01-19 14:27:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207565
;

-- Jan 19, 2023, 2:27:10 PM IST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-01-19 14:27:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207415
;

-- Jan 19, 2023, 2:27:10 PM IST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2023-01-19 14:27:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207414
;

-- Jan 23, 2023, 6:52:57 PM IST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200216,0,0,TO_TIMESTAMP('2023-01-23 18:52:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-01-23 18:52:56','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','SSO_SELECT_ROLE','Y','Show Role Panel When Login With SSO','D','S','0e1cc248-9f7b-4572-96fd-0270c6a9934b')
;
