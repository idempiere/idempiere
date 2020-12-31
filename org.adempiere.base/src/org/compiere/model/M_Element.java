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
package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.db.Database;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;


/**
 *	System Element Model
 *	
 *  @author Jorg Janke
 *  @version $Id: M_Element.java,v 1.3 2006/07/30 00:58:37 jjanke Exp $
 *  FR: [ 2214883 ] Remove SQL code and Replace for Query - red1, teo_sarca
 */
public class M_Element extends X_AD_Element
{

    /**
     * 
     */
    private static final long serialVersionUID = -6644398794862560030L;

	/**
	 * 	Get case sensitive Column Name
	 *	@param columnName case insensitive column name
	 *	@return case sensitive column name
	 */
	public static String getColumnName (String columnName)
	{
		return getColumnName(columnName, null);
	}
	
	/**
	 * Get case sensitive Column Name
	 * @param columnName case insensitive column name
	 * @param trxName optional transaction name
	 * @return case sensitive column name
	 */
	public static String getColumnName (String columnName, String trxName)
	{
		if (columnName == null || columnName.length() == 0)
			return columnName;
	 	M_Element element = get(Env.getCtx(), columnName, trxName);
	 	if (element == null)
	 		return columnName;
		return element.getColumnName();

	}	//	getColumnName

	/**
	 * 	Get Element
	 * 	@param ctx context
	 *	@param columnName case insensitive column name
	 *	@return case sensitive column name
	 */
	public static M_Element get (Properties ctx, String columnName) 
	{
		return get(ctx, columnName, null);
	}
	
	/**
	 * 	Get Element
	 * 	@param ctx context
	 *	@param columnName case insensitive column name
	 *  @param trxName optional transaction name
	 *	@return case sensitive column name
	 */
	public static M_Element get (Properties ctx, String columnName, String trxName)
	{
		if (columnName == null || columnName.length() == 0)
			return null;
		//
		// TODO: caching if trxName == null
 	 	final String whereClause = "UPPER(ColumnName)=?";
	 	M_Element retValue = new Query(ctx, I_AD_Element.Table_Name, whereClause, trxName)
			.setParameters(columnName.toUpperCase())
			.firstOnly();
		return retValue;
	}	//	get

	/**
	 * 	Get Element
	 * 	@param ctx context
	 *	@param columnName case insensitive column name
 	 *	@param trxName trx
	 *	@return case sensitive column name
	 */
	public static M_Element getOfColumn (Properties ctx, int AD_Column_ID, String trxName)
	{
		if (AD_Column_ID ==0)
			return null;
		final String whereClause = "EXISTS (SELECT 1 FROM AD_Column c "
				+ "WHERE c.AD_Element_ID=AD_Element.AD_Element_ID AND c.AD_Column_ID=?)";
		M_Element retValue = new Query(ctx, Table_Name, whereClause, trxName)
		.setParameters(AD_Column_ID)
		.firstOnly();
		return retValue;
	}	//	get

