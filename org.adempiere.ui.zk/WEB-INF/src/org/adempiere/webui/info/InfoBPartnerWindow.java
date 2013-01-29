/**
 * 
 */
package org.adempiere.webui.info;

import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.panel.InvoiceHistory;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
public class InfoBPartnerWindow extends InfoWindow {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8994747783253141939L;

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 */
	public InfoBPartnerWindow(int WindowNo, String tableName, String keyColumn,
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
	public InfoBPartnerWindow(int WindowNo, String tableName, String keyColumn,
			String queryValue, boolean multipleSelection, String whereClause,
			int AD_InfoWindow_ID, boolean lookup) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID, lookup);
	}

	/**
	 *	Has History
	 *  @return true
	 */
	@Override
	protected boolean hasHistory()
	{
		return true;
	}	//	hasHistory
	
	// Elaine 2008/12/16
	/**************************************************************************
	 *	Show History
	 */
	@Override
	protected void showHistory()
	{
		log.info("");
		Integer C_BPartner_ID = getSelectedRowKey();
		if (C_BPartner_ID == null)
			return;
		InvoiceHistory ih = new InvoiceHistory (this, C_BPartner_ID.intValue(), 
			0, 0, 0);
		ih.setVisible(true);
		ih = null;
	}	//	showHistory

	@Override
	protected void createParameterPanel() {
		super.createParameterPanel();
		String isSOTrx = Env.getContext(Env.getCtx(), p_WindowNo, "IsSOTrx");
		if (!Util.isEmpty(isSOTrx)) {
			if ("Y".equals(isSOTrx)) {
				for (WEditor editor : editors) {
					if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("IsCustomer")) {
						editor.setValue("Y");
						break;
					}
				}
			} else if ("N".equals(isSOTrx)) {
				for (WEditor editor : editors) {
					if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("IsVendor")) {
						editor.setValue("Y");
						break;
					}
				}
			}
		}
	}
}
