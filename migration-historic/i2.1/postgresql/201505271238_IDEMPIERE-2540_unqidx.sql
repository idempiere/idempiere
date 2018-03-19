-- IDEMPIERE-2540 unique index on price break
-- May 27, 2015 12:33:21 PM COT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201036,'ab4b4d97-9364-451d-9c1d-dbaf2585ff5c',TO_TIMESTAMP('2015-05-27 12:33:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','m_productpricevendorbreak_unq',TO_TIMESTAMP('2015-05-27 12:33:21','YYYY-MM-DD HH24:MI:SS'),100,53172,'N','Y','N','N','N')
;

-- May 27, 2015 12:35:21 PM COT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201265,'72bb9352-bf69-4ecf-b170-d6107de2fabb',TO_TIMESTAMP('2015-05-27 12:35:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2015-05-27 12:35:21','YYYY-MM-DD HH24:MI:SS'),100,56922,201036,10)
;

-- May 27, 2015 12:35:42 PM COT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201266,'e96ed24c-ed98-4aa2-89a2-47e5779043a7',TO_TIMESTAMP('2015-05-27 12:35:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2015-05-27 12:35:41','YYYY-MM-DD HH24:MI:SS'),100,201036,'COALESCE(C_BPartner_ID,-1)',20)
;

-- May 27, 2015 12:36:09 PM COT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201267,'12feebe5-ace2-4a3a-8f3a-0a6228157967',TO_TIMESTAMP('2015-05-27 12:36:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2015-05-27 12:36:08','YYYY-MM-DD HH24:MI:SS'),100,56921,201036,30)
;

-- May 27, 2015 12:36:18 PM COT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201268,'7ce72777-6a11-4734-bda5-9c1fc2156a13',TO_TIMESTAMP('2015-05-27 12:36:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2015-05-27 12:36:18','YYYY-MM-DD HH24:MI:SS'),100,56929,201036,40)
;

-- May 27, 2015 12:36:45 PM COT
CREATE UNIQUE INDEX m_productpricevendorbreak_unq ON M_ProductPriceVendorBreak (M_Product_ID,COALESCE(C_BPartner_ID,-1),M_PriceList_Version_ID,BreakValue)
;

SELECT register_migration_script('201505271238_IDEMPIERE-2540_unqidx.sql') FROM dual
;

