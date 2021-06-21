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

package org.adempiere.webui.component;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Messagebox;
/**
 * Application Confirm Panel
 * Web UI port of the rich client's ConfirmPanel by Jorg Janke
 * @author Sendy Yagambrum
 * @date July 25, 2007
 **/
public final class ConfirmPanel extends Div
{
	private static final String SMALL_SCREEN_BUTTON_CLASS = "btn-small small-img-btn";

	/**
	 * 
	 */
	private static final long serialVersionUID = -5522843675498634948L;

	/** Action String OK.        */
    public static final String A_OK = "Ok";
    /** Action String Cancel.    */
    public static final String A_CANCEL = "Cancel";
    /** Action String Refresh.   */
    public static final String A_REFRESH = "Refresh";
    /** Action String Reset.     */
    public static final String A_RESET = "Reset";
    /** Action String Customize. */
    public static final String A_CUSTOMIZE = "Customize";
    /** Action String History.   */
    public static final String A_HISTORY = "History";
    /** Action String Zoom.      */
    public static final String A_ZOOM = "Zoom";
    
    /** Action String Process.   */
    public static final String A_PROCESS = "Process";
    /** Action String Print.     */
    public static final String A_PRINT = "Print";
    /** Action String Export.    */
    public static final String A_EXPORT = "Export";
    /** Action String Help.      */
    public static final String A_HELP = "Help";
    /** Action String Delete.    */
    public static final String A_DELETE = "Delete";
    /** Action String PAttribute.    */
    public static final String A_PATTRIBUTE = "PAttribute";
    /** Action String New.   */
    public static final String A_NEW = "New";

    private boolean  m_withText = false;

    private Map<String, Button> buttonMap = new HashMap<String, Button>();
	private boolean m_withImage = true;

    /**
     * Creates a button of the specified id
     *
     * @param id button id
     * @return  button
     *
     * <p>The string can be any of the following and the corresponding button will be created: </p>
     * <dl>
     * <dt>Ok</dt>          <dd>Ok button</dd>
     * <dt>Cancel</dt>      <dd>Cancel button</dd>
     * <dt>Refresh</dt>     <dd>Refresh button</dd>
     * <dt>Reset</dt>       <dd>Reset button</dd>
     * <dt>History</dt>     <dd>History button</dd>
     * <dt>Process</dt>     <dd>Process button</dd>
     * <dt>New</dt>         <dd>New button</dd>
     * <dt>Customize</dt>   <dd>Customize button</dd>
     * <dt>Delete</dt>      <dd>Delete button</dd>
     * <dt>Save</dt>        <dd>Save button</dd>
     * <dt>Zoom</dt>        <dd>Zoom button</dd>
     * <dt>Help</dt>        <dd>Help button</dd>
     * </dl>
     *
     */
    public Button createButton(String name)
    {
        Button button = ButtonFactory.createNamedButton(name, m_withText, m_withImage);        
        button.setId(name);
        buttonMap.put(name, button);
        if (!Util.isEmpty(extraButtonSClass))
        	LayoutUtils.addSclass(extraButtonSClass, button);

        return button;
    }
    
    public Button createButton(String name, String image, String tooltip)
    {
        Button button = ButtonFactory.createButton(name, image, tooltip);        
        button.setId(name);
        buttonMap.put(name, button);
        if (!Util.isEmpty(extraButtonSClass))
        	LayoutUtils.addSclass(extraButtonSClass, button);

        return button;
    }

    /**
     * create confirm panel with multiple options
     * @param withCancelButton       with cancel
     * @param withRefreshButton      with refresh
     * @param withResetButton        with reset
     * @param withCustomizeButton    with customize
     * @param withHistoryButton      with history
     * @param withZoomButton         with zoom
     */
    public ConfirmPanel(boolean withCancelButton,
             boolean withRefreshButton,
             boolean withResetButton,
             boolean withCustomizeButton,
             boolean withHistoryButton,
             boolean withZoomButton)
    {
    	this(withCancelButton, withRefreshButton, withResetButton, withCustomizeButton, withHistoryButton, withZoomButton, ButtonFactory.isWithText());
    }

    /**
     * create confirm panel with multiple options
     * @param withCancelButton       with cancel
     * @param withRefreshButton      with refresh
     * @param withResetButton        with reset
     * @param withCustomizeButton    with customize
     * @param withHistoryButton      with history
     * @param withZoomButton         with zoom
     * @param withText
     */
    public ConfirmPanel(boolean withCancelButton,
            boolean withRefreshButton,
            boolean withResetButton,
            boolean withCustomizeButton,
            boolean withHistoryButton,
            boolean withZoomButton,
            boolean withText)
    {
    	this(withCancelButton, withRefreshButton, withResetButton, withCustomizeButton, withHistoryButton, withZoomButton, withText, !withText ? true : ButtonFactory.isWithImage());
    }
    
