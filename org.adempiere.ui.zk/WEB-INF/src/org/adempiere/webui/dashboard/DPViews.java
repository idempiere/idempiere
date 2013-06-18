/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation
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
package org.adempiere.webui.dashboard;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.InfoSchedule;
import org.compiere.model.I_A_Asset;
import org.compiere.model.I_C_BPartner;
import org.compiere.model.I_C_Invoice;
import org.compiere.model.I_C_Order;
import org.compiere.model.I_C_Payment;
import org.compiere.model.I_M_InOut;
import org.compiere.model.I_M_Product;
import org.compiere.model.I_S_ResourceAssignment;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MRole;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Box;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Vbox;

/**
 * Dashboard item: Info views
 * @author Elaine
 * @date November 20, 2008
 */
public class DPViews extends DashboardPanel implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8375414665766937581L;

	public DPViews()
	{
		super();
		setSclass("views-box");
        this.appendChild(createViewPanel());
	}
	
	private Box createViewPanel()
	{
		Vbox vbox = new Vbox();

		if (MInfoWindow.get(I_M_Product.Table_Name, null) != null)
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoProduct");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoProduct")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/InfoProduct16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		if (MInfoWindow.get(I_C_BPartner.Table_Name, null) != null)
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoBPartner");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoBPartner")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/InfoBPartner16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		if (MRole.getDefault().isShowAcct() && MRole.getDefault().isAllow_Info_Account())
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoAccount");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoAccount")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/InfoAccount16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		if (MRole.getDefault().isAllow_Info_Schedule())
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoSchedule");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoSchedule")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/InfoSchedule16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		vbox.appendChild(new Separator("horizontal"));
		if (MInfoWindow.get(I_C_Order.Table_Name, null) != null)
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoOrder");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoOrder")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/Info16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		if (MInfoWindow.get(I_C_Invoice.Table_Name, null) != null)
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoInvoice");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoInvoice")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/Info16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		if (MInfoWindow.get(I_M_InOut.Table_Name, null) != null)
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoInOut");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoInOut")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/Info16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		if (MInfoWindow.get(I_C_Payment.Table_Name, null) != null)
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoPayment");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoPayment")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/Info16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
//		if (MRole.getDefault().isAllow_Info_CashJournal())
//		{
//			ToolBarButton btnViewItem = new ToolBarButton("InfoCashLine");
//			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoCashLine")));
//			btnViewItem.setImage("/images/Info16.png");
//			btnViewItem.addEventListener(Events.ON_CLICK, this);
//			vbox.appendChild(btnViewItem);
//		}
		if (MInfoWindow.get(I_S_ResourceAssignment.Table_Name, null) != null)
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoAssignment");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoAssignment")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/Info16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		if (MInfoWindow.get(I_A_Asset.Table_Name, null) != null)
		{
			ToolBarButton btnViewItem = new ToolBarButton("InfoAsset");
			btnViewItem.setSclass("link");
			btnViewItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "InfoAsset")));
			btnViewItem.setImage(ThemeManager.getThemeResource("images/Info16.png"));
			btnViewItem.addEventListener(Events.ON_CLICK, this);
			vbox.appendChild(btnViewItem);
		}
		
		return vbox;
	}
        
    public void onEvent(Event event)
    {
        Component comp = event.getTarget();
        String eventName = event.getName();
        
        if(eventName.equals(Events.ON_CLICK))
        {
            if(comp instanceof ToolBarButton)
            {
            	ToolBarButton btn = (ToolBarButton) comp;
        		String actionCommand = btn.getName();
        		int WindowNo = 0;
        		
        		if (actionCommand.equals("InfoProduct"))
        		{
        			InfoPanel.showProduct(WindowNo);
        		}
        		else if (actionCommand.equals("InfoBPartner"))
        		{
        			InfoPanel.showBPartner(WindowNo);
        		}
        		else if (actionCommand.equals("InfoAsset"))
        		{
        			InfoPanel.showAsset(WindowNo);
        		}
        		else if (actionCommand.equals("InfoAccount"))
        		{
        			new org.adempiere.webui.acct.WAcctViewer();
        		}
        		else if (actionCommand.equals("InfoSchedule"))
        		{
        			InfoSchedule is = new InfoSchedule(null, false);
        			is.setAttribute(Window.MODE_KEY, Mode.EMBEDDED);
        			AEnv.showWindow(is);
        		}
        		else if (actionCommand.equals("InfoOrder"))
        		{
        			InfoPanel.showOrder(WindowNo, "");
        		}
        		else if (actionCommand.equals("InfoInvoice"))
        		{
        			InfoPanel.showInvoice(WindowNo, "");
        		}
        		else if (actionCommand.equals("InfoInOut"))
        		{
        			InfoPanel.showInOut(WindowNo, "");
        		}
        		else if (actionCommand.equals("InfoPayment"))
        		{
        			InfoPanel.showPayment(WindowNo, "");
        		}
//        		else if (actionCommand.equals("InfoCashLine"))
//        		{
//        			InfoPanel.showCashLine(WindowNo, "");
//        		}
        		else if (actionCommand.equals("InfoAssignment"))
        		{
        			InfoPanel.showAssignment(WindowNo, "");
        		}
            }
        }
	}
}
