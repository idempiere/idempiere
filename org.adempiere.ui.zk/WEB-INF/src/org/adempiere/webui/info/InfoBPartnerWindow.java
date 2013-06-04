/**
 * 
 */
package org.adempiere.webui.info;

import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.panel.InvoiceHistory;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
public class InfoBPartnerWindow extends InfoWindow {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7970170769665110830L;

	private int m_AD_User_ID_index = -1;
    private int m_C_BPartner_Location_ID_index = -1;

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
		if (!isLookup() && Util.isEmpty(isSOTrx)) {
			isSOTrx = "Y";
		}
		
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
	
	@Override
	protected void saveSelectionDetail() {
        int row = contentPanel.getSelectedRow();
        if (row == -1)
            return;

        int AD_User_ID = 0;
        int C_BPartner_Location_ID = 0;
        
        if (m_AD_User_ID_index != -1)
        {
            Object data =contentPanel.getValueAt(row, m_AD_User_ID_index);
            if (data instanceof KeyNamePair)
            	AD_User_ID = ((KeyNamePair)data).getKey();
        }
        //
        if (m_C_BPartner_Location_ID_index != -1)
        {
            Object data =contentPanel.getValueAt(row, m_C_BPartner_Location_ID_index);
            if (data instanceof KeyNamePair)
                C_BPartner_Location_ID = ((KeyNamePair)data).getKey();
        }
        //  publish for Callout to read
        Integer ID = getSelectedRowKey();
        Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "C_BPartner_ID", ID == null ? "0" : ID.toString());
        Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "AD_User_ID", String.valueOf(AD_User_ID));
        Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "C_BPartner_Location_ID", String.valueOf(C_BPartner_Location_ID));
       
		super.saveSelectionDetail();
	}
	
	@Override
	protected void prepareTable() {
		super.prepareTable();

		// Get indexes
        for (int i = 0; i < p_layout.length; i++)
        {
        	if (p_layout[i].getKeyPairColSQL().indexOf("AD_User_ID") != -1)
				m_AD_User_ID_index = i;
        	//
            if (p_layout[i].getKeyPairColSQL().indexOf("C_BPartner_Location_ID") != -1)
                m_C_BPartner_Location_ID_index = i;
        }
	}

}
