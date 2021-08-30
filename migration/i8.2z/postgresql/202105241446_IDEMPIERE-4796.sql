-- IDEMPIERE-4796
-- May 24, 2021, 2:38:13 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203486,0,0,'Y',TO_TIMESTAMP('2021-05-24 14:38:13','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-05-24 14:38:13','YYYY-MM-DD HH24:MI:SS'),0,'HTMLAttachmentType','HTML Attachment Type','Define html email body processing behaviour. HTML Email body can be converted as attachment *.html file or parse images into attachment.','HTML Attachment Type','D','419fec21-afb6-4f9a-b78f-48be3a1cbcaa')
;

-- May 24, 2021, 2:40:51 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200186,'HTML Attachment Type List','L',0,0,'Y',TO_TIMESTAMP('2021-05-24 14:40:51','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-05-24 14:40:51','YYYY-MM-DD HH24:MI:SS'),0,'D','N','d907e9e1-f51c-4d32-ac85-287be286962e')
;

-- May 24, 2021, 2:41:41 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200505,'HTML as Attachment',200186,'H',0,0,'Y',TO_TIMESTAMP('2021-05-24 14:41:40','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-05-24 14:41:40','YYYY-MM-DD HH24:MI:SS'),0,'D','6a1a33f0-0150-4061-9bb9-c3ced1ba507c')
;

-- May 24, 2021, 2:42:34 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200506,'Parse Images to Attachments',200186,'I',0,0,'Y',TO_TIMESTAMP('2021-05-24 14:42:34','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-05-24 14:42:34','YYYY-MM-DD HH24:MI:SS'),0,'D','13bf37a5-821f-45d2-9931-b64a6209904b')
;

-- May 24, 2021, 2:43:33 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200342,0,0,'Y',TO_TIMESTAMP('2021-05-24 14:43:33','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2021-05-24 14:43:33','YYYY-MM-DD HH24:MI:SS'),0,'HTML Attachment Type','Define html email body processing behaviour. HTML Email body can be converted as attachment *.html file or parse images into attachment.',50012,140,17,200186,'N',1,'Y','H','HTMLAttachmentType','Y','D',203486,'b86cbb49-9fdf-47c8-af70-203e7354784c','N','N')
;

SELECT Register_Migration_Script ('202105241446_IDEMPIERE-4796.sql') FROM DUAL
;
