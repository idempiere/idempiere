SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 8, 2013 10:45:41 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-10-08 10:45:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11125
;

-- Oct 8, 2013 10:45:41 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=90, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2013-10-08 10:45:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12171
;

-- Oct 8, 2013 10:45:41 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2013-10-08 10:45:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11129
;

-- Oct 8, 2013 10:45:41 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=110, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-10-08 10:45:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11126
;

-- Oct 8, 2013 10:46:24 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-10-08 10:46:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11137
;

-- Oct 8, 2013 10:46:24 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2013-10-08 10:46:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12172
;

-- Oct 8, 2013 10:46:24 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=90, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-10-08 10:46:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11141
;

-- Oct 8, 2013 10:46:24 AM MYT
-- IDEMPIERE-1285 Estimated Landed Cost for PO
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-10-08 10:46:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11138
;

SELECT register_migration_script('201310080300_IDEMPIERE-1285.sql') FROM dual
;

