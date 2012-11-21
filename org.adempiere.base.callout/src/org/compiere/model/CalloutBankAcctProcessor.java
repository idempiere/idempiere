package org.compiere.model;

import java.util.Properties;

import org.compiere.util.Env;

/**
 * 
 * @author Elaine
 *
 */
public class CalloutBankAcctProcessor extends CalloutEngine
{
	/**
	 * Payment Processor Changed
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return null or error message
	 */
	public String paymentProcessor(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer C_PaymentProcessor_ID = (Integer)value;
		if (C_PaymentProcessor_ID == null || C_PaymentProcessor_ID.intValue() == 0)
			return "";
		
		MPaymentProcessor pp = new MPaymentProcessor(ctx, C_PaymentProcessor_ID, null);
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptMC, pp.isAcceptMC());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptVisa, pp.isAcceptVisa());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptAMEX, pp.isAcceptAMEX());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptDiners, pp.isAcceptDiners());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptCorporate, pp.isAcceptCorporate());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptDiscover, pp.isAcceptDiscover());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptDirectDeposit, pp.isAcceptDirectDeposit());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptDirectDebit, pp.isAcceptDirectDebit());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptCheck, pp.isAcceptCheck());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_AcceptATM, pp.isAcceptATM());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_MinimumAmt, pp.getMinimumAmt());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_C_Currency_ID, pp.getC_Currency_ID());
		mTab.setValue(MBankAccountProcessor.COLUMNNAME_RequireVV, pp.isRequireVV());
		
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptMC, pp.isAcceptMC() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptVisa, pp.isAcceptVisa() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptAMEX, pp.isAcceptAMEX() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptDiners, pp.isAcceptDiners() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptCorporate, pp.isAcceptCorporate() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptDiscover, pp.isAcceptDiscover() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptDirectDeposit, pp.isAcceptDirectDeposit() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptDirectDebit, pp.isAcceptDirectDebit() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptCheck, pp.isAcceptCheck() ? "Y" : "N");
		Env.setContext(ctx, WindowNo, mTab.getTabNo(), MBankAccountProcessor.COLUMNNAME_IsPPAcceptATM, pp.isAcceptATM() ? "Y" : "N");
		
		return null;
	}
}
