SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 23, 2021 5:21:44 PM MYT
UPDATE AD_Process SET Name='Copy BOM Lines From',Updated=TO_DATE('2021-09-23 17:21:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53004
;

-- Sep 23, 2021 5:22:14 PM MYT
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_DATE('2021-09-23 17:22:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53027
;

-- Sep 23, 2021 5:23:00 PM MYT
UPDATE AD_Column SET DefaultValue='A',Updated=TO_DATE('2021-09-23 17:23:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53343
;

-- Sep 23, 2021 5:27:12 PM MYT
UPDATE AD_Window SET Name='Bill of Materials & Formula', Description='Maintain Product Bill of Materials & Formula',Updated=TO_DATE('2021-09-23 17:27:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53006
;

-- Sep 23, 2021 5:28:01 PM MYT
UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N',Updated=TO_DATE('2021-09-23 17:28:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53479
;

-- Sep 23, 2021 5:35:38 PM MYT
UPDATE AD_Menu SET IsActive='Y', AD_Window_ID=53006,Updated=TO_TIMESTAMP('2021-09-23 17:35:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53298
;

-- Sep 23, 2021 5:36:52 PM MYT
UPDATE AD_Table SET IsDeleteable='N', IsView='Y',Updated=TO_DATE('2021-09-23 17:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=383
;

INSERT INTO PP_PRODUCT_BOM
            (pp_product_bom_id, ad_client_id, ad_org_id, isactive, created,
             createdby, updated, updatedby, m_product_id, bomtype, VALUE,
             NAME, description, help, revision, copyfrom,
             m_changenotice_id, processing, validfrom, validto,
             m_attributesetinstance_id, bomuse, c_uom_id, pp_product_bom_uu)
   SELECT Nextidfunc (53015, 'N'), ad_client_id, ad_org_id, isactive, created,
          createdby, updated, updatedby, m_product_id, 'A', VALUE, 
          cast(NAME as character varying(60)), description, help,
          NULL, NULL, NULL, NULL, created, NULL, NULL, 'A', c_uom_id, generate_uuid()
     FROM M_PRODUCT
    WHERE isbom = 'Y' AND m_product_id > 999999 
	AND NOT EXISTS
	( SELECT x.m_product_id FROM pp_product_bom x WHERE x.m_product_id=m_product.m_product_id AND x.value=m_product.value)
;

INSERT INTO PP_PRODUCT_BOMLINE
            (pp_product_bomline_id, ad_client_id, ad_org_id, isactive,
             created, createdby, updated, updatedby, line, m_product_id,
             pp_product_bom_id, qtybom, description, help, feature, assay,
             backflushgroup, c_uom_id, componenttype, forecast, iscritical,
             isqtypercentage, issuemethod, leadtimeoffset,
             m_attributesetinstance_id, m_changenotice_id, qtybatch, scrap,
             validfrom, validto, pp_product_bomline_uu)
   SELECT Nextidfunc (53016, 'N'), mpb.ad_client_id, mpb.ad_org_id, mpb.isactive,
          mpb.created, mpb.createdby, mpb.updated, mpb.updatedby, mpb.line,
          mpb.m_productbom_id, ppb.pp_product_bom_id, mpb.bomqty,
          mpb.description, NULL, NULL, 0, NULL, mp.c_uom_id, 'CO', 0, 'N',
          'N', '0', 0, NULL, NULL, 0, 0, mpb.created, NULL, mpb.M_PRODUCT_BOM_UU
     FROM M_PRODUCT_BOM mpb, PP_PRODUCT_BOM ppb, M_PRODUCT mp, M_Product pp
    WHERE mpb.m_product_id = ppb.m_product_id
	  AND ppb.m_product_id = pp.m_product_id
	  AND ppb.value = pp.value
      AND mpb.m_productbom_id = mp.m_product_id
      AND mpb.m_product_bom_id > 999999
;

UPDATE PP_PRODUCT_BOMLINE SET PP_PRODUCT_BOMLINE_UU = generate_uuid() WHERE pp_product_bomline_uu IS NULL
;

ALTER TABLE m_product_bom RENAME TO m_product_bom_old
;

CREATE OR REPLACE VIEW m_product_bom
(
		m_product_bom_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, line, m_product_id, m_productbom_id, 
		bomqty, description, bomtype, m_product_bom_uu
) AS
SELECT l.pp_product_bomline_id, l.ad_client_id, l.ad_org_id, l.isactive, l.created, l.createdby, l.updated, l.updatedby, l.line, b.m_product_id, l.m_product_id, 
       l.qtybom, b.description,
       CASE l.componenttype WHEN 'OP' THEN 'O' WHEN 'CO' THEN 'P' WHEN 'PH' THEN 'P' WHEN 'PK' THEN 'P' WHEN 'VA' THEN 
         CASE WHEN l.feature in ('1','2','3','4','5','6','7','8','9') THEN l.feature ELSE 'O' END 
         ELSE 'P' 
       END AS bomtype, l.pp_product_bomline_uu
FROM pp_product_bom b 
JOIN pp_product_bomline l ON b.pp_product_bom_id=l.pp_product_bom_id
WHERE b.bomtype='A' AND b.bomuse='A' AND b.isactive='Y'
;

-- Sep 24, 2021 2:59:59 PM MYT
UPDATE AD_Table SET IsChangeLog='N',Updated=TO_TIMESTAMP('2021-09-24 14:59:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=383
;

-- Sep 24, 2021 3:00:26 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-09-24 15:00:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4723
;

-- Sep 24, 2021 3:00:42 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-09-24 15:00:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8555
;

-- Sep 24, 2021 3:01:05 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-09-24 15:01:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4724
;

-- Sep 24, 2021 3:01:15 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N',Updated=TO_TIMESTAMP('2021-09-24 15:01:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4716
;

-- Sep 24, 2021 3:01:38 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N', DefaultValue=NULL,Updated=TO_TIMESTAMP('2021-09-24 15:01:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4770
;

-- Sep 24, 2021 3:01:57 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-09-24 15:01:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4722
;

-- Sep 24, 2021 3:02:04 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N',Updated=TO_TIMESTAMP('2021-09-24 15:02:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=60923
;

-- Sep 24, 2021 3:02:15 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-09-24 15:02:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4721
;

-- Sep 24, 2021 2:22:50 PM MYT
UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N', IsActive='N',Updated=TO_TIMESTAMP('2021-09-24 14:22:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53470
;

-- Sep 24, 2021 2:23:20 PM MYT
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2021-09-24 14:23:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53323
;

-- Sep 24, 2021 2:30:22 PM MYT
INSERT INTO AD_Message (AD_Message_ID,AD_Client_ID,Updated,AD_Org_ID,MsgText,MsgType,Created,EntityType,CreatedBy,UpdatedBy,Value,AD_Message_UU,IsActive) VALUES (200402,0,TO_TIMESTAMP('2021-09-24 14:30:15','YYYY-MM-DD HH24:MI:SS'),0,'You can only set one default BOM ( BOM Type is Current Active and BOM Use is Master ) for a product.','E',TO_TIMESTAMP('2021-09-24 14:30:15','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'OnlyOneCurrentActiveMasterBOM','56bbf336-47fb-4bf1-94fb-9cc643db733c','Y')
;

-- Sep 24, 2021 3:04:31 PM MYT
UPDATE AD_Tab SET IsReadOnly='Y', IsInsertRecord='N',Updated=TO_TIMESTAMP('2021-09-24 15:04:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=383
;

-- Sep 25, 2021 5:57:35 PM MYT
UPDATE AD_Field SET DisplayLogic='@ComponentType@=''VA''|@ComponentType@=''OP''',Updated=TO_DATE('2021-09-25 17:57:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58125
;

-- Sep 25, 2021 5:58:55 PM MYT
UPDATE AD_Field SET DisplayLogic='@ComponentType@=''VA''|@ComponentType@=''OP''',Updated=TO_DATE('2021-09-25 17:58:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53495
;

-- Sep 26, 2021 3:58:50 PM MYT
UPDATE AD_Column SET DefaultValue='-1',Updated=TO_DATE('2021-09-26 15:58:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53364
;

-- Sep 26, 2021 3:59:41 PM MYT
UPDATE AD_Tab SET IsActive='N',Updated=TO_DATE('2021-09-26 15:59:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=317
;

-- Sep 26, 2021 4:00:07 PM MYT
UPDATE AD_Tab SET DisplayLogic='@IsBOM@=''Y''',IsActive='Y',Updated=TO_DATE('2021-09-26 16:00:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53286
;

-- Sep 26, 2021 4:01:23 PM MYT
UPDATE AD_Tab SET DisplayLogic='@IsBOM@=''Y''',IsActive='Y',Updated=TO_DATE('2021-09-26 16:01:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53287
;

-- Sep 26, 2021 4:02:54 PM MYT
UPDATE AD_Tab SET IsSingleRow='Y',Updated=TO_DATE('2021-09-26 16:02:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53287
;

-- Sep 27, 2021 11:36:52 AM MYT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2021-09-27 11:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53338
;

-- Sep 27, 2021 11:36:59 AM MYT
ALTER TABLE PP_Product_BOM MODIFY ValidFrom DATE DEFAULT NULL 
;

-- Sep 27, 2021 11:36:59 AM MYT
ALTER TABLE PP_Product_BOM MODIFY ValidFrom NULL
;

-- Sep 27, 2021 11:38:02 AM MYT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53359
;

-- Sep 27, 2021 11:38:08 AM MYT
ALTER TABLE PP_Product_BOMLine MODIFY IssueMethod CHAR(1) DEFAULT '1'
;

-- Sep 27, 2021 11:38:10 AM MYT
ALTER TABLE PP_Product_BOMLine MODIFY IssueMethod NULL
;

-- Sep 27, 2021 11:42:48 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53473
;

-- Sep 27, 2021 11:42:48 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53472
;

-- Sep 27, 2021 11:42:48 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53469
;

-- Sep 27, 2021 11:42:48 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53476
;

-- Sep 27, 2021 11:42:48 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53479
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53470
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53465
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53466
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53467
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53468
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53471
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53477
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53478
;

-- Sep 27, 2021 11:42:49 AM MYT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53480
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53473
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53472
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53469
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53476
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53479
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53470
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53462
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53463
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53474
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53475
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53464
;

-- Sep 27, 2021 11:43:11 AM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53465
;

-- Sep 27, 2021 11:43:12 AM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53466
;

-- Sep 27, 2021 11:43:12 AM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53467
;

-- Sep 27, 2021 11:43:12 AM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53468
;

-- Sep 27, 2021 11:43:12 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53471
;

-- Sep 27, 2021 11:43:12 AM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53477
;

-- Sep 27, 2021 11:43:12 AM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53478
;

-- Sep 27, 2021 11:43:12 AM MYT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53480
;

-- Sep 27, 2021 11:45:58 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58081
;

-- Sep 27, 2021 11:45:58 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53504
;

-- Sep 27, 2021 11:45:58 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53505
;

-- Sep 27, 2021 11:45:58 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53503
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53502
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53501
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53499
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53497
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53496
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53491
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53490
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53489
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53500
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53493
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53486
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53487
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53488
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53498
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53495
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53506
;

-- Sep 27, 2021 11:45:59 AM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53481
;

-- Sep 27, 2021 11:46:36 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53504
;

-- Sep 27, 2021 11:46:36 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53505
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53503
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53501
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53502
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58081
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53499
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53497
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53496
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53491
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53490
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53489
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53500
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53493
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53486
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53487
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53488
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53498
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53495
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53506
;

-- Sep 27, 2021 11:46:37 AM MYT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:38:02','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53481
;

-- Sep 27, 2021 11:48:48 AM MYT
UPDATE AD_Field SET SeqNo=20, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2021-09-27 11:48:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53481
;

-- Sep 27, 2021 11:48:48 AM MYT
UPDATE AD_Field SET SeqNo=30, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2021-09-27 11:48:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53492
;

-- Sep 27, 2021 11:48:48 AM MYT
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2021-09-27 11:48:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53494
;

-- Sep 27, 2021 11:48:48 AM MYT
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2021-09-27 11:48:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53486
;

-- Sep 27, 2021 11:48:49 AM MYT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2021-09-27 11:48:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53487
;

-- Sep 27, 2021 11:48:49 AM MYT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2021-09-27 11:48:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53488
;

-- Sep 27, 2021 11:48:49 AM MYT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2021-09-27 11:48:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53498
;

-- Sep 27, 2021 11:48:49 AM MYT
UPDATE AD_Field SET SeqNo=100, ColumnSpan=2,Updated=TO_DATE('2021-09-27 11:48:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53495
;

-- Sep 27, 2021 11:48:50 AM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2021-09-27 11:48:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53506
;

-- Sep 27, 2021 11:50:02 AM MYT
UPDATE AD_Table SET AD_Window_ID=140,Updated=TO_DATE('2021-09-27 11:50:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53018
;

-- Sep 27, 2021 11:50:27 AM MYT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53372
;

-- Sep 27, 2021 11:50:33 AM MYT
ALTER TABLE PP_Product_BOMLine MODIFY ValidFrom DATE DEFAULT NULL 
;

-- Sep 27, 2021 11:50:33 AM MYT
ALTER TABLE PP_Product_BOMLine MODIFY ValidFrom NULL
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58100
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58097
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58096
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58094
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58093
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58088
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58089
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58090
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58091
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58092
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58095
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58098
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58099
;

-- Sep 27, 2021 11:52:25 AM MYT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58101
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58100
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58097
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58096
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58094
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58093
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58088
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58083
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58084
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58085
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58086
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58087
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58089
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58090
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58091
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58092
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58095
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58098
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58099
;

-- Sep 27, 2021 11:52:47 AM MYT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58101
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58124
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58123
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58122
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58121
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58120
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58118
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58117
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58116
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58115
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58114
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58113
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58108
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58109
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58110
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58111
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58112
;

-- Sep 27, 2021 11:53:52 AM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58119
;

-- Sep 27, 2021 11:53:53 AM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58125
;

-- Sep 27, 2021 11:53:53 AM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58126
;

-- Sep 27, 2021 11:53:53 AM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58127
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58124
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58123
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58122
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58121
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58120
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58118
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58117
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58116
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58115
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58114
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58113
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58108
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58109
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58110
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58111
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58112
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58119
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58125
;

-- Sep 27, 2021 11:54:20 AM MYT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58126
;

-- Sep 27, 2021 11:54:21 AM MYT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y', Updated=TO_DATE('2021-09-27 11:50:27','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58127
;

-- Sep 27, 2021 11:55:01 AM MYT
UPDATE AD_Field SET SeqNo=20, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2021-09-27 11:55:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58127
;

-- Sep 27, 2021 11:55:01 AM MYT
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2021-09-27 11:55:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58106
;

-- Sep 27, 2021 11:55:02 AM MYT
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2021-09-27 11:55:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58107
;

-- Sep 27, 2021 11:55:02 AM MYT
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2021-09-27 11:55:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58110
;

-- Sep 27, 2021 11:55:02 AM MYT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2021-09-27 11:55:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58111
;

-- Sep 27, 2021 11:55:02 AM MYT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2021-09-27 11:55:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58112
;

-- Sep 27, 2021 11:55:02 AM MYT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2021-09-27 11:55:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58119
;

-- Sep 27, 2021 11:55:03 AM MYT
UPDATE AD_Field SET SeqNo=100, ColumnSpan=2,Updated=TO_DATE('2021-09-27 11:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58125
;

-- Sep 27, 2021 11:55:03 AM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2021-09-27 11:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58126
;

-- Sep 27, 2021 12:12:50 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:55:03','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53506
;

-- Sep 27, 2021 12:13:05 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:55:03','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53506
;

-- Sep 27, 2021 12:13:05 PM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:55:03','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=53481
;

-- Sep 27, 2021 12:13:48 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=TO_DATE('2021-09-27 11:55:03','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58126
;

-- Sep 27, 2021 12:13:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=TO_DATE('2021-09-27 11:55:03','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58126
;

-- Sep 27, 2021 12:13:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=TO_DATE('2021-09-27 11:55:03','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 WHERE AD_Field_ID=58127
;

-- Sep 28, 2021 6:30:10 PM MYT
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,Name,Updated,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,EntityType,AD_Org_ID) VALUES ('PP_Product_BOM.IsActive=''Y'' AND PP_Product_BOM.M_Product_ID=@M_Product_ID@ AND PP_Product_BOM.AD_Org_ID IN (0,@AD_Org_ID@)',200136,'PP_Product_BOM of M_Product',TO_DATE('2021-09-28 18:30:09','YYYY-MM-DD HH24:MI:SS'),'S','de413613-585d-40b9-a801-82a9f725d442',100,100,'Y',0,TO_DATE('2021-09-28 18:30:09','YYYY-MM-DD HH24:MI:SS'),'D',0)
;

-- Sep 28, 2021 6:33:43 PM MYT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,IsRange,AD_Process_Para_UU,AD_Reference_ID,AD_Val_Rule_ID,IsMandatory,EntityType,CreatedBy,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,Updated,UpdatedBy,IsEncrypted,Created,AD_Client_ID,AD_Element_ID,AD_Process_ID,AD_Org_ID) VALUES (200278,'N','95eb329b-9484-4cdb-aa83-534166ba8288',19,200136,'Y','D',100,'BOM & Formula','PP_Product_BOM_ID','BOM & Formula',10,'Y',30,'@SQL=SELECT PP_Product_BOM_ID FROM PP_Product_BOM WHERE BOMUse=''A'' AND BOMType=''A'' AND IsActive=''Y'' AND AD_Client_ID=@#AD_Client_ID@ AND AD_Org_ID IN (0,@AD_Org_ID@) ORDER BY AD_Org_ID Desc LIMIT 1','Y',TO_DATE('2021-09-28 18:33:42','YYYY-MM-DD HH24:MI:SS'),100,'N',TO_DATE('2021-09-28 18:33:42','YYYY-MM-DD HH24:MI:SS'),0,53245,53226,0)
;

-- Sep 28, 2021 8:57:21 PM MYT
UPDATE AD_Process_Para SET DefaultValue='@SQL=SELECT PP_Product_BOM_ID FROM PP_Product_BOM WHERE BOMUse=''A'' AND BOMType=''A'' AND IsActive=''Y'' AND AD_Client_ID=@#AD_Client_ID@ AND AD_Org_ID IN (0,@AD_Org_ID@) ORDER BY AD_Org_ID Desc',Updated=TO_DATE('2021-09-28 20:57:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200278
;

-- Sep 28, 2021 8:57:44 PM MYT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200056, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200056)
;

-- Sep 28, 2021 9:04:59 PM MYT
UPDATE AD_Process_Para SET DefaultValue='@SQL=SELECT PP_Product_BOM_ID FROM PP_Product_BOM WHERE M_Product_ID=@M_Product_ID@ AND BOMUse=''A'' AND BOMType=''A'' AND IsActive=''Y'' AND AD_Client_ID=@#AD_Client_ID@ AND AD_Org_ID IN (0,@AD_Org_ID@) ORDER BY AD_Org_ID Desc',Updated=TO_DATE('2021-09-28 21:04:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200278
;

-- Sep 28, 2021 9:05:15 PM MYT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200057, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200057)
;

-- Sep 29, 2021 10:45:24 AM MYT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Val_Rule_ID,AD_Table_ID,IsToolbarButton,AD_Reference_ID,AD_Org_ID) VALUES (213948,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','3abf2f17-51e0-448d-b6f8-42564b7d5f70',TO_DATE('2021-09-29 10:45:22','YYYY-MM-DD HH24:MI:SS'),'Y','PP_Product_BOM_ID','BOM & Formula','@SQL=SELECT PP_Product_BOM_ID FROM PP_Product_BOM WHERE M_Product_ID=@M_Product_ID@ AND BOMUse=''A'' AND BOMType=''A'' AND IsActive=''Y'' AND AD_Client_ID=@#AD_Client_ID@ AND AD_Org_ID IN (0,@AD_Org_ID@) ORDER BY AD_Org_ID Desc','BOM & Formula','N','Y',100,100,'N',0,TO_DATE('2021-09-29 10:45:22','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',53245,200136,325,'N',19,0)
;

-- Sep 29, 2021 10:45:39 AM MYT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200058, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200058)
;

-- Sep 29, 2021 10:45:41 AM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='PPProductBOM_MProduction',Updated=TO_DATE('2021-09-29 10:45:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213948
;

-- Sep 29, 2021 10:45:41 AM MYT
ALTER TABLE M_Production ADD PP_Product_BOM_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 29, 2021 10:45:42 AM MYT
ALTER TABLE M_Production ADD CONSTRAINT PPProductBOM_MProduction FOREIGN KEY (PP_Product_BOM_ID) REFERENCES pp_product_bom(pp_product_bom_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 29, 2021 10:51:33 AM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,206081,'N',0,'N','N',95,'Y','Y',TO_DATE('2021-09-29 10:51:32','YYYY-MM-DD HH24:MI:SS'),'BOM & Formula','BOM & Formula','390e17df-7857-4cfa-82e4-64e6d29b2a73','Y','N',100,100,'Y','Y',105,1,'N',0,TO_DATE('2021-09-29 10:51:32','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213948,'D',53344,0)
;

-- Sep 29, 2021 11:29:46 AM MYT
UPDATE AD_Process_Para SET DisplayLogic='@IsUseProductionPlan@=N',Updated=TO_DATE('2021-09-29 11:29:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200278
;

UPDATE PP_Product_BOM SET BOMUSE='A' WHERE AD_Client_ID=11 AND BOMType='A' AND IsActive='Y' AND M_Product_ID < 1000000
;

SELECT Register_Migration_Script ('202109291600_IDEMPIERE-1250.sql') FROM DUAL
;

