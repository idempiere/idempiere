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

package org.adempiere.webui.adwindow;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.IServiceHolder;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.action.Actions;
import org.adempiere.webui.action.IAction;
import org.adempiere.webui.component.FToolbar;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.event.ToolbarListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MRole;
import org.compiere.model.MToolBarButton;
import org.compiere.model.MToolBarButtonRestrict;
import org.compiere.model.X_AD_ToolBarButton;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.image.AImage;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Space;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 *
 * @author Cristina Ghita, www.arhipac.ro
 * 				<li>FR [ 2076330 ] Add new methods in CWindowToolbar class
 */
public class ADWindowToolbar extends FToolbar implements EventListener<Event>
{
	/**
	 *
	 */
	private static final long serialVersionUID = 3390505814516682801L;

	private static final String BTNPREFIX = "Btn";

    private static CLogger log = CLogger.getCLogger(ADWindowToolbar.class);

    private ToolBarButton btnIgnore;

    private ToolBarButton btnHelp, btnNew, btnCopy, btnDelete, btnDeleteSelection, btnSave;

    private ToolBarButton btnSaveAndCreate; // Elaine 2009/03/02 - Save & Create

    private ToolBarButton btnRefresh, btnFind, btnLock, btnAttachment;

    private ToolBarButton btnGridToggle;

    private ToolBarButton btnParentRecord, btnDetailRecord;

    private ToolBarButton btnReport, btnArchive, btnPrint;

    private ToolBarButton btnZoomAcross, btnActiveWorkflows, btnRequests, btnProductInfo;

    private ToolBarButton btnChat;

    private ToolBarButton btnCustomize;

    private ToolBarButton btnExport;
    private ToolBarButton btnFileImport;

    private ToolBarButton btnProcess;

    private HashMap<String, ToolBarButton> buttons = new HashMap<String, ToolBarButton>();

//    private ToolBarButton btnExit;

    private ArrayList<ToolbarListener> listeners = new ArrayList<ToolbarListener>();

    private Event event;

    private Map<Integer, ToolBarButton> keyMap = new HashMap<Integer, ToolBarButton>();
    private Map<Integer, ToolBarButton> altKeyMap = new HashMap<Integer, ToolBarButton>();
    private Map<Integer, ToolBarButton> ctrlKeyMap = new HashMap<Integer, ToolBarButton>();

    private List<ToolbarCustomButton> toolbarCustomButtons = new ArrayList<ToolbarCustomButton>();

	// Elaine 2008/12/04
	/** Show Personal Lock								*/
	public boolean isPersonalLock = MRole.getDefault().isPersonalLock();
	private boolean isAllowProductInfo = MRole.getDefault().isAllow_Info_Product();

	private int windowNo = 0;

	private long prevKeyEventTime = 0;

	private KeyEvent prevKeyEvent;

	/**	Last Modifier of Action Event					*/
//	public int 				lastModifiers;
	//

    public ADWindowToolbar()
    {
    	this(0);
    }

    public ADWindowToolbar(int windowNo) {
    	setWindowNo(windowNo);
        init();
	}

