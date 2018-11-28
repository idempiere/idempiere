SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3837 Revenue Recognition
-- Nov 27, 2018, 7:19:23 PM CET
UPDATE AD_Window SET IsActive='Y',Updated=TO_DATE('2018-11-27 19:19:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=174
;

-- Nov 27, 2018, 7:19:23 PM CET
UPDATE AD_Menu SET Name='Revenue Recognition', Description='Revenue Recognition Rules', IsActive='Y',Updated=TO_DATE('2018-11-27 19:19:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=186
;

-- Nov 27, 2018, 7:19:23 PM CET
UPDATE AD_WF_Node SET Name='Revenue Recognition', Description='Revenue Recognition Rules', IsActive='Y',Updated=TO_DATE('2018-11-27 19:19:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WF_Node_ID=50098
;

-- Nov 27, 2018, 7:20:09 PM CET
ALTER TABLE C_RevenueRecognition ADD FixedRecogDay NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2018, 7:20:45 PM CET
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='N', FKConstraintName='ADClient_CRevenueRecogService', FKConstraintType='N',Updated=TO_DATE('2018-11-27 19:20:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=74644
;

-- Nov 27, 2018, 7:20:46 PM CET
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='N', FKConstraintName='ADOrg_CRevenueRecogService', FKConstraintType='N',Updated=TO_DATE('2018-11-27 19:20:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=74645
;

-- Nov 27, 2018, 7:20:46 PM CET
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='N', FKConstraintName='CreatedBy_CRevenueRecogService', FKConstraintType='N',Updated=TO_DATE('2018-11-27 19:20:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=74652
;

-- Nov 27, 2018, 7:20:46 PM CET
UPDATE AD_Column SET IsUpdateable='N', IsToolbarButton='N', FKConstraintName='CRevenueRecognition_CRevenueRe', FKConstraintType='N',Updated=TO_DATE('2018-11-27 19:20:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=74649
;

-- Nov 27, 2018, 7:20:46 PM CET
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='N', FKConstraintName='UpdatedBy_CRevenueRecogService', FKConstraintType='N',Updated=TO_DATE('2018-11-27 19:20:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=74659
;

-- Nov 27, 2018, 7:20:46 PM CET
CREATE TABLE C_RevenueRecog_Service (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, C_RevenueRecognition_ID NUMBER(10) NOT NULL, C_RevenueRecog_Service_ID NUMBER(10) NOT NULL, Description VARCHAR2(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Line NUMBER(10) DEFAULT NULL , Percent NUMBER DEFAULT NULL , Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT C_RevenueRecog_Service_Key PRIMARY KEY (C_RevenueRecog_Service_ID))
;

-- Nov 27, 2018, 7:20:46 PM CET
ALTER TABLE C_RevenueRecog_Service ADD CONSTRAINT ADClient_CRevenueRecogService FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2018, 7:20:46 PM CET
ALTER TABLE C_RevenueRecog_Service ADD CONSTRAINT ADOrg_CRevenueRecogService FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2018, 7:20:46 PM CET
ALTER TABLE C_RevenueRecog_Service ADD CONSTRAINT CreatedBy_CRevenueRecogService FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2018, 7:20:46 PM CET
ALTER TABLE C_RevenueRecog_Service ADD CONSTRAINT CRevenueRecognition_CRevenueRe FOREIGN KEY (C_RevenueRecognition_ID) REFERENCES c_revenuerecognition(c_revenuerecognition_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2018, 7:20:46 PM CET
ALTER TABLE C_RevenueRecog_Service ADD CONSTRAINT UpdatedBy_CRevenueRecogService FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2018, 7:21:11 PM CET
ALTER TABLE C_RevenueRecognition_Run MODIFY GL_Journal_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2018, 7:21:27 PM CET
ALTER TABLE C_RevenueRecognition_Run ADD DateRecognized DATE DEFAULT NULL 
;

-- Nov 27, 2018, 7:21:35 PM CET
UPDATE AD_Column SET IsToolbarButton='N', FKConstraintName='CRevenueRecogService_CRevenueR', FKConstraintType='N',Updated=TO_DATE('2018-11-27 19:21:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=77928
;

-- Nov 27, 2018, 7:21:35 PM CET
ALTER TABLE C_RevenueRecognition_Run ADD C_RevenueRecog_Service_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2018, 7:21:35 PM CET
ALTER TABLE C_RevenueRecognition_Run ADD CONSTRAINT CRevenueRecogService_CRevenueR FOREIGN KEY (C_RevenueRecog_Service_ID) REFERENCES c_revenuerecog_service(c_revenuerecog_service_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2018, 7:22:22 PM CET
UPDATE AD_Sequence SET Name='C_RevenueRecog_Service', Description='Table C_RevenueRecog_Service',Updated=TO_DATE('2018-11-27 19:22:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=54047
;

-- Nov 27, 2018, 7:26:38 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203286,0,0,'Y',TO_DATE('2018-11-27 19:26:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-11-27 19:26:37','YYYY-MM-DD HH24:MI:SS'),100,'C_RevenueRecog_Service_UU','C_RevenueRecog_Service_UU','C_RevenueRecog_Service_UU','U','ec9dbc11-467b-45c4-912b-cab4291bdd60')
;

-- Nov 27, 2018, 7:26:39 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213821,1.0,'C_RevenueRecog_Service_UU',53888,'C_RevenueRecog_Service_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2018-11-27 19:26:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-11-27 19:26:37','YYYY-MM-DD HH24:MI:SS'),100,203286,'Y','N','U','N','f9c7c4a1-a23e-46a4-b9c8-3fd103fb31bf','N')
;

-- Nov 27, 2018, 7:26:39 PM CET
ALTER TABLE C_RevenueRecog_Service ADD C_RevenueRecog_Service_UU VARCHAR2(36) DEFAULT NULL 
;

-- Nov 27, 2018, 7:26:39 PM CET
ALTER TABLE C_RevenueRecog_Service ADD CONSTRAINT C_RevenueRecog_Service_UU_idx UNIQUE (C_RevenueRecog_Service_UU)
;

-- Nov 27, 2018, 10:46:24 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 22:46:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4834
;

-- Nov 27, 2018, 10:46:24 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 22:46:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4832
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4830
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4829
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4834
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4831
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4835
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4833
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74749
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4832
;

-- Nov 27, 2018, 10:47:02 PM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=77047
;

-- Nov 27, 2018, 10:49:44 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsAllowCopy='Y', XPosition=3, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 22:49:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=74745
;

-- Nov 27, 2018, 10:49:44 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 22:49:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=74741
;

-- Nov 27, 2018, 10:49:44 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 22:49:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=74746
;

-- Nov 27, 2018, 10:49:44 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=3, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 22:49:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=74743
;

-- Nov 27, 2018, 10:49:44 PM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 22:49:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=74748
;

-- Nov 27, 2018, 10:50:47 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74745
;

-- Nov 27, 2018, 10:50:47 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74747
;

-- Nov 27, 2018, 10:50:47 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74748
;

-- Nov 27, 2018, 10:50:47 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74742
;

-- Nov 27, 2018, 10:50:47 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74744
;

-- Nov 27, 2018, 10:50:47 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74746
;

-- Nov 27, 2018, 10:50:47 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74743
;

-- Nov 27, 2018, 10:50:47 PM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74741
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4820
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4819
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4821
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4818
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4857
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4822
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4827
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4825
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4828
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4826
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4823
;

-- Nov 27, 2018, 10:51:36 PM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4824
;

-- Nov 27, 2018, 10:52:20 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=77047
;

-- Nov 27, 2018, 10:52:20 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4831
;

-- Nov 27, 2018, 10:52:20 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4834
;

-- Nov 27, 2018, 10:52:20 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=74749
;

-- Nov 27, 2018, 10:52:20 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4832
;

-- Nov 27, 2018, 10:52:20 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4833
;

-- Nov 27, 2018, 10:52:20 PM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=sysdate, UpdatedBy=100 WHERE AD_Field_ID=4835
;

UPDATE AD_Field SET IsDisplayed='Y', IsDisplayedGrid='Y',Updated=TO_DATE('2018-11-27 23:06:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11767
;

UPDATE AD_Field SET IsDisplayed='Y', IsDisplayedGrid='Y',Updated=TO_DATE('2018-11-27 23:06:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5529
;

UPDATE AD_Field SET IsDisplayed='Y', IsDisplayedGrid='Y',Updated=TO_DATE('2018-11-27 23:06:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5431
;

UPDATE AD_Field SET IsDisplayed='Y', IsDisplayedGrid='Y',Updated=TO_DATE('2018-11-27 23:06:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3079
;

UPDATE AD_Field SET IsDisplayed='Y', IsDisplayedGrid='Y',Updated=TO_DATE('2018-11-27 23:06:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53577
;

UPDATE AD_Field SET IsDisplayed='Y', IsDisplayedGrid='Y',Updated=TO_DATE('2018-11-27 23:06:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4821
;

UPDATE AD_Field SET IsDisplayed='Y', IsDisplayedGrid='Y',Updated=TO_DATE('2018-11-27 23:06:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53875
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3079
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1025
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2587
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5888
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6129
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1032
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1031
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201343
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6841
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10411
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1026
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200294
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200295
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200296
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200297
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7646
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1319
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1320
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1321
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1322
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3743
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3746
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3747
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3744
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3745
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1027
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1028
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1568
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1569
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5381
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5383
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12418
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5910
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5911
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=500, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6130
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=510, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8307
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=520, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6343
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=530, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6344
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=540, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58973
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=550, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8608
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=560, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8613
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=570, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52015
;

-- Nov 27, 2018, 11:56:17 PM CET
UPDATE AD_Field SET SeqNo=580, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-27 23:56:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52016
;

-- Nov 28, 2018, 12:27:46 AM CET
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MAX(Line),0)+10 FROM C_RevenueRecog_Service WHERE C_RevenueRecognition_ID=@C_RevenueRecognition_ID@', IsToolbarButton='N',Updated=TO_DATE('2018-11-28 00:27:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=74662
;

-- Nov 28, 2018, 12:30:11 AM CET
UPDATE AD_Field SET IsActive='Y', IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:30:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3927
;

-- Nov 28, 2018, 12:30:32 AM CET
UPDATE AD_Field SET IsActive='Y', IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:30:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3853
;

UPDATE c_bp_group_acct
SET unearnedrevenue_acct=(SELECT unearnedrevenue_acct FROM c_acctschema_default WHERE c_acctschema_default.c_acctschema_id=c_bp_group_acct.c_acctschema_id)
WHERE unearnedrevenue_acct IS NULL;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3007
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3008
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3013
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3010
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3012
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3011
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3015
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3014
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=77048
;

-- Nov 28, 2018, 12:39:14 AM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-11-28 00:39:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3009
;

-- Nov 28, 2018, 12:39:51 AM CET
ALTER TABLE C_RevenueRecognition_Run MODIFY GL_Journal_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 28, 2018, 12:39:51 AM CET
ALTER TABLE C_RevenueRecognition_Run MODIFY GL_Journal_ID NULL
;

-- Nov 28, 2018, 12:57:53 AM CET
INSERT INTO AD_TreeNodeMM (AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Tree_ID,Node_ID,AD_Client_ID,AD_TreeNodeMM_UU) VALUES (0,'Y',TO_DATE('2018-11-28 00:57:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-11-28 00:57:53','YYYY-MM-DD HH24:MI:SS'),100,0,10,53885,0,'4a31b4dd-998f-48e4-ab69-0129052f5a04')
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=164
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=280
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=158
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=522
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200008
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=118
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53288
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=169
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53289
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=433
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53290
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=352
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=434
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=435
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200045
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200046
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200019
;

-- Nov 28, 2018, 12:58:33 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=278, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53885
;

-- Nov 28, 2018, 1:29:56 AM CET
UPDATE AD_Process_Para SET AD_Val_Rule_ID=102,Updated=TO_DATE('2018-11-28 01:29:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=55002
;

-- Nov 28, 2018, 1:43:02 AM CET
UPDATE AD_Column SET AD_Val_Rule_ID=104,Updated=TO_DATE('2018-11-28 01:43:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=74645
;

-- Nov 28, 2018, 1:46:54 AM CET
UPDATE AD_Table SET AccessLevel='3',Updated=TO_DATE('2018-11-28 01:46:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53888
;

SELECT register_migration_script('201811271928_RevenueRecognitionPR.sql') FROM dual
;

