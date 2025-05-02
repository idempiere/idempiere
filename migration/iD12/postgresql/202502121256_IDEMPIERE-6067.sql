-- IDEMPIERE-6067
SELECT register_migration_script('202502121256_IDEMPIERE-6067.sql') FROM dual;

-- Feb 12, 2025, 12:56:41 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate invoice: invoice is allocated',0,0,'Y',TO_TIMESTAMP('2025-02-12 12:56:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-12 12:56:40','YYYY-MM-DD HH24:MI:SS'),10,200935,'InvoiceReactivationFailedAllocationLine','D','053026a2-cce7-47fe-b3d1-b43d65549b71')
;

-- Feb 12, 2025, 12:57:50 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate invoice: invoice is used on a Match Invoice record',0,0,'Y',TO_TIMESTAMP('2025-02-12 12:57:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-12 12:57:50','YYYY-MM-DD HH24:MI:SS'),10,200936,'InvoiceReactivationFailedMatchInvoice','D','06cc4b28-08c4-456f-bdf1-133bb242aa73')
;

-- Feb 12, 2025, 12:58:02 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate invoice: invoice is used on a Match PO record',0,0,'Y',TO_TIMESTAMP('2025-02-12 12:58:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-12 12:58:02','YYYY-MM-DD HH24:MI:SS'),10,200937,'InvoiceReactivationFailedMatchPO','D','8e9726ff-39a3-44e5-84ce-c200068fbff6')
;

-- Feb 28, 2025, 4:22:15 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203988,0,0,'Y',TO_TIMESTAMP('2025-02-28 16:22:15','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-28 16:22:15','YYYY-MM-DD HH24:MI:SS'),10,'IsCanBeReactivated','Can Be Reactivated','This document can be reactivated','If ticked, this checkbox allow user to reactivate once it has been completed (according to rights given to the role)','Can Be Reactivated','D','0219ac08-5b84-4f4b-a693-4100d93984bb')
;

-- Feb 28, 2025, 4:22:40 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217048,0,'Can Be Reactivated','This document can be reactivated','If ticked, this checkbox allow user to reactivate once it has been completed (according to rights given to the role)',217,'IsCanBeReactivated','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2025-02-28 16:22:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-28 16:22:40','YYYY-MM-DD HH24:MI:SS'),10,203988,'Y','N','D','N','N','N','Y','6e772525-a619-434f-acbb-222ce90c460e','N',0,'N','N','N','N')
;

-- Feb 28, 2025, 4:22:41 PM CET
ALTER TABLE C_DocType ADD COLUMN IsCanBeReactivated CHAR(1) DEFAULT 'N' CHECK (IsCanBeReactivated IN ('Y','N')) NOT NULL
;

-- Feb 28, 2025, 4:22:52 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208710,'Can Be Reactivated','This document can be reactivated','If ticked, this checkbox allow user to reactivate once it has been completed (according to rights given to the role)',167,217048,'Y',1,370,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-02-28 16:22:51','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-28 16:22:51','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','4e29a45f-612e-416e-a48d-c923bbea9abe','Y',350,2,2)
;

-- Feb 28, 2025, 4:23:08 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=350, XPosition=5,Updated=TO_TIMESTAMP('2025-02-28 16:23:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208710
;

-- Feb 28, 2025, 4:23:08 PM CET
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2025-02-28 16:23:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=6567
;

-- Feb 28, 2025, 4:23:08 PM CET
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2025-02-28 16:23:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=3125
;

-- Mar 20, 2025, 2:06:23 PM CET
UPDATE AD_Field SET DisplayLogic='@DocBaseType@=''SOO'' | @DocBaseType@=''POO'' | @DocBaseType@=''API'' | @DocBaseType@=''ARI'' | @DocBaseType@=''ARF'' | @DocBaseType@=''API'' | @DocBaseType@=''ARC'' | @DocBaseType@=''APC'' | @DocBaseType@=''ARR'' | @DocBaseType@=''APP'' | @DocBaseType@=''CMB'' | @DocBaseType@=''GLJ''',Updated=TO_TIMESTAMP('2025-03-20 14:06:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=208710
;

-- Mar 20, 2025, 2:14:42 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','{0} cannot be reactivated',0,0,'Y',TO_TIMESTAMP('2025-03-20 14:14:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-03-20 14:14:41','YYYY-MM-DD HH24:MI:SS'),10,200941,'DocTypeCannotBeReactivated','D','c4bd569c-db4d-440b-9c05-e99ec99716c1')
;


UPDATE C_DocType SET IsCanBeReactivated = 'Y' WHERE DocBaseType IN ('SOO', 'POO', 'ARR', 'APP', 'CMB', 'GLJ')
;