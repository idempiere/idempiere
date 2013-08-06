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

package org.adempiere.webui.window;

import static org.compiere.model.SystemIDs.REFERENCE_YESNO;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;
import java.util.regex.Pattern;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListCell;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBar;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.part.MultiTabPart;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.GridTab;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MUserQuery;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.SecureEngine;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Datebox;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Vlayout;

/**
 *  This class is based on org.compiere.apps.search.Find written by Jorg Janke.
 *  Find/Search Records.
 *
 *  @author     Sendy Yagambrum
 *  @date       June 27, 2007
 */
public class FindWindow extends Window implements EventListener<Event>, ValueChangeListener, DialogEvents
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3901459797939709594L;

	// values and label for history combo
	private static final String HISTORY_DAY_ALL = "All";
	private static final String HISTORY_DAY_YEAR = "Year";
	private static final String HISTORY_DAY_MONTH = "Month";
	private static final String HISTORY_DAY_WEEK = "Week";
	private static final String HISTORY_DAY_DAY = "Day";
	private static final String HISTORY_LABEL= "History";
	/** Main Window for the Lookup Panel   */
    private MultiTabPart winMain;
    /**  Simple Window Tab  */
    private Window winLookupRecord;
    /** Advanced Window Tab */
    private Window winAdvanced;
    //
    private Combobox fQueryName;
    //
    private Listbox advancedPanel;
    /** container of Simple Window contents   */
    private Grid contentSimple;
    /** Target Window No            */
    private int             m_targetWindowNo;
    /** Table ID                    */
    private int             m_AD_Table_ID;
    /** Table Name                  */
    private String          m_tableName;
    /** Where                       */
    private String          m_whereExtended;
    /** Search Fields               */
    private GridField[]     m_findFields;
    /** Resulting query             */
    private MQuery          m_query = null;
    /** Is cancel ?                 */
    private boolean         m_isCancel = false; // teo_sarca [ 1708717 ]
    /** Logger          */
    private static CLogger log = CLogger.getCLogger(FindWindow.class);
    /** Number of records           */
    private int             m_total;
    private PreparedStatement   m_pstmt;
    //
    /** List of WEditors            */
    private ArrayList<WEditor>          m_sEditors = new ArrayList<WEditor>();
    /** For Grid Controller         */
    public static final int     TABNO = 99;
    /** Length of Fields on first tab   */
    public static final int     FIELDLENGTH = 20;

    private int m_AD_Tab_ID = 0;
	private MUserQuery[] userQueries;
	private Rows contentSimpleRows;
	private boolean m_createNew = false;
	private boolean isvalid = true;
	private int m_minRecords;
	private String m_title;
	private ToolBarButton btnSave;
	private Label msgLabel;

	/** Index ColumnName = 0		*/
	public static final int		INDEX_COLUMNNAME = 0;
	/** Index Operator = 1			*/
	public static final int		INDEX_OPERATOR = 1;
	/** Index Value = 2				*/
	public static final int		INDEX_VALUE = 2;
	/** Index Value2 = 3			*/
	public static final int		INDEX_VALUE2 = 3;
	
	/** Index AndOr = 4		*/
	public static final int		INDEX_ANDOR = 4;
	/** Index LeftBracket = 5		*/
	public static final int		INDEX_LEFTBRACKET = 5;
	/** Index RightBracket = 6		*/
	public static final int		INDEX_RIGHTBRACKET = 6;
	/** Index History		*/
	public static final int		INDEX_HISTORY = 1;
	
	/** Search messages using translation */
	private String				m_sNew;	


	private static final String FIELD_SEPARATOR = "<^>";
	private static final String SEGMENT_SEPARATOR = "<~>";
	private static final String HISTORY_SEPARATOR = "<#>";
	
	private Combobox historyCombo = new Combobox();

	private Properties m_findCtx;
	
	private static final String ON_POST_VISIBLE_ATTR = "onPostVisible.Event.Posted";

    /**
     * FindPanel Constructor
     * @param targetWindowNo targetWindowNo
     * @param title title
     * @param AD_Table_ID AD_Table_ID
     * @param tableName tableName
     * @param whereExtended whereExtended
     * @param findFields findFields
     * @param minRecords minRecords
     * @param adTabId
    **/
    public FindWindow (int targetWindowNo, String title,
            int AD_Table_ID, String tableName, String whereExtended,
            GridField[] findFields, int minRecords, int adTabId)
    {
        m_targetWindowNo = targetWindowNo;
        m_title = title;
        m_AD_Table_ID = AD_Table_ID;
        m_tableName = tableName;
        m_whereExtended = whereExtended;
        m_findFields = findFields;
        m_sNew = "** ".concat(Msg.getMsg(Env.getCtx(), "New Query")).concat(" **");		
        m_AD_Tab_ID = adTabId;
        m_minRecords = minRecords;
        m_isCancel = true;
        //
        m_findCtx = new Properties(Env.getCtx());
        
        this.setBorder("normal");
        this.setShadow(false);
        this.setWidth("900px");
        this.setHeight("350px");
        this.setTitle(Msg.getMsg(Env.getCtx(), "Find").replaceAll("&", "") + ": " + title);
        this.setClosable(false);
        this.setSizable(true);  
        this.setMaximizable(false);
        
        this.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "findWindow");
        this.setId("findWindow_"+targetWindowNo);
        LayoutUtils.addSclass("find-window", this);
    }
    
    public boolean initialize() 
    {
    	m_query = new MQuery (m_tableName);
        m_query.addRestriction(m_whereExtended);
        //  Required for Column Validation
        Env.setContext(Env.getCtx(), m_targetWindowNo, "Find_Table_ID", m_AD_Table_ID);
        //
        initPanel();
        initFind();
        initFindAdvanced();

        if (m_total < m_minRecords)
        {
            return false;
        }
        return true;
    }
    
    public boolean validate(int targetWindowNo, String title,
            int AD_Table_ID, String tableName, String whereExtended,
            GridField[] findFields, int minRecords, int adTabId)
    {
    	if (m_targetWindowNo != targetWindowNo) return false;
    	if ((title == null && m_title != null) || (title != null && m_title == null) || !(title.equals(m_title))) return false;
    	if (AD_Table_ID != m_AD_Table_ID) return false;
    	if ((tableName == null && m_tableName != null) || (tableName != null && m_tableName == null) || !(tableName.equals(m_tableName))) return false;
    	if ((whereExtended == null && m_whereExtended != null) || (whereExtended != null && m_whereExtended == null) || !(whereExtended.equals(m_whereExtended))) return false;
    	if (adTabId != m_AD_Tab_ID) return false;
    	if ((findFields == null && m_findFields != null) || (findFields != null && m_findFields == null) || (findFields.length != m_findFields.length)) return false;
    	if (findFields != null && findFields.length > 0) 
    	{
    		for(int i = 0; i < findFields.length; i++)
    		{
    			if (findFields[i].getAD_Field_ID() != m_findFields[i].getAD_Field_ID()) return false;
    		}
    	}
    	
    	m_minRecords = minRecords;
    	m_total = getNoOfRecords(null, false);
    	if (m_total < m_minRecords)
        {
            return false;
        }
    	
    	m_query = new MQuery (m_tableName);
        m_query.addRestriction(m_whereExtended);
        
    	return true;
    }
    
    /**
     * initialise lookup record tab
     *
    **/
    private void initSimple()
    {
        Button btnNew = ButtonFactory.createNamedButton(ConfirmPanel.A_NEW);
        btnNew.setId("btnNew");
        btnNew.addEventListener(Events.ON_CLICK,this);

        Button btnOk = ButtonFactory.createNamedButton(ConfirmPanel.A_OK);
        btnOk.setName("btnOkSimple");
        btnOk.setId("btnOk");
        btnOk.addEventListener(Events.ON_CLICK,this);

        Button btnCancel = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL);
        btnCancel.setId("btnCancel");
        btnCancel.addEventListener(Events.ON_CLICK,this);

        Panel pnlButtonRight = new Panel();
        pnlButtonRight.appendChild(btnOk);
        pnlButtonRight.appendChild(btnCancel);
        pnlButtonRight.setStyle("text-align:right");
        pnlButtonRight.setWidth("100%");
        pnlButtonRight.setHflex("1");

        Panel pnlButtonLeft = new Panel();
        pnlButtonLeft.appendChild(btnNew);
        pnlButtonLeft.setHflex("1");

        Hbox hboxButton = new Hbox();
        hboxButton.appendChild(pnlButtonLeft);
        hboxButton.appendChild(pnlButtonRight);
        hboxButton.setWidth("100%");

        contentSimple = new Grid();
        contentSimple.setId("contentSimple");
        contentSimple.setStyle("width: 100%; position: relative");
        contentSimple.makeNoStrip();
        contentSimple.setHflex("1");
        contentSimple.setSizedByContent(true);
        
        Columns columns = new Columns();
        Column column = new Column();
        column.setAlign("right");
        column.setWidth("30%");
        columns.appendChild(column);
        
        column = new Column();
        column.setAlign("left");
        column.setWidth("50%");
        columns.appendChild(column);
        
        column = new Column();
        column.setWidth("20%");
        columns.appendChild(column);
        
        contentSimple.appendChild(columns);

        contentSimpleRows = new Rows();
        contentSimple.appendChild(contentSimpleRows);
        contentSimple.setVflex(true);

        Borderlayout layout = new Borderlayout();
        layout.setHflex("1");
        layout.setVflex("1");
        winLookupRecord.appendChild(layout);

        Center center = new Center();
        layout.appendChild(center);
        center.appendChild(contentSimple);
        contentSimple.setVflex("1");
		contentSimple.setHflex("1");

        South south = new South();
        layout.appendChild(south);
        south.appendChild(hboxButton);

        winLookupRecord.setWidth("100%");
        winLookupRecord.setHeight("100%");
        winLookupRecord.addEventListener(Events.ON_OK, this);
        LayoutUtils.addSclass("find-window-simple", winLookupRecord);

    }   //  initSimple

    /**
     * initialise Advanced Tab
     *
    **/
    private void initAdvanced()
    {
        ToolBarButton btnNew = new ToolBarButton();
        btnNew.setImage(ThemeManager.getThemeResource("images/New24.png"));
        btnNew.setAttribute("name", "btnNewAdv");
        btnNew.addEventListener(Events.ON_CLICK, this);

        ToolBarButton btnDelete = new ToolBarButton();
        btnDelete.setAttribute("name","btnDeleteAdv");
        btnDelete.setImage(ThemeManager.getThemeResource("images/Delete24.png"));
        btnDelete.addEventListener(Events.ON_CLICK, this);

        Button btnOk = ButtonFactory.createNamedButton(ConfirmPanel.A_OK);
        btnOk.setName("btnOkAdv");
        btnOk.addEventListener(Events.ON_CLICK, this);

        Button btnCancel = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL);
        btnCancel.addEventListener(Events.ON_CLICK, this);

        Panel pnlButtonRight = new Panel();
        pnlButtonRight.appendChild(btnOk);
        pnlButtonRight.appendChild(btnCancel);
        pnlButtonRight.setStyle("text-align: right");

        ToolBar toolBar = new ToolBar();
        toolBar.appendChild(btnNew);
        toolBar.appendChild(btnDelete);
        toolBar.setWidth("100%");

        fQueryName.addEventListener(Events.ON_SELECT, this);

        Hbox confirmPanel = new Hbox();
        confirmPanel.appendChild(pnlButtonRight);
        confirmPanel.setWidth("100%");
        confirmPanel.setPack("end");

        advancedPanel = new Listbox();
        advancedPanel.setSizedByContent(true);
        ListHead listhead = new ListHead();
        listhead.setSizable(true);

        ListHeader lstHAndOr = new ListHeader();
        lstHAndOr.setLabel(Msg.getMsg(Env.getCtx(), "And/Or"));
        lstHAndOr.setWidth("10%");

        ListHeader lstHLeftBracket = new ListHeader();
        lstHLeftBracket.setLabel("(");
        lstHLeftBracket.setWidth("6%");

        ListHeader lstHColumn = new ListHeader();
        lstHColumn.setLabel(Msg.translate(Env.getCtx(), "AD_Column_ID"));
        lstHColumn.setWidth("30%");

        ListHeader lstHOperator = new ListHeader();
        lstHOperator.setLabel(Msg.getMsg(Env.getCtx(), "Operator"));

        ListHeader lstHQueryValue = new ListHeader();
        lstHQueryValue.setLabel(Msg.getMsg(Env.getCtx(), "QueryValue"));
        lstHQueryValue.setWidth("24%");

        ListHeader lstHQueryTo = new ListHeader();
        lstHQueryTo.setLabel(Msg.getMsg(Env.getCtx(), "QueryValue2"));
        lstHQueryTo.setWidth("20%");

        ListHeader lstHRightBracket = new ListHeader();
        lstHRightBracket.setLabel(")");
        lstHRightBracket.setWidth("6%");

        listhead.appendChild(lstHAndOr);
        listhead.appendChild(lstHLeftBracket);

        listhead.appendChild(lstHColumn);
        listhead.appendChild(lstHOperator);
        listhead.appendChild(lstHQueryValue);
        listhead.appendChild(lstHQueryTo);
        listhead.appendChild(lstHRightBracket);
        advancedPanel.appendChild(listhead);
        advancedPanel.setVflex(true);
        
        

        Borderlayout layout = new Borderlayout();
        layout.setHflex("1");
        layout.setVflex("1");
        winAdvanced.appendChild(layout);
        
        North north =new North();
        layout.appendChild(north);        
        north.appendChild(toolBar);
       
        toolBar.setVflex("0");

        Center center = new Center();
        layout.appendChild(center);
        center.appendChild(advancedPanel);
        advancedPanel.setVflex("1");
        advancedPanel.setHflex("1");

        South south = new South();
        layout.appendChild(south);
        south.appendChild(confirmPanel);

        winAdvanced.setHeight("100%");
        winAdvanced.setWidth("99%");
        winAdvanced.addEventListener(Events.ON_OK,this);
        LayoutUtils.addSclass("find-window-advanced", winAdvanced);

    } // initAdvanced

    /**
     * initialise Main Window
     *
    **/
    private void initPanel()
    {
    	setShadow(true);
    	
    	Vlayout layout = new Vlayout();
    	layout.setStyle("height: 100%; width: 100%; position: relative;");
    	layout.setVflex("1");
    	this.appendChild(layout);
    	
    	Div div = new Div();
    	div.setVflex("0");
    	layout.appendChild(div);
    	
    	btnSave = new ToolBarButton();
        btnSave.setAttribute("name","btnSaveAdv");
        btnSave.setImage(ThemeManager.getThemeResource("images/Save24.png"));
        btnSave.addEventListener(Events.ON_CLICK, this);
        btnSave.setDisabled(true);
        btnSave.setId("btnSave");
        btnSave.setStyle("vertical-align: middle;");

        fQueryName = new Combobox();
        fQueryName.setTooltiptext(Msg.getMsg(Env.getCtx(),"QueryName"));
		fQueryName.setReadonly(true);
		fQueryName.setId("savedQueryCombo");

		//user query
		userQueries = MUserQuery.get(Env.getCtx(), m_AD_Tab_ID);
		for (int i = 0; i < userQueries.length; i++)
			fQueryName.appendItem(userQueries[i].getName());
		fQueryName.setValue("");
		fQueryName.addEventListener(Events.ON_SELECT, this);
		
		Label label = new Label(Msg.getMsg(Env.getCtx(), "SavedQuery"));
		label.setStyle("vertical-align: middle;");
		div.appendChild(label);
		div.appendChild(fQueryName);
        div.appendChild(btnSave);
        
        fQueryName.setStyle("margin-left: 3px; margin-right: 3px; position: relative; vertical-align: middle;");
        
        msgLabel = new Label("");
        msgLabel.setStyle("margin-left: 10px; margin-right: 20px; vertical-align: middle;");
        div.appendChild(msgLabel);

        // adding history combo
        prepareHistoryCombo();
        Label labelHistory = new Label(Msg.getMsg(Env.getCtx(), HISTORY_LABEL));
        labelHistory.setStyle("vertical-align: middle;");
        div.appendChild(labelHistory);
        div.appendChild(historyCombo);
        historyCombo.setStyle("margin-left: 3px; margin-right: 3px; position: relative; vertical-align: middle;");

        winMain = new MultiTabPart();
        winMain.createPart(layout);
        winMain.getComponent().setStyle("position: relative; margin-left: auto; margin-right: auto; margin-top: 3px; margin-bottom: 3px;");
        winMain.getComponent().setVflex("1");
        winMain.getComponent().addEventListener(Events.ON_SELECT, this);
        winAdvanced = new Window();
        winLookupRecord = new Window();
        Tabpanel tabPanel = new Tabpanel();
        tabPanel.setStyle("height: 100%; width: 99%; padding-right: 2px; margin: auto;");
        tabPanel.appendChild(winLookupRecord);
        tabPanel.setId("simpleSearch");
        winMain.addTab(tabPanel, Msg.getMsg(Env.getCtx(), "Find").replaceAll("&", ""),false, true);
        tabPanel = new Tabpanel();
        tabPanel.setStyle("height: 100%; width: 100%");
        tabPanel.appendChild(winAdvanced);
        tabPanel.setId("advancedSearch");
        winMain.addTab(tabPanel, Msg.getMsg(Env.getCtx(), "Advanced").replaceAll("&", ""), false, false);
        initSimple();
        initAdvanced();

    } // initPanel
    
    
    /**
     * preparing combo of history
     */
    private void prepareHistoryCombo()
    {
    	historyCombo.setAutodrop(true);
    	historyCombo.setAutocomplete(false);
    	historyCombo.setButtonVisible(true);
    	historyCombo.setReadonly(true);
    	historyCombo.setId("historyCombo");
    	historyCombo.appendItem(" ", "");
    	historyCombo.appendItem((Msg.getMsg(Env.getCtx(), HISTORY_DAY_ALL)),HISTORY_DAY_ALL);
    	historyCombo.appendItem((Msg.getMsg(Env.getCtx(), HISTORY_DAY_YEAR)), HISTORY_DAY_YEAR);
    	historyCombo.appendItem((Msg.getMsg(Env.getCtx(), HISTORY_DAY_MONTH)), HISTORY_DAY_MONTH);
    	historyCombo.appendItem((Msg.getMsg(Env.getCtx(), HISTORY_DAY_WEEK)), HISTORY_DAY_WEEK);
    	historyCombo.appendItem((Msg.getMsg(Env.getCtx(), HISTORY_DAY_DAY)), HISTORY_DAY_DAY);
    }

    /**
     *  Dynamic Init.6
     *  Set up GridController
    **/
    private void initFind()
    {
        log.config("");
        
        ArrayList<GridField> gridFieldList = new ArrayList<GridField>();
        //  Get Info from target Tab
        for (int i = 0; i < m_findFields.length; i++)
        {
            GridField mField = m_findFields[i];

            if (mField.isSelectionColumn()) {
    			if (mField.getVO().displayType == DisplayType.YesNo) {
    				// Make Yes-No searchable as list
    				GridFieldVO vo = mField.getVO();
    				GridFieldVO ynvo = vo.clone(vo.ctx, vo.WindowNo, vo.TabNo, vo.AD_Window_ID, vo.AD_Tab_ID, vo.tabReadOnly);
    				ynvo.IsDisplayed = true;
    				ynvo.displayType = DisplayType.List;
    				ynvo.AD_Reference_Value_ID = REFERENCE_YESNO;

    				ynvo.lookupInfo = MLookupFactory.getLookupInfo (ynvo.ctx, ynvo.WindowNo, ynvo.AD_Column_ID, ynvo.displayType,
    						Env.getLanguage(ynvo.ctx), ynvo.ColumnName, ynvo.AD_Reference_Value_ID,
    						ynvo.IsParent, ynvo.ValidationCode);

    				GridField ynfield = new GridField(ynvo);

    				// replace the original field by the YN List field
    				m_findFields[i] = ynfield;
    				mField = ynfield;
    			} else if  ( mField.getVO().displayType == DisplayType.Button ) {
    				// Make Buttons searchable
    				GridFieldVO vo = mField.getVO();
    				if ( vo.AD_Reference_Value_ID > 0 )
    				{
    					GridFieldVO postedvo = vo.clone(vo.ctx, vo.WindowNo, vo.TabNo, vo.AD_Window_ID, vo.AD_Tab_ID, vo.tabReadOnly);
    					postedvo.IsDisplayed = true;
    					postedvo.displayType = DisplayType.List;

    					postedvo.lookupInfo = MLookupFactory.getLookupInfo (postedvo.ctx, postedvo.WindowNo, postedvo.AD_Column_ID, postedvo.displayType,
    							Env.getLanguage(postedvo.ctx), postedvo.ColumnName, postedvo.AD_Reference_Value_ID,
    							postedvo.IsParent, postedvo.ValidationCode);

    					GridField postedfield = new GridField(postedvo);

    					// replace the original field by the Posted List field
    					m_findFields[i] = postedfield;
    					mField = postedfield;
    				}
    			} else {
    				// clone the field and clean gridtab - IDEMPIERE-1105
    		        GridField findField = (GridField) mField.clone(m_findCtx);        
    		        findField.setGridTab(null);
					m_findFields[i] = findField;
    				mField = findField;
    			}
            	gridFieldList.add(mField); 
            } // isSelectionColumn

        }   //  for all target tab fields

       
       // added comparator on sequence of selection column for IDEMPIERE-377
        Collections.sort(gridFieldList, new Comparator<GridField>() {
			@Override
			public int compare(GridField o1, GridField o2) {
				return o1.getSeqNoSelection()-o2.getSeqNoSelection();
			}
		});
        
        // adding sorted columns
        for(GridField field:gridFieldList){
        	addSelectionColumn (field);
		} 
        
        gridFieldList = null;
        m_total = getNoOfRecords(null, false);

    }   //  initFind

    /**
     *  initialise Advanced tab
    **/
    private void initFindAdvanced()
    {
        log.config("");
        createFields();
		refreshUserQueries(); //Initializes and sets fQueryName		
    }   //  initFindAdvanced

    /**
     * create respective fields in the advanced window tab
     *
    **/
    private void createFields()
    {
        List<?> rowList = advancedPanel.getChildren();
        int row = rowList.size()-1;
    	createFields(null,row);
    }
    
    /**
     * create respective fields in the advanced window tab
     *
    **/
    private void createFields(String[] fields, int row)
    {
    	if (null!=fields && fields.length>=1 && fields[0].contains(HISTORY_SEPARATOR))
    			return;
        ListItem listItem = new ListItem();
        listItem.setId("Row"+advancedPanel.getItemCount());

        Listbox listColumn = new Listbox();
        listColumn.setId("listColumn"+listItem.getId());
        listColumn.setName("listColumn");
        listColumn.setMold("select");
        listColumn.setRows(0);
        listColumn.addEventListener(Events.ON_SELECT,this);
        listColumn.setHflex("true");
        
        Listbox listOperator = new Listbox();
        listOperator.setId("listOperator"+listItem.getId());
        listOperator.setName("listOperator");
        listOperator.setMold("select");
        listOperator.setRows(0);
        listOperator.addEventListener(Events.ON_SELECT,this);
        listOperator.setHflex("true");
        
        Listbox listAndOr = new Listbox();
        listAndOr.setId("listAndOr"+listItem.getId());
        listAndOr.setName("listAndOr");
        listAndOr.setMold("select");
        listAndOr.setRows(0);
        listAndOr.addEventListener(Events.ON_SELECT,this);
        listAndOr.setHflex("true");

        Listbox listLeftBracket = new Listbox();
        listLeftBracket.setId("listLeftBracket"+listItem.getId());
        listLeftBracket.setName("listLeftBracket");
        listLeftBracket.setMold("select");
        listLeftBracket.setRows(0);
        listLeftBracket.addEventListener(Events.ON_SELECT,this);
        listLeftBracket.setHflex("true");

        Listbox listRightBracket = new Listbox();
        listRightBracket.setId("listRightBracket"+listItem.getId());
        listRightBracket.setName("listRightBracket");
        listRightBracket.setMold("select");
        listRightBracket.setRows(0);
        listRightBracket.addEventListener(Events.ON_SELECT,this);
        listRightBracket.setHflex("true");

        setValues(listColumn, listOperator, fields);

        // And Or
    	ValueNamePair[]	andOr = new ValueNamePair[] {
    		new ValueNamePair ("",			""),	
    		new ValueNamePair ("AND",		Msg.getMsg(Env.getCtx(),"AND")),
    		new ValueNamePair ("OR",		Msg.getMsg(Env.getCtx(),"OR"))	
    	};
        
    	for (ValueNamePair item: andOr)
            listAndOr.appendItem(item.getName(), item.getValue());
    	if (row<=0){ // don't show item on the first row.
        	listAndOr.setSelectedIndex(0);
    		listAndOr.setVisible(false);
    	} else {
    		listAndOr.setSelectedIndex(1); //And - default
    		listAndOr.setVisible(true);
    	}

        // Left Bracket
    	ValueNamePair[]	leftBracket = new ValueNamePair[] {
    		new ValueNamePair ("",			""),	
    		new ValueNamePair ("(",			"("),
    		new ValueNamePair ("((",		"(("),	
    		new ValueNamePair ("(((",		"(((")	
    	};
        
    	for (ValueNamePair item: leftBracket)
            listLeftBracket.appendItem(item.getName(), item.getValue());
    	listLeftBracket.setSelectedIndex(0);
        
        // Right Bracket
    	ValueNamePair[]	rightBracket = new ValueNamePair[] {
    		new ValueNamePair ("",			""),	
    		new ValueNamePair (")",			")"),
    		new ValueNamePair ("))",		"))"),	
    		new ValueNamePair (")))",		")))")	
    	};
        
    	for (ValueNamePair item: rightBracket)
            listRightBracket.appendItem(item.getName(), item.getValue());
    	listRightBracket.setSelectedIndex(0);
        
        ListCell cellColumn = new ListCell();
        cellColumn.appendChild(listColumn);
        cellColumn.setId("cellColumn"+listItem.getId());

        ListCell cellOperator = new ListCell();
        cellOperator.appendChild(listOperator);
        cellOperator.setId("cellOperator"+listItem.getId());

        ListCell cellQueryFrom = new ListCell();
        cellQueryFrom.setId("cellQueryFrom"+listItem.getId());

        ListCell cellQueryTo = new ListCell();
        cellQueryTo.setId("cellQueryTo"+listItem.getId());

        ListCell cellAndOr = new ListCell();
        cellAndOr.appendChild(listAndOr);
        cellAndOr.setId("cellAndOr"+listItem.getId());

        ListCell cellLeftBracket = new ListCell();
        cellLeftBracket.appendChild(listLeftBracket);
        cellLeftBracket.setId("cellLeftBracket"+listItem.getId());

        ListCell cellRightBracket = new ListCell();
        cellRightBracket.appendChild(listRightBracket);
        cellRightBracket.setId("cellRightBracket"+listItem.getId());

        listItem.appendChild(cellAndOr);
        listItem.appendChild(cellLeftBracket);
        listItem.appendChild(cellColumn);
        listItem.appendChild(cellOperator);
        listItem.appendChild(cellQueryFrom);
        listItem.appendChild(cellQueryTo);
        listItem.appendChild(cellRightBracket);

        advancedPanel.appendChild(listItem);
        advancedPanel.setSelectedItem(listItem);

        if (fields != null){
        	// QueryFrom
	        String columnName = listColumn.getSelectedItem().getValue().toString();
	        if (columnName == null || columnName == "")
	        	return;
	    	String value = fields.length > INDEX_VALUE ? fields[INDEX_VALUE] : "";
	    	if(value.length() > 0)
	    	{
	    		cellQueryFrom.setAttribute("value", value); // Elaine 2009/03/16 - set attribute value
		        cellQueryFrom.appendChild(parseString(getTargetMField(columnName), value, listItem, false));
	    	}
	    	// QueryTo
	    	String value2 = fields.length > INDEX_VALUE2 ? fields[INDEX_VALUE2] : "";
	    	if(value2.length() > 0)
	    	{
	    		cellQueryTo.setAttribute("value", value2); // Elaine 2009/03/16 - set attribute value
	    		cellQueryTo.appendChild(parseString(getTargetMField(columnName), value2, listItem, true));
	    	}
	    	
	    	// AndOr
	    	String sandOr = fields.length > INDEX_ANDOR ? fields[INDEX_ANDOR] : "";
	    	if(sandOr.length() > 0)
	    	{
	        	for (int i=0; i< listAndOr.getItems().size(); i++) {
	        		if (listAndOr.getItemAtIndex(i).getValue().equals(sandOr)){
	                	listAndOr.setSelectedIndex(i);
	                	break;
	        		}
	        	}
	    	}

	    	// Left Bracket
	    	String sLeftBracket = fields.length > INDEX_LEFTBRACKET ? fields[INDEX_LEFTBRACKET] : "";
	    	if(sLeftBracket.length() > 0)
	    	{
	        	for (int i=0; i < listLeftBracket.getItems().size(); i++) {
	        		if (listLeftBracket.getItemAtIndex(i).getValue().equals(sLeftBracket)){
	        			listLeftBracket.setSelectedIndex(i);
	                	break;
	        		}
	        	}
	    	}

	    	// Right Bracket
	    	String sRightBracket = fields.length > INDEX_RIGHTBRACKET ? fields[INDEX_RIGHTBRACKET] : "";
	    	if(sRightBracket.length() > 0)
	    	{
	        	for (int i=0; i < listRightBracket.getItems().size(); i++) {
	        		if (listRightBracket.getItemAtIndex(i).getValue().equals(sRightBracket)){
	        			listRightBracket.setSelectedIndex(i);
	                	break;
	        		}
	        	}
	    	}
	    	
        }
        
   }    // createFields

    private void setValues(Listbox listColumn, Listbox listOperator, String[] fields)
    {
        //  0 = Columns
        ArrayList<ValueNamePair> items = new ArrayList<ValueNamePair>();
        for (int c = 0; c < m_findFields.length; c++)
        {
            GridField field = m_findFields[c];
            
            String columnName = field.getColumnName();
            String header = field.getHeader();
            if (header == null || header.length() == 0)
            {
                header = Msg.translate(Env.getCtx(), columnName);

                if (header == null || header.length() == 0)
                    continue;
            }
            if (field.isKey())
                header += (" (ID)");
            ValueNamePair pp = new ValueNamePair(columnName, header.toString());
            items.add(pp);
        }
        ValueNamePair[] cols = new ValueNamePair[items.size()];
        items.toArray(cols);
        Arrays.sort(cols);      //  sort alpha
        ValueNamePair[] op = MQuery.OPERATORS;

        if(fields == null)
        {
            listColumn.appendItem("","" );
            for (ValueNamePair item: cols)
                listColumn.appendItem(item.getName(), item.getValue());
        	listColumn.setSelectedIndex(0);

            for (ValueNamePair item: op)
                listOperator.appendItem(item.getName(), item.getValue());
            listOperator.setSelectedIndex(0);
        }
        else
        {
        	String columnName = fields.length > INDEX_COLUMNNAME ? fields[INDEX_COLUMNNAME] : "";
        	String operator = fields.length > INDEX_OPERATOR ? fields[INDEX_OPERATOR] : "";

            boolean selected = false;
            listColumn.appendItem("","");
            for (int i = 0; i < cols.length; i++)
            {
            	ValueNamePair item = cols[i];
                ListItem li = listColumn.appendItem(item.getName(), item.getValue());
                if(item.getValue().equals(columnName))
            	{
                	listColumn.setSelectedItem(li);
            		selected = true;
            	}
            }
            if(!selected) listColumn.setSelectedIndex(0);

            selected = false;
            for (int i = 0; i < op.length; i++)
            {
            	ValueNamePair item = op[i];
            	ListItem li = listOperator.appendItem(item.getName(), item.getValue());
            	if(item.getValue().equals(operator))
            	{
            		listOperator.setSelectedItem(li);
            		selected = true;
            	}
            }
            if(!selected) listOperator.setSelectedIndex(0);
        }
    }   // setValues

    /**
     *  Add Selection Column to first Tab
     *  @param mField field
    **/
    public void addSelectionColumn(GridField mField)
    {
        if (log.isLoggable(Level.CONFIG)) log.config(mField.getHeader());
        int displayLength = mField.getDisplayLength();
        if (displayLength <= 0 || displayLength > FIELDLENGTH)
            mField.setDisplayLength(FIELDLENGTH);
        else
            displayLength = 0;

        //  Editor
        WEditor editor = null;
        //false will use hflex which is render 1 pixel too width on firefox
        editor = WebEditorFactory.getEditor(mField, true);
        editor.setMandatory(false);
        editor.setReadWrite(true);
        editor.dynamicDisplay();
        editor.fillHorizontal();
        Label label = editor.getLabel();
        Component fieldEditor = editor.getComponent();

        //
        if (displayLength > 0)      //  set it back
            mField.setDisplayLength(displayLength);
        //

        Row panel = new Row();
        panel.appendChild(label);
        panel.appendChild(fieldEditor);
        panel.appendChild(new Space());

        contentSimpleRows.appendChild(panel);
        m_sEditors.add(editor);

        fieldEditor.addEventListener(Events.ON_OK,this);
    }   // addSelectionColumn
    
    public void onEvent(Event event) throws Exception
    {
        m_createNew  = false;
        if (Events.ON_SELECT.equals(event.getName()))
        {
            if (event.getTarget() instanceof Listbox)
            {
                ListItem row = (ListItem)(event.getTarget().getParent().getParent());
                Listbox listbox = (Listbox)event.getTarget();
                advancedPanel.setSelectedItem(row);
                Listbox listColumn = (Listbox)row.getFellow("listColumn"+row.getId());
                Listbox listOperator = (Listbox)row.getFellow("listOperator"+row.getId());

                if (listbox.getId().equals(listColumn.getId()) || listbox.getId().equals(listOperator.getId()))
                {
                	if (listbox.getId().equals(listColumn.getId()))
                	{
                		ListItem column = listColumn.getSelectedItem();
                		if (column != null && column.getValue().toString().length() > 0)
                		{
                			addOperators(column, listOperator);
                		}
                	}
                }
                Component componentFrom = getEditorCompQueryFrom(row);
                componentFrom.setId("searchFieldFrom"+row.getId());
                Component componentTo = getEditorCompQueryTo(row);
                componentTo.setId("searchFieldTo"+row.getId());
                Listbox listOp = (Listbox) row.getFellow("listOperator"+row.getId());
                String betweenValue = listOp.getSelectedItem().getValue().toString();
                
                if(betweenValue.equals(MQuery.NULL) || betweenValue.equals(MQuery.NOT_NULL))
                {
                	// to not display any editor
                	row.getFellow("cellQueryFrom"+row.getId()).getChildren().clear();
                	row.getFellow("cellQueryTo"+row.getId()).getChildren().clear();
                }
                else if (listbox.getId().equals(listColumn.getId()) || listbox.getId().equals(listOperator.getId())) 
                {
                	addRowEditor(componentFrom, (ListCell)row.getFellow("cellQueryFrom"+row.getId()));
                	addRowEditor(componentTo,(ListCell)row.getFellow("cellQueryTo"+row.getId()));
                }
            }
            else if (event.getTarget() == fQueryName)
            {
            	int index = fQueryName.getSelectedIndex();
            	if(index < 0) return;
            	if (winMain.getComponent().getSelectedIndex() != 1) 
            	{
            		winMain.getComponent().setSelectedIndex(1);
            		btnSave.setDisabled(m_AD_Tab_ID <= 0);
            		historyCombo.setSelectedItem(null);
            		fQueryName.setReadonly(false); 
            	}
            	msgLabel.setText("");

            	if(index == 0) 
            	{ // no query - wipe and start over.
            		List<?> rowList = advancedPanel.getChildren();
            		for (int rowIndex = rowList.size() - 1; rowIndex >= 1; rowIndex--)
            			rowList.remove(rowIndex);
            		createFields();  
            	}
    			else
    				parseUserQuery(userQueries[index-1]);
    		}
    		else if (event.getTarget() instanceof Tab) {
    			if (winMain.getComponent().getSelectedIndex() == 1) {
    				fQueryName.setReadonly(false);
    				btnSave.setDisabled(m_AD_Tab_ID <= 0);
    				historyCombo.setSelectedItem(null);
    				if (advancedPanel.getItems().size() == 0) {
    					createFields();
    				}
    			} else {
    				fQueryName.setReadonly(true);
    				btnSave.setDisabled(true);
    				historyCombo.setDisabled(false);
    			}
    		}
        }   //
        else if (Events.ON_CLICK.equals(event.getName()))
        {
            //  Toolbar Buttons actions
            if(event.getTarget() instanceof ToolBarButton)
            {
                ToolBarButton button = (ToolBarButton)event.getTarget();

                if ("btnNewAdv".equals(button.getAttribute("name").toString()))
                {
                	createFields();
                }

                else if ("btnDeleteAdv".equals(button.getAttribute("name").toString()))
                {
                    int index = advancedPanel.getSelectedIndex();
                    if (advancedPanel.getSelectedItem() != null) 
                    {
                    	advancedPanel.getSelectedItem().detach();
                    	advancedPanel.setSelectedIndex(--index);
                    }
                }

                else if ("btnSaveAdv".equals(button.getAttribute("name").toString()))
                {
                	cmd_save(true);
                }
            }
            //  Confirm panel actions
            else if(event.getTarget() instanceof Button)
            {
                Button btn = (Button)event.getTarget();

                if ("btnOkSimple".equals(btn.getName()))
                {
                    cmd_ok_Simple();
                    fQueryName.setValue("");
                    if (advancedPanel != null) {
                    	advancedPanel.getItems().clear();
                    }
                    dispose();
                }
                else if ("btnOkAdv".equals(btn.getName()))
                {
                    cmd_ok_Advanced();
                    dispose();
                }
                else if("btnCancel".equals(btn.getName()))
                {
                	m_isCancel = true;
                    dispose();
                }
                else if ("btnNew".equals(btn.getName()))
                {
                    m_query = MQuery.getNoRecordQuery(m_tableName, true);
                    m_total = 0;
                    m_createNew  = true;
                    m_isCancel = false;
                    dispose();
                }
            }
        }
        else if (Events.ON_OK.equals(event.getName()))
        {
            if (winLookupRecord.equals(event.getTarget()))
            {
                cmd_ok_Simple();
                dispose();
            }
            else if (winAdvanced.equals(event.getTarget()))
            {
                cmd_ok_Advanced();
                dispose();
            }
            // Check simple panel fields
            for (WEditor editor : m_sEditors)
            {
            	if (editor.getComponent() == event.getTarget())
            	{
                    cmd_ok_Simple();
                    dispose();
            	}
            }
        }

    }   //  onEvent

    private void parseUserQuery(MUserQuery userQuery)
    {
    	String code = userQuery.getCode();
    	String[] segments = code.split(Pattern.quote(SEGMENT_SEPARATOR));

        List<?> rowList = advancedPanel.getChildren();
        for (int rowIndex = rowList.size() - 1; rowIndex >= 1; rowIndex--)
        	rowList.remove(rowIndex);

		for (int i = 0; i < segments.length; i++)
		{
			String[] fields = segments[i].split(Pattern.quote(FIELD_SEPARATOR));

			createFields(fields, i);
		}
		
		String[] historysegments = code.split(Pattern.quote(HISTORY_SEPARATOR));
    	
		String history = historysegments.length > INDEX_HISTORY? historysegments[INDEX_HISTORY] : "";
    	if(history.length() > 0)
    	{
    		historyCombo.setAttribute("history", history);
    		//historyCombo.setSelectedItem(new Comboitem(history));
    		//historyCombo.setSelectedItem(new Comboitem(history, history));
    		historyCombo.setSelectedIndex(getHistoryIndex(history)+1);
    	}

		advancedPanel.invalidate();
	}
    
    private int getHistoryIndex(String value)
    {
    	int myIndex = 0;
    	if(value.equals(HISTORY_DAY_YEAR))
    		myIndex = 1;
    	else if(value.equals(HISTORY_DAY_MONTH))
    		myIndex = 2;
    	else if(value.equals(HISTORY_DAY_WEEK))
    		myIndex = 3;
    	else if(value.equals(HISTORY_DAY_DAY))
    		myIndex = 4;
    	return myIndex;
    }

	/**
	 * 	Parse String
	 * 	@param field column
	 * 	@param in value
	 * @param to
	 * @param listItem
	 * 	@return data type corected value
	 */
	private Component parseString(GridField field, String in, ListItem listItem, boolean to)
	{
		if (in == null)
			return null;
		int dt = field.getDisplayType();
		try
		{
			WEditor editor = null;
			if (field.isKey())
	            editor = new WNumberEditor(field);
	        else
	            editor = WebEditorFactory.getEditor(field, true);
	        if (editor == null)
	            editor = new WStringEditor(field);

			//	Return Integer
			if (dt == DisplayType.Integer
				|| (DisplayType.isID(dt) && field.getColumnName().endsWith("_ID")))
			{
				int i = Integer.parseInt(in);
		        editor.setValue(new Integer(i));
			}
			//	Return BigDecimal
			else if (DisplayType.isNumeric(dt))
			{
				editor.setValue(DisplayType.getNumberFormat(dt).parse(in));
			}
			//	Return Timestamp
			else if (DisplayType.isDate(dt))
			{
				long time = 0;
				try
				{
					time = DisplayType.getDateFormat_JDBC().parse(in).getTime();
					editor.setValue(new Timestamp(time));
				}
				catch (Exception e)
				{
					StringBuilder msglog = new StringBuilder().append(in.toString()).append("(").append(in.getClass()).append(")").append(e);
					log.log(Level.SEVERE, msglog.toString());
					time = DisplayType.getDateFormat(dt).parse(in).getTime();
				}

				editor.setValue(new Timestamp(time));
			}
			else if (dt == DisplayType.YesNo)
				editor.setValue(Boolean.valueOf(in));
			else
				editor.setValue(in);

			editor.addValueChangeListener(this);

			boolean between = false;
	        Listbox listOp = (Listbox) listItem.getFellow("listOperator"+listItem.getId());
	        String betweenValue = listOp.getSelectedItem().getValue().toString();
	        String opValue = MQuery.OPERATORS[MQuery.BETWEEN_INDEX].getValue();
	        if (to &&  betweenValue != null
	            && betweenValue.equals(opValue))
	            between = true;

	        boolean enabled = !to || (to && between);

			editor.setReadWrite(enabled);
	        editor.setVisible(enabled);
	        editor.dynamicDisplay();

			return editor.getComponent();
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, "Object=" + in, ex);
			return null;
		}

	}	//	parseValue

    private void cmd_save(boolean saveQuery)
	{
		//
		m_query = new MQuery(m_tableName);
		m_query.addRestriction(Env.parseContext(Env.getCtx(), m_targetWindowNo, m_whereExtended, false));
		StringBuilder code = new StringBuilder();
		
		int openBrackets = 0;

        List<?> rowList = advancedPanel.getChildren();

        for (int rowIndex = 1; rowIndex < rowList.size() ; rowIndex++)
        {
            //  Column
            ListItem row = (ListItem)rowList.get(rowIndex);
            Listbox column = (Listbox)row.getFellow("listColumn"+row.getId());
            if (column == null)
                continue;
            String ColumnName = column.getSelectedItem().getValue().toString();
            String infoName = column.toString();
            //
            GridField field = getTargetMField(ColumnName);
            if(field == null) continue; // Elaine 2008/07/29
            boolean isProductCategoryField = isProductCategoryField(field.getColumnName());
            String ColumnSQL = field.getColumnSQL(false);
            // Left brackets
            Listbox listLeftBracket = (Listbox)row.getFellow("listLeftBracket"+row.getId());
            String lBrackets = listLeftBracket.getSelectedItem().getValue().toString();
			if ( lBrackets != null )
				openBrackets += lBrackets.length();
			else lBrackets = "";
			// Right brackets
            Listbox listRightBracket = (Listbox)row.getFellow("listRightBracket"+row.getId());
            String rBrackets = listRightBracket.getSelectedItem().getValue().toString();
			if ( rBrackets != null )
				openBrackets -= rBrackets.length();
			else rBrackets = "";
			// And Or
            Listbox listAndOr = (Listbox)row.getFellow("listAndOr"+row.getId());
            String andOr = listAndOr.getSelectedItem().getValue().toString();
			boolean and = true;
			if ( rowIndex > 1 ) {
				and = !"OR".equals(andOr);
			}         
            //  Op
            Listbox op = (Listbox)row.getFellow("listOperator"+row.getId());
            if (op == null)
                continue;
            String Operator = op.getSelectedItem().getValue().toString();

            //  Value   ******
            ListCell cellQueryFrom = (ListCell)row.getFellow("cellQueryFrom"+row.getId());
            Object value = null;
            
            //Allowing Date validation before save
            Component compo = cellQueryFrom.getFirstChild();
            if(compo instanceof Datebox) {
               Datebox dbox = (Datebox)compo;
               if(dbox.getValue() != null)
            	  value = new Timestamp(((Date)dbox.getValue()).getTime());
            }
            else if(compo instanceof DatetimeBox) {
            	  DatetimeBox dtbox = (DatetimeBox)compo;
            	  if(dtbox.getValue() != null)
            		 value = new Timestamp(((Date)dtbox.getValue()).getTime());
            }
            else {
            	value = cellQueryFrom.getAttribute("value");
            }
            
            if (value == null)
            {
            	if(Operator.equals(MQuery.NULL) || Operator.equals(MQuery.NOT_NULL))
            	{
            		m_query.addRestriction(ColumnSQL, Operator, null,
            				infoName, null, and, openBrackets);
            		if (code.length() > 0)
        				code.append(SEGMENT_SEPARATOR);
        			code.append(ColumnName)
        				.append(FIELD_SEPARATOR)
        				.append(Operator)
        				.append(FIELD_SEPARATOR)
        				.append("")
        				.append(FIELD_SEPARATOR)
        				.append("")
        				.append(FIELD_SEPARATOR)
        				.append(andOr)
        				.append(FIELD_SEPARATOR)
        				.append(lBrackets)
        				.append(FIELD_SEPARATOR)
        				.append(rBrackets);
            	}
            	continue;
            }
            Object parsedValue = parseValue(field, value);
            if (parsedValue == null)
                continue;
            String infoDisplay = value.toString();
            if (field.isLookup())
                infoDisplay = field.getLookup().getDisplay(value);
            else if (field.getDisplayType() == DisplayType.YesNo)
                infoDisplay = Msg.getMsg(Env.getCtx(), infoDisplay);
            //  Value2  ******
            Object value2 = null;
            if (MQuery.OPERATORS[MQuery.BETWEEN_INDEX].getValue().equals(Operator))
            {
                ListCell cellQueryTo = (ListCell)row.getFellow("cellQueryTo"+row.getId());
                
                //Allowing Date validation before save
                compo = cellQueryTo.getFirstChild();
                if(compo instanceof Datebox) {
                   Datebox dbox = (Datebox)compo;
                   if(dbox.getValue() != null)
                	  value2 = new Timestamp(((Date)dbox.getValue()).getTime());
                }
                else if(compo instanceof DatetimeBox) {
                	  DatetimeBox dtbox = (DatetimeBox)compo;
                	  if(dtbox.getValue() != null)
                		 value2 = new Timestamp(((Date)dtbox.getValue()).getTime());
                }
                else {
                	value2 = cellQueryFrom.getAttribute("value");
                }
                
                
                value2 = cellQueryTo.getAttribute("value");
                if (value2 == null)
                    continue;
                Object parsedValue2 = parseValue(field, value2);
                String infoDisplay_to = value2.toString();
                if (parsedValue2 == null)
                    continue;
                m_query.addRangeRestriction(ColumnSQL, parsedValue, parsedValue2,
                    infoName, infoDisplay, infoDisplay_to, and, openBrackets);
            }
            else if (isProductCategoryField && MQuery.OPERATORS[MQuery.EQUAL_INDEX].getValue().equals(Operator)) {
                if (!(parsedValue instanceof Integer)) {
                    continue;
                }
                m_query.addRestriction(getSubCategoryWhereClause(((Integer) parsedValue).intValue()), and, openBrackets);
            }
            else
            	m_query.addRestriction(ColumnSQL, Operator, parsedValue,
            			infoName, infoDisplay, and, openBrackets);

            if (code.length() > 0)
            	code.append(SEGMENT_SEPARATOR);
            code.append(ColumnName)
            .append(FIELD_SEPARATOR)
            .append(Operator)
            .append(FIELD_SEPARATOR)
            .append(value.toString())
            .append(FIELD_SEPARATOR)
            .append(value2 != null ? value2.toString() : "")
            .append(FIELD_SEPARATOR)
            .append(andOr)
            .append(FIELD_SEPARATOR)
            .append(lBrackets)
            .append(FIELD_SEPARATOR)
            .append(rBrackets);
        }
        String selected = fQueryName.getValue();
		if (selected != null) {
			String name = selected;
			if ((fQueryName.getSelectedIndex() == 0 || name.equals(m_sNew)) && saveQuery){ // New query - needs a name

				FDialog.warn (m_targetWindowNo, this, "NeedsName", name);
				return;
			}
			if (saveQuery){
			
				if(historyCombo.getSelectedItem()!=null)
		        {
					code.append(SEGMENT_SEPARATOR);
					code.append(HISTORY_SEPARATOR);
					code.append(historyCombo.getSelectedItem().getValue());
		        }
				
				MUserQuery uq = MUserQuery.get(Env.getCtx(), m_AD_Tab_ID, name);
				if (code.length() > 0) { // New or updated
					if (uq == null) // Create a new record
					{
						uq = new MUserQuery (Env.getCtx(), 0, null);
						uq.setName (name);
						uq.setAD_Tab_ID(m_AD_Tab_ID); //red1 UserQuery [ 1798539 ] taking in new field from Compiere
						uq.setAD_User_ID(Env.getAD_User_ID(Env.getCtx())); //red1 - [ 1798539 ] missing in Compiere delayed source :-)
					}
					
				} else	if (code.length() <= 0){ // Delete the query
					if (uq == null) 
					{
						FDialog.warn (m_targetWindowNo, this, "NeedsQuery", name);
						return;
					}
					if (uq.delete(true))
					{
						FDialog.info (m_targetWindowNo, this, "Deleted", name);
						refreshUserQueries();
					}
					else
						FDialog.warn (m_targetWindowNo, this, "DeleteError", name);
					return;
				}
				uq.setCode (code.toString());
				uq.setAD_Table_ID (m_AD_Table_ID);
				//
				if (uq.save())
				{
					msgLabel.setText(Msg.getMsg(Env.getCtx(), "Saved"));
					refreshUserQueries();
				}
				else
					msgLabel.setText(Msg.getMsg(Env.getCtx(), "SaveError"));
			}
			//

		}

	}	//	cmd_save

	private void refreshUserQueries()
	{
		String value = m_sNew;
		if (fQueryName.getItemCount()>0){ // The list is initialized
			value = fQueryName.getValue();
		}
		userQueries = MUserQuery.get(Env.getCtx(), m_AD_Tab_ID);
		fQueryName.getItems().clear();
		boolean selected = false;
		fQueryName.appendItem(m_sNew);  
		for (int i = 0; i < userQueries.length; i++)
		{
			Comboitem ci = fQueryName.appendItem(userQueries[i].getName());
			if(value.equals(userQueries[i].getName()))
			{
				fQueryName.setSelectedItem(ci);
				parseUserQuery(userQueries[i]);
				selected = true;
			}
		}

		if(!selected) fQueryName.setSelectedIndex(0);	}

    /**
     * retrieve the columnName of the Column item selected
     * @param label label
    **/
    private String getColumnName(ListItem row)
    {
        Listbox listColumn = (Listbox)row.getFellow("listColumn"+row.getId());
        String columnName = listColumn.getSelectedItem().getValue().toString();

        return columnName;

    }   // getColumnName

    /**
     *  get editor component for 'query' field
     * @param row   row
     * @return  editor component
    **/
    private Component getEditorCompQueryFrom(ListItem row)
    {
        return getEditorComponent(row, false);
    }

    /**
     *  get editor component for 'query to' field
     * @param row   row
     * @return  editor component
    **/
    private Component getEditorCompQueryTo(ListItem row)
    {
        return getEditorComponent(row, true);
    }

    /**
     * add the editor component in the 'QueryValue' field
     * @param component editor component
     * @param label label to replace by editor component
    **/
    private void addRowEditor(Component component, ListCell listcell)
    {
        listcell.setLabel("");
        listcell.getChildren().clear();
        listcell.appendChild(component);
        ((HtmlBasedComponent)component).setHflex("1");
        listcell.invalidate();
     }   //  addComponent

    /**
     *    Retrieve operators depending on the item selected in the 'Column' field
     *    and add them to the selection
     *    @param column Column field selected
    **/
    private void addOperators(ListItem column, Listbox listOperator)
    {
    	String columnName = column.getValue().toString();
    	int referenceType = -1;
    	if (columnName != null) {
    		MTable table = MTable.get(Env.getCtx(), m_tableName);
    		MColumn col = table.getColumn(columnName);
    		referenceType = col.getAD_Reference_ID();
    	}
        if (DisplayType.isLookup(referenceType)
        		|| DisplayType.YesNo == referenceType
        		|| DisplayType.Button == referenceType)
        {
        	addOperators(MQuery.OPERATORS_LOOKUP, listOperator);
        }
        else if (DisplayType.isNumeric(referenceType)
        		|| DisplayType.isDate(referenceType)
        		|| DisplayType.isID(referenceType)) // Note that lookups were filtered above
        {
        	addOperators(MQuery.OPERATORS_NUMBERS, listOperator);
        }
        else // DisplayType.isText
        {
        	addOperators(MQuery.OPERATORS, listOperator);
        }
    } //    addOperators

    /**
     * add Operators
     * @param op array of operators
    **/
    private void addOperators(ValueNamePair[] op, Listbox listOperator)
    {
        List<?> itemList = listOperator.getChildren();
        itemList.clear();
        for (ValueNamePair item: op)
        {
            listOperator.appendItem(item.getName(), item.getValue());
        }
        listOperator.setSelectedIndex(0);
    }   //  addOperators

    /**
     *  Get Editor
     *  @param row row
     *  @return Editor component
    **/
    public Component getEditorComponent(ListItem row, boolean to)
    {
        String columnName = getColumnName(row);
        boolean between = false;
        Listbox listOp = (Listbox) row.getFellow("listOperator"+row.getId());
        String betweenValue = listOp.getSelectedItem().getValue().toString();
        String opValue = MQuery.OPERATORS[MQuery.BETWEEN_INDEX].getValue();
        if (to &&  betweenValue != null
            && betweenValue.equals(opValue))
            between = true;

        boolean enabled = !to || (to && between);

        //  Create Editor
        GridField field = getTargetMField(columnName);        
        if(field == null) return new Label("");

        GridField findField = (GridField) field.clone(m_findCtx);        
        findField.setGridTab(null);
        WEditor editor = null;
        if (findField.isKey() 
        		|| (!DisplayType.isLookup(findField.getDisplayType()) && DisplayType.isID(findField.getDisplayType())))
        {
            editor = new WNumberEditor(findField);
		}
        else if (findField.getDisplayType() == DisplayType.Button)        	
        {
			if (findField.getAD_Reference_Value_ID() > 0) {		
				MLookupInfo info = MLookupFactory.getLookup_List(Env.getLanguage(Env.getCtx()), findField.getAD_Reference_Value_ID());
				MLookup mLookup = new MLookup(info, 0);
				editor = new WTableDirEditor(columnName, false,false, true, mLookup);
        		findField.addPropertyChangeListener(editor);

			} else {
				if (columnName.endsWith("_ID")) {
					editor = new WNumberEditor(findField);
				} else {
					editor = new WStringEditor(findField);
				}
			}
        }
        else
        {
        	//reload lookupinfo for find window
        	if (DisplayType.isLookup(findField.getDisplayType()) ) 
        	{        		
        		findField.loadLookupNoValidate();        		
        		editor = WebEditorFactory.getEditor(findField, true);
        		findField.addPropertyChangeListener(editor);
        	} 
        	else 
        	{
        		editor = WebEditorFactory.getEditor(findField, true);
        		findField.addPropertyChangeListener(editor);
        	}
        }
        if (editor == null)
        {
            editor = new WStringEditor(findField);
            findField.addPropertyChangeListener(editor);
        }
        
        editor.addValueChangeListener(this);
        editor.setValue(null);
        editor.setReadWrite(enabled);
        editor.setVisible(enabled);
        editor.dynamicDisplay();
        //
        return editor.getComponent();

    }   //  getTableCellEditorComponent

    /**
     *  Get Target MField
     *  @param columnName column name
     *  @return MField
    **/
    public GridField getTargetMField (String columnName)
    {
        if (columnName == null)
            return null;
        for (int c = 0; c < m_findFields.length; c++)
        {
            GridField field = m_findFields[c];
            if (columnName.equals(field.getColumnName()))
                return field;
        }
        return null;

    }   //  getTargetMField

    /**
     *  Simple OK Button pressed
    **/
    private void cmd_ok_Simple()
    {
        //  Create Query String
        m_query = new MQuery(m_tableName);
        m_query.addRestriction(Env.parseContext(Env.getCtx(), m_targetWindowNo, m_whereExtended, false));
        //  Special Editors
        for (int i = 0; i < m_sEditors.size(); i++)
        {
            WEditor wed = (WEditor)m_sEditors.get(i);
            Object value = wed.getValue();
            if (value != null && value.toString().length() > 0)
            {
                String ColumnName = wed.getColumnName();
                StringBuilder msglog = new StringBuilder(ColumnName).append("=").append(value);
                if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());

                // globalqss - Carlos Ruiz - 20060711
                // fix a bug with virtualColumn + isSelectionColumn not yielding results
                GridField field = getTargetMField(ColumnName);
                // add encryption here if the field is encrypted.
                if (field.isEncryptedColumn()) {
                	value = SecureEngine.encrypt(value, Env.getAD_Client_ID(Env.getCtx()));
                }
                
                boolean isProductCategoryField = isProductCategoryField(field.getColumnName());
                StringBuilder ColumnSQL = new StringBuilder(field.getColumnSQL(false));
                //
                // Be more permissive for String columns
                if (isSearchLike(field))
                {
                    StringBuilder valueStr = new StringBuilder(value.toString().toUpperCase());
                    if (!valueStr.toString().endsWith("%"))
                        valueStr.append("%");
                    //
                    ColumnSQL = new StringBuilder("UPPER(").append(ColumnSQL).append(")");
                    value = valueStr.toString();
                }
                //
                if (value.toString().indexOf('%') != -1)
                    m_query.addRestriction(ColumnSQL.toString(), MQuery.LIKE, value, ColumnName, wed.getDisplay());
                else if (isProductCategoryField && value instanceof Integer)
                    m_query.addRestriction(getSubCategoryWhereClause(((Integer) value).intValue()));
                else
                    m_query.addRestriction(ColumnSQL.toString(), MQuery.EQUAL, value, ColumnName, wed.getDisplay());
                
                /*
                if (value.toString().indexOf('%') != -1)
                    m_query.addRestriction(ColumnName, MQuery.LIKE, value, ColumnName, ved.getDisplay());
                else
                    m_query.addRestriction(ColumnName, MQuery.EQUAL, value, ColumnName, ved.getDisplay());
                */
                // end globalqss patch
            }
        }   //  editors
        
        if(historyCombo.getSelectedItem()!=null)
        {
        	addHistoryRestriction(historyCombo.getSelectedItem());
        }
        
        m_isCancel = false; // teo_sarca [ 1708717 ]
        //  Test for no records
        if (getNoOfRecords(m_query, true) != 0)
          dispose();

    }   //  cmd_ok_Simple
    
    /**
     * Get days from selected values of history combo
     * @param selectedItem
     * @return
     */
    private int getHistoryDays(String selectedItem) 
	{
    	int retDays = 0;
		if (selectedItem.equals(HISTORY_DAY_DAY))
			retDays = 1;
		else if (selectedItem.equals(HISTORY_DAY_WEEK))
			retDays = 7;
		else if (selectedItem.equals(HISTORY_DAY_MONTH))
			retDays = 31;
		else if (selectedItem.equals(HISTORY_DAY_YEAR))
			retDays = 365;
		return retDays;
		
	}
    

    /**
     * Adding where clause from history data
     * @param selectedHistoryItem
     */
    private void addHistoryRestriction(Comboitem selectedHistoryItem)
    {
    	String selectedHistoryValue = historyCombo.getSelectedItem().getValue();
    	log.info("History combo selected value  =" +selectedHistoryValue);

    	if (null!=selectedHistoryItem && selectedHistoryItem.toString().length() > 0 && getHistoryDays(selectedHistoryValue) > 0)
    	{
    		StringBuilder where = new StringBuilder();
    		where.append("Created >= ");
    		where.append("SysDate-").append(getHistoryDays(selectedHistoryValue));
    		m_query.addRestriction(where.toString());
    	}
    }
    


    public void dispose()
    {
        log.config("");

        //  Find SQL
        DB.close(m_pstmt);
        m_pstmt = null;
        
        //
        super.dispose();
        
        isvalid = false;
    }   //  dispose

    /**
     *  Advanced OK Button pressed
     */
    private void cmd_ok_Advanced()
    {
        m_isCancel = false; // teo_sarca [ 1708717 ]
        //  save pending
        cmd_save(false);
        
        if(historyCombo.getSelectedItem()!=null)
        {
        	addHistoryRestriction(historyCombo.getSelectedItem());
        }
        
        if (getNoOfRecords(m_query, true) != 0)
          dispose();
    }   //  cmd_ok_Advanced

    
    /**
     *  Get the number of records of target tab
     *  @param query where clause for target tab
     *  @param alertZeroRecords show dialog if there are no records
     *  @return number of selected records;
     *          if the results are more then allowed this method will return 0
    **/
    private int getNoOfRecords (MQuery query, boolean alertZeroRecords)
    {
        if (log.isLoggable(Level.CONFIG)) log.config("" + query);
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM ");
        sql.append(m_tableName);
        boolean hasWhere = false;
        if (m_whereExtended != null && m_whereExtended.length() > 0)
        {
            sql.append(" WHERE ").append(m_whereExtended);
            hasWhere = true;
        }
        if (query != null && query.isActive())
        {
            if (hasWhere)
                sql.append(" AND ");
            else
                sql.append(" WHERE ");
            sql.append(query.getWhereClause());
        }
        //  Add Access
        String finalSQL = MRole.getDefault().addAccessSQL(sql.toString(),
            m_tableName, MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
        finalSQL = Env.parseContext(Env.getCtx(), m_targetWindowNo, finalSQL, false);
        Env.setContext(Env.getCtx(), m_targetWindowNo, TABNO, GridTab.CTX_FindSQL, finalSQL);

        //  Execute Qusery
        m_total = 999999;
        Statement stmt = null;
        ResultSet rs = null;
        try
        {
            stmt = DB.createStatement();
            rs = stmt.executeQuery(finalSQL);
            if (rs.next())
                m_total = rs.getInt(1);
        }
        catch (SQLException e)
        {
            log.log(Level.SEVERE, finalSQL, e);
        }
        finally
        {
        	DB.close(rs, stmt);
        	rs = null;
        	stmt = null;
        }
        MRole role = MRole.getDefault();
        //  No Records
      /*  if (m_total == 0 && alertZeroRecords)
            FDialog.warn(m_targetWindowNo, this, "FindZeroRecords");*/
        //  More then allowed
        if (query != null && role.isQueryMax(m_total))
        {
            FDialog.error(m_targetWindowNo, this, "FindOverMax",
                m_total + " > " + role.getMaxQueryRecords());
            m_total = 0; // return 0 if more then allowed - teo_sarca [ 1708717 ]
        }
        else
            if (log.isLoggable(Level.CONFIG)) log.config("#" + m_total);
        //
        /*if (query != null)
            statusBar.setStatusToolTip (query.getWhereClause());*/
        return m_total;

    }   //  getNoOfRecords

    /**
     * Checks the given column.
     * @param columnName
     * @return true if the column is a product category column
    **/
    private boolean isProductCategoryField(String columnName) {
        return MProduct.COLUMNNAME_M_Product_Category_ID.equals(columnName);
    }   //  isProductCategoryField

    /**
     * Returns a sql where string with the given category id and all of its subcategory ids.
     * It is used as restriction in MQuery.
     * @param productCategoryId
     * @return
    **/
    private String getSubCategoryWhereClause(int productCategoryId) {
        //if a node with this id is found later in the search we have a loop in the tree
        int subTreeRootParentId = 0;
        StringBuilder retString = new StringBuilder(" M_Product_Category_ID IN (");
        String sql = "SELECT M_Product_Category_ID, M_Product_Category_Parent_ID FROM M_Product_Category WHERE AD_Client_ID=? AND IsActive='Y'";
        final Vector<SimpleTreeNode> categories = new Vector<SimpleTreeNode>(100);
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = DB.prepareStatement(sql, null);
            pstmt.setInt(1, Env.getAD_Client_ID(Env.getCtx()));
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getInt(1) == productCategoryId) {
                    subTreeRootParentId = rs.getInt(2);
                }
                categories.add(new SimpleTreeNode(rs.getInt(1), rs.getInt(2)));
            }
            retString.append(getSubCategoriesString(productCategoryId, categories, subTreeRootParentId))
            		 .append(") ");
        } catch (SQLException e) {
            log.log(Level.SEVERE, sql, e);
            retString = new StringBuilder();
        } catch (AdempiereSystemError e) {
            log.log(Level.SEVERE, sql, e);
            retString = new StringBuilder();
        }
        finally{
        	DB.close(rs, pstmt);
        	rs = null; pstmt = null;
        }
        return retString.toString();

    }   //  getSubCategoryWhereClause

    /**
     * Recursive search for subcategories with loop detection.
     * @param productCategoryId
     * @param categories
     * @param loopIndicatorId
     * @return comma seperated list of category ids
     * @throws AdempiereSystemError if a loop is detected
    **/
    private String getSubCategoriesString(int productCategoryId, Vector<SimpleTreeNode> categories, int loopIndicatorId) throws AdempiereSystemError {
        StringBuilder ret = new StringBuilder();
        final Iterator<SimpleTreeNode> iter = categories.iterator();
        while (iter.hasNext()) {
            SimpleTreeNode node = (SimpleTreeNode) iter.next();
            if (node.getParentId() == productCategoryId) {
                if (node.getNodeId() == loopIndicatorId) {
                    throw new AdempiereSystemError("The product category tree contains a loop on categoryId: " + loopIndicatorId);
                }
                ret.append(getSubCategoriesString(node.getNodeId(), categories, loopIndicatorId)).append(",");
            }
        }
        if (log.isLoggable(Level.FINE)) log.fine(ret.toString());
        StringBuilder msgreturn = new StringBuilder(ret.toString()).append(productCategoryId);
        return msgreturn.toString();

    }   //  getSubCategoriesString

    /**
     * Simple tree node class for product category tree search.
     * @author Karsten Thiemann, kthiemann@adempiere.org
     *
    **/
    private static class SimpleTreeNode {

        private int nodeId;

        private int parentId;

        public SimpleTreeNode(int nodeId, int parentId) {
            this.nodeId = nodeId;
            this.parentId = parentId;
        }

        public int getNodeId() {
            return nodeId;
        }

        public int getParentId() {
            return parentId;
        }
    }   //  SimpleTreeNode

    /**
     *  Parse Value
     *  @param field column
     *  @param in value
     *  @return data type corected value
    **/
    private Object parseValue (GridField field, Object in)
    {
        if (in == null)
            return null;
        int dt = field.getDisplayType();
        try
        {
            //  Return Integer
            if (dt == DisplayType.Integer
                || (DisplayType.isID(dt) && field.getColumnName().endsWith("_ID")))
            {
                if (in instanceof Integer)
                    return in;
                int i = Integer.parseInt(in.toString());
                return new Integer(i);
            }
            //  Return BigDecimal
            else if (DisplayType.isNumeric(dt))
            {
                if (in instanceof BigDecimal)
                    return in;
                return DisplayType.getNumberFormat(dt).parse(in.toString());
            }
            //  Return Timestamp
            else if (DisplayType.isDate(dt))
            {
                if (in instanceof Timestamp)
                    return in;
                long time = 0;
                try
                {
                    time = DisplayType.getDateFormat_JDBC().parse(in.toString()).getTime();
                    return new Timestamp(time);
                }
                catch (Exception e)
                {
                    StringBuilder msglog = new StringBuilder(in.toString()).append("(").append(in.getClass()).append(")").append(e);
                	log.log(Level.SEVERE, msglog.toString());
                    time = DisplayType.getDateFormat(dt).parse(in.toString()).getTime();
                }
                return new Timestamp(time);
            }
            //  Return Y/N for Boolean
            else if (in instanceof Boolean)
                return ((Boolean)in).booleanValue() ? "Y" : "N";
        }
        catch (Exception ex)
        {
            log.log(Level.SEVERE, "Object=" + in, ex);
            String error = ex.getLocalizedMessage();
            if (error == null || error.length() == 0)
                error = ex.toString();
            StringBuilder errMsg = new StringBuilder();
            errMsg.append(field.getColumnName()).append(" = ").append(in).append(" - ").append(error);
            //
            FDialog.error(0, this, "ValidationError", errMsg.toString());
            return null;
        }

        return in;
    }   //  parseValue

    /**************************************************************************
     *  Get Query - Retrieve result
     *  @return String representation of query
     */
    public MQuery getQuery()
    {
        MRole role = MRole.getDefault();
        if (role.isQueryMax(getTotalRecords()) && !m_isCancel)
        {
            m_query = MQuery.getNoRecordQuery (m_tableName, false);
            m_total = 0;
            log.warning("Query - over max");
        }
        else
            log.info("Query=" + m_query);
        return m_query;
    }   //  getQuery

    /**
     *  Get Total Records
     *  @return no of records
    **/
    public int getTotalRecords()
    {
        return m_total;

    }   //  getTotalRecords

    public void valueChange(ValueChangeEvent evt)
    {
        if (evt != null && evt.getSource() instanceof WEditor)
        {
            WEditor editor = (WEditor)evt.getSource();
            // Editor component
            Component component = editor.getComponent();
            ListCell listcell = (ListCell)component.getParent();
            listcell.setAttribute("value", evt.getNewValue());
            if (evt.getNewValue() == null)
            	Env.setContext(m_findCtx, m_targetWindowNo, editor.getColumnName(), "");
            else if (evt.getNewValue() instanceof Boolean)
            	Env.setContext(m_findCtx, m_targetWindowNo, editor.getColumnName(), (Boolean)evt.getNewValue());
            else if (evt.getNewValue() instanceof Timestamp)
            	Env.setContext(m_findCtx, m_targetWindowNo, editor.getColumnName(), (Timestamp)evt.getNewValue());
            else
            	Env.setContext(m_findCtx, m_targetWindowNo, editor.getColumnName(), evt.getNewValue().toString());
        }
    }

	public void OnPostVisible() {
		removeAttribute(ON_POST_VISIBLE_ATTR);
		if (m_sEditors.size() > 0)
			Clients.response(new AuFocus(m_sEditors.get(0).getComponent()));
	}

	/**
	 *
	 * @return true if dialog cancel by user, false otherwise
	 */
	public boolean isCancel() {
		return m_isCancel;
	}

	/**
	 * @return true if user press the new button
	 */
	public boolean isCreateNew() {
		return m_createNew;
	}

	@Override
	public boolean setVisible(boolean visible) {
		boolean ret = super.setVisible(visible);
		if (visible) {
			if (getAttribute(ON_POST_VISIBLE_ATTR) == null) {
				setAttribute(ON_POST_VISIBLE_ATTR, Boolean.TRUE);
				Events.echoEvent("OnPostVisible", this, null);
			}
		} else {
			//auto detach
			detach();
		}
		return ret;
	}
	
	private boolean isSearchLike(GridField field)
	{
		return DisplayType.isText(field.getDisplayType())
		&& MColumn.isSuggestSelectionColumn(field.getColumnName(), true);
	}

	public boolean isValid()
	{
		return isvalid;
	}	
	
}   //  FindPanel