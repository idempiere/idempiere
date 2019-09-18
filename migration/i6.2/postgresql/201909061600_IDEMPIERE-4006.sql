-- IDEMPIERE-4006 Wrong matched PO quanity for vendor credit memo
-- Sep 3, 2019, 5:51:11 PM SGT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203363,0,0,'Y',TO_TIMESTAMP('2019-09-03 17:51:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-09-03 17:51:10','YYYY-MM-DD HH24:MI:SS'),100,'Ref_MatchPO_ID','Referenced Match PO','Referenced Match PO','D','880834ea-81fe-4813-95de-7390350cee95')
;

-- Sep 3, 2019, 5:51:15 PM SGT
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2019-09-03 17:51:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203363
;

-- Sep 3, 2019, 5:52:04 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214044,0,'Referenced Match PO',473,'Ref_MatchPO_ID',10,'N','N','N','N','N',0,'N',30,200017,0,0,'Y',TO_TIMESTAMP('2019-09-03 17:52:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-09-03 17:52:03','YYYY-MM-DD HH24:MI:SS'),100,203363,'Y','N','D','N','N','N','Y','50fc1a1d-5bb0-4631-94c3-92c2fa9ec13a','Y',0,'N','N','N','N')
;

-- Sep 3, 2019, 5:52:16 PM SGT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2019-09-03 17:52:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214044
;

-- Sep 3, 2019, 5:52:21 PM SGT
UPDATE AD_Column SET FKConstraintName='RefMatchPO_MMatchPO', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-09-03 17:52:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214044
;

-- Sep 3, 2019, 5:52:21 PM SGT
ALTER TABLE M_MatchPO ADD COLUMN Ref_MatchPO_ID NUMERIC(10) DEFAULT NULL 
;

-- Sep 3, 2019, 5:52:22 PM SGT
ALTER TABLE M_MatchPO ADD CONSTRAINT RefMatchPO_MMatchPO FOREIGN KEY (Ref_MatchPO_ID) REFERENCES m_matchpo(m_matchpo_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 4, 2019, 5:39:23 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206171,'Referenced Match PO',409,214044,'Y',10,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-09-04 17:39:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-09-04 17:39:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e69ff166-dfc2-4b3d-b432-744b10440827','Y',180,2)
;

-- Sep 4, 2019, 5:41:04 PM SGT
UPDATE AD_Field SET SeqNo=65, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=65, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-09-04 17:41:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206171
;

SELECT register_migration_script('201909061600_IDEMPIERE-4006.sql') FROM dual
;
