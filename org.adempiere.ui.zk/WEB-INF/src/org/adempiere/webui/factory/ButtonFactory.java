/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.webui.factory;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * Factory class to create button with consistent look and feel
 * @author hengsin
 *
 */
public class ButtonFactory {

	private static final String ZK_BUTTON_STYLE = "ZK_BUTTON_STYLE";
	
	/**
	 * @return true if button should have text label
	 */
	public static final boolean isWithText() {
		String type = MSysConfig.getValue(ZK_BUTTON_STYLE, "I");
		return type.indexOf("T") >= 0;
	}
	
	/**
	 * @return true if button should include an image icon
	 */
	public static final boolean isWithImage() {
		String type = MSysConfig.getValue(ZK_BUTTON_STYLE, "I");
		return type.indexOf("I") >= 0;
	}
	
	/**
	 * Create named button with default style
	 * @param name
	 * @return new button instance
	 */
	public static Button createNamedButton(String name)
	{
		return createNamedButton(name, isWithText(), isWithImage());
	}
	
	/**
	 * 
	 * @param name button name. If withText is true, the name will be used to 
	 * lookup the button label from ad_message
	 * @param withText text button
	 * @param withImage image button 
	 * @return new button instance
	 */
	public static Button createNamedButton(String name, boolean withText, boolean withImage)
    {
        Button button = new Button();
        button.setName("btn"+name);

        String text = Util.cleanAmp(Msg.translate(Env.getCtx(), name));

        if (withText && text != null)
        {
        	button.setLabel(text);
        	if (withImage) 
        	{
        		button.setImage(ThemeManager.getThemeResource("images/"+name+"16.png"));        	
        	}
        	LayoutUtils.addSclass("txt-btn", button);
        }
        else
        {
        	button.setImage(ThemeManager.getThemeResource("images/"+name+"24.png"));
        	if (text != null)
        		button.setTooltiptext(text);
        	LayoutUtils.addSclass("img-btn", button);
        }
        
        //add named class for further customization option 
        String className = "btn-" + name.toLowerCase();
        LayoutUtils.addSclass(className, button);

        return button;
    }
	
	/**
	 * @param label
	 * @param image
	 * @param tooltiptext
	 * @return new button instance
	 */
	public static Button createButton(String label, String image, String tooltiptext)
    {
        Button button = new Button();
        
        if (!Util.isEmpty(label))
        {
        	button.setLabel(label);
        	if (!Util.isEmpty(image)) 
        	{
        		button.setImage(image);        	
        		LayoutUtils.addSclass("img-txt-btn", button);
        	}
        	else
        	{
        		LayoutUtils.addSclass("txt-btn", button);
        	}
        }
        else if (!Util.isEmpty(image))
        {
        	button.setImage(image);
        	LayoutUtils.addSclass("img-btn", button);
        }
        
        if (!Util.isEmpty(tooltiptext))
        {
        	button.setTooltiptext(tooltiptext);
        }
        
        return button;
    }
}
