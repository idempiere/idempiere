-- IDEMPIERE-6552 Make OIDC force login configurable by provider
SELECT register_migration_script('202607261257_IDEMPIERE-6552.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 26, 2026, 12:57:59 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204119,0,0,'Y',TO_TIMESTAMP('2026-07-26 12:57:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-26 12:57:59','YYYY-MM-DD HH24:MI:SS'),100,'IsForceLogin','Force Login','Require the OpenID Connect provider to reauthenticate the user','When enabled, the authorization request includes prompt=login. Disable it to allow reuse of an existing provider session or remember-me cookie.','Force Login','D','019f9e13-18e2-7ff2-9bbe-1725dd523b37')
;

-- Jul 26, 2026, 1:01:27 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217653,0,'Force Login','Require the OpenID Connect provider to reauthenticate the user','When enabled, the authorization request includes prompt=login. Disable it to allow reuse of an existing provider session or remember-me cookie.',200360,'IsForceLogin','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-07-26 13:01:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-26 13:01:26','YYYY-MM-DD HH24:MI:SS'),100,204119,'Y','N','D','N','N','N','Y','019f9e16-43b8-7be9-8aa4-d07eb1c80e6c','Y',0,'N','N','N','N')
;

-- Jul 26, 2026, 1:02:00 PM CEST
ALTER TABLE SSO_PrincipalConfig ADD IsForceLogin CHAR(1) DEFAULT 'Y' CHECK (IsForceLogin IN ('Y','N')) NOT NULL
;

-- Jul 26, 2026, 1:05:19 PM CEST
ALTER TABLE SSO_PrincipalConfig MODIFY IsForceLogin CHAR(1) DEFAULT 'Y'
;

-- Jul 26, 2026, 1:05:19 PM CEST
UPDATE SSO_PrincipalConfig SET IsForceLogin='Y' WHERE IsForceLogin IS NULL
;

-- Jul 26, 2026, 1:08:07 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209238,'Force Login','Require the OpenID Connect provider to reauthenticate the user','When enabled, the authorization request includes prompt=login. Disable it to allow reuse of an existing provider session or remember-me cookie.',200328,217653,'Y',1,160,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-07-26 13:08:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-07-26 13:08:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019f9e1c-611a-700a-baa0-441627d8c858','Y',160,2,2)
;

-- Jul 26, 2026, 1:10:01 PM CEST
UPDATE AD_Field SET DisplayLogic='@SSO_Provider@=''OIDC''',Updated=TO_TIMESTAMP('2026-07-26 13:10:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209238
;

-- Jul 26, 2026, 1:12:11 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-07-26 13:12:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207414
;

-- Jul 26, 2026, 1:12:11 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=2,Updated=TO_TIMESTAMP('2026-07-26 13:12:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209238
;