	private void init()
    {
    	LayoutUtils.addSclass("adwindow-toolbar", this);

        btnIgnore = createButton("Ignore", "Ignore", "Ignore");
        btnIgnore.setTooltiptext(btnIgnore.getTooltiptext()+ "    Alt+Z");
        btnHelp = createButton("Help", "Help","Help");
        btnHelp.setTooltiptext(btnHelp.getTooltiptext()+ "    Alt+H");
        btnNew = createButton("New", "New", "New");
        btnNew.setTooltiptext(btnNew.getTooltiptext()+ "    Alt+N");
        btnCopy = createButton("Copy", "Copy", "Copy");
        btnCopy.setTooltiptext(btnCopy.getTooltiptext()+ "    Alt+C");
        btnDelete = createButton("Delete", "Delete", "Delete");
        btnDelete.setTooltiptext(btnDelete.getTooltiptext()+ "    Alt+D");
        btnDeleteSelection = createButton("DeleteSelection", "DeleteSelection", "DeleteSelection");
        btnSave = createButton("Save", "Save", "Save");
        btnSave.setTooltiptext(btnSave.getTooltiptext()+ "    Alt+S");
        btnSaveAndCreate = createButton("SaveCreate", "SaveCreate", "SaveCreate");
        btnSaveAndCreate.setTooltiptext(btnSaveAndCreate.getTooltiptext()+ "    Alt+A");
        btnRefresh = createButton("Refresh", "Refresh", "Refresh");
        btnRefresh.setTooltiptext(btnRefresh.getTooltiptext()+ "    Alt+E");
        btnFind = createButton("Find", "Find", "Find");
        btnFind.setTooltiptext(btnFind.getTooltiptext()+ "    Alt+F");
        btnAttachment = createButton("Attachment", "Attachment", "Attachment");
        btnChat = createButton("Chat", "Chat", "Chat");
        btnGridToggle = createButton("Toggle", "Multi", "Multi");
        btnGridToggle.setTooltiptext(btnGridToggle.getTooltiptext()+ "    Alt+T");
        btnParentRecord = createButton("ParentRecord", "Parent", "Parent");
        btnParentRecord.setTooltiptext(btnParentRecord.getTooltiptext()+ "   Alt+Up");
        btnDetailRecord = createButton("DetailRecord", "Detail", "Detail");
        btnDetailRecord.setTooltiptext(btnDetailRecord.getTooltiptext()+ "   Alt+Down");
        btnReport = createButton("Report", "Report", "Report");
        btnReport.setTooltiptext(btnReport.getTooltiptext()+ "    Alt+R");
        btnArchive = createButton("Archive", "Archive", "Archive");
        btnPrint = createButton("Print", "Print", "Print");
        btnPrint.setTooltiptext(btnPrint.getTooltiptext()+ "    Alt+P");
        btnLock = createButton("Lock", "Lock", "Lock"); // Elaine 2008/12/04
		btnLock.setVisible(isPersonalLock);
		btnZoomAcross = createButton("ZoomAcross", "ZoomAcross", "ZoomAcross");
        btnActiveWorkflows = createButton("ActiveWorkflows", "WorkFlow", "WorkFlow");
        btnRequests = createButton("Requests", "Request", "Request");
        btnProductInfo = createButton("ProductInfo", "Product", "InfoProduct");
        btnProductInfo.setVisible(isAllowProductInfo);

        btnCustomize= createButton("Customize", "Customize", "Customize");
        btnCustomize.setDisabled(false);

        btnProcess= createButton("Process", "Process", "Process");
        btnProcess.setTooltiptext(btnProcess.getTooltiptext()+ "    Alt+O");
        btnProcess.setDisabled(false);


        // Help and Exit should always be enabled
        btnHelp.setDisabled(false);
        btnGridToggle.setDisabled(false);
        btnZoomAcross.setDisabled(false);

        btnActiveWorkflows.setDisabled(false); // Elaine 2008/07/17
        btnRequests.setDisabled(false); // Elaine 2008/07/22
        btnProductInfo.setDisabled(!isAllowProductInfo); // Elaine 2008/07/22
        btnArchive.setDisabled(false); // Elaine 2008/07/28
        btnLock.setDisabled(!isPersonalLock); // Elaine 2008/12/04

        if (MRole.getDefault().isCanExport())
        {
        	btnExport = createButton("Export", "Export", "Export");
        }
        btnFileImport = createButton("FileImport", "FileImport", "FileImport");

        configureKeyMap();

        setWidth("100%");
    }


    private ToolBarButton createButton(String name, String image, String tooltip)
    {
    	ToolBarButton btn = new ToolBarButton("");
        btn.setName(BTNPREFIX+name);
        btn.setId(btn.getName());
        if (image != null) 
        {
        	String size = Env.getContext(Env.getCtx(), "#ZK_Toolbar_Button_Size");
        	String suffix = "24.png";
        	if (!Util.isEmpty(size)) 
        	{
        		suffix = size + ".png";
        	}
        	btn.setImage(ThemeManager.getThemeResource("images/"+image + suffix));
        }
        btn.setTooltiptext(Msg.getMsg(Env.getCtx(),tooltip));
        btn.setSclass("toolbar-button");

        buttons.put(name, btn);
        this.appendChild(btn);
        //make toolbar button last to receive focus
        btn.setTabindex(0);
        btn.addEventListener(Events.ON_CLICK, this);
        btn.setDisabled(true);

        return btn;
    }

    public ToolBarButton getButton(String name)
    {
    	return buttons.get(name);
    }

