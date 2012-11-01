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
 */
public class GridTabCSVImporter implements IGridTabImporter
{
	private static final String ERROR_HEADER = "_ERROR_";
	private static final String LOG_HEADER = "_LOG_";
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(GridTabCSVImporter.class);
	boolean m_isError = false;
	
	public File fileImport(GridTab gridTab, List<GridTab> childs, InputStream filestream, Charset charset) {

		ICsvMapReader mapReader = null;
		File errFile = null;
		File logFile = null;
		PrintWriter errFileW = null;
		PrintWriter logFileW = null;
		CsvPreference csvpref = CsvPreference.STANDARD_PREFERENCE;
		String delimiter = String.valueOf((char) csvpref.getDelimiterChar());
		String quoteChar = String.valueOf((char) csvpref.getQuoteChar());
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
				boolean isForeign = headName.indexOf("[") > 0 && headName.endsWith("]");
				if (isForeign) {
					int end = headName.indexOf("[");
					columnName = headName.substring(0, end);
				}
				GridField field = gridTab.getField(columnName);
				if (field == null) {
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FieldNotFound", new Object[] {columnName}));
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
						boolean isForeign = headName.indexOf("[") > 0 && headName.endsWith("]");
						String foreignColumn = null;
						if (isForeign) {
							int end = headName.indexOf("[");
							columnName = headName.substring(0, end);
							int startf = headName.indexOf("[")+1;
							int endf = headName.length()-1;
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
							if (isForeign && value != null) {
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
						gridTab.dataNew(false);
						for (String headName : header) {
							if (headName == null)
								continue;
							Object value = map.get(headName);

							String columnName = headName;
							boolean isForeign = headName.indexOf("[") > 0 && headName.endsWith("]");
							String foreignColumn = null;
							if (isForeign) {
								int end = headName.indexOf("[");
								columnName = headName.substring(0, end);
								int startf = headName.indexOf("[")+1;
								int endf = headName.length()-1;
								foreignColumn = headName.substring(startf, endf);
							}
							GridField field = gridTab.getField(columnName);
							if (field.isParentValue())
								continue;
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
							if (value != null) {
								if (field.isEditable(true)) {
									gridTab.setValue(columnName, setValue);
								} else {
									logMsg = Msg.getMsg(Env.getCtx(), "FieldNotEditable", new Object[] {headName});
									error = true;
									break;
								}
							}
						}
						if (! error) {
							if (gridTab.dataSave(false)) {
								PO po = gridTab.getTableModel().getPO(gridTab.getCurrentRow());
								logMsg = Msg.getMsg(Env.getCtx(), "SuccessfullySaved", 
										new Object[] {po != null ? po.toString() : gridTab.getTableModel().getKeyID(gridTab.getCurrentRow())});
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
