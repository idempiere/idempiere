-- IDEMPIERE-6575
SELECT register_migration_script('202506121038_IDEMPIERE-6575.sql') FROM dual;

-- Jun 12, 2025, 10:38:48 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204008,0,0,'Y',TO_TIMESTAMP('2025-06-12 10:38:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-12 10:38:48','YYYY-MM-DD HH24:MI:SS'),100,'SequenceKey','Sequence Key','Stores a unique key that determines the sequence numbering scope.','The key can be composed of various elements like organization, year/month, prefix, or suffix values based on the Document Sequence configuration.','Sequence Key','D','60e33002-4a95-490b-a0c1-a0c769c10f98')
;

-- Jun 12, 2025, 10:39:40 AM CEST
ALTER TABLE AD_Sequence_No RENAME COLUMN CalendarYearMonth TO SequenceKey
;

-- Jun 12, 2025, 10:39:40 AM CEST
UPDATE AD_Column SET Name='Sequence Key', Description='Stores a unique key that determines the sequence numbering scope.', Help='The key can be composed of various elements like organization, year/month, prefix, or suffix values based on the Document Sequence configuration.', ColumnName='SequenceKey', AD_Element_ID=204008, IsUpdateable='N', Placeholder=NULL,Updated=TO_TIMESTAMP('2025-06-12 10:39:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=262
;

-- Jun 12, 2025, 10:42:41 AM CEST
UPDATE AD_Field SET Name='Sequence Key', Description='Stores a unique key that determines the sequence numbering scope.', Help='The key can be composed of various elements like organization, year/month, prefix, or suffix values based on the Document Sequence configuration.',Updated=TO_TIMESTAMP('2025-06-12 10:42:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200047
;

-- Jun 12, 2025, 3:32:22 PM CEST
UPDATE AD_Column SET FieldLength=255, IsUpdateable='N',Updated=TO_TIMESTAMP('2025-06-12 15:32:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=262
;

-- Jun 12, 2025, 3:32:24 PM CEST
INSERT INTO t_alter_column values('ad_sequence_no','SequenceKey','VARCHAR(255)',null,null)
;

