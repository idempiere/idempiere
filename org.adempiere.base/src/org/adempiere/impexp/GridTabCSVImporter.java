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

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.sql.Timestamp;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;
import java.util.logging.Level;

import org.adempiere.base.IGridTabImporter;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.MColumn;
import org.compiere.model.MLocation;
import org.compiere.model.MQuery;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;
import org.supercsv.cellprocessor.Optional;
import org.supercsv.cellprocessor.ParseBigDecimal;
import org.supercsv.cellprocessor.ParseBool;
import org.supercsv.cellprocessor.ParseDate;
import org.supercsv.cellprocessor.ParseInt;
import org.supercsv.cellprocessor.constraint.StrMinMax;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.exception.SuperCsvCellProcessorException;
import org.supercsv.io.CsvMapReader;
import org.supercsv.io.ICsvMapReader;
import org.supercsv.prefs.CsvPreference;

/**
 * CSV Importer for GridTab
 * @author Carlos Ruiz
 * @author Juan David Arboleda 
 */
public class GridTabCSVImporter implements IGridTabImporter
{
	private static final String ERROR_HEADER = "_ERROR_";
	private static final String LOG_HEADER = "_LOG_";
	private String IMPORT_MODE = null;
	
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(GridTabCSVImporter.class);
	boolean m_isError = false;
	
