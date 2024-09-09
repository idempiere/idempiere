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

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.webui.component.Window;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 * Error window in error.zul<br/>
 * Remove SSO Principal from session when error.
 * 
 * @author Logilite Technologies
 */
public class ErrorWindow extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1089842665320591389L;

	public ErrorWindow()
	{
		/* If the session token is removed directly then the error page is not load.
		 * Executions.schedule does not work because request is not alive.
		 * so echo event to remove token after error page load.
		 * TODO find a way to use Executions.schedule
		 */
		addEventListener("onRemoveSSOPrincipal", this);
		Events.echoEvent("onRemoveSSOPrincipal", this, null);
	}

	@Override
	public void onEvent(Event event) throws Exception
	{
		Executions.getCurrent().getSession().removeAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
	}
}
