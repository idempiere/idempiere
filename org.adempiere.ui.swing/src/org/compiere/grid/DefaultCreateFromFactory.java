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
package org.compiere.grid;

import org.compiere.model.GridTab;
import org.compiere.model.I_C_BankStatement;
import org.compiere.model.I_C_Invoice;
import org.compiere.model.I_M_InOut;
import org.compiere.model.I_M_PackageMPS;
import org.compiere.model.I_M_RMA;
import org.compiere.model.I_X_DepositBatch;

/**
 * 
 * @author Elaine
 *
 */
public class DefaultCreateFromFactory implements ICreateFromFactory 
{

	@Override
	public ICreateFrom create(GridTab mTab, String columnName) 
	{
		String tableName = mTab.getTableName();
		if (columnName.equals("CreateFrom"))
		{			
			if (tableName.equals(I_C_Invoice.Table_Name))
				return new VCreateFromInvoiceUI(mTab);
			else if (tableName.equals(I_C_BankStatement.Table_Name))
//				return new VCreateFromStatementUI(mTab);
				return new VCreateFromStatementBatchUI(mTab);
			else if (tableName.equals(I_M_InOut.Table_Name))
				return new VCreateFromShipmentUI(mTab);
			else if (tableName.equals(I_M_RMA.Table_Name))
				return new VCreateFromRMAUI(mTab);
			else if (tableName.equals(I_M_PackageMPS.Table_Name))
				return new VCreateFromPackageShipmentUI(mTab);
			else if (tableName.equals(I_X_DepositBatch.Table_Name))
				return new VCreateFromDepositBatchUI(mTab);
		}
		else if (columnName.equalsIgnoreCase("X_CreateFromBatch"))
		{
			if (tableName.equals(I_C_BankStatement.Table_Name))
				return new VCreateFromBatchStatementUI(mTab);
		}
		return null;
	}

}
