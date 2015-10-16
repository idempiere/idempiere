-- IDEMPIERE-2811 Each Record should have a primary key
-- Oct 8, 2015 2:03:10 PM CDT
UPDATE AD_Table SET IsChangeLog='Y',Updated=TO_TIMESTAMP('2015-10-08 14:03:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=251
;

-- Oct 8, 2015 2:05:05 PM CDT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (202909,0,0,'Y',TO_TIMESTAMP('2015-10-08 14:04:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 14:04:59','YYYY-MM-DD HH24:MI:SS'),100,'M_ProductPrice_ID','Product Price','Intersection between a Product and a Price List Version','Product Price','D','b731d80c-41bb-49c7-a7e7-607b0282f589')
;

-- Oct 8, 2015 2:06:58 PM CDT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212276,0,'Product Price','Intersection between a Product and a Price List Version',251,'M_ProductPrice_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2015-10-08 14:06:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 14:06:53','YYYY-MM-DD HH24:MI:SS'),100,202909,'N','N','D','N','N','N','Y','1360b74a-aa47-40a1-a882-63d7de49b337','N',0,'N','N')
;

-- Oct 8, 2015 2:07:06 PM CDT
ALTER TABLE M_ProductPrice ADD COLUMN M_ProductPrice_ID NUMERIC(10) DEFAULT NULL 
;

--Chuck added here
--drop current primary key
alter table m_productprice drop constraint m_productprice_pkey;

--Chuck added here
--set the values for the keys
update m_productprice set m_productprice_id = nextIdFunc(165,'N'); 
--165 = select ad_sequence_id from ad_sequence where name = 'M_ProductPrice' and istableID='Y'

-- Oct 8, 2015 2:07:06 PM CDT
ALTER TABLE M_ProductPrice ADD CONSTRAINT M_ProductPrice_Key PRIMARY KEY (M_ProductPrice_ID)
;

-- Oct 8, 2015 2:14:47 PM CDT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201038,'d3ad099b-7d97-4d27-b915-45d1f455b225',TO_TIMESTAMP('2015-10-08 14:14:47','YYYY-MM-DD HH24:MI:SS'),100,'Create a unique index between a Product and a Price List Version','D','Y','m_productprice_unique_idx',TO_TIMESTAMP('2015-10-08 14:14:47','YYYY-MM-DD HH24:MI:SS'),100,251,'Y','Y','N','N','N')
;

-- Oct 8, 2015 2:15:48 PM CDT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201270,'66d9bca2-0d32-4766-8ef5-6c7bf2eb8802',TO_TIMESTAMP('2015-10-08 14:15:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2015-10-08 14:15:43','YYYY-MM-DD HH24:MI:SS'),100,2760,201038,10)
;

-- Oct 8, 2015 2:16:05 PM CDT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201271,'001e971a-88e7-4230-aca3-a3d8e4c59b12',TO_TIMESTAMP('2015-10-08 14:16:05','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2015-10-08 14:16:05','YYYY-MM-DD HH24:MI:SS'),100,2064,201038,20)
;

-- Oct 8, 2015 2:16:13 PM CDT
ALTER TABLE M_ProductPrice ADD CONSTRAINT m_productprice_unique_idx UNIQUE (M_PriceList_Version_ID,M_Product_ID)
;

-- Oct 8, 2015 2:23:10 PM CDT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203893,'Product Price','Intersection between a Product and a Price List Version',183,212276,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-08 14:23:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 14:23:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb261ad2-c016-4281-adc9-c16742b0c125','N',2)
;

-- Oct 8, 2015 2:23:52 PM CDT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203894,'Product Price','Intersection between a Product and a Price List Version',192,212276,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-08 14:23:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 14:23:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1b98cc19-95b3-4f55-8b68-d9d4cea960ee','N',2)
;

-- Oct 8, 2015 2:24:12 PM CDT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203895,'Product Price','Intersection between a Product and a Price List Version',420,212276,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-08 14:24:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 14:24:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c4997db2-b72c-45bd-812a-1869a7c0d090','N',2)
;

-- Oct 8, 2015 2:24:45 PM CDT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (203896,'Product Price','Intersection between a Product and a Price List Version',421,212276,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-10-08 14:24:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-10-08 14:24:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','be6c8292-76b4-46f4-af5e-c991463c85d8','N',2)
;

SELECT register_migration_script('201510160847_IDEMPIERE-2811.sql') FROM dual
;

