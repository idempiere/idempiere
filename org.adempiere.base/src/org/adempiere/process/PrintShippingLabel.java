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
 **********************************************************************/
package org.adempiere.process;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.compiere.model.MAttachment;
import org.compiere.model.MPackage;
import org.compiere.model.MShipperLabels;
import org.compiere.process.SvrProcess;

/**
 * Process to perform printing of shipping label that have been attached to {@link MPackage}.
 * Uses {@link IPrintShippingLabel} service to print as image or to label printer.
 */
@org.adempiere.base.annotation.Process
public class PrintShippingLabel extends SvrProcess 
{
	private MPackage m_package;
	
	@Override
	protected void prepare() 
	{
		m_package = new MPackage(getCtx(), getRecord_ID(), get_TrxName());
	}

	@Override
	protected String doIt() throws Exception 
	{
		MAttachment attachment = m_package.getAttachment(true);
		if (attachment == null)
			return "No labels";

		int labelId = m_package.getM_ShipperLabels_ID();
		if (labelId <= 0)
			return "Label format not defined.";

		IPrintShippingLabel service = getService();
		if (service != null)
		{
			MShipperLabels label = new MShipperLabels(getCtx(), labelId, get_TrxName());		
			if (MShipperLabels.LABELPRINTMETHOD_Image.equals(label.getLabelPrintMethod()))
				return service.printImageLabel(attachment, label, getProcessInfo().getTitle());
			else
				return service.printToLabelPrinter(attachment, label);
		}
		else
			return "Not found in service/extension registry and classpath";
	}

	private static IServiceReferenceHolder<IPrintShippingLabel> s_serviceReference = null;
	
	private synchronized static IPrintShippingLabel getService() {
		if (s_serviceReference != null) {
			IPrintShippingLabel service = s_serviceReference.getService();
			if (service != null)
				return service;
		}
		IServiceReferenceHolder<IPrintShippingLabel> serviceReference = Service.locator().locate(IPrintShippingLabel.class).getServiceReference();
		if (serviceReference != null) {
			IPrintShippingLabel service = serviceReference.getService();
			if (service != null) {
				s_serviceReference = serviceReference;
				return service;
			}
		}
		return null;
		
	}
}