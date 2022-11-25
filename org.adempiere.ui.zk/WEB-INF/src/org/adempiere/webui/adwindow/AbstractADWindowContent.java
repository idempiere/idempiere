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

import static org.compiere.model.MSysConfig.ZK_GRID_AFTER_FIND;
import static org.compiere.model.SystemIDs.PROCESS_AD_CHANGELOG_REDO;
import static org.compiere.model.SystemIDs.PROCESS_AD_CHANGELOG_UNDO;

import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.Extensions;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.WArchive;
import org.adempiere.webui.WRequest;
import org.adempiere.webui.WZoomAcross;
import org.adempiere.webui.adwindow.validator.WindowValidatorEvent;
import org.adempiere.webui.adwindow.validator.WindowValidatorEventType;
import org.adempiere.webui.adwindow.validator.WindowValidatorManager;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.BusyDialogTemplate;
import org.adempiere.webui.apps.HelpWindow;
import org.adempiere.webui.apps.ProcessModalDialog;
import org.adempiere.webui.apps.form.WCreateFromFactory;
import org.adempiere.webui.apps.form.WCreateFromWindow;
import org.adempiere.webui.apps.form.WQuickForm;
import org.adempiere.webui.component.DesktopTabpanel;
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.ProcessInfoDialog;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.editor.IProcessButton;
import org.adempiere.webui.editor.WButtonEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.event.ActionEvent;
import org.adempiere.webui.event.ActionListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ToolbarListener;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.factory.InfoManager;
import org.adempiere.webui.info.InfoWindow;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.panel.WAttachment;
import org.adempiere.webui.panel.WDocActionPanel;
import org.adempiere.webui.panel.action.CSVImportAction;
import org.adempiere.webui.panel.action.ExportAction;
import org.adempiere.webui.panel.action.FileImportAction;
import org.adempiere.webui.panel.action.ReportAction;
import org.adempiere.webui.part.AbstractUIPart;
import org.adempiere.webui.part.ITabOnSelectHandler;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.CustomizeGridViewDialog;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.FindWindow;
import org.adempiere.webui.window.LabelAction;
import org.adempiere.webui.window.WChat;
import org.adempiere.webui.window.WPostIt;
import org.adempiere.webui.window.WRecordAccessDialog;
import org.compiere.grid.ICreateFrom;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.I_M_Product;
import org.compiere.model.MImage;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MQuery;
import org.compiere.model.MRecentItem;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUserPreference;
import org.compiere.model.MWindow;
import org.compiere.model.PO;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.AbstractComponent;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.sys.ExecutionCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.Popup;
import org.zkoss.zul.RowRenderer;
import org.zkoss.zul.Window.Mode;
import org.zkoss.zul.impl.LabelImageElement;

/**
 *
 * This class is based on org.compiere.apps.APanel written by Jorg Janke.
 * @author Jorg Janke
 *
 * @author <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @author <a href="mailto:hengsin@gmail.com">Low Heng Sin</a>
 * @date Feb 25, 2007
 * @version $Revision: 0.10 $
 *
 * @author Cristina Ghita, www.arhipac.ro
 * see FR [ 2877111 ] See identifiers columns when delete records https://sourceforge.net/p/adempiere/feature-requests/855/
 *
 * @author hengsin, hengsin.low@idalica.com
 * see FR [2887701] https://sourceforge.net/p/adempiere/feature-requests/866/
 * @sponsor www.metas.de
 *
 * @author Teo Sarca, teo.sarca@gmail.com
 *  	<li>BF [ 2992540 ] Grid/Panel not refreshed after process run
 *  		https://sourceforge.net/p/adempiere/zk-web-client/418/
 *  	<li>BF [ 2985892 ] Opening a window using a new record query is not working
 *  		https://sourceforge.net/p/adempiere/zk-web-client/411/
 */
