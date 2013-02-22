-- Feb 22, 2013 3:02:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element SET Name='Shipper Configuration', PrintName='Shipper Configuration',Updated=TO_DATE('2013-02-22 15:02:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200601
;

-- Feb 22, 2013 3:02:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200601
;

-- Feb 22, 2013 3:02:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET ColumnName='X_Shipper_ID', Name='Shipper Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200601
;

-- Feb 22, 2013 3:02:15 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_Shipper_ID', Name='Shipper Configuration', Description=NULL, Help=NULL, AD_Element_ID=200601 WHERE UPPER(ColumnName)='X_SHIPPER_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 22, 2013 3:02:15 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_Shipper_ID', Name='Shipper Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200601 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:02:15 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_InfoColumn SET ColumnName='X_Shipper_ID', Name='Shipper Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200601 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:02:15 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET Name='Shipper Configuration', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200601) AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:02:17 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_PrintFormatItem pi SET PrintName='Shipper Configuration', Name='Shipper Configuration' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200601)
;

-- Feb 22, 2013 3:03:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element SET Name='Shipper Labels Configuration', PrintName='Shipper Labels Configuration',Updated=TO_DATE('2013-02-22 15:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200603
;

-- Feb 22, 2013 3:03:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200603
;

-- Feb 22, 2013 3:03:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET ColumnName='X_ShipperLabels_ID', Name='Shipper Labels Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200603
;

-- Feb 22, 2013 3:03:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_ShipperLabels_ID', Name='Shipper Labels Configuration', Description=NULL, Help=NULL, AD_Element_ID=200603 WHERE UPPER(ColumnName)='X_SHIPPERLABELS_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 22, 2013 3:03:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_ShipperLabels_ID', Name='Shipper Labels Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200603 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_InfoColumn SET ColumnName='X_ShipperLabels_ID', Name='Shipper Labels Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200603 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET Name='Shipper Labels Configuration', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200603) AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:47 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_PrintFormatItem pi SET PrintName='Shipper Labels Configuration', Name='Shipper Labels Configuration' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200603)
;

-- Feb 22, 2013 3:03:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element SET Name='Shipper Packaging Configuration', PrintName='Shipper Packaging Configuration',Updated=TO_DATE('2013-02-22 15:03:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200605
;

-- Feb 22, 2013 3:03:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200605
;

-- Feb 22, 2013 3:03:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET ColumnName='X_ShipperPackaging_ID', Name='Shipper Packaging Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200605
;

-- Feb 22, 2013 3:03:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_ShipperPackaging_ID', Name='Shipper Packaging Configuration', Description=NULL, Help=NULL, AD_Element_ID=200605 WHERE UPPER(ColumnName)='X_SHIPPERPACKAGING_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 22, 2013 3:03:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_ShipperPackaging_ID', Name='Shipper Packaging Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200605 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_InfoColumn SET ColumnName='X_ShipperPackaging_ID', Name='Shipper Packaging Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200605 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET Name='Shipper Packaging Configuration', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200605) AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_PrintFormatItem pi SET PrintName='Shipper Packaging Configuration', Name='Shipper Packaging Configuration' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200605)
;

-- Feb 22, 2013 3:03:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element SET Name='Shipper Pickup Types Configuration', PrintName='Shipper Pickup Types Configuration',Updated=TO_DATE('2013-02-22 15:03:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200607
;

-- Feb 22, 2013 3:03:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200607
;

-- Feb 22, 2013 3:03:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET ColumnName='X_ShipperPickupTypes_ID', Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200607
;

-- Feb 22, 2013 3:03:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_ShipperPickupTypes_ID', Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL, AD_Element_ID=200607 WHERE UPPER(ColumnName)='X_SHIPPERPICKUPTYPES_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 22, 2013 3:03:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_ShipperPickupTypes_ID', Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200607 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_InfoColumn SET ColumnName='X_ShipperPickupTypes_ID', Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200607 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET Name='Shipper Pickup Types Configuration', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200607) AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:03:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_PrintFormatItem pi SET PrintName='Shipper Pickup Types Configuration', Name='Shipper Pickup Types Configuration' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200607)
;

-- Feb 22, 2013 3:04:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element SET Name='Shipping Processor Configuration', PrintName='Shipping Processor Configuration',Updated=TO_DATE('2013-02-22 15:04:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200599
;

-- Feb 22, 2013 3:04:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200599
;

-- Feb 22, 2013 3:04:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Column SET ColumnName='X_ShippingProcessor_ID', Name='Shipping Processor Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200599
;

-- Feb 22, 2013 3:04:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_ShippingProcessor_ID', Name='Shipping Processor Configuration', Description=NULL, Help=NULL, AD_Element_ID=200599 WHERE UPPER(ColumnName)='X_SHIPPINGPROCESSOR_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 22, 2013 3:04:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET ColumnName='X_ShippingProcessor_ID', Name='Shipping Processor Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200599 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:04:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_InfoColumn SET ColumnName='X_ShippingProcessor_ID', Name='Shipping Processor Configuration', Description=NULL, Help=NULL WHERE AD_Element_ID=200599 AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:04:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET Name='Shipping Processor Configuration', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200599) AND IsCentrallyMaintained='Y'
;

-- Feb 22, 2013 3:04:12 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_PrintFormatItem pi SET PrintName='Shipping Processor Configuration', Name='Shipping Processor Configuration' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200599)
;

-- Feb 22, 2013 3:05:11 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201503
;

-- Feb 22, 2013 3:05:11 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=1074
;

-- Feb 22, 2013 3:05:11 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=2588
;

-- Feb 22, 2013 3:05:11 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201435
;

-- Feb 22, 2013 3:05:15 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201503
;

-- Feb 22, 2013 3:05:15 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=1074
;

-- Feb 22, 2013 3:05:15 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=2588
;

-- Feb 22, 2013 3:05:15 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201435
;

-- Feb 22, 2013 3:07:37 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2013-02-22 15:07:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201279
;

-- Feb 22, 2013 3:07:41 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2013-02-22 15:07:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201281
;

-- Feb 22, 2013 3:10:54 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2013-02-22 15:10:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201179
;

-- Feb 22, 2013 3:10:55 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2013-02-22 15:10:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201181
;

-- Feb 22, 2013 3:14:24 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET IsActive='N',Updated=TO_DATE('2013-02-22 15:14:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200048
;

-- Feb 22, 2013 3:15:38 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Ref_List SET IsActive='Y',Updated=TO_DATE('2013-02-22 15:15:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=227
;

-- Feb 22, 2013 3:15:43 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Ref_List SET IsActive='Y',Updated=TO_DATE('2013-02-22 15:15:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=226
;

-- Feb 22, 2013 3:31:20 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET IsSameLine='N', XPosition=1,Updated=TO_DATE('2013-02-22 15:31:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1107
;

-- Feb 22, 2013 4:01:44 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',259,208596,'D','Y','N','N',0,'N',1,'N',20,'N',201981,'N','Y','32ed29cc-e0a4-4148-b53b-a05dfe53e537','Y','IsPriviledgedRate','N','Priviledged Rate','Y',100,TO_DATE('2013-02-22 16:01:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-22 16:01:42','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 22, 2013 4:01:45 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208596 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 22, 2013 4:01:48 PM SGT
-- Ticket 1001758: FedEx & UPS
ALTER TABLE C_Order ADD IsPriviledgedRate CHAR(1) DEFAULT 'N' CHECK (IsPriviledgedRate IN ('Y','N')) NOT NULL
;

-- Feb 22, 2013 4:02:21 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',186,1,'N','N',208596,'Y',201827,'N','D','Priviledged Rate','N','Y','0334ed28-48ce-4bad-b226-66f159c41298',100,0,TO_DATE('2013-02-22 16:02:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-22 16:02:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 22, 2013 4:02:21 PM SGT
-- Ticket 1001758: FedEx & UPS
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201827 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=201827
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=201613
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=1104
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=1077
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=1103
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=8653
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=1098
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=3272
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=2112
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=2109
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=3113
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=1099
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=56906
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=2593
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=2589
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=1324
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=7038
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y' WHERE AD_Field_ID=7826
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y' WHERE AD_Field_ID=7825
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y' WHERE AD_Field_ID=1112
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y' WHERE AD_Field_ID=1113
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y' WHERE AD_Field_ID=1082
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y' WHERE AD_Field_ID=1084
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y' WHERE AD_Field_ID=60922
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y' WHERE AD_Field_ID=6560
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y' WHERE AD_Field_ID=1083
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y' WHERE AD_Field_ID=3660
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y' WHERE AD_Field_ID=52014
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y' WHERE AD_Field_ID=58037
;

-- Feb 22, 2013 4:02:39 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNo=570,IsDisplayed='Y' WHERE AD_Field_ID=60972
;

-- Feb 22, 2013 4:02:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=201827
;

-- Feb 22, 2013 4:02:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=201613
;

-- Feb 22, 2013 4:02:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=1104
;

-- Feb 22, 2013 4:02:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=1077
;

-- Feb 22, 2013 4:02:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=1103
;

-- Feb 22, 2013 4:02:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=8653
;

-- Feb 22, 2013 4:02:50 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=1098
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=3272
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=2112
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=2109
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=3113
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=1099
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=56906
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=2593
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y' WHERE AD_Field_ID=2589
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y' WHERE AD_Field_ID=1324
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=430,IsDisplayedGrid='Y' WHERE AD_Field_ID=7038
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=440,IsDisplayedGrid='Y' WHERE AD_Field_ID=7826
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=450,IsDisplayedGrid='Y' WHERE AD_Field_ID=7825
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=460,IsDisplayedGrid='Y' WHERE AD_Field_ID=1112
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=470,IsDisplayedGrid='Y' WHERE AD_Field_ID=1113
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=480,IsDisplayedGrid='Y' WHERE AD_Field_ID=1082
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=490,IsDisplayedGrid='Y' WHERE AD_Field_ID=1084
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=500,IsDisplayedGrid='Y' WHERE AD_Field_ID=60922
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=510,IsDisplayedGrid='Y' WHERE AD_Field_ID=6560
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=520,IsDisplayedGrid='Y' WHERE AD_Field_ID=1083
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=530,IsDisplayedGrid='Y' WHERE AD_Field_ID=3660
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=540,IsDisplayedGrid='Y' WHERE AD_Field_ID=52014
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=550,IsDisplayedGrid='Y' WHERE AD_Field_ID=58037
;

-- Feb 22, 2013 4:02:51 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET SeqNoGrid=560,IsDisplayedGrid='Y' WHERE AD_Field_ID=60972
;

-- Feb 22, 2013 4:04:01 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET DisplayLogic='@OrderType@=''SO'' & @FreightCostRule@=''C''', XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-02-22 16:04:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201827
;

-- Feb 22, 2013 4:04:28 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET AD_FieldGroup_ID=130,Updated=TO_DATE('2013-02-22 16:04:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201827
;

-- Feb 22, 2013 4:04:30 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Field SET AD_FieldGroup_ID=130,Updated=TO_DATE('2013-02-22 16:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201613
;

-- Feb 22, 2013 4:05:34 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET DefaultValue='@IsPriviledgedRate@',Updated=TO_DATE('2013-02-22 16:05:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200049
;

-- Feb 22, 2013 4:08:29 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET DefaultValue='@IsPriviledgedRate@=''Y''',Updated=TO_DATE('2013-02-22 16:08:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200049
;

-- Feb 22, 2013 4:09:38 PM SGT
-- Ticket 1001758: FedEx & UPS
ALTER TABLE C_Order MODIFY IsPriviledgedRate CHAR(1) DEFAULT 'N'
;

-- Feb 22, 2013 4:09:43 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE C_Order SET IsPriviledgedRate='N' WHERE IsPriviledgedRate IS NULL
;

-- Feb 22, 2013 4:10:58 PM SGT
-- Ticket 1001758: FedEx & UPS
UPDATE AD_Process_Para SET DefaultValue='@IsPriviledgedRate@',Updated=TO_DATE('2013-02-22 16:10:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200049
;

SELECT register_migration_script('201302221708_TICKET-1001758.sql') FROM dual
;

