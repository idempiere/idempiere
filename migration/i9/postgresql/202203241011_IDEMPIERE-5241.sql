-- IDEMPIERE-5241
SELECT register_migration_script('202203241011_IDEMPIERE-5241.sql') FROM dual;

-- Mar 24, 2022, 10:11:28 AM CET
UPDATE AD_Column SET ValueMin='1', IsToolbarButton='N',Updated=TO_TIMESTAMP('2022-03-24 10:11:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=59698
;

-- Mar 24, 2022, 10:11:43 AM CET
UPDATE AD_Column SET MandatoryLogic='@IsTimeSeries@ = Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2022-03-24 10:11:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=59903
;

-- Mar 24, 2022, 10:12:26 AM CET
UPDATE AD_Column SET DefaultValue=NULL, IsMandatory='N', IsToolbarButton='N',Updated=TO_TIMESTAMP('2022-03-24 10:12:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=59685
;

-- Mar 24, 2022, 10:12:28 AM CET
INSERT INTO t_alter_column values('ad_chartdatasource','WhereClause','VARCHAR(2000)',null,'NULL')
;

-- Mar 24, 2022, 10:12:28 AM CET
INSERT INTO t_alter_column values('ad_chartdatasource','WhereClause',null,'NULL',null)
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59597
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59596
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59598
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59599
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59600
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59673
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59679
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=202479
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59601
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59602
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59674
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59680
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59675
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59676
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59677
;

-- Mar 24, 2022, 10:12:58 AM CET
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=0 WHERE AD_Field_ID=59603
;

