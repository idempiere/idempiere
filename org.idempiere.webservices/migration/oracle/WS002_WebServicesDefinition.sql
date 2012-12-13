-- Jan 30, 2009 7:13:26 PM COT
-- Web Service Definition and Security

INSERT INTO WS_WebService (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,Help,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID) VALUES (0,0,TO_DATE('2009-01-30 19:17:43','YYYY-MM-DD HH24:MI:SS'),100,'Contributed by http://www.globalqss.com - implemented security','This web services are very generic - so it''s necessary to configure the security layer in the web services security window to make them work.  You can take a look to GardenWorld samples.','Y','Model Oriented Web Services',TO_DATE('2009-01-30 19:17:43','YYYY-MM-DD HH24:MI:SS'),100,'ModelADService',50001)
;

INSERT INTO WS_WebServiceMethod (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,Help,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID) VALUES (0,0,TO_DATE('2009-01-30 19:19:03','YYYY-MM-DD HH24:MI:SS'),100,'To invoke corresponding methods of documents when changing document action.','Change DocAction for documents, i.e. Complete a Material Receipt
WARNING! This web service complete documents not via workflow, so it jump over any approval step considered in document workflow.
To complete documents using workflow it''s better to use the runProcess web service','Y','Set Document Action',TO_DATE('2009-01-30 19:19:03','YYYY-MM-DD HH24:MI:SS'),100,'setDocAction',50001,50021)
;

INSERT INTO WS_WebServiceMethod (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID) VALUES (0,0,TO_DATE('2009-01-30 19:19:47','YYYY-MM-DD HH24:MI:SS'),100,'Run a process or report - if the process is a document workflow a document action can be configured','Y','Run Process',TO_DATE('2009-01-30 19:19:47','YYYY-MM-DD HH24:MI:SS'),100,'runProcess',50001,50022)
;

INSERT INTO WS_WebServiceMethod (AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID) VALUES (0,0,TO_DATE('2009-01-30 19:20:02','YYYY-MM-DD HH24:MI:SS'),100,'Y','Get Reference Lists or Reference Tables',TO_DATE('2009-01-30 19:20:02','YYYY-MM-DD HH24:MI:SS'),100,'getList',50001,50023)
;

INSERT INTO WS_WebServiceMethod (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,Help,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID) VALUES (0,0,TO_DATE('2009-01-30 19:21:02','YYYY-MM-DD HH24:MI:SS'),100,'Web Service to create data following the persistence model of Adempiere','Web Service to create data following the persistence model of Adempiere, this is calling properly before/afterSave methods - and configured model validators.','Y','Create Data',TO_DATE('2009-01-30 19:21:02','YYYY-MM-DD HH24:MI:SS'),100,'createData',50001,50024)
;

INSERT INTO WS_WebServiceMethod (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,Help,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID) VALUES (0,0,TO_DATE('2009-01-30 19:21:27','YYYY-MM-DD HH24:MI:SS'),100,'Web Service to modify data following the persistence model of Adempiere','Web Service to modify data following the persistence model of Adempiere, this is calling properly before/afterSave methods - and configured model validators.','Y','Update Data',TO_DATE('2009-01-30 19:21:27','YYYY-MM-DD HH24:MI:SS'),100,'updateData',50001,50025)
;

INSERT INTO WS_WebServiceMethod (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,Help,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID) VALUES (0,0,TO_DATE('2009-01-30 19:21:52','YYYY-MM-DD HH24:MI:SS'),100,'Web Service to delete data following the persistence model of Adempiere','Web Service to delete data following the persistence model of Adempiere, this is calling properly before/afterDelete methods - and configured model validators.','Y','Delete Data',TO_DATE('2009-01-30 19:21:52','YYYY-MM-DD HH24:MI:SS'),100,'deleteData',50001,50026)
;

INSERT INTO WS_WebServiceMethod (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID) VALUES (0,0,TO_DATE('2009-01-30 19:22:22','YYYY-MM-DD HH24:MI:SS'),100,'Access a record via its ID and return the corresponding data','Y','Read Data',TO_DATE('2009-01-30 19:22:22','YYYY-MM-DD HH24:MI:SS'),100,'readData',50001,50027)
;

INSERT INTO WS_WebServiceMethod (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,Name,Updated,UpdatedBy,Value,WS_WebService_ID,WS_WebServiceMethod_ID) VALUES (0,0,TO_DATE('2009-01-30 19:22:50','YYYY-MM-DD HH24:MI:SS'),100,'Access records via conditions on columns - return data rows','Y','Query Data',TO_DATE('2009-01-30 19:22:50','YYYY-MM-DD HH24:MI:SS'),100,'queryData',50001,50028)
;

SELECT register_migration_script('WS002_WebServicesDefinition.sql') FROM dual
;