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
package org.idempiere.zk.datatable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.TreeMap;

import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.zk.datatable.DatatableReportRenderer.FunctionTypes;
import org.json.JSONArray;
import org.json.JSONString;
import org.zkoss.zk.ui.Executions;

public class DataTableOptions {
	
	public class JSONFunction implements JSONString {

	    private String string;

	    public JSONFunction(String string) {
	        this.string = string;
	    }

	    @Override
	    public String toJSONString() {
	        return string;
	    }

	}
	
	public final Integer DESC_OFFSET = 1000000;
	
	private HashMap<FunctionTypes, ArrayList<Integer>> functionMap;
	
	private Integer printColLastIndex;
	
	private String locale;

	private boolean ordering = true;
	
	/**
	 * @param locale
	 */
	public DataTableOptions(String locale) {
		functionMap = new HashMap<>();
		this.locale = locale;
	}
	
	/**
	 * Get datatables settings
	 * @return json datatables settings
	 */
	public String getDataTableOptions() {
		String localePath = geti18nURL();
		String i18nPath = localePath != null && Executions.getCurrent() != null ? Executions.encodeURL(localePath) : null;		
		StringBuilder dataOptions = new StringBuilder();
		dataOptions.append(" { ");
		dataOptions.append(" pageLength: ").append(250);
		dataOptions.append(", lengthMenu: [ [250, 500, 1000, -1], [250, 500, 1000,\"").append(Msg.getMsg( Language.getAD_Language(locale), "All")).append("\" ] ] ");
		dataOptions.append(", colReorder: true");
		dataOptions.append(", responsive: false");
		dataOptions.append(", ordering: ").append(ordering ? "true " : "false ");
		if (i18nPath != null)
			dataOptions.append(", language: { url: '").append(i18nPath).append("' }");
		dataOptions.append(", layout: {topStart:['buttons'], topEnd:['pageLength'], bottomStart: ['info'], bottomEnd: ['paging']} ");
		dataOptions.append("""
			, buttons: [{extend: 'colvis', collectionLayout: 'fixed columns'},
			  { text: 'Responsive', 
			    action: function ( e, dt, node, config ) {
			       let option = dt.init(); 
			       option.responsive = !option.responsive;
				   option.buttons[1].text = option.responsive ? 'Responsive ✓' : 'Responsive';
				   dt.destroy(); 
				   $('#JS_DataTable').DataTable(option);
			    }
			  }]""");
		
		dataOptions.append(", initComplete:").append("""
			 function () { 	
			   let tbl = this;		   
			   this.api().columns().every(function () {
				  let that = this;
				  let selector = 'th[data-dt-column="' + this.index() + '"]';
				  let headerCell = tbl.find(selector);
				  if (headerCell.length) {
				  	let input = headerCell.find('input');
				  	input.on('keyup change clear', 
				      function () { 
					      if (that.search() !== this.value) {  
					         that.search(this.value).draw();
					      }
					  });
				  } 				  
			   });
		     }""");
		
		String orderBy = getOrderBy();

		if(orderBy != null)
			dataOptions.append(", order: ").append(orderBy);
		
		String groupByDataSrc = getGroupDataSrc();
		if(groupByDataSrc != null) {
			dataOptions.append(", rowGroup: { ");
			dataOptions.append(" dataSrc: ").append(groupByDataSrc);
			String aggregateFunctions = getRowGroupRendered();
			if(!Util.isEmpty(aggregateFunctions)) {
				dataOptions.append(" , ").append(" endRender: ").append(aggregateFunctions);
				dataOptions.append(" , ").append(" startRender: null ");
			}
			dataOptions.append(" } ");
		}
		
		String footerFunction = getFootAggregateFunctions();
		if(!Util.isEmpty(footerFunction)) {
			dataOptions.append(", footerCallback: ").append(footerFunction);
		}
		
		dataOptions.append(" } ");
		return dataOptions.toString();
		
	}

	/**
	 * Get i18n json URL for datatables
	 * @return i18n json URL
	 */
	public String geti18nURL() {
		String localePath = "~./js/datatables/i18n/"+this.locale+".json";
		if (getClass().getResource("/web"+localePath.substring(2)) == null) {
			if (this.locale.contains("-")) {
				localePath = "~./js/datatables/i18n/"+this.locale.substring(0, this.locale.indexOf("-")) +".json";
				if (getClass().getResource("/web"+localePath.substring(2)) == null) {
					localePath = null;
				}
			}
		}
		return localePath;
	}
	
