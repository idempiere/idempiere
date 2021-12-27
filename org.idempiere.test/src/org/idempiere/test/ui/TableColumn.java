/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/

package org.idempiere.test.ui;

/**
 * 
 * @author hengsin
 *
 */
public class TableColumn
{
    /** The header value of the column. */
    protected String headerValue;
    
    protected Class<?> columnClass;
    
    protected String tooltipText;

	private int AD_Reference_ID;

    /** 
     *  Cover method, using a default width of 75 
     *  @see #WTableColumn(int)
     */
    public TableColumn() {
		headerValue = null;
    }
    

    /**
     * Sets the <code>Object</code> whose string representation will be
     * used as the value for the <code>headerRenderer</code>.  When the
     * <code>WTableColumn</code> is created, the default <code>headerValue</code>
     * is <code>null</code>.
     * 
     * @param headerValue  the new headerValue
     * @see	  #getHeaderValue
     */
    public void setHeaderValue(String headerValue) 
    {
		this.headerValue = headerValue;
		
		return;
    }
    

    /**
     * Returns the <code>Object</code> used as the value for the header
     * renderer.
     *
     * @return	the <code>headerValue</code> property
     * @see	#setHeaderValue
     */
    public String getHeaderValue() 
    {
    	return headerValue;
    }
    

    /**
     * 
     * @return Class
     */
	public Class<?> getColumnClass() 
	{
		return columnClass;
	}

	/**
	 * 
	 * @param columnClass
	 */
	public void setColumnClass(Class<?> columnClass) 
	{
		this.columnClass = columnClass;
	}

	/**
	 * @return tooltip text
	 */
	public String getTooltipText() {
		return tooltipText;
	}

	/**
	 * @param tooltipText
	 */
	public void setTooltipText(String tooltipText) {
		this.tooltipText = tooltipText;
	}
	
	public int getAD_Reference_ID() {
		return AD_Reference_ID;
	}
	
	public void setAD_Reference_ID(int AD_Reference_ID) {
		this.AD_Reference_ID=AD_Reference_ID;
	}
}
