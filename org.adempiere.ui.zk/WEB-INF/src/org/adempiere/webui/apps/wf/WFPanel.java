/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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
package org.adempiere.webui.apps.wf;

import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.webui.session.SessionManager;
import org.compiere.apps.wf.WFGraphLayout;
import org.compiere.apps.wf.WFNodeWidget;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;

/**
 *	WorkFlow Panel
 *
 * 	@author Low Heng Sin
 */
public class WFPanel extends Borderlayout implements EventListener
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8777798080154603970L;


	/**
	 * 	Create Workflow Panel
	 */
	public WFPanel ()
	{
		try
		{
			jbInit();
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "WFPanel", e);
		}
		m_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
	}	//	WFPanel

	/**	Window No			*/
	@SuppressWarnings("unused")
	private int         m_WindowNo = 0;


	/**	Workflow Model				*/
	private MWorkflow	m_wf = null;

	/**	Logger			*/
	private static CLogger	log = CLogger.getCLogger(WFPanel.class);
	
	//	IO
	private WFNodeContainer nodeContainer = new WFNodeContainer();
	
	private Html infoTextPane = new Html();
	private Div contentPanel = new Div();
	//
	private Table table;
	
	
	/**
	 * 	Static Init
	 *  <pre>
	 * 		centerScrollPane
	 * 			centerPanel
	 * 		south Panel
	 * 			infoScrollPane
	 * 			buttonPanel
	 * 	</pre>
	 * 	@throws Exception
	 */
	private void jbInit() throws Exception
	{
		this.setStyle("height: 100%; width: 100%; position: absolute");
		Center center = new Center();
		this.appendChild(center);
		createTable();
		center.appendChild(table);
		contentPanel.setStyle("width: 100%; heigh: 100%;");
		center.setAutoscroll(true);
		center.setFlex(false);
		
		South south = new South();
		this.appendChild(south);
		south.appendChild(infoTextPane);
		south.setHeight("15%");
		south.setSplittable(true);
		south.setCollapsible(true);
		south.setAutoscroll(true);
		south.setFlex(true);		
	}	//	jbInit

	private void createTable() {
		table = new Table();
		table.setDynamicProperty("cellpadding", "0");
		table.setDynamicProperty("cellspacing", "0");
		table.setDynamicProperty("border", "none");
		table.setStyle("margin:0;padding:0");
	}
		
	/**
	 * 	Dispose
	 * @see org.compiere.apps.form.FormPanel#dispose()
	 */
	public void dispose()
	{
		SessionManager.getAppDesktop().closeActiveWindow();
	}	//	dispose

	
	/**
	 * 	Load Workflow & Nodes
	 * 	@param AD_Workflow_ID ID
	 */
	public void load (int AD_Workflow_ID)
	{
		log.fine("AD_Workflow_ID=" + AD_Workflow_ID);
		if (AD_Workflow_ID == 0)
			return;
		//	Get Workflow
		m_wf = new MWorkflow (Env.getCtx(), AD_Workflow_ID, null);
		nodeContainer.removeAll();
		nodeContainer.setWorkflow(m_wf);
		
		//	Add Nodes for Paint
		MWFNode[] nodes = m_wf.getNodes(true, Env.getAD_Client_ID(Env.getCtx()));
		List<Integer> added = new ArrayList<Integer>();
		for (int i = 0; i < nodes.length; i++)
		{
			if (!added.contains(nodes[i].getAD_WF_Node_ID()))
				nodeContainer.addNode(nodes[i]);
		}
		
		//  Add lines
		for (int i = 0; i < nodes.length; i++)
		{
			MWFNodeNext[] nexts = nodes[i].getTransitions(Env.getAD_Client_ID(Env.getCtx()));
			for (int j = 0; j < nexts.length; j++)
			{
				nodeContainer.addEdge(nexts[j]);
			}
		}
				
		
		Dimension dimension = nodeContainer.getDimension();
		BufferedImage bi = new BufferedImage (dimension.width, dimension.height, BufferedImage.TYPE_INT_ARGB);
		Graphics2D graphics = bi.createGraphics();
		nodeContainer.validate(graphics);
		nodeContainer.paint(graphics);

		try {
			int row = nodeContainer.getRowCount();
			for(int i = 0; i < row; i++) {
				Tr tr = new Tr();
				table.appendChild(tr);
				for(int c = 0; c < 4; c++) {
					BufferedImage t = new BufferedImage(WFGraphLayout.COLUMN_WIDTH, WFGraphLayout.ROW_HEIGHT, BufferedImage.TYPE_INT_ARGB);
					Graphics2D tg = t.createGraphics();
					Td td = new Td();
//					td.setStyle("border: 1px dotted lightgray");
					tr.appendChild(td);
					
					int x = c * WFGraphLayout.COLUMN_WIDTH;
					int y = i * WFGraphLayout.ROW_HEIGHT;

					tg.drawImage(bi.getSubimage(x, y, WFGraphLayout.COLUMN_WIDTH, WFGraphLayout.ROW_HEIGHT), 0, 0, null);
					org.zkoss.zul.Image image = new org.zkoss.zul.Image();
					image.setContent(t);
					td.appendChild(image);

					WFNodeWidget widget = nodeContainer.findWidget(i+1, c+1);
					if (widget != null)
					{
						MWFNode node = widget.getModel();
						if (node.getHelp(true) != null) {
							image.setTooltiptext(node.getHelp(true));
						}
						image.setAttribute("AD_WF_Node_ID", node.getAD_WF_Node_ID());
						image.addEventListener(Events.ON_CLICK, this);
						image.setStyle("cursor:pointer;border:none;margin:0;padding:0;");
					}
					else
					{
						image.setStyle("border:none;margin:0;padding:0;");
					}

					tg.dispose();
				}
			}

		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
		
		//	Info Text
		StringBuffer msg = new StringBuffer("");
		msg.append("<H2>").append(m_wf.getName(true)).append("</H2>");
		String s = m_wf.getDescription(true);
		if (s != null && s.length() > 0)
			msg.append("<B>").append(s).append("</B>");
		s = m_wf.getHelp(true);
		if (s != null && s.length() > 0)
			msg.append("<BR>").append(s);
		infoTextPane.setContent(msg.toString());

	}	//	load

	/**
	 * 	String Representation
	 * 	@return info
	 */
	public String toString()
	{
		StringBuffer sb = new StringBuffer("WorkflowPanel[");
		if (m_wf != null)
			sb.append(m_wf.getAD_Workflow_ID());
		sb.append("]");
		return sb.toString();
	}	//	toString
	
	public MWorkflow getWorkflow() 
	{
		return m_wf;
	}

	public void onEvent(Event event) throws Exception {
		if (Events.ON_CLICK.equals(event.getName())) {
			Integer id = (Integer) event.getTarget().getAttribute("AD_WF_Node_ID");
			if (id != null) {
				MWFNode[] nodes = m_wf.getNodes(true, Env.getAD_Client_ID(Env.getCtx()));
				for(MWFNode node : nodes) {
					if (node.getAD_WF_Node_ID() == id) {
						start(node);
						break;
					}
				}
			}
		}
	}

	private void start(MWFNode wfn) {
		if (wfn.getAD_Window_ID() > 0) {
			SessionManager.getAppDesktop().openWindow(wfn.getAD_Window_ID());
		} else if (wfn.getAD_Form_ID() > 0) {
			SessionManager.getAppDesktop().openForm(wfn.getAD_Form_ID());
		} else if (wfn.getAD_Process_ID() > 0) {
			SessionManager.getAppDesktop().openProcessDialog(wfn.getAD_Process_ID(), false);
		} else if (wfn.getAD_Task_ID() > 0) {
			SessionManager.getAppDesktop().openTask(wfn.getAD_Task_ID());
		} else if (wfn.getWorkflow_ID() > 0) {
			SessionManager.getAppDesktop().openWorkflow(wfn.getWorkflow_ID());
		} 		
	}

}	//	WFPanel
