package org.adempiere.process;

import org.compiere.model.MAttachment;
import org.compiere.model.MShipperLabels;

public interface IPrintShippingLabel {

	public String printToLabelPrinter(MAttachment attachment, MShipperLabels labelType) throws Exception;
	
	public String printImageLabel(MAttachment attachment, MShipperLabels labelType, String title) throws Exception;
	
}