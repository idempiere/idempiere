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
package org.compiere.model;

import java.math.BigDecimal;
import java.util.ArrayList;

import org.adempiere.model.ITaxProvider;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Standard tax provider
 * @author Elaine
 *
 */
public class StandardTaxProvider implements ITaxProvider {
	
	@Override
	public boolean calculateOrderTaxTotal(MTaxProvider provider, MOrder order) {
		//	Lines
		BigDecimal totalLines = Env.ZERO;
		ArrayList<Integer> taxList = new ArrayList<Integer>();
		MOrderLine[] lines = order.getLines();
		for (int i = 0; i < lines.length; i++)
		{
			MOrderLine line = lines[i];
			totalLines = totalLines.add(line.getLineNetAmt());
			Integer taxID = new Integer(line.getC_Tax_ID());
			if (!taxList.contains(taxID))
			{
				MTax tax = new MTax(order.getCtx(), taxID, order.get_TrxName());
				if (tax.getC_TaxProvider_ID() != 0)
					continue;
				MOrderTax oTax = MOrderTax.get (line, order.getPrecision(), false, order.get_TrxName());	//	current Tax
				oTax.setIsTaxIncluded(order.isTaxIncluded());
				if (!oTax.calculateTaxFromLines())
					return false;
				if (!oTax.save(order.get_TrxName()))
					return false;
				taxList.add(taxID);
			}
		}
		
		//	Taxes
		BigDecimal grandTotal = totalLines;
		MOrderTax[] taxes = order.getTaxes(true);
		for (int i = 0; i < taxes.length; i++)
		{
			MOrderTax oTax = taxes[i];
			if (oTax.getC_TaxProvider_ID() != 0) {
				if (!order.isTaxIncluded())
					grandTotal = grandTotal.add(oTax.getTaxAmt());
				continue;
			}
			MTax tax = oTax.getTax();
			if (tax.isSummary())
			{
				MTax[] cTaxes = tax.getChildTaxes(false);
				for (int j = 0; j < cTaxes.length; j++)
				{
					MTax cTax = cTaxes[j];
					BigDecimal taxAmt = cTax.calculateTax(oTax.getTaxBaseAmt(), order.isTaxIncluded(), order.getPrecision());
					//
					MOrderTax newOTax = new MOrderTax(order.getCtx(), 0, order.get_TrxName());
					newOTax.setClientOrg(order);
					newOTax.setC_Order_ID(order.getC_Order_ID());
					newOTax.setC_Tax_ID(cTax.getC_Tax_ID());
					newOTax.setPrecision(order.getPrecision());
					newOTax.setIsTaxIncluded(order.isTaxIncluded());
					newOTax.setTaxBaseAmt(oTax.getTaxBaseAmt());
					newOTax.setTaxAmt(taxAmt);
					if (!newOTax.save(order.get_TrxName()))
						return false;
					//
					if (!order.isTaxIncluded())
						grandTotal = grandTotal.add(taxAmt);
				}
				if (!oTax.delete(true, order.get_TrxName()))
					return false;
				if (!oTax.save(order.get_TrxName()))
					return false;
			}
			else
			{
				if (!order.isTaxIncluded())
					grandTotal = grandTotal.add(oTax.getTaxAmt());
			}
		}		
		//
		order.setTotalLines(totalLines);
		order.setGrandTotal(grandTotal);
		return true;
	}

	@Override
	public boolean updateOrderTax(MTaxProvider provider, MOrderLine line) {
		MTax mtax = new MTax(line.getCtx(), line.getC_Tax_ID(), line.get_TrxName());
    	if (mtax.getC_TaxProvider_ID() == 0)
    		return line.updateOrderTax(false);
    	return true;
	}

	@Override
	public boolean calculateInvoiceTaxTotal(MTaxProvider provider, MInvoice invoice) {
		//	Lines
		BigDecimal totalLines = Env.ZERO;
		ArrayList<Integer> taxList = new ArrayList<Integer>();
		MInvoiceLine[] lines = invoice.getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MInvoiceLine line = lines[i];
			totalLines = totalLines.add(line.getLineNetAmt());
			if (!taxList.contains(line.getC_Tax_ID()))
			{
				MTax tax = new MTax(invoice.getCtx(), line.getC_Tax_ID(), invoice.get_TrxName());
				if (tax.getC_TaxProvider_ID() != 0)
					continue;
				MInvoiceTax iTax = MInvoiceTax.get (line, invoice.getPrecision(), false, invoice.get_TrxName()); //	current Tax
				if (iTax != null)
				{
					iTax.setIsTaxIncluded(invoice.isTaxIncluded());
					if (!iTax.calculateTaxFromLines())
						return false;
					iTax.saveEx();
					taxList.add(line.getC_Tax_ID());
				}
			}
		}

