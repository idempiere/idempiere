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

import java.util.function.Function;

import org.adempiere.webui.editor.WEditor;

/**
 * Model for {@link WListbox} column
 * @author Andrew Kimball
 */
public class WTableColumn
{
    /** The header value of the column. */
    protected Object		headerValue;
    
    protected Class<?> columnClass;
    
    protected String tooltipText;

	private int AD_Reference_ID;

	private Function<EditorProviderParameters, WEditor> editorProvider;

    /** 
     *  Default constructor
     */
    public WTableColumn() {
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
     * Get the <code>Object</code> used as the value for the header
     * renderer.
     *
     * @return	the <code>headerValue</code> property
     * @see	#setHeaderValue
     */
    public Object getHeaderValue() 
    {
    	return headerValue;
    }

    /**
     * @return Class
     */
	public Class<?> getColumnClass() 
	{
		return columnClass;
	}

	/**
	 * Set column type
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
	
	/**
	 * Set optional editor provider for column
	 * @param provider Function&lt;EditorProviderParameters, WEditor&gt;
	 */
	public void setEditorProvider(Function<EditorProviderParameters, WEditor> provider) {
		this.editorProvider = provider;
	}
	
	/**
	 * @return Function&lt;EditorProviderParameters, WEditor&gt; instance of null
	 */
	public Function<EditorProviderParameters, WEditor> getEditorProvider() {
		return editorProvider;
	}
	
	/**
	 * Parameters for editor provider 
	 */
	public static class EditorProviderParameters {
		public WListbox listbox;
		public int rowIndex;
		public int columnIndex;
		public Object value;
		
		/**
		 * @param listbox
		 * @param rowIndex
		 * @param columnIndex
		 * @param value
		 */
		public EditorProviderParameters(WListbox listbox, int rowIndex, int columnIndex, Object value) {
			this.listbox = listbox;
			this.rowIndex = rowIndex;
			this.columnIndex = columnIndex;
			this.value = value;
		}				
	}
}
