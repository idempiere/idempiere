-- Mar 10, 2013 10:37:02 PM COT
-- IDEMPIERE-594 Improve positioning on windows 
UPDATE AD_FieldGroup SET IsCollapsedByDefault='N',Updated=TO_TIMESTAMP('2013-03-10 22:37:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_FieldGroup_ID=200011
;

-- Mar 10, 2013 10:37:15 PM COT
INSERT INTO AD_FieldGroup (FieldGroupType,EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_UU,AD_FieldGroup_ID,AD_Client_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive) VALUES ('C','D','Y','Product Category Accounts','e4b37cba-8f1b-47b0-b842-792063a5f049',200013,0,TO_TIMESTAMP('2013-03-10 22:37:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-10 22:37:14','YYYY-MM-DD HH24:MI:SS'),0,100,'Y')
;

-- Mar 10, 2013 10:37:15 PM COT
INSERT INTO AD_FieldGroup_Trl (AD_Language,AD_FieldGroup_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_FieldGroup_Trl_UU ) SELECT l.AD_Language,t.AD_FieldGroup_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_FieldGroup t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_FieldGroup_ID=200013 AND NOT EXISTS (SELECT * FROM AD_FieldGroup_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_FieldGroup_ID=t.AD_FieldGroup_ID)
;

-- Mar 10, 2013 10:38:15 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2655
;

-- Mar 10, 2013 10:38:20 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2657
;

-- Mar 10, 2013 10:38:24 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12347
;

-- Mar 10, 2013 10:38:38 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12348
;

-- Mar 10, 2013 10:38:42 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2656
;

-- Mar 10, 2013 10:38:45 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2658
;

-- Mar 10, 2013 10:38:47 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3825
;

-- Mar 10, 2013 10:38:50 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4860
;

-- Mar 10, 2013 10:38:53 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4861
;

-- Mar 10, 2013 10:38:56 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:38:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4862
;

-- Mar 10, 2013 10:39:00 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200013,Updated=TO_TIMESTAMP('2013-03-10 22:39:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56527
;

-- Mar 10, 2013 10:39:40 PM COT
UPDATE AD_FieldGroup SET IsCollapsedByDefault='N',Updated=TO_TIMESTAMP('2013-03-10 22:39:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_FieldGroup_ID=200010
;

-- Mar 10, 2013 10:39:51 PM COT
INSERT INTO AD_FieldGroup (FieldGroupType,EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_UU,AD_FieldGroup_ID,AD_Client_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive) VALUES ('C','D','Y','Business Partner Group Accounts','20ab4286-f212-43c1-975b-f726600fe849',200014,0,TO_TIMESTAMP('2013-03-10 22:39:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-10 22:39:51','YYYY-MM-DD HH24:MI:SS'),0,100,'Y')
;

-- Mar 10, 2013 10:39:51 PM COT
INSERT INTO AD_FieldGroup_Trl (AD_Language,AD_FieldGroup_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_FieldGroup_Trl_UU ) SELECT l.AD_Language,t.AD_FieldGroup_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_FieldGroup t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_FieldGroup_ID=200014 AND NOT EXISTS (SELECT * FROM AD_FieldGroup_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_FieldGroup_ID=t.AD_FieldGroup_ID)
;

-- Mar 10, 2013 10:40:37 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:40:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3822
;

-- Mar 10, 2013 10:40:41 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:40:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3853
;

-- Mar 10, 2013 10:40:44 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:40:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3827
;

-- Mar 10, 2013 10:40:48 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:40:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3829
;

-- Mar 10, 2013 10:40:51 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:40:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3828
;

-- Mar 10, 2013 10:40:54 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:40:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2650
;

-- Mar 10, 2013 10:40:57 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:40:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2659
;

-- Mar 10, 2013 10:41:00 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:41:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2649
;

-- Mar 10, 2013 10:41:03 PM COT
UPDATE AD_Field SET AD_FieldGroup_ID=200014,Updated=TO_TIMESTAMP('2013-03-10 22:41:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2661
;

SELECT register_migration_script('201303102242_IDEMPIERE-594.sql') FROM dual
;

