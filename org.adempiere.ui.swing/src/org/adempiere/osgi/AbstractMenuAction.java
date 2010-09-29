package org.adempiere.osgi;

import javax.swing.JMenu;
import javax.swing.JMenuBar;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;

public abstract class AbstractMenuAction implements IMenuAction {

	protected CLogger log = CLogger.getCLogger(getClass());
	
	protected JMenu getMenu(JMenuBar menuBar, String label)	{

		// Translated text
		String text = Msg.getMsg(Env.getCtx(), label);
		int pos = text.indexOf('&');
		if (pos != -1)	{
			text = text.substring(0, pos) + text.substring(pos+1);
		}
		
		for (int i=0; i < menuBar.getMenuCount(); i++)	{
			JMenu menu = menuBar.getMenu(i);
			if (text.equals(menu.getText()))	{
				return menu;
			}
		}
		// menu not found.
		log.warning("Menu " + label + " not found.");
		return null;
	}
	
	
}
