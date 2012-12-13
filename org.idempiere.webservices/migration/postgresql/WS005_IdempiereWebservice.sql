
-- Dec 12, 2012 8:54:30 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Column SET SeqNoSelection=2, IsSelectionColumn='Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-12-12 20:54:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56727
;

-- Dec 12, 2012 8:54:41 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Column SET SeqNoSelection=1, IsSelectionColumn='Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-12-12 20:54:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56730
;

-- Dec 12, 2012 9:27:55 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53166,202041,'D',1,'N','N','N',0,'N',10,'N',18,'N',120,'N','Y','c3d437e8-e10d-4d1b-87e6-68eb5ab4c9ea','Y','AD_Reference_ID','System Reference and Validation','The Reference could be a display type, list or table validation.','Reference','Y',100,TO_TIMESTAMP('2012-12-12 21:27:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 21:27:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 9:27:55 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202041 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 9:28:03 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceFieldInput ADD COLUMN AD_Reference_ID NUMERIC(10) DEFAULT NULL 
;

-- Dec 12, 2012 9:29:30 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53166,202042,'D','N','N','N',0,'N',30,'Y',10,'N',228,'N','Y','30db973a-b039-437e-b55a-c9ca1e9d7378','Y','ColumnName','Name of the column in the database','The Column Name indicates the name of a column on a table as defined in the database.','DB Column Name','Y',100,TO_TIMESTAMP('2012-12-12 21:29:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 21:29:30','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 9:29:30 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202042 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 9:29:38 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceFieldInput ADD COLUMN ColumnName VARCHAR(30) DEFAULT NULL 
;

-- Dec 12, 2012 9:31:07 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IdentifierLogic',200592,'D','Identifier Logic','Identifier Logic','d5470526-d7b3-41fb-9ee7-35190020169c',0,TO_TIMESTAMP('2012-12-12 21:31:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-12 21:31:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 12, 2012 9:31:08 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200592 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 12, 2012 9:32:26 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53166,202043,'D','N','N','N',0,'N',2000,'N',14,'N',200592,'N','Y','bdf425b5-7c59-42d4-bb59-56c9800e8325','Y','IdentifierLogic','Identifier Logic','Y',100,TO_TIMESTAMP('2012-12-12 21:32:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 21:32:25','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 9:32:26 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202043 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 9:32:51 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceFieldInput ADD COLUMN IdentifierLogic VARCHAR(2000) DEFAULT NULL 
;

-- Dec 12, 2012 9:33:11 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-12-12 21:33:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202042
;

-- Dec 12, 2012 9:33:22 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-12-12 21:33:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202041
;

-- Dec 12, 2012 9:36:10 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53166,202044,'D','N','N','N',0,'N',1,'N',20,'N',382,'N','Y','f0baaca8-7437-4a9d-a02d-26827b0b54b2','Y','IsIdentifier','This column is part of the record identifier','N','The Identifier checkbox indicates that this column is part of the identifier or key for this table.  ','Identifier','Y',100,TO_TIMESTAMP('2012-12-12 21:36:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 21:36:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 9:36:10 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202044 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 9:36:22 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceFieldInput ADD COLUMN IsIdentifier CHAR(1) DEFAULT 'N' CHECK (IsIdentifier IN ('Y','N'))
;

-- Dec 12, 2012 9:36:34 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO t_alter_column values('ws_webservicefieldinput','IdentifierLogic','VARCHAR(2000)',null,'NULL')
;

-- Dec 12, 2012 9:37:50 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Description,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsNullIdentifier',200593,'D','Should allow null value for identifiere field','Allow Null Value','Allow Null Value','a704f515-b9a7-4e90-8d44-d7e16e0f5d8c',0,TO_TIMESTAMP('2012-12-12 21:37:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-12 21:37:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 12, 2012 9:37:50 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200593 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 12, 2012 9:39:48 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53166,202045,'D','N','N','N',0,'N',1,'N',20,'N',200593,'N','Y','9cc0e2b6-8bc2-4541-86ad-63513f027011','Y','IsNullIdentifier','Should allow null value for identifiere field','N','Allow Null Value','Y',100,TO_TIMESTAMP('2012-12-12 21:39:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 21:39:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 9:39:48 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202045 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 9:39:53 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceFieldInput ADD COLUMN IsNullIdentifier CHAR(1) DEFAULT 'N' CHECK (IsNullIdentifier IN ('Y','N'))
;

-- Dec 12, 2012 9:40:15 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO t_alter_column values('ws_webservicefieldinput','IsIdentifier','CHAR(1)',null,'N')
;



-- Dec 12, 2012 10:36:44 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('WS_WebServiceType_UU',200594,'D','WS_WebServiceType_UU','WS_WebServiceType_UU','1be8e032-ddc3-489c-8c3d-9a4416968d32',0,TO_TIMESTAMP('2012-12-12 22:36:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-12 22:36:43','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 12, 2012 10:36:44 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200594 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 12, 2012 10:37:11 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53164,202046,'D','N','N','N',0,'N',36,'N',10,'N',200594,'N','Y','0d88f8d9-25c1-4507-a495-b7ba84378e86','Y','WS_WebServiceType_UU','WS_WebServiceType_UU','N',100,TO_TIMESTAMP('2012-12-12 22:37:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 22:37:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 10:37:11 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202046 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 10:37:33 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceType ADD COLUMN WS_WebServiceType_UU VARCHAR(36) DEFAULT NULL 
;

-- Dec 12, 2012 10:38:46 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('WS_WebService_Para_UU',200595,'D','WS_WebService_Para_UU','WS_WebService_Para_UU','2f690372-900f-457e-8ef7-d1b04496fa5c',0,TO_TIMESTAMP('2012-12-12 22:38:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-12 22:38:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 12, 2012 10:38:46 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200595 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 12, 2012 10:39:14 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53165,202047,'D','N','N','N',0,'N',36,'N',10,'N',200595,'N','Y','90cb04b7-7f82-4866-97f6-c8ff0da18c8b','Y','WS_WebService_Para_UU','WS_WebService_Para_UU','N',100,TO_TIMESTAMP('2012-12-12 22:39:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 22:39:13','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 10:39:14 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202047 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 10:39:21 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebService_Para ADD COLUMN WS_WebService_Para_UU VARCHAR(36) DEFAULT NULL 
;

-- Dec 12, 2012 10:40:21 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('WS_WebServiceFieldInput_UU',200596,'D','WS_WebServiceFieldInput_UU','WS_WebServiceFieldInput_UU','b835e570-ab79-4d64-8b4c-2d1ee688e783',0,TO_TIMESTAMP('2012-12-12 22:40:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-12 22:40:21','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 12, 2012 10:40:21 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200596 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 12, 2012 10:40:43 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53166,202048,'D','N','N','N',0,'N',36,'N',10,'N',200596,'N','Y','2f2437aa-cd9c-4fcb-972b-ed1e3393d108','Y','WS_WebServiceFieldInput_UU','WS_WebServiceFieldInput_UU','N',100,TO_TIMESTAMP('2012-12-12 22:40:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 22:40:42','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 10:40:43 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202048 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 10:40:47 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceFieldInput ADD COLUMN WS_WebServiceFieldInput_UU VARCHAR(36) DEFAULT NULL 
;

-- Dec 12, 2012 10:41:43 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('WS_WebServiceFieldOutput_UU',200597,'D','WS_WebServiceFieldOutput_UU','WS_WebServiceFieldOutput_UU','bcdfaa22-d87c-4df5-935b-d8f5339d4f51',0,TO_TIMESTAMP('2012-12-12 22:41:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-12 22:41:42','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 12, 2012 10:41:43 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200597 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 12, 2012 10:42:01 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53167,202049,'D','N','N','N',0,'N',36,'N',10,'N',200597,'N','Y','0617cbde-f858-4138-aaa4-fca99bc30988','Y','WS_WebServiceFieldOutput_UU','WS_WebServiceFieldOutput_UU','N',100,TO_TIMESTAMP('2012-12-12 22:42:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 22:42:01','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 10:42:01 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202049 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 10:42:06 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceFieldOutput ADD COLUMN WS_WebServiceFieldOutput_UU VARCHAR(36) DEFAULT NULL 
;

-- Dec 12, 2012 10:43:48 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('WS_WebServiceTypeAccess_UU',200598,'D','WS_WebServiceTypeAccess_UU','WS_WebServiceTypeAccess_UU','32df84f5-c650-425a-b9a8-eca3ed2a6209',0,TO_TIMESTAMP('2012-12-12 22:43:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-12 22:43:47','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 12, 2012 10:43:48 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200598 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 12, 2012 10:44:41 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,53168,202050,'D','N','N','N',0,'N',36,'N',10,'N',200598,'N','Y','43bdb652-1a55-4bd5-affd-b55841f1a1ec','Y','WS_WebServiceTypeAccess_UU','WS_WebServiceTypeAccess_UU','N',100,TO_TIMESTAMP('2012-12-12 22:44:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-12 22:44:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 12, 2012 10:44:41 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=202050 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 12, 2012 10:44:46 PM IST
-- IDEMPIERE-460 Adding support for composite service
ALTER TABLE WS_WebServiceTypeAccess ADD COLUMN WS_WebServiceTypeAccess_UU VARCHAR(36) DEFAULT NULL 
;





-- Dec 12, 2012 11:49:01 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Column SET MandatoryLogic='@AD_Column_ID@=0',Updated=TO_TIMESTAMP('2012-12-12 23:49:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202041
;

-- Dec 12, 2012 11:54:37 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53189,1,'N','N',202045,'Y',201365,'N','D','Should allow null value for identifiere field','Allow Null Value','N','Y','678c6e86-9e5f-49d6-819b-bd08b0946f17',100,0,TO_TIMESTAMP('2012-12-12 23:54:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-12 23:54:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 12, 2012 11:54:37 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201365 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 12, 2012 11:54:38 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53189,30,'N','N',202042,'Y',201366,'N','The Column Name indicates the name of a column on a table as defined in the database.','D','Name of the column in the database','DB Column Name','N','Y','24b12b95-27eb-4303-a550-46402b4a44cb',100,0,TO_TIMESTAMP('2012-12-12 23:54:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-12 23:54:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 12, 2012 11:54:38 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201366 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 12, 2012 11:54:39 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53189,1,'N','N',202044,'Y',201367,'N','The Identifier checkbox indicates that this column is part of the identifier or key for this table.  ','D','This column is part of the record identifier','Identifier','N','Y','5551bd5f-7bde-42f0-88ac-4ccd099ace7a',100,0,TO_TIMESTAMP('2012-12-12 23:54:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-12 23:54:38','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 12, 2012 11:54:39 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201367 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 12, 2012 11:54:40 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53189,2000,'N','N',202043,'Y',201368,'N','D','Identifier Logic','N','Y','67a1f8e7-44d4-4254-94b8-950a64f331f4',100,0,TO_TIMESTAMP('2012-12-12 23:54:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-12 23:54:39','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 12, 2012 11:54:40 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201368 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 12, 2012 11:54:41 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53189,10,'N','N',202041,'Y',201369,'N','The Reference could be a display type, list or table validation.','D','System Reference and Validation','Reference','N','Y','837295cd-2ecc-429d-ad18-dba6dadd7c91',100,0,TO_TIMESTAMP('2012-12-12 23:54:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-12 23:54:40','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 12, 2012 11:54:41 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201369 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 12, 2012 11:54:41 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53189,36,'N','N',202048,'Y',201370,'N','D','WS_WebServiceFieldInput_UU','N','Y','3ae46bba-2a92-4c9e-849c-98a716ec16fe',100,0,TO_TIMESTAMP('2012-12-12 23:54:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-12 23:54:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 12, 2012 11:54:41 PM IST
-- IDEMPIERE-460 Adding support for composite service
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201370 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 12, 2012 11:55:36 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201370
;

-- Dec 12, 2012 11:55:36 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201366
;

-- Dec 12, 2012 11:55:37 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201367
;

-- Dec 12, 2012 11:55:37 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201365
;

-- Dec 12, 2012 11:55:37 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201368
;

-- Dec 12, 2012 11:55:37 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=201369
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201370
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=56668
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=56669
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=56666
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201366
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201365
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201367
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201368
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201369
;

-- Dec 12, 2012 11:56:27 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=56667
;

-- Dec 12, 2012 11:57:03 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-12 23:57:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56665
;

-- Dec 12, 2012 11:57:16 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2, XPosition=4,Updated=TO_TIMESTAMP('2012-12-12 23:57:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56667
;

-- Dec 12, 2012 11:57:38 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-12 23:57:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56669
;

-- Dec 12, 2012 11:58:06 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-12 23:58:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56666
;

-- Dec 12, 2012 11:58:49 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2, DisplayLogic='@AD_Column_ID@=0', XPosition=4,Updated=TO_TIMESTAMP('2012-12-12 23:58:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201366
;

-- Dec 12, 2012 11:59:28 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-12-12 23:59:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201367
;

-- Dec 12, 2012 11:59:52 PM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-12-12 23:59:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201365
;

-- Dec 13, 2012 12:00:14 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=5, NumLines=4,Updated=TO_TIMESTAMP('2012-12-13 00:00:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201368
;

-- Dec 13, 2012 12:00:43 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET DisplayLogic='@AD_Column_ID@>0',Updated=TO_TIMESTAMP('2012-12-13 00:00:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201368
;

-- Dec 13, 2012 12:01:30 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET DisplayLogic='@AD_Column_ID@>0',Updated=TO_TIMESTAMP('2012-12-13 00:01:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201367
;

-- Dec 13, 2012 12:02:02 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET DisplayLogic='@IsIdentifier@=''Y"',Updated=TO_TIMESTAMP('2012-12-13 00:02:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201365
;

-- Dec 13, 2012 12:02:24 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET DisplayLogic='@IsIdentifier@=''Y"',Updated=TO_TIMESTAMP('2012-12-13 00:02:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201368
;

-- Dec 13, 2012 12:03:37 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET DisplayLogic='@AD_Column_ID@=0',Updated=TO_TIMESTAMP('2012-12-13 00:03:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201369
;

-- Dec 13, 2012 12:06:07 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-12-13 00:06:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56664
;

-- Dec 13, 2012 12:06:51 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56646
;

-- Dec 13, 2012 12:07:06 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2, XPosition=4,Updated=TO_TIMESTAMP('2012-12-13 00:07:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56650
;

-- Dec 13, 2012 12:07:37 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:07:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56651
;

-- Dec 13, 2012 12:07:57 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:07:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56649
;

-- Dec 13, 2012 12:08:15 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:08:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56653
;

-- Dec 13, 2012 12:08:59 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2, XPosition=4,Updated=TO_TIMESTAMP('2012-12-13 00:08:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56654
;

-- Dec 13, 2012 12:09:30 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=4, XPosition=1,Updated=TO_TIMESTAMP('2012-12-13 00:09:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56654
;

-- Dec 13, 2012 12:09:41 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:09:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56652
;

-- Dec 13, 2012 12:10:01 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2012-12-13 00:10:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56648
;

-- Dec 13, 2012 12:10:15 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET NumLines=3,Updated=TO_TIMESTAMP('2012-12-13 00:10:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56648
;

-- Dec 13, 2012 12:10:30 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=5, NumLines=3,Updated=TO_TIMESTAMP('2012-12-13 00:10:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56647
;

-- Dec 13, 2012 12:10:43 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-12-13 00:10:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56645
;

-- Dec 13, 2012 12:11:51 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:11:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56657
;

-- Dec 13, 2012 12:12:01 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2, XPosition=4,Updated=TO_TIMESTAMP('2012-12-13 00:12:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56659
;

-- Dec 13, 2012 12:12:14 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:12:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56663
;

-- Dec 13, 2012 12:12:27 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:12:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56660
;

-- Dec 13, 2012 12:12:36 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:12:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56661
;

-- Dec 13, 2012 12:12:55 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:12:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56658
;

-- Dec 13, 2012 12:13:09 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-12-13 00:13:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56656
;

-- Dec 13, 2012 12:14:18 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:14:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56671
;

-- Dec 13, 2012 12:14:32 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2, XPosition=4,Updated=TO_TIMESTAMP('2012-12-13 00:14:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56673
;

-- Dec 13, 2012 12:14:42 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:14:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56675
;

-- Dec 13, 2012 12:14:50 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56672
;

-- Dec 13, 2012 12:14:58 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-12-13 00:14:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56670
;

-- Dec 13, 2012 12:15:33 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56677
;

-- Dec 13, 2012 12:15:43 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2, XPosition=4,Updated=TO_TIMESTAMP('2012-12-13 00:15:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56678
;

-- Dec 13, 2012 12:15:54 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:15:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56681
;

-- Dec 13, 2012 12:16:01 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-12-13 00:16:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56680
;

-- Dec 13, 2012 12:16:09 AM IST
-- IDEMPIERE-460 Adding support for composite service
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-12-13 00:16:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56676
;