	/**
	 * 	Get Element
	 * 	@param ctx context
	 *	@param columnName case insentitive column name
	 *	@return case sensitive column name
	 */
	public static M_Element getOfColumn (Properties ctx, int AD_Column_ID)
	{
		return getOfColumn(ctx, AD_Column_ID, null);
	}	//	get
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Element_ID element
	 *	@param trxName transaction
	 */
	public M_Element (Properties ctx, int AD_Element_ID, String trxName)
	{
		super (ctx, AD_Element_ID, trxName);
		if (AD_Element_ID == 0)
		{
		//	setColumnName (null);
		//	setEntityType (null);	// U
		//	setName (null);
		//	setPrintName (null);
		}	
	}	//	M_Element

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public M_Element (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	M_Element

	/**
	 * 	Minimum Constructor
	 *	@param ctx context
	 *	@param columnName column
	 *	@param EntityType entity type
	 *	@param trxName trx
	 */
	public M_Element (Properties ctx, String columnName, String EntityType,
		String trxName)
	{
		super(ctx, 0, trxName);
		setColumnName (columnName);
		setName (columnName);
		setPrintName (columnName);
		//
		setEntityType (EntityType);	// U
	}	//	M_Element

	
	/* (non-Javadoc)
	 * @see org.compiere.model.PO#beforeSave(boolean)
	 */
	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Column AD_Element.ColumnName should be unique - teo_sarca [ 1613107 ]
		if (newRecord || is_ValueChanged(COLUMNNAME_ColumnName)) {
			String columnName = getColumnName().trim();
			if (getColumnName().length() != columnName.length())
				setColumnName(columnName);
			
			StringBuilder sql = new StringBuilder("select count(*) from AD_Element where UPPER(ColumnName)=?");
			if (!newRecord)
				sql.append(" AND AD_Element_ID<>").append(get_ID()); 
			int no = DB.getSQLValue(null, sql.toString(), columnName.toUpperCase());
			if (no > 0) {
				log.saveError(DBException.SAVE_ERROR_NOT_UNIQUE_MSG, Msg.getElement(getCtx(), COLUMNNAME_ColumnName));
				return false;
			}
		}
		String error = Database.isValidIdentifier(getColumnName());
		if (!Util.isEmpty(error)) {
			log.saveError("Error", Msg.getMsg(getCtx(), error) + " [ColumnName]");
			return false;
		}
		
		return true;
	}

	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		//	Update Columns, Fields, Parameters, Print Info
		if (!newRecord)
		{
			StringBuilder sql = new StringBuilder();
			int no = 0;
			
			if (   is_ValueChanged(M_Element.COLUMNNAME_Name)
				|| is_ValueChanged(M_Element.COLUMNNAME_Description)
				|| is_ValueChanged(M_Element.COLUMNNAME_Help)
				|| is_ValueChanged(M_Element.COLUMNNAME_Placeholder)
				|| is_ValueChanged(M_Element.COLUMNNAME_ColumnName)
				) {
				//	Column
				sql = new StringBuilder("UPDATE AD_Column SET ColumnName=")
					.append(DB.TO_STRING(getColumnName()))
					.append(", Name=").append(DB.TO_STRING(getName()))
					.append(", Description=").append(DB.TO_STRING(getDescription()))
					.append(", Help=").append(DB.TO_STRING(getHelp()))
					.append(", Placeholder=").append(DB.TO_STRING(getPlaceholder()))
					.append(" WHERE AD_Element_ID=").append(get_ID());
				no = DB.executeUpdate(sql.toString(), get_TrxName());
				if (log.isLoggable(Level.FINE)) log.fine("afterSave - Columns updated #" + no);

				//	Parameter 
				sql = new StringBuilder("UPDATE AD_Process_Para SET ColumnName=")
					.append(DB.TO_STRING(getColumnName()))
					.append(", Name=").append(DB.TO_STRING(getName()))
					.append(", Description=").append(DB.TO_STRING(getDescription()))
					.append(", Help=").append(DB.TO_STRING(getHelp()))
					.append(", AD_Element_ID=").append(get_ID())
					.append(" WHERE UPPER(ColumnName)=")
					.append(DB.TO_STRING(getColumnName().toUpperCase()))
					.append(" AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL");
				no = DB.executeUpdate(sql.toString(), get_TrxName());
				
				sql = new StringBuilder("UPDATE AD_Process_Para SET ColumnName=")
					.append(DB.TO_STRING(getColumnName()))
					.append(", Name=").append(DB.TO_STRING(getName()))
					.append(", Description=").append(DB.TO_STRING(getDescription()))
					.append(", Help=").append(DB.TO_STRING(getHelp()))
					.append(", Placeholder=").append(DB.TO_STRING(getPlaceholder()))
					.append(" WHERE AD_Element_ID=").append(get_ID())
					.append(" AND IsCentrallyMaintained='Y'");
				no += DB.executeUpdate(sql.toString(), get_TrxName());
				if (log.isLoggable(Level.FINE)) log.fine("Parameters updated #" + no);
				
				// Info Column
				sql = new StringBuilder("UPDATE AD_InfoColumn SET ColumnName=")
					.append(DB.TO_STRING(getColumnName()))
					.append(", Name=").append(DB.TO_STRING(getName()))
					.append(", Description=").append(DB.TO_STRING(getDescription()))
					.append(", Help=").append(DB.TO_STRING(getHelp()))
					.append(", Placeholder=").append(DB.TO_STRING(getPlaceholder()))
					.append(" WHERE AD_Element_ID=").append(get_ID())
					.append(" AND IsCentrallyMaintained='Y'");
				no += DB.executeUpdate(sql.toString(), get_TrxName());
				if (log.isLoggable(Level.FINE)) log.fine("Info Column updated #" + no);
			}
			
			if (   is_ValueChanged(M_Element.COLUMNNAME_Name)
				|| is_ValueChanged(M_Element.COLUMNNAME_Description)
				|| is_ValueChanged(M_Element.COLUMNNAME_Help)
				|| is_ValueChanged(M_Element.COLUMNNAME_Placeholder)
				) {
				//	Field
				sql = new StringBuilder("UPDATE AD_Field SET Name=")
					.append(DB.TO_STRING(getName()))
					.append(", Description=").append(DB.TO_STRING(getDescription()))
					.append(", Help=").append(DB.TO_STRING(getHelp()))
					.append(", Placeholder=").append(DB.TO_STRING(getPlaceholder()))
					.append(" WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=")
					.append(get_ID())
					.append(") AND IsCentrallyMaintained='Y'");
				no = DB.executeUpdate(sql.toString(), get_TrxName());
				if (log.isLoggable(Level.FINE)) log.fine("Fields updated #" + no);
				
				// Info Column - update Name, Description, Help - doesn't have IsCentrallyMaintained currently
				// no = DB.executeUpdate(sql.toString(), get_TrxName());
				// log.fine("InfoColumn updated #" + no);
			}
			
			if (   is_ValueChanged(M_Element.COLUMNNAME_PrintName)
				|| is_ValueChanged(M_Element.COLUMNNAME_Name)
				) {
				//	Print Info
				sql = new StringBuilder("UPDATE AD_PrintFormatItem SET PrintName=")
					.append(DB.TO_STRING(getPrintName()))
					.append(", Name=").append(DB.TO_STRING(getName()))
					.append(" WHERE IsCentrallyMaintained='Y'")	
					.append(" AND EXISTS (SELECT * FROM AD_Column c ")
						.append("WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=")
						.append(get_ID()).append(")");
				no = DB.executeUpdate(sql.toString(), get_TrxName());
				if (log.isLoggable(Level.FINE)) log.fine("PrintFormatItem updated #" + no);
			}
			
		}
		return success;
	}	//	afterSave
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("M_Element[");
		sb.append (get_ID()).append ("-").append (getColumnName()).append ("]");
		return sb.toString ();
	}	//	toString

	public void renameDBColumn(String newColumnName, ProcessInfo pi) {
		List<MColumn> columns = new Query(getCtx(), MColumn.Table_Name, "AD_Element_ID=?", get_TrxName())
				.setParameters(getAD_Element_ID())
				.setOrderBy("AD_Column_ID")
				.list();

		for (MColumn column : columns) {
			String msg = column.renameDBColumn(newColumnName);
			column.saveEx();
			if (pi != null) {
				pi.addLog(0, null, null, msg, MColumn.Table_ID, column.getAD_Column_ID());
			}
		}

		setColumnName(newColumnName);
		return;
	}

}	//	M_Element
