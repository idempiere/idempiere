package org.adempiere.client;

import org.adempiere.base.Core;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.compiere.apps.form.FormPanel;

public class Client {

	public static FormPanel getFormPanel(String className) {
		if (Core.isExtension(className))
			className = className.substring(Core.OSGI_PREFIX.length());
		ServiceQuery query = new ServiceQuery();
		query.put("class", className);
		return Service.locate(FormPanel.class, query );
	}

}
