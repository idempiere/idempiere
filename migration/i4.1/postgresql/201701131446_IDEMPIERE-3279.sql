-- IDEMPIERE-3279 Implement configurable Write-Off in Payment Selection
-- Jan 13, 2017 2:39:27 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212953,1,'Write-off Amount','Amount to write-off','The Write Off Amount indicates the amount to be written off as uncollectible.',525,'WriteOffAmt',22,'N','N','Y','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2017-01-13 14:39:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-01-13 14:39:19','YYYY-MM-DD HH24:MI:SS'),100,1450,'N','N','D','N','N','N','Y','0e379fab-cf4d-4209-8576-f8c7f13031af','Y','N','N')
;

-- Jan 13, 2017 2:40:17 PM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2017-01-13 14:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212953
;

-- Jan 13, 2017 2:40:30 PM CET
UPDATE AD_Column SET DefaultValue='0',Updated=TO_TIMESTAMP('2017-01-13 14:40:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212953
;

-- Jan 13, 2017 2:40:32 PM CET
ALTER TABLE C_PaySelectionCheck ADD COLUMN WriteOffAmt NUMERIC DEFAULT '0' NOT NULL
;

-- Jan 13, 2017 2:41:26 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (212955,1,'Write-off Amount','Amount to write-off','The Write Off Amount indicates the amount to be written off as uncollectible.',427,'WriteOffAmt',22,'N','N','Y','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2017-01-13 14:41:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-01-13 14:41:16','YYYY-MM-DD HH24:MI:SS'),100,1450,'N','N','D','N','N','N','Y','5a8e715a-7b5f-4daf-b88f-aaa0f229e9df','Y','N','N')
;

-- Jan 13, 2017 2:41:55 PM CET
UPDATE AD_Column SET DefaultValue='0',Updated=TO_TIMESTAMP('2017-01-13 14:41:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212955
;

-- Jan 13, 2017 2:41:56 PM CET
ALTER TABLE C_PaySelectionLine ADD COLUMN WriteOffAmt NUMERIC DEFAULT '0' NOT NULL
;

-- Jan 13, 2017 2:43:36 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204354,'Write-off Amount','Amount to write-off','The Write Off Amount indicates the amount to be written off as uncollectible.',353,212955,'Y',0,160,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-01-13 14:43:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-01-13 14:43:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','13756b9c-d9db-4c83-9fea-d0b05b866bc0','Y',160,1,1,1,'N','N','N')
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=4416
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=4417
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=4423
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=4431
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=4938
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=4429
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=4433
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=4421
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=10896
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=10641
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=4432
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=10640
;

-- Jan 13, 2017 2:43:49 PM CET
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=204354
;

-- Jan 13, 2017 2:44:17 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204354
;

-- Jan 13, 2017 2:44:17 PM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10640
;

-- Jan 13, 2017 2:44:17 PM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4939
;

-- Jan 13, 2017 2:44:17 PM CET
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5840
;

-- Jan 13, 2017 2:44:17 PM CET
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10616
;

-- Jan 13, 2017 2:44:39 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (204355,'Write-off Amount','Amount to write-off','The Write Off Amount indicates the amount to be written off as uncollectible.',436,212953,'Y',0,140,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-01-13 14:44:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-01-13 14:44:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9bef867f-a47d-49f4-b2a7-3d69c3a71a14','Y',140,1,1,1,'N','N','N')
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=5828
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=5829
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=5830
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=5831
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=5837
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=5833
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=5835
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=10642
;

-- Jan 13, 2017 2:44:47 PM CET
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=204355
;

-- Jan 13, 2017 2:45:13 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:45:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204355
;

-- Jan 13, 2017 2:45:13 PM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:45:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5839
;

-- Jan 13, 2017 2:45:13 PM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:45:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10897
;

-- Jan 13, 2017 2:45:13 PM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:45:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5838
;

-- Jan 13, 2017 2:45:13 PM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:45:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5836
;

-- Jan 13, 2017 2:45:13 PM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:45:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10617
;

-- Jan 13, 2017 2:45:23 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-01-13 14:45:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204355
;

CREATE OR REPLACE FUNCTION invoiceWriteOff
(
    p_C_Invoice_ID NUMERIC
)
RETURNS numeric AS $body$
DECLARE
    v_Amount NUMERIC;
    v_ClientId C_Invoice.AD_Client_ID%TYPE;
    custom_function AD_SysConfig.Value%TYPE;
    command VARCHAR(1000);
BEGIN
    SELECT AD_Client_ID INTO v_ClientId FROM C_Invoice WHERE C_Invoice_ID=p_C_Invoice_ID;
    custom_function := get_Sysconfig('PAYSELECTION_CUSTOM_INVOICEWRITEOFF_FUNCTION', '', v_ClientId, 0);
    IF LENGTH(custom_function) > 0
    THEN
	command := 'SELECT '||custom_function||'('||p_C_Invoice_ID||')';
        EXECUTE command INTO v_Amount;
    ELSE
        v_Amount := 0;
    END IF;
    RETURN v_Amount;
END;
$body$ LANGUAGE plpgsql STABLE;

SELECT register_migration_script('201701131446_IDEMPIERE-3279.sql') FROM dual
;

