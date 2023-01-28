/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.adempiere.webui.window;

import org.adempiere.base.sso.ISSOPrinciple;
import org.adempiere.webui.component.FWindow;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 * Error window in error.zul
 * Remove SSO principle from session when error.
 * 
 * @author Logilite Technologies
 */
public class ErrorWindow extends FWindow implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1089842665320591389L;

	public ErrorWindow()
	{
		addEventListener("onRemoveSSOPrinciple", this);
		Events.echoEvent("onRemoveSSOPrinciple", this, null);
	}

	@Override
	public void onEvent(Event event) throws Exception
	{
		Executions.getCurrent().getSession().removeAttribute(ISSOPrinciple.SSO_PRINCIPLE_SESSION_NAME);
	}

}
