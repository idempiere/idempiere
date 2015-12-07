/******************************************************************************
 * Copyright (C) 2014 iDempiere                                               *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

package org.zkoss.zk.ui.sys;

import org.zkoss.zk.ui.UiException;
import org.zkoss.zk.ui.WebApp;
import org.zkoss.zk.ui.http.SimpleWebApp;
import org.zkoss.zk.ui.util.Configuration;

public class WebAppFactoryExImpl implements WebAppFactory {

	@Override
	public WebApp newWebApp(Object ctx, Configuration config) {
		Class<?> cls = config.getWebAppClass();
		if (cls != null) {
			try {
				return (WebApp)cls.newInstance();
			} catch (Exception ex) {
				throw UiException.Aide.wrap(ex, "Unable to construct "+cls);
			}
		} else {
			return new SimpleWebApp();
		}
		
	}

}