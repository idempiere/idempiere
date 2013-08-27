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
 */
public interface ITaxProvider {
		
	public boolean calculateOrderTaxTotal(MTaxProvider provider, MOrder order);
	
	public boolean updateOrderTax(MTaxProvider provider, MOrderLine line);
	
	public boolean calculateInvoiceTaxTotal(MTaxProvider provider, MInvoice invoice);

	public boolean updateInvoiceTax(MTaxProvider provider, MInvoiceLine line);
	
	public boolean recalculateTax(MTaxProvider provider, MInvoiceLine line, boolean newRecord);
	
	public boolean calculateRMATaxTotal(MTaxProvider provider, MRMA rma);
	
	public boolean updateRMATax(MTaxProvider provider, MRMALine line);
	
	public String validateConnection(MTaxProvider provider, ProcessInfo pi) throws Exception;
	
}