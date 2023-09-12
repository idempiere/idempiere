/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.info;

import java.util.logging.Level;

import org.adempiere.webui.panel.InvoiceHistory;
import org.compiere.model.GridField;
import org.compiere.model.MBPartner;
import org.compiere.util.Env;

/**
 * Info window for C_BPartner
 * @author hengsin
 *
 */
public class InfoBPartnerWindow extends InfoWindow {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 240758053410996182L;

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
	 * @param field
	 */
	public InfoBPartnerWindow(int WindowNo, String tableName, String keyColumn,
			String queryValue, boolean multipleSelection, String whereClause,
			int AD_InfoWindow_ID, boolean lookup, GridField field) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID, lookup, field);
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
	 * @param field
	 * @param predefinedContextVariables
	 */
	public InfoBPartnerWindow(int WindowNo, String tableName, String keyColumn,
			String queryValue, boolean multipleSelection, String whereClause,
			int AD_InfoWindow_ID, boolean lookup, GridField field, String predefinedContextVariables) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID, lookup, field, predefinedContextVariables);
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
	
	/**
	 *	Show History
	 */
	@Override
	protected void showHistory()
	{
		if (log.isLoggable(Level.INFO))
			log.info("");
		Integer C_BPartner_ID = getIntSelectedRowKey(MBPartner.Table_ID);
		if (C_BPartner_ID == null)
			return;
		InvoiceHistory ih = new InvoiceHistory (this, C_BPartner_ID.intValue(), 
			0, 0, 0);
		ih.setVisible(true);
		ih = null;
	}	//	showHistory

	
	@Override
	protected void saveSelectionDetail() {
        int row = contentPanel.getSelectedRow();
        if (row == -1)
            return;

 		super.saveSelectionDetail();

        //  publish for Callout to read
        Integer ID = getIntSelectedRowKey(MBPartner.Table_ID);
        Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "C_BPartner_ID", ID == null ? "0" : ID.toString());
	}
	
}
