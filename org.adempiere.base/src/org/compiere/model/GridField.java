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
 * Contributor(s): Victor Perez e-Evolution victor.perez@e-evolution.com      *
 *****************************************************************************/
package org.compiere.model;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.logging.Level;

import org.adempiere.base.LookupFactoryHelper;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;
import org.idempiere.util.ParseSeq;

/**
 *  Grid Field Model.
 *  <p>
 *  Fields are a combination of AD_Field (the display attributes)
 *  and AD_Column (the storage attributes).
 *  <p>
 *  The Field maintains the current edited value. If the value is changed,
 *  it fire PropertyChange "FieldValue".
 *  If the background is changed the PropertyChange "FieldAttribute" is fired.
 *  <br>
 *  Usually editors listen to their fields.
 *
 *  @author Jorg Janke
 *  @author Victor Perez , e-Evolution.SC FR [ 1757088 ], [1877902] Implement JSR 223 Scripting APIs to Callout
 *  		https://sourceforge.net/p/adempiere/feature-requests/318/ to FR [1877902]
 *  @author Carlos Ruiz, qss FR [1877902]
 *  @author Juan David Arboleda (arboleda), GlobalQSS, [ 1795398 ] Process Parameter: add display and readonly logic
 *  @author Teo Sarca, teo.sarca@gmail.com
 *  		<li>BF [ 2874646 ] GridField issue when a lookup is key
 *  			https://sourceforge.net/p/adempiere/bugs/2164/
 *  @author victor.perez@e-evolution.com,www.e-evolution.com
 *  		<li>BF [ 2910358 ] Error in context when a field is found in different tabs.
 *  			https://sourceforge.net/p/adempiere/bugs/2255/
 *     		<li>BF [ 2910368 ] Error in context when IsActive field is found in different
 *  			https://sourceforge.net/p/adempiere/bugs/2256/
 *  		<li>BF [ 3007342 ] Included tab context conflict issue
 *  			https://sourceforge.net/p/adempiere/bugs/2409/
 *  @version $Id: GridField.java,v 1.5 2006/07/30 00:51:02 jjanke Exp $
 */
