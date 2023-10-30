-- IDEMPIERE-5896
SELECT register_migration_script('202310300817_IDEMPIERE-5896.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 30, 2023, 8:17:41 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (nextidfunc(188,'N'),0,0,'Y',TO_TIMESTAMP('2023-10-30 08:17:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-30 08:17:41','YYYY-MM-DD HH24:MI:SS'),100,'JoinClause','Sql JOIN','Sql JOIN','D','2c20b363-664d-4b20-9b50-c3dd33ee915d')
;

-- Oct 30, 2023, 8:18:05 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (nextidfunc(3,'N'),0,'Sql JOIN',200216,'JoinClause',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2023-10-30 08:18:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-30 08:18:05','YYYY-MM-DD HH24:MI:SS'),100,toRecordId('AD_Element','2c20b363-664d-4b20-9b50-c3dd33ee915d'),'Y','N','D','N','N','N','Y','9e5c6dbc-4da2-4151-aaa4-ea85ae3e3987','Y',0,'N','N','N')
;

-- Oct 30, 2023, 8:18:10 AM BRT
ALTER TABLE PA_DocumentStatus ADD JoinClause VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Oct 30, 2023, 8:18:44 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (nextidfunc(188,'N'),0,0,'Y',TO_TIMESTAMP('2023-10-30 08:18:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-30 08:18:44','YYYY-MM-DD HH24:MI:SS'),100,'CountClause','Sql COUNT','Sql COUNT','U','4b87ac1b-43a2-4af0-8ce2-ec66a0c97104')
;

-- Oct 30, 2023, 8:19:10 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (nextidfunc(3,'N'),0,'Sql COUNT',200216,'CountClause',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-10-30 08:19:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-30 08:19:10','YYYY-MM-DD HH24:MI:SS'),100,toRecordId('AD_Element','4b87ac1b-43a2-4af0-8ce2-ec66a0c97104'),'Y','N','U','N','N','N','Y','7e7cae04-c653-4751-bb8b-be507e5e0d18','Y',0,'N','N','N')
;

-- Oct 30, 2023, 8:19:20 AM BRT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2023-10-30 08:19:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_UU='7e7cae04-c653-4751-bb8b-be507e5e0d18'
;

-- Oct 30, 2023, 8:19:25 AM BRT
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2023-10-30 08:19:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_UU='4b87ac1b-43a2-4af0-8ce2-ec66a0c97104'
;

-- Oct 30, 2023, 8:19:30 AM BRT
ALTER TABLE PA_DocumentStatus ADD CountClause VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Oct 30, 2023, 8:19:55 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (nextidfunc(4,'N'),'Sql JOIN',200222,toRecordId('AD_Column','9e5c6dbc-4da2-4151-aaa4-ea85ae3e3987'),'Y',2000,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-30 08:19:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-30 08:19:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e48934e6-6c93-44cb-b5e1-874bc37fc8b3','Y',190,5,3)
;

-- Oct 30, 2023, 8:19:55 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (nextidfunc(4,'N'),'Sql COUNT',200222,toRecordId('AD_Column','7e7cae04-c653-4751-bb8b-be507e5e0d18'),'Y',255,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-30 08:19:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-30 08:19:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3981af87-5ca5-4470-a7c6-fb70865fc77f','Y',200,5)
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204406
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204407
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204409
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204408
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204411
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204410
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204412
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_UU='3981af87-5ca5-4470-a7c6-fb70865fc77f'
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=1,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_UU='e48934e6-6c93-44cb-b5e1-874bc37fc8b3'
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204404
;

-- Oct 30, 2023, 8:20:22 AM BRT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-10-30 08:20:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204405
;

