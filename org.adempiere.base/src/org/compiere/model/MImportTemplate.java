/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Carlos Ruiz                							  *
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
package org.compiere.model;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOSupport;
import org.supercsv.io.CsvMapReader;
import org.supercsv.io.ICsvMapReader;
import org.supercsv.prefs.CsvPreference;

/**
 *	Import Template Model
 *
 *  @author Carlos Ruiz - GlobalQSS
 */
public class MImportTemplate extends X_AD_ImportTemplate implements ImmutablePOSupport
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 7751951143524784901L;

	/**	Logger			*/
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MImportTemplate.class);

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_ImportTemplate_UU  UUID key
     * @param trxName Transaction
     */
    public MImportTemplate(Properties ctx, String AD_ImportTemplate_UU, String trxName) {
        super(ctx, AD_ImportTemplate_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_ImportTemplate_ID id
	 *	@param trxName transaction
	 */
	public MImportTemplate (Properties ctx, int AD_ImportTemplate_ID, String trxName)
	{
	      super (ctx, AD_ImportTemplate_ID, trxName);
	}	//	MImportTemplate

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MImportTemplate (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MImportTemplate

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MImportTemplate(MImportTemplate copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MImportTemplate(Properties ctx, MImportTemplate copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MImportTemplate(Properties ctx, MImportTemplate copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Set default character set (if not fill yet)
		if (getCharacterSet() == null) {
			setCharacterSet(Charset.defaultCharset().displayName());
		}
		// Validate character set is fill and supported by current JVM
		if (getCharacterSet() == null || !Charset.isSupported(getCharacterSet())) {
			log.saveError("Error", Msg.parseTranslation(getCtx(), "@Invalid@ @CharacterSet@"));
			return false;
		}
		if (   is_new()
			|| is_ValueChanged(COLUMNNAME_CSVHeader)
			|| is_ValueChanged(COLUMNNAME_CSVAliasHeader)
			|| is_ValueChanged(COLUMNNAME_CharacterSet)
			|| is_ValueChanged(COLUMNNAME_SeparatorChar)
			|| is_ValueChanged(COLUMNNAME_QuoteChar)
			|| is_ValueChanged(COLUMNNAME_AD_Tab_ID))
			calculateAndValidateColumnTypes(); // this throws an Exception if there are wrong columns in the CSV Header
		return super.beforeSave(newRecord);
	}

	/**	Cache of Role						*/
	private static CCache<String,List<MImportTemplate>>	s_cacheRoleTab = new CCache<String,List<MImportTemplate>>(Table_Name, Table_Name+"_Of_Role", 5);

	/**
	 * Get accessible import templates 
	 * @param roleid AD_Role_ID
	 * @param tabid AD_Tab_ID
	 * @return list of MImportTemplate
	 */
	public static List<MImportTemplate> getTemplates(int roleid, int tabid) {
		String key = roleid + "_" + tabid;
		List<MImportTemplate> retValue = s_cacheRoleTab.get(key);
		if (retValue != null)
			return retValue;

		final String where = ""
				+ "IsActive = 'Y' "
				+ "AND AD_Client_ID IN ( 0, ? ) "
				+ "AND AD_Tab_ID = ? " 
				+ "AND EXISTS (SELECT 1 "
				+ "            FROM   AD_ImportTemplateAccess ita "
				+ "            WHERE  ita.AD_ImportTemplate_ID = AD_ImportTemplate.AD_ImportTemplate_ID "
				+ "                   AND ita.IsActive = 'Y' "
				+ "                   AND ( ita.AD_Role_ID = ? "
				+ "                          OR ita.AD_Role_ID IN (SELECT Included_Role_ID "
				+ "                                                FROM   AD_Role_Included "
				+ "                                                WHERE  AD_Role_ID = ? AND IsActive = 'Y') ) "
				+ "                   AND ( IsAllowInsert = 'Y' "
				+ "                          OR IsAllowMerge = 'Y' "
				+ "                          OR IsAllowUpdate = 'Y' ))";
		retValue = new Query(Env.getCtx(), MImportTemplate.Table_Name, where, null)
			.setParameters(Env.getAD_Client_ID(Env.getCtx()), tabid, roleid, roleid)
			.setOrderBy("Name")
			.list();
		if (retValue.size() > 0)
			retValue.stream().forEach(e -> e.markImmutable());
		s_cacheRoleTab.put(key, retValue);
		return retValue;
	}

	/**
	 * @param importMode I (Insert), U (Update) or M (Merge)
	 * @param roleID AD_Role_ID
	 * @return true if role can perform importMode with this template
	 */
	public boolean isAllowed(String importMode, int roleID) {
		StringBuilder sql= new StringBuilder(""
				+ "SELECT COUNT(*) "
				+ "FROM   AD_ImportTemplateaccess "
				+ "WHERE  IsActive = 'Y' "
				+ "       AND AD_ImportTemplate_ID = ? "
				+ "       AND ( AD_Role_ID = ? "
				+ "              OR AD_Role_ID IN (SELECT Included_Role_ID "
				+ "                                FROM   AD_Role_Included "
				+ "                                WHERE  AD_Role_id = ? "
				+ "                                       AND IsActive = 'Y') ) "
				+ "       AND IsAllow");
		if ("I".equals(importMode))
			sql.append("Insert");
		else if ("U".equals(importMode))
			sql.append("Update");
		else if ("M".equals(importMode))
			sql.append("Merge");
		else
			return false;
		sql.append("='Y'");

		int cnt = DB.getSQLValueEx(get_TrxName(), sql.toString(), getAD_ImportTemplate_ID(), roleID, roleID);
		return cnt > 0;
	}

	/**
	 * Byte Order Mark character for UTF-16BE
	 */
	public static final String UTF16BE_BOM = "\uFEFF";

	/**
	 * - If needed preProcess the file when an Excel file and generate a CSV file, then<br/>
	 * - Validate that InputStream header is CSVHeader or AliasCSVHeader.<br/>
	 * - If the header is AliasCSVHeader it replaces it with the CSVHeader so it can be processed.<br/>
	 * @param in input file
	 * @return InputStream with the CSVHeader that can be processed by CsvMapReader
	 */
	public InputStream validateFile(InputStream in) {

		if (MImportTemplate.IMPORTTEMPLATETYPE_ExcelXLSXLSX.equals(getImportTemplateType())) {
			try {
				in = convertExcelToCSV(in);
			} catch (Exception e) {
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ErrorConvertingXlsToCsv") + " -> " + e.getLocalizedMessage(), e);
			}
		}

		Charset charset = Charset.forName(getCharacterSet());
		BufferedReader reader = new BufferedReader(new InputStreamReader(in, charset));
		File tmpfile = null;
		InputStream is = null;
		BufferedWriter bw = null;
		try {
			String firstLine = null;
			String line = null;
			while ((line = reader.readLine()) != null) {
				if (firstLine == null) {
					firstLine = line;
					if (firstLine.startsWith(UTF16BE_BOM))
						firstLine = firstLine.substring(1);
					/* Validate that file header is CSVHeader or AliasCSVHeader */
					if (   firstLine.equals(getCSVHeader())
						|| firstLine.equals(getCSVAliasHeader())) {
						// we copy here the file to a new one (replacing the header if it's the alias)
						tmpfile = File.createTempFile("CSVImportAction", ".csv");
						bw = new BufferedWriter(new FileWriter(tmpfile,charset));
						bw.write(getCSVHeader());
					} else {
						throw new AdempiereException(Msg.getMsg(Env.getCtx(), "WrongCSVHeader"));
					}
				} else {
					bw.write(line);
				}
				bw.write('\n');
			}
			is = new FileInputStream(tmpfile);
		} catch (IOException e) {
			throw new AdempiereException(e);
		} finally {
			if (in != null)
				try {
					in.close();
				} catch (IOException e) {
				}
			
			if (bw != null)
				try {
					bw.close();
				} catch (IOException e) {
				}
			
			if (reader != null)
				try {
					reader.close();
				} catch (IOException e) {
				}
		}
		return is;
	}

    /**
     * Convert an Excel (XLS or XLSX) file to CSV 
     * @param excelIs input stream containing XLS/XLSX
     * @return input stream containing CSV
     * @throws IOException
     */
	public InputStream convertExcelToCSV(InputStream excelIs) throws IOException {

		Workbook workbook = WorkbookFactory.create(excelIs);

		List<Integer> colTypes = calculateAndValidateColumnTypes();

		Sheet sheet = workbook.getSheetAt(0); // First sheet

		File tmpfile = File.createTempFile("CSVImportActionConvert", ".csv");
		Charset charset = Charset.forName(getCharacterSet());
		try (BufferedWriter bw = new BufferedWriter(new FileWriter(tmpfile, charset))) {
			for (Row row : sheet) {
				boolean firstCell = true;
				for (int cn = 0; cn < colTypes.size(); cn++) {
					int displayType = colTypes.get(cn);
					Cell cell = row.getCell(cn, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
					if (firstCell) {
						firstCell = false;
					} else {
						bw.append(getSeparatorChar());
					}

					CellType cellType = cell.getCellType();
					if (cellType.equals(CellType.FORMULA))
						cellType = cell.getCachedFormulaResultType();
					if (! (   cellType.equals(CellType.BLANK)
						   || cellType.equals(CellType.STRING)
						   || cellType.equals(CellType.BOOLEAN)
						   || cellType.equals(CellType.NUMERIC)))
						throw new IllegalStateException("Unsupported cell type: " + cell.getCellType());
					if (! cellType.equals(CellType.BLANK)) { // blank cells are not processed - write them just as empty strings

						if (cellType.equals(CellType.BOOLEAN)) {
							// boolean cells are converted to Y/N iDempiere notation
							if (cell.getBooleanCellValue())
								bw.append("Y");
							else
								bw.append("N");

						} else if (DisplayType.YesNo == displayType) {
							// a Yes/No value is expected, try to convert true/false and 1/0 to Y/N
							if (cellType.equals(CellType.NUMERIC)) {
								double doubleValue = cell.getNumericCellValue();
								if (doubleValue == 1.0)
									bw.append("Y");
								else if (doubleValue == 0.0)
									bw.append("N");
								else
									addNumeric(bw, doubleValue, displayType);
							} else { // STRING
								String stringValue = cell.getStringCellValue();
								if (stringValue.equalsIgnoreCase("true") || stringValue.equals("y"))
									stringValue = "Y";
								else if (stringValue.equalsIgnoreCase("false") || stringValue.equals("n"))
									stringValue = "N";
								addString(bw, stringValue);
							}

						} else if (DisplayType.isDate(displayType)) {
							// a date time is expected
							if (cellType.equals(CellType.NUMERIC)) {
								SimpleDateFormat sdf;
								if (displayType == DisplayType.Date)
									 sdf = DisplayType.getDateFormat_JDBC();
								else
									 sdf = DisplayType.getTimestampFormat_Default();
								Date date = cell.getDateCellValue();
								addString(bw, sdf.format(date));
							} else { // STRING
								addString(bw, cell.getStringCellValue());
							}

						} else {
							if (cellType.equals(CellType.NUMERIC)) {
								addNumeric(bw, cell.getNumericCellValue(), displayType);
							} else { // STRING
								addString(bw, cell.getStringCellValue());
							}

						}
					}

				}
				bw.newLine();
			}
		}
		workbook.close();
		InputStream is = new FileInputStream(tmpfile);
		return is;
	}

	/**
	 * Add a String to the BufferedWriter
	 * @param bw BufferedWriter
	 * @param value String
	 * @throws IOException
	 */
	private void addString(BufferedWriter bw, String value) throws IOException {
		boolean addQuotes = (value.contains(getQuoteChar()) || value.contains(getSeparatorChar()));
		if (addQuotes)
			bw.append(getQuoteChar());
		bw.append(value.replace(getQuoteChar(), getQuoteChar().concat(getQuoteChar())));
		if (addQuotes)
			bw.append(getQuoteChar());
	}

	/**
	 * Add a Numeric value to the BufferedWriter
	 * @param bw BufferedWriter
	 * @param doubleValue double
	 * @param displayType
	 * @throws IOException
	 */
	private void addNumeric(BufferedWriter bw, double doubleValue, int displayType) throws IOException {
		int intValue = (int) doubleValue;
		DecimalFormat df = DisplayType.getNumberFormat(displayType);
		if (   intValue == doubleValue
			|| displayType == DisplayType.Integer
			|| displayType == DisplayType.Table
			|| displayType == DisplayType.TableDir
			|| displayType == DisplayType.Search
			|| displayType == DisplayType.RecordID) {
			df.setParseIntegerOnly(true);
			df.setMaximumFractionDigits(0);
		}
		df.setGroupingSize(0);
		String str = df.format(doubleValue);
		addString(bw, str);
	}

	/**
	 * Calculate the expected column types depending on the columns defined in the CSVHeader
	 * Every column can have the format
	 *   Column
	 *   Column[ForeignColumn]
	 *   DetailTableName>Column
	 *   DetailTableName>Column[ForeignColumn]
	 *   Any column can end with /K (can be ignored)
	 * @return List of expected DisplayType for every column
	 */
	private List<Integer> calculateAndValidateColumnTypes() {
		List<Integer> retValue = new ArrayList<Integer>();

		String delimiterChar = getSeparatorChar();
		String quoteChar = getQuoteChar();
		CsvPreference csvpref = new CsvPreference.Builder(quoteChar.charAt(0), delimiterChar.charAt(0), "\r\n" /* ignored */).build();
		InputStream is = null;
		List<String>csvHeaders = null;
		ICsvMapReader mapReader = null;
		try {
			is = new ByteArrayInputStream( getCSVHeader().getBytes(getCharacterSet()));
			InputStreamReader reader = new InputStreamReader(is);
			mapReader = new CsvMapReader(reader, csvpref);
			csvHeaders =  Arrays.asList(mapReader.getHeader(true));
		} catch (IOException e) {
			throw new AdempiereException(e);
		} finally {
			if (mapReader != null) {
				try {
					mapReader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		if (csvHeaders == null || csvHeaders.size() == 0) {
			throwCSVHeaderNotFound("");
		}

		// Validate that alias has the same number of columns as the header
		if (! Util.isEmpty(getCSVAliasHeader())) {
			InputStream isa = null;
			List<String>csvAliasHeaders = null;
			ICsvMapReader mapReaderAlias = null;
			try {
				isa = new ByteArrayInputStream( getCSVAliasHeader().getBytes(getCharacterSet()));
				InputStreamReader reader = new InputStreamReader(isa);
				mapReaderAlias = new CsvMapReader(reader, csvpref);
				csvAliasHeaders =  Arrays.asList(mapReaderAlias.getHeader(true));
			} catch (IOException e) {
				throw new AdempiereException(e);
			} finally {
				if (mapReaderAlias != null) {
					try {
						mapReaderAlias.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			if (csvAliasHeaders == null || csvAliasHeaders.size() != csvHeaders.size()) {
				throw new AdempiereException(Msg.getMsg(getCtx(), "CSVAliasHeaderNotValid"));
			}
		}

		// Validate existence of each column and obtain the data type
		MTab mainTab = MTab.get(getAD_Tab_ID());
		MTable mainTable = MTable.get(mainTab.getAD_Table_ID());
		for (String csvHeader : csvHeaders) {
			String columnHeader = csvHeader;
			// first remove the /K mark
			if (columnHeader.endsWith("/K"))
				columnHeader = columnHeader.substring(0, columnHeader.length()-2);
			// check if there is a foreign column that defines the type
			String foreignColumnName = null;
			int idxOpen = columnHeader.indexOf("[");
			if (idxOpen > 0) {
				int idxClose = columnHeader.indexOf("]");
				if (idxClose > 0 && idxClose > idxOpen) {
					foreignColumnName = columnHeader.substring(idxOpen+1, idxClose);
					columnHeader = columnHeader.substring(0, idxOpen);
				}
			}
			// if this is from a detail table
			int idxTableSep = columnHeader.lastIndexOf(">");
			MTable table = null;
			String tableName = null;
			String columnName = null;
			if (idxTableSep > 0) {
				tableName = columnHeader.substring(0, idxTableSep);
				if (tableName.lastIndexOf(">") > 0) {
					tableName = tableName.substring(tableName.lastIndexOf(">")+1);
				}
				table = MTable.get(getCtx(), tableName);
				columnName = columnHeader.substring(idxTableSep+1);
			} else {
				table = mainTable;
				tableName = table.getTableName();
				columnName = columnHeader;
			}
			if (table == null)
				throwCSVHeaderNotFound(csvHeader);
			MColumn column = table.getColumn(columnName);
			if (column == null)
				throwCSVHeaderNotFound(csvHeader);
			String foreignTableName = null;
			if (foreignColumnName != null) {
				foreignTableName = column.getReferenceTableName();
				MTable foreignTable = MTable.get(getCtx(), foreignTableName);
				if (foreignTable == null)
					throwCSVHeaderNotFound(csvHeader);
				column = foreignTable.getColumn(foreignColumnName);
				if (column == null)
					throwCSVHeaderNotFound(csvHeader);
			}
			if (log.isLoggable(Level.INFO))
				log.info("CSV Header column found -> " + csvHeader + " -> " + tableName + "." + columnName
					+ (foreignColumnName != null ? "[" + foreignTableName + "." + foreignColumnName + "]" : "") );
			int ref = column.getAD_Reference_ID();
			retValue.add(ref);
		}
		return retValue;
	}

	/**
	 * Throws an exception indicating a CSV Header that could not be found
	 * @param csvHeader
	 */
	private void throwCSVHeaderNotFound(String csvHeader) {
		throw new AdempiereException(Msg.getMsg(getCtx(), "CSVHeaderColumnNotFound", new Object[]{csvHeader}));
	}

	@Override
	public MImportTemplate markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MImportTemplate
