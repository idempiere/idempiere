/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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

import java.util.Locale;
import java.util.Properties;

import javax.servlet.ServletRequest;

import org.adempiere.webui.part.AbstractUIPart;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.LoginWindow;
import org.zkoss.web.servlet.Servlets;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.metainfo.PageDefinition;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.East;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.West;
import org.zkoss.zul.Window;

/**
 * Manage login window for login and role selection
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @author  Low Heng Sin
 * @date    Mar 3, 2007
 * @version $Revision: 0.10 $
 */
public class WLogin extends AbstractUIPart
{
	/** IWebClient instance ({@link AdempiereWebUI}) */
	private IWebClient app;
	/** Main layout */
	private Borderlayout layout;
	@Deprecated(forRemoval = true, since = "11")
	private Window browserWarningWindow;
	/** embedded window for login and role selection */
	private LoginWindow loginWindow;

	/**
	 * 
	 * @param app
	 */
    public WLogin(IWebClient app)
    {
        this.app = app;
    }

    /**
     * Create UI from login.zul file. <br/> 
     * The main layout component ("layout") must be instance of {@link Borderlayout}. <br/>
     * Get {@link #loginWindow} reference from zul using id "loginWindow".
     */
    @Override
    protected Component doCreatePart(Component parent)
    {
    	PageDefinition pageDefintion = Executions.getCurrent().getPageDefinition(ThemeManager.getThemeResource("zul/login/login.zul"));
    	Component loginPage = Executions.createComponents(pageDefintion, parent, null);
    	
        layout = (Borderlayout) loginPage.getFellow("layout");

        loginWindow = (LoginWindow) loginPage.getFellow("loginWindow");
        loginWindow.init(app);

        boolean mobile = false;        
		if (Executions.getCurrent().getBrowser("mobile") !=null) {
			mobile = true;
		} else {
			String ua = Servlets.getUserAgent((ServletRequest) Executions.getCurrent().getNativeRequest());
			ua = ua.toLowerCase();
			if (ua.contains("ipad") || ua.contains("iphone") || ua.contains("android"))
				mobile = true;
		}
    	
        West west = layout.getWest();
        if (west.getFirstChild() != null && west.getFirstChild().getFirstChild() != null) {
    		west.setCollapsible(true);
    		west.setSplittable(true);
        	if (mobile) {    		
        		west.setOpen(false);
        	}
        } else {
        	west.setVisible(false);
        }
        
        East east = layout.getEast();
        if (east.getFirstChild() != null && east.getFirstChild().getFirstChild() != null) {
        	if (mobile) {    		
        		east.setCollapsible(true);
        		east.setOpen(false);
        	}
        } else {
        	east.setVisible(false);
        }
        
        North north = layout.getNorth();
        if (north.getFirstChild() == null || north.getFirstChild().getFirstChild() == null) {
        	north.setVisible(false);
        }
        
        South south = layout.getSouth();
        if (south.getFirstChild() == null || south.getFirstChild().getFirstChild() == null) {
        	south.setVisible(false);
        }

        return layout;
    }

    /**
     * detach/dispose window content
     */
	public void detach() {
		layout.detach();
		layout = null;
		if (browserWarningWindow != null)
			browserWarningWindow.detach();
	}

	/**
	 * @return {@link Component}
	 */
	public Component getComponent() {
		return layout;
	}

	/**
	 * Show change role panel in {@link #loginWindow}
	 * @param locale
	 * @param properties env context
	 */
	public void changeRole(Locale locale, Properties properties) {
		loginWindow.changeRole(locale, properties);
	}
}
