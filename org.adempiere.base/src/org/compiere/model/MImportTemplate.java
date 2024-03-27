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
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.apache.poi.hssf.usermodel.HSSFWorkbookFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbookFactory;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Import Template Model
 *
 *  @author Carlos Ruiz - GlobalQSS
 */
public class MImportTemplate extends X_AD_ImportTemplate implements ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4681075469110529774L;
	
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
		// Validate character set vs supported
		if (getCharacterSet() == null) {
			setCharacterSet(Charset.defaultCharset().displayName());
		}
		if (getCharacterSet() == null || !Charset.isSupported(getCharacterSet())) {
			log.saveError("Error", Msg.parseTranslation(getCtx(), "@Invalid@ @CharacterSet@"));
			return false;
		}
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
	 * Byte Order Mark character for UTF-8
	 */
	public static final String UTF8_BOM = "\uFEFF";

	/**
	 * - If needed preProcess the file when an Excel file and generate a CSV file, then<br/>
	 * - Validate that InputStream header is CSVHeader or AliasCSVHeader.<br/>
	 * - If the header is AliasCSVHeader it replaces it with the CSVHeader so it can be processed.<br/>
	 * @param in input file
	 * @return InputStream with the CSVHeader that can be processed by CsvMapReader
	 */
	public InputStream validateFile(InputStream in) {

		if (   MImportTemplate.IMPORTTEMPLATETYPE_XLS.equals(getImportTemplateType())
			|| MImportTemplate.IMPORTTEMPLATETYPE_XLSX.equals(getImportTemplateType())) {
			try {
				in = convertExcelToCSV(in);
			} catch (Exception e) {
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ErrorConvertingXlsToCsv") + " -> " + e.getLocalizedMessage(), e);
			}
		}

		// we copy here the file to a new one (replacing the header if it's the alias)
		Charset charset = Charset.forName(getCharacterSet());
		BufferedReader reader = new BufferedReader(new InputStreamReader(in, charset));
		File tmpfile = null;
		InputStream is = null;
		BufferedWriter bw = null;
		try {
			tmpfile = File.createTempFile("CSVImportAction", ".csv");
			bw = new BufferedWriter(new FileWriter(tmpfile,charset));
			String firstLine = null;
			String line = null;
			while ((line = reader.readLine()) != null) {
				if (firstLine == null) {
					firstLine = line;
					if (firstLine.startsWith(UTF8_BOM))
						firstLine = firstLine.substring(1);
					/* Validate that file header is CSVHeader or AliasCSVHeader */
					if (   firstLine.equals(getCSVHeader())
						|| firstLine.equals(getCSVAliasHeader())) {
						bw.write(getCSVHeader());
					} else {
						reader.close();
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

        Workbook workbook = null;
		if (MImportTemplate.IMPORTTEMPLATETYPE_XLS.equals(getImportTemplateType())) {
            HSSFWorkbookFactory xlsWbf = new HSSFWorkbookFactory();
            workbook = xlsWbf.create(excelIs);
		} else if (MImportTemplate.IMPORTTEMPLATETYPE_XLSX.equals(getImportTemplateType())) {
            XSSFWorkbookFactory xlsxWbf = new XSSFWorkbookFactory();
            workbook = xlsxWbf.create(excelIs);
		} else {
			// unexpected error
			throw new AdempiereException("Wrong template type -> " + getImportTemplateType());
		}
        Sheet sheet = workbook.getSheetAt(0); // First sheet

		File tmpfile = File.createTempFile("CSVImportActionConvert", ".csv");
		Charset charset = Charset.forName(getCharacterSet());
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(tmpfile, charset))) {
            for (Row row : sheet) {
            	boolean firstCell = true;
            	for (int cn = 0; cn < row.getLastCellNum(); cn++) {
            		Cell cell = row.getCell(cn, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                	if (firstCell) {
                		firstCell = false;
                	} else {
                        bw.append(getSeparatorChar());
                	}
                	/* TODO: get the formula values based on the expected reference of the column instead of the spreadsheet itself */
                    switch (cell.getCellType().equals(CellType.FORMULA) ? cell.getCachedFormulaResultType() : cell.getCellType()) {
                        case STRING:
                        	String value = cell.getStringCellValue();
                        	boolean addQuotes = (value.contains(getQuoteChar()) || value.contains(getSeparatorChar()));
                        	if (addQuotes)
                        		bw.append(getQuoteChar());
                            bw.append(value.replace(getQuoteChar(), getQuoteChar().concat(getQuoteChar())));
                        	if (addQuotes)
                        		bw.append(getQuoteChar());
                            break;
                        case BOOLEAN:
                        	if (cell.getBooleanCellValue())
                                bw.append("Y");
                        	else
                                bw.append("N");
                            break;
                        case NUMERIC:
                            bw.append(Double.toString(cell.getNumericCellValue()));
                            break;
                        case BLANK:
                            // Treat blank cells as empty strings
                            break;
                        default:
                            throw new IllegalStateException("Unsupported cell type: " + cell.getCellType());
                    }
                }
                bw.newLine();
            }
        }
        workbook.close();
        InputStream is = new FileInputStream(tmpfile);
		return is;
    }

	@Override
	public MImportTemplate markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MImportTemplate