    /** VK_A thru VK_Z are the same as ASCII 'A' thru 'Z' (0x41 - 0x5A) */
    public static final int VK_A              = 0x41;
    public static final int VK_B              = 0x42;
    public static final int VK_C              = 0x43;
    public static final int VK_D              = 0x44;
    public static final int VK_E              = 0x45;
    public static final int VK_F              = 0x46;
    public static final int VK_G              = 0x47;
    public static final int VK_H              = 0x48;
    public static final int VK_I              = 0x49;
    public static final int VK_J              = 0x4A;
    public static final int VK_K              = 0x4B;
    public static final int VK_L              = 0x4C;
    public static final int VK_M              = 0x4D;
    public static final int VK_N              = 0x4E;
    public static final int VK_O              = 0x4F;
    public static final int VK_P              = 0x50;
    public static final int VK_Q              = 0x51;
    public static final int VK_R              = 0x52;
    public static final int VK_S              = 0x53;
    public static final int VK_T              = 0x54;
    public static final int VK_U              = 0x55;
    public static final int VK_V              = 0x56;
    public static final int VK_W              = 0x57;
    public static final int VK_X              = 0x58;
    public static final int VK_Y              = 0x59;
    public static final int VK_Z              = 0x5A;

    private void configureKeyMap()
    {
		altKeyMap.put(VK_H, btnHelp);
		altKeyMap.put(VK_N, btnNew);
		altKeyMap.put(VK_D, btnDelete);
		altKeyMap.put(VK_S, btnSave);
		altKeyMap.put(VK_A, btnSaveAndCreate);
		altKeyMap.put(VK_C, btnCopy);
		altKeyMap.put(VK_E, btnRefresh);
		altKeyMap.put(VK_T, btnGridToggle);
		altKeyMap.put(KeyEvent.UP, btnParentRecord);
		altKeyMap.put(KeyEvent.DOWN, btnDetailRecord);
		altKeyMap.put(VK_F, btnFind);
		altKeyMap.put(VK_Z, btnIgnore);
		altKeyMap.put(VK_R, btnReport);		
		altKeyMap.put(VK_P, btnPrint);
		altKeyMap.put(VK_O, btnProcess);
	}

	protected void addSeparator()
    {
		Space s = new Space();
		s.setSpacing("6px");
		s.setOrient("vertical");
		this.appendChild(s);
    }

    public void addListener(ToolbarListener toolbarListener)
    {
        listeners.add(toolbarListener);
    }

    public void removeListener(ToolbarListener toolbarListener)
    {
        listeners.remove(toolbarListener);
    }

    public void onEvent(Event event)
    {
        String eventName = event.getName();

        if(eventName.equals(Events.ON_CLICK))
        {
            if(event.getTarget() instanceof ToolBarButton)
            {
            	doOnClick(event);
            }
        } else if (eventName.equals(Events.ON_CTRL_KEY))
        {
        	KeyEvent keyEvent = (KeyEvent) event;
        	if (LayoutUtils.isReallyVisible(this)) {
	        	//filter same key event that is too close
	        	//firefox fire key event twice when grid is visible
	        	long time = System.currentTimeMillis();
	        	if (prevKeyEvent != null && prevKeyEventTime > 0 &&
	        			prevKeyEvent.getKeyCode() == keyEvent.getKeyCode() &&
	    				prevKeyEvent.getTarget() == keyEvent.getTarget() &&
	    				prevKeyEvent.isAltKey() == keyEvent.isAltKey() &&
	    				prevKeyEvent.isCtrlKey() == keyEvent.isCtrlKey() &&
	    				prevKeyEvent.isShiftKey() == keyEvent.isShiftKey()) {
	        		if ((time - prevKeyEventTime) <= 300) {
	        			return;
	        		}
	        	}
	        	this.onCtrlKeyEvent(keyEvent);
        	}
        }
    }

	private void doOnClick(Event event) {
		this.event = event;
		ToolBarButton cComponent = (ToolBarButton) event.getTarget();
		String compName = cComponent.getName();
		String methodName = "on" + compName.substring(3);
		Iterator<ToolbarListener> listenerIter = listeners.iterator();
		while(listenerIter.hasNext())
		{
		    try
		    {
		        ToolbarListener tListener = listenerIter.next();
		        Method method = tListener.getClass().getMethod(methodName, (Class[]) null);
		        method.invoke(tListener, (Object[]) null);
		    }
		    catch (Exception e)
		    {
		    	String msg = null;
		    	ValueNamePair vp = CLogger.retrieveError();
		    	if (vp != null) {
		    		msg = vp.getName();
		    	}
		    	if (msg == null) {
		    		Throwable cause = e.getCause();
		    		if (cause != null) {
		    			msg = cause.getLocalizedMessage();
		    		}
		    	}
		    	if (msg == null) {
		    		msg = "Could not invoke Toolbar listener method: " + methodName + "()";
		    	}
		    	FDialog.error(windowNo, this, "Error", msg);
		    	log.log(Level.SEVERE, msg, e);
		    }
		}
		this.event = null;
	}

