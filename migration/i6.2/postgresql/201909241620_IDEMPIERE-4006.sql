-- IDEMPIERE-4006 Wrong matched PO quanity for vendor credit memo
-- Sep 23, 2019, 4:25:35 PM SGT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2019-09-23 16:25:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6505
;

-- Sep 23, 2019, 4:25:44 PM SGT
INSERT INTO t_alter_column values('m_matchinv','M_InOutLine_ID','NUMERIC(10)',null,'NULL')
;

-- Sep 23, 2019, 4:25:44 PM SGT
INSERT INTO t_alter_column values('m_matchinv','M_InOutLine_ID',null,'NULL',null)
;

-- Sep 23, 2019, 4:26:11 PM SGT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203364,0,0,'Y',TO_TIMESTAMP('2019-09-23 16:26:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-09-23 16:26:10','YYYY-MM-DD HH24:MI:SS'),100,'Ref_MatchInv_ID','Referenced Match Invoice','Referenced Match Invoice','D','95682836-1311-42ee-b981-554da51f518d')
;

-- Sep 23, 2019, 4:27:21 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214052,0,'Referenced Match Invoice',472,'Ref_MatchInv_ID',10,'N','N','N','N','N',0,'N',30,200018,0,0,'Y',TO_TIMESTAMP('2019-09-23 16:27:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-09-23 16:27:20','YYYY-MM-DD HH24:MI:SS'),100,203364,'Y','N','D','N','N','N','Y','54d57989-da02-4888-baba-0209ce4e61e9','Y',0,'N','N','N','N')
;

-- Sep 23, 2019, 4:27:26 PM SGT
UPDATE AD_Column SET FKConstraintName='RefMatchInv_MMatchInv', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-09-23 16:27:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214052
;

-- Sep 23, 2019, 4:27:26 PM SGT
ALTER TABLE M_MatchInv ADD COLUMN Ref_MatchInv_ID NUMERIC(10) DEFAULT NULL 
;

-- Sep 23, 2019, 4:27:27 PM SGT
ALTER TABLE M_MatchInv ADD CONSTRAINT RefMatchInv_MMatchInv FOREIGN KEY (Ref_MatchInv_ID) REFERENCES m_matchinv(m_matchinv_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 23, 2019, 4:28:40 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206179,'Referenced Match Invoice',408,214052,'Y',10,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-09-23 16:28:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-09-23 16:28:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ad6ec9e2-b188-4f85-aa0b-6fb90e0dc51d','Y',150,2)
;

-- Sep 23, 2019, 4:29:39 PM SGT
UPDATE AD_Field SET SeqNo=65, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=65, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-09-23 16:29:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206179
;

SELECT register_migration_script('201909241620_IDEMPIERE-4006.sql') FROM dual
;