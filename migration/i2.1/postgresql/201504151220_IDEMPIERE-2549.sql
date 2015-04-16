update ad_process_para set seqno=seqno+1000 where ad_process_id=53161 and seqno>=80;

update ad_process_para set seqno=seqno-990 where ad_process_id=53161 and seqno>=1080;

-- IDEMPIERE-2549 Password rule break Initial Client Setup
-- Apr 15, 2015 12:17:41 PM COT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202876,0,0,'Y',TO_TIMESTAMP('2015-04-15 12:17:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-15 12:17:40','YYYY-MM-DD HH24:MI:SS'),100,'IsSetInitialPassword','IsSetInitialPassword','IsSetInitialPassword','D','0e03fdbc-cb25-4705-bbd8-4442b02563af')
;

-- Apr 15, 2015 12:17:58 PM COT
UPDATE AD_Element SET Name='Set Initial Password', PrintName='Set Initial Password',Updated=TO_TIMESTAMP('2015-04-15 12:17:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202876
;

-- Apr 15, 2015 12:17:58 PM COT
UPDATE AD_Column SET ColumnName='IsSetInitialPassword', Name='Set Initial Password', Description=NULL, Help=NULL WHERE AD_Element_ID=202876
;

-- Apr 15, 2015 12:17:58 PM COT
UPDATE AD_Process_Para SET ColumnName='IsSetInitialPassword', Name='Set Initial Password', Description=NULL, Help=NULL, AD_Element_ID=202876 WHERE UPPER(ColumnName)='ISSETINITIALPASSWORD' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 15, 2015 12:17:58 PM COT
UPDATE AD_Process_Para SET ColumnName='IsSetInitialPassword', Name='Set Initial Password', Description=NULL, Help=NULL WHERE AD_Element_ID=202876 AND IsCentrallyMaintained='Y'
;

-- Apr 15, 2015 12:17:58 PM COT
UPDATE AD_InfoColumn SET ColumnName='IsSetInitialPassword', Name='Set Initial Password', Description=NULL, Help=NULL WHERE AD_Element_ID=202876 AND IsCentrallyMaintained='Y'
;

-- Apr 15, 2015 12:17:58 PM COT
UPDATE AD_Field SET Name='Set Initial Password', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202876) AND IsCentrallyMaintained='Y'
;

-- Apr 15, 2015 12:17:58 PM COT
UPDATE AD_PrintFormatItem SET PrintName='Set Initial Password', Name='Set Initial Password' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202876)
;

-- Apr 15, 2015 12:18:34 PM COT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200132,0,0,'Y',TO_TIMESTAMP('2015-04-15 12:18:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-15 12:18:34','YYYY-MM-DD HH24:MI:SS'),100,'Set Initial Password',53161,80,20,'N',1,'Y','Y','IsSetInitialPassword','Y','D',202876,'54bfb648-044e-47d3-b232-bb61a4632772','N')
;

-- Apr 15, 2015 12:19:10 PM COT
UPDATE AD_Process SET IsActive='N',Updated=TO_TIMESTAMP('2015-04-15 12:19:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=288
;

-- Apr 15, 2015 12:36:59 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Force change on next login',0,0,'Y',TO_TIMESTAMP('2015-04-15 12:36:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-04-15 12:36:59','YYYY-MM-DD HH24:MI:SS'),100,200349,'ForceChangeOnNextLogin','D','ef609a89-2d65-44f8-8aaf-4a29854510c9')
;

SELECT register_migration_script('201504151220_IDEMPIERE-2549.sql') FROM dual
;

