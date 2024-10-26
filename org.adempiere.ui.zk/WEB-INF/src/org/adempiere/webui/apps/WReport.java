/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2007 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2007 Low Heng Sin hengsin@avantz.com
 * _____________________________________________
 *****************************************************************************/
package org.adempiere.webui.apps;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.webui.window.Dialog;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportCtl;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;

/**
 * Launch report for table (immediate or through popup menu, depends on the number of print format discover
 * for AD_Table_ID and AD_Window_ID). 
 * @author Low Heng Sin
 *
 */
public class WReport implements EventListener<Event> {

	/**
	 *	Call {@link #WReport(int, MQuery, Component, int)}
	 *  @param AD_Table_ID table
	 *  @param query query
	 */
	public WReport (int AD_Table_ID, MQuery	query)
	{
		new WReport(AD_Table_ID, query, null, 0);
	}
	
	/**
	 *	Call {@link #WReport(int, MQuery, Component, int, String)}
	 *  @param AD_Table_ID table
	 *  @param query query
	 *  @param parent The invoking parent component
	 *  @param WindowNo The invoking parent window number
	 */
	public WReport (int AD_Table_ID, MQuery	query, Component parent, 
			int WindowNo)
	{
		this(AD_Table_ID, query, parent, WindowNo, null);
	}
	
	/**
	 *	Launch report immediately (if only one print format found) or show menu popup 
	 *  for the list of print formats discover for AD_Table_ID and AD_Window_ID (from WindowNo).
	 *
	 *  @param AD_Table_ID table
	 *  @param query query
	 *  @param parent The invoking parent window
	 *  @param WindowNo The invoking parent window number
	 *  @param whereExtended
	 */
	public WReport (int AD_Table_ID, MQuery	query, Component parent, 
			int WindowNo, String whereExtended)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("AD_Table_ID=" + AD_Table_ID + " " + query);
		if (!MRole.getDefault().isCanReport(AD_Table_ID))
		{
			Dialog.error(0, "AccessCannotReport", query.getTableName());
			return;
		}

		m_query = query;
		this.parent = parent;
		this.WindowNo = WindowNo;
		this.whereExtended = whereExtended;

		int AD_Window_ID = Env.getContextAsInt(Env.getCtx(), WindowNo, "_WinInfo_AD_Window_ID", true);
		if (AD_Window_ID == 0)
			AD_Window_ID = Env.getZoomWindowID(query);
		
		//	See What is there
		getPrintFormats (AD_Table_ID, AD_Window_ID);
	}	//	AReport

	/**	Query parameter **/
	private MQuery	 	m_query;
	/** menu popup to show the list of print formats discover **/
	private Menupopup 	m_popup;
	/**	List of KeyNamePair(AD_PrintFormat_ID,Name)	**/
	private List<KeyNamePair>	m_list = new ArrayList<KeyNamePair>();
	/**	Logger **/
	private static final CLogger log = CLogger.getCLogger(WReport.class);
	/** The invoking parent component **/
	protected Component parent;
	/** The parent window number **/
	protected int WindowNo;
	/** The filter to apply to this report **/
	private String whereExtended;
	
	/**
	 * 	Get Print Formats for table and window.<br/>
	 *  If there's only 1 print format found, call {@link #launchReport(KeyNamePair)}, otherwise call {@link #showPopup()}.
	 * 	@param AD_Table_ID table
	 *  @param AD_Window_ID
	 */
	private void getPrintFormats (int AD_Table_ID, int AD_Window_ID)
	{
		m_list = MPrintFormat.getAccessiblePrintFormats(AD_Table_ID, AD_Window_ID, null, true);

		if (m_list.size() == 1)
			launchReport ((KeyNamePair)m_list.get(0));
		//	Multiple Formats exist - show selection
		else 
			showPopup();	//	below button
	}	//	getPrintFormats

	/**
	 * Show popup menu for the list of print formats found.
	 */
	private void showPopup() {
		m_popup = new Menupopup();		
		for(int i = 0; i < m_list.size(); i++)
		{
			KeyNamePair pp = (KeyNamePair) m_list.get(i);
			Menuitem menuitem = new Menuitem(pp.getName());
			menuitem.setValue(i + "");
			menuitem.addEventListener(Events.ON_CLICK, this);
			m_popup.appendChild(menuitem);
		}
		m_popup.setPage(parent.getPage());
		m_popup.open(parent);
	}

	/**
	 * 	Launch Report
	 * 	@param pp KeyNamePair(AD_PrintFormat_ID,Name)
	 */
	private void launchReport (KeyNamePair pp)
	{
		MPrintFormat pf = MPrintFormat.get(Env.getCtx(), pp.getKey(), false);
		launchReport (pf);
	}	//	launchReport

	/**
	 * 	Launch Report
	 * 	@param pf print format
	 */
	private void launchReport (MPrintFormat pf)
	{
		int Record_ID = 0;
		if (m_query.getRestrictionCount() == 1) {
			if (m_query.getColumnName(0).equals(m_query.getTableName()+"_ID")) {
				Object vrec = m_query.getCode(0);
				if (vrec instanceof Integer) {
					Record_ID = ((Integer)m_query.getCode(0)).intValue();
				} else {
					try {
						Record_ID = Integer.parseInt(m_query.getCode(0).toString());
					} catch (NumberFormatException e) {
						log.info(e.getMessage());
					}
				}
			}
		}
		PrintInfo info = new PrintInfo(
			pf.getName(),
			pf.getAD_Table_ID(),
			Record_ID);
		info.setDescription(m_query.getInfo());
		
		if(pf != null && pf.getJasperProcess_ID() > 0)
		{
			// It's a report using the JasperReports engine
			ProcessInfo pi = new ProcessInfo ("", pf.getJasperProcess_ID(), pf.getAD_Table_ID(), Record_ID);
			
			//	Execute Process
			WProcessCtl.process(WindowNo, pi, null);
		}
		else
		{
			// It's a default report using the standard printing engine
			ReportEngine re = new ReportEngine (Env.getCtx(), pf, m_query, info, null, WindowNo);
			re.setWhereExtended(whereExtended);
			ReportCtl.preview(re);
		}
	}	//	launchReport

	/**
	 * 	Get AD_Table_ID for Table Name
	 * 	@param tableName table name
	 * 	@return AD_Table_ID or 0
	 */
	public static int getAD_Table_ID (String tableName)
	{
		return MTable.getTable_ID(tableName);
	}	//	getAD_Table_ID

	@Override
	public void onEvent(Event event) {
		if(event.getTarget() instanceof Menuitem)
		{
			//ON_CLICK event from showPopup() menu item. 
			Menuitem mi = (Menuitem) event.getTarget();
			launchReport(m_list.get(Integer.parseInt(mi.getValue().toString())));
		}
	}		
}
