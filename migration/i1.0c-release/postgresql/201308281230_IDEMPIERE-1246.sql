-- Aug 29, 2013 12:54:44 PM COT
-- IDEMPIERE-1246 Implement "Open in Grid Mode" as user preference
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200008,210850,319,'N','N','N',0,'N',1,'N',17,'N','N','Y','6326bd83-7b11-4da6-8407-26b186050943','Y','IsDisplayedGrid',NULL,'Show in Grid','Y',TO_TIMESTAMP('2013-08-29 12:54:44','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-29 12:54:44','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200083,'N')
;

-- Aug 29, 2013 12:55:27 PM COT
ALTER TABLE AD_Tab_Customization ADD COLUMN IsDisplayedGrid CHAR(1) DEFAULT NULL 
;

-- Aug 22, 2013 2:45:25 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('I','Open in Grid Mode',200224,'4603f89b-78cf-4f1d-beeb-b33146aa91fa','OpenInGridMode','Y',TO_TIMESTAMP('2013-08-22 14:45:25','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-08-22 14:45:25','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

SELECT register_migration_script('201308281230_IDEMPIERE-1246.sql') FROM dual
;
