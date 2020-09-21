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
	 * 
	 */
	private static final long serialVersionUID = -4681075469110529774L;
	
	/**	Logger			*/
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MImportTemplate.class);

	/**************************************************************************
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
	 * 
	 * @param copy
	 */
	public MImportTemplate(MImportTemplate copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MImportTemplate(Properties ctx, MImportTemplate copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
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
	 * Validate that InputStream header is CSVHeader or AliasCSVHeader
	 * If the header is AliasCSVHeader it replaces it with the CSVHeader so it can be
	 * processed
	 * @param in input file
	 * @return InputStream with the CSVHeader that can be processed by CsvMapReader
	 */
	public InputStream validateFile(InputStream in) {
		// because the input stream cannot be reset we need to copy here the file to a new one (replacing the header if it's the alias)
		Charset charset = Charset.forName(getCharacterSet());
		BufferedReader reader = new BufferedReader(new InputStreamReader(in, charset));
		File tmpfile = null;
		InputStream is = null;
		BufferedWriter bw = null;
		try {
			tmpfile = File.createTempFile("CSVImportAction", "csv");
			bw = new BufferedWriter(new FileWriter(tmpfile,charset));
			String firstLine = null;
			String line = null;
			while ((line = reader.readLine()) != null) {
				if (firstLine == null) {
					firstLine = line;
					/* Validate that m_file_istream header is CSVHeader or AliasCSVHeader */
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

	@Override
	public MImportTemplate markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MImportTemplate
