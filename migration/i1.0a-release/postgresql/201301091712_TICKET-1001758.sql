-- Jan 9, 2013 3:45:58 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsIdentifier='Y', IsSelectionColumn='Y', ColumnSQL=NULL,Updated=TO_TIMESTAMP('2013-01-09 15:45:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202144
;

-- Jan 9, 2013 3:46:03 PM SGT
-- Ticket 1001758: FedEx & UPS
ALTER TABLE M_Shipper ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

-- Jan 9, 2013 3:46:48 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsIdentifier='Y', IsSelectionColumn='Y', ColumnSQL=NULL,Updated=TO_TIMESTAMP('2013-01-09 15:46:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202148
;

-- Jan 9, 2013 3:46:51 PM SGT
-- Ticket 1001758: FedEx & UPS
ALTER TABLE M_ShipperLabels ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

-- Jan 9, 2013 3:47:11 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsIdentifier='Y', IsSelectionColumn='Y', ColumnSQL=NULL,Updated=TO_TIMESTAMP('2013-01-09 15:47:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202147
;

-- Jan 9, 2013 3:47:14 PM SGT
-- Ticket 1001758: FedEx & UPS
ALTER TABLE M_ShipperPackaging ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

-- Jan 9, 2013 3:47:42 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsIdentifier='Y', IsSelectionColumn='Y', ColumnSQL=NULL,Updated=TO_TIMESTAMP('2013-01-09 15:47:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202149
;

-- Jan 9, 2013 3:47:44 PM SGT
-- Ticket 1001758: FedEx & UPS
ALTER TABLE M_ShipperPickupTypes ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

-- Jan 9, 2013 3:48:04 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsIdentifier='Y', IsSelectionColumn='Y', ColumnSQL=NULL,Updated=TO_TIMESTAMP('2013-01-09 15:48:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202146
;

-- Jan 9, 2013 3:48:07 PM SGT
-- Ticket 1001758: FedEx & UPS
ALTER TABLE M_ShippingProcessor ADD COLUMN Name VARCHAR(60) DEFAULT NULL 
;

UPDATE M_Shipper ms SET Name = (
SELECT xs.Name 
FROM X_Shipper xs 
WHERE xs.X_Shipper_ID=ms.X_Shipper_ID)
WHERE ms.X_Shipper_ID > 0
AND ms.Name IS NULL;

UPDATE M_ShipperLabels ms SET Name = (
SELECT xs.Name 
FROM X_ShipperLabels xs 
WHERE xs.X_ShipperLabels_ID=ms.X_ShipperLabels_ID)
WHERE ms.X_ShipperLabels_ID > 0
AND ms.Name IS NULL;

UPDATE M_ShipperPackaging ms SET Name = (
SELECT xs.Name 
FROM X_ShipperPackaging xs 
WHERE xs.X_ShipperPackaging_ID=ms.X_ShipperPackaging_ID)
WHERE ms.X_ShipperPackaging_ID > 0
AND ms.Name IS NULL;

UPDATE M_ShipperPickupTypes ms SET Name = (
SELECT xs.Name 
FROM X_ShipperPickupTypes xs 
WHERE xs.X_ShipperPickupTypes_ID=ms.X_ShipperPickupTypes_ID)
WHERE ms.X_ShipperPickupTypes_ID > 0
AND ms.Name IS NULL;

UPDATE M_ShippingProcessor ms SET Name = (
SELECT xs.Name 
FROM X_ShippingProcessor xs 
WHERE xs.X_ShippingProcessor_ID=ms.X_ShippingProcessor_ID)
WHERE ms.X_ShippingProcessor_ID > 0
AND ms.Name IS NULL;

-- Jan 9, 2013 3:55:29 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-01-09 15:55:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202144
;

-- Jan 9, 2013 3:55:31 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipper','Name','VARCHAR(60)',null,null)
;

-- Jan 9, 2013 3:55:31 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipper','Name',null,'NOT NULL',null)
;

-- Jan 9, 2013 3:55:42 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-01-09 15:55:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202148
;

-- Jan 9, 2013 3:55:46 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipperlabels','Name','VARCHAR(60)',null,null)
;

-- Jan 9, 2013 3:55:46 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipperlabels','Name',null,'NOT NULL',null)
;

-- Jan 9, 2013 3:55:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-01-09 15:55:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202147
;

-- Jan 9, 2013 3:55:55 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipperpackaging','Name','VARCHAR(60)',null,null)
;

-- Jan 9, 2013 3:55:55 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipperpackaging','Name',null,'NOT NULL',null)
;

-- Jan 9, 2013 3:56:04 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipperpickuptypes','Name','VARCHAR(60)',null,'NULL')
;

-- Jan 9, 2013 3:56:08 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-01-09 15:56:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202149
;

-- Jan 9, 2013 3:56:09 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipperpickuptypes','Name','VARCHAR(60)',null,null)
;

-- Jan 9, 2013 3:56:09 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shipperpickuptypes','Name',null,'NOT NULL',null)
;

-- Jan 9, 2013 3:56:19 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-01-09 15:56:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202146
;

-- Jan 9, 2013 3:56:20 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shippingprocessor','Name','VARCHAR(60)',null,null)
;

-- Jan 9, 2013 3:56:20 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO t_alter_column values('m_shippingprocessor','Name',null,'NOT NULL',null)
;

-- Jan 9, 2013 3:59:04 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200036,60,'N','N',202146,'Y',201647,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','N','Y','200b96dd-069f-4e2b-8aad-b4295784ac28',100,0,TO_TIMESTAMP('2013-01-09 15:59:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-09 15:59:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 9, 2013 3:59:05 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201647 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 9, 2013 3:59:13 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201647
;

-- Jan 9, 2013 3:59:13 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200954
;

-- Jan 9, 2013 3:59:13 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200971
;

-- Jan 9, 2013 3:59:13 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200956
;

-- Jan 9, 2013 3:59:13 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200957
;

-- Jan 9, 2013 3:59:17 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201647
;

-- Jan 9, 2013 3:59:17 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200954
;

-- Jan 9, 2013 3:59:17 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200971
;

-- Jan 9, 2013 3:59:17 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200956
;

-- Jan 9, 2013 3:59:17 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200957
;

-- Jan 9, 2013 4:00:35 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201503
;

-- Jan 9, 2013 4:00:35 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=1074
;

-- Jan 9, 2013 4:00:35 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=2588
;

-- Jan 9, 2013 4:00:35 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200953
;

-- Jan 9, 2013 4:00:35 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201502
;

-- Jan 9, 2013 4:00:43 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201503
;

-- Jan 9, 2013 4:00:43 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=1074
;

-- Jan 9, 2013 4:00:43 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=2588
;

-- Jan 9, 2013 4:00:43 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200953
;

-- Jan 9, 2013 4:00:43 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201502
;

-- Jan 9, 2013 4:01:10 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200037,60,'N','N',202147,'Y',201648,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','N','Y','e6ecb888-b63b-4fc0-96d7-48091fd3cd57',100,0,TO_TIMESTAMP('2013-01-09 16:01:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-09 16:01:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 9, 2013 4:01:10 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201648 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 9, 2013 4:01:14 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200038,60,'N','N',202148,'Y',201649,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','N','Y','71923594-97e9-47a5-b997-6e74066a988b',100,0,TO_TIMESTAMP('2013-01-09 16:01:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-09 16:01:13','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 9, 2013 4:01:14 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201649 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 9, 2013 4:01:18 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200039,60,'N','N',202149,'Y',201650,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','N','Y','46e611b6-75d4-4e31-8e07-41e879a57ca0',100,0,TO_TIMESTAMP('2013-01-09 16:01:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-09 16:01:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 9, 2013 4:01:18 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201650 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 9, 2013 4:01:30 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201650
;

-- Jan 9, 2013 4:01:30 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200995
;

-- Jan 9, 2013 4:01:30 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200997
;

-- Jan 9, 2013 4:01:36 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201650
;

-- Jan 9, 2013 4:01:36 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200995
;

-- Jan 9, 2013 4:01:36 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200997
;

-- Jan 9, 2013 4:01:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201649
;

-- Jan 9, 2013 4:01:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200982
;

-- Jan 9, 2013 4:01:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200987
;

-- Jan 9, 2013 4:01:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200984
;

-- Jan 9, 2013 4:01:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201649
;

-- Jan 9, 2013 4:01:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200982
;

-- Jan 9, 2013 4:01:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200987
;

-- Jan 9, 2013 4:01:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200984
;

-- Jan 9, 2013 4:02:00 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201648
;

-- Jan 9, 2013 4:02:00 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200972
;

-- Jan 9, 2013 4:02:00 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201346
;

-- Jan 9, 2013 4:02:00 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200974
;

-- Jan 9, 2013 4:02:03 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201648
;

-- Jan 9, 2013 4:02:03 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200972
;

-- Jan 9, 2013 4:02:03 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201346
;

-- Jan 9, 2013 4:02:03 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200974
;

-- Jan 9, 2013 4:03:37 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-01-09 16:03:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201503
;

-- Jan 9, 2013 4:03:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-01-09 16:03:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201648
;

-- Jan 9, 2013 4:03:59 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-01-09 16:03:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201649
;

-- Jan 9, 2013 4:04:07 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-01-09 16:04:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201650
;

-- Jan 9, 2013 4:04:59 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-01-09 16:04:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201647
;

-- Jan 9, 2013 4:07:08 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET DisplayLogic='@X_Shipper_ID@>0',Updated=TO_TIMESTAMP('2013-01-09 16:07:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201502
;

-- Jan 9, 2013 4:09:32 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2013-01-09 16:09:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202147
;

-- Jan 9, 2013 4:09:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2013-01-09 16:09:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202144
;

-- Jan 9, 2013 4:09:59 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2013-01-09 16:09:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202148
;

-- Jan 9, 2013 4:10:23 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2013-01-09 16:10:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202149
;

-- Jan 9, 2013 4:10:31 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2013-01-09 16:10:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202146
;

-- Jan 9, 2013 4:12:06 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2013-01-09 16:12:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200995
;

-- Jan 9, 2013 4:12:09 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2013-01-09 16:12:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200997
;

-- Jan 9, 2013 4:12:53 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET IsSameLine='N', XPosition=2,Updated=TO_TIMESTAMP('2013-01-09 16:12:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200982
;

-- Jan 9, 2013 4:13:07 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET IsSameLine='N', XPosition=2,Updated=TO_TIMESTAMP('2013-01-09 16:13:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200972
;

-- Jan 9, 2013 4:13:30 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2013-01-09 16:13:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200995
;

-- Jan 9, 2013 4:16:13 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200984
;

-- Jan 9, 2013 4:16:13 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200987
;

-- Jan 9, 2013 4:16:17 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200984
;

-- Jan 9, 2013 4:16:17 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200987
;

-- Jan 9, 2013 4:16:30 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET IsSameLine='Y', XPosition=5,Updated=TO_TIMESTAMP('2013-01-09 16:16:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200984
;

-- Jan 9, 2013 4:16:36 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-01-09 16:16:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200997
;

-- Jan 9, 2013 4:16:44 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200974
;

-- Jan 9, 2013 4:16:44 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201346
;

-- Jan 9, 2013 4:16:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200974
;

-- Jan 9, 2013 4:16:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201346
;

-- Jan 9, 2013 4:16:58 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET IsSameLine='Y', XPosition=5,Updated=TO_TIMESTAMP('2013-01-09 16:16:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200974
;

-- Jan 9, 2013 4:34:48 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET Callout='org.compiere.model.CalloutShippingProcessor.shippingProcessor',Updated=TO_TIMESTAMP('2013-01-09 16:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202139
;

-- Jan 9, 2013 4:43:33 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('X_ShipperLabels_ID IN (SELECT X_ShipperLabels_ID FROM X_ShipperLabels WHERE X_Shipper_ID IN (SELECT X_Shipper_ID FROM M_Shipper WHERE M_Shipper_ID=@M_Shipper_ID@)',200020,'D','M_ShipperLabels X_ShipperLabels_ID','S','9f005c77-9ba4-4f6a-a1c7-3da9c0bb42f1',100,100,TO_TIMESTAMP('2013-01-09 16:43:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-09 16:43:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Jan 9, 2013 4:43:43 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET AD_Val_Rule_ID=200020,Updated=TO_TIMESTAMP('2013-01-09 16:43:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202142
;

-- Jan 9, 2013 4:46:38 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Val_Rule SET Code='X_ShipperLabels.X_ShipperLabels_ID IN (SELECT X_ShipperLabels_ID FROM X_ShipperLabels WHERE X_Shipper_ID IN (SELECT X_Shipper_ID FROM M_Shipper WHERE M_Shipper_ID=@M_Shipper_ID@))',Updated=TO_TIMESTAMP('2013-01-09 16:46:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200020
;

-- Jan 9, 2013 4:47:52 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('X_ShipperPackaging.X_ShipperPackaging_ID IN (SELECT X_ShipperPackaging_ID FROM X_ShipperPackaging WHERE X_Shipper_ID IN (SELECT X_Shipper_ID FROM M_Shipper WHERE M_Shipper_ID=@M_Shipper_ID@))',200021,'D','M_ShipperPackaging X_ShipperPackaging_ID','S','0eda1648-695c-40e0-b421-d2fb0077c672',100,100,TO_TIMESTAMP('2013-01-09 16:47:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-09 16:47:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Jan 9, 2013 4:47:59 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET AD_Val_Rule_ID=200021,Updated=TO_TIMESTAMP('2013-01-09 16:47:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202141
;

-- Jan 9, 2013 4:48:39 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('X_ShipperPickupTypes.X_ShipperPickupTypes_ID IN (SELECT X_ShipperPickupTypes_ID FROM X_ShipperPickupTypes WHERE X_Shipper_ID IN (SELECT X_Shipper_ID FROM M_Shipper WHERE M_Shipper_ID=@M_Shipper_ID@))',200022,'D','M_ShipperPickupTypes X_ShipperPickupTypes_ID','S','7eb82600-c4ef-41c2-9205-4015b9b15e9c',100,100,TO_TIMESTAMP('2013-01-09 16:48:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-09 16:48:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Jan 9, 2013 4:48:45 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET AD_Val_Rule_ID=200022,Updated=TO_TIMESTAMP('2013-01-09 16:48:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=202143
;

SELECT register_migration_script('201301091712_TICKET-1001758.sql') FROM dual
;