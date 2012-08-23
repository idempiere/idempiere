/******************************************************************************
 * Product: Posterita Ajax UI 												  *
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

package org.adempiere.webui.session;

import java.util.Properties;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.IWebClient;
import org.adempiere.webui.desktop.IDesktop;
import org.compiere.model.MUser;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Session;

/**
 * 
 * @author <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class SessionManager
{
    public static final String SESSION_APPLICATION = "SessionApplication";
    
    public static boolean isUserLoggedIn(Properties ctx)
    {
        String adUserId = Env.getContext(ctx, "#AD_User_ID");
        String adRoleId = Env.getContext(ctx, "#AD_Role_ID");
        String adClientId = Env.getContext(ctx, "#AD_Client_ID");
        String adOrgId = Env.getContext(ctx, "#AD_Org_ID");

        return (!"".equals(adUserId) && !"".equals(adRoleId)
                && !"".equals(adClientId) && !"".equals(adOrgId));
    }
    
    private static Session getSession()
    {
    	Execution execution = Executions.getCurrent();
    	Desktop desktop = execution != null ? execution.getDesktop() 
    			: (Desktop) Env.getCtx().get(AdempiereWebUI.ZK_DESKTOP_SESSION_KEY); 
        return  desktop != null ? desktop.getSession() : null;
    }
    
    public static void setSessionApplication(IWebClient app)
    {
        Session session = getSession();
        if (session != null)
        	session.setAttribute(SESSION_APPLICATION, app);
    }
    
    public static IDesktop getAppDesktop()
    {
    	IWebClient webClient = getSessionApplication();
    	return webClient != null ? webClient.getAppDeskop() : null;
    }
    
    public static IWebClient getSessionApplication()
    {
        Session session = getSession();
        IWebClient app = session != null ? (IWebClient)session.getAttribute(SESSION_APPLICATION) : null;
        return app;
    }
    
    public static void logoutSession()
    {
    	IWebClient app = getSessionApplication();
    	if (app != null)
    		app.logout();
    }
    
    public static void changeRole(MUser user){
    	IWebClient app = getSessionApplication();
    	if (app != null)
    		app.changeRole(user);
    }

}
