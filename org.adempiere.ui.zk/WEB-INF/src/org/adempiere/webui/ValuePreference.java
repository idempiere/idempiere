/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.webui;

import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;

import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ZkCssHelper;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.GridField;
import org.compiere.model.MRole;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Login;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;

/**
 *  Maintain Value Preferences.
 *  To delete a preference, select a null value and save.
 *
 *  @author Jorg Janke
 *  @version  $Id: ValuePreference.java,v 1.2 2006/07/30 00:51:28 jjanke Exp $
 */
public class ValuePreference extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7594680475358417813L;

	/**
	 *  Factory
	 *  @param ref
	 *  @param mField	field
	 *  @param aValue	value
	 */
	public static void start (Component ref, GridField mField, Object aValue)
	{
		if (aValue != null && aValue instanceof Boolean)
			if ((Boolean) aValue)
				aValue = 'Y';
			else
				aValue = 'N';
		start (ref, mField, aValue, null);
	}   //  start

	/**
	 *  Factory
	 *  @param ref
	 *  @param mField	field
	 *  @param aValue	value
	 *  @param aDisplayValue	display value
	 */
	public static void start (Component ref, GridField mField, Object aValue, String aDisplayValue)
	{
		if (!mField.isEditable(false))
		{
			log.info("Field not editable (R/O)");
			return;
		}
		
		//  Set Value/DisplayValue
		String Value = null;
		String DisplayValue = null;
		if (aValue != null)
		{
			Value = aValue.toString();
			DisplayValue = (aDisplayValue == null) ? Value : aDisplayValue;
		}

		//  Get from mField
		//  AD_Window_ID, DisplayAttribute, Attribute, DisplayType, AD_Referenece_ID
		int AD_Window_ID = mField.getAD_Window_ID_Of_Panel();
		String Attribute = mField.getColumnName();
		String DisplayAttribute = mField.getHeader();
		int displayType = mField.getDisplayType();
		int AD_Reference_ID = 0;
		int WindowNo = mField.getWindowNo();

		//  Get from Environment (WindowNo)
		//  AD_Client_ID, AD_Org_ID, AD_User_ID, Frame
		int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		int AD_Org_ID = Env.getContextAsInt(Env.getCtx(), WindowNo, "AD_Org_ID");
		int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		
		//  Create Editor
		@SuppressWarnings("unused")
		ValuePreference vp = new ValuePreference (WindowNo,
			AD_Client_ID, AD_Org_ID, AD_User_ID, AD_Window_ID, mField.getAD_Process_ID_Of_Panel(), mField.getAD_InfoWindow_ID_of_Panel(),
			Attribute, DisplayAttribute, Value, DisplayValue,
			displayType, AD_Reference_ID, ref);
	}   //  create

	/**
	 *  Create the popup menu item to start the ValuePreference editor.
	 *  <code>
	 *  .. add method
	 *  public void setField (MField mField)
	 *  {
	 *      m_mField = mField;
	 *      if (m_mField != null)
	 *          ValuePreference.addMenu (this, m_popupMenu);
	 *	}   //  setField
	 *
	 *  .. in actionPerformed add ..
	 *  if (e.getActionCommand().equals(ValuePreference.NAME))
	 *  {
	 *      ValuePreference.start (m_mField, getValue(), DisplayValue);
	 *      return;
	 *  }
	 *  </code>
	 *  @param l listener
	 *  @param popupMenu menu
	 *  @return JMenuItem
	 */
	/*
	public static CMenuItem addMenu (ActionListener l, JPopupMenu popupMenu)
	{
		CMenuItem mi = new CMenuItem (Msg.getMsg(Env.getCtx(), NAME), s_icon);
		mi.setActionCommand(NAME);
		mi.addActionListener(l);
		popupMenu.add(mi);
		return mi;
	}*/   //  addMenu

	/** The Name of the Editor      */
	public static final String      NAME = "ValuePreference";
	/** The Menu Icon               */
	//private static String ICON_URL = "images/VPreference16.png";
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(ValuePreference.class);
	private AbstractADWindowContent adwindowContent;
	
	/**
	 *  Constructor
	 *
	 *  @param WindowNo window no
	 *  @param AD_Client_ID client
	 *  @param AD_Org_ID org
	 *  @param AD_User_ID user
	 *  @param AD_Window_ID window id
	 *  @param Attribute attribute
	 *  @param DisplayAttribute attribute display
	 *  @param Value value
	 *  @param DisplayValue value display
	 *  @param displayType display type
	 *  @param AD_Reference_ID reference
	 * @param ref 
	 */
	public ValuePreference (int WindowNo,
		int AD_Client_ID, int AD_Org_ID, int AD_User_ID, int AD_Window_ID, int AD_Process_ID_Of_Panel, int AD_Infowindow_ID,
		String Attribute, String DisplayAttribute, String Value, String DisplayValue,
		int displayType, int AD_Reference_ID, Component ref)
	{
		super();
		this.setTitle(Msg.getMsg(Env.getCtx(), NAME) + " " + DisplayAttribute);
		
		if (log.isLoggable(Level.CONFIG)) log.config("WindowNo=" + WindowNo
			+ ", Client_ID=" + AD_Client_ID + ", Org_ID=" + AD_Org_ID + ", User_ID=" + AD_User_ID + ", Window_ID=" + AD_Window_ID
			+ ",  Attribute=" + Attribute + "/" + DisplayAttribute + ",  Value=" + Value + "/" + DisplayValue
			+ ",  DisplayType=" + displayType + ", Reference_ID=" + AD_Reference_ID);
		
		m_ctx = Env.getCtx();
		m_WindowNo = WindowNo;
		m_AD_Client_ID = AD_Client_ID;
		m_AD_Org_ID = AD_Org_ID;
		m_AD_User_ID = AD_User_ID;
		m_AD_Window_ID = AD_Window_ID;
		m_Attribute = Attribute;
		m_DisplayAttribute = DisplayAttribute;
		m_Value = Value;
		m_DisplayValue = DisplayValue;
		m_DisplayType = displayType;
		m_AD_Process_ID_Of_Panel = AD_Process_ID_Of_Panel;
		m_AD_Infowindow_ID = AD_Infowindow_ID;
		//
		m_role = MRole.getDefault();
		
		if (m_AD_Infowindow_ID > 0 && m_AD_Process_ID_Of_Panel > 0)
			isProcessInIW = true;
		
		try
		{
			init();
			dynInit();
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		} 
		
		this.setClosable(true);
		adwindowContent = findADWindowContent(ref);
		if (adwindowContent != null) {			
			ZkCssHelper.appendStyle(this, "position: absolute;");
			adwindowContent.getComponent().getParent().appendChild(this);
			adwindowContent.showBusyMask(this);
			LayoutUtils.openOverlappedWindow(ref, this, "after_start");
		} else {
			AEnv.showCenterScreen(this);
		}
		Executions.schedule(getDesktop(), e -> confirmPanel.getOKButton().focus(), new Event("onPostOpenValuePreferenceDialog"));

	}   //  ValuePreference

	private AbstractADWindowContent findADWindowContent(Component comp) {
		ADWindow adwindow = ADWindow.findADWindow(comp);
		return adwindow != null ? adwindow.getADWindowContent() : null;
	}

	private Properties      m_ctx;
	private int             m_WindowNo;
	private int             m_AD_Client_ID;
	private int             m_AD_Org_ID;
	private int             m_AD_User_ID;
	private int             m_AD_Window_ID;
	private String          m_Attribute;
	private String          m_DisplayAttribute;
	private String          m_Value;
	private String          m_DisplayValue;
	private int             m_DisplayType;
	private MRole			m_role;
	private int				m_AD_Process_ID_Of_Panel;
	private int				m_AD_Infowindow_ID;

	//  Display
	private Panel setPanel = new Panel();
	private Grid setLayout = new Grid();
	private Label lAttribute = new Label();
	private Textbox fAttribute = new Textbox();
	private Textbox fAttributeValue = new Textbox();
	private Label lValue = new Label();
	private Label lValueValue = new Label();
	private Textbox fValue = new Textbox();
	private Label lidValue = new Label();
	private Textbox fidValue = new Textbox();
	private Label lSetFor = new Label();
	private Checkbox cbClient = new Checkbox();
	private Checkbox cbOrg = new Checkbox();
	private Checkbox cbUser = new Checkbox();
	private Checkbox cbWindow = new Checkbox();
	private Checkbox cbProcess = new Checkbox();
	private Checkbox cbInfowindow = new Checkbox();
	private Label lExplanation = new Label();

	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Button bDelete;
	
	/**
	* is true when value preference for a field of process call by info window 
	*/
	private boolean isProcessInIW = false;

	/**
	 *  Static Layout
	 *  @throws Exception
	 */
	private void init() throws Exception
	{
		setSclass("popup-dialog");
		Vlayout vlayout = new Vlayout();
		vlayout.setHflex("1");
		this.appendChild(vlayout);
		lAttribute.setValue(Msg.translate(m_ctx, "Attribute").replace("&", ""));
		lValue.setValue(Msg.translate(m_ctx, "Value").replace("&", ""));
		lidValue.setValue("Id");
		lSetFor.setValue(Msg.getMsg(m_ctx, "ValuePreferenceSetFor"));
		cbClient.setLabel(Msg.translate(m_ctx, "AD_Client_ID"));
		cbOrg.setLabel(Msg.translate(m_ctx, "AD_Org_ID"));
		cbUser.setLabel(Msg.translate(m_ctx, "AD_User_ID"));
		cbUser.setChecked(true);
		cbWindow.setLabel(Msg.translate(m_ctx, "AD_Window_ID"));
		cbWindow.setChecked(true);
		cbProcess.setLabel(Msg.translate(m_ctx, "AD_Process_ID"));
		cbProcess.setChecked(true);
		cbInfowindow.setLabel(Msg.translate(m_ctx, "AD_InfoWindow_ID"));
		cbInfowindow.setChecked(true);
		// 
		setPanel.appendChild(setLayout);
		ZKUpdateUtil.setHflex(setPanel, "1");
		fAttribute.setReadonly(true);
		fAttributeValue.setReadonly(true);
		fValue.setReadonly(true);
		
		Grid grid = GridFactory.newGridLayout();
		grid.setStyle("background-image: none;");
		LayoutUtils.addSclass("dialog-content", grid);
		vlayout.appendChild(grid);
		        
		Rows rows = new Rows();
		grid.appendChild(rows);
		
		Row row = new Row();
		Div div = new Div();
		div.setStyle("text-align: right");
		div.appendChild(lAttribute);
		row.appendCellChild(div, 1);
		row.appendCellChild(fAttribute, 3);
		ZKUpdateUtil.setWidth(fAttribute, "98%");
		row.appendCellChild(fAttributeValue, 3);
		fAttributeValue.setWidth("98%");
		rows.appendChild(row);
		
		row = new Row();
		div = new Div();
		div.setStyle("text-align: right");
		div.appendChild(lidValue);
		row.appendCellChild(div, 1);
		row.appendCellChild(fidValue, 6);  
		fidValue.setWidth("99%");  
		fidValue.setReadonly(true);
		rows.appendChild(row);
		
		rows.appendChild(row);
		row = new Row();
		div = new Div();
		div.setStyle("text-align: right");
		div.appendChild(lValue);
		row.appendCellChild(div, 1);
		row.appendCellChild(fValue, 6);
		ZKUpdateUtil.setWidth(fValue, "99%");
		rows.appendChild(row);
		
		row = new Row();
		div = new Div();
		div.setStyle("text-align: right");
		div.appendChild(lSetFor);
		row.appendChild(div);
		Hlayout chlayout = new Hlayout();
		chlayout.setSpacing("5px");		
		chlayout.appendChild(cbClient);
		chlayout.appendChild(cbOrg);
		chlayout.appendChild(cbUser);

		if(isProcessInIW){
			// in case show process in info window, don't show checkbox window in value preference dialog.
			// must set is checked to save current windowID (dummy) with value preference other it will save null, 
			// make data conflic with case save for all window 
			cbWindow.setChecked(true);
		}else{
			chlayout.appendChild(cbWindow);
		}
		
		if(m_AD_Infowindow_ID > 0){
			chlayout.appendChild(cbInfowindow);
		}
		
		if(m_AD_Process_ID_Of_Panel > 0){
			chlayout.appendChild(cbProcess);
		}
		
		row.appendCellChild(chlayout, 5);
		rows.appendChild(row);

		row = new Row();
		row.appendCellChild(new Space(), 1);
		row.appendCellChild(lExplanation, 5);
		rows.appendChild(row);
		
		Div footer = new Div();
		vlayout.appendChild(footer);
			
		if (!ThemeManager.isUseCSSForWindowSize()) {			
			ZKUpdateUtil.setWindowWidthX(this, 500);
		}
		else
		{
			ZKUpdateUtil.setWindowWidthX(this, 740);
		}
		confirmPanel.setVflex("min");
		confirmPanel.setClass("dialog-footer");
		footer.appendChild(confirmPanel);
		
		this.setSizable(true);
		this.setSclass("value-preference-dialog");
	}   //  jbInit

	/**
	 *  Dynamic Init
	 */
	private void dynInit()
	{
		//  Set Attribute/Value
		fAttribute.setText(m_DisplayAttribute);
		fAttributeValue.setValue(m_Attribute);
		fValue.setText(m_DisplayValue);
		fidValue.setText(m_Value);
		lValueValue.setValue(m_Value);
		if (CLogMgt.isLevelFine())
		{
			fAttributeValue.setVisible(false);
			lValueValue.setVisible(false);
		}

		//  ActionListener
		cbClient.setEnabled(false);
		cbClient.setChecked(true);
	//	cbClient.addActionListener(this);
		
		//	Can Change Org
		if (MRole.PREFERENCETYPE_Client.equals(m_role.getPreferenceType()))
			cbOrg.addEventListener(Events.ON_CHECK, this);
		else
		{
			cbOrg.setEnabled(false);
			cbOrg.setChecked(true);
		}
		
		//	Can Change User
		if (MRole.PREFERENCETYPE_Client.equals(m_role.getPreferenceType())
			|| MRole.PREFERENCETYPE_Organization.equals(m_role.getPreferenceType()))
			cbUser.addEventListener(Events.ON_CHECK, this);
		else
		{
			cbUser.setEnabled(false);
			cbUser.setChecked(true);
		}
		//	Can change all/specific
		cbWindow.addEventListener(Events.ON_CHECK, this);
		cbProcess.addEventListener(Events.ON_CHECK, this);
		cbInfowindow.addEventListener(Events.ON_CHECK, this);

		//  Other
		confirmPanel.addComponentsLeft(confirmPanel.createButton("Delete"));
		confirmPanel.addActionListener(Events.ON_CLICK, this);		
		bDelete = confirmPanel.getButton("Delete");
		setExplanation();
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}   //  dynInit

	/**
	 *  Action Listener
	 *  @param e event
	 */
	public void onEvent(Event e) throws Exception
	{
		if (e.getTarget().getId().equals("Cancel"))
		{
			onCancel();
		}
		else if (e.getTarget().getId().equals("Ok"))
		{
			insert();
			detach();
		}
		else if (e.getTarget() == bDelete)
		{
			int no = delete();
			if (no == 0)
				Dialog.warn(m_WindowNo, this.getTitle(), "ValuePreferenceNotFound");
			else
				Dialog.info(m_WindowNo, "ValuePreferenceDeleted", String.valueOf(no));
			detach();
		}
		else
			setExplanation();
	}   //  actionPerformed

	private void onCancel() {
		this.detach();
	}

	/**
	 *  Set Explanation
	 */
	private void setExplanation()
	{
		/** @todo translation */
		StringBuilder expl = new StringBuilder(Msg.getCleanMsg(Env.getCtx(), "For")).append(" ");
		if (cbClient.isChecked() && cbOrg.isChecked() )
			expl.append(Msg.getCleanMsg(Env.getCtx(), "this Client and Organization"));
		else if (cbClient.isChecked() && !cbOrg.isChecked())
			expl.append(Msg.getCleanMsg(Env.getCtx(), "all Organizations of this Client"));
		else if (!cbClient.isChecked() && cbOrg.isChecked())
		{
			cbOrg.setChecked(false);
			expl.append(Msg.getCleanMsg(Env.getCtx(), "entire System"));
		}
		else
			expl.append(Msg.getCleanMsg(Env.getCtx(), "entire System"));
		//
		if (cbUser.isChecked())
			expl.append(", " + Msg.getCleanMsg(Env.getCtx(), "this User"));
		else
			expl.append(", " + Msg.getCleanMsg(Env.getCtx(), "all Users"));
		//
		if (cbWindow.isChecked())
			expl.append(" " + Msg.getCleanMsg(Env.getCtx(), "and this Window"));
		else
			expl.append(" " + Msg.getCleanMsg(Env.getCtx(), "and all Windows"));
		//
		if (m_AD_Process_ID_Of_Panel > 0){
			if (cbProcess.isChecked())
				expl.append(" " + Msg.getCleanMsg(Env.getCtx(), "and this Process"));
			else
				expl.append(" " + Msg.getCleanMsg(Env.getCtx(), "and all Process"));
		}
		//
		if (m_AD_Infowindow_ID > 0){
			if (cbInfowindow.isChecked())
				expl.append(" " + Msg.getCleanMsg(Env.getCtx(),"and this Info Window"));
			else
				expl.append(" " + Msg.getCleanMsg(Env.getCtx(),"and all Info Window"));
		}
		
		lExplanation.setValue(expl.toString ());

	}   //  setExplanation

	/**
	 *  Delete Preference
	 *  @return number of rows deleted
	 */
	public int delete()
	{
		log.info("");

		StringBuilder sql = new StringBuilder ("DELETE FROM AD_Preference WHERE ");
		sql.append("AD_Client_ID=").append(cbClient.isChecked() ? m_AD_Client_ID : 0);
		sql.append(" AND AD_Org_ID=").append(cbOrg.isChecked() ? m_AD_Org_ID : 0);
		if (cbUser.isChecked())
			sql.append(" AND AD_User_ID=").append(m_AD_User_ID);
		else
			sql.append(" AND AD_User_ID IS NULL");
		if (cbWindow.isChecked())
			sql.append(" AND AD_Window_ID=").append(m_AD_Window_ID);
		else
			sql.append(" AND AD_Window_ID IS NULL");
		
		// set where for Process 
		if (m_AD_Process_ID_Of_Panel > 0 && cbProcess.isChecked()){
			// case set for a process 
			sql.append(" AND AD_Process_ID=").append(m_AD_Process_ID_Of_Panel);
		}else{
			// case set for a all process or non set for process (set for window or infowindow)
			sql.append(" AND AD_Process_ID IS NULL");
		}
		
		// set where for infoWindow 
		if (m_AD_Infowindow_ID > 0 && cbInfowindow.isChecked()){
			// case set for a info window
			sql.append(" AND AD_InfoWindow_ID=").append(m_AD_Infowindow_ID);
		}else{
			// case set for a all process or non set for process (set for window or infowindow)
			sql.append(" AND AD_InfoWindow_ID IS NULL");
		}
		
		if (m_AD_Process_ID_Of_Panel > 0){
			// in case Preference for process, set PreferenceFor = P
			sql.append(" AND PreferenceFor = 'P'");
		}else if (m_AD_Infowindow_ID > 0){
			// in case Preference for info window, set PreferenceFor = I
			sql.append(" AND PreferenceFor = 'I'");
		}else {
			// in case Preference for window, set PreferenceFor = W
			sql.append(" AND PreferenceFor = 'W'");
		}
		
		sql.append(" AND Attribute='").append(m_Attribute).append("'");
		//
		if (log.isLoggable(Level.FINE)) log.fine( sql.toString());
		int no = DB.executeUpdate(sql.toString(), null);
		if (no > 0)
			Env.setContext(m_ctx, getContextKey(), (String)null);
		return no;
	}   //  delete

	/**
	 *  Get Context Key
	 *  preferences in context update follow key.
	 *  they load when login, and update when change.
	 *  @see Login#loadPreferences(org.compiere.util.KeyNamePair, org.compiere.util.KeyNamePair, java.sql.Timestamp, String)
	 *  and set to field when display field, {@link GridField#getDefault()}
	 *  @return Context Key
	 */
	private String getContextKey()
	{
		// add window id info in case have process or field in info window parameter
		StringBuilder preferencesContextKey = new StringBuilder ("P") ;
		if (m_AD_Window_ID > 0){
			preferencesContextKey.append(m_AD_Window_ID);
		}else{
			preferencesContextKey.append("0");
		}
		// add info window info in case have process or field in info window parameter
		if (cbInfowindow.isChecked()){
			preferencesContextKey.append("|").append(m_AD_Infowindow_ID);
		}else{
			preferencesContextKey.append("|0");
		}
		
		if (m_AD_Process_ID_Of_Panel > 0){
			// add info process info and field info in case have process
			if (cbProcess.isChecked())
				return preferencesContextKey.append("|").append(m_AD_Process_ID_Of_Panel).append("|").append(m_Attribute).toString();
			else{
				return preferencesContextKey.append("|0|").append(m_Attribute).toString();
			}
		}else if (m_AD_Infowindow_ID > 0){
			// add field info in case lie in info window parameter
			return preferencesContextKey.append("|").append(m_Attribute).toString();
		}else{
			// key in case lie in standard window
			if (cbWindow.isChecked())
				return "P" + m_AD_Window_ID + "|" + m_Attribute;
			else
				return "P|" + m_Attribute;
		}
		
	}   //  getContextKey

	/**
	 *  Save to Disk
	 */
	public void insert()
	{
		log.info("");

		//  --- Delete first
		int no = delete();
		
		//	Handle NULL
		if (m_Value == null || m_Value.length() == 0)
		{
			if (DisplayType.isLookup(m_DisplayType))
				m_Value = "-1";	//	 -1 may cause problems (BPartner - M_DiscountSchema
			else if (DisplayType.isDate(m_DisplayType))
				m_Value = " ";
			else
			{
				Dialog.warn(m_WindowNo, this.getTitle(), "ValuePreferenceNotInserted");
				return;
			}
		}

		//  --- Inserting
		int Client_ID = cbClient.isChecked() ? m_AD_Client_ID : 0;
		int Org_ID = cbOrg.isChecked() ? m_AD_Org_ID : 0;
		int AD_Preference_ID = DB.getNextID(m_ctx, "AD_Preference", null);
		//
		StringBuilder sql = new StringBuilder ("INSERT INTO AD_Preference ("
			+ "AD_Preference_ID, AD_Preference_UU, AD_Client_ID, AD_Org_ID, IsActive, Created,CreatedBy,Updated,UpdatedBy,"
			+ "AD_Window_ID, AD_Process_ID, AD_InfoWindow_ID, PreferenceFor, AD_User_ID, Attribute, Value) VALUES (");
		sql.append(AD_Preference_ID).append(",").append(DB.TO_STRING(UUID.randomUUID().toString())).append(",").append(Client_ID).append(",").append(Org_ID)
			.append(", 'Y',getDate(),").append(m_AD_User_ID).append(",getDate(),").append(m_AD_User_ID).append(", ");
		
		if (cbWindow.isChecked())
			sql.append(m_AD_Window_ID).append(",");
		else
			sql.append("NULL,") ;
		
		// set value for AD_Process_ID and PreferenceFor
		if(m_AD_Process_ID_Of_Panel > 0 && cbProcess.isChecked()){
			sql.append(m_AD_Process_ID_Of_Panel).append(",");
			
		}else{
			// in case Preference for window, AD_Process_ID always null
			sql.append("NULL,");
		}
		
		// set info window id
		if (m_AD_Infowindow_ID > 0 && cbInfowindow.isChecked()){
			sql.append(m_AD_Infowindow_ID).append(",");
				
		}else {
			sql.append("NULL,");
		}
		
		if (m_AD_Process_ID_Of_Panel > 0){
			// in case Preference for process, set PreferenceFor = P
			sql.append("'P',");
		}else if (m_AD_Infowindow_ID > 0){
			// in case Preference for info window, set PreferenceFor = I
			sql.append("'I',");
		}else {
			// in case Preference for window, set PreferenceFor = W
			sql.append("'W',");
		}
		
		if (cbUser.isChecked())
			sql.append(m_AD_User_ID).append(",");
		else
			sql.append("NULL,");
		//
		sql.append(DB.TO_STRING(m_Attribute)).append(",").append(DB.TO_STRING(m_Value)).append(")");
		//
		if (log.isLoggable(Level.FINE)) log.fine( sql.toString());
		no = DB.executeUpdate(sql.toString(), null);
		if (no == 1)
		{
			Env.setContext(m_ctx, getContextKey(), m_Value);
			Dialog.info(m_WindowNo, "ValuePreferenceInserted");
		}
		else
			Dialog.warn(m_WindowNo, this.getTitle(), "ValuePreferenceNotInserted");

	}   //  insert

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		if (adwindowContent != null) {
			adwindowContent.hideBusyMask();
		}
	}

	
}   //  ValuePreference
