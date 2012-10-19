package org.compiere.grid;

import org.compiere.model.MBankAccountProcessor;

public interface IPaymentForm {

	public boolean checkMandatory();
	
	public boolean saveChangesInTrx(final String trxName);
	
	public boolean needSave();
	
	public void showWindow();
	
	public void closeWindow();
	
	public Object getWindow();
	
	public Object getCustomizePanel();
	
	public void setCustomizeValues();
	
	public void setBankAccountProcessor(MBankAccountProcessor bankAccountProcessor);
}