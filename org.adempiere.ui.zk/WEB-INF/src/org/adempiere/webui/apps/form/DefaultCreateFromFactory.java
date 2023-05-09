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
package org.adempiere.webui.apps.form;

import org.compiere.grid.ICreateFrom;
import org.compiere.grid.ICreateFromFactory;
import org.compiere.model.GridTab;
import org.compiere.model.I_C_BankStatement;
import org.compiere.model.I_C_Invoice;
import org.compiere.model.I_M_InOut;
import org.compiere.model.I_M_PackageMPS;
import org.compiere.model.I_M_RMA;
import org.compiere.model.I_C_DepositBatch;

/**
 * Default implementation of {@link ICreateFromFactory}
 * @author Elaine
 */
public class DefaultCreateFromFactory implements ICreateFromFactory 
{

	@Override
	public ICreateFrom create(GridTab mTab) 
	{
		String tableName = mTab.getTableName();
		if (tableName.equals(I_C_Invoice.Table_Name))
			return new WCreateFromInvoiceUI(mTab);
		else if (tableName.equals(I_C_BankStatement.Table_Name))
			return new WCreateFromStatementUI(mTab);
		else if (tableName.equals(I_M_InOut.Table_Name))
			return new WCreateFromShipmentUI(mTab);
		else if (tableName.equals(I_M_RMA.Table_Name))
			return new WCreateFromRMAUI(mTab);
		else if (tableName.equals(I_M_PackageMPS.Table_Name))
			return new WCreateFromPackageShipmentUI(mTab);
		else if (tableName.equals(I_C_DepositBatch.Table_Name))
			return new WCreateFromDepositBatchUI(mTab);
		return null;
	}

}