	public File fileImport(GridTab gridTab, List<GridTab> childs, InputStream filestream, Charset charset , String importMode) {		
		ICsvMapReader mapReader = null;
		File errFile = null;
		File logFile = null;
		PrintWriter errFileW = null;
		PrintWriter logFileW = null;
		CsvPreference csvpref = CsvPreference.STANDARD_PREFERENCE;
		String delimiter = String.valueOf((char) csvpref.getDelimiterChar());
		String quoteChar = String.valueOf((char) csvpref.getQuoteChar());
		IMPORT_MODE = importMode;
        
		if(!gridTab.isInsertRecord() && IMPORT_MODE.equals("I"))
        	throw new AdempiereException("Insert record disabled for Tab");
	
		try {
			String errFileName = FileUtil.getTempMailName("Import_" + gridTab.getTableName(), "_err.csv");
			errFile = new File(errFileName);
			errFileW = new PrintWriter(errFile, charset.name());
			mapReader = new CsvMapReader(new InputStreamReader(filestream, charset), csvpref);
			List<String> header =  Arrays.asList(mapReader.getHeader(true));  
			List<CellProcessor> readProcArray = new ArrayList<CellProcessor>();
			Map<GridTab,Integer> tabMapIndexes = new HashMap<GridTab,Integer>();
			int indxDetail=0;
			List<GridField> locationFields = null;
			boolean isThereKey   = false;
			//Mapping header  
			for(int idx = 0; idx < header.size(); idx++) {
				String headName = header.get(idx);
				if (headName.equals(ERROR_HEADER) || headName.equals(LOG_HEADER)){
					header.set(idx, null);
					readProcArray.add(null);
					continue;
				}
				if (headName.indexOf(">") > 0) {
					if(idx==0){
					   throw new AdempiereException(Msg.getMsg(Env.getCtx(),"WrongHeader", new Object[] {headName}));
				    }else if (headName.contains(MTable.getTableName(Env.getCtx(), MLocation.Table_ID)) && locationFields==null){ 
				       locationFields = getSpecialMColumn(header,MTable.getTableName(Env.getCtx(), MLocation.Table_ID),idx);
					   for(GridField sField:locationFields){
				           readProcArray.add(getProccesorFromColumn(MColumn.get(Env.getCtx(),sField.getAD_Column_ID()))); 
				           indxDetail++;
					   }
					   idx=indxDetail;
				    }else
					   break;
				    
				}else{
					boolean isKeyColumn = headName.indexOf("/") > 0;
					boolean isForeing 	= headName.indexOf("[") > 0 && headName.indexOf("]")>0;
					String  columnName  = getColumnName (isKeyColumn,isForeing,false,headName);
					GridField field 	= gridTab.getField(columnName);
					
					if (field == null)
						throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FieldNotFound" , new Object[] {columnName}) );
					else if(isKeyColumn && !isThereKey)
						isThereKey =true;
					
					readProcArray.add(getProccesorFromColumn(MColumn.get(Env.getCtx(),field.getAD_Column_ID()))); 
					indxDetail++;
			    }
			}	
			
			if((IMPORT_MODE.equals("U") || IMPORT_MODE.equals("M")) && !isThereKey)
			    throw new AdempiereException(gridTab.getTableName()+": "+Msg.getMsg(Env.getCtx(), "NoKeyFound"));
			
			tabMapIndexes.put(gridTab,indxDetail-1);
			String  childTableName   = null;
			isThereKey = false;
			locationFields = null;
			GridTab currentDetailTab = null;
			//Mapping details 
		    for(int idx = indxDetail; idx < header.size(); idx++) {	
		    	String detailName = header.get(idx);
		    	if(detailName!=null && detailName.indexOf(">") > 0){
		    	   childTableName = detailName.substring(0,detailName.indexOf(">"));  
		    	   if (currentDetailTab==null || 
		    		  (currentDetailTab!=null && !childTableName.equals(currentDetailTab.getTableName()))){
		    		   
		    		   if(currentDetailTab!=null){ 
		    			 //check out key per Tab   
		   		    	 if((IMPORT_MODE.equals("U") || IMPORT_MODE.equals("M")) && !isThereKey){
		 				    throw new AdempiereException(currentDetailTab.getTableName()+": "+Msg.getMsg(Env.getCtx(), "NoKeyFound"));
		   		    	 }else{
		   		    	    tabMapIndexes.put(currentDetailTab,idx-1); 	
			    			isThereKey =false; 
		   		    	 } 
		    		   }
		    		   
		    		   for(GridTab detail: childs){
						   if(detail.getTableName().equals(childTableName)){
							  currentDetailTab = detail;
							  break;
						   }
					   } 
		    	   }
		    	   
				   if(currentDetailTab == null) 
					  throw new AdempiereException(Msg.getMsg(Env.getCtx(),"NoChildTab",new Object[] {childTableName}));
		    	   
				   String columnName = detailName;
				   if (columnName.contains(MTable.getTableName(Env.getCtx(), MLocation.Table_ID)) && locationFields==null){
					   locationFields = getSpecialMColumn(header,MTable.getTableName(Env.getCtx(), MLocation.Table_ID),idx);
					   for(GridField sField:locationFields){
						   readProcArray.add(getProccesorFromColumn(MColumn.get(Env.getCtx(),sField.getAD_Column_ID()))); 
						   idx++;
					   }
					   idx--;
				    }else{
					   boolean isKeyColumn= columnName.indexOf("/") > 0;
					   boolean isForeing  = columnName.indexOf("[") > 0 && columnName.indexOf("]")>0;
					   columnName = getColumnName(isKeyColumn,isForeing,true,columnName);
					   GridField field = currentDetailTab.getField(columnName);
					  
					   if(field == null)
						  throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FieldNotFound",new Object[] {detailName}));
					   else if(isKeyColumn && !isThereKey)
						  isThereKey =true;
					
					   readProcArray.add(getProccesorFromColumn(MColumn.get(Env.getCtx(),field.getAD_Column_ID())));  
				   }				   
		    	}else
		    	   throw new AdempiereException(Msg.getMsg(Env.getCtx(),"WrongDetailName",new Object[] {" col("+idx+") ",detailName}));
		    	
		    }
		    
		    if(currentDetailTab!=null){
		    	if((IMPORT_MODE.equals("U") || IMPORT_MODE.equals("M")) && !isThereKey)
				   throw new AdempiereException(currentDetailTab.getTableName()+": "+Msg.getMsg(Env.getCtx(), "NoKeyFound"));

			    tabMapIndexes.put(currentDetailTab,header.size()-1); 	   
		    }
	
		    TreeMap<GridTab,Integer> sortedtTabMapIndexes= null;
		    if (childs.size()>0 && !tabMapIndexes.isEmpty()){
		    	ValueComparator bvc =  new ValueComparator(tabMapIndexes);
		        sortedtTabMapIndexes = new TreeMap<GridTab,Integer>(bvc);
		        sortedtTabMapIndexes.putAll(tabMapIndexes);
		    }else{
		    	sortedtTabMapIndexes = new TreeMap<GridTab,Integer>();
		    	sortedtTabMapIndexes.put(gridTab,header.size()-1); 	   
		    }
			
		    CellProcessor[] processors = readProcArray.toArray(new CellProcessor[readProcArray.size()]);	
			m_isError = false;
			// write the header
			String rawHeader = mapReader.getUntokenizedRow();
			errFileW.write(rawHeader + delimiter + ERROR_HEADER + "\n");
			List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
			List<String> rawData = new ArrayList<String>();
			// pre-process to check for errors
			while (true) {
				Map<String, Object> map = null;
				boolean isLineError = false; 
				StringBuilder errMsg = new StringBuilder();
				try {			
				    map = mapReader.read((String [])header.toArray(), processors);
				} catch (SuperCsvCellProcessorException e) {
					int idx = e.getCsvContext().getColumnNumber() - 1;
					errMsg.append(header.get(idx)).append(": ").append(e.getMessage());
					isLineError = true;
				}
				String rawLine = mapReader.getUntokenizedRow();
				if (! isLineError) {
					if(map == null)
					   break;
					
					//Re-order information coming from map
					List<Object> tmpRow = getOrderedRowFromMap(header,map);	  					
					//read master and detail
					int initIndx= 0;
					for(Map.Entry<GridTab, Integer> tabIndex : sortedtTabMapIndexes.entrySet()) {
						GridTab tmpGrid = tabIndex.getKey(); 						
						if(gridTab.equals(tmpGrid) && tmpRow.get(0)==null){
						   initIndx = indxDetail;
						   continue;	
						}						
						int endindx = tabIndex.getValue();
						StringBuilder lineError = preprocessRow (tmpGrid,header,tmpRow,initIndx,endindx);
						if( lineError!= null && lineError.length() > 0 ){
							isLineError = true;
							if (errMsg.length() > 0)
								errMsg.append(" / ");
							    errMsg.append(lineError);
						}
					    initIndx = endindx + 1;
					}
				}
				if (isLineError && ! m_isError)
					m_isError = true;
				if (!m_isError) {
					data.add(map);
					rawData.add(rawLine);
				}
				// write
				rawLine = rawLine + delimiter + quoteChar + errMsg.toString().replaceAll(quoteChar, "") + quoteChar + "\n";
				errFileW.write(rawLine);
			}

			if (!m_isError) {
				String logFileName = FileUtil.getTempMailName("Import_" + gridTab.getTableName(), "_log.csv");
				logFile = new File(logFileName);
				logFileW = new PrintWriter(logFile, charset.name());
				// write the header
				logFileW.write(rawHeader + delimiter + LOG_HEADER + "\n");
				// no errors found - process header and then details 
				boolean isMasterok = true;
				PO masterRecord = null; 
				String trxName= null;
				for (int idx = 0; idx < data.size(); idx++) {
					String rawLine = rawData.get(idx);
					String logMsg = null;
					StringBuilder  rowResult = new StringBuilder();
					Trx trx = null;
					GridTab currentGridTab=null;
					boolean error=false;
					boolean isDetail=false ;
					int currentColumn=0;
					
					if (rawLine.charAt(0)==',')
						isDetail=true;
		
					//if master failed, then ignore any detail from it.  
					if (!isMasterok && isDetail){
						rawLine = rawLine + delimiter + quoteChar + Msg.getMsg(Env.getCtx(),"NotProccesed") + quoteChar + "\n";
						logFileW.write(rawLine);
						continue;	 
					}					
					
					try {
						Map<String, Object> map = data.get(idx);
						isMasterok = true;
						if(!isDetail){
						   masterRecord = null;
						   trxName = "Import_" + gridTab.getTableName() + "_" + UUID.randomUUID();
						}else if (trxName == null){
						   trxName ="Import_" + gridTab.getTableName() + "_" + UUID.randomUUID();
						}
						
						for(Map.Entry<GridTab, Integer> tabIndex : sortedtTabMapIndexes.entrySet()) {
							currentGridTab = tabIndex.getKey(); 			

							if(isDetail && gridTab.equals(currentGridTab)){
							   currentColumn=indxDetail;
							   continue;			
							}
						
							currentGridTab.getTableModel().setImportingMode(true,trxName);	
							trx = Trx.get(trxName,true);
							int j =  tabIndex.getValue();	
							
							logMsg = areValidKeysAndColumns(currentGridTab,map,header,currentColumn,j,masterRecord);
							
							if (logMsg == null){
								if (IMPORT_MODE.equals("I")){
								  if(!currentGridTab.getTableModel().isOpen())
								      currentGridTab.getTableModel().open(0);					
								  //how to read from status since the warning is coming empty ?
								  if (!currentGridTab.dataNew(false))
									  logMsg = "["+currentGridTab.getName()+"]"+"- Was not able to create a new record!";
								} 
								
								if(logMsg==null)
								   logMsg = proccessRow(currentGridTab,header,map,currentColumn,j,masterRecord);

								currentColumn = j + 1;		
								if(!(logMsg == null)){
								   IMPORT_MODE =importMode;   
							 	   //Ignore row since there is no data 
								   if("NO_DATA_TO_IMPORT".equals(logMsg)){
									  logMsg ="";
									  currentGridTab.dataIgnore();
									  continue;
								   }else 
									  error =true;
								}
							}else {
								error =true;
								currentColumn = j + 1;
							}
							if (! error) {
								if (currentGridTab.dataSave(false)){						
									PO po = currentGridTab.getTableModel().getPO(currentGridTab.getCurrentRow());		
									//Keep master record for details validation 
									if(currentGridTab.equals(gridTab))
									   masterRecord = po;

									if(IMPORT_MODE.equals("I"))
									   logMsg = Msg.getMsg(Env.getCtx(), "Inserted")+" "+ po.toString();	
									else
									   logMsg = Msg.getMsg(Env.getCtx(), "Updated")+" "+ po.toString(); 
									
									trx.commit();
									if(isDetail || currentGridTab.isDetail()){
									   currentGridTab.refreshParentTabs();   
									   currentGridTab.getTableModel().dataRequery(masterRecord.get_WhereClause(true), false, 0);
									}
									currentGridTab.dataRefresh(true);
								} else {
									ValueNamePair ppE = CLogger.retrieveWarning();
									if (ppE==null)   
										ppE = CLogger.retrieveError();
									
									String info = null;
									
									if (ppE != null)
										info = ppE.getName();
									if (info == null)
										info = "";
									
									logMsg = Msg.getMsg(Env.getCtx(), "Error") + " " + Msg.getMsg(Env.getCtx(), "SaveError") + " (" + info + ")";
									currentGridTab.dataIgnore();
									trx.rollback();
									
									if(currentGridTab.equals(gridTab) && masterRecord==null){
									   isMasterok = false;
									   break;
								    }
								}
								rowResult.append("<"+currentGridTab.getTableName()+">: ");
								rowResult.append(logMsg);
							    rowResult.append(" / ");
							} else {
								currentGridTab.dataIgnore();
								error = false;
								trx.rollback();
								
								rowResult.append("<"+currentGridTab.getTableName()+">: ");
								rowResult.append(logMsg);
							    rowResult.append(" / ");
   
								//Master Failed, thus details cannot be imported 
								if(currentGridTab.equals(gridTab) && masterRecord==null){
								   isMasterok = false;
								   break;
								}
							}	
							IMPORT_MODE = importMode;
							currentGridTab.getTableModel().setImportingMode(false, null); 	
						}
					} catch (Exception e) {
						rowResult.append("<"+currentGridTab.getTableName()+">: ");
						rowResult.append(Msg.getMsg(Env.getCtx(), "Error") + " " + e.getLocalizedMessage());
					    rowResult.append(" / ");
						currentGridTab.dataIgnore();
						trx.rollback();
						error = true;
					} finally {						
					  if (trx != null) {
						  trx.close();
						  trx = null;
					  }
					  IMPORT_MODE =importMode; 
					}
					// write
					rawLine = rawLine + delimiter + quoteChar + rowResult.toString().replaceAll(delimiter, "") + quoteChar + "\n";
					logFileW.write(rawLine);
				}
			}
		} catch (IOException e) {
	      throw new AdempiereException(e);
		}
		finally {
			try {
				if (mapReader != null)
					mapReader.close();
				if (errFileW != null) {
					errFileW.flush();
					errFileW.close();
				}
				if (logFileW != null) {
					logFileW.flush();
					logFileW.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		gridTab.getTableModel().dataRequery("1=1",false,0);
		gridTab.dataRefreshAll();
		if (logFile != null)
			return logFile;
		else
			return errFile;
	}
	
	private String getColumnName(boolean isKey ,boolean isForeing ,boolean isDetail , String headName){		
		
		if(isKey){
		   if(headName.indexOf("/") > 0){
			  if(headName.endsWith("K"))
				  headName = headName.substring(0,headName.length()-2);  
			  else
				 throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ColumnKey")+" "+headName);
		   } 
		}
		
		if(isForeing)
		   headName = headName.substring(0, headName.indexOf("["));		
		
        if(isDetail){
           headName = headName.substring(headName.indexOf(">")+ 1,headName.length());
           if (headName.indexOf(">")>0)
        	   headName = headName.substring(headName.indexOf(">")+ 1,headName.length());
        }
        return headName;
	}
	
	private List<GridField> getSpecialMColumn(List<String> header, String tableName, int idx) {
		
		List<GridField> lsField = new ArrayList<GridField>();		
		if (tableName.equals(MTable.getTableName(Env.getCtx(), MLocation.Table_ID))){
			GridWindowVO gWindowVO = Env.getMWindowVO(0,121,0); 
			GridWindow m_mWindow = new GridWindow (gWindowVO);
			GridTab m_mTab = m_mWindow.getTab(0);
			m_mWindow.initTab(0);
			for(int i = idx;i< header.size();i++){
				if (header.get(i).contains(MTable.getTableName(Env.getCtx(), MLocation.Table_ID))) {
					boolean isKeyColumn = header.get(i).indexOf("/") > 0;
					boolean isForeing 	= header.get(i).indexOf("[") > 0 && header.get(i).indexOf("]")>0;
					String  columnName  = getColumnName (isKeyColumn,isForeing,true,header.get(i)); 
					GridField field  = m_mTab.getField(columnName);
					if (field == null)
						throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FieldNotFound", new Object[] {header.get(i)}));
					
					lsField.add(field);
				}else
					break;
			}
		}
		return lsField;
	}

	private List<Object> getOrderedRowFromMap (List<String> header,Map<String, Object> map){
		List<Object> tmpRow= new ArrayList<Object>();  
		for (int i = 0; i < header.size(); i++)
			tmpRow.add(null);
		
		for(Map.Entry<String, Object> record : map.entrySet()) {
			String Column =record.getKey();
			Object value  = record.getValue();
		    int toIndx= header.indexOf(Column);
		    tmpRow.set(toIndx, value);
        }	
		return tmpRow;	
	}
	
	private StringBuilder preprocessRow (GridTab gridTab,List<String> header,List<Object> tmpRow,int startindx,int endindx){
		
	    boolean isEmptyRow = true;
	    boolean isAddressValidated = false ;
	    StringBuilder  mandatoryColumns = new StringBuilder();
	    for(int i = startindx;  i < endindx +1; i++){
			String columnName = header.get(i);	
			Object value = tmpRow.get(i); 	
			//Validate Address
			if(header.get(i).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID)) && !isAddressValidated){
			   StringBuilder specialColumns = new StringBuilder();
			   specialColumns = validateSpecialFields(gridTab,header,tmpRow,i,"C_Location_ID");
			   isAddressValidated = true;
			   if(specialColumns==null)
				  continue;   
			   else
				  return specialColumns;     
			}else if (header.get(i).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID)) && isAddressValidated){
				continue;
			}
			
			if(value!=null)
			   isEmptyRow=false;
			
			if (log.isLoggable(Level.FINE)) log.fine("Setting " + columnName + " to " + value);

			boolean isKeyColumn = columnName.indexOf("/") > 0;
			boolean isForeing 	= columnName.indexOf("[") > 0 && columnName.indexOf("]")>0;
			boolean isDetail    = columnName.indexOf(">") > 0;
			columnName = getColumnName(isKeyColumn,isForeing,isDetail,columnName);
			String foreignColumn=null; 
			if(isForeing) 
			   foreignColumn = header.get(i).substring(header.get(i).indexOf("[")+1, header.get(i).indexOf("]"));
		
			GridField field=gridTab.getField(columnName);					
			if (field == null) 
				return new StringBuilder(Msg.getMsg(Env.getCtx(), "NotAWindowField" , new Object[] {header.get(i)}));

			if (field.isParentValue())
				continue;
			
			if (field.isReadOnly() && !field.isParentValue()) 
				return new StringBuilder(Msg.getMsg(Env.getCtx(), "FieldIsReadOnly",new Object[] {header.get(i)}));
			
			if (!(field.isDisplayed() || field.isDisplayedGrid())) 
				return new StringBuilder(Msg.getMsg(Env.getCtx(), "FieldNotDisplayed",new Object[] {header.get(i)}));
			
			MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());		
			if((field.isMandatory(true) || column.isMandatory()) && value == null && field.getDefault()==null){ 
				mandatoryColumns.append(" / ");
				mandatoryColumns.append(header.get(i));
			} 
			