public abstract class AbstractADWindowContent extends AbstractUIPart implements ToolbarListener,
        EventListener<Event>, DataStatusListener, ActionListener, ITabOnSelectHandler
{
    private static final String ON_FOCUS_DEFER_EVENT = "onFocusDefer";

	private static final String ON_DEFER_SET_DETAILPANE_SELECTION_EVENT = "onDeferSetDetailpaneSelection";

	private static final CLogger logger;

    static
    {
        logger = CLogger.getCLogger(AbstractADWindowContent.class);
    }

    private Properties           ctx;

    private GridWindow           gridWindow;

    protected StatusBar     statusBar;

    protected IADTabbox          	 adTabbox;

    private int                  curWindowNo;

    private boolean              m_onlyCurrentRows = true;

    protected ADWindowToolbar     toolbar;

    protected String             title;

	private int m_onlyCurrentDays = 0;

	private boolean m_findCancelled;

	private boolean m_findCreateNew;

	private boolean m_queryInitiating;

	protected BreadCrumb breadCrumb;

	private int adWindowId;

	private MImage image;
	
	private String deleteConfirmationLogic;

	/**
	 * Quick Form Status bar
	 */
	protected StatusBar statusBarQF;

	/**
	 * Maintain no of quick form tabs open
	 */
	protected ArrayList <Integer>			quickFormOpenTabs	= new ArrayList <Integer>();

	protected Component lastFocusEditor = null;
	
	/**
	 * Constructor
	 * @param ctx
	 * @param windowNo
	 * @param adWindowId 
	 */
    public AbstractADWindowContent(Properties ctx, int windowNo, int adWindowId)
    {
        this.ctx = ctx;
        this.curWindowNo = windowNo;
        this.adWindowId = adWindowId;

        initComponents();
    }

    /**
     * @param parent
     * @return Component
     */
	public Component createPart(Object parent)
    {
		adTabbox = createADTab();
		adTabbox.setSelectionEventListener(this);
		adTabbox.setADWindowPanel(this);

        Component comp = super.createPart(parent);
        comp.addEventListener(LayoutUtils.ON_REDRAW_EVENT, this);
        comp.addEventListener(ON_DEFER_SET_DETAILPANE_SELECTION_EVENT, this);
        comp.addEventListener(ON_FOCUS_DEFER_EVENT, this);
        comp.setAttribute(ITabOnSelectHandler.ATTRIBUTE_KEY, this);
        
        return comp;
    }

	public BreadCrumb getBreadCrumb()
	{
		return breadCrumb;
	}

	/**
	 * @return StatusBarPanel
	 */
	public StatusBar getStatusBar()
    {
    	return statusBar;
    }

    private void initComponents()
    {
        /** Initalise toolbar */
        toolbar = new ADWindowToolbar(this, getWindowNo());
        toolbar.setId("windowToolbar");
        toolbar.addListener(this);

        statusBar = new StatusBar();
        
        GridWindowVO gWindowVO = AEnv.getMWindowVO(curWindowNo, adWindowId, 0);
        if (gWindowVO == null)
        {
            throw new ApplicationException(Msg.getMsg(ctx,
                    "AccessTableNoView")
                    + "(No Window Model Info)");
        }
        gridWindow = new GridWindow(gWindowVO, true);
        title = gridWindow.getName();
        image = gridWindow.getMImage();
    }    

    /**
     * @return IADTab
     */
    protected abstract IADTabbox createADTab();

    protected abstract void switchEditStatus(boolean editStatus);
    
    /**
     * set focus to active panel
     */
    public void focusToActivePanel() {
    	IADTabpanel adTabPanel = adTabbox.getSelectedTabpanel();
		focusToTabpanel(adTabPanel);
	}

    private void focusToTabpanel(IADTabpanel adTabPanel ) {
		if (adTabPanel != null && adTabPanel instanceof HtmlBasedComponent) {
			Events.echoEvent(ON_FOCUS_DEFER_EVENT, getComponent(), (HtmlBasedComponent)adTabPanel);
		}
	}

    /**
     * @param query
     * @return boolean
     */
	public boolean initPanel(MQuery query)
    {
		// This temporary validation code is added to check the reported bug
		// [ adempiere-ZK Web Client-2832968 ] User context lost?
		// https://sourceforge.net/p/adempiere/zk-web-client/303/
		// it's harmless, if there is no bug then this must never fail
		Session currSess = Executions.getCurrent().getDesktop().getSession();
		int checkad_user_id = -1;
		if (currSess != null && currSess.getAttribute("Check_AD_User_ID") != null)
			checkad_user_id = (Integer)currSess.getAttribute("Check_AD_User_ID");
		if (checkad_user_id!=Env.getAD_User_ID(ctx))
		{
			String msg = "Timestamp=" + new Date()
					+ ", Bug 2832968 SessionUser="
					+ checkad_user_id
					+ ", ContextUser="
					+ Env.getAD_User_ID(ctx)
					+ ".  Please report conditions to your system administrator or in sf tracker 2832968";
			ApplicationException ex = new ApplicationException(msg);
			logger.log(Level.SEVERE, msg, ex);
			throw ex;
		}
		// End of temporary code for [ adempiere-ZK Web Client-2832968 ] User context lost?

		// Set AutoCommit for this Window
		Env.setAutoCommit(ctx, curWindowNo, Env.isAutoCommit(ctx));
		boolean autoNew = Env.isAutoNew(ctx);
		Env.setAutoNew(ctx, curWindowNo, autoNew);

        // WindowName variable preserved for backward compatibility
        // please consider it as DEPRECATED and use _WinInfo_WindowName instead 
        Env.setContext(ctx, curWindowNo, "WindowName", gridWindow.getName()); // deprecated
        Env.setContext(ctx, curWindowNo, "_WinInfo_WindowName", gridWindow.getName());
        Env.setContext(ctx, curWindowNo, "_WinInfo_AD_Window_ID", gridWindow.getAD_Window_ID());
        Env.setContext(ctx, curWindowNo, "_WinInfo_AD_Window_UU", gridWindow.getAD_Window_UU());

        // Set SO/AutoNew for Window
        Env.setContext(ctx, curWindowNo, "IsSOTrx", gridWindow.isSOTrx());
        if (!autoNew && gridWindow.isTransaction())
        {
            Env.setAutoNew(ctx, curWindowNo, true);
        }

        m_onlyCurrentRows =  gridWindow.isTransaction();

        MQuery detailQuery = null;
        /**
         * Window Tabs
         */
        if (query != null && query.getZoomTableName() != null && query.getZoomColumnName() != null)
    	{
    		if (!query.getZoomTableName().equalsIgnoreCase(gridWindow.getTab(0).getTableName()))
    		{
    			detailQuery = query;
    			query = new MQuery();
    			query.addRestriction("1=2");
    			query.setRecordCount(0);
    		}
    	}

        int tabSize = gridWindow.getTabCount();

        GridTab gridTab = null;
        for (int tab = 0; tab < tabSize; tab++)
        {
            gridTab = initTab(query, tab);
            if (tab == 0 && gridTab == null && m_findCancelled)
            	return false;
        }

        if (gridTab != null)
        	gridTab.getTableModel().setChanged(false);

        adTabbox.setSelectedIndex(0);
        // set again IsSOTrx for window if context for window is clear at AbstractADTab.prepareContext, 
        if (Env.getContext(ctx, curWindowNo, "IsSOTrx", true) == null)
        	Env.setContext(ctx, curWindowNo, "IsSOTrx", gridWindow.isSOTrx());
        toolbar.enableTabNavigation(adTabbox.getTabCount() > 1);
        toolbar.enableFind(true);
        adTabbox.evaluate(null);

        toolbar.updateToolbarAccess();
        updateToolbar();
        if (query == null && toolbar.initDefaultQuery()) {
        	doOnQueryChange();
        }
        
        if (detailQuery != null && zoomToDetailTab(detailQuery))
        {
        	return true;
        }

        SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Tab, adTabbox.getSelectedGridTab().getAD_Tab_ID());

        return true;
    }

	private boolean zoomToDetailTab(MQuery query) {
		//zoom to detail
        if (query != null && query.getZoomTableName() != null && query.getZoomColumnName() != null)
    	{
    		GridTab gTab = gridWindow.getTab(0);
    		if (!query.getZoomTableName().equalsIgnoreCase(gTab.getTableName()))
    		{
    			int tabSize = gridWindow.getTabCount();

    	        for (int tab = 0; tab < tabSize; tab++)
    	        {
    	        	gTab = gridWindow.getTab(tab);
    	        	if (gTab.isSortTab())
    	        		continue;
    	        	if (gTab.getTableName().equalsIgnoreCase(query.getZoomTableName()))
    	        	{
    	        		if (doZoomToDetail(gTab, query, tab)) {
	        				return true;
	        			}
    	        	}
    	        }
    		}
    	}
        return false;
	}

	private boolean doZoomToDetail(GridTab gTab, MQuery query, int tabIndex) {
		GridField[] fields = gTab.getFields();
		for (GridField field : fields)
		{
			if (field.getColumnName().equalsIgnoreCase(query.getZoomColumnName()))
			{
				gridWindow.initTab(tabIndex);
				int[] parentIds = DB.getIDsEx(null, "SELECT " + gTab.getLinkColumnName() + " FROM " + gTab.getTableName() + " WHERE " + query.getWhereClause());
				if (parentIds.length > 0)
				{
					GridTab parentTab = null;
					Map<Integer, MQuery>queryMap = new TreeMap<Integer, MQuery>();

					for (int parentId : parentIds)
					{
						Map<Integer, Object[]>parentMap = new TreeMap<Integer, Object[]>();
						int index = tabIndex;
						int oldpid = parentId;
						GridTab currentTab = gTab;
						while (index > 0)
						{
							index--;
							GridTab pTab = gridWindow.getTab(index);
							if (pTab.getTabLevel() < currentTab.getTabLevel())
							{
								if (parentTab == null)
									parentTab = pTab;
								gridWindow.initTab(index);
								if (index > 0)
								{
									if (pTab.getLinkColumnName() != null && pTab.getLinkColumnName().trim().length() > 0)
									{
										int pid = DB.getSQLValue(null, "SELECT " + pTab.getLinkColumnName() + " FROM " + pTab.getTableName() + " WHERE " + currentTab.getLinkColumnName() + " = ?", oldpid);
										if (pid > 0)
										{
											parentMap.put(index, new Object[]{currentTab.getLinkColumnName(), oldpid});
											oldpid = pid;
											currentTab = pTab;
										}
										else
										{
											parentMap.clear();
											break;
										}
									}
								}
								else
								{
									parentMap.put(index, new Object[]{currentTab.getLinkColumnName(), oldpid});
								}
							}
						}
	
						for(Map.Entry<Integer, Object[]> entry : parentMap.entrySet())
						{
							GridTab pTab = gridWindow.getTab(entry.getKey());
							Object[] value = entry.getValue();
							MQuery pquery = queryMap.get(entry.getKey());
							if (pquery == null) 
							{
								pquery = new MQuery(pTab.getAD_Table_ID());
								queryMap.put(entry.getKey(), pquery);
								pquery.addRestriction((String)value[0], "=", value[1]);
							}
							else
							{
								pquery.addRestriction((String)value[0], "=", value[1], null, null, false, 0);
							}
						}
					}

					for (Map.Entry<Integer, MQuery> entry : queryMap.entrySet())
					{
						GridTab pTab = gridWindow.getTab(entry.getKey());
						IADTabpanel tp = adTabbox.findADTabpanel(pTab);
        				tp.createUI();
        				if (tp.getTabLevel() == 0)
        				{
        					pTab.setQuery(entry.getValue());
        					tp.query();
        				}
        				else 
        				{
        					tp.query();
        					pTab.setQuery(entry.getValue());
        					tp.query();
        				}
					}

					MQuery targetQuery = new MQuery(gTab.getAD_Table_ID());
					targetQuery.addRestriction(gTab.getLinkColumnName(), "=", parentTab.getRecord_ID());
					gTab.setQuery(targetQuery);
					IADTabpanel gc = null;
					gc = adTabbox.findADTabpanel(gTab);
					gc.createUI();
					gc.query(false, 0, 0);

					int zoomColumnIndex = -1;
					GridTable table = gTab.getTableModel();
					for (int i = 0; i < table.getColumnCount(); i++)
					{
						if (table.getColumnName(i).equalsIgnoreCase(query.getZoomColumnName()))
						{
							zoomColumnIndex = i;
							break;
						}
					}
    				int count = table.getRowCount();
    				for(int i = 0; i < count; i++)
    				{
    					int id = -1;
    					if (zoomColumnIndex >= 0) 
    					{
    						Object zoomValue = table.getValueAt(i, zoomColumnIndex);
    						if (zoomValue != null && zoomValue instanceof Number)
    						{
    							id = ((Number)zoomValue).intValue();
    						}
    					}
    					else
    					{
    						id = table.getKeyID(i);
    					}
    					if (id == ((Integer)query.getZoomValue()).intValue())
    					{
    						setActiveTab(gridWindow.getTabIndex(gTab), null);
    						gTab.navigate(i);
    						return true;
    					}
    				}
				}
			}
		}
		return false;
	}

	private void initQueryOnNew(MQuery result) {
		GridTab curTab = adTabbox.getSelectedGridTab();
		boolean onNew = false;
		if (curTab.isHighVolume() && m_findCreateNew)
			onNew = true;
		else if (result == null && curTab.getRowCount() == 0 && Env.isAutoNew(ctx, curWindowNo))
			onNew = true;
		else if (!curTab.isReadOnly() && curTab.isQueryNewRecord())
			onNew = true;
		if (onNew) {
			Executions.schedule(AEnv.getDesktop(), new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					onNew();
					ADTabpanel adtabpanel = (ADTabpanel) getADTab().getSelectedTabpanel();
					adtabpanel.focusToFirstEditor(false);
				}
			}, new Event("onInsert"));
		}
	}

	/**
	 * @param query
	 * @param tabIndex
	 */
	protected GridTab initTab(MQuery query, int tabIndex) {
		gridWindow.initTab(tabIndex);

		final GridTab gTab = gridWindow.getTab(tabIndex);
		Env.setContext(ctx, curWindowNo, tabIndex, GridTab.CTX_TabLevel, Integer.toString(gTab.getTabLevel()));

		// Query first tab
		if (tabIndex == 0)
		{
			gTab.setUpdateWindowContext(true);
			m_queryInitiating = true;
			getComponent().setVisible(false);
		    initialQuery(query, gTab, new Callback<MQuery>() {
				@Override
				public void onCallback(MQuery result) {
					m_queryInitiating = false;

					if (m_findCancelled) {
						SessionManager.getAppDesktop().closeWindow(curWindowNo);
				    	return;
					}

					if (!getComponent().isVisible())
						getComponent().setVisible(true);

					// Set initial Query on first tab
				    if (result != null)
				    {
				        m_onlyCurrentRows = false;
				        gTab.setQuery(result);
				    }

				    if (adTabbox.getSelectedTabpanel() != null)
				    {
					    initFirstTabpanel();

					    initQueryOnNew(result);
				    }
				}

			});
		}
		else
		{
			gTab.setUpdateWindowContext(false);
		}

		String type = gTab.getTabType();
		if (!Util.isEmpty(type))
		{
			IADTabpanel adTabPanal = Extensions.getADTabPanel(type);
			if (adTabPanal != null)
			{
				initTabPanel(query, tabIndex, gTab, adTabPanal);
			}
			else
			{
				logger.log(Level.SEVERE, "No implementaton for tab type " + type + " Found", new Exception("No implementaton for tab type " + type + " Found"));
			}
		}
		else if (gTab.isSortTab())
		{
			ADSortTab sortTab = new ADSortTab();
			sortTab.init(this, gTab);
			adTabbox.addTab(gTab, sortTab);
			sortTab.registerAPanel(this);
			if (tabIndex == 0) {
				sortTab.createUI();
				if (!m_queryInitiating)
				{
					initFirstTabpanel();
				}
			}
			gTab.addDataStatusListener(this);
		}
		else
		{
			ADTabpanel fTabPanel = new ADTabpanel();
			initTabPanel(query, tabIndex, gTab, fTabPanel);
		}

		return gTab;
	} // initTab

	private void initTabPanel(MQuery query, int tabIndex, final GridTab gTab, IADTabpanel adTabPanal)
	{
		adTabPanal.addEventListener(ADTabpanel.ON_DYNAMIC_DISPLAY_EVENT, this);
		gTab.addDataStatusListener(this);
		adTabPanal.init(this, gTab);
		adTabbox.addTab(gTab, adTabPanal);
		if (tabIndex == 0)
		{
			adTabPanal.createUI();
			if (!m_queryInitiating)
			{
		    		try {
						initFirstTabpanel();
		    		} catch (Exception e) {
		        		if (DBException.isTimeout(e)) {
		        			Dialog.error(curWindowNo, GridTable.LOAD_TIMEOUT_ERROR_MESSAGE);
		        		}
		    		}
			}
		}

		if (!m_queryInitiating && tabIndex == 0)
		{
			initQueryOnNew(query);
		}
	} // initTabPanel

	private void initFirstTabpanel() {
		adTabbox.getSelectedTabpanel().query(m_onlyCurrentRows, m_onlyCurrentDays, adTabbox.getSelectedGridTab().getMaxQueryRecords());
		adTabbox.getSelectedTabpanel().activate(true);
		Events.echoEvent(new Event(ADTabpanel.ON_POST_INIT_EVENT, adTabbox.getSelectedTabpanel()));
	}

    /**
     * Initial Query
     *
     * @param query
     *            initial query
     * @param mTab
     *            tab
     * @return query or null
     */
    private void initialQuery(final MQuery query, GridTab mTab, final Callback<MQuery> callback)
    {
        // We have a (Zoom) query
        if (query != null && query.isActive())
        {
    		callback.onCallback(query);
    		return;
        }

        //
		StringBuffer where = new StringBuffer(Env.parseContext(ctx, curWindowNo, mTab.getWhereExtended(), false));
        // Query automatically if high volume and no query
        boolean require = mTab.isHighVolume();
        if (!require && !m_onlyCurrentRows) // No Trx Window
        {
            if (query != null)
            {
                String wh2 = query.getWhereClause();
                if (wh2.length() > 0)
                {
                    if (where.length() > 0)
                        where.append(" AND ");
                    where.append(wh2);
                }
            }
            //
            StringBuffer sql = new StringBuffer("SELECT COUNT(*) FROM ")
                    .append(mTab.getTableName());
            if (where.length() > 0)
                sql.append(" WHERE ").append(where);
            String finalSQL = MRole.getDefault().addAccessSQL(sql.toString(),
            		mTab.getTableName(), MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
            int no = DB.getSQLValue(null, finalSQL.toString());
            //
            require = mTab.isQueryRequire(no);
        }
        // Show Query
        if (require)
        {
        	m_findCancelled = false;
        	m_findCreateNew = false;
            GridField[] findFields = mTab.getFields();
            FindWindow findWindow = new FindWindow(curWindowNo, mTab.getTabNo(),
                    mTab.getName(), mTab.getAD_Table_ID(), mTab.getTableName(),
                    where.toString(), findFields, 10, mTab.getAD_Tab_ID(), this); // no query below 10
           	tabFindWindowHashMap.put(mTab, findWindow);
            setupEmbeddedFindwindow(findWindow);
            if (findWindow.initialize())
            {
	        	findWindow.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						if (!findWindow.isCancel())
			            {
			            	m_findCreateNew = findWindow.isCreateNew();
			            	MQuery result = findWindow.getQuery();
			            	callback.onCallback(result);
			            	EventListener<? extends Event> listener = findWindow.getEventListeners(DialogEvents.ON_WINDOW_CLOSE).iterator().next();
			            	findWindow.removeEventListener(DialogEvents.ON_WINDOW_CLOSE, listener);
			            }
			            else
			            {
			            	m_findCancelled = true;
			            	callback.onCallback(null);
			            }
					}
				});	        	
	        	getComponent().addEventListener("onInitialQuery", new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						getComponent().getParent().appendChild(findWindow);
						LayoutUtils.openEmbeddedWindow(getComponent().getParent(), findWindow, "overlap");						
					}
				});
	        	Events.echoEvent("onInitialQuery", getComponent(), null);
            }
            else
            {
            	callback.onCallback(query);
            }
        }
        else
        {
        	callback.onCallback(query);
        }
    } // initialQuery

	private void setupEmbeddedFindwindow(FindWindow findWindow) {
		findWindow.setTitle(null);
		findWindow.setBorder("none");	
		findWindow.setStyle("position: absolute;background-color: #fff;");
		ZKUpdateUtil.setWidth(findWindow, "100%");
		if (ClientInfo.maxHeight(ClientInfo.MEDIUM_HEIGHT-1))
			ZKUpdateUtil.setHeight(findWindow, "100%");
		else
			ZKUpdateUtil.setHeight(findWindow, "60%");
		findWindow.setZindex(1000);
		findWindow.setSizable(false);
		findWindow.setContentStyle("background-color: #fff; width: 99%; margin: auto;");
	}

    public String getTitle()
    {
        return title;
    }
    
    public MImage getImage()
    {
    	return image;
    }

    /**
     * @see ToolbarListener#onDetailRecord()
     */
    public void onDetailRecord()
    {
    	adTabbox.onDetailRecord();
    }

	/**
     * @see ToolbarListener#onParentRecord()
     */
    public void onParentRecord()
    {
    	List<BreadCrumbLink> parents = breadCrumb.getParentLinks();
    	if (!parents.isEmpty()) {
    		Events.sendEvent(parents.get(parents.size()-1), new Event(Events.ON_CLICK, parents.get(parents.size()-1)));
    	}
    }

    /**
     * @see ToolbarListener#onFirst()
     */
    public void onFirst()
    {
    	Callback<Boolean> callback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					adTabbox.getSelectedGridTab().navigate(-1); // not zero because of IDEMPIERE-3736 
			        focusToActivePanel();
				}
			}
		};
		saveAndNavigate(callback);
    }

    /**
     * @see ToolbarListener#onLast()
     */
    public void onLast()
    {
        Callback<Boolean> callback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					adTabbox.getSelectedGridTab().navigate(adTabbox.getSelectedGridTab().getRowCount() - 1);
			        focusToActivePanel();
				}
			}
		};
		onSave(false, true, callback);
    }

    /**
     * @see ToolbarListener#onNext()
     */
    public void onNext()
    {
        Callback<Boolean> callback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					adTabbox.getSelectedGridTab().navigateRelative(+1);
					focusToActivePanel();
				}
			}
		};
		saveAndNavigate(callback);
    }

    /**
     * @see ToolbarListener#onPrevious()
     */
    public void onPrevious()
    {
        Callback<Boolean> callback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					adTabbox.getSelectedGridTab().navigateRelative(-1);
			        focusToActivePanel();
				}
			}
		};
		saveAndNavigate(callback);
    }

    /**
     * @see ToolbarListener#onPrevious()
     */
    public void onTreeNavigate(final GridTab gt, final int rowIndex)
    {
    	Callback<Boolean> callback = new Callback<Boolean>() {
    		@Override
    		public void onCallback(Boolean result) {
    			if (result) {
    				gt.navigate(rowIndex);
    				//focusToActivePanel();
    			}
    		}
    	};
    	saveAndNavigate(callback);
    }

    // Elaine 2008/12/04
	private Menupopup 	m_popup = null;
	private Menuitem 	m_lock = null;
	private Menuitem 	m_access = null;

	private HashMap<GridTab, FindWindow> tabFindWindowHashMap = new HashMap<GridTab, FindWindow>();
	private int masterRecord = -1;

	private Div mask;

	protected ADWindow adwindow;

	protected boolean showingOnExitDialog;

	/**
	 *	@see ToolbarListener#onLock()
	 */
	public void onLock()
	{
		if (!toolbar.isPersonalLock)
			return;
		if (adTabbox.getSelectedGridTab().getRecord_ID() == -1)	//	No Key
			return;

		if(m_popup == null)
		{
			m_popup = new Menupopup();

			m_lock = new Menuitem(Msg.translate(Env.getCtx(), "Lock"));
			m_popup.appendChild(m_lock);
			m_lock.addEventListener(Events.ON_CLICK, new EventListener<Event>()
			{
				public void onEvent(Event event) throws Exception
				{
					adTabbox.getSelectedGridTab().lock(Env.getCtx(), adTabbox.getSelectedGridTab().getRecord_ID(), !toolbar.getButton("Lock").isPressed());
					adTabbox.getSelectedGridTab().loadLocks();			//	reload

					toolbar.lock(adTabbox.getSelectedGridTab().isLocked());
				}
			});

			m_access = new Menuitem(Msg.translate(Env.getCtx(), "RecordAccessDialog"));
			m_popup.appendChild(m_access);
			m_access.addEventListener(Events.ON_CLICK, new EventListener<Event>()
			{
				public void onEvent(Event event) throws Exception
				{
					WRecordAccessDialog recordAccessDialog = new WRecordAccessDialog(null, adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getRecord_ID());
					recordAccessDialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

						@Override
						public void onEvent(Event event) throws Exception {
							toolbar.lock(adTabbox.getSelectedGridTab().isLocked());
							focusToLastFocusEditor();
						}
					});

					AEnv.showWindow(recordAccessDialog);
				}
			});
			LayoutUtils.autoDetachOnClose(m_popup);
		}
		if (m_popup.getPage() == null) {
			LabelImageElement btn = toolbar.getToolbarItem("Lock");
			Popup popup = LayoutUtils.findPopup(btn.getParent());
			if (popup != null) {
				popup.appendChild(m_popup);				
			} else {
				m_popup.setPage(toolbar.getToolbarItem("Lock").getPage());
			}
		}
		m_popup.open(toolbar.getToolbarItem("Lock"), "after_start");		
	}	//	lock
	//


    /**
     * @see ToolbarListener#onAttachment()
     */
    public void onAttachment()
    {
		int record_ID = adTabbox.getSelectedGridTab().getRecord_ID();
		if (logger.isLoggable(Level.INFO)) logger.info("Record_ID=" + record_ID);

		if (record_ID == -1)	//	No Key
		{
			return;
		}

		EventListener<Event> listener = new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				toolbar.setPressed("Attachment",adTabbox.getSelectedGridTab().hasAttachment());
				focusToLastFocusEditor();
			}
		};
		//	Attachment va =
		WAttachment win = new WAttachment (	curWindowNo, adTabbox.getSelectedGridTab().getAD_AttachmentID(),
							adTabbox.getSelectedGridTab().getAD_Table_ID(), record_ID, null, listener);		
		win.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				hideBusyMask();
			}
		});
		getComponent().getParent().appendChild(win);
		showBusyMask(win);		
		LayoutUtils.openOverlappedWindow(getComponent(), win, "middle_center");
		win.focus();
	}

    public void onChat()
    {
    	int recordId = adTabbox.getSelectedGridTab().getRecord_ID();
    	if (logger.isLoggable(Level.INFO)) logger.info("Record_ID=" + recordId);

		if (recordId== -1)	//	No Key
		{
			return;
		}

		//	Find display
		String infoName = null;
		String infoDisplay = null;
		for (int i = 0; i < adTabbox.getSelectedGridTab().getFieldCount(); i++)
		{
			GridField field = adTabbox.getSelectedGridTab().getField(i);
			if (field.isKey())
				infoName = field.getHeader();
			if ((field.getColumnName().equals("Name") || field.getColumnName().equals("DocumentNo") )
				&& field.getValue() != null)
				infoDisplay = field.getValue().toString();
			if (infoName != null && infoDisplay != null)
				break;
		}
		if (infoDisplay == null) {
			infoDisplay = "";
		}
		String description = infoName + ": " + infoDisplay;

    	WChat chat = new WChat(curWindowNo, adTabbox.getSelectedGridTab().getCM_ChatID(), adTabbox.getSelectedGridTab().getAD_Table_ID(), recordId, description, null);
    	chat.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				hideBusyMask();
				toolbar.setPressed("Chat",adTabbox.getSelectedGridTab().hasChat());
				focusToLastFocusEditor();				
			}
		});
    	getComponent().getParent().appendChild(chat);
    	showBusyMask(chat);    	    	
    	LayoutUtils.openOverlappedWindow(getComponent(), chat, "middle_center");
    	chat.showWindow();
    }

    public void onPostIt()
    {
    	int recordId = adTabbox.getSelectedGridTab().getRecord_ID();
    	logger.info("Record_ID=" + recordId);

    	if (recordId== -1)	//	No Key
    	{
    		return;
    	}

    	//	Find display
    	String infoName = null;
    	String infoDisplay = null;
    	for (int i = 0; i < adTabbox.getSelectedGridTab().getFieldCount(); i++)
    	{
    		GridField field = adTabbox.getSelectedGridTab().getField(i);
    		if (field.isKey())
    			infoName = field.getHeader();
    		if ((field.getColumnName().equals("Name") || field.getColumnName().equals("DocumentNo") )
    				&& field.getValue() != null)
    			infoDisplay = field.getValue().toString();
    		if (infoName != null && infoDisplay != null)
    			break;
    	}
    	String header = infoName + ": " + infoDisplay;

    	WPostIt postit = new WPostIt(header, adTabbox.getSelectedGridTab().getAD_PostIt_ID(), adTabbox.getSelectedGridTab().getAD_Table_ID(), recordId, null);
    	postit.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
    		@Override
    		public void onEvent(Event event) throws Exception {
    			hideBusyMask();
    			toolbar.setPressed("PostIt",adTabbox.getSelectedGridTab().hasPostIt());
    			focusToLastFocusEditor();
    		}
    	});
    	getComponent().getParent().appendChild(postit);
    	showBusyMask(postit);    	    	
    	LayoutUtils.openOverlappedWindow(getComponent(), postit, "middle_center");
    	postit.showWindow();
    }
    
    /**
     * Open Label panel
     */
	public void onLabel() {
		toolbar.setPressed("Label",false);
		LabelAction labelAction = new LabelAction(this);
		labelAction.show();
	}
    
    /**
     * @see ToolbarListener#onToggle()
     */
    public void onToggle()
    {
    	adTabbox.getSelectedTabpanel().switchRowPresentation();
    	toolbar.enableCustomize(adTabbox.getSelectedTabpanel().isEnableCustomizeButton());
    	focusToActivePanel();
    }

	/**
     * @param callback
     */
    public synchronized void onExit(Callback<Boolean> callback)
    {
    	if (isPendingChanges())
    	{
    		showingOnExitDialog = true;
    		Dialog.ask(curWindowNo, "CloseUnSave?", b -> {
    			showingOnExitDialog = false;
    			callback.onCallback(b);
    			if (!b)
    			{
    				//restore focus
    				focusToLastFocusEditor();
    			}
    		});
    	}
    	else
    	{
    		callback.onCallback(Boolean.TRUE);
    	}
    	
    }

    /**
     * restore focus to last known focus editor (if any)
     * @return true if there's last focus editor
     */
	public boolean focusToLastFocusEditor() {
		return focusToLastFocusEditor(false);
	}
	
    /**
     * restore focus to last known focus editor (if any)
     * @param defer true to schedule for later/defer execution
     * @return true if there's last focus editor
     */
	public boolean focusToLastFocusEditor(boolean defer) {
		if (lastFocusEditor != null && lastFocusEditor instanceof HtmlBasedComponent && 
			lastFocusEditor.getPage() != null && LayoutUtils.isReallyVisible(lastFocusEditor)) {
			if (defer) {
				final HtmlBasedComponent editor = (HtmlBasedComponent) lastFocusEditor;
				Executions.schedule(getComponent().getDesktop(), e -> editor.focus(), new Event("onScheduleFocusToLastFocusEditor"));
			} else {
				((HtmlBasedComponent)lastFocusEditor).focus();
			}
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Invoke when quick form is click
	 */
	public void onQuickForm() {
		onQuickForm(false);
	}

	/**
	 * Invoke when quick form is click
	 * @param focusTabAtEnd the tab to return when finished
	 */
	public void onQuickForm(boolean stayInParent)
	{
		logger.log(Level.FINE, "Invoke Quick Form");
		// Prevent to open Quick Form if already opened.
		if (!this.registerQuickFormTab(getADTab().getSelectedGridTab().getAD_Tab_ID()))
		{
			logger.fine("TabID=" + getActiveGridTab().getAD_Tab_ID() + "  is already open.");
			return;
		}
		int table_ID = adTabbox.getSelectedGridTab().getAD_Table_ID();
		if (table_ID == -1)
			return;

		statusBarQF = new StatusBar();
		// Remove Key-listener of parent Quick Form
		int tabLevel = getToolbar().getQuickFormTabHrchyLevel();
		if (tabLevel > 0 && getCurrQGV() != null)
		{
			SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, getCurrQGV());
		}

		WQuickForm form = new WQuickForm(this, m_onlyCurrentRows, m_onlyCurrentDays);
		form.setTitle(this.getADTab().getSelectedGridTab().getName());
		form.setVisible(true);
		form.setSizable(true);
		form.setMaximizable(true);
		form.setMaximized(true);
		form.setPosition("center");
		form.setStayInParent(stayInParent);
		ZKUpdateUtil.setWindowHeightX(form, 550);
		ZKUpdateUtil.setWindowWidthX(form, 900);
		ZkCssHelper.appendStyle(form, "z-index: 900;");

		AEnv.showWindow(form);
	} // onQuickForm

    /**
     * @param event
     * @see EventListener#onEvent(Event)
     */
    public void onEvent(Event event)
    {
    	if (CompositeADTabbox.ON_SELECTION_CHANGED_EVENT.equals(event.getName()))
    	{
    		Object eventData = event.getData();

	        if (eventData != null && eventData instanceof Object[] && ((Object[])eventData).length == 2)
	        {
	        	Object[] indexes = (Object[]) eventData;
	        	final int newTabIndex = (Integer)indexes[1];

	        	final int originalTabIndex = adTabbox.getSelectedIndex();
	        	final int originalTabRow = adTabbox.getSelectedGridTab().getCurrentRow();
	            setActiveTab(newTabIndex, new Callback<Boolean>() {

					@Override
					public void onCallback(Boolean result) {
						if (result)
						{
							if (newTabIndex < originalTabIndex)
							{
								if (adTabbox.isDetailPaneLoaded())
									adTabbox.setDetailPaneSelectedTab(originalTabIndex, originalTabRow);
								else {
									Events.echoEvent(new Event(ON_DEFER_SET_DETAILPANE_SELECTION_EVENT, getComponent(), new Integer[]{originalTabIndex, originalTabRow}));
								}
							}
			            }
			            else
			            {
			            	//reset to original
			            	adTabbox.setSelectedIndex(originalTabIndex);
			            }

					}
				});
	            
	            SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Tab, adTabbox.getSelectedGridTab().getAD_Tab_ID());
	        }
    	}
    	else if (event.getTarget() instanceof ProcessModalDialog)
    	{
    		if (!DialogEvents.ON_WINDOW_CLOSE.equals(event.getName())){
    			return;
    		}

    		hideBusyMask();
    		ProcessModalDialog dialog = (ProcessModalDialog) event.getTarget();
    		ProcessInfo pi = dialog.getProcessInfo();

    		onModalClose(pi);

			String s = null;
			boolean b = false;
			ProcessInfoLog[] logs = null;
			if (getActiveGridTab().isQuickForm)
			{
				s = statusBarQF.getStatusLine();
				b = statusBarQF.getStatusError();
				logs = statusBarQF.getPLogs();
			}
			else
			{
				s = statusBar.getStatusLine();
				b = statusBar.getStatusError();
				logs = statusBar.getPLogs();
			}

			MPInstance instance = new MPInstance(ctx, pi.getAD_PInstance_ID(), "false");
			if (!instance.isRunAsJob() && !dialog.isCancel()){
				// when run as job or canceled, don't expect see its effect when close parameter panel, so don't refresh
				onRefresh(true, false);
			}

			if (getActiveGridTab().isQuickForm)
			{
				statusBarQF.setStatusLine(s, b, logs);
			}
			else
			{
				statusBar.setStatusLine(s, b, logs);
			}
    	}
    	else if (ADTabpanel.ON_DYNAMIC_DISPLAY_EVENT.equals(event.getName()))
    	{
    		IADTabpanel adtab = (IADTabpanel) event.getTarget();
    		if (adtab == adTabbox.getSelectedTabpanel()) {
    			toolbar.enableProcessButton(adtab.isEnableProcessButton());
    			toolbar.dynamicDisplay();
    		}
    	}
    	else if (event.getTarget() == getComponent() && event.getName().equals(LayoutUtils.ON_REDRAW_EVENT)) {
    		ExecutionCtrl ctrl = (ExecutionCtrl) Executions.getCurrent();
    		Event evt = ctrl.getNextEvent();
    		if (evt != null) {
    			Events.sendEvent(evt);
    			Events.postEvent(new Event(LayoutUtils.ON_REDRAW_EVENT, getComponent()));
    			return;
    		}
    		LayoutUtils.redraw((AbstractComponent) getComponent());
    	}
    	else if (event.getName().equals(ON_DEFER_SET_DETAILPANE_SELECTION_EVENT)) {
    		Integer[] data = (Integer[]) event.getData();
    		adTabbox.setDetailPaneSelectedTab(data[0], data[1]);
    	}
    	else if (event.getName().equals(ON_FOCUS_DEFER_EVENT)) {
    		HtmlBasedComponent comp = (HtmlBasedComponent) event.getData();
    		if (comp instanceof ADTabpanel)
    			((ADTabpanel)comp).focusToFirstEditor(false);
    		else
    			comp.focus();
    		// 
    	}    		
    }

	private void setActiveTab(final int newTabIndex, final Callback<Boolean> callback) {

		final int oldTabIndex = adTabbox.getSelectedIndex();

		if (oldTabIndex == newTabIndex)
		{
			if (callback != null)
				callback.onCallback(true);
		}
		else
		{
			Callback<Boolean> command = new Callback<Boolean>() {

				@Override
				public void onCallback(Boolean result) {
					if (result) {
						setActiveTab0(oldTabIndex, newTabIndex, callback);
					} else if (callback != null) {
						callback.onCallback(false);
					}
				}
			};
			Object value = Executions.getCurrent().getAttribute(CompositeADTabbox.AD_TABBOX_ON_EDIT_DETAIL_ATTRIBUTE);
			if (value != null && value == adTabbox.getSelectedDetailADTabpanel()
				&& (adTabbox.getDirtyADTabpanel() == adTabbox.getSelectedDetailADTabpanel() 
				    || (adTabbox.getDirtyADTabpanel() == null 
				        && adTabbox.getSelectedDetailADTabpanel().getGridTab().isNew()))) {
				command.onCallback(true);
			} else {
				saveAndNavigate(command);
			}
		}

	}

	public void saveAndNavigate(final Callback<Boolean> callback) {
		if (adTabbox != null)
		{
			if (adTabbox.isSortTab())
			{
				onSave(false, true, callback);
			}
			else if (adTabbox.needSave(true, false))
		    {
		    	if (adTabbox.needSave(true, true))
				{
		    		onSave(false, true, callback);
				}
				else
				{
					//  new record, but nothing changed
					adTabbox.dataIgnore();
					callback.onCallback(true);
				}
			}   //  there is a change
			else {
				// just in case
				adTabbox.dataIgnore();
				callback.onCallback(true);
			}
		}
		else
			callback.onCallback(true);
	}

	private void setActiveTab0(int oldTabIndex, int newTabIndex,
			final Callback<Boolean> callback) {
		boolean back = false;
		IADTabpanel oldTabpanel = adTabbox.getSelectedTabpanel();

		if (!adTabbox.updateSelectedIndex(oldTabIndex, newTabIndex))
		{
		    Dialog.warn(curWindowNo, "TabSwitchJumpGo", title);
		    if (callback != null)
				callback.onCallback(false);
		    return;
		}

		IADTabpanel newTabpanel = adTabbox.getSelectedTabpanel();
		
		//toggle window context update
		if (newTabpanel.getGridTab() != null)
			newTabpanel.getGridTab().setUpdateWindowContext(true);
		if (oldTabIndex > newTabIndex && oldTabpanel.getGridTab() != null)
			oldTabpanel.getGridTab().setUpdateWindowContext(false);

		boolean activated = newTabpanel.isActivated();
		if (oldTabpanel != null)
			oldTabpanel.activate(false);
		if (!activated)
			newTabpanel.activate(true);

		back = (newTabIndex < oldTabIndex);
		if (back && newTabpanel.getTabLevel() > 0)
		{
			if (newTabpanel.getTabLevel() >= oldTabpanel.getTabLevel())
				back = false;
			else if ((newTabIndex - oldTabIndex) > 1)
			{
				for (int i = oldTabIndex - 1; i > newTabIndex; i--)
				{
					IADTabpanel next = adTabbox.getADTabpanel(i);
					if (next != null && next.getTabLevel() <= newTabpanel.getTabLevel())
					{
						back = false;
						break;
					}
				}
			}
		}

		if (!back)
		{
			Object value = Executions.getCurrent().removeAttribute(CompositeADTabbox.AD_TABBOX_ON_EDIT_DETAIL_ATTRIBUTE);
			if (value != newTabpanel)
			{
				newTabpanel.query();
				if (newTabpanel instanceof ADTabpanel)
				{
					ADTabpanel adtabpanel = (ADTabpanel) newTabpanel;
					Events.echoEvent(ADTabpanel.ON_POST_INIT_EVENT, adtabpanel, null);
				}			
			}
			else 
			{
				//detail pane of the new header tab might need refresh
				if (newTabpanel instanceof ADTabpanel)
				{
					ADTabpanel adtabpanel = (ADTabpanel) newTabpanel;
					Events.echoEvent(ADTabpanel.ON_POST_INIT_EVENT, adtabpanel, null);
				}
			}				
		}
		else
		{
		    newTabpanel.refresh();
		}

		if (adTabbox.getSelectedTabpanel() instanceof ADSortTab)
		{
			((ADSortTab)adTabbox.getSelectedTabpanel()).registerAPanel(this);
		}
		else
		{
			if (adTabbox.getSelectedGridTab().getRowCount() == 0 && Env.isAutoNew(ctx, getWindowNo()))
			{
				onNew();
			}
		}

		updateToolbar();

		breadCrumb.setNavigationToolbarVisibility(!adTabbox.getSelectedGridTab().isSortTab());

		if (callback != null)
			callback.onCallback(true);
	}
	
	private void updateToolbar()
	{
		toolbar.enableTabNavigation(breadCrumb.hasParentLink(), adTabbox.getSelectedDetailADTabpanel() != null);

		toolbar.setPressed("Attachment",adTabbox.getSelectedGridTab().hasAttachment());
		toolbar.setPressed("PostIt",adTabbox.getSelectedGridTab().hasPostIt());
		toolbar.setPressed("Chat",adTabbox.getSelectedGridTab().hasChat());

		if (toolbar.isPersonalLock)
		{
			toolbar.lock(adTabbox.getSelectedGridTab().isLocked());
		}

		toolbar.enablePrint(adTabbox.getSelectedGridTab().isPrinted() && !adTabbox.getSelectedGridTab().isNew());

		toolbar.enableQuickForm(adTabbox.getSelectedTabpanel().isEnableQuickFormButton() && !adTabbox.getSelectedGridTab().isReadOnly());

		boolean isNewRow = adTabbox.getSelectedGridTab().getRowCount() == 0 || adTabbox.getSelectedGridTab().isNew();
        
		IADTabpanel adtab = adTabbox.getSelectedTabpanel();
        toolbar.enableProcessButton(adtab != null && adtab.isEnableProcessButton());
        toolbar.enableCustomize(adtab.isEnableCustomizeButton());
        
		toolbar.setPressed("Find",adTabbox.getSelectedGridTab().isQueryActive() || 
				(!isNewRow && (m_onlyCurrentRows || m_onlyCurrentDays > 0)));
		
		toolbar.refreshUserQuery(adTabbox.getSelectedGridTab().getAD_Tab_ID(), getCurrentFindWindow() != null ? getCurrentFindWindow().getAD_UserQuery_ID() : 0);

		// update from customized implementation
		adtab.updateToolbar(toolbar);
	}

	/**
	 * @param e
	 * @see DataStatusListener#dataStatusChanged(DataStatusEvent)
	 */
    public void dataStatusChanged(DataStatusEvent e)
    {
    	//ignore non-ui thread event.
    	if (Executions.getCurrent() == null)
    		return;

    	boolean detailTab = false;
    	if (e.getSource() instanceof GridTable)
    	{
    		GridTable gridTable = (GridTable) e.getSource();
    		if (adTabbox.getSelectedGridTab() != null && adTabbox.getSelectedGridTab().getTableModel() != gridTable) {
    			detailTab = true;
    		}
    	} else if (e.getSource() instanceof GridTab)
    	{
    		GridTab gridTab = (GridTab)e.getSource();
    		if (adTabbox.getSelectedGridTab() != gridTab) detailTab = true;
    	}

        String adInfo = e.getAD_Message();
        if (   adInfo == null
        	|| GridTab.DEFAULT_STATUS_MESSAGE.equals(adInfo)
        	|| GridTable.DATA_REFRESH_MESSAGE.equals(adInfo)
        	|| GridTable.DATA_INSERTED_MESSAGE.equals(adInfo)
        	|| GridTable.DATA_IGNORED_MESSAGE.equals(adInfo)
        	|| GridTable.DATA_UPDATE_COPIED_MESSAGE.equals(adInfo)
        	|| GridTable.DATA_SAVED_MESSAGE.equals(adInfo)
           ) {

	        String prefix = null;
	        if (adTabbox.needSave(true, false) ||
        		adTabbox.getSelectedGridTab().isNew() ||
        		(adTabbox.getSelectedDetailADTabpanel() != null && adTabbox.getSelectedDetailADTabpanel().getGridTab().isNew())) {
	        	// same condition as enableSave below
	        	prefix = "*";
	        }

	        String titleLogic = null;
	        int windowID = getADTab().getSelectedGridTab().getAD_Window_ID();
	        if (windowID > 0) {
	        	titleLogic = MWindow.get(Env.getCtx(), windowID).getTitleLogic();
	        }
	        String header = null;
	        if (! Util.isEmpty(titleLogic)) {
		        StringBuilder sb = new StringBuilder();
		        if (prefix != null)
		        	sb.append(prefix);
				sb.append(Env.getContext(ctx, curWindowNo, "_WinInfo_WindowName", false)).append(": ");
				if (titleLogic.contains("<")) {
					// IDEMPIERE-1328 - enable using format or subcolumns on title
					if (   getADTab() != null
						&& getADTab().getADTabpanel(0) != null
						&& getADTab().getADTabpanel(0).getGridTab() != null
						&& getADTab().getADTabpanel(0).getGridTab().getTableModel() != null) {
						GridTab tab = getADTab().getADTabpanel(0).getGridTab();
						int row = tab.getCurrentRow();
						int cnt = tab.getRowCount();
						boolean inserting = tab.getTableModel().isInserting();
						if (row >= 0 && cnt > 0 && !inserting) {
							PO po = tab.getTableModel().getPO(row);
							titleLogic = Env.parseVariable(titleLogic, po, null, false);
						} else {
							titleLogic = Env.parseContext(Env.getCtx(), curWindowNo, titleLogic, false, true);
						}
					}
				} else {
					titleLogic = Env.parseContext(Env.getCtx(), curWindowNo, titleLogic, false, true);
				}
        		sb.append(titleLogic);
        		header = sb.toString().trim();
        		if (header.endsWith(":"))
        			header = header.substring(0, header.length()-1);
	        }
	        if (Util.isEmpty(header))
	        	header = AEnv.getDialogHeader(Env.getCtx(), curWindowNo, prefix);

	        SessionManager.getAppDesktop().setTabTitle(header, curWindowNo);
        }

    	if (!detailTab)
    	{
	        String dbInfo = e.getMessage();
	        if (logger.isLoggable(Level.INFO)) logger.info(dbInfo);
	        if (adTabbox.getSelectedGridTab() != null && adTabbox.getSelectedGridTab().isQueryActive())
	            dbInfo = "[ " + dbInfo + " ]";
	        breadCrumb.setStatusDB(dbInfo, e, adTabbox.getSelectedGridTab());
    	}
    	else if (adTabbox.getSelectedDetailADTabpanel() == null)
    	{
    		return;
    	}

        //  Set Message / Info
        if (e.getAD_Message() != null || e.getInfo() != null)
        {
        	if (GridTab.DEFAULT_STATUS_MESSAGE.equals(e.getAD_Message()))
        	{
        		if (detailTab) {
        			String msg = e.getTotalRows() + " " + Msg.getMsg(Env.getCtx(), "Records");
                	adTabbox.setDetailPaneStatusMessage(msg, false);
				} else {
					if (getActiveGridTab().isQuickForm)
					{
						statusBarQF.setStatusLine("", false);
					}
					else
					{
						statusBar.setStatusLine("", false);
					}
				}
        	}
        	else
        	{
	            StringBuilder sb = new StringBuilder();
	            String msg = e.getMessage();
	            StringBuilder adMessage = new StringBuilder();
	            String origmsg = null;
	            if (msg != null && msg.length() > 0)
	            {
	            	if (detailTab && GridTable.DATA_REFRESH_MESSAGE.equals(e.getAD_Message()))
	            	{
	            		origmsg = e.getTotalRows() + " " + Msg.getMsg(Env.getCtx(), "Records");
	            	}
	            	else
	            	{
	            		origmsg = Msg.getMsg(Env.getCtx(), e.getAD_Message());
	            	}
	            	adMessage.append(origmsg);
	            }
	            String info = e.getInfo();
	            if (info != null && info.length() > 0)
	            {
	            	Object[] arguments = info.split("[;]");
	            	int index = 0;
	            	while(index < arguments.length)
	            	{
	            		String expr = "{"+index+"}";
	            		if (adMessage.indexOf(expr) >= 0)
	            		{
	            			index++;
	            		}
	            		else
	            		{
	            			break;
	            		}
	            	}
	            	if (index < arguments.length)
	            	{
	            		if (adMessage.length() > 0 && !adMessage.toString().trim().endsWith(":"))
		                    adMessage.append(": ");
	            		StringBuilder tail = new StringBuilder();
	            		while(index < arguments.length)
	            		{
	            			if (tail.length() > 0) tail.append(", ");
	            			tail.append("{").append(index).append("}");
	            			index++;
	            		}
	            		adMessage.append(tail);
	            	}
					if (   arguments.length == 1 
						&& origmsg != null 
						&& origmsg.equals(arguments[0])) { // check dup message
		            	sb.append(origmsg);
					} else {
		            	String adMessageQuot = Util.replace(adMessage.toString(), "'", "''");
				sb.append(new MessageFormat(adMessageQuot, Env.getLanguage(Env.getCtx()).getLocale()).format(arguments));
	            	}
	            }
	            else
	            {
	            	sb.append(adMessage);
	            }
	            if (sb.length() > 0)
	            {
	                int pos = sb.indexOf("\n");
	                if (pos != -1 && pos+1 < sb.length())  // replace CR/NL
	                {
	                    sb.replace(pos, pos+1, " - ");
	            	}
	                if (detailTab) {
	                	adTabbox.setDetailPaneStatusMessage(sb.toString (), e.isError ());
	                } else {
	                	if (getActiveGridTab().isQuickForm)
						{
	                		statusBarQF.setStatusLine(sb.toString(), e.isError());
						}
						else
						{
							statusBar.setStatusLine(sb.toString(), e.isError());
						}
	                }
	            }
        	}
        }

        IADTabpanel tabPanel = detailTab ? adTabbox.getSelectedDetailADTabpanel()
    			: getADTab().getSelectedTabpanel();

        //  Confirm Error
        if (e.isError() && !e.isConfirmed() && tabPanel instanceof ADTabpanel)
        {
        	//focus to error field
        	GridField[] fields = tabPanel.getGridTab().getFields();
        	for (GridField field : fields)
        	{
        		if (field.isError())
        		{
        			((ADTabpanel)tabPanel).setFocusToField(field.getColumnName());
        			break;
        		}
        	}
            e.setConfirmed(true);   //  show just once - if MTable.setCurrentRow is involved the status event is re-issued
        }
        //  Confirm Warning
        else if (e.isWarning() && !e.isConfirmed())
        {
        	boolean isImporting = false; 
        	if (e.getSource() instanceof GridTab) {
        		GridTab gridTab = (GridTab)e.getSource();
        		isImporting = gridTab.getTableModel().isImporting();
        	} else if (e.getSource() instanceof GridTable) {
        		GridTable gridTable = (GridTable) e.getSource();
        		isImporting = gridTable.isImporting();
        	}
        	if (!isImporting) {
        		Dialog.warn(curWindowNo, e.getAD_Message(), e.getInfo());
        		e.setConfirmed(true);   //  show just once - if MTable.setCurrentRow is involved the status event is re-issued
        	}
        }

        boolean changed = e.isChanged() || e.isInserting();
        boolean readOnly = adTabbox.getSelectedGridTab().isReadOnly();
        boolean processed = adTabbox.getSelectedGridTab().isProcessed();
        boolean insertRecord = !readOnly;
        boolean deleteRecord = !readOnly;
        if (!detailTab)
        {
	        if (insertRecord)
	        {
	            insertRecord = tabPanel.getGridTab().isInsertRecord();
	        }
	        toolbar.enableNew(!changed && insertRecord && !tabPanel.getGridTab().isSortTab());
	        toolbar.enableCopy(!changed && insertRecord && !tabPanel.getGridTab().isSortTab() && adTabbox.getSelectedGridTab().getRowCount()>0);
	        toolbar.enableRefresh(!changed);
	        if (deleteRecord)
	        {
	        	deleteRecord = tabPanel.getGridTab().isDeleteRecord();
	        }
	        toolbar.enableDelete(!changed && deleteRecord && !tabPanel.getGridTab().isSortTab() && !processed);
	        //
	        if (readOnly && adTabbox.getSelectedGridTab().isAlwaysUpdateField())
	        {
	            readOnly = false;
	        }
        }
        else
        {
        	adTabbox.updateDetailPaneToolbar(changed, readOnly);
        }
        boolean isEditting = adTabbox.needSave(true, false) ||
        		adTabbox.getSelectedGridTab().isNew() ||
        		(adTabbox.getSelectedDetailADTabpanel() != null && adTabbox.getSelectedDetailADTabpanel().getGridTab().isNew());
        toolbar.enableIgnore(isEditting);
        
        switchEditStatus (isEditting);
        
        if (changed && !readOnly && !toolbar.isSaveEnable() ) {
        	if (tabPanel.getGridTab().getRecord_ID() > 0) {
            	if (adTabbox.getSelectedIndex() == 0 && !detailTab) {
            		MRecentItem.addModifiedField(ctx, adTabbox.getSelectedGridTab().getAD_Table_ID(),
            				adTabbox.getSelectedGridTab().getRecord_ID(), Env.getAD_User_ID(ctx),
            				Env.getAD_Role_ID(ctx), adTabbox.getSelectedGridTab().getAD_Window_ID(),
            				adTabbox.getSelectedGridTab().getAD_Tab_ID());
            	} else {
	        		GridTab mainTab = getMainTabAbove();
	        		if (mainTab != null) {
			        	MRecentItem.addModifiedField(ctx, mainTab.getAD_Table_ID(),
			        			mainTab.getRecord_ID(), Env.getAD_User_ID(ctx),
			        			Env.getAD_Role_ID(ctx), mainTab.getAD_Window_ID(),
			        			mainTab.getAD_Tab_ID());
	        		}
            	}
        	}
        }

        toolbar.enableSave(adTabbox.needSave(true, false) ||
        		adTabbox.getSelectedGridTab().isNew() ||
        		(adTabbox.getSelectedDetailADTabpanel() != null && adTabbox.getSelectedDetailADTabpanel().getGridTab().isNew()));

        if (!e.isError() && Util.isEmpty(adInfo)) {
        	autoSaveChanges(e);
        }
        
        //
        //  No Rows
        if (e.getTotalRows() == 0 && insertRecord && !detailTab && !tabPanel.getGridTab().isSortTab())
        {
            toolbar.enableNew(true);
            toolbar.enableCopy(false);
            toolbar.enableDelete(false);
        }

        //  Transaction info
        if (!detailTab)
        {
        	GridTab gt = adTabbox.getSelectedGridTab();
	        String trxInfo = gt.getStatusLine();
	        if (trxInfo == null)
	        	trxInfo = "";
            statusBar.setInfo(trxInfo);
	        SessionManager.getAppDesktop().updateHelpQuickInfo(gt);
        }

	    //  Check Attachment
        boolean canHaveAttachment = adTabbox.getSelectedGridTab().canHaveAttachment();       //  not single _ID column
        //
        if (canHaveAttachment && e.isLoading() &&
                adTabbox.getSelectedGridTab().getCurrentRow() > e.getLoadedRows())
        {
            canHaveAttachment = false;
        }
        if (canHaveAttachment && adTabbox.getSelectedGridTab().getRecord_ID() == -1)    //   No Key
        {
            canHaveAttachment = false;
        }
        if (canHaveAttachment)
        {
            toolbar.enableAttachment(true);
            toolbar.setPressed("Attachment",adTabbox.getSelectedGridTab().hasAttachment());
        }
        else
        {
            toolbar.enableAttachment(false);
        }

        // Check Chat and PostIt
        boolean canHaveChat = true;
        if (e.isLoading() &&
                adTabbox.getSelectedGridTab().getCurrentRow() > e.getLoadedRows())
        {
            canHaveChat = false;
        }
        if (canHaveChat && adTabbox.getSelectedGridTab().getRecord_ID() == -1)    //   No Key
        {
            canHaveChat = false;
        }
        if (canHaveChat)
        {
            toolbar.enableChat(true);
            toolbar.setPressed("Chat",adTabbox.getSelectedGridTab().hasChat());
            toolbar.enablePostIt(true);
            toolbar.setPressed("PostIt",adTabbox.getSelectedGridTab().hasPostIt());
            toolbar.enableLabel(true);
            toolbar.setPressed("Label",adTabbox.getSelectedGridTab().hasLabel());
        }
        else
        {
        	toolbar.enableChat(false);
        	toolbar.enablePostIt(false);
        	toolbar.enableLabel(false);
        }

        // Elaine 2008/12/05
        //  Lock Indicator
        if (toolbar.isPersonalLock)
        {
			toolbar.lock(adTabbox.getSelectedGridTab().isLocked());
        }
        //

        if (!detailTab) 
        {
        	adTabbox.evaluate(e);
        }
        
		int record_ID = adTabbox.getSelectedGridTab().getRecord_ID();

        if (adTabbox.getSelectedGridTab().getTabLevel() == 0 && record_ID != masterRecord) {
        	clenFindWindowHashMap();
        	masterRecord = record_ID;
        }

        boolean isNewRow = adTabbox.getSelectedGridTab().getRowCount() == 0 || adTabbox.getSelectedGridTab().isNew();
        toolbar.enableArchive(!isNewRow);
        toolbar.enableZoomAcross(!isNewRow);
        toolbar.enableActiveWorkflows(!isNewRow);
        toolbar.enableRequests(!isNewRow);
		toolbar.setPressed("Find", adTabbox.getSelectedGridTab().isQueryActive() || 
				(!isNewRow && (m_onlyCurrentRows || m_onlyCurrentDays > 0)));
		/*if (adTabbox.getSelectedGridTab().isQueryActive() && 
				tabFindWindowHashMap.get(adTabbox.getSelectedGridTab()) != null) 
			findWindow = tabFindWindowHashMap.get(adTabbox.getSelectedGridTab());*/
		toolbar.refreshUserQuery(adTabbox.getSelectedGridTab().getAD_Tab_ID(), getCurrentFindWindow() != null ? getCurrentFindWindow().getAD_UserQuery_ID() : 0);

        toolbar.enablePrint(adTabbox.getSelectedGridTab().isPrinted() && !isNewRow);
        toolbar.enableReport(!isNewRow);
        toolbar.enableExport(!isNewRow && !adTabbox.getSelectedGridTab().isSortTab());
        toolbar.enableFileImport(toolbar.isNewEnabled());
		toolbar.enableCSVImport(toolbar.isNewEnabled() && adTabbox.getSelectedGridTab().hasTemplate());
        
        toolbar.enableTabNavigation(breadCrumb.hasParentLink(), adTabbox.getSelectedDetailADTabpanel() != null);
        
        IADTabpanel adtab = adTabbox.getSelectedTabpanel();
        toolbar.enableProcessButton(adtab != null && adtab.isEnableProcessButton());
        toolbar.enableCustomize(adtab.isEnableCustomizeButton());

    }

	private synchronized void autoSaveChanges(DataStatusEvent e) {		
		if (!e.isInitEdit() && toolbar.isSaveEnable() && MSysConfig.getBooleanValue(MSysConfig.ZK_AUTO_SAVE_CHANGES, false, Env.getAD_Client_ID(Env.getCtx()))) {
        	final IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
        	if (dirtyTabpanel != null && !dirtyTabpanel.getGridTab().isSortTab() 
        		&& Util.isEmpty(dirtyTabpanel.getGridTab().getCommitWarning(), true)
        		&& Env.isAutoCommit(ctx, curWindowNo)) {
        		if (dirtyTabpanel.getGridTab().isNeedSaveAndMandatoryFill()) {
            		String tabsExcluded = MSysConfig.getValue(MSysConfig.ZK_AUTO_SAVE_TABS_EXCLUDED, Env.getAD_Client_ID(Env.getCtx()));
            		boolean isTabExcluded = false;
            		if (!Util.isEmpty(tabsExcluded)) {
            			String tabID = String.valueOf(dirtyTabpanel.getGridTab().getAD_Tab_ID());
            			String tabUU = dirtyTabpanel.getGridTab().getAD_Tab_UU();
            			for (String excl : tabsExcluded.split(",")) {
           					if (excl.equals(tabID) || excl.equals(tabUU)) {
           						isTabExcluded = true;
            				}
            			}
            		}
            		if (!isTabExcluded) {
            			//sleep needed for onClose to show confirmation dialog
            			try {
    						Thread.sleep(200);
    					} catch (InterruptedException e2) {
    					}
            			if (!showingOnExitDialog)
            				Executions.schedule(getComponent().getDesktop(), e1 -> asyncAutoSave(), new Event("onAutoSave"));
            		}
        		}
        	}
        }
	}

	private synchronized void asyncAutoSave() {
		//ensure still dirty and can save
		if (toolbar.isSaveEnable() && !showingOnExitDialog) {
        	final IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
        	if (dirtyTabpanel != null && dirtyTabpanel.getGridTab().isNeedSaveAndMandatoryFill()) {
        		onSave(false, false, null);
        	}
        }
	}
	
    /**
     * @return boolean
     */
    public boolean isFirstTab()
    {
        int selTabIndex = adTabbox.getSelectedIndex();
        return (selTabIndex == 0);
    }

    /**
     * refresh all row
     * @param fireEvent
     */
    public void onRefresh(final boolean fireEvent)
    {
    	onRefresh(fireEvent, true);
    }

    /**
     * refresh all row
     * @param fireEvent
     * @param saveCurrentRow
     */
    public void onRefresh(final boolean fireEvent, final boolean saveCurrentRow)
    {
    	if (saveCurrentRow)
    	{
	    	onSave(false, true, new Callback<Boolean>() {

				@Override
				public void onCallback(Boolean result) {
					doOnRefresh(fireEvent);
				}
			});
    	}
    	else
    	{
    		doOnRefresh(fireEvent);
    	}
    }

	/**
	 * @param fireEvent
	 */
	protected void doOnRefresh(final boolean fireEvent) {		
		IADTabpanel headerTab = adTabbox.getSelectedTabpanel();
		IADTabpanel detailTab = adTabbox.getSelectedDetailADTabpanel();
		try {
			adTabbox.getSelectedGridTab().dataRefreshAll(fireEvent, true);			
		} catch (Exception e) {			
			if (DBException.isTimeout(e)) {
				Dialog.error(getWindowNo(), "GridTabLoadTimeoutError");
			} else {
				Dialog.error(getWindowNo(), "Error", e.getMessage());
				logger.log(Level.SEVERE, e.getMessage(), e);
			}
			adTabbox.getSelectedGridTab().reset();
			return;
		}
		
		adTabbox.getSelectedGridTab().refreshParentTabs();		
		headerTab.dynamicDisplay(0);
		if (detailTab != null)
		{
			detailTab.dynamicDisplay(0);
		}
		focusToActivePanel();
		// IDEMPIERE-1328 - refresh recent item after running a process, i.e. completing a doc that changes documentno
    	MRecentItem.touchUpdatedRecord(ctx, adTabbox.getSelectedGridTab().getAD_Table_ID(),
    			adTabbox.getSelectedGridTab().getRecord_ID(), Env.getAD_User_ID(ctx));
	}

    /**
     * @see ToolbarListener#onRefresh()
     */
    public void onRefresh()
    {
    	GridTab gridTab = adTabbox.getSelectedGridTab();
    	/*if (gridTab != null && gridTab.getTableModel() != null)
    	{
    		gridTab.getTableModel().resetCacheSortState();
    	}
    	Column sortColumn = findCurrentSortColumn();*/
    	onRefresh(true, false);
    	/*if (sortColumn != null)
    	{
    		sortColumn.setSortDirection("natural");
    	}*/
    	if (gridTab.isSortTab()) { // refresh is not refreshing sort tabs
    		IADTabpanel tabPanel = adTabbox.getSelectedTabpanel();
    		tabPanel.query(false, 0, 0);
    	}
    }