    public void enableTabNavigation(boolean enabled)
    {
        enableTabNavigation(enabled, enabled);
    }

    public void enableTabNavigation(boolean enableParent, boolean enableDetail)
    {
        this.btnParentRecord.setDisabled(!enableParent);
        this.btnDetailRecord.setDisabled(!enableDetail);
    }

    public void enableRefresh(boolean enabled)
    {
        this.btnRefresh.setDisabled(!enabled);
    }

    public void enableSave(boolean enabled)
    {
        this.btnSave.setDisabled(!enabled);
    	this.btnSaveAndCreate.setDisabled(!enabled);
    }

    public boolean isSaveEnable() {
    	return !btnSave.isDisabled();
    }

//    public void enableExit(boolean enabled)
//    {
//    	this.btnExit.setDisabled(!enabled);
//    }

    public void enableDelete(boolean enabled)
    {
        this.btnDelete.setDisabled(!enabled);
        this.btnDeleteSelection.setDisabled(!enabled);
    }

    public void enableIgnore(boolean enabled)
    {
        this.btnIgnore.setDisabled(!enabled);
    }

    public void enableNew(boolean enabled)
    {
        this.btnNew.setDisabled(!enabled);
        this.btnCopy.setDisabled(!enabled);
    }

    public void enableAttachment(boolean enabled)
    {
        this.btnAttachment.setDisabled(!enabled);
    }

    public void enableChat(boolean enabled)
    {
        this.btnChat.setDisabled(!enabled);
    }

    public void enablePrint(boolean enabled)
    {
    	this.btnPrint.setDisabled(!enabled);
    }

    public void enableReport(boolean enabled)
    {
    	this.btnReport.setDisabled(!enabled);
    }

    public void enableFind(boolean enabled)
    {
        this.btnFind.setDisabled(!enabled);
    }

    public void enableGridToggle(boolean enabled)
    {
    	btnGridToggle.setDisabled(!enabled);
    }

    public void enableCustomize(boolean enabled)
    {
    	btnCustomize.setDisabled(!enabled);
    }

    public void lock(boolean locked)
    {
    	this.btnLock.setPressed(locked);

    	String imgURL = "images/"+ (this.btnLock.isPressed() ? "LockX" : "Lock") + "24.png";
    	imgURL = ThemeManager.getThemeResource(imgURL);
		this.btnLock.setImage(imgURL);
    }

    public Event getEvent()
    {
    	return event;
    }

	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		ToolBarButton btn = null;
		if (keyEvent.isAltKey() && !keyEvent.isCtrlKey() && !keyEvent.isShiftKey())
		{
			if (keyEvent.getKeyCode() == VK_X)
			{
				if (windowNo > 0)
				{
					prevKeyEventTime = System.currentTimeMillis();
		        	prevKeyEvent = keyEvent;
					keyEvent.stopPropagation();
					SessionManager.getAppDesktop().closeWindow(windowNo);
				}
			}
			else
			{
				btn = altKeyMap.get(keyEvent.getKeyCode());
			}
		}
		else if (!keyEvent.isAltKey() && keyEvent.isCtrlKey() && !keyEvent.isShiftKey())
			btn = ctrlKeyMap.get(keyEvent.getKeyCode());
		else if (!keyEvent.isAltKey() && !keyEvent.isCtrlKey() && !keyEvent.isShiftKey())
			btn = keyMap.get(keyEvent.getKeyCode());

