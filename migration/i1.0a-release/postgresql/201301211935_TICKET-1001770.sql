-- Jan 21, 2013 3:00:42 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Column SET ReadOnlyLogic='@M_Product_ID@!0',Updated=TO_TIMESTAMP('2013-01-21 15:00:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=52002
;

-- Jan 21, 2013 3:01:59 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',660,208397,'D','N','N','N',0,'N',10,'N',30,231,'N',454,'@M_InOutLine_ID@!0 | @C_Charge_ID@!0','N','Y','afd09a4d-ab7f-4880-8f7d-b4b8c25acdfa','Y','M_Product_ID','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.','Product','Y',100,TO_TIMESTAMP('2013-01-21 15:01:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-01-21 15:01:57','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 21, 2013 3:02:00 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208397 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 21, 2013 3:02:05 PM SGT
-- Ticket 1001770: RMA improvements
ALTER TABLE M_RMALine ADD COLUMN M_Product_ID NUMERIC(10) DEFAULT NULL 
;

-- Jan 21, 2013 3:02:22 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Column SET ReadOnlyLogic='@M_InOutLine_ID@!0 | @M_Product_ID@!0',Updated=TO_TIMESTAMP('2013-01-21 15:02:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=52002
;

-- Jan 21, 2013 3:06:17 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',629,10,'N','N',208397,'Y',201688,'N','Identifies an item which is either purchased or sold in this organization.','D','Product, Service, Item','Product','N','Y','09418daf-385d-4f02-b05c-35ed42ce9dac',100,0,TO_TIMESTAMP('2013-01-21 15:06:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-21 15:06:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 21, 2013 3:06:17 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201688 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 21, 2013 3:06:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201688
;

-- Jan 21, 2013 3:06:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=52002
;

-- Jan 21, 2013 3:06:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=9316
;

-- Jan 21, 2013 3:06:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=52001
;

-- Jan 21, 2013 3:06:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=201663
;

-- Jan 21, 2013 3:06:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=52004
;

-- Jan 21, 2013 3:06:28 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201688
;

-- Jan 21, 2013 3:06:28 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=52002
;

-- Jan 21, 2013 3:06:28 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=9316
;

-- Jan 21, 2013 3:06:28 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=52001
;

-- Jan 21, 2013 3:06:28 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=201663
;

-- Jan 21, 2013 3:06:28 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=52004
;

-- Jan 21, 2013 3:06:39 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET DisplayLength=14, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-21 15:06:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201688
;

-- Jan 21, 2013 3:06:52 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',53281,10,'N','N',208397,'Y',201689,'N','Identifies an item which is either purchased or sold in this organization.','D','Product, Service, Item','Product','N','Y','24772a1f-1505-4194-ba8d-27b2031c7584',100,0,TO_TIMESTAMP('2013-01-21 15:06:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-21 15:06:49','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 21, 2013 3:06:52 PM SGT
-- Ticket 1001770: RMA improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201689 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 21, 2013 3:06:59 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201689
;

-- Jan 21, 2013 3:06:59 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=57977
;

-- Jan 21, 2013 3:06:59 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=57978
;

-- Jan 21, 2013 3:06:59 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=57979
;

-- Jan 21, 2013 3:06:59 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=201677
;

-- Jan 21, 2013 3:06:59 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=57980
;

-- Jan 21, 2013 3:07:03 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201689
;

-- Jan 21, 2013 3:07:03 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=57977
;

-- Jan 21, 2013 3:07:03 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=57978
;

-- Jan 21, 2013 3:07:03 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=57979
;

-- Jan 21, 2013 3:07:03 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=201677
;

-- Jan 21, 2013 3:07:03 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=57980
;

-- Jan 21, 2013 3:07:15 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Field SET DisplayLength=14, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-01-21 15:07:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201689
;

UPDATE M_RMALine rl SET M_Product_ID = (
	SELECT iol.M_Product_ID 
	FROM M_InOutLine iol 
	WHERE rl.M_InOutLine_ID = iol.M_InOutLine_ID), 
	C_Charge_ID = (
	SELECT iol.C_Charge_ID  
	FROM M_InOutLine iol 
	WHERE rl.M_InOutLine_ID = iol.M_InOutLine_ID) 
WHERE rl.M_InOutLine_ID > 0;

-- Jan 21, 2013 7:39:24 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Message SET MsgText='Shipment/Receipt Line or product or charge should be entered', Value='FillShipLineOrProductOrCharge',Updated=TO_TIMESTAMP('2013-01-21 19:39:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=523849
;

-- Jan 21, 2013 7:39:25 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=523849
;

-- Jan 21, 2013 7:39:52 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Message SET MsgText='Either product or charge should be selected', Value='JustProductOrCharge',Updated=TO_TIMESTAMP('2013-01-21 19:39:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=523850
;

-- Jan 21, 2013 7:39:52 PM SGT
-- Ticket 1001770: RMA improvements
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=523850
;

SELECT register_migration_script('201301211935_TICKET-1001770.sql') FROM dual
;