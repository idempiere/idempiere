-- Oct 15, 2012 6:21:27 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ServerName',200182,'Node instance name','D','Server Name','Server Name','7bd7b80a-d97d-4643-8d69-e2856a2a144a',0,TO_TIMESTAMP('2012-10-15 18:21:26','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-10-15 18:21:26','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Oct 15, 2012 6:21:27 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200182 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Oct 15, 2012 6:22:04 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,566,200613,'D','N','N','N',0,'N',80,'Y',14,'N','N',200182,'N','Y','14d3c02e-9f80-40cb-8507-e040fbaf3ef6','N','Y','N','ServerName','Node instance name','Server Name','Y',100,TO_TIMESTAMP('2012-10-15 18:22:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-15 18:22:03','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Oct 15, 2012 6:22:04 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200613 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 15, 2012 6:22:45 PM IST
-- IDEMPIERE-389 Adding server name on AD_Session
ALTER TABLE AD_Session ADD COLUMN ServerName VARCHAR(80) DEFAULT NULL 
;

SELECT register_migration_script('934_IDEMPIERE-389.sql') FROM dual
;