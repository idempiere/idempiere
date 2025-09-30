-- IDEMPIERE-6203 Back-dating costing
SELECT register_migration_script('202410231256_IDEMPIERE-6203.sql') FROM dual;

-- Oct 23, 2024, 12:56:40 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Insufficient Stock Coverage. A reversal of shipment/project issue is required to replenish stock before reversal.',0,0,'Y',TO_TIMESTAMP('2024-10-23 12:56:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-23 12:56:39','YYYY-MM-DD HH24:MI:SS'),100,200909,'InsufficientStockCoverageForReversal','D','e5ce06cd-329e-4157-aa34-02cab5a8a2d0')
;

-- Oct 23, 2024, 12:56:57 PM MYT
UPDATE AD_Message SET MsgText='Insufficient Stock Coverage. A shipment should not be allowed if there is insufficient stock before the shipment’s movement date.',Updated=TO_TIMESTAMP('2024-10-23 12:56:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200904
;

-- Oct 23, 2024, 1:00:19 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203956,0,0,'Y',TO_TIMESTAMP('2024-10-23 13:00:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-23 13:00:18','YYYY-MM-DD HH24:MI:SS'),100,'Ref_CostDetail_ID','Referenced Cost Detail','Ref Cost Detail','D','1b27b7ec-59ad-4f16-818b-c8eb927b0f70')
;

-- Oct 23, 2024, 1:01:32 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216888,0,'Referenced Cost Detail',808,'Ref_CostDetail_ID',10,'N','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2024-10-23 13:01:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-23 13:01:31','YYYY-MM-DD HH24:MI:SS'),100,203956,'Y','N','D','N','N','N','Y','a7776345-3f37-4776-8d69-e57a817accfa','Y',0,'N','N','N','N')
;

-- Oct 23, 2024, 1:01:47 PM MYT
ALTER TABLE M_CostDetail ADD COLUMN Ref_CostDetail_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 23, 2024, 1:04:05 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208520,'Referenced Cost Detail',748,216888,'Y',10,320,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-10-23 13:04:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-23 13:04:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','69077bf9-6d9c-48e1-a937-b00bc5ecea1b','Y',310,2)
;

-- Oct 23, 2024, 1:06:24 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=300,Updated=TO_TIMESTAMP('2024-10-23 13:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208520
;

-- Oct 23, 2024, 1:06:38 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=290,Updated=TO_TIMESTAMP('2024-10-23 13:06:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208520
;

-- Oct 23, 2024, 1:07:54 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, IsReadOnly='Y', XPosition=1,Updated=TO_TIMESTAMP('2024-10-23 13:07:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208520
;

-- Oct 23, 2024, 1:07:55 PM MYT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2024-10-23 13:07:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12153
;

-- Oct 23, 2024, 1:07:55 PM MYT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2024-10-23 13:07:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208509
;

-- Oct 23, 2024, 1:07:55 PM MYT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2024-10-23 13:07:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58846
;

-- Oct 23, 2024, 1:07:55 PM MYT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2024-10-23 13:07:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58847
;

-- Oct 23, 2024, 1:07:56 PM MYT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2024-10-23 13:07:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58848
;

-- Oct 23, 2024, 1:07:56 PM MYT
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2024-10-23 13:07:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58849
;

-- Oct 23, 2024, 1:09:23 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=230,Updated=TO_TIMESTAMP('2024-10-23 13:09:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208520
;

-- Oct 23, 2024, 1:09:23 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=240,Updated=TO_TIMESTAMP('2024-10-23 13:09:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12153
;

-- Oct 23, 2024, 1:09:24 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=250,Updated=TO_TIMESTAMP('2024-10-23 13:09:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208509
;

-- Oct 23, 2024, 1:09:24 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=260,Updated=TO_TIMESTAMP('2024-10-23 13:09:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58846
;

-- Oct 23, 2024, 1:09:24 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=270,Updated=TO_TIMESTAMP('2024-10-23 13:09:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58847
;

-- Oct 23, 2024, 1:09:25 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=280,Updated=TO_TIMESTAMP('2024-10-23 13:09:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58848
;

-- Oct 23, 2024, 1:09:25 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=290,Updated=TO_TIMESTAMP('2024-10-23 13:09:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58849
;

