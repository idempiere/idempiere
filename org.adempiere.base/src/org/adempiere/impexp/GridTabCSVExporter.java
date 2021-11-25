/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Carlos Ruiz                                             *
 * Copyright (C) 2012 Trek Global                                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.impexp;

import static org.compiere.model.SystemIDs.REFERENCE_PAYMENTRULE;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.MTabCustomization;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.I_AD_EntityType;
import org.compiere.model.MColumn;
import org.compiere.model.MLocation;
import org.compiere.model.MQuery;
import org.compiere.model.MRefList;
import org.compiere.model.MTab;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluator;
import org.compiere.util.Ini;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.supercsv.cellprocessor.FmtBool;
import org.supercsv.cellprocessor.FmtDate;
import org.supercsv.cellprocessor.FmtNumber;
import org.supercsv.cellprocessor.Optional;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.io.CsvMapWriter;
import org.supercsv.io.ICsvMapWriter;
import org.supercsv.prefs.CsvPreference;

/**
 * CSV Exporter for GridTab
 * @author Carlos Ruiz
 * @author Juan David Arboleda 
 */
public class GridTabCSVExporter implements IGridTabExporter
{
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(GridTabCSVExporter.class);

	@Override
	public void export(GridTab gridTab, List<GridTab> childs, boolean currentRowOnly, File file,int indxDetailSelected) {

		ICsvMapWriter mapWriter = null;
		Map<GridTab,GridField[]> tabMapDetails = new HashMap<GridTab, GridField[]>();
		MTable table= null;
		MTable tableDetail = null;
		try {
			FileOutputStream fileOut = new FileOutputStream (file); 			
			OutputStreamWriter oStrW = new OutputStreamWriter(fileOut, Ini.getCharset());
			BufferedWriter bw = new BufferedWriter(oStrW); 
			mapWriter = new CsvMapWriter(bw, CsvPreference.STANDARD_PREFERENCE);
			String isValidTab = isValidTabToExport(gridTab);
			if(isValidTab!=null){
			   throw new AdempiereException(isValidTab);
			}
			GridTable gt = gridTab.getTableModel();
			GridField[] gridFields = getFields(gridTab);
			if(gridFields.length==0) 
			   throw new AdempiereException(gridTab.getName()+": Did not find any available field to be exported.");
			
			List<String> headArray = new ArrayList<String>();
			List<CellProcessor> procArray = new ArrayList<CellProcessor>();
			table = MTable.get(Env.getCtx(), gridTab.getTableName());
			int specialHDispayType = 0; 
			//master tab
			for (int idxfld = 0; idxfld < gridFields.length; idxfld++) {
				GridField field = gridFields[idxfld];
				MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());		
				//Special Columns 
				if(DisplayType.Location == field.getDisplayType()){
				   specialHDispayType = DisplayType.Location;
				   continue;
				} else if (! (field.isDisplayed() || field.isDisplayedGrid())) {
				   continue;	
				}
				String headName = resolveColumnName(table, column);
				headArray.add(headName);
				if (DisplayType.Date == field.getDisplayType()) {
					procArray.add(new Optional(new FmtDate(DisplayType.DEFAULT_DATE_FORMAT)));
				} else if (DisplayType.DateTime == field.getDisplayType()) {
					procArray.add(new Optional(new FmtDate(DisplayType.DEFAULT_TIMESTAMP_FORMAT)));
				} else if (DisplayType.Time == field.getDisplayType()) {
					procArray.add(new Optional(new FmtDate(DisplayType.DEFAULT_TIME_FORMAT)));
				} else if (DisplayType.Integer == field.getDisplayType() || DisplayType.isNumeric(field.getDisplayType())) {
					DecimalFormat nf = DisplayType.getNumberFormat(field.getDisplayType());
					nf.setGroupingUsed(false);
					procArray.add(new Optional(new FmtNumber(nf)));
				} else if (DisplayType.YesNo == field.getDisplayType()) {
					procArray.add(new Optional(new FmtBool("Y", "N")));
				} else { // lookups
					procArray.add(new Optional());
				}
			}
			
			if(specialHDispayType > 0){
			   for(String specialHeader:resolveSpecialColumnName(specialHDispayType)){
				   headArray.add(gridTab.getTableName()+">"+specialHeader);
				   procArray.add(null);
			   }	
			}
			//Details up to tab level 1 
			if(childs.size() > 0){		
			  int specialDetDispayType = 0; 

			  for(GridTab detail: childs){
				 
				 if(!detail.isDisplayed())
					continue;
				 
				 if(detail.getDisplayLogic()!=null){
					//TODO: it's need? DisplayLogic is evaluated when call detail.isDisplayed() 
				    if(currentRowOnly && !Evaluator.evaluateLogic(detail,detail.getDisplayLogic()))
					   continue;
				 }
		 		 
				 if(detail.getTabLevel()>1) 
	 			    continue; 
				  
				 isValidTab = isValidTabToExport(detail);
				 if (isValidTab!=null){
					 if (log.isLoggable(Level.INFO)) log.info(isValidTab);
					 continue;
				 }	
				 tableDetail = MTable.get(Env.getCtx(), detail.getTableName());	 
				 gridFields = getFields(detail);
				 for(GridField field : gridFields){
					 MColumn columnDetail  = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
					 if(DisplayType.Location == field.getDisplayType()){
						specialDetDispayType = DisplayType.Location;
						continue;
					 }
					 String  headNameDetail= detail.getTableName()+">"+resolveColumnName(tableDetail, columnDetail);
					 headArray.add(headNameDetail); 
					 if (DisplayType.Date == field.getDisplayType()) {
						 procArray.add(new Optional(new FmtDate(DisplayType.DEFAULT_DATE_FORMAT)));
					 } else if (DisplayType.DateTime == field.getDisplayType()) {
						 procArray.add(new Optional(new FmtDate(DisplayType.DEFAULT_TIMESTAMP_FORMAT)));
					 } else if (DisplayType.Time == field.getDisplayType()) {
						 procArray.add(new Optional(new FmtDate(DisplayType.DEFAULT_TIME_FORMAT)));
					 } else if (DisplayType.Integer == field.getDisplayType() || DisplayType.isNumeric(field.getDisplayType())) {
						 DecimalFormat nf = DisplayType.getNumberFormat(field.getDisplayType());
						 nf.setGroupingUsed(false);
						 procArray.add(new Optional(new FmtNumber(nf)));
					 } else if (DisplayType.YesNo == field.getDisplayType()) {
						 procArray.add(new Optional(new FmtBool("Y", "N")));
					 } else { // lookups and text
						 procArray.add(new Optional());
					 }
				} 
			    if(specialDetDispayType > 0){
				   for(String specialHeader:resolveSpecialColumnName(specialDetDispayType)){
					   headArray.add(detail.getTableName()+">"+specialHeader);
					   procArray.add(null);
				   }
				   specialDetDispayType = 0;
			    }				 
			    tabMapDetails.put(detail,gridFields); 
			}
				gridFields = null;
		   }
				
			// the header elements are used to map the bean values to each column (names must match)
			String[] header = headArray.toArray(new String[headArray.size()]);
			CellProcessor[] processors = procArray.toArray(new CellProcessor[procArray.size()]);
			// write the header
			mapWriter.writeHeader(header);
			// write the beans
			int start = 0;
			int end = 0;
			if (currentRowOnly) {
				start = gridTab.getCurrentRow();
				end = start + 1;
			} else {
				end = gt.getRowCount();
			}
			for (int idxrow = start; idxrow < end; idxrow++) {
				Map<String, Object> row = new HashMap<String, Object>();
				int idxfld = 0;	
				int index =0;
				int rowDetail=0;  
				int record_Id = 0;

				gridTab.setCurrentRow(idxrow);
				for(GridField field : getFields(gridTab)){   
					MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
					Object value = null;
					String headName = header[idxfld];
					if(DisplayType.Location == field.getDisplayType()){
					   Object fResolved =resolveValue(gridTab, table, column, idxrow, column.getColumnName());  
					   if (fResolved!=null)  		   
						   record_Id= Integer.parseInt(fResolved.toString());
					   
					   continue;
					}else if (DisplayType.Payment == field.getDisplayType()){
					   value = MRefList.getListName(Env.getCtx(),REFERENCE_PAYMENTRULE, gridTab.getValue(idxrow, header[idxfld]).toString()); 		 
					}else{	
					   value = resolveValue(gridTab, table, column, idxrow, headName);
					}
					row.put(headName,value);
					idxfld++;
					index++;
				} 
			    	
				if(specialHDispayType > 0 && record_Id > 0){
				   switch(specialHDispayType) {
			         case DisplayType.Location:  
			              MLocation address = new MLocation (Env.getCtx(),record_Id,null);  
						  for(String specialHeader:resolveSpecialColumnName(specialHDispayType)){
							  String columnName = specialHeader.substring(specialHeader.indexOf(">")+1,specialHeader.length());		
							  Object sValue = null; 
							  if (columnName.indexOf("[") >= 0 && columnName .endsWith("]")){ 
								  int indx = columnName.indexOf("["); 
								  String columnRef= columnName.substring(indx+1,columnName.length()-1);	
								  String tableRef = columnName.substring(0,indx);
								  Object record_id= address.get_Value(tableRef); 
								  if (record_id!=null)
								      sValue = queryExecute(columnRef,tableRef,record_id);
							  }else{
								  sValue = address.get_Value(columnName);	
								  if (DisplayType.YesNo == MColumn.get(Env.getCtx(), MLocation.Table_Name, columnName).getAD_Reference_ID()) {
									  if (sValue != null && (Boolean) sValue)
										  sValue = "Y";
									  else if (sValue != null && ! (Boolean) sValue)
										  sValue = "N";
								  }
							  }						
							  row.put(gridTab.getTableName()+">"+specialHeader,sValue);
							  idxfld++;
							  index++;
						 }
			             break;
			         }	
				}

				if(childs.size()>0){
					for (GridTab childTab:childs){
						if (!childTab.isLoadComplete()){
							childTab.initTab(false);
						}
						
						childTab.query(false, 0, 0);
					}
					
					while(true){
						 Map<String, Object> tmpRow = resolveMasterDetailRow(rowDetail,tabMapDetails,headArray,index); 					  
						 if(tmpRow!= null){   							
						   for(Map.Entry<String, Object> details : tmpRow.entrySet()) {	
							   String detailColumn = details.getKey();
							   Object value =details.getValue();
							   row.put(detailColumn , value);
						   }
						   rowDetail++;
						   mapWriter.write(row, header,processors);
						}else{
						   break;
						}
					 
			    	}  	
				}
				
				if(rowDetail==0)
				    mapWriter.write(row, header,processors);
				
				idxfld=0;
			}
		} catch (IOException e) {
			throw new AdempiereException(e);
		} finally {
			if (mapWriter != null) {
				try {
					mapWriter.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	//add constraints to not allow certain tabs 
	private String isValidTabToExport(GridTab gridTab){
	    String result=null;
	    
	    MTab tab = MTab.get(gridTab.getAD_Tab_ID());

		if (tab.isReadOnly())
		   result = Msg.getMsg(Env.getCtx(),"FieldIsReadOnly", new Object[] {gridTab.getName()});
		
		return result;
	}
	
	private Map<String, Object> resolveMasterDetailRow(int currentDetRow,Map<GridTab,GridField[]> tabMapDetails,List<String>headArray,int idxfld){
		Map<String,Object> activeRow = new HashMap<String,Object>();
		Object value = null;
		boolean hasDetails = false;
		int specialDetDispayType = 0; 
		
		if (currentDetRow > 0 )
		   for(int j =0;j<idxfld;j++)
			   activeRow.put(headArray.get(j), null);	
		
		for(Map.Entry<GridTab, GridField[]> childTabDetail : tabMapDetails.entrySet()) {		
		    GridTab childTab = childTabDetail.getKey();
			Map<String,Object> row = new HashMap<String,Object>();
		    if (childTab.getRowCount() > 0) {
		    	int specialRecordId = 0;
		    	for(GridField field : childTabDetail.getValue()){
				    MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
					if(DisplayType.Location == column.getAD_Reference_ID()){
					   specialDetDispayType = DisplayType.Location;
					   Object fResolved = resolveValue(childTab, MTable.get(Env.getCtx(),childTab.getTableName()), column, currentDetRow,column.getColumnName());
					   if(fResolved!=null)
					      specialRecordId = Integer.parseInt(fResolved.toString());
				       
					   continue;
				    }
				    MTable tableDetail = MTable.get(Env.getCtx(), childTab.getTableName());
				    String headName = headArray.get(headArray.indexOf(childTab.getTableName()+">"+resolveColumnName(tableDetail,column))); 
				    value = resolveValue(childTab, MTable.get(Env.getCtx(),childTab.getTableName()), column, currentDetRow, headName.substring(headName.indexOf(">")+ 1,headName.length()));
				    
				    if(DisplayType.Payment == field.getDisplayType() && value != null)
					   value = MRefList.getListName(Env.getCtx(),REFERENCE_PAYMENTRULE, value.toString()); 
					   
				    row.put(headName,value);
				    if(value!=null)
				       hasDetails = true;
			    }	
				if(specialDetDispayType > 0 && specialRecordId > 0){
					MLocation address = new MLocation (Env.getCtx(),specialRecordId,null);  
					for(String specialHeader:resolveSpecialColumnName(specialDetDispayType)){
						String columnName = specialHeader.substring(specialHeader.indexOf(">")+1,specialHeader.length());		
						Object sValue = null; 
						if (columnName.indexOf("[") >= 0 && columnName .endsWith("]")){ 
							int indx = columnName.indexOf("["); 
							String columnRef= columnName.substring(indx+1,columnName.length()-1);	
							String tableRef = columnName.substring(0,indx);
							Object record_id= address.get_Value(tableRef); 
							if(record_id!=null)
							   sValue = queryExecute(columnRef,tableRef,record_id);
						}else{
							sValue = address.get_Value(columnName);	
							if (DisplayType.YesNo == MColumn.get(Env.getCtx(), MLocation.Table_Name, columnName).getAD_Reference_ID()) {
								if (sValue != null && (Boolean) sValue)
									sValue = "Y";
								else if (sValue != null && ! (Boolean) sValue)
									sValue = "N";
							}
						}						
						row.put(childTab.getTableName()+">"+specialHeader,sValue);
					}	
				}
		    }
	       activeRow.putAll(row);
		}
		if (hasDetails)
			return activeRow;
		else
		    return null;
	}
	
	/**
	 * @param childTab
	 * @param parentGrid
	 * @param currentParentIndex
	 * @return
	 */
	@Deprecated // don't use any where, relate IDEMPIERE-2788
	public String getWhereClause (GridTab childTab, GridTab parentGrid, int currentParentIndex){
		String whereClau = null; 
		String linkColumn = childTab.getLinkColumnName();
		if (parentGrid.getKeyColumnName().equals(linkColumn)){
	    	whereClau= linkColumn+MQuery.EQUAL + parentGrid.getKeyID(currentParentIndex);
		}else{
			whereClau= parentGrid.getKeyColumnName() + MQuery.EQUAL + parentGrid.getValue(currentParentIndex, parentGrid.getKeyColumnName());
		}
	    return whereClau; 
	}
	
	private Object resolveValue(GridTab gridTab, MTable table, MColumn column, int i, String headName) {
		Object value = null;
		if (headName.indexOf("[") >= 0 && headName.endsWith("]")) {
			String foreignTable = column.getReferenceTableName();
			Object idO = gridTab.getValue(i, column.getColumnName());
			if (idO != null) {
				if (foreignTable.equals("AD_Ref_List")) {
					String ref = (String) idO;
					value = MRefList.getListName(Env.getCtx(), column.getAD_Reference_Value_ID(), ref);
				} else {
					int id = (Integer) idO;
					int start = headName.indexOf("[")+1;
					int end = headName.length()-1;
					String foreignColumn = headName.substring(start, end);
					StringBuilder select = new StringBuilder("SELECT ")
							.append(foreignColumn).append(" FROM ")
							.append(foreignTable).append(" WHERE ")
							.append(foreignTable).append("_ID=?");
					value = DB.getSQLValueStringEx(null, select.toString(), id);
				}
			}
		} else {
			value = gridTab.getValue(i, headName);
		}
		return value;
	}
	
	private Object queryExecute(String selectColumn,String tableName,Object record_id){		
		
		StringBuilder select = new StringBuilder("SELECT ")
		   					   .append(selectColumn).append(" FROM ")
		   					   .append(tableName.substring(0,tableName.length()-3)).append(" WHERE ")
		   					   .append(tableName).append("=?");
		
	    return DB.getSQLValueStringEx(null, select.toString(),record_id);
	}
	
	private String resolveColumnName(MTable table, MColumn column) {
		StringBuilder name = new StringBuilder(column.getColumnName());
		if (DisplayType.isLookup(column.getAD_Reference_ID())) {
			// resolve to identifier - search for value first, if not search for name - if not use the ID
			String foreignTable = column.getReferenceTableName();
			if ("AD_EntityType".equals(foreignTable) && I_AD_EntityType.COLUMNNAME_AD_EntityType_ID.equals(column.getColumnName())){
				name.append("[EntityType]"); // ColumnName is unique value IDEMPIERE-3375
			}else if ( ! ("AD_Language".equals(foreignTable) || "AD_EntityType".equals(foreignTable) || "AD_Ref_List".equals(foreignTable))) {
				MTable fTable = MTable.get(Env.getCtx(), foreignTable);
				// Hardcoded / do not check for Value on AD_Org, AD_User and AD_Ref_List, must use name for these two tables
				if ("AD_Element".equals(foreignTable)){
					name.append("[ColumnName]"); // ColumnName is unique value IDEMPIERE-3375
				}else if (! ("AD_Org".equals(foreignTable) || "AD_User".equals(foreignTable)) && fTable.getColumn("Value") != null) {
					name.append("[Value]"); // fully qualified
				} else if (fTable.getColumn("Name") != null) {
					name.append("[Name]");
				} else if (fTable.getColumn("DocumentNo") != null) {
					name.append("[DocumentNo]");
				}
			}
		} else if (DisplayType.Account == column.getAD_Reference_ID()) {
			name.append("[Combination]");
		}
		return name.toString();
	}
	
	private ArrayList<String> resolveSpecialColumnName(int displayType){
		
		ArrayList<String> specialColumnNames = new ArrayList<String>();
		if (DisplayType.Location == displayType ){
			GridWindowVO gWindowVO = Env.getMWindowVO(0,121,0); 
			GridWindow m_mWindow = new GridWindow (gWindowVO);
			GridTab m_mTab = m_mWindow.getTab(0);
			m_mWindow.initTab(0);
			for(GridField locField:m_mTab.getFields()){
				if("AD_Client_ID".equals(locField.getColumnName()))
					continue;
				if("AD_Org_ID".equals(locField.getColumnName()))
					continue;
				if("IsActive".equals(locField.getColumnName()))
					continue;
				if(!locField.isDisplayed())
					continue;
				
				String fName = resolveColumnName(MTable.get(Env.getCtx(), m_mTab.getTableName()),MColumn.get(Env.getCtx(), locField.getAD_Column_ID()));
				specialColumnNames.add(m_mTab.getTableName()+">"+ fName);	
			}	
		}
		
		return specialColumnNames;
	}
	
	@Override
	public String getFileExtension() {
		return "csv";
	}

	@Override
	public String getFileExtensionLabel() {
		return Msg.getMsg(Env.getCtx(), "FileCSV");
	}

	@Override
	public String getContentType() {
		return "application/csv";
	}

	private GridField[] getFields (GridTab gridTab) {
		GridTable tableModel = gridTab.getTableModel();
		GridField[] tmpFields = tableModel.getFields();
		MTabCustomization tabCustomization = MTabCustomization.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), gridTab.getAD_Tab_ID(), null);
		GridField[] gridFields = null;
		if (tabCustomization != null 
			&& tabCustomization.getAD_Tab_Customization_ID() > 0 
			&& !Util.isEmpty(tabCustomization.getCustom(), true)) 
		{
			String custom = tabCustomization.getCustom().trim();
			String[] customComponent = custom.split(";");
			String[] fieldIds = customComponent[0].split("[,]");
			List<GridField> fieldList = new ArrayList<GridField>();
			for (String fieldIdStr : fieldIds) 
			{
				fieldIdStr = fieldIdStr.trim();
				if (fieldIdStr.length() == 0) continue;
				int AD_Field_ID = Integer.parseInt(fieldIdStr);
				for (GridField gridField : tmpFields) 
				{
					if (gridField.getAD_Field_ID() == AD_Field_ID) {
						if (   gridField.isVirtualColumn()
							|| gridField.isEncrypted()
							|| gridField.isEncryptedColumn()
							|| !(gridField.isDisplayed() || gridField.isDisplayedGrid())
							|| gridField.isReadOnly()
							|| (DisplayType.Button == MColumn.get(Env.getCtx(),gridField.getAD_Column_ID()).getAD_Reference_ID())
						   )
							continue;

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
			
			for (GridField field:tmpFields)
			{
				if ("AD_Client_ID".equals(field.getColumnName()))
					continue;
				if (DisplayType.Button == MColumn.get(Env.getCtx(),field.getAD_Column_ID()).getAD_Reference_ID())
					continue;
				if (   field.isVirtualColumn()
						|| field.isEncrypted()
						|| field.isEncryptedColumn()
						|| !(field.isDisplayed() || field.isDisplayedGrid()))
						continue;
				if (field.isParentValue() || (!field.isReadOnly() && field.isDisplayedGrid()) || field.isParentColumn())
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
		return gridFields;
	}

	@Override
	public String getSuggestedFileName(GridTab gridTab) {
		return "Export_" + gridTab.getTableName() + "." + getFileExtension();
	}

	/**
	 * {@inheritDoc}
	 * just export display tab, one level deep, not read only and not account tab
	 */
	@Override
	public boolean isExportableTab(GridTab detail) {
		if(!detail.isDisplayed())
			return false;
		
		 if(detail.getTabLevel()>1) 
			    return false; 
		  
		 if (isValidTabToExport(detail) != null){
			 return false;
		 }
		 
		 return true;
	}

}
