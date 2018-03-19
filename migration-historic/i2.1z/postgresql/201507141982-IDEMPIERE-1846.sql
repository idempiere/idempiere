-- IDEMPIERE-1846 Extend Scheduler by SchedulerSubject and SchedulerMessage
-- Jul 14, 2015 12:25:14 AM ICT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212393,0,'Mail Template','Text templates for mailings','The Mail Template indicates the mail template for return messages. Mail text can include variables.  The priority of parsing is User/Contact, Business Partner and then the underlying business object (like Request, Dunning, Workflow object).<br>
So, @Name@ would resolve into the User name (if user is defined defined), then Business Partner name (if business partner is defined) and then the Name of the business object if it has a Name.<br>
For Multi-Lingual systems, the template is translated based on the Business Partner''s language selection.',688,'R_MailText_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2015-07-14 00:25:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-07-14 00:25:14','YYYY-MM-DD HH24:MI:SS'),100,1515,'N','N','D','N','N','N','Y','69fd9dea-4a77-4270-82db-70b78db81d7b','Y',0,'N','N')
;

-- Jul 14, 2015 12:25:25 AM ICT
UPDATE AD_Column SET FKConstraintName='RMailText_ADScheduler', FKConstraintType='N',Updated=TO_TIMESTAMP('2015-07-14 00:25:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212393
;

-- Jul 14, 2015 12:25:25 AM ICT
ALTER TABLE AD_Scheduler ADD COLUMN R_MailText_ID NUMERIC(10) DEFAULT NULL 
;

-- Jul 14, 2015 12:25:25 AM ICT
ALTER TABLE AD_Scheduler ADD CONSTRAINT RMailText_ADScheduler FOREIGN KEY (R_MailText_ID) REFERENCES r_mailtext(r_mailtext_id) DEFERRABLE INITIALLY DEFERRED
;
-- Jul 14, 2015 12:58:50 AM ICT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (203924,'Mail Template','Text templates for mailings','The Mail Template indicates the mail template for return messages. Mail text can include variables.  The priority of parsing is User/Contact, Business Partner and then the underlying business object (like Request, Dunning, Workflow object).<br>
So, @Name@ would resolve into the User name (if user is defined defined), then Business Partner name (if business partner is defined) and then the Name of the business object if it has a Name.<br>
For Multi-Lingual systems, the template is translated based on the Business Partner''s language selection.',589,212393,'Y',0,160,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-07-14 00:58:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-07-14 00:58:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','279a9bda-15f1-4f41-b52d-7d0818c21d90','Y',150,1,1,1,'N','N','N')
;

-- Jul 14, 2015 12:59:33 AM ICT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2015-07-14 00:59:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203924
;

-- Jul 14, 2015 12:59:33 AM ICT
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2015-07-14 00:59:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200501
;

-- Jul 14, 2015 12:59:33 AM ICT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2015-07-14 00:59:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9434
;
-- Jul 14, 2015 2:07:07 AM ICT
UPDATE AD_Field SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2015-07-14 02:07:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203924
;
SELECT register_migration_script('201507141982-IDEMPIERE-1846.sql') FROM dual
;
