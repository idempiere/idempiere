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

import org.compiere.model.GridTab;
import org.compiere.model.MBankAccountProcessor;

public interface IPaymentForm {
	
	public void init(int WindowNo, GridTab mTab);

	public boolean dynInit() throws Exception;
	
	public void loadData();
	
	public boolean checkMandatory();
	
	/**************************************************************************
	 *	Save Changes
	 *	@return true, if Window can exit
	 */
	public boolean saveChanges();
	
	public boolean saveChangesInTrx(final String trxName);
	
	/**
	 * 	Need Save record (payment with waiting order)
	 *	@return true if payment with waiting order
	 */
	public boolean needSave();
	
	public void processOnline();
	
	public boolean isApproved();
	
	public void showWindow();
	
	public void closeWindow();
	
	public Object getWindow();
	
	public Object getCustomizePanel();
	
	public void setCustomizeValues();
	
	public void setBankAccountProcessor(MBankAccountProcessor bankAccountProcessor);
}