			if (isForeing && value != null && !"(null)".equals(value)){
				String foreignTable = column.getReferenceTableName();
				String idS = null;
				int id = -1;
				if("AD_Ref_List".equals(foreignTable))
				   idS= resolveForeignList(column,foreignColumn,value);
				else 
				   id = resolveForeign(foreignTable,foreignColumn,value);
				
				if(idS == null && id < 0){	
				   //it could be that record still doesn't exist if import mode is inserting or merging   	
				   if(IMPORT_MODE.equals("U"))
				     return new StringBuilder(Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{header.get(i),value}));
				}
			} else {
				// no validation here
				// TODO: we could validate length of string or min/max
			}
		}
	    
		if(mandatoryColumns.length()>1 && !isEmptyRow) 
		   return new StringBuilder(Msg.getMsg(Env.getCtx(), "FillMandatory")+" "+mandatoryColumns);
		else
		   return null;		
	}
	
	private StringBuilder validateSpecialFields(GridTab gridTab,List<String> header,List<Object> tmpRow,int i,String sField){

	   GridField field = gridTab.getField(sField);
	   if(field == null) 
		  return new StringBuilder(Msg.getMsg(Env.getCtx(), "NotAWindowField",new Object[] {sField}));
	    
	   if(field.isReadOnly() && !field.isParentValue()) 
		  return new StringBuilder(Msg.getMsg(Env.getCtx(), "FieldIsReadOnly",new Object[] {field.getColumnName()}));
			
	   if(!(field.isDisplayed() || field.isDisplayedGrid())) 
		  return new StringBuilder(Msg.getMsg(Env.getCtx(), "FieldNotDisplayed",new Object[] {field.getColumnName()}));
	   
	   if (header.get(i).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID)))
	   {
		   //without Region or Country any address would be invalid 
		   boolean thereIsCountry = false ;
		   boolean thereIsRegion  = false; 
		   boolean isEmptyRow = true;
		   for(int j= i;j< header.size();j++){
			   if(!header.get(j).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID)))
			       break;
			   				   
			   String columnName = header.get(j);	
			   Object value = tmpRow.get(j);   
			   if(value!=null){ 
				  if(columnName.contains("RegionName")||columnName.contains("C_Region_ID")) 
				     thereIsRegion = true;
				  if(columnName.contains("C_Country_ID"))
					 thereIsCountry= true;
			   }else
				  continue;
			   			    
			   boolean isKeyColumn = columnName.indexOf("/") > 0;
			   boolean isForeing   = columnName.indexOf("[") > 0 && columnName.indexOf("]")>0;
			   boolean isDetail    = columnName.indexOf(">") > 0;
			   String  foreignColumn = null; 
			   columnName = getColumnName(isKeyColumn,isForeing,isDetail,columnName);
			   if(isForeing) 
				  foreignColumn = header.get(j).substring(header.get(j).indexOf("[")+1, header.get(j).indexOf("]"));
			   
			   if(isForeing && !"(null)".equals(value)){ 
			      String foreignTable = columnName.substring(0,columnName.length()-3);
				  if(resolveForeign(foreignTable,foreignColumn,value) < 0)
				     return new StringBuilder(Msg.getMsg(Env.getCtx(), "ForeignNotResolved" ,new Object[]{header.get(j),value}));   
			   }	   
			   isEmptyRow=false;
	      }	   
		  MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());		
		  if((field.isMandatory(true) || column.isMandatory()) && !isEmptyRow && (!thereIsRegion || !thereIsCountry)) 
			  return new StringBuilder(Msg.getMsg(Env.getCtx(), "FillMandatory")+" "+field.getColumnName()+"["+(thereIsRegion==true?"Region":"C_Country_ID")+"]");
	   }
	   return null;
	}	
	
	private String proccessRow(GridTab gridTab,List<String> header, Map<String, Object> map,int startindx,int endindx,PO masterRecord){
		
		String logMsg = null;	
		boolean isThereRow = false;
		MLocation address = null;
		List<String> parentColumns = new ArrayList<String>(); 
		for(int i = startindx ; i < endindx + 1 ; i++){
			String columnName = header.get(i);
			Object value = map.get(header.get(i));
			boolean isDetail = false;
			if(value == null)
			   continue;
				
			if(columnName.endsWith("_ID") && "0".equals(value))
			   continue;
				
			boolean isKeyColumn= columnName.indexOf("/") > 0;
			boolean isForeing  = columnName.indexOf("[") > 0 && columnName.indexOf("]")>0;
			isDetail   = columnName.indexOf(">") > 0;
			columnName = getColumnName(isKeyColumn,isForeing,isDetail,columnName);
			String foreignColumn = null;
			Object setValue = null;
			
			if(isForeing) 
			   foreignColumn = header.get(i).substring(header.get(i).indexOf("[")+1,header.get(i).indexOf("]"));
			
			if(header.get(i).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID))){
		    
				if(address == null){
				    if(IMPORT_MODE.equals("I")){
					   address = new MLocation (Env.getCtx(),0,masterRecord.get_TrxName());	   
				    }else{
				       Object location = gridTab.getValue("C_Location_ID")==null?0:gridTab.getValue("C_Location_ID").toString();
					   int C_Location_ID = Integer.parseInt(location.toString());  
					   address =  new MLocation (Env.getCtx(),C_Location_ID,masterRecord.get_TrxName());	
				    }
				}
				
				if(!"(null)".equals(value.toString().trim())){
				   if(isForeing) {
					  String foreignTable = columnName.substring(0,columnName.length()-3);
					  setValue = resolveForeign(foreignTable,foreignColumn,value);
					  if("C_City".equals(foreignTable))
						 address.setCity(value.toString());  
					}else
					  setValue = value;			
				}
				address.set_ValueOfColumn(columnName,setValue);
			}else{
				if(isKeyColumn && IMPORT_MODE.equals("U"))
				   continue;
				
				GridField field = gridTab.getField(columnName);
				if (field.isParentValue()){
					
					if("(null)".equals(value.toString())){
					   logMsg = Msg.getMsg(Env.getCtx(),"NoParentDelete", new Object[] {header.get(i)}); 
					   break;
					}
					
					if(isForeing && masterRecord!=null){
					   if (masterRecord.get_Value(foreignColumn).toString().equals(value)){
						   logMsg = gridTab.setValue(field,masterRecord.get_ID());
						   if(logMsg.equals(""))
							  logMsg= null;
						   else break;
					   }else{
						   if(value!=null){					      
						      logMsg = header.get(i)+" - "+Msg.getMsg(Env.getCtx(),"DiffParentValue", new Object[] {masterRecord.get_Value(foreignColumn).toString(),value});
						      break;
						   }   
					   }
					}else if (masterRecord==null && isDetail){
						MColumn column = MColumn.get(Env.getCtx(),field.getAD_Column_ID());
						String foreignTable = column.getReferenceTableName();
						String idS = null;
						int id = -1;
						
						if ("AD_Ref_List".equals(foreignTable)) 
							idS= resolveForeignList(column, foreignColumn, value);
						else 
							id = resolveForeign(foreignTable, foreignColumn, value);
						
						if(idS == null && id < 0)	
						   return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{header.get(i),value});
						
						if(id >= 0)
						   logMsg = gridTab.setValue(field,id);
						else if (idS != null)
						   logMsg = gridTab.setValue(field,idS);
						
						if(logMsg !=null && logMsg.equals(""))
						   logMsg = null;
						else break;
					}
					parentColumns.add(columnName);	
					continue;
				}
				//this field should not be inserted or updated 
				if(!field.isDisplayed(true)) 
					continue;
					
				if (!IMPORT_MODE.equals("I") && !field.isEditable(true) && value!=null) {
					logMsg = Msg.getMsg(Env.getCtx(), "FieldNotEditable", new Object[] {header.get(i)}) + "{" + value + "}";
					break;
				}		
				if("(null)".equals(value.toString().trim())){
				   logMsg = gridTab.setValue(field,null);	
				   if(logMsg.equals(""))
					  logMsg= null;
				   else break;
				}else{
				   
				   MColumn column = MColumn.get(Env.getCtx(),field.getAD_Column_ID());
				   if (isForeing){
						String foreignTable = column.getReferenceTableName();
						if ("AD_Ref_List".equals(foreignTable)) {
							String idS = resolveForeignList(column, foreignColumn, value);
							if(idS == null)	
							   return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{header.get(i),value});
							
							setValue = idS;
							isThereRow =true;
						} else {
							int id = resolveForeign(foreignTable, foreignColumn, value);
							if(id < 0)	
							   return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{header.get(i),value});
							
							setValue = id;
							if (field.isParentValue()) {
								int actualId = (Integer) field.getValue();
								if (actualId != id) {
									logMsg = Msg.getMsg(Env.getCtx(), "ParentCannotChange",new Object[]{header.get(i)});
									break;
								}
							}
							isThereRow =true;
						}
				   }else{
					   if(value != null) {
						  if(value instanceof java.util.Date)
							 value = new Timestamp(((java.util.Date)value).getTime());
							
						  setValue = value;
						  isThereRow =true;
					   }
				   }
					
				   if(setValue != null) 				
					  logMsg = gridTab.setValue(field,setValue);
				   
				   if(logMsg!=null && logMsg.equals(""))
					  logMsg= null;
				   else break;
			   }
			}	
		}
			 
		if(address!=null){  
			if (!address.save()){
			    logMsg = CLogger.retrieveError()+" Address : "+address;
			}else {
				logMsg = gridTab.setValue("C_Location_ID",address.get_ID());
				if(logMsg.equals(""))
				   logMsg= null;
				
				isThereRow =true;	
			}
		}	
	    
		boolean checkParentKey = parentColumns.size()!=gridTab.getParentColumnNames().size();
		if(isThereRow && logMsg==null && masterRecord!=null && checkParentKey){
			for(String linkColumn : gridTab.getParentColumnNames()){
				String columnName = linkColumn;
				Object setValue   = masterRecord.get_Value(linkColumn);
		        //resolve missing key 
				if(setValue==null){
			       columnName = null;
		           for(int j = startindx;j < endindx + 1;j++){
		        	   if(header.get(j).contains(linkColumn)){
		        		   columnName = header.get(j);
		        		   setValue   = map.get(columnName);
		        		   break;
		        	   }
		           }
		           if( columnName!=null ){
					   String foreignColumn = null;						
					   boolean isForeing = columnName.indexOf("[") > 0 && columnName.indexOf("]")>0;
					   if(isForeing) 
						  foreignColumn  = columnName.substring(columnName.indexOf("[")+1,columnName.indexOf("]"));   
			           
					   columnName = getColumnName(false,isForeing,true,columnName);	      
					   MColumn column = MColumn.get(Env.getCtx(),gridTab.getField(columnName).getAD_Column_ID());
					   if (isForeing){
							String foreignTable = column.getReferenceTableName();
							if ("AD_Ref_List".equals(foreignTable)) {
								String idS = resolveForeignList(column,foreignColumn,setValue);
								if(idS == null)	
								   return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{columnName,setValue});
								
								setValue = idS;
							} else {
								int id = resolveForeign(foreignTable, foreignColumn, setValue);
								if(id < 0)	
								   return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{columnName,setValue});
								
								setValue = id;
							}
					   }	   
		           }else{ 
		    	       logMsg = "Key: "+linkColumn+" "+ Msg.getMsg(Env.getCtx(),"NotFound"); 
		    	       break; 
		           }
			    }
				logMsg = gridTab.setValue(linkColumn,setValue);		   
			    if(logMsg.equals(""))
			       logMsg= null;
			    else continue;
		   }
		}
		
		if(logMsg == null && !isThereRow)
		   logMsg ="NO_DATA_TO_IMPORT";
		
		return logMsg;
	}
	
	private CellProcessor getProccesorFromColumn(MColumn column) {
		// TODO: List columns can use RequireSubStr constraint
		if (DisplayType.Date == column.getAD_Reference_ID()) {
			return (new Optional(new ParseDate(DisplayType.DEFAULT_DATE_FORMAT)));
		} else if (DisplayType.DateTime == column.getAD_Reference_ID()) {
			return (new Optional(new ParseDate(DisplayType.DEFAULT_TIMESTAMP_FORMAT)));
		} else if (DisplayType.Time == column.getAD_Reference_ID()) {
			return (new Optional(new ParseDate("DisplayType.DEFAULT_TIME_FORMAT")));
		} else if (DisplayType.Integer == column.getAD_Reference_ID()) {
			return (new Optional(new ParseInt()));
		} else if (DisplayType.isNumeric(column.getAD_Reference_ID())) {
			return (new Optional(new ParseBigDecimal(new DecimalFormatSymbols(Language.getLoginLanguage().getLocale()))));
		} else if (DisplayType.YesNo == column.getAD_Reference_ID()) {
			return (new Optional(new ParseBool("y", "n")));
		} else if (DisplayType.isText(column.getAD_Reference_ID())) {
			return (new Optional(new StrMinMax(1, column.getFieldLength())));
		} else {  // optional lookups and text
			return null;
		}
	}
	
	private String areValidKeysAndColumns(GridTab gridTab, Map<String, Object> map,List<String> header,int startindx,int endindx, PO masterRecord){
		MQuery pquery = new MQuery(gridTab.getAD_Table_ID());
		String logMsg= null;
		Object tmpValue=null;
		String columnwithKey=null;
		Object setValue = null;
		List<String> parentColumns = new ArrayList<String>(); 
		//Process columnKeys + Foreign to add restrictions.
		for (int i = startindx ; i < endindx + 1 ; i++){					  
		    boolean isKeyColumn = header.get(i).indexOf("/") > 0 && header.get(i).endsWith("K");	
			if(isKeyColumn && !header.get(i).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID))){  
			   boolean isForeing = header.get(i).indexOf("[") > 0 && header.get(i).indexOf("]")>0;
			   boolean isDetail  = header.get(i).indexOf(">") > 0;
			   columnwithKey = getColumnName(isKeyColumn,isForeing,isDetail,header.get(i));
			   
			   if(map.get(header.get(i)) instanceof java.util.Date)
				  tmpValue = new Timestamp(((java.util.Date)map.get(header.get(i))).getTime());
			   else 
				  tmpValue = map.get(header.get(i));
				
			   if (tmpValue==null)
				   continue;
			   
			   GridField field = gridTab.getField(columnwithKey);
			   MColumn column  = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
			   if(field.isParentValue()){
				  parentColumns.add(column.getColumnName());
			   }
			   String foreignColumn = null;		   
			   if(isForeing){
				  foreignColumn  = header.get(i).substring(header.get(i).indexOf("[")+1,header.get(i).indexOf("]"));
				  String foreignTable = column.getReferenceTableName();
				  if ("AD_Ref_List".equals(foreignTable)) {
					  String idS = resolveForeignList(column, foreignColumn, tmpValue);
					  setValue = idS;
				  }else {
					  int id = resolveForeign(foreignTable, foreignColumn, tmpValue);
					  setValue = id;
	             }
			   }else{
				   setValue = tmpValue ;
			   }
			   pquery.addRestriction(columnwithKey,MQuery.EQUAL,setValue);
		   }
		}
		
		if (pquery.getRestrictionCount() > 0){
			//check out if parent keys were completed properly 
			if (gridTab.isDetail()){
				for(String linkColumn : gridTab.getParentColumnNames()){
					if(!pquery.getWhereClause().contains(linkColumn)){
						Object value = masterRecord.get_Value(linkColumn);
						//resolve key
						if(value==null){
						   String columnName = null;
				           for(int j = startindx;j<endindx + 1;j++){
				        	   if(header.get(j).contains(linkColumn)){
				        		   columnName = header.get(j);
				        		   value = map.get(header.get(j));
				        		   break;
				        	   }
				           }
				           if(columnName!=null){
				        	   boolean isForeing = columnName.indexOf("[") > 0 && columnName.indexOf("]")>0;
							   columnwithKey     = getColumnName(false,isForeing,true,columnName);
							   MColumn column    = MColumn.get(Env.getCtx(),gridTab.getField(columnwithKey).getAD_Column_ID());
							   String foreignColumn = null;		   
							   if(isForeing){
								  foreignColumn       = columnName.substring(columnName.indexOf("[")+1,columnName.indexOf("]"));
								  String foreignTable = column.getReferenceTableName();
								  if ("AD_Ref_List".equals(foreignTable)) {
									  String idS = resolveForeignList(column,foreignColumn,value);
									  value = idS;
								  }else {
									  int id = resolveForeign(foreignTable,foreignColumn,value);
									  value = id;
					             }
							   }
				           }else{ //mandatory key not found 
				    	       return Msg.getMsg(Env.getCtx(),"FillMandatory")+" "+linkColumn;   
				           }
					    }
						if(value!=null)
						   pquery.addRestriction(linkColumn,MQuery.EQUAL,value);  	
					}
				}	
			}
			gridTab.getTableModel().dataRequery(pquery.getWhereClause(),false,0);
			gridTab.setCurrentRow(0,true);
	    	if (IMPORT_MODE.equals("I")){
				if(gridTab.getTableModel().getRowCount()>=1)
				   logMsg = Msg.getMsg(Env.getCtx(), "AlreadyExists")+" "+pquery;
				else  
				  return null;	
			}
			if (IMPORT_MODE.equals("U")){
				if(gridTab.getTableModel().getRowCount()==1)
				   return null;
				else if(gridTab.getTableModel().getRowCount()<=0)
				   logMsg = Msg.getMsg(Env.getCtx(), "not.found")+" "+pquery; 
				else if(gridTab.getTableModel().getRowCount()>1)
			       logMsg = Msg.getMsg(Env.getCtx(),"TooManyRows")+" "+pquery; 
			}
		    if (IMPORT_MODE.equals("M")){
			   if(gridTab.getTableModel().getRowCount()==1)
				  IMPORT_MODE = "U";
			   else if(gridTab.getTableModel().getRowCount()<=0)
				  IMPORT_MODE = "I";
			   else if(gridTab.getTableModel().getRowCount()>1)
				  logMsg = Msg.getMsg(Env.getCtx(),"TooManyRows")+" "+pquery; 	
		   }
	   }
		
	   return logMsg;
	}
	
	private String resolveForeignList(MColumn column, String foreignColumn, Object value) {
		String idS = null;
		StringBuilder select = new StringBuilder("SELECT Value FROM AD_Ref_List WHERE ")
			.append(foreignColumn).append("=? AND AD_Reference_ID=? AND IsActive='Y'");
		idS = DB.getSQLValueStringEx(null, select.toString(), value, column.getAD_Reference_Value_ID());
		return idS;
	}

	private int resolveForeign(String foreignTable, String foreignColumn, Object value) {
		int id = -1;
		StringBuilder select = new StringBuilder("SELECT ")
			.append(foreignTable).append("_ID FROM ")
			.append(foreignTable).append(" WHERE ")
			.append(foreignColumn).append("=? AND IsActive='Y' AND AD_Client_ID=?");
		id = DB.getSQLValueEx(null, select.toString(), value, Env.getAD_Client_ID(Env.getCtx()));
		if (id == -1 && !"AD_Client".equals(foreignTable)) {
			MTable ft = MTable.get(Env.getCtx(), foreignTable);
			String accessLevel = ft.getAccessLevel();
			if (   MTable.ACCESSLEVEL_All.equals(accessLevel)
				|| MTable.ACCESSLEVEL_SystemOnly.equals(accessLevel)
				|| MTable.ACCESSLEVEL_SystemPlusClient.equals(accessLevel)) {
				// try System client if the table has System access
				id = DB.getSQLValueEx(null, select.toString(), value, 0);
			}
		}
		return id;
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

	@Override
	public String getSuggestedFileName(GridTab gridTab) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dt = sdf.format(cal.getTime());
		String localFile = "Import_" + gridTab.getTableName() + "_" + dt
				+ (m_isError ? "_err" : "_log")
				+ "." + getFileExtension();
		return localFile;
	}
	
    static class ValueComparator implements Comparator<GridTab> {
    	Map<GridTab,Integer> base;
		public ValueComparator(Map<GridTab,Integer> base) {
		    this.base = base;
		}
		// Note: this comparator imposes orderings that are inconsistent with equals.    
		public int compare(GridTab a, GridTab b) {
		    if(base.get(a) >= base.get(b))
		       return 1;
		    else
		       return -1;
		}
    }
}
