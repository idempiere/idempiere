package org.adempiere.testplugin;

import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.compiere.model.Callout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;

public class MyCallout1 implements IColumnCallout {

	public String start(Properties ctx, int WindowNo, GridTab mTab,
			GridField mField, Object value, Object oldValue) {
		System.out.println("Callout on C_Order.Description: "+oldValue+"->"+value);
		return null;
	}

}