    /**
     * create confirm panel with multiple options
     * @param withCancelButton       with cancel
     * @param withRefreshButton      with refresh
     * @param withResetButton        with reset
     * @param withCustomizeButton    with customize
     * @param withHistoryButton      with history
     * @param withZoomButton         with zoom
     * @param withText
     * @param withImage Incude image for button. Note that image always included if withText is false
     */
    public ConfirmPanel(boolean withCancelButton,
            boolean withRefreshButton,
            boolean withResetButton,
            boolean withCustomizeButton,
            boolean withHistoryButton,
            boolean withZoomButton,
            boolean withText,
            boolean withImage)
    {
    	m_withText = withText;
    	m_withImage  = withImage;

        init();

        addComponentsRight(createButton(A_OK));
                
        setVisible(A_CANCEL, withCancelButton);
        if (withCancelButton)
        	addComponentsRight(createButton(A_CANCEL));    

        if (withRefreshButton)
        {
             addComponentsLeft(createButton(A_REFRESH));
        }
        if (withResetButton)
        {
            addComponentsLeft(createButton(A_RESET));
        }
        if (withCustomizeButton)
        {
            addComponentsLeft(createButton(A_CUSTOMIZE));
        }
        if (withHistoryButton)
        {
            addComponentsLeft(createButton(A_HISTORY));
        }
        if (withZoomButton)
        {
            addComponentsLeft(createButton(A_ZOOM));
        }
    }

    /**
     * Create confirm panel with Ok button only
     */
    public ConfirmPanel()
    {
        this(false,false,false,false,false,false);
    }

    /**
     * Create confirm panel with Ok and Cancel button
     * @param withCancel with cancel
     *
     */
    public ConfirmPanel(boolean withCancel)
    {
        this(withCancel,false,false,false,false,false);
    }
    //
    private Hlayout pnlBtnRight;
    private Hlayout pnlBtnLeft;
    // IDEMPIERE-1334 center panel, contain all process button
    private Hlayout pnlBtnCenter;

	private String extraButtonSClass;

	private boolean useSmallButtonClassForSmallScreen;

    /**
     * initialise components
     */
    private void init()
    {
        pnlBtnLeft = new Hlayout();
        pnlBtnLeft.setSclass("confirm-panel-left");
        pnlBtnRight = new Hlayout();
        pnlBtnRight.setSclass("confirm-panel-right");

        // IDEMPIERE-1334 start
        pnlBtnCenter = new Hlayout();
        pnlBtnCenter.setSclass("confirm-panel-center");
        // IDEMPIERE-1334 end
        
        this.appendChild(pnlBtnLeft);
        // IDEMPIERE-1334
        this.appendChild(pnlBtnCenter);
        this.appendChild(pnlBtnRight);
        this.setSclass("confirm-panel");
        ZKUpdateUtil.setVflex(this, "min");
        setId("confirmPanel");
    }

    /**
     * IDEMPIERE-1334
     * add a process button into center panel
     * @param btName
     * @param imgName
     * @return
     */
    public Button addButton (String btName, String imgName){
    	 Button btProcess = createButton(btName);
    	 // replace default image with image set at info process
    	 if (m_withImage && imgName != null && imgName.trim().length() > 0)
    		 btProcess.setImage(ThemeManager.getThemeResource("images/" + imgName));
    	 addComponentsCenter(btProcess);
    	 return btProcess;     	
    }
    
    public Button addProcessButton (String btName, String imgName){
   	 Button btProcess = createButton(btName, imgName, null);
   	 // replace default image with image set at info process
   	 if (m_withImage && imgName != null && imgName.trim().length() > 0)
   		 btProcess.setImage(ThemeManager.getThemeResource("images/" + imgName));
   	 addComponentsCenter(btProcess);
   	 return btProcess;     	
   }
   
    /**
     * add button to the left side of the confirm panel
     * @param button button
     */
    public void addComponentsLeft(Button button)
    {
    	if (!buttonMap.containsKey(button.getId()))
    		buttonMap.put(button.getId(), button);
        pnlBtnLeft.appendChild(button);
        if (useSmallButtonClassForSmallScreen)
        	LayoutUtils.addSclass(SMALL_SCREEN_BUTTON_CLASS, button);
    }

