-- Jan 18, 2013 4:52:01 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',660,208382,'D','N','N','N',0,'N',10,'N',19,'N',213,'N','Y','08e6d70e-0e85-418b-85b8-d662b950e701','Y','C_Tax_ID','Tax identifier','The Tax indicates the type of tax used in document line.','Tax','Y',100,TO_TIMESTAMP('2013-01-18 16:51:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 16:51:59','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 18, 2013 4:52:01 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208382 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 4:52:06 PM SGT
-- Ticket 1001770: RMA improvements
ALTER TABLE M_RMALine ADD COLUMN C_Tax_ID NUMERIC(10) DEFAULT NULL 
;

UPDATE M_RMALine rl SET C_Tax_ID = (
SELECT CASE WHEN il.C_Tax_ID IS NOT NULL THEN il.C_Tax_ID ELSE ol.C_Tax_ID END 
FROM M_InOutLine iol
LEFT JOIN C_InvoiceLine il ON iol.M_InOutLine_ID = il.M_InOutLine_ID 
LEFT JOIN C_OrderLine ol ON iol.C_OrderLine_ID = ol.C_OrderLine_ID 
WHERE rl.M_InOutLine_ID = iol.M_InOutLine_ID 
)
WHERE rl.M_InOutLine_ID IS NOT NULL
;

UPDATE M_RMALine rl SET C_Tax_ID = (
SELECT t.C_Tax_ID
FROM C_Tax t
WHERE t.AD_Client_ID=rl.AD_Client_ID
AND t.IsActive = 'Y'
AND t.IsTaxExempt = 'Y'
AND t.ValidFrom < getdate() ORDER BY IsDefault DESC LIMIT 1)
WHERE rl.M_InOutLine_ID IS NULL
;

-- Jan 18, 2013 4:59:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-01-18 16:59:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208382
;

-- Jan 18, 2013 4:59:39 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO t_alter_column values('m_rmaline','C_Tax_ID','NUMERIC(10)',null,null)
;

-- Jan 18, 2013 4:59:39 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO t_alter_column values('m_rmaline','C_Tax_ID',null,'NOT NULL',null)
;

-- Jan 18, 2013 5:00:31 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,PO_Window_ID,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','1',145,320,200055,'N','N','N','D','L','298e09ea-6dbc-4ecb-bc34-d98739b4347f','Y','Y','M_RMATax','Return Material Authorization Tax',53099,'RMA Tax',0,'Y',0,TO_TIMESTAMP('2013-01-18 17:00:30','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-01-18 17:00:30','YYYY-MM-DD HH24:MI:SS'))
;

