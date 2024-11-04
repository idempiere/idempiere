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
package org.compiere.minigrid;

import org.compiere.model.GridField;

/**
 *  Column details for list view of data
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ColumnInfo.java,v 1.3 2006/07/30 00:51:28 jjanke Exp $
 */
public class ColumnInfo
{
	/**
	 *  Create Column (r/o and not color column)
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass)
	{
		this(colHeader, colSQL, colClass, true, false, null);
	}   //  ColumnInfo

	/**
	 *  Create Column (r/o and not color column)
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 *  @param readOnly  column is read only
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass, boolean readOnly)
	{
		this(colHeader, colSQL, colClass, readOnly, false, null);
	}   //  ColumnInfo

	/**
	 *  Create Column (r/o and not color column)
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 *  @param keyPairColSQL  SQL select for the ID of the for the displayed column
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass, String keyPairColSQL)
	{
		this(colHeader, colSQL, colClass, true, false, keyPairColSQL);
	}   //  ColumnInfo

	/**
	 *  Create Column (r/o and not color column)
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 *  @param keyPairColSQL  SQL select for the ID of the for the displayed column
	 *  @param readOnly  column is read only
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass, String keyPairColSQL, boolean readOnly)
	{
		this(colHeader, colSQL, colClass, readOnly, false, keyPairColSQL, null);
	}

	/**
	 *  Create Column (r/o and not color column)
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 *  @param keyPairColSQL  SQL select for the ID of the for the displayed column
	 *  @param readOnly  column is read only
	 *  @param displayColumn SQL select code for display column
	 *  @param selectClause AD_InfoColumn.SelectClause
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass, String keyPairColSQL, boolean readOnly, String displayColumn, String selectClause)
	{
		this(colHeader, colSQL, colClass, readOnly, false, keyPairColSQL, null, displayColumn, selectClause);
	}   //  ColumnInfo

	/**
	 *  Create Column
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 *  @param readOnly  column is read only
	 *  @param colorColumn   if true, value of column determines foreground color
	 *  @param keyPairColSQL  SQL select for the ID of the for the displayed column
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass,
		boolean readOnly, boolean colorColumn, String keyPairColSQL)
	{
		this(colHeader, colSQL, colClass, readOnly, false, keyPairColSQL, null, null, null);
	}

	/**
	 *  Create Column
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 *  @param readOnly  column is read only
	 *  @param colorColumn   if true, value of column determines foreground color
	 *  @param keyPairColSQL  SQL select for the ID of the for the displayed column
	 *  @param columnName Column Name
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass,
		boolean readOnly, boolean colorColumn, String keyPairColSQL, String columnName) {
		this(colHeader, colSQL, colClass, readOnly, colorColumn, keyPairColSQL, columnName, null, null);
	}

	/**
	 *  Create Column
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 *  @param readOnly  column is read only
	 *  @param colorColumn   if true, value of column determines foreground color
	 *  @param keyPairColSQL  SQL select for the ID of the for the displayed column
	 *  @param columnName Column Name
	 *  @param displayColumn SQL select code for display column
	 *  @param selectClause AD_InfoColumn.SelectClause
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass,
		boolean readOnly, boolean colorColumn, String keyPairColSQL, String columnName, String displayColumn, String selectClause)
	{
		setColHeader(colHeader);
		setColSQL(colSQL);
		setColClass(colClass);
		setReadOnly(readOnly);
		setColorColumn(colorColumn);
		setColumnName(columnName);
		setKeyPairColSQL(keyPairColSQL);
		setDisplayColumn(displayColumn);
		setSelectClause(selectClause);
	}   //  ColumnInfo

	/**
	 *  Create Column
	 *
	 *  @param colHeader Column Header
	 *  @param colSQL    SQL select code for column
	 *  @param colClass  class of column - determines display
	 *  @param readOnly  column is read only
	 *  @param columnName Column Name
	 */
	public ColumnInfo (String colHeader, String colSQL, Class<?> colClass, boolean readOnly, String columnName)
	{
		this(colHeader, colSQL, colClass, readOnly, false, null, columnName, null, null);
	}   //  ColumnInfo

	private String      m_colHeader;
	private String      m_columnName;
	private String      m_colSQL;
	private Class<?>       m_colClass;
	private boolean     m_readOnly;
	private boolean     m_colorColumn;
	private String      m_keyPairColSQL = "";
	private GridField m_gridField;

	private String colDescription;
	private int AD_Reference_ID;
	private String m_displayColumn;
	private int AD_Reference_Value_ID;
	private String selectClause;

	/**
	 * 	Get Column Class
	 *	@return class
	 */
	public Class<?> getColClass()
	{
		return m_colClass;
	}
	
