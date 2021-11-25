-- Jun 17, 2021, 4:31:48 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200175,0,0,TO_TIMESTAMP('2021-06-17 16:31:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-06-17 16:31:47','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_GRID_AUTO_HIDE_EMPTY_COLUMNS','N','Y/N - Auto hide column with empty content','D','C','b1bcee77-fbb7-413a-a22b-f250929b3e65')
;

-- Jun 19, 2021, 1:50:21 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203516,0,0,'Y',TO_TIMESTAMP('2021-06-19 13:50:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-19 13:50:20','YYYY-MM-DD HH24:MI:SS'),100,'IsAutoHideEmptyColumn','Auto Hide Empty Column','Auto Hide Empty Column','D','557fd34c-cf85-45c9-9ef0-63b233f4d572')
;

-- Jun 19, 2021, 1:52:02 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214505,0,'Auto Hide Empty Column',200008,'IsAutoHideEmptyColumn',1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_TIMESTAMP('2021-06-19 13:52:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-19 13:52:01','YYYY-MM-DD HH24:MI:SS'),100,203516,'Y','N','D','N','N','N','Y','18b6313e-2902-4e33-abd6-d135b6b5f4b3','Y',0,'N','N','N','N')
;

-- Jun 19, 2021, 1:52:14 PM MYT
ALTER TABLE AD_Tab_Customization ADD COLUMN IsAutoHideEmptyColumn CHAR(1) DEFAULT NULL 
;

SELECT Register_Migration_Script ('202106171641_IDEMPIERE-4835.sql') FROM DUAL
;