-- Jan 18, 2013 5:00:31 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200055 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Jan 18, 2013 5:00:33 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200050,'da791086-8393-4349-a410-be079d3153d8','Table M_RMATax','M_RMATax',1,0,0,TO_TIMESTAMP('2013-01-18 17:00:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-18 17:00:32','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Jan 18, 2013 5:00:41 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208383,'D','Y','N','N','N',22,'N',19,129,'N',102,'N','Y','8595ba8a-1211-4ec6-b91d-7f46b76aeeed','N','AD_Client_ID','Client/Tenant for this installation.','@AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_TIMESTAMP('2013-01-18 17:00:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:41 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208383 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:42 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208384,'D','Y','N','N','N',22,'N',19,130,'N',113,'N','Y','3fe85743-f55a-4750-8650-56507cd41f48','N','AD_Org_ID','Organizational entity within client','@AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_TIMESTAMP('2013-01-18 17:00:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:41','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:42 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208384 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:43 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208385,'D','Y','N','N','Y',22,'N',30,'N',558,'N','Y','bf483ef9-6d1c-495c-9ae9-e117a31b3f27','N','C_Order_ID','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','Order','Y',100,TO_TIMESTAMP('2013-01-18 17:00:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:42','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:43 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208385 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:44 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('M_RMATax_UU',202194,'D','M_RMATax_UU','M_RMATax_UU','de6a4308-2c53-426a-ad7a-def5ee38fb87',0,TO_TIMESTAMP('2013-01-18 17:00:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-18 17:00:43','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 18, 2013 5:00:44 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202194 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 18, 2013 5:00:45 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1.00,'N','N',200055,208386,'D','N','N','N','N',36,'N',10,'N',202194,'N','Y','527a6a3d-b00d-4ac0-af6b-cc5c3dffd81c','Y','M_RMATax_UU','M_RMATax_UU','N',100,TO_TIMESTAMP('2013-01-18 17:00:43','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:43','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:45 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208386 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:46 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208387,'D','Y','N','N','Y',22,'N',19,'N',213,'N','Y','718e0bcb-d693-4aae-af32-9d25e333fa4c','N','C_Tax_ID','Tax identifier','The Tax indicates the type of tax used in document line.','Tax','Y',100,TO_TIMESTAMP('2013-01-18 17:00:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:45','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:46 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208387 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:46 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208388,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','a690c1bd-01d6-4d33-8816-550592918a76','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_TIMESTAMP('2013-01-18 17:00:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:46','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:47 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208388 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:47 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208389,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','6d732e19-2310-48b5-882a-85d8d424a4cd','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_TIMESTAMP('2013-01-18 17:00:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:47 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208389 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:48 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208390,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','c8793533-f511-4700-8402-159ec00a0fde','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_TIMESTAMP('2013-01-18 17:00:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:48 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208390 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:49 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208391,'D','Y','N','N',0,'N',1,'N',20,'N',1065,'N','Y','182bd9c5-2dc1-4456-818c-fcb199e0cd8d','Y','IsTaxIncluded','Tax is included in the price ','The Tax Included checkbox indicates if the prices include tax.  This is also known as the gross price.','Price includes Tax','Y',100,TO_TIMESTAMP('2013-01-18 17:00:48','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:48','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:49 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208391 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:50 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208392,'D','Y','N','N',0,'N',1,'N',20,'N',1047,'N','Y','ddfe564a-9085-4193-98cb-dbbb19f129d3','Y','Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.','Processed','Y',100,TO_TIMESTAMP('2013-01-18 17:00:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:49','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:50 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208392 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:51 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208393,'D','Y','N','N','N',22,'N',12,'N',1133,'N','Y','fc895533-0ea5-4f9f-bd7a-2e8fd69bbb42','N','TaxAmt','Tax Amount for a document','The Tax Amount displays the total tax amount for a document.','Tax Amount','Y',100,TO_TIMESTAMP('2013-01-18 17:00:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:50','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:51 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208393 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:51 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208394,'D','Y','N','N','N',22,'N',12,'N',1134,'N','Y','efc186f9-ba73-4711-a499-16fda1cfbf2b','N','TaxBaseAmt','Base for calculating the tax amount','The Tax Base Amount indicates the base amount used for calculating the tax amount.','Tax base Amount','Y',100,TO_TIMESTAMP('2013-01-18 17:00:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:51','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:51 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208394 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:52 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208395,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','b9b679d0-113d-4e70-b241-13424b9bed41','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_TIMESTAMP('2013-01-18 17:00:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:51','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:52 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208395 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:00:53 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'N','N',200055,208396,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','02658f9d-f73a-4de2-be47-bb26d0f76a3e','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_TIMESTAMP('2013-01-18 17:00:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-18 17:00:52','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 18, 2013 5:00:53 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208396 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 18, 2013 5:01:26 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Column SET AD_Element_ID=2412, IsUpdateable='N', ColumnName='M_RMA_ID', Description='Return Material Authorization', Help='A Return Material Authorization may be required to accept returns and to create Credit Memos', Name='RMA',Updated=TO_TIMESTAMP('2013-01-18 17:01:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208385
;

-- Jan 18, 2013 5:01:26 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=208385
;

-- Jan 18, 2013 5:01:26 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET Name='RMA', Description='Return Material Authorization', Help='A Return Material Authorization may be required to accept returns and to create Credit Memos' WHERE AD_Column_ID=208385 AND IsCentrallyMaintained='Y'
;

-- Jan 18, 2013 5:02:07 PM SGT
-- Ticket 1001770: RMA improvements
CREATE TABLE M_RMATax (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_Tax_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTaxIncluded CHAR(1) CHECK (IsTaxIncluded IN ('Y','N')) NOT NULL, M_RMA_ID NUMERIC(10) NOT NULL, M_RMATax_UU VARCHAR(36) DEFAULT NULL , Processed CHAR(1) CHECK (Processed IN ('Y','N')) NOT NULL, TaxAmt NUMERIC NOT NULL, TaxBaseAmt NUMERIC NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT M_RMATax_Key PRIMARY KEY (C_Tax_ID, M_RMA_ID))
;

-- Jan 18, 2013 5:02:56 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',629,36,'N','N',60949,'Y',201660,'N','D','M_RMALine_UU','N','Y','a262b6b1-c890-4c85-a974-4af6b28f2f15',100,0,TO_TIMESTAMP('2013-01-18 17:02:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:02:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:02:56 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201660 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:02:57 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',629,22,'N','N',57792,'Y',201661,'N','The Invoiced Quantity indicates the quantity of a product that have been invoiced.','D','Invoiced Quantity','Quantity Invoiced','N','Y','25f4b674-b6ac-4b55-8bb6-d4f6c4ef207b',100,0,TO_TIMESTAMP('2013-01-18 17:02:56','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:02:56','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:02:57 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201661 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:02:57 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',629,22,'N','N',57791,'Y',201662,'N','D','Referenced RMA Line','N','Y','671f0cdf-975c-438e-9904-3ba0034e45e8',100,0,TO_TIMESTAMP('2013-01-18 17:02:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:02:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:02:58 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201662 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:02:58 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',629,10,'N','N',208382,'Y',201663,'N','The Tax indicates the type of tax used in document line.','D','Tax identifier','Tax','N','Y','085358dd-5812-430f-9efe-9b73dec92b6d',100,0,TO_TIMESTAMP('2013-01-18 17:02:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:02:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:02:58 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201663 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:03:31 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201660
;

-- Jan 18, 2013 5:03:31 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201661
;

-- Jan 18, 2013 5:03:31 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201662
;

-- Jan 18, 2013 5:03:31 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=201663
;

-- Jan 18, 2013 5:03:31 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=52004
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=9317
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201660
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201661
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201662
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=9311
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=9314
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=52005
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=9315
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=9310
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=9312
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=52002
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=9316
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=52001
;

-- Jan 18, 2013 5:03:37 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=201663
;

-- Jan 18, 2013 5:04:27 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:04:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201663
;

-- Jan 18, 2013 5:05:24 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,Help,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,AD_Column_ID,AD_Tab_UU,IsInsertRecord,IsAdvancedTab,TabLevel,EntityType,Name,Description,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','N',320,30,'The RMA Tax Tab displays the tax amount for a RMA based on the lines entered.','N','N',200055,'N','Y','N',208385,'c6a404bb-f31a-42e7-aaa4-e4ef95043b24','N','N',1,'D','RMA Tax','RMA Tax',200065,0,TO_TIMESTAMP('2013-01-18 17:05:23','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-01-18 17:05:23','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Jan 18, 2013 5:05:24 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200065 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jan 18, 2013 5:05:26 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,1,'N','N',208390,'Y',201664,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','c9d4c511-2c45-423b-ac4c-6f3a08097b62',100,0,TO_TIMESTAMP('2013-01-18 17:05:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:26 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201664 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:27 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,22,'N','N',208383,'Y',201665,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','2cdc5aa8-aae8-46f3-8238-cf165292732f',100,0,TO_TIMESTAMP('2013-01-18 17:05:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:27 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201665 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:28 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,36,'N','N',208386,'Y',201666,'N','D','M_RMATax_UU','N','Y','301a7e21-5aaf-48c6-a517-d16742f9f94c',100,0,TO_TIMESTAMP('2013-01-18 17:05:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:28 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201666 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:29 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,22,'N','N',208384,'Y',201667,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','eb8268c4-b965-45d6-b27f-b198c050b8eb',100,0,TO_TIMESTAMP('2013-01-18 17:05:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:29 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201667 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:30 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,1,'N','N',208391,'Y',201668,'N','The Tax Included checkbox indicates if the prices include tax.  This is also known as the gross price.','D','Tax is included in the price ','Price includes Tax','N','Y','9e82ee49-a5df-4a92-99c0-1ae992da860a',100,0,TO_TIMESTAMP('2013-01-18 17:05:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:30 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201668 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:30 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,1,'N','N',208392,'Y',201669,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','N','Y','679b7f15-7f3c-40a4-876c-60da0f77c65d',100,0,TO_TIMESTAMP('2013-01-18 17:05:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:30','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:30 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201669 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:31 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,22,'N','N',208385,'Y',201670,'N','A Return Material Authorization may be required to accept returns and to create Credit Memos','D','Return Material Authorization','RMA','N','Y','404d7b87-c65c-4b28-a257-b43e9d26e8d2',100,0,TO_TIMESTAMP('2013-01-18 17:05:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:30','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:31 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201670 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:32 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,22,'N','N',208387,'Y',201671,'N','The Tax indicates the type of tax used in document line.','D','Tax identifier','Tax','N','Y','13d6c87b-bda6-4950-a6ae-3f316f2b65e7',100,0,TO_TIMESTAMP('2013-01-18 17:05:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:32 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201671 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:33 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,22,'N','N',208393,'Y',201672,'N','The Tax Amount displays the total tax amount for a document.','D','Tax Amount for a document','Tax Amount','N','Y','09af15f0-fc73-4239-8a1b-ec31621c1aac',100,0,TO_TIMESTAMP('2013-01-18 17:05:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:32','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:33 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201672 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:34 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200065,22,'N','N',208394,'Y',201673,'N','The Tax Base Amount indicates the base amount used for calculating the tax amount.','D','Base for calculating the tax amount','Tax base Amount','N','Y','a2ad8fee-bbab-4263-b667-f548e880dbfe',100,0,TO_TIMESTAMP('2013-01-18 17:05:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:05:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:05:34 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201673 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201664
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201666
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201669
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=201665
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=201667
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201670
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201671
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201672
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201673
;

-- Jan 18, 2013 5:05:56 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201668
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201664
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201665
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201666
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201669
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201667
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201670
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201671
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201672
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201673
;

-- Jan 18, 2013 5:06:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201668
;

-- Jan 18, 2013 5:06:42 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-01-18 17:06:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201665
;

-- Jan 18, 2013 5:06:43 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-01-18 17:06:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201670
;

-- Jan 18, 2013 5:06:44 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-01-18 17:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201672
;

-- Jan 18, 2013 5:06:44 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-01-18 17:06:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201673
;

-- Jan 18, 2013 5:07:04 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-01-18 17:07:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201668
;

-- Jan 18, 2013 5:07:10 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:07:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201673
;

-- Jan 18, 2013 5:07:11 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:07:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201668
;

-- Jan 18, 2013 5:07:12 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:07:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201672
;

-- Jan 18, 2013 5:07:12 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:07:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201671
;

-- Jan 18, 2013 5:07:14 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:07:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201670
;

-- Jan 18, 2013 5:07:15 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:07:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201667
;

-- Jan 18, 2013 5:07:21 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:07:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201665
;

-- Jan 18, 2013 5:07:27 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-01-18 17:07:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201673
;

-- Jan 18, 2013 5:07:56 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53281,36,'N','N',60949,'Y',201674,'N','D','M_RMALine_UU','N','Y','e556a4d4-23fa-41de-8b67-f76dc9cbe7a1',100,0,TO_TIMESTAMP('2013-01-18 17:07:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:07:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:07:56 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201674 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:07:57 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53281,22,'N','N',57792,'Y',201675,'N','The Invoiced Quantity indicates the quantity of a product that have been invoiced.','D','Invoiced Quantity','Quantity Invoiced','N','Y','aabdec36-722c-48b2-9d26-c0daad9b13ca',100,0,TO_TIMESTAMP('2013-01-18 17:07:56','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:07:56','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:07:57 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201675 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:07:58 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53281,22,'N','N',57791,'Y',201676,'N','D','Referenced RMA Line','N','Y','a9dab917-43a2-4c3e-8304-ccb23fc936c0',100,0,TO_TIMESTAMP('2013-01-18 17:07:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:07:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:07:58 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201676 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:07:58 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53281,10,'N','N',208382,'Y',201677,'N','The Tax indicates the type of tax used in document line.','D','Tax identifier','Tax','N','Y','ab1f4145-601c-47e0-aa8b-332c18696f87',100,0,TO_TIMESTAMP('2013-01-18 17:07:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:07:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 18, 2013 5:07:58 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201677 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:08:09 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201674
;

-- Jan 18, 2013 5:08:09 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201675
;

-- Jan 18, 2013 5:08:09 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201676
;

-- Jan 18, 2013 5:08:09 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=201677
;

-- Jan 18, 2013 5:08:09 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=57980
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=57970
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201674
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201675
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201676
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=57971
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=57972
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=57973
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=57974
;

-- Jan 18, 2013 5:08:17 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=57975
;

-- Jan 18, 2013 5:08:18 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=57976
;

-- Jan 18, 2013 5:08:18 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=57977
;

-- Jan 18, 2013 5:08:18 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=57978
;

-- Jan 18, 2013 5:08:18 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=57979
;

-- Jan 18, 2013 5:08:18 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=201677
;

-- Jan 18, 2013 5:08:42 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-18 17:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201677
;

-- Jan 18, 2013 5:08:47 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-01-18 17:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201677
;

-- Jan 18, 2013 5:09:04 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-01-18 17:09:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201663
;

-- Jan 18, 2013 5:10:08 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,Help,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,AD_Column_ID,AD_Tab_UU,IsInsertRecord,IsAdvancedTab,TabLevel,EntityType,Name,Description,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','N',53099,30,'The RMA Tax Tab displays the tax associated with the RMA Lines.','N','N',200055,'N','Y','N',208385,'6ff733fc-e3cf-423d-887f-4c8b1eb91c97','N','N',1,'D','RMA Tax','RMA Tax',200066,0,TO_TIMESTAMP('2013-01-18 17:10:07','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-01-18 17:10:07','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Jan 18, 2013 5:10:08 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200066 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jan 18, 2013 5:10:14 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,1,'N','N',208390,0,'Y',201678,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','N','7f6c0fa5-6d65-4f1d-9bf1-0dcc193e14ed',100,0,TO_TIMESTAMP('2013-01-18 17:10:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:13','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,1,'N')
;

-- Jan 18, 2013 5:10:14 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201678 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:15 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,36,'N','N',208386,0,'Y',201679,'N','D','M_RMATax_UU','N','N','a75a3819-abde-43c3-b1b6-154929bc2e05',100,0,TO_TIMESTAMP('2013-01-18 17:10:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:14','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,1,'N')
;

-- Jan 18, 2013 5:10:15 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201679 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:15 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,1,'N','N',208392,0,'Y',201680,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','N','N','a311c623-e1d4-44fb-9c20-3a003565f5ef',100,0,TO_TIMESTAMP('2013-01-18 17:10:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,1,'N')
;

-- Jan 18, 2013 5:10:15 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201680 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:16 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,22,'N','N',208383,10,'Y',201681,'Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','0c1f846a-d0e9-4962-9fd7-fc8fe6edb8e8',100,0,TO_TIMESTAMP('2013-01-18 17:10:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,2,'N')
;

-- Jan 18, 2013 5:10:16 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201681 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:17 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,22,'N','N',208384,20,'Y',201682,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','61509d7a-3fb5-4fd5-a8e7-33845bf47e25',100,0,TO_TIMESTAMP('2013-01-18 17:10:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:16','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,1,2,'N')
;

-- Jan 18, 2013 5:10:17 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201682 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:19 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,22,'N','N',208385,30,'Y',201683,'Y','A Return Material Authorization may be required to accept returns and to create Credit Memos','D','Return Material Authorization','RMA','N','Y','979dca3f-a651-4351-827b-f7c7a5c679a0',100,0,TO_TIMESTAMP('2013-01-18 17:10:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:17','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,2,'N')
;

-- Jan 18, 2013 5:10:19 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201683 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:20 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,22,'N','N',208387,40,'Y',201684,'N','The Tax indicates the type of tax used in document line.','D','Tax identifier','Tax','N','Y','4243ba57-783a-4681-aab8-dc1f8bec76cd',100,0,TO_TIMESTAMP('2013-01-18 17:10:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:19','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,1,2,'N')
;

-- Jan 18, 2013 5:10:20 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201684 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:20 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,22,'N','N',208393,50,'Y',201685,'Y','The Tax Amount displays the total tax amount for a document.','D','Tax Amount for a document','Tax Amount','N','Y','7808dd51-7112-4b63-810e-e70f5e915a07',100,0,TO_TIMESTAMP('2013-01-18 17:10:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:20','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,2,'N')
;

-- Jan 18, 2013 5:10:20 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201685 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:21 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,22,'Y','N',208394,60,'Y',201686,'Y','The Tax Base Amount indicates the base amount used for calculating the tax amount.','D','Base for calculating the tax amount','Tax base Amount','N','Y','a56c59af-1253-45e5-9875-5ffb89acfc42',100,0,TO_TIMESTAMP('2013-01-18 17:10:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:20','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,4,2,'N')
;

-- Jan 18, 2013 5:10:21 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201686 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 18, 2013 5:10:22 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (NumLines,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,IsQuickEntry) VALUES (1,'N',200066,1,'N','N',208391,70,'Y',201687,'Y','The Tax Included checkbox indicates if the prices include tax.  This is also known as the gross price.','D','Tax is included in the price ','Price includes Tax','N','Y','101855b4-d848-4e42-85e6-d93f7e001a41',100,0,TO_TIMESTAMP('2013-01-18 17:10:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-18 17:10:21','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,2,2,'N')
;

-- Jan 18, 2013 5:10:22 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201687 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

SELECT register_migration_script('201301181905_TICKET-1001770.sql') FROM dual
;

