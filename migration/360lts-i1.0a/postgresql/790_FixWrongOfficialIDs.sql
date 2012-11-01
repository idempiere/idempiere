delete from M_DistributionRunLine where M_DistributionRunLine_ID=1000000 and ad_client_id=11 and M_DistributionList_ID=1000000;

delete from M_DistributionListLine where M_DistributionListLine_ID IN (1000000,1000001,1000002) and ad_client_id=11 and M_DistributionList_ID=1000000;

delete from M_DistributionList where M_DistributionList_ID=1000000 and ad_client_id=11 and name='DistributionA';

delete from AD_ImpFormat_Row where AD_ImpFormat_Row_ID IN (1000000,1000001,1000002,1000003,1000004,1000005,1000006,1000007,1000008,1000009,1000010,1000011) and ad_client_id=11;

delete from AD_ImpFormat where AD_ImpFormat_id IN (1000000,1000001) and ad_client_id=11;


INSERT INTO AD_ImpFormat(ad_impformat_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, name, description, ad_table_id, formattype, processing, separatorchar)
  VALUES(50004, 11, 0, 'Y', TO_TIMESTAMP('2004-03-30 16:35:43', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-03-30 16:36:10', 'YYYY-MM-DD HH24:MI:SS'), 100, 'Example Order', 'Garden World Example Order', 591, 'C', 'N', NULL);
INSERT INTO AD_ImpFormat(ad_impformat_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, name, description, ad_table_id, formattype, processing, separatorchar)
  VALUES(50005, 11, 0, 'Y', TO_TIMESTAMP('2004-04-02 15:40:00', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-02 15:40:00', 'YYYY-MM-DD HH24:MI:SS'), 100, 'Example Invoice', 'Example Invoice for Garden World', 598, 'C', 'N', NULL);

INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50094, 11, 0, 'Y', TO_TIMESTAMP('2004-03-30 16:37:23', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-03-30 16:37:23', 'YYYY-MM-DD HH24:MI:SS'), 100, 50004, 10, 'Document Type Name', 9036, 1, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50095, 11, 0, 'Y', TO_TIMESTAMP('2004-03-30 16:38:49', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-03-30 16:38:49', 'YYYY-MM-DD HH24:MI:SS'), 100, 50004, 20, 'Is Sales Order Transaction', 9040, 2, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50096, 11, 0, 'Y', TO_TIMESTAMP('2004-03-30 16:39:07', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-03-30 16:39:07', 'YYYY-MM-DD HH24:MI:SS'), 100, 50004, 30, 'Business Partner Value', 8994, 3, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50097, 11, 0, 'Y', TO_TIMESTAMP('2004-03-30 16:39:29', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-03-30 16:39:29', 'YYYY-MM-DD HH24:MI:SS'), 100, 50004, 40, 'Product Value', 9037, 4, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50098, 11, 0, 'Y', TO_TIMESTAMP('2004-03-30 16:39:53', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-03-30 16:39:53', 'YYYY-MM-DD HH24:MI:SS'), 100, 50004, 50, 'Quantity Ordered', 9028, 5, 0, 'N', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50099, 11, 0, 'Y', TO_TIMESTAMP('2004-04-02 15:39:27', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-02 15:39:27', 'YYYY-MM-DD HH24:MI:SS'), 100, 109, 160, 'ConversionType', 10293, 0, 0, 'C', NULL, '.', 'N', 'S', NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50100, 11, 0, 'Y', TO_TIMESTAMP('2004-04-02 15:41:07', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-02 15:41:07', 'YYYY-MM-DD HH24:MI:SS'), 100, 50005, 10, 'Document Type Name', 9219, 1, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50101, 11, 0, 'Y', TO_TIMESTAMP('2004-04-02 15:41:26', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-02 15:41:26', 'YYYY-MM-DD HH24:MI:SS'), 100, 50005, 20, 'IS Sales Order Transaction', 9202, 2, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50102, 11, 0, 'Y', TO_TIMESTAMP('2004-04-02 15:41:40', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-02 15:41:40', 'YYYY-MM-DD HH24:MI:SS'), 100, 50005, 30, 'Business Partner', 9192, 3, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50103, 11, 0, 'Y', TO_TIMESTAMP('2004-04-02 15:41:53', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-02 15:41:53', 'YYYY-MM-DD HH24:MI:SS'), 100, 50005, 40, 'Product', 9178, 4, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50104, 11, 0, 'Y', TO_TIMESTAMP('2004-04-02 15:42:13', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-02 15:42:13', 'YYYY-MM-DD HH24:MI:SS'), 100, 50005, 50, 'Quantity', 9177, 5, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);
INSERT INTO AD_ImpFormat_Row(ad_impformat_row_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, ad_impformat_id, seqno, name, ad_column_id, startno, endno, datatype, dataformat, decimalpoint, divideby100, constantvalue, callout, script)
  VALUES(50105, 11, 0, 'Y', TO_TIMESTAMP('2004-04-02 15:42:32', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-02 15:42:32', 'YYYY-MM-DD HH24:MI:SS'), 100, 50005, 60, 'Document Number', 9187, 6, 0, 'S', NULL, '.', 'N', NULL, NULL, NULL);

INSERT INTO M_DistributionList(m_distributionlist_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, name, description, help, ratiototal, processing)
  VALUES(50000, 11, 11, 'Y', TO_TIMESTAMP('2004-04-01 19:41:12', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-01 19:41:12', 'YYYY-MM-DD HH24:MI:SS'), 100, 'DistributionA', NULL, NULL, 80, 'N');

INSERT INTO M_DistributionListLine(m_distributionlistline_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, m_distributionlist_id, c_bpartner_id, c_bpartner_location_id, minqty, ratio, description)
  VALUES(50000, 11, 11, 'Y', TO_TIMESTAMP('2004-04-01 19:41:33', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-01 19:41:33', 'YYYY-MM-DD HH24:MI:SS'), 100, 50000, 118, 113, 0, 50, NULL);
INSERT INTO M_DistributionListLine(m_distributionlistline_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, m_distributionlist_id, c_bpartner_id, c_bpartner_location_id, minqty, ratio, description)
  VALUES(50001, 11, 11, 'Y', TO_TIMESTAMP('2004-04-01 19:41:42', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-01 19:41:42', 'YYYY-MM-DD HH24:MI:SS'), 100, 50000, 117, 112, 0, 10, NULL);
INSERT INTO M_DistributionListLine(m_distributionlistline_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, m_distributionlist_id, c_bpartner_id, c_bpartner_location_id, minqty, ratio, description)
  VALUES(50002, 11, 11, 'Y', TO_TIMESTAMP('2004-04-01 19:41:51', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-01 19:41:51', 'YYYY-MM-DD HH24:MI:SS'), 100, 50000, 114, 109, 0, 20, NULL);

INSERT INTO M_DistributionRunLine(m_distributionrunline_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, m_distributionrun_id, line, description, m_distributionlist_id, m_product_id, totalqty, minqty)
  VALUES(50000, 11, 11, 'Y', TO_TIMESTAMP('2004-04-01 19:42:44', 'YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2004-04-01 19:42:44', 'YYYY-MM-DD HH24:MI:SS'), 100, 100, 10, NULL, 50000, 136, 1500, 200);

