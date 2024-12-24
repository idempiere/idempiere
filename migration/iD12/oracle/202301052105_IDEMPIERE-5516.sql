-- IDEMPIERE-5516 Unallocated Cash and Payment selection account configurable per BPartner
SELECT register_migration_script('202301052105_IDEMPIERE-5516.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 5, 2023, 9:05:21 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215733,1,'Unallocated Cash','Unallocated Cash Clearing Account','Receipts not allocated to Invoices',183,'B_UnallocatedCash_Acct',22,'N','N','N','N','N',0,'N',25,0,0,'Y',TO_TIMESTAMP('2023-01-05 21:05:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-05 21:05:20','YYYY-MM-DD HH24:MI:SS'),100,1687,'Y','N','D','N','N','N','Y','087716e2-a724-4c43-8cb4-28fc88ec05cc','Y','N','N','N','N')
;

-- Jan 5, 2023, 9:05:26 PM IST
UPDATE AD_Column SET FKConstraintName='BUnallocatedCashAcct_CBPCustom', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-01-05 21:05:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215733
;

-- Jan 5, 2023, 9:05:26 PM IST
ALTER TABLE C_BP_Customer_Acct ADD B_UnallocatedCash_Acct NUMBER(10) DEFAULT NULL
;

-- Jan 5, 2023, 9:06:34 PM IST
ALTER TABLE C_BP_Customer_Acct ADD CONSTRAINT BUnallocatedCashAcct_CBPCustom FOREIGN KEY (B_UnallocatedCash_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 5, 2023, 9:06:40 PM IST
-- UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-01-05 21:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215733
-- ;

-- Jan 5, 2023, 9:07:18 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207519,'Unallocated Cash','Unallocated Cash Clearing Account','Receipts not allocated to Invoices',212,215733,'Y',0,80,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-05 21:07:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-05 21:07:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dad1b7c8-9945-44ea-8809-2437ac125928','Y',90,1,1,1,'N','N','N','N')
;

-- Jan 5, 2023, 9:07:59 PM IST
UPDATE AD_Field SET SeqNo=80, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-01-05 21:07:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207519
;

-- Jan 5, 2023, 9:07:59 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-01-05 21:07:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204683
;

-- Jan 5, 2023, 9:11:54 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215734,0,'Unallocated Cash','Unallocated Cash Clearing Account','Receipts not allocated to Invoices',395,'B_UnallocatedCash_Acct',22,'N','N','N','N','N',0,'N',25,0,0,'Y',TO_TIMESTAMP('2023-01-05 21:11:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-05 21:11:53','YYYY-MM-DD HH24:MI:SS'),100,1687,'Y','N','D','N','N','N','Y','4a2a9b28-9718-47e3-bea1-f4ab2cfc972d','Y',0,'N','N','N','N')
;

-- Jan 5, 2023, 9:11:56 PM IST
UPDATE AD_Column SET FKConstraintName='BUnallocatedCashAcct_CBPGroupA', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-01-05 21:11:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215734
;

-- Jan 5, 2023, 9:11:56 PM IST
ALTER TABLE C_BP_Group_Acct ADD B_UnallocatedCash_Acct NUMBER(10) DEFAULT NULL 
;

-- Jan 5, 2023, 9:11:56 PM IST
ALTER TABLE C_BP_Group_Acct ADD CONSTRAINT BUnallocatedCashAcct_CBPGroupA FOREIGN KEY (B_UnallocatedCash_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 5, 2023, 9:12:00 PM IST
-- UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-01-05 21:12:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215734
-- ;

-- Jan 5, 2023, 9:12:27 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207520,'Unallocated Cash','Unallocated Cash Clearing Account','Receipts not allocated to Invoices',323,215734,'Y',0,180,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-05 21:12:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-05 21:12:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d22c9186-8b0b-4a8c-aabb-5342e24ea66f','Y',200,1,1,1,'N','N','N','N')
;

-- Jan 5, 2023, 9:12:41 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=1, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-01-05 21:12:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207520
;

-- Jan 5, 2023, 9:12:41 PM IST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2023-01-05 21:12:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3924
;

-- Jan 5, 2023, 9:12:41 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2023-01-05 21:12:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204685
;

-- Jan 5, 2023, 9:13:07 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215735,0,'Payment Selection','AP Payment Selection Clearing Account',395,'B_PaymentSelect_Acct',22,'N','N','N','N','N',0,'N',25,0,0,'Y',TO_TIMESTAMP('2023-01-05 21:13:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-05 21:13:07','YYYY-MM-DD HH24:MI:SS'),100,1686,'Y','N','D','N','N','N','Y','f617b4d6-03a7-48ac-80f5-00bf2bf6ae6f','Y',0,'N','N','N','N')
;

-- Jan 5, 2023, 9:13:09 PM IST
ALTER TABLE C_BP_Group_Acct MODIFY B_UnallocatedCash_Acct NUMBER(10)
;

-- Jan 5, 2023, 9:13:50 PM IST
UPDATE AD_Column SET FKConstraintName='BPaymentSelectAcct_CBPGroupAcc', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-01-05 21:13:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215735
;

-- Jan 5, 2023, 9:13:50 PM IST
ALTER TABLE C_BP_Group_Acct ADD B_PaymentSelect_Acct NUMBER(10) DEFAULT NULL 
;

-- Jan 5, 2023, 9:13:50 PM IST
ALTER TABLE C_BP_Group_Acct ADD CONSTRAINT BPaymentSelectAcct_CBPGroupAcc FOREIGN KEY (B_PaymentSelect_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 5, 2023, 9:06:40 PM IST
-- UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-01-05 21:06:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215735
-- ;

-- Jan 5, 2023, 9:14:04 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207521,'Payment Selection','AP Payment Selection Clearing Account',323,215735,'Y',0,170,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-05 21:14:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-05 21:14:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','677cfe7a-8ca8-4c74-ae83-76486f2d58d0','Y',210,1,1,1,'N','N','N','N')
;

-- Jan 5, 2023, 9:14:31 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-01-05 21:14:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207521
;

-- Jan 5, 2023, 9:14:31 PM IST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2023-01-05 21:14:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3924
;

-- Jan 5, 2023, 9:15:22 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215737,0,'Payment Selection','AP Payment Selection Clearing Account',185,'B_PaymentSelect_Acct',22,'N','N','N','N','N',0,'N',25,0,0,'Y',TO_TIMESTAMP('2023-01-05 21:15:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-05 21:15:22','YYYY-MM-DD HH24:MI:SS'),100,1686,'Y','N','D','N','N','N','Y','9ae9170c-c0ca-4fc5-96ba-22fce9165e7b','Y',0,'N','N','N','N')
;

-- Jan 5, 2023, 9:15:24 PM IST
UPDATE AD_Column SET FKConstraintName='BPaymentSelectAcct_CBPVendorAc', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-01-05 21:15:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215737
;

-- Jan 5, 2023, 9:15:24 PM IST
ALTER TABLE C_BP_Vendor_Acct ADD B_PaymentSelect_Acct NUMBER(10) DEFAULT NULL 
;

-- Jan 5, 2023, 9:15:24 PM IST
ALTER TABLE C_BP_Vendor_Acct ADD CONSTRAINT BPaymentSelectAcct_CBPVendorAc FOREIGN KEY (B_PaymentSelect_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 5, 2023, 9:15:39 PM IST
-- UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2023-01-05 21:15:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215737
-- ;

-- Jan 5, 2023, 9:16:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207522,'Payment Selection','AP Payment Selection Clearing Account',213,215737,'Y',0,80,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-05 21:16:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-05 21:16:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f99a8b1d-072c-4785-965f-e8529c9ef932','Y',90,1,2,1,'N','N','N','N')
;


-- CHECK SAME CLIENT & ACCT_SCHEMA AGAINST DUPLICATE ELEMENT ACCOUNT USED IN BANK ACCOUNT ACCOUNTING
-- For UnAllocatedCash_Acct
SET SERVEROUTPUT ON;
DECLARE 
    CURSOR cursorRecord IS 
        SELECT DISTINCT ba.AD_Client_ID, ba.C_AcctSchema_ID, vu.Account_ID
        FROM C_BankAccount_Acct ba
        INNER JOIN C_ValidCombination vu ON (vu.C_ValidCombination_ID = ba.B_UnAllocatedCash_Acct)
        WHERE ba.IsActive = 'Y'
        ORDER BY ba.C_AcctSchema_ID;

    acctSchemaID NUMBER := 0;
    duplicateAcctFound BOOLEAN := FALSE;

BEGIN
    FOR item IN cursorRecord 
    LOOP
        DBMS_OUTPUT.PUT_LINE('UnAllocatedCash account used, clientID: ' || item.AD_Client_ID || '; acctSchemaID: ' || item.C_AcctSchema_ID || ' accountID: ' || item.Account_ID);

        IF (item.C_AcctSchema_ID = acctSchemaID) 
        THEN
            duplicateAcctFound := TRUE;
        ELSE
            acctSchemaID := item.C_AcctSchema_ID;
        END IF;
    END LOOP;

    IF duplicateAcctFound THEN
        DBMS_OUTPUT.PUT_LINE('WARNING: Bank account found different UnAllocatedCash_Acct used against same client under same acctSchema, Please verify it [ IDEMPIERE-5516 ].');
    ELSE
    	-- Update C_BP_Group_Acct > B_UnallocatedCash_Acct from Bank Acct 
        MERGE INTO C_BP_Group_Acct bga
	USING (	SELECT a.AD_Client_ID, a.C_AcctSchema_ID, B_UnallocatedCash_Acct 
		FROM C_AcctSchema_Default a 
	) st 
	ON ( st.AD_Client_ID = bga.AD_Client_ID AND st.C_AcctSchema_ID  = bga.C_AcctSchema_ID )
	WHEN MATCHED THEN
		UPDATE 
		SET 	bga.B_UnallocatedCash_Acct = st.B_UnallocatedCash_Acct
		WHERE 	bga.B_UnallocatedCash_Acct IS NULL
	;
	-- Update C_BP_Customer_Acct > B_UnallocatedCash_Acct from Bank Acct
	MERGE INTO C_BP_Customer_Acct bga
	USING (	SELECT a.AD_Client_ID, a.C_AcctSchema_ID, b.C_BPartner_ID, B_UnallocatedCash_Acct
		FROM C_BP_Group_Acct a
		INNER JOIN C_BPartner b ON (b.C_BP_Group_ID = a.C_BP_Group_ID)
	) st 
	ON ( st.AD_Client_ID = bga.AD_Client_ID AND st.C_AcctSchema_ID  = bga.C_AcctSchema_ID AND st.C_BPartner_ID = bga.C_BPartner_ID )
	WHEN MATCHED THEN
		UPDATE 
		SET bga.B_UnallocatedCash_Acct = st.B_UnallocatedCash_Acct
		WHERE bga.B_UnallocatedCash_Acct IS NULL
	;

    END IF;
END
;

-- For B_PaymentSelect_Acct
SET SERVEROUTPUT ON;
DECLARE 
    CURSOR cursorRecord IS 
        SELECT DISTINCT ba.AD_Client_ID, ba.C_AcctSchema_ID, vu.Account_ID
        FROM C_BankAccount_Acct ba
        INNER JOIN C_ValidCombination vu ON (vu.C_ValidCombination_ID = ba.B_PaymentSelect_Acct)
        WHERE ba.IsActive = 'Y'
        ORDER BY ba.C_AcctSchema_ID;

    acctSchemaID NUMBER := 0;
    duplicateAcctFound BOOLEAN := FALSE;

BEGIN
    FOR item IN cursorRecord 
    LOOP
        DBMS_OUTPUT.PUT_LINE('PaymentSelect_Acct account used, clientID: ' || item.AD_Client_ID || '; acctSchemaID: ' || item.C_AcctSchema_ID || ' accountID: ' || item.Account_ID);

        IF (item.C_AcctSchema_ID = acctSchemaID) 
        THEN
            duplicateAcctFound := TRUE;
        ELSE
            acctSchemaID := item.C_AcctSchema_ID;
        END IF;
    END LOOP;

    IF duplicateAcctFound THEN
        DBMS_OUTPUT.PUT_LINE('WARNING: Bank account found different PaymentSelect_Acct used against same client under same acctSchema, Please verify it [ IDEMPIERE-5516 ].');
    ELSE
	-- Update C_BP_Group_Acct > B_PaymentSelect_Acct from Bank Acct
        MERGE INTO C_BP_Group_Acct bga
	USING (	SELECT a.AD_Client_ID, a.C_AcctSchema_ID, B_PaymentSelect_Acct 
		FROM C_AcctSchema_Default a 
	) st 
	ON ( st.AD_Client_ID = bga.AD_Client_ID AND st.C_AcctSchema_ID  = bga.C_AcctSchema_ID )
	WHEN MATCHED THEN
		UPDATE 
		SET 	bga.B_PaymentSelect_Acct = st.B_PaymentSelect_Acct
		WHERE 	bga.B_PaymentSelect_Acct IS NULL
	;
	-- Update C_BP_Vendor_Acct > B_PaymentSelect_Acct from Bank Acct
	MERGE INTO C_BP_Vendor_Acct bga
	USING (	SELECT a.AD_Client_ID, a.C_AcctSchema_ID, b.C_BPartner_ID, B_PaymentSelect_Acct
		FROM C_BP_Group_Acct a
		INNER JOIN C_BPartner b ON (b.C_BP_Group_ID = a.C_BP_Group_ID)
	) st 
	ON ( st.AD_Client_ID = bga.AD_Client_ID AND st.C_AcctSchema_ID  = bga.C_AcctSchema_ID AND st.C_BPartner_ID = bga.C_BPartner_ID )
	WHEN MATCHED THEN
		UPDATE 
		SET 	bga.B_PaymentSelect_Acct = st.B_PaymentSelect_Acct
		WHERE 	bga.B_PaymentSelect_Acct IS NULL  
		;

    END IF;
END
;

