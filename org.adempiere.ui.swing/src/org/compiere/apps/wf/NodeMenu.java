/**
 * 
 */
package org.compiere.apps.wf;

import java.awt.Point;

import javax.swing.JPopupMenu;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWorkflow;
import org.netbeans.api.visual.action.PopupMenuProvider;
import org.netbeans.api.visual.widget.Widget;

/**
 * @author hengsin
 *
 */
public class NodeMenu implements PopupMenuProvider {

	private WFContentPanel panel;
	private MWorkflow m_wf;

	/**
	 * 
	 */
	public NodeMenu(WFContentPanel panel, MWorkflow wf) {
		this.panel = panel;
		m_wf = wf;
	}

	/* (non-Javadoc)
	 * @see org.netbeans.api.visual.action.PopupMenuProvider#getPopupMenu(org.netbeans.api.visual.widget.Widget, java.awt.Point)
	 */
	public JPopupMenu getPopupMenu(Widget w, Point p) {
		WFNodeWidget widget = (WFNodeWidget) w;
		MWFNode node = widget.getModel();
		JPopupMenu m_LinePopupMenu = new JPopupMenu(node.getName());
		if (node.getAD_Client_ID() == Env.getAD_Client_ID(Env.getCtx()))
		{
			String title = Msg.getMsg(Env.getCtx(), "DeleteNode") + 
				": " + node.getName();
			addMenuItem(m_LinePopupMenu, title, node, -1);
			m_LinePopupMenu.addSeparator();
		}
		MWFNode[] nodes = m_wf.getNodes(true, Env.getAD_Client_ID(Env.getCtx()));
		MWFNodeNext[] lines = node.getTransitions(Env.getAD_Client_ID(Env.getCtx()));
		//	Add New Line
		for (int n = 0; n < nodes.length; n++)
		{
			MWFNode nn = nodes[n];
			if (nn.getAD_WF_Node_ID() == node.getAD_WF_Node_ID())
				continue;	//	same
			boolean found = false;
			for (int i = 0; i < lines.length; i++)
			{
				MWFNodeNext line = lines[i];
				if (nn.getAD_WF_Node_ID() == line.getAD_WF_Next_ID())
				{
					found = true;
					break;
				}
			}
			if (!found)
			{
				String title = Msg.getMsg(Env.getCtx(), "AddLine") 
					+ ": " + node.getName() + " -> " + nn.getName();
				addMenuItem(m_LinePopupMenu, title, node, nn.getAD_WF_Node_ID());
			}
		}
		m_LinePopupMenu.addSeparator();
		//	Delete Lines
		for (int i = 0; i < lines.length; i++)
		{
			MWFNodeNext line = lines[i];
			if (line.getAD_Client_ID() != Env.getAD_Client_ID(Env.getCtx()))
				continue;
			MWFNode next = MWFNode.get(Env.getCtx(), line.getAD_WF_Next_ID());
			String title = Msg.getMsg(Env.getCtx(), "DeleteLine")
				+ ": " + node.getName() + " -> " + next.getName();
			addMenuItem(m_LinePopupMenu, title, line);
		}
		return m_LinePopupMenu;
	}
	
	/**
	 * 	Add Menu Item to - add new line to node
	 *	@param menu base menu
	 *	@param title title
	 */
	private void addMenuItem (JPopupMenu menu, String title, MWFNode node, int AD_WF_NodeTo_ID)
	{
		WFPopupItem item = new WFPopupItem (title, node, AD_WF_NodeTo_ID);
		menu.add(item);
		item.addActionListener(panel);
	}	//	addMenuItem
	
	/**
	 * 	Add Menu Item to - delete line
	 *	@param menu base menu
	 *	@param title title
	 */
	private void addMenuItem (JPopupMenu menu, String title, MWFNodeNext line)
	{
		WFPopupItem item = new WFPopupItem (title, line);
		menu.add(item);
		item.addActionListener(panel);
	}	//	addMenuItem
	
}
