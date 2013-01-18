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
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import org.adempiere.base.IGridTabImporter;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MColumn;
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
import org.supercsv.cellprocessor.constraint.StrNotNullOrEmpty;
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
		boolean isThereKey = false;
		try {
			String errFileName = FileUtil.getTempMailName("Import_" + gridTab.getTableName(), "_err.csv");
			errFile = new File(errFileName);
			errFileW = new PrintWriter(errFile, charset.name());
			mapReader = new CsvMapReader(new InputStreamReader(filestream, charset), csvpref);

			String[] header = mapReader.getHeader(true);
			List<CellProcessor> readProcArray = new ArrayList<CellProcessor>();
			for (int idx = 0; idx < header.length; idx++) {
				String headName = header[idx];
				if (headName.equals(ERROR_HEADER) || headName.equals(LOG_HEADER)) {
					header[idx] = null;
					readProcArray.add(null);
					continue;
				}
				String columnName = headName;
				boolean isKeyColumn = false;
				if ( columnName.indexOf("/") > 0 ){
					if(columnName.endsWith("K")){
					   isKeyColumn =true;
					   columnName = headName.substring(0,headName.length()-2);  
					}else{
					   throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ColumnKey", new Object[] {columnName}));
					}
				} 			
				
				boolean isForeign = columnName.indexOf("[") > 0 && columnName.endsWith("]");
				if (isForeign) {
					int end = columnName.indexOf("[");
					columnName = columnName.substring(0, end);
				}
				
				GridField field = gridTab.getField(columnName);
				if (field == null) {
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FieldNotFound", new Object[] {columnName}));
				}else if(isKeyColumn && !isThereKey){
					isThereKey =true;
				}
				MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
				// TODO: List columns can use RequireSubStr constraint
				if (column.isMandatory()) {
					if (DisplayType.Date == column.getAD_Reference_ID()) {
						readProcArray.add(new ParseDate(DisplayType.DEFAULT_DATE_FORMAT));
					} else if (DisplayType.DateTime == column.getAD_Reference_ID()) {
						readProcArray.add(new ParseDate(DisplayType.DEFAULT_TIMESTAMP_FORMAT));
					} else if (DisplayType.Time == column.getAD_Reference_ID()) {
						readProcArray.add(new ParseDate("DisplayType.DEFAULT_TIME_FORMAT"));
					} else if (DisplayType.Integer == column.getAD_Reference_ID()) {
						readProcArray.add(new ParseInt());
					} else if (DisplayType.isNumeric(column.getAD_Reference_ID())) {
						readProcArray.add(new ParseBigDecimal(new DecimalFormatSymbols(Language.getLoginLanguage().getLocale())));
					} else if (DisplayType.YesNo == column.getAD_Reference_ID()) {
						readProcArray.add(new ParseBool("y", "n"));
					} else if (DisplayType.isText(column.getAD_Reference_ID())) {
						readProcArray.add(new StrMinMax(1, column.getFieldLength()));
					} else { // mandatory lookups
						readProcArray.add(new StrNotNullOrEmpty());
					}
				} else {
					if (DisplayType.Date == column.getAD_Reference_ID()) {
						readProcArray.add(new Optional(new ParseDate(DisplayType.DEFAULT_DATE_FORMAT)));
					} else if (DisplayType.DateTime == column.getAD_Reference_ID()) {
						readProcArray.add(new Optional(new ParseDate(DisplayType.DEFAULT_TIMESTAMP_FORMAT)));
					} else if (DisplayType.Time == column.getAD_Reference_ID()) {
						readProcArray.add(new Optional(new ParseDate("DisplayType.DEFAULT_TIME_FORMAT")));
					} else if (DisplayType.Integer == column.getAD_Reference_ID()) {
						readProcArray.add(new Optional(new ParseInt()));
					} else if (DisplayType.isNumeric(column.getAD_Reference_ID())) {
						readProcArray.add(new Optional(new ParseBigDecimal(new DecimalFormatSymbols(Language.getLoginLanguage().getLocale()))));
					} else if (DisplayType.YesNo == column.getAD_Reference_ID()) {
						readProcArray.add(new Optional(new ParseBool("y", "n")));
					} else if (DisplayType.isText(column.getAD_Reference_ID())) {
						readProcArray.add(new Optional(new StrMinMax(1, column.getFieldLength())));
					} else { // optional lookups and text
						readProcArray.add(null);
					}
				}
			}
			if((IMPORT_MODE.equals("U") || IMPORT_MODE.equals("M")) && !isThereKey){
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NoKeyFound"));
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
					map = mapReader.read(header, processors);
				} catch (SuperCsvCellProcessorException e) {
					int idx = e.getCsvContext().getColumnNumber() - 1;
					errMsg.append(header[idx]).append(": ").append(e.getMessage());
					isLineError = true;
				}
				String rawLine = mapReader.getUntokenizedRow();
				if (! isLineError) {
					if (map == null)
						break;
					for (Entry<String, Object> set : map.entrySet()) {
						StringBuilder lineError = new StringBuilder();
						String headName = set.getKey();
						Object value = set.getValue();
						log.fine("Setting " + headName + " to " + value);

						String columnName = headName;
						
						boolean isKeyColumn = headName.indexOf("/") > 0 && (headName.endsWith("K"));					
						if (isKeyColumn)  
						    columnName = headName.substring(0,headName.length()-2);
						
						boolean isForeign = columnName.indexOf("[") > 0 && columnName.endsWith("]");
						String foreignColumn = null;
						if (isForeign) {
							int end = columnName.indexOf("[");
							columnName = columnName.substring(0, end);
							int startf = headName.indexOf("[")+1;
							int endf = headName.indexOf("]");
							foreignColumn = headName.substring(startf, endf);
						}

						GridField field = gridTab.getField(columnName);
						if (field == null) {
							lineError.append(Msg.getMsg(Env.getCtx(), "NotAWindowField", new Object[] {headName}));
							isLineError = true;
						}
						if (!isLineError && field.isReadOnly() && !field.isParentValue()) {
							lineError.append(Msg.getMsg(Env.getCtx(), "FieldIsReadOnly", new Object[] {headName}));
							isLineError = true;
						}
						if (!isLineError && ! ( field.isDisplayed() || field.isDisplayedGrid() )) {
							lineError.append(Msg.getMsg(Env.getCtx(), "FieldNotDisplayed", new Object[] {headName}));
							isLineError = true;
						}
						if (!isLineError) {
							MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
							if (isForeign && value != null){
								String foreignTable = column.getReferenceTableName();
								String idS = null;
								int id = -1;
								if ("AD_Ref_List".equals(foreignTable)) {
									idS = resolveForeignList(column, foreignColumn, value);
								} else {
									id = resolveForeign(foreignTable, foreignColumn, value);
								}
								if (idS == null && id < 0) {
									lineError.append(Msg.getMsg(Env.getCtx(), "ForeignNotResolved", new Object[] {headName, value.toString()}));
									isLineError = true;
								}
							} else {
								// no validation here
								// TODO: we could validate length of string or min/max
							}
						}
						if (isLineError && lineError.length() > 0) {
							if (errMsg.length() > 0)
								errMsg.append(" / ");
							errMsg.append(lineError);
						}
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

				// no errors found - then process
				for (int idx = 0; idx < data.size(); idx++) {
					String rawLine = rawData.get(idx);
					String trxName = null;
					String logMsg = null;
					Trx trx = null;
					boolean error = false;
					try {
						trxName = "Import_" + gridTab.getTableName() + "_" + UUID.randomUUID();
						trx = Trx.get(trxName, true);
						Map<String, Object> map = data.get(idx);
						gridTab.getTableModel().setImportingMode(true, trxName);
						
						if (isThereKey)
						    logMsg = areValidKeysAndColumns(gridTab,map,header);

						if (logMsg == null){
							
							if (IMPORT_MODE.equals("I"))
						 	    gridTab.dataNew(false);
							
							for (String headName : header) {
								if (headName == null)
									continue;
								Object value = map.get(headName);
								String columnName = headName;
		
								boolean isKeyColumn = headName.indexOf("/") > 0 && (headName.endsWith("K"));	
								if (isKeyColumn) {			
								   if(IMPORT_MODE.equals("I"))
									  columnName = columnName.substring(0,headName.length()-2);
								   if(IMPORT_MODE.equals("U"))//Key Column never updated
									  continue;
								}   								
								boolean isForeign = columnName.indexOf("[") > 0 && columnName.endsWith("]");
								String foreignColumn = null;
								if (isForeign) {
									int end = columnName.indexOf("[");
									columnName = columnName.substring(0, end);
									int startf = headName.indexOf("[")+1;
									int endf = headName.indexOf("]");
									foreignColumn = headName.substring(startf, endf);
								}							
								GridField field = gridTab.getField(columnName);
								if (field.isParentValue())
									continue;
								
								if (!field.isEditable(true)) {
									logMsg = Msg.getMsg(Env.getCtx(), "FieldNotEditable", new Object[] {headName});
									error = true;
									break;
								}
								
								MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
								Object setValue = null;
								if (isForeign) {
									String foreignTable = column.getReferenceTableName();
									if ("AD_Ref_List".equals(foreignTable)) {
										String idS = resolveForeignList(column, foreignColumn, value);
										setValue = idS;
									} else {
										int id = resolveForeign(foreignTable, foreignColumn, value);
										setValue = id;
										if (field.isParentValue()) {
											int actualId = (Integer) field.getValue();
											if (actualId != id) {
												logMsg = Msg.getMsg(Env.getCtx(), "ParentCannotChange", new Object[] {headName});
												error = true;
												break;
											}
										}
									}
								} else {
									if (value != null) {
										if (value != null && value instanceof java.util.Date)
											value = new Timestamp(((java.util.Date)value).getTime());
										
										setValue = value;
									}
								}
								if (setValue != null) {				
								    gridTab.setValue(field,setValue);
								}
							}
						}else {
							error =true;
						}
						if (! error) {
							if (gridTab.dataSave(false)) {
								PO po = gridTab.getTableModel().getPO(gridTab.getCurrentRow());					
								if(IMPORT_MODE.equals("I")){
								   logMsg = Msg.getMsg(Env.getCtx(), "Inserted") + po.toString();	
								}else{
								   logMsg = Msg.getMsg(Env.getCtx(), "Updated") + po.toString();	 
								} 
							} else {
								error = true;
								ValueNamePair ppE = CLogger.retrieveWarning();
								String info = null;
								if (ppE != null)
									info = ppE.getName();
								if (info == null)
									info = "";
								logMsg = Msg.getMsg(Env.getCtx(), "Error") + " " + Msg.getMsg(Env.getCtx(), "SaveError") + " (" + info + ")";
								gridTab.dataIgnore();
							}
						} else {
							gridTab.dataIgnore();
						}
					} catch (Exception e) {
						logMsg = Msg.getMsg(Env.getCtx(), "Error") + " " + e.getLocalizedMessage();
						error = true;
					} finally {
						if (trx != null) {
							if (error) {
								trx.rollback();
							} else {
								trx.commit();
							}
							trx.close();
							trx = null;
						}
						gridTab.getTableModel().setImportingMode(false, null);
						IMPORT_MODE =importMode; 
					}
					// write
					logMsg = logMsg.replaceAll(delimiter, "");
					rawLine = rawLine + delimiter + quoteChar + logMsg + quoteChar + "\n";
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
		if (logFile != null)
			return logFile;
		else
			return errFile;		
	}
	

	private String areValidKeysAndColumns(GridTab gridTab, Map<String, Object> map,String[] header){
		MQuery pquery = new MQuery(gridTab.getAD_Table_ID());
		String logMsg= null;
		Object tmpValue=null;
		String columnwithKey=null;
		Object setValue = null;
		//Process columnKeys + Foreign to add restrictions.
		for (int i=0 ; i< header.length; i++){					  
		    boolean isKeyColumn = header[i].indexOf("/") > 0 && header[i].endsWith("K");	
			if(isKeyColumn){  
			   columnwithKey = header[i].substring(0,header[i].length()-2);
			   boolean isForeign = columnwithKey.indexOf("[") > 0 && columnwithKey.indexOf("]") > 0;
			   String foreignColumn = null;
			   if(isForeign) {
				  int end = columnwithKey.indexOf("[");
				  columnwithKey = columnwithKey.substring(0, end);
				  int startf = header[i].indexOf("[")+1;
				  int endf = header[i].indexOf("]");
				  foreignColumn = header[i].substring(startf, endf);

				  if (map.get(header[i]) instanceof java.util.Date)
					  tmpValue = new Timestamp(((java.util.Date)map.get(header[i])).getTime());
				  else 
					  tmpValue = map.get(header[i]);
					
				  MColumn column = MColumn.get(Env.getCtx(), gridTab.getField(columnwithKey).getAD_Column_ID());
				  String foreignTable = column.getReferenceTableName();
				  if ("AD_Ref_List".equals(foreignTable)) {
					  String idS = resolveForeignList(column, foreignColumn, tmpValue);
					  setValue = idS;
				  }else {
					  int id = resolveForeign(foreignTable, foreignColumn, tmpValue);
					  setValue = id;
					  if (gridTab.getField(columnwithKey).isParentValue()) {
						  int actualId = (Integer) gridTab.getField(columnwithKey).getValue();
						  if (actualId != id) {
							  logMsg = Msg.getMsg(Env.getCtx(), "ParentCannotChange", new Object[] {header[i]});
							  break;
						  }  
			          } 
	             }	
			   }else{
				   if (map.get(header[i]) instanceof java.util.Date)
					   tmpValue = new Timestamp(((java.util.Date)map.get(header[i])).getTime());
				   else 
					   tmpValue = map.get(header[i]);
				   
				   setValue = tmpValue ;
			   }
			 pquery.addRestriction(columnwithKey,MQuery.EQUAL,setValue);	
		   }
		}
		gridTab.setQuery(pquery);
		gridTab.query(false);
		if (IMPORT_MODE.equals("I")){
			if(gridTab.getRowCount()>=1)
			   logMsg = Msg.getMsg(Env.getCtx(), "AlreadyExists", new Object[] {pquery}); 
		}
		if (IMPORT_MODE.equals("U")){
			if(gridTab.getRowCount()<=0)
			  logMsg = Msg.getMsg(Env.getCtx(), "not.found", new Object[] {pquery}); 
			else if(gridTab.getRowCount()>1)
			  logMsg = Msg.getMsg(Env.getCtx(),"SQLErrorNotUnique", new Object[] {pquery}); 	
		}
	    if (IMPORT_MODE.equals("M")){
		   if(gridTab.getRowCount()==1)
			  IMPORT_MODE = "U";
		   else if(gridTab.getRowCount()<=0)
			  IMPORT_MODE = "I";
		   else if(gridTab.getRowCount()>1)
			  logMsg = Msg.getMsg(Env.getCtx(),"TooManyRows", new Object[] {pquery}); 	
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

}
