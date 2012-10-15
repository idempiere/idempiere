package org.compiere.grid;

public interface IPaymentForm {

	public boolean checkMandatory();
	
	public boolean saveChangesInTrx(final String trxName);
	
	public boolean needSave();
	
	public void showWindow();
	
	public void closeWindow();
	
	public Object getWindow();
}