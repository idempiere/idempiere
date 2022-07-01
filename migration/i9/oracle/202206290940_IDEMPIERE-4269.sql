SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4269
-- 29.06.2022 09:17:31
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203610,0,0,'Y',TO_DATE('2022-06-29 09:17:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-06-29 09:17:25','YYYY-MM-DD HH24:MI:SS'),100,'SubtractOnHand','Subtract In Progress Shipment From On Hand','Subtract In Progress Shipment From On Hand','Subtract In Progress Shipment From On Hand','D','f09a7fa9-83fc-4644-85b2-b610c51b2fe0')
;

-- 29.06.2022 09:21:02
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200387,0,0,'Y',TO_DATE('2022-06-29 09:20:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-06-29 09:20:57','YYYY-MM-DD HH24:MI:SS'),100,'Subtract In Progress Shipment From On Hand','Subtract In Progress Shipment From On Hand',118,70,20,'N',0,'N','N','SubtractOnHand','Y','D',203610,'159af26e-2742-445b-b847-d58bbfbbb24f','N','N')
;

-- 29.06.2022 09:32:35
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201124,'93a3dcd5-88ef-4d3a-bd60-03d52149b80b',TO_DATE('2022-06-29 09:32:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','m_inout_docstatus',TO_DATE('2022-06-29 09:32:30','YYYY-MM-DD HH24:MI:SS'),100,319,'N','N','N','N','N')
;

-- 29.06.2022 09:36:53
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201503,'e311a6c6-fa5b-4763-8462-a0845164c255',TO_DATE('2022-06-29 09:36:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2022-06-29 09:36:48','YYYY-MM-DD HH24:MI:SS'),100,4323,201124,10)
;

-- 29.06.2022 09:37:14
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201504,'407f09d0-60e2-45a1-895a-abe894e1c2c1',TO_DATE('2022-06-29 09:37:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2022-06-29 09:37:14','YYYY-MM-DD HH24:MI:SS'),100,3790,201124,20)
;

-- 29.06.2022 09:37:29
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201505,'f46b4b2b-ed50-4142-bfec-c0cd55f15c4a',TO_DATE('2022-06-29 09:37:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2022-06-29 09:37:24','YYYY-MM-DD HH24:MI:SS'),100,3798,201124,30)
;

-- 29.06.2022 09:37:43
CREATE INDEX m_inout_docstatus ON M_InOut (DocStatus,IsSOTrx,M_Warehouse_ID)
;

SELECT register_migration_script('202206290940_IDEMPIERE-4269.sql') FROM dual
;