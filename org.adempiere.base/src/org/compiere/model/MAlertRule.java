/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Util;

/**
 *	Alert Rule Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MAlertRule.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MAlertRule extends X_AD_AlertRule
{
	private static final long serialVersionUID = -1267260460210893262L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_AlertRule_UU  UUID key
     * @param trxName Transaction
     */
    public MAlertRule(Properties ctx, String AD_AlertRule_UU, String trxName) {
        super(ctx, AD_AlertRule_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_AlertRule_ID id
	 *	@param trxName transaction
	 */
	public MAlertRule (Properties ctx, int AD_AlertRule_ID, String trxName)
	{
		super (ctx, AD_AlertRule_ID, trxName);
	}	//	MAlertRule

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MAlertRule (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MAlertRule
	
	/** Alert */
	private MAlert m_parent = null;
	
	/**
	 * Get parent
	 * @return parent alert
	 */
	public MAlert getParent() {
		if (m_parent == null || m_parent.get_ID() != getAD_Alert_ID())
			m_parent = new MAlert(getCtx(), getAD_Alert_ID(), get_TrxName());
		return m_parent;
	}
	
	/**
	 * Set parent alert.
	 * NOTE: is not setting AD_Alert_ID
	 * @param alert
	 */
	public void setParent(MAlert alert) {
		m_parent = alert;
	}
	
	/**
	 *	Get Sql
	 *	@return sql
	 *  @deprecated Use {@link #getSql(boolean)} instead
	 */
	public String getSql()
	{
		return getSql(false);
	}
	
	/**
	 * Get Sql
	 * @param applySecurity apply role/client security
	 * @return sql
	 */
	public String getSql(boolean applySecurity)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT ").append(getSelectClause())
			.append(" FROM ").append(getFromClause());
		if (getWhereClause() != null && getWhereClause().length() > 0)
			sql.append(" WHERE ").append(getWhereClause());
		StringBuilder finalSQL = new StringBuilder(sql.toString());
		//
		// Apply Security:
		if (applySecurity) {
			MAlert alert = getParent();
			if (alert.isEnforceRoleSecurity()
					|| alert.isEnforceClientSecurity())
			{
				int AD_Role_ID = alert.getFirstAD_Role_ID();
				if (AD_Role_ID == -1)
					AD_Role_ID = alert.getFirstUserAD_Role_ID();
				if (AD_Role_ID != -1)
				{
					MRole role = MRole.get(getCtx(), AD_Role_ID);
					finalSQL = new StringBuilder(role.addAccessSQL(finalSQL.toString(), null, true, false));
				}
			}
		}
		//
		if (getOtherClause() != null && getOtherClause().length() > 0)
			finalSQL.append(" ").append(getOtherClause());
		return finalSQL.toString();
	}	//	getSql
	
	/**
	 * Create Empty Report File
	 * @param extension file extension
	 * @return newly created File
	 */
	public File createReportFile(String extension)
	{
		if (Util.isEmpty(extension))
		{
			throw new IllegalArgumentException("Parameter extension cannot be empty");
		}
		StringBuilder msgname = new StringBuilder(new SimpleDateFormat("yyyyMMddhhmm").format(new Timestamp(System.currentTimeMillis())))
				.append("_").append(getName().trim());
		String name = msgname.toString();
		File file = null;
		try
		{
			StringBuilder msgp = new StringBuilder(name).append(".").append(extension);
			file = new File(System.getProperty("java.io.tmpdir"), msgp.toString());
			file.createNewFile();
			return file;
		}
		catch (Exception e)
		{
			file = null;
		}
		// Fallback
		String filePrefix = "Alert_"; // TODO: add AD_AlertRule.FileName (maybe)
		try
		{
			StringBuilder msgctf = new StringBuilder(".").append(extension);
			file = File.createTempFile(filePrefix, msgctf.toString());
		}
		catch (IOException e)
		{
			throw new AdempiereException(e);
		}
		return file;
	}
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		if (newRecord)
			setIsValid(true);
		if (isValid())
			setErrorMsg(null);
		return true;
	}	//	beforeSave
	
	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (!success)
			return false;
		return updateParent();
	}
	
	@Override
	protected boolean afterDelete(boolean success) {
		if (!success)
			return false;
		return updateParent();
	}

	/**
	 * Update parent (MAlert) IsValid flag
	 * @return true if success
	 */
	private boolean updateParent() {
		StringBuilder sql_count = new StringBuilder("SELECT COUNT(*) FROM ").append(Table_Name).append(" r")
							.append(" WHERE r.").append(COLUMNNAME_AD_Alert_ID).append("=a.").append(MAlert.COLUMNNAME_AD_Alert_ID)
								.append(" AND r.").append(COLUMNNAME_IsValid).append("='N'")
								.append(" AND r.IsActive='Y'");
		StringBuilder sql = new StringBuilder("UPDATE ").append(MAlert.Table_Name).append(" a SET ")
			.append(" ").append(MAlert.COLUMNNAME_IsValid).append("=(CASE WHEN (").append(sql_count).append(") > 0 THEN 'N' ELSE 'Y' END)")
			.append(" WHERE a.").append(MAlert.COLUMNNAME_AD_Alert_ID).append("=?");
		int no = DB.executeUpdate(sql.toString(), getAD_Alert_ID(), get_TrxName());
		return no == 1;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MAlertRule[");
		sb.append(get_ID())
			.append("-").append(getName())
			.append(",Valid=").append(isValid())
			.append(",").append(getSql(false));
		sb.append ("]");
		return sb.toString ();
	}	//	toString
	
}	//	MAlertRule
