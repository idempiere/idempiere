/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.grid;

import org.compiere.model.MBankAccountProcessor;
import org.compiere.model.PO;

/**
 * 
 * Payment form interface for different payment mode (cash, credit card, etc)
 *
 */
public interface IPaymentForm {

	/**
	 * Dynamic initialization
	 * @return false if there are errors, true otherwise
	 * @throws Exception
	 */
	public boolean dynInit() throws Exception;
	
	/**
	 * Load payment and related transaction records. Usually call from dynInit() 
	 */
	public void loadData();
	
	/**
	 * Mandatory field validations
	 * @return true if all mandatory field have been populated
	 */
	public boolean checkMandatory();
	
	/**
	 * Is only show payment rule and doesn't save changes to DB
	 * @return true if only show payment rule and doesn't save changes to DB
	 */
	public boolean isOnlyRule();
	
	/**
	 *	Save Changes
	 *	@return true, if Window can exit
	 */
	public boolean saveChanges();
	
	/**
	 * Save changes to DB
	 * @param trxName
	 * @return true if save successfully
	 */
	public boolean saveChangesInTrx(final String trxName);
		
	/**
	 * 	Need to save the calling window (order, invoice)
	 *	@return true if changes have been made to the calling window
	 */
	public boolean needSave();
	
	/**
	 * Online payment processing (for e.g credit card)
	 */
	public void processOnline();
	
	/**
	 * Is payment transaction have been approved by payment gateway
	 * @return true if payment transaction have been approved by payment gateway
	 */
	public boolean isApproved();
	
	/**
	 * Show form
	 */
	public void showWindow();
	
	/**
	 * Close form
	 */
	public void closeWindow();
	
	/**
	 * Get instance of UI form
	 * @return instance of UI form
	 */
	public Object getWindow();
	
	/**
	 * Make additional changes to PO before write to DB
	 * @param po
	 */
	public void setCustomizeValues(PO po);
	
	/**
	 * Set online payment processor configuration
	 * @param bankAccountProcessor
	 */
	public void setBankAccountProcessor(MBankAccountProcessor bankAccountProcessor);
}