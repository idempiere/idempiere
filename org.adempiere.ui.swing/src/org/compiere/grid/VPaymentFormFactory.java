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

import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.compiere.model.GridTab;

/**
 * 
 * @author Elaine
 *
 */
public class VPaymentFormFactory {
	
	public static IPaymentForm getPaymentForm(int windowNo, GridTab mTab, String paymentRule)
	{
		ServiceQuery query = new ServiceQuery();
		query.put("paymentRule", paymentRule);
		return Service.locator().locate(IPaymentForm.class, query).getService();
	}
	
	public static IPaymentForm create(int windowNo, GridTab mTab, String paymentRule)
	{
		IPaymentForm form = getPaymentForm(windowNo, mTab, paymentRule);
		if (form != null)
			form.init(windowNo, mTab);
		return form;
	}
}
