-- Nov 14, 2012 2:22:34 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200883,'D','Y','N','N',0,'N',1,'N',20,'N',1359,'N','Y','54a7f56f-c8cc-4328-ba33-db06ab85964c','Y','N','AcceptAMEX','Accept American Express Card','N','Indicates if American Express Cards are accepted','Accept AMEX','Y',100,TO_TIMESTAMP('2012-11-14 14:22:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:22:31','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:22:34 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200883 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:22:44 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptAMEX CHAR(1) DEFAULT 'N' CHECK (AcceptAMEX IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:23:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200884,'D','Y','N','N',0,'N',1,'N',20,'N',1360,'N','Y','83d82033-bff8-460d-8ac3-10b6f03af57c','Y','N','AcceptATM','Accept Bank ATM Card','N','Indicates if Bank ATM Cards are accepted','Accept ATM','Y',100,TO_TIMESTAMP('2012-11-14 14:23:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:23:16','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:23:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200884 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:23:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptATM CHAR(1) DEFAULT 'N' CHECK (AcceptATM IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:24:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200885,'D','Y','N','N',0,'N',1,'N',20,'N',1361,'N','Y','ac1b57a5-8041-4f3f-bea1-56a5d03f1f65','Y','N','AcceptCheck','Accept ECheck (Electronic Checks)','N','Indicates if EChecks are accepted','Accept Electronic Check','Y',100,TO_TIMESTAMP('2012-11-14 14:24:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:24:03','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:24:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200885 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:24:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptCheck CHAR(1) DEFAULT 'N' CHECK (AcceptCheck IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:24:47 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200886,'D','Y','N','N',0,'N',1,'N',20,'N',1362,'N','Y','2fe74cca-80c3-4fff-976f-6d6124db8eae','Y','N','AcceptCorporate','Accept Corporate Purchase Cards','N','Indicates if Corporate Purchase Cards are accepted ','Accept Corporate','Y',100,TO_TIMESTAMP('2012-11-14 14:24:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:24:46','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:24:47 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200886 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:24:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptCorporate CHAR(1) DEFAULT 'N' CHECK (AcceptCorporate IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:25:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200887,'D','Y','N','N',0,'N',1,'N',20,'N',1363,'N','Y','2f0ad9ab-76e0-4497-9a3c-6b20a6a4b220','Y','N','AcceptDiners','Accept Diner''s Club','N','Indicates if Diner''s Club Cards are accepted ','Accept Diners','Y',100,TO_TIMESTAMP('2012-11-14 14:25:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:25:15','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:25:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200887 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:25:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptDiners CHAR(1) DEFAULT 'N' CHECK (AcceptDiners IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:26:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200888,'D','Y','N','N',0,'N',1,'N',20,'N',2346,'N','Y','f6828180-ec61-473b-afbc-afee43f0decb','Y','N','AcceptDirectDebit','Accept Direct Debits (vendor initiated)','N','Accept Direct Debit transactions. Direct Debits are initiated by the vendor who has permission to deduct amounts from the payee''s account.','Accept Direct Debit','Y',100,TO_TIMESTAMP('2012-11-14 14:26:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:26:03','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:26:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200888 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:26:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptDirectDebit CHAR(1) DEFAULT 'N' CHECK (AcceptDirectDebit IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:26:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200889,'D','Y','N','N',0,'N',1,'N',20,'N',1358,'N','Y','a159a329-738d-49c6-a816-3e19ed9a92ea','Y','N','AcceptDirectDeposit','Accept Direct Deposit (payee initiated)','N','Indicates if Direct Deposits (wire transfers, etc.) are accepted. Direct Deposits are initiated by the payee.','Accept Direct Deposit','Y',100,TO_TIMESTAMP('2012-11-14 14:26:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:26:50','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:26:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200889 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:26:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptDirectDeposit CHAR(1) DEFAULT 'N' CHECK (AcceptDirectDeposit IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:27:43 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200890,'D','Y','N','N',0,'N',1,'N',20,'N',1492,'N','Y','7e8f34da-b4cd-4d3b-9af1-4f7c758f5240','Y','N','AcceptDiscover','Accept Discover Card','N','Indicates if Discover Cards are accepted','Accept Discover','Y',100,TO_TIMESTAMP('2012-11-14 14:27:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:27:42','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:27:43 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200890 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:27:44 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptDiscover CHAR(1) DEFAULT 'N' CHECK (AcceptDiscover IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:28:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200891,'D','Y','N','N',0,'N',1,'N',20,'N',1364,'N','Y','a8883a48-03ac-4493-859a-53ac5daf79f8','Y','N','AcceptMC','Accept Master Card','N','Indicates if Master Cards are accepted ','Accept MasterCard','Y',100,TO_TIMESTAMP('2012-11-14 14:28:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:28:15','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:28:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200891 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:28:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptMC CHAR(1) DEFAULT 'N' CHECK (AcceptMC IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:28:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200892,'D','Y','N','N',0,'N',1,'N',20,'N',1365,'N','Y','0616b644-af4e-4e63-bf49-2861e95491ee','Y','N','AcceptVisa','Accept Visa Cards','N','Indicates if Visa Cards are accepted ','Accept Visa','Y',100,TO_TIMESTAMP('2012-11-14 14:28:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:28:49','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:28:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200892 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:28:51 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN AcceptVisa CHAR(1) DEFAULT 'N' CHECK (AcceptVisa IN ('Y','N')) NOT NULL
;

-- Nov 14, 2012 2:30:40 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200893,'D','Y','N','N',0,'N',60,'N',10,'N',1398,'N','Y','abee617d-bc0d-4bb4-acbe-1a060a448257','Y','N','HostAddress','Host Address URL or DNS','The Host Address identifies the URL or DNS of the target host','Host Address','Y',100,TO_TIMESTAMP('2012-11-14 14:30:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:30:39','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:30:40 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200893 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:30:42 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN HostAddress VARCHAR(60) NOT NULL
;

-- Nov 14, 2012 2:30:55 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-11-14 14:30:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200893
;

-- Nov 14, 2012 2:30:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN HostAddress VARCHAR(60) DEFAULT NULL 
;

-- Nov 14, 2012 2:31:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200894,'D','Y','N','N',0,'N',14,'N',11,'N',1399,'N','Y','dbde6de4-aa61-4b64-b8ad-981419272e19','Y','N','HostPort','Host Communication Port','The Host Port identifies the port to communicate with the host.','Host port','Y',100,TO_TIMESTAMP('2012-11-14 14:31:48','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:31:48','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:31:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200894 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:31:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN HostPort NUMERIC(10) NOT NULL
;

-- Nov 14, 2012 2:31:56 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-11-14 14:31:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200894
;

-- Nov 14, 2012 2:31:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN HostPort NUMERIC(10) DEFAULT NULL 
;

-- Nov 14, 2012 2:32:57 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200895,'D','N','N','N',0,'N',60,'N',10,'N',1902,'N','Y','ef994727-21e7-4c05-a0c5-98a73ccab5ee','Y','N','PartnerID','Partner ID or Account for the Payment Processor','Partner ID (Verisign) or Account ID (Optimal)','Partner ID','Y',100,TO_TIMESTAMP('2012-11-14 14:32:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:32:56','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:32:57 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200895 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:32:59 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN PartnerID VARCHAR(60) DEFAULT NULL 
;

-- Nov 14, 2012 2:34:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200896,'D','N','N','N',0,'N',60,'N',10,'N',1904,'N','Y','df8c58ef-34e0-41cc-923e-d2b1f5fd618f','Y','N','VendorID','Vendor ID for the Payment Processor','Vendor ID','Y',100,TO_TIMESTAMP('2012-11-14 14:34:48','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:34:48','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:34:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200896 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:34:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN VendorID VARCHAR(60) DEFAULT NULL 
;

-- Nov 14, 2012 2:35:42 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200897,'D','N','N','N',0,'N',100,'N',10,'N',1444,'N','Y','339251d7-eb2b-4a40-b119-3e1112b2e94e','Y','N','UserID','User ID or account number','The User ID identifies a user and allows access to records or processes.','User ID','Y',100,TO_TIMESTAMP('2012-11-14 14:35:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:35:41','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:35:42 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200897 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:35:43 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN UserID VARCHAR(100) DEFAULT NULL 
;

-- Nov 14, 2012 2:36:12 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200898,'U','N','N','N',0,'N',60,'N',10,'N',498,'N','Y','f9351d22-8c23-4640-8b35-c9398cf045e7','Y','N','Password','Password of any length (case sensitive)','The Password for this User.  Passwords are required to identify authorized users.  For Adempiere Users, you can change the password via the Process "Reset Password".','Password','Y',100,TO_TIMESTAMP('2012-11-14 14:36:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:36:12','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:36:12 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200898 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:36:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-11-14 14:36:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200898
;

-- Nov 14, 2012 2:36:22 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN Password VARCHAR(60) DEFAULT NULL 
;

-- Nov 14, 2012 2:37:02 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200899,'D','N','N','N',0,'N',60,'N',10,'N',1418,'N','Y','330404b7-a6bf-4cdb-8a14-8ecce4b26a18','Y','N','ProxyAddress',' Address of your proxy server','The Proxy Address must be defined if you must pass through a firewall to access your payment processor. ','Proxy address','Y',100,TO_TIMESTAMP('2012-11-14 14:36:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:36:58','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:37:02 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200899 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:37:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN ProxyAddress VARCHAR(60) DEFAULT NULL 
;

-- Nov 14, 2012 2:39:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200900,'D','N','N','N',0,'N',22,'N',11,'N',1421,'N','Y','60af9c18-2ced-46a1-8ccd-a0356c996889','Y','N','ProxyPort','Port of your proxy server','The Proxy Port identifies the port of your proxy server.','Proxy port','Y',100,TO_TIMESTAMP('2012-11-14 14:39:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:39:51','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:39:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200900 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:39:57 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN ProxyPort NUMERIC(10) DEFAULT NULL 
;

-- Nov 14, 2012 2:49:27 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200901,'D','N','N','N',0,'N',60,'N',10,'N',1419,'N','Y','21ea3826-75bf-475d-ac02-39b7a3222c26','Y','N','ProxyLogon','Logon of your proxy server','The Proxy Logon identifies the Logon ID for your proxy server.','Proxy logon','Y',100,TO_TIMESTAMP('2012-11-14 14:49:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:49:26','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:49:27 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200901 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:49:29 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN ProxyLogon VARCHAR(60) DEFAULT NULL 
;

-- Nov 14, 2012 2:53:28 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200902,'D','N','N','N',0,'N',60,'N',10,'N',1420,'N','Y','0cff6e87-89b0-49fd-a3d9-7bde5ed72284','Y','N','ProxyPassword','Password of your proxy server','The Proxy Password identifies the password for your proxy server.','Proxy password','Y',100,TO_TIMESTAMP('2012-11-14 14:53:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 14:53:27','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 2:53:28 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200902 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 2:53:29 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN ProxyPassword VARCHAR(60) DEFAULT NULL 
;

-- Nov 14, 2012 3:01:40 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200883,'Y',200786,'N','Indicates if American Express Cards are accepted','D','Accept American Express Card','Accept AMEX','N','Y','3688faee-79c2-46c4-92bc-8db7c105e87c',100,0,TO_TIMESTAMP('2012-11-14 15:01:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:39','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:40 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200786 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200884,'Y',200787,'N','Indicates if Bank ATM Cards are accepted','D','Accept Bank ATM Card','Accept ATM','N','Y','0973b597-4051-4d5e-a7e6-578e1c9bd616',100,0,TO_TIMESTAMP('2012-11-14 15:01:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200787 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:42 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200886,'Y',200788,'N','Indicates if Corporate Purchase Cards are accepted ','D','Accept Corporate Purchase Cards','Accept Corporate','N','Y','2cfe2a0b-bbf5-47f6-8dbb-cd69250f95b6',100,0,TO_TIMESTAMP('2012-11-14 15:01:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:42 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200788 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:43 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200887,'Y',200789,'N','Indicates if Diner''s Club Cards are accepted ','D','Accept Diner''s Club','Accept Diners','N','Y','db3ae988-d566-4d52-aa7e-827953d378ac',100,0,TO_TIMESTAMP('2012-11-14 15:01:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:42','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:43 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200789 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:44 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200888,'Y',200790,'N','Accept Direct Debit transactions. Direct Debits are initiated by the vendor who has permission to deduct amounts from the payee''s account.','D','Accept Direct Debits (vendor initiated)','Accept Direct Debit','N','Y','47391406-0349-4b47-b7fb-c680793de85e',100,0,TO_TIMESTAMP('2012-11-14 15:01:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:43','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:44 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200790 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:45 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200889,'Y',200791,'N','Indicates if Direct Deposits (wire transfers, etc.) are accepted. Direct Deposits are initiated by the payee.','D','Accept Direct Deposit (payee initiated)','Accept Direct Deposit','N','Y','b1b87d3b-7737-4213-9052-b9ffe1af1865',100,0,TO_TIMESTAMP('2012-11-14 15:01:44','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:44','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:45 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200791 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200890,'Y',200792,'N','Indicates if Discover Cards are accepted','D','Accept Discover Card','Accept Discover','N','Y','414be897-74e7-48ab-94de-57d4523262c3',100,0,TO_TIMESTAMP('2012-11-14 15:01:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:45','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200792 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200885,'Y',200793,'N','Indicates if EChecks are accepted','D','Accept ECheck (Electronic Checks)','Accept Electronic Check','N','Y','9224bdf7-cfdb-40d9-8854-b3a06646969f',100,0,TO_TIMESTAMP('2012-11-14 15:01:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:46','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200793 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:47 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200891,'Y',200794,'N','Indicates if Master Cards are accepted ','D','Accept Master Card','Accept MasterCard','N','Y','917617a2-8dcc-4963-a589-55e3c016cee5',100,0,TO_TIMESTAMP('2012-11-14 15:01:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:46','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:47 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200794 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200892,'Y',200795,'N','Indicates if Visa Cards are accepted ','D','Accept Visa Cards','Accept Visa','N','Y','72c2e730-4985-4708-907b-a61e397f5965',100,0,TO_TIMESTAMP('2012-11-14 15:01:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:47','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200795 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,60,'N','N',200893,'Y',200796,'N','The Host Address identifies the URL or DNS of the target host','D','Host Address URL or DNS','Host Address','N','Y','24c564a8-d002-46d2-ab6f-d43523f0f1ee',100,0,TO_TIMESTAMP('2012-11-14 15:01:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200796 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,14,'N','N',200894,'Y',200797,'N','The Host Port identifies the port to communicate with the host.','D','Host Communication Port','Host port','N','Y','16aa64b4-7bc3-4d6e-8bec-acba469d4084',100,0,TO_TIMESTAMP('2012-11-14 15:01:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:49','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200797 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,60,'N','N',200895,'Y',200798,'N','Partner ID (Verisign) or Account ID (Optimal)','D','Partner ID or Account for the Payment Processor','Partner ID','N','Y','63b919ba-88f2-4327-9d22-833744eba910',100,0,TO_TIMESTAMP('2012-11-14 15:01:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200798 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:51 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,60,'N','N',200898,'Y',200799,'N','The Password for this User.  Passwords are required to identify authorized users.  For Adempiere Users, you can change the password via the Process "Reset Password".','D','Password of any length (case sensitive)','Password','N','Y','d9bb39b2-87fe-484c-bb71-62a6d15f49ac',100,0,TO_TIMESTAMP('2012-11-14 15:01:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:51 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200799 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,60,'N','N',200899,'Y',200800,'N','The Proxy Address must be defined if you must pass through a firewall to access your payment processor. ','D',' Address of your proxy server','Proxy address','N','Y','6b3a7438-e553-489c-98ae-a5cd3937c70b',100,0,TO_TIMESTAMP('2012-11-14 15:01:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:51','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200800 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,60,'N','N',200901,'Y',200801,'N','The Proxy Logon identifies the Logon ID for your proxy server.','D','Logon of your proxy server','Proxy logon','N','Y','32144fe6-1948-44aa-868e-248c2aa166ea',100,0,TO_TIMESTAMP('2012-11-14 15:01:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:52','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200801 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:54 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,60,'N','N',200902,'Y',200802,'N','The Proxy Password identifies the password for your proxy server.','D','Password of your proxy server','Proxy password','N','Y','986460a9-8574-408a-b20b-fb04f1901aed',100,0,TO_TIMESTAMP('2012-11-14 15:01:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:54 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200802 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:54 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,22,'N','N',200900,'Y',200803,'N','The Proxy Port identifies the port of your proxy server.','D','Port of your proxy server','Proxy port','N','Y','a4b5afd8-54f8-4550-8b74-fd525bf3f137',100,0,TO_TIMESTAMP('2012-11-14 15:01:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:54 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200803 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:55 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,100,'N','N',200897,'Y',200804,'N','The User ID identifies a user and allows access to records or processes.','D','User ID or account number','User ID','N','Y','4225d4de-e31f-4b6c-945e-084677072b9d',100,0,TO_TIMESTAMP('2012-11-14 15:01:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:55 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200804 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:01:56 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,60,'N','N',200896,'Y',200805,'N','D','Vendor ID for the Payment Processor','Vendor ID','N','Y','11c6b86c-0346-4377-b723-b9d7e7d94625',100,0,TO_TIMESTAMP('2012-11-14 15:01:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 15:01:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 3:01:56 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200805 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200796
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200797
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200798
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200805
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200804
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200799
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200800
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200803
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200801
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200802
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200794
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200786
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200788
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=200791
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200793
;

-- Nov 14, 2012 3:04:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 3:04:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=60,Updated=TO_TIMESTAMP('2012-11-14 15:04:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200796
;

-- Nov 14, 2012 3:04:55 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=70,Updated=TO_TIMESTAMP('2012-11-14 15:04:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200797
;

-- Nov 14, 2012 3:04:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=80,Updated=TO_TIMESTAMP('2012-11-14 15:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200798
;

-- Nov 14, 2012 3:05:01 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=90,Updated=TO_TIMESTAMP('2012-11-14 15:05:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200805
;

-- Nov 14, 2012 3:05:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=100,Updated=TO_TIMESTAMP('2012-11-14 15:05:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200804
;

-- Nov 14, 2012 3:05:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=110,Updated=TO_TIMESTAMP('2012-11-14 15:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200799
;

-- Nov 14, 2012 3:05:09 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=120,Updated=TO_TIMESTAMP('2012-11-14 15:05:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200800
;

-- Nov 14, 2012 3:05:10 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=130,Updated=TO_TIMESTAMP('2012-11-14 15:05:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200803
;

-- Nov 14, 2012 3:05:13 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=140,Updated=TO_TIMESTAMP('2012-11-14 15:05:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200801
;

-- Nov 14, 2012 3:05:15 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=150,Updated=TO_TIMESTAMP('2012-11-14 15:05:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200802
;

-- Nov 14, 2012 3:05:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=160,Updated=TO_TIMESTAMP('2012-11-14 15:05:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200794
;

-- Nov 14, 2012 3:05:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=170,Updated=TO_TIMESTAMP('2012-11-14 15:05:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 3:05:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=180,Updated=TO_TIMESTAMP('2012-11-14 15:05:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200786
;

-- Nov 14, 2012 3:05:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=190,Updated=TO_TIMESTAMP('2012-11-14 15:05:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 3:05:23 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=200,Updated=TO_TIMESTAMP('2012-11-14 15:05:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200788
;

-- Nov 14, 2012 3:05:24 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=210,Updated=TO_TIMESTAMP('2012-11-14 15:05:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 3:05:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=220,Updated=TO_TIMESTAMP('2012-11-14 15:05:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200791
;

-- Nov 14, 2012 3:05:27 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=230,Updated=TO_TIMESTAMP('2012-11-14 15:05:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 3:05:28 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=240,Updated=TO_TIMESTAMP('2012-11-14 15:05:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200793
;

-- Nov 14, 2012 3:05:30 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=250,Updated=TO_TIMESTAMP('2012-11-14 15:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 3:06:25 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200796
;

-- Nov 14, 2012 3:06:25 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200797
;

-- Nov 14, 2012 3:06:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200798
;

-- Nov 14, 2012 3:06:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200805
;

-- Nov 14, 2012 3:06:27 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200804
;

-- Nov 14, 2012 3:06:27 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200799
;

-- Nov 14, 2012 3:06:27 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200800
;

-- Nov 14, 2012 3:06:28 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200803
;

-- Nov 14, 2012 3:06:28 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200801
;

-- Nov 14, 2012 3:06:29 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200802
;

-- Nov 14, 2012 3:06:29 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200794
;

-- Nov 14, 2012 3:06:30 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 3:06:30 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200786
;

-- Nov 14, 2012 3:06:32 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 3:06:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200788
;

-- Nov 14, 2012 3:06:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 3:06:34 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200791
;

-- Nov 14, 2012 3:06:34 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 3:06:34 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200793
;

-- Nov 14, 2012 3:06:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-14 15:06:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 3:07:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-11-14 15:07:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200796
;

-- Nov 14, 2012 3:07:29 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2012-11-14 15:07:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200797
;

-- Nov 14, 2012 3:07:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-11-14 15:07:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200798
;

-- Nov 14, 2012 3:07:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-11-14 15:07:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200805
;

-- Nov 14, 2012 3:07:40 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-11-14 15:07:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200804
;

-- Nov 14, 2012 3:08:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2012-11-14 15:08:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200805
;

-- Nov 14, 2012 3:08:19 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-11-14 15:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200799
;

-- Nov 14, 2012 3:08:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-11-14 15:08:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200800
;

-- Nov 14, 2012 3:08:22 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-11-14 15:08:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200801
;

-- Nov 14, 2012 3:08:30 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2012-11-14 15:08:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200802
;

-- Nov 14, 2012 3:08:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLength=11,Updated=TO_TIMESTAMP('2012-11-14 15:08:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200803
;

-- Nov 14, 2012 3:08:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-11-14 15:08:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200799
;

-- Nov 14, 2012 3:08:34 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-11-14 15:08:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200803
;

-- Nov 14, 2012 3:08:39 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2012-11-14 15:08:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200802
;

-- Nov 14, 2012 3:08:40 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-11-14 15:08:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200803
;

-- Nov 14, 2012 3:08:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-11-14 15:08:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200799
;

-- Nov 14, 2012 3:08:45 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-11-14 15:08:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 3:08:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-11-14 15:08:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 3:08:47 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-11-14 15:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 3:08:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-11-14 15:08:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 3:08:57 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-11-14 15:08:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 3:08:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-11-14 15:08:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200794
;

-- Nov 14, 2012 3:09:00 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-11-14 15:09:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 3:09:00 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-11-14 15:09:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200786
;

-- Nov 14, 2012 3:09:02 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-11-14 15:09:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 3:09:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-11-14 15:09:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200788
;

-- Nov 14, 2012 3:09:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-11-14 15:09:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 3:09:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-11-14 15:09:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200791
;

-- Nov 14, 2012 3:09:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-11-14 15:09:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 3:09:06 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2012-11-14 15:09:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200793
;

-- Nov 14, 2012 3:09:06 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2012-11-14 15:09:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 3:14:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:14:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200796
;

-- Nov 14, 2012 3:15:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:15:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200797
;

-- Nov 14, 2012 3:17:29 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200798
;

-- Nov 14, 2012 3:17:32 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200805
;

-- Nov 14, 2012 3:17:34 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200804
;

-- Nov 14, 2012 3:17:36 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200799
;

-- Nov 14, 2012 3:17:37 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200800
;

-- Nov 14, 2012 3:17:40 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200803
;

-- Nov 14, 2012 3:17:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200801
;

-- Nov 14, 2012 3:17:43 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200802
;

-- Nov 14, 2012 3:17:44 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200794
;

-- Nov 14, 2012 3:17:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 3:17:47 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200786
;

-- Nov 14, 2012 3:17:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 3:17:51 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200788
;

-- Nov 14, 2012 3:17:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 3:17:54 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200791
;

-- Nov 14, 2012 3:17:55 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 3:17:57 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200793
;

-- Nov 14, 2012 3:17:59 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-14 15:17:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 3:31:36 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET IsUpdateable='N', Callout='org.compiere.model.CalloutBankAcctProcessor.paymentProcessor',Updated=TO_TIMESTAMP('2012-11-14 15:31:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200694
;

-- Nov 14, 2012 6:02:02 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptAMEX',200223,'D','Accept AMEX','Accept AMEX','bdcee7b1-efa8-475a-9226-9bca6afd1426',0,TO_TIMESTAMP('2012-11-14 18:02:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:02:00','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:02:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200223 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:02:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptATM',200224,'D','Accept ATM','Accept ATM','37f5aeda-1a0b-4429-b87f-c5f6eb247781',0,TO_TIMESTAMP('2012-11-14 18:02:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:02:19','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:02:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200224 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:02:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptCheck',200225,'D','Accept Check','Accept Check','4e194559-ef85-4fcc-89c9-ba5f2a617764',0,TO_TIMESTAMP('2012-11-14 18:02:35','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:02:35','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:02:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200225 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:02:55 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptCorporate',200226,'D','Accept Corporate','Accept Corporate','35855f43-0dd1-4460-b3a3-7c3d9e906e35',0,TO_TIMESTAMP('2012-11-14 18:02:54','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:02:54','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:02:55 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200226 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:03:12 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptDiners',200227,'D','Accept Diners','Accept Diners','a70de08e-ea22-47c2-a9e2-54fc3adde344',0,TO_TIMESTAMP('2012-11-14 18:03:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:03:11','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:03:12 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200227 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:03:30 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptDirectDebit',200228,'D','Accept Direct Debit','Accept Direct Debit','7ffb6a54-8f59-4027-b097-6d8357863bb6',0,TO_TIMESTAMP('2012-11-14 18:03:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:03:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:03:30 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200228 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:03:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptDirectDeposit',200229,'D','Accept Direct Deposit','Accept Direct Deposit','70f0abc8-4014-4821-8552-0c3f1d8d29c3',0,TO_TIMESTAMP('2012-11-14 18:03:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:03:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:03:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200229 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:04:02 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptDiscover',200230,'D','Accept Discover','Accept Discover','7518770b-665a-4084-8a3e-b3c218b30e74',0,TO_TIMESTAMP('2012-11-14 18:04:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:04:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:04:02 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200230 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:04:31 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptMC',200231,'D','Accept MasterCard','Accept MasterCard','5a0efa1e-56bd-486d-a661-5e82ac3352c7',0,TO_TIMESTAMP('2012-11-14 18:04:30','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:04:30','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:04:31 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200231 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:04:44 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsAcceptVisa',200232,'D','Accept Visa','Accept Visa','210f09cd-580a-4307-9586-ea3f244b7469',0,TO_TIMESTAMP('2012-11-14 18:04:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-14 18:04:43','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 14, 2012 6:04:44 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200232 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 14, 2012 6:06:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200903,'U','N','N','N',0,'N',1,'N',20,'N',200223,'N','Y','9b526d26-0a00-4444-b078-f5f31b5f7f96','N','N','IsAcceptAMEX','(SELECT pp.AcceptAMEX FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept AMEX','N',100,TO_TIMESTAMP('2012-11-14 18:06:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:06:03','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:06:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200903 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:06:38 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-11-14 18:06:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200903
;

-- Nov 14, 2012 6:07:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200904,'D','N','N','N',0,'N',1,'N',20,'N',200224,'N','Y','5d742552-5192-4710-8f40-535531707e02','N','N','IsAcceptATM','(SELECT pp.AcceptATM FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept ATM','N',100,TO_TIMESTAMP('2012-11-14 18:07:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:07:05','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:07:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200904 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:07:32 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200905,'D','N','N','N',0,'N',1,'N',20,'N',200225,'N','Y','e71b546e-2a72-42d7-a107-60cd82611d30','N','N','IsAcceptCheck','(SELECT pp.AcceptCheck FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept Check','N',100,TO_TIMESTAMP('2012-11-14 18:07:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:07:31','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:07:32 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200905 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:07:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200906,'D','N','N','N',0,'N',1,'N',20,'N',200226,'N','Y','bef525ff-b528-47fc-9015-58d580109bdc','N','N','IsAcceptCorporate','(SELECT pp.AcceptCorporate FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept Corporate','N',100,TO_TIMESTAMP('2012-11-14 18:07:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:07:57','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:07:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200906 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:08:32 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200907,'D','N','N','N',0,'N',1,'N',20,'N',200227,'N','Y','285440b3-a119-4866-969d-ccc3daf34ba6','N','N','IsAcceptDiners','(SELECT pp.AcceptDiners FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept Diners','N',100,TO_TIMESTAMP('2012-11-14 18:08:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:08:31','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:08:32 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200907 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:09:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200908,'D','N','N','N',0,'N',1,'N',20,'N',200228,'N','Y','f8ebacd4-f51a-4897-9a8b-e3ae62a3fcfd','N','N','IsAcceptDirectDebit','(SELECT pp.AcceptDirectDebit FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept Direct Debit','N',100,TO_TIMESTAMP('2012-11-14 18:09:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:09:06','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:09:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200908 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:09:36 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200909,'D','N','N','N',0,'N',1,'N',20,'N',200229,'N','Y','ab81e308-7349-4c4b-8fab-117dfb10b932','N','N','IsAcceptDirectDeposit','(SELECT pp.AcceptDirectDeposit FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept Direct Deposit','N',100,TO_TIMESTAMP('2012-11-14 18:09:35','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:09:35','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:09:36 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200909 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:10:06 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200910,'D','N','N','N',0,'N',1,'N',20,'N',200230,'N','Y','3b5b05a4-63ea-4c98-90d6-fe26670b048d','N','N','IsAcceptDiscover','(SELECT pp.AcceptDiscover FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept Discover','N',100,TO_TIMESTAMP('2012-11-14 18:10:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:10:05','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:10:06 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200910 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:10:32 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200911,'D','N','N','N',0,'N',1,'N',20,'N',200231,'N','Y','539de20e-d3fa-4108-b5db-31d1a5aebf91','N','N','IsAcceptMC','(SELECT pp.AcceptMC FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept MasterCard','N',100,TO_TIMESTAMP('2012-11-14 18:10:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:10:31','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:10:32 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200911 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:10:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,ColumnSQL,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200912,'D','N','N','N',0,'N',1,'N',20,'N',200232,'N','Y','b06de04c-7e85-43c9-8965-6cb3f0663743','N','N','IsAcceptVisa','(SELECT pp.AcceptVisa FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID=C_BankAccount_Processor.C_PaymentProcessor_ID)','Accept Visa','N',100,TO_TIMESTAMP('2012-11-14 18:10:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-14 18:10:51','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 14, 2012 6:10:52 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200912 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 14, 2012 6:16:45 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptMC@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:16:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200794
;

-- Nov 14, 2012 6:17:06 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptVisa@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 6:17:11 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptAMEX@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200786
;

-- Nov 14, 2012 6:17:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptDiners@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 6:17:28 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptCorporate@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200788
;

-- Nov 14, 2012 6:17:34 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptDiscover@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 6:17:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptDirectDeposit@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200791
;

-- Nov 14, 2012 6:17:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptDirectDebit@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 6:17:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptCheck@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200793
;

-- Nov 14, 2012 6:17:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsAcceptATM@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:17:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 6:35:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200903,'Y',200806,'N','D','Accept AMEX','N','Y','54e7f3d8-a3fb-4dd5-ae1b-a7c4f683e236',100,0,TO_TIMESTAMP('2012-11-14 18:35:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200806 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200904,'Y',200807,'N','D','Accept ATM','N','Y','c31a08b7-118c-445b-b6b9-dbd379839209',100,0,TO_TIMESTAMP('2012-11-14 18:35:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200807 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200905,'Y',200808,'N','D','Accept Check','N','Y','4590b815-c303-44fa-a4f9-73e7e577a845',100,0,TO_TIMESTAMP('2012-11-14 18:35:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200808 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:19 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200906,'Y',200809,'N','D','Accept Corporate','N','Y','79173208-6057-4b50-82d8-bee6bb7a03fd',100,0,TO_TIMESTAMP('2012-11-14 18:35:18','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:18','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:19 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200809 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200907,'Y',200810,'N','D','Accept Diners','N','Y','34d73908-5806-4dbd-bc91-0f224e122f86',100,0,TO_TIMESTAMP('2012-11-14 18:35:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:19','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200810 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200908,'Y',200811,'N','D','Accept Direct Debit','N','Y','1bb433de-f69b-4dde-b8d2-6205b22672d1',100,0,TO_TIMESTAMP('2012-11-14 18:35:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200811 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200909,'Y',200812,'N','D','Accept Direct Deposit','N','Y','87657bdd-5f67-48fb-ab2b-72ba17f34ed1',100,0,TO_TIMESTAMP('2012-11-14 18:35:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:21','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:22 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200812 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:22 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200910,'Y',200813,'N','D','Accept Discover','N','Y','b698adf0-e5af-4b16-806c-aced77db0cba',100,0,TO_TIMESTAMP('2012-11-14 18:35:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:22 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200813 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:23 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200911,'Y',200814,'N','D','Accept MasterCard','N','Y','1b7f6752-aa8f-442a-9df5-26a3b9a30b2a',100,0,TO_TIMESTAMP('2012-11-14 18:35:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:23 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200814 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:24 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200912,'Y',200815,'N','D','Accept Visa','N','Y','6b26d10e-c714-4cdd-8232-73d5abb209d9',100,0,TO_TIMESTAMP('2012-11-14 18:35:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-14 18:35:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 14, 2012 6:35:24 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200815 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200806
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200807
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200808
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200809
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200810
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200811
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200812
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200813
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200814
;

-- Nov 14, 2012 6:35:35 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200815
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200806
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200807
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200787
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200808
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200809
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200810
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200811
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200812
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200813
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200814
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200815
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200643
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200644
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200641
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200645
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200640
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200796
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200797
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200798
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200805
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200804
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200799
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200800
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200803
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200801
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200802
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200794
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200786
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200788
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200791
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 6:35:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=200793
;

-- Nov 14, 2012 6:43:42 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptAMEX',Updated=TO_TIMESTAMP('2012-11-14 18:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200223
;

-- Nov 14, 2012 6:43:42 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptAMEX', Name='Accept AMEX', Description=NULL, Help=NULL WHERE AD_Element_ID=200223
;

-- Nov 14, 2012 6:43:43 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptAMEX', Name='Accept AMEX', Description=NULL, Help=NULL, AD_Element_ID=200223 WHERE UPPER(ColumnName)='ISPPACCEPTAMEX' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:43:43 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptAMEX', Name='Accept AMEX', Description=NULL, Help=NULL WHERE AD_Element_ID=200223 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:43:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptATM',Updated=TO_TIMESTAMP('2012-11-14 18:43:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200224
;

-- Nov 14, 2012 6:43:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptATM', Name='Accept ATM', Description=NULL, Help=NULL WHERE AD_Element_ID=200224
;

-- Nov 14, 2012 6:43:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptATM', Name='Accept ATM', Description=NULL, Help=NULL, AD_Element_ID=200224 WHERE UPPER(ColumnName)='ISPPACCEPTATM' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:43:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptATM', Name='Accept ATM', Description=NULL, Help=NULL WHERE AD_Element_ID=200224 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:44:00 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptCheck',Updated=TO_TIMESTAMP('2012-11-14 18:44:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200225
;

-- Nov 14, 2012 6:44:00 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptCheck', Name='Accept Check', Description=NULL, Help=NULL WHERE AD_Element_ID=200225
;

-- Nov 14, 2012 6:44:00 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptCheck', Name='Accept Check', Description=NULL, Help=NULL, AD_Element_ID=200225 WHERE UPPER(ColumnName)='ISPPACCEPTCHECK' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:44:00 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptCheck', Name='Accept Check', Description=NULL, Help=NULL WHERE AD_Element_ID=200225 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:44:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptCorporate',Updated=TO_TIMESTAMP('2012-11-14 18:44:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200226
;

-- Nov 14, 2012 6:44:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptCorporate', Name='Accept Corporate', Description=NULL, Help=NULL WHERE AD_Element_ID=200226
;

-- Nov 14, 2012 6:44:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptCorporate', Name='Accept Corporate', Description=NULL, Help=NULL, AD_Element_ID=200226 WHERE UPPER(ColumnName)='ISPPACCEPTCORPORATE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:44:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptCorporate', Name='Accept Corporate', Description=NULL, Help=NULL WHERE AD_Element_ID=200226 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:44:09 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptDiners',Updated=TO_TIMESTAMP('2012-11-14 18:44:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200227
;

-- Nov 14, 2012 6:44:09 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptDiners', Name='Accept Diners', Description=NULL, Help=NULL WHERE AD_Element_ID=200227
;

-- Nov 14, 2012 6:44:09 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptDiners', Name='Accept Diners', Description=NULL, Help=NULL, AD_Element_ID=200227 WHERE UPPER(ColumnName)='ISPPACCEPTDINERS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:44:09 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptDiners', Name='Accept Diners', Description=NULL, Help=NULL WHERE AD_Element_ID=200227 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:44:13 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptDirectDebit',Updated=TO_TIMESTAMP('2012-11-14 18:44:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200228
;

-- Nov 14, 2012 6:44:13 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptDirectDebit', Name='Accept Direct Debit', Description=NULL, Help=NULL WHERE AD_Element_ID=200228
;

-- Nov 14, 2012 6:44:13 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptDirectDebit', Name='Accept Direct Debit', Description=NULL, Help=NULL, AD_Element_ID=200228 WHERE UPPER(ColumnName)='ISPPACCEPTDIRECTDEBIT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:44:13 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptDirectDebit', Name='Accept Direct Debit', Description=NULL, Help=NULL WHERE AD_Element_ID=200228 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:44:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptDirectDeposit',Updated=TO_TIMESTAMP('2012-11-14 18:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200229
;

-- Nov 14, 2012 6:44:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptDirectDeposit', Name='Accept Direct Deposit', Description=NULL, Help=NULL WHERE AD_Element_ID=200229
;

-- Nov 14, 2012 6:44:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptDirectDeposit', Name='Accept Direct Deposit', Description=NULL, Help=NULL, AD_Element_ID=200229 WHERE UPPER(ColumnName)='ISPPACCEPTDIRECTDEPOSIT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:44:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptDirectDeposit', Name='Accept Direct Deposit', Description=NULL, Help=NULL WHERE AD_Element_ID=200229 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:44:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptDiscover',Updated=TO_TIMESTAMP('2012-11-14 18:44:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200230
;

-- Nov 14, 2012 6:44:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptDiscover', Name='Accept Discover', Description=NULL, Help=NULL WHERE AD_Element_ID=200230
;

-- Nov 14, 2012 6:44:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptDiscover', Name='Accept Discover', Description=NULL, Help=NULL, AD_Element_ID=200230 WHERE UPPER(ColumnName)='ISPPACCEPTDISCOVER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:44:21 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptDiscover', Name='Accept Discover', Description=NULL, Help=NULL WHERE AD_Element_ID=200230 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:44:25 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptMC',Updated=TO_TIMESTAMP('2012-11-14 18:44:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200231
;

-- Nov 14, 2012 6:44:25 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptMC', Name='Accept MasterCard', Description=NULL, Help=NULL WHERE AD_Element_ID=200231
;

-- Nov 14, 2012 6:44:25 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptMC', Name='Accept MasterCard', Description=NULL, Help=NULL, AD_Element_ID=200231 WHERE UPPER(ColumnName)='ISPPACCEPTMC' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:44:25 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptMC', Name='Accept MasterCard', Description=NULL, Help=NULL WHERE AD_Element_ID=200231 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:44:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Element SET ColumnName='IsPPAcceptVisa',Updated=TO_TIMESTAMP('2012-11-14 18:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200232
;

-- Nov 14, 2012 6:44:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET ColumnName='IsPPAcceptVisa', Name='Accept Visa', Description=NULL, Help=NULL WHERE AD_Element_ID=200232
;

-- Nov 14, 2012 6:44:51 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptVisa', Name='Accept Visa', Description=NULL, Help=NULL, AD_Element_ID=200232 WHERE UPPER(ColumnName)='ISPPACCEPTVISA' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Nov 14, 2012 6:44:51 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Process_Para SET ColumnName='IsPPAcceptVisa', Name='Accept Visa', Description=NULL, Help=NULL WHERE AD_Element_ID=200232 AND IsCentrallyMaintained='Y'
;

-- Nov 14, 2012 6:45:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptMC@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200794
;

-- Nov 14, 2012 6:45:19 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptVisa@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200795
;

-- Nov 14, 2012 6:45:23 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptAMEX@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200786
;

-- Nov 14, 2012 6:45:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptDiners@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200789
;

-- Nov 14, 2012 6:45:30 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptCorporate@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200788
;

-- Nov 14, 2012 6:45:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptDiscover@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200792
;

-- Nov 14, 2012 6:45:36 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptDirectDeposit@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200791
;

-- Nov 14, 2012 6:45:38 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptDirectDebit@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200790
;

-- Nov 14, 2012 6:45:41 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0 & @IsPPAcceptCheck@=Y',Updated=TO_TIMESTAMP('2012-11-14 18:45:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200793
;

-- Nov 16, 2012 12:19:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200796
;

-- Nov 16, 2012 12:19:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200796
;

-- Nov 16, 2012 12:19:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200797
;

-- Nov 16, 2012 12:19:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200797
;

-- Nov 16, 2012 12:19:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200800
;

-- Nov 16, 2012 12:19:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200800
;

-- Nov 16, 2012 12:19:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200803
;

-- Nov 16, 2012 12:19:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200803
;

-- Nov 16, 2012 12:19:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200801
;

-- Nov 16, 2012 12:19:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200801
;

-- Nov 16, 2012 12:19:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200802
;

-- Nov 16, 2012 12:19:05 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200802
;

-- Nov 16, 2012 12:19:49 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200893
;

-- Nov 16, 2012 12:19:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=200893
;

-- Nov 16, 2012 12:19:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200894
;

-- Nov 16, 2012 12:19:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=200894
;

-- Nov 16, 2012 12:19:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200899
;

-- Nov 16, 2012 12:19:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=200899
;

-- Nov 16, 2012 12:19:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200901
;

-- Nov 16, 2012 12:19:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=200901
;

-- Nov 16, 2012 12:19:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200902
;

-- Nov 16, 2012 12:19:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=200902
;

-- Nov 16, 2012 12:19:54 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200900
;

-- Nov 16, 2012 12:19:54 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=200900
;

-- Nov 16, 2012 12:21:12 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200914,'D','N','N','N',0,'N',14,'N',12,'N',2177,'N','Y','5edef5f9-24df-479b-bcd8-207cb4b54d3d','Y','N','MinimumAmt','Minimum Amount in Document Currency','Minimum Amt','Y',100,TO_TIMESTAMP('2012-11-16 12:21:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-16 12:21:10','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 16, 2012 12:21:12 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200914 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 16, 2012 12:21:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN MinimumAmt NUMERIC DEFAULT NULL 
;

-- Nov 16, 2012 12:22:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200915,'D','N','N','N',0,'N',10,'N',19,'N',193,'N','Y','4639311c-25e6-4a78-b303-3908596d11cd','Y','N','C_Currency_ID','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record','Currency','Y',100,TO_TIMESTAMP('2012-11-16 12:22:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-16 12:22:19','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 16, 2012 12:22:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200915 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 16, 2012 12:22:22 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN C_Currency_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 16, 2012 12:23:29 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton) VALUES (0,'N','N',200030,200916,'D','Y','N','N',0,'N',1,'N',20,'N',1499,'N','Y','30eb7811-32a6-48de-8c1f-59ac35802c7f','Y','N','RequireVV','Require 3/4 digit Credit Verification Code','N','The Require CC Verification checkbox indicates if this bank accounts requires a verification number for credit card transactions.','Require CreditCard Verification Code','Y',100,TO_TIMESTAMP('2012-11-16 12:23:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-11-16 12:23:28','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N')
;

-- Nov 16, 2012 12:23:29 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200916 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 16, 2012 12:23:30 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
ALTER TABLE C_BankAccount_Processor ADD COLUMN RequireVV CHAR(1) DEFAULT 'N' CHECK (RequireVV IN ('Y','N')) NOT NULL
;

-- Nov 16, 2012 12:24:02 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,10,'N','N',200915,'Y',200816,'N','Indicates the Currency to be used when processing or reporting on this record','D','The Currency for this record','Currency','N','Y','f02d1dff-0415-4f38-b3a7-d9807441148d',100,0,TO_TIMESTAMP('2012-11-16 12:24:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-16 12:24:01','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 16, 2012 12:24:02 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200816 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 16, 2012 12:24:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,14,'N','N',200914,'Y',200817,'N','D','Minimum Amount in Document Currency','Minimum Amt','N','Y','20d9b928-82e5-4407-b2d9-3c8a8f97ccd2',100,0,TO_TIMESTAMP('2012-11-16 12:24:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-16 12:24:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 16, 2012 12:24:03 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200817 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 16, 2012 12:24:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200026,1,'N','N',200916,'Y',200818,'N','The Require CC Verification checkbox indicates if this bank accounts requires a verification number for credit card transactions.','D','Require 3/4 digit Credit Verification Code','Require CreditCard Verification Code','N','Y','864e2684-e797-4d51-b611-9884644cd2cc',100,0,TO_TIMESTAMP('2012-11-16 12:24:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-11-16 12:24:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 16, 2012 12:24:04 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200818 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200798
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200805
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200804
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200799
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200794
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200795
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200786
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200789
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200788
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200792
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200791
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200790
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200793
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200817
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200818
;

-- Nov 16, 2012 12:24:26 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200816
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200798
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200805
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200804
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200799
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200794
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200795
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200786
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200789
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200788
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200792
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200791
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200790
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200793
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200817
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200818
;

-- Nov 16, 2012 12:24:33 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200816
;

-- Nov 16, 2012 12:24:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-16 12:24:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200817
;

-- Nov 16, 2012 12:24:59 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-16 12:24:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200818
;

-- Nov 16, 2012 12:24:59 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET DisplayLogic='@C_PaymentProcessor_ID@!0',Updated=TO_TIMESTAMP('2012-11-16 12:24:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200816
;

-- Nov 16, 2012 12:25:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-16 12:25:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200816
;

-- Nov 16, 2012 12:25:08 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-16 12:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200818
;

-- Nov 16, 2012 12:25:09 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-11-16 12:25:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200817
;

-- Nov 16, 2012 12:25:16 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsSameLine='Y', XPosition=5,Updated=TO_TIMESTAMP('2012-11-16 12:25:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200818
;

-- Nov 16, 2012 12:25:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsCentrallyMaintained='N', Help='The Only Currency field indicates that this bank account accepts only the currency identified here.', Description='Restrict accepting only this currency', Name='Only Currency',Updated=TO_TIMESTAMP('2012-11-16 12:25:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200816
;

-- Nov 16, 2012 12:25:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200816
;

-- Nov 16, 2012 12:26:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200816
;

-- Nov 16, 2012 12:26:46 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200818
;

-- Nov 16, 2012 12:26:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200816
;

-- Nov 16, 2012 12:26:48 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200818
;

UPDATE C_BankAccount_Processor bap 
SET AcceptAMEX = (SELECT pp.AcceptAMEX FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptATM = (SELECT pp.AcceptATM FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptCheck = (SELECT pp.AcceptCheck FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptCorporate = (SELECT pp.AcceptCorporate FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptDiners = (SELECT pp.AcceptDiners FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptDirectDebit = (SELECT pp.AcceptDirectDebit FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptDirectDeposit = (SELECT pp.AcceptDirectDeposit FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptDiscover = (SELECT pp.AcceptDiscover FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptMC = (SELECT pp.AcceptMC FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET AcceptVisa = (SELECT pp.AcceptVisa FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET PartnerID = (SELECT pp.PartnerID FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET VendorID = (SELECT pp.VendorID FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET UserID = (SELECT pp.UserID FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET Password = (SELECT pp.Password FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET MinimumAmt = (SELECT pp.MinimumAmt FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET C_Currency_ID = (SELECT pp.C_Currency_ID FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

UPDATE C_BankAccount_Processor bap 
SET RequireVV = (SELECT pp.RequireVV FROM C_PaymentProcessor pp WHERE pp.C_PaymentProcessor_ID = bap.C_PaymentProcessor_ID);

ALTER TABLE C_BankAccount_Processor DROP COLUMN HostAddress;
ALTER TABLE C_BankAccount_Processor DROP COLUMN HostPort;
ALTER TABLE C_BankAccount_Processor DROP COLUMN ProxyAddress;
ALTER TABLE C_BankAccount_Processor DROP COLUMN ProxyPort;
ALTER TABLE C_BankAccount_Processor DROP COLUMN ProxyLogon;
ALTER TABLE C_BankAccount_Processor DROP COLUMN ProxyPassword;

ALTER TABLE C_PaymentProcessor DROP COLUMN PartnerID;
ALTER TABLE C_PaymentProcessor DROP COLUMN VendorID;
ALTER TABLE C_PaymentProcessor DROP COLUMN UserID;
ALTER TABLE C_PaymentProcessor DROP COLUMN Password;

-- Nov 16, 2012 3:32:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200566
;

-- Nov 16, 2012 3:32:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200566
;

-- Nov 16, 2012 3:32:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200567
;

-- Nov 16, 2012 3:32:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200567
;

-- Nov 16, 2012 3:32:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200568
;

-- Nov 16, 2012 3:32:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200568
;

-- Nov 16, 2012 3:32:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200569
;

-- Nov 16, 2012 3:32:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Field WHERE AD_Field_ID=200569
;

-- Nov 16, 2012 3:33:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=7798
;

-- Nov 16, 2012 3:33:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=7798
;

-- Nov 16, 2012 3:33:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=5059
;

-- Nov 16, 2012 3:33:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=5059
;

-- Nov 16, 2012 3:33:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=5058
;

-- Nov 16, 2012 3:33:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=5058
;

-- Nov 16, 2012 3:33:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=7797
;

-- Nov 16, 2012 3:33:07 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
DELETE FROM AD_Column WHERE AD_Column_ID=7797
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200589
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200590
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200587
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200570
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200571
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200572
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200573
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200574
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200575
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200576
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200577
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200578
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200579
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200580
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200581
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200582
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200583
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=200584
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=200585
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200586
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200588
;

-- Nov 16, 2012 3:33:50 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200729
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200558
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200589
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200590
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200587
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200559
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200561
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200562
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200563
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200564
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200565
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200570
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200571
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200572
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200573
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200574
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200575
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200576
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200577
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200578
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200579
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200580
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200581
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200582
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200583
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200584
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=200585
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=200586
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=200588
;

-- Nov 16, 2012 3:33:58 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=200729
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200558
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200559
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200561
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200562
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200563
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200564
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200565
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200570
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200571
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200572
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200573
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200574
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200575
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200576
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200577
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200578
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200579
;

-- Nov 16, 2012 3:34:17 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200580
;

-- Nov 16, 2012 3:34:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200581
;

-- Nov 16, 2012 3:34:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200582
;

-- Nov 16, 2012 3:34:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200583
;

-- Nov 16, 2012 3:34:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=200584
;

-- Nov 16, 2012 3:34:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=200585
;

-- Nov 16, 2012 3:34:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=200586
;

-- Nov 16, 2012 3:34:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=200588
;

-- Nov 16, 2012 3:34:18 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=200729
;

-- Nov 16, 2012 3:35:09 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2012-11-16 15:35:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200897
;

-- Nov 16, 2012 3:35:13 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO t_alter_column values('c_bankaccount_processor','UserID','VARCHAR(100)',null,null)
;

-- Nov 16, 2012 3:35:13 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO t_alter_column values('c_bankaccount_processor','UserID',null,'NOT NULL',null)
;

-- Nov 16, 2012 3:35:20 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2012-11-16 15:35:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200898
;

-- Nov 16, 2012 3:35:22 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO t_alter_column values('c_bankaccount_processor','Password','VARCHAR(60)',null,null)
;

-- Nov 16, 2012 3:35:22 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
INSERT INTO t_alter_column values('c_bankaccount_processor','Password',null,'NOT NULL',null)
;

-- Nov 16, 2012 5:17:53 PM SGT
-- Ticket #1001611: Adjust Payment Processor Options for Tenant
UPDATE AD_Field SET IsEncrypted='Y',Updated=TO_TIMESTAMP('2012-11-16 17:17:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200799
;

SELECT register_migration_script('201211161720_TICKET-1001611.sql') FROM dual
;