/*
    private Column findCurrentSortColumn() {
		IADTabpanel iadtabpanel = getADTab().getSelectedTabpanel();
		if (iadtabpanel instanceof ADTabpanel) {
			ADTabpanel adtabpanel = (ADTabpanel) iadtabpanel;
			Grid grid = adtabpanel.getGridView().getListbox();
			Columns columns = grid.getColumns();
			if (columns != null) {
				List<?> list = columns.getChildren();
				for(int i = 0; i < list.size(); i++)
				{
					Component c = (Component) list.get(i);
					if (c instanceof Column) {
						Column column = (Column) c;
						if (!"natural".equals(column.getSortDirection())) {
							return column;
						}
					}
				}
			}
		}
		return null;
	}
*/
    /**
     * @see ToolbarListener#onHelp()
     */
    public void onHelp()
    {	
    	closeToolbarPopup("Help");
    	SessionManager.getAppDesktop().showWindow(new HelpWindow(gridWindow), "center");    	    
    }

    @Override
    public void onNew()
    {
    	final Callback<Boolean> postCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.AFTER_NEW.getName());
			    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, null);
				}
			}
		};
    	Callback<Boolean> preCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					onNewCallback(postCallback);
				}
			}
		};
		
		WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.BEFORE_NEW.getName());
    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, preCallback);
    }
    
    private void onNewCallback(final Callback<Boolean> postCallback)
    {
        if (!adTabbox.getSelectedGridTab().isInsertRecord())
        {
            logger.warning("Insert Record disabled for Tab");
            if (postCallback != null)
            	postCallback.onCallback(false);
            return;
        }

        saveAndNavigate(new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result)
				{
					boolean newRecord = adTabbox.getSelectedGridTab().dataNew(false);
			        if (newRecord)
			        {
			            adTabbox.getSelectedTabpanel().dynamicDisplay(0);
			            toolbar.enableNew(false);
			            toolbar.enableCopy(false);
			            toolbar.enableDelete(false);
			            breadCrumb.enableFirstNavigation(adTabbox.getSelectedGridTab().getCurrentRow() > 0);
			            breadCrumb.enableLastNavigation(adTabbox.getSelectedGridTab().getCurrentRow() + 1 < adTabbox.getSelectedGridTab().getRowCount());
			            toolbar.enableTabNavigation(breadCrumb.hasParentLink(), adTabbox.getSelectedDetailADTabpanel() != null);
			            toolbar.enableIgnore(true);
			            if (adTabbox.getSelectedGridTab().isSingleRow()) 
			            {
			            	if (adTabbox.getSelectedTabpanel().isGridView())
			            	{
			            		adTabbox.getSelectedTabpanel().switchRowPresentation();
			            	}
			            }
			            
			            if (adTabbox.getSelectedTabpanel().isGridView())
			            {
			            	adTabbox.getSelectedTabpanel().getGridView().onEditCurrentRow();
			            }
			            if (postCallback != null)
			            	postCallback.onCallback(true);
			        }
			        else
			        {
			            logger.severe("Could not create new record");
			            if (postCallback != null)
			            	postCallback.onCallback(false);
			        }
			        focusToActivePanel();
				}
				else
				{
					if (postCallback != null)
		            	postCallback.onCallback(result);
				}
			}
		});
    }

    @Override
    public void onCopy()
    {
    	final Callback<Boolean> postCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.AFTER_COPY.getName());
			    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, null);
				}
			}
		};
    	Callback<Boolean> preCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					onCopyCallback(postCallback);
				}
			}
		};
		
		WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.BEFORE_COPY.getName());
    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, preCallback);
    }
    
	// Elaine 2008/11/19
    private void onCopyCallback(Callback<Boolean> postCallback)
    {
        if (!adTabbox.getSelectedGridTab().isInsertRecord())
        {
            logger.warning("Insert Record disabled for Tab");
            if (postCallback != null)
            	postCallback.onCallback(false);
            return;
        }

        boolean newRecord = adTabbox.getSelectedGridTab().dataNew(true);
        if (newRecord)
        {
            adTabbox.getSelectedTabpanel().dynamicDisplay(0);
            toolbar.enableNew(false);
            toolbar.enableCopy(false);
            toolbar.enableDelete(false);
            breadCrumb.enableFirstNavigation(adTabbox.getSelectedGridTab().getCurrentRow() > 0);
            breadCrumb.enableLastNavigation(adTabbox.getSelectedGridTab().getCurrentRow() + 1 < adTabbox.getSelectedGridTab().getRowCount());
            toolbar.enableTabNavigation(false);
            toolbar.enableIgnore(true);
            if (postCallback != null)
            	postCallback.onCallback(true);
            
        }
        else
        {
            logger.severe("Could not create new record");
            if (postCallback != null)
            	postCallback.onCallback(false);
        }
        focusToActivePanel();
    }
    //

    /**
     * @see ToolbarListener#onFind()
     */
    public void onFind()
    {
        if (adTabbox.getSelectedGridTab() == null)
            return;

        clearTitleRelatedContext();
        
        // The record was not changed locally
        if (adTabbox.getDirtyADTabpanel() == null) {
        	doOnFind();
        } else {
            onSave(false, false, new Callback<Boolean>() {
    			@Override
    			public void onCallback(Boolean result) {
    				if (result) {
    					doOnFind();
    				}
    			}
    		});        	
        }
    }

	private void doOnFind() {
		//  Gets Fields from AD_Field_v
        GridField[] findFields = adTabbox.getSelectedGridTab().getFields();
        if (!isCurrentFindWindowValid()) {
        	if (!getFindWindow(findFields))
        		return;
        }

        if (!getCurrentFindWindow().getEventListeners(DialogEvents.ON_WINDOW_CLOSE).iterator().hasNext()) {
        	getCurrentFindWindow().addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					hideBusyMask();
					if (!getCurrentFindWindow().isCancel())
			        {
				        MQuery query = getCurrentFindWindow().getQuery();

				        //  Confirmed query
				        if (query != null)
				        {
				            m_onlyCurrentRows = false;          //  search history too
				            adTabbox.getSelectedGridTab().setQuery(query);
				            adTabbox.getSelectedTabpanel().query(m_onlyCurrentRows, m_onlyCurrentDays, adTabbox.getSelectedGridTab().getMaxQueryRecords());   //  autoSize
				        }

				        if (getCurrentFindWindow().isCreateNew())
				        	onNew();
				        else {
				        	adTabbox.getSelectedGridTab().dataRefresh(false); // Elaine 2008/07/25

				        	if (!adTabbox.getSelectedTabpanel().isGridView()) { // See if we should force the grid view

				        		boolean forceGridView = false;
				        		String up = Env.getContext(Env.getCtx(), MUserPreference.COLUMNNAME_ViewFindResult);

				        		if (up.equals(MUserPreference.VIEWFINDRESULT_Default)) {
				        			forceGridView = MSysConfig.getBooleanValue(ZK_GRID_AFTER_FIND, false, Env.getAD_Client_ID(Env.getCtx()));
				        		}
				        		else if (up.equals(MUserPreference.VIEWFINDRESULT_AlwaysInGridView)) {
				        			forceGridView = true;
				        		}
				        		else if (up.equals(MUserPreference.VIEWFINDRESULT_AccordingToThreshold)) {
				        			forceGridView = adTabbox.getSelectedTabpanel().getGridTab().getRowCount() >= Env.getContextAsInt(Env.getCtx(), MUserPreference.COLUMNNAME_GridAfterFindThreshold);
				        		}

				        		if (forceGridView)
				        			adTabbox.getSelectedTabpanel().switchRowPresentation();
				        	}
				        }
				        toolbar.refreshUserQuery(adTabbox.getSelectedGridTab().getAD_Tab_ID(), getCurrentFindWindow().getAD_UserQuery_ID());
				        focusToActivePanel();
			        }
					else
					{
						toolbar.setPressed("Find",adTabbox.getSelectedGridTab().isQueryActive());
						focusToLastFocusEditor();
					}
			        
				}
			});
        }

        getComponent().getParent().appendChild(getCurrentFindWindow());
        showBusyMask(getCurrentFindWindow());                
        LayoutUtils.openEmbeddedWindow(toolbar, getCurrentFindWindow(), "after_start");
	}
	
	/**
	 * Validates if the current FindWindow corresponds to the actve tab and record  
	 * @return true if the current find window is good to use
	 */
	private boolean isCurrentFindWindowValid() {
        GridField[] findFields = adTabbox.getSelectedGridTab().getFields();
		return getCurrentFindWindow() != null && getCurrentFindWindow().validate(adTabbox.getSelectedGridTab().getWindowNo(), 
				adTabbox.getSelectedGridTab().getName(),
	            adTabbox.getSelectedGridTab().getAD_Table_ID(), 
	            adTabbox.getSelectedGridTab().getTableName(),
	            adTabbox.getSelectedGridTab().getWhereExtended(), 
	            findFields, 
	            1, 
	            adTabbox.getSelectedGridTab().getAD_Tab_ID());
	}

	@Override
	public void onIgnore() 
	{
    	final Callback<Boolean> postCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.AFTER_IGNORE.getName());
			    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, null);
				}
			}
		};
    	Callback<Boolean> preCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					onIgnoreCallback(postCallback);
				}
			}
		};
		
		WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.BEFORE_IGNORE.getName());
    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, preCallback);
    }
	
    private void onIgnoreCallback(Callback<Boolean> postCallback)
    {
    	IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
    	boolean newrecod = adTabbox.getSelectedGridTab().isNew();
    	if (dirtyTabpanel != null && dirtyTabpanel.getGridTab().isSortTab())
    	{
    		adTabbox.dataIgnore();
    		toolbar.enableIgnore(false);
    	}
    	else
    	{
    		clearTitleRelatedContext();

	        adTabbox.dataIgnore();
	        toolbar.enableIgnore(false);
	        if (newrecod) {
	        	onRefresh(true, false);
	        } else if (dirtyTabpanel != null) {
	        	dirtyTabpanel.getGridTab().dataRefresh(true);	// update statusbar & toolbar
	        	dirtyTabpanel.dynamicDisplay(0);
	        } else {
	        	onRefresh(true, false);
	        }

    	}
    	if (dirtyTabpanel != null) {
    		focusToTabpanel(dirtyTabpanel);
    		//ensure row indicator is not lost
    		if (dirtyTabpanel.getGridView() != null && 
    				dirtyTabpanel.getGridView().getListbox() != null &&
    				dirtyTabpanel.getGridView().getListbox().getRowRenderer() != null) {
        		RowRenderer<Object[]> renderer = dirtyTabpanel.getGridView().getListbox().getRowRenderer();
        		GridTabRowRenderer gtr = (GridTabRowRenderer)renderer;
        		org.zkoss.zul.Row row = gtr.getCurrentRow();
        		if (row != null)
        			gtr.setCurrentRow(row);    			
    		}
    	}
    	else
    		focusToActivePanel();

    	updateToolbar();
    	
    	if (postCallback != null)
    		postCallback.onCallback(true);
    }

    /**
     * @see ToolbarListener#onSave()
     */
    @Override
    public void onSave()
    {
    	final IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
		onSave(true, false, new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result)
			{
				if (result)
				{
					String statusLine = null;
					if (getActiveGridTab().isQuickForm)
					{
						statusLine = statusBarQF.getStatusLine();
					}
					else
					{
						statusLine = statusBar.getStatusLine();
					}
					adTabbox.getSelectedGridTab().dataRefreshAll(true, true);
					adTabbox.getSelectedGridTab().refreshParentTabs();
					if (getActiveGridTab().isQuickForm)
					{
						statusBarQF.setStatusLine(statusLine);
					}
					else
					{
						statusBar.setStatusLine(statusLine);
					}
					if (adTabbox.getSelectedDetailADTabpanel() != null && adTabbox.getSelectedDetailADTabpanel().getGridTab() != null)
						adTabbox.getSelectedDetailADTabpanel().getGridTab().dataRefreshAll(true, true);
				}
				if (dirtyTabpanel != null) {
					if (dirtyTabpanel == adTabbox.getSelectedDetailADTabpanel())
						Clients.scrollIntoView(dirtyTabpanel);
					focusToTabpanel(dirtyTabpanel);
				} else {
					focusToActivePanel();
				}
				
				if(adTabbox.getSelectedGridTab().isQuickForm())
					onRefresh(true, true);
			}
		});
    }

    public void onSave(final boolean onSaveEvent, final boolean onNavigationEvent, final Callback<Boolean> callback) {
    	final Callback<Boolean> postCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.AFTER_SAVE.getName());
			    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, callback);
				} else if (callback != null) {
					callback.onCallback(result);
				}
			}
		};
		
    	Callback<Boolean> preCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					onSaveCallback(onSaveEvent, onNavigationEvent, postCallback);
				} else if (callback != null) {
					callback.onCallback(result);
				}
			}
		};
		
    	WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.BEFORE_SAVE.getName());
    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, preCallback);
	}

	public void onSavePayment()
    {
    	onSave(false, false, new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result) {
				onRefresh(true, false);
			}

		});
    }

    /**
     * @param onSaveEvent
     */
    private void onSaveCallback(final boolean onSaveEvent, final boolean onNavigationEvent, final Callback<Boolean> callback)
    {
    	final boolean wasChanged = toolbar.isSaveEnable();
    	IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
    	final boolean newRecord = dirtyTabpanel != null ? (dirtyTabpanel.getGridTab().isNew()) : adTabbox.getSelectedGridTab().isNew();
    	if (dirtyTabpanel == null) {
			onSave0(onSaveEvent, onNavigationEvent, newRecord, wasChanged, callback);
			return;
    	}
    	if (!Util.isEmpty(dirtyTabpanel.getGridTab().getCommitWarning()) ||
			(!Env.isAutoCommit(ctx, curWindowNo) && onNavigationEvent))
		{
			Dialog.ask(curWindowNo, "SaveChanges?", dirtyTabpanel.getGridTab().getCommitWarning(), new Callback<Boolean>() {

				@Override
				public void onCallback(Boolean result)
				{
					if (result)
					{
						onSave0(onSaveEvent, onNavigationEvent, newRecord, wasChanged, callback);
					}
					else
					{
						if (callback != null)
			    			callback.onCallback(false);
					}
				}
			});
		}
		else
		{
			onSave0(onSaveEvent, onNavigationEvent, newRecord, wasChanged, callback);
		}
    }

	private void onSave0(boolean onSaveEvent, boolean navigationEvent,
			boolean newRecord, boolean wasChanged, Callback<Boolean> callback) {
		IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
		boolean retValue = adTabbox.dataSave(onSaveEvent);

		if (!retValue)
		{
			if (CLogger.peekError() == null && ! wasChanged && callback != null) {
				callback.onCallback(true);
				return;
			}
			showLastError();
			if (callback != null)
				callback.onCallback(false);
			return;
		} else if (!onSaveEvent && dirtyTabpanel != null && !(dirtyTabpanel instanceof ADSortTab)) //need manual refresh
		{
			dirtyTabpanel.getGridTab().setCurrentRow(dirtyTabpanel.getGridTab().getCurrentRow());
		}

		if (!navigationEvent && dirtyTabpanel != null) {
			dirtyTabpanel.dynamicDisplay(0);
			dirtyTabpanel.afterSave(onSaveEvent);
		}

		IADTabpanel dirtyTabpanel2 = adTabbox.getDirtyADTabpanel();
		if (dirtyTabpanel2 != null && dirtyTabpanel2 != dirtyTabpanel) {
			onSave(onSaveEvent, navigationEvent, callback);
			return;
		} else if (dirtyTabpanel instanceof ADSortTab) {
			ADSortTab sortTab = (ADSortTab) dirtyTabpanel;
			if (!sortTab.isChanged()) {
				if (sortTab == adTabbox.getSelectedTabpanel()) {
					if (getActiveGridTab().isQuickForm)
					{
						statusBarQF.setStatusLine(Msg.getMsg(Env.getCtx(), "Saved"));
					}
					else
					{
						statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), "Saved"));
					}
				} else {
    				adTabbox.setDetailPaneStatusMessage(Msg.getMsg(Env.getCtx(), "Saved"), false);
    			}
    		}
		}

		if (wasChanged) {
		    if (newRecord) {
		    	if (adTabbox.getSelectedGridTab().getRecord_ID() > 0) {
		        	if (adTabbox.getSelectedIndex() == 0) {
			        	MRecentItem.addModifiedField(ctx, adTabbox.getSelectedGridTab().getAD_Table_ID(),
			        			adTabbox.getSelectedGridTab().getRecord_ID(), Env.getAD_User_ID(ctx),
			        			Env.getAD_Role_ID(ctx), adTabbox.getSelectedGridTab().getAD_Window_ID(),
			        			adTabbox.getSelectedGridTab().getAD_Tab_ID());
		        	} else {
		        		GridTab mainTab = getMainTabAbove();
		        		if (mainTab != null) {
				        	MRecentItem.addModifiedField(ctx, mainTab.getAD_Table_ID(),
				        			mainTab.getRecord_ID(), Env.getAD_User_ID(ctx),
				        			Env.getAD_Role_ID(ctx), mainTab.getAD_Window_ID(),
				        			mainTab.getAD_Tab_ID());
		        		}
		        	}
		    	}
		    } else {
		    	if (adTabbox.getSelectedIndex() == 0) {
		        	MRecentItem.touchUpdatedRecord(ctx, adTabbox.getSelectedGridTab().getAD_Table_ID(),
		        			adTabbox.getSelectedGridTab().getRecord_ID(), Env.getAD_User_ID(ctx));
		    	} else {
	        		GridTab mainTab = getMainTabAbove();
		    		if (mainTab != null) {
			        	MRecentItem.touchUpdatedRecord(ctx, mainTab.getAD_Table_ID(),
			        			mainTab.getRecord_ID(), Env.getAD_User_ID(ctx));
		    		}
		    	}
		    }
		}

		if (dirtyTabpanel != null && dirtyTabpanel != adTabbox.getSelectedTabpanel()) {
			Executions.getCurrent().setAttribute("adtabpane.saved", dirtyTabpanel);
			dirtyTabpanel.getGridTab().refreshParentTabs();
		}
		
		if (callback != null)
			callback.onCallback(true);
	}

	private GridTab getMainTabAbove() {
		/* when a detail record is modified add header to recent items */
		GridTab mainTab = adTabbox.getSelectedGridTab(); // find parent tab (IDEMPIERE-2125 - tbayen)
		while (mainTab != null && mainTab.getTabLevel() > 0) {
			GridTab parentTab = mainTab.getParentTab();
			if (parentTab == mainTab)
				break;
			mainTab = parentTab;
		}
		return mainTab;
	}

	private void showLastError() {
		String msg = CLogger.retrieveErrorString(null);
		if (msg != null)
		{
			if (getActiveGridTab().isQuickForm)
			{
				statusBarQF.setStatusLine(Msg.getMsg(Env.getCtx(), msg), true);
			}
			else
			{
				statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), msg), true);
			}
		}
		//other error will be catch in the dataStatusChanged event
	}

	private void showLastWarning() {
		String msg = CLogger.retrieveWarningString(null);
		if (msg != null)
		{
			statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), msg), true);
		}
	}

	/**
	 * @see ToolbarListener#onSaveCreate()
	 */
	public void onSaveCreate()
    {
    	onSave(true, true, new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result)
			{
				if(result)
		    	{
		    		adTabbox.getSelectedGridTab().dataRefreshAll(true, true);
		    		adTabbox.getSelectedGridTab().refreshParentTabs();
		    		IADTabpanel dirtyTabpanel = (IADTabpanel) Executions.getCurrent().removeAttribute("adtabpane.saved");
		    		if (dirtyTabpanel != null && dirtyTabpanel.getGridTab().isDetail()) {
		    			try {
							adTabbox.getSelectedTabpanel().getDetailPane().onNew();
						} catch (Exception e) {
							throw new RuntimeException(e);
						}
		    		} else {
		    			onNew();
		    		}
		    	}
			}
		});
    }

	@Override
	public void onDelete()
	{
		final Callback<Boolean> postCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.AFTER_DELETE.getName());
			    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, null);
				}
			}
		};
    	Callback<Boolean> preCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					onDeleteCallback(postCallback);
				}
			}
		};
		
		WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.BEFORE_DELETE.getName());
    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, preCallback);
	}
	
    private void onDeleteCallback(final Callback<Boolean> postCallback)
    {
        if (adTabbox.getSelectedGridTab().isReadOnly())
        {
        	if (postCallback != null)
        		postCallback.onCallback(false);
            return;
        }
        
        //delete selected if it is grid view and row selection
        final int[] indices = adTabbox.getSelectedGridTab().getSelection();
		if (indices.length > 0 && adTabbox.getSelectedTabpanel().isGridView())
		{
			onDeleteSelected(postCallback);
			return;
		}
		
		deleteConfirmationLogic = adTabbox.getSelectedGridTab().getDeleteConfirmationLogic();
		if(Util.isEmpty(deleteConfirmationLogic)) {
			Dialog.ask(curWindowNo, "DeleteRecord?", new Callback<Boolean>() {
				@Override
				public void onCallback(Boolean result)
				{
					if (result)
					{
			        	//error will be catch in the dataStatusChanged event
			            boolean success = adTabbox.getSelectedGridTab().dataDelete();
			            adTabbox.getSelectedGridTab().dataRefreshAll(true, true);
			    		adTabbox.getSelectedGridTab().refreshParentTabs();
			    		if (!success)
			    			showLastWarning();
	
			            adTabbox.getSelectedTabpanel().dynamicDisplay(0);
			            focusToActivePanel();
			            MRecentItem.publishChangedEvent(Env.getAD_User_ID(ctx));		           
					}
					if (postCallback != null)
						postCallback.onCallback(result);
				}
			});
		}
		else {
			int tableID = adTabbox.getSelectedGridTab().getAD_Table_ID();
			int recordID = adTabbox.getSelectedGridTab().getRecord_ID();
			deleteConfirmationLogic = FileUtil.parseTitle(ctx, deleteConfirmationLogic, tableID, recordID, curWindowNo, null);
			deleteConfirmationLogic = Msg.parseTranslation(ctx, deleteConfirmationLogic);
			
			WEditor editor = new WStringEditor();
			editor.fillHorizontal();
			editor.setValidInput(deleteConfirmationLogic);
			
			Dialog.askForInputTextConfirmation(curWindowNo, editor, "DeleteRecordWithConfirm?", new Object[] {deleteConfirmationLogic}, null, 
					new Callback<Map.Entry<Boolean, String>>() {
				@Override
				public void onCallback(Map.Entry<Boolean, String> result)
				{
					if(!result.getKey() || !(result.getValue() instanceof String))
						return;
						
					if(result.getValue().equals(deleteConfirmationLogic)) {
						boolean success = adTabbox.getSelectedGridTab().dataDelete();
			            adTabbox.getSelectedGridTab().dataRefreshAll(true, true);
			    		adTabbox.getSelectedGridTab().refreshParentTabs();
			    		if (!success)
			    			showLastWarning();
	
			            adTabbox.getSelectedTabpanel().dynamicDisplay(0);
			            focusToActivePanel();
			            MRecentItem.publishChangedEvent(Env.getAD_User_ID(ctx));
			            
					}
					if (postCallback != null)
						postCallback.onCallback(result.getValue().equals(deleteConfirmationLogic));
				}
			});		
		}
    }

    // Elaine 2008/12/01
    private void onDeleteSelected(final Callback<Boolean> postCallback)
	{
    	if (adTabbox.getSelectedGridTab().isReadOnly() || !adTabbox.getSelectedTabpanel().isGridView())
        {
    		if (postCallback != null)
    			postCallback.onCallback(false);
            return;
        }
    	deleteConfirmationLogic = adTabbox.getSelectedGridTab().getDeleteConfirmationLogic();
		final int[] indices = adTabbox.getSelectedGridTab().getSelection();
		if(indices.length > 0) {
			StringBuilder sb = new StringBuilder();
			sb.append(Env.getContext(ctx, curWindowNo, "_WinInfo_WindowName", false)).append(" - ")
				.append(indices.length).append(" ").append(Msg.getMsg(Env.getCtx(), "Selected"));
			if(Util.isEmpty(deleteConfirmationLogic)) {
				Dialog.ask(sb.toString(), curWindowNo,"DeleteSelection", new Callback<Boolean>() {
					@Override
					public void onCallback(Boolean result) {
						if(result){
							adTabbox.getSelectedGridTab().clearSelection();						
							Arrays.sort(indices);
							int offset = 0;
							int count = 0;
							for (int i = 0; i < indices.length; i++)
							{
								adTabbox.getSelectedGridTab().navigate(indices[i]-offset);
								if (adTabbox.getSelectedGridTab().dataDelete())
								{
									offset++;
									count++;
								}
							}
				            adTabbox.getSelectedGridTab().dataRefreshAll(true, true);
				    		adTabbox.getSelectedGridTab().refreshParentTabs();
							
							adTabbox.getSelectedTabpanel().dynamicDisplay(0);
							if (getActiveGridTab().isQuickForm)
							{
								statusBarQF.setStatusLine(Msg.getMsg(Env.getCtx(), "Deleted") + ": " + count, false);
							}
							else
							{
								statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), "Deleted") + ": " + count, false);
							}
						}
						if (postCallback != null)
							postCallback.onCallback(result);
					}
				});
			}
			else {
				deleteConfirmationLogic = Msg.getMsg(ctx, "DeleteSelection");
				
				WEditor editor = new WStringEditor();
				editor.fillHorizontal();
				editor.setValidInput(deleteConfirmationLogic);
				
				Dialog.askForInputTextConfirmation(curWindowNo, editor, "DeleteSelectionWithConfirm?", new String[] {Integer.toString(indices.length), deleteConfirmationLogic}, null, 
						new Callback<Map.Entry<Boolean, String>>() {
					@Override
					public void onCallback(Map.Entry<Boolean, String> result)
					{
						if(!result.getKey() || !(result.getValue() instanceof String))
							return;
							
						if(result.getValue().equals(deleteConfirmationLogic)) {
							adTabbox.getSelectedGridTab().clearSelection();						
							Arrays.sort(indices);
							int offset = 0;
							int count = 0;
							for (int i = 0; i < indices.length; i++)
							{
								adTabbox.getSelectedGridTab().navigate(indices[i]-offset);
								if (adTabbox.getSelectedGridTab().dataDelete())
								{
									offset++;
									count++;
								}
							}
				            adTabbox.getSelectedGridTab().dataRefreshAll(true, true);
				    		adTabbox.getSelectedGridTab().refreshParentTabs();
							
							adTabbox.getSelectedTabpanel().dynamicDisplay(0);
							if (getActiveGridTab().isQuickForm)
							{
								statusBarQF.setStatusLine(Msg.getMsg(Env.getCtx(), "Deleted") + ": " + count, false);
							}
							else
							{
								statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), "Deleted") + ": " + count, false);
							}
						}
						if (postCallback != null)
							postCallback.onCallback(result.getValue().equals(deleteConfirmationLogic));
					}
				});		
			}
		} else {
			if (getActiveGridTab().isQuickForm)
			{
				statusBarQF.setStatusLine(Msg.getMsg(Env.getCtx(), "Selected") + ": 0", false);
			}
			else
			{
				statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), "Selected") + ": 0", false);
			}
			if (postCallback != null)
				postCallback.onCallback(false);
		}
	}
	//

    @Override
    public void onPrint() {
    	closeToolbarPopup("Print");
    	final Callback<Boolean> postCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.AFTER_PRINT.getName());
			    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, null);
				}
			}
		};
    	Callback<Boolean> preCallback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					onPrintCallback(postCallback);
				}
			}
		};
		
		WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.BEFORE_PRINT.getName());
    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, preCallback);
    }
    
	private void onPrintCallback(final Callback<Boolean> postCallback) {
		//Get process defined for this tab
		final int AD_Process_ID = adTabbox.getSelectedGridTab().getAD_Process_ID();
		//log.info("ID=" + AD_Process_ID);

		//	No report defined
		if (AD_Process_ID == 0)
		{
			onReport();

			return;
		}

		Callback<Boolean> callback = new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) {
					int table_ID = adTabbox.getSelectedGridTab().getAD_Table_ID();
					int record_ID = adTabbox.getSelectedGridTab().getRecord_ID();

					final ProcessModalDialog dialog = new ProcessModalDialog(AbstractADWindowContent.this, getWindowNo(), AD_Process_ID,table_ID, record_ID, true);
					if (dialog.isValid()) {
						//dialog.setWidth("500px");
						dialog.setBorder("normal");						
						getComponent().getParent().appendChild(dialog);
						showBusyMask(dialog);
						LayoutUtils.openOverlappedWindow(getComponent(), dialog, "middle_center");
						if (postCallback != null) {
							dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
								@Override
								public void onEvent(Event event) throws Exception {
									postCallback.onCallback(!dialog.isCancel());
								}
							});
						}
						dialog.focus();
					} else if (postCallback != null) {
						postCallback.onCallback(result);
					}
				} else if (postCallback != null) {
					postCallback.onCallback(result);
				}
			}
		};
		onSave(false, false, callback);
	}

	/**
     * @see ToolbarListener#onReport()
     */
	public void onReport() {
		if (!MRole.getDefault().isCanReport(adTabbox.getSelectedGridTab().getAD_Table_ID()))
		{
			Dialog.error(curWindowNo, "AccessCannotReport");
			return;
		}

		Callback<Boolean> callback = new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result) {
				if (result) {
					onReport0();
				} else {
					focusToLastFocusEditor();
				}
			}
		};
		onSave(false, false, callback);
	}

	private void onReport0() {
		ReportAction reportAction = new ReportAction(this);
		reportAction.show();
	}

	/**
     * @see ToolbarListener#onZoomAcross()
     */
	public void onZoomAcross() {
		if (toolbar.getEvent() != null)
		{
			int record_ID = adTabbox.getSelectedGridTab().getRecord_ID();
			if (record_ID <= 0)
				return;

			//	Query
			MQuery query = new MQuery();
			//	Current row
			String link = adTabbox.getSelectedGridTab().getKeyColumnName();
			//	Link for detail records
			if (link.length() == 0)
				link = adTabbox.getSelectedGridTab().getLinkColumnName();
			if (link.length() != 0)
			{
				if (link.endsWith("_ID"))
					query.addRestriction(link, MQuery.EQUAL,
						Integer.valueOf(Env.getContextAsInt(ctx, curWindowNo, link)));
				else
					query.addRestriction(link, MQuery.EQUAL,
						Env.getContext(ctx, curWindowNo, link));
			}
			new WZoomAcross(toolbar.getToolbarItem("ZoomAcross"), adTabbox.getSelectedGridTab()
					.getTableName(), adTabbox.getSelectedGridTab().getAD_Window_ID(), query);
		}
	}

	// Elaine 2008/07/17
	/**
     * @see ToolbarListener#onActiveWorkflows()
     */
	public void onActiveWorkflows() {
		if (toolbar.getEvent() != null)
		{
			if (adTabbox.getSelectedGridTab().getRecord_ID() <= 0) {
				return;
			} else {
				closeToolbarPopup("ActiveWorkflows");
				try {
					AEnv.startWorkflowProcess(adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getRecord_ID());
				} catch (Exception e) {
					CLogger.get().saveError("Error", e);
					throw new ApplicationException(e.getMessage(), e);
				}
			}
		}
	}
	//

	private void closeToolbarPopup(String btnName) {
		LabelImageElement btn = toolbar.getToolbarItem(btnName);
		Popup popup = LayoutUtils.findPopup(btn.getParent());
		if (popup != null) {
			popup.close();
		}
	}

	// Elaine 2008/07/22
	/**
     * @see ToolbarListener#onRequests()
     */
	public void onRequests()
	{
		if (toolbar.getEvent() != null)
		{
			if (adTabbox.getSelectedGridTab().getRecord_ID() <= 0)
				return;

			int C_BPartner_ID = 0;
			Object bpartner = adTabbox.getSelectedGridTab().getValue("C_BPartner_ID");
			if(bpartner != null)
				C_BPartner_ID = Integer.valueOf(bpartner.toString());

			new WRequest(toolbar.getToolbarItem("Requests"), adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getRecord_ID(), C_BPartner_ID);
		}
	}
	//

	// Elaine 2008/07/22
	/**
     * @see ToolbarListener#onProductInfo()
     */
	public void onProductInfo()
	{
		closeToolbarPopup("ProductInfo");
		InfoPanel.showPanel(I_M_Product.Table_Name);
	}
	//


	// Elaine 2008/07/28
	/**
     * @see ToolbarListener#onArchive()
     */
	public void onArchive()
	{
		if (toolbar.getEvent() != null)
		{
			if (adTabbox.getSelectedGridTab().getRecord_ID() <= 0)
				return;

			new WArchive(toolbar.getToolbarItem("Archive"), adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getRecord_ID());
		}
	}

	//

	@Override
	public void onExport() {
		int AD_Table_ID=getActiveGridTab().getAD_Table_ID();
		final boolean isCanExport=MRole.getDefault().isCanExport(AD_Table_ID);
		if (!isCanExport) {
			Dialog.error(curWindowNo, "AccessCannotExport");
			return;
		} else {
			ExportAction action = new ExportAction(this);
			action.export();
		}
	}

	@Override
	public void onFileImport() {
		FileImportAction action = new FileImportAction(this);
		action.fileImport();
	}

	@Override
	public void onCSVImport() {
		CSVImportAction action = new CSVImportAction(this);
		action.fileImport();
	}
	
	@Override
	public void onSearchQuery() {
		if (adTabbox.getSelectedGridTab() == null)
            return;

        clearTitleRelatedContext();

		// The record was not changed locally
        if (adTabbox.getDirtyADTabpanel() == null) {
        	doOnQueryChange();
        } else {
            onSave(false, false, new Callback<Boolean>() {
    			@Override
    			public void onCallback(Boolean result) {
    				if (result) {
    					doOnQueryChange();
    				}
    			}
    		});        	
        }
	}
	
	/**
	 * Simulate opening the Find Window, selecting a user query and click ok
	 */
	public void doOnQueryChange() {
		//  Gets Fields from AD_Field_v
		GridField[] findFields = adTabbox.getSelectedGridTab().getFields();
		if (!isCurrentFindWindowValid()) {
        	if (!getFindWindow(findFields))
        		return;
		}

		getCurrentFindWindow().setAD_UserQuery_ID(toolbar.getAD_UserQuery_ID());
		getCurrentFindWindow().advancedOkClick();
		MQuery query = getCurrentFindWindow().getQuery();

		//  Confirmed query
		if (query != null) {
			m_onlyCurrentRows = false;
			adTabbox.getSelectedGridTab().setQuery(query);
			try {
				adTabbox.getSelectedTabpanel().query(m_onlyCurrentRows, m_onlyCurrentDays, MRole.getDefault().getMaxQueryRecords());   //  autoSize
			} catch (Exception e) {
				if (   e.getCause() != null 
					&& e.getCause() instanceof SQLException
					&& DB.getDatabase().isQueryTimeout((SQLException)e.getCause())) {
					// ignore, is captured somewhere else
	        		return;
				} else {
					throw new DBException(e);
				}
			}
		}

		adTabbox.getSelectedGridTab().dataRefresh(false);

		focusToActivePanel();
		getCurrentFindWindow().dispose();
	}

	/**************************************************************************
	 *	Start Button Process
	 *  @param vButton button
	 */
	private void actionButton (final IProcessButton wButton)
	{
		if (adTabbox.getSelectedGridTab().hasChangedCurrentTabAndParents()) {
			String msg = CLogger.retrieveErrorString("Please ReQuery Window");
			Dialog.error(curWindowNo, null, msg);
			return;
		}

		if (logger.isLoggable(Level.INFO)) logger.info(wButton.toString());

		final String col = wButton.getColumnName();

		//  Zoom
		if (col.equals("Record_ID"))
		{
			int AD_Table_ID = -1;
			int Record_ID = -1;

			if (wButton instanceof WButtonEditor) {
				int curTabNo = 0;
				WButtonEditor be = (WButtonEditor)wButton;
				if (be.getGridField() != null && be.getGridField().getGridTab() != null) {
					curTabNo = ((WButtonEditor)wButton).getGridField().getGridTab().getTabNo();
					AD_Table_ID = Env.getContextAsInt (ctx, curWindowNo, curTabNo, "AD_Table_ID");
					Record_ID = Env.getContextAsInt (ctx, curWindowNo, curTabNo, "Record_ID");
				}
			}
			if (AD_Table_ID < 0)
				AD_Table_ID = Env.getContextAsInt (ctx, curWindowNo, "AD_Table_ID");
			if (Record_ID < 0)
				Record_ID = Env.getContextAsInt (ctx, curWindowNo, "Record_ID");

			AEnv.zoom(AD_Table_ID, Record_ID);
			return;
		} // Zoom

		//  save first	---------------

		if (adTabbox.needSave(true, false))
		{
			onSave(false, false, new Callback<Boolean>() {
				@Override
				public void onCallback(Boolean result) {
					if (result) {
						actionButton0(col, wButton);
					}
				}
			});
		}
		else
		{
			actionButton0(col, wButton);
		}
	}

	/**************************************************************************
	 *	Start Button Process
	 * @param col
	 * @param wButton
	 */
	private void actionButton0 (String col, final IProcessButton wButton)
	{
		//To perform button action (adtabPanel is null in QuickForm)  
		IADTabpanel adtabPanel = null;
		if (adTabbox.getSelectedGridTab().isQuickForm())
		{
			adtabPanel=this.getADTab().getSelectedTabpanel();
		}
		else
		{
			adtabPanel = findADTabpanel(wButton);
		}
		boolean startWOasking = false;
		if (adtabPanel == null) {
			return;
		}
		final int table_ID = adtabPanel.getGridTab().getAD_Table_ID();

		//	Record_ID

		int record_ID = adtabPanel.getGridTab().getRecord_ID();

		//	Record_ID - Language Handling

		if (record_ID == -1 && adtabPanel.getGridTab().getKeyColumnName().equals("AD_Language"))
			record_ID = Env.getContextAsInt (ctx, curWindowNo, "AD_Language_ID");

		//	Record_ID - Change Log ID

		if (record_ID == -1
			&& (wButton.getProcess_ID() == PROCESS_AD_CHANGELOG_UNDO || wButton.getProcess_ID() == PROCESS_AD_CHANGELOG_REDO))
		{
			Integer id = (Integer)adtabPanel.getGridTab().getValue("AD_ChangeLog_ID");
			record_ID = id.intValue();
		}

		//	Ensure it's saved

		if (record_ID == -1 && adtabPanel.getGridTab().getKeyColumnName().endsWith("_ID"))
		{
			Dialog.error(curWindowNo, "SaveErrorRowNotFound");
			return;
		}

		boolean isProcessMandatory = false;
		//	Pop up Document Action (Workflow)
		if (col.equals("DocAction"))
		{
			final WDocActionPanel win = new WDocActionPanel(adtabPanel.getGridTab());
			if (win.getNumberOfOptions() == 0)
			{
				logger.info("DocAction - No Options");
				return;
			}
			else
			{
				final int recordIdParam = record_ID;				
				win.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					public void onEvent(Event event) throws Exception {
						hideBusyMask();
						focusToLastFocusEditor();
						if (!win.isStartProcess()) {								
							return;
						}
						boolean startWOasking = true;
						boolean isProcessMandatory = true;
						executeButtonProcess(wButton, startWOasking, table_ID, recordIdParam, isProcessMandatory);
					}
				});				
				getComponent().getParent().appendChild(win);
				showBusyMask(win);
				LayoutUtils.openOverlappedWindow(getComponent(), win, "middle_center");
				win.focus();
				return;
			}
		} // DocAction

		//  Pop up Create From 
		else if (col.equals("CreateFrom"))
		{
			ICreateFrom cf = WCreateFromFactory.create(adtabPanel.getGridTab());

			if(cf != null)
			{
				if(cf.isInitOK())
				{					
					final WCreateFromWindow window = (WCreateFromWindow) cf.getWindow();
					window.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, AdempiereIdGenerator.escapeId(window.getTitle()));
					window.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
						@Override
						public void onEvent(Event event) throws Exception {
							hideBusyMask();
							if (!window.isCancel()) {
								onRefresh(true, false);
							} else {
								focusToLastFocusEditor();
							}
						}
					});
					window.setZindex(1000);
					window.setMaximizable(true);
					window.setSizable(true);
					ZkCssHelper.appendStyle(window, "position: absolute; ");					
					getComponent().getParent().appendChild(window);
					showBusyMask(window);
					cf.showWindow();
					LayoutUtils.openOverlappedWindow(getComponent(), window, "middle_center");
					window.focus();
				}
				return;
			}
			// else may start process
		} // CreateFrom

		//  Posting -----

		else if (col.equals("Posted") && MRole.getDefault().isShowAcct())
		{
			//  Check Doc Status

			String processed = Env.getContext(ctx, curWindowNo, "Processed");

			if (!processed.equals("Y"))
			{
				String docStatus = Env.getContext(ctx, curWindowNo, "DocStatus");

				if (DocAction.STATUS_Completed.equals(docStatus)
					|| DocAction.STATUS_Closed.equals(docStatus)
					|| DocAction.STATUS_Reversed.equals(docStatus)
					|| DocAction.STATUS_Voided.equals(docStatus)
					|| table_ID == MProjectIssue.Table_ID) // document without status
					;
				else
				{
					Dialog.error(curWindowNo, "PostDocNotComplete");
					return;
				}
			}

			// try to get table and record id from context data (eg for unposted view)
			// otherwise use current table/record
			int tableId = Env.getContextAsInt(ctx, curWindowNo, "AD_Table_ID", true);
			int recordId = Env.getContextAsInt(ctx, curWindowNo, "Record_ID", true);
			if ( tableId == 0 || recordId == 0 )
			{
				tableId = adtabPanel.getGridTab().getAD_Table_ID();
				recordId = adtabPanel.getGridTab().getRecord_ID();
			}

			//  Check Post Status
			final Object ps = adtabPanel.getGridTab().getValue("Posted");

			if (ps != null && ps.equals("Y"))
			{
				new org.adempiere.webui.acct.WAcctViewer(Env.getContextAsInt (ctx, curWindowNo, "AD_Client_ID"),
						tableId, recordId);
			}
			else
			{
				final int tableIdRef = tableId;
				final int recordIdRef = recordId;
				Dialog.ask(curWindowNo, "PostImmediate?", new Callback<Boolean>() {

					@Override
					public void onCallback(Boolean result)
					{
						if (result)
						{
							boolean force = ps != null && !ps.equals ("N");		//	force when problems

							String error = AEnv.postImmediate (curWindowNo, Env.getAD_Client_ID(ctx),
								tableIdRef, recordIdRef, force);

							onRefresh(true, false);

							if (error != null)
							{
								if (getActiveGridTab().isQuickForm)
								{
									statusBarQF.setStatusLine(error, true);
								}
								else
								{
									statusBar.setStatusLine(error, true);
								}
							}
						}
					}
				});
			}
			return;
		}   //  Posted

		executeButtonProcess(wButton, startWOasking, table_ID, record_ID,
				isProcessMandatory);
	} // actionButton

	private Div getMask() {
		if (mask == null) {
			mask = new Mask();
		}
		return mask;
	}
	
	public void hideBusyMask() {
		if (mask != null && mask.getParent() != null) {
			mask.detach();
			StringBuilder script = new StringBuilder("(function(){let w=zk.Widget.$('#");
			script.append(getComponent().getParent().getUuid()).append("');if(w) w.busy=false;");
			script.append("})()");
			Clients.response(new AuScript(script.toString()));
		}
	}
	
	public void showBusyMask(Window window) {
		getComponent().getParent().appendChild(getMask());
		StringBuilder script = new StringBuilder("(function(){let w=zk.Widget.$('#");
		script.append(getComponent().getParent().getUuid()).append("');");
		if (window != null) {
			script.append("let d=zk.Widget.$('#").append(window.getUuid()).append("');w.busy=d;");
		} else {
			script.append("w.busy=true;");
		}
		script.append("})()");
		Clients.response(new AuScript(script.toString()));
	}

	/**
	 * 
	 * @return true if window is block by mask or highlighted window
	 */
	public boolean isBlock() {
		//check blocking by local mask
		if (mask != null && mask.getParent() != null) {
			return true;
		}
		
		//check blocking by highlighted window
		if (getComponent() != null && getComponent().getPage() != null) {
			Collection<Component> roots = getComponent().getPage().getRoots();
			for(Component comp : roots) {
				if (comp instanceof org.zkoss.zul.Window) {
					org.zkoss.zul.Window wnd = (org.zkoss.zul.Window) comp;
					if (wnd.isVisible() && wnd.inHighlighted())
						return true;
				}
			}
		}
		
		//check blocking by mask from ISupportMask (window, tabpanel)
		if (getComponent() != null) {
			Component p = getComponent().getParent();
			while (p != null) {
				if (p instanceof Mask) {
					if (p.isVisible()) {
						return true;
					}
				} else if (p instanceof DesktopTabpanel) {
					for(Component c : p.getChildren()) {
						if (c instanceof Mask) {
							if (c.isVisible())
								return true;
						}
					}
				}
				p = p.getParent();
			}
		}
		return false;
	}
	
	public void executeButtonProcess(final IProcessButton wButton,
			final boolean startWOasking, final int table_ID, final int record_ID,
			boolean isProcessMandatory) {
		/**
		 *  Start Process ----
		 */

		if (logger.isLoggable(Level.CONFIG)) logger.config("Process_ID=" + wButton.getProcess_ID() + ", InfoWindow_ID=" + wButton.getInfoWindow_ID() + ", Record_ID=" + record_ID);

		if (wButton.getProcess_ID() == 0 && wButton.getInfoWindow_ID() == 0)
		{
			if (isProcessMandatory)
			{
				Dialog.error(curWindowNo, null, Msg.parseTranslation(ctx, "@NotFound@ @AD_Process_ID@ @AD_InfoWindow_ID@"));
			}
			return;
		}

		//	Save item changed

		if (adTabbox.needSave(true, false))
		{
			onSave(false, false, new Callback<Boolean>() {

				@Override
				public void onCallback(Boolean result) {
					if (result) {
						if (wButton.getInfoWindow_ID() > 0)
							executionButtonInfoWindow0(wButton);
						else
							executeButtonProcess0(wButton, startWOasking, table_ID, record_ID);
					}
				}
			});
		}
		else
		{
			if (wButton.getInfoWindow_ID() > 0)
				executionButtonInfoWindow0(wButton);
			else
				executeButtonProcess0(wButton, startWOasking, table_ID, record_ID);
		}
	}

	private void executeButtonProcess0(final IProcessButton wButton,
			boolean startWOasking, int table_ID, int record_ID) {
		// call form
		MProcess pr = new MProcess(ctx, wButton.getProcess_ID(), null);
		int adFormID = pr.getAD_Form_ID();
		if (adFormID != 0 )
		{
			String title = wButton.getDescription();
			if (title == null || title.length() == 0)
				title = wButton.getDisplay();							
			ProcessInfo pi = new ProcessInfo (title, wButton.getProcess_ID(), table_ID, record_ID);
			pi.setAD_User_ID (Env.getAD_User_ID(ctx));
			pi.setAD_Client_ID (Env.getAD_Client_ID(ctx));
			IADTabpanel adtabPanel = null;
			if (adTabbox.getSelectedGridTab().isQuickForm())
			{
				adtabPanel=this.getADTab().getSelectedTabpanel();
			}
			else
			{
				adtabPanel = findADTabpanel(wButton);
			}
			GridTab gridTab = null;
			if (adtabPanel != null)
				gridTab = adtabPanel.getGridTab();
			ADForm form = ADForm.openForm(adFormID, gridTab);
			form.setProcessInfo(pi);
			Mode mode = form.getWindowMode();
			form.setAttribute(Window.MODE_KEY, form.getWindowMode());
			form.setAttribute(Window.INSERT_POSITION_KEY, Window.INSERT_NEXT);
			
			if (mode == Mode.HIGHLIGHTED || mode == Mode.MODAL) {
				form.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						hideBusyMask();
						onRefresh(true, false);						
					}
				});
				form.setPage(getComponent().getPage());
				form.doHighlighted();
				form.focus();
			}
			else {
				SessionManager.getAppDesktop().showWindow(form);
			}
		}
		else
		{
			IADTabpanel adtabPanel = null;
			if (adTabbox.getSelectedGridTab().isQuickForm())
				adtabPanel = this.getADTab().getSelectedTabpanel();
			else
				adtabPanel = findADTabpanel(wButton);

			ProcessInfo pi = new ProcessInfo("", wButton.getProcess_ID(), table_ID, record_ID);
			if (adtabPanel != null && adtabPanel.isGridView() && adtabPanel.getGridTab() != null)
			{
				int[] indices = adtabPanel.getGridTab().getSelection();
				if (indices.length > 0)
				{
					List<Integer> records = new ArrayList<Integer>();
					for (int i = 0; i < indices.length; i++)
					{
						int keyID = adtabPanel.getGridTab().getKeyID(indices[i]);
						if (keyID > 0)
							records.add(keyID);
					}

					// IDEMPIERE-3998 Set multiple selected grid records into process info
					pi.setRecord_IDs(records);
				}
			}

			ProcessModalDialog dialog = new ProcessModalDialog(this, curWindowNo, pi, startWOasking);

			if (dialog.isValid())
			{
				//dialog.setWidth("500px");
				dialog.setBorder("normal");				
				getComponent().getParent().appendChild(dialog);
				if (ClientInfo.isMobile())
				{
					dialog.doHighlighted();
				}
				else
				{
					showBusyMask(dialog);
					LayoutUtils.openOverlappedWindow(getComponent(), dialog, "middle_center");
				}
				Executions.schedule(getComponent().getDesktop(), e -> dialog.focus(), new Event("onPostShowProcessModalDialog"));
			}
		}
	}

	private void executionButtonInfoWindow0(final IProcessButton wButton) {
		IADTabpanel adtabPanel = null;
		if (adTabbox.getSelectedGridTab().isQuickForm())
		{
			adtabPanel = this.getADTab().getSelectedTabpanel();
		}
		else
		{
			adtabPanel = findADTabpanel(wButton);
		}
		if (adtabPanel == null)
			return;
			
		GridTab gridTab = adtabPanel.getGridTab();		
		if (gridTab == null)
			return;
		
		InfoWindow infoWindow = InfoManager.create(gridTab.getWindowNo(), wButton.getInfoWindow_ID(), (String)null);
		infoWindow.setAttribute(Window.MODE_KEY, Mode.OVERLAPPED);
		infoWindow.setCloseAfterExecutionOfProcess(true);		
		infoWindow.setBorder("normal");
		infoWindow.setClosable(true);
		infoWindow.moveProcessButtonsToBeforeRight();
		int height = ClientInfo.get().desktopHeight;
		int width = ClientInfo.get().desktopWidth;
		if (width <= ClientInfo.MEDIUM_WIDTH)
		{
			ZKUpdateUtil.setWidth(infoWindow, "100%");
			ZKUpdateUtil.setHeight(infoWindow, "100%");
		}
		else
		{
			height = height * 85 / 100;
    		width = width * 80 / 100;
    		ZKUpdateUtil.setWidth(infoWindow, width + "px");
    		ZKUpdateUtil.setHeight(infoWindow, height + "px");
		}
		infoWindow.setContentStyle("overflow: auto");
		
		infoWindow.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, AdempiereIdGenerator.escapeId(infoWindow.getTitle()));
		infoWindow.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				hideBusyMask();
				if (!infoWindow.isCancelled())
					onRefresh(true, false);
				else
					focusToLastFocusEditor();
			}
		});
		infoWindow.setZindex(1000);
		infoWindow.setMaximizable(true);
		infoWindow.setSizable(true);
		getComponent().getParent().appendChild(infoWindow);
		showBusyMask(infoWindow);
		LayoutUtils.openOverlappedWindow(getComponent(), infoWindow, "middle_center");	
		infoWindow.focusToFirstEditor();
	}
	
	/**
	 * @param event
	 * @see ActionListener#actionPerformed(ActionEvent)
	 */
	public void actionPerformed(final ActionEvent event)
	{
		Runnable runnable = new Runnable() {
			public void run() {
				String error = processButtonCallout((IProcessButton) event.getSource());
				if (error != null && error.trim().length() > 0)
				{
					if (getActiveGridTab().isQuickForm)
					{
						statusBarQF.setStatusLine(error, true);
					}
					else
					{
						statusBar.setStatusLine(error, true);
					}
					focusToLastFocusEditor();
					return;
				}
				actionButton((IProcessButton) event.getSource());
			}
		};
		BusyDialogTemplate template = new BusyDialogTemplate(runnable);
		template.run();
	}

	/**************************************************************************
	 *  Process Callout(s).
	 *  <p>
	 *  The Callout is in the string of
	 *  "class.method;class.method;"
	 * If there is no class name, i.e. only a method name, the class is regarded
	 * as CalloutSystem.
	 * The class needs to comply with the Interface Callout.
	 *
	 * @param field field
	 * @return error message or ""
	 * @see org.compiere.model.Callout
	 */
	private String processButtonCallout (IProcessButton button)
	{
		IADTabpanel adtab = null;
		if (adTabbox.getSelectedGridTab().isQuickForm())
		{
			adtab=this.getADTab().getSelectedTabpanel();
		}
		else
		{
			adtab = findADTabpanel(button);
		}
		if (adtab != null) {
			GridField field = adtab.getGridTab().getField(button.getColumnName());
			if (field != null)
				return adtab.getGridTab().processCallout(field);
			else
				return "";
		} else {
			return "";
		}
	}	//	processButtonCallout

	public IADTabpanel findADTabpanel(IProcessButton button) {
		IADTabpanel adtab = null;
		if (button.getADTabpanel() != null)
			return button.getADTabpanel();

		Component c = button instanceof WEditor ? ((WEditor)button).getComponent() : (Component)button;
		while (c != null) {
			if (c instanceof IADTabpanel) {
				adtab = (IADTabpanel) c;
				break;
			}
			c = c.getParent();
		}
		return adtab;
	}

	/**
	 *
	 * @return IADTab
	 */
	public IADTabbox getADTab() {
		return adTabbox;
	}

	/**
	 * @param pi
	 */
	public void executeASync(ProcessInfo pi) {
	}

	/**
	 * @param pi
	 */
	private void onModalClose(ProcessInfo pi) {
		boolean notPrint = pi != null
		&& pi.getAD_Process_ID() != adTabbox.getSelectedGridTab().getAD_Process_ID()
		&& pi.isReportingProcess() == false;
		//
		//  Process Result

		if (Executions.getCurrent() != null)
		{
			if (notPrint || pi.isError()) // show process info if it is not print or have error
			{
				updateUI(pi);
			}
		}
		else
		{
			try {
				//acquire desktop, 2 second timeout
				Executions.activate(getComponent().getDesktop(), 2000);
				try {
					if (notPrint || pi.isError()) // show process info if it is not print or have error
					{
						updateUI(pi);
					}
                } catch(Error ex){
                	throw ex;
                } finally{
                	//release full control of desktop
                	Executions.deactivate(getComponent().getDesktop());
                }
			} catch (Exception e) {
				logger.log(Level.WARNING, "Failed to update UI upon unlock.", e);
			}
		}
	}

	private void updateUI(ProcessInfo pi) {						
		//	Timeout
		if (pi.isTimeout())		//	set temporarily to R/O
			Env.setContext(ctx, curWindowNo, "Processed", "Y");
		//	Update Status Line
		String summary = pi.getSummary();
		if (summary != null && summary.indexOf('@') != -1)
			pi.setSummary(Msg.parseTranslation(Env.getCtx(), summary));

		//		Get Log Info
		ProcessInfoUtil.setLogFromDB(pi);
		ProcessInfoLog m_logs[] = pi.getLogs();
		if (getActiveGridTab().isQuickForm)
		{
			statusBarQF.setStatusLine(pi.getSummary(), pi.isError(), m_logs);
		}
		else
		{
			statusBar.setStatusLine(pi.getSummary(), pi.isError(), m_logs);
		}
		
		
		if (m_logs != null && m_logs.length > 0) {
			ProcessInfoDialog dialog = ProcessInfoDialog.showProcessInfo(pi, curWindowNo, getComponent(), false);
			dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, e -> focusToActivePanel());
		}
		
	}

	/**
	 *
	 * @return toolbar instance
	 */
	public ADWindowToolbar getToolbar() {
		return toolbar;
	}

	/**
	 * @return active grid tab
	 */
	public GridTab getActiveGridTab() {
		return adTabbox.getSelectedGridTab();
	}

	/**
	 * @return windowNo
	 */
	public int getWindowNo() {
		return curWindowNo;
	}

	/**
	 * show dialog to customize fields (hidden, display, order of field) in grid mode 
	 * @see CustomizeGridViewDialog
     * @see ToolbarListener#onCustomize()
     */
	public void onCustomize() {
		ADTabpanel tabPanel = (ADTabpanel) getADTab().getSelectedTabpanel();
		CustomizeGridViewDialog.onCustomize(tabPanel, b -> {
			focusToLastFocusEditor();
		});
	}

	/**
	 * @see org.adempiere.webui.event.ToolbarListener#onProcess()
	 */
	@Override
	public void onProcess() {
		ProcessButtonPopup popup = new ProcessButtonPopup();
		popup.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "processButtonPopup");
		IADTabpanel adtab = adTabbox.getSelectedTabpanel();
		popup.render(adtab.getToolbarButtons());
		if (popup.getChildren().size() > 0) {
			popup.setPage(this.getComponent().getPage());
			popup.open(getToolbar().getToolbarItem("Process"), "after_start");
		}
	}

	@Override
	public void onSelect() {
		if (getCurrentFindWindow() != null && getCurrentFindWindow().getPage() != null && getCurrentFindWindow().isVisible() && m_queryInitiating) {
			LayoutUtils.openEmbeddedWindow(getComponent().getParent(), getCurrentFindWindow(), "overlap");
		} else {
			focusToLastFocusEditor();
		}
	}

	public boolean isPendingChanges() {
		return adTabbox.getDirtyADTabpanel() != null;
	}

	public void setADWindow(ADWindow adwindow) {
		this.adwindow = adwindow;
	}
	
	public ADWindow getADWindow() {
		return adwindow;
	}
	
	public boolean getFindWindow(GridField[] findFields) {
		FindWindow findWindow = getCurrentFindWindow();
		if (findWindow != null && isCurrentFindWindowValid()) {
			toolbar.setSelectedUserQuery(findWindow.getAD_UserQuery_ID());
		} else {
			findWindow = new FindWindow (adTabbox.getSelectedGridTab().getWindowNo(), adTabbox.getSelectedGridTab().getTabNo(), adTabbox.getSelectedGridTab().getName(),
					adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getTableName(),
					adTabbox.getSelectedGridTab().getWhereExtended(), findFields, 1, adTabbox.getSelectedGridTab().getAD_Tab_ID(), this);

			setupEmbeddedFindwindow(findWindow);
			if (!findWindow.initialize()) {
				if (findWindow.getTotalRecords() == 0) {
					Dialog.info(curWindowNo, "NoRecordsFound");
				}
				return false;
			}
			tabFindWindowHashMap.put(adTabbox.getSelectedGridTab(), findWindow);
		}
		return true;
	}
	
	public FindWindow getCurrentFindWindow() {
		return tabFindWindowHashMap.get(adTabbox.getSelectedGridTab());
	}
	
	/**
	 * Clean all the detail cached FindWindow objects
	 * when the master record is changed
	 */
	private void clenFindWindowHashMap() {
		tabFindWindowHashMap.keySet().removeIf(tab -> tab.getTabLevel() != 0);
	}
	
	private void clearTitleRelatedContext() {
		// IDEMPIERE-1328
		// clear the values for the tab header
        String titleLogic = null;
        int windowID = getADTab().getSelectedGridTab().getAD_Window_ID();
        if (windowID > 0) {
        	titleLogic = MWindow.get(Env.getCtx(), windowID).getTitleLogic();
        }
        if (titleLogic != null) {
    		String token;
    		String inStr = new String(titleLogic);

    		int i = inStr.indexOf('@');
    		while (i != -1)
    		{
    			inStr = inStr.substring(i+1, inStr.length());	// from first @

    			int j = inStr.indexOf('@');						// next @
    			if (j < 0)
    			{
    				logger.log(Level.SEVERE, "No second tag: " + inStr);
    				return;						//	no second tag
    			}

    			token = inStr.substring(0, j);
        		Env.setContext(ctx, curWindowNo, token, "");

    			inStr = inStr.substring(j+1, inStr.length());	// from second @
    			i = inStr.indexOf('@');
    		}
        } else {
    		Env.setContext(ctx, curWindowNo, "DocumentNo", "");
    		Env.setContext(ctx, curWindowNo, "Value", "");
    		Env.setContext(ctx, curWindowNo, "Name", "");
        }
	}
	
	/**
	 * @return Quick Form StatusBar
	 */
	public StatusBar getStatusBarQF()
	{
		return statusBarQF;
	}
	
	/**
	 * @param statusBar
	 */
	public void setStatusBarQF(StatusBar statusBar)
	{
		statusBarQF = statusBar;
	}	
	
	/**
	 * Implementation to work key listener for the current open Quick Form.
	 */
	QuickGridView currQGV = null;

	/**
	 * @return
	 */
	public QuickGridView getCurrQGV()
	{
		return currQGV;
	}

	/**
	 * @param currQGV
	 */
	public void setCurrQGV(QuickGridView currQGV)
	{
		this.currQGV = currQGV;
	}

	/**
	 * Close Quick form to remove tabID from the list
	 * 
	 * @param AD_Tab_ID
	 */
	public void closeQuickFormTab(Integer AD_Tab_ID)
	{
		quickFormOpenTabs.remove(AD_Tab_ID);
	} // closeQuickFormTab

	/**
	 * Get list of open quick form tabs
	 * 
	 * @return list of tabIDs
	 */
	public ArrayList <Integer> getOpenQuickFormTabs( )
	{
		return quickFormOpenTabs;
	} // getOpenQuickFormTabs

	/**
	 * Register Quick form against tabID
	 * 
	 * @param AD_Tab_ID
	 * @return False when already quick form opens for same tab
	 */
	public boolean registerQuickFormTab(Integer AD_Tab_ID)
	{
		if (quickFormOpenTabs.contains(AD_Tab_ID))
		{
			return false;
		}

		quickFormOpenTabs.add(AD_Tab_ID);

		return true;
	} // registerQuickFormTab
	
	/**
	 * 
	 * @return {@link GridWindow}
	 */
	public GridWindow getGridWindow() {
		return gridWindow;
	}

	
	/**
	 * set component of last focus editor.
	 * Use in onClose/Exit to restore focus
	 * @param component
	 */
	public void setLastFocusEditor(Component component) {
		lastFocusEditor = component;
	}
}
