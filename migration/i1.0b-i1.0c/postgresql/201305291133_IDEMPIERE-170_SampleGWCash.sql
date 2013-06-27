-- May 29, 2013 11:30:16 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO C_Bank (C_Bank_UU,RoutingNo,C_Bank_ID,IsOwnBank,Name,AD_Org_ID,Updated,Created,CreatedBy,UpdatedBy,AD_Client_ID,IsActive) VALUES ('269f3083-6c14-4e08-bc65-2f9e91927cb0','POS Cash',200000,'Y','POS Cash',0,TO_TIMESTAMP('2013-05-29 11:30:15','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-05-29 11:30:15','YYYY-MM-DD HH24:MI:SS'),100,100,11,'Y')
;

-- May 29, 2013 11:30:39 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO C_BankAccount (CurrentBalance,C_Currency_ID,IsDefault,BankAccountType,CreditLimit,C_BankAccount_ID,C_BankAccount_UU,CreatedBy,Created,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,IsActive,AccountNo,Value,Name,C_Bank_ID) VALUES (0,100,'N','B',0,200000,'4781b89e-ce6d-41c9-9c89-12d2db752b61',100,TO_TIMESTAMP('2013-05-29 11:30:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-05-29 11:30:38','YYYY-MM-DD HH24:MI:SS'),11,100,11,'Y','HQ POS Cash','HQ POS Cash','HQ POS Cash',200000)
;

-- May 29, 2013 11:30:39 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO C_BankAccount_Acct (C_BankAccount_ID, C_AcctSchema_ID, AD_Client_ID,AD_Org_ID,IsActive, Created,CreatedBy,Updated,UpdatedBy ,B_Asset_Acct,B_InterestExp_Acct,B_InterestRev_Acct,B_InTransit_Acct,B_PaymentSelect_Acct,B_UnallocatedCash_Acct,C_BankAccount_Acct_UU) SELECT 200000, p.C_AcctSchema_ID, p.AD_Client_ID,0,'Y', statement_timestamp(),100,statement_timestamp(),100,p.B_Asset_Acct,p.B_InterestExp_Acct,p.B_InterestRev_Acct,p.B_InTransit_Acct,p.B_PaymentSelect_Acct,p.B_UnallocatedCash_Acct,generate_uuid() FROM C_AcctSchema_Default p WHERE p.AD_Client_ID=11 AND NOT EXISTS (SELECT * FROM C_BankAccount_Acct e WHERE e.C_AcctSchema_ID=p.C_AcctSchema_ID AND e.C_BankAccount_ID=200000)
;

-- May 29, 2013 11:30:55 AM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
INSERT INTO C_BankAccountDoc (C_BankAccount_ID,PaymentRule,C_BankAccountDoc_ID,Check_PrintFormat_ID,CurrentNext,Name,C_BankAccountDoc_UU,Created,UpdatedBy,Updated,AD_Org_ID,CreatedBy,AD_Client_ID,IsActive) VALUES (200000,'B',200000,126,0,'HQ POS Cash','cdfacd83-2ca2-45a6-93f4-36215066c94d',TO_TIMESTAMP('2013-05-29 11:30:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-05-29 11:30:54','YYYY-MM-DD HH24:MI:SS'),11,100,11,'Y')
;

SELECT register_migration_script('201305291133_IDEMPIERE-170_SampleGWCash.sql') FROM dual
;

