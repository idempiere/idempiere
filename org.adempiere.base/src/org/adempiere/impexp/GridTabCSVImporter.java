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

import static org.compiere.model.SystemIDs.REFERENCE_DOCUMENTACTION;
import static org.compiere.model.SystemIDs.REFERENCE_PAYMENTRULE;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;

import org.adempiere.base.IGridTabImporter;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.IProcessUI;
import org.adempiere.util.ProcessUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.MColumn;
import org.compiere.model.MLocation;
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MRefList;
import org.compiere.model.MRefTable;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfo;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.compiere.wf.MWFProcess;
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
	private static final String IMPORT_MODE_MERGE = "M";
	private static final String IMPORT_MODE_UPDATE = "U";
	private static final String IMPORT_MODE_INSERT = "I";
	
	private boolean m_isError = false;
	private String m_import_mode = null;
	private List<String> header;  
    private List<CellProcessor> readProcArray;
    private List<GridField> locationFields;
	private boolean isThereKey;
    private boolean isThereDocAction;
    private Map<GridTab,Integer> tabMapIndexes;
    private List<Map<String, Object>> data;
    private ICsvMapReader mapReader;
    private TreeMap<GridTab,Integer> sortedtTabMapIndexes;
    private List<String> rawData;
    private boolean isMasterok = true; 
	private boolean isDetailok = true;
	private boolean error = false;
	private List<String>  rowsTmpResult;
	private PO masterRecord;
    
    //Files management
	private File errFile;
	private File logFile;
	private PrintWriter errFileW;
	private PrintWriter logFileW;
	
	private CsvPreference csvpref = CsvPreference.STANDARD_PREFERENCE;
	private String delimiter = String.valueOf((char) csvpref.getDelimiterChar());
	private String quoteChar = String.valueOf((char) csvpref.getQuoteChar());
	
	//Trx
	private Trx trx;
	private String trxName;
	private boolean isSingleTrx = false;

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(GridTabCSVImporter.class);
	
	public File fileImport(GridTab gridTab, List<GridTab> childs, InputStream filestream, Charset charset , String importMode) {		
		return fileImport(gridTab, childs, filestream, charset, importMode, null);
	}//fileImport

	@Override
	public File fileImport(GridTab gridTab, List<GridTab> childs, InputStream filestream, Charset charset, String importMode, IProcessUI processUI) {

		if(!gridTab.isInsertRecord() && isInsertMode())
			throwAdempiereException("Insert record disabled for Tab");

		try {
			String errFileName = FileUtil.getTempMailName("Import_" + gridTab.getTableName(), "_err.csv");
			initValues();
			m_import_mode = importMode;
			errFile = new File(errFileName);
			errFileW = new PrintWriter(errFile, charset.name());
			mapReader = new CsvMapReader(new InputStreamReader(filestream, charset), csvpref);
			header =  Arrays.asList(mapReader.getHeader(true));  

			//Mapping header
			int indxDetail = mapCSVHeader(gridTab);

			if(isUpdateOrMergeMode() && !isThereKey)
				throwAdempiereException(gridTab.getTableName()+": "+Msg.getMsg(Env.getCtx(), "NoKeyFound"));

			tabMapIndexes.put(gridTab,indxDetail-1);
			isThereKey = false;
			locationFields = null;

			//Mapping details 
			mapCSVDetail(indxDetail, childs);

			sortedtTabMapIndexes = null;
			if (childs.size()>0 && !tabMapIndexes.isEmpty()){
				ValueComparator bvc =  new ValueComparator(tabMapIndexes);
				sortedtTabMapIndexes = new TreeMap<GridTab,Integer>(bvc);
				sortedtTabMapIndexes.putAll(tabMapIndexes);
			}else{
				Map<GridTab,Integer> localMapIndexes = new HashMap<GridTab,Integer>();
				localMapIndexes.put(gridTab, header.size()-1);
				ValueComparator bvc =  new ValueComparator(localMapIndexes);
				sortedtTabMapIndexes = new TreeMap<GridTab,Integer>(bvc);
				sortedtTabMapIndexes.putAll(localMapIndexes);
			}

			m_isError = false;
			// write the header
			String rawHeader = mapReader.getUntokenizedRow();
			errFileW.write(rawHeader + delimiter + ERROR_HEADER + "\n");
			data = new ArrayList<Map<String, Object>>();
			rawData = new ArrayList<String>();

			// pre-process to check for errors
			preProcess(processUI, gridTab, indxDetail);

			if ( !m_isError ) {

				String logFileName = FileUtil.getTempMailName("Import_" + gridTab.getTableName(), "_log.csv");
				logFile = new File(logFileName);
				logFileW = new PrintWriter(logFile, charset.name());
				// write the header
				logFileW.write(rawHeader + delimiter + LOG_HEADER + "\n");
				// no errors found - process header and then details 
				isMasterok = true; 
				isDetailok = true;
				error = false;
				trx = null;
				trxName = null;
				rowsTmpResult = new ArrayList<String>();

				long lastOutput = new Date().getTime();

				for (int idx = 0; idx < data.size(); idx++) {

					if( processUI != null && new Date().getTime()-lastOutput > 1000 /* one second */){
						processUI.statusUpdate(refreshImportStatus(idx + 1, data.size() + 1));
						lastOutput = new Date().getTime();
					}

					String rawLine = rawData.get(idx);
					StringBuilder rowResult = new StringBuilder();
					boolean isDetail = false;

					if (rawLine.charAt(0)==','){
						isDetail=true;
						//check out if master row comes empty  
						Map<String, Object> rowMap = data.get(idx);
						for(int i=0; i < indxDetail-1; i++){	
							if(rowMap.get(header.get(i))!=null){
								isDetail=false;
								break;
							}
						}
					}

					if (!isMasterok && isDetail){
						rawLine = rawLine + delimiter + quoteChar + Msg.getMsg(Env.getCtx(),"NotProcessed") + quoteChar + "\n";
						rowsTmpResult.add(rawLine);
						continue;		 
					}else if(isMasterok && isDetail && !isDetailok){
						rawLine = rawLine + delimiter + quoteChar + "Record not proccesed due to detail record failure" + quoteChar + "\n";
						rowsTmpResult.add(rawLine);
						continue;	 
					}
					
					if( isSingleTrx() && trx == null )
						createTrx(gridTab);

					if( !isDetail && !isSingleTrx() ){
						manageMasterTrx(gridTab, null);
						createTrx(gridTab);
					}
					if (trx != null)
						trx.setDisplayName(GridTabCSVImporter.class.getName()+"_fileImport_" + gridTab.getTableName());

					String recordResult = processRecord(importMode, gridTab, indxDetail, isDetail, idx, rowResult, childs);
					rowResult.append(recordResult);

					// write
					rawLine = rawLine + delimiter + quoteChar + rowResult.toString().replaceAll(delimiter, "") + quoteChar + "\n";
					rowsTmpResult.add(rawLine);
					
					if( isSingleTrx() && isError() )
						break;

				}

				manageMasterTrx(gridTab,childs);

			}
		} catch (IOException e) {
			throw new AdempiereException(e);
		} catch (Exception ex) {
			throw new AdempiereException(ex);
		} finally {
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

			gridTab.getTableModel().setImportingMode(false,null);
			for (GridTab detail : childs) {
				detail.getTableModel().setImportingMode(false,null);
			}
			gridTab.dataRefreshAll();

		}		
		if (logFile != null)
			return logFile;
		else
			return errFile;
	}//fileImport
	
	private void initValues(){
		mapReader = null;
		errFile = null;
		logFile = null;
		errFileW = null;
		logFileW = null;
		masterRecord = null;
		readProcArray = new ArrayList<CellProcessor>();
		tabMapIndexes = new HashMap<GridTab,Integer>();
		locationFields = null;
		isThereKey = false;
		isThereDocAction = false;
	}
	
	/**
	 * Rollsback the trx and update the text in the file
	 */
	private void rollbackTrx(){
		trx.rollback();
		for( String row : rowsTmpResult ){
			row = row.replaceAll("Updated","RolledBack");
			row = row.replaceAll("Inserted","RolledBack");
			logFileW.write(row);
		}
	}
	
	/**
	 * Commit the trx and writes in the file
	 */
	private String commitTrx(){
		try {
			trx.commit(true);
		} catch (SQLException e) {
			setError(true);
			return e.getLocalizedMessage();
		}
		for( String row : rowsTmpResult )
			logFileW.write(row);
		return null;
	}
	
	/**
	 * Map the header and returns the index where the detail starts
	 * @param gridTab
	 * @return
	 */
	private int mapCSVHeader(GridTab gridTab){
		
		int indxDetail = 0;
		
		for(int idx = 0; idx < header.size(); idx++) {
			String headName = header.get(idx);

			if (headName==null) {
				throwAdempiereException("Header column cannot be empty, Col: " + (idx + 1));
			}

			if (headName.equals(ERROR_HEADER) || headName.equals(LOG_HEADER)){
				header.set(idx, null);
				readProcArray.add(null);
				continue;
			}
			if (headName.indexOf(">") > 0) {
				if(idx==0){
					throwAdempiereException(Msg.getMsg(Env.getCtx(),"WrongHeader", new Object[] {headName}));
				}else if (headName.contains(MTable.getTableName(Env.getCtx(), MLocation.Table_ID)) && locationFields==null){ 
					locationFields = getSpecialMColumn(header,MTable.getTableName(Env.getCtx(), MLocation.Table_ID),idx);
					for(GridField sField:locationFields){
						readProcArray.add(getProccesorFromColumn(sField)); 
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
					throwAdempiereException(Msg.getMsg(Env.getCtx(), "FieldNotFound" , new Object[] {columnName}) );
				else if(isKeyColumn && !isThereKey)
					isThereKey =true;
				else if (!isThereDocAction &&
						MColumn.get(Env.getCtx(),field.getAD_Column_ID()).getAD_Reference_Value_ID() == REFERENCE_DOCUMENTACTION )
					isThereDocAction= true;

				readProcArray.add(getProccesorFromColumn(field)); 
				indxDetail++;
			}
		}
		
		return indxDetail;
	}//mapFileHeader
	
	/**
	 * Map details fields in the csv file
	 * @param indxDetail
	 */
	private void mapCSVDetail(int indxDetail, List<GridTab> childs){

		String  childTableName = null;
		GridTab currentDetailTab = null;

		for(int idx = indxDetail; idx < header.size(); idx++) {	
			String detailName = header.get(idx);
			if(detailName!=null && detailName.indexOf(">") > 0){
				childTableName = detailName.substring(0,detailName.indexOf(">"));  
				if (currentDetailTab==null || 
						(currentDetailTab!=null && !childTableName.equals(currentDetailTab.getTableName()))){

					if(currentDetailTab!=null){ 
						//check out key per Tab   
						if(isUpdateOrMergeMode() && !isThereKey){
							throwAdempiereException(currentDetailTab.getTableName()+": "+Msg.getMsg(Env.getCtx(), "NoKeyFound"));
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
					throwAdempiereException(Msg.getMsg(Env.getCtx(),"NoChildTab",new Object[] {childTableName}));

				String columnName = detailName;
				if (columnName.contains(MTable.getTableName(Env.getCtx(), MLocation.Table_ID)) && locationFields==null){
					locationFields = getSpecialMColumn(header,MTable.getTableName(Env.getCtx(), MLocation.Table_ID),idx);
					for(GridField sField:locationFields){
						readProcArray.add(getProccesorFromColumn(sField)); 
						idx++;
					}
					idx--;
				}else{
					boolean isKeyColumn= columnName.indexOf("/") > 0;
					boolean isForeing  = columnName.indexOf("[") > 0 && columnName.indexOf("]")>0;
					columnName = getColumnName(isKeyColumn,isForeing,true,columnName);
					GridField field = currentDetailTab.getField(columnName);

					if(field == null)
						throwAdempiereException(Msg.getMsg(Env.getCtx(), "FieldNotFound",new Object[] {detailName}));
					else if(isKeyColumn && !isThereKey)
						isThereKey =true;

					readProcArray.add(getProccesorFromColumn(field));  
				}				   
			}else
				throwAdempiereException(Msg.getMsg(Env.getCtx(),"WrongDetailName",new Object[] {" col("+idx+") ",detailName}));

		}
		if(currentDetailTab!=null){
			if(isUpdateOrMergeMode() && !isThereKey)
				throwAdempiereException(currentDetailTab.getTableName()+": "+Msg.getMsg(Env.getCtx(), "NoKeyFound"));

			tabMapIndexes.put(currentDetailTab,header.size()-1); 	   
		}

	}//mapFileDetail
	
	/**
	 * Pre process te file lookign for errors
	 * @param processUI
	 * @param gridTab
	 * @param indxDetail
	 */
	private void preProcess(IProcessUI processUI, GridTab gridTab, int indxDetail){

		CellProcessor[] processors = readProcArray.toArray(new CellProcessor[readProcArray.size()]);	
		long lastOutput = new Date().getTime();

		while (true) {
			if( processUI != null && new Date().getTime()-lastOutput > 1000 /* one second */){
				processUI.statusUpdate(refreshImportStatus(data.size(), 0));
				lastOutput = new Date().getTime();
			}

			Map<String, Object> map = null;
			boolean isLineError = false; 
			StringBuilder errMsg = new StringBuilder();

			try {			
				// devCoffee #6141 - IDEMPIERE-3832
				String[] hdrs = new String[header.size()];
				header.toArray(hdrs);
				map = mapReader.read( hdrs, processors);
			} catch (SuperCsvCellProcessorException e) {
				int idx = e.getCsvContext().getColumnNumber() - 1;
				errMsg.append(header.get(idx)).append(": ").append(e.getMessage());
				isLineError = true;
			} catch (IOException e) {
				throw new AdempiereException(e);
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
	}//preProcess
	
	/**
	 * Manage the trx
	 * if the trx exists - commits when no errors, rollback when errors.
	 * @param gridTab
	 * @param childs
	 */
	private void manageMasterTrx(GridTab gridTab, List<GridTab> childs){
		if (trx != null) {
			try {
				if (isError()) {
					gridTab.dataDelete();
					rollbackTrx();
					setError(false);
				} else {
					boolean commit = false;
					if (isThereDocAction) {
	
						boolean isError = false;
						int AD_Process_ID = MColumn.get(Env.getCtx(), gridTab.getField("DocAction").getAD_Column_ID()).getAD_Process_ID(); 
	
						if (AD_Process_ID > 0){
							String docResult = processDocAction(masterRecord, AD_Process_ID); 
	
							if (docResult.contains("error")) 
								isError = true; 
	
							rowsTmpResult.set(0,rowsTmpResult.get(0).replace(quoteChar + "\n",docResult + quoteChar + "\n")); 
						} else {
							throwAdempiereException("No Process found for document action.");	  
						}
	
						if (isError){
							gridTab.dataDelete();
							rollbackTrx();
						} else {
							commit = true;
						}
					} else {
						commit = true;
					}
					if (commit) {
						String commitResult = commitTrx();
						if (isError()) {
							rowsTmpResult.set(0,rowsTmpResult.get(0).replace(quoteChar + "\n",commitResult + quoteChar + "\n")); 
							gridTab.dataDelete();
							rollbackTrx();
						}
					}
				}
			} finally {
				trx.close();
				trx=null;
			}
		}

	}//manageMasterTrx
	
	/**
	 * Create a new Trx with a random Name
	 * @param gridTab
	 */
	private void createTrx(GridTab gridTab){
		trxName = Trx.createTrxName("CSVImport");
		gridTab.getTableModel().setImportingMode(true,trxName);	
		trx = Trx.get(trxName,true);
		masterRecord = null;
		rowsTmpResult.clear();
		isMasterok = true;
		isDetailok = true;
		
	} //createTrx
	
	/**
	 * Process the record for each row
	 * First insert the master tab - if no errors found proceeds with the details tabs when existing
	 * Stops at the first error found in the row
	 * @param importMode
	 * @param gridTab
	 * @param indxDetail
	 * @param isDetail
	 * @param idx
	 * @param rowResult
	 * @return
	 */
	private String processRecord(String importMode, GridTab gridTab, int indxDetail, boolean isDetail, int idx, StringBuilder rowResult, List<GridTab> childs){
		
		String logMsg = null;
		GridTab currentGridTab = null;
		int currentColumn = 0;

		try {

			for( Map.Entry<GridTab, Integer> tabIndex : sortedtTabMapIndexes.entrySet() ) {

				currentGridTab = tabIndex.getKey(); 			

				if( isDetail && gridTab.equals(currentGridTab) ){
					currentColumn = indxDetail;
					continue;			
				}

				//Assign master trx to its children
				if( !gridTab.equals(currentGridTab) ){
					currentGridTab.getTableModel().setImportingMode(true,trxName);	
					isDetail=true;
				}

				int j = tabIndex.getValue();	
				logMsg = areValidKeysAndColumns(currentGridTab,data.get(idx),header,currentColumn,j,masterRecord,trx);

				if (logMsg == null){

					if ( isInsertMode() ){
						if( !currentGridTab.getTableModel().isOpen() )
							currentGridTab.getTableModel().open(0);
						//how to read from status since the warning is coming empty ?
						if ( !currentGridTab.dataNew(false) ){
							logMsg = "["+currentGridTab.getName()+"]"+"- Was not able to create a new record!";
						}else{
							currentGridTab.navigateCurrent();
							if (! isDetail) {
								for (GridTab child : childs) {
									child.query(false);
								}
							}
						}
					} 

					if( logMsg==null )
						logMsg = proccessRow(currentGridTab,header,data.get(idx),currentColumn,j,masterRecord,trx);

					currentColumn = j + 1;
					if( !(logMsg == null) ){
						m_import_mode = importMode;   
						//Ignore row since there is no data 
						if("NO_DATA_TO_IMPORT".equals(logMsg)){
							logMsg = "";
							continue;
						}else 
							setError(true);
					}

				}else {
					setError(true);
					currentColumn = j + 1;
				}

				if ( !isError() ) {
					if ( currentGridTab.dataSave(false) ){						
						PO po = currentGridTab.getTableModel().getPO(currentGridTab.getCurrentRow());		
						//Keep master record for details validation 
						if(currentGridTab.equals(gridTab))
							masterRecord = po;

						if( isInsertMode() ) {
							logMsg = Msg.getMsg(Env.getCtx(), "Inserted") + " " + po.toString();
							if (!Util.isEmpty(currentGridTab.getKeyColumnName()) && currentGridTab.getKeyColumnName().endsWith("_ID")) {
								int recordId = currentGridTab.getRecord_ID();
								if (recordId > 0) {
									if (currentGridTab.getTabNo() == 0)
										Env.setContext(Env.getCtx(), currentGridTab.getWindowNo(), currentGridTab.getKeyColumnName(), recordId);
									Env.setContext(Env.getCtx(), currentGridTab.getWindowNo(), currentGridTab.getTabNo(), currentGridTab.getKeyColumnName(), Integer.toString(recordId));
								}
							}
						} else {
							logMsg = Msg.getMsg(Env.getCtx(), "Updated") + " " + po.toString(); 
							if( currentGridTab.equals(gridTab) && sortedtTabMapIndexes.size()>1 )
								currentGridTab.dataRefresh(true); 
						}
					} else {
						ValueNamePair ppE = CLogger.retrieveWarning();
						if (ppE==null)   
							ppE = CLogger.retrieveError();

						String info = null;

						if ( ppE != null )
							info = ppE.getName();
						if ( info == null )
							info = "";

						logMsg = Msg.getMsg(Env.getCtx(), "Error") + " " + Msg.getMsg(Env.getCtx(), "SaveError") + " (" + info + ")";
						currentGridTab.dataIgnore();

						//Problem in the master record
						if( currentGridTab.equals(gridTab) && masterRecord == null ){
							isMasterok = false;
							rowResult.append( "<" + currentGridTab.getTableName() + ">: " );
							rowResult.append(logMsg);
							rowResult.append(" / ");
							break;
						}

						//Problem in the detail record
						if( !currentGridTab.equals(gridTab) && masterRecord != null ){
							isDetailok = false;
							rowResult.append( "<" + currentGridTab.getTableName() + ">: " );
							rowResult.append(logMsg);
							rowResult.append(" / ");
							break;
						}
					}
					
					rowResult.append( "<" + currentGridTab.getTableName() + ">: " );
					rowResult.append(logMsg);
					rowResult.append(" / ");

				} else { //if error true
					currentGridTab.dataIgnore();

					rowResult.append( "<" + currentGridTab.getTableName() + ">: " );
					rowResult.append(logMsg);
					rowResult.append(" / ");

					//Master Failed, thus details cannot be imported 
					if( currentGridTab.equals(gridTab) && masterRecord == null ){
						isMasterok = false;
						break;
					}
					
					//Detail failed
					if( !currentGridTab.equals(gridTab) && masterRecord != null ){
						isDetailok = false;
						break;
					}
				}	
				m_import_mode = importMode;	
			}
		} catch (Exception e) {

			rowResult.append( "<" + currentGridTab.getTableName() + ">: " );
			rowResult.append(Msg.getMsg(Env.getCtx(), "Error") + " " + e);
			rowResult.append(" / ");
			currentGridTab.dataIgnore();

			setError(true);

			//Master Failed, thus details cannot be imported 
			if( currentGridTab.equals(gridTab) && masterRecord == null )
				isMasterok = false;

			if( !currentGridTab.equals(gridTab) && masterRecord != null )
				isDetailok = false;

		} finally {
			m_import_mode = importMode;
		}
		
		return rowResult.toString();

	}//processRecord
	
	private void throwAdempiereException(String msg){
	    throw new AdempiereException(msg);
	}
	
	private String refreshImportStatus(int currentRecord, int total){
		int percent = currentRecord * 100;
		if (total > 0)
			percent = percent / total;
		else
			percent = 0;
		
		if( percent == 0 ){
			Object[] args = new Object[] {currentRecord};
			return Msg.getMsg(Env.getCtx(), "PreProcessingCVSProgress", args);
		}else{
			Object[] args = new Object[] {currentRecord, total, percent};
			return Msg.getMsg(Env.getCtx(), "PercentProcessingProgress", args);
		}
	}

	private String processDocAction(PO document, int AD_Process_ID){
		int AD_Workflow_ID = MProcess.get(Env.getCtx(),AD_Process_ID).getAD_Workflow_ID();  
		
		if (AD_Workflow_ID > 0){
			ProcessInfo wfProcess = new ProcessInfo (document.get_TrxName(),AD_Process_ID,document.get_Table_ID(),document.get_ID());
			wfProcess.setTransactionName(document.get_TrxName());  
			MWFProcess wdPro = ProcessUtil.startWorkFlow(Env.getCtx(),wfProcess, AD_Workflow_ID);
			if(wdPro == null) 
			   return "Document action could not be proccesed"; 
			else if (wfProcess.isError())
			   return "Document action error: "+wfProcess.getSummary();
			else  	
			   return "Document action processed ["+wfProcess.getSummary()+"]";
		}else {
		   return "No workflow was found";	
		}
	}
	
	private boolean isInsertMode() {
		return IMPORT_MODE_INSERT.equals(m_import_mode);
	}
	
	private boolean isUpdateMode() {
		return IMPORT_MODE_UPDATE.equals(m_import_mode);
	}

	private boolean isMergeMode() {
		return IMPORT_MODE_MERGE.equals(m_import_mode);
	}

	private boolean isUpdateOrMergeMode() {
		return isUpdateMode() || isMergeMode();
	}

	private String getColumnName(boolean isKey ,boolean isForeing ,boolean isDetail , String headName){		
		
		if(isKey){
		   if(headName.indexOf("/") > 0){
			  if(headName.endsWith("K"))
				  headName = headName.substring(0,headName.length()-2);
			  else if (headName.endsWith("KT")){
				  setSingleTrx(true);
				  headName = headName.substring(0,headName.length()-3);
			  }
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
			if (!"C_Location".equals(gridTab.getTableName()))
			{
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
			
			if (!(field.isDisplayed() || field.isDisplayedGrid())) 
				return new StringBuilder(Msg.getMsg(Env.getCtx(), "FieldNotDisplayed",new Object[] {header.get(i)}));
			
			MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
			boolean isWrongValueForMandatory = false;
			if (field.isMandatory(false) || column.isMandatory()){
				if (isInsertMode() && value == null && field.getDefault()==null){
					isWrongValueForMandatory = true;
				}else if (!isInsertMode() && "(null)".equals(value)){
					isWrongValueForMandatory = true;
				}
			}
			
			if(isWrongValueForMandatory){ 
				mandatoryColumns.append(" / ");
				mandatoryColumns.append(header.get(i));
			} 
			
			if (isForeing && value != null && !"(null)".equals(value)){
				String foreignTable = column.getReferenceTableName();
				String idS = null;
				int id = -1;
				if("AD_Ref_List".equals(foreignTable))
				   idS= resolveForeignList(column,foreignColumn,value,null);
				else 
				   id = resolveForeign(foreignTable,foreignColumn,value,field,null);
				
				if(idS == null && id < 0){	
				   //it could be that record still doesn't exist if import mode is inserting or merging   	
				   if(isUpdateMode())
				     return new StringBuilder(Msg.getMsg(Env.getCtx(),id==-2?"ForeignMultipleResolved":"ForeignNotResolved",new Object[]{header.get(i),value}));
				}
			} else {
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
	    
	   if(!(field.isDisplayed() || field.isDisplayedGrid())) 
		  return new StringBuilder(Msg.getMsg(Env.getCtx(), "FieldNotDisplayed",new Object[] {field.getColumnName()}));
	   
	   if (header.get(i).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID)))
	   {
		   //without Country any address would be invalid 
		   boolean thereIsCountry = false ;
		   boolean isEmptyRow = true;
		   for(int j= i;j< header.size();j++){
			   if(!header.get(j).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID)))
			       break;
			    //validate if location contains its parent table 
				if(!header.get(j).contains(gridTab.getTableName()))
				    return new StringBuilder().append("Invalid location column's name, it must contain its parent table: ")
				    		   .append(gridTab.getTableName().toString())
				    		   .append("[").append(header.get(j)).append("]");
				
			   String columnName = header.get(j);	
			   Object value = tmpRow.get(j);   
			   if(value!=null){ 
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
			      int id = resolveForeign(foreignTable,foreignColumn,value,field,null);
				  if (id < 0)
					  return new StringBuilder(Msg.getMsg(Env.getCtx(), id==-2?"ForeignMultipleResolved":"ForeignNotResolved" ,new Object[]{header.get(j),value}));   
			   }	   
			   isEmptyRow=false;
	      }	   
		  MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());		
		  if((field.isMandatory(true) || column.isMandatory()) && !isEmptyRow && !thereIsCountry) 
			  return new StringBuilder(Msg.getMsg(Env.getCtx(), "FillMandatory")+" "+field.getColumnName()+"["+"C_Country_ID]");
	   }
	   return null;
	}	
	
	private String proccessRow(GridTab gridTab,List<String> header, Map<String, Object> map,int startindx,int endindx,PO masterRecord,Trx trx){
		
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
				
			if (columnName.endsWith("_ID") && "0".equals(value) && ! MTable.isZeroIDTable(gridTab.getTableName()))
			   continue;
				
			boolean isKeyColumn= columnName.indexOf("/") > 0;
			boolean isForeing  = columnName.indexOf("[") > 0 && columnName.indexOf("]")>0;
			isDetail   = columnName.indexOf(">") > 0;
			columnName = getColumnName(isKeyColumn,isForeing,isDetail,columnName);
			String foreignColumn = null;
			Object setValue = null;
			
			if(isForeing) 
			   foreignColumn = header.get(i).substring(header.get(i).indexOf("[")+1,header.get(i).indexOf("]"));
			if(!isForeing && !isKeyColumn && ("AD_Language".equals(columnName) || "EntityType".equals(columnName))) {
				setValue = value;
				GridField field = gridTab.getField(columnName);
			    logMsg = gridTab.setValue(field,setValue);
			    if(logMsg!=null && logMsg.equals(""))
			    	logMsg= null;
			}else if(!"C_Location".equals(gridTab.getTableName()) && header.get(i).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID))){
		    
				if(address == null){
				    if(isInsertMode()){
					   address = new MLocation (Env.getCtx(),0,trx.getTrxName());	   
				    }else{
				       Object location = gridTab.getValue("C_Location_ID")==null?0:gridTab.getValue("C_Location_ID").toString();
					   int C_Location_ID = Integer.parseInt(location.toString());  
					   address =  new MLocation (Env.getCtx(),C_Location_ID,trx.getTrxName());	
				    }
				}
				GridField field = gridTab.getField(columnName);
				if(!"(null)".equals(value.toString().trim())){
				   if(isForeing) {
					  String foreignTable = columnName.substring(0,columnName.length()-3);
					  setValue = resolveForeign(foreignTable,foreignColumn,value,field,trx);
					  if("C_City".equals(foreignTable))
						 address.setCity(value.toString());  
					}else
					  setValue = value;			
				}
				address.set_ValueOfColumn(columnName,setValue);
			}else{
				if(isKeyColumn && isUpdateMode())
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
					}else if(isForeing && masterRecord==null && gridTab.getTabLevel()>0){
						Object master =gridTab.getParentTab().getValue(foreignColumn);
						if (master!=null && value!=null && !master.toString().equals(value)){
							logMsg = header.get(i)+" - "+Msg.getMsg(Env.getCtx(),"DiffParentValue", new Object[] {master.toString(),value});
							break;
						}			
					}else if (masterRecord==null && isDetail){
						MColumn column = MColumn.get(Env.getCtx(),field.getAD_Column_ID());
						String foreignTable = column.getReferenceTableName();
						String idS = null;
						int id = -1;
						
						if ("AD_Ref_List".equals(foreignTable)) 
							idS= resolveForeignList(column, foreignColumn, value,trx);
						else 
							id = resolveForeign(foreignTable,foreignColumn,value, field, trx);
						
						if(idS == null && id < 0)	
						   return Msg.getMsg(Env.getCtx(),id==-2?"ForeignMultipleResolved":"ForeignNotResolved",new Object[]{header.get(i),value});
						
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
							String idS = resolveForeignList(column, foreignColumn, value,trx);
							if(idS == null)	
							   return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{header.get(i),value});
							
							setValue = idS;
							isThereRow =true;
						} else {
							
							int id = resolveForeign(foreignTable, foreignColumn, value,field,trx);
							if(id < 0)	
								return Msg.getMsg(Env.getCtx(),id==-2?"ForeignMultipleResolved":"ForeignNotResolved",new Object[]{header.get(i),value});

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
							
						  if(DisplayType.Payment == field.getDisplayType()){
   							 String oldValue = value.toString(); 
							 for(ValueNamePair pList: MRefList.getList(Env.getCtx(),REFERENCE_PAYMENTRULE,false)){
								 if(pList.getName().equals(oldValue.toString())){
									oldValue = pList.getValue(); 
									break;
								 }
							 }
							 if(!value.toString().equals(oldValue)) 
							     value = oldValue;
							 else
								 return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{header.get(i),value}); 
						  }else if(DisplayType.Button == field.getDisplayType()){
							 if(column.getAD_Reference_Value_ID()== REFERENCE_DOCUMENTACTION){
								String oldValue = value.toString(); 
							    for(ValueNamePair pList: MRefList.getList(Env.getCtx(),REFERENCE_DOCUMENTACTION,false)){
								    if(pList.getName().equals(oldValue.toString())){
									   oldValue = pList.getValue(); 
									   break;
									}
								}
								if(!value.toString().equals(oldValue)) 
									value = oldValue;
							    else
								    return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{header.get(i),value});  
							 }else{
								 return Msg.getMsg(Env.getCtx(),"Invalid") + " Column ["+column.getColumnName()+"]";   
							 } 
						  }  else if (DisplayType.isNumeric(field.getDisplayType()) || DisplayType.isID(field.getDisplayType())) {
							  if (columnName.endsWith("_ID")) {
								  if (!(value instanceof Integer)) {
									  Integer idValue = Integer.valueOf(value.toString());
									  value = idValue;
								  }
							  } else if (!(value instanceof BigDecimal)) {
								  BigDecimal decValue = new BigDecimal(value.toString());
								  value = decValue;
							  }
						  }
						  setValue = value;
						  isThereRow =true;
					   }
				   }
									   
				   if(setValue != null) {
					  Object oldValue = gridTab.getValue(field);
					  if (isValueChanged(oldValue, setValue)) {
						  if (!field.isEditable(true)) {
							  return Msg.getMsg(Env.getCtx(), "FieldIsReadOnly",new Object[] {header.get(i)});
						  }
						  logMsg = gridTab.setValue(field,setValue);
					  } else {
						  logMsg = "";
					  }
				   }
				   
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
				logMsg = gridTab.setValue("C_Location_ID",address.getC_Location_ID());
				if(logMsg.equals(""))
				   logMsg= null;
				else 
				   return logMsg;
				
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
					   GridField field = gridTab.getField(columnName);
					   MColumn column = MColumn.get(Env.getCtx(),field.getAD_Column_ID());
					   if (isForeing){
							String foreignTable = column.getReferenceTableName();
							if ("AD_Ref_List".equals(foreignTable)) {
								String idS = resolveForeignList(column,foreignColumn,setValue,trx);
								if(idS == null)	
								   return Msg.getMsg(Env.getCtx(),"ForeignNotResolved",new Object[]{columnName,setValue});
								
								setValue = idS;
							} else {
								int id = resolveForeign(foreignTable, foreignColumn, setValue, field, trx);
								if (id < 0)
								   return Msg.getMsg(Env.getCtx(),id==-2?"ForeignMultipleResolved":"ForeignNotResolved",new Object[]{columnName,setValue});
								
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
	
	private CellProcessor getProccesorFromColumn(GridField field) {
		// TODO: List columns can use RequireSubStr constraint
		if (DisplayType.Date == field.getDisplayType()) {
			return (new Optional(new ParseDate(DisplayType.DEFAULT_DATE_FORMAT)));
		} else if (DisplayType.DateTime == field.getDisplayType()) {
			return (new Optional(new ParseDate(DisplayType.DEFAULT_TIMESTAMP_FORMAT)));
		} else if (DisplayType.Time == field.getDisplayType()) {
			return (new Optional(new ParseDate(DisplayType.DEFAULT_TIME_FORMAT)));
		} else if (DisplayType.Integer == field.getDisplayType()) {
			return (new Optional(new ParseInt()));
		} else if (DisplayType.isNumeric(field.getDisplayType())) {
			return (new Optional(new ParseBigDecimal(new DecimalFormatSymbols(Language.getLoginLanguage().getLocale()))));
		} else if (DisplayType.YesNo == field.getDisplayType()) {
			return (new Optional(new ParseBool("y", "n")));
		} else if (DisplayType.TextLong == field.getDisplayType()) {
			return (new Optional(new StrMinMax(1, Long.MAX_VALUE)));
		} else if (DisplayType.isText(field.getDisplayType())) {
			return (new Optional(new StrMinMax(1, field.getFieldLength())));
		} else {  // optional lookups and text
			return null;
		}
	}
	
	private String areValidKeysAndColumns(GridTab gridTab, Map<String, Object> map,List<String> header,int startindx,int endindx,PO masterRecord,Trx trx){
		MQuery pquery = new MQuery(gridTab.getAD_Table_ID());
		String logMsg= null;
		Object tmpValue=null;
		String columnwithKey=null;
		Object setValue = null;
		List<String> parentColumns = new ArrayList<String>(); 
		//Process columnKeys + Foreign to add restrictions.
		for (int i = startindx ; i < endindx + 1 ; i++){					  
		    boolean isKeyColumn = header.get(i).indexOf("/") > 0 && ( header.get(i).endsWith("K") || header.get(i).endsWith("KT"));	
		    if(isKeyColumn && ("C_Location".equals(gridTab.getTableName()) || !header.get(i).contains(MTable.getTableName(Env.getCtx(),MLocation.Table_ID)))){  
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
					  String idS = resolveForeignList(column, foreignColumn, tmpValue,trx);
					  setValue = idS;
				  }else {
					  int id = resolveForeign(foreignTable, foreignColumn, tmpValue,field,trx);
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
						Object value = masterRecord!=null?masterRecord.get_Value(linkColumn):null;
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
							   GridField field = gridTab.getField(columnwithKey);
							   MColumn column    = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
							   String foreignColumn = null;		   
							   if(isForeing){
								  foreignColumn       = columnName.substring(columnName.indexOf("[")+1,columnName.indexOf("]"));
								  String foreignTable = column.getReferenceTableName();
								  if ("AD_Ref_List".equals(foreignTable)) {
									  String idS = resolveForeignList(column,foreignColumn,value,trx);
									  value = idS;
								  }else {
									  int id = resolveForeign(foreignTable,foreignColumn,value,field,trx);
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
			gridTab.getTableModel().dataRequery(pquery.getWhereClause(), false, 0, false);
	    	if (isInsertMode()){
				if(gridTab.getTableModel().getRowCount()>=1)
				   logMsg = Msg.getMsg(Env.getCtx(), "AlreadyExists")+" "+pquery;
				else  
				  return null;	
			}
			if (isUpdateMode()){
				if(gridTab.getTableModel().getRowCount()==1){
			       gridTab.navigateCurrent();
				   return null;
				}
				else if(gridTab.getTableModel().getRowCount()<=0)
				   logMsg = Msg.getMsg(Env.getCtx(), "not.found")+" "+pquery; 
				else if(gridTab.getTableModel().getRowCount()>1)
			       logMsg = Msg.getMsg(Env.getCtx(),"TooManyRows")+" "+pquery; 
			}
		    if (isMergeMode()){
			   if(gridTab.getTableModel().getRowCount()==1){
			      gridTab.navigateCurrent();
				  m_import_mode = IMPORT_MODE_UPDATE;
			   }else if(gridTab.getTableModel().getRowCount()<=0)
				  m_import_mode = IMPORT_MODE_INSERT;
			   else if(gridTab.getTableModel().getRowCount()>1)
				  logMsg = Msg.getMsg(Env.getCtx(),"TooManyRows")+" "+pquery; 	
		   }
	   }
		
	   return logMsg;
	}
	
	private String resolveForeignList(MColumn column, String foreignColumn, Object value ,Trx trx) {
		String idS = null;
		String trxName = (trx!=null?trx.getTrxName():null); 
		StringBuilder select = new StringBuilder("SELECT Value FROM AD_Ref_List WHERE ")
			.append(foreignColumn).append("=? AND AD_Reference_ID=? AND IsActive='Y'");
		idS = DB.getSQLValueStringEx(trxName, select.toString(), value, column.getAD_Reference_Value_ID());
		return idS;
	}

	private int resolveForeign(String foreignTable, String foreignColumn, Object value, GridField field, Trx trx) {
		boolean systemAccess = false;
		if (!"AD_Client".equals(foreignTable)) {
			MTable ft = MTable.get(Env.getCtx(), foreignTable);
			String accessLevel = ft.getAccessLevel();
			if (   MTable.ACCESSLEVEL_All.equals(accessLevel)
				|| MTable.ACCESSLEVEL_SystemOnly.equals(accessLevel)
				|| MTable.ACCESSLEVEL_SystemPlusClient.equals(accessLevel)) {
				systemAccess = true;
			}
		}
		int thisClientId = Env.getAD_Client_ID(Env.getCtx());

		String trxName = (trx!=null?trx.getTrxName():null); 

		StringBuilder postSelect = new StringBuilder(" FROM ")
			.append(foreignTable).append(" WHERE ")
			.append(foreignColumn).append("=? AND IsActive='Y' AND AD_Client_ID=?");
	  if (field != null ) {
		if (!Util.isEmpty(field.getVO().ValidationCode)) {
			String dynamicValid = Env.parseContext(Env.getCtx(), field.getWindowNo(), field.getGridTab().getTabNo(), field.getVO().ValidationCode, false);
			if (Util.isEmpty(dynamicValid)) {
				return 0;// it's parse error but simple consider like ForeignNotResolved
			}else {
				postSelect.append(" AND (").append(dynamicValid).append(")");
			}
		}
		int ref = field.getVO().displayType;
		int refval = field.getVO().AD_Reference_Value_ID;
		if (refval > 0 && (ref == DisplayType.Table || ref == DisplayType.Search)) {
			final MRefTable refTable = new Query(Env.getCtx(), MRefTable.Table_Name, "AD_Reference_ID=?", trxName)
					.setParameters(refval)
					.firstOnly();
			String whereClause = refTable.getWhereClause();
			if (!Util.isEmpty(whereClause)) {
				String dynamicValid = Env.parseContext(Env.getCtx(), field.getWindowNo(), field.getGridTab().getTabNo(), whereClause, false);
				if (Util.isEmpty(dynamicValid)) {
					return 0;// it's parse error but simple consider like ForeignNotResolved
				}else {
					postSelect.append(" AND (").append(dynamicValid).append(")");
				}
			}
		}
	  }
		StringBuilder selectCount = new StringBuilder("SELECT COUNT(*)").append(postSelect);
		StringBuilder selectId = new StringBuilder("SELECT ").append(foreignTable).append("_ID").append(postSelect);
		int count = DB.getSQLValueEx(trxName, selectCount.toString(), value, thisClientId);
		if (count == 1) { // single value found, OK
			return DB.getSQLValueEx(trxName, selectId.toString(), value, thisClientId);
		} else if (count > 1) { // multiple values found, error ForeignMultipleResolved
			return -2;
		} else if (count == 0) { // no values found, error ForeignNotResolved
			if (systemAccess && thisClientId != 0) {
				// not found in client, try with System
				count = DB.getSQLValueEx(trxName, selectCount.toString(), value, 0 /* System */);
				if (count == 1) { // single value found, OK
					return DB.getSQLValueEx(trxName, selectId.toString(), value,  0 /* System */);
				} else if (count > 1) { // multiple values found, error ForeignMultipleResolved
					return -2;
				}
			}
		}
		return -3;   // no values found, error ForeignNotResolved
	}

	//Copy from GridTable
	@SuppressWarnings("unchecked")
	private boolean	isValueChanged(Object oldValue, Object value)
	{
		if ( isNotNullAndIsEmpty(oldValue) ) {
			oldValue = null;
		}

		if ( isNotNullAndIsEmpty(value) ) {
			value = null;
		}

		boolean bChanged = (oldValue == null && value != null) 
							|| (oldValue != null && value == null);

		if (!bChanged && oldValue != null)
		{
			if (oldValue.getClass().equals(value.getClass()))
			{
				if (oldValue instanceof Comparable<?>)
				{
					bChanged = (((Comparable<Object>)oldValue).compareTo(value) != 0);
				}
				else
				{
					bChanged = !oldValue.equals(value);
				}
			}
			else if(value != null)
			{
				bChanged = !(oldValue.toString().equals(value.toString()));
			}
		}
		return bChanged;	
	}
	
	//Copy from GridTable
	private boolean isNotNullAndIsEmpty (Object value) {
		if (value != null 
				&& (value instanceof String) 
				&& value.toString().equals("")
			) 
		{
			return true;
		} else {
			return false;
		}

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
	
    public boolean isError() {
		return error;
	}

	public boolean isSingleTrx() {
		return isSingleTrx;
	}

	public void setSingleTrx(boolean isSingleTrx) {
		this.isSingleTrx = isSingleTrx;
	}

	public void setError(boolean error) {
		this.error = error;
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
