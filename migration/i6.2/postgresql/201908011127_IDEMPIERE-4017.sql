-- IDEMPIERE-4017  Create a Unique Key case/accent insensitive to AD_Table.TableName (FHCA-1005)
-- Aug 1, 2019, 10:56:57 AM CEST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2019-08-01 10:56:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210545
;

-- Aug 1, 2019, 10:57:57 AM CEST
UPDATE AD_IndexColumn SET AD_Column_ID=NULL, ColumnSQL='UPPER(TableName)',Updated=TO_TIMESTAMP('2019-08-01 10:57:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200242
;

-- Aug 1, 2019, 10:58:35 AM CEST
DROP INDEX ad_table_name
;

-- Aug 1, 2019, 10:58:35 AM CEST
CREATE UNIQUE INDEX ad_table_name ON AD_Table (UPPER(TableName))
;

-- Aug 1, 2019, 11:44:05 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invalid identifier: empty',0,0,'Y',TO_TIMESTAMP('2019-08-01 11:44:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-01 11:44:04','YYYY-MM-DD HH24:MI:SS'),100,200515,'InvalidIdentifierEmpty','D','b590389d-3397-40be-9b8d-46546c50ba47')
;

-- Aug 1, 2019, 11:44:26 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invalid identifier: must not contain spaces',0,0,'Y',TO_TIMESTAMP('2019-08-01 11:44:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-01 11:44:25','YYYY-MM-DD HH24:MI:SS'),100,200516,'InvalidIdentifierSpaces','D','6c46585b-8a0d-410e-a0d8-5eb588bdfee5')
;

-- Aug 1, 2019, 11:44:39 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invalid identifier: first character must be alphabetic',0,0,'Y',TO_TIMESTAMP('2019-08-01 11:44:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-01 11:44:39','YYYY-MM-DD HH24:MI:SS'),100,200517,'InvalidIdentifierFirstCharAlpha','D','c83578cb-5af4-427b-aab2-224b45b65620')
;

-- Aug 1, 2019, 11:45:06 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invalid identifier: just alphanumeric and underscore characters are allowed',0,0,'Y',TO_TIMESTAMP('2019-08-01 11:45:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-08-01 11:45:06','YYYY-MM-DD HH24:MI:SS'),100,200518,'InvalidIdentifierJustAlpha','D','f87e4c12-ce8d-464f-a1f7-201529ffa7a8')
;

-- Aug 1, 2019, 11:59:00 AM CEST
UPDATE AD_IndexColumn SET AD_Column_ID=NULL, ColumnSQL='UPPER(ColumnName)',Updated=TO_TIMESTAMP('2019-08-01 11:59:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=200068
;

-- Aug 1, 2019, 11:59:04 AM CEST
DROP INDEX ad_column_name
;

-- Aug 1, 2019, 11:59:04 AM CEST
CREATE UNIQUE INDEX ad_column_name ON AD_Column (AD_Table_ID,UPPER(ColumnName))
;

-- Aug 1, 2019, 12:00:09 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201073,'f4182255-8184-4cfd-9fc1-fb8b19d3aaf6',TO_TIMESTAMP('2019-08-01 12:00:09','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_column_fkconstraintname',TO_TIMESTAMP('2019-08-01 12:00:09','YYYY-MM-DD HH24:MI:SS'),100,101,'N','Y','N','N')
;

-- Aug 1, 2019, 12:00:37 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201388,'928de5aa-4a1c-4aed-aaea-86109ba81219',TO_TIMESTAMP('2019-08-01 12:00:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-08-01 12:00:36','YYYY-MM-DD HH24:MI:SS'),100,201073,'UPPER(FKConstraintName)',1)
;

-- Aug 1, 2019, 12:00:44 PM CEST
CREATE UNIQUE INDEX ad_column_fkconstraintname ON AD_Column (UPPER(FKConstraintName))
;

-- Aug 1, 2019, 12:32:28 PM CEST
UPDATE AD_Tab SET IsSingleRow='Y',Updated=TO_TIMESTAMP('2019-08-01 12:32:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200096
;

-- Aug 1, 2019, 12:32:31 PM CEST
UPDATE AD_Tab SET IsSingleRow='Y',Updated=TO_TIMESTAMP('2019-08-01 12:32:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200097
;

-- Aug 1, 2019, 12:33:20 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201074,'ed01f300-0824-4497-84b5-4bcfd4c88db9',TO_TIMESTAMP('2019-08-01 12:33:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_tableindex_name',TO_TIMESTAMP('2019-08-01 12:33:20','YYYY-MM-DD HH24:MI:SS'),100,200085,'N','Y','N','N','N')
;

-- Aug 1, 2019, 12:33:35 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201389,'a163915d-a5ba-45f9-9411-144d499af1fd',TO_TIMESTAMP('2019-08-01 12:33:35','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-08-01 12:33:35','YYYY-MM-DD HH24:MI:SS'),100,201074,'UPPER(Name)',1)
;

-- Aug 1, 2019, 12:33:43 PM CEST
CREATE UNIQUE INDEX ad_tableindex_name ON AD_TableIndex (UPPER(Name))
;

SELECT register_migration_script('201908011127_IDEMPIERE-4017.sql') FROM dual
;