		//	Taxes
		BigDecimal grandTotal = totalLines;
		MInvoiceTax[] taxes = invoice.getTaxes(true);
		for (int i = 0; i < taxes.length; i++)
		{
			MInvoiceTax iTax = taxes[i];
			if (iTax.getC_TaxProvider_ID() != 0) {
				if (!invoice.isTaxIncluded())
				    grandTotal = grandTotal.add(iTax.getTaxAmt());
		    	continue;
		    }
			MTax tax = iTax.getTax();
			if (tax.isSummary())
			{
				MTax[] cTaxes = tax.getChildTaxes(false);	//	Multiple taxes
				for (int j = 0; j < cTaxes.length; j++)
				{
					MTax cTax = cTaxes[j];
					BigDecimal taxAmt = cTax.calculateTax(iTax.getTaxBaseAmt(), invoice.isTaxIncluded(), invoice.getPrecision());
					//
					MInvoiceTax newITax = new MInvoiceTax(invoice.getCtx(), 0, invoice.get_TrxName());
					newITax.setClientOrg(invoice);
					newITax.setAD_Org_ID(invoice.getAD_Org_ID());
					newITax.setC_Invoice_ID(invoice.getC_Invoice_ID());
					newITax.setC_Tax_ID(cTax.getC_Tax_ID());
					newITax.setPrecision(invoice.getPrecision());
					newITax.setIsTaxIncluded(invoice.isTaxIncluded());
					newITax.setTaxBaseAmt(iTax.getTaxBaseAmt());
					newITax.setTaxAmt(taxAmt);
					newITax.saveEx(invoice.get_TrxName());
					//
					if (!invoice.isTaxIncluded())
						grandTotal = grandTotal.add(taxAmt);
				}
				iTax.deleteEx(true, invoice.get_TrxName());
			}
			else
			{
				if (!invoice.isTaxIncluded())
					grandTotal = grandTotal.add(iTax.getTaxAmt());
			}
		}
		//
		invoice.setTotalLines(totalLines);
		invoice.setGrandTotal(grandTotal);
		return true;
	}

	@Override
	public boolean updateInvoiceTax(MTaxProvider provider, MInvoiceLine line) {
		MTax mtax = new MTax(line.getCtx(), line.getC_Tax_ID(), line.get_TrxName());
    	if (mtax.getC_TaxProvider_ID() == 0)
    		return line.updateInvoiceTax(false);
    	return true;
	}
	
	@Override
	public boolean recalculateTax(MTaxProvider provider, MInvoiceLine line, boolean newRecord) {
		if (!newRecord && line.is_ValueChanged(MInvoiceLine.COLUMNNAME_C_Tax_ID))
		{
			MTax mtax = new MTax(line.getCtx(), line.getC_Tax_ID(), line.get_TrxName());
	    	if (mtax.getC_TaxProvider_ID() == 0)
	    	{
				//	Recalculate Tax for old Tax
				if (!line.updateInvoiceTax(true))
					return false;
	    	}
		}
		return line.updateHeaderTax();
	}

	@Override
	public boolean calculateRMATaxTotal(MTaxProvider provider, MRMA rma) {
		//	Lines
		BigDecimal totalLines = Env.ZERO;
		ArrayList<Integer> taxList = new ArrayList<Integer>();
		MRMALine[] lines = rma.getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MRMALine line = lines[i];
			totalLines = totalLines.add(line.getLineNetAmt());
			Integer taxID = new Integer(line.getC_Tax_ID());
			if (!taxList.contains(taxID))
			{
				MTax tax = new MTax(rma.getCtx(), taxID, rma.get_TrxName());
				if (tax.getC_TaxProvider_ID() != 0)
					continue;
				MRMATax oTax = MRMATax.get (line, rma.getPrecision(), false, rma.get_TrxName());	//	current Tax
				oTax.setIsTaxIncluded(rma.isTaxIncluded());
				if (!oTax.calculateTaxFromLines())
					return false;
				if (!oTax.save(rma.get_TrxName()))
					return false;
				taxList.add(taxID);
			}
		}
		
		//	Taxes
		BigDecimal grandTotal = totalLines;
		MRMATax[] taxes = rma.getTaxes(true);
		for (int i = 0; i < taxes.length; i++)
		{
			MRMATax oTax = taxes[i];
			if (oTax.getC_TaxProvider_ID() != 0) {
				if (!rma.isTaxIncluded())
					grandTotal = grandTotal.add(oTax.getTaxAmt());
				continue;
			}
			MTax tax = oTax.getTax();
			if (tax.isSummary())
			{
				MTax[] cTaxes = tax.getChildTaxes(false);
				for (int j = 0; j < cTaxes.length; j++)
				{
					MTax cTax = cTaxes[j];
					BigDecimal taxAmt = cTax.calculateTax(oTax.getTaxBaseAmt(), rma.isTaxIncluded(), rma.getPrecision());
					//
					MRMATax newOTax = new MRMATax(rma.getCtx(), 0, rma.get_TrxName());
					newOTax.setClientOrg(rma);
					newOTax.setM_RMA_ID(rma.getM_RMA_ID());
					newOTax.setC_Tax_ID(cTax.getC_Tax_ID());
					newOTax.setPrecision(rma.getPrecision());
					newOTax.setIsTaxIncluded(rma.isTaxIncluded());
					newOTax.setTaxBaseAmt(oTax.getTaxBaseAmt());
					newOTax.setTaxAmt(taxAmt);
					if (!newOTax.save(rma.get_TrxName()))
						return false;
					//
					if (!rma.isTaxIncluded())
						grandTotal = grandTotal.add(taxAmt);
				}
				if (!oTax.delete(true, rma.get_TrxName()))
					return false;
				if (!oTax.save(rma.get_TrxName()))
					return false;
			}
			else
			{
				if (!rma.isTaxIncluded())
					grandTotal = grandTotal.add(oTax.getTaxAmt());
			}
		}		
		//
		rma.setAmt(grandTotal);
		return true;
	}

	@Override
	public boolean updateRMATax(MTaxProvider provider, MRMALine line) {
		MTax mtax = new MTax(line.getCtx(), line.getC_Tax_ID(), line.get_TrxName());
    	if (mtax.getC_TaxProvider_ID() == 0)
    		return line.updateOrderTax(false);
    	return true;
	}

	@Override
	public String validateConnection(MTaxProvider provider, ProcessInfo pi) throws Exception {
		throw new IllegalStateException(Msg.getMsg(provider.getCtx(), "ActionNotSupported"));
	}
}
