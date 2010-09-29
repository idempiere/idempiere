/**
 * 
 */
package org.adempiere.pipo2;

import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;

/**
 * @author hengsin
 *
 */
public class OSGiHandlerRegistry implements IHandlerRegistry {

	private final static String SERVICE_ID = "org.adempiere.pipo.Handlers";
	/**
	 * 
	 */
	public OSGiHandlerRegistry() {
		// TODO Auto-generated constructor stub
	}

	/* (non-Javadoc)
	 * @see org.adempiere.pipo2.IHandlerRegistry#getHandler(org.adempiere.pipo2.Element)
	 */
	@Override
	public ElementHandler getHandler(Element element) {
		String id = null;
		ElementHandler handler = null;
		String type = element.attributes.getValue("type");
		if (ELEMENT_TYPE_TRANSLATION.equals(type)) {
			id = TABLE_TRANSLATION_HANDLER;
		} else {
			id = element.getElementValue();
		}
		
		ServiceQuery query = new ServiceQuery();
		query.put("id", id);
		handler = Service.locate(ElementHandler.class, SERVICE_ID, query);
		if (handler == null) {
			id = TABLE_GENERIC_HANDLER;
			query.put("id", id);
			handler = Service.locate(ElementHandler.class, SERVICE_ID, query);
		}
		return handler;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.pipo2.IHandlerRegistry#getHandler(java.lang.String)
	 */
	@Override
	public ElementHandler getHandler(String name) {
		ElementHandler handler = null;
		ServiceQuery query = new ServiceQuery();
		query.put("id", name);
		handler = Service.locate(ElementHandler.class, SERVICE_ID, query);
		return handler;
	}
}
