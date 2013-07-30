/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.idempiere.process;

import java.math.BigDecimal;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MProduct;
import org.compiere.process.SvrProcess;

/**
 * @author hengsin
 *
 */
public class CostAdjustmentLineRefreshCost extends SvrProcess {

	/**
	 * 
	 */
	public CostAdjustmentLineRefreshCost() {
	}

	/* (non-Javadoc)
	 * @see org.compiere.process.SvrProcess#prepare()
	 */
	@Override
	protected void prepare() {
	}

	/* (non-Javadoc)
	 * @see org.compiere.process.SvrProcess#doIt()
	 */
	@Override
	protected String doIt() throws Exception {
		MInventoryLine line = new MInventoryLine(getCtx(), getRecord_ID(), null);
		MProduct product = line.getProduct();
		MClient client = MClient.get(getCtx(), line.getAD_Client_ID());
		MAcctSchema as = client.getAcctSchema();
		MCost cost = product.getCostingRecord(as, line.getAD_Org_ID(), line.getM_AttributeSetInstance_ID(), line.getM_Inventory().getCostingMethod());
		if (cost != null) {
			line.setCurrentCostPrice(cost.getCurrentCostPrice());
			line.setNewCostPrice(cost.getCurrentCostPrice());
			line.saveEx();
		} else {
			line.setCurrentCostPrice(BigDecimal.ZERO);
			line.setNewCostPrice(BigDecimal.ZERO);
			line.saveEx();
		}
		
		return "@Ok@";
	}
}
