/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.process;

import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MProduct;
import org.eevolution.model.MPPProductBOMLine;

/**
 * 
 * @author hengsin
 *
 */
@org.adempiere.base.annotation.Process
public class UniversalSubstitution extends SvrProcess {

	int productId = 0;
	int replacementId = 0;

	@Override
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (name.equals("M_Product_ID"))
				productId  = para[i].getParameterAsInt();
			else if (name.equals("Substitute_ID"))
				replacementId =para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);		
		}
	}

	@Override
	protected String doIt() throws SQLException {

		if ( productId == 0 || replacementId == 0 )
			throw new AdempiereException("Product and replacement product required");
		
		MProduct product = new MProduct(getCtx(), productId, get_TrxName());
		List<MPPProductBOMLine> boms = MPPProductBOMLine.getByProduct(product);
		
		int count = 0;
		// Use model class to invalidate the product
		for (MPPProductBOMLine bom : boms) {
			bom.setM_Product_ID(replacementId);
			bom.saveEx();
			count++;
		}
		StringBuilder msgreturn = new StringBuilder().append(count).append(" BOM Line products updated");
		return msgreturn.toString();
	}

}
