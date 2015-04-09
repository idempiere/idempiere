-- IDEMPIERE-2558:don't allow use old password when change password
-- Apr 9, 2015 8:07:17 AM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212114,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200171,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2015-04-09 08:07:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-09 08:07:16','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','73768f30-e902-4b6b-9c00-1786c8c97794','N',0,'N','N')
;

-- Apr 9, 2015 8:07:48 AM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212115,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200171,'CreatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2015-04-09 08:07:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-09 08:07:45','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','12891791-597b-4a5a-a8a7-0bfd63986645','N',0,'N','N')
;

-- Apr 9, 2015 8:08:05 AM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212116,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200171,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2015-04-09 08:08:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-09 08:08:04','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','b4a3d061-4bde-465e-ac1b-3b436636f212','N',0,'N','N')
;

-- Apr 9, 2015 8:08:25 AM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212117,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200171,'UpdatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2015-04-09 08:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-09 08:08:25','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','8eea090f-9780-421c-94d3-77a71ca620ac','N',0,'N','N')
;

-- Apr 9, 2015 8:08:53 AM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212118,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200171,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2015-04-09 08:08:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-09 08:08:52','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','09459c69-f118-4c5a-8535-05272f8b41bf','N',0,'N','N')
;


-- Apr 9, 2015 8:15:16 AM ICT
ALTER TABLE AD_Password_History ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() 
;

-- Apr 9, 2015 8:15:26 AM ICT
UPDATE AD_Column SET FKConstraintName='CreatedBy_ADPasswordHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2015-04-09 08:15:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212115
;

-- Apr 9, 2015 8:15:26 AM ICT
ALTER TABLE AD_Password_History ADD COLUMN CreatedBy NUMERIC(10) DEFAULT NULL 
;

-- Apr 9, 2015 8:15:26 AM ICT
ALTER TABLE AD_Password_History ADD CONSTRAINT CreatedBy_ADPasswordHistory FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 9, 2015 8:15:46 AM ICT
ALTER TABLE AD_Password_History ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N'))
;

-- Apr 9, 2015 8:15:59 AM ICT
ALTER TABLE AD_Password_History ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() 
;

-- Apr 9, 2015 8:16:06 AM ICT
UPDATE AD_Column SET FKConstraintName='UpdatedBy_ADPasswordHistory', FKConstraintType='N',Updated=TO_TIMESTAMP('2015-04-09 08:16:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212117
;

-- Apr 9, 2015 8:16:06 AM ICT
ALTER TABLE AD_Password_History ADD COLUMN UpdatedBy NUMERIC(10) DEFAULT NULL 
;

-- Apr 9, 2015 8:16:06 AM ICT
ALTER TABLE AD_Password_History ADD CONSTRAINT UpdatedBy_ADPasswordHistory FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 9, 2015 8:21:06 AM ICT
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200080
;

-- Apr 9, 2015 8:21:06 AM ICT
DELETE FROM AD_Field WHERE AD_Field_ID=200080
;

-- Apr 9, 2015 8:21:18 AM ICT
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=200137
;

-- Apr 9, 2015 8:21:18 AM ICT
DELETE FROM AD_Column WHERE AD_Column_ID=200137
;

ALTER TABLE ad_passwordrule DROP COLUMN dictwordlength
;

SELECT register_migration_script('201504091605-IDEMPIERE-2558.sql') FROM dual
;

