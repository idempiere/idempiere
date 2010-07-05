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
package org.adempiere.as;

import java.util.Hashtable;

import org.adempiere.base.Service;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class ASFactory {
	public final static String JBOSS = "JBoss";
	
	public final static String GLASS_FISH = "GlassFish";
	
	public final static String[] AS_Names = new String[] {
		JBOSS, GLASS_FISH
	};
	
	private static IApplicationServer applicationServer;
	
	static {
		applicationServer = Service.locate(IApplicationServer.class);
		if (applicationServer == null) {
			applicationServer = new IApplicationServer() {

				public int getDefaultNamingServicePort() {
					return 0;
				}

				public Hashtable<String, String> getInitialContextEnvironment(
						String AppsHost, int AppsPort, String principal,
						String credential) {
					return new Hashtable<String, String>();
				}			
			};
		}
	}

	/**
	 * @return IApplicationServer
	 */
	public static IApplicationServer getApplicationServer() {
		return applicationServer;
	}	
}
