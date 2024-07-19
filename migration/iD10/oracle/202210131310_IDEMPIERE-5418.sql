-- IDEMPIERE-5418 Add Translation for AD_ChartDatasource
SELECT register_migration_script('202210131310_IDEMPIERE-5418.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 13, 2022, 1:10:18 PM CEST
UPDATE AD_ChartDatasource SET FromClause='C_Opportunity o
INNER JOIN C_SalesStage s ON (s.C_SalesStage_ID=o.C_SalesStage_ID)
LEFT JOIN C_SalesStage_Trl st ON (st.C_SalesStage_ID = s.C_SalesStage_ID AND st.AD_Language=''@#AD_Language@'')', CategoryColumn='s.Value || ''. '' || COALESCE(st.Name, s.Name)',Updated=TO_TIMESTAMP('2022-10-13 13:10:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50000
;

-- Oct 13, 2022, 1:10:47 PM CEST
UPDATE AD_ChartDatasource SET FromClause='C_Opportunity o
INNER JOIN C_SalesStage s ON (s.C_SalesStage_ID=o.C_SalesStage_ID)
LEFT JOIN C_SalesStage_Trl st ON (st.C_SalesStage_ID = s.C_SalesStage_ID AND st.AD_Language=''@#AD_Language@'')', CategoryColumn='s.Value || ''. '' || COALESCE(st.Name, s.Name)',Updated=TO_TIMESTAMP('2022-10-13 13:10:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50002
;

-- Oct 13, 2022, 1:12:04 PM CEST
UPDATE AD_ChartDatasource SET FromClause='C_Opportunity o
INNER JOIN C_SalesStage s ON (s.C_SalesStage_ID=o.C_SalesStage_ID)
INNER JOIN C_Campaign c ON (o.C_Campaign_ID=c.C_Campaign_ID)
LEFT JOIN C_Campaign_Trl ct ON (ct.C_Campaign_ID = c.C_Campaign_ID AND ct.AD_Language=''@#AD_Language@'')', CategoryColumn='COALESCE(ct.Name, c.Name)',Updated=TO_TIMESTAMP('2022-10-13 13:12:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50001
;

-- Oct 13, 2022, 1:16:05 PM CEST
UPDATE AD_ChartDatasource SET FromClause='R_Request r
INNER JOIN R_RequestType rt ON (rt.R_RequestType_ID=r.R_RequestType_ID)
INNER JOIN R_Status rs ON (r.R_Status_ID=rs.R_Status_ID)
INNER JOIN AD_Ref_List l ON (l.AD_Reference_ID=154 AND l.Value=r.Priority)
LEFT JOIN AD_Ref_List_Trl lt ON (lt.AD_Ref_List_ID=l.AD_Ref_List_ID AND AD_Language=''@#AD_Language@'')', SeriesColumn='(l.Value || '' '' || COALESCE(lt.Name, l.Name))',Updated=TO_TIMESTAMP('2022-10-13 13:16:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ChartDatasource_ID=50005
;

-- Oct 13, 2022, 1:29:42 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintType='C',Updated=TO_TIMESTAMP('2022-10-13 13:29:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215306
;

-- Oct 13, 2022, 1:29:44 PM CEST
ALTER TABLE AD_ChartDatasource_Trl MODIFY AD_ChartDatasource_ID NUMBER(10)
;

-- Oct 13, 2022, 1:29:44 PM CEST
ALTER TABLE AD_ChartDatasource_Trl DROP CONSTRAINT adchartdatasourceadchartdatas
;

-- Oct 13, 2022, 1:29:44 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD CONSTRAINT ADChartDatasourceADChartDatas FOREIGN KEY (AD_ChartDatasource_ID) REFERENCES ad_chartdatasource(ad_chartdatasource_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;
