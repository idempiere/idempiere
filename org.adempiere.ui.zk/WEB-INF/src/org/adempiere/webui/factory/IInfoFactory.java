/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.factory;

import org.adempiere.webui.info.InfoWindow;
import org.adempiere.webui.panel.InfoPanel;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;

/**
 *
 * @author hengsin
 *
 */
public interface IInfoFactory {

	/**
	 * 
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param value
	 * @param multiSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 * @param lookup
	 * @return {@link InfoPanel}
	 */
	public InfoPanel create (int WindowNo,
            String tableName, String keyColumn, String value,
            boolean multiSelection, String whereClause, int AD_InfoWindow_ID, boolean lookup);

	/**
	 * 
	 * @param lookup
	 * @param field
	 * @param tableName
	 * @param keyColumn
	 * @param value
	 * @param multiSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 * @return {@link InfoPanel}
	 */
	public InfoPanel create (Lookup lookup, GridField field,
            String tableName, String keyColumn, String value,
            boolean multiSelection, String whereClause, int AD_InfoWindow_ID);
	
	/**
	 * 
	 * @param AD_InfoWindow_ID
	 * @return {@link InfoWindow}
	 */
	public InfoWindow create (int AD_InfoWindow_ID); 
	
	/**
	 * 
	 * @param AD_InfoWindow_ID
	 * @param predefinedContextVariables
	 * @return {@link InfoWindow}
	 */
	public default InfoWindow create (int windowNo, int AD_InfoWindow_ID, String predefinedContextVariables) {
		return create (AD_InfoWindow_ID);
	}
	
	/**
	 * 
	 * @param AD_InfoWindow_ID
	 * @param predefinedContextVariables
	 * @return {@link InfoWindow}
	 */
	public default InfoWindow create (int AD_InfoWindow_ID, String predefinedContextVariables) {
		return create (AD_InfoWindow_ID, predefinedContextVariables);
	}
}
