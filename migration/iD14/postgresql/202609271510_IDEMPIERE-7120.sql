-- IDEMPIERE-7120 Implement Allow Gaps in Numeric Document Sequences
SELECT register_migration_script('202609271510_IDEMPIERE-7120.sql') FROM dual;

-- Sep 27, 2026, 3:10:53 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204126,0,0,'Y',TO_TIMESTAMP('2026-09-27 15:09:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-27 15:09:25','YYYY-MM-DD HH24:MI:SS'),100,'IsAllowSequenceGaps','Allow Gaps','Allow gaps in the generated sequence numbers','If enabled, the next sequence number is obtained without placing a row lock on the AD_Sequence record. This avoids blocking concurrent transactions that use the same sequence, which reduces database contention and lock-wait timeouts under high concurrency. The trade-off is that the resulting document/value numbers may contain gaps - for example when a transaction that requested a number is later rolled back, or when two transactions read the counter before either commits. Do not enable this for sequences where strict, gap-free numbering is a legal or fiscal requirement (e.g. some countries'' fiscal document numbering rules). Leave disabled to preserve the current behavior of locking the sequence row to guarantee consecutive numbers.','Allow Gaps','D','01a0e2fd-6738-7aae-a331-664d91b5ee62')
;

-- Sep 27, 2026, 3:11:08 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217660,0,'Allow Gaps','Allow gaps in the generated sequence numbers','If enabled, the next sequence number is obtained without placing a row lock on the AD_Sequence record. This avoids blocking concurrent transactions that use the same sequence, which reduces database contention and lock-wait timeouts under high concurrency. The trade-off is that the resulting document/value numbers may contain gaps - for example when a transaction that requested a number is later rolled back, or when two transactions read the counter before either commits. Do not enable this for sequences where strict, gap-free numbering is a legal or fiscal requirement (e.g. some countries'' fiscal document numbering rules). Leave disabled to preserve the current behavior of locking the sequence row to guarantee consecutive numbers.',115,'IsAllowSequenceGaps','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-09-27 15:11:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-27 15:11:07','YYYY-MM-DD HH24:MI:SS'),100,204126,'Y','N','D','N','N','N','Y','01a0e2fd-a24a-75f0-baf0-2814db718b00','Y',0,'N','N','N','N')
;

-- Sep 27, 2026, 3:11:09 PM CEST
ALTER TABLE AD_Sequence ADD COLUMN IsAllowSequenceGaps CHAR(1) DEFAULT 'N' CHECK (IsAllowSequenceGaps IN ('Y','N')) NOT NULL
;

UPDATE AD_Sequence SET IsAllowSequenceGaps='Y' WHERE IsTableID='Y'
;

-- Sep 27, 2026, 3:15:25 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (209245,'Allow Gaps','Allow gaps in the generated sequence numbers','If enabled, the next sequence number is obtained without placing a row lock on the AD_Sequence record. This avoids blocking concurrent transactions that use the same sequence, which reduces database contention and lock-wait timeouts under high concurrency. The trade-off is that the resulting document/value numbers may contain gaps - for example when a transaction that requested a number is later rolled back, or when two transactions read the counter before either commits. Do not enable this for sequences where strict, gap-free numbering is a legal or fiscal requirement (e.g. some countries'' fiscal document numbering rules). Leave disabled to preserve the current behavior of locking the sequence row to guarantee consecutive numbers.',146,217660,'Y',0,210,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-09-27 15:15:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-27 15:15:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a0e301-8e4e-7c67-a987-3cf9e425f770','Y',220,1,1,1,'N','N','N','N','N')
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, XPosition=5, ReadOnlyLogic='@IsTableID@=Y',Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209245
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=329
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54391
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=332
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=333
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200162
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200163
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=335
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54357
;

-- Sep 27, 2026, 3:16:14 PM CEST
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-09-27 15:16:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200164
;

-- Sep 27, 2026, 3:16:15 PM CEST
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-09-27 15:16:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1555
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2019
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=323
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=324
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=325
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=326
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=330
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=331
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209244
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=70,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=635
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=80,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1554
;

-- Sep 27, 2026, 3:16:53 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=90,Updated=TO_TIMESTAMP('2026-09-27 15:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209245
;

