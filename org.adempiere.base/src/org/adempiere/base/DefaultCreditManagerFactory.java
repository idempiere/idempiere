/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.adempiere.base;

import org.compiere.model.MInOut;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MPayment;
import org.compiere.model.PO;
import org.compiere.model.credit.CreditManagerInOut;
import org.compiere.model.credit.CreditManagerInvoice;
import org.compiere.model.credit.CreditManagerOrder;
import org.compiere.model.credit.CreditManagerPayment;
import org.osgi.service.component.annotations.Component;

/**
 * Default Credit Manager Factory
 * 
 * @author Logilite Technologies
 * @since  June 25, 2023
 */
@Component(immediate = true, service = ICreditManagerFactory.class)
public class DefaultCreditManagerFactory implements ICreditManagerFactory
{

	@Override
	public ICreditManager getCreditManager(PO po)
	{
		if (po instanceof MOrder)
			return new CreditManagerOrder((MOrder) po);
		else if (po instanceof MInvoice)
			return new CreditManagerInvoice((MInvoice) po);
		else if (po instanceof MPayment)
			return new CreditManagerPayment((MPayment) po);
		else if (po instanceof MInOut)
			return new CreditManagerInOut((MInOut) po);
		return null;
	}

}
