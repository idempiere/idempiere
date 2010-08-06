package org.adempiere.pipo2;

public interface IHandlerRegistry {

	public static final String ELEMENT_TYPE_TRANSLATION = "translation";
	public static final String ELEMENT_TYPE_TABLE = "table";
	public static final String ELEMENT_TYPE_TASK = "task";
	public static final String ELEMENT_TYPE_PROPERTIES = "properties";
	
	public static final String TABLE_TRANSLATION_HANDLER = "table.translationHandler";
	public static final String TABLE_GENERIC_HANDLER = "table.genericHandler";
	
	/**
	 * @param element
	 * @return ElementHandler
	 */
	public ElementHandler getHandler(Element element);
	
	/**
	 * @param name
	 * @return ElementHandler
	 */
	public ElementHandler getHandler(String name);
}
