package org.adempiere.webui.factory;

import org.adempiere.webui.grid.IQuickEntry;
import org.adempiere.webui.grid.WQuickEntry;


/**
 * @author Andreas Sumerauer
 */
public class DefaultQuickEntryFactory implements IQuickEntryFactory {

	@Override
	public IQuickEntry newQuickEntryInstance(int WindowNo, int TabNo, int AD_Window_ID) {
		return new WQuickEntry(WindowNo, TabNo, AD_Window_ID);
	}

	@Override
	public IQuickEntry newQuickEntryInstance(int AD_Window_ID) {
		return new WQuickEntry(AD_Window_ID);
	}
}
