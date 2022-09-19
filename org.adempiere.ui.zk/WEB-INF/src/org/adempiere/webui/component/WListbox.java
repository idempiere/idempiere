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

package org.adempiere.webui.component;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.model.MWlistboxCustomization;
import org.adempiere.webui.event.TableValueChangeEvent;
import org.adempiere.webui.event.TableValueChangeListener;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.MRole;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Util;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.Listhead;
import org.zkoss.zul.Listheader;

/**
 * Replacement for the Swing client minigrid component
 *
 * ZK Listbox extension for Adempiere Web UI.
 * The listbox contains a model and a renderer.
 * The model holds the underlying data objects, while the
 * renderer deals with displaying the data objects.
 * The renderer will render data objects using a variety of components.
 * These components can then be edited if they are not readonly.
 *
 * @author Andrew Kimball
 * @author Sendy Yagambrum
 */
public class WListbox extends Listbox implements IMiniTable, TableValueChangeListener, WTableModelListener
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5501893389366975849L;

	/**	Logger. */
	private static final CLogger logger = CLogger.getCLogger(WListbox.class);

	/** Is Total Show */
	private boolean showTotals = false;

	/** Model Index of Key Column.   */
	protected int m_keyColumnIndex = -1;

	/** List of R/W columns.     */
	private ArrayList<Integer> m_readWriteColumn = new ArrayList<Integer>();
	// TODO this duplicates other info held on columns. Needs rationalising.
	/** Layout set in prepareTable and used in loadTable.    */
	private ColumnInfo[] m_layout = null;
	/** column class types (e.g. Boolean) */
	private ArrayList<Class<?>> m_modelHeaderClass = new ArrayList<Class<?>>();
	/** Color Column Index of Model.     */
	private int m_colorColumnIndex = -1;
	/** Color Column compare data.       */
	private Object m_colorDataCompare = Env.ZERO;
	
	// F3P: support IDColumn for selection
	private boolean allowIDColumnForReadWrite = false;
	//support for saving column width
	private String wListBoxName = null;
	/**
	 * Default constructor.
	 *
	 * Sets a row renderer and an empty model
	 */
	public WListbox()
	{
		super();
		WListItemRenderer rowRenderer = new WListItemRenderer();
	    rowRenderer.addTableValueChangeListener(this);

		setItemRenderer(rowRenderer);
		setModel(new ListModelTable());
	}

	/**
	 * Set the data model and column header names for the Listbox.
	 *
	 * @param model        The data model to assign to the table
	 * @param columnNames  The names of the table columns
	 */
	public void setData(ListModelTable model, List< ? extends String> columnNames)
	{
		WListItemRenderer rowRenderer = null;
		if (columnNames != null && columnNames.size() > 0)
		{
	    	//	 instantiate our custom row renderer
		    rowRenderer = new WListItemRenderer(columnNames);

	    	// add listener for listening to component changes
	    	rowRenderer.addTableValueChangeListener(this);
		}
	    // assign the model and renderer
	    this.setModel(model);
	    if (rowRenderer != null)
	    {
	    	getModel().setNoColumns(columnNames.size());
	    	this.setItemRenderer(rowRenderer);

	    	//recreate listhead if needed
		    ListHead head = getListHead();
		    if (head != null)
		    {
		    	head.getChildren().clear();
		    	rowRenderer.renderListHead(head);
	    	}
	    }

	    repaint();
	}

    public void setModel(ListModel<?> model)
    {
    	if (getModel() == model)
    		return;
    	
        super.setModel(model);
        if (model instanceof ListModelTable)
        {
            // TODO need to remove listener before adding, but how to do this without
            // causing ConcurrentModificationException
            //((ListModelTable)model).removeTableModelListener(this);
            ((ListModelTable)model).addTableModelListener(this);
        }
    }

	/**
	 * Create the listbox header by fetching it from the renderer and adding
	 * it to the Listbox.
	 *
	 */
	public void initialiseHeader()
	{
	    ListHead head = getListHead();

	    //init only once
	    if (head == null)
	    {
	    	head = new ListHead();
	    	appendChild(head);
	    }
	    else if (head.getChildren().size() > 0)
	    {
	    	if (this.getItemRenderer() instanceof WListItemRenderer)
	    	{
	    		boolean clearTableColumns = false;
	    		WListItemRenderer renderer = (WListItemRenderer) this.getItemRenderer();
	    		if (renderer.getTableColumns().size() != head.getChildren().size())
	    		{
	    			clearTableColumns = true;
	    		}
	    		else
	    		{
	    			List<WTableColumn> m_tableColumns = renderer.getTableColumns();
	    			for (int columnIndex = 0; columnIndex < m_tableColumns.size(); columnIndex++)
	    	        {
	    				WTableColumn column = m_tableColumns.get(columnIndex);
	    				ListHeader header = renderer.getListHeader(columnIndex);
	    				if (header != null && !header.getLabel().equals(column.getHeaderValue()))
	    				{
	    					clearTableColumns = true;
	    					break;
	    				}
	    			}
	    			
	    			if (!clearTableColumns)
	    				return;
	    		}
	    		
	    		if (clearTableColumns)
	    			head.getChildren().clear();
	    	}
	    	else
	    	{
	    		return;
	    	}
	    }

	    // render list head
	    if (this.getItemRenderer() instanceof WListItemRenderer)
	    {
	    	((WListItemRenderer)this.getItemRenderer()).renderListHead(head);
	    }
	    else
	    {
	    	throw new ApplicationException("Rendering of the ListHead is unsupported for "
	    			+ this.getItemRenderer().getClass().getSimpleName());
	    }
	}

	/**
	 *  Is the cell at the specified row and column editable?
	 *
	 *  @param row 		row index of cell
	 *  @param column 	column index of cell
	 *  @return true if cell is editable, false otherwise
	 */
	public boolean isCellEditable(int row, int column)
	{
		//  if the first column holds a boolean and it is false, it is not editable
		
		Object val = getValueAt(row, 0); 
		
		//  if the first column holds a boolean and it is false, it is not editable
		if (column != 0
			&& (val instanceof Boolean)
			&& !((Boolean)val).booleanValue())
		{
			return false;
		}
		
		// F3P: If allowed, use idcolumn as a switch for read/write (Some logic as boolean)
		
		if(allowIDColumnForReadWrite 
			&& column != 0
			&& val instanceof IDColumn 
			&& ((IDColumn)val).isSelected() == false)
		{
			return false;
		}

		//  is the column read/write?
		if (m_readWriteColumn.contains(Integer.valueOf(column)))
		{
			return true;
		}

		return false;
	}   //  isCellEditable

    /**
     * Returns the cell value at <code>row</code> and <code>column</code>.
     * <p>
     * <b>Note</b>: The column is specified in the table view's display
     *  order, and not in the <code>TableModel</code>'s column
     *	order.  This is an important distinction because as the
     *	user rearranges the columns in the table,
     *	the column at a given index in the view will change.
     *  Meanwhile the user's actions never affect the model's
     *  column ordering.
     *
     * @param   row    	the index of the row whose value is to be queried
     * @param   column  the index of the column whose value is to be queried
     * @return  the Object at the specified cell
     */
    public Object getValueAt(int row, int column)
    {
        return getModel().getDataAt(row, convertColumnIndexToModel(column));
    }

    /**
     * Return the <code>ListModelTable</code> associated with this table.
     *
     * @return The <code>ListModelTable</code> associated with this table.
     */
    public ListModelTable getModel()
    {
    	if (super.getModel() == null)
    	{
    		return null;
    	}
    	else if (super.getModel() instanceof ListModelTable)
		{
	    	return (ListModelTable)super.getModel();
		}
		else
		{
			throw new IllegalArgumentException("Model must be instance of " + ListModelTable.class.getName());
		}
    }

    /**
	 * Set the cell value at <code>row</code> and <code>column</code>.
	 *
	 * @param value		The value to set
     * @param row    	the index of the row whose value is to be set
     * @param column	the index of the column whose value is to be set
	 */
	public void setValueAt(Object value, int row, int column)
	{
		getModel().setDataAt(value, row, convertColumnIndexToModel(column));
	}

    /**
     * Convert the index for a column from the display index to the
     * corresponding index in the underlying model.
     * <p>
     * This is unused for this implementation because the column ordering
     * cannot be dynamically changed.
     *
     * @param   viewColumnIndex     the index of the column in the view
     * @return  the index of the corresponding column in the model
     */
    public int convertColumnIndexToModel(int viewColumnIndex)
    {
    	return viewColumnIndex;
    }

    /**
	 *  Set Column at the specified <code>index</code> to read-only or read/write.
	 *
	 *  @param index 	index of column to set as read-only (or not)
	 *  @param readOnly Read only value. If <code>true</code> column is read only,
	 *  				if <code>false</code> column is read-write
	 */
	public void setColumnReadOnly (int index, boolean readOnly)
	{
		Integer indexObject = Integer.valueOf(index);

		//  Column is ReadWrite
		if (m_readWriteColumn.contains(indexObject))
		{
			//  Remove from list
			if (readOnly)
			{
				m_readWriteColumn.remove(indexObject);
			}   //  ReadOnly
		}
		//  current column is R/O - ReadWrite - add to list
		else if (!readOnly)
		{
			m_readWriteColumn.add(indexObject);
		}

		return;
	}   //  setColumnReadOnly

	/**
	 *  Prepare Table and return SQL required to get resultset to
	 *  populate table.
	 *
	 *  @param layout    		array of column info
	 *  @param from      		SQL FROM content
	 *  @param where     		SQL WHERE content
	 *  @param multiSelection 	multiple selections
	 *  @param tableName 		table name
	 *  @return SQL statement to use to get resultset to populate table
	 */
	public String prepareTable(ColumnInfo[] layout,
							String from,
							String where,
							boolean multiSelection,
							String tableName)
	{
		return prepareTable(layout, from, where, multiSelection, tableName, true);
	}   //  prepareTable

    /**
     *  Prepare Table and return SQL required to get resultset to
     *  populate table
     *
     * @param layout            array of column info
     * @param from              SQL FROM content
     * @param where             SQL WHERE content
     * @param multiSelection    multiple selections
     * @param tableName         multiple selections
     * @param addAccessSQL      specifies whether to addAcessSQL
     * @return  SQL statement to use to get resultset to populate table
     */
    public String prepareTable(ColumnInfo[] layout,
            String from,
            String where,
            boolean multiSelection,
            String tableName,
            boolean addAccessSQL)
    {
        int columnIndex = 0;
        StringBuilder sql = new StringBuilder ("SELECT ");
        setLayout(layout);

        clearColumns();

        setMultiSelection(multiSelection);

        //  add columns & sql
        for (columnIndex = 0; columnIndex < layout.length; columnIndex++)
        {
            //  create sql
            if (columnIndex > 0)
            {
                sql.append(", ");
            }
            sql.append(layout[columnIndex].getColSQL());

            //  adding ID column
            if (layout[columnIndex].isKeyPairCol())
            {
                sql.append(",").append(layout[columnIndex].getKeyPairColSQL());
            }

            //  add to model
            addColumn(layout[columnIndex].getColHeader(), layout[columnIndex].getColDescription(), layout[columnIndex].getAD_Reference_ID());

            // set the colour column
            if (layout[columnIndex].isColorColumn())
            {
                setColorColumn(columnIndex);
            }
            if (layout[columnIndex].getColClass() == IDColumn.class)
            {
                m_keyColumnIndex = columnIndex;
            }
        }

        //  set editors (two steps)
        for (columnIndex = 0; columnIndex < layout.length; columnIndex++)
        {
            setColumnClass(columnIndex,
                        layout[columnIndex].getColClass(),
                        layout[columnIndex].isReadOnly(),
                        layout[columnIndex].getColHeader());
        }

        sql.append( " FROM ").append(from);
        sql.append(" WHERE ").append(where);

        if (from.length() == 0)
        {
            return sql.toString();
        }
        //
        if (addAccessSQL)
        {
            String finalSQL = MRole.getDefault().addAccessSQL(sql.toString(),
                                                        tableName,
                                                        MRole.SQL_FULLYQUALIFIED,
                                                        MRole.SQL_RO);

            logger.finest(finalSQL);

            return finalSQL;
        }
        else
        {
            return sql.toString();
        }
    }   // prepareTable

	/**
	 * Clear the table columns from both the model and renderer
	 */
	private void clearColumns()
	{
		((WListItemRenderer)getItemRenderer()).clearColumns();
		getModel().setNoColumns(0);

		return;
	}

	/**
	 * @param header
	 */
	@Override
	public void addColumn (String header) 
	{
		addColumn(header, null);
	}
	
	public void addColumn (String header, String description)
	{
		addColumn(header, description, 0);
	}
	/**
	 *  Add Table Column and specify the column header.
	 *
	 *  @param header	name of column header
	 *  @param description
	 */
	public void addColumn (String header, String description, int AD_Reference_ID)
	{
		WListItemRenderer renderer = (WListItemRenderer)getItemRenderer();
		renderer.addColumn(Util.cleanAmp(header), description, AD_Reference_ID);
		getModel().addColumn();

		return;
	}   //  addColumn

	/**
	 * Set the attributes of the column.
	 *
	 * @param index		The index of the column to be modified
	 * @param classType	The class of data that the column will contain
	 * @param readOnly	Whether the data in the column is read only
	 * @param header	The header text for the column
	 *
	 * @see #setColumnClass(int, Class, boolean)
	 */
	public void setColumnClass (int index, Class<?> classType, boolean readOnly, String header)
	{
		WListItemRenderer renderer = (WListItemRenderer)getItemRenderer();

		setColumnReadOnly(index, readOnly);

		renderer.setColumnHeader(index, header);

		renderer.setColumnClass(index, classType);

		if (index < m_modelHeaderClass.size())
			m_modelHeaderClass.set(index, classType);
		else
			m_modelHeaderClass.add(classType);

 		return;
	}




    /**
     * Set the attributes of the column.
     *
     * @param index     The index of the column to be modified
     * @param classType The class of data that the column will contain
     * @param readOnly  Whether the data in the column is read only
     *
     * @see #setColumnClass(int, Class, boolean, String)
     */
    public void setColumnClass (int index, Class<?> classType, boolean readOnly)
    {
        setColumnReadOnly(index, readOnly);

        WListItemRenderer renderer = (WListItemRenderer)getItemRenderer();

        renderer.setColumnClass(index, classType);

        m_modelHeaderClass.add(classType);

        return;
    }

	/**
	 * Set the attributes of the column.
	 *
	 * @param classType	The class of data that the column will contain
	 * @param readOnly	Whether the data in the column is read only
	 * @param header	The header text for the column
	 *
	 * @see #setColumnClass(int, Class, boolean)
	 * @see #addColumn(String)
	 */
	public void addColumn(Class<?> classType, boolean readOnly, String header)
	{
		m_modelHeaderClass.add(classType);

		setColumnReadOnly(m_modelHeaderClass.size() - 1, readOnly);

		addColumn(header);

		WListItemRenderer renderer = (WListItemRenderer)getItemRenderer();
		renderer.setColumnClass((renderer.getNoColumns() - 1), classType);

 		return;
	}

	/**
	 *	Set the Column to determine the color of the row (based on model index).
	 *  @param modelIndex 	the index of the column used to decide the colour
	 */
	public void setColorColumn (int modelIndex)
	{
		m_colorColumnIndex = modelIndex;
	}   //  setColorColumn

	/**
	 *	Load Table from ResultSet - The ResultSet is not closed.
	 *
	 *  @param rs 	ResultSet containing data t enter int the table.
	 *  			The contents must conform to the column layout defined in
	 *  			{@link #prepareTable(ColumnInfo[], String, String, boolean, String)}
	 */
	public void loadTable(ResultSet rs)
	{
		int row = 0; // model row
		int col = 0; // model column
		Object data = null;
		int rsColIndex = 0; // index into result set
		int rsColOffset = 1;  //  result set columns start with 1
		Class<?> columnClass; // class of the column

		if (getLayout() == null)
		{
			throw new UnsupportedOperationException("Layout not defined");
		}

		clearTable();		

		try
		{
			while (rs.next())
			{
				row = getItemCount();
				setRowCount(row + 1);
				rsColOffset = 1;
				for (col = 0; col < m_layout.length; col++)
				{
					//reset the data value
					data=null;
					columnClass = m_layout[col].getColClass();
					rsColIndex = col + rsColOffset;

					if (isColumnClassMismatch(col, columnClass))
					{
						throw new ApplicationException("Cannot enter a " + columnClass.getName()
								+ " in column " + col + ". " +
								"An object of type " + m_modelHeaderClass.get(col).getSimpleName()
								+ " was expected.");
					}

					if (columnClass == IDColumn.class)
					{
						data = new IDColumn(rs.getInt(rsColIndex));
					}
					else if (columnClass == Boolean.class)
					{
						data = Boolean.valueOf(rs.getString(rsColIndex).equals("Y"));
					}
					else if (columnClass == Timestamp.class)
					{
						data = rs.getTimestamp(rsColIndex);
					}
					else if (columnClass == BigDecimal.class)
					{
						data = rs.getBigDecimal(rsColIndex);
					}
					else if (columnClass == Double.class)
					{
						data = Double.valueOf(rs.getDouble(rsColIndex));
					}
					else if (columnClass == Integer.class)
					{
						data = Integer.valueOf(rs.getInt(rsColIndex));
					}
					else if (columnClass == KeyNamePair.class)
					{
						// TODO factor out this generation
						String display = rs.getString(rsColIndex);
						int key = rs.getInt(rsColIndex + 1);
						data = new KeyNamePair(key, display);
						rsColOffset++;
					}
					else
					{
						// TODO factor out this cleanup
						String s = rs.getString(rsColIndex);
						if (s != null)
						{
							data = s.trim();	//	problems with NCHAR
						}
						else
						{
							data=null;
						}
					}
					//  store in underlying model
					getModel().setDataAt(data, row, col);
				}
			}
		}
		catch (SQLException exception)
		{
			logger.log(Level.SEVERE, "", exception);
		}
		if (getShowTotals())
			addTotals(m_layout);
		
		repaint();

		if (logger.isLoggable(Level.CONFIG)) logger.config("Row(rs)=" + getRowCount());
	}	//	loadTable

	/**
	 * @param col
	 * @param columnClass
	 * @return
	 */
	private boolean isColumnClassMismatch(int col, Class<?> columnClass)
	{
		return !columnClass.equals(m_modelHeaderClass.get(col));
	}

	/**
	 *	Load Table from Object Array.
	 *  @param pos array of Persistent Objects
	 */
	public void loadTable(PO[] pos)
	{
		int row = 0;
		int col = 0;
		int poIndex = 0; // index into the PO array
		String columnName;
		Object data;
		Class<?> columnClass;

		if (m_layout == null)
		{
			throw new UnsupportedOperationException("Layout not defined");
		}

		//  Clear Table
		clearTable();

		for (poIndex = 0; poIndex < pos.length; poIndex++)
		{
			PO myPO = pos[poIndex];
			row = getRowCount();
			setRowCount(row + 1);

			for (col = 0; col < m_layout.length; col++)
			{
				columnName = m_layout[col].getColSQL();
				data = myPO.get_Value(columnName);
				if (data != null)
				{
					columnClass = m_layout[col].getColClass();

					if (isColumnClassMismatch(col, columnClass))
					{
						throw new ApplicationException("Cannot enter a " + columnClass.getName()
								+ " in column " + col + ". " +
								"An object of type " + m_modelHeaderClass.get(col).getSimpleName()
								+ " was expected.");
					}

					if (columnClass == IDColumn.class)
					{
						data = new IDColumn(((Integer)data).intValue());
					}
					else if (columnClass == Double.class)
					{
						data = Double.valueOf(((BigDecimal)data).doubleValue());
					}
				}
				//  store
				getModel().setDataAt(data, row, col);
			}
		}
		if (getShowTotals())
			addTotals(m_layout);
		
		repaint();

		if (logger.isLoggable(Level.CONFIG)) logger.config("Row(array)=" + getRowCount());
	}	//	loadTable

	/**
	 * Clear the table components.
	 */
	public void clear()
	{
		this.getChildren().clear();
	}
	/**
	 *  Get the key of currently selected row based on layout defined in
	 *  {@link #prepareTable(ColumnInfo[], String, String, boolean, String)}.
	 *
	 *  @return ID if key
	 */
	public Integer getSelectedRowKey()
	{
		if (m_layout == null)
		{
			throw new UnsupportedOperationException("Layout not defined");
		}

		int row = getSelectedRow();

		// make common function
		return getRowKeyAt (row);		
	}   //  getSelectedRowKey

	/**
	 * IDEMPIERE-1334
	 * get key of record at index
	 * @param index
	 * @return
	 */
	public Integer getRowKeyAt (int index){
		// TODO factor out the two parts of this guard statement
		if (index < 0 || m_keyColumnIndex < 0)
			return null;
		
		
		Object data = getModel().getDataAt(index, m_keyColumnIndex);

			if (data instanceof IDColumn)
			{
				data = ((IDColumn)data).getRecord_ID();
			}
			if (data instanceof Integer)
			{
				return (Integer)data;
			}
		return null;
		}

	/**
	 * IDEMPIERE-1334
	 * deselect all current select, set all record have key in lsKey is selected
	 * when non key column just return
	 * @param lsKey
	 */
	public void setSelectedByKeys (List<Integer> lsKey){		
		// no key column because can't set selected, just return
		if (m_keyColumnIndex < 0)
			return;					
		ListModelTable model = getModel();
		List<Object> lsSelectedItem = new ArrayList<Object> ();  
		for (int index = 0; index < model.getSize(); index++){
			Integer key = getRowKeyAt(index);
			if (key == null)
				continue;
			
			if (lsKey.contains(key)){
				lsSelectedItem.add (model.getElementAt(index));						
			}			
		}	
		model.setSelection(lsSelectedItem);
	}

	public Integer getFirstRowKey()
	{
		if (m_layout == null)
		{
			throw new UnsupportedOperationException("Layout not defined");
		}
		
		if (getRowCount() <= 0)
		{
			return null;
		}
		
		// make common function
		return getRowKeyAt (0);
	}
	
	/**
     * Returns the index of the first selected row, -1 if no row is selected.
     *
     * @return the index of the first selected row
     */
    public int getSelectedRow()
    {
    	return this.getSelectedIndex();
    }

	/**
	 *  Set the size of the underlying data model.
	 *
	 *  @param rowCount	number of rows
	 */
	public void setRowCount (int rowCount)
	{
		getModel().setNoRows(rowCount);

		return;
	}   //  setRowCount

	/*
	 * Set the name of the wListbox. This is use to save the width of columns
	 * into ad_wlistbox_customization.
	 */
	public void setwListBoxName(String wListBoxName) {
		this.wListBoxName = wListBoxName;
	}
	
	/*
	 * Get the name of the wListbox
	 */
	public String getwListBoxName() {
		return wListBoxName;
	}	
	
	/**
	 *  Get Layout.
	 *
	 *  @return Array of ColumnInfo
	 */
	public ColumnInfo[] getLayoutInfo()
	{
		return getLayout();
	}   //  getLayout

	/**
	 * Removes all data stored in the underlying model.
	 *
	 */
	public void clearTable()
	{
		WListItemRenderer renderer = null;

		// First clear the model
		getModel().clear();

		// Then the renderer
		if (getItemRenderer() instanceof WListItemRenderer)
		{
			renderer = (WListItemRenderer)getItemRenderer();
			renderer.clearSelection();
		}
		else
		{
			throw new IllegalArgumentException("Renderer must be instance of WListItemRenderer");
		}

		return;
	}


    /**
     * Get  the number of rows in this table's model.
     *
     * @return the number of rows in this table's model
     *
     */
    public int getRowCount()
    {
        return getModel().getSize();
    }


	/**
	 *  Set whether or not multiple rows can be selected.
	 *
	 *  @param multiSelection are multiple selections allowed
	 */
	public void setMultiSelection(boolean multiSelection)
	{
		this.setMultiple(multiSelection);

		return;
	}   //  setMultiSelection


	/**
	 *  Query whether multiple rows can be selected in the table.
	 *
	 *  @return true if multiple rows can be selected
	 */
	public boolean isMultiSelection()
	{
		return this.isMultiple();
	}   //  isMultiSelection

	/**
	 *  Set if Totals is Show
	 *  @param show
	 */
	public void setShowTotals(boolean show)
	{
		showTotals= show;
	}
	/**
	 *  get if Totals is Show
	 */
	public boolean getShowTotals()
	{
		return showTotals;
	}

	/**
	 *  Set ColorColumn comparison criteria.
	 *
	 *  @param dataCompare object encapsualating comparison criteria
	 */
	public void setColorCompare (Object dataCompare)
	{
		m_colorDataCompare = dataCompare;

		return;
	}   //

	/**
	 *	Get ColorCode for Row.
	 *  <pre>
	 *	If numerical value in compare column is
	 *		negative = -1,
	 *      positive = 1,
	 *      otherwise = 0
	 *  If Timestamp
	 *  </pre>
	 * @param row row
	 * @return color code
	 */
	public int getColorCode (int row)
	{
		// TODO expose these through interface
		// (i.e. make public class member variables)
		final int valPositive = 1;
		final int valNegative = -1;
		final int valOtherwise = 0;
		Object data;
		int cmp = valOtherwise;

		if (m_colorColumnIndex  == -1)
		{
			return valOtherwise;
		}

		data = getModel().getDataAt(row, m_colorColumnIndex);

		//	We need to have a Number
		if (data == null)
		{
			return valOtherwise;
		}

		try
		{
			if (data instanceof Timestamp)
			{
				if ((m_colorDataCompare == null)
					|| !(m_colorDataCompare instanceof Timestamp))
				{
					m_colorDataCompare = new Timestamp(System.currentTimeMillis());
				}
				cmp = ((Timestamp)m_colorDataCompare).compareTo((Timestamp)data);
			}
			else
			{
				if ((m_colorDataCompare == null)
					|| !(m_colorDataCompare instanceof BigDecimal))
				{
					m_colorDataCompare = Env.ZERO;
				}
				if (!(data instanceof BigDecimal))
				{
					data = new BigDecimal(data.toString());
				}
				cmp = ((BigDecimal)m_colorDataCompare).compareTo((BigDecimal)data);
			}
		}
		catch (Exception exception)
		{
			return valOtherwise;
		}

		if (cmp > 0)
		{
			return valNegative;
		}
		else if (cmp < 0)
		{
			return valPositive;
		}

		return valOtherwise;
	}   //  getColorCode

	/* (non-Javadoc)
	 * @see org.adempiere.webui.event.TableValueChangeListener#tableValueChange
	 * 		(org.adempiere.webui.event.TableValueChangeEvent)
	 */
	public void tableValueChange(TableValueChangeEvent event)
	{
		int col = event.getColumn(); // column of table field which caused the event
		int row = event.getRow(); // row of table field which caused the event
		boolean newBoolean;
		IDColumn idColumn;

		// if the event was caused by an ID Column and the value is a boolean
		// then set the IDColumn's select field
		if (col >= 0 && row >=0)
		{
			if (this.getValueAt(row, col) instanceof IDColumn
				&& event.getNewValue() instanceof Boolean)
			{
				newBoolean = ((Boolean)event.getNewValue()).booleanValue();
				idColumn = (IDColumn)this.getValueAt(row, col);
				idColumn.setSelected(newBoolean);
				this.setValueAt(idColumn, row, col);
			}
			// othewise just set the value in the model to the new value
			else
			{
				this.setValueAt(event.getNewValue(), row, col);
			}
		}

		return;
	}


	/**
	 * Repaint the Table.
	 */
	public void repaint()
	{
	    // create header (if needed)
	    initialiseHeader();
	    renderCustomHeaderWidth();
	    invalidate();
	}

    /**
     * Get the table layout.
     *
     * @return the layout of the table
     * @see #setLayout(ColumnInfo[])
     */
	public ColumnInfo[] getLayout()
	{
		return m_layout;
	}

	/**
	 * Set the column information for the table.
	 *
	 * @param layout	The new layout to set for the table
	 * @see #getLayout()
	 */
	private void setLayout(ColumnInfo[] layout)
	{
		this.m_layout = layout;
		getModel().setNoColumns(m_layout.length);

		return;
	}

    /**
     * Respond to a change in the table's model.
     *
     * If the event indicates that the entire table has changed, the table is repainted.
     *
     * @param event The event fired to indicate a change in the table's model
     */
    public void tableChanged(WTableModelEvent event)
    {
        if ((event.getType() == WTableModelEvent.CONTENTS_CHANGED)
                && (event.getColumn() == WTableModelEvent.ALL_COLUMNS)
                && (event.getFirstRow() == WTableModelEvent.ALL_ROWS))
        {
            this.repaint();
            //sync model with listbox
            ListModelTable model = this.getModel();
            model.updateComponent(0, model.getSize()-1);
        }
        else if ((event.getType() == WTableModelEvent.CONTENTS_CHANGED)
        		&& event.getFirstRow() != WTableModelEvent.ALL_ROWS
        		&& !m_readWriteColumn.isEmpty())
        {
        	int[] indices = this.getSelectedIndices();
        	ListModelTable model = this.getModel();
        	if (event.getLastRow() > event.getFirstRow())
        		model.updateComponent(event.getFirstRow(), event.getLastRow());
        	else
        		model.updateComponent(event.getFirstRow());
        	if (indices != null && indices.length > 0)
        	{
        		this.setSelectedIndices(indices);
        	}
        }

        return;
    }

    /**
     * no op, to ease porting of swing form
     */
	public void autoSize() {
		//no op
	}

	/**
	 * TODO:in theory column of model maybe not map with column of view
	 * in case set other data model this function always return number of column of model, 
	 * maybe not equal with number of column of view
	 * so it should is m_layout.length
	 */
	public int getColumnCount() {
		return getModel() != null ? getModel().getNoColumns() : 0;
	}
	
	public int getKeyColumnIndex() {
		return m_keyColumnIndex;
	}

	/**
	 *  Adding a new row with the totals
	 */
	public void addTotals(ColumnInfo[] layout)
	{
		if (getRowCount() == 0 || layout.length == 0)
			return;
		
		Object[] total = new Object[layout.length];
		
		for (int row = 0 ; row < getRowCount(); row ++)
		{

				for (int col = 0; col < layout.length; col++)
				{
					Object data = getModel().getValueAt(row, col);
					Class<?> c = layout[col].getColClass();
					if (c == BigDecimal.class)
					{	
						BigDecimal subtotal = Env.ZERO;
						if(total[col]!= null)
							subtotal = (BigDecimal)(total[col]);
							
						BigDecimal amt =  (BigDecimal) data;
						if(subtotal == null)
							subtotal = Env.ZERO;
						if(amt == null )
							amt = Env.ZERO;
						total[col] = subtotal.add(amt);
					}
					else if (c == Double.class)
					{
						Double subtotal = Double.valueOf(0);
						if(total[col] != null)
							subtotal = (Double)(total[col]);
						
						Double amt =  (Double) data;
						if(subtotal == null)
							subtotal = Double.valueOf(0);
						if(amt == null )
							amt = Double.valueOf(0);
						total[col] = subtotal + amt;
						
					}		
				}	
		}
		
		//adding total row

		int row = getRowCount() + 1;
		setRowCount(row);
		for (int col = 0; col < layout.length; col++)
		{
			Class<?> c = layout[col].getColClass();
			if (c == BigDecimal.class)
			{	
				setValueAt(total[col] , row - 1, col);
			}
			else if (c == Double.class)
			{
				setValueAt(total[col] , row -1 , col);
			}
			else
			{	
				if(col == 0 )
				{	
					setValueAt(" \u03a3  " , row -1 , col);
				}	
				else
					setValueAt(null , row - 1, col );	
			}	
			
		}
	}

	public boolean isAllowIDColumnForReadWrite()
	{
		return allowIDColumnForReadWrite;
	}

	public void setAllowIDColumnForReadWrite(boolean allowIDColumnForReadWrite)
	{
		this.allowIDColumnForReadWrite = allowIDColumnForReadWrite;
	}
	
	   /**
     * Retrieve the width of the column
     * 
     * @param columnName the name of the column to find the width of.
     * @param columnList list of the columns and their width
     * @return the width of the column
     */
	private String getColumnWidth(String columnName, List<String>columnList) 
	{
		String width ="null";
		String[] w;
		
		for (String column : columnList)
		{
			w = column.trim().split("=");
			if (w[0].equals(columnName))
			{
				return w[1];
			}
		}
		return width;
	}
	
    /**
     * Render the header of the WListbox with the columns width of the saved column width
     * 
     */
	public void renderCustomHeaderWidth () 
	{
		if (wListBoxName != null && getListHead() != null) 
		{
			MWlistboxCustomization WListBoxCustomization =    MWlistboxCustomization.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), wListBoxName, null);
			Boolean isHasCustomizeData =  WListBoxCustomization != null &&
					  WListBoxCustomization.getAD_Wlistbox_Customization_ID() > 0 &&
					  WListBoxCustomization.getCustom() != null &&
					  WListBoxCustomization.getCustom().trim().length() > 0; 			
			if (isHasCustomizeData) 
			{
				String[] custom = WListBoxCustomization.getCustom().trim().split(",");		
				List<String>columnList = Arrays.asList(custom);
				ColumnInfo[] Columns = this.getLayout();
				Listhead listHead =  getListhead();
				if (listHead != null && columnList.size() > 0) 
				{
					List<?> headers = listHead.getChildren();
					int i = 0;
					for(Object obj : headers)
					{
						Listheader header = (Listheader) obj;
						String columnWidth = this.getColumnWidth(Columns[i].getColumnName(), columnList);
						if (!("null".equals(columnWidth)))	
							ZKUpdateUtil.setWidth(header, columnWidth);
						i++; 
					}
				}
			}
		}
	}

	/**
     * Save the width of all the columns in the WLsitbox  
     */
	public void saveColumnWidth() 
	{
		if (!Util.isEmpty(getwListBoxName()))
		{
			StringBuilder custom = new StringBuilder(); 
			Listhead listHead = getListHead();
			ColumnInfo[] layout = getLayout();
			if (listHead != null && layout != null) 
			{
				List<?> headers = listHead.getChildren();
				if (headers.size() != layout.length)
					return;
				
				int i = 0;
				for(Object obj : headers)
				{
					Listheader header = (Listheader) obj;
					String width = header.getWidth();
					String colName = layout[i].getColumnName();
					if (colName != null && !colName.isEmpty())
					{
						custom.append (colName + "=");
						if (width == null)
						{
							width = "null";
						}
						custom.append(width);
						custom.append(",");					
					}				
					i++;
				}
				if (custom.length() > 0)
					custom.deleteCharAt(custom.length() - 1);
				MWlistboxCustomization.saveData(Env.getCtx(), getwListBoxName(), Env.getAD_User_ID(Env.getCtx()), custom.toString(), null);
			}			
		}						
	}

}
