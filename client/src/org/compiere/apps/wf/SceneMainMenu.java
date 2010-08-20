/**
 * 
 */
package org.compiere.apps.wf;

import java.awt.Point;

import javax.swing.JPopupMenu;

import org.compiere.swing.CMenuItem;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.netbeans.api.visual.action.PopupMenuProvider;
import org.netbeans.api.visual.widget.Widget;

/**
 * @author hengsin
 *
 */
public class SceneMainMenu implements PopupMenuProvider {

	private JPopupMenu 			m_NewPopupMenu = new JPopupMenu();
	private CMenuItem 			m_NewMenuNode = new CMenuItem(Msg.getMsg(Env.getCtx(), "CreateNewNode"));
	
	public static final String ADD_NEW_NODE_ACTION = "addNewNodeAction";
	
	/**
	 * @param wfContentPanel 
	 * 
	 */
	public SceneMainMenu(WFContentPanel wfContentPanel) {
		m_NewMenuNode.setActionCommand(ADD_NEW_NODE_ACTION);
		m_NewMenuNode.addActionListener(wfContentPanel);
		m_NewPopupMenu.add(m_NewMenuNode);
	}

	/* (non-Javadoc)
	 * @see org.netbeans.api.visual.action.PopupMenuProvider#getPopupMenu(org.netbeans.api.visual.widget.Widget, java.awt.Point)
	 */
	public JPopupMenu getPopupMenu(Widget arg0, Point arg1) {
		return m_NewPopupMenu;
	}

}
