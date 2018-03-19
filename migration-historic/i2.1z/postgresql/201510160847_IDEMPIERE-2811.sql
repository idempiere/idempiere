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

-- set values for current records on seed:
update m_productprice set m_productprice_id=200000 where m_productprice_uu='ca85b76d-4013-4882-860b-078762e9f694';
update m_productprice set m_productprice_id=200001 where m_productprice_uu='a68cf750-b1b6-4e25-9789-d94cda4d2102';
update m_productprice set m_productprice_id=200002 where m_productprice_uu='db2efe29-dc4c-4eb8-ac9a-49d74849b354';
update m_productprice set m_productprice_id=200003 where m_productprice_uu='0fe45807-c302-426f-bfc8-825eb670f320';
update m_productprice set m_productprice_id=200004 where m_productprice_uu='3799d51e-78ad-4d6b-b0bf-55c13513c483';
update m_productprice set m_productprice_id=200005 where m_productprice_uu='d855d37b-761d-400f-9e3b-14338ffe1f8c';
update m_productprice set m_productprice_id=200006 where m_productprice_uu='85663b7f-8bcd-47cc-8a0d-caadacc586bf';
update m_productprice set m_productprice_id=200007 where m_productprice_uu='49ae2aa7-cc07-4277-abbb-5e6d016b1cdd';
update m_productprice set m_productprice_id=200008 where m_productprice_uu='6a1dbdcb-c320-4f4f-9382-519674d04fdf';
update m_productprice set m_productprice_id=200009 where m_productprice_uu='2c8250ff-7c09-4f4c-a22d-c0d970296eda';
update m_productprice set m_productprice_id=200010 where m_productprice_uu='6400d5a2-dca5-44f1-8b37-a2b64bb1589d';
update m_productprice set m_productprice_id=200011 where m_productprice_uu='f36fac70-79bb-419d-88d8-3877322a52df';
update m_productprice set m_productprice_id=200012 where m_productprice_uu='bac01842-6931-48c1-a3d7-afce388d57de';
update m_productprice set m_productprice_id=200013 where m_productprice_uu='d916eee5-7621-4e26-b67d-d151cccca411';
update m_productprice set m_productprice_id=200014 where m_productprice_uu='5ce04b5e-edcc-407d-bfda-58fb4d6c4312';
update m_productprice set m_productprice_id=200015 where m_productprice_uu='95876f92-39b0-417d-b1c0-4f74c45d694e';
update m_productprice set m_productprice_id=200016 where m_productprice_uu='ab7d9fab-d4c2-4549-b20a-20a67a877948';
update m_productprice set m_productprice_id=200017 where m_productprice_uu='53b69545-8ffc-4be5-b09c-2c4cc39a2fbd';
update m_productprice set m_productprice_id=200018 where m_productprice_uu='3b704ef3-9382-4e58-8300-5153ce8cceaf';
update m_productprice set m_productprice_id=200019 where m_productprice_uu='d68cfe48-8b4d-4c18-84fa-9fc089e455b6';
update m_productprice set m_productprice_id=200020 where m_productprice_uu='cf0e6cfe-e32f-4911-aa50-595699d2dda5';
update m_productprice set m_productprice_id=200021 where m_productprice_uu='dd565dcf-cbaf-48db-ad67-edc1bfa332e3';
update m_productprice set m_productprice_id=200022 where m_productprice_uu='e8337bd6-1ea4-45c1-8fa0-b361b6c182ff';
update m_productprice set m_productprice_id=200023 where m_productprice_uu='41834a2b-81d6-4792-ab49-217b3da5a618';
update m_productprice set m_productprice_id=200024 where m_productprice_uu='5dd707c4-e509-43a6-893f-9c17735bab2c';
update m_productprice set m_productprice_id=200025 where m_productprice_uu='85477327-f224-4942-906c-dffdc978284f';
update m_productprice set m_productprice_id=200026 where m_productprice_uu='4fc08721-c835-49ba-8929-88528a795df3';
update m_productprice set m_productprice_id=200027 where m_productprice_uu='b1c811a0-930a-4f43-9e48-99e29e762a4c';
update m_productprice set m_productprice_id=200028 where m_productprice_uu='a3bec380-a322-4076-a202-6739e7cda68a';
update m_productprice set m_productprice_id=200029 where m_productprice_uu='50bc2ec9-9df1-4c67-b54a-f5c54b615761';
update m_productprice set m_productprice_id=200030 where m_productprice_uu='b5e874fd-0d20-4cdf-a804-ca93e0ab15b5';
update m_productprice set m_productprice_id=200031 where m_productprice_uu='f6c1af47-dcc2-431f-9f28-f8d97407352d';
update m_productprice set m_productprice_id=200032 where m_productprice_uu='4676f1bf-b4cd-4270-b4f4-be93935ac692';
update m_productprice set m_productprice_id=200033 where m_productprice_uu='f309a3ca-45c2-411f-9d3e-cd7393563da3';
update m_productprice set m_productprice_id=200034 where m_productprice_uu='7dabe715-bb09-4aa7-8b12-eb55d9187fce';
update m_productprice set m_productprice_id=200035 where m_productprice_uu='28d2c8a6-31c7-473b-b1f6-169a293e0ed4';
update m_productprice set m_productprice_id=200036 where m_productprice_uu='f2bce1f3-eabc-4ee4-9843-81308e3166b7';
update m_productprice set m_productprice_id=200037 where m_productprice_uu='661c60d4-4682-45ea-85a7-d92f30b375fd';
update m_productprice set m_productprice_id=200038 where m_productprice_uu='b54e03bf-7dae-4e32-b36c-a54979a7ebbd';
update m_productprice set m_productprice_id=200039 where m_productprice_uu='c1d4d374-c02a-4c7d-b62c-5ac811f4da65';
update m_productprice set m_productprice_id=200040 where m_productprice_uu='459ebe02-850a-4978-97dc-7167bd984db1';
update m_productprice set m_productprice_id=200041 where m_productprice_uu='d18436c9-6ad6-4241-9003-61361b209830';
update m_productprice set m_productprice_id=200042 where m_productprice_uu='1ccd8970-0ee5-41ec-b148-32f416c91358';
update m_productprice set m_productprice_id=200043 where m_productprice_uu='1667419f-9a22-4c99-aef3-652342d1f2ba';
update m_productprice set m_productprice_id=200044 where m_productprice_uu='6eeef018-4bd9-4afc-81e0-50b904c745a1';
update m_productprice set m_productprice_id=200045 where m_productprice_uu='9ff167db-9afd-4ee3-bfde-3c2f86195f07';
update m_productprice set m_productprice_id=200046 where m_productprice_uu='6eb86169-7162-459d-b4d1-efd3c5d79f43';
update m_productprice set m_productprice_id=200047 where m_productprice_uu='02594b07-9001-4215-95ae-54aa1546013d';
update m_productprice set m_productprice_id=200048 where m_productprice_uu='db9b7dd6-cb32-4c72-958d-bfa1eb25d170';
update m_productprice set m_productprice_id=200049 where m_productprice_uu='d745376f-a9c4-4a84-85ef-c9ed29770e8f';
update m_productprice set m_productprice_id=200050 where m_productprice_uu='410aa0f2-7e6b-4b95-a59a-d8596757bba1';
update m_productprice set m_productprice_id=200051 where m_productprice_uu='5f1738cf-fe56-45ae-afdd-8118c9b99c2f';
update m_productprice set m_productprice_id=200052 where m_productprice_uu='65e29aa5-0bde-4fed-967e-e24c3aed54b5';
update m_productprice set m_productprice_id=200053 where m_productprice_uu='1064ade5-e4dc-4990-8ca1-bdcfab780c38';
update m_productprice set m_productprice_id=200054 where m_productprice_uu='c21ba71d-2af8-4ed5-8e68-88f221f760f1';
update m_productprice set m_productprice_id=200055 where m_productprice_uu='5deacdbc-75aa-412f-abf8-ee8fde7c711b';
update m_productprice set m_productprice_id=200056 where m_productprice_uu='05d61d84-8d12-40c9-bcf2-6d3a47af330b';
update m_productprice set m_productprice_id=200057 where m_productprice_uu='1d85767d-a689-4391-874a-4595db5f29e4';
update m_productprice set m_productprice_id=200058 where m_productprice_uu='5133d210-b8ba-4bc8-b32c-3d8b6fcba09e';
update m_productprice set m_productprice_id=200059 where m_productprice_uu='9c14e2e4-7466-43c7-9c1d-29c0dfbb2304';
update m_productprice set m_productprice_id=200060 where m_productprice_uu='7cf9318b-b81e-4829-9f08-75af1901169e';
update m_productprice set m_productprice_id=200061 where m_productprice_uu='471b007a-68e2-446c-9ad6-e31f34c8d499';
update m_productprice set m_productprice_id=200062 where m_productprice_uu='e0e8e5c0-9d04-4357-a551-5388b40faa9c';
update m_productprice set m_productprice_id=200063 where m_productprice_uu='3830a325-6c61-46b6-8e2f-ef34209420de';
update m_productprice set m_productprice_id=200064 where m_productprice_uu='b0f4cc83-2c67-4137-a654-5e2db60abac1';
update m_productprice set m_productprice_id=200065 where m_productprice_uu='9a8b097b-8094-443b-a190-e5316276481f';
update m_productprice set m_productprice_id=200066 where m_productprice_uu='515d300f-487d-4016-b639-4ea606b3fddf';
update m_productprice set m_productprice_id=200067 where m_productprice_uu='2d99e2be-82ca-4ac9-84ff-8b00d9d96e69';
update m_productprice set m_productprice_id=200068 where m_productprice_uu='63b54d84-8216-4b88-9d30-c4361a0dab1c';
update m_productprice set m_productprice_id=200069 where m_productprice_uu='773e544a-a274-43b2-a911-436619eb2438';
update m_productprice set m_productprice_id=200070 where m_productprice_uu='18013200-0b98-4156-94a3-9d0775dff675';
update m_productprice set m_productprice_id=200071 where m_productprice_uu='9757a398-0a80-401a-8d16-1cfe66df9274';
update m_productprice set m_productprice_id=200072 where m_productprice_uu='b443759d-1a74-433a-8224-37911bd647f1';
update m_productprice set m_productprice_id=200073 where m_productprice_uu='22bd20b3-e605-4a6b-b65f-04f8e821840e';
update m_productprice set m_productprice_id=200074 where m_productprice_uu='10af5c34-36e6-4d63-af2a-346e22496d31';
update m_productprice set m_productprice_id=200075 where m_productprice_uu='dba93922-b587-4b3b-bab2-648c1665d6fd';
update m_productprice set m_productprice_id=200076 where m_productprice_uu='50757485-d5f2-490f-b25b-a4376fcc8283';
update m_productprice set m_productprice_id=200077 where m_productprice_uu='b39ee3c8-4d2d-4bf4-a33d-1eef243dbc55';
update m_productprice set m_productprice_id=200078 where m_productprice_uu='4bc87139-1019-47b1-b1a0-269f5987b0f7';
update m_productprice set m_productprice_id=200079 where m_productprice_uu='4a6fe9f3-f915-42ba-b239-dd8a67e30c6c';
update m_productprice set m_productprice_id=200080 where m_productprice_uu='6cd4fc6d-a668-4edb-a28f-a43c93ef4009';
update m_productprice set m_productprice_id=200081 where m_productprice_uu='8d07f8a1-c668-4f60-9c26-51ca94ba5179';
update m_productprice set m_productprice_id=200082 where m_productprice_uu='0a9d69fa-7f4f-4561-a462-639a0cbed724';
update m_productprice set m_productprice_id=200083 where m_productprice_uu='b362fd8f-0e3d-4fd6-9647-6179ba9bd721';
update m_productprice set m_productprice_id=200084 where m_productprice_uu='8b41a05a-37bf-47a0-957c-23f5eb6e2e53';
update m_productprice set m_productprice_id=200085 where m_productprice_uu='ecefead2-aea3-48ff-b358-b7663304e429';

--Chuck added here
--set the values for the keys
-- !! too slow without native sequences !! -- update m_productprice set m_productprice_id = nextIdFunc(165,'N') where m_productprice_id is null;
--165 = select ad_sequence_id from ad_sequence where name = 'M_ProductPrice' and istableID='Y'
update m_productprice
set m_productprice_id=rownum
from (
SELECT m_pricelist_version_id, m_product_id
	, 999999+ROW_NUMBER() OVER (ORDER BY m_pricelist_version_id, m_product_id) AS rownum
FROM
	m_productprice
where m_productprice_id is null
) as numbered
WHERE numbered.m_pricelist_version_id=m_productprice.m_pricelist_version_id
and numbered.m_product_id=m_productprice.m_product_id
;

-- for native sequences is also updated using processes_post_migration/postgresql/03_update_sequences.sql
update ad_sequence set currentnext=(select max(m_productprice_id) from m_productprice) where ad_sequence_id=165
;

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

