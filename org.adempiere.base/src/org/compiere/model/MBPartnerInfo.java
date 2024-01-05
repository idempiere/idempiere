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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 *	Business Partner Info Model for report view
 *	
 *  @author Jorg Janke
 *  @version $Id: MBPartnerInfo.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MBPartnerInfo extends X_RV_BPartner
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7947336480731180299L;

	/**
	 * 	Find BPartners
	 *	@param ctx context
	 *	@param Value Business Partner Value
	 *	@param Name Business Partner Name
	 *	@param Contact Contact/User Name
	 *	@param EMail Contact/User EMail
	 *	@param Phone phone
	 *	@param City city
	 *	@return array of MBPartnerInfo
	 */
	public static MBPartnerInfo[] find (Properties ctx, 
		String Value, String Name, String Contact, String EMail, String Phone, String City)
	{
		StringBuilder sql = new StringBuilder ("SELECT * FROM RV_BPartner WHERE IsActive='Y'");
		StringBuilder sb = new StringBuilder();
		Value = getFindParameter (Value);
		if (Value != null)
			sb.append("UPPER(Value) LIKE ?");
		Name = getFindParameter (Name);
		if (Name != null)
		{
			if (sb.length() > 0)
				sb.append(" OR ");
			sb.append("UPPER(Name) LIKE ?");
		}
		Contact = getFindParameter (Contact);
		if (Contact != null)
		{
			if (sb.length() > 0)
				sb.append(" OR ");
			sb.append("UPPER(ContactName) LIKE ?");
		}
		EMail = getFindParameter (EMail);
		if (EMail != null)
		{
			if (sb.length() > 0)
				sb.append(" OR ");
			sb.append("UPPER(EMail) LIKE ?");
		}
		Phone = getFindParameter (Phone);
		if (Phone != null)
		{
			if (sb.length() > 0)
				sb.append(" OR ");
			sb.append("UPPER(Phone) LIKE ?");
		}
		City = getFindParameter (City);
		if (City != null)
		{
			if (sb.length() > 0)
				sb.append(" OR ");
			sb.append("UPPER(City) LIKE ?");
		}
		if (sb.length() > 0)
			sql.append(" AND (").append(sb).append(")");
		sql.append(" ORDER BY Value");
		//
		String finalSQL = MRole.getDefault().addAccessSQL(sql.toString(), 
			"RV_BPartner", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		ArrayList<MBPartnerInfo> list = new ArrayList<MBPartnerInfo>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(finalSQL, null);
			int index = 1;
			if (Value != null)
				pstmt.setString(index++, Value);
			if (Name != null)
				pstmt.setString(index++, Name);
			if (Contact != null)
				pstmt.setString(index++, Contact);
			if (EMail != null)
				pstmt.setString(index++, EMail);
			if (Phone != null)
				pstmt.setString(index++, Phone);
			if (City != null)
				pstmt.setString(index++, City);
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MBPartnerInfo (ctx, rs, null));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, "find - " + finalSQL, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//	Return
		MBPartnerInfo[] retValue = new MBPartnerInfo[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	find
		
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MBPartnerInfo.class);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param RV_BPartner_UU  UUID key
     * @param trxName Transaction
     */
    public MBPartnerInfo(Properties ctx, String RV_BPartner_UU, String trxName) {
        super(ctx, RV_BPartner_UU, trxName);
    }

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MBPartnerInfo (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MBPartnerInfo

}	//	MBPartnerInfo
