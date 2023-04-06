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

/**
 * Model for {@link WListbox} column
 * @author Andrew Kimball
 */
public class WTableColumn
{
	@Deprecated(forRemoval = true, since = "11")
    protected int width;

    @Deprecated(forRemoval = true, since = "11")
    protected int minWidth;

    @Deprecated(forRemoval = true, since = "11")
    private int preferredWidth;

    @Deprecated(forRemoval = true, since = "11")
    protected int maxWidth;
    
    @Deprecated(forRemoval = true, since = "11")
    protected boolean	isResizable;

    /** The header value of the column. */
    protected Object		headerValue;
    
    protected Class<?> columnClass;
    
    protected String tooltipText;

	private int AD_Reference_ID;

    /** 
     *  Default constructor
     */
    public WTableColumn() {
    	headerValue = null;
    }
    
    /**
     * @param width
     */
    @Deprecated(forRemoval = true, since = "11")
    public WTableColumn(int width) 
    {
		this.width = width;
		this.preferredWidth = width;
		
		// Set other instance variables to default values.
		minWidth = 15;
		maxWidth = Integer.MAX_VALUE;
		isResizable = true;
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
    public void setHeaderValue(Object headerValue) 
    {
		this.headerValue = headerValue;
    }
    
    /**
     * Returns the <code>Object</code> used as the value for the header
     * renderer.
     *
     * @return	the <code>headerValue</code> property
     * @see	#setHeaderValue
     */
    public Object getHeaderValue() 
    {
    	return headerValue;
    }
    
    @Deprecated(forRemoval = true, since = "11")
    public void setWidth(int width) 
    {
		this.width = Math.min(Math.max(width, minWidth), maxWidth);
		
		return;
    }

    @Deprecated(forRemoval = true, since = "11")
    public int getWidth() 
    {
    	return width;
    }

    @Deprecated(forRemoval = true, since = "11")
    public void setPreferredWidth(int preferredWidth) 
    { 
		this.preferredWidth = Math.min(Math.max(preferredWidth, minWidth), maxWidth);
    }

    @Deprecated(forRemoval = true, since = "11")
    public int getPreferredWidth() 
    {
    	return preferredWidth;
    }

    @Deprecated(forRemoval = true, since = "11")
    public void setMinWidth(int minWidth) 
    { 	
		this.minWidth = Math.max(minWidth, 0);
		
		if (width < minWidth) 
		{
		    setWidth(minWidth);
		}
		
		if (preferredWidth < minWidth) 
		{
		    setPreferredWidth(minWidth);
		}
		
		return;
    }

    @Deprecated(forRemoval = true, since = "11")
    public int getMinWidth() 
    {
    	return minWidth;
    }

    @Deprecated(forRemoval = true, since = "11")
    public void setMaxWidth(int maxWidth) 
    {	
		this.maxWidth = Math.max(minWidth, maxWidth);
		if (width > maxWidth) 
		{
		    setWidth(maxWidth);
		}
		if (preferredWidth > maxWidth) 
		{
		    setPreferredWidth(maxWidth);
		}
		
		return;
    }

    @Deprecated(forRemoval = true, since = "11")
    public int getMaxWidth() 
    {
    	return maxWidth;
    }

    @Deprecated(forRemoval = true, since = "11")
    public void setResizable(boolean isResizable) 
    {	
    	this.isResizable = isResizable;	
    }

    @Deprecated(forRemoval = true, since = "11")
    public boolean getResizable() 
    {
    	return isResizable;
    }

    /**
     * @return Class
     */
	public Class<?> getColumnClass() 
	{
		return columnClass;
	}

	/**
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
	
	/**
	 * @return AD_Reference_ID
	 */
	public int getAD_Reference_ID() {
		return AD_Reference_ID;
	}
	
	/**
	 * @param AD_Reference_ID
	 */
	public void setAD_Reference_ID(int AD_Reference_ID) {
		this.AD_Reference_ID=AD_Reference_ID;
	}
}