	/**
	 * Get group rendering function
	 * @return group rendering function
	 */
	private String getRowGroupRendered() {
		
		ArrayList<Integer> groupByList = functionMap.get(FunctionTypes.GROUP_BY);
		Integer groupBy = groupByList.get(0);
		
		TreeMap<Integer, String[]> groupRowNamesMap = new TreeMap<>();
		
		StringBuilder retValue = new StringBuilder();
		retValue.append(" function ( rows, group ) { ");
		// Prepare localization
		retValue.append(" let locale = '" + locale + "'; ");
		
		String groupName = "groupBy_"+groupBy;
		retValue.append(" let ").append(groupName);
		retValue.append(" = group; ");
		groupRowNamesMap.put(groupBy, new String[] { groupName, null });			

		
		retValue.append(" let totalRows = []; ");
		retValue.append(" let displayRows = rows.data(); ");
		retValue.append(" rows.rows().data().filter(function(value, index) { ")
			.append(" let groupValue = null; ")		
			.append(" if(value[").append(groupBy).append("].includes('<a ')) { ")
			.append(" let htmlObject = $(value[").append(groupBy).append("]);")
			.append(" groupValue = htmlObject[0].innerText;")
			.append(" } else { ")
			.append(" groupValue = value[").append(groupBy).append("] }  ")
			.append(" if( groupValue === group ) ")
			.append(" { totalRows.push(value);  } ")
			.append(" }); ");
		
		
		setAggregateFunctions(retValue, groupRowNamesMap);
		
		retValue.append(" let rowRender = $('<tr/>') ");
		Integer prevColIndex = 0;
		for(Entry<Integer, String[]> groupRowNameSet :groupRowNamesMap.entrySet()) {
			Integer actualColIndex = groupRowNameSet.getKey();
			String[] varValues = groupRowNameSet.getValue();
		

			if(actualColIndex -prevColIndex > 0) {
				retValue.append(".append( '<td ");
				retValue.append("colspan=\"").append(actualColIndex-prevColIndex).append("\"/>");
				retValue.append("')");
			}

			if(varValues != null && varValues.length == 2) {
				String varName = varValues[0];
				String varTotalName = varValues[1];
				
				if(varName.contains("groupBy_"))
					retValue.append(".append( '<td class=\"datatable-text\" >  ");
				else
					retValue.append(".append( '<td class=\"datatable-number\" > ");
				if(!Util.isEmpty(varName)) {
					retValue.append("'+"+varName+"+'");
				}
				
				if(!Util.isEmpty(varTotalName)) {
					retValue.append(" <br> ('+"+varTotalName+"+')");
				}
				
				if(varName.contains("groupBy_"))
					retValue.append("  Σ ");
			}
			
			retValue.append("</td>' )");
			prevColIndex = varValues==null ? actualColIndex : actualColIndex+1;
		}
		
		if(prevColIndex < (printColLastIndex+1)) {
			retValue.append(".append( '<td ");
			if((printColLastIndex+1)-prevColIndex > 1)
				retValue.append("colspan=\"").append((printColLastIndex+1)-prevColIndex).append("\"/>");

			retValue.append("') ");
		}
		retValue.append("; ");
		retValue.append("return rowRender;");
		retValue.append(" } ");
		
		return retValue.toString();
	}
	