public class GridField 
	implements Serializable, Evaluatee, Cloneable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 496387784464611123L;

	/**
	 *  Field Constructor.
	 *  requires initField for complete instantiation
	 *  @param vo ValueObjecy
	 */
	public GridField (GridFieldVO vo)
	{
		m_vo = vo;
		//  Set Attributes
		loadLookup();
		setError(false);
	}   //  GridField

	/** Value Object                */
	private GridFieldVO        m_vo;
	/** The Mnemonic				*/
	private char			m_mnemonic = 0;
	
	private GridTab m_gridTab;
	
	/** 
	 * Use by lookup editor to indicate setting of new value is in progress.
	 * GridTab.processDependentFields will check this flag to avoid clearing of lookup field value that just have been set.
	 **/ 
	private boolean m_lookupEditorSettingValue = false;
	private boolean m_lockedRecord = false;
	
	/**
	 *  Dispose
	 */
	protected void dispose()
	{
		m_propertyChangeListeners = null;
		if (m_lookup != null)
			m_lookup.dispose();
		m_lookup = null;
		m_vo.lookupInfo = null;
		m_vo = null;
	}   //  dispose


	/** Lookup for this field       */
	private Lookup			m_lookup = null;
	/** New Row / inserting         */
	private boolean			m_inserting = false;


	/** Max Display Length = 60		*/
	public static final int MAXDISPLAY_LENGTH = 60;

	/** The current value                   */
	private Object          m_value = null;
	/** The old to force Property Change    */
	private static Object   s_oldValue = new Object();
	/** The old/previous value              */
	private Object          m_oldValue = s_oldValue;
	/** Only fire Property Change if old value really changed   */
	private boolean         m_valueNoFire = true;
	/** Error Status                        */
	private boolean         m_error = false;
	/** Parent Check						*/
	private Boolean			m_parentValue = null;

	/** Property Change         			*/
	private PropertyChangeSupport m_propertyChangeListeners = new PropertyChangeSupport(this);
	/** PropertyChange Name 				*/
	public static final String  PROPERTY = "FieldValue";
	/** Indicator for new Value				*/
	public static final String  INSERTING = "FieldValueInserting";

	/** Error Value for HTML interface          */
	private String			m_errorValue = null;
	/** Error Value indicator for HTML interface    */
	private boolean			m_errorValueFlag = false;

	/**	Logger			*/
	private static CLogger	log = CLogger.getCLogger(GridField.class);
	
	
	/**************************************************************************
	 *  Set Lookup for columns with lookup
	 */
	public void loadLookup()
	{
		if (!isLookup())
			return;
		if (log.isLoggable(Level.CONFIG)) log.config("(" + m_vo.ColumnName + ")");

		if (DisplayType.isLookup(m_vo.displayType))
		{
			if (m_vo.IsDisplayed)
			{
				if (m_vo.lookupInfo == null)
				{
					log.log(Level.SEVERE, "(" + m_vo.ColumnName + ") - No LookupInfo");
					return;
				}
				//
				loadLookupNoValidate();
			}
		}
		else 
		{
			loadLookupFromFactory();
			
		}
	}   //  m_lookup

	private void loadLookupFromFactory() {
		//http://jira.idempiere.com/browse/IDEMPIERE-694		
		m_lookup = LookupFactoryHelper.getLookup(m_vo);
	}

	/***
	 * bypass isdisplay validation, used by findwindow
	 */
	public void loadLookupNoValidate() {
		if (m_vo.lookupInfo == null && isLookup()) {
			m_vo.loadLookupInfo();
		}
		if (m_vo.lookupInfo == null) {
			return;
		}
		//	Prevent loading of CreatedBy/UpdatedBy
		if (m_vo.displayType == DisplayType.Table
			&& (m_vo.ColumnName.equals("CreatedBy") || m_vo.ColumnName.equals("UpdatedBy")) )
		{
			m_vo.lookupInfo.IsCreadedUpdatedBy = true;
			m_vo.lookupInfo.DisplayType = DisplayType.Search;
			m_vo.displayType = DisplayType.Search;
		}
		m_vo.lookupInfo.IsKey = isKey();
		loadLookupFromFactory();
	}

	/**
	 *  Wait until Load is complete
	 */
	public void lookupLoadComplete()
	{
		if (m_lookup == null)
			return;
		m_lookup.loadComplete();
	}   //  loadCompete

	/**
	 *  Get Lookup, may return null
	 *  @return lookup
	 */
	public Lookup getLookup()
	{ 
		if (m_lookup == null) loadLookupNoValidate(); // IDEMPIERE-913
		return m_lookup;
	}    //  getLookup

	/**
	 *  Is this field a Lookup?.
	 *  @return true if lookup field
	 */
	public boolean isLookup()
	{
		boolean retValue = false;
		if (DisplayType.isLookup(m_vo.displayType))
			retValue = true;
		else if (m_vo.IsKey)
			retValue = false;
		else {
			//http://jira.idempiere.com/browse/IDEMPIERE-694
			if (LookupFactoryHelper.isLookup(m_vo))
				retValue = true;
		}
		return retValue;
	}   //  isLookup

	/**
	 *  Refresh Lookup if the lookup is unstable
	 *  @return true if lookup is validated
	 */
	public boolean refreshLookup()
	{
		if (m_lookup == null)
			return true;

		//  if there is a validation string, the lookup is unstable - read-only fields are not loaded initially
		if (m_lookup.getValidation().length() == 0 && m_lookup.isLoaded())
			return true;
		//
		if (log.isLoggable(Level.FINE)) log.fine("(" + m_vo.ColumnName + ")");
		m_lookup.refresh();
		return m_lookup.isValidated();
	}   //  refreshLookup

	/**
	 *  Get a list of variables, this field is dependent on.
	 *  - for display purposes or
	 *  - for lookup purposes
	 *  @return ArrayList
	 */
	public ArrayList<String> getDependentOn()
	{
		ArrayList<String> list = new ArrayList<String>();
		//  Display
		Evaluator.parseDepends(list, m_vo.DisplayLogic);
		Evaluator.parseDepends(list, m_vo.ReadOnlyLogic);
		Evaluator.parseDepends(list, m_vo.MandatoryLogic);
		// Virtual UI Column
		if (m_vo.ColumnSQL != null && m_vo.ColumnSQL.length() > 0 && m_vo.ColumnSQL.startsWith("@SQL="))
			Evaluator.parseDepends(list, m_vo.ColumnSQL.substring(5));
		//  Lookup
		if (m_lookup != null)
			Evaluator.parseDepends(list, m_lookup.getValidation());
		//
		if (list.size() > 0 && CLogMgt.isLevelFiner())
		{
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < list.size(); i++)
				sb.append(list.get(i)).append(" ");
			if (log.isLoggable(Level.FINER)) log.finer("(" + m_vo.ColumnName + ") " + sb.toString());
		}
		return list;
	}   //  getDependentOn

	
	/**************************************************************************
	 *	Set Error.
	 *  Used by editors to set the color
	 *  @param error true if error
	 */
	public void setError (boolean error)
	{
		m_error = error;
	}	//	setBackground

	/**
	 *	Get Background Error.
	 *  @return error
	 */
	public boolean isError()
	{
		return m_error;
	}	//	isError


	/**
	 *	Is it Mandatory to enter for user?
	 *  Mandatory checking is dome in MTable.getMandatory
	 *  @param checkContext - check environment (requires correct row position)
	 *  @return true if mandatory
	 */
	public boolean isMandatory (boolean checkContext)
	{
//	  Do we have a mandatory rule
		if (checkContext && m_vo.MandatoryLogic.length() > 0)
		{
			boolean retValue  = false;
			if (m_vo.MandatoryLogic != null && m_vo.MandatoryLogic.startsWith("@SQL=")) {
				retValue = Evaluator.parseSQLLogic(m_vo.MandatoryLogic, m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, m_vo.ColumnName);

			} else{
				retValue= Evaluator.evaluateLogic(this, m_vo.MandatoryLogic);

			}
			
			if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " Mandatory(" + m_vo.MandatoryLogic + ") => Mandatory-" + retValue);
			if (retValue)
				return true;
		}
		
		//  Not mandatory
		if (!m_vo.IsMandatory || isVirtualColumn())
			return false;

		//  Numeric Keys and Created/Updated as well as 
		//	DocumentNo/Value/ASI are not mandatory (persistence layer manages them)
		if (m_gridTab != null &&  // if gridtab doesn't exist then it's not a window field (probably a process parameter field)
			  (   (m_vo.IsKey && m_vo.ColumnName.endsWith("_ID"))
				|| m_vo.ColumnName.startsWith("Created") || m_vo.ColumnName.startsWith("Updated")
				|| m_vo.ColumnName.equals("Value") 
				|| m_vo.ColumnName.equals("DocumentNo")
				|| m_vo.ColumnName.equals("M_AttributeSetInstance_ID") 	//	0 is valid
			  )
			)
			return false;

		//  Mandatory if displayed
		return isDisplayed (checkContext);
	}	//	isMandatory

	/**
	 *	Is parameter Editable - checks if parameter is Read Only
	 *  @param checkContext if true checks Context
	 *  @return true, if editable
	 */
	public boolean isEditablePara(boolean checkContext) {
		if (checkContext && m_vo.ReadOnlyLogic.length() > 0)
		{
			if (m_vo.ReadOnlyLogic.startsWith("@SQL="))
			{
				boolean retValue = !Evaluator.parseSQLLogic(m_vo.ReadOnlyLogic, m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, m_vo.ColumnName);
				if (!retValue)
					return false;
			}
			else
			{
				boolean retValue = !Evaluator.evaluateLogic(this, m_vo.ReadOnlyLogic);
				if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " R/O(" + m_vo.ReadOnlyLogic + ") => R/W-" + retValue);
				if (!retValue)
					return false;
			}
		}

		//  ultimately visibility decides
		return isDisplayed (checkContext);
	}
	
	/**
	 *	Is it Editable - checks IsActive, IsUpdateable, and isDisplayed
	 *  @param checkContext if true checks Context for Active, IsProcessed, LinkColumn
	 *  @return true, if editable
	 */
	public boolean isEditable (boolean checkContext)
	{
		return isEditable(m_vo.ctx, checkContext,false);
	}
	
	/**
	 *	Is it Editable in Grid- checks IsActive, IsUpdateable, and isDisplayedGrid
	 *  @param checkContext if true checks Context for Active, IsProcessed, LinkColumn
	 *  @return true, if editable
	 */
	public boolean isEditableGrid (boolean checkContext)
	{
		return isEditable(m_vo.ctx, checkContext,true);
	}
	
	/**
	 *	Is it Editable - checks IsActive, IsUpdateable, and isDisplayed
	 *  @param checkContext if true checks Context for Active, IsProcessed, LinkColumn
	 *  @return true, if editable
	 */
	public boolean isEditable (Properties ctx, boolean checkContext,boolean isGrid)
	{
		if (isVirtualColumn())
			return false;
		if (m_lockedRecord)
			return false;
		//  Fields always enabled (are usually not updateable)
		if (m_vo.ColumnName.equals("Posted")
			|| (m_vo.ColumnName.equals("Record_ID") && m_vo.displayType == DisplayType.Button))	//  Zoom
			return true;

		//  Tab or field is R/O
		if (m_vo.tabReadOnly || m_vo.IsReadOnly)
		{
			if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " NO - TabRO=" + m_vo.tabReadOnly + ", FieldRO=" + m_vo.IsReadOnly);
			return false;
		}

		//  Fields always updateable
		if (m_vo.IsAlwaysUpdateable)
		{
			return true;
		}
		
		//  Do we have a Always updatable rule
		if (checkContext && m_vo.AlwaysUpdatableLogic.length() > 0)
		{
			boolean isAlwaysUpdatable = false;
			if (m_vo.AlwaysUpdatableLogic.startsWith("@SQL=")) {
				isAlwaysUpdatable = Evaluator.parseSQLLogic(m_vo.AlwaysUpdatableLogic, m_vo.ctx, m_vo.WindowNo,
						m_vo.TabNo, m_vo.ColumnName);
			} else {
				isAlwaysUpdatable = Evaluator.evaluateLogic(this, m_vo.AlwaysUpdatableLogic);
				if (log.isLoggable(Level.FINEST))
					log.finest(m_vo.ColumnName + " R/O(" + m_vo.AlwaysUpdatableLogic + ") => R/W-" + isAlwaysUpdatable);

			}
			if(isAlwaysUpdatable)
				return true;
		}
		
		
			

		//check tab context
		if (checkContext && getGridTab() != null &&
			! "Y".equals(Env.getContext(Env.getCtx(), getWindowNo(), "_QUICK_ENTRY_MODE_")))
		{
			if (getGridTab().isReadOnly())
			{
				return false;
			}
		}

		//	Not Updateable - only editable if new updateable row
		if (!m_vo.IsUpdateable && !m_inserting)
		{
			if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " NO - FieldUpdateable=" + m_vo.IsUpdateable);
			return false;
		}

		//	Field is the Link Column of the tab
		if (m_vo.ColumnName.equals(Env.getContext(ctx, m_vo.WindowNo, m_vo.TabNo, GridTab.CTX_LinkColumnName)))
		{
			if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " NO - LinkColumn");
			return false;
		}

		//	Role Access & Column Access			
		if (checkContext)
		{
			int AD_Client_ID = Env.getContextAsInt(ctx, m_vo.WindowNo, m_vo.TabNo, "AD_Client_ID");
			int AD_Org_ID = Env.getContextAsInt(ctx, m_vo.WindowNo, m_vo.TabNo, "AD_Org_ID");
			String keyColumn = Env.getContext(ctx, m_vo.WindowNo, m_vo.TabNo, GridTab.CTX_KeyColumnName);
			if ("EntityType".equals(keyColumn))
				keyColumn = "AD_EntityType_ID";
			if (!keyColumn.endsWith("_ID"))
				keyColumn += "_ID";			//	AD_Language_ID
			if (getGridTab() != null) {
				int Record_ID = Env.getContextAsInt(ctx, m_vo.WindowNo, m_vo.TabNo, keyColumn);
				int AD_Table_ID = m_vo.AD_Table_ID;
				if (!MRole.getDefault(ctx, false).canUpdate(
					AD_Client_ID, AD_Org_ID, AD_Table_ID, Record_ID, false))
					return false;
				if (!MRole.getDefault(ctx, false).isColumnAccess(AD_Table_ID, m_vo.AD_Column_ID, false))
					return false;
				if (getDisplayType() == DisplayType.Button) {
					if (getAD_Process_ID() > 0) {
						// Verify access to process for buttons
						Boolean access = MRole.getDefault().getProcessAccess(getAD_Process_ID());
						if (access == null || !access.booleanValue())
							return false;
					}
					else if (getAD_InfoWindow_ID() > 0) {
						// Verify access to info window for buttons
						Boolean access = MRole.getDefault().getInfoAccess(getAD_InfoWindow_ID());
						if (access == null || !access.booleanValue())
							return false;
					}
				}
				
			}
		}
			
		//  Do we have a readonly rule
		if (checkContext && m_vo.ReadOnlyLogic.length() > 0)
		{
			if (m_vo.ReadOnlyLogic.startsWith("@SQL="))
			{
				boolean retValue = !Evaluator.parseSQLLogic(m_vo.ReadOnlyLogic, m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, m_vo.ColumnName);
				if (!retValue)
					return false;
			}
			else
			{
				boolean retValue = !Evaluator.evaluateLogic(this, m_vo.ReadOnlyLogic);
				if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " R/O(" + m_vo.ReadOnlyLogic + ") => R/W-" + retValue);
				if (!retValue)
					return false;
			}
		}
		
		//BF [ 2910368 ]
		//  Always editable if Active
		if (checkContext && "Y".equals(Env.getContext(ctx, m_vo.WindowNo, m_vo.TabNo, "IsActive"))
				&& (   m_vo.ColumnName.equals("Processing")
					|| m_vo.ColumnName.equals("PaymentRule")
					|| m_vo.ColumnName.equals("DocAction") 
					|| m_vo.ColumnName.equals("GenerateTo")))
			return true;

		//  Record is Processed	***	
		if (checkContext 
			&& ("Y".equals(get_ValueAsString("Processed")) || "Y".equals(get_ValueAsString("Processing"))) )
			return false;

		//  IsActive field is editable, if record not processed
		if (m_vo.ColumnName.equals("IsActive"))
			return true;
		// BF [ 2910368 ]
		// Record is not Active
		if (checkContext && getGridTab() != null && !Env.getContext(ctx, m_vo.WindowNo,m_vo.TabNo, "IsActive").equals("Y"))
			return false;


		
		return isDisplayed (ctx, checkContext);
	}	//	isEditable

	/**
	 *  Set Inserting (allows to enter not updateable fields).
	 *  Reset when setting the Field Value
	 *  @param inserting true if inserting
	 */
	public void setInserting (boolean inserting)
	{
		m_inserting = inserting;
	}   //  setInserting

	
	/**************************************************************************
	 *	Create default value.
	 *  <pre>{@code
	 *		(a) Key/Parent/IsActive/SystemAccess
	 *      (b) SQL Default
	 *		(c) Column Default		//	system integrity
	 *      (d) User Preference
	 *		(e) System Preference
	 *		(f) DataType Defaults
	 *
	 *  Don't default from Context => use explicit defaultValue
	 *  (would otherwise copy previous record)
	 *  }</pre>
	 *  this method code in mind GirdField lie at standard window, and default is receive when new record.
	 *  maybe it will don't suitable for use at other place as info panel parameter,...
	 *  @return default value or null
	 */
	public Object getDefault()
	{
		/**
		 *  (a) Key/Parent/IsActive/SystemAccess
		 */
		if (isIgnoreDefault())
			return null;
		
		String orderGetDefault = "123457";// this value can put to system configuration
		
		Object defaultValue = null;
		
		if ((defaultValue = getDefault (orderGetDefault)) != null){
			return defaultValue;
		}
		
		/**
		 *  No resolution
		 */
		if (log.isLoggable(Level.FINE)) log.fine("[NONE] " + m_vo.ColumnName);
		return null;
	}	//	getDefault
	
	/**
	 * get default of field when field don't lie down at standard window
	 * @return
	 */
	public Object getDefaultForPanel (){
		//default is preference for field > special case > default logic > sql default > data-type default
		String defaultSeq = "623";
		return getDefault (MSysConfig.getValue(MSysConfig.ZK_SEQ_DEFAULT_VALUE_PANEL, defaultSeq, Env.getAD_Client_ID(m_vo.ctx)));
	}
	
	/**
	 * Get default value with priority define by seqGetDefaultValueStr
	 * @param seqGetDefaultValueStr
	 * @return
	 */
	public Object getDefault(String seqGetDefaultValueStr){
		ParseSeq seqGetDefaultValue = ParseSeq.getNumberOrder(seqGetDefaultValueStr);
		
		if (seqGetDefaultValue == null)
			throw new AdempiereException ("seq define for get default value has wrong value");

		return getDefault (seqGetDefaultValue);
	}
	
	/**
	 * Get default value with priority define by seqGetDefaultValue
	 * @param seqGetDefaultValue
	 * @return
	 */
	public Object getDefault(ParseSeq seqGetDefaultValue){
		Object defaultValue = null;
		for (Character seqType : seqGetDefaultValue){
			if (   seqType == '3'  // default from Expression 
				&& m_vo.DefaultValue != null
				&& m_vo.DefaultValue.toUpperCase().equals("NULL")) // IDEMPIERE-2678
				return null;
			defaultValue = getDefaultValueByType(seqType);
			if (defaultValue != null)
				return defaultValue;
		}
		
		return defaultValue;
	}
	
	/**
	 * "1" mean from special case
	 * "2" mean from sql default
	 * "3" mean from default logic
	 * "4" mean user preference
	 * "5" mean from system preference
	 * "6" mean preference for field lie down at panel as process parameter, info parameter,...
	 * "7" mean data-type default
	 * @param defaultValueType
	 * @return
	 */
	protected Object getDefaultValueByType (Character defaultValueType){
		if (defaultValueType.equals('1')){
			return defaultForSpecialCase();
		}else if (defaultValueType.equals('2')){
			return defaultFromSQLExpression();
		}else if (defaultValueType.equals('3')){
			return defaultFromExpression();
		}else if (defaultValueType.equals('4') || defaultValueType.equals('5')){
			return defaultFromPreference(defaultValueType);
		}else if (defaultValueType.equals('6')){
			return defaultFromPreferenceForPanel();
		}else if (defaultValueType.equals('7')){
			return defaultFromDatatype();
		}
		
		return null;
	}
	
	protected boolean isIgnoreDefault (){
		// No defaults for these fields
		return (m_vo.IsKey || m_vo.displayType == DisplayType.RowID 
				|| DisplayType.isLOB(m_vo.displayType)
				|| "Created".equals(m_vo.ColumnName) // for Created/Updated default is managed on PO, and direct inserts on DB
				|| "Updated".equals(m_vo.ColumnName));
	}

	/**
	 * When field lie down at standard window, for make new record, some column is fix will special logic
	 * example: reference column at child tab always use parent value
	 * active column always true
	 * in system client always use system for client
	 * @return
	 */
	protected Object defaultForSpecialCase (){
		Object defaultValue = null;
		// Set Parent to context if not explicitly set
		if ((defaultValue = defaultFromParent()) != null){
			return defaultValue;
		}
		
		// is active field then return "Y"
		if ((defaultValue = defaultForActiveField()) != null){
			return defaultValue;
		}
		
		// Set Client & Org to System, if System access
		if ((defaultValue = defaultForClientOrg()) != null){
			return defaultValue;
		}
		
		return null;
	}
	
	protected Object defaultFromParent (){
		// Set Parent to context if not explicitly set
		if (isParentValue()
			&& (m_vo.DefaultValue == null || m_vo.DefaultValue.length() == 0))
		{
			String parent = Env.getContext(m_vo.ctx, m_vo.WindowNo, m_vo.ColumnName);
			if (log.isLoggable(Level.FINE)) log.fine("[Parent] " + m_vo.ColumnName + "=" + parent);
			return createDefault(parent);
		}
		return null;
	}

	protected Object defaultForActiveField (){
		// Always Active
		if (m_vo.ColumnName.equals("IsActive"))
		{
			if (log.isLoggable(Level.FINE)) log.fine("[IsActive] " + m_vo.ColumnName + "=Y");
			return "Y";
		}
		
		return null;
	}
	
	protected Object defaultForClientOrg (){
		// Set Client & Org to System, if System access
		if (X_AD_Table.ACCESSLEVEL_SystemOnly.equals(Env.getContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, GridTab.CTX_AccessLevel))
			&& (m_vo.ColumnName.equals("AD_Client_ID") || m_vo.ColumnName.equals("AD_Org_ID")))
		{
			if (log.isLoggable(Level.FINE)) log.fine("[SystemAccess] " + m_vo.ColumnName + "=0");
			return Integer.valueOf(0);
		}
		//	Set Org to System, if Client access
		else if (X_AD_Table.ACCESSLEVEL_SystemPlusClient.equals(Env.getContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, GridTab.CTX_AccessLevel))
			&& m_vo.ColumnName.equals("AD_Org_ID"))
		{
			if (log.isLoggable(Level.FINE)) log.fine("[ClientAccess] " + m_vo.ColumnName + "=0");
			return Integer.valueOf(0);
		}
		
		return null;
	}
	
	protected Object defaultFromSQLExpression () {
		/**
		 *  (b) SQL Statement (for data integity & consistency)
		 */
		String	defStr = "";
		if (m_vo.DefaultValue != null && m_vo.DefaultValue.startsWith("@SQL="))
		{
			String sql = m_vo.DefaultValue.substring(5);			//	w/o tag
			//hengsin, capture unparseable error to avoid subsequent sql exception
			sql = Env.parseContext(m_vo.ctx, m_vo.WindowNo, sql, false, false);	//	replace variables
			if (sql.equals(""))
			{
				log.log(Level.WARNING, "(" + m_vo.ColumnName + ") - Default SQL variable parse failed: "
					+ m_vo.DefaultValue);
			}
			else
			{
				PreparedStatement stmt = null;
				ResultSet rs = null;
				try
				{					
					String trxName = m_gridTab != null ? m_gridTab.getTableModel().get_TrxName() : null;
					stmt = DB.prepareStatement(sql, trxName);
					rs = stmt.executeQuery();
					if (rs.next())
						defStr = rs.getString(1);
					else
					{
						if (log.isLoggable(Level.INFO))
							log.log(Level.INFO, "(" + m_vo.ColumnName + ") - no Result: " + sql);
					}
				}
				catch (SQLException e)
				{
					log.log(Level.WARNING, "(" + m_vo.ColumnName + ") " + sql, e);
				}
				finally
				{
					DB.close(rs, stmt);
					rs = null;
					stmt = null;
				}
			}
			if (defStr != null && defStr.length() > 0)
			{
				if (log.isLoggable(Level.FINE)) log.fine("[SQL] " + m_vo.ColumnName + "=" + defStr);
				return createDefault(defStr);
			}

		}	//	SQL Statement
		
		return null;
	}
	
	protected Object defaultFromExpression (){
		/**
		 * 	(c) Field DefaultValue		=== similar code in AStartRPDialog.getDefault ===
		 */
		if (m_vo.DefaultValue != null && !m_vo.DefaultValue.equals("") && !m_vo.DefaultValue.startsWith("@SQL="))
		{
			String defStr = "";		//	problem is with texts like 'sss;sss'
			//	It is one or more variables/constants
			StringTokenizer st = new StringTokenizer(m_vo.DefaultValue, ",;", false);
			while (st.hasMoreTokens())
			{
				defStr = st.nextToken().trim();
				if (defStr.equals("@SysDate@"))				//	System Time
					return new Timestamp (System.currentTimeMillis());
				else if (defStr.indexOf('@') != -1)			//	it is a variable
					defStr = Env.parseContext(m_vo.ctx, m_vo.WindowNo, defStr.trim(), false, false);
				else if (defStr.indexOf("'") != -1)			//	it is a 'String'
					defStr = defStr.replace('\'', ' ').trim();

				if (!defStr.equals(""))
				{
					if (log.isLoggable(Level.FINE)) log.fine("[DefaultValue] " + m_vo.ColumnName + "=" + defStr);
					return createDefault(defStr);
				 }
			}	//	while more Tokens
		}	//	Default value
		
		return null;
	}
	
	/**
	 * get preference when field don't lie down at standard window
	 * @return
	 */
	protected Object defaultFromPreferenceForPanel() {
		String defStr = "";
		if (getAD_Process_ID_Of_Panel() > 0) {
			defStr = Env.getPreference(m_vo.ctx, getAD_Window_ID_Of_Panel(),
					getAD_InfoWindow_ID_of_Panel(), getAD_Process_ID_Of_Panel(),
					m_vo.ColumnName);

			// when have no preference set for field, and field lie in process
			// dialog call from infoWindow
			if (defStr.equals("") && getAD_InfoWindow_ID_of_Panel() > 0) {
				// try get preference for current infoWindow but all process
				defStr = Env.getPreference(m_vo.ctx, Env.adWindowDummyID,
						getAD_InfoWindow_ID_of_Panel(), 0, m_vo.ColumnName);

				if (defStr.equals("")) {
					// try get preference for current process but all infoWindow
					defStr = Env.getPreference(m_vo.ctx, Env.adWindowDummyID,
							0, getAD_Process_ID_Of_Panel(), m_vo.ColumnName);
				}

				if (defStr.equals("")) {
					// try get preference for all infoWindow and all process
					defStr = Env.getPreference(m_vo.ctx, Env.adWindowDummyID,
							0, 0, m_vo.ColumnName);
				}
			}

			if (defStr.equals("")) {
				// try get preference apply for all process and current window
				defStr = Env.getPreference(m_vo.ctx,
						getAD_Window_ID_Of_Panel(), 0, 0, m_vo.ColumnName);
			}

			if (defStr.equals("")) {
				// try get preference apply for all window and this process
				defStr = Env.getPreference(m_vo.ctx, 0, 0,
						getAD_Process_ID_Of_Panel(), m_vo.ColumnName);
			}

			if (defStr.equals("")) {
				// try get preference apply for all process and all window
				defStr = Env.getPreference(m_vo.ctx, 0, 0, 0, m_vo.ColumnName);
			}

			if (!defStr.equals("")) {
				if (log.isLoggable(Level.FINE))
					log.fine("[Process Parameter Preference] "
							+ m_vo.ColumnName + "=" + defStr);
				return createDefault(defStr);
			}
			// <- End of suggested changes
		} else if (getAD_InfoWindow_ID_of_Panel() > 0) {
			defStr = Env.getPreference(m_vo.ctx, getAD_Window_ID_Of_Panel(),
					getAD_InfoWindow_ID_of_Panel(), m_vo.ColumnName);
			if (!defStr.equals("")) {
				if (log.isLoggable(Level.FINE))
					log.fine("[Process Parameter Preference] "
							+ m_vo.ColumnName + "=" + defStr);
				return createDefault(defStr);
			}
		}
		return null;
	}
	
	/**
	 * @param defaultValueType "4" for user preference and "5" for system preference
	 * @return
	 */
	protected Object defaultFromPreference(Character defaultValueType) {
		String defStr = "";
		if (defaultValueType.equals('4')){
			/**
			 * (d) Preference (user) - P|
			 */
			defStr = Env.getPreference(m_vo.ctx, m_vo.AD_Window_ID,
					m_vo.ColumnName, false);
			if (!defStr.equals("")) {
				if (log.isLoggable(Level.FINE))
					log.fine("[UserPreference] " + m_vo.ColumnName + "="
							+ defStr);
				return createDefault(defStr);
			}
		}else if (defaultValueType.equals('5')){
			/**
			 * (e) Preference (System) - # $
			 */
			defStr = Env.getPreference(m_vo.ctx, m_vo.AD_Window_ID,
					m_vo.ColumnName, true);
			if (!defStr.equals("")) {
				if (log.isLoggable(Level.FINE))
					log.fine("[SystemPreference] " + m_vo.ColumnName + "="
							+ defStr);
				return createDefault(defStr);
			}	
		}

		return null;
	}
	
	protected Object defaultFromDatatype (){
		/**
		 *	(f) DataType defaults
		 */
		//	Button to N
		if (m_vo.displayType == DisplayType.Button && !m_vo.ColumnName.endsWith("_ID"))
		{
			if (log.isLoggable(Level.FINE)) log.fine("[Button=N] " + m_vo.ColumnName);
			return "N";
		}
		//	CheckBoxes default to No
		if (m_vo.displayType == DisplayType.YesNo)
		{
			if (log.isLoggable(Level.FINE)) log.fine("[YesNo=N] " + m_vo.ColumnName);
			return "N";
		}
		if (m_vo.ColumnName.endsWith("_ID"))
		{
			if (log.isLoggable(Level.FINE)) log.fine("[ID=null] "  + m_vo.ColumnName);
			return null;
		}
		//  actual Numbers default to zero
		if (DisplayType.isNumeric(m_vo.displayType))
		{
			if (log.isLoggable(Level.FINE)) log.fine("[Number=0] " + m_vo.ColumnName);
			return createDefault("0");
		}
		
		return null;
	}
	
	/**
	 *	Create Default Object type.
	 *  <pre>
	 *		Integer 	(IDs, Integer)
	 *		BigDecimal 	(Numbers)
	 *		Timestamp	(Dates)
	 *		Boolean		(YesNo)
	 *		default: String
	 *  </pre>
	 *  @param value string
	 *  @return type dependent converted object
	 */
	private Object createDefault (String value)
	{
		//	true NULL
		if (value == null || value.toString().length() == 0 || value.toUpperCase().equals("NULL"))
			return null;
		//	see also MTable.readData
		try
		{
			//	IDs & Integer & CreatedBy/UpdatedBy
			if (m_vo.ColumnName.endsWith("atedBy")
					|| (m_vo.ColumnName.endsWith("_ID") && DisplayType.isID(m_vo.displayType))) // teo_sarca [ 1672725 ] Process parameter that ends with _ID but is boolean
			{
				try	//	defaults -1 => null
				{
					int ii = Integer.parseInt(value);
					if (ii < 0)
						return null;
					return Integer.valueOf(ii);
				}
				catch (Exception e)
				{
					log.warning("Cannot parse: " + value + " - " + e.getMessage());
				}
				return Integer.valueOf(0);
			}
			//	Integer
			if (m_vo.displayType == DisplayType.Integer)
				return Integer.valueOf(value);
			
			//	Number
			if (DisplayType.isNumeric(m_vo.displayType))
				return new BigDecimal(value);
			
			//	Timestamps
			if (DisplayType.isDate(m_vo.displayType))
			{
				// try timestamp format - then date format -- [ 1950305 ]
				java.util.Date date = null;
				SimpleDateFormat dateTimeFormat = DisplayType.getTimestampFormat_Default();
				SimpleDateFormat dateFormat = DisplayType.getDateFormat_JDBC();
				SimpleDateFormat timeFormat = DisplayType.getTimeFormat_Default();
				try {
					if (m_vo.displayType == DisplayType.Date) {
						date = dateFormat.parse (value);
					} else if (m_vo.displayType == DisplayType.Time) {
						date = timeFormat.parse (value);
					} else {
						date = dateTimeFormat.parse (value);
					}
				} catch (java.text.ParseException e) {
					date = DisplayType.getDateFormat_JDBC().parse (value);
				}
				return new Timestamp (date.getTime());
			}
			
			//	Boolean
			if (m_vo.displayType == DisplayType.YesNo)
				return Boolean.valueOf ("Y".equals(value));
			
			//	Default
			return value;
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, m_vo.ColumnName + " - " + e.getMessage());
		}
		return null;
	}	//	createDefault

	/**
	 *  Validate initial Field Value.  Do not push direct value if it doesn't exist
	 * 	Called from GridTab.dataNew when inserting
	 *  @return true if valid
	 */
	public boolean validateValueNoDirect()
	{
		refreshLookup();
		//  null
		if (m_value == null || m_value.toString().length() == 0)
		{
			if (isMandatory(true))
			{
				m_error = true;
				return false;
			}
			else
				return true;
		}
		
		//	Search not cached
		if (getDisplayType() == DisplayType.Search && m_lookup != null)
		{
			// need to re-set invalid values - OK BPartner in PO Line - not OK SalesRep in Invoice
			if (m_lookup.getDirect(m_value, false, true) == null)
			{
				if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " Search not valid - set to null");
				setValue(null, m_inserting);
				m_error = true;
				return false;
			}
			return true;
		} 

		//  cannot be validated
		if (!isLookup() || m_lookup == null)
			return true;
		if (getDisplayType() == DisplayType.ChosenMultipleSelectionList) {
			boolean allValid = true;
			for (String vals : ((String)m_value).split(",")) {
				if (! m_lookup.containsKeyNoDirect(vals)) {
					if (m_lookup.get(vals) == null) {
						allValid = false;
						break;
					}
					String name = m_lookup.get(vals).getName();
					if (name.startsWith(MLookup.INACTIVE_S) && name.endsWith(MLookup.INACTIVE_E)) {
						allValid = false;
						break;
					}
				}
			}
			if (allValid)
				return true;
		} else if (getDisplayType() == DisplayType.ChosenMultipleSelectionTable || getDisplayType() == DisplayType.ChosenMultipleSelectionSearch) {
			boolean allValid = true;
			for (String vals : ((String)m_value).split(",")) {
				Integer vali = Integer.valueOf(vals);
				if (! m_lookup.containsKeyNoDirect(vali)) {
					if (m_lookup.get(vali) == null) {
						allValid = false;
						break;
					}
					String name = m_lookup.get(vali).getName();
					if (name.startsWith(MLookup.INACTIVE_S) && name.endsWith(MLookup.INACTIVE_E)) {
						allValid = false;
						break;
					}
				}
			}
			if (allValid)
				return true;
		} else if (m_lookup.containsKeyNoDirect(m_value)) {
			String name = m_lookup.get(m_value).getName();
			if (! ( name.startsWith(MLookup.INACTIVE_S) && name.endsWith(MLookup.INACTIVE_E) ) ) {
				return true;
			}
		}
		//	it's not null, a lookup and does not have the key
		if (isKey() || isParentValue())		//	parents/ket are not validated
			return true;	
			
		// special case for IDEMPIERE-2781
		if (   "AD_Client_ID".equals(m_vo.ColumnName)
			&& "0".equals(m_value.toString())
			&& Env.getAD_Client_ID(Env.getCtx()) == 0)
			return true;

		if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " - set to null");
		setValue(null, m_inserting);
		m_error = true;
		return false;
	}   //  validateValueNoDirect

	/**
	 *  Validate initial Field Value.  Push direct value if it doesn't exist
	 * 	Called from GridTab.setCurrentRow when inserting
	 *  @return true if valid
	 *  @deprecated use validateValueNoDirect instead
	 */
	public boolean validateValue()
	{
		//  null
		if (m_value == null || m_value.toString().length() == 0)
		{
			if (isMandatory(true))
			{
				m_error = true;
				return false;
			}
			else
				return true;
		}
		
		//	Search not cached
		if (getDisplayType() == DisplayType.Search && m_lookup != null)
		{
			// need to re-set invalid values - OK BPartner in PO Line - not OK SalesRep in Invoice
			if (m_lookup.getDirect(m_value, false, true) == null)
			{
				if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " Search not valid - set to null");
				setValue(null, m_inserting);
				m_error = true;
				return false;
			}
			return true;
		} 

		//  cannot be validated
		if (!isLookup()
			|| m_lookup == null
			|| m_lookup.containsKey(m_value))
			return true;
		//	it's not null, a lookup and does not have the key
		if (isKey() || isParentValue())		//	parents/ket are not validated
			return true;	
			
		if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName + " - set to null");
		setValue(null, m_inserting);
		m_error = true;
		return false;
	}   //  validateValue

	/**************************************************************************
	 *	Is the Column Visible ?
	 *  @param checkContext - check environment (requires correct row position)
	 *  @return true, if visible
	 */
	public boolean isDisplayed (boolean checkContext)
	{
		return isDisplayed(m_vo.ctx, checkContext);
	}

	/**************************************************************************
	 *	Is the Column Visible ?
	 *  @param checkContext - check environment (requires correct row position)
	 *  @return true, if visible
	 */
	public boolean isDisplayed (final Properties ctx, boolean checkContext)
	{
		//  ** static content **
		//  not displayed
		if (!m_vo.IsDisplayed)
			return false;
		//  no restrictions
		if (m_vo.DisplayLogic.equals(""))
			return true;

		//  ** dynamic content **
		if (checkContext)
		{
			if (m_vo.DisplayLogic.startsWith("@SQL=")) {
				return Evaluator.parseSQLLogic(m_vo.DisplayLogic, m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, m_vo.ColumnName);
			}
			Evaluatee evaluatee = new Evaluatee() {
				public String get_ValueAsString(String variableName) {
					return GridField.this.get_ValueAsString(ctx, variableName);
				}
			};
			boolean retValue = Evaluator.evaluateLogic(evaluatee, m_vo.DisplayLogic);
			if (log.isLoggable(Level.FINEST)) log.finest(m_vo.ColumnName 
				+ " (" + m_vo.DisplayLogic + ") => " + retValue);
			return retValue;
		}
		return true;
	}	//	isDisplayed

	/**
	 * 	Get Variable Value (Evaluatee)
	 *	@param variableName name
	 *	@return value
	 */
	public String get_ValueAsString (String variableName)
	{
		return get_ValueAsString(m_vo.ctx, variableName);
	}
	
	/**
	 * 	Get Variable Value (Evaluatee)
	 *	@param variableName name
	 *	@return value
	 */
	public String get_ValueAsString (Properties ctx, String variableName)
	{
		return new DefaultEvaluatee(getGridTab(), m_vo.WindowNo, m_vo.TabNo).get_ValueAsString(ctx, variableName);
	}	//	get_ValueAsString


	/**
	 *	Add Display Dependencies to given List.
	 *  Source: DisplayLogic
	 *  @param list list to be added to
	 */
	public void addDependencies (ArrayList<String> list)
	{
		//	nothing to parse
		if (!m_vo.IsDisplayed || m_vo.DisplayLogic.equals(""))
			return;

		StringTokenizer logic = new StringTokenizer(m_vo.DisplayLogic.trim(), "&|", false);

		while (logic.hasMoreTokens())
		{
			StringTokenizer st = new StringTokenizer(logic.nextToken().trim(), "!=^", false);
			while (st.hasMoreTokens())
			{
				String tag = st.nextToken().trim();					//	get '@tag@'
				//	Do we have a @variable@ ?
				if (tag.indexOf('@') != -1)
				{
					tag = tag.replace('@', ' ').trim();				//	strip 'tag'
					//	Add columns (they might not be a column, but then it is static)
					if (!list.contains(tag))
						list.add(tag);
				}
			}
		}
	}	//	addDependencies

	
	/**************************************************************************
	 *  Get Column Name
	 *  @return column name
	 */
	public String getColumnName()
	{
		return m_vo.ColumnName;
	}	//	getColumnName
	
	/**
	 *  Get Column Name or SQL .. with/without AS
	 *  @param withAS include AS ColumnName for virtual columns in select statements
	 *  @return column name
	 */
	public String getColumnSQL(boolean withAS)
	{
		if (m_vo.ColumnSQL != null && m_vo.ColumnSQL.length() > 0)
		{
			String query;
			if (m_vo.ColumnSQL.startsWith("@SQL=") || m_vo.ColumnSQL.startsWith("@SQLFIND="))
				query = "NULL";
			else
				query = m_vo.ColumnSQL;
			if (withAS)
				return query + " AS " + m_vo.ColumnName;
			else
				return query;
		}
		return m_vo.ColumnName;
	}	//	getColumnSQL
	
	/**
	 *  Get Column Name or SQL for search queries
	 *  @return column name
	 */
	public String getSearchColumnSQL()
	{
		if (m_vo.ColumnSQL != null && m_vo.ColumnSQL.length() > 0)
		{
			String query;
			if (m_vo.ColumnSQL.startsWith("@SQL="))
				query = "NULL";
			else if (m_vo.ColumnSQL.startsWith("@SQLFIND="))
				query = m_vo.ColumnSQL.substring(9);
			else
				query = m_vo.ColumnSQL;
			return query;
		}
		return m_vo.ColumnName;
	}	//	getSearchColumnSQL

	/**
	 *  Is Virtual Column
	 *  @return column is virtual
	 */
	public boolean isVirtualColumn()
	{
		return (m_vo.ColumnSQL != null && m_vo.ColumnSQL.length() > 0);
	}	//	isVirtualColumn
	
	/**
	 *  Is Virtual DB Column
	 *  @return column is virtual DB
	 */
	public boolean isVirtualDBColumn()
	{
		return (m_vo.ColumnSQL != null && m_vo.ColumnSQL.length() > 0 && !m_vo.ColumnSQL.startsWith("@SQL="));
	}	//	isVirtualDBColumn
	
	/**
	 *  Is Virtual UI Column
	 *  @return column is virtual UI
	 */
	public boolean isVirtualUIColumn()
	{
		return (m_vo.ColumnSQL != null && m_vo.ColumnSQL.length() > 0 && m_vo.ColumnSQL.startsWith("@SQL="));
	}	//	isVirtualUIColumn
	
	/**
	 *  Is Virtual search Column
	 *  @return column is virtual search
	 */
	public boolean isVirtualSearchColumn()
	{
		return (m_vo.ColumnSQL != null && m_vo.ColumnSQL.length() > 0 && m_vo.ColumnSQL.startsWith("@SQLFIND="));
	}	//	isVirtualDBColumn
	
	/**
	 * 	Get Header
	 *	@return header
	 */
	public String getHeader()
	{
		return m_vo.Header;
	}
	/**
	 * 	Get Display Type
	 *	@return dt
	 */
	public int getDisplayType()
	{
		return m_vo.displayType;
	}
	/**
	 * 	Get AD_Reference_Value_ID
	 *	@return reference value
	 */
	public int getAD_Reference_Value_ID()
	{
		return m_vo.AD_Reference_Value_ID;
	}
	/**
	 * 	Get AD_Window_ID
	 *	@return window
	 */
	public int getAD_Window_ID()
	{
		return m_vo.AD_Window_ID;
	}
	/** 
	 *  in case this field lie on parameter process panel, AD_Process_ID_Of_Panel is id of process will run in this panel 
	 *  it's difference with AD_Process_ID
	 */
	public int getAD_Process_ID_Of_Panel()
	{
		return m_vo.AD_Process_ID_Of_Panel;
	}
	
	/** 
	 *  in case this field lie on parameter process panel, AD_Process_ID_Of_Panel is id of process will run in this panel 
	 *  it's difference with AD_Process_ID
	 */
	public int getAD_Window_ID_Of_Panel()
	{
		return m_vo.AD_Window_ID_Of_Panel > 0 ? m_vo.AD_Window_ID_Of_Panel : m_vo.AD_Window_ID;		
	}
	
	public int getAD_InfoWindow_ID_of_Panel(){
		return m_vo.AD_InfoWindow_ID_Of_Panel;
	}
	
	/** get AD_Chart_ID
	 * @return chart id
	 */
	public int getAD_Chart_ID()
	{
		return m_vo.AD_Chart_ID;
	}
	
	
	/**
	 * 	Get Window No
	 *	@return window no
	 */
	public int getWindowNo()
	{
		return m_vo.WindowNo;
	}
	/**
	 * 	Get AD_Column_ID
	 *	@return column
	 */
	public int getAD_Column_ID()
	{
		return m_vo.AD_Column_ID;
	}
	/**
	 * 	Get Display Length
	 *	@return display
	 */
	public int getDisplayLength()
	{
		return m_vo.DisplayLength;
	}
	/**
	 * 	Is SameLine
	 *	@return trie if same line
	 */
	public boolean isSameLine()
	{
		return m_vo.IsSameLine;
	}
	/**
	 * 	Is Displayed
	 *	@return true if displayed
	 */
	public boolean isDisplayed()
	{
		return m_vo.IsDisplayed;
	}
	/**
	 * 	Is Displayed
	 *	@return true if displayed
	 */
	public boolean isDisplayedGrid()
	{
		return m_vo.IsDisplayedGrid;
	}
	/**
	 * 	Grid sequence number
	 *	@return sequence number
	 */
	public int getSeqNoGrid()
	{
		return m_vo.SeqNoGrid;
	}
	/**
	 * 	Get DisplayLogic
	 *	@return display logic
	 */
	public String getDisplayLogic()
	{
		return m_vo.DisplayLogic;
	}
	/**
	 * 	Get Default Value
	 *	@return default
	 */
	public String getDefaultValue()
	{
		return m_vo.DefaultValue;
	}
	/**
	 * 	Is ReadOnly
	 *	@return true if read only
	 */
	public boolean isReadOnly()
	{
		if (isVirtualColumn())
			return true;
		return m_vo.IsReadOnly;
	}
	/**
	 * 	Is Updateable
	 *	@return true if updateable
	 */
	public boolean isUpdateable()
	{
		if (isVirtualColumn())
			return false;
		return m_vo.IsUpdateable;
	}
	/**
	 * 	Is Autocomplete
	 *	@return true if autocomplete
	 */
	public boolean isAutocomplete() {
		return m_vo.IsAutocomplete;
	}
	/**
	 * 	Is Allow Copy
	 *	@return true if allow copy
	 */
	public boolean isAllowCopy() {
		/* IDEMPIERE-67
		 * Extending MColumn.isStandardColumn
		 * Force some additional columns to forbid copy from the UI
		 */
		String colname = getColumnName();
		if (   colname.equals("C_CashLine_ID")
			|| colname.equals("C_Location_ID")
			|| colname.equals("C_Payment_ID")
			|| colname.equals("DocAction")
			|| colname.equals("DocStatus")
			|| colname.equals("DocumentNo")
			|| colname.equals("EntityType")
			|| colname.equals("GrandTotal")
			|| colname.equals("IsAllocated")
			|| colname.equals("IsApproved")
			|| colname.equals("IsDelivered")
			|| colname.equals("IsGenerated")
			|| colname.equals("IsInvoiced")
			|| colname.equals("IsPaid")
			|| colname.equals("IsReconciled")
			|| colname.equals("IsSelfService")
			|| colname.equals("Line")
			|| colname.equals("Posted")
			|| colname.equals("Processed")
			|| colname.equals("ProcessedOn")
			|| colname.equals("TotalCr")
			|| colname.equals("TotalDr")
			|| colname.equals("TotalLines")
			|| colname.startsWith("Ref_"))
			return false;
		return m_vo.IsAllowCopy;
	}
	/**
	 * 	Is Always Updateable
	 *	@return true if always updateable
	 */
	public boolean isAlwaysUpdateable()
	{
		if (isVirtualColumn() || !m_vo.IsUpdateable)
			return false;
		return m_vo.IsAlwaysUpdateable;
	}
	/**
	 * 	Is Heading
	 *	@return heading
	 */
	public boolean isHeading()
	{
		return m_vo.IsHeading;
	}
	/**
	 * 	Is Field Only
	 *	@return field only
	 */
	public boolean isFieldOnly()
	{
		return m_vo.IsFieldOnly;
	}
	/**
	 * 	Is Encrypted Field (display)
	 *	@return encrypted field
	 */
	public boolean isEncryptedField()
	{
		return m_vo.IsEncryptedField;
	}
	/**
	 * 	Is Encrypted Field (display) or obscured
	 *	@return encrypted field
	 */
	public boolean isEncrypted()
	{
		if (m_vo.IsEncryptedField)
			return true;
		String ob = getObscureType();
		if (ob != null && ob.length() > 0)
			return true;
		return m_vo.ColumnName.equals("Password");
	}
	/**
	 * 	Is Encrypted Column (data)
	 *	@return encrypted column
	 */
	public boolean isEncryptedColumn()
	{
		return m_vo.IsEncryptedColumn;
	}
	/**
	 * 	Is Selection Column
	 *	@return selection
	 */
	public boolean isSelectionColumn()
	{
		return m_vo.IsSelectionColumn;
	}
	/**
	 * 	Is HTML Field (display)
	 *	@return html field
	 */
	public boolean isHtml()
	{
		return m_vo.IsHtml;
	}
	/**
	 * 	Selection column sequence
	 *	@return SeqNoSelection
	 */
	public int getSeqNoSelection() 
	{
		return m_vo.SeqNoSelection;
	}
	/**
	 * 	Get Obscure Type
	 *	@return obscure
	 */
	public String getObscureType()
	{
		return m_vo.ObscureType;
	}
	/**
	 * 	Get Sort No
	 *	@return  sort
	 */
	public int getSortNo()
	{
		return m_vo.SortNo;
	}
	/**
	 * 	Get Field Length
	 *	@return field length
	 */
	public int getFieldLength()
	{
		return m_vo.FieldLength;
	}
	/**
	 * 	Get VFormat
	 *	@return format
	 */
	public String getVFormat()
	{
		return m_vo.VFormat;
	}
	/**
	 * 	Get Format Pattern
	 *	@return format pattern
	 */
	public String getFormatPattern() {
		return m_vo.FormatPattern;
	}
	/**
	 * 	Get Value Min
	 *	@return min
	 */
	public String getValueMin()
	{
		return m_vo.ValueMin;
	}
	/**
	 * 	Get Value Max
	 *	@return max
	 */
	public String getValueMax()
	{
		return m_vo.ValueMax;
	}
	/**
	 * 	Get Field Group
	 *	@return field group
	 */
	public String getFieldGroup()
	{
		return m_vo.FieldGroup;
	}
	/**
	 * 	Get Field Group Type
	 *	@return field group type
	 */
	public String getFieldGroupType()
	{
		return m_vo.FieldGroupType;
	}
	/**
	 * 	Key
	 *	@return key
	 */
	public boolean isKey()
	{
		return m_vo.IsKey;
	}
	/**
	 * 	UUID
	 *	@return is UUID
	 */
	public boolean isUUID()
	{
		if (getGridTab() != null) {
			if (m_vo.ColumnName.equals(PO.getUUIDColumnName(getGridTab().getTableName()))) {
				return true;
			}
		}
		return false;
	}
	/**
	 * 	Parent Column
	 *	@return parent column
	 */
	public boolean isParentColumn()
	{
			return m_vo.IsParent;
	}
	/**
	 * 	Parent Link Value
	 *	@return parent value
	 */
	public boolean isParentValue()
	{
		if (m_parentValue != null)
			return m_parentValue.booleanValue();
		if (!DisplayType.isID(m_vo.displayType) || m_vo.TabNo == 0)
			m_parentValue = Boolean.FALSE;
		else 
		{
			String LinkColumnName = Env.getContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, GridTab.CTX_LinkColumnName);
			if (LinkColumnName == null || LinkColumnName.length() == 0)
				m_parentValue = Boolean.FALSE; // teo_sarca, [ 1673886 ]
			else 
				m_parentValue = Boolean.valueOf(m_vo.ColumnName.equals(LinkColumnName));
			if (m_parentValue) {
				if (log.isLoggable(Level.CONFIG)) log.config(m_parentValue
					+ " - Link(" + LinkColumnName + ", W=" + m_vo.WindowNo + ",T=" + m_vo.TabNo
					+ ") = " + m_vo.ColumnName);
			}
			else {
				m_parentValue = Boolean.valueOf(isIndirectParentValue());
			}
		}
		return m_parentValue.booleanValue();
	}	//	isParentValue
	
	/**
	 * 	Get Callout
	 *	@return callout
	 */
	public String getCallout()
	{
		return m_vo.Callout;
	}
	
	/**
	 * 	Get AD_Process_ID
	 *	@return process
	 */
	public int getAD_Process_ID()
	{
		return m_vo.AD_Process_ID;
	}
	/**
	 * 	Get AD_InfoWindow_ID
	 *	@return info window
	 */
	public int getAD_InfoWindow_ID()
	{
		return m_vo.AD_InfoWindow_ID;
	}
	/**
	 * 	Get Description
	 *	@return description
	 */
	public String getDescription()
	{
		return m_vo.Description;
	}
	/**
	 * 	Get Help
	 *	@return help
	 */
	public String getHelp()
	{
		return m_vo.Help;
	}
	/**
	 * 	Get AD_Tab_ID
	 *	@return tab
	 */
	public int getAD_Tab_ID()
	{
		return m_vo.AD_Tab_ID;
	}
	/**
	 * 	Get VO
	 *	@return value object
	 */
	public GridFieldVO getVO()
	{
		return m_vo;
	}

	/**
	 * 	Default Focus
	 *	@return focus
	 */
	public boolean isDefaultFocus()
	{
		return m_vo.IsDefaultFocus;
	}	//	isDefaultFocus

	/**
	 *  Is this a long (string/text) field (over 60/2=30 characters)
	 *  @return true if long field
	 */
	public boolean isLongField()
	{
		return (m_vo.DisplayLength >= MAXDISPLAY_LENGTH/2);
	}   //  isLongField
	
	/**
	 * 	Get AD_Field_ID
	 *	@return field
	 */
	public int getAD_Field_ID()
	{
		return m_vo.AD_Field_ID;
	}
	
	/**
	 *  Set Value to null.
	 *  <p>
	 *  Do not update context - called from GridTab.setCurrentRow
	 *  Send Bean PropertyChange if there is a change
	 */
	public void setValue ()
	{
		if (m_valueNoFire)      //  set the old value
			m_oldValue = m_value;
		m_value = null;
		m_inserting = false;
		m_error = false;        //  reset error

		//  Does not fire, if same value
		m_propertyChangeListeners.firePropertyChange(PROPERTY, m_oldValue, m_value);
	}   //  setValue

	/**
	 *  Set Value to null.
	 *  <p>
	 *  Do update context - called from GridTab.setCurrentRow
	 *  Send Bean PropertyChange if there is a change
	 */
	public void setValueAndUpdateContext ()
	{
		if (m_valueNoFire)      //  set the old value
			m_oldValue = m_value;
		m_value = null;
		m_inserting = false;
		m_error = false;        //  reset error

		// [ 1881480 ] Navigation problem between tabs
		Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.ColumnName, (String) m_value);

		//  Does not fire, if same value
		m_propertyChangeListeners.firePropertyChange(PROPERTY, m_oldValue, m_value);
	}   //  setValue

	/**
	 *  Set Value.
	 *  <p>
	 *  Update context, if not text or RowID;
	 *  Send Bean PropertyChange if there is a change
	 *  @param newValue new value
	 *  @param inserting true if inserting
	 */
	public void setValue (Object newValue, boolean inserting)
	{
		if (m_valueNoFire)      //  set the old value
			m_oldValue = m_value;
		m_value = newValue;
		m_inserting = inserting;
		m_error = false;        //  reset error

		updateContext();

		//  Does not fire, if same value
		Object oldValue = m_oldValue;
		if (inserting)
			oldValue = INSERTING;
		m_propertyChangeListeners.firePropertyChange(PROPERTY, oldValue, m_value);
	}   //  setValue

	/**
	 * Update env. context with current value
	 */
	public void updateContext() {
		//	Set Context
		if (m_vo.displayType == DisplayType.Text 
			|| m_vo.displayType == DisplayType.Memo
			|| m_vo.displayType == DisplayType.TextLong
			|| m_vo.displayType == DisplayType.Binary
			|| m_vo.displayType == DisplayType.RowID
			|| isEncrypted())
			;	//	ignore
		else if (m_value instanceof Boolean)
		{
			backupValue(); // teo_sarca [ 1699826 ]
			if (!isParentTabField() && isUpdateWindowContext())
			{
				Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.ColumnName, 
					((Boolean)m_value).booleanValue());
			}
			if (m_gridTab != null) {
				Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, m_vo.ColumnName,
						m_value==null ? null : (((Boolean)m_value) ? "Y" : "N"));
			}
		}
		else if (m_value instanceof Timestamp)
		{
			backupValue(); // teo_sarca [ 1699826 ]
			if (!isParentTabField() && isUpdateWindowContext())
			{
				Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.ColumnName, (Timestamp)m_value);
			}
			// BUG:3075946 KTU - Fix Thai Date
			String stringValue = null;
			if (m_value != null && !m_value.toString().equals("")) {
				Calendar c1 = Calendar.getInstance();
				c1.setTime((Date) m_value);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				stringValue = sdf.format(c1.getTime());
			}
			if (m_gridTab != null) {
				Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, m_vo.ColumnName, stringValue);
			}
			// KTU - Fix Thai Date		
		}
		else
		{
			backupValue(); // teo_sarca [ 1699826 ]
			if (!isParentTabField() && isUpdateWindowContext())
			{
				Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.ColumnName, 
					m_value==null ? null : m_value.toString());
			}
			if (m_gridTab != null) {
				Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, m_vo.ColumnName,
						m_value==null ? null : m_value.toString());
			}
		}		
	}
	
	public int getAD_LabelStyle_ID()
	{
		return m_vo.AD_LabelStyle_ID;
	}
	
	public int getAD_FieldStyle_ID()
	{
		return m_vo.AD_FieldStyle_ID;
	}

	/**
	 * 	Set Value and Validate
	 *	@param newValue value
	 *	@param inserting insert
	 *	@return null or error message
	 */
	public String setValueValidate (String newValue, boolean inserting)
	{
		if (newValue == null)
			setValue();

		//	Data Type Test
		int dt = getDisplayType();
		try
		{
			//	Return Integer
			if (dt == DisplayType.Integer
				|| (DisplayType.isID(dt) && getColumnName().endsWith("_ID")))
			{
				int i = Integer.parseInt(newValue);
				setValue (Integer.valueOf(i), inserting);
			}
			//	Return BigDecimal
			else if (DisplayType.isNumeric(dt))
			{
				BigDecimal value = (BigDecimal)DisplayType.getNumberFormat(dt).parse(newValue);
				setValue (value, inserting);
				return null;
			}
			//	Return Timestamp
			else if (DisplayType.isDate(dt))
			{
				long time = DisplayType.getDateFormat_JDBC().parse(newValue).getTime();
				setValue (new Timestamp(time), inserting);
				return null;
			}
			//	Return Boolean
			else if (dt == DisplayType.YesNo)
			{
				Boolean value = null;
				if (newValue.equals("Y"))
					value = Boolean.TRUE;
				else if (newValue.equals("N"))
					value = Boolean.FALSE;
				else
					return getColumnName() + " = " + newValue + " - Must be Y/N";
				setValue (value, inserting);
				return null;
			}
			else if (DisplayType.isText(dt))
			{
				setValue (newValue, inserting);
				return null;
			}
			else
				return getColumnName() + " not mapped "
					+ DisplayType.getDescription(dt);
		}
		catch (Exception ex)
		{
			log.log(Level.SEVERE, "Value=" + newValue, ex);
			
			String error = ex.getLocalizedMessage();
			if (error == null || error.length() == 0)
				error = ex.toString();
			return getColumnName() + " = " + newValue + " - " + error;
		}
		
		//	ID - test ID
		if (!DisplayType.isID(dt))
			return null;
		
		//TODO: setValueValidate

		return null;
	}	//	setValueValidate

	/**
	 *  Get Value
	 *  @return current value
	 */
	public Object getValue()
	{
		return m_value;
	}   //  getValue

	/**
	 *  Set old/previous Value.
	 *  (i.e. don't fire Property change)
	 *  Used by VColor.setField
	 *  @param value if false property change will always be fires
	 */
	public void setValueNoFire (boolean value)
	{
		m_valueNoFire = value;
	}   //  setOldValue

	/**
	 *  Get old/previous Value.
	 * 	Called from MTab.processCallout
	 *  @return old value
	 */
	public Object getOldValue()
	{
		return m_oldValue;
	}   //  getOldValue

	/**
	 *  Set Error Value (the value, which cuased some Error)
	 *  @param errorValue error message
	 */
	public void setErrorValue (String errorValue)
	{
		m_errorValue = errorValue;
		m_errorValueFlag = true;
	}   //  setErrorValue

	/**
	 *  Get Error Value (the value, which cuased some Error) <b>AND</b> reset it to null
	 *  @return error value
	 */
	public String getErrorValue ()
	{
		String s = m_errorValue;
		m_errorValue = null;
		m_errorValueFlag = false;
		return s;
	}   //  getErrorValue

	/**
	 *  Return true, if value has Error (for HTML interface) <b>AND</b> reset it to false
	 *  @return has error
	 */
	public boolean isErrorValue()
	{
		boolean b = m_errorValueFlag;
		m_errorValueFlag = false;
		return b;
	}   //  isErrorValue

	/**
	 *  Overwrite default DisplayLength
	 *  @param length new length
	 */
	public void setDisplayLength (int length)
	{
		m_vo.DisplayLength = length;
	}   //  setDisplayLength

	/**
	 *  Overwrite Displayed
	 *  @param displayed trie if displayed
	 */
	public void setDisplayed (boolean displayed)
	{
		m_vo.IsDisplayed = displayed;
	}   //  setDisplayed

	
	/**
	 * 	Create Mnemonic for field
	 *	@return no for r/o, client, org, document no
	 */
	public boolean isCreateMnemonic()
	{
		if (isReadOnly() 
			|| m_vo.ColumnName.equals("AD_Client_ID")
			|| m_vo.ColumnName.equals("AD_Org_ID")
			|| m_vo.ColumnName.equals("DocumentNo"))
			return false;
		return true;
	}
	
	/**
	 * 	Get Label Mnemonic
	 *	@return Mnemonic
	 */
	public char getMnemonic()
	{
		return m_mnemonic;
	}	//	getMnemonic
	
	/**
	 * 	Set Label Mnemonic
	 *	@param mnemonic Mnemonic
	 */
	public void setMnemonic (char mnemonic)
	{
		m_mnemonic = mnemonic;
	}	//	setMnemonic

	
	/**
	 *  String representation
	 *  @return string representation
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("GridField[")
			.append(m_vo.ColumnName).append("=").append(m_value);
		if (isKey())
			sb.append("(Key)");
		if (isParentColumn())
			sb.append("(Parent)");
		sb.append(", IsDisplayed="+m_vo.IsDisplayed);
		sb.append("]");
		return sb.toString();
	}   //  toString

	/**
	 *  Extended String representation
	 *  @return string representation
	 */
	public String toStringX()
	{
		StringBuilder sb = new StringBuilder("GridField[");
		sb.append(m_vo.ColumnName).append("=").append(m_value)
			.append(",DisplayType=").append(getDisplayType())
			.append("]");
		return sb.toString();
	}   //  toStringX


	/*************************************************************************
	 *  Remove Property Change Listener
	 *  @param l listener
	 */
	public synchronized void removePropertyChangeListener(PropertyChangeListener l)
	{
		m_propertyChangeListeners.removePropertyChangeListener(l);
	}

	/**
	 *  Add Property Change Listener
	 *  @param l listener
	 */
	public synchronized void addPropertyChangeListener(PropertyChangeListener l)
	{
		m_propertyChangeListeners.addPropertyChangeListener(l);
	}
	
	
	/**************************************************************************
	 * 	Create Fields.
	 * 	Used by APanel.cmd_find  and  Viewer.cmd_find
	 * 	@param ctx context
	 * 	@param WindowNo window
	 * 	@param TabNo tab no
	 * 	@param AD_Tab_ID tab
	 * 	@return array of all fields in display order
	 */
	public static GridField[] createFields (Properties ctx, int WindowNo, int TabNo,
		 int AD_Tab_ID)
	{
		ArrayList<GridFieldVO> listVO = new ArrayList<GridFieldVO>();
		int AD_Window_ID = 0;
		boolean readOnly = false;
		
		String sql = GridFieldVO.getSQL(ctx);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Tab_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				GridFieldVO vo = GridFieldVO.create(ctx, WindowNo, TabNo, 
					AD_Window_ID, AD_Tab_ID, readOnly, rs);
				listVO.add(vo);
			}
			Collections.sort(listVO, new GridFieldVO.SeqNoComparator());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		//
		GridField[] retValue = new GridField[listVO.size()];
		for (int i = 0; i < listVO.size(); i++)
			retValue[i] = new GridField ((GridFieldVO)listVO.get(i));
		return retValue;
	}	//	createFields
		
	/**
	 * bug[1637757]
	 * Check whether is indirect parent. 
	 * @return boolean
	 */
	private boolean isIndirectParentValue()
	{
		boolean result = false;
		int tabNo = m_vo.TabNo;
		int currentLevel = Env.getContextAsInt(m_vo.ctx, m_vo.WindowNo, tabNo, GridTab.CTX_TabLevel);
		if (tabNo > 1 && currentLevel > 1)
		{
			while ( tabNo >= 1 && !result)
			{
				tabNo--;
				int level = Env.getContextAsInt(m_vo.ctx, m_vo.WindowNo, tabNo, GridTab.CTX_TabLevel);
				if (level > 0 && level < currentLevel) 
				{
					String linkColumn = Env.getContext(m_vo.ctx, m_vo.WindowNo, tabNo, GridTab.CTX_LinkColumnName);
					if (m_vo.ColumnName.equals(linkColumn))
					{
						result = true;
						if (log.isLoggable(Level.CONFIG)) log.config(result
								+ " - Link(" + linkColumn + ", W=" + m_vo.WindowNo + ",T=" + m_vo.TabNo
								+ ") = " + m_vo.ColumnName);
					}
					currentLevel = level;
				}
			}
		}
		return result;
	}			
	
	/** Initial context value for this field - teo_sarca [ 1699826 ] */
	private String m_backupValue = null;
	
	/** Is the initial context value for this field backup ? - teo_sarca [ 1699826 ] */
	private boolean m_isBackupValue = false;
	
	/**
	 * Backup the context value
	 * @author teo_sarca [ 1699826 ]
	 */
	private final void backupValue() {
		if (!m_isBackupValue) {
			m_backupValue = get_ValueAsString(m_vo.ColumnName);
			if (log.isLoggable(Level.FINEST)) log.finest("Backup " + m_vo.WindowNo + "|" + m_vo.ColumnName + "=" + m_backupValue);
			m_isBackupValue = true;
		}
	}
	
	/**
	 * Restore the backup value if any
	 * author teo_sarca [ 1699826 ]
	 */
	public void restoreValue() {
		if (m_isBackupValue) {
			if (isParentTabField())
			{
				if (log.isLoggable(Level.FINEST)) log.finest("Restore " + m_vo.WindowNo + "|" + m_vo.TabNo + "|" + m_vo.ColumnName + "=" + m_backupValue);
				Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.TabNo, m_vo.ColumnName, m_backupValue);
			}
			else
			{
				if (log.isLoggable(Level.FINEST)) log.finest("Restore " + m_vo.WindowNo + "|" + m_vo.ColumnName + "=" + m_backupValue);
				Env.setContext(m_vo.ctx, m_vo.WindowNo, m_vo.ColumnName, m_backupValue);
			}
		}
	}
	
	/**
	 * Feature Request [1707462]
	 * Enable user to change VFormat on runtime
	 * @param strNewFormat VFormat mask
	 * author fer_luck
	 */
	public void setVFormat(String strNewFormat){
		m_vo.VFormat = strNewFormat;
	} //setVFormat
	
	
	/**
    *  Feature Request FR [ 1757088 ]
	*  Get the id tab include
	*  @return id Tab
	*/
	public int getIncluded_Tab_ID ()
	{	 
	 return m_vo.Included_Tab_ID;
	}
	
	/**
	 * Set the default state of collapse field group type
	 * @param flag
	 */
	public void setIsCollapsedByDefault(boolean flag) {
		m_vo.IsCollapsedByDefault = flag;
	}

	/**
	 * Get the default state of collapse field group type
	 */
	public boolean getIsCollapsedByDefault() {
		return m_vo.IsCollapsedByDefault;
	}
	
	/**
	 * Returns a list containing all existing entries of this field
	 * with the actual AD_Client_ID.
	 * @return List of existing entries for this field
	 */
	public List<String> getEntries() {
		/* TODO: consider caching the list to avoid repeating queries on every window open (twice, for find and for field) */
		MColumn column = MColumn.get(Env.getCtx(), getAD_Column_ID());
		MTable table = MTable.get(Env.getCtx(), column.getAD_Table_ID());
		String tableName = table.getTableName();
		String columnName = column.getColumnName();
		ArrayList<String> list = new ArrayList<String>();
		if (tableName != null && columnName != null) {
			int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sql = new StringBuilder()
					.append("SELECT DISTINCT ")
					.append(columnName)
					.append(" FROM ")
					.append(tableName)
					.append(" WHERE AD_Client_ID=? AND ")
					.append(columnName)
					.append(" IS NOT NULL ORDER BY 1");
			try {
				pstmt = DB.prepareStatement(sql.toString(), null);
				pstmt.setInt(1, AD_Client_ID);

				rs = pstmt.executeQuery();
				while (rs.next()) {
					list.add(rs.getString(1));
				}
			} catch (Exception e) {
				log.log(Level.SEVERE, sql.toString(), e);
			} finally {
				DB.close(rs, pstmt);
			}
		}
		
		return list;
	}
	
	/**
	 * @param gridTab
	 */
	public void setGridTab(GridTab gridTab)
	{
		m_gridTab = gridTab;
	}

	/**
	 * @return GridTab
	 */
	public GridTab getGridTab()
	{
		return m_gridTab;
	}
	
	/**
	 * @param columnName
	 * @return true if columnName also exist in parent tab
	 */
	private boolean isParentTabField(String columnName)
	{
		if (m_gridTab == null)
			return false;
		GridTab parentTab = m_gridTab.getParentTab();
		while (parentTab != null)
		{
			if (parentTab.getField(columnName) != null)
				return true;
			parentTab = parentTab.getParentTab();
		}
		return false; 
	}
	
	/**
	 * 
	 * @return true if this field (m_vo.ColumnName) also exist in parent tab
	 */
	private boolean isParentTabField()
	{
		return isParentTabField(m_vo.ColumnName);
	}
	
	private boolean isUpdateWindowContext()
	{
		if (getGridTab() != null)
			return getGridTab().isUpdateWindowContext();
		
		return true;
	}
	
	/*IDEMPIERE-358*/
	
	public int getXPosition()
	{
		return m_vo.XPosition;
	}
	
	public int getColumnSpan()
	{
		return m_vo.ColumnSpan;
	}
	
	public int getNumLines()
	{
		return m_vo.NumLines;
	}
	
	public boolean isToolbarButton()
	{
		return m_vo.displayType == DisplayType.Button &&
			(MColumn.ISTOOLBARBUTTON_Toolbar.equals(m_vo.IsToolbarButton) || MColumn.ISTOOLBARBUTTON_Both.equals(m_vo.IsToolbarButton));
	}

	public boolean isToolbarOnlyButton()
	{
		return m_vo.displayType == DisplayType.Button && MColumn.ISTOOLBARBUTTON_Toolbar.equals(m_vo.IsToolbarButton);
	}

	public boolean isLockedRecord() {
		return m_lockedRecord;
	}

	public void setLockedRecord(boolean lockedRecord) {
		this.m_lockedRecord = lockedRecord;
	}

	public int getPA_DashboardContent_ID()
	{
		return m_vo.PA_DashboardContent_ID;
	}

	public String getPlaceholder() {
		return m_vo.Placeholder;
	}

	public String getPlaceholder2() {
		return m_vo.Placeholder2;
	}

	public void setPlaceholder(String placeholder) {
		m_vo.Placeholder = placeholder;
	}

	public GridField clone(Properties ctx)  
	{
		try {
			GridField field = (GridField) super.clone();
			field.m_vo = field.m_vo.clone(ctx, field.m_vo.WindowNo, field.m_vo.TabNo, 
					field.m_vo.AD_Window_ID, field.m_vo.AD_Tab_ID, field.m_vo.tabReadOnly);
			field.m_vo.lookupInfo = null;
			field.m_lookup = null;
			field.m_propertyChangeListeners = new PropertyChangeSupport(this);
			return field;
		} catch (CloneNotSupportedException e) {
			throw new IllegalStateException(e.getLocalizedMessage(), e);
		}
		
	}
	
	/**
	 * @param b
	 */
	public void setLookupEditorSettingValue(boolean b)
	{
		m_lookupEditorSettingValue = b;
	}
	
	/**
	 * @return true if the setting value of this field by UI is in progress 
	 */
	public boolean isLookupEditorSettingValue()
	{
		return m_lookupEditorSettingValue;
	}
	/**
	 * Is Quick Form
	 * @return true if displayed in Quick Form
	 */
	public boolean isQuickForm() {
		return m_vo.IsQuickForm;
	}

	public void processUIVirtualColumn() {
		String sql = m_vo.ColumnSQL.substring(5);
		sql = Env.parseContext(Env.getCtx(), getWindowNo(), sql, false);
		if (Util.isEmpty(sql)) {
			setValue(null, false);
		} else {
			if (DisplayType.isDate(m_vo.displayType)) {
				Timestamp valueTS = DB.getSQLValueTSEx(null, sql, new Object[] {});
				setValue(valueTS, false);
			} else if (DisplayType.isNumeric(m_vo.displayType)) {
				BigDecimal valueBD = DB.getSQLValueBDEx(null, sql, new Object[] {});
				setValue(valueBD, false);
			} else if (DisplayType.isID(m_vo.displayType)) {
				int valueInt = DB.getSQLValueEx(null, sql, new Object[] {});
				setValue(valueInt, false);
			} else { // default to String
				String valueStr = DB.getSQLValueStringEx(null, sql);
				setValue(valueStr, false);
			}
		}
	}
}   //  GridField
