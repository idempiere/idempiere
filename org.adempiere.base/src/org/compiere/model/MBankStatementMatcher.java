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

import org.adempiere.base.Core;
import org.compiere.impexp.BankStatementMatcherInterface;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	Bank Statement Matcher Configuration
 *	
 *  @author Jorg Janke
 *  @version $Id: MBankStatementMatcher.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 */
public class MBankStatementMatcher extends X_C_BankStatementMatcher
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3756318777177414260L;

	/**
	 * 	Get Bank Statement Matcher Configuration
	 * 	@param ctx context
	 *	@param trxName transaction
	 *	@return matchers
	 */
	public static MBankStatementMatcher[] getMatchers (Properties ctx, String trxName)
	{
		ArrayList<MBankStatementMatcher> list = new ArrayList<MBankStatementMatcher>();
		String sql = MRole.getDefault(ctx, false).addAccessSQL(
			"SELECT * FROM C_BankStatementMatcher ORDER BY SeqNo", 
			"C_BankStatementMatcher", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		@SuppressWarnings("unused")
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add (new MBankStatementMatcher(ctx, rs, trxName));
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//	Convert		
		MBankStatementMatcher[] retValue = new MBankStatementMatcher[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getMatchers

	/** Static Logger					*/
	private static CLogger 	s_log = CLogger.getCLogger(MBankStatementMatcher.class);

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_BankStatementMatcher_UU  UUID key
     * @param trxName Transaction
     */
    public MBankStatementMatcher(Properties ctx, String C_BankStatementMatcher_UU, String trxName) {
        super(ctx, C_BankStatementMatcher_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_BankStatementMatcher_ID id
	 *	@param trxName transaction
	 */
	public MBankStatementMatcher(Properties ctx, int C_BankStatementMatcher_ID, String trxName)
	{
		super(ctx, C_BankStatementMatcher_ID, trxName);
	}	//	MBankStatementMatcher

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MBankStatementMatcher(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MBankStatementMatcher

	private BankStatementMatcherInterface	m_matcher = null;
	private Boolean							m_matcherValid = null;

	/**
	 * 	Is Matcher Valid
	 *	@return true if valid
	 */
	public boolean isMatcherValid()
	{
		if (m_matcherValid == null)
			getMatcher();
		return m_matcherValid.booleanValue();
	}	//	isMatcherValid

	/**
	 * 	Get matcher instance 
	 *	@return Matcher Instance
	 */
	public BankStatementMatcherInterface getMatcher()
	{
		if (m_matcher != null 
			|| (m_matcherValid != null && m_matcherValid.booleanValue()))
			return m_matcher;
			
		String className = getClassname();
		if (className == null || className.length() == 0)
			return null;
		
		try
		{
			if (log.isLoggable(Level.INFO)) log.info( "MBankStatementMatch Class Name=" + className);
			// load the BankStatementMatcher class via OSGi Service definition from a plugin
			m_matcher = Core.getBankStatementMatcher(className);
			if(m_matcher==null){
				// if no OSGi plugin is found try the legacy way (in my own classpath)
				Class<?> bsrClass = Class.forName(className);
				m_matcher = (BankStatementMatcherInterface) bsrClass.getDeclaredConstructor().newInstance();
			}
			m_matcherValid = Boolean.TRUE;
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, className, e);
			m_matcher = null;
			m_matcherValid = Boolean.FALSE;
		}
		return m_matcher;
	}	//	getMatcher


}	//	MBankStatementMatcher