	/**
	 * Get table footer aggregate rendering function
	 * @return table footer aggregate rendering function
	 */
	private String getFootAggregateFunctions() {
		
		TreeMap<Integer, String[]> groupRowNamesMap = new TreeMap<>();
		
		StringBuilder retValue = new StringBuilder();
		retValue.append(" function ( tfoot, data, start, end, display ) { ");
		retValue.append(" let api = this.api(); ");
		// Prepare localization
		retValue.append(" let locale = '" + locale + "'; ");
		
		ArrayList<Integer> groupByList = functionMap.get(FunctionTypes.GROUP_BY);
		if(groupByList != null) {
			Integer groupBy = groupByList.get(0);
			
			String groupName = "groupBy_"+groupBy;
			retValue.append(" let ").append(groupName);
			retValue.append(" = ' Σ'; ");
			groupRowNamesMap.put(groupBy, new String[] { groupName, null });
		}
		
		retValue.append(" let totalRows = data; ");
		retValue.append(" let displayRows = api.rows({ page: 'current' }).data(); ");
		setAggregateFunctions(retValue, groupRowNamesMap);
		
		for(Entry<Integer, String[]> groupRowNameSet :groupRowNamesMap.entrySet()) {
			Integer actualColIndex = groupRowNameSet.getKey();
			String[] varValues = groupRowNameSet.getValue();
			
			if(varValues == null || varValues.length != 2) {
				continue;
			}
			String varValue = varValues[0];
			String varTotalValue = varValues[1];
			
			retValue.append(" $( api.column( ");
			retValue.append(actualColIndex);
			retValue.append(" ).footer() ).html(").append(varValue);	
			
			if(!Util.isEmpty(varTotalValue)) {
				retValue.append(" ).append('<br>') ");
				retValue.append(".append( '(' + ").append(varTotalValue).append(" +')'");
			}
			
			retValue.append(" ) ");
			

			if(varValue.contains("groupBy_"))
				retValue.append(".addClass( 'datatable-text');");
			else
				retValue.append(".addClass( 'datatable-number');");
		}
		
		retValue.append(" } ");
		return retValue.toString();
		
	}
	
