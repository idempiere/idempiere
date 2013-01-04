/**
 * 
 */
package org.adempiere.webui.info;

/**
 * @author hengsin
 *
 */
public class InfoPAttributeWindow extends InfoWindow {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4554543873526769338L;

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 */
	public InfoPAttributeWindow(int WindowNo, String tableName,
			String keyColumn, String queryValue, boolean multipleSelection,
			String whereClause, int AD_InfoWindow_ID) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 * @param lookup
	 */
	public InfoPAttributeWindow(int WindowNo, String tableName,
			String keyColumn, String queryValue, boolean multipleSelection,
			String whereClause, int AD_InfoWindow_ID, boolean lookup) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID, lookup);
		// TODO Auto-generated constructor stub
	}

}
