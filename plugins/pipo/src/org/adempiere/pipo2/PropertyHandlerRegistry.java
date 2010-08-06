/**
 * 
 */
package org.adempiere.pipo2;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.handler.CommonTranslationHandler;
import org.adempiere.pipo2.handler.GenericPOElementHandler;

/**
 * @author hengsin
 *
 */
public class PropertyHandlerRegistry implements IHandlerRegistry {

	private static Properties handlerRegistry;
	
	static {
    	handlerRegistry = new Properties();
		try {
			handlerRegistry.load((PackInHandler.class.getResourceAsStream("pipo-handler.properties")));
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
	
	private Map<String, ElementHandler>handlers = null;
	
	/**
	 * default constructor
	 */
	public PropertyHandlerRegistry() {
		handlers = new HashMap<String, ElementHandler>();
    	handlers.put(TABLE_GENERIC_HANDLER, new GenericPOElementHandler());
    	handlers.put(TABLE_TRANSLATION_HANDLER, new CommonTranslationHandler());
	}

	/**
	 * @see org.adempiere.pipo2.IHandlerRegistry#getHandler(org.adempiere.pipo2.Element)
	 */
	@Override
	public ElementHandler getHandler(Element element) {
		ElementHandler handler = null;
		String type = element.attributes.getValue("type");
		if (ELEMENT_TYPE_TRANSLATION.equals(type))
			handler = handlers.get(TABLE_TRANSLATION_HANDLER);
		else
			handler = handlers.get(element.getElementValue());
		if (handler == null)
		{
			String className = handlerRegistry.getProperty(element.getElementValue());
			if (className != null)
			{
				try
				{
					Class<?> clazz = getClass().getClassLoader().loadClass(className);
					handler = (ElementHandler) clazz.newInstance();
				}
				catch (Exception e)
				{
					throw new AdempiereException(e.getLocalizedMessage(), e);
				}
				handlers.put(element.getElementValue(), handler);
			}
			else
			{
				handler = handlers.get(TABLE_GENERIC_HANDLER);
			}
		}
		return handler;
	}

	/**
	 * @see org.adempiere.pipo2.IHandlerRegistry#getHandler(java.lang.String)
	 */
	@Override
	public ElementHandler getHandler(String name) {
		String className = handlerRegistry.getProperty(name);
		ElementHandler handler = className != null ? handlers.get(className) : null;
		if (handler == null && className != null)
		{
			try
			{
				Class<?> clazz = getClass().getClassLoader().loadClass(className);
				handler = (ElementHandler)clazz.newInstance();
				handlers.put(className, handler);
			} catch (Exception e)
			{
				throw new AdempiereException(e.getLocalizedMessage(), e);
			}
		}
		return handler;
	}

}
