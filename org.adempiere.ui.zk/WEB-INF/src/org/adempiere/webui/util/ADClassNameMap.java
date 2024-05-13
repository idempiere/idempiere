package org.adempiere.webui.util;

import java.util.HashMap;
import java.util.Map;

/**
 * Class name mapping between Swing client and Zk Web Client
 */
public class ADClassNameMap {

	/** Swing Class Name:Zk Class Name */
	private static Map<String, String> map = new HashMap<String, String>();
	
	static {
		map.put("org.compiere.apps.wf.WFPanel", "org.adempiere.webui.apps.wf.WFEditor");
	}
	
	/**
	 * 
	 * @param src swing client class name
	 * @return zk class name
	 */
	public static String get(String src) {
		return map.get(src);
	}
	
	/**
	 * 
	 * @param src swing class name
	 * @param target zk class name
	 */
	public static void add(String src, String target) {
		map.put(src, target);
	}
}
