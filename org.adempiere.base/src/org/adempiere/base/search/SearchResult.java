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
package org.adempiere.base.search;

import java.util.HashMap;
import java.util.Map;

/**
 * Value class to hold search result
 */
public class SearchResult {
    private String windowName;
    private int windowId;
    private String tableName;
    private int recordId;
    private String label;
    private String name;
    private Object[] values;
    private Map<String, Object> valueMap = new HashMap<>();
    private int AD_Message_ID = 0;
    private int AD_Style_ID = 0;
    private int row = -1;
    private double relevanceScore = 0.0;

    /**
     * @return the windowId
     */
    public int getWindowId() {
        return windowId;
    }

    /**
     * @param windowId the windowId to set
     */
    public void setWindowId(int windowId) {
        this.windowId = windowId;
    }

    /**
     * @return the tableName
     */
    public String getTableName() {
        return tableName;
    }

    /**
     * @param tableName the tableName to set
     */
    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    /**
     * @return the windowName
     */
    public String getWindowName() {
        return windowName;
    }

    /**
     * @param windowName the windowName to set
     */
    public void setWindowName(String windowName) {
        this.windowName = windowName;
    }

    /**
     * @return the recordId
     */
    public int getRecordId() {
        return recordId;
    }

    /**
     * @param recordId the recordId to set
     */
    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }

    /**
     * @return the label
     */
    public String getLabel() {
        return label;
    }

    /**
     * @param label the label to set
     */
    public void setLabel(String label) {
        this.label = label;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Set result set values (after the first record id value)
     * 
     * @param values
     */
    public void setValues(Object[] values) {
        this.values = values;
    }

    /**
     * Get result set values (after the first record id value)
     * 
     * @return value array
     */
    public Object[] getValues() {
        return this.values;
    }

    /**
     * Set columnName:columnValue map
     * 
     * @param valueMap
     */
    public void setValueMap(Map<String, Object> valueMap) {
        this.valueMap = valueMap;
    }

    /**
     * @return columnName:columnValue map
     */
    public Map<String, Object> getValueMap() {
        return this.valueMap;
    }

    /**
     * @param AD_Message_ID
     */
    public void setAD_Message_ID(int AD_Message_ID) {
        this.AD_Message_ID = AD_Message_ID;
    }

    /**
     * @return AD_Message_ID
     */
    public int getAD_Message_ID() {
        return this.AD_Message_ID;
    }

    /**
     * @param AD_Style_ID
     */
    public void setAD_Style_ID(int AD_Style_ID) {
        this.AD_Style_ID = AD_Style_ID;
    }

    /**
     * @return AD_Style_ID
     */
    public int getAD_Style_ID() {
        return this.AD_Style_ID;
    }

    /**
     * Set row number of this search result (within search results that uses the
     * same AD_Message_ID)
     * 
     * @param row
     */
    public void setRow(int row) {
        this.row = row;
    }

    /**
     * Get row number
     * 
     * @return row number of this search result (within search results that uses the
     *         same AD_Message_ID)
     */
    public int getRow() {
        return this.row;
    }
    
    public void setRelevanceScore(double relevanceScore) {
		this.relevanceScore = relevanceScore;
    }
    
    public double getRelevanceScore() {
    	return this.relevanceScore;
    }
   
}
