package org.adempiere.process;

import org.adempiere.base.Service;
import org.compiere.model.MAttachment;
import org.compiere.model.MPackage;
import org.compiere.model.MShipperLabels;
import org.compiere.process.SvrProcess;

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

		IPrintShippingLabel service = Service.locator().locate(IPrintShippingLabel.class).getService();
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
}