	/**
	 * @param retValue
	 * @param groupRowNamesMap
	 */
	private void setAggregateFunctions(StringBuilder retValue, TreeMap<Integer, String[]> groupRowNamesMap) {
		
		ArrayList<Integer> averageList = functionMap.get(FunctionTypes.AVG);
		ArrayList<Integer> countList = functionMap.get(FunctionTypes.COUNT);
		ArrayList<Integer> deviationList = functionMap.get(FunctionTypes.DEVIATION);
		ArrayList<Integer> maxList = functionMap.get(FunctionTypes.MAX);
		ArrayList<Integer> minList = functionMap.get(FunctionTypes.MIN);
		ArrayList<Integer> sumList = functionMap.get(FunctionTypes.SUM);
		ArrayList<Integer> varianceList = functionMap.get(FunctionTypes.VARIANCE);
		
		if(averageList != null) {
			for(Integer averageID:averageList) {
				String varTotalName = "average_total_"+averageID;
				retValue.append(" let ").append(varTotalName).append(" =  new Intl.NumberFormat(locale).format(+(( totalRows.map(i => new NumberParser(locale).parse(i[").append(averageID).append("])).reduce( function (a, b) { return a + b*1; }, 0) ");
				retValue.append(" / totalRows.length ).toFixed(4))); ");
				
				String varName = "average_"+averageID;
				groupRowNamesMap.put(averageID, new String[] { varName, varTotalName });
				retValue.append(" let ").append(varName).append(" =  new Intl.NumberFormat(locale).format(+(( displayRows.map(i => new NumberParser(locale).parse(i[").append(averageID).append("])).reduce( function (a, b) { return a + b*1; }, 0) ");
				retValue.append(" / displayRows.length ).toFixed(4))); ");
			}
		}
		
		// Count List
		if(countList != null) {
			for(Integer countID:countList) {
				String varTotalName = "count_total_"+countID;
				retValue.append(" let ").append(varTotalName).append(" =  new Intl.NumberFormat(locale).format(totalRows.length); ");
				
				String varName = "count_"+countID;
				groupRowNamesMap.put(countID, new String[] { varName, varTotalName });
				retValue.append(" let ").append(varName).append(" =  new Intl.NumberFormat(locale).format(displayRows.length); ");
			}
		}
		
		if(sumList != null) {
			for(Integer sumID:sumList) {
				String varTotalName = "sum_total_"+sumID;
				retValue.append(" let ").append(varTotalName).append(" =  new Intl.NumberFormat(locale).format(+((totalRows.map(i => new NumberParser(locale).parse(i[").append(sumID).append("])).reduce( function (a, b) { return a + b*1; }, 0)).toFixed(4))); ");
				
				String varName = "sum_"+sumID;
				groupRowNamesMap.put(sumID, new String[] { varName, varTotalName });
				retValue.append(" let ").append(varName).append(" =  new Intl.NumberFormat(locale).format(+((displayRows.map(i => new NumberParser(locale).parse(i[").append(sumID).append("])).reduce( function (a, b) { return a + b*1; }, 0)).toFixed(4))); ");
			}
		}
		
		if(maxList != null) {
			for(Integer maxID:maxList) {
				String varTotalName = "max_total_"+maxID;
				retValue.append(" let ").append(varTotalName).append(" =  new Intl.NumberFormat(locale).format(totalRows.map(i => new NumberParser(locale).parse(i[").append(maxID)
					.append("])).reduce(function(a, b) { return Math.max(a, b);})); ");
				
				String varName = "max_"+maxID;
				groupRowNamesMap.put(maxID, new String[] { varName, varTotalName });
				retValue.append(" let ").append(varName).append(" =  new Intl.NumberFormat(locale).format(displayRows.map(i => new NumberParser(locale).parse(i[").append(maxID)
					.append("])).reduce(function(a, b) { return Math.max(a, b);})); ");
			}
		}
		
		if(minList != null) {
			for(Integer minID:minList) {
				String varTotalName = "min_total_"+minID;
				retValue.append(" let ").append(varTotalName).append(" =  new Intl.NumberFormat(locale).format( totalRows.map(i => new NumberParser(locale).parse(i[").append(minID)
				.append("])).reduce(function(a, b) { return Math.min(a, b);})); ");
				
				String varName = "min_"+minID;
				groupRowNamesMap.put(minID, new String[] { varName, varTotalName });
				retValue.append(" let ").append(varName).append(" =  new Intl.NumberFormat(locale).format( displayRows.map(i => new NumberParser(locale).parse(i[").append(minID)
				.append("])).reduce(function(a, b) { return Math.min(a, b);})); ");
			}
		}
		
		if(varianceList != null) {
			for(Integer varianceID:varianceList) {
				String varTotalName = "variance_total_"+varianceID;
				
				retValue.append(" let ").append(varTotalName).append(" = totalRows.map((i) => { return { sum: new NumberParser(locale).parse(i[").append(varianceID)
					.append("]), sumSquare: (new NumberParser(locale).parse(i[").append(varianceID).append("]) * new NumberParser(locale).parse(i[").append(varianceID).append("]))  ")
					.append(" }; } )");
				retValue.append(".reduce( function (a, b) { let c = { sum: a.sum + b.sum*1, sumSquare: a.sumSquare + b.sumSquare*1 }; return c; }, { sum: 0, sumSquare: 0 }); ");
				
				retValue.append(varTotalName).append(" = new Intl.NumberFormat(locale).format( +(((").append(varTotalName).append(".sumSquare - (( ").append(varTotalName).append(".sum * ").append(varTotalName).append(".sum ) / totalRows.length ))/ totalRows.length ).toFixed(4))); ");
			
				String varName = "variance_"+varianceID;
				groupRowNamesMap.put(varianceID, new String[] { varName, varTotalName });
				
				retValue.append(" let ").append(varName).append(" = displayRows.map((i) => { return { sum: new NumberParser(locale).parse(i[").append(varianceID)
					.append("]), sumSquare: (new NumberParser(locale).parse(i[").append(varianceID).append("]) * new NumberParser(locale).parse(i[").append(varianceID).append("]))  ")
					.append(" }; } )");
				retValue.append(".reduce( function (a, b) { let c = { sum: a.sum + b.sum*1, sumSquare: a.sumSquare + b.sumSquare*1 }; return c; }, { sum: 0, sumSquare: 0 }); ");
				
				retValue.append(varName).append(" = new Intl.NumberFormat(locale).format( +(((").append(varName).append(".sumSquare - (( ").append(varName).append(".sum * ").append(varName).append(".sum ) / displayRows.length ))/ displayRows.length ).toFixed(4))); ");
			}
		}
				
		// Deviation
		if(deviationList != null) {
			for(Integer deviationID:deviationList) {
				String varTotalName = "deviation_total_"+deviationID;
				
				retValue.append(" let ").append(varTotalName).append(" = totalRows.map((i) => { return { sum: new NumberParser(locale).parse(i[").append(deviationID)
					.append("]), sumSquare: (new NumberParser(locale).parse(i[").append(deviationID).append("]) * new NumberParser(locale).parse(i[").append(deviationID).append("]))  ")
					.append(" }; } )");
				retValue.append(".reduce( function (a, b) { let c = { sum: a.sum + b.sum*1, sumSquare: a.sumSquare + b.sumSquare*1 }; return c; }, { sum: 0, sumSquare: 0 }); ");
				
				retValue.append(varTotalName).append(" = ((").append(varTotalName).append(".sumSquare - (( ").append(varTotalName).append(".sum * ").append(varTotalName).append(".sum ) / totalRows.length ))/ totalRows.length ); ");
				retValue.append(varTotalName).append(" =  new Intl.NumberFormat(locale).format(+(Math.sqrt(").append(varTotalName).append(").toFixed(4)));");
			
				String varName = "deviation_"+deviationID;
				groupRowNamesMap.put(deviationID, new String[] { varName, varTotalName });
				
				retValue.append(" let ").append(varName).append(" = displayRows.map((i) => { return { sum: new NumberParser(locale).parse(i[").append(deviationID)
					.append("]), sumSquare: (new NumberParser(locale).parse(i[").append(deviationID).append("]) * new NumberParser(locale).parse(i[").append(deviationID).append("]))  ")
					.append(" }; } )");
				retValue.append(".reduce( function (a, b) { let c = { sum: a.sum + b.sum*1, sumSquare: a.sumSquare + b.sumSquare*1 }; return c; }, { sum: 0, sumSquare: 0 }); ");
				
				retValue.append(varName).append(" = ((").append(varName).append(".sumSquare - (( ").append(varName).append(".sum * ").append(varName).append(".sum ) / displayRows.length ))/ displayRows.length ); ");
				retValue.append(varName).append(" =  new Intl.NumberFormat(locale).format(+(Math.sqrt(").append(varName).append(").toFixed(4)));");
			}
		}
	}
	
