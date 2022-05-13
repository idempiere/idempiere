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
import java.util.logging.Level;

import org.adempiere.base.IServiceHolder;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.action.Actions;
import org.adempiere.webui.action.IAction;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.FToolbar;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.event.ToolbarListener;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.GridTab;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MToolBarButton;
import org.compiere.model.MUserQuery;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.image.AImage;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.AfterSizeEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.A;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Row;
import org.zkoss.zul.Rows;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.impl.LabelImageElement;

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
	private static final long serialVersionUID = -5151981978053022864L;

	public static final String BTNPREFIX = "Btn";
	
	public static final String MNITMPREFIX = "Mnitm";

    private static final CLogger log = CLogger.getCLogger(ADWindowToolbar.class);
    
	/** Search messages using translation */
	private String				m_sNew;	

    private Combobox fQueryName;
	private MUserQuery[] userQueries;
	private MUserQuery selectedUserQuery;

    private ToolBarButton btnIgnore;

    private ToolBarButton btnHelp, btnNew, btnCopy, btnDelete, btnSave;

    private ToolBarButton btnSaveAndCreate; // Elaine 2009/03/02 - Save & Create

    private ToolBarButton btnRefresh, btnFind, btnLock, btnAttachment;

    private ToolBarButton btnGridToggle;

    private ToolBarButton btnParentRecord, btnDetailRecord;

    private ToolBarButton btnReport, btnArchive, btnPrint;

    private ToolBarButton btnZoomAcross, btnActiveWorkflows, btnRequests, btnProductInfo;

    private ToolBarButton btnChat;
    
    private ToolBarButton btnPostIt;

    private ToolBarButton btnCustomize;

    private ToolBarButton btnExport;
    private ToolBarButton btnFileImport;
    private ToolBarButton btnCSVImport;

    private ToolBarButton btnProcess;
    
    private ToolBarButton btnQuickForm;

    private ToolBarButton btnShowMore;

    private HashMap<String, ToolBarButton> buttons = new HashMap<String, ToolBarButton>();
	private ArrayList<ToolBarButton> mobileShowMoreButtons = new ArrayList<ToolBarButton>();
	
//    private ToolBarButton btnExit;

    private ArrayList<ToolbarListener> listeners = new ArrayList<ToolbarListener>();

    private Event event;

    private Map<Integer, ToolBarButton> keyMap = new HashMap<Integer, ToolBarButton>();
    private Map<Integer, ToolBarButton> altKeyMap = new HashMap<Integer, ToolBarButton>();
    private Map<Integer, ToolBarButton> ctrlKeyMap = new HashMap<Integer, ToolBarButton>();

    private List<ToolbarCustomButton> toolbarCustomButtons = new ArrayList<ToolbarCustomButton>();
    
    private List<String> restrictionList;
    private List<String> advancedList;

	// Elaine 2008/12/04
	/** Show Personal Lock								*/
	public boolean isPersonalLock = MRole.getDefault().isPersonalLock();
	private boolean isAllowProductInfo = MRole.getDefault().canAccess_Info_Product();

	private int windowNo = 0;

	private long prevKeyEventTime = 0;

	private KeyEvent prevKeyEvent;
	
	// Maintain hierarchical Quick form by its parent-child tab while open leaf
	// tab once & dispose and doing same action
	private int							quickFormTabHrchyLevel		= 0;

	private A overflowButton;

	private ArrayList<ToolBarButton> overflows;

	private Popup overflowPopup;
	
	private int prevWidth;

	private AbstractADWindowContent windowContent;

	/**	Last Modifier of Action Event					*/
