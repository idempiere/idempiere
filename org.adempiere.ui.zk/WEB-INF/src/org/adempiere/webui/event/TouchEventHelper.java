/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.webui.event;

import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Grid;

/**
 * @author hengsin
 *
 */
public class TouchEventHelper {

	private static final String TABLET_SCROLLING_FIX_INIT = "tablet.scrolling.fix.init";
    
    
	/**
	 * iPad: Use client side listener to workaround the issue that grid header doesn't scroll together with body.
	 * Outstanding Issues: Frozen not working. 
	 * @param grid
	 */
	public static void addTabletScrollingFix(Grid grid) {
		Boolean b = (Boolean) grid.getAttribute(TABLET_SCROLLING_FIX_INIT);
		if (b != null && b.booleanValue())
			return;
		
		String script = "jq('#" + grid.getUuid() + "-body').bind('scroll'," +
				"function(event) { setTimeout(function(){" +
				"jq('#" + grid.getUuid() + "-head').scrollLeft(" +
				"jq('#" + grid.getUuid() + "-body').scrollLeft()); },0);});";
				
		Clients.response(new AuScript(grid, script));
		
		grid.setAttribute(TABLET_SCROLLING_FIX_INIT, Boolean.TRUE);
	}
}
