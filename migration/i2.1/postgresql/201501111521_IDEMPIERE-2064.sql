-- Jan 11, 2015 3:18:55 PM COT
-- IDEMPIERE-2064 Implement toolbar+tab button
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200099,'IsToolbarButton','L',0,0,'Y',TO_TIMESTAMP('2015-01-11 15:18:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-01-11 15:18:54','YYYY-MM-DD HH24:MI:SS'),100,'D','N','d90d1cd0-4cf1-41e0-84cb-53600a366a22')
;

-- Jan 11, 2015 3:19:18 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200285,'Toolbar',200099,'Y',0,0,'Y',TO_TIMESTAMP('2015-01-11 15:19:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-01-11 15:19:18','YYYY-MM-DD HH24:MI:SS'),100,'D','5803fda0-fda8-4100-85f2-a4fe8142a059')
;

-- Jan 11, 2015 3:19:35 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200286,'Window',200099,'N',0,0,'Y',TO_TIMESTAMP('2015-01-11 15:19:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-01-11 15:19:34','YYYY-MM-DD HH24:MI:SS'),100,'D','eb2f6365-a357-4655-9102-d622360aacce')
;

-- Jan 11, 2015 3:19:45 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200287,'Both',200099,'B',0,0,'Y',TO_TIMESTAMP('2015-01-11 15:19:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-01-11 15:19:44','YYYY-MM-DD HH24:MI:SS'),100,'D','5b8b7285-d4da-4513-8941-a280d501ea19')
;

-- Jan 11, 2015 3:20:17 PM COT
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=200099,Updated=TO_TIMESTAMP('2015-01-11 15:20:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200703
;

-- Jan 11, 2015 3:20:18 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200099,Updated=TO_TIMESTAMP('2015-01-11 15:20:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200949
;

-- Jan 11, 2015 3:20:20 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200099,Updated=TO_TIMESTAMP('2015-01-11 15:20:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200958
;

-- Jan 11, 2015 3:20:35 PM COT
INSERT INTO t_alter_column values('ad_column','IsToolbarButton','CHAR(1)',null,'Y')
;

-- Jan 11, 2015 3:20:36 PM COT
UPDATE AD_Column SET IsToolbarButton='Y' WHERE IsToolbarButton IS NULL
;

-- Jan 11, 2015 3:20:44 PM COT
INSERT INTO t_alter_column values('ad_field','IsToolbarButton','CHAR(1)',null,'NULL')
;

-- Jan 11, 2015 3:20:50 PM COT
INSERT INTO t_alter_column values('ad_userdef_field','IsToolbarButton','CHAR(1)',null,'NULL')
;

ALTER TABLE ad_column DROP CONSTRAINT ad_column_istoolbarbutton_check CASCADE
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200648
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59619
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=171
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56279
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2574
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2573
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202518
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=160
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=161
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=162
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=166
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5122
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=169
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2370
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10128
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4941
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50188
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=168
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=159
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4940
;

-- Jan 11, 2015 4:53:13 PM COT
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2015-01-11 16:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200288
;

-- Jan 11, 2015 4:55:14 PM COT
UPDATE AD_Element SET Description='Show the button on the toolbar, the window, or both', Help='The IsToolbarButton field indicates if this button is part of the toolbar''s process button popup list, or render as field in window, or both.',Updated=TO_TIMESTAMP('2015-01-11 16:55:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200187
;

-- Jan 11, 2015 4:55:14 PM COT
UPDATE AD_Column SET ColumnName='IsToolbarButton', Name='Toolbar Button', Description='Show the button on the toolbar, the window, or both', Help='The IsToolbarButton field indicates if this button is part of the toolbar''s process button popup list, or render as field in window, or both.' WHERE AD_Element_ID=200187
;

-- Jan 11, 2015 4:55:14 PM COT
UPDATE AD_Process_Para SET ColumnName='IsToolbarButton', Name='Toolbar Button', Description='Show the button on the toolbar, the window, or both', Help='The IsToolbarButton field indicates if this button is part of the toolbar''s process button popup list, or render as field in window, or both.', AD_Element_ID=200187 WHERE UPPER(ColumnName)='ISTOOLBARBUTTON' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 11, 2015 4:55:14 PM COT
UPDATE AD_Process_Para SET ColumnName='IsToolbarButton', Name='Toolbar Button', Description='Show the button on the toolbar, the window, or both', Help='The IsToolbarButton field indicates if this button is part of the toolbar''s process button popup list, or render as field in window, or both.' WHERE AD_Element_ID=200187 AND IsCentrallyMaintained='Y'
;

-- Jan 11, 2015 4:55:14 PM COT
UPDATE AD_InfoColumn SET ColumnName='IsToolbarButton', Name='Toolbar Button', Description='Show the button on the toolbar, the window, or both', Help='The IsToolbarButton field indicates if this button is part of the toolbar''s process button popup list, or render as field in window, or both.' WHERE AD_Element_ID=200187 AND IsCentrallyMaintained='Y'
;

-- Jan 11, 2015 4:55:14 PM COT
UPDATE AD_Field SET Name='Toolbar Button', Description='Show the button on the toolbar, the window, or both', Help='The IsToolbarButton field indicates if this button is part of the toolbar''s process button popup list, or render as field in window, or both.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200187) AND IsCentrallyMaintained='Y'
;

-- Jan 11, 2015 5:01:02 PM COT
UPDATE AD_Column SET IsToolbarButton='B',Updated=TO_TIMESTAMP('2015-01-11 17:01:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6487
;

SELECT register_migration_script('201501111521_IDEMPIERE-2064.sql') FROM dual
;

