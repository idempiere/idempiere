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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	GL Journal Callout
 *	
 *  @author Jorg Janke
 *  @version $Id: CalloutGLJournal.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class CalloutGLJournal extends CalloutEngine
{
	/**
	 *  Journal - Period.
	 *  Check that selected period is in DateAcct Range or Adjusting Period
	 *  Called when C_Period_ID or DateAcct, DateDoc changed
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String period (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		String colName = mField.getColumnName();
		if (value == null)
			return "";

		Timestamp DateAcct = null;
		if (colName.equals("DateAcct"))
			DateAcct = (Timestamp)value;
		else
			DateAcct = (Timestamp)mTab.getValue("DateAcct");
		int C_Period_ID = 0;
		if (colName.equals("C_Period_ID"))
			C_Period_ID = ((Integer)value).intValue();

		//  When DateDoc is changed, update DateAcct
		if (colName.equals("DateDoc"))
		{
			mTab.setValue("DateAcct", value);
		}

		//  When DateAcct/Org is changed, set C_Period_ID
		else if (colName.equals("DateAcct") || colName.equals("AD_Org_ID"))
		{
			String sql = "SELECT C_Period_ID "
				+ "FROM C_Period "
				+ "WHERE C_Year_ID IN "
				+ "	(SELECT C_Year_ID FROM C_Year WHERE C_Calendar_ID=?)"
				+ " AND ? BETWEEN StartDate AND EndDate"
				// globalqss - cruiz - Bug [ 1577712 ] Financial Period Bug
				+ " AND IsActive='Y'"
				+ " AND PeriodType='S'";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				int AD_Org_ID = mTab.getValue("AD_Org_ID") != null ? ((Number)mTab.getValue("AD_Org_ID")).intValue() : 0;
				int C_Calendar_ID = MPeriod.getC_Calendar_ID(ctx, AD_Org_ID);
				pstmt.setInt(1, C_Calendar_ID);
				pstmt.setTimestamp(2, DateAcct);
				rs = pstmt.executeQuery();
				if (rs.next())
					C_Period_ID = rs.getInt(1);
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, sql, e);
				return e.getLocalizedMessage();
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
			if (C_Period_ID != 0)
				mTab.setValue("C_Period_ID", Integer.valueOf(C_Period_ID));
		}

		//  When C_Period_ID is changed, check if in DateAcct range and set to end date if not
		else
		{
			String sql = "SELECT PeriodType, StartDate, EndDate "
				+ "FROM C_Period WHERE C_Period_ID=?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				pstmt.setInt(1, C_Period_ID);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					Timestamp StartDate = rs.getTimestamp(2);
					Timestamp EndDate = rs.getTimestamp(3);
					//  out of range - set to last day
					if (DateAcct == null
						|| DateAcct.before(StartDate) || DateAcct.after(EndDate))
						mTab.setValue("DateAcct", EndDate);
				}
			}
			catch (SQLException e)
			{
				log.log(Level.SEVERE, sql, e);
				return e.getLocalizedMessage();
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
		}
		return "";
	}   //  	Journal_Period

	/**
	 * 	Journal/Line - rate.
	 * 	Set CurrencyRate from DateAcct, C_ConversionType_ID, C_Currency_ID
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String rate (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (value == null)
			return "";
		
		//  Source info
		Integer Currency_ID = (Integer)mTab.getValue("C_Currency_ID");
		int C_Currency_ID = Currency_ID.intValue();
		Integer ConversionType_ID = (Integer)mTab.getValue("C_ConversionType_ID");
		int C_ConversionType_ID = ConversionType_ID.intValue();
		Timestamp DateAcct = (Timestamp)mTab.getValue("DateAcct");
		if (DateAcct == null)
			DateAcct = new Timestamp(System.currentTimeMillis());
		//
		int C_AcctSchema_ID = Env.getContextAsInt(ctx, WindowNo, "C_AcctSchema_ID");
		MAcctSchema as = MAcctSchema.get (ctx, C_AcctSchema_ID);
		int AD_Client_ID = Env.getContextAsInt(ctx, WindowNo, "AD_Client_ID");
		int AD_Org_ID = Env.getContextAsInt(ctx, WindowNo, "AD_Org_ID");

		BigDecimal CurrencyRate = MConversionRate.getRate(C_Currency_ID, as.getC_Currency_ID(), 
			DateAcct, C_ConversionType_ID, AD_Client_ID, AD_Org_ID);
		if (log.isLoggable(Level.FINE)) log.fine("rate = " + CurrencyRate);
		if (CurrencyRate == null)
			CurrencyRate = Env.ZERO;
		mTab.setValue("CurrencyRate", CurrencyRate);

		return "";
	}	//	rate
	
	/**
	 *  JournalLine - Amt.
	 *  Convert the source amount to accounted amount (AmtAcctDr/Cr)
	 *  Called when source amount (AmtSourceCr/Dr) or rate changes
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String amt (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (value == null || isCalloutActive())
			return "";

		//  Get Target Currency & Precision from C_AcctSchema.C_Currency_ID
		int C_AcctSchema_ID = Env.getContextAsInt(ctx, WindowNo, "C_AcctSchema_ID");
		MAcctSchema as = MAcctSchema.get(ctx, C_AcctSchema_ID);
		int Precision = as.getStdPrecision();

		BigDecimal CurrencyRate = (BigDecimal)mTab.getValue("CurrencyRate");
		if (CurrencyRate == null)
		{
			CurrencyRate = Env.ONE;
			mTab.setValue("CurrencyRate", CurrencyRate);
		}

		//  AmtAcct = AmtSource * CurrencyRate  ==> Precision
		BigDecimal AmtSourceDr = (BigDecimal)mTab.getValue("AmtSourceDr");
		if (AmtSourceDr == null)
			AmtSourceDr = Env.ZERO;
		BigDecimal AmtSourceCr = (BigDecimal)mTab.getValue("AmtSourceCr");
		if (AmtSourceCr == null)
			AmtSourceCr = Env.ZERO;

		BigDecimal AmtAcctDr = AmtSourceDr.multiply(CurrencyRate);
		AmtAcctDr = AmtAcctDr.setScale(Precision, RoundingMode.HALF_UP);
		mTab.setValue("AmtAcctDr", AmtAcctDr);
		BigDecimal AmtAcctCr = AmtSourceCr.multiply(CurrencyRate);
		AmtAcctCr = AmtAcctCr.setScale(Precision, RoundingMode.HALF_UP);
		mTab.setValue("AmtAcctCr", AmtAcctCr);

		return "";
	}   //  amt

	public String account (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)	// idempiere 344 - nmicoud
	{
		String colName = mField.getColumnName();
		if (value == null || isCalloutActive())
			return "";

		if (colName.equals("Account_ID")
				|| colName.equals("C_SubAcct_ID")
				|| colName.equals("M_Product_ID")
				|| colName.equals("C_BPartner_ID")
				|| colName.equals("AD_OrgTrx_ID")
				|| colName.equals("AD_Org_ID")
				|| colName.equals("C_LocFrom_ID")
				|| colName.equals("C_LocTo_ID")
				|| colName.equals("C_SalesRegion_ID")
				|| colName.equals("C_Project_ID")
				|| colName.equals("C_Campaign_ID")
				|| colName.equals("C_Activity_ID")
				|| colName.equals("User1_ID")
				|| colName.equals("User2_ID")
				|| colName.equals("UserElement1_ID")
				|| colName.equals("UserElement2_ID")
			)
		{
			mTab.setValue("C_ValidCombination_ID", null);
			mTab.setValue("Alias_ValidCombination_ID", null);
		}
		return "";
	}

	public String alias (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)	// idempiere 344 - nmicoud
	{
		String colName = mField.getColumnName();
		if (value == null || isCalloutActive())
			return "";

		Integer Combi_ID = ((Integer)value).intValue();
		
		if (colName.equals("Alias_ValidCombination_ID")) 
			mTab.setValue("C_ValidCombination_ID", Combi_ID);
	
		if (colName.equals("C_ValidCombination_ID"))
			mTab.setValue("Alias_ValidCombination_ID", Combi_ID);
		
		if (colName.equals("C_ValidCombination_ID") || colName.equals("Alias_ValidCombination_ID"))
		{
			MAccount combi = new MAccount(ctx, Combi_ID, null);
			mTab.setValue("Account_ID", combi.getAccount_ID() != 0 ? combi.getAccount_ID() : null);
			mTab.setValue("C_SubAcct_ID", combi.getC_SubAcct_ID() != 0 ? combi.getC_SubAcct_ID() : null);
			mTab.setValue("M_Product_ID", combi.getM_Product_ID() != 0 ? combi.getM_Product_ID() : null);
			mTab.setValue("C_BPartner_ID", combi.getC_BPartner_ID() != 0 ? combi.getC_BPartner_ID() : null);
			mTab.setValue("AD_OrgTrx_ID", combi.getAD_OrgTrx_ID() != 0 ? combi.getAD_OrgTrx_ID() : null);
			mTab.setValue("AD_Org_ID", combi.getAD_Org_ID() != 0 ? combi.getAD_Org_ID() : null);
			mTab.setValue("C_LocFrom_ID", combi.getC_LocFrom_ID() != 0 ? combi.getC_LocFrom_ID() : null);
			mTab.setValue("C_LocTo_ID", combi.getC_LocTo_ID() != 0 ? combi.getC_LocTo_ID() : null);
			mTab.setValue("C_SalesRegion_ID", combi.getC_SalesRegion_ID() != 0 ? combi.getC_SalesRegion_ID() : null);
			mTab.setValue("C_Project_ID", combi.getC_Project_ID() != 0 ? combi.getC_Project_ID() : null);
			mTab.setValue("C_Campaign_ID", combi.getC_Campaign_ID() != 0 ? combi.getC_Campaign_ID() : null);
			mTab.setValue("C_Activity_ID", combi.getC_Activity_ID() != 0 ? combi.getC_Activity_ID() : null);
			mTab.setValue("User1_ID", combi.getUser1_ID() != 0 ? combi.getUser1_ID() : null);
			mTab.setValue("User2_ID", combi.getUser2_ID()!= 0 ? combi.getUser2_ID() : null);
			mTab.setValue("UserElement1_ID", combi.getUserElement1_ID() != 0 ? combi.getUserElement1_ID() : null);
			mTab.setValue("UserElement2_ID", combi.getUserElement2_ID() != 0 ? combi.getUserElement2_ID() : null);
		}
		return "";
	}
	
	/**
	 *  Journal - Acct Schema
	 *  Set Currency from C_AcctSchema_ID
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String acctSchema(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (value == null)
			return "";
		
		int C_AcctSchema_ID = Env.getContextAsInt(ctx, WindowNo, "C_AcctSchema_ID");
		MAcctSchema as = MAcctSchema.get (ctx, C_AcctSchema_ID);
		mTab.setValue("C_Currency_ID", as.getC_Currency_ID());
		
		return "";
	}

	/**
	 *  Journal - Doc Type
	 *  Set GL Category from C_DocType_ID
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String docType(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (value == null)
			return "";
		
		int C_DocType_ID = Env.getContextAsInt(ctx, WindowNo, "C_DocType_ID");
		MDocType dt = MDocType.get (ctx, C_DocType_ID);
		mTab.setValue("GL_Category_ID", dt.getGL_Category_ID());
		
		return "";
	}

}	//	CalloutGLJournal