	/**
	 * 	Get Column Header
	 *	@return header
	 */
	public String getColHeader()
	{
		return m_colHeader;
	}
	
	/**
	 * 	Get Column Name
	 *	@return Column Name
	 */
	public String getColumnName()
	{
		return m_columnName;
	}
	
	/**
	 * 	Get Column SQL
	 *	@return sql
	 */
	public String getColSQL()
	{
		return m_colSQL;
	}
	
	/**
	 * 	Is Column ReadOnly
	 *	@return r/o
	 */
	public boolean isReadOnly()
	{
		return m_readOnly;
	}
	
	/**
	 * 	Set Column class
	 *	@param colClass class
	 */
	public void setColClass(Class<?> colClass)
	{
		m_colClass = colClass;
	}
	
	/**
	 * 	Set Column Header
	 *	@param colHeader header
	 */
	public void setColHeader(String colHeader)
	{
		m_colHeader = colHeader;
		if (colHeader != null)
		{
			int index = colHeader.indexOf('&');
			if (index != -1)
				m_colHeader = colHeader.substring(0, index) + colHeader.substring(index+1); 
		}
	}
	
	/**
	 * 	Set Column Name
	 *	@param columnName Column Name
	 */
	public void setColumnName(String columnName)
	{
		m_columnName = columnName;
	}
	
	/**
	 * 	Set Column SQL
	 *	@param colSQL sql
	 */
	public void setColSQL(String colSQL)
	{
		m_colSQL = colSQL;
	}
	
	/**
	 * 	Set Read Only
	 *	@param readOnly r/o
	 */
	public void setReadOnly(boolean readOnly)
	{
		m_readOnly = readOnly;
	}
	
	/**
	 * 	Set Color Column
	 *	@param colorColumn color
	 */
	public void setColorColumn(boolean colorColumn)
	{
		m_colorColumn = colorColumn;
	}
	
	/**
	 * 	Is Column a ColorColumn
	 *	@return true if color column
	 */
	public boolean isColorColumn()
	{
		return m_colorColumn;
	}
	
	/**
	 *  Add ID column SQL for the displayed column.<br/>
	 *  The Class for this should be KeyNamePair.
	 *  @param keyPairColSQL
	 */
	public void setKeyPairColSQL(String keyPairColSQL)
	{
		m_keyPairColSQL = keyPairColSQL;
		if (m_keyPairColSQL == null)
			m_keyPairColSQL = "";
	}
	
	/**
	 * 	Get Key Pair Column SQL
	 *	@return sql
	 */
	public String getKeyPairColSQL()
	{
		return m_keyPairColSQL;
	}
	
	/**
	 * 	Is Column a Key Pair Column
	 *	@return column
	 */
	public boolean isKeyPairCol()
	{
		return m_keyPairColSQL.length() > 0;
	}
	
	public void setGridField(GridField gridField) 
	{
		m_gridField = gridField;
	}
	
	public GridField getGridField()
	{
		return m_gridField;
	}

	/**
	 * Get Column description
	 * @return Column description
	 */
	public String getColDescription() {
		return colDescription;
	}

	/**
	 * Set Column description
	 * @param colDescription
	 */
	public void setColDescription(String colDescription) {
		this.colDescription = colDescription;
	}
	
	public int getAD_Reference_ID() {
		return AD_Reference_ID;
	}

	public void setAD_Reference_ID(int AD_Reference_ID) {
		this.AD_Reference_ID = AD_Reference_ID;
	}

	/**
	 * Get Display Column
	 * @return DisplayColumn
	 */
	public String getDisplayColumn() {
		return m_displayColumn != null ? m_displayColumn : "";
	}

	/**
	 * Set Display Column
	 * @param displayColumn
	 */
	public void setDisplayColumn(String displayColumn) {
		this.m_displayColumn = displayColumn;
	}

	/**
	 * Get Reference Value
	 * @return the aD_Reference_Value_ID
	 */
	public int getAD_Reference_Value_ID() {
		return AD_Reference_Value_ID;
	}

	/**
	 * Set Reference Value
	 * @param AD_Reference_Value_ID the AD_Reference_Value_ID to set
	 */
	public void setAD_Reference_Value_ID(int AD_Reference_Value_ID) {
		this.AD_Reference_Value_ID = AD_Reference_Value_ID;
	}

	/**
	 * Get Sql SELECT
	 * @return the selectClause
	 */
	public String getSelectClause() {
		return selectClause;
	}

	/**
	 * Set Sql SELECT
	 * @param selectClause the selectClause to set
	 */
	public void setSelectClause(String selectClause) {
		this.selectClause = selectClause;
	}
}   //  infoColumn
