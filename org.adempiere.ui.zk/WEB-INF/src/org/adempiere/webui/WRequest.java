/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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

package org.adempiere.webui;

import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.GridTab;
import org.compiere.model.MQuery;
import org.compiere.model.MRequest;
import static org.compiere.model.SystemIDs.*;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.Popup;

/**
 *	Handle Request Button Action.
 *	Show Popup Menu.
 *	
 *  @author Jorg Janke
 *  @version $Id: ARequest.java,v 1.2 2006/07/30 00:51:27 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1904928 ] Request: Related Request field not filled
 */
public class WRequest implements EventListener<Event>
{
	/**
	 * 	Constructor
	 *	@param invoker invoker button
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param C_BPartner_ID optional bp
	 */
	public WRequest (Component invoker, int AD_Table_ID, int Record_ID, int C_BPartner_ID)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("AD_Table_ID=" + AD_Table_ID + ", Record_ID=" + Record_ID);
		m_AD_Table_ID = AD_Table_ID;
		m_Record_ID = Record_ID;
		m_C_BPartner_ID = C_BPartner_ID;
		getRequests(invoker);
		
	}	//	WRequest

	/**	The Table						*/
	private int			m_AD_Table_ID;
	/** The Record						*/
	private int			m_Record_ID;
	/** BPartner						*/
	private int			m_C_BPartner_ID;
	
	/**	The Popup						*/
	private Menupopup 	m_popup = new Menupopup();
	private Menuitem 	m_new = null;
	private Menuitem 	m_active = null;
	private Menuitem 	m_all = null;
	/** Where Clause					*/
	protected StringBuilder 		m_where = null;
	
	/**	Logger	*/
	private static final CLogger	log	= CLogger.getCLogger (WRequest.class);

	/**
	 * 	Display Request Options - New/Existing.
	 * 	@param invoker button
	 */
	private void getRequests (Component invoker)
	{
		m_new = new Menuitem(Msg.getMsg(Env.getCtx(), "RequestNew"));
		if (ThemeManager.isUseFontIconForImage())
			m_new.setIconSclass("z-icon-New");
		else
			m_new.setImage(ThemeManager.getThemeResource("images/New16.png"));
		m_new.addEventListener(Events.ON_CLICK, this);
		m_popup.appendChild(m_new);
		//
		m_where = new StringBuilder();
		int[] counts = MRequest.getRequestCount(m_AD_Table_ID, m_Record_ID, m_where, null);
		int activeCount = counts[1];
		int inactiveCount = counts[0];
		if (activeCount > 0)
		{
			m_active = new Menuitem(Msg.getMsg(Env.getCtx(), "RequestActive") 
					+ " (" + activeCount + ")");
			m_active.addEventListener(Events.ON_CLICK, this);
			m_popup.appendChild(m_active);
		}
		if (inactiveCount > 0)
		{
			m_all = new Menuitem(Msg.getMsg(Env.getCtx(), "RequestAll") 
					+ " (" + (activeCount + inactiveCount) + ")");
			m_all.addEventListener(Events.ON_CLICK, this);
			m_popup.appendChild(m_all);
		}
		
		Popup popup = LayoutUtils.findPopup(invoker);
		if (popup != null)
		{
			popup.appendChild(m_popup);
		}
		else
		{
			m_popup.setPage(invoker.getPage());
			LayoutUtils.autoDetachOnClose(m_popup);
		}
		m_popup.open(invoker, "after_start");
	}
	
	@Override
	public void onEvent(final Event e) throws Exception 
	{
		if (e.getTarget() instanceof Menuitem) 
		{
			//open request window
			MQuery query = null;
			if (e.getTarget() == m_active)
			{
				query = new MQuery("");
				String where = "(" + m_where + ") AND Processed='N'";
				query.addRestriction(where);
				query.setRecordCount(0);
			}
			else if (e.getTarget() == m_all)
			{
				query = new MQuery("");
				query.addRestriction(m_where.toString());
				query.setRecordCount(0);
			}
			else if (e.getTarget() == m_new)
			{
				query = new MQuery("");
				query.addRestriction("1=2");
				query.setRecordCount(0);
			}
			
			int AD_Window_ID = WINDOW_REQUESTS_ALL;		//	232=all - 201=my
			if (m_popup.getParent() instanceof Popup) {
				((Popup)m_popup.getParent()).close();
			}
			SessionManager.getAppDesktop().openWindow(AD_Window_ID, query, new Callback<ADWindow>() {
				
				@Override
				public void onCallback(ADWindow result) {
					if(result == null)
						return;
				
					onNew(e, result);
				}
			});									
		}
	}

	/**
	 * Set initial values for new request record
	 * @param e
	 * @param frame
	 */
	private void onNew(Event e, ADWindow frame) {
		//	New - set Table/Record
		if (e.getTarget() == m_new)
		{
			GridTab tab = frame.getADWindowContent().getActiveGridTab();
			MRequest.newRequest(tab, m_AD_Table_ID, m_Record_ID, m_C_BPartner_ID);
		}
	}
}
