/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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
package org.adempiere.model;

import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MTaxProvider;
import org.compiere.process.ProcessInfo;

/**
 * Tax provider interface
 * @author Elaine
 *
 * @contributor Murilo H. Torquato <muriloht@devcoffee.com.br>
 *
 */
public interface ITaxProvider {
		
	/**
	 * Calculate order tax
	 * @param provider
	 * @param order
	 * @return true if success, false otherwise
	 */
	public boolean calculateOrderTaxTotal(MTaxProvider provider, MOrder order);
	
	/**
	 * Update order tax for line
	 * @param provider
	 * @param line
	 * @return true if success, false otherwise
	 */
	public boolean updateOrderTax(MTaxProvider provider, MOrderLine line);

	/**
	 * Re-calculate order tax for line (if line tax id change)
	 * @param provider
	 * @param line
	 * @param newRecord
	 * @return true if success, false otherwise
	 */
	public boolean recalculateTax(MTaxProvider provider, MOrderLine line, boolean newRecord);

	/**
	 * Update order tax total
	 * @param provider
	 * @param line
	 * @return true if success, false otherwise
	 */
	public boolean updateHeaderTax(MTaxProvider provider, MOrderLine line);

	/**
	 * Calculate invoice tax total
	 * @param provider
	 * @param invoice
	 * @return true if success, false otherwise
	 */
	public boolean calculateInvoiceTaxTotal(MTaxProvider provider, MInvoice invoice);

	/**
	 * Update invoice tax for line
	 * @param provider
	 * @param line
	 * @return true if success, false otherwise
	 */
	public boolean updateInvoiceTax(MTaxProvider provider, MInvoiceLine line);
	
	/**
	 * Re-calculate invoice tax for line (if line tax id change)
	 * @param provider
	 * @param line
	 * @param newRecord
	 * @return true if success, false otherwise
	 */
	public boolean recalculateTax(MTaxProvider provider, MInvoiceLine line, boolean newRecord);

	/**
	 * Update invoice tax total
	 * @param provider
	 * @param line
	 * @return true if success, false otherwise
	 */
	public boolean updateHeaderTax(MTaxProvider provider, MInvoiceLine line);

	/**
	 * Calculate rma tax total
	 * @param provider
	 * @param rma
	 * @return true if success, false otherwise
	 */
	public boolean calculateRMATaxTotal(MTaxProvider provider, MRMA rma);
	
	/**
	 * Update rma tax for rma line
	 * @param provider
	 * @param line
	 * @return true if success, false otherwise
	 */
	public boolean updateRMATax(MTaxProvider provider, MRMALine line);

	/**
	 * Re-calculate rma tax for ram line (if line tax id change)
	 * @param provider
	 * @param line
	 * @param newRecord
	 * @return true if success, false otherwise
	 */
	public boolean recalculateTax(MTaxProvider provider, MRMALine line, boolean newRecord);

	/**
	 * Update rma header total
	 * @param provider
	 * @param line
	 * @return true if success, false otherwise
	 */
	public boolean updateHeaderTax(MTaxProvider provider, MRMALine line);

	/**
	 * 
	 * @param provider
	 * @param pi
	 * @return error message
	 * @throws Exception
	 */
	public String validateConnection(MTaxProvider provider, ProcessInfo pi) throws Exception;
	
}