    /**
     * add button to the right side of the confirm panel
     * @param button button
     */
    public void addComponentsRight(Button button)
    {
    	if (!buttonMap.containsKey(button.getId()))
    		buttonMap.put(button.getId(), button);
        pnlBtnRight.appendChild(button);
        if (useSmallButtonClassForSmallScreen)
        	LayoutUtils.addSclass(SMALL_SCREEN_BUTTON_CLASS, button);
    }

    /**
     * IDEMPIERE-1334
     * add button to the center side of the confirm panel
     * @param button button
     */
    public void addComponentsCenter(Button button)
    {
    	if (!buttonMap.containsKey(button.getId()))
    		buttonMap.put(button.getId(), button);
        pnlBtnCenter.appendChild(button);
        if (useSmallButtonClassForSmallScreen)
        	LayoutUtils.addSclass(SMALL_SCREEN_BUTTON_CLASS, button);
    }

    /**
     * Add combobox to center panel
     * @param cbb
     */
    public void addComponentsCenter(Combobox cbb){
    	pnlBtnCenter.appendChild(cbb);
    }
    
    /**
     * Add checkbox to center panel
     * @param cb
     */
    public void addComponentsCenter(Checkbox cb){
    	pnlBtnCenter.appendChild(cb);
    	
    }    
    
    /**
     * return button of the specified id
     * @param id button id
     * @return button or null if no button is found
     * <p> The button id can be any of the following
     * <dl>
     * <dt>Ok</dt>          <dd>Ok button</dd>
     * <dt>Cancel</dt>      <dd>Cancel button</dd>
     * <dt>Refresh</dt>     <dd>Refresh button</dd>
     * <dt>Reset</dt>       <dd>Reset button</dd>
     * <dt>History</dt>     <dd>History button</dd>
     * <dt>Process</dt>     <dd>Process button</dd>
     * <dt>New</dt>         <dd>New button</dd>
     * <dt>Customize</dt>   <dd>Customize button</dd>
     * <dt>Delete</dt>      <dd>Delete button</dd>
     * <dt>Save</dt>        <dd>Save button</dd>
     * <dt>Zoom</dt>        <dd>Zoom button</dd>
     * <dt>Help</dt>        <dd>Help button</dd>
     * </dl>
     */
    public Button getButton(String id)
    {
        return buttonMap.get(id);
    }

