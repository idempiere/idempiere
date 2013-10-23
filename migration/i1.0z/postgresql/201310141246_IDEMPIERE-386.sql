-- Dec 25, 2012 10:54:46 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Description,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('DateMaterialPolicy',202184,'This field is used to record time used for LIFO and FIFO material policy','D','Time used for LIFO and FIFO Material Policy','Date  Material Policy','Date  Material Policy','b45c798f-5957-4856-bc64-979c5dd54147',0,TO_TIMESTAMP('2012-12-25 10:54:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-25 10:54:44','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 25, 2012 10:54:46 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202184 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 25, 2012 10:56:17 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,200026,208340,'D','N','N','N',0,'N',7,'N',16,'N',202184,'N','Y','913e1eca-ca35-461a-ae0d-709589cd89d5','Y','DateMaterialPolicy','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy','Date  Material Policy','Y',100,TO_TIMESTAMP('2012-12-25 10:56:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-25 10:56:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 25, 2012 10:56:17 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208340 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 25, 2012 10:56:39 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
ALTER TABLE M_StorageOnHand ADD COLUMN DateMaterialPolicy TIMESTAMP DEFAULT NULL 
;

-- Dec 25, 2012 11:17:33 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('UseGuaranteeDateForMPolicy',202185,'D','Use Guarantee Date for Material Policy','Use Guarantee Date for Material Policy','de278e48-9731-4100-bf5f-f8b74dc15807',0,TO_TIMESTAMP('2012-12-25 11:17:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-12-25 11:17:32','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Dec 25, 2012 11:17:33 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202185 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Dec 25, 2012 11:18:40 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,560,208341,'D','N','N','N',0,'N',1,'N',20,'N',202185,'N','Y','3af336ad-d7c4-4bcc-b2dd-f7f23e39bc82','Y','UseGuaranteeDateForMPolicy','N','Use Guarantee Date for Material Policy','Y',100,TO_TIMESTAMP('2012-12-25 11:18:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-25 11:18:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 25, 2012 11:18:40 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208341 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 25, 2012 11:18:47 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
ALTER TABLE M_AttributeSet ADD COLUMN UseGuaranteeDateForMPolicy CHAR(1) DEFAULT 'N' CHECK (UseGuaranteeDateForMPolicy IN ('Y','N'))
;

-- Dec 25, 2012 11:21:32 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',461,36,'N','N',60867,'Y',201616,'N','D','M_AttributeSet_UU','N','Y','a02bb9da-705d-4ee5-9ba0-8809aaca675c',100,0,TO_TIMESTAMP('2012-12-25 11:21:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-25 11:21:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 25, 2012 11:21:32 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201616 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 25, 2012 11:21:33 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',461,1,'N','N',208341,'Y',201617,'N','D','Use Guarantee Date for Material Policy','N','Y','afec456c-437d-42ff-8b92-6d764569c8e4',100,0,TO_TIMESTAMP('2012-12-25 11:21:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-25 11:21:32','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 25, 2012 11:21:33 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201617 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 25, 2012 11:22:03 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201616
;

-- Dec 25, 2012 11:22:03 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=201617
;

-- Dec 25, 2012 11:22:03 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=10419
;

-- Dec 25, 2012 11:23:29 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2012-12-25 11:23:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201617
;

-- Dec 25, 2012 11:26:29 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET ColumnSpan=2, DisplayLogic='@IsGuaranteeDate@=Y', XPosition=5,Updated=TO_TIMESTAMP('2012-12-25 11:26:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201617
;



-- Dec 25, 2012 8:12:36 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',0,762,208342,'D','N','N','N',0,'N',7,'N',16,'N',202184,'N','Y','f2ee4123-70c8-40d5-bb0a-38543c4b2522','Y','DateMaterialPolicy','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy','Date  Material Policy','Y',100,TO_TIMESTAMP('2012-12-25 20:12:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-12-25 20:12:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Dec 25, 2012 8:12:36 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208342 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Dec 25, 2012 8:13:36 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-12-25 20:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208342
;

-- Dec 25, 2012 8:13:42 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
ALTER TABLE M_InOutLineMA ADD COLUMN DateMaterialPolicy TIMESTAMP DEFAULT NULL 
;

UPDATE M_InOutLineMA SET DateMaterialPolicy = (SELECT Date(io.MovementDate) FROM M_InOut io JOIN M_InOutLine iol ON (io.M_InOut_ID=iol.M_InOut_ID) WHERE iol.M_InOutLine_ID=M_InOutLineMA.M_InOutLine_ID) WHERE DateMaterialPolicy IS NULL
;

ALTER TABLE M_InOutLineMA ALTER COLUMN DateMaterialPolicy SET NOT NULL
;

ALTER TABLE M_InOutLineMA DROP CONSTRAINT m_inoutlinema_pkey
;

ALTER TABLE M_InOutLineMA ADD CONSTRAINT m_inoutlinema_pkey PRIMARY KEY(m_inoutline_id, m_attributesetinstance_id, datematerialpolicy)
;

-- Dec 25, 2012 8:14:10 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',751,7,'N','N',208342,'Y',201618,'N','This field is used to record time used for LIFO and FIFO material policy','D','Time used for LIFO and FIFO Material Policy','Date  Material Policy','N','Y','c489cb75-8f36-4818-a77c-a30ba8ae5ac2',100,0,TO_TIMESTAMP('2012-12-25 20:14:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-25 20:14:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 25, 2012 8:14:10 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201618 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 25, 2012 8:14:11 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',751,36,'N','N',60900,'Y',201619,'N','D','M_InOutLineMA_UU','N','Y','74956b1b-7def-46f8-a9a5-eeb0575fe4bb',100,0,TO_TIMESTAMP('2012-12-25 20:14:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-12-25 20:14:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Dec 25, 2012 8:14:11 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201619 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Dec 25, 2012 8:16:53 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201619
;

-- Dec 25, 2012 8:16:53 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201618
;

-- Dec 25, 2012 8:17:04 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=12195
;

-- Dec 25, 2012 8:17:04 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201619
;

-- Dec 25, 2012 8:17:04 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=12197
;

-- Dec 25, 2012 8:17:04 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=12198
;

-- Dec 25, 2012 8:17:04 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=12194
;

-- Dec 25, 2012 8:17:04 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=12196
;

-- Dec 25, 2012 8:17:04 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201618
;


-- Jul 16, 2013 10:14:03 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType,AD_Element_ID) VALUES (0,'N',0,764,210651,'N','N','N',0,'N',7,'N',16,'N','N','Y','b261acf8-ab20-4532-ad4e-fd1f122231cf','Y','DateMaterialPolicy','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy','Date  Material Policy','Y',100,TO_TIMESTAMP('2013-07-16 10:14:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-07-16 10:14:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N',0,'D',202184)
;

-- Jul 16, 2013 10:14:04 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210651 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 16, 2013 10:14:26 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
ALTER TABLE M_MovementLineMA ADD COLUMN DateMaterialPolicy TIMESTAMP DEFAULT NULL 
;

UPDATE M_MovementLineMA SET DateMaterialPolicy = (SELECT Date(m.MovementDate) FROM M_Movement m JOIN M_MovementLine ml ON (m.M_Movement_ID=ml.M_Movement_ID) WHERE ml.M_MovementLine_ID=M_MovementLineMA.M_MovementLine_ID) WHERE DateMaterialPolicy IS NULL
;

ALTER TABLE M_MovementLineMA ALTER COLUMN DateMaterialPolicy SET NOT NULL
;

ALTER TABLE M_MovementLineMA DROP CONSTRAINT m_movementlinema_pkey
;

ALTER TABLE M_MovementLineMA ADD CONSTRAINT m_movementlinema_pkey PRIMARY KEY(m_movementline_id, m_attributesetinstance_id, datematerialpolicy)
;

-- Jul 16, 2013 10:18:20 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',750,36,'N','N',60914,60,'Y',202287,'N','M_MovementLineMA_UU','N','N','33f63b7c-5503-4f61-a18d-7ba082506da0',100,0,TO_TIMESTAMP('2013-07-16 10:18:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-16 10:18:19','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 16, 2013 10:18:20 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202287 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 16, 2013 10:18:21 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',750,7,'N','N',210651,70,'Y',202288,'N','This field is used to record time used for LIFO and FIFO material policy','Time used for LIFO and FIFO Material Policy','Date  Material Policy','N','Y','c1bdc238-1b5a-4d3e-b321-86b285dd9a12',100,0,TO_TIMESTAMP('2013-07-16 10:18:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-16 10:18:20','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 16, 2013 10:18:21 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202288 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 16, 2013 10:19:33 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-16 10:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12188
;

-- Jul 16, 2013 10:19:33 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-07-16 10:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12191
;

-- Jul 16, 2013 10:19:33 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2013-07-16 10:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202288
;

-- Jul 16, 2013 10:19:33 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2013-07-16 10:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202287
;

-- Jul 16, 2013 10:20:08 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-16 10:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202288
;

-- Jul 16, 2013 10:21:06 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-16 10:21:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12194
;

-- Jul 16, 2013 10:21:06 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-07-16 10:21:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12196
;

-- Jul 16, 2013 10:21:06 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-16 10:21:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201618
;



-- Jul 16, 2013 11:33:25 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType,AD_Element_ID) VALUES (0,'N',0,763,210653,'N','N','N',0,'N',7,'N',16,'N','N','Y','b14bae38-065a-4daa-9ad5-94b96062e511','Y','DateMaterialPolicy','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy','Date  Material Policy','Y',100,TO_TIMESTAMP('2013-07-16 11:33:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-07-16 11:33:24','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N',0,'D',202184)
;

-- Jul 16, 2013 11:33:25 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210653 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 16, 2013 11:35:42 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2013-07-16 11:35:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210653
;

-- Jul 16, 2013 11:35:52 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
ALTER TABLE M_InventoryLineMA ADD COLUMN DateMaterialPolicy TIMESTAMP DEFAULT NULL 
;

UPDATE M_InventoryLineMA SET DateMaterialPolicy = (SELECT Date(i.MovementDate) FROM M_Inventory i JOIN M_InventoryLine il ON (i.M_Inventory_ID=il.M_Inventory_ID) WHERE il.M_InventoryLine_ID=M_InventoryLineMA.M_InventoryLine_ID) WHERE DateMaterialPolicy IS NULL
;

ALTER TABLE M_InventoryLineMA ALTER COLUMN DateMaterialPolicy SET NOT NULL
;

ALTER TABLE M_InventoryLineMA DROP CONSTRAINT m_inventorylinema_pkey
;

ALTER TABLE M_InventoryLineMA ADD CONSTRAINT m_inventorylinema_pkey PRIMARY KEY(m_inventoryline_id, m_attributesetinstance_id, datematerialpolicy)
;

-- Jul 16, 2013 11:36:10 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',749,36,'N','N',60903,60,'Y',202289,'N','M_InventoryLineMA_UU','N','N','a3609970-e680-491b-a608-100617e5eb64',100,0,TO_TIMESTAMP('2013-07-16 11:36:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-16 11:36:09','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 16, 2013 11:36:10 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202289 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 16, 2013 11:36:11 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',749,7,'N','N',210653,70,'Y',202290,'N','This field is used to record time used for LIFO and FIFO material policy','Time used for LIFO and FIFO Material Policy','Date  Material Policy','N','Y','4318813a-f3e7-43d6-a795-7682a2b37fd6',100,0,TO_TIMESTAMP('2013-07-16 11:36:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-16 11:36:10','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 16, 2013 11:36:11 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202290 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 16, 2013 11:36:34 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-16 11:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12182
;

-- Jul 16, 2013 11:36:34 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-07-16 11:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12184
;

-- Jul 16, 2013 11:36:34 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-16 11:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202290
;

-- Jul 16, 2013 11:36:34 AM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2013-07-16 11:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202289
;

-- Jul 17, 2013 4:07:09 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',321,36,'N','N',60929,130,'Y',202335,'N','M_ProductionLine_UU','N','N','976abb9e-bb13-4a15-a379-e74764a407f0',100,0,TO_TIMESTAMP('2013-07-17 16:07:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 16:07:08','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 17, 2013 4:07:09 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202335 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 17, 2013 4:09:07 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted,AD_Client_ID,EntityType,AD_Element_ID) VALUES (0,'N',0,765,210658,'N','N','N',0,'N',7,'N',16,'N','N','Y','7834c3ff-8c66-441c-bc49-9430e9861db2','Y','DateMaterialPolicy','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy','Date  Material Policy','Y',100,TO_TIMESTAMP('2013-07-17 16:09:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-07-17 16:09:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N',0,'D',202184)
;

-- Jul 17, 2013 4:09:07 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210658 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 17, 2013 4:09:17 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
ALTER TABLE M_ProductionLineMA ADD COLUMN DateMaterialPolicy TIMESTAMP DEFAULT NULL 
;

UPDATE M_ProductionLineMA SET DateMaterialPolicy = (SELECT Date(p.MovementDate) FROM M_Production p JOIN M_ProductionLine pl ON (p.M_Production_ID=pl.M_Production_ID) WHERE pl.M_ProductionLine_ID=M_ProductionLineMA.M_ProductionLine_ID) WHERE DateMaterialPolicy IS NULL
;

ALTER TABLE M_ProductionLineMA ALTER COLUMN DateMaterialPolicy SET NOT NULL
;

ALTER TABLE M_ProductionLineMA DROP CONSTRAINT m_productionlinema_pkey
;

ALTER TABLE M_ProductionLineMA ADD CONSTRAINT m_productionlinema_pkey PRIMARY KEY(m_productionline_id, m_attributesetinstance_id, datematerialpolicy)
;

ALTER TABLE m_storageonhand DROP CONSTRAINT m_storageonhand_pkey
;


Update M_StorageOnHand SET DateMaterialPolicy = Date(Created)
;

-- Aug 3, 2013 2:45:42 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-08-03 14:45:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208340
;

-- Aug 3, 2013 2:46:05 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO t_alter_column values('m_storageonhand','DateMaterialPolicy','TIMESTAMP',null,null)
;

-- Aug 3, 2013 2:46:05 PM IST
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO t_alter_column values('m_storageonhand','DateMaterialPolicy',null,'NOT NULL',null)
;

ALTER TABLE M_StorageOnHand ADD CONSTRAINT m_storageonhand_pkey PRIMARY KEY (m_product_id , m_locator_id , m_attributesetinstance_id, DateMaterialPolicy )
;

CREATE OR REPLACE VIEW m_storage
AS
  SELECT s.m_product_id,
         s.m_locator_id,
         s.ad_client_id,
         s.ad_org_id,
         s.isactive,
         s.created,
         s.createdby,
         s.updated,
         s.updatedby,
         s.qtyonhand,
         0 AS qtyreserved,
         0 AS qtyordered,
         s.datelastinventory,
         s.m_attributesetinstance_id,
         s.m_storageonhand_uu AS m_storage_uu,
         s.datematerialpolicy AS datematerialpolicy
  FROM   m_storageonhand s
  UNION
  SELECT sr.m_product_id,
         w.m_reservelocator_id AS m_locator_id,
         sr.ad_client_id,
         sr.ad_org_id,
         sr.isactive,
         sr.created,
         sr.createdby,
         sr.updated,
         sr.updatedby,
         0                     AS qtyonhand,
         sr.qty                AS qtyreserved,
         0                     AS qtyordered,
         sr.datelastinventory,
         sr.m_attributesetinstance_id,
         sr.m_storagereservation_uu AS m_storage_uu,
         null as datematerialpolicy
  FROM   m_storagereservation sr
         JOIN m_warehouse w
           ON sr.m_warehouse_id = w.m_warehouse_id
  WHERE  sr.issotrx = 'Y' and sr.qty <> 0
  UNION
  SELECT so.m_product_id,
         w.m_reservelocator_id AS m_locator_id,
         so.ad_client_id,
         so.ad_org_id,
         so.isactive,
         so.created,
         so.createdby,
         so.updated,
         so.updatedby,
         0                     AS qtyonhand,
         0                     AS qtyreserved,
         so.qty                AS qtyordered,
         so.datelastinventory,
         so.m_attributesetinstance_id,
         so.m_storagereservation_uu AS m_storage_uu,
         null as datematerialpolicy
  FROM   m_storagereservation so
         JOIN m_warehouse w
           ON so.m_warehouse_id = w.m_warehouse_id
  WHERE  so.issotrx = 'N' and so.qty <> 0
;

-- Oct 16, 2013 5:48:19 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,250,1003519,'N','N','N',0,'N',7,'N',16,'N','N','N','e7fac848-ba58-41ac-81f3-bac9f3c81e62','N','DateMaterialPolicy','Time used for LIFO and FIFO Material Policy','This field is used to record time used for LIFO and FIFO material policy','Date  Material Policy','N',TO_TIMESTAMP('2013-10-16 17:48:19','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-10-16 17:48:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202184,'N')
;

-- Oct 16, 2013 5:48:56 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,EntityType,IsAdvancedField,IsDefaultFocus) VALUES (0,'N',53244,0,'N','N',1003519,110,'Y',1002071,'N','This field is used to record time used for LIFO and FIFO material policy','Time used for LIFO and FIFO Material Policy','Date  Material Policy','cf628432-e15e-47fe-af1d-9803f5b155b8','Y','N',100,0,TO_TIMESTAMP('2013-10-16 17:48:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-16 17:48:56','YYYY-MM-DD HH24:MI:SS'),'Y','Y',110,1,'N',0,2,1,'D','N','N')
;

-- Oct 16, 2013 5:49:35 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-10-16 17:49:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1002071
;

-- Oct 16, 2013 5:49:35 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2013-10-16 17:49:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57394
;

-- Oct 16, 2013 5:49:35 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2013-10-16 17:49:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57393
;

-- Oct 16, 2013 5:49:35 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2013-10-16 17:49:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57395
;

-- Oct 16, 2013 5:49:35 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2013-10-16 17:49:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57396
;

-- Oct 16, 2013 5:49:35 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2013-10-16 17:49:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57399
;

-- Oct 16, 2013 5:50:26 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=60,Updated=TO_TIMESTAMP('2013-10-16 17:50:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1002071
;

-- Oct 16, 2013 5:50:35 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=70,Updated=TO_TIMESTAMP('2013-10-16 17:50:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57394
;

-- Oct 16, 2013 5:50:44 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=80,Updated=TO_TIMESTAMP('2013-10-16 17:50:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57393
;

-- Oct 16, 2013 5:50:53 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=90,Updated=TO_TIMESTAMP('2013-10-16 17:50:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57395
;

-- Oct 16, 2013 5:51:03 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=100,Updated=TO_TIMESTAMP('2013-10-16 17:51:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57396
;

-- Oct 16, 2013 5:51:14 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Field SET SeqNoGrid=110,Updated=TO_TIMESTAMP('2013-10-16 17:51:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57399
;

-- Oct 16, 2013 8:01:34 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET AD_Reference_ID=15,Updated=TO_TIMESTAMP('2013-10-16 20:01:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208340
;

-- Oct 16, 2013 8:03:45 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET AD_Reference_ID=15,Updated=TO_TIMESTAMP('2013-10-16 20:03:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208342
;

-- Oct 16, 2013 8:04:25 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET AD_Reference_ID=15,Updated=TO_TIMESTAMP('2013-10-16 20:04:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210653
;

-- Oct 16, 2013 8:05:02 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET AD_Reference_ID=15,Updated=TO_TIMESTAMP('2013-10-16 20:05:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210651
;

-- Oct 16, 2013 8:05:35 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET AD_Reference_ID=15,Updated=TO_TIMESTAMP('2013-10-16 20:05:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210658
;

-- Oct 16, 2013 8:06:41 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET AD_Reference_ID=15,Updated=TO_TIMESTAMP('2013-10-16 20:06:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1003519
;

-- Oct 17, 2013 4:05:31 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2013-10-17 16:05:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208340
;

-- Oct 17, 2013 4:06:52 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2013-10-17 16:06:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208342
;

-- Oct 17, 2013 4:07:28 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2013-10-17 16:07:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210653
;

-- Oct 17, 2013 4:08:06 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2013-10-17 16:08:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210651
;

-- Oct 17, 2013 4:09:51 PM MYT
-- IDEMPIERE-386 Redesign ASI usage for FIFO
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2013-10-17 16:09:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210658
;

SELECT register_migration_script('201310141246_IDEMPIERE-386.sql') FROM dual
;
