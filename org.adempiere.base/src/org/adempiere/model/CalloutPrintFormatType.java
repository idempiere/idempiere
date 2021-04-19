package org.adempiere.model;

import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.X_AD_PrintFormatItem;
import org.compiere.util.DB;

public class CalloutPrintFormatType implements IColumnCallout {

	@Override
	public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {

		String printFormatType = (String)value;

		if(!X_AD_PrintFormatItem.PRINTFORMATTYPE_Script.equals(printFormatType))
			return null;

		int AD_PrintFormat_ID = (Integer) mTab.getValue("AD_PrintFormat_ID");

		int count = DB.getSQLValue(null, "SELECT count(*) FROM AD_PrintFormatItem WHERE PrintFormatType = 'S' AND AD_PrintFormat_ID =  ?",AD_PrintFormat_ID);
		mTab.setValue("Name", "SCRIPTCOLUMN"+count );

		return null;
	}

}
