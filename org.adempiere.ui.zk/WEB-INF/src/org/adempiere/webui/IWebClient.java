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
package org.adempiere.webui;

import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.util.UserPreference;
import org.compiere.model.MUser;
import org.zkforge.keylistener.Keylistener;

/**
 * Interface for web client
 * @author hengsin
 * @see AdempiereWebUI
 */
public interface IWebClient {

	/**
	 * handle login completed
	 */
	public void loginCompleted();

	/**
	 * handle logout
	 */
	public void logout();

	/**
	 * auto logout after close of browser tab
	 */
	public void logoutAfterTabDestroyed();

	/**
	 * Get {@link IDesktop} instance
	 * @return IDesktop
	 */
	public IDesktop getAppDeskop();

	/**
	 * load user preference by user id
	 * @param userId
	 * @return UserPreference
	 */
	public UserPreference loadUserPreference(int userId);

	/**
	 * Get current user preference
	 * @return UserPreference
	 */
	public UserPreference getUserPreference();
	
	/**
	 * handle change Role
	 */
	public void changeRole(MUser user);

	/**
	 * Get global key listener
	 * @return {@link Keylistener}
	 */
	public abstract Keylistener getKeylistener();
	
	/**
	 * Get current ClientInfo
	 * @return {@link ClientInfo}
	 */
	default ClientInfo getClientInfo() {
		return getAppDeskop().getClientInfo();
	}
}