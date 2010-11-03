package org.adempiere.webui;

import org.adempiere.base.Core;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;

public class Extensions {

	public static Object getForm(String id) {
		if (Core.isExtension(id)) {
			id = id.substring(Core.OSGI_PREFIX.length());
		}

		ServiceQuery query = new ServiceQuery();
		query.put(ServiceQuery.EXTENSION_ID, id);
		return Service.locate(Object.class, "org.adempiere.webui.Form", query);
	}
}
