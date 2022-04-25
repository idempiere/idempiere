/**
 * 
 */
package org.adempiere.webui.info;

import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class InfoInvoiceWindow extends InfoWindow {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5175983673145977830L;

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 */
	public InfoInvoiceWindow(int WindowNo, String tableName, String keyColumn,
			String queryValue, boolean multipleSelection, String whereClause,
			int AD_InfoWindow_ID) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID);
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
	public InfoInvoiceWindow(int WindowNo, String tableName, String keyColumn,
			String queryValue, boolean multipleSelection, String whereClause,
			int AD_InfoWindow_ID, boolean lookup) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID, lookup);
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
	 * @param predefinedContextVariables
	 */
	public InfoInvoiceWindow(int WindowNo, String tableName, String keyColumn,
			String queryValue, boolean multipleSelection, String whereClause,
			int AD_InfoWindow_ID, boolean lookup, String predefinedContextVariables) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID, lookup, null, predefinedContextVariables);
	}
	
	@Override
	protected void saveSelectionDetail() {
        int row = contentPanel.getSelectedRow();
        if (row == -1)
            return;

		super.saveSelectionDetail();

        //  publish for Callout to read
        Integer ID = getSelectedRowKey();
        Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "C_Invoice_ID", ID == null ? "0" : ID.toString());
	}

}
