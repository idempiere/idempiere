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

import static org.compiere.model.SystemIDs.PROCESS_AD_CHANGELOG_REDO;
import static org.compiere.model.SystemIDs.PROCESS_AD_CHANGELOG_UNDO;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.TreeMap;
import java.util.logging.Level;

import javax.servlet.http.HttpServletRequest;

import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.WArchive;
import org.adempiere.webui.WRequest;
import org.adempiere.webui.WZoomAcross;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.BusyDialogTemplate;
import org.adempiere.webui.apps.ProcessModalDialog;
import org.adempiere.webui.apps.form.WCreateFromFactory;
import org.adempiere.webui.apps.form.WCreateFromWindow;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.ProcessInfoDialog;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.editor.IProcessButton;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.event.ActionEvent;
import org.adempiere.webui.event.ActionListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ToolbarListener;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.panel.WAttachment;
import org.adempiere.webui.panel.WDocActionPanel;
import org.adempiere.webui.panel.action.ExportAction;
import org.adempiere.webui.panel.action.FileImportAction;
import org.adempiere.webui.panel.action.ReportAction;
import org.adempiere.webui.part.AbstractUIPart;
import org.adempiere.webui.part.ITabOnSelectHandler;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.CustomizeGridViewDialog;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.FindWindow;
import org.adempiere.webui.window.WChat;
import org.adempiere.webui.window.WRecordAccessDialog;
import org.compiere.grid.ICreateFrom;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.Lookup;
import org.compiere.model.MImage;
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MRecentItem;
import org.compiere.model.MRole;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.WebDoc;
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
import org.zkoss.zul.Column;
import org.zkoss.zul.Columns;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;
import org.zkoss.zul.Window.Mode;

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
 * @see FR [ 2877111 ] See identifiers columns when delete records https://sourceforge.net/tracker/?func=detail&atid=879335&aid=2877111&group_id=176962
 *
 * @author hengsin, hengsin.low@idalica.com
 * @see FR [2887701] https://sourceforge.net/tracker/?func=detail&atid=879335&aid=2887701&group_id=176962
 * @sponsor www.metas.de
 *
 * @author Teo Sarca, teo.sarca@gmail.com
 *  	<li>BF [ 2992540 ] Grid/Panel not refreshed after process run
 *  		https://sourceforge.net/tracker/?func=detail&aid=2992540&group_id=176962&atid=955896
 *  	<li>BF [ 2985892 ] Opening a window using a new record query is not working
 *  		https://sourceforge.net/tracker/?func=detail&aid=2985892&group_id=176962&atid=955896
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

    private boolean 			 boolChanges = false;

	private int m_onlyCurrentDays = 0;

	private Component parent;

	private boolean m_findCancelled;

	private boolean m_findCreateNew;

	private boolean m_queryInitiating;

	protected BreadCrumb breadCrumb;

	private int adWindowId;

	private MImage image;

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
		if (parent instanceof Component)
			this.parent = (Component) parent;

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
        toolbar = new ADWindowToolbar(getWindowNo());
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

    private void focusToActivePanel() {
    	IADTabpanel adTabPanel = adTabbox.getSelectedTabpanel();
		focusToTabpanel(adTabPanel);
	}

    private void focusToTabpanel(IADTabpanel adTabPanel ) {
		if (adTabPanel != null && adTabPanel instanceof HtmlBasedComponent) {
			Events.echoEvent(ON_FOCUS_DEFER_EVENT, getComponent(), (HtmlBasedComponent)adTabPanel);
		}
	}

    /**
     * @param adWindowId
     * @param query
     * @return boolean
     */
	public boolean initPanel(MQuery query)
    {
		// This temporary validation code is added to check the reported bug
		// [ adempiere-ZK Web Client-2832968 ] User context lost?
		// https://sourceforge.net/tracker/?func=detail&atid=955896&aid=2832968&group_id=176962
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
    	if (query != null && query.getZoomTableName() != null && query.getZoomColumnName() != null
				&& query.getZoomValue() instanceof Integer && (Integer)query.getZoomValue() > 0)
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
        Env.setContext(ctx, curWindowNo, "WindowName", gridWindow.getName());
        Env.setContext(ctx, curWindowNo, "AD_Window_ID", gridWindow.getAD_Window_ID());
        Env.setContext(ctx, curWindowNo, "AD_Window_UU", gridWindow.getAD_Window_UU());

        if (gridTab != null)
        	gridTab.getTableModel().setChanged(false);

        adTabbox.setSelectedIndex(0);
        // all fields context for window is clear at AbstractADTab.prepareContext, set again IsSOTrx for window
        Env.setContext(ctx, curWindowNo, "IsSOTrx", gridWindow.isSOTrx());
        toolbar.enableTabNavigation(adTabbox.getTabCount() > 1);
        toolbar.enableFind(true);
        adTabbox.evaluate(null);

        if (detailQuery != null && zoomToDetailTab(detailQuery))
        {
        	return true;
        }

        toolbar.updateToolbarAccess(adWindowId);
        updateToolbar();
        
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
				int parentId = DB.getSQLValue(null, "SELECT " + gTab.getLinkColumnName() + " FROM " + gTab.getTableName() + " WHERE " + query.getWhereClause());
				if (parentId > 0)
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
						MQuery pquery = new MQuery(pTab.getAD_Table_ID());
						pquery.addRestriction((String)value[0], "=", value[1]);						
						IADTabpanel tp = adTabbox.findADTabpanel(pTab);
        				tp.createUI();
        				if (tp.getTabLevel() == 0)
        				{
        					pTab.setQuery(pquery);
        					tp.query();
        				}
        				else 
        				{
        					tp.query();
        					pTab.setQuery(pquery);
        					tp.query();
        				}        				
					}

					MQuery targetQuery = new MQuery(gTab.getAD_Table_ID());
					targetQuery.addRestriction(gTab.getLinkColumnName(), "=", parentId);
					gTab.setQuery(targetQuery);
					IADTabpanel gc = null;
					gc = adTabbox.findADTabpanel(gTab);
					gc.createUI();
					gc.query(false, 0, 0);

					GridTable table = gTab.getTableModel();
    				int count = table.getRowCount();
    				for(int i = 0; i < count; i++)
    				{
    					int id = table.getKeyID(i);
    					if (id == ((Integer)query.getZoomValue()).intValue())
    					{
    						setActiveTab(gridWindow.getTabIndex(gTab), null);
    						gTab.navigate(i);
    						if (gc.isGridView())
    							gc.switchRowPresentation();
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

		if (gTab.isSortTab())
		{
			ADSortTab sortTab = new ADSortTab(curWindowNo, gTab);
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
			fTabPanel.addEventListener(ADTabpanel.ON_DYNAMIC_DISPLAY_EVENT, this);
	    	gTab.addDataStatusListener(this);
	    	fTabPanel.init(this, curWindowNo, gTab, gridWindow);
	    	adTabbox.addTab(gTab, fTabPanel);
		    if (tabIndex == 0) {
		    	fTabPanel.createUI();
		    	if (!m_queryInitiating)
				{
					initFirstTabpanel();
				}
		    }

		    if (!m_queryInitiating && tabIndex == 0)
		    {
		    	initQueryOnNew(query);
		    }
		}

		return gTab;
	}

	private void initFirstTabpanel() {
		adTabbox.getSelectedTabpanel().query(m_onlyCurrentRows, m_onlyCurrentDays, MRole.getDefault().getMaxQueryRecords());
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
        if (query != null && query.isActive() && query.getRecordCount() < 10)
        {
        	callback.onCallback(query);
        	return;
        }

        //
        StringBuffer where = new StringBuffer();
        // Query automatically if high volume and no query
        boolean require = mTab.isHighVolume();
        if (!require && !m_onlyCurrentRows) // No Trx Window
        {
            String wh1 = Env.parseContext(ctx, curWindowNo, mTab.getWhereExtended(), false);
            if (wh1 == null || wh1.length() == 0)
                wh1 = mTab.getWhereClause();
            if (wh1 != null && wh1.length() > 0)
                where.append(wh1);
            //
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
            // Does not consider security
            int no = DB.getSQLValue(null, sql.toString());
            //
            require = MRole.getDefault().isQueryRequire(no);
        }
        // Show Query
        if (require)
        {
        	m_findCancelled = false;
        	m_findCreateNew = false;
            GridField[] findFields = mTab.getFields();
            findWindow = new FindWindow(curWindowNo,
                    mTab.getName(), mTab.getAD_Table_ID(), mTab.getTableName(),
                    where.toString(), findFields, 10, mTab.getAD_Tab_ID()); // no query below 10
            setupEmbeddedFindwindow();
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

	private void setupEmbeddedFindwindow() {
		findWindow.setTitle(null);
		findWindow.setBorder("none");	
		findWindow.setStyle("position: absolute; border-bottom: 2px solid #484848; padding: 2px; background-color: #fff;");
		findWindow.setWidth("100%");
		findWindow.setHeight("60%");
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
					adTabbox.getSelectedGridTab().navigate(0);
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

    // Elaine 2008/12/04
	private Menupopup 	m_popup = null;
	private Menuitem 	m_lock = null;
	private Menuitem 	m_access = null;

	private FindWindow findWindow;

	private Div mask;

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
						}
					});

					AEnv.showWindow(recordAccessDialog);
				}
			});

			m_popup.setPage(toolbar.getButton("Lock").getPage());
		}
		m_popup.open(toolbar.getButton("Lock"));
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
			//aAttachment.setEnabled(false);
			return;
		}

		EventListener<Event> listener = new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				toolbar.getButton("Attachment").setPressed(adTabbox.getSelectedGridTab().hasAttachment());
				focusToActivePanel();				
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
				toolbar.getButton("Chat").setPressed(adTabbox.getSelectedGridTab().hasChat());
				focusToActivePanel();				
			}
		});
    	getComponent().getParent().appendChild(chat);
    	showBusyMask(chat);    	    	
    	LayoutUtils.openOverlappedWindow(getComponent(), chat, "middle_center");
    	chat.showWindow();
    }

    /**
     * @see ToolbarListener#onToggle()
     */
    public void onToggle()
    {
    	adTabbox.getSelectedTabpanel().switchRowPresentation();
    	//Deepak-Enabling customize button IDEMPIERE-364
        if(!(adTabbox.getSelectedTabpanel() instanceof ADSortTab))
        	toolbar.enableCustomize(((ADTabpanel)adTabbox.getSelectedTabpanel()).isGridView());
    	focusToActivePanel();
    }

    /**
     * @return boolean
     */
    public boolean onExit()
    {
    	if (!boolChanges)
    	{
    		return true;
    	}
    	else
    		FDialog.info(this.curWindowNo, null, "SaveBeforeClose");

    	return false;
    }

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
    		hideBusyMask();
    		ProcessModalDialog dialog = (ProcessModalDialog) event.getTarget();
    		onModalClose(dialog.getProcessInfo());
    		String s = breadCrumb.getStatusLine(); 
    		boolean b = breadCrumb.getStatusError();
    		ProcessInfoLog[] logs = breadCrumb.getPLogs();
    		onRefresh(true, false);
    		breadCrumb.setStatusLine(s, b, logs);       	
    	}
    	else if (ADTabpanel.ON_DYNAMIC_DISPLAY_EVENT.equals(event.getName()))
    	{
    		ADTabpanel adtab = (ADTabpanel) event.getTarget();
    		if (adtab == adTabbox.getSelectedTabpanel()) {
    			toolbar.enableProcessButton(adtab.getToolbarButtons().size() > 0);
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
    		comp.focus();
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
		    FDialog.warn(curWindowNo, "TabSwitchJumpGo", title);
		    if (callback != null)
				callback.onCallback(false);
		    return;
		}


		IADTabpanel newTabpanel = adTabbox.getSelectedTabpanel();

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
				newTabpanel.query();
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

		toolbar.getButton("Attachment").setPressed(adTabbox.getSelectedGridTab().hasAttachment());
		toolbar.getButton("Chat").setPressed(adTabbox.getSelectedGridTab().hasChat());
		toolbar.getButton("Find").setPressed(adTabbox.getSelectedGridTab().isQueryActive());

		if (toolbar.isPersonalLock)
		{
			toolbar.lock(adTabbox.getSelectedGridTab().isLocked());
		}

		toolbar.enablePrint(adTabbox.getSelectedGridTab().isPrinted());

        //Deepak-Enabling customize button IDEMPIERE-364
        if(!(adTabbox.getSelectedTabpanel() instanceof ADSortTab))
        {
        	toolbar.enableCustomize(((ADTabpanel)adTabbox.getSelectedTabpanel()).isGridView());
        }
        else 
        {
        	toolbar.enableCustomize(false);
        	toolbar.enableProcessButton(false);
        }

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

    	if (!detailTab)
    	{
	        String dbInfo = e.getMessage();
	        if (logger.isLoggable(Level.INFO)) logger.info(dbInfo);
	        if (adTabbox.getSelectedGridTab() != null && adTabbox.getSelectedGridTab().isQueryActive())
	            dbInfo = "[ " + dbInfo + " ]";
	        breadCrumb.setStatusDB(dbInfo, e);
    	} else if (adTabbox.getSelectedDetailADTabpanel() == null)
    	{
    		return;
    	}

        //  Set Message / Info
        if (e.getAD_Message() != null || e.getInfo() != null)
        {
        	if (GridTab.DEFAULT_STATUS_MESSAGE.equals(e.getAD_Message()))
        	{
        		if (detailTab) {
                	adTabbox.setDetailPaneStatusMessage("", false);
                } else {
                	breadCrumb.setStatusLine ("", false);
                }
        	}
        	else
        	{
	            StringBuilder sb = new StringBuilder();
	            String msg = e.getMessage();
	            StringBuilder adMessage = new StringBuilder();
	            if (msg != null && msg.length() > 0)
	            {
	            	adMessage.append(Msg.getMsg(Env.getCtx(), e.getAD_Message()));
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
	            	sb.append(MessageFormat.format(adMessage.toString(), arguments));
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
	                	breadCrumb.setStatusLine (sb.toString (), e.isError ());
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
        		FDialog.warn(curWindowNo, null, e.getAD_Message(), e.getInfo());
        		e.setConfirmed(true);   //  show just once - if MTable.setCurrentRow is involved the status event is re-issued
        	}
        }

        boolean changed = e.isChanged() || e.isInserting();
        boolean readOnly = adTabbox.getSelectedGridTab().isReadOnly();
        boolean insertRecord = !readOnly;
        if (!detailTab)
        {
	        //  update Change
	        boolChanges = changed;

	        if (insertRecord)
	        {
	            insertRecord = tabPanel.getGridTab().isInsertRecord();
	        }
	        toolbar.enableNew(!changed && insertRecord && !tabPanel.getGridTab().isSortTab());
	        toolbar.enableRefresh(!changed);
	        toolbar.enableDelete(!changed && !readOnly && !tabPanel.getGridTab().isSortTab());
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
        toolbar.enableIgnore(adTabbox.needSave(true, false) ||
        		adTabbox.getSelectedGridTab().isNew() ||
        		(adTabbox.getSelectedDetailADTabpanel() != null && adTabbox.getSelectedDetailADTabpanel().getGridTab().isNew()));

        if (changed && !readOnly && !toolbar.isSaveEnable() ) {
        	if (tabPanel.getGridTab().getRecord_ID() > 0) {
            	if (adTabbox.getSelectedIndex() == 0 && !detailTab) {
            		MRecentItem.addModifiedField(ctx, adTabbox.getSelectedGridTab().getAD_Table_ID(),
            				adTabbox.getSelectedGridTab().getRecord_ID(), Env.getAD_User_ID(ctx),
            				Env.getAD_Role_ID(ctx), adTabbox.getSelectedGridTab().getAD_Window_ID(),
            				adTabbox.getSelectedGridTab().getAD_Tab_ID());
            	} else {
	        		/* when a detail record is modified add header to recent items */
	        		GridTab mainTab = gridWindow.getTab(0);
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

        //
        //  No Rows
        if (e.getTotalRows() == 0 && insertRecord && !detailTab)
        {
            toolbar.enableNew(true);
            toolbar.enableDelete(false);
        }

        //  Transaction info
        if (!detailTab)
        {
	        String trxInfo = adTabbox.getSelectedGridTab().getTrxInfo();
	        if (trxInfo != null)
	        {
	            statusBar.setInfo(trxInfo);
	        }
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
            toolbar.getButton("Attachment").setPressed(adTabbox.getSelectedGridTab().hasAttachment());
        }
        else
        {
            toolbar.enableAttachment(false);
        }

        // Check Chat
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
            toolbar.getButton("Chat").setPressed(adTabbox.getSelectedGridTab().hasChat());
        }
        else
        {
        	toolbar.enableChat(false);
        }

        toolbar.getButton("Find").setPressed(adTabbox.getSelectedGridTab().isQueryActive());

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

        toolbar.enablePrint(adTabbox.getSelectedGridTab().isPrinted());
        toolbar.enableReport(true);
        toolbar.enableExport(!adTabbox.getSelectedGridTab().isSortTab());
        toolbar.enableFileImport(!changed && !adTabbox.getSelectedGridTab().isSortTab() && adTabbox.getSelectedGridTab().isInsertRecord());
        
        toolbar.enableTabNavigation(breadCrumb.hasParentLink(), adTabbox.getSelectedDetailADTabpanel() != null);
        
        //Deepak-Enabling customize button IDEMPIERE-364
        if(!(adTabbox.getSelectedTabpanel() instanceof ADSortTab))
        	toolbar.enableCustomize(((ADTabpanel)adTabbox.getSelectedTabpanel()).isGridView());
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
					adTabbox.getSelectedGridTab().dataRefreshAll(fireEvent, true);
			        adTabbox.getSelectedTabpanel().dynamicDisplay(0);
			        focusToActivePanel();
				}
			});
    	}
    	else
    	{
    		adTabbox.getSelectedGridTab().dataRefreshAll(fireEvent, true);
	        adTabbox.getSelectedTabpanel().dynamicDisplay(0);
	        focusToActivePanel();
    	}
    }

    /**
     * @see ToolbarListener#onRefresh()
     */
    public void onRefresh()
    {
    	onRefresh(true);
    }

    /**
     * @see ToolbarListener#onHelp()
     */
    public void onHelp()
    {
    	WebDoc doc = gridWindow.getHelpDoc(false);
    	String html = doc.toString();
    	HttpServletRequest request = (HttpServletRequest) Executions.getCurrent().getNativeRequest();
    	String logo = request.getContextPath() + ThemeManager.getThemeResource("images/header-logo.png");
    	html = html.replace("images/header-logo.png", logo);
		SessionManager.getAppDesktop().showHTMLContent(html, "Help", true);
    }

    /**
     * @see ToolbarListener#onNew()
     */
    public void onNew()
    {
        if (!adTabbox.getSelectedGridTab().isInsertRecord())
        {
            logger.warning("Insert Record disabled for Tab");
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
			            toolbar.enableDelete(false);
			            breadCrumb.enableFirstNavigation(adTabbox.getSelectedGridTab().getCurrentRow() > 0);
			            breadCrumb.enableLastNavigation(adTabbox.getSelectedGridTab().getCurrentRow() + 1 < adTabbox.getSelectedGridTab().getRowCount());
			            toolbar.enableTabNavigation(breadCrumb.hasParentLink(), adTabbox.getSelectedDetailADTabpanel() != null);
			            toolbar.enableIgnore(true);
			            toolbar.enablePrint(adTabbox.getSelectedGridTab().isPrinted());
			            toolbar.enableReport(true);
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
			        }
			        else
			        {
			            logger.severe("Could not create new record");
			        }
			        focusToActivePanel();
				}
			}
		});
    }

	// Elaine 2008/11/19
    /**
     * @see ToolbarListener#onCopy()
     */
    public void onCopy()
    {
        if (!adTabbox.getSelectedGridTab().isInsertRecord())
        {
            logger.warning("Insert Record disabled for Tab");
            return;
        }

        boolean newRecord = adTabbox.getSelectedGridTab().dataNew(true);
        if (newRecord)
        {
            adTabbox.getSelectedTabpanel().dynamicDisplay(0);
            toolbar.enableNew(false);
            toolbar.enableDelete(false);
            breadCrumb.enableFirstNavigation(adTabbox.getSelectedGridTab().getCurrentRow() > 0);
            breadCrumb.enableLastNavigation(adTabbox.getSelectedGridTab().getCurrentRow() + 1 < adTabbox.getSelectedGridTab().getRowCount());
            toolbar.enableTabNavigation(false);
            toolbar.enableIgnore(true);
            toolbar.enablePrint(adTabbox.getSelectedGridTab().isPrinted());
            toolbar.enableReport(true);
        }
        else
        {
            logger.severe("Could not create new record");
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

        onSave(false, false, new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result) {
				if (result) {
					doOnFind();
				}
			}
		});
    }

	private void doOnFind() {
		//  Gets Fields from AD_Field_v
        GridField[] findFields = adTabbox.getSelectedGridTab().getFields();
        if (findWindow == null || !findWindow.validate(adTabbox.getSelectedGridTab().getWindowNo(), adTabbox.getSelectedGridTab().getName(),
            adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getTableName(),
            adTabbox.getSelectedGridTab().getWhereExtended(), findFields, 1, adTabbox.getSelectedGridTab().getAD_Tab_ID())) {
	        findWindow = new FindWindow (adTabbox.getSelectedGridTab().getWindowNo(), adTabbox.getSelectedGridTab().getName(),
	            adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getTableName(),
	            adTabbox.getSelectedGridTab().getWhereExtended(), findFields, 1, adTabbox.getSelectedGridTab().getAD_Tab_ID());

	        setupEmbeddedFindwindow();	        
	        if (!findWindow.initialize()) {
	        	if (findWindow.getTotalRecords() == 0) {
	        		FDialog.info(curWindowNo, getComponent(), "NoRecordsFound");
	        	}
	        	return;
	        }
        }

        if (!findWindow.getEventListeners(DialogEvents.ON_WINDOW_CLOSE).iterator().hasNext()) {
        	findWindow.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					hideBusyMask();
					if (!findWindow.isCancel())
			        {
				        MQuery query = findWindow.getQuery();

				        //  Confirmed query
				        if (query != null)
				        {
				            m_onlyCurrentRows = false;          //  search history too
				            adTabbox.getSelectedGridTab().setQuery(query);
				            adTabbox.getSelectedTabpanel().query(m_onlyCurrentRows, m_onlyCurrentDays, MRole.getDefault().getMaxQueryRecords());   //  autoSize
				        }

				        if (findWindow.isCreateNew())
				        	onNew();
				        else
				        	adTabbox.getSelectedGridTab().dataRefresh(false); // Elaine 2008/07/25
			        }
					else
					{
						toolbar.getButton("Find").setPressed(adTabbox.getSelectedGridTab().isQueryActive());
					}
			        focusToActivePanel();
				}
			});
        }

        getComponent().getParent().appendChild(findWindow);
        showBusyMask(findWindow);                
        LayoutUtils.openEmbeddedWindow(toolbar, findWindow, "after_start");
	}

    /**
     * @see ToolbarListener#onIgnore()
     */
    public void onIgnore()
    {
    	IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
    	boolean newrecod = adTabbox.getSelectedGridTab().isNew();
    	if (dirtyTabpanel != null && dirtyTabpanel.getGridTab().isSortTab())
    	{
    		dirtyTabpanel.refresh();
    		toolbar.enableIgnore(false);
    	}
    	else
    	{
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
    	if (dirtyTabpanel != null)
    		focusToTabpanel(dirtyTabpanel);
    	else
    		focusToActivePanel();
    	
    	updateToolbar();
    }

    /**
     * @see ToolbarListener#onSave()
     */
    public void onSave()
    {
    	final IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
    	onSave(true, false, new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result)
			{
				if (result)
				{
		    		String statusLine = breadCrumb.getStatusLine();
		    		adTabbox.getSelectedGridTab().dataRefreshAll(true, true);
		    		breadCrumb.setStatusLine(statusLine);
		    	}
				if (dirtyTabpanel != null) {
					if (dirtyTabpanel == adTabbox.getSelectedDetailADTabpanel())
						Clients.scrollIntoView(dirtyTabpanel);
					focusToTabpanel(dirtyTabpanel);
				} else {
					focusToActivePanel();
				}
			}
		});
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
    private void onSave(final boolean onSaveEvent, final boolean onNavigationEvent, final Callback<Boolean> callback)
    {
    	final boolean wasChanged = toolbar.isSaveEnable();
    	IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
    	final boolean newRecord = dirtyTabpanel != null ? (dirtyTabpanel.getGridTab().isNew()) : adTabbox.getSelectedGridTab().isNew();
    	if (dirtyTabpanel == null) {
			onSave0(onSaveEvent, onNavigationEvent, newRecord, wasChanged, callback);
			return;
    	}
    	if (dirtyTabpanel instanceof ADSortTab)
    	{
    		ADSortTab sortTab = (ADSortTab) dirtyTabpanel;
    		sortTab.saveData();

    		if (!onNavigationEvent)
    		{
	    		toolbar.enableSave(sortTab.isChanged());	//	set explicitly
	    		toolbar.enableIgnore(sortTab.isChanged());
    		}
    		if (!sortTab.isChanged()) {
    			if (sortTab == adTabbox.getSelectedTabpanel()) {
    				breadCrumb.setStatusLine(Msg.getMsg(Env.getCtx(), "Saved"));
    			} else {
    				adTabbox.setDetailPaneStatusMessage(Msg.getMsg(Env.getCtx(), "Saved"), false);
    			}
    		}
    		if (callback != null)
    			callback.onCallback(true);
    	}
    	else
    	{
    		if (!Util.isEmpty(dirtyTabpanel.getGridTab().getCommitWarning()) ||
    			(!Env.isAutoCommit(ctx, curWindowNo) && onNavigationEvent))
    		{
    			FDialog.ask(curWindowNo, this.getComponent(), "SaveChanges?", dirtyTabpanel.getGridTab().getCommitWarning(), new Callback<Boolean>() {

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
    }

	private void onSave0(boolean onSaveEvent, boolean navigationEvent,
			boolean newRecord, boolean wasChanged, Callback<Boolean> callback) {
		IADTabpanel dirtyTabpanel = adTabbox.getDirtyADTabpanel();
		boolean retValue = adTabbox.dataSave(onSaveEvent);

		if (!retValue)
		{
			showLastError();
			if (callback != null)
				callback.onCallback(false);
			return;
		} else if (!onSaveEvent && dirtyTabpanel != null) //need manual refresh
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
		        		/* when a detail record is modified add header to recent items */
		        		GridTab mainTab = gridWindow.getTab(0);
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
		    		GridTab mainTab = gridWindow.getTab(0);
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

	private void showLastError() {
		String msg = CLogger.retrieveErrorString(null);
		if (msg != null)
		{
			breadCrumb.setStatusLine(Msg.getMsg(Env.getCtx(), msg), true);
		}
		//other error will be catch in the dataStatusChanged event
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

    /**
     * @see ToolbarListener#onDelete()
     */
    public void onDelete()
    {
        if (adTabbox.getSelectedGridTab().isReadOnly())
        {
            return;
        }

        FDialog.ask(curWindowNo, null, "DeleteRecord?", new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result)
			{
				if (result)
				{
		        	//error will be catch in the dataStatusChanged event
		            adTabbox.getSelectedGridTab().dataDelete();

		            adTabbox.getSelectedTabpanel().dynamicDisplay(0);
		            focusToActivePanel();
				}
	        }
		});
    }

    // Elaine 2008/12/01
	/**
	 * @see ToolbarListener#onDelete()
	 */
    public void onDeleteSelection()
	{
		if (adTabbox.getSelectedGridTab().isReadOnly())
        {
            return;
        }

		//show table with deletion rows -> value, name...
		final Window messagePanel = new Window();
		messagePanel.setBorder("normal");
		messagePanel.setWidth("600px");
		messagePanel.setTitle(Msg.getMsg(Env.getCtx(), "Find").replaceAll("&", "") + ": " + title);
        messagePanel.setClosable(true);
        messagePanel.setSizable(true);
        messagePanel.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "deleteSelection");

		final Listbox listbox = new Listbox();
		listbox.setHeight("400px");

		// Display the first 5 fields data exclude Organization, Client and YesNo field data
		ArrayList<String> columnNames = new ArrayList<String>();
		GridField[] fields = adTabbox.getSelectedGridTab().getFields();
		if(adTabbox.getSelectedGridTab().getField("DocumentNo")!=null){
			columnNames.add(adTabbox.getSelectedGridTab().getField("DocumentNo").getColumnName());
		}
		if(adTabbox.getSelectedGridTab().getField("Line")!=null){
			columnNames.add(adTabbox.getSelectedGridTab().getField("Line").getColumnName());
		}
		if(adTabbox.getSelectedGridTab().getField("Value")!=null){
			columnNames.add(adTabbox.getSelectedGridTab().getField("Value").getColumnName());
		}
		if(adTabbox.getSelectedGridTab().getField("Name")!=null){
			columnNames.add(adTabbox.getSelectedGridTab().getField("Name").getColumnName());
		}
		for(int i = 0; i < fields.length; i++)
		{
			GridField field = fields[i];
			if(field.getColumnName().equalsIgnoreCase("AD_Org_ID")
					|| field.getColumnName().equalsIgnoreCase("AD_Client_ID")
					|| field.getDisplayType() == DisplayType.YesNo)
				continue;
			if (!columnNames.contains(field.getColumnName()))
			{
				columnNames.add(field.getColumnName());
			}
		}

		ArrayList<String> data = new ArrayList<String>();
		int noOfRows = adTabbox.getSelectedGridTab().getRowCount();
		for(int i=0; i<noOfRows; i++)
		{
			StringBuffer displayValue = new StringBuffer();
			if("".equals(adTabbox.getSelectedGridTab().getKeyColumnName()))
			{
				ArrayList<String> parentColumnNames = adTabbox.getSelectedGridTab().getParentColumnNames();
				for (Iterator<String> iter = parentColumnNames.iterator(); iter.hasNext();)
				{
					String columnName = iter.next();
					GridField field = adTabbox.getSelectedGridTab().getField(columnName);
					if(field.isLookup()){
						Lookup lookup = field.getLookup();
						if (lookup != null){
							displayValue = displayValue.append(lookup.getDisplay(adTabbox.getSelectedGridTab().getValue(i,columnName))).append(" | ");
						} else {
							displayValue = displayValue.append(adTabbox.getSelectedGridTab().getValue(i,columnName)).append(" | ");
						}
					} else {
						displayValue = displayValue.append(adTabbox.getSelectedGridTab().getValue(i,columnName)).append(" | ");
					}
				}
			} else {
				displayValue = displayValue.append(adTabbox.getSelectedGridTab().getValue(i,adTabbox.getSelectedGridTab().getKeyColumnName()));
			}

			int count = 0;
			for(int j=0; j < columnNames.size() && count < 5; j++)
			{
				Object value = adTabbox.getSelectedGridTab().getValue(i, columnNames.get(j));
				if(value == null) continue; // skip when value is null
				String text = value.toString().trim();
				if(text.length() == 0) continue; // skip when value is empty
				GridField field = adTabbox.getSelectedGridTab().getField(columnNames.get(j));
				if(field != null)
				{
					if (field.isLookup())
					{
						Lookup lookup = field.getLookup();
						if (lookup != null)
							text = lookup.getDisplay(value);
					}
					else if (DisplayType.isDate(field.getDisplayType()))
					{
						text = DisplayType.getDateFormat(field.getDisplayType()).format(value);
					}
				}
				if(text.length() > 30)
					text = text.substring(0, 30); // display the first 30 characters
				displayValue = displayValue.append(" | ").append(text);
				count++;
			}

			data.add(displayValue.toString());
		}

		for(int i = 0; i < data.size(); i++)
		{
			String record = data.get(i);
			listbox.appendItem(record, record);
		}

		listbox.setMultiple(true);
		messagePanel.appendChild(listbox);

		Div div = new Div();
		div.setStyle("text-align: center");
		messagePanel.appendChild(div);

		Hbox hbox = new Hbox();
		hbox.setStyle("padding-top: 2px");
		div.appendChild(hbox);

		Button btnOk = ButtonFactory.createNamedButton(ConfirmPanel.A_OK);
		// Invert - Unify  OK/Cancel IDEMPIERE-77
		btnOk.addEventListener(Events.ON_CLICK, new EventListener<Event>()
		{
			public void onEvent(Event event) throws Exception
			{
				FDialog.ask(curWindowNo, messagePanel, "DeleteSelection", new Callback<Boolean>() {

					@Override
					public void onCallback(Boolean result)
					{
						if (result)
						{
							logger.fine("ok");
							Set<Listitem> selectedValues = listbox.getSelectedItems();
							if(selectedValues != null)
							{
								for(Iterator<Listitem> iter = selectedValues.iterator(); iter.hasNext();)
								{
									Listitem li = iter.next();
									if(li != null)
										if (logger.isLoggable(Level.FINE)) logger.fine((String) li.getValue());
								}
							}

							int[] indices = listbox.getSelectedIndices();
							Arrays.sort(indices);
							int offset = 0;
							for (int i = 0; i < indices.length; i++)
							{
								adTabbox.getSelectedGridTab().navigate(indices[i]-offset);
								if (adTabbox.getSelectedGridTab().dataDelete())
								{
									offset++;
								}
							}
							adTabbox.getSelectedTabpanel().dynamicDisplay(0);

				            messagePanel.dispose();
				        } else {
							logger.fine("cancel");
						}
					}

				});
			}
		});
		hbox.appendChild(btnOk);

		Button btnCancel = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL);
		btnCancel.addEventListener(Events.ON_CLICK, new EventListener<Event>()
		{
			public void onEvent(Event event) throws Exception
			{
				messagePanel.dispose();
			}
		});
		hbox.appendChild(btnCancel);
		hbox.setPack("end");
		hbox.setHflex("1");

		messagePanel.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				hideBusyMask();
				focusToActivePanel();
			}
		});		
		getComponent().getParent().appendChild(messagePanel);
		showBusyMask(messagePanel);
		LayoutUtils.openOverlappedWindow(getComponent(), messagePanel, "middle_center");
	}
	//

    /**
     * @see ToolbarListener#onPrint()
     */
	public void onPrint() {
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

					ProcessModalDialog dialog = new ProcessModalDialog(AbstractADWindowContent.this, getWindowNo(), AD_Process_ID,table_ID, record_ID, true);
					if (dialog.isValid()) {
						dialog.setWidth("500px");
						dialog.setBorder("normal");						
						getComponent().getParent().appendChild(dialog);
						showBusyMask(dialog);
						LayoutUtils.openOverlappedWindow(getComponent(), dialog, "middle_center");
						dialog.focus();
					}
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
			FDialog.error(curWindowNo, parent, "AccessCannotReport");
			return;
		}

		Callback<Boolean> callback = new Callback<Boolean>() {

			@Override
			public void onCallback(Boolean result) {
				if (result) {
					onReport0();
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
						new Integer(Env.getContextAsInt(ctx, curWindowNo, link)));
				else
					query.addRestriction(link, MQuery.EQUAL,
						Env.getContext(ctx, curWindowNo, link));
			}
			new WZoomAcross(toolbar.getEvent().getTarget(), adTabbox.getSelectedGridTab()
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
			if (adTabbox.getSelectedGridTab().getRecord_ID() <= 0)
				return;
			else
				AEnv.startWorkflowProcess(adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getRecord_ID());
		}
	}
	//

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

			new WRequest(toolbar.getEvent().getTarget(), adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getRecord_ID(), C_BPartner_ID);
		}
	}
	//

	// Elaine 2008/07/22
	/**
     * @see ToolbarListener#onProductInfo()
     */
	public void onProductInfo()
	{
		InfoPanel.showProduct(0);
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

			new WArchive(toolbar.getEvent().getTarget(), adTabbox.getSelectedGridTab().getAD_Table_ID(), adTabbox.getSelectedGridTab().getRecord_ID());
		}
	}

	//

	@Override
	public void onExport() {
		ExportAction action = new ExportAction(this);
		action.export();
	}

	@Override
	public void onFileImport() {
		FileImportAction action = new FileImportAction(this);
		action.fileImport();
	}

	/**************************************************************************
	 *	Start Button Process
	 *  @param vButton button
	 */
	private void actionButton (final IProcessButton wButton)
	{
		if (adTabbox.getSelectedGridTab().hasChangedCurrentTabAndParents()) {
			String msg = CLogger.retrieveErrorString("Please ReQuery Window");
			FDialog.error(curWindowNo, parent, null, msg);
			return;
		}

		if (logger.isLoggable(Level.INFO)) logger.info(wButton.toString());

		final String col = wButton.getColumnName();

		//  Zoom
		if (col.equals("Record_ID"))
		{
			int AD_Table_ID = Env.getContextAsInt (ctx, curWindowNo, "AD_Table_ID");
			int Record_ID = Env.getContextAsInt (ctx, curWindowNo, "Record_ID");

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
		final IADTabpanel adtabPanel = findADTabpanel(wButton);
		boolean startWOasking = false;
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
			FDialog.error(curWindowNo, parent, "SaveErrorRowNotFound");
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
					|| DocAction.STATUS_Voided.equals(docStatus))
					;
				else
				{
					FDialog.error(curWindowNo, parent, "PostDocNotComplete");
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
				FDialog.ask(curWindowNo, null, "PostImmediate?", new Callback<Boolean>() {

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
								breadCrumb.setStatusLine(error, true);
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
			StringBuilder script = new StringBuilder("var w=zk.Widget.$('#");
			script.append(getComponent().getParent().getUuid()).append("');w.busy=false;");
			Clients.response(new AuScript(script.toString()));
		}
	}
	
	public void showBusyMask(Window window) {
		getComponent().getParent().appendChild(getMask());
		StringBuilder script = new StringBuilder("var w=zk.Widget.$('#");
		script.append(getComponent().getParent().getUuid()).append("');");
		if (window != null) {
			script.append("var d=zk.Widget.$('#").append(window.getUuid()).append("');w.busy=d;");
		} else {
			script.append("w.busy=true;");
		}
		Clients.response(new AuScript(script.toString()));
	}

	private void executeButtonProcess(final IProcessButton wButton,
			final boolean startWOasking, final int table_ID, final int record_ID,
			boolean isProcessMandatory) {
		/**
		 *  Start Process ----
		 */

		if (logger.isLoggable(Level.CONFIG)) logger.config("Process_ID=" + wButton.getProcess_ID() + ", Record_ID=" + record_ID);

		if (wButton.getProcess_ID() == 0)
		{
			if (isProcessMandatory)
			{
				FDialog.error(curWindowNo, null, null, Msg.parseTranslation(ctx, "@NotFound@ @AD_Process_ID@"));
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
						executeButtonProcess0(wButton, startWOasking, table_ID, record_ID);
					}
				}
			});
		}
		else
		{
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
			final IADTabpanel adtabPanel = findADTabpanel(wButton);
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
				showBusyMask(form);
				LayoutUtils.openOverlappedWindow(getComponent(), form, "middle_center");
				form.focus();
			}
			else {
				SessionManager.getAppDesktop().showWindow(form);
			}
		}
		else
		{
			ProcessModalDialog dialog = new ProcessModalDialog(this, curWindowNo, wButton.getProcess_ID(), table_ID, record_ID, startWOasking);

			if (dialog.isValid())
			{
				dialog.setWidth("500px");
				dialog.setBorder("normal");				
				getComponent().getParent().appendChild(dialog);
				showBusyMask(dialog);
				LayoutUtils.openOverlappedWindow(getComponent(), dialog, "middle_center");
				dialog.focus();
			}
			else
			{
				onRefresh(true, false);
			}
		}
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
					breadCrumb.setStatusLine(error, true);
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
		IADTabpanel adtab = findADTabpanel(button);
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
			if (notPrint)		//	refresh if not print
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
					if (notPrint)		//	refresh if not print
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
		breadCrumb.setStatusLine(pi.getSummary(), pi.isError(),m_logs);
		if (m_logs != null) {
			ProcessInfoDialog dialog = new ProcessInfoDialog(AEnv.getDialogHeader(ctx, curWindowNo),Env.getHeader(ctx, curWindowNo), m_logs);
			dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					hideBusyMask();
				}
			});			
			getComponent().getParent().appendChild(dialog);
			showBusyMask(dialog);
			LayoutUtils.openOverlappedWindow(this.getComponent(),dialog,"middle_center");
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
     * @see ToolbarListener#onCustomize()
     */
	public void onCustomize() {
		ADTabpanel tabPanel = (ADTabpanel) getADTab().getSelectedTabpanel();
		Columns columns = tabPanel.getGridView().getListbox().getColumns();
		List<Component> columnList = columns.getChildren();
		GridField[] fields = tabPanel.getGridView().getFields();
		Map<Integer, String> columnsWidth = new HashMap<Integer, String>();
		ArrayList<Integer> gridFieldIds = new ArrayList<Integer>();
		for (int i = 0; i < fields.length; i++) {
			Column column = (Column) columnList.get(i+1);
			String width = column.getWidth();
			columnsWidth.put(fields[i].getAD_Field_ID(), width);
			gridFieldIds.add(fields[i].getAD_Field_ID());

		}
		CustomizeGridViewDialog.showCustomize(0, adTabbox.getSelectedGridTab().getAD_Tab_ID(), columnsWidth,gridFieldIds,tabPanel.getGridView());
	}

	/**
	 * @see org.adempiere.webui.event.ToolbarListener#onProcess()
	 */
	@Override
	public void onProcess() {
		ProcessButtonPopup popup = new ProcessButtonPopup();
		popup.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "processButtonPopup");
		ADTabpanel adtab = (ADTabpanel) adTabbox.getSelectedTabpanel();
		popup.render(adtab.getToolbarButtons());

		LayoutUtils.openPopupWindow(toolbar.getButton("Process"), popup, "after_start");
	}

	@Override
	public void onSelect() {
		if (findWindow != null && findWindow.getPage() != null && findWindow.isVisible() && m_queryInitiating) {
			LayoutUtils.openEmbeddedWindow(getComponent().getParent(), findWindow, "overlap");
		}
	}
}
