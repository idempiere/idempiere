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

package org.adempiere.webui.panel;

import static org.compiere.model.SystemIDs.PROCESS_AD_CHANGELOG_REDO;
import static org.compiere.model.SystemIDs.PROCESS_AD_CHANGELOG_UNDO;

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
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.WArchive;
import org.adempiere.webui.WRequest;
import org.adempiere.webui.WZoomAcross;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.BusyDialogTemplate;
import org.adempiere.webui.apps.ProcessModalDialog;
import org.adempiere.webui.apps.form.WCreateFromFactory;
import org.adempiere.webui.apps.form.WCreateFromWindow;
import org.adempiere.webui.apps.form.WPayment;
import org.adempiere.webui.component.CWindowToolbar;
import org.adempiere.webui.component.IADTab;
import org.adempiere.webui.component.IADTabList;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WButtonEditor;
import org.adempiere.webui.event.ActionEvent;
import org.adempiere.webui.event.ActionListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ToolbarListener;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.panel.action.ExportAction;
import org.adempiere.webui.panel.action.ReportAction;
import org.adempiere.webui.part.AbstractUIPart;
import org.adempiere.webui.session.SessionManager;
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
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MRecentItem;
import org.compiere.model.MRole;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.WebDoc;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Button;
import org.zkoss.zul.Column;
import org.zkoss.zul.Columns;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menupopup;

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
public abstract class AbstractADWindowPanel extends AbstractUIPart implements ToolbarListener,
        EventListener<Event>, DataStatusListener, ActionListener
{
    private static final CLogger logger;

    static
    {
        logger = CLogger.getCLogger(AbstractADWindowPanel.class);
    }

    private Properties           ctx;

    private GridWindow           gridWindow;

    protected StatusBarPanel     statusBar;

    protected IADTab          	 adTab;

    private int                  curWindowNo;

    private GridTab              curTab;

    private boolean              m_onlyCurrentRows = true;

    private IADTabpanel           curTabpanel;

    protected CWindowToolbar     toolbar;

    private int                  curTabIndex;

    protected String             title;

    private boolean              newRecord;

    private boolean 			 boolChanges = false;

	private int m_onlyCurrentDays = 0;

	private Component parent;

	private boolean m_findCancelled;

	private boolean m_findCreateNew;

	private boolean m_queryInitiating;

	/**
	 * Constructor
	 * @param ctx
	 * @param windowNo
	 */
    public AbstractADWindowPanel(Properties ctx, int windowNo)
    {
        this.ctx = ctx;
        this.curWindowNo = windowNo;

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

		adTab = createADTab();
		adTab.addSelectionEventListener(this);
		adTab.setADWindowPanel(this);

        return super.createPart(parent);
    }

	/**
	 * @return StatusBarPanel
	 */
	public StatusBarPanel getStatusBar()
    {
    	return statusBar;
    }

    private void initComponents()
    {
        /** Initalise toolbar */
        toolbar = new CWindowToolbar(getWindowNo());
        toolbar.addListener(this);

        statusBar = new StatusBarPanel();
    }

    /**
     * @return IADTab
     */
    protected abstract IADTab createADTab();

    private void focusToActivePanel() {
    	IADTabpanel adTabPanel = adTab.getSelectedTabpanel();
		if (adTabPanel != null && adTabPanel instanceof HtmlBasedComponent) {
			((HtmlBasedComponent)adTabPanel).focus();
		}
	}

    /**
     * @param adWindowId
     * @param query
     * @return boolean
     */
	public boolean initPanel(int adWindowId, MQuery query)
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

        GridWindowVO gWindowVO = AEnv.getMWindowVO(curWindowNo, adWindowId, 0);
        if (gWindowVO == null)
        {
            throw new ApplicationException(Msg.getMsg(ctx,
                    "AccessTableNoView")
                    + "(No Window Model Info)");
        }
        gridWindow = new GridWindow(gWindowVO, true);
        title = gridWindow.getName();

        // Set AutoNew for Window
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

        for (int tab = 0; tab < tabSize; tab++)
        {
            initTab(query, tab);
            if (tab == 0 && curTab == null && m_findCancelled)
            	return false;
        }
        Env.setContext(ctx, curWindowNo, "WindowName", gridWindow.getName());
        
        if (curTab != null)
        	curTab.getTableModel().setChanged(false);

        curTabIndex = 0;

        adTab.setSelectedIndex(0);	        
        // all fields context for window is clear at AbstractADTab.prepareContext, set IsSOTrx for window
        Env.setContext(ctx, curWindowNo, "IsSOTrx", gridWindow.isSOTrx());	        
        toolbar.enableTabNavigation(adTab.getTabCount() > 1);
        toolbar.enableFind(true);
        adTab.evaluate(null);

        if (detailQuery != null && zoomToDetailTab(detailQuery))
        {
        	return true;
        }

        updateToolbar();

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
						pTab.setQuery(pquery);
						IADTabpanel tp = adTab.findADTabpanel(pTab);
        				tp.createUI();
        				tp.query();
					}

					MQuery targetQuery = new MQuery(gTab.getAD_Table_ID());
					targetQuery.addRestriction(gTab.getLinkColumnName(), "=", parentId);
					gTab.setQuery(targetQuery);
					IADTabpanel gc = null;
					gc = adTab.findADTabpanel(gTab);
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
    						return true;
    					}
    				}
				}
			}
		}
		return false;
	}

	private void initQueryOnNew(MQuery result) {
		if (curTab.isHighVolume() && m_findCreateNew)
			onNew();
		else if (result == null && curTab.getRowCount() == 0 && Env.isAutoNew(ctx, curWindowNo))
			onNew();
		else if (!curTab.isReadOnly() && curTab.isQueryNewRecord())
			onNew();
	}
	
	/**
	 * @param query
	 * @param tabIndex
	 */
	protected void initTab(MQuery query, int tabIndex) {
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
				    
				    if (curTabpanel != null) 
				    {
					    initFirstTabpanel();
					    
					    initQueryOnNew(result);
				    }
				}
				
			});		    

		    curTab = gTab;
		    curTabIndex = tabIndex;
		}

		if (gTab.isSortTab())
		{
			ADSortTab sortTab = new ADSortTab(curWindowNo, gTab);
			adTab.addTab(gTab, sortTab);
			sortTab.registerAPanel(this);
			if (tabIndex == 0) {
				curTabpanel = sortTab;
				curTabpanel.createUI();
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
	    	gTab.addDataStatusListener(this);
	    	fTabPanel.init(this, curWindowNo, gTab, gridWindow);
	    	adTab.addTab(gTab, fTabPanel);
		    if (tabIndex == 0) {
		    	fTabPanel.createUI();
		    	curTabpanel = fTabPanel;
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
	}

	private void initFirstTabpanel() {
		curTabpanel.query(m_onlyCurrentRows, m_onlyCurrentDays, MRole.getDefault().getMaxQueryRecords());
		curTabpanel.activate(true);
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
	        	findWindow.setTitle(null);
	        	getComponent().addEventListener("onInitialQuery", new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						LayoutUtils.openPopupWindow(getComponent(), findWindow, "overlap");
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

    public String getTitle()
    {
        return title;
    }

    /**
     * @see ToolbarListener#onDetailRecord()
     */
    public void onDetailRecord()
    {
        int maxInd = adTab.getTabCount() - 1;
        int curInd = adTab.getSelectedIndex();
        if (curInd < maxInd)
        {
            setActiveTab(curInd + 1, new Callback<Boolean>() {
				
				@Override
				public void onCallback(Boolean result) {
					focusToActivePanel();
				}
			});
        }        
    }

	/**
     * @see ToolbarListener#onParentRecord()
     */
    public void onParentRecord()
    {
        int curInd = adTab.getSelectedIndex();
        if (curInd > 0)
        {
            setActiveTab(curInd - 1, new Callback<Boolean>() {
				@Override
				public void onCallback(Boolean result) {
					focusToActivePanel();
				}
			});
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
					curTab.navigate(0);
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
					curTab.navigate(curTab.getRowCount() - 1);
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
					curTab.navigateRelative(+1);
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
					curTab.navigateRelative(-1);
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

	/**
	 *	@see ToolbarListener#onLock()
	 */
	public void onLock()
	{
		if (!toolbar.isPersonalLock)
			return;
		if (curTab.getRecord_ID() == -1)	//	No Key
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
					curTab.lock(Env.getCtx(), curTab.getRecord_ID(), !toolbar.getButton("Lock").isPressed());
					curTab.loadAttachments();			//	reload

					toolbar.lock(curTab.isLocked());
				}
			});

			m_access = new Menuitem(Msg.translate(Env.getCtx(), "RecordAccessDialog"));
			m_popup.appendChild(m_access);
			m_access.addEventListener(Events.ON_CLICK, new EventListener<Event>()
			{
				public void onEvent(Event event) throws Exception
				{
					WRecordAccessDialog recordAccessDialog = new WRecordAccessDialog(null, curTab.getAD_Table_ID(), curTab.getRecord_ID());
					recordAccessDialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

						@Override
						public void onEvent(Event event) throws Exception {
							toolbar.lock(curTab.isLocked());
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
		int record_ID = curTab.getRecord_ID();
		logger.info("Record_ID=" + record_ID);

		if (record_ID == -1)	//	No Key
		{
			//aAttachment.setEnabled(false);
			return;
		}

		EventListener<Event> listener = new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				curTab.loadAttachments();				//	reload
				toolbar.getButton("Attachment").setPressed(curTab.hasAttachment());
				focusToActivePanel();
			}
		};
		//	Attachment va =
		new WAttachment (	curWindowNo, curTab.getAD_AttachmentID(),
							curTab.getAD_Table_ID(), record_ID, null, listener);		
	}

    public void onChat()
    {
    	int recordId = curTab.getRecord_ID();
    	logger.info("Record_ID=" + recordId);

		if (recordId== -1)	//	No Key
		{
			return;
		}

		//	Find display
		String infoName = null;
		String infoDisplay = null;
		for (int i = 0; i < curTab.getFieldCount(); i++)
		{
			GridField field = curTab.getField(i);
			if (field.isKey())
				infoName = field.getHeader();
			if ((field.getColumnName().equals("Name") || field.getColumnName().equals("DocumentNo") )
				&& field.getValue() != null)
				infoDisplay = field.getValue().toString();
			if (infoName != null && infoDisplay != null)
				break;
		}
		String description = infoName + ": " + infoDisplay;

    	WChat chat = new WChat(curWindowNo, curTab.getCM_ChatID(), curTab.getAD_Table_ID(), recordId, description, null);
    	chat.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				curTab.loadChats();
				toolbar.getButton("Chat").setPressed(curTab.hasChat());
				focusToActivePanel();
			}
		});    	
    	chat.showWindow();
    }

    /**
     * @see ToolbarListener#onToggle()
     */
    public void onToggle()
    {
    	curTabpanel.switchRowPresentation();
    	//Deepak-Enabling customize button IDEMPIERE-364
        if(!(curTabpanel instanceof ADSortTab))
        	toolbar.enableCustomize(((ADTabpanel)curTabpanel).isGridView());
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
    	if (Events.ON_SELECT.equals(event.getName()))
    	{
	    	IADTabList tabList = null;
	    	Component target = event.getTarget();
	    	if (target instanceof IADTabList)
	    	{
	    		tabList = (IADTabList) target;
	    	}
	    	else
	    	{
	    		target = target.getParent();
	    		while(target != null)
	    		{
	    			if (target instanceof IADTabList)
	    	    	{
	    	    		tabList = (IADTabList) target;
	    	    		break;
	    	    	}
	    			target = target.getParent();
	    		}
	    	}
	
	        if (tabList != null)
	        {
	        	int newTabIndex = tabList.getSelectedIndex();
	
	        	final IADTabList tabListRef = tabList;
	        	final int originalTabIndex = curTabIndex;
	            setActiveTab(newTabIndex, new Callback<Boolean>() {

					@Override
					public void onCallback(Boolean result) {
						if (result)
						{
			            	//force sync model
			            	tabListRef.refresh();
			            }
			            else
			            {
			            	//reset to original
			            	tabListRef.setSelectedIndex(originalTabIndex);
			            }
						
					}
				});	            
	        }
    	}
    	else if (event.getTarget() instanceof ProcessModalDialog)
    	{
    		ProcessModalDialog dialog = (ProcessModalDialog) event.getTarget();
    		onModalClose(dialog.getProcessInfo());
    		onRefresh(false, false);
    	}
    }

	private void setActiveTab(final int newTabIndex, final Callback<Boolean> callback) {

		final int oldTabIndex = curTabIndex;

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
			saveAndNavigate(command);
		}
		
	}

	protected void saveAndNavigate(final Callback<Boolean> callback) {
		if (curTab != null)
		{
			if (curTab.isSortTab())
			{
				onSave(false, true, callback);
			}
			else if (curTab.needSave(true, false))
		    {
		    	if (curTab.needSave(true, true))
				{
		    		onSave(false, true, callback);
				}
				else 
				{
					//  new record, but nothing changed
					curTab.dataIgnore();
					callback.onCallback(true);
				}
			}   //  there is a change
			else
				callback.onCallback(true);
		}
		else
			callback.onCallback(true);
	}

	private void setActiveTab0(int oldTabIndex, int newTabIndex,
			final Callback<Boolean> callback) {
		boolean back = false;
		if (!adTab.updateSelectedIndex(oldTabIndex, newTabIndex))
		{
		    FDialog.warn(curWindowNo, "TabSwitchJumpGo", title);
		    if (callback != null)
				callback.onCallback(false);
		}

		IADTabpanel oldTabpanel = curTabpanel;
		IADTabpanel newTabpanel = adTab.getSelectedTabpanel();
		curTab = newTabpanel.getGridTab();

		if (oldTabpanel != null)
			oldTabpanel.activate(false);
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
					IADTabpanel next = adTab.getADTabpanel(i);
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
		    newTabpanel.query();
		}
		else
		{
		    newTabpanel.refresh();
		}

		curTabIndex = newTabIndex;
		curTabpanel = newTabpanel;

		if (curTabpanel instanceof ADSortTab)
		{
			((ADSortTab)curTabpanel).registerAPanel(this);
		}
		else
		{
			if (curTab.getRowCount() == 0 && Env.isAutoNew(ctx, getWindowNo()))
			{
				onNew();
			}
		}

		updateToolbar();

		if (callback != null)
			callback.onCallback(true);
	}

	private void updateToolbar()
	{
		toolbar.enableTabNavigation(curTabIndex > 0,
		        curTabIndex < (adTab.getTabCount() - 1));

		toolbar.getButton("Attachment").setPressed(curTab.hasAttachment());
		toolbar.getButton("Chat").setPressed(curTab.hasChat());
		toolbar.getButton("Find").setPressed(curTab.isQueryActive());

		if (toolbar.isPersonalLock)
		{
			toolbar.lock(curTab.isLocked());
		}

		toolbar.enablePrint(curTab.isPrinted());

        //Deepak-Enabling customize button IDEMPIERE-364
        if(!(curTabpanel instanceof ADSortTab))
        	toolbar.enableCustomize(((ADTabpanel)curTabpanel).isGridView());
        else
        	toolbar.enableCustomize(false);
	}

	/**
	 * @param e
	 * @see DataStatusListener#dataStatusChanged(DataStatusEvent)
	 */
    public void dataStatusChanged(DataStatusEvent e)
    {
    	//ignore non-ui thread event for now.
    	if (Executions.getCurrent() == null)
    		return;

        logger.info(e.getMessage());
        String dbInfo = e.getMessage();
        if (curTab != null && curTab.isQueryActive())
            dbInfo = "[ " + dbInfo + " ]";
        statusBar.setStatusDB(dbInfo, e);

        //  Set Message / Info
        if (e.getAD_Message() != null || e.getInfo() != null)
        {
            StringBuffer sb = new StringBuffer();
            String msg = e.getMessage();
            if (msg != null && msg.length() > 0)
            {
                sb.append(Msg.getMsg(Env.getCtx(), e.getAD_Message()));
            }
            String info = e.getInfo();
            if (info != null && info.length() > 0)
            {
                if (sb.length() > 0 && !sb.toString().trim().endsWith(":"))
                    sb.append(": ");
                sb.append(info);
            }
            if (sb.length() > 0)
            {
                int pos = sb.indexOf("\n");
                if (pos != -1 && pos+1 < sb.length())  // replace CR/NL
                {
                    sb.replace(pos, pos+1, " - ");
            	}
                boolean showPopup = e.isError()
                	|| (!GridTab.DEFAULT_STATUS_MESSAGE.equals(e.getAD_Message()) && !GridTable.DATA_REFRESH_MESSAGE.equals(e.getAD_Message()));
                statusBar.setStatusLine (sb.toString (), e.isError (), showPopup);
            }
        }

        //  Confirm Error
        if (e.isError() && !e.isConfirmed())
        {
        	//focus to error field
        	ADTabpanel tabPanel = (ADTabpanel) getADTab().getSelectedTabpanel();
        	GridField[] fields = curTab.getFields();
        	for (GridField field : fields)
        	{
        		if (field.isError())
        		{
        			tabPanel.setFocusToField(field.getColumnName());
        			break;
        		}
        	}
            e.setConfirmed(true);   //  show just once - if MTable.setCurrentRow is involved the status event is re-issued
        }
        //  Confirm Warning
        else if (e.isWarning() && !e.isConfirmed())
        {
            FDialog.warn(curWindowNo, null, e.getAD_Message(), e.getInfo());
            e.setConfirmed(true);   //  show just once - if MTable.setCurrentRow is involved the status event is re-issued
        }

        //  update Navigation
        boolean firstRow = e.isFirstRow();
        boolean lastRow = e.isLastRow();
        toolbar.enableFirstNavigation(!firstRow && !curTab.isSortTab());
        toolbar.enableLastNavigation(!lastRow && !curTab.isSortTab());

        //  update Change
        boolean changed = e.isChanged() || e.isInserting();
        boolChanges = changed;
        boolean readOnly = curTab.isReadOnly();
        boolean insertRecord = !readOnly;

        if (insertRecord)
        {
            insertRecord = curTab.isInsertRecord();
        }
        toolbar.enableNew(!changed && insertRecord && !curTab.isSortTab());
        toolbar.enableRefresh(!changed);
        toolbar.enableDelete(!changed && !readOnly && !curTab.isSortTab());
        //
        if (readOnly && curTab.isAlwaysUpdateField())
        {
            readOnly = false;
        }
        toolbar.enableIgnore(changed && !readOnly);

        if (changed && !readOnly && !toolbar.isSaveEnable() ) {
        	if (curTab.getRecord_ID() > 0) {
            	if (curTabIndex == 0) {
            		MRecentItem.addModifiedField(ctx, curTab.getAD_Table_ID(),
            				curTab.getRecord_ID(), Env.getAD_User_ID(ctx),
            				Env.getAD_Role_ID(ctx), curTab.getAD_Window_ID(),
            				curTab.getAD_Tab_ID());
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

        toolbar.enableSave(changed && !readOnly);
        //
        //  No Rows
        if (e.getTotalRows() == 0 && insertRecord)
        {
            toolbar.enableNew(true);
            toolbar.enableDelete(false);
        }

        //  Transaction info
        String trxInfo = curTab.getTrxInfo();
        if (trxInfo != null)
        {
            statusBar.setInfo(trxInfo);
        }

        //  Check Attachment
        boolean canHaveAttachment = curTab.canHaveAttachment();       //  not single _ID column
        //
        if (canHaveAttachment && e.isLoading() &&
                curTab.getCurrentRow() > e.getLoadedRows())
        {
            canHaveAttachment = false;
        }
        if (canHaveAttachment && curTab.getRecord_ID() == -1)    //   No Key
        {
            canHaveAttachment = false;
        }
        if (canHaveAttachment)
        {
            toolbar.enableAttachment(true);
            toolbar.getButton("Attachment").setPressed(curTab.hasAttachment());
        }
        else
        {
            toolbar.enableAttachment(false);
        }

        // Check Chat
        boolean canHaveChat = true;
        if (e.isLoading() &&
                curTab.getCurrentRow() > e.getLoadedRows())
        {
            canHaveChat = false;
        }
        if (canHaveChat && curTab.getRecord_ID() == -1)    //   No Key
        {
            canHaveChat = false;
        }
        if (canHaveChat)
        {
            toolbar.enableChat(true);
            toolbar.getButton("Chat").setPressed(curTab.hasChat());
        }
        else
        {
        	toolbar.enableChat(false);
        }

        toolbar.getButton("Find").setPressed(curTab.isQueryActive());

        // Elaine 2008/12/05
        //  Lock Indicator
        if (toolbar.isPersonalLock)
        {
			toolbar.lock(curTab.isLocked());
        }
        //

        adTab.evaluate(e);

        toolbar.enablePrint(curTab.isPrinted());
        toolbar.enableReport(true);
        toolbar.enableExport(!curTab.isSortTab());
        
        //Deepak-Enabling customize button IDEMPIERE-364
        if(!(curTabpanel instanceof ADSortTab))
        	toolbar.enableCustomize(((ADTabpanel)curTabpanel).isGridView());
        toolbar.updateToolBarAndMenuWithRestriction(gridWindow.getAD_Window_ID());
    }

    /**
     * @return boolean
     */
    public boolean isFirstTab()
    {
        int selTabIndex = adTab.getSelectedIndex();
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
					curTab.dataRefreshAll(fireEvent, true);
			        curTabpanel.dynamicDisplay(0);
			        focusToActivePanel();
				}
			});        
    	}
    	else
    	{
    		curTab.dataRefreshAll(fireEvent, true);
	        curTabpanel.dynamicDisplay(0);
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
    	WebDoc doc = gridWindow.getHelpDoc(true);
		SessionManager.getAppDesktop().showURL(doc, "Help", true);
    }

    /**
     * @see ToolbarListener#onNew()
     */
    public void onNew()
    {
        if (!curTab.isInsertRecord())
        {
            logger.warning("Insert Record disabled for Tab");
            return;
        }

        saveAndNavigate(new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) {
				if (result) 
				{
					newRecord = curTab.dataNew(false);
			        if (newRecord)
			        {
			            curTabpanel.dynamicDisplay(0);
			            toolbar.enableNew(false);
			            toolbar.enableDelete(false);
			            toolbar.enableNavigation(false);
			            toolbar.enableTabNavigation(false);
			            toolbar.enableIgnore(true);
			            toolbar.enablePrint(curTab.isPrinted());
			            toolbar.enableReport(true);
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
        if (!curTab.isInsertRecord())
        {
            logger.warning("Insert Record disabled for Tab");
            return;
        }

        newRecord = curTab.dataNew(true);
        if (newRecord)
        {
            curTabpanel.dynamicDisplay(0);
            toolbar.enableNew(false);
            toolbar.enableDelete(false);
            toolbar.enableNavigation(false);
            toolbar.enableTabNavigation(false);
            toolbar.enableIgnore(true);
            toolbar.enablePrint(curTab.isPrinted());
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
        if (curTab == null)
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
        GridField[] findFields = curTab.getFields();
        if (findWindow == null || !findWindow.validate(curTab.getWindowNo(), curTab.getName(),
            curTab.getAD_Table_ID(), curTab.getTableName(),
            curTab.getWhereExtended(), findFields, 1, curTab.getAD_Tab_ID())) {
	        findWindow = new FindWindow (curTab.getWindowNo(), curTab.getName(),
	            curTab.getAD_Table_ID(), curTab.getTableName(),
	            curTab.getWhereExtended(), findFields, 1, curTab.getAD_Tab_ID());
	        
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
					if (!findWindow.isCancel())
			        {
				        MQuery query = findWindow.getQuery();
	
				        //  Confirmed query
				        if (query != null)
				        {
				            m_onlyCurrentRows = false;          //  search history too
				            curTab.setQuery(query);
				            curTabpanel.query(m_onlyCurrentRows, m_onlyCurrentDays, MRole.getDefault().getMaxQueryRecords());   //  autoSize
				        }
	
				        if (findWindow.isCreateNew())
				        	onNew();
				        else
				        	curTab.dataRefresh(false); // Elaine 2008/07/25
			        }
					else
					{
						toolbar.getButton("Find").setPressed(curTab.isQueryActive());
					}
			        focusToActivePanel();
				}
			});
        }
        findWindow.setTitle(null);
        LayoutUtils.openPopupWindow(toolbar, findWindow, "after_start");
	}

    /**
     * @see ToolbarListener#onIgnore()
     */
    public void onIgnore()
    {
    	if (curTab.isSortTab())
    	{
    		curTabpanel.refresh();
    		toolbar.enableIgnore(false);
    	}
    	else
    	{
	        curTab.dataIgnore();
	        curTab.dataRefresh(true);	// update statusbar & toolbar
	        curTabpanel.dynamicDisplay(0);
	        toolbar.enableIgnore(false);
    	}
    	focusToActivePanel();
    }

    /**
     * @see ToolbarListener#onSave()
     */
    public void onSave()
    {
    	onSave(true, false, new Callback<Boolean>() {
			@Override
			public void onCallback(Boolean result) 
			{
				if (result)
				{
		    		String statusLine = statusBar.getStatusLine();
		    		curTab.dataRefreshAll(true, true);
		    		statusBar.setStatusLine(statusLine);		    		
		    	}				
				focusToActivePanel();
			}
		});    	    	
    }

    /**
     * @param onSaveEvent
     */
    private void onSave(final boolean onSaveEvent, final boolean onNavigationEvent, final Callback<Boolean> callback)
    {
    	final boolean newRecord = (curTab.getRecord_ID() <= 0);
    	final boolean wasChanged = toolbar.isSaveEnable();
    	if (curTab.isSortTab())
    	{
    		if (onNavigationEvent)
    			((ADSortTab)curTabpanel).unregisterPanel();
    		else
    			((ADSortTab)curTabpanel).saveData();
    		if (!onNavigationEvent)
    		{
	    		toolbar.enableSave(false);	//	set explicitly
	    		toolbar.enableIgnore(false);
    		}
    		if (callback != null)
    			callback.onCallback(true);
    	}
    	else
    	{
    		if ((curTab.getCommitWarning() != null && curTab.getCommitWarning().trim().length() > 0) ||
    			(!Env.isAutoCommit(ctx, curWindowNo) && onNavigationEvent))
    		{
    			FDialog.ask(curWindowNo, this.getComponent(), "SaveChanges?", curTab.getCommitWarning(), new Callback<Boolean>() {

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
		boolean retValue = curTab.dataSave(onSaveEvent);

		if (!retValue)
		{
			showLastError();
			if (callback != null)
				callback.onCallback(false);
			return;
		} else if (!onSaveEvent) //need manual refresh
		{
			curTab.setCurrentRow(curTab.getCurrentRow());
		}
		
		if (!navigationEvent) {
			curTabpanel.dynamicDisplay(0);
			curTabpanel.afterSave(onSaveEvent);
		}

		if (wasChanged) {
		    if (newRecord) {
		    	if (curTab.getRecord_ID() > 0) {
		        	if (curTabIndex == 0) {
			        	MRecentItem.addModifiedField(ctx, curTab.getAD_Table_ID(),
			        			curTab.getRecord_ID(), Env.getAD_User_ID(ctx),
			        			Env.getAD_Role_ID(ctx), curTab.getAD_Window_ID(),
			        			curTab.getAD_Tab_ID());
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
		    	if (curTabIndex == 0) {
		        	MRecentItem.touchUpdatedRecord(ctx, curTab.getAD_Table_ID(),
		        			curTab.getRecord_ID(), Env.getAD_User_ID(ctx));
		    	} else {
		    		GridTab mainTab = gridWindow.getTab(0);
		    		if (mainTab != null) {
			        	MRecentItem.touchUpdatedRecord(ctx, mainTab.getAD_Table_ID(),
			        			mainTab.getRecord_ID(), Env.getAD_User_ID(ctx));
		    		}
		    	}
		    }
		}

		if (callback != null)
			callback.onCallback(true);
	}

	private void showLastError() {
		String msg = CLogger.retrieveErrorString(null);
		if (msg != null)
		{
			statusBar.setStatusLine(Msg.getMsg(Env.getCtx(), msg), true, true);
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
		    		curTab.dataRefreshAll(true, true);
		    		onNew();
		    	}
			}
		});    	
    }

    /**
     * @see ToolbarListener#onDelete()
     */
    public void onDelete()
    {
        if (curTab.isReadOnly())
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
		            curTab.dataDelete();
		            
		            curTabpanel.dynamicDisplay(0);
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
		if (curTab.isReadOnly())
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

		final Listbox listbox = new Listbox();
		listbox.setHeight("400px");

		// Display the first 5 fields data exclude Organization, Client and YesNo field data
		Vector<String> columnNames = new Vector<String>();
		GridField[] fields = curTab.getFields();
		if(curTab.getField("DocumentNo")!=null){
			columnNames.add(curTab.getField("DocumentNo").getColumnName());
		}
		if(curTab.getField("Line")!=null){
			columnNames.add(curTab.getField("Line").getColumnName());
		}
		if(curTab.getField("Value")!=null){
			columnNames.add(curTab.getField("Value").getColumnName());
		}
		if(curTab.getField("Name")!=null){
			columnNames.add(curTab.getField("Name").getColumnName());
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

		Vector<String> data = new Vector<String>();
		int noOfRows = curTab.getRowCount();
		for(int i=0; i<noOfRows; i++)
		{
			StringBuffer displayValue = new StringBuffer();
			if("".equals(curTab.getKeyColumnName()))
			{
				ArrayList<String> parentColumnNames = curTab.getParentColumnNames();
				for (Iterator<String> iter = parentColumnNames.iterator(); iter.hasNext();)
				{
					String columnName = iter.next();
					GridField field = curTab.getField(columnName);
					if(field.isLookup()){
						Lookup lookup = field.getLookup();
						if (lookup != null){
							displayValue = displayValue.append(lookup.getDisplay(curTab.getValue(i,columnName))).append(" | ");
						} else {
							displayValue = displayValue.append(curTab.getValue(i,columnName)).append(" | ");
						}
					} else {
						displayValue = displayValue.append(curTab.getValue(i,columnName)).append(" | ");
					}
				}
			} else {
				displayValue = displayValue.append(curTab.getValue(i,curTab.getKeyColumnName()));
			}

			int count = 0;
			for(int j=0; j < columnNames.size() && count < 5; j++)
			{
				Object value = curTab.getValue(i, columnNames.get(j));
				if(value == null) continue; // skip when value is null
				String text = value.toString().trim();
				if(text.length() == 0) continue; // skip when value is empty
				GridField field = curTab.getField(columnNames.get(j));
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
		div.appendChild(hbox);

		Button btnOk = new Button();
		btnOk.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "OK")));
		btnOk.setImage("/images/Ok16.png");
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
										logger.fine((String) li.getValue());
								}
							}

							int[] indices = listbox.getSelectedIndices();
							Arrays.sort(indices);
							int offset = 0;
							for (int i = 0; i < indices.length; i++)
							{
								curTab.navigate(indices[i]-offset);
								if (curTab.dataDelete())
								{
									offset++;
								}
							}
							curTabpanel.dynamicDisplay(0);

				            messagePanel.dispose();
				        } else {
							logger.fine("cancel");
						}
					}
					
				});		        
			}
		});
		hbox.appendChild(btnOk);

		Button btnCancel = new Button();
		btnCancel.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Cancel")));
		btnCancel.setImage("/images/Cancel16.png");
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

		messagePanel.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		messagePanel.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				focusToActivePanel();
			}
		});
		AEnv.showWindow(messagePanel);		
	}
	//

    /**
     * @see ToolbarListener#onPrint()
     */
	public void onPrint() {
		//Get process defined for this tab
		final int AD_Process_ID = curTab.getAD_Process_ID();
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
					int table_ID = curTab.getAD_Table_ID();
					int record_ID = curTab.getRecord_ID();

					ProcessModalDialog dialog = new ProcessModalDialog(AbstractADWindowPanel.this, getWindowNo(), AD_Process_ID,table_ID, record_ID, true);
					if (dialog.isValid()) {
						dialog.setPosition("center");
						dialog.setPage(AbstractADWindowPanel.this.getComponent().getPage());
						dialog.doHighlighted();
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
		if (!MRole.getDefault().isCanReport(curTab.getAD_Table_ID()))
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
			int record_ID = curTab.getRecord_ID();
			if (record_ID <= 0)
				return;

			//	Query
			MQuery query = new MQuery();
			//	Current row
			String link = curTab.getKeyColumnName();
			//	Link for detail records
			if (link.length() == 0)
				link = curTab.getLinkColumnName();
			if (link.length() != 0)
			{
				if (link.endsWith("_ID"))
					query.addRestriction(link, MQuery.EQUAL,
						new Integer(Env.getContextAsInt(ctx, curWindowNo, link)));
				else
					query.addRestriction(link, MQuery.EQUAL,
						Env.getContext(ctx, curWindowNo, link));
			}
			new WZoomAcross(toolbar.getEvent().getTarget(), curTab
					.getTableName(), curTab.getAD_Window_ID(), query);
		}
	}

	// Elaine 2008/07/17
	/**
     * @see ToolbarListener#onActiveWorkflows()
     */
	public void onActiveWorkflows() {
		if (toolbar.getEvent() != null)
		{
			if (curTab.getRecord_ID() <= 0)
				return;
			else
				AEnv.startWorkflowProcess(curTab.getAD_Table_ID(), curTab.getRecord_ID());
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
			if (curTab.getRecord_ID() <= 0)
				return;

			int C_BPartner_ID = 0;
			Object bpartner = curTab.getValue("C_BPartner_ID");
			if(bpartner != null)
				C_BPartner_ID = Integer.valueOf(bpartner.toString());

			new WRequest(toolbar.getEvent().getTarget(), curTab.getAD_Table_ID(), curTab.getRecord_ID(), C_BPartner_ID);
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
			if (curTab.getRecord_ID() <= 0)
				return;

			new WArchive(toolbar.getEvent().getTarget(), curTab.getAD_Table_ID(), curTab.getRecord_ID());
		}
	}

	//

	@Override
	public void onExport() {
		ExportAction action = new ExportAction(this);
		action.export();
	}

	/**************************************************************************
	 *	Start Button Process
	 *  @param vButton button
	 */
	private void actionButton (final WButtonEditor wButton)
	{
		if (curTab.hasChangedCurrentTabAndParents()) {
			String msg = CLogger.retrieveErrorString("Please ReQuery Window");
			FDialog.error(curWindowNo, parent, null, msg);
			return;
		}

		logger.info(wButton.toString());

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

		if (curTab.needSave(true, false))
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
	private void actionButton0 (String col, final WButtonEditor wButton)
	{
		boolean startWOasking = false;
		final int table_ID = curTab.getAD_Table_ID();

		//	Record_ID

		int record_ID = curTab.getRecord_ID();

		//	Record_ID - Language Handling

		if (record_ID == -1 && curTab.getKeyColumnName().equals("AD_Language"))
			record_ID = Env.getContextAsInt (ctx, curWindowNo, "AD_Language_ID");

		//	Record_ID - Change Log ID

		if (record_ID == -1
			&& (wButton.getProcess_ID() == PROCESS_AD_CHANGELOG_UNDO || wButton.getProcess_ID() == PROCESS_AD_CHANGELOG_REDO))
		{
			Integer id = (Integer)curTab.getValue("AD_ChangeLog_ID");
			record_ID = id.intValue();
		}

		//	Ensure it's saved

		if (record_ID == -1 && curTab.getKeyColumnName().endsWith("_ID"))
		{
			FDialog.error(curWindowNo, parent, "SaveErrorRowNotFound");
			return;
		}

		boolean isProcessMandatory = false;

		//	Pop up Payment Rules
		if (col.equals("PaymentRule"))
		{
			final WPayment vp = new WPayment(curWindowNo, curTab, wButton);
			if (vp.isInitOK())		//	may not be allowed
			{
				vp.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
				vp.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						if (vp.needSave())
						{
							onSave(false, false, new Callback<Boolean>() {

								@Override
								public void onCallback(Boolean result) {
									onRefresh(false, false);
								}
								
							});							
						}						
					}
				});
				AEnv.showWindow(vp);
			}			
			return;
		} // PaymentRule

		//	Pop up Document Action (Workflow)

		else if (col.equals("DocAction"))
		{
			final WDocActionPanel win = new WDocActionPanel(curTab);
			if (win.getNumberOfOptions() == 0)
			{
				logger.info("DocAction - No Options");
				return;
			}
			else
			{
				final int recordIdParam = record_ID;
				win.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
				win.setPosition("center");			
				win.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
					public void onEvent(Event event) throws Exception {						
						if (!win.isStartProcess()) {							
							return;
						}
						boolean startWOasking = true;
						boolean isProcessMandatory = true;
						executeButtonProcess(wButton, startWOasking, table_ID, recordIdParam, isProcessMandatory);
					}
				});
				AEnv.showWindow(win);			
				return;
			}			
		} // DocAction

		//  Pop up Create From

		else if (col.equals("CreateFrom"))
		{
			ICreateFrom cf = WCreateFromFactory.create(curTab);

			if(cf != null)
			{
				if(cf.isInitOK())
				{
					final WCreateFromWindow window = (WCreateFromWindow) cf.getWindow();
					window.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
					window.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
						@Override
						public void onEvent(Event event) throws Exception {
							if (!window.isCancel()) {
								curTab.dataRefresh();
							}
						}
					});
					cf.showWindow();					
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
				tableId = curTab.getAD_Table_ID();
				recordId = curTab.getRecord_ID();
			}

			//  Check Post Status
			final Object ps = curTab.getValue("Posted");

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

							if (error != null)
								statusBar.setStatusLine(error, true, true);

							onRefresh(false, false);
						}						
					}
				});
			}
			return;
		}   //  Posted

		executeButtonProcess(wButton, startWOasking, table_ID, record_ID,
				isProcessMandatory);
	} // actionButton

	private void executeButtonProcess(final WButtonEditor wButton,
			final boolean startWOasking, final int table_ID, final int record_ID,
			boolean isProcessMandatory) {
		/**
		 *  Start Process ----
		 */

		logger.config("Process_ID=" + wButton.getProcess_ID() + ", Record_ID=" + record_ID);

		if (wButton.getProcess_ID() == 0)
		{
			if (isProcessMandatory)
			{
				FDialog.error(curWindowNo, null, null, Msg.parseTranslation(ctx, "@NotFound@ @AD_Process_ID@"));
			}
			return;
		}

		//	Save item changed

		if (curTab.needSave(true, false))
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

	private void executeButtonProcess0(final WButtonEditor wButton,
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
			ADForm form = ADForm.openForm(adFormID);
			form.setProcessInfo(pi);
			form.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
			form.setAttribute(Window.INSERT_POSITION_KEY, Window.INSERT_NEXT);
			SessionManager.getAppDesktop().showWindow(form);
			onRefresh(false, false);
		}
		else
		{
			ProcessModalDialog dialog = new ProcessModalDialog(this, curWindowNo, wButton.getProcess_ID(), table_ID, record_ID, startWOasking);

			if (dialog.isValid())
			{
				dialog.setWidth("500px");
				dialog.setVisible(true);
				dialog.setPosition("center");
				dialog.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
				AEnv.showWindow(dialog);
			}
			else
			{
				onRefresh(false, false);
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
				String error = processButtonCallout((WButtonEditor)event.getSource());
				if (error != null && error.trim().length() > 0)
				{
					statusBar.setStatusLine(error, true);
					return;
				}
				actionButton((WButtonEditor)event.getSource());
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
	private String processButtonCallout (WButtonEditor button)
	{
		GridField field = curTab.getField(button.getColumnName());
		return curTab.processCallout(field);
	}	//	processButtonCallout

	/**
	 *
	 * @return IADTab
	 */
	public IADTab getADTab() {
		return adTab;
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
		&& pi.getAD_Process_ID() != curTab.getAD_Process_ID()
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
		statusBar.setStatusLine(pi.getSummary(), pi.isError(), true);
		//	Get Log Info
		ProcessInfoUtil.setLogFromDB(pi);
		String logInfo = pi.getLogInfo();
		if (logInfo.length() > 0)
			FDialog.info(curWindowNo, this.getComponent(), Env.getHeader(ctx, curWindowNo),
				pi.getTitle() + "<br>" + logInfo);
	}

	/**
	 *
	 * @return toolbar instance
	 */
	public CWindowToolbar getToolbar() {
		return toolbar;
	}

	/**
	 * @return active grid tab
	 */
	public GridTab getActiveGridTab() {
		return curTab;
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
		
		CustomizeGridViewDialog.showCustomize(0, curTab.getAD_Tab_ID(), columnsWidth,gridFieldIds,tabPanel.getGridView());			

	}
}
