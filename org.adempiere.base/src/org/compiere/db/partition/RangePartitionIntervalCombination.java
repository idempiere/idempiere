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
 **********************************************************************/
package org.compiere.db.partition;

import java.util.ArrayList;
import java.util.List;

public class RangePartitionIntervalCombination {
	private List<List<String>> columnNameCombinations;
	private List<List<String>> nameCombinations;
	private List<List<Object>> fromCombinations;
	private List<List<Object>> toCombinations;
	
	/**
	 * @param columnNameCombinations
	 * @param nameCombinations
	 * @param fromCombinations
	 * @param toCombinations
	 */
	public RangePartitionIntervalCombination(List<List<String>> columnNameCombinations, List<List<String>> nameCombinations, List<List<Object>> fromCombinations, List<List<Object>> toCombinations)
	{
		this.columnNameCombinations = columnNameCombinations;
		this.nameCombinations = nameCombinations;
		this.fromCombinations = fromCombinations;
		this.toCombinations = toCombinations;
	}

	/**
	 * @return column names
	 */
	public List<List<String>> getColumnNameCombinations() {
		return columnNameCombinations;
	}
	
	/**
	 * @return interval names
	 */
	public List<List<String>> getNameCombinations() {
		return nameCombinations;
	}

	/**
	 * @return interval from values
	 */
	public List<List<Object>> getFromCombinations() {
		return fromCombinations;
	}

	/**
	 * @return interval to values
	 */
	public List<List<Object>> getToCombinations() {
		return toCombinations;
	}
	
	/**
	 * Generate combination from intervals
	 * @param intervals
	 * @param currentIndex
	 * @return generated combination
	 */
	public static RangePartitionIntervalCombination generateCombinations(List<List<RangePartitionInterval>> intervals, int currentIndex) {
		List<List<String>> columnNameCombinations = new ArrayList<>();
		List<List<String>> nameCombinations = new ArrayList<>();
		List<List<Object>> fromCombinations = new ArrayList<>();
		List<List<Object>> toCombinations = new ArrayList<>();
		RangePartitionIntervalCombination combination = new RangePartitionIntervalCombination(columnNameCombinations, nameCombinations, fromCombinations, toCombinations);
	
	    if (currentIndex == intervals.size()) {
	    	combination.getColumnNameCombinations().add(new ArrayList<>());
	    	combination.getNameCombinations().add(new ArrayList<>());
	    	combination.getFromCombinations().add(new ArrayList<>());
	    	combination.getToCombinations().add(new ArrayList<>());
	    } else {
	        for (RangePartitionInterval value : intervals.get(currentIndex)) {
	        	RangePartitionIntervalCombination subCombinations = generateCombinations(intervals, currentIndex + 1);
	
	        	for (List<String> subCombination : subCombinations.getColumnNameCombinations()) {
	                List<String> columns = new ArrayList<>();
	                columns.add(value.getColumnName());
	                columns.addAll(subCombination);
	                combination.getColumnNameCombinations().add(columns);
	            }
	        	
	            for (List<String> subCombination : subCombinations.getNameCombinations()) {
	                List<String> names = new ArrayList<>();
	                names.add(value.getName());
	                names.addAll(subCombination);
	                combination.getNameCombinations().add(names);
	            }
	            
	            for (List<Object> subCombination : subCombinations.getFromCombinations()) {
	                List<Object> fromValues = new ArrayList<>();
	                fromValues.add(value.getFrom());
	                fromValues.addAll(subCombination);
	                combination.getFromCombinations().add(fromValues);
	            }
	            
	            for (List<Object> subCombination : subCombinations.getToCombinations()) {
	                List<Object> toValues = new ArrayList<>();
	                toValues.add(value.getTo());
	                toValues.addAll(subCombination);
	                combination.getToCombinations().add(toValues);
	            }
	        }
	    }
	
	    return combination;
	}
}