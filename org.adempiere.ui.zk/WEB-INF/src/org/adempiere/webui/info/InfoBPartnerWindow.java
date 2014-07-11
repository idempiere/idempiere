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
	private static final long serialVersionUID = -5291476382115985651L;

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

	/**
	 * {@inheritDoc}
	 * set value of checkbox IsVendor and IsCustomer by IsSOTrx flag
	 */
	@Override
	protected void initParameters() {
		String isSOTrx = Env.getContext(Env.getCtx(), p_WindowNo, "IsSOTrx");
		if (!isLookup() && Util.isEmpty(isSOTrx)) {
			isSOTrx = "Y";
		}
		
		if (!Util.isEmpty(isSOTrx)) {
			if ("Y".equals(isSOTrx)) {
				// set value of IsCustomer checkbox
				for (WEditor editor : editors) {
					if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("IsCustomer")) {
						editor.setValue("Y");
						break;
					}
				}
			} else if ("N".equals(isSOTrx)) {
				// set value of IsVendor checkbox
				for (WEditor editor : editors) {
					if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("IsVendor")) {
						editor.setValue("Y");
						break;
					}
				}
			}
		}
	}
	
	@Override
	protected void saveSelectionDetail() {
        int row = contentPanel.getSelectedRow();
        if (row == -1)
            return;

 		super.saveSelectionDetail();

        //  publish for Callout to read
        Integer ID = getSelectedRowKey();
        Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "C_BPartner_ID", ID == null ? "0" : ID.toString());
	}
	
}