    /**
     * sets the visibility of the specified button
     * @param btnName   button name
     * @param visible   visibility
     * <p> The button name can be any of the following
     * <dl>
     * <dt>Ok</dt>          <dd>Ok button</dd>
     * <dt>Cancel</dt>      <dd>Cancel button</dd>
     * <dt>Refresh</dt>     <dd>Refresh button</dd>
     * <dt>Reset</dt>       <dd>Reset button</dd>
     * <dt>History</dt>     <dd>History button</dd>
     * <dt>Process</dt>     <dd>Process button</dd>
     * <dt>New</dt>         <dd>New button</dd>
     * <dt>Customize</dt>   <dd>Customize button</dd>
     * <dt>Delete</dt>      <dd>Delete button</dd>
     * <dt>Save</dt>        <dd>Save button</dd>
     * <dt>Zoom</dt>        <dd>Zoom button</dd>
     * <dt>Help</dt>        <dd>Help button</dd>
     * </dl>
     */
    public void setVisible(String id, boolean visible)
    {
        Button btn = getButton(id);
        if (btn != null)
        {
            btn.setVisible(visible);
        }
    }
    /**
     * returns whether the specified button is visible or not
     * @param btnName
     * @return visibility of the button
     * <p> The button name can be any of the following
     * <dl>
     * <dt>Ok</dt>          <dd>Ok button</dd>
     * <dt>Cancel</dt>      <dd>Cancel button</dd>
     * <dt>Refresh</dt>     <dd>Refresh button</dd>
     * <dt>Reset</dt>       <dd>Reset button</dd>
     * <dt>History</dt>     <dd>History button</dd>
     * <dt>Process</dt>     <dd>Process button</dd>
     * <dt>New</dt>         <dd>New button</dd>
     * <dt>Customize</dt>   <dd>Customize button</dd>
     * <dt>Delete</dt>      <dd>Delete button</dd>
     * <dt>Save</dt>        <dd>Save button</dd>
     * <dt>Zoom</dt>        <dd>Zoom button</dd>
     * <dt>Help</dt>        <dd>Help button</dd>
     * </dl>
     */
    public boolean isVisible(String btnName)
    {
        Button btn = getButton(btnName);
        if (btn != null)
        {
            return btn.isVisible();
        }
        else
        {
            try
            {
                Messagebox.show("No "+btnName+" button available");
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            return false;
        }
    }
    /**
     * enable specific button
     * @param id   button id
     * @param enabled   enabled
     *
     * <p> The button id can be any of the following
     * <dl>
     * <dt>Ok</dt>          <dd>Ok button</dd>
     * <dt>Cancel</dt>      <dd>Cancel button</dd>
     * <dt>Refresh</dt>     <dd>Refresh button</dd>
     * <dt>Reset</dt>       <dd>Reset button</dd>
     * <dt>History</dt>     <dd>History button</dd>
     * <dt>Process</dt>     <dd>Process button</dd>
     * <dt>New</dt>         <dd>New button</dd>
     * <dt>Customize</dt>   <dd>Customize button</dd>
     * <dt>Delete</dt>      <dd>Delete button</dd>
     * <dt>Save</dt>        <dd>Save button</dd>
     * <dt>Zoom</dt>        <dd>Zoom button</dd>
     * <dt>Help</dt>        <dd>Help button</dd>
     * </dl>
     */
    public void setEnabled(String id, boolean enabled)
    {
        Button button = getButton(id);
        if (button != null)
        {
            button.setEnabled(enabled);
        }
    }

    /**
     * enable all components
     * @param enabled enabled
     */
    public void setEnabledAll(boolean enabled)
    {
        List<?> list1 = pnlBtnLeft.getChildren();
        List<?> list2 = pnlBtnRight.getChildren();
        // IDEMPIERE-1334
        List<?> list3 = pnlBtnCenter.getChildren();
        Iterator<?> iter1 = list1.iterator();
        Iterator<?> iter2 = list2.iterator();
        // IDEMPIERE-1334
        Iterator<?> iter3 = list3.iterator();

        while (iter1.hasNext())
        {
            Button button = (Button)iter1.next();
            button.setEnabled(enabled);
        }
        while (iter2.hasNext())
        {
            Button button = (Button)iter2.next();
            button.setEnabled(enabled);
        }
        // IDEMPIERE-1334 start
        while (iter3.hasNext())
        {
            Button button = (Button)iter3.next();
            button.setEnabled(enabled);
        }
        // IDEMPIERE-1334 end
    }
    /**
     * add action listener on the existing buttons
     * @param event event
     * @param listener listener
     */
    public void addActionListener(String event, EventListener<?> listener)
    {
        List<?> list1 = pnlBtnLeft.getChildren();
        List<?> list2 = pnlBtnRight.getChildren();
        // IDEMPIERE-1334
        List<?> list3 = pnlBtnCenter.getChildren();
        Iterator<?> iter1 = list1.iterator();
        Iterator<?> iter2 = list2.iterator();
        // IDEMPIERE-1334
        Iterator<?> iter3 = list3.iterator();

        while (iter1.hasNext())
        {
            Button button = (Button)iter1.next();
            button.addEventListener(event, listener);
        }
        while (iter2.hasNext())
        {
            Button button = (Button)iter2.next();
            button.addEventListener(event, listener);
        }
        // IDEMPIERE-1334 start
        while (iter3.hasNext())
        {
        	Object element = iter3.next();
        	if (element instanceof Button) 
        	{
	            ((Button)element).addEventListener(event, listener);
        	}
        }
        // IDEMPIERE-1334 start
    }

    /**
     * added to ease porting of swing form
     * @param listener
     */
	public void addActionListener(EventListener<?> listener) {
		addActionListener(Events.ON_CLICK, listener);
	}

	/**
	 * alias for addComponentsLeft for ease of porting swing form
	 * @param selectAllButton
	 */
	public void addButton(Button button) {
		addComponentsLeft(button);
	}

	/**
	 * alias for getButton("Ok"), to ease porting of swing form
	 * @return Button
	 */
	public Button getOKButton() {
		return getButton(A_OK);
	}

	public void addButtonSclass(String cls) {
		for(Button btn : buttonMap.values()) {
			LayoutUtils.addSclass(cls, btn);
		}
		extraButtonSClass = cls;
	}
	
	public void removeButtonSclass(String cls) {
		for(Button btn : buttonMap.values()) {
			LayoutUtils.removeSclass(cls, btn);
		}
	}

	public void useSmallButtonClassForSmallScreen() {
		useSmallButtonClassForSmallScreen = true;
		addButtonSclass(SMALL_SCREEN_BUTTON_CLASS);
	}
}   //  ConfirmPanel
