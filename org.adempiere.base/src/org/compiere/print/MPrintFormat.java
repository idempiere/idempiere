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
package org.compiere.print;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.model.MTabCustomization;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.MColumn;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.Query;
import org.compiere.model.X_AD_PrintFormat;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	AD_PrintFormat - Print Format Model.
 *	(Add missing Items with PrintFormatUtil)
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: MPrintFormat.java,v 1.3 2006/07/30 00:53:02 jjanke Exp $
 */
public class MPrintFormat extends X_AD_PrintFormat implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7542581302442072662L;

	/**
	 *	Public Constructor.
	 * 	Use static get methods
	 *  @param ctx context
	 *  @param AD_PrintFormat_ID AD_PrintFormat_ID
	 *	@param trxName transaction
	 */
	public MPrintFormat (Properties ctx, int AD_PrintFormat_ID, String trxName)
	{
		super (ctx, AD_PrintFormat_ID, trxName);
		//	Language=[Deutsch,Locale=de_DE,AD_Language=en_US,DatePattern=DD.MM.YYYY,DecimalPoint=false]
		m_language = Env.getLanguage(ctx);
		if (AD_PrintFormat_ID == 0)
		{
			setStandardHeaderFooter(true);
			setIsTableBased(true);
			setIsForm(false);
			setIsDefault(false);
		}
		m_items = getItems();
	}	//	MPrintFormat

	public void reloadItems() {
		m_items = getItems();
		if (is_Immutable() && m_items != null && m_items.length > 0)
			Arrays.stream(m_items).forEach(e -> e.markImmutable());
	}
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPrintFormat (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
		m_language = Env.getLanguage(ctx);
		m_items = getItems();
	}	//	MPrintFormat

	/**
	 * 
	 * @param copy
	 */
	public MPrintFormat(MPrintFormat copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPrintFormat(Properties ctx, MPrintFormat copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPrintFormat(Properties ctx, MPrintFormat copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_translationViewLanguage = copy.m_translationViewLanguage;
		this.m_items = copy.m_items != null ? Arrays.stream(copy.m_items).map(e -> {return new MPrintFormatItem(ctx, e, trxName);}).toArray(MPrintFormatItem[]::new) : null;
		this.m_language = copy.m_language != null ? new Language(copy.m_language) : null;
		this.m_tFormat = copy.m_tFormat != null ? new MPrintTableFormat(ctx, copy.m_tFormat, trxName) : null;
	}
	
	/** Items							*/
	private MPrintFormatItem[]		m_items = null;
	/** Translation View Language		*/
	private String					m_translationViewLanguage = null;
	/**	Language of Report				*/
	private Language 				m_language;
	/** Table Format					*/
	private MPrintTableFormat 		m_tFormat;

	/**	Static Logger	*/
	private static CLogger			s_log = CLogger.getCLogger (MPrintFormat.class);

	/**
	 * 	Get Language
	 *  @return language
	 */
	public Language getLanguage()
	{
		return m_language;
	}	//	getLanguage

	/**
	 * 	Set Language
	 *  @param language language
	 */
	public void setLanguage(Language language)
	{
		if (language != null)
		{
			m_language = language;
		}
		m_translationViewLanguage = null;
	}	//	getLanguage

	/**
	 * 	Get AD_Column_ID of Order Columns
	 * 	@return Array of AD_Column_IDs in Sort Order
	 */
	public int[] getOrderAD_Column_IDs()
	{
		HashMap<Integer,Integer> map = new HashMap<Integer,Integer>();	//	SortNo - AD_Column_ID
		for (int i = 0; i < m_items.length; i++)
		{
			//	Sort Order and Column must be > 0
			if (m_items[i].getSortNo() != 0 && m_items[i].getAD_Column_ID() != 0)
				map.put(Integer.valueOf(m_items[i].getSortNo()), Integer.valueOf(m_items[i].getAD_Column_ID()));
		}
		//	Get SortNo and Sort them
		Integer[] keys = new Integer[map.keySet().size()];
		map.keySet().toArray(keys);
		Arrays.sort(keys);

		//	Create AD_Column_ID array
		int[] retValue = new int[keys.length];
		for (int i = 0; i < keys.length; i++)
		{
			Integer value = (Integer)map.get(keys[i]);
			retValue[i] = value.intValue();
		}
		return retValue;
	}	//	getOrderAD_Column_IDs

	/**
	 * 	Get AD_Column_IDs of columns in Report
	 * 	@return Array of AD_Column_ID
	 */
	public int[] getAD_Column_IDs()
	{
		ArrayList<Integer> list = new ArrayList<Integer>();
		for (int i = 0; i < m_items.length; i++)
		{
			if (m_items[i].getAD_Column_ID() != 0 && m_items[i].isPrinted())
				list.add(Integer.valueOf(m_items[i].getAD_Column_ID()));
		}
		//	Convert
		int[] retValue = new int[list.size()];
		for (int i = 0; i < list.size(); i++)
			retValue[i] = ((Integer)list.get(i)).intValue();
		return retValue;
	}	//	getAD_Column_IDs

	/**
	 * 	Set Items
	 * 	@param items items
	 */
	private void setItems (MPrintFormatItem[] items)
	{
		if (items != null)
			m_items = items;
	}	//	setItems

	/**
	 * 	Get active Items
	 * 	@return items
	 */
	private MPrintFormatItem[] getItems()
	{
		ArrayList<MPrintFormatItem> list = new ArrayList<MPrintFormatItem>();
		String sql = "SELECT * FROM AD_PrintFormatItem pfi "
			+ "WHERE pfi.AD_PrintFormat_ID=? AND pfi.IsActive='Y'"
			//	Display restrictions - Passwords, etc.
			+ " AND NOT EXISTS (SELECT * FROM AD_Field f "
				+ "WHERE pfi.AD_Column_ID=f.AD_Column_ID"
				+ " AND (f.IsEncrypted='Y' OR f.ObscureType IS NOT NULL))"
			+ "ORDER BY SeqNo";
		MRole role = MRole.getDefault(getCtx(), false);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, get_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MPrintFormatItem pfi = new MPrintFormatItem(p_ctx, rs, get_TrxName());
				if (role.isColumnAccess(getAD_Table_ID(), pfi.getAD_Column_ID(), true, get_TrxName()))
					list.add (pfi);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		MPrintFormatItem[] retValue = new MPrintFormatItem[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getItems

	/**
	 * 	Get All Items
	 * 	@return items
	 */
	public MPrintFormatItem[] getAllItems() {
		return getAllItems("SeqNo");
	}
	
	/**
	 * 	Get All Items
	 *  @param orderBy
	 * 	@return items
	 */
	public MPrintFormatItem[] getAllItems(String orderBy)
	{
		String whereClause = "AD_PrintFormatItem.AD_PrintFormat_ID=? "
			//	Display restrictions - Passwords, etc.
			+ " AND NOT EXISTS (SELECT * FROM AD_Field f "
				+ "WHERE AD_PrintFormatItem.AD_Column_ID=f.AD_Column_ID"
				+ " AND (f.IsEncrypted='Y' OR f.ObscureType IS NOT NULL))";
		List<MPrintFormatItem> list = new Query(getCtx(), MPrintFormatItem.Table_Name, whereClause, get_TrxName())
			.setParameters(get_ID())
			.setOnlyActiveRecords(true)
			.setOrderBy(orderBy)
			.list();

		MRole role = MRole.getDefault(getCtx(), false);
		list.removeIf(pfi -> !role.isColumnAccess(getAD_Table_ID(), pfi.getAD_Column_ID(), true));

		MPrintFormatItem[] retValue = new MPrintFormatItem[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getAllItems

	/**
	 * 	Get Items Not in A Print Format
	 * 	@return items
	 */
	private MPrintFormatItem[] getItemsNotIn(int AD_PrintFormat_ID)
	{
		ArrayList<MPrintFormatItem> list = new ArrayList<MPrintFormatItem>();
		String sql = "SELECT * FROM AD_PrintFormatItem pfi "
			+ "WHERE pfi.AD_PrintFormat_ID=? AND pfi.IsActive='Y'"
			//	Display restrictions - Passwords, etc.
			+ " AND NOT EXISTS (SELECT * FROM AD_Field f "
				+ "WHERE pfi.AD_Column_ID=f.AD_Column_ID"
				+ " AND (f.IsEncrypted='Y' OR f.ObscureType IS NOT NULL))" 
				+ " AND AD_Column_ID NOT IN (SELECT pfi.AD_Column_ID FROM AD_PrintFormatItem pfi WHERE pfi.AD_PrintFormat_ID=? AND pfi.AD_Column_ID IS NOT NULL) "
			+ "ORDER BY SeqNo";
		MRole role = MRole.getDefault(getCtx(), false);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, get_ID());
			pstmt.setInt(2, AD_PrintFormat_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MPrintFormatItem pfi = new MPrintFormatItem(p_ctx, rs, get_TrxName());
				if (role.isColumnAccess(getAD_Table_ID(), pfi.getAD_Column_ID(), true))
					list.add (pfi);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		MPrintFormatItem[] retValue = new MPrintFormatItem[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getItemsNotIn

	/**
	 * 	Get Item Count
	 * 	@return number of items or -1 if items not defined
	 */
	public int getItemCount()
	{
		if (m_items == null)
			return -1;
		return m_items.length;
	}	//	getItemCount

	/**
	 * 	Get Print Format Item
	 * 	@param index index
	 * 	@return Print Format Item
	 */
	public MPrintFormatItem getItem (int index)
	{
		if (index < 0 || index >= m_items.length)
			throw new ArrayIndexOutOfBoundsException("Index=" + index + " - Length=" + m_items.length);
		return m_items[index];
	}	//	getItem

	/**
	 * 	Set the translation of the Format Items to the original
	 */
	public void setTranslation()
	{
		StringBuilder sb = new StringBuilder ("UPDATE AD_PrintFormatItem_Trl t"
			+ " SET (PrintName, PrintNameSuffix)="
			+ " (SELECT PrintName, PrintNameSuffix FROM AD_PrintFormatItem i WHERE i.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID) "
			+ "WHERE AD_PrintFormatItem_ID IN"
			+ " (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem WHERE AD_PrintFormat_ID=").append(get_ID()).append(")");
		int no = DB.executeUpdate(sb.toString(), get_TrxName());
		if (log.isLoggable(Level.FINE)) log.fine("setTranslation #" + no);
	}	//	setTranslation


	/**************************************************************************
	 * 	Set Standard Header
	 *	@param standardHeaderFooter true if std header
	 */
	public void setStandardHeaderFooter (boolean standardHeaderFooter)
	{
		super.setIsStandardHeaderFooter(standardHeaderFooter);
		if (standardHeaderFooter)
		{
			setFooterMargin(0);
			setHeaderMargin(0);
		}
	}	//	setSatndardHeaderFooter

	/**
	 * 	Set Table based.
	 * 	Reset Form
	 * 	@param tableBased true if table based
	 */
	public void setIsTableBased (boolean tableBased)
	{
		super.setIsTableBased (tableBased);
		if (tableBased)
			super.setIsForm(false);
	}	//	setIsTableBased


	/**************************************************************************
	 * 	Set Translation View Language.
	 * 	@param language language (checked for base language)
	 */
	public void setTranslationLanguage (Language language)
	{
		if (language == null || language.isBaseLanguage())
		{
			if (log.isLoggable(Level.INFO)) log.info("Ignored - " + language);
			m_translationViewLanguage = null;
		}
		else
		{
			if (log.isLoggable(Level.INFO)) log.info("Language=" + language.getAD_Language());
			m_translationViewLanguage = language.getAD_Language();
			m_language = language;
		}
	}	//	setTranslationLanguage

	/**
	 *  Get Translation View use
	 *	@return true if a translation view is used
	 */
	public boolean isTranslationView()
	{
		return m_translationViewLanguage != null;
	}	//	isTranslationView

	/**
	 *	Update the Query to access the Translation View.
	 *  Can be called multiple times, adds only if not set already
	 *  @param query query to be updated
	 */
	public void setTranslationViewQuery (MQuery query)
	{
		//	Set Table Name and add add restriction, if a view and language set
		if (m_translationViewLanguage != null && query != null && query.getTableName().toUpperCase().endsWith("_V"))
		{
			query.setTableName(query.getTableName() + "t");
			query.addRestriction("AD_Language", MQuery.EQUAL, m_translationViewLanguage);
		}
	}	//	setTranslationViewQuery


	/**************************************************************************
	 * 	Get Optional TableFormat
	 * 	@param AD_PrintTableFormat_ID table format
	 */
	public void setAD_PrintTableFormat_ID (int AD_PrintTableFormat_ID)
	{
		super.setAD_PrintTableFormat_ID(AD_PrintTableFormat_ID);
		m_tFormat = MPrintTableFormat.get (getCtx(), AD_PrintTableFormat_ID, getAD_PrintFont_ID());
		if (is_Immutable())
			m_tFormat.markImmutable();
	}	//	getAD_PrintTableFormat_ID

	/**
	 * 	Get Table Format
	 * 	@return Table Format
	 */
	public MPrintTableFormat getTableFormat()
	{
		if (m_tFormat == null)
		{
			m_tFormat = MPrintTableFormat.get(getCtx(), getAD_PrintTableFormat_ID(), getAD_PrintFont_ID());
			if (is_Immutable())
				m_tFormat.markImmutable();
		}
		return m_tFormat;
	}	//	getTableFormat

	/**
	 * 	Sting Representation
	 * 	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MPrintFormat[ID=").append(get_ID())
			.append(",Name=").append(getName())
			.append(",Language=").append(getLanguage())
			.append(",Items=").append(getItemCount())
			.append("]");
		return sb.toString();
	}	//	toString


	/**************************************************************************
	 *  Load Special data (images, ..).
	 *  To be extended by sub-classes
	 *  @param rs result set
	 *  @param index zero based index
	 *  @return value value
	 *  @throws SQLException
	 */
	protected Object loadSpecial (ResultSet rs, int index) throws SQLException
	{
		return null;
	}   //  loadSpecial

	/**
	 *  Save Special Data.
	 *  To be extended by sub-classes
	 *  @param value value
	 *  @param index index
	 *  @return SQL code for INSERT VALUES clause
	 */
	protected String saveNewSpecial (Object value, int index)
	{
		if (value == null)
			return "NULL";
		return value.toString();
	}   //  saveNewSpecial
	
	static public MPrintFormat createFromGridLayout(Properties ctx, GridTab gridTab, boolean allColumns)
	{
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		MPrintFormat pf = new MPrintFormat(ctx, 0, null);
		pf.setAD_Table_ID(gridTab.getAD_Table_ID());

		//	Get Info
		String sql = "SELECT TableName,"		//	1
			+ " COALESCE (cpc.AD_PrintColor_ID, pc.AD_PrintColor_ID) AS AD_PrintColor_ID,"	//	2
			+ " COALESCE (cpf.AD_PrintFont_ID, pf.AD_PrintFont_ID) AS AD_PrintFont_ID,"
			+ " COALESCE (cpp.AD_PrintPaper_ID, pp.AD_PrintPaper_ID) AS AD_PrintPaper_ID "
			+ "FROM AD_Table t, AD_Client c"
			+ " LEFT OUTER JOIN AD_PrintColor cpc ON (cpc.AD_Client_ID=c.AD_Client_ID AND cpc.IsDefault='Y')"
			+ " LEFT OUTER JOIN AD_PrintFont cpf ON (cpf.AD_Client_ID=c.AD_Client_ID AND cpf.IsDefault='Y')"
			+ " LEFT OUTER JOIN AD_PrintPaper cpp ON (cpp.AD_Client_ID=c.AD_Client_ID AND cpp.IsDefault='Y'),"
			+ " AD_PrintColor pc, AD_PrintFont pf, AD_PrintPaper pp "
			+ "WHERE t.AD_Table_ID=? AND c.AD_Client_ID=?"		//	#1/2
			+ " AND pc.IsDefault='Y' AND pf.IsDefault='Y' AND pp.IsDefault='Y'";
		boolean error = true;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, gridTab.getAD_Table_ID());
			pstmt.setInt(2, AD_Client_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				//	Name
				String TableName = rs.getString(1);
				String ColumnName = TableName + "_ID";
				String basename = ColumnName;
				if (!ColumnName.equals("T_Report_ID"))
				{
					basename = Msg.translate (ctx, ColumnName);
					if (ColumnName.equals (basename)) //	not found
						basename = Msg.translate (ctx, TableName);
				}
				setUniqueName(AD_Client_ID, pf, basename);
				//
				pf.setAD_PrintColor_ID(rs.getInt(2));
				pf.setAD_PrintFont_ID(rs.getInt(3));
				pf.setAD_PrintPaper_ID(rs.getInt(4));
				//
				error = false;
			}
			else
				s_log.log(Level.SEVERE, "No info found " + gridTab.getAD_Table_ID());
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (error)
			return null;

		//	Save & complete
		pf.saveEx();
		
		GridField[] gridFields = null;
		
		GridTable tableModel = gridTab.getTableModel();
		GridField[] tmpFields = tableModel.getFields();
		MTabCustomization tabCustomization = MTabCustomization.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), gridTab.getAD_Tab_ID(), null);
		if (!allColumns && tabCustomization != null && tabCustomization.getAD_Tab_Customization_ID() > 0 
			&& tabCustomization.getCustom() != null && tabCustomization.getCustom().trim().length() > 0) 
		{
			String custom = tabCustomization.getCustom().trim();
			String[] customComponent = custom.split(";");
			String[] fieldIds = customComponent[0].split("[,]");
			List<GridField> fieldList = new ArrayList<GridField>();
			for(String fieldIdStr : fieldIds) 
			{
				fieldIdStr = fieldIdStr.trim();
				if (fieldIdStr.length() == 0) continue;
				int AD_Field_ID = Integer.parseInt(fieldIdStr);
				for(GridField gridField : tmpFields) 
				{
					if (gridField.getAD_Field_ID() == AD_Field_ID) 
					{
						if(gridField.isDisplayedGrid())
							fieldList.add(gridField);
						
						break;
					}
				}
			}
			gridFields = fieldList.toArray(new GridField[0]);
		} 
		else 
		{
			ArrayList<GridField> gridFieldList = new ArrayList<GridField>();
			
			for(GridField field:tmpFields)
			{
				if(field.isDisplayedGrid())
					gridFieldList.add(field);
			}
			
			Collections.sort(gridFieldList, new Comparator<GridField>() {
				@Override
				public int compare(GridField o1, GridField o2) {
					return o1.getSeqNoGrid()-o2.getSeqNoGrid();
				}
			});
			
			gridFields = new GridField[gridFieldList.size()];
			gridFieldList.toArray(gridFields);
		}
		
		ArrayList<MPrintFormatItem> printFormatItemList = new ArrayList<MPrintFormatItem>();
		int seqNo = 1;
		for (GridField gridField : gridFields)
		{
			if (gridField.isVirtualUIColumn())
				continue;
			MPrintFormatItem pfi = MPrintFormatItem.createFromGridField(pf, gridField, seqNo++);
			if (pfi != null)
			{
				printFormatItemList.add (pfi);
				if (s_log.isLoggable(Level.FINEST)) s_log.finest("Tab: " + pfi);
			}
		}
		
		MPrintFormatItem[] printFormatItems = new MPrintFormatItem[printFormatItemList.size()];
		printFormatItemList.toArray(printFormatItems);
		pf.setItems(printFormatItems);
		
		return pf;
	}

	private static boolean exists(int clientID, String name) {
		final String sql = "SELECT COUNT(*) FROM AD_PrintFormat WHERE AD_Client_ID=? AND Name=?";
		int cnt = DB.getSQLValue(null, sql, clientID, name);
		return cnt > 0;
	}

	/**************************************************************************
	 * 	Create MPrintFormat for Table
	 *  @param ctx context
	 * 	@param AD_Table_ID table
	 * 	@return print format
	 */
	static public MPrintFormat createFromTable (Properties ctx, int AD_Table_ID)
	{
		return createFromTable(ctx, AD_Table_ID, 0);
	}	//	createFromTable

	/**
	 * 
	 * 	Create MPrintFormat for Table
	 *  @param ctx context
	 * 	@param AD_Table_ID table
	 *  @param AD_PrintFormat_ID 0 or existing PrintFormat
	 * 	@return print format
	 */
	static public MPrintFormat createFromTable (Properties ctx,
			int AD_Table_ID, int AD_PrintFormat_ID) {
		return createFromTable(ctx, AD_Table_ID, AD_PrintFormat_ID, null);
	}
	
	/**
	 * 	Create MPrintFormat for Table
	 *  @param ctx context
	 * 	@param AD_Table_ID table
	 *  @param AD_PrintFormat_ID 0 or existing PrintFormat
	 *  @param trxName the transaction
	 * 	@return print format
	 */
	static public MPrintFormat createFromTable (Properties ctx,
		int AD_Table_ID, int AD_PrintFormat_ID, String trxName)
	{
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		if (s_log.isLoggable(Level.INFO)) s_log.info ("AD_Table_ID=" + AD_Table_ID + " - AD_Client_ID=" + AD_Client_ID);

		MPrintFormat pf = new MPrintFormat(ctx, AD_PrintFormat_ID, trxName);
		pf.setAD_Table_ID (AD_Table_ID);

		//	Get Info
		String sql = "SELECT TableName,"		//	1
			+ " COALESCE (cpc.AD_PrintColor_ID, pc.AD_PrintColor_ID) AS AD_PrintColor_ID,"	//	2
			+ " COALESCE (cpf.AD_PrintFont_ID, pf.AD_PrintFont_ID) AS AD_PrintFont_ID,"
			+ " COALESCE (cpp.AD_PrintPaper_ID, pp.AD_PrintPaper_ID) AS AD_PrintPaper_ID "
			+ "FROM AD_Table t, AD_Client c"
			+ " LEFT OUTER JOIN AD_PrintColor cpc ON (cpc.AD_Client_ID=c.AD_Client_ID AND cpc.IsDefault='Y')"
			+ " LEFT OUTER JOIN AD_PrintFont cpf ON (cpf.AD_Client_ID=c.AD_Client_ID AND cpf.IsDefault='Y')"
			+ " LEFT OUTER JOIN AD_PrintPaper cpp ON (cpp.AD_Client_ID=c.AD_Client_ID AND cpp.IsDefault='Y'),"
			+ " AD_PrintColor pc, AD_PrintFont pf, AD_PrintPaper pp "
			+ "WHERE t.AD_Table_ID=? AND c.AD_Client_ID=?"		//	#1/2
			+ " AND pc.IsDefault='Y' AND pf.IsDefault='Y' AND pp.IsDefault='Y'";
		boolean error = true;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			pstmt.setInt(1, AD_Table_ID);
			pstmt.setInt(2, AD_Client_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				//	Name
				String TableName = rs.getString(1);
				String ColumnName = TableName + "_ID";
				String basename = ColumnName;
				if (!ColumnName.equals("T_Report_ID"))
				{
					basename = Msg.translate (ctx, ColumnName);
					if (ColumnName.equals (basename)) //	not found
						basename = Msg.translate (ctx, TableName);
				}
				setUniqueName(AD_Client_ID, pf, basename);
				//
				pf.setAD_PrintColor_ID(rs.getInt(2));
				pf.setAD_PrintFont_ID(rs.getInt(3));
				pf.setAD_PrintPaper_ID(rs.getInt(4));
				//
				error = false;
			}
			else
				s_log.log(Level.SEVERE, "No info found " + AD_Table_ID);
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (error)
			return null;

		//	Save & complete
		pf.saveEx();
		pf.setItems (createItems(ctx, pf));
		//
		return pf;
	}	//	createFromTable

	/**
	 * 	Create MPrintFormat for ReportView
	 *  @param ctx context
	 * 	@param AD_ReportView_ID ReportView
	 *  @param ReportName - optional Report Name
	 * 	@return print format
	 */
	static public MPrintFormat createFromReportView (Properties ctx, int AD_ReportView_ID, String ReportName)
	{
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		if (s_log.isLoggable(Level.INFO)) s_log.info ("AD_ReportView_ID=" + AD_ReportView_ID + " - AD_Client_ID=" + AD_Client_ID + " - " + ReportName);

		MPrintFormat pf = new MPrintFormat(ctx, 0, null);
		pf.setAD_ReportView_ID (AD_ReportView_ID);

		//	Get Info
		String sql = "SELECT t.TableName,"
			+ " COALESCE (cpc.AD_PrintColor_ID, pc.AD_PrintColor_ID) AS AD_PrintColor_ID,"
			+ " COALESCE (cpf.AD_PrintFont_ID, pf.AD_PrintFont_ID) AS AD_PrintFont_ID,"
			+ " COALESCE (cpp.AD_PrintPaper_ID, pp.AD_PrintPaper_ID) AS AD_PrintPaper_ID,"
			+ " t.AD_Table_ID "
			+ "FROM AD_ReportView rv"
			+ " INNER JOIN AD_Table t ON (rv.AD_Table_ID=t.AD_Table_ID),"
			+ " AD_Client c"
			+ " LEFT OUTER JOIN AD_PrintColor cpc ON (cpc.AD_Client_ID=c.AD_Client_ID AND cpc.IsDefault='Y')"
			+ " LEFT OUTER JOIN AD_PrintFont cpf ON (cpf.AD_Client_ID=c.AD_Client_ID AND cpf.IsDefault='Y')"
			+ " LEFT OUTER JOIN AD_PrintPaper cpp ON (cpp.AD_Client_ID=c.AD_Client_ID AND cpp.IsDefault='Y'),"
			+ " AD_PrintColor pc, AD_PrintFont pf, AD_PrintPaper pp "
			+ "WHERE rv.AD_ReportView_ID=? AND c.AD_Client_ID=?"
			+ " AND pc.IsDefault='Y' AND pf.IsDefault='Y' AND pp.IsDefault='Y'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean error = true;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_ReportView_ID);
			pstmt.setInt(2, AD_Client_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				//	Name
				String basename = ReportName;
				if (basename == null || basename.length() == 0)
					basename = rs.getString(1);		//	TableName
				setUniqueName(AD_Client_ID, pf, basename);
				//
				pf.setAD_PrintColor_ID(rs.getInt(2));
				pf.setAD_PrintFont_ID(rs.getInt(3));
				pf.setAD_PrintPaper_ID(rs.getInt(4));
				//
				pf.setAD_Table_ID (rs.getInt(5));
				error = false;
			}
			else
				s_log.log(Level.SEVERE, "Not found: AD_ReportView_ID=" + AD_ReportView_ID);
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (error)
			return null;

		//	Save & complete
		pf.saveEx();
		pf.setItems (createItems(ctx, pf));
		//
		return pf;
	}	//	createFromReportView

	public static void setUniqueName(int AD_Client_ID, MPrintFormat pf, String basename) {
		String name = basename;
		pf.setName(name);
		boolean dateAsSuffix = true;
		boolean sleep = false;
		while (exists(AD_Client_ID, pf.getName())) {
			if (sleep)
				Env.sleep(1); // wait 1 sec to get next second in datetime
			else
				sleep = true;
			if (dateAsSuffix) {
				name = basename + "_" + getDateTime();
			} else {
				name = getDateTime() + "_" + basename;
			}
			pf.setName(name);
			if (sleep && !name.equals(pf.getName())) {
				// there has been already one iteration and the name is being truncated
				// change method to put date as prefix
				dateAsSuffix = false;
			}
		}
	}


	/**
	 * 	Create Items.
	 *  Using the display order of Fields in some Tab
	 *  @param ctx context
	 *  @param format print format
	 * 	@return items
	 */
	static private MPrintFormatItem[] createItems (Properties ctx, MPrintFormat format)
	{
		s_log.fine ("From window Tab ...");
		ArrayList<MPrintFormatItem> list = new ArrayList<MPrintFormatItem>();
		//	Get Column List from Tab
		String sql = "SELECT AD_Column_ID " //, Name, IsDisplayed, SeqNo
			+ "FROM AD_Field "
			+ "WHERE IsActive='Y' AND AD_Tab_ID=(SELECT MIN(AD_Tab_ID) FROM AD_Tab WHERE AD_Table_ID=? AND IsActive='Y')"
			+ " AND IsEncrypted='N' AND ObscureType IS NULL "
			+ " AND AD_Column_ID NOT IN (SELECT pfi.AD_Column_ID FROM AD_PrintFormatItem pfi WHERE pfi.AD_PrintFormat_ID=? AND pfi.AD_Column_ID IS NOT NULL) "
			+ " AND (AD_Column_ID IN (SELECT AD_Column_ID FROM AD_ReportView_Column WHERE AD_ReportView_ID=? AND IsActive='Y')"
			+ " OR ((SELECT COUNT(*) FROM AD_ReportView_Column WHERE AD_ReportView_ID=? AND IsActive='Y') = 0))"
			+ "ORDER BY COALESCE(IsDisplayed,'N') DESC, SortNo, SeqNo, Name";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, format.get_TrxName());
			pstmt.setInt(1, format.getAD_Table_ID());
			pstmt.setInt(2, format.getAD_PrintFormat_ID());
			pstmt.setInt(3, format.getAD_ReportView_ID());
			pstmt.setInt(4, format.getAD_ReportView_ID());
			rs = pstmt.executeQuery();
			int seqNo = 1;
			while (rs.next())
			{
				int columnID = rs.getInt(1);
				MColumn column = MColumn.get(ctx, columnID);
				if (column.isVirtualUIColumn())
					continue;
				MPrintFormatItem pfi = MPrintFormatItem.createFromColumn (format, columnID, seqNo++);
				if (pfi != null)
				{
					list.add (pfi);
					if (s_log.isLoggable(Level.FINEST)) s_log.finest("Tab: " + pfi);
				}
			}
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, "(tab) - " + sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//	No Tab found for Table
		if (list.size() == 0)
		{
			s_log.fine("From Table ...");
			sql = "SELECT AD_Column_ID "
				+ "FROM AD_Column "
				+ "WHERE IsActive='Y' AND AD_Table_ID=? "
				+ " AND AD_Column_ID NOT IN (SELECT pfi.AD_Column_ID FROM AD_PrintFormatItem pfi WHERE pfi.AD_PrintFormat_ID=? AND pfi.AD_Column_ID IS NOT NULL) "
				+ " AND (AD_Column_ID IN (SELECT AD_Column_ID FROM AD_ReportView_Column WHERE AD_ReportView_ID=? AND IsActive='Y')"
				+ " OR ((SELECT COUNT(*) FROM AD_ReportView_Column WHERE AD_ReportView_ID=?) = 0 AND IsActive='Y'))"
				+ "ORDER BY IsIdentifier DESC, SeqNo, Name";
			try
			{
				pstmt = DB.prepareStatement(sql, format.get_TrxName());
				pstmt.setInt(1, format.getAD_Table_ID());
				pstmt.setInt(2, format.getAD_PrintFormat_ID());
				pstmt.setInt(3, format.getAD_ReportView_ID());
				pstmt.setInt(4, format.getAD_ReportView_ID());
				rs = pstmt.executeQuery();
				int seqNo = 1;
				while (rs.next())
				{
					int columnID = rs.getInt(1);
					MColumn column = MColumn.get(ctx, columnID);
					if (column.isVirtualUIColumn())
						continue;
					MPrintFormatItem pfi = MPrintFormatItem.createFromColumn (format, columnID, seqNo++);
					if (pfi != null)
					{
						list.add (pfi);
						if (s_log.isLoggable(Level.FINEST)) s_log.finest("Table: " + pfi);
					}
				}
			}
			catch (SQLException e)
			{
				s_log.log(Level.SEVERE, "(table) - " + sql, e);
			}
			finally {
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
		}

		//
		MPrintFormatItem[] retValue = new MPrintFormatItem[list.size()];
		list.toArray(retValue);
		if (s_log.isLoggable(Level.INFO)) s_log.info(format + " - #" + retValue.length);
		return retValue;
	}	//	createItems

	/**
	 * 	Copy Items
	 *  @param fromFormat from print format
	 *  @param toFormat to print format (client, id)
	 * 	@return items
	 */
	static private MPrintFormatItem[] copyItems (MPrintFormat fromFormat, MPrintFormat toFormat)
	{
		if (s_log.isLoggable(Level.INFO)) s_log.info("From=" + fromFormat);
		ArrayList<MPrintFormatItem> list = new ArrayList<MPrintFormatItem>();

		MPrintFormatItem[] items = fromFormat.getItemsNotIn(toFormat.get_ID());
		for (int i = 0; i < items.length; i++)
		{
			MPrintFormatItem pfi = items[i].copyToClient (toFormat.getAD_Client_ID(), toFormat.get_ID(), toFormat.get_TrxName());
			if (pfi != null)
				list.add (pfi);
		}
		//
		MPrintFormatItem[] retValue = new MPrintFormatItem[list.size()];
		list.toArray(retValue);
		copyTranslationItems (items, retValue, toFormat.get_TrxName());	//	JTP fix
		return retValue;
	}	//	copyItems

	/**
     *	Copy translation records (from - to)
     *	@param fromItems from items
     *	@param toItems to items
     *  @param trxName
     */
    static private void copyTranslationItems (MPrintFormatItem[] fromItems,
    	MPrintFormatItem[] toItems, String trxName)
    {
    	if (fromItems == null || toItems == null)
            return;		//	should not happen

    	int counter = 0;
        for (int i = 0; i < fromItems.length; i++)
        {
            int fromID = fromItems[i].getAD_PrintFormatItem_ID();
            int toID = toItems[i].getAD_PrintFormatItem_ID();

            StringBuilder sql = new StringBuilder("UPDATE AD_PrintFormatItem_Trl new ")
            	//	Set
            	.append("SET (PrintName, PrintNameSuffix, IsTranslated) = ")
            	.append("(")
            	.append("SELECT PrintName, PrintNameSuffix, IsTranslated ")
            	.append("FROM AD_PrintFormatItem_Trl old ")
            	.append("WHERE old.AD_Language=new.AD_Language")
            	.append(" AND AD_PrintFormatItem_ID =").append(fromID)
            	.append(") ")
            	//	WHERE
            	.append("WHERE  AD_PrintFormatItem_ID=").append(toID)
            	.append(" AND EXISTS (SELECT AD_PrintFormatItem_ID ")
            		.append(" FROM AD_PrintFormatItem_trl old")
            		.append(" WHERE old.AD_Language=new.AD_Language")
            		.append(" AND AD_PrintFormatItem_ID =").append(fromID)
            		.append(")");
            int no = DB.executeUpdate(sql.toString(), trxName);
            if (no == 0)	//	if first has no translation, the rest does neither
            	break;
            counter += no;
        }	//	for
        if (s_log.isLoggable(Level.FINEST)) s_log.finest("#" + counter);
    }	//	copyTranslationItems


	/**************************************************************************
	 * 	Copy existing Definition To Client
	 * 	@param ctx context
	 * 	@param from_AD_PrintFormat_ID format
	 * 	@param to_AD_PrintFormat_ID format
	 * 	@return print format
	 */
	public static MPrintFormat copy (Properties ctx,
		int from_AD_PrintFormat_ID, int to_AD_PrintFormat_ID)
	{
		return copy (ctx, from_AD_PrintFormat_ID, to_AD_PrintFormat_ID, -1);
	}	//	copy

	/**
	 * 	Copy existing Definition To Client
	 * 	@param ctx context
	 * 	@param AD_PrintFormat_ID format
	 * 	@param to_Client_ID to client
	 * 	@return print format
	 */
	public static MPrintFormat copyToClient (Properties ctx,
		int AD_PrintFormat_ID, int to_Client_ID)
	{
		return copyToClient(ctx, AD_PrintFormat_ID, to_Client_ID, (String)null);
	}
	
	/**
	 * 	Copy existing Definition To Client
	 * 	@param ctx context
	 * 	@param AD_PrintFormat_ID format
	 * 	@param to_Client_ID to client
	 *  @param trxName
	 * 	@return print format
	 */
	public static MPrintFormat copyToClient (Properties ctx,
		int AD_PrintFormat_ID, int to_Client_ID, String trxName)
	{
		return copy (ctx, AD_PrintFormat_ID, 0, to_Client_ID, trxName);
	}	//	copy

	/**
	 * 	Copy existing Definition To Client
	 * 	@param ctx context
	 * 	@param from_AD_PrintFormat_ID format
	 *  @param to_AD_PrintFormat_ID to format or 0 for new
	 * 	@param to_Client_ID to client (ignored, if to_AD_PrintFormat_ID <> 0)
	 * 	@return print format
	 */
	private static MPrintFormat copy (Properties ctx, int from_AD_PrintFormat_ID,
		int to_AD_PrintFormat_ID, int to_Client_ID)
	{
		return copy(ctx, from_AD_PrintFormat_ID, to_AD_PrintFormat_ID, to_Client_ID, (String)null);
	}
	
	/**
	 * 	Copy existing Definition To Client
	 * 	@param ctx context
	 * 	@param from_AD_PrintFormat_ID format
	 *  @param to_AD_PrintFormat_ID to format or 0 for new
	 * 	@param to_Client_ID to client (ignored, if to_AD_PrintFormat_ID <> 0)
	 * 	@return print format
	 */
	private static MPrintFormat copy (Properties ctx, int from_AD_PrintFormat_ID,
		int to_AD_PrintFormat_ID, int to_Client_ID, String trxName)
	{
		if (s_log.isLoggable(Level.INFO)) s_log.info ("From AD_PrintFormat_ID=" + from_AD_PrintFormat_ID
			+ ", To AD_PrintFormat_ID=" + to_AD_PrintFormat_ID
			+ ", To Client_ID=" + to_Client_ID);
		if (from_AD_PrintFormat_ID == 0)
			throw new IllegalArgumentException ("From_AD_PrintFormat_ID is 0");
		//
		MPrintFormat from = new MPrintFormat(ctx, from_AD_PrintFormat_ID, trxName);
		MPrintFormat to = new MPrintFormat (ctx, to_AD_PrintFormat_ID, trxName);		//	could be 0
		MPrintFormat.copyValues (from, to);
		//	New
		if (to_AD_PrintFormat_ID == 0)
		{
			if (to_Client_ID < 0)
				to_Client_ID = Env.getAD_Client_ID(ctx);
			to.setClientOrg (to_Client_ID, 0);
		}
		//	Set Name - Remove TEMPLATE - add copy
		to.setName(Util.replace(to.getName(), "TEMPLATE", String.valueOf(to_Client_ID)));
		to.setName(to.getName()
			+ " - " + Util.cleanAmp(Msg.getMsg(ctx, "Copy")));
		setUniqueName(to.getAD_Client_ID(), to, to.getName());
		//
		to.saveEx();

		//	Copy Items
		to.setItems(copyItems(from,to));
		return to;
	}	//	copyToClient

	/*************************************************************************/

	private static String getDateTime() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dt = sdf.format(cal.getTime());
		return dt;
	}

	/** Cached Formats						*/
	static private ImmutablePOCache<String,MPrintFormat> s_formats = new ImmutablePOCache<String,MPrintFormat>(Table_Name, 30) {
		private static final long serialVersionUID = 2428566381289874703L;

		@Override
		public int reset(int recordId) {
			if (recordId <= 0)
				return reset();
			
			if (cache.isEmpty() && nullList.isEmpty())
				return 0;
			
			StringBuilder key = new StringBuilder()
					.append(recordId).append("|");
			int removed = 0;
			if (!nullList.isEmpty()) {
				String[] nullKeys = nullList.toArray(new String[0]);
				for(String nullKey : nullKeys) {
					if (nullKey.startsWith(key.toString())) {
						if (nullList.remove(nullKey))
							removed++;
					}
				}
			}
			
			if (!cache.isEmpty()) {
				String[] cacheKeys = cache.keySet().toArray(new String[0]);
				for(String cacheKey : cacheKeys) {
					if (cacheKey.startsWith(key.toString())) {
						MPrintFormat v = cache.remove(cacheKey);
						if (v != null)
							removed++;
					}
				}
			}
			return removed;
		}
		
	};

	/**
	 * 	Get Format from cache (immutable)
	 * 	@param AD_PrintFormat_ID id
	 * 	@return Format
	 */
	static public MPrintFormat get (int AD_PrintFormat_ID)
	{
		return get(Env.getCtx(), AD_PrintFormat_ID, false);
	}
	
	/**
	 * 	Get Format from cache (immutable)
	 * 	@param ctx context
	 * 	@param AD_PrintFormat_ID id
	 *  @param readFromDisk refresh from disk
	 * 	@return Format
	 */
	static public MPrintFormat get (Properties ctx, int AD_PrintFormat_ID, boolean readFromDisk)
	{
		StringBuilder key = new StringBuilder()
				.append(AD_PrintFormat_ID).append("|")
				.append(MRole.getDefault().getAD_Role_ID());
		MPrintFormat pf = null;
		if (!readFromDisk)
			pf = s_formats.get(ctx, key.toString(), e -> new MPrintFormat(ctx, e));
		if (pf == null)
		{
			pf = new MPrintFormat (ctx, AD_PrintFormat_ID, (String)null);
			if (pf.get_ID() == AD_PrintFormat_ID)
			{
				s_formats.put(key.toString(), pf, e -> new MPrintFormat(Env.getCtx(), e));
				return pf;
			}
			return null;
		}

		return pf;
	}	//	get

	/**
	 * 	Get (default) Printformat for Report View or Table
	 *	@param ctx context
	 *	@param AD_ReportView_ID id or 0
	 *	@param AD_Table_ID id or 0
	 *	@return first print format found or null
	 */
	static public MPrintFormat get (Properties ctx, int AD_ReportView_ID, int AD_Table_ID)
	{
		MPrintFormat retValue = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM AD_PrintFormat WHERE ";
		if (AD_ReportView_ID > 0)
			sql += "AD_ReportView_ID=?";
		else
			sql += "AD_Table_ID=?";
		sql += " ORDER BY IsDefault DESC";
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_ReportView_ID > 0 ? AD_ReportView_ID : AD_Table_ID);
			rs = pstmt.executeQuery ();
			if (rs.next ())
				retValue = new MPrintFormat (ctx, rs, null);
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return retValue;
	}	//	get

	/**
	 * 	Delete Format from Cache
	 * 	@param AD_PrintFormat_ID id
	 */
	static public void deleteFromCache (int AD_PrintFormat_ID)
	{
		StringBuilder key = new StringBuilder()
				.append(AD_PrintFormat_ID).append("|")
				.append(MRole.getDefault().getAD_Role_ID());
		s_formats.put(key.toString(), null);
	}	//	deleteFromCache

    //begin vpj-cd e-evolution
	/**
	 * Get ID of Print Format use Name
	 * @param formatName
	 * @param AD_Table_ID
	 * @param AD_Client_ID
	 * @return AD_PrintFormat_ID
	 */
	public static int getPrintFormat_ID(String formatName, int AD_Table_ID, int AD_Client_ID) {
		final String sql = "SELECT AD_PrintFormat_ID FROM AD_PrintFormat"
								+ " WHERE Name = ? AND AD_Table_ID = ? AND AD_Client_ID IN (0, ?)"
								+ " ORDER BY AD_Client_ID DESC";
		return DB.getSQLValue(null, sql, formatName, AD_Table_ID, AD_Client_ID);
	}
	//end vpj-cd e-evolution

	/**
	 * @param AD_Table_ID
	 * @param AD_Window_ID
	 * @param trxName
	 * @param makeNewWhenEmpty
	 * @return
	 */
	public static List<KeyNamePair> getAccessiblePrintFormats (int AD_Table_ID, int AD_Window_ID, String trxName, boolean makeNewWhenEmpty)
	{
		String constantForRoleAccess = "SELECT * FROM AD_PrintFormat WHERE ";
		StringBuilder sqlWhereB = new StringBuilder(constantForRoleAccess)
			.append("AD_Table_ID=? AND IsTableBased='Y' ");
		if (AD_Window_ID > 0)
			sqlWhereB.append("AND (AD_Window_ID=? OR AD_Window_ID IS NULL)");		
		//
		String sqlWhere = MRole.getDefault().addAccessSQL (
				sqlWhereB.toString(), "AD_PrintFormat", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);

		// remove " WHERE " to use in Query
		sqlWhere = sqlWhere.substring(constantForRoleAccess.length());
		
		// add sql parameter
		List<Object> lsParameter = new ArrayList<Object>();

		lsParameter.add(Integer.valueOf(AD_Table_ID));
		if (AD_Window_ID > 0)
			lsParameter.add(Integer.valueOf(AD_Window_ID));		
		
		// init query
		Query query = new Query(Env.getCtx(), MPrintFormat.Table_Name, sqlWhere, trxName);
		
		query.setParameters(lsParameter);
		
		query.setOnlyActiveRecords(true);
		query.setOrderBy(" ORDER BY AD_Client_ID DESC, IsDefault DESC, Name ");
		
		// query print fomart just in this client  
		List<MPrintFormat> lsPrintFormat = query.setClient_ID().list();
		MPrintFormat newPrintFormat = null;
		
		if (lsPrintFormat.size() == 0){
			// get print format form other client
			newPrintFormat = query.setClient_ID(false).first();
		}

		// if must get from other client, make new print format is copy from other client
		if (newPrintFormat != null){
			newPrintFormat = MPrintFormat.copyToClient(Env.getCtx(), newPrintFormat.getAD_PrintFormat_ID(), Env.getAD_Client_ID(Env.getCtx()));
			lsPrintFormat.add(newPrintFormat);
		}
		
		// none client have print format, make new from default template
		if (lsPrintFormat.size() == 0){
			newPrintFormat =  MPrintFormat.createFromTable(Env.getCtx(), AD_Table_ID);
			lsPrintFormat.add(newPrintFormat);
		}
		
		// convert lsPrintFormat to list KeyNamePair, apply translate for name column
		List<KeyNamePair>	m_list = new ArrayList<KeyNamePair>();
		
		for (MPrintFormat printFormat : lsPrintFormat){
			m_list.add(new KeyNamePair(printFormat.get_ID(), printFormat.get_Translation(MPrintFormat.COLUMNNAME_Name)));
		}				
		
		return m_list;
	}

	@Override
	@Deprecated
	public MPrintFormat clone() throws CloneNotSupportedException {
		MPrintFormat clone = (MPrintFormat) super.clone();
		clone.m_items = m_items == null ? null : new MPrintFormatItem[m_items.length];
		for(int i = 0; i < m_items.length; i++) {
			clone.m_items[i] = m_items[i];
		}
		clone.m_tFormat = m_tFormat;
		clone.m_language = Env.getLanguage(Env.getCtx());
		clone.m_translationViewLanguage = null;
		return clone;
	}

	public static int getZoomWindowID(int AD_PrintFormat_ID) {
		int pfAD_Window_ID = Env.getZoomWindowID(Table_ID, AD_PrintFormat_ID);
		return pfAD_Window_ID;
	}

	@Override
	public MPrintFormat markImmutable() 
	{
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_items != null && m_items.length > 0)
			Arrays.stream(m_items).forEach(e -> e.markImmutable());
		if (m_tFormat != null)
			m_tFormat.markImmutable();
		return this;
	}

}	//	MPrintFormat
