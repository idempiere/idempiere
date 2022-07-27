update c_payment
set C_BPartner_ID=112, isallocated='N'
where c_payment_id = 101;

delete from c_allocationline
where C_AllocationHdr_ID=102;

delete from c_allocationhdr
where C_AllocationHdr_ID=102;

update c_bankaccount ba
set currentbalance = (SELECT sum(statementdifference) FROM c_bankstatement bs WHERE bs.c_bankaccount_id=ba.c_bankaccount_id AND bs.processed='Y')
where C_BankAccount_ID=100;

SELECT register_migration_script('202202061544_IDEMPIERE-4297.sql') FROM dual
;