		if (btn != null) {
			prevKeyEventTime = System.currentTimeMillis();
        	prevKeyEvent = keyEvent;
			keyEvent.stopPropagation();
			if (!btn.isDisabled() && btn.isVisible()) {
				Events.sendEvent(btn, new Event(Events.ON_CLICK, btn));
				//client side script to close combobox popup
				String script = "var w=zk.Widget.$('#" + btn.getUuid()+"'); " +
						"zWatch.fire('onFloatUp', w);";
				Clients.response(new AuScript(script));
			}
		}
	}

	/**
	 *
	 * @param visible
	 */
	public void setVisibleAll(boolean visible)
	{
		for (ToolBarButton btn : buttons.values())
		{
			btn.setVisible(visible);
		}
	}

	/**
	 *
	 * @param buttonName
	 * @param visible
	 */
	public void setVisible(String buttonName, boolean visible)
	{
		ToolBarButton btn = buttons.get(buttonName);
		if (btn != null)
		{
			btn.setVisible(visible);
		}
	}

	/**
	 *
	 * @param windowNo
	 */
	public void setWindowNo(int windowNo) {
		this.windowNo = windowNo;
	}

	/**
	 * Enable/disable export button
	 * @param b
	 */
	public void enableExport(boolean b) {
		if (btnExport != null)
			btnExport.setDisabled(!b);
	}

	/**
	 * Enable/disable file import button
	 * @param b
	 */
	public void enableFileImport(boolean b) {
		if (btnFileImport != null)
			btnFileImport.setDisabled(!b);
	}

	private boolean ToolBarMenuRestictionLoaded = false;
	public void updateToolbarAccess(int AD_Window_ID) {
		loadCustomButton(AD_Window_ID);

		if (ToolBarMenuRestictionLoaded)
			return;
		Properties m_ctx = Env.getCtx();

		int ToolBarButton_ID = 0;

		int[] restrictionList = MToolBarButtonRestrict.getOfWindow(m_ctx, MRole.getDefault().getAD_Role_ID(), AD_Window_ID, false, null);
		if (log.isLoggable(Level.INFO))
			log.info("restrictionList="+restrictionList.toString());

		for (int i = 0; i < restrictionList.length; i++)
		{
			ToolBarButton_ID= restrictionList[i];

			X_AD_ToolBarButton tbt = new X_AD_ToolBarButton(m_ctx, ToolBarButton_ID, null);
			String restrictName = BTNPREFIX + tbt.getComponentName();
			if (log.isLoggable(Level.CONFIG)) log.config("tbt="+tbt.getAD_ToolBarButton_ID() + " / " + restrictName);

			for (Component p = this.getFirstChild(); p != null; p = p.getNextSibling()) {
				if (p instanceof ToolBarButton) {
					if ( restrictName.equals(((ToolBarButton)p).getName()) ) {
						this.removeChild(p);
						break;
					}
				}
			}

		}	// All restrictions

		dynamicDisplay();
		ToolBarMenuRestictionLoaded = true;
	}

	private void loadCustomButton(int AD_Window_ID) {
		MToolBarButton[] mToolbarButtons = MToolBarButton.getOfWindow(AD_Window_ID, null);
		if (mToolbarButtons != null && mToolbarButtons.length > 0) {
			for (MToolBarButton mToolBarButton : mToolbarButtons) {
				String actionId = mToolBarButton.getActionClassName();
				IServiceHolder<IAction> serviceHolder = Actions.getAction(actionId);
				if (serviceHolder != null && serviceHolder.getService() != null) {
					String labelKey = actionId + ".label";
					String tooltipKey = actionId + ".tooltip";
					String label = Msg.getMsg(Env.getCtx(), labelKey);
					String tooltiptext = Msg.getMsg(Env.getCtx(), tooltipKey);
					if (labelKey.equals(label)) {
						label = mToolBarButton.getName();
					}
					if (tooltipKey.equals(tooltiptext)) {
						tooltiptext = null;
					}
					ToolBarButton btn = createButton(mToolBarButton.getComponentName(), null, tooltiptext);
					btn.removeEventListener(Events.ON_CLICK, this);
					btn.setId(mToolBarButton.getName());
					btn.setDisabled(false);

					AImage aImage = Actions.getActionImage(actionId);
					if (aImage != null) {
						btn.setImageContent(aImage);
					} else {
						btn.setLabel(label);
					}

					ToolbarCustomButton toolbarCustomBtn = new ToolbarCustomButton(mToolBarButton, btn, actionId, windowNo);
					toolbarCustomButtons.add(toolbarCustomBtn);

					appendChild(btn);
				}
			}
		}
	}

	public void enableProcessButton(boolean b) {
		if (btnProcess != null) {
			btnProcess.setDisabled(!b);
		}
	}

	public void dynamicDisplay() {
		for(ToolbarCustomButton toolbarCustomBtn : toolbarCustomButtons) {
			toolbarCustomBtn.dynamicDisplay();
		}
	}

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		try {
			SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
		} catch (Exception e) {}
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
		}
	}
}