//	public int 				lastModifiers;
	//

    public ADWindowToolbar()
    {
    	this(null, 0);
    }

    public ADWindowToolbar(AbstractADWindowContent windowContent, int windowNo) {
    	this.windowContent = windowContent;
    	setWindowNo(windowNo);
        init();
        if (ClientInfo.isMobile()) {
        	mobileInit();
        }
	}

	private void init()
    {
    	LayoutUtils.addSclass("adwindow-toolbar", this);

        //IDEMPIERE-4085
        m_sNew = "** ".concat(Msg.getMsg(Env.getCtx(), "New Query")).concat(" **");
        fQueryName = new Combobox();
        fQueryName.setTooltiptext(Msg.getMsg(Env.getCtx(),"SelectQuery"));
        fQueryName.setPlaceholder(Msg.getMsg(Env.getCtx(),"SelectQuery"));
        fQueryName.setId(BTNPREFIX + "SearchQuery");
        fQueryName.addEventListener(Events.ON_SELECT, this);
        LayoutUtils.addSclass("toolbar-searchbox", fQueryName);
				
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
        btnSave = createButton("Save", "Save", "Save");
        btnSave.setTooltiptext(btnSave.getTooltiptext()+ "    Alt+S");
        btnSaveAndCreate = createButton("SaveCreate", "SaveCreate", "SaveCreate");
        btnSaveAndCreate.setTooltiptext(btnSaveAndCreate.getTooltiptext()+ "    Alt+A");
        btnRefresh = createButton("Refresh", "Refresh", "Refresh");
        btnRefresh.setTooltiptext(btnRefresh.getTooltiptext()+ "    Alt+E");
        btnFind = createButton("Find", "Find", "Find");
        btnFind.setTooltiptext(btnFind.getTooltiptext()+ "    Alt+F");
        btnAttachment = createButton("Attachment", "Attachment", "Attachment");
        btnPostIt = createButton("PostIt", "PostIt", "PostIt");
        btnChat = createButton("Chat", "Chat", "Chat");
        btnGridToggle = createButton("Toggle", "Multi", "Toggle");
        btnGridToggle.setTooltiptext(btnGridToggle.getTooltiptext()+ "    Alt+T");
        btnParentRecord = createButton("ParentRecord", "Parent", "ParentRecord");
        btnParentRecord.setTooltiptext(btnParentRecord.getTooltiptext()+ "   Alt+Up");
        btnDetailRecord = createButton("DetailRecord", "Detail", "DetailRecord");
        btnDetailRecord.setTooltiptext(btnDetailRecord.getTooltiptext()+ "   Alt+Down");
        btnReport = createButton("Report", "Report", "Report");
        btnReport.setTooltiptext(btnReport.getTooltiptext()+ "    Alt+R");
        btnArchive = createButton("Archive", "Archive", "Archive");
        btnPrint = createButton("Print", "Print", "Print");
        btnPrint.setTooltiptext(btnPrint.getTooltiptext()+ "    Alt+P");
        if (isPersonalLock) {
            btnLock = createButton("Lock", "Lock", "Lock"); // Elaine 2008/12/04
            btnLock.setDisabled(!isPersonalLock); // Elaine 2008/12/04
    		btnLock.setVisible(isPersonalLock);
        }
		btnZoomAcross = createButton("ZoomAcross", "ZoomAcross", "ZoomAcross");
        btnActiveWorkflows = createButton("ActiveWorkflows", "WorkFlow", "ActiveWorkflows");
        btnRequests = createButton("Requests", "Request", "Requests");
        if (isAllowProductInfo) {
            btnProductInfo = createButton("ProductInfo", "Product", "ProductInfo");
            btnProductInfo.setDisabled(!isAllowProductInfo); // Elaine 2008/07/22
            btnProductInfo.setVisible(isAllowProductInfo);
        }

        btnCustomize= createButton("Customize", "Customize", "Customize");
        btnCustomize.setDisabled(false);

        btnProcess= createButton("Process", "Process", "Process");
        btnProcess.setTooltiptext(btnProcess.getTooltiptext()+ "    Alt+O");
        btnProcess.setDisabled(false);

        btnQuickForm = createButton("QuickForm", "QuickForm", "QuickForm");
        btnQuickForm.setDisabled(false);

        // Help and Exit should always be enabled
        btnHelp.setDisabled(false);
        btnGridToggle.setDisabled(false);
        btnZoomAcross.setDisabled(false);

        btnActiveWorkflows.setDisabled(false); // Elaine 2008/07/17
        btnRequests.setDisabled(false); // Elaine 2008/07/22
        btnArchive.setDisabled(false); // Elaine 2008/07/28

        if (MRole.getDefault().isCanExport())
        {
        	btnExport = createButton("Export", "Export", "Export");
        }
        btnFileImport = createButton("FileImport", "FileImport", "FileImport");
        btnCSVImport = createButton("CSVImport", "CSVImport", "CSVImport");
        
        btnShowMore = createButton("ShowMore", "ShowMore", "ShowMore");
        btnShowMore.setDisabled(true);
        btnShowMore.setVisible(false);

        if (!ClientInfo.isMobile())
        	overflows = new ArrayList<ToolBarButton>();
        MToolBarButton[] officialButtons = MToolBarButton.getToolbarButtons("W", null);
        for (MToolBarButton button : officialButtons) {
        	if (!button.isActive() || !hasAccess(BTNPREFIX+button.getComponentName())) {
        		buttons.remove(button.getComponentName());
        	} else {
        		if (button.isCustomization()) {
        			String actionId = button.getActionClassName();
        			IServiceHolder<IAction> serviceHolder = Actions.getAction(actionId);
        			IAction action = serviceHolder.getService();
        			if (serviceHolder != null && action != null) {
        				String labelKey = actionId + ".label";
        				String tooltipKey = actionId + ".tooltip";
        				String label = Msg.getMsg(Env.getCtx(), labelKey, true);
        				String tooltiptext = Msg.getMsg(Env.getCtx(), labelKey, false);
        				if (Util.isEmpty(tooltiptext, true))
        					tooltiptext = Msg.getMsg(Env.getCtx(), tooltipKey, true);
        				else
        					tooltipKey = labelKey;
        				if (labelKey.equals(label)) {
        					label = button.getName();
        				}
        				if (tooltipKey.equals(tooltiptext) || labelKey.equals(tooltiptext)) {
        					tooltipKey = null;
        				}
        				ToolBarButton btn = createButton(button.getComponentName(), null, tooltipKey);
        				btn.removeEventListener(Events.ON_CLICK, this);
        				btn.setId(button.getName());
        				btn.setDisabled(false);

        				btn.setIconSclass(null);
        				if (ThemeManager.isUseFontIconForImage()) {
        					String iconSclass = Actions.getActionIconSclass(actionId);
        					if (!Util.isEmpty(iconSclass, true)) {
        						btn.setIconSclass(iconSclass);
        						LayoutUtils.addSclass("font-icon-toolbar-button", btn);
        					}
        				}
        				//not using font icon, fallback to image or label
        				if (Util.isEmpty(btn.getIconSclass(), true)) {
	        				AImage aImage = Actions.getActionImage(actionId);
	        				if (aImage != null) {
	        					btn.setImageContent(aImage);
	        				} else {
	        					btn.setLabel(label);
	        				}
        				}

        				ToolbarCustomButton toolbarCustomBtn = new ToolbarCustomButton(button, btn, actionId, windowNo);
        				toolbarCustomButtons.add(toolbarCustomBtn);

        				if (ClientInfo.isMobile() && button.isShowMore()) 
        					mobileShowMoreButtons.add(btn);
        				else if (!button.isShowMore()) {
            				this.appendChild(btn);
            				action.decorate(btn);        					
        				}
        			}
        		}
        		if (buttons.get(button.getComponentName()) != null) {
        			if (ClientInfo.isMobile() && button.isShowMore()) 
    					mobileShowMoreButtons.add(buttons.get(button.getComponentName()));
    				else if (button.isShowMore())
        				overflows.add(buttons.get(button.getComponentName()));
        			else {
            			this.appendChild(buttons.get(button.getComponentName()));
            			if (button.isAddSeparator()) {
            				this.appendChild(new Separator("vertical"));
            			}
        			}
        		} else if (button.isSearchQueryComponent())
    		        this.appendChild(fQueryName); 
        	}
        }
        if (!ClientInfo.isMobile() && overflows.size() > 0) {
            enableShowMore();
        }

    	configureKeyMap();

        ZKUpdateUtil.setWidth(this, "100%");
    }


    private ToolBarButton createButton(String name, String image, String tooltip)
    {
    	ToolBarButton btn = new ToolBarButton("");
        btn.setName(BTNPREFIX+name);
        btn.setId(btn.getName());
        if (image != null) 
        {
        	if (ThemeManager.isUseFontIconForImage()) 
        	{
        		String iconSclass = "z-icon-" + image;
        		btn.setIconSclass(iconSclass);
        		LayoutUtils.addSclass("font-icon-toolbar-button", btn);
        	}
        	else
        	{
	        	Executions.createComponents(ThemeManager.getPreference(), this, null);
	        	String size = Env.getContext(Env.getCtx(), ITheme.ZK_TOOLBAR_BUTTON_SIZE);
	        	String suffix = "24.png";
	        	if (!Util.isEmpty(size)) 
	        	{
	        		suffix = size + ".png";
	        	}
	        	btn.setImage(ThemeManager.getThemeResource("images/"+image + suffix));
        	}
        }
        String tooltipText = Msg.getMsg(Env.getCtx(),tooltip,false);
        if (Util.isEmpty(tooltipText, true))
        	tooltipText = Msg.getMsg(Env.getCtx(),tooltip,true);
        btn.setTooltiptext(tooltipText);
        LayoutUtils.addSclass("toolbar-button", btn);
        
        buttons.put(name, btn);
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
    
    public LabelImageElement getToolbarItem(String name)
    {
    	return	buttons.get(name);
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
		altKeyMap.put(VK_L, btnCustomize);
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
            	if (!event.getTarget().isVisible())
            		return;
            	if (!event.getTarget().getId().contentEquals(BTNPREFIX+"ShowMore"))
            		doOnClick(event);
            	else
            		onShowMore();
            }
        } else if (eventName.equals(Events.ON_CTRL_KEY))
        {
			KeyEvent keyEvent = (KeyEvent) event;

			// If Quick form is opened then prevent toolbar shortcut key events.
			if (!(keyEvent.getKeyCode() == KeyEvent.F2) && windowContent != null && windowContent.getOpenQuickFormTabs().size() > 0)
				return;

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
        } else if (Events.ON_SELECT.equals(eventName)) 
        {
        	int index = fQueryName.getSelectedIndex();
        	if (index < 0) return;
        	if (index == 0) // no query - refresh
        		setSelectedUserQuery(null);
        	else if (m_sNew.equals(fQueryName.getValue())) { //On new send the Event to open the FindWindow
        		Events.sendEvent(Events.ON_CLICK, btnFind, null);
        		return;
        	}
        	else
				setSelectedUserQuery(userQueries[index-1]);

        	doOnClick(event);
        }
    }

	private void doOnClick(Event event) {
		this.event = event;
		String compName;
		String methodName;
		if (event.getTarget() == fQueryName) {
			methodName = "onSearchQuery";
		} else {
			ToolBarButton cComponent = (ToolBarButton) event.getTarget();
			compName = cComponent.getName();
			methodName = "on" + compName.substring(3);
		}
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
    }
    
    public boolean isDeleteEnable()
    {
    	return !btnDelete.isDisabled();
    }
    
	public boolean isNewEnabled() {
    	return !btnNew.isDisabled();
	}

    public void enableIgnore(boolean enabled)
    {
        this.btnIgnore.setDisabled(!enabled);
    }

    public void enableNew(boolean enabled)
    {
        this.btnNew.setDisabled(!enabled);
    }

    public void enableCopy(boolean enabled)
    {
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
    
    public void enableArchive(boolean enabled)
    {
    	btnArchive.setDisabled(!enabled);
    }
    
    public void enableZoomAcross(boolean enabled)
    {
    	btnZoomAcross.setDisabled(!enabled);
    }
    
    public void enableActiveWorkflows(boolean enabled)
    {
    	btnActiveWorkflows.setDisabled(!enabled);
    }
    
    public void enableRequests(boolean enabled)
    {
    	btnRequests.setDisabled(!enabled);
    }
    
	public void enableQuickForm(boolean enabled)
	{
		btnQuickForm.setDisabled(!enabled);
	}

    public void lock(boolean locked)
    {
    	setPressed("Lock", locked);

      	if (ThemeManager.isUseFontIconForImage())
      	{
      		String iconSclass = "z-icon-" + (this.btnLock.isPressed() ? "lock" : "unlock") ;
      		this.btnLock.setIconSclass(iconSclass);
      		LayoutUtils.addSclass("font-icon-toolbar-button", this.btnLock);
      	}
      	else
      	{
      		String size = Env.getContext(Env.getCtx(), ITheme.ZK_TOOLBAR_BUTTON_SIZE);
      		String suffix = "24.png";
      		if (!Util.isEmpty(size))
      		{
      			suffix = size + ".png";
      		}
      		String imgURL = "images/"+ (this.btnLock.isPressed() ? "LockX" : "Lock") + suffix;
        	imgURL = ThemeManager.getThemeResource(imgURL);
    		this.btnLock.setImage(imgURL);
      	}
    }

    public void enablePostIt(boolean enabled)
    {
        this.btnPostIt.setDisabled(!enabled);
    }

    public Event getEvent()
    {
    	return event;
    }

	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		if (windowContent != null && windowContent.isBlock())
			return;
		
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
		{
			if (keyEvent.getKeyCode() == KeyEvent.F2)
			{
				quickFormTabHrchyLevel = quickFormTabHrchyLevel + 1;
				fireButtonClickEvent(keyEvent, btnDetailRecord);
				if (!btnQuickForm.isDisabled() && btnQuickForm.isVisible())
				{
					fireButtonClickEvent(keyEvent, btnQuickForm);
				}
				else if (!btnParentRecord.isDisabled() && btnParentRecord.isVisible())
				{
					fireButtonClickEvent(keyEvent, btnParentRecord);
					quickFormTabHrchyLevel = quickFormTabHrchyLevel - 1;
				}
				return;
			}
			else
			{
				btn = ctrlKeyMap.get(keyEvent.getKeyCode());
			}
		}
		else if (!keyEvent.isAltKey() && !keyEvent.isCtrlKey() && !keyEvent.isShiftKey())
			btn = keyMap.get(keyEvent.getKeyCode());
		else if (!keyEvent.isAltKey() && !keyEvent.isCtrlKey() && keyEvent.isShiftKey())
		{
			if (keyEvent.getKeyCode() == KeyEvent.F2)
			{
				btn = btnQuickForm;
			}
		}
		fireButtonClickEvent(keyEvent, btn);
	}

	private void fireButtonClickEvent(KeyEvent keyEvent, ToolBarButton btn)
	{
		if (btn != null) {
			prevKeyEventTime = System.currentTimeMillis();
        	prevKeyEvent = keyEvent;
			keyEvent.stopPropagation();
			if (!btn.isDisabled() && btn.isVisible()) {
				Events.sendEvent(btn, new Event(Events.ON_CLICK, btn));
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

	/**
	 * Enable/disable CSV import button
	 * @param b
	 */
	public void enableCSVImport(boolean b) {
		if (btnCSVImport != null)
			btnCSVImport.setDisabled(!b);
	}

	private boolean ToolBarMenuRestictionLoaded = false;
	
	private boolean hasAccess(String buttonName) {
		ADWindow adwindow = ADWindow.get(windowNo);
		if (restrictionList == null)
			restrictionList = adwindow.getWindowToolbarRestrictList();
		
		if (restrictionList.contains(buttonName))
			return false;
		
		if (!MRole.getDefault().isAccessAdvanced()) {
			if (advancedList == null)
				advancedList = adwindow.getWindowAdvancedButtonList();
			
			if (advancedList.contains(buttonName))
				return false;
		}// All advanced btn
		
		return true;
	}

	public void updateToolbarAccess() {
		if (ToolBarMenuRestictionLoaded)
			return;
		
		ADWindow adwindow = ADWindow.findADWindow(this);

		dynamicDisplay();
		// If no workflow set for the table => disable btnWorkflow
		if (!btnActiveWorkflows.isDisabled()) {
			GridTab gridTab = adwindow.getADWindowContent().getActiveGridTab();
			if (gridTab != null) {
				btnActiveWorkflows.setDisabled(!hasWorkflow(gridTab));
			}
		}
		ToolBarMenuRestictionLoaded = true;
	}

	/** btnActiveWorkflow should be disabled when table has not workflow defined */
	boolean hasWorkflow(GridTab gridTab)
	{
		String sql = "SELECT COUNT(*) FROM AD_Workflow WHERE IsActive='Y' AND AD_Table_ID=? AND AD_Client_ID IN (0,?)";
		return (DB.getSQLValueEx(null, sql, gridTab.getAD_Table_ID(), Env.getAD_Client_ID(Env.getCtx())) > 0);
	}

	public void enableProcessButton(boolean b) {
		if (btnProcess != null) {
			btnProcess.setDisabled(!b);
		}
	}

	public void dynamicDisplay() {
		List<Toolbarbutton> customButtons = new ArrayList<Toolbarbutton>();
		for(ToolbarCustomButton toolbarCustomBtn : toolbarCustomButtons) {
			if (overflows != null)
				toolbarCustomBtn.dynamicDisplay(overflows.contains(toolbarCustomBtn.getToolbarbutton()));
			customButtons.add(toolbarCustomBtn.getToolbarbutton());
		}
		
		ADWindow adwindow = ADWindow.findADWindow(this);
		GridTab gridTab = adwindow.getADWindowContent().getActiveGridTab();
		if (gridTab != null) {
			int AD_Tab_ID = gridTab.getAD_Tab_ID();
			List<String> restrictionList = adwindow.getTabToolbarRestrictList(AD_Tab_ID);
			
			for (Component p = this.getFirstChild(); p != null; p = p.getNextSibling()) {
				if (p instanceof ToolBarButton) {
					if (!customButtons.contains(p) && !p.isVisible())
						p.setVisible(true);
				} else if (p instanceof Combobox && !p.isVisible()) {
					p.setVisible(true);
				}
			}
			
			for (String restrictName : restrictionList)
			{
				for (Component p = this.getFirstChild(); p != null; p = p.getNextSibling()) {
					if (p instanceof ToolBarButton) {
						if ( restrictName.equals(((ToolBarButton)p).getName()) ) {
							p.setVisible(false);
							break;
						}
					} else if (p instanceof Combobox) {
						if (restrictName.equals(((Combobox) p).getId())) {
							p.setVisible(false);
							break;
						}
					}
				}

			}
			
			if (overflows != null) {
				//Set visible all overflow buttons with the same condition as above
				overflows.stream()
				.filter(button -> !customButtons.contains(button) && !button.isVisible())
				.forEach(button -> button.setVisible(true));
				
				for (String restrictName : restrictionList) {
					for (ToolBarButton p : overflows) {
						if (restrictName.equals(p.getName())) {
							p.setVisible(false);
							break;
						}
					}
				}
			}
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
	
	private void mobileInit() {	
		LayoutUtils.addSclass("mobile", this);
		addEventListener("onOverflowButton", evt -> onOverflowButton(evt));
		this.setWidgetOverride("toolbarScrollable", "function (wgt) {\n" + 
				"	var total = jq(wgt.$n()).width();\n" + 
				"	var w = wgt.firstChild;\n" + 
				"	var a = " + !mobileShowMoreButtons.isEmpty() + ";\n" + 
				"\n" + 
				"	// make sure all images are loaded.\n" + 
				"	if (zUtl.isImageLoading()) {\n" + 
				"		var f = arguments.callee;\n" + 
				"		setTimeout(function () {\n" + 
				"			return f(wgt);\n" + 
				"		}, 20);\n" + 
				"		return;\n" + 
				"	}\n" + 
				"	for (; w; w = w.nextSibling) {\n" + 
				"		var ow = jq(w.$n()).outerWidth(true);\n" +
				"		if (typeof ow != 'undefined') {total -= ow;}\n" + 
				"		if (total < 0 && w.className == 'zul.wgt.Toolbarbutton') {\n" + 
				"			break;\n" + 
				"		}\n" + 
				"	}\n" + 
				"	if (w && total < 0) {\n" + 
				"       var event = new zk.Event(wgt, 'onOverflowButton', w.uuid, {toServer: true}); \n" +
				"       zAu.send(event); \n" +
				"	}\n" +
				"	else if (a) {\n" + 
				"       var event = new zk.Event(wgt, 'onOverflowButton', null, {toServer: true}); \n" +
				"       zAu.send(event); \n" +
				"	}\n" +
				"}");
		addEventListener(Events.ON_AFTER_SIZE, (AfterSizeEvent evt) -> onAfterSize(evt));
		
		addCallback(AFTER_PAGE_ATTACHED, t -> afterPageAttached());
	}

	private void afterPageAttached() {
		Component p = getParent();
		while (p != null) {
			if (p instanceof Tabpanel) {
				p.addEventListener(WindowContainer.ON_MOBILE_SET_SELECTED_TAB, evt -> this.invalidate());
				break;
			}
			p = p.getParent();
		}
	}

	private void onAfterSize(AfterSizeEvent evt) {
		int width = evt.getWidth();
		if (width != prevWidth) {
			prevWidth = width;
			if (overflowButton != null)
				overflowButton.detach();	
			if (overflowPopup != null)
				overflowPopup.detach();
			if (overflows != null) {
				for (ToolBarButton btn : overflows) {
					appendChild(btn);
				}
				overflows = null;
			}
			Events.postEvent("onPostAfterSize", this, null);
		}
	}

	private void onOverflowButton(Event evt) {
		overflows = new ArrayList<>();
		String uuid = (String) evt.getData();
		if (uuid != null) {
			boolean overflowStarted = false;
			for(Component comp : getChildren()) {
				if (comp instanceof ToolBarButton) {
					if (overflowStarted) {
						overflows.add((ToolBarButton) comp);
					} else if (comp.getUuid().equals(uuid)) {
						overflows.add((ToolBarButton) comp);
						overflowStarted = true;
					}
				}
			}
		}
		//Add at the end of the overflow those buttons marked as isShowMore
		for (ToolBarButton toolbarButton : mobileShowMoreButtons)
			overflows.add(toolbarButton);
		if (overflows.size() > 0) {
			createOverflowButton();
			populateOverflowPopup();
		}
	}

	private void populateOverflowPopup() {
		boolean vertical = !ClientInfo.isMobile() && MSysConfig.getBooleanValue(MSysConfig.ZK_TOOLBAR_SHOW_MORE_VERTICAL, true, Env.getAD_Client_ID(Env.getCtx()));
		if (vertical) {
			Grid grid = new Grid();
			grid.setHflex("min");
			grid.setStyle("border:none;");
			Rows rows = new Rows();
			rows.setParent(grid);
			overflowPopup.appendChild(grid);
			LayoutUtils.addSclass("toolbar-overflow-popup-vertical", overflowPopup);
			for(ToolBarButton btn : overflows) {
				Row row = new Row();
				row.setParent(rows);
				Cell cell1 = new Cell();
				cell1.setParent(row);
				cell1.appendChild(btn);
				cell1.setStyle("border:none;");
				String msgValue = btn.getName().substring(BTNPREFIX.length());
				String msg = Msg.getMsg(Env.getCtx(), msgValue);
				btn.setLabel(msg);
				btn.setHflex("1");
			}
		} else {
			for(ToolBarButton btn : overflows) {
				overflowPopup.appendChild(btn);
			}
		}
		
		if (!vertical) {
			int cnt = 0;
			for(Component c : getChildren()) {
				if (c instanceof ToolBarButton)
					cnt++;
			}
			if (overflows.size() >= cnt) {
				String script = "var e = jq('#" + getUuid() + "');";
				script = script + "var b=zk.Widget.$('#" + overflowPopup.getUuid() + "'); ";
				script = script + "b.setWidth(e.css('width'));";
				Clients.evalJavaScript(script);
			} else {
				overflowPopup.setWidth(null);
			}
		}
	}

	private void enableShowMore() {
		this.appendChild(btnShowMore);
        btnShowMore.setDisabled(false);
        btnShowMore.setVisible(true);                
		newOverflowPopup();
		appendChild(overflowPopup);
		populateOverflowPopup();
	}

	private void onShowMore() {
		Long ts = (Long) overflowPopup.removeAttribute("popup.close");
		if (ts != null) {
			if (System.currentTimeMillis() - ts.longValue() < 500) {
				return;
			}
		}
		overflowPopup.open(btnShowMore, "after_end");
	}
	
	private void createOverflowButton() {
		overflowButton = new A();
		overflowButton.setTooltiptext(Msg.getMsg(Env.getCtx(), "ShowMore"));
		overflowButton.setIconSclass("z-icon-ShowMore");
		overflowButton.setSclass("font-icon-toolbar-button toolbar-button mobile-overflow-link");
		appendChild(overflowButton);
		newOverflowPopup();
		appendChild(overflowPopup);
		overflowButton.addEventListener(Events.ON_CLICK, e -> {
			Long ts = (Long) overflowPopup.removeAttribute("popup.close");
			if (ts != null) {
				if (System.currentTimeMillis() - ts.longValue() < 500) {
					return;
				}
			}
			overflowPopup.open(overflowButton, "after_end");
		});
	}

	private void newOverflowPopup() {
		overflowPopup = new Popup();
		overflowPopup.addEventListener(Events.ON_OPEN, (OpenEvent oe) -> {
			if (!oe.isOpen()) {
				overflowPopup.setAttribute("popup.close", System.currentTimeMillis());
				Component[] childrens = overflowPopup.getChildren().toArray(new Component[0]);
				for (Component child : childrens) {
					if (child instanceof Grid || child instanceof Toolbarbutton)
						continue;
					child.detach();
				}
			}
		});
	}
	
	public void onPostAfterSize() {
		if (this.getPage() != null) {
			String script = "var w = zk.Widget.$('#" + getUuid() + "'); w.toolbarScrollable(w);";
			Clients.evalJavaScript(script);
		}
	}
	
    public void setPressed(String buttonName, boolean pressed) {
    	if (getButton(buttonName) != null)
    		getButton(buttonName).setPressed(pressed);
    }

	/**
	 * @return
	 */
	public int getQuickFormTabHrchyLevel()
	{
		return quickFormTabHrchyLevel;
	}

	/**
	 * @param quickFormHrchyTabLevel
	 */
	public void setQuickFormTabHrchyLevel(int quickFormHrchyTabLevel)
	{
		this.quickFormTabHrchyLevel = quickFormHrchyTabLevel;
	}
    
    public void refreshUserQuery(int AD_Tab_ID, int AD_UserQuery_ID) {
    	if (AEnv.getOrSetExecutionAttribute(getClass().getName()+".refreshUserQuery")) {
    		return;
    	}
    	
    	fQueryName.getItems().clear();
        userQueries = MUserQuery.get(Env.getCtx(), AD_Tab_ID);
        fQueryName.appendItem("");
        for (int i = 0; i < userQueries.length; i++) {
	       	Comboitem li = fQueryName.appendItem(userQueries[i].getName());
	       	li.setValue(userQueries[i].getAD_UserQuery_ID());
	       	if (AD_UserQuery_ID == userQueries[i].getAD_UserQuery_ID()) {
	       		fQueryName.setSelectedItem(li);
	       		if (AD_UserQuery_ID != getAD_UserQuery_ID())
	       			setSelectedUserQuery(AD_UserQuery_ID);
	       	}
        }
        fQueryName.appendItem(m_sNew, 0);
        if (AD_UserQuery_ID <= 0 || fQueryName.getItemCount() <= 1 
        		|| fQueryName.getSelectedItem() == null)
        	fQueryName.setSelectedIndex(0);
    }
    
	public void setSelectedUserQuery(int AD_UserQuery_ID) {
		for (MUserQuery userQuery : userQueries) {
			if (AD_UserQuery_ID == userQuery.getAD_UserQuery_ID()) {
				selectedUserQuery = userQuery;
				break;
			}
		}
	}
	
	public void setSelectedUserQuery(MUserQuery selectedUserQuery) {
		this.selectedUserQuery = selectedUserQuery;
		if (selectedUserQuery != null)
			fQueryName.setValue(selectedUserQuery.getName());
	}

	public int getAD_UserQuery_ID() {
		if (selectedUserQuery == null)
			return 0;
		return selectedUserQuery.getAD_UserQuery_ID();
	}

	/**
	 * Init Default Query in Window Toolbar
	 * @return true if initialized
	 */
	public boolean initDefaultQuery() {
		if(userQueries != null) {
	        for (int i = 0; i < userQueries.length; i++) {
	        	if(userQueries[i].isDefault()) {
		       		fQueryName.setSelectedIndex(i);		       		
		       		setSelectedUserQuery(userQueries[i]);
		       		return true;		       		
	        	}
	        }
		}
		return false;
	}
}
