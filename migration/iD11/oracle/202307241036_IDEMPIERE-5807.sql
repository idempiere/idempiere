-- IDEMPIERE-5807 Add ability to specify attribute set when importing products
SELECT register_migration_script('202307241036_IDEMPIERE-5807.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 24, 2023, 10:36:38 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215906,1.00,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',532,'M_AttributeSet_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-07-24 10:36:37','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-24 10:36:37','YYYY-MM-DD HH24:MI:SS'),10,2017,'Y','N','D','N','N','N','N','ce9a930a-ff98-47b8-b0d0-4ff3ee6c2f88','Y',0,'N','N','mattributeset_iproduct','S','N')
;

-- Jul 24, 2023, 10:36:42 AM CEST
ALTER TABLE I_Product ADD M_AttributeSet_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 24, 2023, 10:36:42 AM CEST
ALTER TABLE I_Product ADD CONSTRAINT mattributeset_iproduct FOREIGN KEY (M_AttributeSet_ID) REFERENCES m_attributeset(m_attributeset_id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
;

-- Jul 24, 2023, 10:41:52 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207713,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',442,215906,'Y',22,520,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-07-24 10:41:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-07-24 10:41:52','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','e0ba7938-158e-450c-9938-32ccc83d9098','Y',520,2)
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=310, XPosition=1,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207713
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206546
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=206547
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5986
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5985
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5958
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5977
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5982
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5999
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=12420
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=12419
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5975
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=430,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5963
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=440,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5960
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=450,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5973
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=460,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5988
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=470,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5996
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=480,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5968
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=490,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5971
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=500,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5970
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=510,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5993
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=520,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=5965
;

-- Jul 24, 2023, 10:42:59 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-07-24 10:42:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=204866
;

