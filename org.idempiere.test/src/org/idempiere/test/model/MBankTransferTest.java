package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MBankTransfer;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class MBankTransferTest extends AbstractTestCase {

	public MBankTransferTest() {
	}
	
	@Test
	public void testBankTransfer() {
		MBankTransfer bankTransfer = new MBankTransfer(Env.getCtx(), 0, getTrxName());
		bankTransfer.setPayDate(TimeUtil.getDay(null));
		bankTransfer.setDateAcct(TimeUtil.getDay(null));
		bankTransfer.setFrom_C_BankAccount_ID(DictionaryIDs.C_BankAccount.HQ_POS_CASH.id);
		bankTransfer.setFrom_AD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		bankTransfer.setFrom_C_BPartner_ID(DictionaryIDs.C_BPartner.CHEMICAL_INC.id);
		bankTransfer.setFrom_Amt(Env.ONEHUNDRED);
		bankTransfer.setFrom_C_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		bankTransfer.setFrom_C_Currency_ID(DictionaryIDs.C_Currency.USD.id);

		bankTransfer.setTo_C_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		bankTransfer.setTo_AD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		bankTransfer.setTo_C_BPartner_ID(DictionaryIDs.C_BPartner.CHEMICAL_INC.id);
		bankTransfer.setTo_Amt(Env.ONEHUNDRED);
		bankTransfer.setTo_C_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		bankTransfer.setTo_C_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		bankTransfer.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(bankTransfer, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		bankTransfer.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, bankTransfer.getDocStatus());
	}
	
	@Test
	public void testBankTransferSameBankAccount() {
		MBankTransfer bankTransfer = new MBankTransfer(Env.getCtx(), 0, getTrxName());
		bankTransfer.setPayDate(TimeUtil.getDay(null));
		bankTransfer.setDateAcct(TimeUtil.getDay(null));
		bankTransfer.setFrom_C_BankAccount_ID(DictionaryIDs.C_BankAccount.HQ_POS_CASH.id);
		bankTransfer.setFrom_AD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		bankTransfer.setFrom_C_BPartner_ID(DictionaryIDs.C_BPartner.CHEMICAL_INC.id);
		bankTransfer.setFrom_Amt(Env.ONEHUNDRED);
		bankTransfer.setFrom_C_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		bankTransfer.setFrom_C_Currency_ID(DictionaryIDs.C_Currency.USD.id);

		bankTransfer.setTo_C_BankAccount_ID(DictionaryIDs.C_BankAccount.HQ_POS_CASH.id);
		bankTransfer.setTo_AD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		bankTransfer.setTo_C_BPartner_ID(DictionaryIDs.C_BPartner.CHEMICAL_INC.id);
		bankTransfer.setTo_Amt(Env.ONEHUNDRED);
		bankTransfer.setTo_C_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		bankTransfer.setTo_C_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		
		AdempiereException exception = assertThrows(AdempiereException.class, () -> bankTransfer.saveEx());
		assertEquals(exception.getMessage(), "Error: "+Msg.getMsg(bankTransfer.getCtx(), "FromToBankAccountMustDifferent", new Object[] {bankTransfer.toString()}));
	}
	
	@Test
	public void testBankTransferDifferentOrgFrom() {
		MBankTransfer bankTransfer = new MBankTransfer(Env.getCtx(), 0, getTrxName());
		bankTransfer.setPayDate(TimeUtil.getDay(null));
		bankTransfer.setDateAcct(TimeUtil.getDay(null));
		bankTransfer.setFrom_C_BankAccount_ID(DictionaryIDs.C_BankAccount.HQ_POS_CASH.id);
		bankTransfer.setFrom_AD_Org_ID(DictionaryIDs.AD_Org.FERTILIZER.id);
		bankTransfer.setFrom_C_BPartner_ID(DictionaryIDs.C_BPartner.CHEMICAL_INC.id);
		bankTransfer.setFrom_Amt(Env.ONEHUNDRED);
		bankTransfer.setFrom_C_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		bankTransfer.setFrom_C_Currency_ID(DictionaryIDs.C_Currency.USD.id);

		bankTransfer.setTo_C_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
		bankTransfer.setTo_AD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
		bankTransfer.setTo_C_BPartner_ID(DictionaryIDs.C_BPartner.CHEMICAL_INC.id);
		bankTransfer.setTo_Amt(Env.ONEHUNDRED);
		bankTransfer.setTo_C_Charge_ID(DictionaryIDs.C_Charge.BANK.id);
		bankTransfer.setTo_C_Currency_ID(DictionaryIDs.C_Currency.USD.id);
		
		AdempiereException exception = assertThrows(AdempiereException.class, () -> bankTransfer.saveEx());
		assertEquals(exception.getMessage(), "Error: "+Msg.getMsg(bankTransfer.getCtx(), "FromOrgNotMatchBankAccount", new Object[] {bankTransfer.toString()}));
	}
	
}
