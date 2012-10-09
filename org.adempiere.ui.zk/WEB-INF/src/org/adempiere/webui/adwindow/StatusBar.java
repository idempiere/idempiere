/******************************************************************************
. * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.adwindow;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Vbox;

/**
 * This class is based on org.compiere.apps.StatusBar written by Jorg Janke.
 * @author Jorg Janke
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 12, 2007
 * @version $Revision: 0.10 $
 */
public class StatusBar extends Panel
{
	/**
	 *
	 */
	private static final long serialVersionUID = -3262889055635240201L;

    private Label infoLine;

	private Div west;

	public StatusBar()
	{
        super();
        init();
    }

    private void init()
    {
        Hbox hbox = new Hbox();
        hbox.setWidth("100%");
        hbox.setHeight("100%");
        hbox.setHflex("1");
        hbox.setPack("center");
        Cell leftCell = new Cell();
        hbox.appendChild(leftCell);
        leftCell.setWidth("100%");
        
        infoLine = new Label();
        
        west = new Div();
        west.setStyle("text-align: left; ");
        west.appendChild(infoLine);
        Vbox vbox = new Vbox();
        vbox.setPack("center");
        LayoutUtils.addSclass("status", vbox);
        vbox.appendChild(west);
        leftCell.appendChild(vbox);

        this.appendChild(hbox);
        
    }

    /**
	 *	Set Info Line
	 *  @param text text
	 */
	public void setInfo (String text)
	{
		infoLine.setValue(text != null ? text : "");
		infoLine.setTooltiptext(text);
		infoLine.setStyle("font-weight: bold;");
	}	//	setInfo

}
