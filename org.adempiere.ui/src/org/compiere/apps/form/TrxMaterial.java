/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.compiere.apps.form;

import static org.compiere.model.SystemIDs.WINDOW_MATERIALTRANSACTIONS_INDIRECTUSER;

import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.apps.IStatusBar;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.I_C_ProjectIssue;
import org.compiere.model.I_M_InOutLine;
import org.compiere.model.I_M_InventoryLine;
import org.compiere.model.I_M_MovementLine;
import org.compiere.model.I_M_ProductionLine;
import org.compiere.model.I_M_Transaction;
import org.compiere.model.MQuery;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;

public class TrxMaterial {

	/**	Window No			*/
	public int         	m_WindowNo = 0;
	/** MWindow                 */
	public GridWindow         m_mWindow = null;
	/** MTab pointer            */
	public GridTab            m_mTab = null;

	public MQuery          m_staticQuery = null;
	/**	Logger			*/
	public static CLogger log = CLogger.getCLogger(TrxMaterial.class);
	
	/**
	 *  Dynamic Layout (Grid).
	 * 	Based on AD_Window: Material Transactions
	 */
	public void dynInit(IStatusBar statusBar)
	{
		m_staticQuery = new MQuery();
		m_staticQuery.addRestriction("AD_Client_ID", MQuery.EQUAL, Env.getAD_Client_ID(Env.getCtx()));
		int AD_Window_ID = WINDOW_MATERIALTRANSACTIONS_INDIRECTUSER;		//	Hardcoded
		GridWindowVO wVO = Env.getMWindowVO (m_WindowNo, AD_Window_ID, 0);
		if (wVO == null)
			return;
		m_mWindow = new GridWindow (wVO);
		m_mTab = m_mWindow.getTab(0);
		m_mWindow.initTab(0);
		//
		m_mTab.setQuery(MQuery.getEqualQuery("1", "2"));
		m_mTab.query(false);
		statusBar.setStatusLine(" ", false);
		statusBar.setStatusDB(" ");
	}   //  dynInit
	
	/**************************************************************************
	 *  Refresh - Create Query and refresh grid
	 */
	public void refresh(Object organization, Object locator, Object product, Object movementType, 
			Timestamp movementDateFrom, Timestamp movementDateTo, IStatusBar statusBar)
	{
		/**
		 *  Create Where Clause
		 */
		MQuery query = m_staticQuery.deepCopy();
		//  Organization
		if (organization != null && organization.toString().length() > 0)
			query.addRestriction("AD_Org_ID", MQuery.EQUAL, organization);
		//  Locator
		if (locator != null && locator.toString().length() > 0)
			query.addRestriction("M_Locator_ID", MQuery.EQUAL, locator);
		//  Product
		if (product != null && product.toString().length() > 0)
			query.addRestriction("M_Product_ID", MQuery.EQUAL, product);
		//  MovementType
		if (movementType != null && movementType.toString().length() > 0)
			query.addRestriction("MovementType", MQuery.EQUAL, movementType);
		//  DateFrom
		if (movementDateFrom != null)
			query.addRestriction("TRUNC(MovementDate)", MQuery.GREATER_EQUAL, movementDateFrom);
		//  DateTO
		if (movementDateTo != null)
			query.addRestriction("TRUNC(MovementDate)", MQuery.LESS_EQUAL, movementDateTo);
		if (log.isLoggable(Level.INFO)) log.info( "VTrxMaterial.refresh query=" + query.toString());

		/**
		 *  Refresh/Requery
		 */
		statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), "StartSearch"), false);
		//
		m_mTab.setQuery(query);
		m_mTab.query(false);
		//
		int no = m_mTab.getRowCount();
		statusBar.setStatusLine(" ", false);
		statusBar.setStatusDB(Integer.toString(no));
	}   //  refresh
	
	public int AD_Table_ID;
	public int Record_ID;
	/**
	 *  Zoom
	 */
	public void zoom()
	{
		log.info("");
		//
		AD_Table_ID = 0;
		Record_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNo, I_M_Transaction.COLUMNNAME_M_InOutLine_ID);
		if (Record_ID != 0) {
			AD_Table_ID = I_M_InOutLine.Table_ID;
		} else {
			Record_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNo, I_M_Transaction.COLUMNNAME_M_InventoryLine_ID);
			if (Record_ID != 0) {
				AD_Table_ID = I_M_InventoryLine.Table_ID;
			} else {
				Record_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNo, I_M_Transaction.COLUMNNAME_M_MovementLine_ID);
				if (Record_ID != 0) {
					AD_Table_ID = I_M_MovementLine.Table_ID;
				} else {
					Record_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNo, I_M_Transaction.COLUMNNAME_M_ProductionLine_ID);
					if (Record_ID != 0) {
						AD_Table_ID = I_M_ProductionLine.Table_ID;
					} else {
						Record_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNo, I_M_Transaction.COLUMNNAME_C_ProjectIssue_ID);
						if (Record_ID != 0) {
							AD_Table_ID = I_C_ProjectIssue.Table_ID;
						} else {
							log.warning("Not found zoom table WindowNo=" + m_WindowNo);
						}
					}
				}
			}
		}
	}   //  zoom


}
