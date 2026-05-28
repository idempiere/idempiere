-- IDEMPIERE-7009
SELECT register_migration_script('202605281328_IDEMPIERE-7009.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 28, 2026, 1:28:21 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217620,0,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200445,'IsDefault','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-05-28 13:28:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 13:28:21','YYYY-MM-DD HH24:MI:SS'),10,1103,'Y','N','D','N','N','N','Y','019e6e57-b172-765d-86da-b0d11fa1eb77','Y',0,'N','N','N','N')
;

-- May 28, 2026, 1:28:22 PM CEST
ALTER TABLE C_SalesPipeline ADD IsDefault CHAR(1) DEFAULT 'N' CHECK (IsDefault IN ('Y','N')) NOT NULL
;

-- May 28, 2026, 1:28:31 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209214,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200424,217620,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 13:28:31','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 13:28:31','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6e57-da86-7a5b-964f-ae70c6e65e61','Y',60,2,2)
;

-- May 28, 2026, 1:28:38 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-05-28 13:28:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209193
;

-- May 28, 2026, 1:28:38 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-05-28 13:28:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209192
;

DECLARE
    v_sequenceSP_ID NUMBER;
    v_sequenceSPS_ID NUMBER;
    v_salesPipeline_ID NUMBER;
    v_salesPipelineStage_ID NUMBER;
    v_pipeline_id NUMBER;
    v_seqno NUMBER;

BEGIN

    -- Get sequences
    SELECT AD_Sequence_ID INTO v_sequenceSP_ID FROM AD_Sequence WHERE Name = 'C_SalesPipeline' AND IsActive = 'Y' AND IsTableID = 'Y' AND IsAutoSequence = 'Y' AND AD_Client_ID = 0;
    SELECT AD_Sequence_ID INTO v_sequenceSPS_ID FROM AD_Sequence WHERE Name = 'C_SalesPipeline_Stage' AND IsActive = 'Y' AND IsTableID = 'Y' AND IsAutoSequence = 'Y' AND AD_Client_ID = 0;

    -- Loop clients
    FOR v_client IN (
        SELECT AD_Client_ID
        FROM AD_Client
        WHERE AD_Client_ID > 0
    )
    LOOP

		AD_Sequence_Next ('C_SalesPipeline', v_client.AD_Client_ID, v_salesPipeline_ID);

        -- Insert Pipeline
        INSERT INTO C_SalesPipeline (
            C_SalesPipeline_ID,
            C_SalesPipeline_UU,
            AD_Client_ID,
            AD_Org_ID,
            IsActive,
            Created,
            CreatedBy,
            Updated,
            UpdatedBy,
            Name,
            Value,
            IsDefault
        )
        VALUES (
            v_salesPipeline_ID,
            Generate_UUID(),
            v_client.AD_Client_ID,
            0,
            'Y',
            SYSDATE,
            100,
            SYSDATE,
            100,
            'Default',
            'Default',
            'Y'
        )
        RETURNING C_SalesPipeline_ID INTO v_pipeline_id;

        v_seqno := 10;

        -- Loop stages
        FOR rec IN (
            SELECT C_SalesStage_ID, Probability
            FROM C_SalesStage
            WHERE IsActive = 'Y'
            ORDER BY Value
        )
        LOOP

            AD_Sequence_Next ('C_SalesPipeline_Stage', v_client.AD_Client_ID, v_salesPipelineStage_ID);

            INSERT INTO C_SalesPipeline_Stage (
                C_SalesPipeline_Stage_ID,
                C_SalesPipeline_Stage_UU,
                AD_Client_ID,
                AD_Org_ID,
                IsActive,
                Created,
                CreatedBy,
                Updated,
                UpdatedBy,
                C_SalesPipeline_ID,
                C_SalesStage_ID,
                SeqNo,
                Probability
            )
            VALUES (
                v_salesPipelineStage_ID,
                Generate_UUID(),
                v_client.AD_Client_ID,
                0,
                'Y',
                SYSDATE,
                100,
                SYSDATE,
                100,
                v_pipeline_id,
                rec.C_SalesStage_ID,
                v_seqno,
                rec.Probability
            );

            v_seqno := v_seqno + 10;

        END LOOP;

		UPDATE C_Opportunity SET C_SalesPipeline_ID = v_pipeline_id WHERE AD_Client_ID = v_client.AD_Client_ID;

    END LOOP;

END;
/



-- May 28, 2026, 2:01:48 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2026-05-28 14:01:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217619
;

-- May 28, 2026, 2:01:50 PM CEST
ALTER TABLE C_Opportunity MODIFY C_SalesPipeline_ID NUMBER(10)
;

-- May 28, 2026, 2:01:50 PM CEST
ALTER TABLE C_Opportunity MODIFY C_SalesPipeline_ID NOT NULL
;

-- May 28, 2026, 2:07:19 PM CEST
UPDATE AD_Ref_Table SET OrderByClause='(
    SELECT sps.SeqNo
    FROM C_SalesPipeline_Stage sps
    WHERE sps.C_SalesStage_ID = C_SalesStage.C_SalesStage_ID
    AND sps.C_SalesPipeline_ID = @C_SalesPipeline_ID:0@
)',Updated=TO_TIMESTAMP('2026-05-28 14:07:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Reference_ID=200287
;

-- May 28, 2026, 2:24:03 PM CEST
UPDATE AD_Val_Rule SET Code='EXISTS (
    SELECT 1
    FROM C_SalesPipeline_Stage sps
    WHERE sps.C_SalesPipeline_ID = @C_SalesPipeline_ID:0@
    AND sps.C_SalesStage_ID = C_SalesStage.C_SalesStage_ID
)',Updated=TO_TIMESTAMP('2026-05-28 14:24:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Val_Rule_ID=200209
;