	/**
	 * @param type
	 * @param id
	 */
	public void addPrintColumnIndex(FunctionTypes type, Integer id) {
		ArrayList<Integer> list = functionMap.get(type);
		if (list == null) {
			list = new ArrayList<>();
			functionMap.put(type, list);
		}
		
		list.add(id);
	}
	
	/**
	 * Get group by json array
	 * @return group by json array
	 */
	private String getGroupDataSrc() {
		StringBuilder retValue = new StringBuilder();
		ArrayList<Integer> groupByList = functionMap.get(FunctionTypes.GROUP_BY);
		if(groupByList == null)
			return null;
		
		if(groupByList.size() > 1) 
			retValue.append(" [ ");
		
		for(int index = 0; index < groupByList.size() ; index++) {
			Integer groupBy = groupByList.get(index);
			StringBuilder function = new StringBuilder();
			function.append("function(row) { ")
				.append(" if(row[").append(groupBy).append("].includes('<a ')) { ")
				.append(" let htmlObject = $(row[").append(groupBy).append("]);")
				.append(" return htmlObject[0].innerText;")
				.append(" } else { ")
				.append(" return row[").append(groupBy).append("] } }");
			
			retValue.append(function.toString());
			if((index + 1) < groupByList.size())
				retValue.append(" , ");
		}
		
		if(groupByList.size() > 1) 
			retValue.append(" ] ");
		
		return retValue.toString();
	}
	
	/**
	 * Get order by json array
	 * @return order by json array
	 */
	private String getOrderBy() {
		String orderBy = orderListToJson(functionMap.get(FunctionTypes.ORDER_BY));
		return orderBy;
	}
	
	/**
	 * Get last print column index
	 * @return last print column index
	 */
	public Integer getPrintColLastIndex() {
		return printColLastIndex;
	}

	/**
	 * Set last print column index
	 * @param printColLastIndex
	 */
	public void setPrintColLastIndex(Integer printColLastIndex) {
		this.printColLastIndex = printColLastIndex;
	}

	/**
	 * Get locale
	 * @return locale
	 */
	public String getLocale() {
		return locale;
	}

	/**
	 * Convert orderByList to json array
	 * @param orderByList
	 * @return json array for orderByList
	 */
	private String orderListToJson(ArrayList<Integer> orderByList) {
		if(orderByList == null)
			return null;
		
		JSONArray orderArray = null;
		String orderString = "asc"; // asc / desc
		
		for(int orderBy: orderByList) {
			if(orderArray == null)
				orderArray = new JSONArray();
			
			if(orderBy >= DESC_OFFSET) {
				orderBy = orderBy - DESC_OFFSET;
				orderString = "desc";
			} else {
				orderString = "asc";
			}
			JSONArray orderItem = new JSONArray();
			orderItem.put(orderBy);
			orderItem.put(orderString);
			orderArray.put(orderItem);
		}
		return orderArray.toString();

	}

	/**
	 * Enable/disable column sorting option for user
	 */
	public void setOrdering(boolean ordering) {
		this.ordering = ordering;
	}
	
	
	
}
